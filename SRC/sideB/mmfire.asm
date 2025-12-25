; side B file $12 - mmfire   (prgram $DEA0-$DFEF)
; Norfair Song

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_11
    .ascstr "MMFIRE", $00, $00
FDSFileMacroPart2 $DEA0, FDSFileType_PRGRAM



.include "songs/norfair.asm"



; remnants of brinstar song data
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A, $44, $48, $B4, $4C, $B3, $48, $46
    .byte $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2, $44, $B9, $44, $4C, $52, $B4, $54
    .byte $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9, $26, $3E, $34, $B2, $26, $B9, $26
    .byte $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2, $2C, $B9, $2C, $3A, $2C, $FF, $C4
    .byte $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9, $18, $26, $18, $B2, $18, $FF, $C2
    .byte $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1C, $B9, $1C
    .byte $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF, $B2, $26, $12, $16, $18, $1C, $20
    .byte $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2, $10, $B9, $30, $2C, $28, $B2, $1E
    .byte $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9, $2A, $FF, $E8, $B2, $04, $04, $04
    .byte $B9, $04, $04, $04, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $CA, $B1, $04, $04, $04, $07, $04, $04, $FF, $E0, $B4, $04, $FF, $17, $18



FDSFileMacroPart3

