; side B file $11 - mmrock   (prgram $DEA0-$DFEF)
; Brinstar Song

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_10
    .ascstr "MMROCK", $00, $00
FDSFileMacroPart2 $DEA0, FDSFileType_PRGRAM



.include "songs/brinstar.asm"



    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $CA, $B1, $04, $04, $04, $07, $04, $04, $FF, $E0, $B4, $04, $FF, $17, $18



FDSFileMacroPart3

