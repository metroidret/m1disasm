; side B file $18 - stg6pgm  (prgram $B560-$CCDF)
; Kraid Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_12
    .ascstr "STG6PGM", $00
FDSFileMacroPart2 $B560, FDSFileType_PRGRAM



.redef AREA = "STG6PGM"

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

    .byte $4C, $41, $BC

    .byte $49, $FF
    .byte $18, $69, $01, $60

    .byte $1D

    .byte $10

    .word $0200

    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

    .byte $07

    .byte $14

    .byte $6E

    .byte $06

    .byte $00

    .byte $03

    .byte $43

    .byte $00, $00

    .byte $00, $00

    .byte $00, $00

    .byte $64

; Enemy AI jump table
ChooseEnemyAIRoutine: ;($B5DD)
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word $B914
        .word $B92F
        .word $B5C3
        .word $B934
        .word $B941
        .word $B993
        .word $B5C3
        .word $BA3C
        .word $BAAC
        .word $BADC
        .word $BB24
        .word $B5C3
        .word $B5C3
        .word $B5C3
        .word $B5C3
        .word $B5C3


EnemyDeathAnimIndex: ;($B603)
    .byte $27, $27
    .byte $29, $29
    .byte $2D, $2B
    .byte $31, $2F
    .byte $33, $33
    .byte $41, $41
    .byte $48, $48
    .byte $50, $4E
    .byte $6D, $6F
    .byte $00, $00
    .byte $00, $00
    .byte $64, $64
    .byte $64, $64
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

EnemyHealthTbl: ;($B623)
    .byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

EnemyRestingAnimIndex: ;($B633)
    .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $54, $52
    .byte $67, $6A, $56, $58, $5D, $62, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

EnemyActiveAnimIndex: ;($B653)
    .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $4B, $48
    .byte $67, $6A, $56, $58, $5A, $5F, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

    .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

    .byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

EnemyForceSpeedTowardsSamusDelayTbl: ;($B693)
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

EnemyDistanceToSamusThreshold: ;($B6A3)
    .byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl: ;($B6B3)
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

EnemyMovementChoiceOffset: ;($B6C3)
    .byte EnemyMovementChoice_SidehopperFloor_{AREA} - EnemyMovementChoices ; 00 - sidehopper
    .byte EnemyMovementChoice_SidehopperCeiling_{AREA} - EnemyMovementChoices ; 01 - ceiling sidehopper
    .byte $00 ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnemyMovementChoice_Ripper_{AREA} - EnemyMovementChoices ; 03 - ripper
    .byte EnemyMovementChoice_Skree_{AREA} - EnemyMovementChoices ; 04 - skree
    .byte EnemyMovementChoice_Zeela_{AREA} - EnemyMovementChoices ; 05 - crawler (enemy moves manually)
    .byte $00 ; 06 - same as 2
    .byte EnemyMovementChoice_Geega_{AREA} - EnemyMovementChoices ; 07 - geega
    .byte EnemyMovementChoice_Kraid_{AREA} - EnemyMovementChoices ; 08 - kraid
    .byte EnemyMovementChoice_KraidLint_{AREA} - EnemyMovementChoices ; 09 - kraid lint
    .byte EnemyMovementChoice_KraidNail_{AREA} - EnemyMovementChoices ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

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
    .byte $7F, $70, $70, $90, $90, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable: ;($B737)
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable: ;($B74B)
    .byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable: ;($B75F)
    .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

    .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $5F, $62
    .byte $64, $64
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetX:
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetY:
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

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
EnemyMovementChoice_SidehopperFloor_{AREA}:
    EnemyMovementChoiceEntry $01, $02
EnemyMovementChoice_SidehopperCeiling_{AREA}:
    EnemyMovementChoiceEntry $03, $04
EnemyMovementChoice_Ripper_{AREA}:
    EnemyMovementChoiceEntry $06
EnemyMovementChoice_Skree_{AREA}:
    EnemyMovementChoiceEntry $07
EnemyMovementChoice_Geega_{AREA}:
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Zeela_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_Kraid_{AREA}:
    EnemyMovementChoiceEntry $0C, $0D
EnemyMovementChoice_KraidLint_{AREA}:
    EnemyMovementChoiceEntry $0E
EnemyMovementChoice_KraidNail_{AREA}:
    EnemyMovementChoiceEntry $0F, $10, $11, $0F


; unused (???)
EnemyMovement00_R_{AREA}:
    SignMagSpeed $20,  2,  2
    EnemyMovementInstr_FE

EnemyMovement00_L_{AREA}:
    SignMagSpeed $20, -2,  2
    EnemyMovementInstr_FE

EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
EnemyMovement02_R_{AREA}:
EnemyMovement02_L_{AREA}:
EnemyMovement03_R_{AREA}:
EnemyMovement03_L_{AREA}:
EnemyMovement04_R_{AREA}:
EnemyMovement04_L_{AREA}:
EnemyMovement05_R_{AREA}:
EnemyMovement05_L_{AREA}:
    ; nothing

; ripper
EnemyMovement06_R_{AREA}:
    SignMagSpeed $01,  1,  0
    EnemyMovementInstr_Restart

EnemyMovement06_L_{AREA}:
    SignMagSpeed $01, -1,  0
    EnemyMovementInstr_Restart

; skree
EnemyMovement07_R_{AREA}:
    SignMagSpeed $04,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  6
    SignMagSpeed $01,  2,  4
    SignMagSpeed $04,  2,  6
    EnemyMovementInstr_RepeatPreviousUntilFailure
    SignMagSpeed $01,  0,  0
    SignMagSpeed $64,  0,  0
    EnemyMovementInstr_StopMovement

EnemyMovement07_L_{AREA}:
    SignMagSpeed $04, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  6
    SignMagSpeed $01, -2,  4
    SignMagSpeed $04, -2,  6
    EnemyMovementInstr_RepeatPreviousUntilFailure
    SignMagSpeed $01,  0,  0
    SignMagSpeed $64,  0,  0
    EnemyMovementInstr_StopMovement

EnemyMovement08_R_{AREA}:
EnemyMovement08_L_{AREA}:
EnemyMovement09_R_{AREA}:
EnemyMovement09_L_{AREA}:
EnemyMovement0A_R_{AREA}:
EnemyMovement0A_L_{AREA}:
EnemyMovement0B_R_{AREA}:
EnemyMovement0B_L_{AREA}:
    ; nothing

; kraid
EnemyMovement0C_R_{AREA}:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0C_L_{AREA}:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_R_{AREA}:
    SignMagSpeed $32,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_L_{AREA}:
    SignMagSpeed $32, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32,  1,  1
    EnemyMovementInstr_FE

; kraid lint
EnemyMovement0E_R_{AREA}:
    SignMagSpeed $50,  4,  0
    EnemyMovementInstr_Restart

EnemyMovement0E_L_{AREA}:
    SignMagSpeed $50, -4,  0
    EnemyMovementInstr_Restart

; kraid nail
EnemyMovement0F_R_{AREA}:
    SignMagSpeed $02,  3, -7
    SignMagSpeed $04,  3, -6
    SignMagSpeed $04,  3, -5
    SignMagSpeed $05,  3, -3
    SignMagSpeed $03,  3, -1
    SignMagSpeed $04,  3,  0
    SignMagSpeed $05,  3,  1
    SignMagSpeed $03,  3,  3
    SignMagSpeed $05,  3,  5
    SignMagSpeed $04,  3,  6
    SignMagSpeed $50,  3,  7
    EnemyMovementInstr_Restart

EnemyMovement0F_L_{AREA}:
    SignMagSpeed $02, -3, -7
    SignMagSpeed $04, -3, -6
    SignMagSpeed $04, -3, -5
    SignMagSpeed $05, -3, -3
    SignMagSpeed $03, -3, -1
    SignMagSpeed $04, -3,  0
    SignMagSpeed $05, -3,  1
    SignMagSpeed $03, -3,  3
    SignMagSpeed $05, -3,  5
    SignMagSpeed $04, -3,  6
    SignMagSpeed $50, -3,  7
    EnemyMovementInstr_Restart

EnemyMovement10_R_{AREA}:
    SignMagSpeed $02,  4, -7
    SignMagSpeed $04,  4, -6
    SignMagSpeed $04,  4, -5
    SignMagSpeed $05,  4, -3
    SignMagSpeed $03,  4, -1
    SignMagSpeed $04,  4,  0
    SignMagSpeed $05,  4,  1
    SignMagSpeed $03,  4,  3
    SignMagSpeed $05,  4,  5
    SignMagSpeed $04,  4,  6
    SignMagSpeed $50,  4,  7
    EnemyMovementInstr_Restart

EnemyMovement10_L_{AREA}:
    SignMagSpeed $02, -4, -7
    SignMagSpeed $04, -4, -6
    SignMagSpeed $04, -4, -5
    SignMagSpeed $05, -4, -3
    SignMagSpeed $03, -4, -1
    SignMagSpeed $04, -4,  0
    SignMagSpeed $05, -4,  1
    SignMagSpeed $03, -4,  3
    SignMagSpeed $05, -4,  5
    SignMagSpeed $04, -4,  6
    SignMagSpeed $50, -4,  7
    EnemyMovementInstr_Restart

EnemyMovement11_R_{AREA}:
    SignMagSpeed $02,  2, -7
    SignMagSpeed $04,  2, -6
    SignMagSpeed $04,  2, -5
    SignMagSpeed $05,  2, -3
    SignMagSpeed $03,  2, -1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2,  1
    SignMagSpeed $03,  2,  3
    SignMagSpeed $05,  2,  5
    SignMagSpeed $04,  2,  6
    SignMagSpeed $50,  2,  7
    EnemyMovementInstr_Restart

EnemyMovement11_L_{AREA}:
    SignMagSpeed $02, -2, -7
    SignMagSpeed $04, -2, -6
    SignMagSpeed $04, -2, -5
    SignMagSpeed $05, -2, -3
    SignMagSpeed $03, -2, -1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2,  1
    SignMagSpeed $03, -2,  3
    SignMagSpeed $05, -2,  5
    SignMagSpeed $04, -2,  6
    SignMagSpeed $50, -2,  7
    EnemyMovementInstr_Restart



EnProjectileMovement0_{AREA}:
    SignMagSpeed $04,  3, -3
    SignMagSpeed $05,  3, -2
    SignMagSpeed $06,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $06,  3,  1
    SignMagSpeed $05,  3,  2
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
    .byte $A9, $09, $85, $80, $85, $81, $BD, $60, $B4, $C9, $03, $F0
    .byte $03, $20, $1B, $6C, $A9, $06, $85, $00, $A9, $08, $85, $01, $4C, $FD, $B8, $A9
    .byte $0F, $4C, $16, $B9, $BD, $60, $B4, $C9, $03, $F0, $03, $20, $1E, $6C, $4C, $24
    .byte $B9, $A5, $7C, $C9, $01, $F0, $44, $C9, $03, $F0, $45, $BD, $06, $04, $C9, $0F
    .byte $90, $34, $C9, $11, $B0, $07, $A9, $3A, $9D, $6D, $B4, $D0, $29, $DE, $6D, $B4
    .byte $D0, $24, $A9, $00, $9D, $60, $B4, $A0, $0C, $A9, $0A, $99, $A0, $00, $BD, $00
    .byte $04, $99, $A1, $00, $BD, $01, $04, $99, $A2, $00, $BD, $67, $B4, $99, $A3, $00
    .byte $88, $88, $88, $88, $10, $E3, $A9, $02, $4C, $00, $6C, $A9, $08, $4C, $03, $6C
    .byte $4C, $06, $6C, $20, $09, $6C, $29, $03, $F0, $34, $A5, $7C, $C9, $01, $F0, $EB
    .byte $C9, $03, $F0, $EC, $BD, $60, $B4, $C9, $03, $F0, $23, $BD, $0A, $04, $29, $03
    .byte $C9, $01, $D0, $11, $BC, $00, $04, $C0, $E4, $D0, $0A, $20, $04, $BA, $A9, $03
    .byte $9D, $0A, $04, $D0, $06, $20, $29, $BA, $20, $EF, $B9, $20, $0D, $BA, $A9, $03
    .byte $20, $0C, $6C, $4C, $06, $6C, $BD, $05, $04, $4A, $BD, $0A, $04, $29, $03, $2A
    .byte $A8, $B9, $E7, $B9, $4C, $0F, $6C, $35, $35, $3E, $38, $3B, $3B, $38, $3E, $A6
    .byte $45, $B0, $19, $A5, $00, $D0, $0D, $BC, $0A, $04, $88, $98, $29, $03, $9D, $0A
    .byte $04, $4C, $D6, $B9, $BD, $05, $04, $49, $01, $9D, $05, $04, $60, $20, $21, $BA
    .byte $20, $29, $BA, $A6, $45, $90, $09, $20, $21, $BA, $9D, $0A, $04, $20, $D6, $B9
    .byte $60, $BC, $0A, $04, $C8, $98, $29, $03, $60, $BC, $05, $04, $84, $00, $46, $00
    .byte $2A, $0A, $A8, $B9, $49, $6C, $48, $B9, $48, $6C, $48, $60, $BD, $60, $B4, $C9
    .byte $02, $D0, $38, $BD, $03, $04, $D0, $33, $BD, $6A, $B4, $D0, $12, $AD, $0D, $03
    .byte $38, $FD, $00, $04, $C9, $40, $B0, $23, $A9, $7F, $9D, $6A, $B4, $D0, $1C, $BD
    .byte $02, $04, $30, $17, $A9, $00, $9D, $02, $04, $9D, $06, $04, $9D, $6A, $B4, $BD
    .byte $05, $04, $29, $01, $A8, $B9, $AA, $BA, $9D, $03, $04, $BD, $05, $04, $0A, $30
    .byte $1E, $BD, $60, $B4, $C9, $02, $D0, $17, $20, $36, $6C, $48, $20, $39, $6C, $85
    .byte $05, $68, $85, $04, $20, $B4, $BB, $20, $27, $6C, $90, $08, $20, $A2, $BB, $A9
    .byte $03, $4C, $03, $6C, $A9, $00, $9D, $60, $B4, $60, $08, $F8, $BD, $60, $B4, $C9
    .byte $03, $90, $19, $F0, $04, $C9, $05, $D0, $1C, $A9, $00, $8D, $70, $B4, $8D, $80
    .byte $B4, $8D, $90, $B4, $8D, $A0, $B4, $8D, $B0, $B4, $F0, $09, $20, $27, $BB, $20
    .byte $D8, $BB, $20, $11, $BC, $A9, $0A, $85, $00, $4C, $28, $B9, $BD, $05, $04, $29
    .byte $02, $F0, $07, $BD, $60, $B4, $C9, $03, $D0, $07, $A9, $00, $9D, $60, $B4, $F0
    .byte $2B, $BD, $05, $04, $0A, $30, $25, $BD, $60, $B4, $C9, $02, $D0, $1E, $20, $2D
    .byte $6C, $A6, $45, $A5, $00, $9D, $02, $04, $20, $30, $6C, $A6, $45, $A5, $00, $9D
    .byte $03, $04, $20, $33, $6C, $B0, $05, $A9, $03, $9D, $60, $B4, $A9, $01, $20, $0C
    .byte $6C, $4C, $06, $6C, $4C, $DC, $BA, $A2, $50, $20, $34, $BB, $8A, $38, $E9, $10
    .byte $AA, $D0, $F6, $60, $BC, $60, $B4, $F0, $26, $BD, $6E, $B4, $C9, $0A, $F0, $04
    .byte $C9, $09, $D0, $6F, $BD, $05, $04, $29, $02, $F0, $14, $88, $F0, $1C, $C0, $02
    .byte $F0, $0D, $C0, $03, $D0, $5D, $BD, $0C, $04, $C9, $01, $D0, $56, $F0, $0B, $A9
    .byte $00, $9D, $60, $B4, $9D, $0F, $04, $20, $2A, $6C, $AD, $05, $04, $9D, $05, $04
    .byte $4A, $08, $8A, $4A, $4A, $4A, $4A, $A8, $B9, $C3, $BB, $85, $04, $B9, $D2, $BB
    .byte $9D, $6E, $B4, $98, $28, $2A, $A8, $B9, $C7, $BB, $85, $05, $8A, $48, $A2, $00
    .byte $20, $B4, $BB, $68, $AA, $20, $27, $6C, $90, $19, $BD, $60, $B4, $D0, $03, $FE
    .byte $60, $B4, $A5, $08, $9D, $00, $04, $A5, $09, $9D, $01, $04, $A5, $0B, $29, $01
    .byte $9D, $67, $B4, $60, $BD, $00, $04, $85, $08, $BD, $01, $04, $85, $09, $BD, $67
    .byte $B4, $85, $0B, $60, $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8
    .byte $08, $F4, $0C, $09, $09, $09, $0A, $0A, $A4, $79, $D0, $02, $A0, $80, $A5, $27
    .byte $29, $02, $D0, $2C, $88, $84, $79, $98, $0A, $30, $25, $29, $0F, $C9, $0A, $D0
    .byte $1F, $A9, $01, $A2, $10, $DD, $60, $B4, $F0, $11, $A2, $20, $DD, $60, $B4, $F0
    .byte $0A, $A2, $30, $DD, $60, $B4, $F0, $03, $E6, $79, $60, $A9, $08, $9D, $09, $04
    .byte $60, $A4, $7A, $D0, $02, $A0, $60, $A5, $27, $29, $02, $D0, $23, $88, $84, $7A
    .byte $98, $0A, $30, $1C, $29, $0F, $D0, $18, $A9, $01, $A2, $40, $DD, $60, $B4, $F0
    .byte $0A, $A2, $50, $DD, $60, $B4, $F0, $03, $E6, $7A, $60, $A9, $08, $9D, $09, $04
    .byte $60



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



.include "sideB/kraid/enemy_sprite_data.asm"


.include "sideB/kraid/palettes.asm"


.include "sideB/kraid/room_ptrs.asm"


.include "sideB/kraid/structure_ptrs.asm"


.include "sideB/kraid/items.asm"


.include "sideB/kraid/rooms.asm"


.include "sideB/kraid/structures.asm"


.include "sideB/kraid/metatiles.asm"



    .byte $02, $04
    .byte $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $FF, $01, $08
    .byte $01, $08, $01, $08, $FF, $01, $09, $01, $09, $01, $09, $FF, $01, $13, $FF, $03
    .byte $1D, $17, $1E, $03, $21, $1C, $21, $03, $21, $1C, $21, $03, $1F, $17, $20, $FF



FDSFileMacroPart3

