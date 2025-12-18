; side B file $03 - hmob1b   (  vram $0C00-$0FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $81
    .ascstr "HMOB1B", $00, $00
FDSFileMacroPart2 $0C00, $01

.incbin "sideB/brinstar/hmob1b.chr"

FDSFileMacroPart3

