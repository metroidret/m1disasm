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

banks = [
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
for bank in banks:
    run_or_exit("wla-6502 -h -o out/" + bank + ".o -I SRC SRC/" + bank + ".asm", "Assembler Error.")
print('Success\n')

print('Linking .o files')
run_or_exit("wlalink -c -S SRC/linkfile out/M1.nes", "Linker Error.")
print('Success\n')

with open("out/M1.nes", "rb") as f:
    md5_hash = hashlib.md5(f.read())
print('MD5 hash: ' + md5_hash.hexdigest())
print('Vanilla : d7da4a907be0012abca6625471ef2c9c')
