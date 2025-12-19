; side B file $16 - stg4pgm  (prgram $B560-$CFDF)
; Norfair Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $11
    .ascstr "STG4PGM", $00
FDSFileMacroPart2 $B560, $00



.redef AREA = "STG4PGM"

PalPntrTbl: ;($B560)
    PtrTableEntryArea PalPntrTbl, Palette00
    PtrTableEntryArea PalPntrTbl, Palette01
    PtrTableEntryArea PalPntrTbl, Palette02
    PtrTableEntryArea PalPntrTbl, Palette03
    PtrTableEntryArea PalPntrTbl, Palette04
    PtrTableEntryArea PalPntrTbl, Palette05
    PtrTableEntryArea PalPntrTbl, Palette06
    PtrTableEntryArea PalPntrTbl, Palette07
    PtrTableEntryArea PalPntrTbl, Palette08
    PtrTableEntryArea PalPntrTbl, Palette09
    PtrTableEntryArea PalPntrTbl, Palette0A
    PtrTableEntryArea PalPntrTbl, Palette0B
    PtrTableEntryArea PalPntrTbl, Palette0C
    PtrTableEntryArea PalPntrTbl, Palette0D
    PtrTableEntryArea PalPntrTbl, Palette0E
    PtrTableEntryArea PalPntrTbl, Palette0F
    PtrTableEntryArea PalPntrTbl, Palette10
    PtrTableEntryArea PalPntrTbl, Palette11
    PtrTableEntryArea PalPntrTbl, Palette12
    PtrTableEntryArea PalPntrTbl, Palette13
    PtrTableEntryArea PalPntrTbl, Palette14
    PtrTableEntryArea PalPntrTbl, Palette15
    PtrTableEntryArea PalPntrTbl, Palette16
    PtrTableEntryArea PalPntrTbl, Palette17

SpecItmsTblPtr: ;($B590)
    .word SpecItmsTbl_{AREA}

AreaPointers: ;($B592)
    .word RoomPtrTable_{AREA}
    .word StructPtrTable_{AREA}
    .word MetatileDefs_{AREA}
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


EnemyDeathAnimIndex: ;($B603)
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

EnemyHealthTbl: ;($B623)
    .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

EnemyRestingAnimIndex: ;($B633)
    .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86
    .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00

EnemyActiveAnimIndex: ;($B653)
    .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C
    .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00

    .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

    .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

EnemyForceSpeedTowardsSamusDelayTbl: ;($B693)
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

EnemyDistanceToSamusThreshold: ;($B6A3)
    .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00

EnemyInitDelayTbl: ;($B6B3)
    .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

EnemyMovementChoiceOffset: ;($B6C3)
    .byte EnemyMovementChoice_GerutaIdle_{AREA} - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_GerutaAttacking_{AREA} - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_RipperII_{AREA} - EnemyMovementChoices ; 02 - ripper II
    .byte $00 ; 03 - disappears
    .byte $00 ; 04 - same as 3
    .byte $00 ; 05 - same as 3
    .byte EnemyMovementChoice_Gamet_{AREA} - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Gamet_{AREA} - EnemyMovementChoices ; 07 - gamet
    .byte $00 ; 08 - same as 3
    .byte EnemyMovementChoice02_{AREA} - EnemyMovementChoices ; 09 - same as 3
    .byte EnemyMovementChoice03_{AREA} - EnemyMovementChoices ; 0A - same as 3
    .byte EnemyMovementChoice_Squeept_{AREA} - EnemyMovementChoices ; 0B - lava jumper
    .byte EnemyMovementChoice_Multiviola_{AREA} - EnemyMovementChoices ; 0C - bouncy orb
    .byte EnemyMovementChoice_Dragon_{AREA} - EnemyMovementChoices ; 0D - dragon
    .byte EnemyMovementChoice_GerutaIdle_{AREA} - EnemyMovementChoices ; 0E - rock launcher thing (enemy doesn't move)
    .byte $00 ; 0F - same as 3

EnemyMovementPtrs: ;($B6D3)
    .word EnemyMovement00_R_{AREA}, EnemyMovement00_L_{AREA}
    .word EnemyMovement01_R_{AREA}, EnemyMovement01_L_{AREA}
    .word EnemyMovement02_R_{AREA}, EnemyMovement02_L_{AREA}
    .word EnemyMovement03_R_{AREA}, EnemyMovement03_L_{AREA}
    .word EnemyMovement04_R_{AREA}, EnemyMovement04_L_{AREA}
    .word EnemyMovement05_R_{AREA}, EnemyMovement05_L_{AREA}
    .word EnemyMovement06_R_{AREA}, EnemyMovement06_L_{AREA}
    .word EnemyMovement07_R_{AREA}, EnemyMovement07_L_{AREA}
    .word EnemyMovement08_R_{AREA}, EnemyMovement08_L_{AREA}
    .word EnemyMovement09_R_{AREA}, EnemyMovement09_L_{AREA}
    .word EnemyMovement0A_R_{AREA}, EnemyMovement0A_L_{AREA}
    .word EnemyMovement0B_R_{AREA}, EnemyMovement0B_L_{AREA}
    .word EnemyMovement0C_R_{AREA}, EnemyMovement0C_L_{AREA}
    .word EnemyMovement0D_R_{AREA}, EnemyMovement0D_L_{AREA}
    .word EnemyMovement0E_R_{AREA}, EnemyMovement0E_L_{AREA}
    .word EnemyMovement0F_R_{AREA}, EnemyMovement0F_L_{AREA}
    .word EnemyMovement10_R_{AREA}, EnemyMovement10_L_{AREA}
    .word EnemyMovement11_R_{AREA}, EnemyMovement11_L_{AREA}
    .word $0000, $0000
    .word $0000, $0000

EnAccelYTable: ;($B723)
    .byte $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable: ;($B737)
    .byte $00, $00, $00, $00, $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable: ;($B74B)
    .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB, $FD, $00, $00, $00
EnSpeedXTable: ;($B75F)
    .byte $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01, $01, $00, $01, $01, $03, $00, $00, $00

    .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte $4D, $4D
    .byte $53, $57
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetX:
    .byte $08, $F8
    .byte $00, $00
    .byte $00, $00
    .byte $08, $F8
EnProjectilePosOffsetY:
    .byte $00
    .byte $00
    .byte $00
    .byte $F8

EnemyFireballMovementPtrTable: ;($B79F)
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

TileBlastFramePtrTable: ;($B7A7)
    .word TileBlastFrame00_{AREA}
    .word TileBlastFrame01_{AREA}
    .word TileBlastFrame02_{AREA}
    .word TileBlastFrame03_{AREA}
    .word TileBlastFrame04_{AREA}
    .word TileBlastFrame05_{AREA}
    .word TileBlastFrame06_{AREA}
    .word TileBlastFrame07_{AREA}
    .word TileBlastFrame08_{AREA}
    .word TileBlastFrame09_{AREA}
    .word TileBlastFrame0A_{AREA}
    .word TileBlastFrame0B_{AREA}
    .word TileBlastFrame0C_{AREA}
    .word TileBlastFrame0D_{AREA}
    .word TileBlastFrame0E_{AREA}
    .word TileBlastFrame0F_{AREA}
    .word TileBlastFrame10_{AREA}

EnemyMovementChoices:
EnemyMovementChoice_RipperII_{AREA}:
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Gamet_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice02_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice03_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice_Squeept_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola_{AREA}:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice_Dragon_{AREA}:
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_GerutaIdle_{AREA}: ; enemy doesn't move
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_GerutaAttacking_{AREA}:
    EnemyMovementChoiceEntry $01


EnemyMovement00_R_{AREA}:
EnemyMovement00_L_{AREA}:
EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
    ; nothing

; ripper II
EnemyMovement02_R_{AREA}:
    SignMagSpeed $01,  3,  0
    EnemyMovementInstr_Restart

EnemyMovement02_L_{AREA}:
    SignMagSpeed $01, -3,  0
    EnemyMovementInstr_Restart

EnemyMovement03_R_{AREA}:
EnemyMovement03_L_{AREA}:
EnemyMovement04_R_{AREA}:
EnemyMovement04_L_{AREA}:
EnemyMovement05_R_{AREA}:
EnemyMovement05_L_{AREA}:
EnemyMovement06_R_{AREA}:
EnemyMovement06_L_{AREA}:
EnemyMovement07_R_{AREA}:
EnemyMovement07_L_{AREA}:
EnemyMovement08_R_{AREA}:
EnemyMovement08_L_{AREA}:
EnemyMovement09_R_{AREA}:
EnemyMovement09_L_{AREA}:
EnemyMovement0A_R_{AREA}:
EnemyMovement0A_L_{AREA}:
EnemyMovement0B_R_{AREA}:
EnemyMovement0B_L_{AREA}:
EnemyMovement0C_R_{AREA}:
EnemyMovement0C_L_{AREA}:
EnemyMovement0D_R_{AREA}:
EnemyMovement0D_L_{AREA}:
EnemyMovement0E_R_{AREA}:
EnemyMovement0E_L_{AREA}:
EnemyMovement0F_R_{AREA}:
EnemyMovement0F_L_{AREA}:
EnemyMovement10_R_{AREA}:
EnemyMovement10_L_{AREA}:
    ; nothing

; dragon
EnemyMovement11_R_{AREA}:
EnemyMovement11_L_{AREA}:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementDragon



EnProjectileMovement0_{AREA}:
    SignMagSpeed $0A,  3, -5
    SignMagSpeed $07,  3, -3
    SignMagSpeed $07,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $07,  3,  1
    SignMagSpeed $07,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

EnProjectileMovement1_{AREA}:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement2_{AREA}:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement3_{AREA}:
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF



RemoveEnemy__{AREA}:
    lda #$00
    sta EnsExtra.0.status,x
    rts

CommonEnemyJump_00_01_02_{AREA}:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq @resting
    cmp #enemyStatus_Explode
    beq @explode
        ; enemy default
        lda $00
        jmp CommonJump_00
    @resting:
        ; enemy resting
        lda $01
        jmp CommonJump_01
    @explode:
    L984D:
        ; enemy explode
        jmp CommonJump_02



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

TileBlastFrame00_{AREA}:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01_{AREA}:
    .byte $22
    .byte $80, $81
    .byte $82, $83

TileBlastFrame02_{AREA}:
    .byte $22
    .byte $84, $85
    .byte $86, $87

TileBlastFrame03_{AREA}:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

TileBlastFrame04_{AREA}:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

TileBlastFrame05_{AREA}:
    .byte $22
    .byte $94, $95
    .byte $96, $97

TileBlastFrame06_{AREA}:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

TileBlastFrame07_{AREA}:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

TileBlastFrame08_{AREA}:
    .byte $22
    .byte $90, $91
    .byte $92, $93

TileBlastFrame09_{AREA}:
    .byte $22
    .byte $70, $71
    .byte $72, $73

TileBlastFrame0A_{AREA}:
    .byte $22
    .byte $74, $75
    .byte $75, $74

TileBlastFrame0B_{AREA}:
    .byte $22
    .byte $76, $76
    .byte $76, $76

TileBlastFrame0C_{AREA}:
TileBlastFrame0D_{AREA}:
TileBlastFrame0E_{AREA}:
TileBlastFrame0F_{AREA}:
TileBlastFrame10_{AREA}:
    ;nothing



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

