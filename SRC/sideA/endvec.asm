; side A file $0D - endvec   (prgram $DFFA-$DFFF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $EE
    .ascstr "ENDVEC", $00, $00
FDSFileMacroPart2 $DFFA, $00

.word ENDPGM_NMI
.word ENDPGM_RESET
.word ENDPGM_IRQ

FDSFileMacroPart3

