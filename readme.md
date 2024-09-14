# Metroid 1 Disassembly

A full disassembly of Metroid 1 for the NES, with sections of varying completeness.

Based on the prior work of SnowBro (Kent Hansen), Dirty McDingus, and the metconst wiki. ZaneDubya's MMC3 mapper port was also a useful resource in making this.

The code has been manually reworked to assemble with asm6f instead of Ophis, because Ophis was slow and lacking some crucial features.

To build, run build.bat in the SRC folder. Currently, each of the banks must be assembled separately and then combined into a single file. This may change eventually.

Please be sure to verify that your code produces an exact copy of the original before submitting a pull request.

### File Structure

Subject to change.

 * build.bat - Under Windows, click this to build. Requires asm6f to be in your path.
 * prg*.asm - Main assembly files for each bank
 * .\brinstar, .\norfair, etc. - Data pertaining to each bank
 * .\common_chr, .\misc_chr - Common and miscellaneous CHR data
 * .\enemies - Assembly files for enemies shared between areas