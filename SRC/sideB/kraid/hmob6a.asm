; side B file $0E - hmob6a   (  vram $0C00-$0FFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $86
    .ascstr "HMOB6A", $00, $00
FDSFileMacroPart2 $0C00, $01

.incbin "sideB/kraid/hmob6a.chr"

FDSFileMacroPart3

