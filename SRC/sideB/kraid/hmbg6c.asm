; side B file $07 - hmbg6c   (  vram $1000-$12DF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $92
    .ascstr "HMBG6C", $00, $00
FDSFileMacroPart2 $1000, $01

.incbin "sideB/kraid/hmbg6c.chr"

FDSFileMacroPart3

