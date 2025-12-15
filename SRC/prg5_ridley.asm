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

; 8D60 - Common Room Elements (loaded everywhere except Tourian)
GFX_CREBG1:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_CRE.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/bg_CRE_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $450, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "common_chr/bg_CRE_cnsus.chr"
    .endif

; 91B0 - Game over, Japanese font tiles (only loaded in Tourian?)
GFX_TourianFont:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        .incbin "tourian/font_chr.chr"
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "tourian/font_chr_cnsus.chr"
    .endif

;Unused tile patterns.
GFX_Bank5Garbage:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        .incbin "tourian/font_chr.chr" skip $250
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "tourian/font_chr_cnsus.chr" skip $250
    .endif

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntryBank PalPntrTbl, Palette00                 ;($A0EB)Default room palette.
    PtrTableEntryBank PalPntrTbl, Palette01                 ;($A10F)Samus power suit palette.
    PtrTableEntryBank PalPntrTbl, Palette02                 ;($A11B)Samus varia suit palette.
    PtrTableEntryBank PalPntrTbl, Palette03                 ;($A115)Samus power suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette04                 ;($A121)Samus varia suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette05                 ;($A127)Alternate room palette.
    PtrTableEntryBank PalPntrTbl, Palette06                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette07                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette08                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette09                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0A                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0B                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0C                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0D                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0E                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette0F                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette10                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette11                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette12                 ;($A13B)
    PtrTableEntryBank PalPntrTbl, Palette13                 ;($A13B)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryBank PalPntrTbl, Palette14                 ;($A142)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette15                 ;($A149)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette16                 ;($A150)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette17                 ;($A157)Unused?
    PtrTableEntryBank PalPntrTbl, Palette18                 ;($A15F)Suitless Samus power suit palette.
    PtrTableEntryBank PalPntrTbl, Palette19                 ;($A167)Suitless Samus varia suit palette.
    PtrTableEntryBank PalPntrTbl, Palette1A                 ;($A16F)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette1B                 ;($A177)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_BANK{BANK}               ;($A20D)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_BANK{BANK}              ;($A17F)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_BANK{BANK}            ;($A1D3)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_BANK{BANK}              ;($AB23)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_BANK{BANK}          ;($9BF0)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_BANK{BANK}          ;($9CF0)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_BANK{BANK}           ;($9D04)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_BANK{BANK}               ;($9B85)Index to values in addr tables for enemy animations.
.ENDST

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
    jmp RTS_Polyp_BANK{BANK}                       ;Area specific routine.

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
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_BANK{BANK} - EnAnimTable_BANK{BANK}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_BANK{BANK} - EnAnimTable_BANK{BANK}

    .byte EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
AreaEnProjectileFallingAnimIndex:
    .byte EnAnim_DessgeegaCeilingHopping_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
AreaEnProjectileSplatterAnimIndex:
    .byte EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_36_BANK{BANK} - EnAnimTable_BANK{BANK}
AreaMellowAnimIndex:
    .byte EnAnim_Mella_BANK{BANK} - EnAnimTable_BANK{BANK}

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine00_BANK{BANK} ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01_BANK{BANK} ; 01 - swooper targetting samus
        .word SidehopperFloorAIRoutine_BANK{BANK} ; 02 - dessgeegas
        .word SidehopperCeilingAIRoutine_BANK{BANK} ; 03 - ceiling dessgeegas
        .word RemoveEnemy__BANK{BANK} ; 04 - disappears
        .word RemoveEnemy__BANK{BANK} ; 05 - same as 4
        .word CrawlerAIRoutine_BANK{BANK} ; 06 - crawler
        .word PipeBugAIRoutine_BANK{BANK} ; 07 - zebbo
        .word RemoveEnemy__BANK{BANK} ; 08 - same as 4
        .word RidleyAIRoutine_BANK{BANK} ; 09 - ridley
        .word RidleyFireballAIRoutine_BANK{BANK} ; 0A - ridley fireball
        .word RemoveEnemy__BANK{BANK} ; 0B - same as 4
        .word MultiviolaAIRoutine_BANK{BANK} ; 0C - bouncy orbs
        .word RemoveEnemy__BANK{BANK} ; 0D - same as 4
        .word PolypAIRoutine_BANK{BANK} ; 0E - polyp (unused)
        .word RemoveEnemy__BANK{BANK} ; 0F - same as 4

EnemyDeathAnimIndex:
    .byte EnAnim_HoltzExplode_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzExplode_BANK{BANK} - EnAnimTable_BANK{BANK} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzExplode_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzExplode_BANK{BANK} - EnAnimTable_BANK{BANK} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaExplodeFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaExplodeFloor_BANK{BANK} - EnAnimTable_BANK{BANK} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaExplodeCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaExplodeCeiling_BANK{BANK} - EnAnimTable_BANK{BANK} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaExplode_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaExplode_BANK{BANK} - EnAnimTable_BANK{BANK} ; 06 - crawler
    .byte EnAnim_ZebboExplode_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ZebboExplode_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyExplode_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyExplode_BANK{BANK} - EnAnimTable_BANK{BANK} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyFireball_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0A - ridley fireball
    .byte EnAnim_MultiviolaSpinningCounterclockwise_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_MultiviolaSpinningCounterclockwise_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0B - same as 4
    .byte EnAnim_MultiviolaExplode_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_MultiviolaExplode_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0C - bouncy orbs
    .byte EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0D - same as 4
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
    .byte EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaIdleFloor_BANK{BANK} - EnAnimTable_BANK{BANK} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK} ; 06 - crawler
    .byte EnAnim_ZebboResting_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ZebboResting_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdle_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyIdle_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyFireball_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_MultiviolaSpinningCounterclockwise_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0C - bouncy orbs
    .byte EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

EnemyActiveAnimIndex:
    .byte EnAnim_HoltzSwooping_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzSwooping_BANK{BANK} - EnAnimTable_BANK{BANK} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzSwooping_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzSwooping_BANK{BANK} - EnAnimTable_BANK{BANK} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaIdleFloor_BANK{BANK} - EnAnimTable_BANK{BANK} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK} ; 06 - crawler
    .byte EnAnim_Zebbo_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_Zebbo_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdle_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyIdle_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_RidleyFireball_L_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_HoltzIdle_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_MultiviolaSpinningCounterclockwise_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0C - bouncy orbs
    .byte EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK} ; 0D - same as 4
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
    .byte EnemyMovementChoice_HoltzIdle_BANK{BANK} - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_HoltzAttacking_BANK{BANK} - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_DessgeegaFloor_BANK{BANK} - EnemyMovementChoices ; 02 - dessgeegas
    .byte EnemyMovementChoice_DessgeegaCeiling_BANK{BANK} - EnemyMovementChoices ; 03 - ceiling dessgeegas
    .byte $00 ; 04 - disappears
    .byte $00 ; 05 - same as 4
    .byte EnemyMovementChoice_Zebbo_BANK{BANK} - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Zebbo_BANK{BANK} - EnemyMovementChoices ; 07 - zebbo
    .byte $00 ; 08 - same as 4
    .byte EnemyMovementChoice_Ridley_BANK{BANK} - EnemyMovementChoices ; 09 - ridley
    .byte EnemyMovementChoice_RidleyFireball_BANK{BANK} - EnemyMovementChoices ; 0A - ridley fireball
    .byte EnemyMovementChoice06_BANK{BANK} - EnemyMovementChoices ; 0B - same as 4
    .byte EnemyMovementChoice_Multiviola_BANK{BANK} - EnemyMovementChoices ; 0C - bouncy orbs
    .byte EnemyMovementChoice08_BANK{BANK} - EnemyMovementChoices ; 0D - same as 4
    .byte EnemyMovementChoice_HoltzIdle_BANK{BANK} - EnemyMovementChoices ; 0E - polyp (unused)
    .byte $00 ; 0F - same as 4

EnemyMovementPtrs:
    .word EnemyMovement00_R_BANK{BANK}, EnemyMovement00_L_BANK{BANK}
    .word EnemyMovement01_R_BANK{BANK}, EnemyMovement01_L_BANK{BANK}
    .word EnemyMovement02_R_BANK{BANK}, EnemyMovement02_L_BANK{BANK}
    .word EnemyMovement03_R_BANK{BANK}, EnemyMovement03_L_BANK{BANK}
    .word EnemyMovement04_R_BANK{BANK}, EnemyMovement04_L_BANK{BANK}
    .word EnemyMovement05_R_BANK{BANK}, EnemyMovement05_L_BANK{BANK}
    .word EnemyMovement06_R_BANK{BANK}, EnemyMovement06_L_BANK{BANK}
    .word EnemyMovement07_R_BANK{BANK}, EnemyMovement07_L_BANK{BANK}
    .word EnemyMovement08_R_BANK{BANK}, EnemyMovement08_L_BANK{BANK}
    .word EnemyMovement09_R_BANK{BANK}, EnemyMovement09_L_BANK{BANK}
    .word EnemyMovement0A_R_BANK{BANK}, EnemyMovement0A_L_BANK{BANK}
    .word EnemyMovement0B_R_BANK{BANK}, EnemyMovement0B_L_BANK{BANK}
    .word EnemyMovement0C_R_BANK{BANK}, EnemyMovement0C_L_BANK{BANK}
    .word EnemyMovement0D_R_BANK{BANK}, EnemyMovement0D_L_BANK{BANK}
    .word EnemyMovement0E_R_BANK{BANK}, EnemyMovement0E_L_BANK{BANK}
    .word EnemyMovement0F_R_BANK{BANK}, EnemyMovement0F_L_BANK{BANK}
    .word EnemyMovement10_R_BANK{BANK}, EnemyMovement10_L_BANK{BANK}
    .word EnemyMovement11_R_BANK{BANK}, EnemyMovement11_L_BANK{BANK}
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

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_34_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_DessgeegaIdleCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}, EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
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

EnProjectileMovementPtrTable:
    .word EnProjectileMovement0_BANK{BANK}
    .word EnProjectileMovement1_BANK{BANK}
    .word EnProjectileMovement2_BANK{BANK}
    .word EnProjectileMovement3_BANK{BANK}

TileBlastFramePtrTable:
    .word TileBlastFrame00_BANK{BANK}
    .word TileBlastFrame01_BANK{BANK}
    .word TileBlastFrame02_BANK{BANK}
    .word TileBlastFrame03_BANK{BANK}
    .word TileBlastFrame04_BANK{BANK}
    .word TileBlastFrame05_BANK{BANK}
    .word TileBlastFrame06_BANK{BANK}
    .word TileBlastFrame07_BANK{BANK}
    .word TileBlastFrame08_BANK{BANK}
    .word TileBlastFrame09_BANK{BANK}
    .word TileBlastFrame0A_BANK{BANK}
    .word TileBlastFrame0B_BANK{BANK}
    .word TileBlastFrame0C_BANK{BANK}
    .word TileBlastFrame0D_BANK{BANK}
    .word TileBlastFrame0E_BANK{BANK}
    .word TileBlastFrame0F_BANK{BANK}
    .word TileBlastFrame10_BANK{BANK}

EnemyMovementChoices:
EnemyMovementChoice_DessgeegaFloor_BANK{BANK}:
    EnemyMovementChoiceEntry $04, $05
EnemyMovementChoice_DessgeegaCeiling_BANK{BANK}:
    EnemyMovementChoiceEntry $06, $07
EnemyMovementChoice02_BANK{BANK}: ; not assigned to any enemy
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Zebbo_BANK{BANK}: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Ridley_BANK{BANK}:
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice_RidleyFireball_BANK{BANK}:
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice06_BANK{BANK}: ; unused enemy
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola_BANK{BANK}:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice08_BANK{BANK}: ; unused enemy
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_HoltzIdle_BANK{BANK}:
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_HoltzAttacking_BANK{BANK}:
    EnemyMovementChoiceEntry $01

EnemyMovement00_R_BANK{BANK}:
EnemyMovement00_L_BANK{BANK}:
EnemyMovement01_R_BANK{BANK}:
EnemyMovement01_L_BANK{BANK}:
    ; nothing

; unused (ripper)
EnemyMovement02_R_BANK{BANK}:
    SignMagSpeed $01,  3,  0
    EnemyMovementInstr_Restart

EnemyMovement02_L_BANK{BANK}:
    SignMagSpeed $01, -3,  0
    EnemyMovementInstr_Restart

EnemyMovement03_R_BANK{BANK}:
EnemyMovement03_L_BANK{BANK}:
EnemyMovement04_R_BANK{BANK}:
EnemyMovement04_L_BANK{BANK}:
EnemyMovement05_R_BANK{BANK}:
EnemyMovement05_L_BANK{BANK}:
EnemyMovement06_R_BANK{BANK}:
EnemyMovement06_L_BANK{BANK}:
EnemyMovement07_R_BANK{BANK}:
EnemyMovement07_L_BANK{BANK}:
EnemyMovement08_R_BANK{BANK}:
EnemyMovement08_L_BANK{BANK}:
EnemyMovement09_R_BANK{BANK}:
EnemyMovement09_L_BANK{BANK}:
EnemyMovement0A_R_BANK{BANK}:
EnemyMovement0A_L_BANK{BANK}:
EnemyMovement0B_R_BANK{BANK}:
EnemyMovement0B_L_BANK{BANK}:
EnemyMovement0C_R_BANK{BANK}:
EnemyMovement0C_L_BANK{BANK}:
EnemyMovement0D_R_BANK{BANK}:
EnemyMovement0D_L_BANK{BANK}:
EnemyMovement0E_R_BANK{BANK}:
EnemyMovement0E_L_BANK{BANK}:
EnemyMovement0F_R_BANK{BANK}:
EnemyMovement0F_L_BANK{BANK}:
EnemyMovement10_R_BANK{BANK}:
EnemyMovement10_L_BANK{BANK}:
    ; nothing

; unused (dragon)
EnemyMovement11_R_BANK{BANK}:
EnemyMovement11_L_BANK{BANK}:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementDragon

EnProjectileMovement0_BANK{BANK}:
EnProjectileMovement1_BANK{BANK}:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement2_BANK{BANK}:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement3_BANK{BANK}:
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

;-------------------------------------------------------------------------------
RemoveEnemy__BANK{BANK}:
    lda #$00
    sta EnsExtra.0.status,x
    rts

CommonEnemyJump_00_01_02_BANK{BANK}:
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

StoreEnemyPositionToTemp__BANK{BANK}:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

LoadEnemyPositionFromTemp__BANK{BANK}:
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

TileBlastFrame00_BANK{BANK}:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01_BANK{BANK}:
    .byte $22
    .byte $80, $81
    .byte $82, $83

TileBlastFrame02_BANK{BANK}:
    .byte $22
    .byte $84, $85
    .byte $86, $87

TileBlastFrame03_BANK{BANK}:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

TileBlastFrame04_BANK{BANK}:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

TileBlastFrame05_BANK{BANK}:
    .byte $22
    .byte $94, $95
    .byte $96, $97

TileBlastFrame06_BANK{BANK}:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

TileBlastFrame07_BANK{BANK}:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

TileBlastFrame08_BANK{BANK}:
    .byte $22
    .byte $90, $91
    .byte $92, $93

TileBlastFrame09_BANK{BANK}:
    .byte $22
    .byte $70, $71
    .byte $72, $73

TileBlastFrame0A_BANK{BANK}:
    .byte $22
    .byte $74, $75
    .byte $76, $77

TileBlastFrame0B_BANK{BANK}:
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

TileBlastFrame0C_BANK{BANK}:
TileBlastFrame0D_BANK{BANK}:
TileBlastFrame0E_BANK{BANK}:
TileBlastFrame0F_BANK{BANK}:
TileBlastFrame10_BANK{BANK}:
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

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "ridley/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/ridley.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/ridley.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/kraid.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/kraid.asm"
.endif

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
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
    .byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00
    
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        .incbin "tourian/bg_chr.chr" skip $500 read $60
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "tourian/bg_chr.chr" skip $500 read $10
        .incbin "tourian/bg_chr_cnsus.chr" skip $510 read $50
    .endif

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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
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

