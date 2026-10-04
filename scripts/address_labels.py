import argparse
import json
import re


BANKS = [
    "prg0_title",
    "prg1_brinstar",
    "prg2_norfair",
    "prg3_tourian",
    "prg4_kraid",
    "prg5_ridley",
    "prg6_graphics",
    "prg7_engine",
]

BANKS_AREA = [
    None,
    "BANK1",
    "BANK2",
    "BANK3",
    "BANK4",
    "BANK5",
    None,
    None
]


def parse_lines(lines, bank, sym_labels):
    label_name_parts = []
    for i, line in enumerate(lines):
        l = line.split(";")[0].strip()
        if l.endswith(":"):
            l = l.removesuffix(":").split("@")
            assert len(l) - 1 <= len(label_name_parts)
            label_name_parts = label_name_parts[:len(l)-1] + l[len(l)-1:]
            label_name = "@".join(label_name_parts)
            if label_name in sym_labels[bank]:
                line = (
                    line.split(";")[0].rstrip() +
                    f" ; {bank:02X}:{sym_labels[bank][label_name]:04X}\n"
                )
                print(line)
            """if len(line.split(";")) > 1:
                if (
                    re.search(r" [\dA-F]{2}\:[\dA-F]{4}", line.split(";", 2)[1]) is None
                    and re.search(r" \$[\dA-F]{4}", line.split(";", 2)[1]) is None
                ):
                    print(line.removesuffix("\n"))"""
        lines[i] = line


def address_labels(infile):
    with open(infile, "r") as f:
        in_lines = f.readlines()
    
    # parse input file
    sym_labels = {}
    in_section = ""
    for line in in_lines:
        comment_index = line.find(";")
        if comment_index != -1:
            line = line[:comment_index]
        line = line.strip()
        if line == "":
            continue
        
        if line.startswith("["):
            in_section = line
        elif in_section == "[information]":
            if line.startswith("version "):
                in_version = int(line[len("version "):])
                if in_version != 3:
                    raise Exception("SYM file bad version: " + line)
        elif in_section == "[labels]":
            # rom labels
            label_value, label_name = line.split(" ")
            label_bank, label_address = label_value.split(":")
            label_bank = int(label_bank, 16)
            label_address = int(label_address, 16)
            if BANKS_AREA[label_bank] is not None:
                label_name = label_name.replace(BANKS_AREA[label_bank], "{AREA}")
            if label_bank not in sym_labels:
                sym_labels[label_bank] = {}
            sym_labels[label_bank][label_name] = label_address
    
    for bank, bank_name in enumerate(BANKS):
        print(f"-- {bank_name} --")
        with open(f"SRC/{bank_name}.asm", "r") as f:
            bank_text = f.readlines()
        parse_lines(bank_text, bank, sym_labels)
        with open(f"SRC/{bank_name}.asm", "w") as f:
            f.writelines(bank_text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('infile', help='Input WLA-DX SYM file')
    args = ap.parse_args()

    address_labels(args.infile)


if __name__ == "__main__":
    main()
