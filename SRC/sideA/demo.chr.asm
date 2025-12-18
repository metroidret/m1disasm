; side A file $01 - demo.chr (  vram $0000-$1D9F)
; Tile data for title screen

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $00
    .ascstr "DEMO.CHR"
FDSFileMacroPart2 $0000, $01

.incbin "sideA/demo.chr.chr"

FDSFileMacroPart3

