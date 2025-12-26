import os
import subprocess
import hashlib
from scripts.rearrange_fdsfiles import rearrange_fdsfiles

def run_or_exit(args, err):
    completed_process = subprocess.run(args, shell=True)
    if completed_process.returncode != 0:
        print("\n" + err + "\n")
        exit(completed_process.returncode)



fds_diskinfo_list = [
    "sideA/disk_info",
    "sideB/disk_info",
]
fds_filesys = [
    [
        "sideA/kyodaku",
        "sideA/demo.chr",
        "sideA/met.hex",
        "sideA/demo.pgm",
        "sideA/demo.pg2",
        "sideA/demo.vec",
        "sideA/bmenst",
        "sideA/main.vec",
        "sideA/main.pgm",
        "sideA/endobj",
        "sideA/endbg",
        "sideA/mmeee",
        "sideA/endpgm",
        "sideA/endvec",
        "sideA/savedata",
    ],
    [
        "sideB/brinstar/hmbg1a",
        "sideB/brinstar/hmbg1b",
        "sideB/brinstar/hmbg1c",
        "sideB/brinstar/hmob1b",
        "sideB/norfair/hmbg4a",
        "sideB/norfair/hmbg4b",
        "sideB/norfair/hmob4a",
        "sideB/kraid/hmbg6c",
        "sideB/tourian/hmbg5b",
        "sideB/tourian/hmbg5c",
        "sideB/tourian/hmbg5d",
        "sideB/tourian/hmob5a",
        "sideB/kraid/hmbg6a",
        "sideB/kraid/hmbg6b",
        "sideB/kraid/hmob6a",
        "sideB/ridley/hmbg7a",
        "sideB/ridley/hmob7a",
        "sideB/mmrock",
        "sideB/mmfire",
        "sideB/mmkiti",
        "sideB/mmkbos",
        "sideB/stg1pgm",
        "sideB/stg4pgm",
        "sideB/stg5pgm",
        "sideB/stg6pgm",
        "sideB/stg7pgm",
        "sideB/mensave2",
        "sideB/mensave",
    ]
]

for filepath in (fds_diskinfo_list + [fds_file for fds_side in fds_filesys for fds_file in fds_side]):
    filepath = "out/" + filepath
    filepath = filepath.split("/")
    for i in range(1, len(filepath)):
        out_folder = "/".join(filepath[0:i])
        if not os.path.exists(out_folder):
            os.mkdir(out_folder)

fds_assembler_vars = {
    "FDSFile_Bank": 0,
    "FDSFile_Side": 0,
    "FDSFile_Number": 0,
    "FDSFile_SideFileQty": 0,
}

class BuildTarget:
    def __init__(self, md5_hash_expected_hex, filename):
        self.md5_hash_expected_hex = md5_hash_expected_hex
        self.filename = filename

build_targets = {
    "FDS": BuildTarget(
        md5_hash_expected_hex="d68f36d25a3474663bb1decfe0fcb395",
        filename="out/M1_FDS_temp.fds",
    ),
}
bt = "FDS"
bto = build_targets[bt]

print('-- Building target ' + bt + ' --')
print('Assembling .asm files')
for fds_side, fds_diskinfo_file in zip(fds_filesys, fds_diskinfo_list):
    # disk info of side
    fds_assembler_vars["FDSFile_Number"] = 0
    fds_assembler_vars["FDSFile_SideFileQty"] = len(fds_side)
    strvars = " ".join([f"-D {var}={value}" for var, value in fds_assembler_vars.items()])
    run_or_exit(f"wla-6502 -h -D BUILDTARGET=\"{bt}\" {strvars} -o out/{fds_diskinfo_file}.o -I SRC SRC/{fds_diskinfo_file}.asm", "Assembler Error.")
    fds_assembler_vars["FDSFile_Bank"] += 1
    for fds_file in fds_side:
        strvars = " ".join([f"-D {var}={value}" for var, value in fds_assembler_vars.items()])
        run_or_exit(f"wla-6502 -h -D BUILDTARGET=\"{bt}\" {strvars} -o out/{fds_file}.o -I SRC SRC/{fds_file}.asm", "Assembler Error.")
        fds_assembler_vars["FDSFile_Bank"] += 2
        fds_assembler_vars["FDSFile_Number"] += 1
    fds_assembler_vars["FDSFile_Side"] += 1
print('Success\n')

print('Linking .o files')
log_filename = f"out/linkerlog_{bt}.txt"
completed_process = subprocess.run(f"wlalink -c -S SRC/linkfile {bto.filename} 2> {log_filename}", shell=True)
if completed_process.returncode != 0:
    print("Linker Error. Here are the last few lines of {log_filename}")
    with open(log_filename, "r") as f:
        log_lines = f.readlines()
    print("".join(log_lines[-10:]))
    exit(completed_process.returncode)
print('Success\n')

print('Packing internal files in ROM filesystem')
rearrange_fdsfiles(bto.filename, "out/M1_FDS_temp.sym", "out/M1_FDS.fds")
print('Success\n')

with open("out/M1_FDS.fds", "rb") as f:
    md5_hash_generated = hashlib.md5(f.read())
print('MD5 hash: ' + md5_hash_generated.hexdigest())

if md5_hash_generated.hexdigest() == bto.md5_hash_expected_hex:
    print("Hash matches vanilla ROM.")
else:
    print("Hash does not match vanilla ROM.")

