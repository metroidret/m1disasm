; side A file $09 - endobj   (  vram $0000-$05FF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_EE
    .ascstr "ENDOBJ", $00, $00
FDSFileMacroPart2 $0000, FDSFileType_CHRRAM

.incbin "sideA/endobj.chr"

FDSFileMacroPart3

