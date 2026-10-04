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
    include_paths = []
    label_name_parts = []
    for i, line in enumerate(lines):
        l = line.split(";")[0].strip()
        if l.startswith(".include \""):
            include_paths.append("SRC/" + l.removeprefix(".include \"").removesuffix("\""))
        elif l.endswith(":"):
            l = l.removesuffix(":").split("@")
            assert len(l) - 1 <= len(label_name_parts), f"{l} {label_name_parts}"
            label_name_parts = label_name_parts[:len(l)-1] + l[len(l)-1:]
            label_name = "@".join(label_name_parts)
            if bank is not None and label_name in sym_labels[bank]:
                line = (
                    line.split(";")[0].rstrip() +
                    f" ; {bank:02X}:{sym_labels[bank][label_name]:04X}\n"
                )
            elif bank is None:
                addr = None
                for sym_labels_of_bank in sym_labels.values():
                    if label_name in sym_labels_of_bank:
                        if addr is None:
                            addr = sym_labels_of_bank[label_name]
                        elif addr != sym_labels_of_bank[label_name]:
                            addr = -1
                if addr == -1:
                    addr = None
                if addr is not None:
                    line = (
                        line.split(";")[0].rstrip() +
                        f" ; ${addr:04X}\n"
                    )
                    print(line)
        lines[i] = line
    return include_paths


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
    
    include_paths_per_bank = {}
    for bank, bank_name in enumerate(BANKS):
        print(f"-- {bank_name} --")
        with open(f"SRC/{bank_name}.asm", "r") as f:
            bank_text = f.readlines()
        include_paths_per_bank[bank] = parse_lines(bank_text, bank, sym_labels)
        with open(f"SRC/{bank_name}.asm", "w") as f:
            f.writelines(bank_text)
    
    include_banks_per_path = {}
    for bank, bank_paths in include_paths_per_bank.items():
        for path in bank_paths:
            if path not in include_banks_per_path:
                include_banks_per_path[path] = bank
            else:
                include_banks_per_path[path] = None
    
    include_banks_per_path["SRC/common_sprite_data.asm"] = None
    
    for path, bank in include_banks_per_path.items():
        if any(p in path for p in ["songs/pal/", "macros", "constant", "reset"]):
            continue
        print(f"-- {path} --")
        with open(path, "r") as f:
            path_text = f.readlines()
        include_paths_per_bank[bank] = parse_lines(path_text, bank, sym_labels)
        with open(path, "w") as f:
            f.writelines(path_text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('infile', help='Input WLA-DX SYM file')
    args = ap.parse_args()

    address_labels(args.infile)


if __name__ == "__main__":
    main()
