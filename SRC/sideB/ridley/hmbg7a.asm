; side B file $0F - hmbg7a   (  vram $1700-$17BF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_87
    .ascstr "HMBG7A", $00, $00
FDSFileMacroPart2 $1700, FDSFileType_CHRRAM

.incbin "sideB/ridley/hmbg7a.chr"

FDSFileMacroPart3

