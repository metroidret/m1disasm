; side B file $0B - hmob5a   (  vram $0C00-$0FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $85
    .ascstr "HMOB5A", $00, $00
FDSFileMacroPart2 $0C00, $01

.incbin "sideB/tourian/hmob5a.chr"

FDSFileMacroPart3

