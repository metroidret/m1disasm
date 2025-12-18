; side A file $05 - demo.vec (prgram $DFFA-$DFFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $00
    .ascstr "DEMO.VEC"
FDSFileMacroPart2 $DFFA, $00

.word DEMO_NMI
.word DEMO_RESET
.word DEMO_RESET

FDSFileMacroPart3

