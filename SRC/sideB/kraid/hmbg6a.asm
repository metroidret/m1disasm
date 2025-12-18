; side B file $0C - hmbg6a   (  vram $1700-$17BF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $86
    .ascstr "HMBG6A", $00, $00
FDSFileMacroPart2 $1700, $01

.incbin "sideB/kraid/hmbg6a.chr"

FDSFileMacroPart3

