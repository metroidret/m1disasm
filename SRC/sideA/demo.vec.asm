; side A file $05 - demo.vec (prgram $DFFA-$DFFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_00
    .ascstr "DEMO.VEC"
FDSFileMacroPart2 $DFFA, FDSFileType_PRGRAM

.word DEMO_NMI
.word DEMO_RESET
.word DEMO_RESET

FDSFileMacroPart3

