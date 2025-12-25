; side B file $00 - hmbg1a   (  vram $1000-$114F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_81
    .ascstr "HMBG1A", $00, $00
FDSFileMacroPart2 $1000, FDSFileType_CHRRAM

.incbin "sideB/brinstar/hmbg1a.chr"

FDSFileMacroPart3

