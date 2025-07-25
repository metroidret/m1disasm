; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi

;Norfair (memory page 2)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 2
.section "ROM Bank $002" bank 2 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Norfair enemy tile patterns.
GFX_NorfairSprites:
    .incbin "norfair/sprite_tiles.chr"

;Tourian enemy tile patterns.
GFX_TourianSprites:
    .incbin "tourian/sprite_tiles.chr"

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntry PalPntrTbl, Palette00                 ;($A178)Default room palette.
    PtrTableEntry PalPntrTbl, Palette01                 ;($A19C)Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette02                 ;($A1A8)Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette03                 ;($A1A2)Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette04                 ;($A1AE)Samus varia suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette05                 ;($A1B4)Alternate room palette.
    PtrTableEntry PalPntrTbl, Palette06                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette07                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette08                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette09                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0A                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0B                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0C                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0D                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0E                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette0F                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette10                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette11                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette12                 ;($A1D7)
    PtrTableEntry PalPntrTbl, Palette13                 ;($A1D7)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntry PalPntrTbl, Palette14                 ;($A1DE)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette15                 ;($A1E5)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette16                 ;($A1EC)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette17                 ;($A1F3)Unused?
    PtrTableEntry PalPntrTbl, Palette18                 ;($A1FB)Suitless Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette19                 ;($A203)Suitless Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette1A                 ;($A20B)Suitless Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette1B                 ;($A213)Suitless Samus varia suit with missiles selected palette.

AreaPointers:
    .word SpecItmsTbl               ;($A2D9)Beginning of special items table.
    .word RmPtrTbl                  ;($A21B)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A277)Beginning of structure pointer table.
    .word MacroDefs                 ;($AEEC)Beginning of macro definitions.
    .word EnFramePtrTable1          ;($9C64)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2          ;($9D64)tables needed to accommodate all entries.
    .word EnPlacePtrTable           ;($9D78)Pointers to enemy frame placement data.
    .word EnAnimTbl                 ;($9BDA)Index to values in addr tables for enemy animations.

; Tourian-specific jump table (dummied out in other banks)
;  Each line is RTS, NOP, NOP in this bank
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
    jmp RTS_Polyp                       ;Area specific routine.(RTS)

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts

L95CC:
    .byte $FF                       ;Not used.
AreaMusicFlag:
    .byte music_Norfair             ;Norfair music init flag.
AreaEnemyDamage:
    .word $0100                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $10, $05, $27, $04, $0F, $FF, $FF

AreaSamusMapPosX:
    .byte $16   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $0D   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette00+1

    .byte $00
AreaFireballKilledAnimIndex:
    .byte EnAnim_FireballKilled - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion - EnAnimTbl
; fireball rising?
    .byte EnAnim_DragonFireballUpRight - EnAnimTbl, EnAnim_DragonFireballUpLeft - EnAnimTbl
AreaFireballFallingAnimIndex:
    .byte EnAnim_DragonFireballDownRight - EnAnimTbl, EnAnim_DragonFireballDownLeft - EnAnimTbl
AreaFireballSplatterAnimIndex:
    .byte EnAnim_DragonFireballSplatter - EnAnimTbl, EnAnim_PolypRockShatter - EnAnimTbl
AreaMellowAnimIndex:
    .byte EnAnim_Mella - EnAnimTbl

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine00 ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01 ; 01 - swooper targetting samus
        .word RipperAIRoutine ; 02 - ripper II
        .word InvalidEnemy ; 03 - disappears
        .word InvalidEnemy ; 04 - same as 3
        .word InvalidEnemy ; 05 - same as 3
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - gamet
        .word InvalidEnemy ; 08 - same as 3
        .word InvalidEnemy ; 09 - same as 3
        .word InvalidEnemy ; 0A - same as 3
        .word SqueeptAIRoutine ; 0B - lava jumper
        .word MultiviolaAIRoutine ; 0C - bouncy orb
        .word SeahorseAIRoutine ; 0D - seahorse
        .word PolypAIRoutine ; 0E - rock launcher thing
        .word InvalidEnemy ; 0F - same as 3

EnemyDeathAnimIndex:
    .byte EnAnim_GerutaExplode - EnAnimTbl, EnAnim_GerutaExplode - EnAnimTbl
    .byte EnAnim_GerutaExplode - EnAnimTbl, EnAnim_GerutaExplode - EnAnimTbl
    .byte EnAnim_RipperIIExplode - EnAnimTbl, EnAnim_RipperIIExplode - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_NovaExplode - EnAnimTbl, EnAnim_NovaExplode - EnAnimTbl
    .byte EnAnim_GametExplodeFacingRight - EnAnimTbl, EnAnim_GametExplodeFacingLeft - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_11 - EnAnimTbl, EnAnim_11 - EnAnimTbl ; unused enemy
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_SqueeptExplode - EnAnimTbl, EnAnim_SqueeptExplode - EnAnimTbl
    .byte EnAnim_MultiviolaExplode - EnAnimTbl, EnAnim_MultiviolaExplode - EnAnimTbl
    .byte EnAnim_DragonExplode - EnAnimTbl, EnAnim_DragonExplode - EnAnimTbl
    .byte $00, $00 ; undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; unused enemy

EnemyHealthTbl:
    .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

EnemyRestingAnimIndex:
    .byte EnAnim_GerutaIdle - EnAnimTbl, EnAnim_GerutaIdle - EnAnimTbl
    .byte EnAnim_GerutaIdle - EnAnimTbl, EnAnim_GerutaIdle - EnAnimTbl
    .byte EnAnim_RipperIIFacingRight - EnAnimTbl, EnAnim_RipperIIFacingLeft - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_NovaOnFloor - EnAnimTbl, EnAnim_NovaOnFloor - EnAnimTbl
    .byte EnAnim_GametRestingFacingRight - EnAnimTbl, EnAnim_GametRestingFacingLeft - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_05 - EnAnimTbl, EnAnim_08 - EnAnimTbl ; unused enemy
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_SqueeptFalling - EnAnimTbl, EnAnim_SqueeptFalling - EnAnimTbl
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTbl, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl
    .byte EnAnim_DragonIdleFacingRight - EnAnimTbl, EnAnim_DragonIdleFacingLeft - EnAnimTbl
    .byte $00, $00 ; undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; unused enemy

EnemyActiveAnimIndex:
    .byte EnAnim_GerutaSwooping - EnAnimTbl, EnAnim_GerutaSwooping - EnAnimTbl
    .byte EnAnim_GerutaSwooping - EnAnimTbl, EnAnim_GerutaSwooping - EnAnimTbl
    .byte EnAnim_RipperIIFacingRight - EnAnimTbl, EnAnim_RipperIIFacingLeft - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_NovaOnFloor - EnAnimTbl, EnAnim_NovaOnFloor - EnAnimTbl
    .byte EnAnim_GametActiveFacingRight - EnAnimTbl, EnAnim_GametActiveFacingLeft - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_05 - EnAnimTbl, EnAnim_08 - EnAnimTbl ; unused enemy
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_SqueeptJumping - EnAnimTbl, EnAnim_SqueeptJumping - EnAnimTbl
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTbl, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl
    .byte EnAnim_DragonIdleFacingRight - EnAnimTbl, EnAnim_DragonIdleFacingLeft - EnAnimTbl
    .byte $00, $00 ; undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; unused enemy

L967B:
    .byte $00
    .byte $00
    .byte $00 | $80
    .byte $02 | $80 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00
    .byte $00
    .byte $00 | $80 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00
    .byte $02 | $80
    .byte $00
    .byte $00
    .byte $00 ; unused enemy

L968B:
    .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

EnemyData0DTbl:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

EnemyDistanceToSamusThreshold:
    .byte $5 | (0 << 7)
    .byte $5 | (0 << 7)
    .byte $00
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00
    .byte $00
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00
    .byte $00
    .byte $C | (1 << 7)
    .byte $00
    .byte $00 ; unused enemy

EnemyInitDelayTbl:
    .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice07 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice08 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice00 - EnemyMovementChoices
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte EnemyMovementChoice01 - EnemyMovementChoices ; enemy moves manually
    .byte EnemyMovementChoice01 - EnemyMovementChoices ; enemy can't use movement strings
    .byte $00 ; unused enemy
    .byte EnemyMovementChoice02 - EnemyMovementChoices ; unused enemy
    .byte EnemyMovementChoice03 - EnemyMovementChoices ; unused enemy
    .byte EnemyMovementChoice04 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice05 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice06 - EnemyMovementChoices
    .byte EnemyMovementChoice07 - EnemyMovementChoices ; enemy doesn't move
    .byte $00 ; unused enemy

EnemyMovementPtrs:
    .word EnemyMovement00_R, EnemyMovement00_L
    .word EnemyMovement01_R, EnemyMovement01_L
    .word EnemyMovement02_R, EnemyMovement02_L
    .word EnemyMovement03_R, EnemyMovement03_L
    .word EnemyMovement04_R, EnemyMovement04_L
    .word EnemyMovement05_R, EnemyMovement05_L
    .word EnemyMovement06_R, EnemyMovement06_L
    .word EnemyMovement07_R, EnemyMovement07_L
    .word EnemyMovement08_R, EnemyMovement08_L
    .word EnemyMovement09_R, EnemyMovement09_L
    .word EnemyMovement0A_R, EnemyMovement0A_L
    .word EnemyMovement0B_R, EnemyMovement0B_L
    .word EnemyMovement0C_R, EnemyMovement0C_L
    .word EnemyMovement0D_R, EnemyMovement0D_L
    .word EnemyMovement0E_R, EnemyMovement0E_L
    .word EnemyMovement0F_R, EnemyMovement0F_L
    .word EnemyMovement10_R, EnemyMovement10_L
    .word EnemyMovement11_R, EnemyMovement11_L
    .byte $00, $00, $00, $00, $00, $00, $00, $00

EnAccelYTable:
    .byte $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB, $FD, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01, $01, $00, $01, $01, $03, $00, $00, $00

L977B:
    .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_PolypRock - EnAnimTbl, EnAnim_PolypRock - EnAnimTbl
    .byte EnAnim_DragonFireballUpRight - EnAnimTbl, EnAnim_DragonFireballUpLeft - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetX:
    .byte $08, $F8
    .byte $00, $00
    .byte $00, $00
    .byte $08, $F8
EnemyFireballPosOffsetY:
    .byte $00
    .byte $00
    .byte $00
    .byte $F8

EnemyFireballMovementPtrTable:
    .word EnemyFireballMovement0
    .word EnemyFireballMovement1
    .word EnemyFireballMovement2
    .word EnemyFireballMovement3

TileBlastFramePtrTable:
    .word TileBlastFrame00
    .word TileBlastFrame01
    .word TileBlastFrame02
    .word TileBlastFrame03
    .word TileBlastFrame04
    .word TileBlastFrame05
    .word TileBlastFrame06
    .word TileBlastFrame07
    .word TileBlastFrame08
    .word TileBlastFrame09
    .word TileBlastFrame0A
    .word TileBlastFrame0B
    .word TileBlastFrame0C
    .word TileBlastFrame0D
    .word TileBlastFrame0E
    .word TileBlastFrame0F
    .word TileBlastFrame10

EnemyMovementChoices:
EnemyMovementChoice00:
    EnemyMovementChoiceEntry $02
EnemyMovementChoice01: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice02: ; unused enemy
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice03: ; unused enemy
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice04: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice05: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $10
EnemyMovementChoice06:
    EnemyMovementChoiceEntry $11
EnemyMovementChoice07: ; enemy doesn't move
    EnemyMovementChoiceEntry $00
EnemyMovementChoice08: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $01


EnemyMovement00_R:
EnemyMovement00_L:
EnemyMovement01_R:
EnemyMovement01_L:
    ; nothing

; ripper II
EnemyMovement02_R:
    SignMagSpeed $01,  3,  0
    EnemyMovementInstr_Restart

EnemyMovement02_L:
    SignMagSpeed $01, -3,  0
    EnemyMovementInstr_Restart

EnemyMovement03_R:
EnemyMovement03_L:
EnemyMovement04_R:
EnemyMovement04_L:
EnemyMovement05_R:
EnemyMovement05_L:
EnemyMovement06_R:
EnemyMovement06_L:
EnemyMovement07_R:
EnemyMovement07_L:
EnemyMovement08_R:
EnemyMovement08_L:
EnemyMovement09_R:
EnemyMovement09_L:
EnemyMovement0A_R:
EnemyMovement0A_L:
EnemyMovement0B_R:
EnemyMovement0B_L:
EnemyMovement0C_R:
EnemyMovement0C_L:
EnemyMovement0D_R:
EnemyMovement0D_L:
EnemyMovement0E_R:
EnemyMovement0E_L:
EnemyMovement0F_R:
EnemyMovement0F_L:
EnemyMovement10_R:
EnemyMovement10_L:
    ; nothing

; seahorse
EnemyMovement11_R:
EnemyMovement11_L:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementSeahorse

EnemyFireballMovement0:
    SignMagSpeed $0A,  3, -5
    SignMagSpeed $07,  3, -3
    SignMagSpeed $07,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $07,  3,  1
    SignMagSpeed $07,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

EnemyFireballMovement1:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnemyFireballMovement2:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnemyFireballMovement3:
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

;-------------------------------------------------------------------------------
InvalidEnemy:
    lda #$00
    sta EnsExtra.0.status,x
    rts

CommonEnemyJump_00_01_02:
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

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Ripper routine
.include "enemies/ripper.asm"

;-------------------------------------------------------------------------------

.include "enemies/swooper.asm"

;-------------------------------------------------------------------------------
; is this unused?
L9963:
    jsr CommonJump_EnemyFlipAfterDisplacement
    lda #$06
    sta $00
    jmp CommonEnemyJump_00_01_02

    jsr CommonJump_EnemyFlipAfterDisplacement
    lda #$06
    sta $00
    jmp CommonEnemyJump_00_01_02

    jsr CommonJump_EnemyFlipAfterDisplacement
    lda #$06
    sta $00
    lda EnemyMovementPtr
    cmp #$02
    bne L9993
    cmp EnsExtra.0.status,x
    bne L9993
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    bne L9993
        jmp L984D
    L9993:
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

StorePositionToTemp:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

LoadPositionFromTemp:
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x
    lda Temp08_PositionY
    sta EnY,x
    lda Temp09_PositionX
    sta EnX,x
    rts

;-------------------------------------------------------------------------------

.include "enemies/squeept.asm"

;-------------------------------------------------------------------------------
; Bouncy Orb Routine (Multiviola?)
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------

.include "enemies/seahorse.asm"

;-------------------------------------------------------------------------------

.include "enemies/polyp.asm"

;-------------------------------------------------------------------------------

TileBlastFrame00:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01:
    .byte $22
    .byte $80, $81
    .byte $82, $83

TileBlastFrame02:
    .byte $22
    .byte $84, $85
    .byte $86, $87

TileBlastFrame03:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

TileBlastFrame04:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

TileBlastFrame05:
    .byte $22
    .byte $94, $95
    .byte $96, $97

TileBlastFrame06:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

TileBlastFrame07:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

TileBlastFrame08:
    .byte $22
    .byte $90, $91
    .byte $92, $93

TileBlastFrame09:
    .byte $22
    .byte $70, $71
    .byte $72, $73

TileBlastFrame0A:
    .byte $22
    .byte $74, $75
    .byte $75, $74

TileBlastFrame0B:
    .byte $22
    .byte $76, $76
    .byte $76, $76

TileBlastFrame0C:
TileBlastFrame0D:
TileBlastFrame0E:
TileBlastFrame0F:
TileBlastFrame10:
    ;nothing

.include "norfair/enemy_sprite_data.asm"

;-----------------------------------------[ Palette data ]-------------------------------------------

.include "norfair/palettes.asm"

;--------------------------[ Room and structure pointer tables ]-----------------------------------

.include "norfair/room_ptrs.asm"

.include "norfair/structure_ptrs.asm"

;---------------------------------[ Special items table ]-----------------------------------------

.include "norfair/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "norfair/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "norfair/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "norfair/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/norfair.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/norfair.asm"
.endif

;Unused. (B099)
.if BUILDTARGET == "NES_NTSC"
    .byte $B9, $30, $3A, $3E, $B6, $42, $B9, $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A
    .byte $44, $48, $B4, $4C, $B3, $48, $46, $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2
    .byte $44, $B9, $44, $4C, $52, $B4, $54, $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9
    .byte $26, $3E, $34, $B2, $26, $B9, $26, $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2
    .byte $2C, $B9, $2C, $3A, $2C, $FF, $C4, $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9
    .byte $18, $26, $18, $B2, $18, $FF, $C2, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9
    .byte $1E, $18, $1E, $B2, $1C, $B9, $1C, $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF
    .byte $B2, $26, $12, $16, $18, $1C, $20, $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2
    .byte $10, $B9, $30, $2C, $28, $B2, $1E, $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9
    .byte $2A, $FF, $E8, $B2, $04, $04, $04, $B9, $04, $04, $04, $FF, $E0, $E0, $F0, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05, $26, $52, $63, $00
    .byte $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B, $8D, $A7, $B1, $00
    .byte $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0, $F0, $F8, $FC, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07, $03, $03, $01, $00
    .byte $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7, $CF, $FE, $EC, $00
    .byte $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9, $1E, $0E, $44, $07
    .byte $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B
    .byte $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF, $C7, $00
    .byte $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $80
    .byte $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A
    .byte $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8
    .byte $E8, $C8, $90, $60, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $44, $B0, $42, $44, $42, $3A, $FF, $B4, $3E, $26, $B6, $42, $B9, $42, $3E, $42
    .byte $BB, $02, $B3, $44, $B2, $3A, $B9, $30, $3A, $3E, $BB, $02, $B6, $42, $B9, $42
    .byte $3E, $42, $BB, $02, $B3, $44, $B2, $3A, $B9, $3A, $44, $48, $BB, $02, $B4, $4C
    .byte $B3, $48, $46, $B6, $48, $B9, $4E, $4C, $48, $BB, $02, $B3, $4C, $B2, $44, $B9
    .byte $44, $4C, $52, $BB, $02, $B4, $54, $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9
    .byte $26, $3E, $34, $BB, $02, $B2, $26, $B9, $26, $34, $26, $BB, $02, $B2, $2C, $B9
    .byte $2C, $3A, $2C, $BB, $02, $B2, $2C, $B9, $2C, $3A, $2C, $BB, $02, $FF, $C4, $B2
    .byte $26, $B9, $34, $26, $26, $BB, $02, $FF, $D0, $B9, $18, $26, $18, $BB, $02, $B2
    .byte $18, $FF, $C2, $B2, $1E, $B9, $1E, $18, $1E, $BB, $02, $B2, $1E, $B9, $1E, $18
    .byte $1E, $BB, $02, $B2, $1C, $B9, $1C, $14, $1C, $BB, $02, $B2, $1C, $B9, $1C, $14
    .byte $1C, $BB, $02, $FF, $B2, $26, $12, $16, $18, $1C, $20, $24, $26, $B2, $28, $B9
    .byte $28, $1E, $18, $BB, $02, $B2, $10, $B9, $30, $2C, $28, $BB, $02, $B2, $1E, $1C
    .byte $18, $14, $2A, $2A, $2A, $2A, $C3, $B9, $2A, $FF, $BB, $02, $C3, $B9, $2A, $FF
    .byte $BB, $02, $C3, $B9, $2A, $FF, $BB, $02, $C3, $B9, $2A, $FF, $BB, $02, $E8, $B2
    .byte $04, $04, $04, $B9, $04, $04, $04, $BB, $01, $FF, $85, $03, $A9, $0C, $85, $11
    .byte $B1, $75, $10, $14, $C9, $FF, $D0, $05, $85, $74, $4C, $49, $F0, $C8, $E6, $59
    .byte $29, $7F, $85, $0F, $B1, $75, $D0, $04, $85, $0F, $A9, $01, $85, $10, $C8, $E6
    .byte $59, $A9, $00, $85, $08, $A5, $0F, $48, $0A, $AA, $A5, $38, $4A, $A5, $6D, $D0
    .byte $16, $90, $0A, $BD, $77, $F3, $48, $BD, $76, $F3, $4C, $FB, $F1, $BD, $F3, $F2
    .byte $48, $BD, $F2, $F2, $4C, $FB, $F1, $30, $16, $90, $0A, $BD, $B3, $96, $48, $BD
    .byte $B2, $96, $4C, $FB, $F1, $BD, $CD, $95, $48, $BD, $CC, $95, $4C, $FB, $F1, $90
    .byte $0A, $BD, $C9, $F4, $48, $BD, $C8, $F4, $4C, $FB, $F1, $BD, $4D, $F4, $48, $BD
    .byte $4C, $F4, $A6, $02, $95, $E0, $E8, $68, $95, $E0, $E8, $86, $02, $68, $85, $05
    .byte $48, $4A, $4A, $AA, $A5, $6D, $D0, $06, $BD, $E1, $F2, $4C, $22, $F2, $30, $06
    .byte $BD, $AF, $95, $4C, $22, $F2, $BD, $3C, $F4, $85, $04, $68, $29, $03, $AA, $E8
    .byte $A5, $04, $CA, $F0, $05, $4A, $4A
.endif

.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .section "ROM Bank $002 - Music Engine" bank 2 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $002 - Music Engine" bank 2 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $002 - Vectors" BANK 2 SLOT "ROMSwitchSlot" ORGA $BFFA FORCE
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

