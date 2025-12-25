; side A file $07 - main.vec (prgram $DFFA-$DFFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_20
    .ascstr "MAIN.VEC"
FDSFileMacroPart2 $DFFA, FDSFileType_PRGRAM

.word MAIN_NMI
.word BMENST_RESET
.word BMENST_RESET

FDSFileMacroPart3

