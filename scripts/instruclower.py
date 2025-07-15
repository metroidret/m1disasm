import argparse

def instruclower(infile):
    with open(infile, "r") as f:
        lines = f.readlines()

    for line in lines:
        label = line[:10].strip()
        if len(label) != 0:
            print(label + ":")
        
        line = line[10:]
        if line.find(";") != -1:
            line = line[:line.find(";")]
        line = line.split()
        
        if len(line) == 0:
            print()
            continue
        
        if line[0] == "BRK":
            print("    .byte $00")
            continue
        
        line[0] = line[0].lower()
        if len(line) >= 2:
            if len(line[1]) == 1:
                line[1] = line[1].lower()
            if line[1].find(",") != -1 and len(line[1].split(",")[1]) == 1:
                line[1] = line[1][:-2] + line[1][-2:].lower()
            if line[1].find(",") != -1 and len(line[1].split(",")[1]) == 2 and line[1][-1:] == ")":
                line[1] = line[1][:-2] + line[1][-2:].lower()
        
        print("    " + " ".join(line))

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('infile', help='Input song ASM file')
    args = ap.parse_args()

    instruclower(args.infile)

if __name__ == "__main__":
    main()

