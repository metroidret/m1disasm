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
.redef AREA = {"BANK{BANK}"}
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

PalettePtrTable:
    PtrTableEntryArea PalettePtrTable, Palette00                 ;($A0EB)Default room palette.
    PtrTableEntryArea PalettePtrTable, Palette01                 ;($A10F)Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette02                 ;($A11B)Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette03                 ;($A115)Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette04                 ;($A121)Samus varia suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette05                 ;($A127)Alternate room palette.
    PtrTableEntryArea PalettePtrTable, Palette06                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette07                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette08                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette09                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0A                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0B                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0C                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0D                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0E                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette0F                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette10                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette11                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette12                 ;($A13B)
    PtrTableEntryArea PalettePtrTable, Palette13                 ;($A13B)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryArea PalettePtrTable, Palette14                 ;($A142)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette15                 ;($A149)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette16                 ;($A150)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette17                 ;($A157)Unused?
    PtrTableEntryArea PalettePtrTable, Palette18                 ;($A15F)Suitless Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette19                 ;($A167)Suitless Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette1A                 ;($A16F)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette1B                 ;($A177)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_{AREA}               ;($A20D)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_{AREA}              ;($A17F)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_{AREA}            ;($A1D3)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_{AREA}              ;($AB23)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_{AREA}          ;($9BF0)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_{AREA}          ;($9CF0)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_{AREA}           ;($9D04)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_{AREA}               ;($9B85)Index to values in addr tables for enemy animations.
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
    jmp RTS_Polyp_{AREA}                       ;Area specific routine.

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

AreaPaletteToggle:
    .byte _id_Palette05+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}

    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileFallingAnimIndex:
    .byte EnAnim_DessgeegaCeilingHopping_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileSplatterAnimIndex:
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_36_{AREA} - EnAnimTable_{AREA}
AreaMellowAnimIndex:
    .byte EnAnim_Mella_{AREA} - EnAnimTable_{AREA}

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_JumpEngine
        .word SwooperAIRoutine00_{AREA} ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01_{AREA} ; 01 - swooper targetting samus
        .word SidehopperFloorAIRoutine_{AREA} ; 02 - dessgeegas
        .word SidehopperCeilingAIRoutine_{AREA} ; 03 - ceiling dessgeegas
        .word RemoveEnemy__{AREA} ; 04 - disappears
        .word RemoveEnemy__{AREA} ; 05 - same as 4
        .word CrawlerAIRoutine_{AREA} ; 06 - crawler
        .word PipeBugAIRoutine_{AREA} ; 07 - zebbo
        .word RemoveEnemy__{AREA} ; 08 - same as 4
        .word RidleyAIRoutine_{AREA} ; 09 - ridley
        .word RidleyFireballAIRoutine_{AREA} ; 0A - ridley fireball
        .word RemoveEnemy__{AREA} ; 0B - same as 4
        .word MultiviolaAIRoutine_{AREA} ; 0C - bouncy orbs
        .word RemoveEnemy__{AREA} ; 0D - same as 4
        .word PolypAIRoutine_{AREA} ; 0E - polyp (unused)
        .word RemoveEnemy__{AREA} ; 0F - same as 4

EnemyDeathAnimIndex:
    .byte EnAnim_HoltzExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzExplode_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzExplode_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaExplodeFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaExplodeFloor_{AREA} - EnAnimTable_{AREA} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaExplodeCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaExplodeCeiling_{AREA} - EnAnimTable_{AREA} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaExplode_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_ZebboExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_ZebboExplode_L_{AREA} - EnAnimTable_{AREA} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyExplode_{AREA} - EnAnimTable_{AREA} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - ridley fireball
    .byte EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA} ; 0B - same as 4
    .byte EnAnim_MultiviolaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaExplode_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orbs
    .byte EnAnim_34_{AREA} - EnAnimTable_{AREA}, EnAnim_34_{AREA} - EnAnimTable_{AREA} ; 0D - same as 4
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
    .byte EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaIdleFloor_{AREA} - EnAnimTable_{AREA} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_ZebboResting_R_{AREA} - EnAnimTable_{AREA}, EnAnim_ZebboResting_L_{AREA} - EnAnimTable_{AREA} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyIdle_L_{AREA} - EnAnimTable_{AREA} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA} ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orbs
    .byte EnAnim_34_{AREA} - EnAnimTable_{AREA}, EnAnim_34_{AREA} - EnAnimTable_{AREA} ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

EnemyActiveAnimIndex:
    .byte EnAnim_HoltzSwooping_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzSwooping_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_HoltzSwooping_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzSwooping_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_DessgeegaIdleFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaIdleFloor_{AREA} - EnAnimTable_{AREA} ; 02 - dessgeegas
    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA} ; 03 - ceiling dessgeegas
    .byte $00, $00 ; 04 - disappears
    .byte $00, $00 ; 05 - same as 4
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_Zebbo_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Zebbo_L_{AREA} - EnAnimTable_{AREA} ; 07 - zebbo
    .byte $00, $00 ; 08 - same as 4
    .byte EnAnim_RidleyIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyIdle_L_{AREA} - EnAnimTable_{AREA} ; 09 - ridley
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - ridley fireball
    .byte EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA} ; 0B - same as 4
    .byte EnAnim_MultiviolaSpinningClockwise_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orbs
    .byte EnAnim_34_{AREA} - EnAnimTable_{AREA}, EnAnim_34_{AREA} - EnAnimTable_{AREA} ; 0D - same as 4
    .byte $00, $00 ; 0E - polyp (unused)
    .byte $00, $00 ; 0F - same as 4

EnemyActiveAnimIndexInitOffset:
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

EnemyMovementPtrs:
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
    .byte EnAnim_34_{AREA} - EnAnimTable_{AREA}, EnAnim_34_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
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
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

VRAMStringPtrTable:
    PtrTableEntryArea VRAMStringPtrTable, VRAMString00
    PtrTableEntryArea VRAMStringPtrTable, VRAMString01
    PtrTableEntryArea VRAMStringPtrTable, VRAMString02
    PtrTableEntryArea VRAMStringPtrTable, VRAMString03
    PtrTableEntryArea VRAMStringPtrTable, VRAMString04
    PtrTableEntryArea VRAMStringPtrTable, VRAMString05
    PtrTableEntryArea VRAMStringPtrTable, VRAMString06
    PtrTableEntryArea VRAMStringPtrTable, VRAMString07
    PtrTableEntryArea VRAMStringPtrTable, VRAMString08
    PtrTableEntryArea VRAMStringPtrTable, VRAMString09
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0A
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0B
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0C
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0D
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0E
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0F
    PtrTableEntryArea VRAMStringPtrTable, VRAMString10

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
    EnemyMovementInstr_TriggerResting

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

;-------------------------------------------------------------------------------
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

StoreEnemyPositionToTemp__{AREA}:
    lda Ens.0.y,x
    sta Temp08_PositionY
    lda Ens.0.x,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

LoadEnemyPositionFromTemp__{AREA}:
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x
    lda Temp08_PositionY
    sta Ens.0.y,x
    lda Temp09_PositionX
    sta Ens.0.x,x
    rts

;-------------------------------------------------------------------------------
; Bouncy Orb Routine
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
.include "enemies/polyp.asm"

;-------------------------------------------------------------------------------

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

;Not used.
    .byte $11, $11, $11, $04, $11, $11, $11, $11, $FF, $08, $20, $22, $22, $22, $22, $22
    .byte $22, $22, $FF, $01, $1F, $FF, $01, $21, $01, $21, $01, $21, $FF, $08, $23, $23
    .byte $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24, $24, $23, $08
    .byte $23, $23, $23, $23, $23, $23, $23, $23, $FF, $01, $23, $01, $23, $01, $23, $01
    .byte $23, $FF, $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24
    .byte $23, $04, $23, $23, $23, $23, $FF, $01, $25, $FF, $01, $26, $01, $26, $01, $26
    .byte $01, $26, $FF, $03, $27, $27, $27, $FF, $03, $28, $28, $28, $FF, $08, $13, $13
    .byte $13, $13, $13, $13, $13, $13, $FF, $01, $13, $01, $13, $01, $13, $01, $13, $FF
    .byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF, $F1, $F1, $F1, $F1, $FF
    .byte $FF, $F0, $F0, $64, $64, $64, $64, $FF, $FF, $64, $64, $A4, $FF, $A4, $FF, $FF
    .byte $A5, $FF, $A5, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $4F, $4F, $4F, $4F, $84
    .byte $85, $86, $87, $88, $89, $8A, $8B, $80, $81, $82, $83, $FF, $FF, $BA, $BA, $BB
    .byte $BB, $BB, $BB, $10, $11, $12, $13, $04, $05, $06, $07, $14, $15, $16, $17, $1C
    .byte $1D, $1E, $1F, $09, $09, $09, $09, $0C, $0D, $0E, $0F, $FF, $FF, $59, $5A, $FF
    .byte $FF, $5A, $5B, $51, $52, $53, $54, $55, $56, $57, $58, $EC, $FF, $ED, $FF, $FF
    .byte $EE, $FF, $EF, $45, $46, $45, $46, $4B, $4C, $4D, $50, $FF, $FF, $FF, $FF, $47
    .byte $48, $47, $48, $08, $08, $08, $08, $70, $71, $72, $73, $74, $75, $76, $77, $E0
    .byte $E1, $E2, $E3, $E4, $E5, $E6, $E7, $20, $21, $22, $23, $25, $25, $24, $24, $78
    .byte $79, $7A, $7B, $E8, $E9, $EA, $EB, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $0D
    .byte $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15, $21
    .byte $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F, $0D
    .byte $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21, $1C
    .byte $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C, $1C
    .byte $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF, $02
    .byte $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01, $21
    .byte $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22, $22
    .byte $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21, $11
    .byte $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF, $01
    .byte $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D, $22
    .byte $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21, $08
    .byte $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22, $20
    .byte $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17, $17
    .byte $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08, $18
    .byte $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C, $1F
    .byte $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18, $18
    .byte $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07, $0D
    .byte $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07, $0D
    .byte $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01
    .byte $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01, $18
    .byte $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14, $04
    .byte $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF, $08
    .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10, $0E
    .byte $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF, $FF
    .byte $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F, $4F
    .byte $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10, $11
    .byte $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C, $1D
    .byte $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A, $2C
    .byte $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28, $28
    .byte $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B, $2B
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D, $3E
    .byte $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B, $0B
    .byte $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56, $57
    .byte $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D, $62
    .byte $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F, $70
    .byte $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49, $4A
    .byte $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18, $19
    .byte $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D, $0D
    .byte $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33, $FF
    .byte $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B, $3E
    .byte $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89, $8A
    .byte $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8, $B9
    .byte $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14, $15
    .byte $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13, $BC
    .byte $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF, $BA
    .byte $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF, $08
    .byte $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C, $4D
    .byte $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12, $FF
    .byte $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00, $BC
    .byte $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93
;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif

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
    .section "ROM Bank $005 - Sound Engine" bank 5 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $005 - Sound Engine" bank 5 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "sound_engine.asm"

.ends

;-----------------------------------------------[ RESET ]--------------------------------------------

.section "ROM Bank $005 - Reset" bank 5 slot "ROMSwitchSlot" orga $BFB0 force

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $005 - Vectors" bank 5 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

