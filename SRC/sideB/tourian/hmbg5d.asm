; side B file $0A - hmbg5d   (  vram $1D00-$1FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $85
    .ascstr "HMBG5D", $00, $00
FDSFileMacroPart2 $1D00, $01

.incbin "sideB/tourian/hmbg5d.chr"

FDSFileMacroPart3

