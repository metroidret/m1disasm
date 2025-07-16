# Metroid 1 Disassembly

A full disassembly of Metroid 1 for the NES, with sections of varying completeness.

Based on the prior work of SnowBro (Kent Hansen), Dirty McDingus, and the metconst wiki. ZaneDubya's MMC3 mapper port was also a useful resource in making this. Figurative fork of alex-west's [met1disasm](https://github.com/alex-west/met1disasm) GitHub repository.

The code has been manually reworked multiple times in a laborious journey to find the assembler fit for the job. (Ophis -> asm6f -> ca65 -> WLA-DX)
Versions of WLA-DX prior to v10.7 will not work.

To build, run `python build.py` in the root folder of the disassembly. Each bank will be compiled into its own object file, and then linked together. Right now, there is nothing to ensure multi-bank labels have consistent NES memory locations in every bank they're in. This may change eventually.

### Contributing

Please be sure to verify that your code produces an exact copy of the original before submitting a pull request.

### File Structure

Subject to change.

 * build.py - Run this to build. Requires WLA-DX binaries to be in your path.
 * SRC/prg*.asm - Main assembly files for each bank
 * SRC/brinstar, SRC/norfair, etc. - Data pertaining to each bank
 * SRC/common_chr - Common CHR data
 * SRC/enemies - Assembly files for enemy AI routines shared between areas
 * SRC/songs - Song data for all songs in the game

### Build targets

 * NES_NTSC - The NTSC version of the game released in North America. This is the most popular one. Port of the FDS version.
 * NES_PAL - The PAL version of the game released in Europe. Derived from the NTSC version.

