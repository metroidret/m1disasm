; side B file $04 - hmbg4a   (  vram $1000-$125F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $84
    .ascstr "HMBG4A", $00, $00
FDSFileMacroPart2 $1000, $01

.incbin "sideB/norfair/hmbg4a.chr"

FDSFileMacroPart3

