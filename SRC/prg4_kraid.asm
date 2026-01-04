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
.redef AREA = {"BANK{BANK}"}
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

PalettePtrTable:
    PtrTableEntryArea PalettePtrTable, Palette00                 ;($A155)Room palette.
    PtrTableEntryArea PalettePtrTable, Palette01                 ;($A179)Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette02                 ;($A185)Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette03                 ;($A17F)Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette04                 ;($A18B)Samus varia suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette05                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette06                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette07                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette08                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette09                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0A                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0B                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0C                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0D                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0E                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette0F                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette10                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette11                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette12                 ;($A191)
    PtrTableEntryArea PalettePtrTable, Palette13                 ;($A191)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryArea PalettePtrTable, Palette14                 ;($A198)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette15                 ;($A19F)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette16                 ;($A1A6)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette17                 ;($A1AD)Unused?
    PtrTableEntryArea PalettePtrTable, Palette18                 ;($A1B5)Suitless Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette19                 ;($A1BD)Suitless Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette1A                 ;($A1C5)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette1B                 ;($A1CD)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_{AREA}               ;($A26D)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_{AREA}              ;($A1D5)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_{AREA}            ;($A21F)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_{AREA}              ;($AC32)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_{AREA}          ;($9CF7)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_{AREA}          ;($9DF7)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_{AREA}           ;($9E25)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_{AREA}               ;($9C86)Index to values in addr tables for enemy animations.
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
    jmp AreaRoutineStub_{AREA} ; Just an RTS

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

AreaPaletteToggle:
    .byte _id_Palette05+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}

    .byte $00, $00
AreaEnProjectileFallingAnimIndex:
    .byte $00, $00
AreaEnProjectileSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine_{AREA} ; 00 - sidehopper
        .word SidehopperCeilingAIRoutine_{AREA} ; 01 - ceiling sidehopper
        .word RTS_95CB ; 02 - unused enemy type that doesn't properly clear itself
        .word RipperAIRoutine_{AREA} ; 03 - ripper
        .word SkreeAIRoutine_{AREA} ; 04 - skree
        .word CrawlerAIRoutine_{AREA} ; 05 - crawler
        .word RTS_95CB ; 06 - same as 2
        .word PipeBugAIRoutine_{AREA} ; 07 - geega
        .word KraidAIRoutine_{AREA} ; 08 - kraid
        .word KraidLintAIRoutine_{AREA} ; 09 - kraid lint
        .word KraidNailAIRoutine_{AREA} ; 0A - kraid nail
        .word RTS_95CB ; 0B - same as 2
        .word RTS_95CB ; 0C - same as 2
        .word RTS_95CB ; 0D - same as 2
        .word RTS_95CB ; 0E - same as 2
        .word RTS_95CB ; 0F - same as 2

EnemyDeathAnimIndex:
    .byte EnAnim_SidehopperFloorExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorExplode_{AREA} - EnAnimTable_{AREA} ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingExplode_{AREA} - EnAnimTable_{AREA} ; 01 - ceiling sidehopper
    .byte EnAnim_WaverExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_WaverExplode_L_{AREA} - EnAnimTable_{AREA} ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_RipperExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RipperExplode_L_{AREA} - EnAnimTable_{AREA} ; 03 - ripper
    .byte EnAnim_SkreeExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SkreeExplode_{AREA} - EnAnimTable_{AREA} ; 04 - skree
    .byte EnAnim_ZeelaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_ZeelaExplode_{AREA} - EnAnimTable_{AREA} ; 05 - crawler
    .byte EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA}, EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA} ; 06 - same as 2
    .byte EnAnim_GeegaExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_GeegaExplode_L_{AREA} - EnAnimTable_{AREA} ; 07 - geega
    .byte EnAnim_KraidExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidExplode_L_{AREA} - EnAnimTable_{AREA} ; 08 - kraid
    .byte $00, $00 ; 09 - kraid lint
    .byte $00, $00 ; 0A - kraid nail
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0B - same as 2
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0C - same as 2
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
    .byte EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA} ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA} ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Waver0_L_{AREA} - EnAnimTable_{AREA} ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_Ripper_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Ripper_L_{AREA} - EnAnimTable_{AREA} ; 03 - ripper
    .byte EnAnim_Skree_{AREA} - EnAnimTable_{AREA}, EnAnim_Skree_{AREA} - EnAnimTable_{AREA} ; 04 - skree
    .byte EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA} ; 05 - crawler
    .byte EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA}, EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA} ; 06 - same as 2
    .byte EnAnim_GeegaResting_R_{AREA} - EnAnimTable_{AREA}, EnAnim_GeegaResting_L_{AREA} - EnAnimTable_{AREA} ; 07 - geega
    .byte EnAnim_Kraid_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Kraid_L_{AREA} - EnAnimTable_{AREA} ; 08 - kraid
    .byte EnAnim_KraidLint_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidLint_L_{AREA} - EnAnimTable_{AREA} ; 09 - kraid lint
    .byte EnAnim_KraidNailIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailIdle_L_{AREA} - EnAnimTable_{AREA} ; 0A - kraid nail
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0B - same as 2
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0C - same as 2
    .byte $00, $00 ; 0D - same as 2
    .byte $00, $00 ; 0E - same as 2
    .byte $00, $00 ; 0F - same as 2

EnemyActiveAnimIndex:
    .byte EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA} ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA} ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Waver0_L_{AREA} - EnAnimTable_{AREA} ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_Ripper_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Ripper_L_{AREA} - EnAnimTable_{AREA} ; 03 - ripper
    .byte EnAnim_Skree_{AREA} - EnAnimTable_{AREA}, EnAnim_Skree_{AREA} - EnAnimTable_{AREA} ; 04 - skree
    .byte EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA} ; 05 - crawler
    .byte EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA}, EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA} ; 06 - same as 2
    .byte EnAnim_Geega_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Geega_L_{AREA} - EnAnimTable_{AREA} ; 07 - geega
    .byte EnAnim_Kraid_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Kraid_L_{AREA} - EnAnimTable_{AREA} ; 08 - kraid
    .byte EnAnim_KraidLint_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidLint_L_{AREA} - EnAnimTable_{AREA} ; 09 - kraid lint
    .byte EnAnim_KraidNailMoving_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailMoving_L_{AREA} - EnAnimTable_{AREA} ; 0A - kraid nail
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0B - same as 2
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA} ; 0C - same as 2
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
    .byte EnAnim_KraidNailMoving_L_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailIdle_L_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_Memu_{AREA} - EnAnimTable_{AREA}, EnAnim_Memu_{AREA} - EnAnimTable_{AREA}
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
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

TileBlastFramePtrTable:
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

AreaRoutineStub_{AREA}:
    rts

; What's this table?
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
    .byte $22
    .byte $70, $71
    .byte $72, $73

TileBlastFrame0A_{AREA}:
    .byte $22
    .byte $74, $75
    .byte $76, $77

TileBlastFrame0B_{AREA}:
    .byte $22
    .byte $78, $79
    .byte $7A, $7B

TileBlastFrame0C_{AREA}:
TileBlastFrame0D_{AREA}:
TileBlastFrame0E_{AREA}:
TileBlastFrame0F_{AREA}:
TileBlastFrame10_{AREA}:
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

;Not used.
    .byte $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15
    .byte $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F
    .byte $0D, $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21
    .byte $1C, $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C
    .byte $1C, $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF
    .byte $02, $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01
    .byte $21, $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22
    .byte $22, $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21
    .byte $11, $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF
    .byte $01, $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D
    .byte $22, $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21
    .byte $08, $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22
    .byte $20, $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17
    .byte $17, $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08
    .byte $18, $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C
    .byte $1F, $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18
    .byte $18, $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07
    .byte $0D, $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07
    .byte $0D, $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A
    .byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01
    .byte $18, $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14
    .byte $04, $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF
    .byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
    .byte $0E, $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF
    .byte $FF, $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F
    .byte $4F, $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10
    .byte $11, $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C
    .byte $1D, $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A
    .byte $2C, $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28
    .byte $28, $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B
    .byte $2B, $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D
    .byte $3E, $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B
    .byte $0B, $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56
    .byte $57, $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D
    .byte $62, $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F
    .byte $70, $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49
    .byte $4A, $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18
    .byte $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D
    .byte $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33
    .byte $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B
    .byte $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89
    .byte $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8
    .byte $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14
    .byte $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13
    .byte $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF
    .byte $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF
    .byte $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C
    .byte $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12
    .byte $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00
    .byte $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93

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

