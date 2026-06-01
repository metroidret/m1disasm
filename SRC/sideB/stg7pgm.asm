; side B file $19 - stg7pgm  (prgram $B560-$CBDF)
; Ridley Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_14
    .ascstr "STG7PGM", $00
FDSFileMacroPart2 $B560, FDSFileType_PRGRAM



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
    jsr CommonJump_JumpEngine
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

.include "sideB/enemies/pipe_bug.asm"

.include "sideB/enemies/swooper.asm"

.include "sideB/enemies/crawler.asm"

.include "sideB/enemies/ridley.asm"



StoreEnemyPositionToTemp__{AREA}:
    .byte $BD, $00, $04
    .byte $85, $08
    .byte $BD, $01, $04
    .byte $85, $09
    .byte $BD, $67, $B4
    .byte $85, $0B
    .byte $60

LoadEnemyPositionFromTemp__{AREA}:
    .byte $A5, $0B
    .byte $29, $01
    .byte $9D, $67, $B4
    .byte $A5, $08
    .byte $9D, $00, $04
    .byte $A5, $09
    .byte $9D, $01, $04
    .byte $60



.include "sideB/enemies/multiviola.asm"

.include "sideB/enemies/polyp.asm"



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

