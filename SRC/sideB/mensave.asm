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
    .dstruct @0 instanceof SamusStat values
        SaveSlot: .db 0
    .endst
    .dstruct @1 instanceof SamusStat values
        SaveSlot: .db 1
    .endst
    .dstruct @2 instanceof SamusStat values
        SaveSlot: .db 2
    .endst

MENSAVE_End:



FDSFileMacroPart3

