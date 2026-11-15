import os
import sys
import subprocess
import hashlib

def run_or_exit(args, err):
    completed_process = subprocess.run(args, shell=True)
    if completed_process.returncode != 0:
        print(f"\n{err}\n")
        completed_process.check_returncode()



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

class BuildTarget:
    def __init__(self, name, md5_hash_expected_hex):
        self.name = name
        self.filename = f"out/M1_{name}.nes"
        self.md5_hash_expected_hex = md5_hash_expected_hex

BUILD_TARGETS = [
    BuildTarget(
        name="NES_NTSC",
        md5_hash_expected_hex="d7da4a907be0012abca6625471ef2c9c",
    ),
    BuildTarget(
        name="NES_PAL",
        md5_hash_expected_hex="442fcb92fce27cabdb7635bd35593d8a",
    ),
    BuildTarget(
        name="NES_MZM",
        md5_hash_expected_hex="8b95635a38bcc59b9f04714f9a4f8514",
    ),
    BuildTarget(
        name="NES_MZM_G",
        md5_hash_expected_hex="b27e46122890364407af3ee7591477ad",
    ),
    BuildTarget(
        name="NES_CNS",
        md5_hash_expected_hex="164fe605f9d1586e9c9d50e0f1e48703",
    ),
]



def main():
    if not os.path.exists("out/"):
        os.mkdir("out/")

    exit_code = 0
    for bto in BUILD_TARGETS:
        try:
            bt = bto.name
            print(f"-- Building target {bto.name} --")
            print("Assembling .asm files")
            for bank in BANKS:
                run_or_exit(f"wla-6502 -h -w -D BUILDTARGET=\"{bto.name}\" -o out/{bank}.o -I SRC SRC/{bank}.asm", "Assembler Error.")
            print("Success\n")

            print("Linking .o files")
            log_filename = "out/linkerlog_" + bt + ".txt"
            completed_process = subprocess.run(f"wlalink -C -S SRC/linkfile {bto.filename} 2> {log_filename}", shell=True)
            if completed_process.returncode != 0:
                print(f"Linker Error. Here are the last few lines of {log_filename}")
                with open(log_filename, "r") as f:
                    log_lines = f.readlines()
                print("".join(log_lines[-10:]))
                completed_process.check_returncode()
            print("Success\n")

            with open(bto.filename, "rb") as f:
                md5_hash_generated = hashlib.md5(f.read())
            print(f"MD5 hash: {md5_hash_generated.hexdigest()}")

            if md5_hash_generated.hexdigest() == bto.md5_hash_expected_hex:
                print("Hash matches vanilla ROM.")
            else:
                print("Hash does not match vanilla ROM.")
        except subprocess.CalledProcessError:
            exit_code = 1
        print()
    sys.exit(exit_code)


if __name__ == "__main__":
    main()
