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
;Disassembled using TRaCER.

;Ridley hideout (memory page 5)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 5
.section "ROM Bank $005" bank 5 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_CREBG1:
    .incbin "common_chr/bg_CRE.chr" ; 8D60 - Common Room Elements (loaded everywhere except Tourian)

GFX_TourianFont:
    .incbin "tourian/font_chr.chr" ; 91B0 - Game over, Japanese font tiles (only loaded in Tourian?)

;Unused tile patterns.
    .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntry PalPntrTbl, Palette00                 ;($A0EB)Default room palette.
    PtrTableEntry PalPntrTbl, Palette01                 ;($A10F)Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette02                 ;($A11B)Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette03                 ;($A115)Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette04                 ;($A121)Samus varia suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette05                 ;($A127)Alternate room palette.
    PtrTableEntry PalPntrTbl, Palette06                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette07                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette08                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette09                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0A                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0B                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0C                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0D                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0E                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette0F                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette10                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette11                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette12                 ;($A13B)
    PtrTableEntry PalPntrTbl, Palette13                 ;($A13B)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntry PalPntrTbl, Palette14                 ;($A142)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette15                 ;($A149)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette16                 ;($A150)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette17                 ;($A157)Unused?
    PtrTableEntry PalPntrTbl, Palette18                 ;($A15F)Suitless Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette19                 ;($A167)Suitless Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette1A                 ;($A16F)Suitless Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette1B                 ;($A177)Suitless Samus varia suit with missiles selected palette.

AreaPointers:
    .word SpecItmsTbl               ;($A20D)Beginning of special items table.
    .word RmPtrTbl                  ;($A17F)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A1D3)Beginning of structure pointer table.
    .word MacroDefs                 ;($AB23)Beginning of macro definitions.
    .word EnFramePtrTable1          ;($9BF0)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2          ;($9CF0)tables needed to accommodate all entries.
    .word EnPlacePtrTable           ;($9D04)Pointers to enemy frame placement data.
    .word EnAnimTbl                 ;($9B85)Index to values in addr tables for enemy animations.

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
    jmp RTS_Polyp                       ;Area specific routine.

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts

L95CC:
    .byte $12                       ;Ridley's room.
AreaMusicFlag:
    .byte music_RidleyArea          ;Ridley hideout music init flag.
AreaEnemyDamage:
    .word $0240                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

AreaSamusMapPosX:
    .byte $19   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $18   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette05+1

    .byte $00
AreaFireballKilledAnimIndex:
    .byte EnAnim_FireballKilled - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_58 - EnAnimTbl

    .byte EnAnim_44 - EnAnimTbl, EnAnim_4A - EnAnimTbl
AreaFireballFallingAnimIndex:
    .byte EnAnim_48 - EnAnimTbl, EnAnim_4A - EnAnimTbl
AreaFireballSplatterAnimIndex:
    .byte EnAnim_4A - EnAnimTbl, EnAnim_36 - EnAnimTbl
AreaMellowAnimIndex:
    .byte EnAnim_25 - EnAnimTbl

ChooseEnemyAIRoutine:
    lda EnType,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine ; 00 - swooper
        .word SwooperAIRoutine2 ; 01 - becomes swooper ?
        .word SidehopperFloorAIRoutine ; 02 - dessgeegas
        .word SidehopperCeilingAIRoutine ; 03 - ceiling dessgeegas
        .word InvalidEnemy ; 04 - disappears
        .word InvalidEnemy ; 05 - same as 4
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - zebbo
        .word InvalidEnemy ; 08 - same as 4
        .word RidleyAIRoutine ; 09 - ridley
        .word RidleyProjectileAIRoutine ; 0A - ridley fireball
        .word InvalidEnemy ; 0B - same as 4
        .word MultiviolaAIRoutine ; 0C - bouncy orbs
        .word InvalidEnemy ; 0D - same as 4
        .word PolypAIRoutine ; 0E - polyp (unused)
        .word InvalidEnemy ; 0F - same as 4

EnemyDeathAnimIndex:
    .byte EnAnim_23 - EnAnimTbl, EnAnim_23 - EnAnimTbl
    .byte EnAnim_23 - EnAnimTbl, EnAnim_23 - EnAnimTbl
    .byte EnAnim_3A - EnAnimTbl, EnAnim_3A - EnAnimTbl
    .byte EnAnim_3C - EnAnimTbl, EnAnim_3C - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_56 - EnAnimTbl, EnAnim_56 - EnAnimTbl
    .byte EnAnim_65 - EnAnimTbl, EnAnim_63 - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_11 - EnAnimTbl, EnAnim_11 - EnAnimTbl
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl
    .byte EnAnim_28 - EnAnimTbl, EnAnim_28 - EnAnimTbl ; unused enemy
    .byte EnAnim_32 - EnAnimTbl, EnAnim_32 - EnAnimTbl
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

EnemyHitPointTbl:
    .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

EnemyRestingAnimIndex:
    .byte EnAnim_1D - EnAnimTbl, EnAnim_1D - EnAnimTbl
    .byte EnAnim_1D - EnAnimTbl, EnAnim_1D - EnAnimTbl
    .byte EnAnim_3E - EnAnimTbl, EnAnim_3E - EnAnimTbl
    .byte EnAnim_44 - EnAnimTbl, EnAnim_44 - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_4A - EnAnimTbl, EnAnim_4A - EnAnimTbl
    .byte EnAnim_69 - EnAnimTbl, EnAnim_67 - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_05 - EnAnimTbl, EnAnim_08 - EnAnimTbl
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl
    .byte EnAnim_1D - EnAnimTbl, EnAnim_1D - EnAnimTbl ; unused enemy
    .byte EnAnim_2D - EnAnimTbl, EnAnim_28 - EnAnimTbl
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

EnemyActiveAnimIndex:
    .byte EnAnim_20 - EnAnimTbl, EnAnim_20 - EnAnimTbl
    .byte EnAnim_20 - EnAnimTbl, EnAnim_20 - EnAnimTbl
    .byte EnAnim_3E - EnAnimTbl, EnAnim_3E - EnAnimTbl
    .byte EnAnim_44 - EnAnimTbl, EnAnim_44 - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte EnAnim_4A - EnAnimTbl, EnAnim_4A - EnAnimTbl
    .byte EnAnim_60 - EnAnimTbl, EnAnim_5D - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte EnAnim_05 - EnAnimTbl, EnAnim_08 - EnAnimTbl
    .byte EnAnim_13 - EnAnimTbl, EnAnim_18 - EnAnimTbl
    .byte EnAnim_1D - EnAnimTbl, EnAnim_1D - EnAnimTbl ; unused enemy
    .byte EnAnim_2D - EnAnimTbl, EnAnim_28 - EnAnimTbl
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

L967B:
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00
    .byte $00
    .byte $00 | $80 ; unused enemy
    .byte $00
    .byte $00
    .byte $00 ; unused enemy
    .byte $02 | $80
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy

L968B:
    .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

EnemyData0DTbl:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:
    .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

EnemyInitDelayTbl:
    .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice09 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice0A - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice00 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice01 - EnemyMovementChoices ; enemy can't use movement strings
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte EnemyMovementChoice03 - EnemyMovementChoices ; enemy moves manually
    .byte EnemyMovementChoice03 - EnemyMovementChoices ; enemy can't use movement strings
    .byte $00 ; unused enemy
    .byte EnemyMovementChoice04 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice05 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice06 - EnemyMovementChoices ; unused enemy
    .byte EnemyMovementChoice07 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice08 - EnemyMovementChoices ; unused enemy
    .byte EnemyMovementChoice09 - EnemyMovementChoices ; unused enemy
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
    .byte $80, $80, $00, $00, $7F, $7F, $81, $81, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
EnSpeedYTable:
    .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9, $FD, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01, $01, $00, $00, $00, $03, $00, $00, $00

L977B:
    .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl
    .byte EnAnim_44 - EnAnimTbl, EnAnim_4A - EnAnimTbl
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
    .word EnemyFireballMovement0
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
EnemyMovementChoice00: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $04, $05
EnemyMovementChoice01: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $06, $07
EnemyMovementChoice02: ; not assigned to any enemy
    EnemyMovementChoiceEntry $02
EnemyMovementChoice03: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice04: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice05: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice06: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice07: ; unused enemy
    EnemyMovementChoiceEntry $10
EnemyMovementChoice08: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $11
EnemyMovementChoice09: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $00
EnemyMovementChoice0A: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $01

EnemyMovement00_R:
EnemyMovement00_L:
EnemyMovement01_R:
EnemyMovement01_L:
    ; nothing

; unused (ripper)
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

; unused (seahorse)
EnemyMovement11_R:
EnemyMovement11_L:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementSeahorse

EnemyFireballMovement0:
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
    sta EnStatus,x
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
        ; enemy explode
        jmp CommonJump_02

;-------------------------------------------------------------------------------

.include "enemies/sidehopper.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Swooper Routine

.include "enemies/swooper.asm"

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

.include "enemies/ridley.asm"

StorePositionToTemp:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnHi,x
    sta Temp0B_PositionHi
    rts

LoadPositionFromTemp:
    lda Temp0B_PositionHi
    and #$01
    sta EnHi,x
    lda Temp08_PositionY
    sta EnY,x
    lda Temp09_PositionX
    sta EnX,x
    rts

;-------------------------------------------------------------------------------
; Bouncy Orb Routine
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
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
    .byte $76, $77

TileBlastFrame0B:
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

TileBlastFrame0C:
TileBlastFrame0D:
TileBlastFrame0E:
TileBlastFrame0F:
TileBlastFrame10:
    ;nothing

.include "ridley/enemy_sprite_data.asm"

;------------------------------------------[ Palette data ]------------------------------------------

.include "ridley/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "ridley/room_ptrs.asm"

.include "ridley/structure_ptrs.asm"

;-----------------------------------[ Special items table ]-----------------------------------------

.include "ridley/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "ridley/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "ridley/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "ridley/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/ridley.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/ridley.asm"
.endif

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/kraid.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/kraid.asm"
.endif

;Not used.
.if BUILDTARGET == "NES_NTSC"
    .byte $2A, $2A, $2A, $B9, $2A, $2A, $2A, $B2, $2A, $2A, $2A, $2A, $2A, $B9, $2A, $12
    .byte $2A, $B2, $26, $B9, $0E, $26, $26, $B2, $26, $B9, $0E, $26, $26, $B2, $22, $B9
    .byte $0A, $22, $22, $B2, $22, $B9, $0A, $22, $22, $B2, $20, $20, $B9, $20, $20, $20
    .byte $B2, $20, $B9, $34, $30, $34, $38, $34, $38, $3A, $38, $3A, $3E, $3A, $3E, $FF
    .byte $C2, $B2, $18, $30, $18, $30, $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2
    .byte $22, $20, $1C, $18, $16, $14, $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $B2
    .byte $2A, $28, $28, $B9, $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $26
    .byte $26, $3E, $FF, $F0, $B2, $01, $04, $01, $04, $FF, $E0, $BA, $2A, $1A, $02, $3A
    .byte $40, $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C
    .byte $38, $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A
    .byte $4C, $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF
    .byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $2B, $3B, $1B, $5A, $D0, $D1, $C3
    .byte $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF
    .byte $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC
    .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    .byte $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03
    .byte $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18
    .byte $30, $E8, $E8, $C8, $90, $60, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $BB, $02, $B9, $22, $20, $22, $BB, $02, $B9, $26, $22, $26, $BB, $02, $B9, $28
    .byte $26, $28, $BB, $02, $B9, $2C, $28, $2C, $BB, $02, $B9, $22, $20, $22, $BB, $02
    .byte $B9, $20, $22, $20, $BB, $02, $B9, $22, $1C, $22, $BB, $02, $B9, $1C, $22, $1C
    .byte $BB, $02, $FF, $D0, $B2, $3E, $B9, $3E, $3E, $3E, $BB, $02, $FF, $C2, $B2, $2A
    .byte $B9, $2A, $12, $2A, $BB, $02, $B2, $2A, $2A, $2A, $B9, $2A, $2A, $2A, $BB, $02
    .byte $B2, $2A, $2A, $2A, $B9, $2A, $2A, $2A, $BB, $02, $B2, $2A, $2A, $2A, $2A, $2A
    .byte $B9, $2A, $12, $2A, $BB, $02, $B2, $26, $B9, $0E, $26, $26, $BB, $02, $B2, $26
    .byte $B9, $0E, $26, $26, $BB, $02, $B2, $22, $B9, $0A, $22, $22, $BB, $02, $B2, $22
    .byte $B9, $0A, $22, $22, $BB, $02, $B2, $20, $20, $B9, $20, $20, $20, $BB, $02, $B2
    .byte $20, $B9, $34, $30, $34, $BB, $02, $B9, $38, $34, $38, $BB, $02, $B9, $3A, $38
    .byte $3A, $BB, $02, $B9, $3E, $3A, $3E, $BB, $02, $FF, $C2, $B2, $18, $30, $18, $30
    .byte $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2, $22, $20, $1C, $18, $16, $14
    .byte $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $BB, $02, $B2, $2A, $28, $28, $B9
    .byte $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $BB, $02, $B9, $26, $26
    .byte $3E, $BB, $02, $FF, $D0, $B2, $01, $04, $FF, $C8, $B2, $04, $04, $07, $04, $04
    .byte $04, $07, $B9, $04, $04, $04, $BB, $01, $FF, $D0, $B2, $04, $07, $04, $B9, $07
    .byte $04, $04, $BB, $01, $FF, $E0, $BA, $2A, $1A, $02, $3A, $40, $02, $1C, $2E, $38
    .byte $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C, $38, $46, $26, $02, $3A
    .byte $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A, $4C, $02, $18, $1E, $FF
    .byte $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF, $C8, $10, $0E, $FF, $C8
    .byte $0E, $0C, $FF, $00, $CA, $F0, $05, $4A, $4A
.endif

.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .section "ROM Bank $005 - Music Engine" bank 5 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $005 - Music Engine" bank 5 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $005 - Vectors" bank 5 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

