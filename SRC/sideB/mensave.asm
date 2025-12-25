; side B file $1B - mensave  (prgram $C000-$C3EF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_EF
    .ascstr "MENSAVE", $00
FDSFileMacroPart2 $C000, FDSFileType_PRGRAM



MENSAVE_C000:
    .ds $140, $00
MENSAVE_C140:
    .ds $140, $00
MENSAVE_C280:
    .ds $140, $00

MENSAVE_C3C0:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02

MENSAVE_End:



FDSFileMacroPart3

