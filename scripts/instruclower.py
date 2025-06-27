import sys

if len(sys.argv) < 2:
    exit("usage: " + sys.argv[0] + " <filename>")

with open(sys.argv[1], "r") as f:
    lines = f.readlines()

for line in lines:
    l = line
    if l.find(";") != -1:
        l = l[:l.find(";")]
    l = l.split()
    if len(l) < 1 or len(l[0]) != 3 or l[0].startswith(".") or l[0].endswith(":"):
        print(line[:-1])
        continue
    li = line.index(l[0])+3
    l0 = line[:li].lower()
    l1 = line[li:]
    print((l0+l1)[:-1])