; side B file $1B - mensave  (prgram $C000-$C3EF)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $EF
    .ascstr "MENSAVE", $00
FDSFileMacroPart2 $C000, $00



.ds $3DF, $00
.byte $01
.ds $F, $00
.byte $02



FDSFileMacroPart3

