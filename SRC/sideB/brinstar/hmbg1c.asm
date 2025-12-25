; side B file $02 - hmbg1c   (  vram $1800-$1FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_91
    .ascstr "HMBG1C", $00, $00
FDSFileMacroPart2 $1800, FDSFileType_CHRRAM

.incbin "sideB/brinstar/hmbg1c.chr"

FDSFileMacroPart3

