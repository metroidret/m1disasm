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

SpecItmsTblPtr:
    .word SpecItmsTbl               ;($A2D9)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable              ;($A21B)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable            ;($A277)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs              ;($AEEC)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1          ;($9C64)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2          ;($9D64)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable           ;($9D78)Pointers to enemy frame placement data.
    EnAnimTable:       .word EnAnimTable               ;($9BDA)Index to values in addr tables for enemy animations.
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

AreaMapPosX:
    .byte $16   ;Samus start x coord on world map.
AreaMapPosY:
    .byte $0D   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette00+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled - EnAnimTable
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion - EnAnimTable
; EnProjectile rising?
    .byte EnAnim_DragonEnProjectileUp_R - EnAnimTable, EnAnim_DragonEnProjectileUp_L - EnAnimTable
AreaEnProjectileFallingAnimIndex:
    .byte EnAnim_DragonEnProjectileDown_R - EnAnimTable, EnAnim_DragonEnProjectileDown_L - EnAnimTable
AreaEnProjectileSplatterAnimIndex:
    .byte EnAnim_DragonEnProjectileSplatter - EnAnimTable, EnAnim_PolypRockShatter - EnAnimTable
AreaMellowAnimIndex:
    .byte EnAnim_Mella - EnAnimTable

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine00 ; 00 - swooper has not seen samus
        .word SwooperAIRoutine01 ; 01 - swooper targetting samus
        .word RipperAIRoutine ; 02 - ripper II
        .word RemoveEnemy_ ; 03 - disappears
        .word RemoveEnemy_ ; 04 - same as 3
        .word RemoveEnemy_ ; 05 - same as 3
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - gamet
        .word RemoveEnemy_ ; 08 - same as 3
        .word RemoveEnemy_ ; 09 - same as 3
        .word RemoveEnemy_ ; 0A - same as 3
        .word SqueeptAIRoutine ; 0B - lava jumper
        .word MultiviolaAIRoutine ; 0C - bouncy orb
        .word DragonAIRoutine ; 0D - dragon
        .word PolypAIRoutine ; 0E - rock launcher thing
        .word RemoveEnemy_ ; 0F - same as 3

EnemyDeathAnimIndex:
    .byte EnAnim_GerutaExplode - EnAnimTable, EnAnim_GerutaExplode - EnAnimTable ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaExplode - EnAnimTable, EnAnim_GerutaExplode - EnAnimTable ; 01 - swooper targetting samus
    .byte EnAnim_RipperIIExplode - EnAnimTable, EnAnim_RipperIIExplode - EnAnimTable ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaExplode - EnAnimTable, EnAnim_NovaExplode - EnAnimTable ; 06 - crawler
    .byte EnAnim_GametExplode_R - EnAnimTable, EnAnim_GametExplode_L - EnAnimTable ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyExplode - EnAnimTable, EnAnim_RidleyExplode - EnAnimTable ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R - EnAnimTable, EnAnim_RidleyFireball_L - EnAnimTable ; 0A - same as 3
    .byte EnAnim_SqueeptExplode - EnAnimTable, EnAnim_SqueeptExplode - EnAnimTable ; 0B - lava jumper
    .byte EnAnim_MultiviolaExplode - EnAnimTable, EnAnim_MultiviolaExplode - EnAnimTable ; 0C - bouncy orb
    .byte EnAnim_DragonExplode - EnAnimTable, EnAnim_DragonExplode - EnAnimTable ; 0D - dragon
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
    .byte EnAnim_GerutaIdle - EnAnimTable, EnAnim_GerutaIdle - EnAnimTable ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaIdle - EnAnimTable, EnAnim_GerutaIdle - EnAnimTable ; 01 - swooper targetting samus
    .byte EnAnim_RipperII_R - EnAnimTable, EnAnim_RipperII_L - EnAnimTable ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaOnFloor - EnAnimTable, EnAnim_NovaOnFloor - EnAnimTable ; 06 - crawler
    .byte EnAnim_GametResting_R - EnAnimTable, EnAnim_GametResting_L - EnAnimTable ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyIdle_R - EnAnimTable, EnAnim_RidleyIdle_L - EnAnimTable ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R - EnAnimTable, EnAnim_RidleyFireball_L - EnAnimTable ; 0A - same as 3
    .byte EnAnim_SqueeptFalling - EnAnimTable, EnAnim_SqueeptFalling - EnAnimTable ; 0B - lava jumper
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTable, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTable ; 0C - bouncy orb
    .byte EnAnim_DragonIdle_R - EnAnimTable, EnAnim_DragonIdle_L - EnAnimTable ; 0D - dragon
    .byte $00, $00 ; 0E - undefined for polyp, because it is invisible at all times
    .byte $00, $00 ; 0F - same as 3

EnemyActiveAnimIndex:
    .byte EnAnim_GerutaSwooping - EnAnimTable, EnAnim_GerutaSwooping - EnAnimTable ; 00 - swooper has not seen samus
    .byte EnAnim_GerutaSwooping - EnAnimTable, EnAnim_GerutaSwooping - EnAnimTable ; 01 - swooper targetting samus
    .byte EnAnim_RipperII_R - EnAnimTable, EnAnim_RipperII_L - EnAnimTable ; 02 - ripper II
    .byte $00, $00 ; 03 - disappears
    .byte $00, $00 ; 04 - same as 3
    .byte $00, $00 ; 05 - same as 3
    .byte EnAnim_NovaOnFloor - EnAnimTable, EnAnim_NovaOnFloor - EnAnimTable ; 06 - crawler
    .byte EnAnim_GametActive_R - EnAnimTable, EnAnim_GametActive_L - EnAnimTable ; 07 - gamet
    .byte $00, $00 ; 08 - same as 3
    .byte EnAnim_RidleyIdle_R - EnAnimTable, EnAnim_RidleyIdle_L - EnAnimTable ; 09 - same as 3
    .byte EnAnim_RidleyFireball_R - EnAnimTable, EnAnim_RidleyFireball_L - EnAnimTable ; 0A - same as 3
    .byte EnAnim_SqueeptJumping - EnAnimTable, EnAnim_SqueeptJumping - EnAnimTable ; 0B - lava jumper
    .byte EnAnim_MultiviolaSpinningClockwise - EnAnimTable, EnAnim_MultiviolaSpinningCounterclockwise - EnAnimTable ; 0C - bouncy orb
    .byte EnAnim_DragonIdle_R - EnAnimTable, EnAnim_DragonIdle_L - EnAnimTable ; 0D - dragon
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
    .byte EnemyMovementChoice_GerutaIdle - EnemyMovementChoices ; 00 - swooper has not seen samus
    .byte EnemyMovementChoice_GerutaAttacking - EnemyMovementChoices ; 01 - swooper targetting samus
    .byte EnemyMovementChoice_RipperII - EnemyMovementChoices ; 02 - ripper II
    .byte $00 ; 03 - disappears
    .byte $00 ; 04 - same as 3
    .byte $00 ; 05 - same as 3
    .byte EnemyMovementChoice_Gamet - EnemyMovementChoices ; 06 - crawler (enemy moves manually)
    .byte EnemyMovementChoice_Gamet - EnemyMovementChoices ; 07 - gamet
    .byte $00 ; 08 - same as 3
    .byte EnemyMovementChoice02 - EnemyMovementChoices ; 09 - same as 3
    .byte EnemyMovementChoice03 - EnemyMovementChoices ; 0A - same as 3
    .byte EnemyMovementChoice_Squeept - EnemyMovementChoices ; 0B - lava jumper
    .byte EnemyMovementChoice_Multiviola - EnemyMovementChoices ; 0C - bouncy orb
    .byte EnemyMovementChoice_Dragon - EnemyMovementChoices ; 0D - dragon
    .byte EnemyMovementChoice_GerutaIdle - EnemyMovementChoices ; 0E - rock launcher thing (enemy doesn't move)
    .byte $00 ; 0F - same as 3

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
    .byte EnAnim_PolypRock - EnAnimTable, EnAnim_PolypRock - EnAnimTable
    .byte EnAnim_DragonEnProjectileUp_R - EnAnimTable, EnAnim_DragonEnProjectileUp_L - EnAnimTable
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
    .word EnProjectileMovement0
    .word EnProjectileMovement1
    .word EnProjectileMovement2
    .word EnProjectileMovement3

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
EnemyMovementChoice_RipperII:
    EnemyMovementChoiceEntry $02
EnemyMovementChoice_Gamet: ; enemy moves manually
    EnemyMovementChoiceEntry $09
EnemyMovementChoice02: ; unused enemy
    EnemyMovementChoiceEntry $0D
EnemyMovementChoice03: ; unused enemy
    EnemyMovementChoiceEntry $0E, $0F
EnemyMovementChoice_Squeept: ; enemy moves manually
    EnemyMovementChoiceEntry $00, $01, $02, $03
EnemyMovementChoice_Multiviola:
    EnemyMovementChoiceEntry $10
EnemyMovementChoice_Dragon:
    EnemyMovementChoiceEntry $11
EnemyMovementChoice_GerutaIdle: ; enemy doesn't move
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_GerutaAttacking:
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

; dragon
EnemyMovement11_R:
EnemyMovement11_L:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    EnemyMovementInstr_StopMovementDragon

EnProjectileMovement0:
    SignMagSpeed $0A,  3, -5
    SignMagSpeed $07,  3, -3
    SignMagSpeed $07,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $07,  3,  1
    SignMagSpeed $07,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

EnProjectileMovement1:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement2:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement3:
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
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

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

.include "enemies/squeept.asm"

;-------------------------------------------------------------------------------
; Bouncy Orb Routine (Multiviola?)
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------

.include "enemies/dragon.asm"

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

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "norfair/metatiles.asm"

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

