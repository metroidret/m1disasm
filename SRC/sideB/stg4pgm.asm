; side B file $16 - stg4pgm  (prgram $B560-$CFDF)
; Norfair Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $11
    .ascstr "STG4PGM", $00
FDSFileMacroPart2 $B560, $00



.redef AREA = "STG4PGM"

    .word $C168
    .word $C18C
    .word $C198
    .word $C192
    .word $C19E
    .word $C1A4
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1C7
    .word $C1CE
    .word $C1D5
    .word $C1DC
    .word $C1E3
    
    .word $C2A9

    .word $C1EB
    .word $C247
    .word $CEBC
    .word EnFramePtrTable1_{AREA}
    .word EnFramePtrTable2_{AREA}
    .word EnPlacePtrTable_{AREA}
    .word EnAnimTable_{AREA}
    
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    
    .byte $4C, $8D, $BB
    
    .byte $49, $FF
    .byte $18, $69, $01, $60
    
    .byte $FF
    
    .byte $08
    
    .word $0100
    
    .byte $10, $05, $27, $04, $0F, $FF, $FF
    
    .byte $16
    
    .byte $0D
    
    .byte $6E
    
    .byte $01
    
    .byte $00
    
    .byte $03
    
    .byte $77
    
    .byte $53, $57
    
    .byte $55, $59
    
    .byte $5B, $4F
    
    .byte $32
    
; Enemy AI jump table
ChooseEnemyAIRoutine: ;($B5DD)
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word $B8CB
        .word $B900
        .word $B8B8
        .word $B82B
        .word $B82B
        .word $B82B
        .word $B98E
        .word $B848
        .word $B82B
        .word $B82B
        .word $B82B
        .word $BA5C
        .word $BACE
        .word $BAE1
        .word $BB54
        .word $B82B
    
    .byte $28, $28
    .byte $28, $28
    .byte $30, $30
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $75, $75
    .byte $84, $82
    .byte $00, $00
    .byte $11, $11
    .byte $13, $18
    .byte $35, $35
    .byte $41, $41
    .byte $4B, $4B
    .byte $00, $00
    .byte $00, $00
    
    .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00
    
    .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86
    .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00
    
    .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C
    .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00
    
    .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00
    
    .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00
    
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00
    
    .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00
    
    .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00
    
    .byte $12, $14, $00, $00, $00, $00, $02, $02, $00, $04, $06, $09, $0E, $10, $12, $00
    
    .word $B7DF, $B7DF
    .word $B7DF, $B7DF
    .word $B7DF, $B7E2
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $B7E5, $B7E5
    .word $0000, $0000
    .word $0000, $0000
    
    .byte $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB, $FD, $00, $00, $00
    .byte $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01, $01, $00, $01, $01, $03, $00, $00, $00
    
    .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00
    
    .byte $00, $00
    .byte $00, $00
    .byte $4D, $4D
    .byte $53, $57
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $08, $F8
    .byte $00, $00
    .byte $00, $00
    .byte $08, $F8
    .byte $00
    .byte $00
    .byte $00
    .byte $F8
    
    .word $B7EF
    .word $B7FE
    .word $B80D
    .word $B81C
    .word $BB8E
    .word $BB93
    .word $BB98
    .word $BB9D
    .word $BBA2
    .word $BBA7
    .word $BBAC
    .word $BBB1
    .word $BBB6
    .word $BBBB
    .word $BBC0
    .word $BBC5
    .word $BBCA
    .word $BBCA
    .word $BBCA
    .word $BBCA
    .word $BBCA
    
    .byte $00
        .byte $02
    .byte $00
        .byte $09
    .byte $00
        .byte $0D
    .byte $01
        .byte $0E, $0F
    .byte $03
        .byte $00, $01, $02, $03
    .byte $00
        .byte $10
    .byte $00
        .byte $11
    .byte $00
        .byte $00
    .byte $00
        .byte $01


    .byte $01, $03
    .byte $FF

    .byte $01, $0B
    .byte $FF

    .byte $14, $90
    .byte $0A, $00
    .byte $FD
    .byte $30, $00
    .byte $14, $10
    .byte $FA



    .byte $0A, $D3
    .byte $07, $B3
    .byte $07, $93
    .byte $07, $03
    .byte $07, $13
    .byte $07, $23
    .byte $50, $33
    .byte $FF
    
    .byte $09, $C2
    .byte $08, $A2
    .byte $07, $92
    .byte $07, $12
    .byte $08, $22
    .byte $09, $42
    .byte $50, $72
    .byte $FF
    
    .byte $07, $C2
    .byte $06, $A2
    .byte $05, $92
    .byte $05, $12
    .byte $06, $22
    .byte $07, $42
    .byte $50, $72
    .byte $FF
    
    .byte $05, $C2
    .byte $04, $A2
    .byte $03, $92
    .byte $03, $12
    .byte $04, $22
    .byte $05, $42
    .byte $50, $72
    .byte $FF



    .byte $A9, $00
    .byte $9D, $60, $B4
    .byte $60
    
    .byte $A5, $7C
    .byte $C9, $01
    .byte $F0, $09
    .byte $C9, $03
    .byte $F0, $0A
    .byte $A5, $00
    .byte $4C, $00, $6C
    .byte $A5, $01
    .byte $4C, $03, $6C
    .byte $4C, $06, $6C



; enemy ai routines
    .byte $BD, $60, $B4, $C9, $02, $D0, $38, $BD
    .byte $03, $04, $D0, $33, $BD, $6A, $B4, $D0, $12, $AD, $0D, $03, $38, $FD, $00, $04
    .byte $C9, $40, $B0, $23, $A9, $7F, $9D, $6A, $B4, $D0, $1C, $BD, $02, $04, $30, $17
    .byte $A9, $00, $9D, $02, $04, $9D, $06, $04, $9D, $6A, $B4, $BD, $05, $04, $29, $01
    .byte $A8, $B9, $B6, $B8, $9D, $03, $04, $BD, $05, $04, $0A, $30, $1E, $BD, $60, $B4
    .byte $C9, $02, $D0, $17, $20, $36, $6C, $48, $20, $39, $6C, $85, $05, $68, $85, $04
    .byte $20, $3A, $BA, $20, $27, $6C, $90, $08, $20, $4A, $BA, $A9, $03, $4C, $03, $6C
    .byte $A9, $00, $9D, $60, $B4, $60, $08, $F8, $BD, $60, $B4, $C9, $03, $F0, $03, $20
    .byte $1E, $6C, $A9, $03, $85, $00, $85, $01, $4C, $31, $B8, $A9, $03, $85, $00, $A9
    .byte $08, $85, $01, $BD, $60, $B4, $C9, $01, $D0, $0C, $BD, $05, $04, $29, $10, $F0
    .byte $05, $A9, $01, $20, $4C, $B9, $20, $EC, $B8, $4C, $31, $B8, $BD, $60, $B4, $C9
    .byte $02, $D0, $0C, $A9, $25, $BC, $02, $04, $10, $02, $A9, $22, $9D, $65, $B4, $60
    .byte $A5, $7C, $C9, $01, $F0, $10, $C9, $03, $F0, $3F, $BD, $60, $B4, $C9, $01, $D0
    .byte $0A, $A9, $00, $20, $4C, $B9, $A9, $08, $4C, $03, $6C, $A9, $80, $9D, $6A, $B4
    .byte $BD, $02, $04, $30, $1C, $BD, $05, $04, $29, $10, $F0, $15, $BD, $00, $04, $38
    .byte $ED, $0D, $03, $10, $03, $20, $BE, $B5, $C9, $10, $B0, $05, $A9, $00, $9D, $6A
    .byte $B4, $20, $EC, $B8, $A9, $03, $4C, $00, $6C, $4C, $06, $6C, $9D, $6E, $B4, $BD
    .byte $0B, $04, $48, $20, $2A, $6C, $68, $9D, $0B, $04, $60, $20, $1B, $6C, $A9, $06
    .byte $85, $00, $4C, $31, $B8, $20, $1B, $6C, $A9, $06, $85, $00, $4C, $31, $B8, $20
    .byte $1B, $6C, $A9, $06, $85, $00, $A5, $7C, $C9, $02, $D0, $0F, $DD, $60, $B4, $D0
    .byte $0A, $20, $09, $6C, $29, $03, $D0, $03, $4C, $45, $B8, $4C, $31, $B8, $20, $09
    .byte $6C, $29, $03, $F0, $34, $A5, $7C, $C9, $01, $F0, $36, $C9, $03, $F0, $2F, $BD
    .byte $60, $B4, $C9, $03, $F0, $23, $BD, $0A, $04, $29, $03, $C9, $01, $D0, $11, $BC
    .byte $00, $04, $C0, $EB, $D0, $0A, $20, $02, $BA, $A9, $03, $9D, $0A, $04, $D0, $06
    .byte $20, $27, $BA, $20, $ED, $B9, $20, $0B, $BA, $A9, $03, $20, $0C, $6C, $4C, $06
    .byte $6C, $4C, $03, $6C, $BD, $05, $04, $4A, $BD, $0A, $04, $29, $03, $2A, $A8, $B9
    .byte $E5, $B9, $4C, $0F, $6C, $69, $69, $72, $6C, $6F, $6F, $6C, $72, $A6, $45, $B0
    .byte $19, $A5, $00, $D0, $0D, $BC, $0A, $04, $88, $98, $29, $03, $9D, $0A, $04, $4C
    .byte $D4, $B9, $BD, $05, $04, $49, $01, $9D, $05, $04, $60, $20, $1F, $BA, $20, $27
    .byte $BA, $A6, $45, $90, $09, $20, $1F, $BA, $9D, $0A, $04, $20, $D4, $B9, $60, $BC
    .byte $0A, $04, $C8, $98, $29, $03, $60, $BC, $05, $04, $84, $00, $46, $00, $2A, $0A
    .byte $A8, $B9, $49, $6C, $48, $B9, $48, $6C, $48, $60, $BD, $00, $04, $85, $08, $BD
    .byte $01, $04, $85, $09, $BD, $67, $B4, $85, $0B, $60, $A5, $0B, $29, $01, $9D, $67
    .byte $B4, $A5, $08, $9D, $00, $04, $A5, $09, $9D, $01, $04, $60, $A5, $7C, $C9, $01
    .byte $D0, $1E, $BD, $60, $B4, $C9, $03, $F0, $59, $C9, $02, $D0, $13, $BC, $08, $04
    .byte $B9, $CA, $BA, $9D, $02, $04, $A9, $40, $9D, $6A, $B4, $A9, $00, $9D, $06, $04
    .byte $BD, $60, $B4, $C9, $03, $F0, $3B, $A5, $7C, $C9, $01, $F0, $35, $C9, $03, $F0
    .byte $36, $20, $36, $6C, $A6, $45, $A9, $00, $85, $05, $A9, $1D, $A4, $00, $84, $04
    .byte $30, $02, $A9, $20, $9D, $65, $B4, $20, $3A, $BA, $20, $27, $6C, $A9, $E8, $90
    .byte $04, $C5, $08, $B0, $0A, $85, $08, $BD, $05, $04, $09, $20, $9D, $05, $04, $20
    .byte $4A, $BA, $A9, $02, $4C, $03, $6C, $4C, $06, $6C, $F6, $F8, $F6, $FA, $BD, $60
    .byte $B4, $C9, $02, $D0, $03, $20, $1E, $6C, $A9, $02, $85, $00, $85, $01, $4C, $31
    .byte $B8, $BD, $60, $B4, $C9, $01, $D0, $05, $A9, $E8, $9D, $00, $04, $C9, $02, $D0
    .byte $4E, $BD, $06, $04, $F0, $49, $BD, $6D, $B4, $D0, $44, $A5, $27, $29, $1F, $D0
    .byte $2B, $A5, $28, $29, $03, $F0, $42, $A9, $02, $85, $82, $A9, $00, $85, $83, $A9
    .byte $43, $85, $7E, $A9, $47, $85, $7F, $A9, $03, $85, $80, $20, $21, $6C, $BD, $05
    .byte $04, $29, $01, $A8, $B9, $7E, $00, $20, $0F, $6C, $F0, $1D, $C9, $0F, $90, $19
    .byte $BD, $05, $04, $29, $01, $A8, $B9, $52, $BB, $20, $0F, $6C, $4C, $49, $BB, $BD
    .byte $60, $B4, $C9, $03, $F0, $03, $20, $1E, $6C, $A9, $01, $85, $00, $85, $01, $4C
    .byte $31, $B8, $45, $49, $A9, $00, $9D, $61, $B4, $9D, $62, $B4, $A9, $10, $9D, $05
    .byte $04, $8A, $0A, $0A, $85, $00, $8A, $4A, $4A, $4A, $4A, $65, $27, $65, $00, $29
    .byte $47, $D0, $1A, $5E, $05, $04, $A9, $03, $85, $82, $A5, $28, $4A, $3E, $05, $04
    .byte $29, $03, $F0, $09, $85, $83, $A9, $02, $85, $80, $4C, $21, $6C



    .byte $60
    
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF
    
    .byte $22
    .byte $80, $81
    .byte $82, $83
    
    .byte $22
    .byte $84, $85
    .byte $86, $87
    
    .byte $22
    .byte $88, $89
    .byte $8A, $8B
    
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F
    
    .byte $22
    .byte $94, $95
    .byte $96, $97
    
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C
    
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E
    
    .byte $22
    .byte $90, $91
    .byte $92, $93
    
    .byte $22
    .byte $70, $71
    .byte $72, $73
    
    .byte $22
    .byte $74, $75
    .byte $75, $74
    
    .byte $22
    .byte $76, $76
    .byte $76, $76



.include "sideB/norfair/enemy_sprite_data.asm"


.include "sideB/norfair/palettes.asm"


.include "sideB/norfair/room_ptrs.asm"


.include "sideB/norfair/structure_ptrs.asm"


.include "sideB/norfair/items.asm"


.include "sideB/norfair/rooms.asm"


.include "sideB/norfair/structures.asm"


.include "sideB/norfair/metatiles.asm"



    .byte $FF, $C1, $FF, $FF, $C2, $01, $FF, $FF, $30, $00, $BC, $BD
    .byte $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $FF, $FF, $FF, $FF
    .byte $95, $B7, $14, $C7, $96, $D6, $44, $2B, $92, $39, $0F, $72, $41, $A7, $00, $1B



FDSFileMacroPart3

