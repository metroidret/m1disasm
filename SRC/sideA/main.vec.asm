; side A file $07 - main.vec (prgram $DFFA-$DFFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $20
    .ascstr "MAIN.VEC"
FDSFileMacroPart2 $DFFA, $00

.word MAIN_NMI
.word BMENST_RESET
.word BMENST_RESET

FDSFileMacroPart3

