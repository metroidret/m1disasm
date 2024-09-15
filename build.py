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

banks_asm = [
    "header.asm",
    "prg0_title.asm",
    "prg1_brinstar.asm",
    "prg2_norfair.asm",
    "prg3_tourian.asm",
    "prg4_kraid.asm",
    "prg5_ridley.asm",
    "prg6_graphics.asm",
    "prg7_engine.asm",
]

banks_o = [
    "header.o",
    "bank0.o",
    "bank1.o",
    "bank2.o",
    "bank3.o",
    "bank4.o",
    "bank5.o",
    "bank6.o",
    "bank7.o",
]
    
print('Assembling .asm files')
for i in range(len(banks_o)):
    run_or_exit(cc65_bin_path + "ca65" + ext + " SRC/" + banks_asm[i] + " -o out/" + banks_o[i], "Assembler Error.")
    print(banks_o[i] + ' assembled')
print('Success\n')

print('Linking .o files')
run_or_exit(cc65_bin_path + "ld65" + ext + " " + " ".join(["out/" + bank_o for bank_o in banks_o]) + " -o out/M1.nes -C SRC/main.cfg", "Linker Error.")
print('Success\n')

"""print('Fixing header')
run_or_exit("rgbfix -v out/M2RoS.gb", "RGBFIX Error.")
print('Done\n')"""

with open("out/M1.nes", "rb") as f:
    md5_hash = hashlib.md5(f.read())
print('MD5 hash: ' + md5_hash.hexdigest())
print('Vanilla : d7da4a907be0012abca6625471ef2c9c')
