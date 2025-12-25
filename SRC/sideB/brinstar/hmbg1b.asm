; side B file $01 - hmbg1b   (  vram $1200-$164F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_90
    .ascstr "HMBG1B", $00, $00
FDSFileMacroPart2 $1200, FDSFileType_CHRRAM

.incbin "sideB/brinstar/hmbg1b.chr"

FDSFileMacroPart3

