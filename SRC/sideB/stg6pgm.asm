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
    jsr CommonJump_JumpEngine
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

VRAMStringPtrTable: ;($B7A7)
    .word VRAMString00_{AREA}
    .word VRAMString01_{AREA}
    .word VRAMString02_{AREA}
    .word VRAMString03_{AREA}
    .word VRAMString04_{AREA}
    .word VRAMString05_{AREA}
    .word VRAMString06_{AREA}
    .word VRAMString07_{AREA}
    .word VRAMString08_{AREA}
    .word VRAMString09_{AREA}
    .word VRAMString0A_{AREA}
    .word VRAMString0B_{AREA}
    .word VRAMString0C_{AREA}
    .word VRAMString0D_{AREA}
    .word VRAMString0E_{AREA}
    .word VRAMString0F_{AREA}
    .word VRAMString10_{AREA}

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



UpdateEnemyCommon_Decide_{AREA}:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq @resting
    cmp #enemyStatus_Explode
    beq @explode
        ; enemy default
        lda $00
        jmp CommonJump_UpdateEnemyCommon
    @resting:
        ; enemy resting
        lda $01
        jmp CommonJump_UpdateEnemyCommon_noMove
    @explode:
        ; enemy explode
        jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim



; enemy ai routines
.include "sideB/enemies/sidehopper.asm"

.include "sideB/enemies/ripper.asm"

.include "sideB/enemies/skree.asm"

.include "sideB/enemies/crawler.asm"

.include "sideB/enemies/pipe_bug.asm"

.include "sideB/enemies/kraid.asm"



    .byte $60

VRAMString00_{AREA}:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

VRAMString01_{AREA}:
    .byte $22
    .byte $80, $81
    .byte $82, $83

VRAMString02_{AREA}:
    .byte $22
    .byte $84, $85
    .byte $86, $87

VRAMString03_{AREA}:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

VRAMString04_{AREA}:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

VRAMString05_{AREA}:
    .byte $22
    .byte $94, $95
    .byte $96, $97

VRAMString06_{AREA}:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

VRAMString07_{AREA}:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

VRAMString08_{AREA}:
    .byte $22
    .byte $90, $91
    .byte $92, $93

VRAMString09_{AREA}:
    .byte $22
    .byte $70, $71
    .byte $72, $73

VRAMString0A_{AREA}:
    .byte $22
    .byte $74, $75
    .byte $76, $77

VRAMString0B_{AREA}:
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

VRAMString0C_{AREA}:
VRAMString0D_{AREA}:
VRAMString0E_{AREA}:
VRAMString0F_{AREA}:
VRAMString10_{AREA}:
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

