; side A file $09 - endobj   (  vram $0000-$05FF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $EE
    .ascstr "ENDOBJ", $00, $00
FDSFileMacroPart2 $0000, $01

.incbin "sideA/endobj.chr"

FDSFileMacroPart3

