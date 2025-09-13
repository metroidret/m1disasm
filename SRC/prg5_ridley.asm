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
GFX_Bank5Garbage:
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

AreaMapPosX:
    .byte $19   ;Samus start x coord on world map.
AreaMapPosY:
    .byte $18   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette05+1

    .byte $00
AreaFireballKilledAnimIndex:
    .byte EnAnim_FireballKilled - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion - EnAnimTbl

    .byte EnAnim_DessgeegaIdleCeiling - EnAnimTbl, EnAnim_ViolaOnFloor - EnAnimTbl
AreaFireballFallingAnimIndex:
    .byte EnAnim_DessgeegaCeilingHopping - EnAnimTbl, EnAnim_ViolaOnFloor - EnAnimTbl
AreaFireballSplatterAnimIndex:
    .byte EnAnim_ViolaOnFloor - EnAnimTbl, EnAnim_36 - EnAnimTbl
AreaMellowAnimIndex:
    .byte EnAnim_Mella - EnAnimTbl

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine00 ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01 ; 01 - swooper targetting samus
        .word SidehopperFloorAIRoutine ; 02 - dessgeegas
        .word SidehopperCeilingAIRoutine ; 03 - ceiling dessgeegas
        .word RemoveEnemy_ ; 04 - disappears
        .word RemoveEnemy_ ; 05 - same as 4
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - zebbo
        .word RemoveEnemy_ ; 08 - same as 4
        .word RidleyAIRoutine ; 09 - ridley
        .word RidleyProjectileAIRoutine ; 0A - ridley fireball
        .word RemoveEnemy_ ; 0B - same as 4
        .word MultiviolaAIRoutine ; 0C - bouncy orbs
        .word RemoveEnemy_ ; 0D - same as 4
        .word PolypAIRoutine ; 0E - polyp (unused)
        .word RemoveEnemy_ ; 0F - same as 4

EnemyDeathAnimIndex:
    .byte EnAnim_HoltzExplode - EnAnimTbl, EnAnim_HoltzExplode - EnAnimTbl ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzExplode - EnAnimTbl, EnAnim_HoltzExplode - EnAnimTbl ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaExplodeFloor - EnAnimTbl, EnAnim_DessgeegaExplodeFloor - EnAnimTbl ; 02 - dessgeegas
    .byte EnAnim_DessgeegaExplodeCeiling - EnAnimTbl, EnAnim_DessgeegaExplodeCeiling - EnAnimTbl ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaExplode - EnAnimTbl, EnAnim_ViolaExplode - EnAnimTbl ; 06 - crawler
    .byte EnAnim_ZebboExplodeFacingRight - EnAnimTbl, EnAnim_ZebboExplodeFacingLeft - EnAnimTbl ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyExplode - EnAnimTbl, EnAnim_RidleyExplode - EnAnimTbl ; 09 - ridley
    .byte EnAnim_RidleyFireballFacingRight - EnAnimTbl, EnAnim_RidleyFireballFacingLeft - EnAnimTbl ; 0A - ridley fireball
    .byte EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl ; 0B - same as 4
    .byte EnAnim_MultiviolaExplode - EnAnimTbl, EnAnim_MultiviolaExplode - EnAnimTbl ; 0C - bouncy orbs
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

EnemyHealthTbl:
    .byte $08 ; 00 - swooper has not seen samus
    .byte $08 ; 01 - swooper targetting samus
    .byte $08 ; 02 - dessgeegas
    .byte $08 ; 03 - ceiling dessgeegas
    .byte $01 ; 04 - disappears
    .byte $01 ; 05 - same as 4
    .byte $02 ; 06 - crawler
    .byte $01 ; 07 - zebbo
    .byte $01 ; 08 - same as 4
    .byte $8C ; 09 - ridley
    .byte $FF ; 0A - ridley fireball
    .byte $FF ; 0B - same as 4
    .byte $08 ; 0C - bouncy orbs
    .byte $06 ; 0D - same as 4
    .byte $FF ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

EnemyRestingAnimIndex:
    .byte EnAnim_HoltzIdle - EnAnimTbl, EnAnim_HoltzIdle - EnAnimTbl ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzIdle - EnAnimTbl, EnAnim_HoltzIdle - EnAnimTbl ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor - EnAnimTbl, EnAnim_DessgeegaIdleFloor - EnAnimTbl ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling - EnAnimTbl, EnAnim_DessgeegaIdleCeiling - EnAnimTbl ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor - EnAnimTbl, EnAnim_ViolaOnFloor - EnAnimTbl ; 06 - crawler
    .byte EnAnim_ZebboRestingFacingRight - EnAnimTbl, EnAnim_ZebboRestingFacingLeft - EnAnimTbl ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdleFacingRight - EnAnimTbl, EnAnim_RidleyIdleFacingLeft - EnAnimTbl ; 09 - ridley
    .byte EnAnim_RidleyFireballFacingRight - EnAnimTbl, EnAnim_RidleyFireballFacingLeft - EnAnimTbl ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle - EnAnimTbl, EnAnim_HoltzIdle - EnAnimTbl ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTbl, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl ; 0C - bouncy orbs
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

EnemyActiveAnimIndex:
    .byte EnAnim_HoltzSwooping - EnAnimTbl, EnAnim_HoltzSwooping - EnAnimTbl ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzSwooping - EnAnimTbl, EnAnim_HoltzSwooping - EnAnimTbl ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor - EnAnimTbl, EnAnim_DessgeegaIdleFloor - EnAnimTbl ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling - EnAnimTbl, EnAnim_DessgeegaIdleCeiling - EnAnimTbl ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor - EnAnimTbl, EnAnim_ViolaOnFloor - EnAnimTbl ; 06 - crawler
    .byte EnAnim_ZebboFacingRight - EnAnimTbl, EnAnim_ZebboFacingLeft - EnAnimTbl ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdleFacingRight - EnAnimTbl, EnAnim_RidleyIdleFacingLeft - EnAnimTbl ; 09 - ridley
    .byte EnAnim_RidleyFireballFacingRight - EnAnimTbl, EnAnim_RidleyFireballFacingLeft - EnAnimTbl ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle - EnAnimTbl, EnAnim_HoltzIdle - EnAnimTbl ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTbl, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTbl ; 0C - bouncy orbs
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

L967B:
    .byte $00 ; 00 - swooper has not seen samus
    .byte $00 ; 01 - swooper targetting samus
    .byte $00 ; 02 - dessgeegas
    .byte $00 ; 03 - ceiling dessgeegas
    .byte $00 ; 04 - disappears
    .byte $00 ; 05 - same as 4
    .byte $00 ; 06 - crawler
    .byte $00 ; 07 - zebbo
    .byte $00 | $80 ; 08 - same as 4
    .byte $00 ; 09 - ridley
    .byte $00 ; 0A - ridley fireball
    .byte $00 ; 0B - same as 4
    .byte $02 | $80 ; 0C - bouncy orbs
    .byte $00 ; 0D - same as 4
    .byte $00 ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

L968B:
    .byte %10001001 ; 00 - swooper has not seen samus
    .byte %10001001 ; 01 - swooper targetting samus
    .byte %10001001 ; 02 - dessgeegas
    .byte %10001001 ; 03 - ceiling dessgeegas
    .byte %00000000 ; 04 - disappears
    .byte %00000000 ; 05 - same as 4
    .byte %00000100 ; 06 - crawler
    .byte %10000000 ; 07 - zebbo
    .byte %10000000 ; 08 - same as 4
    .byte %10000001 ; 09 - ridley
    .byte %00000000 ; 0A - ridley fireball
    .byte %00000000 ; 0B - same as 4
    .byte %00000101 ; 0C - bouncy orbs
    .byte %10001001 ; 0D - same as 4
    .byte %00000000 ; 0E - polyp (unused)
    .byte %00000000 ; 0F - same as 4

EnemyForceSpeedTowardsSamusDelayTbl:
    .byte $01 ; 00 - swooper has not seen samus
    .byte $01 ; 01 - swooper targetting samus
    .byte $01 ; 02 - dessgeegas
    .byte $01 ; 03 - ceiling dessgeegas
    .byte $01 ; 04 - disappears
    .byte $01 ; 05 - same as 4
    .byte $01 ; 06 - crawler
    .byte $01 ; 07 - zebbo
    .byte $28 ; 08 - same as 4
    .byte $10 ; 09 - ridley
    .byte $00 ; 0A - ridley fireball
    .byte $00 ; 0B - same as 4
    .byte $00 ; 0C - bouncy orbs
    .byte $01 ; 0D - same as 4
    .byte $00 ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

EnemyDistanceToSamusThreshold:
    .byte $5 | (0 << 7) ; 00 - swooper has not seen samus
    .byte $5 | (0 << 7) ; 01 - swooper targetting samus
    .byte $00 ; 02 - dessgeegas
    .byte $00 ; 03 - ceiling dessgeegas
    .byte $00 ; 04 - disappears
    .byte $00 ; 05 - same as 4
    .byte $00 ; 06 - crawler
    .byte $00 ; 07 - zebbo
    .byte $00 ; 08 - same as 4
    .byte $00 ; 09 - ridley
    .byte $00 ; 0A - ridley fireball
    .byte $00 ; 0B - same as 4
    .byte $00 ; 0C - bouncy orbs
    .byte $6 | (1 << 7) ; 0D - same as 4
    .byte $00 ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

EnemyInitDelayTbl:
    .byte $10 ; 00 - swooper has not seen samus
    .byte $01 ; 01 - swooper targetting samus
    .byte $03 ; 02 - dessgeegas
    .byte $03 ; 03 - ceiling dessgeegas
    .byte $10 ; 04 - disappears
    .byte $10 ; 05 - same as 4
    .byte $01 ; 06 - crawler
    .byte $08 ; 07 - zebbo
    .byte $09 ; 08 - same as 4
    .byte $10 ; 09 - ridley
    .byte $01 ; 0A - ridley fireball
    .byte $10 ; 0B - same as 4
    .byte $01 ; 0C - bouncy orbs
    .byte $20 ; 0D - same as 4
    .byte $00 ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice_HoltzIdle - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_HoltzAttacking - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_DessgeegaFloor - EnemyMovementChoices ; 02 - dessgeegas
    .byte EnemyMovementChoice_DessgeegaCeiling - EnemyMovementChoices ; 03 - ceiling dessgeegas
    .byte $00 ; 04 - disappears
    .byte $00 ; 05 - same as 4
    .byte EnemyMovementChoice_Zebbo - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Zebbo - EnemyMovementChoices ; 07 - zebbo
    .byte $00 ; 08 - same as 4
    .byte EnemyMovementChoice_Ridley - EnemyMovementChoices ; 09 - ridley
    .byte EnemyMovementChoice_RidleyFireball - EnemyMovementChoices ; 0A - ridley fireball
    .byte EnemyMovementChoice06 - EnemyMovementChoices ; 0B - same as 4
    .byte EnemyMovementChoice_Multiviola - EnemyMovementChoices ; 0C - bouncy orbs
    .byte EnemyMovementChoice08 - EnemyMovementChoices ; 0D - same as 4
    .byte EnemyMovementChoice_HoltzIdle - EnemyMovementChoices ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

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
    .word $0000, $0000
    .word $0000, $0000

EnAccelYTable:
    .byte $80, $80, $00, $00, $7F, $7F, $81, $81, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
EnSpeedYTable:
    .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9, $FD, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01, $01, $00, $00, $00, $03, $00, $00, $00

L977B:
    .byte %01001100 ; 00 - swooper has not seen samus
    .byte %01001100 ; 01 - swooper targetting samus
    .byte %01100100 ; 02 - dessgeegas
    .byte %01101100 ; 03 - ceiling dessgeegas
    .byte %00000000 ; 04 - disappears
    .byte %00000000 ; 05 - same as 4
    .byte %00000000 ; 06 - crawler (enemy moves manually)
    .byte %01000000 ; 07 - zebbo
    .byte %00000000 ; 08 - same as 4
    .byte %01100100 ; 09 - ridley
    .byte %01000100 ; 0A - ridley fireball
    .byte %01000100 ; 0B - same as 4
    .byte %01000000 ; 0C - bouncy orbs
    .byte %00000000 ; 0D - same as 4
    .byte %00000000 ; 0E - polyp (unused)
    .byte %00000000 ; 0F - same as 4

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_34 - EnAnimTbl, EnAnim_34 - EnAnimTbl
    .byte EnAnim_DessgeegaIdleCeiling - EnAnimTbl, EnAnim_ViolaOnFloor - EnAnimTbl
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
EnemyMovementChoice_DessgeegaFloor:
    EnemyMovementChoiceEntry $04, $05
EnemyMovementChoice_DessgeegaCeiling:
    EnemyMovementChoiceEntry $06, $07
EnemyMovementChoice02: ; not assigned to any enemy
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Zebbo: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Ridley:
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice_RidleyFireball:
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice06: ; unused enemy
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice08: ; unused enemy
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_HoltzIdle:
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_HoltzAttacking:
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
RemoveEnemy_:
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

StoreEnemyPositionToTemp_:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

LoadEnemyPositionFromTemp_:
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x
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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS"
    .include "songs/ntsc/ridley.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/ridley.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS"
    .include "songs/ntsc/kraid.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/kraid.asm"
.endif

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS"
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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS"
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

