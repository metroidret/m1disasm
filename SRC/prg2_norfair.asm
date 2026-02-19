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
.redef AREA = {"BANK{BANK}"}
.section "ROM Bank $002" bank 2 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Norfair enemy tile patterns.
GFX_NorfairSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "norfair/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "norfair/sprite_tiles_cnsus.chr"
    .endif

;Tourian enemy tile patterns.
GFX_TourianSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "tourian/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "tourian/sprite_tiles_cnsus.chr"
    .endif

;----------------------------------------------------------------------------------------------------

PalettePtrTable:
    PtrTableEntryArea PalettePtrTable, Palette00                 ;($A178)Default room palette.
    PtrTableEntryArea PalettePtrTable, Palette01                 ;($A19C)Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette02                 ;($A1A8)Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette03                 ;($A1A2)Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette04                 ;($A1AE)Samus varia suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette05                 ;($A1B4)Alternate room palette.
    PtrTableEntryArea PalettePtrTable, Palette06                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette07                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette08                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette09                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0A                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0B                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0C                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0D                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0E                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette0F                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette10                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette11                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette12                 ;($A1D7)
    PtrTableEntryArea PalettePtrTable, Palette13                 ;($A1D7)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryArea PalettePtrTable, Palette14                 ;($A1DE)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette15                 ;($A1E5)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette16                 ;($A1EC)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette17                 ;($A1F3)Unused?
    PtrTableEntryArea PalettePtrTable, Palette18                 ;($A1FB)Suitless Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette19                 ;($A203)Suitless Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette1A                 ;($A20B)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette1B                 ;($A213)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_{AREA}               ;($A2D9)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_{AREA}              ;($A21B)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_{AREA}            ;($A277)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_{AREA}              ;($AEEC)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_{AREA}          ;($9C64)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_{AREA}          ;($9D64)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_{AREA}           ;($9D78)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_{AREA}               ;($9BDA)Index to values in addr tables for enemy animations.
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
    jmp RTS_Polyp_{AREA}                       ;Area specific routine.(RTS)

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

AreaMapPosX:
    .byte $16   ;Samus start x coord on world map.
AreaMapPosY:
    .byte $0D   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPaletteToggle:
    .byte _id_Palette00+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}
; EnProjectile rising?
    .byte EnAnim_DragonEnProjectileUp_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonEnProjectileUp_L_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileFallingAnimIndex:
    .byte EnAnim_DragonEnProjectileDown_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonEnProjectileDown_L_{AREA} - EnAnimTable_{AREA}
AreaEnProjectileSplatterAnimIndex:
    .byte EnAnim_DragonEnProjectileSplatter_{AREA} - EnAnimTable_{AREA}, EnAnim_PolypRockShatter_{AREA} - EnAnimTable_{AREA}
AreaMellowAnimIndex:
    .byte EnAnim_Mella_{AREA} - EnAnimTable_{AREA}

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_JumpEngine
        .word SwooperAIRoutine00_{AREA} ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01_{AREA} ; 01 - swooper targetting samus
        .word RipperAIRoutine_{AREA} ; 02 - ripper II
        .word RemoveEnemy__{AREA} ; 03 - disappears
        .word RemoveEnemy__{AREA} ; 04 - same as 3
        .word RemoveEnemy__{AREA} ; 05 - same as 3
        .word CrawlerAIRoutine_{AREA} ; 06 - crawler
        .word PipeBugAIRoutine_{AREA} ; 07 - gamet
        .word RemoveEnemy__{AREA} ; 08 - same as 3
        .word RemoveEnemy__{AREA} ; 09 - same as 3
        .word RemoveEnemy__{AREA} ; 0A - same as 3
        .word SqueeptAIRoutine_{AREA} ; 0B - lava jumper
        .word MultiviolaAIRoutine_{AREA} ; 0C - bouncy orb
        .word DragonAIRoutine_{AREA} ; 0D - dragon
        .word PolypAIRoutine_{AREA} ; 0E - rock launcher thing
        .word RemoveEnemy__{AREA} ; 0F - same as 3

EnemyDeathAnimIndex:
    .byte EnAnim_GerutaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaExplode_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaExplode_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_RipperIIExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_RipperIIExplode_{AREA} - EnAnimTable_{AREA} ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_NovaExplode_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_GametExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_GametExplode_L_{AREA} - EnAnimTable_{AREA} ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyExplode_{AREA} - EnAnimTable_{AREA} ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - same as 3
    .byte EnAnim_SqueeptExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SqueeptExplode_{AREA} - EnAnimTable_{AREA} ; 0B - lava jumper
    .byte EnAnim_MultiviolaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaExplode_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orb
    .byte EnAnim_DragonExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonExplode_{AREA} - EnAnimTable_{AREA} ; 0D - dragon
    .byte $00, $00 ; 0E - undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; 0F - same as 3

EnemyHealthTbl:
    .byte $08 ; 00 - swooper has not seen samus
    .byte $08 ; 01 - swooper targetting samus
    .byte $FF ; 02 - ripper II
    .byte $01 ; 03 - disappears
    .byte $01 ; 04 - same as 3
    .byte $01 ; 05 - same as 3
    .byte $02 ; 06 - crawler
    .byte $01 ; 07 - gamet
    .byte $01 ; 08 - same as 3
    .byte $20 ; 09 - same as 3
    .byte $FF ; 0A - same as 3
    .byte $FF ; 0B - lava jumper
    .byte $08 ; 0C - bouncy orb
    .byte $06 ; 0D - dragon
    .byte $FF ; 0E - rock launcher thing
    .byte $00 ; 0F - same as 3

EnemyRestingAnimIndex:
    .byte EnAnim_GerutaIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaIdle_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaIdle_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_RipperII_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RipperII_L_{AREA} - EnAnimTable_{AREA} ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_GametResting_R_{AREA} - EnAnimTable_{AREA}, EnAnim_GametResting_L_{AREA} - EnAnimTable_{AREA} ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyIdle_L_{AREA} - EnAnimTable_{AREA} ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - same as 3
    .byte EnAnim_SqueeptFalling_{AREA} - EnAnimTable_{AREA}, EnAnim_SqueeptFalling_{AREA} - EnAnimTable_{AREA} ; 0B - lava jumper
    .byte EnAnim_MultiviolaSpinningClockwise_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orb
    .byte EnAnim_DragonIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonIdle_L_{AREA} - EnAnimTable_{AREA} ; 0D - dragon
    .byte $00, $00 ; 0E - undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; 0F - same as 3

EnemyActiveAnimIndex:
    .byte EnAnim_GerutaSwooping_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaSwooping_{AREA} - EnAnimTable_{AREA} ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaSwooping_{AREA} - EnAnimTable_{AREA}, EnAnim_GerutaSwooping_{AREA} - EnAnimTable_{AREA} ; 01 - swooper targetting samus
    .byte EnAnim_RipperII_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RipperII_L_{AREA} - EnAnimTable_{AREA} ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA} ; 06 - crawler
    .byte EnAnim_GametActive_R_{AREA} - EnAnimTable_{AREA}, EnAnim_GametActive_L_{AREA} - EnAnimTable_{AREA} ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyIdle_L_{AREA} - EnAnimTable_{AREA} ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RidleyFireball_L_{AREA} - EnAnimTable_{AREA} ; 0A - same as 3
    .byte EnAnim_SqueeptJumping_{AREA} - EnAnimTable_{AREA}, EnAnim_SqueeptJumping_{AREA} - EnAnimTable_{AREA} ; 0B - lava jumper
    .byte EnAnim_MultiviolaSpinningClockwise_{AREA} - EnAnimTable_{AREA}, EnAnim_MultiviolaSpinningCounterclockwise_{AREA} - EnAnimTable_{AREA} ; 0C - bouncy orb
    .byte EnAnim_DragonIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonIdle_L_{AREA} - EnAnimTable_{AREA} ; 0D - dragon
    .byte $00, $00 ; 0E - undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; 0F - same as 3

L967B:
    .byte $00 ; 00 - swooper has not seen samus
    .byte $00 ; 01 - swooper targetting samus
    .byte $00 | $80 ; 02 - ripper II
    .byte $02 | $80 ; 03 - disappears
    .byte $00 ; 04 - same as 3
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - crawler
    .byte $00 ; 07 - gamet
    .byte $00 | $80 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - lava jumper
    .byte $02 | $80 ; 0C - bouncy orb
    .byte $00 ; 0D - dragon
    .byte $00 ; 0E - rock launcher thing
    .byte $00 ; 0F - same as 3

L968B:
    .byte %10001001 ; 00 - swooper has not seen samus
    .byte %10001001 ; 01 - swooper targetting samus
    .byte %00000000 ; 02 - ripper II
    .byte %01000010 ; 03 - disappears
    .byte %00000000 ; 04 - same as 3
    .byte %00000000 ; 05 - same as 3
    .byte %00000100 ; 06 - crawler
    .byte %10000000 ; 07 - gamet
    .byte %10000000 ; 08 - same as 3
    .byte %10000001 ; 09 - same as 3
    .byte %00000000 ; 0A - same as 3
    .byte %00000000 ; 0B - lava jumper
    .byte %00000101 ; 0C - bouncy orb
    .byte %10001001 ; 0D - dragon
    .byte %00000000 ; 0E - rock launcher thing
    .byte %00000000 ; 0F - same as 3

EnemyForceSpeedTowardsSamusDelayTbl:
    .byte $01 ; 00 - swooper has not seen samus
    .byte $01 ; 01 - swooper targetting samus
    .byte $01 ; 02 - ripper II
    .byte $01 ; 03 - disappears
    .byte $01 ; 04 - same as 3
    .byte $01 ; 05 - same as 3
    .byte $01 ; 06 - crawler
    .byte $01 ; 07 - gamet
    .byte $28 ; 08 - same as 3
    .byte $10 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - lava jumper
    .byte $00 ; 0C - bouncy orb
    .byte $01 ; 0D - dragon
    .byte $00 ; 0E - rock launcher thing
    .byte $00 ; 0F - same as 3

EnemyDistanceToSamusThreshold:
    .byte $5 | (0 << 7) ; 00 - swooper has not seen samus
    .byte $5 | (0 << 7) ; 01 - swooper targetting samus
    .byte $00 ; 02 - ripper II
    .byte $00 ; 03 - disappears
    .byte $00 ; 04 - same as 3
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - crawler
    .byte $00 ; 07 - gamet
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - lava jumper
    .byte $00 ; 0C - bouncy orb
    .byte $C | (1 << 7) ; 0D - dragon
    .byte $00 ; 0E - rock launcher thing
    .byte $00 ; 0F - same as 3

EnemyInitDelayTbl:
    .byte $10 ; 00 - swooper has not seen samus
    .byte $01 ; 01 - swooper targetting samus
    .byte $01 ; 02 - ripper II
    .byte $01 ; 03 - disappears
    .byte $10 ; 04 - same as 3
    .byte $10 ; 05 - same as 3
    .byte $01 ; 06 - crawler
    .byte $08 ; 07 - gamet
    .byte $09 ; 08 - same as 3
    .byte $10 ; 09 - same as 3
    .byte $01 ; 0A - same as 3
    .byte $10 ; 0B - lava jumper
    .byte $01 ; 0C - bouncy orb
    .byte $20 ; 0D - dragon
    .byte $00 ; 0E - rock launcher thing
    .byte $00 ; 0F - same as 3

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice_GerutaIdle_{AREA} - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_GerutaAttacking_{AREA} - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_RipperII_{AREA} - EnemyMovementChoices ; 02 - ripper II
    .byte $00 ; 03 - disappears
    .byte $00 ; 04 - same as 3
    .byte $00 ; 05 - same as 3
    .byte EnemyMovementChoice_Gamet_{AREA} - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Gamet_{AREA} - EnemyMovementChoices ; 07 - gamet
    .byte $00 ; 08 - same as 3
    .byte EnemyMovementChoice02_{AREA} - EnemyMovementChoices ; 09 - same as 3
    .byte EnemyMovementChoice03_{AREA} - EnemyMovementChoices ; 0A - same as 3
    .byte EnemyMovementChoice_Squeept_{AREA} - EnemyMovementChoices ; 0B - lava jumper
    .byte EnemyMovementChoice_Multiviola_{AREA} - EnemyMovementChoices ; 0C - bouncy orb
    .byte EnemyMovementChoice_Dragon_{AREA} - EnemyMovementChoices ; 0D - dragon
    .byte EnemyMovementChoice_GerutaIdle_{AREA} - EnemyMovementChoices ; 0E - rock launcher thing (enemy doesn't move)
    .byte $00 ; 0F - same as 3

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
    .byte $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB, $FD, $00, $00, $00
EnSpeedXTable:
    .byte $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01, $01, $00, $01, $01, $03, $00, $00, $00

L977B:
    .byte %01001100 ; 00 - swooper has not seen samus
    .byte %01001100 ; 01 - swooper targetting samus
    .byte %00000001 ; 02 - ripper II
    .byte %00000000 ; 03 - disappears
    .byte %00000000 ; 04 - same as 3
    .byte %00000000 ; 05 - same as 3
    .byte %00000000 ; 06 - crawler
    .byte %01000000 ; 07 - gamet
    .byte %00000000 ; 08 - same as 3
    .byte %01100100 ; 09 - same as 3
    .byte %01000100 ; 0A - same as 3
    .byte %01000100 ; 0B - lava jumper
    .byte %01000000 ; 0C - bouncy orb
    .byte %00000000 ; 0D - dragon
    .byte %00000000 ; 0E - rock launcher thing
    .byte %00000000 ; 0F - same as 3

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_PolypRock_{AREA} - EnAnimTable_{AREA}, EnAnim_PolypRock_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_DragonEnProjectileUp_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonEnProjectileUp_L_{AREA} - EnAnimTable_{AREA}
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
EnemyMovementChoice_RipperII_{AREA}:
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Gamet_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice02_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice03_{AREA}: ; unused enemy
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice_Squeept_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola_{AREA}:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice_Dragon_{AREA}:
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_GerutaIdle_{AREA}: ; enemy doesn't move
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_GerutaAttacking_{AREA}:
    EnemyMovementChoiceEntry $01


EnemyMovement00_R_{AREA}:
EnemyMovement00_L_{AREA}:
EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
    ; nothing

; ripper II
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

; dragon
EnemyMovement11_R_{AREA}:
EnemyMovement11_L_{AREA}:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementDragon

EnProjectileMovement0_{AREA}:
    SignMagSpeed $0A,  3, -5
    SignMagSpeed $07,  3, -3
    SignMagSpeed $07,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $07,  3,  1
    SignMagSpeed $07,  3,  2
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
    L984D:
        ; enemy explode
        jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

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
    jmp UpdateEnemyCommon_Decide_{AREA}

    jsr CommonJump_EnemyFlipAfterDisplacement
    lda #$06
    sta $00
    jmp UpdateEnemyCommon_Decide_{AREA}

    jsr CommonJump_EnemyFlipAfterDisplacement
    lda #$06
    sta $00
    lda EnemyStatusPreAI
    cmp #enemyStatus_Active
    bne L9993
    cmp EnsExtra.0.status,x
    bne L9993
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    bne L9993
        jmp L984D
    L9993:
    jmp UpdateEnemyCommon_Decide_{AREA}

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

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

.include "enemies/squeept.asm"

;-------------------------------------------------------------------------------
; Bouncy Orb Routine (Multiviola?)
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------

.include "enemies/dragon.asm"

;-------------------------------------------------------------------------------

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
    .byte $75, $74

VRAMString0B_{AREA}:
    .byte $22
    .byte $76, $76
    .byte $76, $76

VRAMString0C_{AREA}:
VRAMString0D_{AREA}:
VRAMString0E_{AREA}:
VRAMString0F_{AREA}:
VRAMString10_{AREA}:
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

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "norfair/metatiles.asm"

;Not used.
    .byte $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/norfair.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/norfair.asm"
.endif

;Unused. (B099)
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $B9, $30, $3A, $3E, $B6, $42, $B9, $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A
    .byte $44, $48, $B4, $4C, $B3, $48, $46, $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2
    .byte $44, $B9, $44, $4C, $52, $B4, $54, $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9
    .byte $26, $3E, $34, $B2, $26, $B9, $26, $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2
    .byte $2C, $B9, $2C, $3A, $2C, $FF, $C4, $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9
    .byte $18, $26, $18, $B2, $18, $FF, $C2, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9
    .byte $1E, $18, $1E, $B2, $1C, $B9, $1C, $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF
    .byte $B2, $26, $12, $16, $18, $1C, $20, $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2
    .byte $10, $B9, $30, $2C, $28, $B2, $1E, $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9
    .byte $2A, $FF, $E8, $B2, $04, $04, $04, $B9, $04, $04, $04, $FF
    
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        .incbin "tourian/bg_chr.chr" skip $495 read $CB
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "tourian/bg_chr_cnsus.chr" skip $495 read $CB
    .endif
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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
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

