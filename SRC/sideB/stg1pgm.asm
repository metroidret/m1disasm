PalPntrTbl:
    .word STG1PGM_Palette00
    .word STG1PGM_Palette01
    .word STG1PGM_Palette02
    .word STG1PGM_Palette03
    .word STG1PGM_Palette04
    .word STG1PGM_Palette05
    .word STG1PGM_Palette06
    .word STG1PGM_Palette07
    .word STG1PGM_Palette08
    .word STG1PGM_Palette09
    .word STG1PGM_Palette0A
    .word STG1PGM_Palette0B
    .word STG1PGM_Palette0C
    .word STG1PGM_Palette0D
    .word STG1PGM_Palette0E
    .word STG1PGM_Palette0F
    .word STG1PGM_Palette10
    .word STG1PGM_Palette11
    .word STG1PGM_Palette12
    .word STG1PGM_Palette13
    .word STG1PGM_Palette14
    .word STG1PGM_Palette15
    .word STG1PGM_Palette16
    .word STG1PGM_Palette17

AreaPointers:
    .word $C3AE
    .word $C2EC
    .word $C34A
    .word $CEC8
    .word $BDD8
    .word $BED8
    .word $BF06
    .word $BD62

; Tourian-specific jump table
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA

AreaRoutine:
    jmp AreaRoutineStub

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts
    
    .byte $FF
    
    .byte $01
    
    .word $0080
    
    .byte $2B, $2C, $28, $0B, $1C, $0A, $1A
    
    .byte $03
    
    .byte $0E
    
    .byte $B0
    
    .byte $01
    
    .byte $00
    
    .byte $03
    
    .byte $43
    
    .byte $00, $00
    
    .byte $00, $00
    
    .byte $00, $00
    
    .byte $69


; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda $B46E,x
    jsr CommonJump_ChooseRoutine
        .word $B9B0
        .word $B9CB
        .word $B9DD
        .word $B9D0
        .word $B9F2
        .word $BA44
        .word $BAED
        .word $BB2A
        .word $BB9A
        .word $BBCA
        .word $BC12
        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0000


EnemyDeathAnimIndex:
    .byte $27, $27
    .byte $29, $29
    .byte $2D, $2B
    .byte $31, $2F
    .byte $33, $33
    .byte $41, $41
    .byte $4B, $4B
    .byte $55, $53
    .byte $72, $74
    .byte $00, $00
    .byte $00, $00
    .byte $69, $69
    .byte $69, $69
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    
EnemyHealthTbl:
    .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

; ResetAnimIndex table for resting enemy
EnemyRestingAnimIndex:
    .byte $05, $05
    .byte $0B, $0B
    .byte $17, $13
    .byte $1B, $19
    .byte $23, $23
    .byte $35, $35
    .byte $48, $48
    .byte $59, $57
    .byte $6C, $6F
    .byte $5B, $5D
    .byte $62, $67
    .byte $69, $69
    .byte $69, $69
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

; ResetAnimIndex table for active enemy
EnemyActiveAnimIndex:
    .byte $05, $05
    .byte $0B, $0B
    .byte $17, $13
    .byte $1B, $19
    .byte $23, $23
    .byte $35, $35
    .byte $48, $48
    .byte $50, $4D
    .byte $6C, $6F
    .byte $5B, $5D
    .byte $5F, $64
    .byte $69, $69
    .byte $69, $69
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00


    .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00


    .byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00

EnemyData0DTbl:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00

EnemyDistanceToSamusThreshold:
    .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl:
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

EnemyMovementChoiceOffset:
    .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

EnemyMovementPtrs:
    .byte $E7, $B7, $EA, $B7
    .byte $ED, $B7, $ED, $B7
    .byte $ED, $B7, $ED, $B7
    .byte $ED, $B7, $ED, $B7
    .byte $ED, $B7, $ED, $B7
    .byte $ED, $B7, $38, $B8
    .byte $83, $B8, $86, $B8
    .byte $89, $B8, $9D, $B8
    .byte $B1, $B8, $B1, $B8
    .byte $B1, $B8, $B1, $B8
    .byte $B1, $B8, $B1, $B8
    .byte $B1, $B8, $B1, $B8
    .byte $B1, $B8, $B8, $B8
    .byte $BF, $B8, $C6, $B8
    .byte $CD, $B8, $D0, $B8
    .byte $D3, $B8, $EA, $B8
    .byte $01, $B9, $18, $B9
    .byte $2F, $B9, $46, $B9
    
    .byte $00, $00, $00, $00, $00, $00, $00, $00

EnAccelYTable:
    .byte $7F, $40, $30, $C0, $D0, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00


    .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

    .byte $00, $00
    .byte $64, $67
    .byte $69, $69
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

EnemyFireballMovementPtrTable:
    .byte $5D, $B9
    .byte $6C, $B9
    .byte $7B, $B9
    .byte $8A, $B9

TileBlastFramePtrTable:
    .byte $2E, $BD
    .byte $33, $BD
    .byte $38, $BD
    .byte $3D, $BD
    
    .byte $42, $BD
    .byte $47, $BD
    .byte $4C, $BD
    .byte $51, $BD
    
    .byte $56, $BD
    .byte $5B, $BD
    .byte $62, $BD
    .byte $62, $BD
    
    .byte $62, $BD
    .byte $62, $BD
    .byte $62, $BD
    .byte $62, $BD
    .byte $62, $BD


    .byte $01
        .byte $01, $02
    .byte $01
        .byte $03, $04
    .byte $00
        .byte $05
    .byte $00
        .byte $06
    .byte $00
        .byte $07
    .byte $00
        .byte $08
    .byte $00
        .byte $09
    .byte $00
        .byte $00
    .byte $00
        .byte $0B
    .byte $01
        .byte $0C, $0D
    .byte $00
        .byte $0E
    .byte $03
        .byte $0F, $10, $11, $0F


    .byte $20, $22
    .byte $FE
    
    .byte $20, $2A
    .byte $FE
    
    .byte $02, $F2
    .byte $04, $E2
    .byte $04, $D2
    .byte $05, $B2
    .byte $03, $92
    .byte $04, $02
    .byte $05, $12
    .byte $03, $32
    .byte $05, $52
    .byte $04, $62
    .byte $02, $72
    .byte $02, $72
    .byte $04, $62
    .byte $04, $52
    .byte $05, $32
    .byte $03, $12
    .byte $04, $02
    .byte $05, $92
    .byte $03, $B2
    .byte $05, $D2
    .byte $04, $E2
    .byte $02, $F2
    .byte $FD
    .byte $03, $D2
    .byte $06, $B2
    .byte $08, $92
    .byte $05, $02
    .byte $07, $12
    .byte $05, $32
    .byte $04, $52
    .byte $03, $52
    .byte $06, $32
    .byte $08, $12
    .byte $05, $02
    .byte $07, $92
    .byte $05, $B2
    .byte $04, $D2
    .byte $FD
    .byte $FF
    
    .byte $02, $FA
    .byte $04, $EA
    .byte $04, $DA
    .byte $05, $BA
    .byte $03, $9A
    .byte $04, $0A
    .byte $05, $1A
    .byte $03, $3A
    .byte $05, $5A
    .byte $04, $6A
    .byte $02, $7A
    .byte $02, $7A
    .byte $04, $6A
    .byte $04, $5A
    .byte $05, $3A
    .byte $03, $1A
    .byte $04, $0A
    .byte $05, $9A
    .byte $03, $BA
    .byte $05, $DA
    .byte $04, $EA
    .byte $02, $FA
    .byte $FD
    .byte $03, $DA
    .byte $06, $BA
    .byte $08, $9A
    .byte $05, $0A
    .byte $07, $1A
    .byte $05, $3A
    .byte $04, $5A
    .byte $03, $5A
    .byte $06, $3A
    .byte $08, $1A
    .byte $05, $0A
    .byte $07, $9A
    .byte $05, $BA
    .byte $04, $DA
    .byte $FD
    .byte $FF
    
    .byte $01, $01
    .byte $FF
    
    .byte $01, $09
    .byte $FF
    
    .byte $04, $22
    .byte $01, $42
    .byte $01, $22
    .byte $01, $42
    .byte $01, $62
    .byte $01, $42
    .byte $04, $62
    .byte $FC
    .byte $01, $00
    .byte $64, $00
    .byte $FB
    
    .byte $04, $2A
    .byte $01, $4A
    .byte $01, $2A
    .byte $01, $4A
    .byte $01, $6A
    .byte $01, $4A
    .byte $04, $6A
    .byte $FC
    .byte $01, $00
    .byte $64, $00
    .byte $FB
    
    .byte $14, $11
    .byte $0A, $00
    .byte $14, $19
    .byte $FE
    
    .byte $14, $19
    .byte $0A, $00
    .byte $14, $11
    .byte $FE
    
    .byte $1E, $11
    .byte $0A, $00
    .byte $1E, $19
    .byte $FE
    
    .byte $1E, $19
    .byte $0A, $00
    .byte $1E, $11
    .byte $FE
    
    .byte $50, $04
    .byte $FF
    
    .byte $50, $0C
    .byte $FF
    
    .byte $02, $F3
    .byte $04, $E3
    .byte $04, $D3
    .byte $05, $B3
    .byte $03, $93
    .byte $04, $03
    .byte $05, $13
    .byte $03, $33
    .byte $05, $53
    .byte $04, $63
    .byte $50, $73
    .byte $FF
    
    .byte $02, $FB
    .byte $04, $EB
    .byte $04, $DB
    .byte $05, $BB
    .byte $03, $9B
    .byte $04, $0B
    .byte $05, $1B
    .byte $03, $3B
    .byte $05, $5B
    .byte $04, $6B
    .byte $50, $7B
    .byte $FF
    
    .byte $02, $F4
    .byte $04, $E4
    .byte $04, $D4
    .byte $05, $B4
    .byte $03, $94
    .byte $04, $04
    .byte $05, $14
    .byte $03, $34
    .byte $05, $54
    .byte $04, $64
    .byte $50, $74
    .byte $FF
    
    .byte $02, $FC
    .byte $04, $EC
    .byte $04, $DC
    .byte $05, $BC
    .byte $03, $9C
    .byte $04, $0C
    .byte $05, $1C
    .byte $03, $3C
    .byte $05, $5C
    .byte $04, $6C
    .byte $50, $7C
    .byte $FF
    
    .byte $02, $F2
    .byte $04, $E2
    .byte $04, $D2
    .byte $05, $B2
    .byte $03, $92
    .byte $04, $02
    .byte $05, $12
    .byte $03, $32
    .byte $05, $52
    .byte $04, $62
    .byte $50, $72
    .byte $FF
    
    .byte $02, $FA
    .byte $04, $EA
    .byte $04, $DA
    .byte $05, $BA
    .byte $03, $9A
    .byte $04, $0A
    .byte $05, $1A
    .byte $03, $3A
    .byte $05, $5A
    .byte $04, $6A
    .byte $50, $7A
    .byte $FF



    .byte $04, $B3
    .byte $05, $A3
    .byte $06, $93
    .byte $07, $03
    .byte $06, $13
    .byte $05, $23
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


CommonEnemyJump_00_01_02:
    lda $7C
    cmp #$01
    beq @resting
    cmp #$03
    beq @explode
        lda $00
        jmp CommonJump_00
    @resting:
        lda $01
        jmp CommonJump_01
    @explode:
        jmp CommonJump_02



; enemy ai routines
.include "sideB/enemies/sidehopper.asm"

.include "sideB/enemies/ripper.asm"

.include "sideB/enemies/waver.asm"

    .byte $A5, $7C, $C9, $01, $F0, $44, $C9, $03, $F0, $45, $BD, $06, $04, $C9
    .byte $0F, $90, $34, $C9, $11, $B0, $07, $A9, $3A, $9D, $6D, $B4, $D0, $29, $DE, $6D
    .byte $B4, $D0, $24, $A9, $00, $9D, $60, $B4, $A0, $0C, $A9, $0A, $99, $A0, $00, $BD
    .byte $00, $04, $99, $A1, $00, $BD, $01, $04, $99, $A2, $00, $BD, $67, $B4, $99, $A3
    .byte $00, $88, $88, $88, $88, $10, $E3, $A9, $02, $4C, $00, $6C, $A9, $08, $4C, $03
    .byte $6C, $4C, $06, $6C, $20, $09, $6C, $29, $03, $F0, $34, $A5, $7C, $C9, $01, $F0
    .byte $EB, $C9, $03, $F0, $EC, $BD, $60, $B4, $C9, $03, $F0, $23, $BD, $0A, $04, $29
    .byte $03, $C9, $01, $D0, $11, $BC, $00, $04, $C0, $E4, $D0, $0A, $20, $B5, $BA, $A9
    .byte $03, $9D, $0A, $04, $D0, $06, $20, $DA, $BA, $20, $A0, $BA, $20, $BE, $BA, $A9
    .byte $03, $20, $0C, $6C, $4C, $06, $6C, $BD, $05, $04, $4A, $BD, $0A, $04, $29, $03
    .byte $2A, $A8, $B9, $98, $BA, $4C, $0F, $6C, $35, $35, $3E, $38, $3B, $3B, $38, $3E
    .byte $A6, $45, $B0, $19, $A5, $00, $D0, $0D, $BC, $0A, $04, $88, $98, $29, $03, $9D
    .byte $0A, $04, $4C, $87, $BA, $BD, $05, $04, $49, $01, $9D, $05, $04, $60, $20, $D2
    .byte $BA, $20, $DA, $BA, $A6, $45, $90, $09, $20, $D2, $BA, $9D, $0A, $04, $20, $87
    .byte $BA, $60, $BC, $0A, $04, $C8, $98, $29, $03, $60, $BC, $05, $04, $84, $00, $46
    .byte $00, $2A, $0A, $A8, $B9, $49, $6C, $48, $B9, $48, $6C, $48, $60, $A5, $7C, $C9
    .byte $01, $F0, $32, $C9, $03, $F0, $2B, $A9, $80, $9D, $6A, $B4, $BD, $02, $04, $30
    .byte $1C, $BD, $05, $04, $29, $10, $F0, $15, $BD, $00, $04, $38, $ED, $0D, $03, $10
    .byte $03, $20, $BE, $B5, $C9, $10, $B0, $05, $A9, $00, $9D, $6A, $B4, $A9, $03, $4C
    .byte $00, $6C, $4C, $06, $6C, $A9, $08, $4C, $03, $6C, $BD, $60, $B4, $C9, $02, $D0
    .byte $38, $BD, $03, $04, $D0, $33, $BD, $6A, $B4, $D0, $12, $AD, $0D, $03, $38, $FD
    .byte $00, $04, $C9, $40, $B0, $23, $A9, $7F, $9D, $6A, $B4, $D0, $1C, $BD, $02, $04
    .byte $30, $17, $A9, $00, $9D, $02, $04, $9D, $06, $04, $9D, $6A, $B4, $BD, $05, $04
    .byte $29, $01, $A8, $B9, $98, $BB, $9D, $03, $04, $BD, $05, $04, $0A, $30, $1E, $BD
    .byte $60, $B4, $C9, $02, $D0, $17, $20, $36, $6C, $48, $20, $39, $6C, $85, $05, $68
    .byte $85, $04, $20, $A0, $BC, $20, $27, $6C, $90, $08, $20, $8E, $BC, $A9, $03, $4C
    .byte $03, $6C, $A9, $00, $9D, $60, $B4, $60, $04, $FC, $BD, $60, $B4, $C9, $03, $90
    .byte $19, $F0, $04, $C9, $05, $D0, $1C, $A9, $00, $8D, $70, $B4, $8D, $80, $B4, $8D
    .byte $90, $B4, $8D, $A0, $B4, $8D, $B0, $B4, $F0, $09, $20, $15, $BC, $20, $C4, $BC
    .byte $20, $FD, $BC, $A9, $0A, $85, $00, $4C, $C4, $B9, $BD, $05, $04, $29, $02, $F0
    .byte $07, $BD, $60, $B4, $C9, $03, $D0, $07, $A9, $00, $9D, $60, $B4, $F0, $2B, $BD
    .byte $05, $04, $0A, $30, $25, $BD, $60, $B4, $C9, $02, $D0, $1E, $20, $2D, $6C, $A6
    .byte $45, $A5, $00, $9D, $02, $04, $20, $30, $6C, $A6, $45, $A5, $00, $9D, $03, $04
    .byte $20, $33, $6C, $B0, $05, $A9, $03, $9D, $60, $B4, $A9, $01, $20, $0C, $6C, $4C
    .byte $06, $6C, $4C, $CA, $BB, $A2, $50, $20, $22, $BC, $8A, $38, $E9, $10, $AA, $D0
    .byte $F6, $60, $BC, $60, $B4, $F0, $26, $BD, $6E, $B4, $C9, $0A, $F0, $04, $C9, $09
    .byte $D0, $6D, $BD, $05, $04, $29, $02, $F0, $14, $88, $F0, $1C, $C0, $02, $F0, $0D
    .byte $C0, $03, $D0, $5B, $BD, $0C, $04, $C9, $01, $D0, $54, $F0, $0B, $A9, $00, $9D
    .byte $60, $B4, $9D, $0F, $04, $20, $2A, $6C, $AD, $05, $04, $9D, $05, $04, $4A, $08
    .byte $8A, $4A, $4A, $4A, $4A, $A8, $B9, $AF, $BC, $85, $04, $B9, $BE, $BC, $9D, $6E
    .byte $B4, $98, $28, $2A, $A8, $B9, $B3, $BC, $85, $05, $A2, $00, $20, $A0, $BC, $20
    .byte $27, $6C, $A6, $45, $90, $19, $BD, $60, $B4, $D0, $03, $FE, $60, $B4, $A5, $08
    .byte $9D, $00, $04, $A5, $09, $9D, $01, $04, $A5, $0B, $29, $01, $9D, $67, $B4, $60
    .byte $BD, $00, $04, $85, $08, $BD, $01, $04, $85, $09, $BD, $67, $B4, $85, $0B, $60
    .byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
    .byte $09, $09, $0A, $0A, $A4, $79, $D0, $02, $A0, $80, $A5, $27, $29, $02, $D0, $2C
    .byte $88, $84, $79, $98, $0A, $30, $25, $29, $0F, $C9, $0A, $D0, $1F, $A9, $01, $A2
    .byte $10, $DD, $60, $B4, $F0, $11, $A2, $20, $DD, $60, $B4, $F0, $0A, $A2, $30, $DD
    .byte $60, $B4, $F0, $03, $E6, $79, $60, $A9, $08, $9D, $09, $04, $60, $A4, $7A, $D0
    .byte $02, $A0, $60, $A5, $27, $29, $02, $D0, $23, $88, $84, $7A, $98, $0A, $30, $1C
    .byte $29, $0F, $D0, $18, $A9, $01, $A2, $40, $DD, $60, $B4, $F0, $0A, $A2, $50, $DD
    .byte $60, $B4, $F0, $03, $E6, $7A, $60, $A9, $08, $9D, $09, $04, $60



AreaRoutineStub:
    rts
    
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
    
    .byte $32
    .byte $4E, $4E
    .byte $4E, $4E
    .byte $4E, $4E



.include "sideB/brinstar/enemy_sprite_data.asm"


.include "sideB/brinstar/palettes.asm"


.include "sideB/brinstar/room_ptrs.asm"


.include "sideB/brinstar/structure_ptrs.asm"


.include "sideB/brinstar/items.asm"


.include "sideB/brinstar/rooms.asm"


.include "sideB/brinstar/structures.asm"


.include "sideB/brinstar/metatiles.asm"



    .byte $FF, $FF, $FF, $FF
    .byte $95, $B7, $14, $C7, $96, $D6, $44, $2B, $92, $39, $0F, $72, $41, $A7, $00, $1B

