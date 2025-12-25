; side B file $0D - hmbg6b   (  vram $1E00-$1FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_86
    .ascstr "HMBG6B", $00, $00
FDSFileMacroPart2 $1E00, FDSFileType_CHRRAM

.incbin "sideB/kraid/hmbg6b.chr"

FDSFileMacroPart3

