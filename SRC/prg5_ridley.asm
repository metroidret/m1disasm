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
GFX_CREBG1: ; 05:8D60
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_CRE.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $450, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/bg_CRE_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/bg_CRE_cns.chr"
    .endif

; 91B0 - Game over, Japanese font tiles (only loaded in Tourian?)
GFX_TourianFont: ; 05:91B0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G"
        .incbin "tourian/font_chr.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "tourian/font_chr_cns.chr"
    .endif

;Unused tile patterns.
Garbage_05_94B0: ; 05:94B0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G"
        .incbin "garbage/05_94B0.bin"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "garbage/05_94B0_cns.bin"
    .endif

;----------------------------------------------------------------------------------------------------

PalettePtrTable: ; 05:9560
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

SpecItmsTblPtr: ; 05:9598
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

AreaRoutine: ; 05:95C3
    jmp RTS_Polyp_{AREA}                       ;Area specific routine.

;The following routine returns the two's complement of the value stored in A.
TwosComplement_: ; 05:95C6
    eor #$FF
    clc
    adc #$01
    rts

L95CC: ; 05:95CC
    .byte $12                       ;Ridley's room.
AreaMusicFlag: ; 05:95CD
    .byte music_RidleyArea          ;Ridley hideout music init flag.
AreaEnemyDamage: ; 05:95CE
    .word $0240                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers: ; 05:95D0
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

AreaMapPosX: ; 05:95D7
    .byte $19   ;Samus start x coord on world map.
AreaMapPosY: ; 05:95D8
    .byte $18   ;Samus start y coord on world map.
AreaSamusY: ; 05:95D9
    .byte $6E   ;Samus start vertical screen position.

AreaPaletteToggle: ; 05:95DA
    .byte _id_Palette05+1

    .byte $00
AreaEnProjectileKilledAnimIndex: ; 05:95DC
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex: ; 05:95DD
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}

    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileFallingAnimIndex: ; 05:95E0
    .byte EnAnim_DessgeegaCeilingHopping_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileSplatterAnimIndex: ; 05:95E2
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_36_{AREA} - EnAnimTable_{AREA}
AreaMellowAnimIndex: ; 05:95E4
    .byte EnAnim_Mella_{AREA} - EnAnimTable_{AREA}

ChooseEnemyAIRoutine: ; 05:95E5
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

EnemyDeathAnimIndex: ; 05:960B
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

EnemyHealthTbl: ; 05:962B
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

EnemyRestingAnimIndex: ; 05:963B
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

EnemyActiveAnimIndex: ; 05:965B
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

EnemyActiveAnimIndexInitOffset: ; 05:967B
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

L968B: ; 05:968B
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

EnemyForceSpeedTowardsSamusDelayTbl: ; 05:969B
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

EnemyDistanceToSamusThreshold: ; 05:96AB
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

EnemyInitDelayTbl: ; 05:96BB
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

EnemyMovementChoiceOffset: ; 05:96CB
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

EnemyMovementPtrs: ; 05:96DB
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

EnAccelYTable: ; 05:972B
    .byte $80, $80, $00, $00, $7F, $7F, $81, $81, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable: ; 05:973F
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
EnSpeedYTable: ; 05:9753
    .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9, $FD, $00, $00, $00
EnSpeedXTable: ; 05:9767
    .byte $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01, $01, $00, $00, $00, $03, $00, $00, $00

L977B: ; 05:977B
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

EnProjectileRisingAnimIndexTable: ; 05:978B
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_34_{AREA} - EnAnimTable_{AREA}, EnAnim_34_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_DessgeegaIdleCeiling_{AREA} - EnAnimTable_{AREA}, EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetX: ; 05:979B
    .byte $08, $F8
    .byte $00, $00
    .byte $00, $00
    .byte $08, $F8
EnProjectilePosOffsetY: ; 05:97A3
    .byte $00
    .byte $00
    .byte $00
    .byte $F8

EnProjectileMovementPtrTable: ; 05:97A7
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

VRAMStringPtrTable: ; 05:97AF
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

EnemyMovementChoices: ; 05:97D1
EnemyMovementChoice_DessgeegaFloor_{AREA}: ; 05:97D1
    EnemyMovementChoiceEntry $04, $05

EnemyMovementChoice_DessgeegaCeiling_{AREA}: ; 05:97D4
    EnemyMovementChoiceEntry $06, $07

EnemyMovementChoice02_{AREA}: ; 05:97D7
    ; not assigned to any enemy
    EnemyMovementChoiceEntry $02

EnemyMovementChoice_Zebbo_{AREA}: ; 05:97D9
    ; enemy moves manually
    EnemyMovementChoiceEntry $09

EnemyMovementChoice_Ridley_{AREA}: ; 05:97DB
    EnemyMovementChoiceEntry $0D

EnemyMovementChoice_RidleyFireball_{AREA}: ; 05:97DD
    EnemyMovementChoiceEntry $0E, $0F

EnemyMovementChoice06_{AREA}: ; 05:97E0
    ; unused enemy
    EnemyMovementChoiceEntry $00, $01, $02, $03

EnemyMovementChoice_Multiviola_{AREA}: ; 05:97E5
    EnemyMovementChoiceEntry $10

EnemyMovementChoice08_{AREA}: ; 05:97E7
    ; unused enemy
    EnemyMovementChoiceEntry $11

EnemyMovementChoice_HoltzIdle_{AREA}: ; 05:97E9
    EnemyMovementChoiceEntry $00

EnemyMovementChoice_HoltzAttacking_{AREA}: ; 05:97EB
    EnemyMovementChoiceEntry $01


EnemyMovement00_R_{AREA}: ; 05:97ED
EnemyMovement00_L_{AREA}: ; 05:97ED
EnemyMovement01_R_{AREA}: ; 05:97ED
EnemyMovement01_L_{AREA}: ; 05:97ED
    ; nothing

; unused (ripper)
EnemyMovement02_R_{AREA}: ; 05:97ED
    SignMagSpeed $01,  3,  0
    EnemyMovementInstr_Restart

EnemyMovement02_L_{AREA}: ; 05:97F0
    SignMagSpeed $01, -3,  0
    EnemyMovementInstr_Restart

EnemyMovement03_R_{AREA}: ; 05:97F3
EnemyMovement03_L_{AREA}: ; 05:97F3
EnemyMovement04_R_{AREA}: ; 05:97F3
EnemyMovement04_L_{AREA}: ; 05:97F3
EnemyMovement05_R_{AREA}: ; 05:97F3
EnemyMovement05_L_{AREA}: ; 05:97F3
EnemyMovement06_R_{AREA}: ; 05:97F3
EnemyMovement06_L_{AREA}: ; 05:97F3
EnemyMovement07_R_{AREA}: ; 05:97F3
EnemyMovement07_L_{AREA}: ; 05:97F3
EnemyMovement08_R_{AREA}: ; 05:97F3
EnemyMovement08_L_{AREA}: ; 05:97F3
EnemyMovement09_R_{AREA}: ; 05:97F3
EnemyMovement09_L_{AREA}: ; 05:97F3
EnemyMovement0A_R_{AREA}: ; 05:97F3
EnemyMovement0A_L_{AREA}: ; 05:97F3
EnemyMovement0B_R_{AREA}: ; 05:97F3
EnemyMovement0B_L_{AREA}: ; 05:97F3
EnemyMovement0C_R_{AREA}: ; 05:97F3
EnemyMovement0C_L_{AREA}: ; 05:97F3
EnemyMovement0D_R_{AREA}: ; 05:97F3
EnemyMovement0D_L_{AREA}: ; 05:97F3
EnemyMovement0E_R_{AREA}: ; 05:97F3
EnemyMovement0E_L_{AREA}: ; 05:97F3
EnemyMovement0F_R_{AREA}: ; 05:97F3
EnemyMovement0F_L_{AREA}: ; 05:97F3
EnemyMovement10_R_{AREA}: ; 05:97F3
EnemyMovement10_L_{AREA}: ; 05:97F3
    ; nothing

; unused (dragon)
EnemyMovement11_R_{AREA}: ; 05:97F3
EnemyMovement11_L_{AREA}: ; 05:97F3
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_TriggerResting

;-------------------------------------------------------------------------------

; unused
EnProjectileMovement0_{AREA}: ; 05:97FD
    ; nothing

; unused (polyp projectile long)
EnProjectileMovement1_{AREA}: ; 05:97FD
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

; unused (polyp projectile medium)
EnProjectileMovement2_{AREA}: ; 05:980C
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

; unused (polyp projectile short)
EnProjectileMovement3_{AREA}: ; 05:981B
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

;-------------------------------------------------------------------------------

RemoveEnemy__{AREA}: ; 05:982A
    lda #$00
    sta EnsExtra.0.status,x
    rts

UpdateEnemyCommon_Decide_{AREA}: ; 05:9830
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq @resting
    cmp #enemyStatus_Explode
    beq @explode
        ; enemy default
        lda $00
        jmp CommonJump_UpdateEnemyCommon
    @resting: ; 05:983F
        ; enemy resting
        lda $01
        jmp CommonJump_UpdateEnemyCommon_noMove
    @explode: ; 05:9844
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

StoreEnemyPositionToTemp__{AREA}: ; 05:9AE1
    lda Ens.0.y,x
    sta Temp08_PositionY
    lda Ens.0.x,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

LoadEnemyPositionFromTemp__{AREA}: ; 05:9AF1
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

; block 100% destroyed
VRAMString00_{AREA}: ; 05:9B49
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

; shot block (common)
VRAMString01_{AREA}: ; 05:9B4E
    .byte $22
    .byte $80, $81
    .byte $82, $83

; shot block (kraid terrain)
VRAMString02_{AREA}: ; 05:9B53
    .byte $22
    .byte $84, $85
    .byte $86, $87

; shot block (chozo orb)
VRAMString03_{AREA}: ; 05:9B58
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

; shot block (brinstar normal terrain)
VRAMString04_{AREA}: ; 05:9B5D
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

; shot block (brinstar lava terrain)
VRAMString05_{AREA}: ; 05:9B62
    .byte $22
    .byte $94, $95
    .byte $96, $97

; block 33% destroyed
VRAMString06_{AREA}: ; 05:9B67
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

; block 66% destroyed
VRAMString07_{AREA}: ; 05:9B6C
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

; shot block (kraid terrain duplicate)
VRAMString08_{AREA}: ; 05:9B71
    .byte $22
    .byte $90, $91
    .byte $92, $93

; shot block (kraid/ridley donut cube)
VRAMString09_{AREA}: ; 05:9B76
    .byte $22
    .byte $70, $71
    .byte $72, $73

; shot block (kraid brick)
VRAMString0A_{AREA}: ; 05:9B7B
    .byte $22
    .byte $74, $75
    .byte $76, $77

; shot block (ridley cracked cube)
VRAMString0B_{AREA}: ; 05:9B80
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

VRAMString0C_{AREA}: ; 05:9B85
VRAMString0D_{AREA}: ; 05:9B85
VRAMString0E_{AREA}: ; 05:9B85
VRAMString0F_{AREA}: ; 05:9B85
VRAMString10_{AREA}: ; 05:9B85
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
Garbage_Metatile_{AREA}: ; 05:AC23
    .incbin "garbage/metatile_bank5.bin"


;Not used.
Garbage_01_02_03_04_05_AFF0: ; 05:AFF0
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
    .incbin "garbage/01_02_03_04_05_AFF0.bin"
.elif BUILDTARGET == "NES_PAL"
    .incbin "garbage/01_02_03_04_05_AFF0_pal.bin"
.endif

.ends

;------------------------------------------[ Area music data ]---------------------------------------

.section "ROM Bank $005 - Area Song Data" bank 5 slot "ROMSwitchSlot" orga $B000 force

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
    .include "songs/ntsc/ridley.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/ridley.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
    .include "songs/ntsc/kraid.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/kraid.asm"
.endif

;Not used.
Garbage_Song_{AREA}: ; 05:B0E7
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G"
    .incbin "garbage/song_bank5.bin"
.elif BUILDTARGET == "NES_CNS"
    .incbin "garbage/song_bank5_cns.bin"
.elif BUILDTARGET == "NES_PAL"
    .incbin "garbage/song_bank5_pal.bin"
.endif

.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
    .section "ROM Bank $005 - Sound Engine" bank 5 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $005 - Sound Engine" bank 5 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "sound_engine.asm"

.ends

;-----------------------------------------------[ RESET ]--------------------------------------------

.section "ROM Bank $005 - Reset" bank 5 slot "ROMSwitchSlot" orga $BFB0 force

ROMSWITCH_RESET: ; 05:BFB0
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $005 - Vectors" bank 5 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

