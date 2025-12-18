; side B file $15 - stg1pgm  (prgram $B560-$CFDF)
; Brinstar Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $10
    .ascstr "STG1PGM", $00
FDSFileMacroPart2 $B560, $00



.redef AREA = "STG1PGM"

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

AreaRoutine: ;($B5BB)
    jmp AreaRoutineStub_{AREA}

;The following routine returns the two's complement of the value stored in A.
TwosComplement_: ;($B5BE)
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
ChooseEnemyAIRoutine: ;($B5DD)
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine_{AREA} ; 00 - Sidehopper (unused)
        .word SidehopperCeilingAIRoutine_{AREA} ; 01 - Ceiling sidehopper (unused)
        .word WaverAIRoutine_{AREA} ; 02 - Waver
        .word RipperAIRoutine_{AREA} ; 03 - Ripper
        .word SkreeAIRoutine_{AREA} ; 04 - Skree
        .word CrawlerAIRoutine_{AREA} ; 05 - Zoomer (crawler)
        .word RioAIRoutine_{AREA} ; 06 - Rio (swoopers)
        .word PipeBugAIRoutine_{AREA} ; 07 - Zeb
        .word KraidAIRoutine_{AREA} ; 08 - Kraid (crashes due to bug)
        .word KraidLintAIRoutine_{AREA} ; 09 - Kraid's lint (crashes)
        .word KraidNailAIRoutine_{AREA} ; 0A - Kraid's nail (crashes)
        .word $0000 ; 0B - Null pointers (hard crash)
        .word $0000 ; 0C - Null
        .word $0000 ; 0D - Null
        .word $0000 ; 0E - Null
        .word $0000 ; 0F - Null


EnemyDeathAnimIndex: ;($B603)
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
    
EnemyHealthTbl: ;($B623)
    .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

; ResetAnimIndex table for resting enemy
EnemyRestingAnimIndex: ;($B633)
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
EnemyActiveAnimIndex: ;($B653)
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

EnemyForceSpeedTowardsSamusDelayTbl: ;($B693)
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00

EnemyDistanceToSamusThreshold: ;($B6A3)
    .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl: ;($B6B3)
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

EnemyMovementChoiceOffset: ;($B6C3)
    .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

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
    .byte $7F, $40, $30, $C0, $D0, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable: ;($B737)
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable: ;($B74B)
    .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable: ;($B75F)
    .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00


    .byte %01100100 ; 00 - Sidehopper (unused)
    .byte %01101100 ; 01 - Ceiling sidehopper (unused)
    .byte %00100001 ; 02 - Waver
    .byte %00000001 ; 03 - Ripper
    .byte %00000100 ; 04 - Skree
    .byte %00000000 ; 05 - Zoomer (crawler)
    .byte %01001100 ; 06 - Rio (swoopers)
    .byte %01000000 ; 07 - Zeb
    .byte %00000100 ; 08 - Kraid (crashes due to bug)
    .byte %00000000 ; 09 - Kraid's lint (crashes)
    .byte %00000000 ; 0A - Kraid's nail (crashes)
    .byte %01000000 ; 0B - Null pointers (hard crash)
    .byte %01000000 ; 0C - Null
    .byte %00000000 ; 0D - Null
    .byte %00000000 ; 0E - Null
    .byte %00000000 ; 0F - Null

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $64, $67
    .byte $69, $69
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


EnemyMovementChoices: ;($B7C9)
EnemyMovementChoice_SidehopperFloor_{AREA}:
    EnemyMovementChoiceEntry $01, $02
EnemyMovementChoice_SidehopperCeiling_{AREA}:
    EnemyMovementChoiceEntry $03, $04
EnemyMovementChoice_Waver_{AREA}:
    EnemyMovementChoiceEntry $05
EnemyMovementChoice_Ripper_{AREA}:
    EnemyMovementChoiceEntry $06
EnemyMovementChoice_Skree_{AREA}:
    EnemyMovementChoiceEntry $07
EnemyMovementChoice_Rio_{AREA}:
    EnemyMovementChoiceEntry $08
EnemyMovementChoice_Zeb_{AREA}:
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Zoomer_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $00
EnemyMovementChoice08_{AREA}: ; unused
    EnemyMovementChoiceEntry $0B
EnemyMovementChoice_Kraid_{AREA}: ; unused
    EnemyMovementChoiceEntry $0C, $0D
EnemyMovementChoice_KraidLint_{AREA}: ; unused
    EnemyMovementChoiceEntry $0E
EnemyMovementChoice_KraidNail_{AREA}: ; unused
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
    ; nothing

; waver
EnemyMovement05_R_{AREA}:
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
    SignMagSpeed $02,  2,  7
    SignMagSpeed $02,  2,  7
    SignMagSpeed $04,  2,  6
    SignMagSpeed $04,  2,  5
    SignMagSpeed $05,  2,  3
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2, -1
    SignMagSpeed $03,  2, -3
    SignMagSpeed $05,  2, -5
    SignMagSpeed $04,  2, -6
    SignMagSpeed $02,  2, -7
    EnemyMovementInstr_ClearEnJumpDsplcmnt

    SignMagSpeed $03,  2, -5
    SignMagSpeed $06,  2, -3
    SignMagSpeed $08,  2, -1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2,  1
    SignMagSpeed $05,  2,  3
    SignMagSpeed $04,  2,  5
    SignMagSpeed $03,  2,  5
    SignMagSpeed $06,  2,  3
    SignMagSpeed $08,  2,  1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2, -1
    SignMagSpeed $05,  2, -3
    SignMagSpeed $04,  2, -5
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    EnemyMovementInstr_Restart

EnemyMovement05_L_{AREA}:
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
    SignMagSpeed $02, -2,  7
    SignMagSpeed $02, -2,  7
    SignMagSpeed $04, -2,  6
    SignMagSpeed $04, -2,  5
    SignMagSpeed $05, -2,  3
    SignMagSpeed $03, -2,  1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2, -1
    SignMagSpeed $03, -2, -3
    SignMagSpeed $05, -2, -5
    SignMagSpeed $04, -2, -6
    SignMagSpeed $02, -2, -7
    EnemyMovementInstr_ClearEnJumpDsplcmnt

    SignMagSpeed $03, -2, -5
    SignMagSpeed $06, -2, -3
    SignMagSpeed $08, -2, -1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2,  1
    SignMagSpeed $05, -2,  3
    SignMagSpeed $04, -2,  5
    SignMagSpeed $03, -2,  5
    SignMagSpeed $06, -2,  3
    SignMagSpeed $08, -2,  1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2, -1
    SignMagSpeed $05, -2, -3
    SignMagSpeed $04, -2, -5
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    EnemyMovementInstr_Restart

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

; unused (kraid)
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
    SignMagSpeed $1E,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_L_{AREA}:
    SignMagSpeed $1E, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E,  1,  1
    EnemyMovementInstr_FE

; unused (kraid lint)
EnemyMovement0E_R_{AREA}:
    SignMagSpeed $50,  4,  0
    EnemyMovementInstr_Restart

EnemyMovement0E_L_{AREA}:
    SignMagSpeed $50, -4,  0
    EnemyMovementInstr_Restart

; unused (kraid nail)
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
.include "sideB/enemies/sidehopper.asm"

.include "sideB/enemies/ripper.asm"

.include "sideB/enemies/waver.asm"

.include "sideB/enemies/skree.asm"

.include "sideB/enemies/crawler.asm"

.include "sideB/enemies/rio.asm"

.include "sideB/enemies/pipe_bug.asm"

.include "sideB/enemies/kraid.asm"



AreaRoutineStub_{AREA}:
    rts

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
    .byte $32
    .byte $4E, $4E
    .byte $4E, $4E
    .byte $4E, $4E

TileBlastFrame0A_{AREA}:
TileBlastFrame0B_{AREA}:
TileBlastFrame0C_{AREA}:
TileBlastFrame0D_{AREA}:
TileBlastFrame0E_{AREA}:
TileBlastFrame0F_{AREA}:
TileBlastFrame10_{AREA}:
    ; nothing



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



FDSFileMacroPart3

