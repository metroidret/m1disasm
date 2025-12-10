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

;Kraid hideout (memory page 4)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 4
.section "ROM Bank $004" bank 4 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Samus end tile patterns.
GFX_EndingSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "ending/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $520, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "ending/sprite_tiles_cnsus.chr"
    .endif

;Unused tile patterns (needed so the Palette Pointer Table, etc. below are properly aligned)
GFX_KraiUnused:
    .incbin "ridley/sprite_tiles.chr" skip $120 read $E0

; 9360 - Misc Kraid BG CHR
GFX_KraiBG3:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "kraid/bg_chr_3.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "kraid/bg_chr_3_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $200, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "kraid/bg_chr_3_cnsus.chr"
    .endif

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntryBank PalPntrTbl, Palette00                 ;($A155)Room palette.
    PtrTableEntryBank PalPntrTbl, Palette01                 ;($A179)Samus power suit palette.
    PtrTableEntryBank PalPntrTbl, Palette02                 ;($A185)Samus varia suit palette.
    PtrTableEntryBank PalPntrTbl, Palette03                 ;($A17F)Samus power suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette04                 ;($A18B)Samus varia suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette05                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette06                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette07                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette08                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette09                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0A                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0B                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0C                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0D                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0E                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette0F                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette10                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette11                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette12                 ;($A191)
    PtrTableEntryBank PalPntrTbl, Palette13                 ;($A191)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryBank PalPntrTbl, Palette14                 ;($A198)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette15                 ;($A19F)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette16                 ;($A1A6)Samus fade in palette.
    PtrTableEntryBank PalPntrTbl, Palette17                 ;($A1AD)Unused?
    PtrTableEntryBank PalPntrTbl, Palette18                 ;($A1B5)Suitless Samus power suit palette.
    PtrTableEntryBank PalPntrTbl, Palette19                 ;($A1BD)Suitless Samus varia suit palette.
    PtrTableEntryBank PalPntrTbl, Palette1A                 ;($A1C5)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryBank PalPntrTbl, Palette1B                 ;($A1CD)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl               ;($A26D)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_BANK{BANK}              ;($A1D5)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_BANK{BANK}            ;($A21F)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_BANK{BANK}              ;($AC32)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_BANK{BANK}          ;($9CF7)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_BANK{BANK}          ;($9DF7)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_BANK{BANK}           ;($9E25)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_BANK{BANK}               ;($9C86)Index to values in addr tables for enemy animations.
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
    jmp AreaRoutineStub ; Just an RTS

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
RTS_95CB:
    rts

L95CC:
    .byte $1D                       ;Kraid's room.
AreaMusicFlag:
    .byte music_KraidArea           ;Kraid's hideout music init flag.
AreaEnemyDamage:
    .word $0200                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

AreaSamusMapPosX:
    .byte $07   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $14   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette05+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled - EnAnimTable
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion - EnAnimTable

    .byte $00, $00
AreaEnProjectileFallingAnimIndex:
    .byte $00, $00
AreaEnProjectileSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_Memu - EnAnimTable

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine_BANK{BANK} ; 00 - sidehopper
        .word SidehopperCeilingAIRoutine_BANK{BANK} ; 01 - ceiling sidehopper
        .word RTS_95CB ; 02 - unused enemy type that doesn't properly clear itself
        .word RipperAIRoutine_BANK{BANK} ; 03 - ripper
        .word SkreeAIRoutine_BANK{BANK} ; 04 - skree
        .word CrawlerAIRoutine_BANK{BANK} ; 05 - crawler
        .word RTS_95CB ; 06 - same as 2
        .word PipeBugAIRoutine_BANK{BANK} ; 07 - geega
        .word KraidAIRoutine_BANK{BANK} ; 08 - kraid
        .word KraidLintAIRoutine_BANK{BANK} ; 09 - kraid lint
        .word KraidNailAIRoutine_BANK{BANK} ; 0A - kraid nail
        .word RTS_95CB ; 0B - same as 2
        .word RTS_95CB ; 0C - same as 2
        .word RTS_95CB ; 0D - same as 2
        .word RTS_95CB ; 0E - same as 2
        .word RTS_95CB ; 0F - same as 2

EnemyDeathAnimIndex:
    .byte EnAnim_SidehopperFloorExplode - EnAnimTable, EnAnim_SidehopperFloorExplode - EnAnimTable ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingExplode - EnAnimTable, EnAnim_SidehopperCeilingExplode - EnAnimTable ; 01 - ceiling sidehopper
    .byte EnAnim_WaverExplode_R - EnAnimTable, EnAnim_WaverExplode_L - EnAnimTable ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_RipperExplode_R - EnAnimTable, EnAnim_RipperExplode_L - EnAnimTable ; 03 - ripper
    .byte EnAnim_SkreeExplode - EnAnimTable, EnAnim_SkreeExplode - EnAnimTable ; 04 - skree
    .byte EnAnim_ZeelaExplode - EnAnimTable, EnAnim_ZeelaExplode - EnAnimTable ; 05 - crawler
    .byte EnAnim_Geega_L - EnAnimTable, EnAnim_Geega_L - EnAnimTable ; 06 - same as 2
    .byte EnAnim_GeegaExplode_R - EnAnimTable, EnAnim_GeegaExplode_L - EnAnimTable ; 07 - geega
    .byte EnAnim_KraidExplode_R - EnAnimTable, EnAnim_KraidExplode_L - EnAnimTable ; 08 - kraid
    .byte $00, $00 ; 09 - kraid lint
    .byte $00, $00 ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0C - same as 2
    .byte $00, $00 ; 0D - same as 2
    .byte $00, $00 ; 0E - same as 2
    .byte $00, $00 ; 0F - same as 2

EnemyHealthTbl:
    .byte $08 ; 00 - sidehopper
    .byte $08 ; 01 - ceiling sidehopper
    .byte $00 ; 02 - unused enemy type that doesn't properly clear itself
    .byte $FF ; 03 - ripper
    .byte $02 ; 04 - skree
    .byte $02 ; 05 - crawler
    .byte $00 ; 06 - same as 2
    .byte $01 ; 07 - geega
    .byte $60 ; 08 - kraid
    .byte $FF ; 09 - kraid lint
    .byte $FF ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

EnemyRestingAnimIndex:
    .byte EnAnim_SidehopperFloorIdle - EnAnimTable, EnAnim_SidehopperFloorIdle - EnAnimTable ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle - EnAnimTable, EnAnim_SidehopperCeilingIdle - EnAnimTable ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0_R - EnAnimTable, EnAnim_Waver0_L - EnAnimTable ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_Ripper_R - EnAnimTable, EnAnim_Ripper_L - EnAnimTable ; 03 - ripper
    .byte EnAnim_Skree - EnAnimTable, EnAnim_Skree - EnAnimTable ; 04 - skree
    .byte EnAnim_ZeelaOnFloor - EnAnimTable, EnAnim_ZeelaOnFloor - EnAnimTable ; 05 - crawler
    .byte EnAnim_Geega_L - EnAnimTable, EnAnim_Geega_L - EnAnimTable ; 06 - same as 2
    .byte EnAnim_GeegaResting_R - EnAnimTable, EnAnim_GeegaResting_L - EnAnimTable ; 07 - geega
    .byte EnAnim_Kraid_R - EnAnimTable, EnAnim_Kraid_L - EnAnimTable ; 08 - kraid
    .byte EnAnim_KraidLint_R - EnAnimTable, EnAnim_KraidLint_L - EnAnimTable ; 09 - kraid lint
    .byte EnAnim_KraidNailIdle_R - EnAnimTable, EnAnim_KraidNailIdle_L - EnAnimTable ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0C - same as 2
    .byte $00, $00 ; 0D - same as 2
    .byte $00, $00 ; 0E - same as 2
    .byte $00, $00 ; 0F - same as 2

EnemyActiveAnimIndex:
    .byte EnAnim_SidehopperFloorIdle - EnAnimTable, EnAnim_SidehopperFloorIdle - EnAnimTable ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle - EnAnimTable, EnAnim_SidehopperCeilingIdle - EnAnimTable ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0_R - EnAnimTable, EnAnim_Waver0_L - EnAnimTable ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_Ripper_R - EnAnimTable, EnAnim_Ripper_L - EnAnimTable ; 03 - ripper
    .byte EnAnim_Skree - EnAnimTable, EnAnim_Skree - EnAnimTable ; 04 - skree
    .byte EnAnim_ZeelaOnFloor - EnAnimTable, EnAnim_ZeelaOnFloor - EnAnimTable ; 05 - crawler
    .byte EnAnim_Geega_L - EnAnimTable, EnAnim_Geega_L - EnAnimTable ; 06 - same as 2
    .byte EnAnim_Geega_R - EnAnimTable, EnAnim_Geega_L - EnAnimTable ; 07 - geega
    .byte EnAnim_Kraid_R - EnAnimTable, EnAnim_Kraid_L - EnAnimTable ; 08 - kraid
    .byte EnAnim_KraidLint_R - EnAnimTable, EnAnim_KraidLint_L - EnAnimTable ; 09 - kraid lint
    .byte EnAnim_KraidNailMoving_R - EnAnimTable, EnAnim_KraidNailMoving_L - EnAnimTable ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable ; 0C - same as 2
    .byte $00, $00 ; 0D - same as 2
    .byte $00, $00 ; 0E - same as 2
    .byte $00, $00 ; 0F - same as 2

L967B:
    .byte $00 ; 00 - sidehopper
    .byte $00 ; 01 - ceiling sidehopper
    .byte $00 ; 02 - unused enemy type that doesn't properly clear itself
    .byte $00 | $80 ; 03 - ripper
    .byte $00 ; 04 - skree
    .byte $00 ; 05 - crawler
    .byte $00 ; 06 - same as 2
    .byte $00 ; 07 - geega
    .byte $00 ; 08 - kraid
    .byte $00 ; 09 - kraid lint
    .byte $00 ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 | $80 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

L968B:
    .byte %10001001 ; 00 - sidehopper
    .byte %10001001 ; 01 - ceiling sidehopper
    .byte %00001001 ; 02 - unused enemy type that doesn't properly clear itself
    .byte %00000000 ; 03 - ripper
    .byte %10000110 ; 04 - skree
    .byte %00000100 ; 05 - crawler
    .byte %10001001 ; 06 - same as 2
    .byte %10000000 ; 07 - geega
    .byte %10000011 ; 08 - kraid
    .byte %00000000 ; 09 - kraid lint
    .byte %00000000 ; 0A - kraid nail
    .byte %00000000 ; 0B - same as 2
    .byte %10000010 ; 0C - same as 2
    .byte %00000000 ; 0D - same as 2
    .byte %00000000 ; 0E - same as 2
    .byte %00000000 ; 0F - same as 2

EnemyData0DTbl:
    .byte $01 ; 00 - sidehopper
    .byte $01 ; 01 - ceiling sidehopper
    .byte $01 ; 02 - unused enemy type that doesn't properly clear itself
    .byte $01 ; 03 - ripper
    .byte $01 ; 04 - skree
    .byte $01 ; 05 - crawler
    .byte $01 ; 06 - same as 2
    .byte $01 ; 07 - geega
    .byte $01 ; 08 - kraid
    .byte $01 ; 09 - kraid lint
    .byte $01 ; 0A - kraid nail
    .byte $01 ; 0B - same as 2
    .byte $40 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

EnemyDistanceToSamusThreshold:
    .byte $00 ; 00 - sidehopper
    .byte $00 ; 01 - ceiling sidehopper
    .byte $6 | (0 << 7) ; 02 - unused enemy type that doesn't properly clear itself
    .byte $00 ; 03 - ripper
    .byte $3 | (1 << 7) ; 04 - skree
    .byte $00 ; 05 - crawler
    .byte $4 | (1 << 7) ; 06 - same as 2
    .byte $00 ; 07 - geega
    .byte $00 ; 08 - kraid
    .byte $00 ; 09 - kraid lint
    .byte $00 ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

EnemyInitDelayTbl:
    .byte $08 ; 00 - sidehopper
    .byte $08 ; 01 - ceiling sidehopper
    .byte $01 ; 02 - unused enemy type that doesn't properly clear itself
    .byte $01 ; 03 - ripper
    .byte $01 ; 04 - skree
    .byte $01 ; 05 - crawler
    .byte $10 ; 06 - same as 2
    .byte $08 ; 07 - geega
    .byte $10 ; 08 - kraid
    .byte $00 ; 09 - kraid lint
    .byte $00 ; 0A - kraid nail
    .byte $01 ; 0B - same as 2
    .byte $01 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice_SidehopperFloor_BANK{BANK} - EnemyMovementChoices ; 00 - sidehopper
    .byte EnemyMovementChoice_SidehopperCeiling_BANK{BANK} - EnemyMovementChoices ; 01 - ceiling sidehopper
    .byte $00 ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnemyMovementChoice_Ripper_BANK{BANK} - EnemyMovementChoices ; 03 - ripper
    .byte EnemyMovementChoice_Skree_BANK{BANK} - EnemyMovementChoices ; 04 - skree
    .byte EnemyMovementChoice_Zeela_BANK{BANK} - EnemyMovementChoices ; 05 - crawler (enemy moves manually)
    .byte $00 ; 06 - same as 2
    .byte EnemyMovementChoice_Geega_BANK{BANK} - EnemyMovementChoices ; 07 - geega
    .byte EnemyMovementChoice_Kraid_BANK{BANK} - EnemyMovementChoices ; 08 - kraid
    .byte EnemyMovementChoice_KraidLint_BANK{BANK} - EnemyMovementChoices ; 09 - kraid lint
    .byte EnemyMovementChoice_KraidNail_BANK{BANK} - EnemyMovementChoices ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

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
    .byte $7F, $70, $70, $90, $90, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

L977B:
    .byte %01100100 ; 00 - sidehopper
    .byte %01101100 ; 01 - ceiling sidehopper
    .byte %00100001 ; 02 - unused enemy type that doesn't properly clear itself
    .byte %00000001 ; 03 - ripper
    .byte %00000100 ; 04 - skree
    .byte %00000000 ; 05 - crawler (enemy moves manually)
    .byte %01001100 ; 06 - same as 2
    .byte %01000000 ; 07 - geega
    .byte %00000100 ; 08 - kraid
    .byte %00000000 ; 09 - kraid lint
    .byte %00000000 ; 0A - kraid nail
    .byte %01000000 ; 0B - same as 2
    .byte %01000000 ; 0C - same as 2
    .byte %00000000 ; 0D - same as 2
    .byte %00000000 ; 0E - same as 2
    .byte %00000000 ; 0F - same as 2

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_KraidNailMoving_L - EnAnimTable, EnAnim_KraidNailIdle_L - EnAnimTable
    .byte EnAnim_Memu - EnAnimTable, EnAnim_Memu - EnAnimTable
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
EnemyMovementChoice_SidehopperFloor_BANK{BANK}:
    EnemyMovementChoiceEntry $01, $02
EnemyMovementChoice_SidehopperCeiling_BANK{BANK}:
    EnemyMovementChoiceEntry $03, $04
EnemyMovementChoice_Ripper_BANK{BANK}:
    EnemyMovementChoiceEntry $06
EnemyMovementChoice_Skree_BANK{BANK}:
    EnemyMovementChoiceEntry $07
EnemyMovementChoice_Geega_BANK{BANK}:
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Zeela_BANK{BANK}: ; enemy moves manually
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_Kraid_BANK{BANK}:
    EnemyMovementChoiceEntry $0C, $0D
EnemyMovementChoice_KraidLint_BANK{BANK}:
    EnemyMovementChoiceEntry $0E
EnemyMovementChoice_KraidNail_BANK{BANK}:
    EnemyMovementChoiceEntry $0F, $10, $11, $0F

; unused (???)
EnemyMovement00_R_BANK{BANK}:
    SignMagSpeed $20,  2,  2
    EnemyMovementInstr_FE

EnemyMovement00_L_BANK{BANK}:
    SignMagSpeed $20, -2,  2
    EnemyMovementInstr_FE

EnemyMovement01_R_BANK{BANK}:
EnemyMovement01_L_BANK{BANK}:
EnemyMovement02_R_BANK{BANK}:
EnemyMovement02_L_BANK{BANK}:
EnemyMovement03_R_BANK{BANK}:
EnemyMovement03_L_BANK{BANK}:
EnemyMovement04_R_BANK{BANK}:
EnemyMovement04_L_BANK{BANK}:
EnemyMovement05_R_BANK{BANK}:
EnemyMovement05_L_BANK{BANK}:
    ; nothing

; ripper
EnemyMovement06_R_BANK{BANK}:
    SignMagSpeed $01,  1,  0
    EnemyMovementInstr_Restart

EnemyMovement06_L_BANK{BANK}:
    SignMagSpeed $01, -1,  0
    EnemyMovementInstr_Restart

; skree
EnemyMovement07_R_BANK{BANK}:
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

EnemyMovement07_L_BANK{BANK}:
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

EnemyMovement08_R_BANK{BANK}:
EnemyMovement08_L_BANK{BANK}:
EnemyMovement09_R_BANK{BANK}:
EnemyMovement09_L_BANK{BANK}:
EnemyMovement0A_R_BANK{BANK}:
EnemyMovement0A_L_BANK{BANK}:
EnemyMovement0B_R_BANK{BANK}:
EnemyMovement0B_L_BANK{BANK}:
    ; nothing

; kraid
EnemyMovement0C_R_BANK{BANK}:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0C_L_BANK{BANK}:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_R_BANK{BANK}:
    SignMagSpeed $32,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_L_BANK{BANK}:
    SignMagSpeed $32, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32,  1,  1
    EnemyMovementInstr_FE

; kraid lint
EnemyMovement0E_R_BANK{BANK}:
    SignMagSpeed $50,  4,  0
    EnemyMovementInstr_Restart

EnemyMovement0E_L_BANK{BANK}:
    SignMagSpeed $50, -4,  0
    EnemyMovementInstr_Restart

; kraid nail
EnemyMovement0F_R_BANK{BANK}:
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

EnemyMovement0F_L_BANK{BANK}:
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

EnemyMovement10_R_BANK{BANK}:
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

EnemyMovement10_L_BANK{BANK}:
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

EnemyMovement11_R_BANK{BANK}:
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

EnemyMovement11_L_BANK{BANK}:
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

EnProjectileMovement0_BANK{BANK}:
    SignMagSpeed $04,  3, -3
    SignMagSpeed $05,  3, -2
    SignMagSpeed $06,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $06,  3,  1
    SignMagSpeed $05,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

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
; Ripper Routine
.include "enemies/ripper.asm"

;-------------------------------------------------------------------------------
; Skree Routine
.include "enemies/skree.asm"
; The crawler routine below depends upon two of the exit labels in skree.asm

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Kraid Routine
.include "enemies/kraid.asm"
; Note: For this bank the functions StorePositionToTemp and LoadPositionFromTemp
;  are in are in kraid.asm. Extract those functions from that file if you plan
;  on removing it.

AreaRoutineStub_BANK{BANK}:
    rts

; What's this table?
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

.include "kraid/enemy_sprite_data.asm"

;----------------------------------------[ Palette data ]--------------------------------------------

.include "kraid/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "kraid/room_ptrs.asm"

.include "kraid/structure_ptrs.asm"

;-----------------------------------[ Special items table ]-----------------------------------------

.include "kraid/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "kraid/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "kraid/structures.asm"

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "kraid/metatiles.asm"

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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .section "ROM Bank $004 - Music Engine" bank 4 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $004 - Music Engine" bank 4 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $004 - Vectors" bank 4 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

