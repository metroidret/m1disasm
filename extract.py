import os
import importlib
modules = [importlib.import_module("scripts." + m) for m in [
    "extract_chr",
    "extract_garbage",
]]


def main():
    print('Removing previous resources from disassembly')
    for module in modules:
        module.clean()
    print('Success\n')

    print('Extracting resources from vanilla ROMs')
    for module in modules:
        module.extract()
    print('Success')


if __name__ == "__main__":
    main()

