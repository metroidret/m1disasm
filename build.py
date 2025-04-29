import os
import subprocess
import hashlib

def run_or_exit(args, err):
    completed_process = subprocess.run(args, shell=True)
    if completed_process.returncode != 0:
        print("\n" + err + "\n")
        exit(completed_process.returncode)


if not os.path.exists('out/'):
    os.mkdir('out/')

is_windows = os.path.join("a", "b") == "a\\b"
cc65_bin_path = "cc65\\bin\\" if is_windows else "cc65-master/bin/"
ext = ".exe" if is_windows else ""

banks = [
    "header",
    "prg0_title",
    "prg1_brinstar",
    "prg2_norfair",
    "prg3_tourian",
    "prg4_kraid",
    "prg5_ridley",
    "prg6_graphics",
    "prg7_engine",
]

print('Assembling .asm files')
for i in range(len(banks)):
    run_or_exit(cc65_bin_path + "ca65" + ext + " SRC/" + banks[i] + ".asm -o out/" + banks[i] + ".o -l out/" + banks[i] + ".lst -g", "Assembler Error.")
    print(banks[i] + '.o assembled')
print('Success\n')

print('Linking .o files')
run_or_exit(cc65_bin_path + "ld65" + ext + " " + " ".join([("out/" + bank + ".o") for bank in banks]) + " -C SRC/main.cfg -o out/M1.nes -m out/M1.map -Ln out/M1.lbl", "Linker Error.")
print('Success\n')

with open("out/M1.nes", "rb") as f:
    md5_hash = hashlib.md5(f.read())
print('MD5 hash: ' + md5_hash.hexdigest())
print('Vanilla : d7da4a907be0012abca6625471ef2c9c')
