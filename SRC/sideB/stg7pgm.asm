; side B file $19 - stg7pgm  (prgram $B560-$CBDF)
; Ridley Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $14
    .ascstr "STG7PGM", $00
FDSFileMacroPart2 $B560, $00



.redef AREA = "STG7PGM"

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

    .byte $4C, $40, $BB

    .byte $49, $FF
    .byte $18, $69, $01, $60

    .byte $12

    .byte $80

    .word $0240

    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

    .byte $19

    .byte $18

    .byte $6E

    .byte $06

    .byte $00

    .byte $03

    .byte $58

    .byte $44, $4A

    .byte $48, $4A

    .byte $4A, $36

    .byte $25

; Enemy AI jump table
ChooseEnemyAIRoutine: ;($B5DD)
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word $B8CF
        .word $B904
        .word $B83F
        .word $B85A
        .word $B822
        .word $B822
        .word $B95F
        .word $B85F
        .word $B822
        .word $BA0B
        .word $BA42
        .word $B822
        .word $BAFB
        .word $B822
        .word $BB0E
        .word $B822


EnemyDeathAnimIndex: ;($B603)
    .byte $23, $23
    .byte $23, $23
    .byte $3A, $3A
    .byte $3C, $3C
    .byte $00, $00
    .byte $00, $00
    .byte $56, $56
    .byte $65, $63
    .byte $00, $00
    .byte $11, $11
    .byte $13, $18
    .byte $28, $28
    .byte $32, $32
    .byte $34, $34
    .byte $00, $00
    .byte $00, $00

EnemyHealthTbl: ;($B623)
    .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

EnemyRestingAnimIndex: ;($B633)
    .byte $1D, $1D, $1D, $1D, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $69, $67
    .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

EnemyActiveAnimIndex: ;($B653)
    .byte $20, $20, $20, $20, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $60, $5D
    .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

    .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

    .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

EnemyForceSpeedTowardsSamusDelayTbl: ;($B693)
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

EnemyDistanceToSamusThreshold: ;($B6A3)
    .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

EnemyInitDelayTbl: ;($B6B3)
    .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

EnemyMovementChoiceOffset: ;($B6C3)
    .byte EnemyMovementChoice_HoltzIdle_{AREA} - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_HoltzAttacking_{AREA} - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_DessgeegaFloor_{AREA} - EnemyMovementChoices ; 02 - dessgeegas
    .byte EnemyMovementChoice_DessgeegaCeiling_{AREA} - EnemyMovementChoices ; 03 - ceiling dessgeegas
    .byte $00 ; 04 - disappears
    .byte $00 ; 05 - same as 4
    .byte EnemyMovementChoice_Zebbo_{AREA} - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Zebbo_{AREA} - EnemyMovementChoices ; 07 - zebbo
    .byte $00 ; 08 - same as 4
    .byte EnemyMovementChoice_Ridley_{AREA} - EnemyMovementChoices ; 09 - ridley
    .byte EnemyMovementChoice_RidleyFireball_{AREA} - EnemyMovementChoices ; 0A - ridley fireball
    .byte EnemyMovementChoice06_{AREA} - EnemyMovementChoices ; 0B - same as 4
    .byte EnemyMovementChoice_Multiviola_{AREA} - EnemyMovementChoices ; 0C - bouncy orbs
    .byte EnemyMovementChoice08_{AREA} - EnemyMovementChoices ; 0D - same as 4
    .byte EnemyMovementChoice_HoltzIdle_{AREA} - EnemyMovementChoices ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

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
    .byte $80, $80, $00, $00, $7F, $7F, $81, $81, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable: ;($B737)
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
EnSpeedYTable: ;($B74B)
    .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9, $FD, $00, $00, $00
EnSpeedXTable: ;($B75F)
    .byte $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01, $01, $00, $00, $00, $03, $00, $00, $00

    .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte $34, $34
    .byte $44, $4A
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
EnemyMovementChoice_DessgeegaFloor_{AREA}:
    EnemyMovementChoiceEntry $04, $05
EnemyMovementChoice_DessgeegaCeiling_{AREA}:
    EnemyMovementChoiceEntry $06, $07
EnemyMovementChoice02_{AREA}: ; not assigned to any enemy
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Zebbo_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Ridley_{AREA}:
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice_RidleyFireball_{AREA}:
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice06_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola_{AREA}:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice08_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_HoltzIdle_{AREA}:
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_HoltzAttacking_{AREA}:
    EnemyMovementChoiceEntry $01


EnemyMovement00_R_{AREA}:
EnemyMovement00_L_{AREA}:
EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
    ; nothing

; unused (ripper)
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

; unused (dragon)
EnemyMovement11_R_{AREA}:
EnemyMovement11_L_{AREA}:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementDragon



EnProjectileMovement0_{AREA}:
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
        ; enemy explode
        jmp CommonJump_02



; enemy ai routines
    .byte $A9
    .byte $42, $85, $80, $85, $81, $BD, $60, $B4, $C9, $03, $F0, $03, $20, $1B, $6C, $A9
    .byte $06, $85, $00, $A9, $08, $85, $01, $4C, $28, $B8, $A9, $48, $4C, $41, $B8, $BD
    .byte $60, $B4, $C9, $02, $D0, $38, $BD, $03, $04, $D0, $33, $BD, $6A, $B4, $D0, $12
    .byte $AD, $0D, $03, $38, $FD, $00, $04, $C9, $40, $B0, $23, $A9, $7F, $9D, $6A, $B4
    .byte $D0, $1C, $BD, $02, $04, $30, $17, $A9, $00, $9D, $02, $04, $9D, $06, $04, $9D
    .byte $6A, $B4, $BD, $05, $04, $29, $01, $A8, $B9, $CD, $B8, $9D, $03, $04, $BD, $05
    .byte $04, $0A, $30, $1E, $BD, $60, $B4, $C9, $02, $D0, $17, $20, $36, $6C, $48, $20
    .byte $39, $6C, $85, $05, $68, $85, $04, $20, $D9, $BA, $20, $27, $6C, $90, $08, $20
    .byte $E9, $BA, $A9, $03, $4C, $03, $6C, $A9, $00, $9D, $60, $B4, $60, $08, $F8, $A9
    .byte $03, $85, $00, $A9, $08, $85, $01, $BD, $60, $B4, $C9, $01, $D0, $0C, $BD, $05
    .byte $04, $29, $10, $F0, $05, $A9, $01, $20, $50, $B9, $20, $F0, $B8, $4C, $28, $B8
    .byte $BD, $60, $B4, $C9, $02, $D0, $0C, $A9, $20, $BC, $02, $04, $10, $02, $A9, $1D
    .byte $9D, $65, $B4, $60, $A5, $7C, $C9, $01, $F0, $10, $C9, $03, $F0, $3F, $BD, $60
    .byte $B4, $C9, $01, $D0, $0A, $A9, $00, $20, $50, $B9, $A9, $08, $4C, $03, $6C, $A9
    .byte $80, $9D, $6A, $B4, $BD, $02, $04, $30, $1C, $BD, $05, $04, $29, $10, $F0, $15
    .byte $BD, $00, $04, $38, $ED, $0D, $03, $10, $03, $20, $BE, $B5, $C9, $10, $B0, $05
    .byte $A9, $00, $9D, $6A, $B4, $20, $F0, $B8, $A9, $03, $4C, $00, $6C, $4C, $06, $6C
    .byte $9D, $6E, $B4, $BD, $0B, $04, $48, $20, $2A, $6C, $68, $9D, $0B, $04, $60, $20
    .byte $09, $6C, $29, $03, $F0, $34, $A5, $7C, $C9, $01, $F0, $36, $C9, $03, $F0, $2F
    .byte $BD, $60, $B4, $C9, $03, $F0, $23, $BD, $0A, $04, $29, $03, $C9, $01, $D0, $11
    .byte $BC, $00, $04, $C0, $EB, $D0, $0A, $20, $D3, $B9, $A9, $03, $9D, $0A, $04, $D0
    .byte $06, $20, $F8, $B9, $20, $BE, $B9, $20, $DC, $B9, $A9, $03, $20, $0C, $6C, $4C
    .byte $06, $6C, $4C, $03, $6C, $BD, $05, $04, $4A, $BD, $0A, $04, $29, $03, $2A, $A8
    .byte $B9, $B6, $B9, $4C, $0F, $6C, $4A, $4A, $53, $4D, $50, $50, $4D, $53, $A6, $45
    .byte $B0, $19, $A5, $00, $D0, $0D, $BC, $0A, $04, $88, $98, $29, $03, $9D, $0A, $04
    .byte $4C, $A5, $B9, $BD, $05, $04, $49, $01, $9D, $05, $04, $60, $20, $F0, $B9, $20
    .byte $F8, $B9, $A6, $45, $90, $09, $20, $F0, $B9, $9D, $0A, $04, $20, $A5, $B9, $60
    .byte $BC, $0A, $04, $C8, $98, $29, $03, $60, $BC, $05, $04, $84, $00, $46, $00, $2A
    .byte $0A, $A8, $B9, $49, $6C, $48, $B9, $48, $6C, $48, $60, $BD, $60, $B4, $C9, $03
    .byte $90, $19, $F0, $04, $C9, $05, $D0, $21, $A9, $00, $8D, $70, $B4, $8D, $80, $B4
    .byte $8D, $90, $B4, $8D, $A0, $B4, $8D, $B0, $B4, $F0, $0E, $A9, $0B, $85, $80, $A9
    .byte $0E, $85, $81, $20, $1B, $6C, $20, $71, $BA, $A9, $03, $85, $00, $85, $01, $4C
    .byte $28, $B8, $BD, $05, $04, $48, $A9, $02, $85, $00, $85, $01, $20, $28, $B8, $68
    .byte $A6, $45, $5D, $05, $04, $4A, $B0, $13, $BD, $05, $04, $4A, $B0, $12, $BD, $01
    .byte $04, $38, $ED, $0E, $03, $90, $09, $C9, $20, $90, $05, $A9, $00, $9D, $60, $B4
    .byte $60, $A4, $7B, $D0, $02, $A0, $60, $A5, $27, $29, $02, $D0, $24, $88, $84, $7B
    .byte $98, $0A, $30, $1D, $29, $0F, $C9, $0A, $D0, $17, $A2, $50, $BD, $60, $B4, $F0
    .byte $11, $BD, $05, $04, $29, $02, $F0, $0A, $8A, $38, $E9, $10, $AA, $D0, $ED, $E6
    .byte $79, $60, $8A, $A8, $A2, $00, $20, $D9, $BA, $98, $AA, $AD, $05, $04, $9D, $05
    .byte $04, $29, $01, $A8, $B9, $D7, $BA, $85, $05, $A9, $F8, $85, $04, $20, $27, $6C
    .byte $90, $DF, $A9, $00, $9D, $0F, $04, $A9, $0A, $9D, $6E, $B4, $A9, $01, $9D, $60
    .byte $B4, $20, $E9, $BA, $4C, $2A, $6C, $08, $F8, $BD, $00, $04, $85, $08, $BD, $01
    .byte $04, $85, $09, $BD, $67, $B4, $85, $0B, $60, $A5, $0B, $29, $01, $9D, $67, $B4
    .byte $A5, $08, $9D, $00, $04, $A5, $09, $9D, $01, $04, $60, $BD, $60, $B4, $C9, $02
    .byte $D0, $03, $20, $1E, $6C, $A9, $02, $85, $00, $85, $01, $4C, $28, $B8, $A9, $00
    .byte $9D, $61, $B4, $9D, $62, $B4, $A9, $10, $9D, $05, $04, $8A, $4A, $4A, $4A, $4A
    .byte $65, $27, $29, $07, $D0, $1A, $5E, $05, $04, $A9, $03, $85, $82, $A5, $28, $4A
    .byte $3E, $05, $04, $29, $03, $F0, $09, $85, $83, $A9, $02, $85, $80, $4C, $21, $6C



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
    .byte $76, $77

TileBlastFrame0B_{AREA}:
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

TileBlastFrame0C_{AREA}:
TileBlastFrame0D_{AREA}:
TileBlastFrame0E_{AREA}:
TileBlastFrame0F_{AREA}:
TileBlastFrame10_{AREA}:
    ;nothing



.include "sideB/ridley/enemy_sprite_data.asm"


.include "sideB/ridley/palettes.asm"


.include "sideB/ridley/room_ptrs.asm"


.include "sideB/ridley/structure_ptrs.asm"


.include "sideB/ridley/items.asm"


.include "sideB/ridley/rooms.asm"


.include "sideB/ridley/structures.asm"


.include "sideB/ridley/metatiles.asm"



    .byte $11
    .byte $11, $11, $04, $11, $11, $11, $11, $FF, $08, $20, $22, $22, $22, $22, $22, $22
    .byte $22, $FF, $01, $1F, $FF, $01, $21, $01, $21, $01, $21, $FF, $08, $23, $23, $23
    .byte $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24, $24, $23, $08, $23
    .byte $23, $23, $23, $23, $23, $23, $23, $FF, $01, $23, $01, $23, $01, $23, $01, $23
    .byte $FF, $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24, $23
    .byte $04, $23, $23, $23, $23, $FF, $01, $25, $FF, $01, $26, $01, $26, $01, $26, $01



FDSFileMacroPart3

