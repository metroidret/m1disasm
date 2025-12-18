; side B file $0F - hmbg7a   (  vram $1700-$17BF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $87
    .ascstr "HMBG7A", $00, $00
FDSFileMacroPart2 $1700, $01

.incbin "sideB/ridley/hmbg7a.chr"

FDSFileMacroPart3

