; side B file $10 - hmob7a   (  vram $0C00-$0FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_87
    .ascstr "HMOB7A", $00, $00
FDSFileMacroPart2 $0C00, FDSFileType_CHRRAM

.incbin "sideB/ridley/hmob7a.chr"

FDSFileMacroPart3

