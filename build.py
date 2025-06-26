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

class BuildTarget:
    def __init__(self, md5_hash_expected_hex, filename):
        self.md5_hash_expected_hex = md5_hash_expected_hex
        self.filename = filename

build_targets = {
    "NES_NTSC": BuildTarget(
        md5_hash_expected_hex="d7da4a907be0012abca6625471ef2c9c",
        filename="out/M1_NTSC.nes",
    ),
    "NES_PAL": BuildTarget(
        md5_hash_expected_hex="442fcb92fce27cabdb7635bd35593d8a",
        filename="out/M1_PAL.nes",
    )
}

for bt, bto in build_targets.items():
    print('-- Building target ' + bt + ' --')
    print('Assembling .asm files')
    for bank in banks:
        run_or_exit("wla-6502 -h -D BUILDTARGET=\"" + bt + "\" -o out/" + bank + ".o -I SRC SRC/" + bank + ".asm", "Assembler Error.")
    print('Success\n')

    print('Linking .o files')
    log_filename = "out/linkerlog_" + bt + ".txt"
    completed_process = subprocess.run("wlalink -c -S SRC/linkfile " + bto.filename + " 2> " + log_filename, shell=True)
    if completed_process.returncode != 0:
        print("Linker Error. Here are the last few lines of " + log_filename)
        with open(log_filename, "r") as f:
            log_lines = f.readlines()
        print("".join(log_lines[-10:]))
        exit(completed_process.returncode)
    print('Success\n')

    with open(bto.filename, "rb") as f:
        md5_hash_generated = hashlib.md5(f.read())
    print('MD5 hash: ' + md5_hash_generated.hexdigest())

    if md5_hash_generated.hexdigest() == bto.md5_hash_expected_hex:
        print("Hash matches vanilla ROM.")
    else:
        print("Hash does not match vanilla ROM.")
