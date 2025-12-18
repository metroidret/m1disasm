; side B file $01 - hmbg1b   (  vram $1200-$164F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $90
    .ascstr "HMBG1B", $00, $00
FDSFileMacroPart2 $1200, $01

.incbin "sideB/brinstar/hmbg1b.chr"

FDSFileMacroPart3

