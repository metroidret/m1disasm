; side B file $09 - hmbg5c   (  vram $1900-$198F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_85
    .ascstr "HMBG5C", $00, $00
FDSFileMacroPart2 $1900, FDSFileType_CHRRAM

.incbin "sideB/tourian/hmbg5c.chr"

FDSFileMacroPart3

