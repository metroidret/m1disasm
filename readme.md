# Metroid 1 Disassembly

A full disassembly of Metroid 1 for the NES, with sections of varying completeness.

Based on the prior work of SnowBro (Kent Hansen), Dirty McDingus, and the metconst wiki. ZaneDubya's MMC3 mapper port was also a useful resource in making this. Figurative fork of alex-west's [met1disasm](https://github.com/alex-west/met1disasm) GitHub repository.

The code has been manually reworked multiple times in a laborious journey to find the assembler fit for the job. (Ophis -> asm6f -> ca65 -> WLA-DX)

Versions of WLA-DX prior to v10.7 will not work. The latest release, v10.6 back in late 2023, does not have the newest features like the `substring` function, which are used in this disassembly. Because v10.7 is not yet released, you must compile WLA-DX v10.7 from [its source code](https://github.com/vhelin/wla-dx). Instructions on how to compile can be found in WLA-DX's README.

To build, run `python build.py` in the root folder of the disassembly. Each bank will be compiled into its own object file, and then linked together. Duplicate labels that share a name necessarily have the same NES memory location. For duplicate content that doesn't need to be at the same location, labels must use the \_{AREA} suffix.

### Contributing

Please be sure to verify that your code produces an exact copy of the original before submitting a pull request. Run the build script to check that all build targets still have the right checksums.

### File Structure

Subject to change.

 * build.py - Run this to build. Requires WLA-DX binaries to be in your path.
 * SRC/prg*.asm - Main assembly files for each bank
 * SRC/brinstar, SRC/norfair, etc. - Data pertaining to each bank
 * SRC/common\_chr - Common CHR data
 * SRC/enemies - Assembly files for enemy AI routines shared between areas
 * SRC/songs - Song data for all songs in the game

### Build targets

 * NES\_NTSC - The NTSC version of the game released in North America. This is the most popular one. Port of the FDS version.
 * NES\_PAL - The PAL version of the game released in Europe. Derived from NES\_NTSC.
 * NES\_MZMUS - The version of the game included as part of Metroid Zero Mission's North American release. This version is used together with GBA-side hijacks and features to produce the "Original Metroid" sub-game. It has no tile data, because the tile data was compressed separately and is recombined with the game upon decompression. Derived from NES\_NTSC.
 * NES\_MZMUS\_G - This is NES\_MZMUS after it is recombined with its tile data.
 * NES\_MZMJP - The version of the game included as part of Metroid Zero Mission's European release and then its Japanese release. Removes the reset vector, because GBA-side emulation doesn't use it. There is no NES\_MZMJP\_G, because it uses a different strategy than the North American release to handle tile data. Derived from NES\_MZMUS.
 * NES\_CNSUS - The version of the game used for Classic NES Series Metroid's North American and European release. Uses illegal opcode $42 for some hijacks, like opening the save menu on the password display screen. Derived from NES\_MZMUS\_G.
