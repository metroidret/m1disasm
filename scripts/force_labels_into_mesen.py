import argparse
import json

def force_labels_into_mesen(infile, outfile):
    with open(infile, "r") as f:
        in_lines = f.readlines()
    
    # parse input file
    in_labels = {}
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
            label_name = label_name.replace("@", "_").replace(".", "_")
            label_bank = int(label_bank, 16)
            label_address = int(label_address, 16)
            # undo how mmc1 maps prgrom to nes memory
            label_prgrom = label_bank * 0x4000 + (label_address & 0x3fff)
            in_labels[label_name] = {
                "Address": label_prgrom,
                "MemoryType": "NesPrgRom",
                "Label": label_name,
                "Comment": "",
                "Flags": "None",
                "Length": 1
            }
        elif in_section == "[definitions]":
            # ram labels
            label_value, label_name = line.split(" ")
            if label_name.startswith("_"):
                # those are internal definitions, not ram labels
                if label_name.startswith("_sizeof_"):
                    # the following code assumes each _sizeof_ definition comes after its label
                    label_name = label_name[len("_sizeof_"):]
                    label_name = label_name.replace("@", "_").replace(".", "_")
                    if in_labels[label_name]["MemoryType"] != "NesMemory":
                        # don't apply _sizeof_ to rom labels, it looks bad in the debugger
                        continue
                    label_value = int(label_value, 16)
                    in_labels[label_name]["Length"] = label_value
                continue
            label_name = label_name.replace("@", "_").replace(".", "_")
            label_value = int(label_value, 16)
            in_labels[label_name] = {
                "Address": label_value,
                "MemoryType": "NesMemory",
                "Label": label_name,
                "Comment": "",
                "Flags": "None",
                "Length": 1
            }
    
    
    with open(outfile, "r", encoding="utf-8-sig") as f:
        out_text = f.read()
    out_json = json.loads(out_text)
    
    out_json_labels = out_json["WorkspaceByCpu"]["Nes"]["Labels"]
    
    # remove all but console labels
    for i in range(len(out_json_labels)-1, -1, -1):
        label = out_json_labels[i]
        if label["MemoryType"] == "NesMemory" and label["Address"] >= 0x2000 and label["Address"] < 0x4020:
            continue
        out_json_labels.pop(i)
    
    # add labels from input file
    out_json_labels += in_labels.values()
    
    out_text = json.dumps(out_json, indent=2)
    with open(outfile, "w", encoding="utf-8-sig") as f:
        f.write(out_text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('infile', help='Input WLA-DX SYM file')
    ap.add_argument('outfile', help='Output MESEN debugger workspace JSON file')
    args = ap.parse_args()

    force_labels_into_mesen(args.infile, args.outfile)


if __name__ == "__main__":
    main()
