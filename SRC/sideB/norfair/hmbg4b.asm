; side B file $05 - hmbg4b   (  vram $1700-$176F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_84
    .ascstr "HMBG4B", $00, $00
FDSFileMacroPart2 $1700, FDSFileType_CHRRAM

.incbin "sideB/norfair/hmbg4b.chr"

FDSFileMacroPart3

