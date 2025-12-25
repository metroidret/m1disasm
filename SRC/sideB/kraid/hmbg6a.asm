; side B file $0C - hmbg6a   (  vram $1700-$17BF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_86
    .ascstr "HMBG6A", $00, $00
FDSFileMacroPart2 $1700, FDSFileType_CHRRAM

.incbin "sideB/kraid/hmbg6a.chr"

FDSFileMacroPart3

