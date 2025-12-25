; side B file $08 - hmbg5b   (  vram $1200-$17FF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_85
    .ascstr "HMBG5B", $00, $00
FDSFileMacroPart2 $1200, FDSFileType_CHRRAM

.incbin "sideB/tourian/hmbg5b.chr"

FDSFileMacroPart3

