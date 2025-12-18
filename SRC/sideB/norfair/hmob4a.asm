; side B file $06 - hmob4a   (  vram $0C00-$0FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $84
    .ascstr "HMOB4A", $00, $00
FDSFileMacroPart2 $0C00, $01

.incbin "sideB/norfair/hmob4a.chr"

FDSFileMacroPart3

