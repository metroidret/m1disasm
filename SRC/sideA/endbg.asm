; side A file $0A - endbg    (  vram $1000-$13FF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $EE
    .ascstr "ENDBG", $00, $00, $00
FDSFileMacroPart2 $1000, $01

.incbin "sideA/endbg.chr"

FDSFileMacroPart3

