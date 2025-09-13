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
    .incbin "ending/sprite_tiles.chr"

;Unused tile patterns (needed so the Palette Pointer Table, etc. below are properly aligned)
GFX_KraiUnused:
    .incbin "kraid/unused_tiles.chr"

GFX_KraiBG3:
    .incbin "kraid/bg_chr_3.chr" ; 9360 - Misc Kraid BG CHR

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntry PalPntrTbl, Palette00                 ;($A155)Room palette.
    PtrTableEntry PalPntrTbl, Palette01                 ;($A179)Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette02                 ;($A185)Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette03                 ;($A17F)Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette04                 ;($A18B)Samus varia suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette05                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette06                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette07                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette08                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette09                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0A                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0B                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0C                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0D                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0E                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette0F                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette10                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette11                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette12                 ;($A191)
    PtrTableEntry PalPntrTbl, Palette13                 ;($A191)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntry PalPntrTbl, Palette14                 ;($A198)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette15                 ;($A19F)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette16                 ;($A1A6)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette17                 ;($A1AD)Unused?
    PtrTableEntry PalPntrTbl, Palette18                 ;($A1B5)Suitless Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette19                 ;($A1BD)Suitless Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette1A                 ;($A1C5)Suitless Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette1B                 ;($A1CD)Suitless Samus varia suit with missiles selected palette.

AreaPointers:
    .word SpecItmsTbl               ;($A26D)Beginning of special items table.
    .word RmPtrTbl                  ;($A1D5)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A21F)Beginning of structure pointer table.
    .word MacroDefs                 ;($AC32)Beginning of macro definitions.
    .word EnFramePtrTable1          ;($9CF7)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2          ;($9DF7)tables needed to accommodate all entries.
    .word EnPlacePtrTable           ;($9E25)Pointers to enemy frame placement data.
    .word EnAnimTbl                 ;($9C86)Index to values in addr tables for enemy animations.

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
AreaFireballKilledAnimIndex:
    .byte EnAnim_FireballKilled - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion - EnAnimTbl

    .byte $00, $00
AreaFireballFallingAnimIndex:
    .byte $00, $00
AreaFireballSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_Memu - EnAnimTbl

ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine ; 00 - sidehopper
        .word SidehopperCeilingAIRoutine ; 01 - ceiling sidehopper
        .word RTS_95CB ; 02 - unused enemy type that doesn't properly clear itself
        .word RipperAIRoutine ; 03 - ripper
        .word SkreeAIRoutine ; 04 - skree
        .word CrawlerAIRoutine ; 05 - crawler
        .word RTS_95CB ; 06 - same as 2
        .word PipeBugAIRoutine ; 07 - geega
        .word KraidAIRoutine ; 08 - kraid
        .word KraidLintAIRoutine ; 09 - kraid lint
        .word KraidNailAIRoutine ; 0A - kraid nail
        .word RTS_95CB ; 0B - same as 2
        .word RTS_95CB ; 0C - same as 2
        .word RTS_95CB ; 0D - same as 2
        .word RTS_95CB ; 0E - same as 2
        .word RTS_95CB ; 0F - same as 2

EnemyDeathAnimIndex:
    .byte EnAnim_SidehopperFloorExplode - EnAnimTbl, EnAnim_SidehopperFloorExplode - EnAnimTbl ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingExplode - EnAnimTbl, EnAnim_SidehopperCeilingExplode - EnAnimTbl ; 01 - ceiling sidehopper
    .byte EnAnim_WaverExplodeFacingRight - EnAnimTbl, EnAnim_WaverExplodeFacingLeft - EnAnimTbl ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_RipperExplodeFacingRight - EnAnimTbl, EnAnim_RipperExplodeFacingLeft - EnAnimTbl ; 03 - ripper
    .byte EnAnim_SkreeExplode - EnAnimTbl, EnAnim_SkreeExplode - EnAnimTbl ; 04 - skree
    .byte EnAnim_ZeelaExplode - EnAnimTbl, EnAnim_ZeelaExplode - EnAnimTbl ; 05 - crawler
    .byte EnAnim_GeegaFacingLeft - EnAnimTbl, EnAnim_GeegaFacingLeft - EnAnimTbl ; 06 - same as 2
    .byte EnAnim_GeegaExplodeFacingRight - EnAnimTbl, EnAnim_GeegaExplodeFacingLeft - EnAnimTbl ; 07 - geega
    .byte EnAnim_KraidExplodeFacingRight - EnAnimTbl, EnAnim_KraidExplodeFacingLeft - EnAnimTbl ; 08 - kraid
    .byte $00, $00 ; 09 - kraid lint
    .byte $00, $00 ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0C - same as 2
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
    .byte EnAnim_SidehopperFloorIdle - EnAnimTbl, EnAnim_SidehopperFloorIdle - EnAnimTbl ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle - EnAnimTbl, EnAnim_SidehopperCeilingIdle - EnAnimTbl ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0FacingRight - EnAnimTbl, EnAnim_Waver0FacingLeft - EnAnimTbl ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_RipperFacingRight - EnAnimTbl, EnAnim_RipperFacingLeft - EnAnimTbl ; 03 - ripper
    .byte EnAnim_Skree - EnAnimTbl, EnAnim_Skree - EnAnimTbl ; 04 - skree
    .byte EnAnim_ZeelaOnFloor - EnAnimTbl, EnAnim_ZeelaOnFloor - EnAnimTbl ; 05 - crawler
    .byte EnAnim_GeegaFacingLeft - EnAnimTbl, EnAnim_GeegaFacingLeft - EnAnimTbl ; 06 - same as 2
    .byte EnAnim_GeegaRestingFacingRight - EnAnimTbl, EnAnim_GeegaRestingFacingLeft - EnAnimTbl ; 07 - geega
    .byte EnAnim_KraidFacingRight - EnAnimTbl, EnAnim_KraidFacingLeft - EnAnimTbl ; 08 - kraid
    .byte EnAnim_KraidLintFacingRight - EnAnimTbl, EnAnim_KraidLintFacingLeft - EnAnimTbl ; 09 - kraid lint
    .byte EnAnim_KraidNailIdleFacingRight - EnAnimTbl, EnAnim_KraidNailIdleFacingLeft - EnAnimTbl ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0C - same as 2
    .byte $00, $00 ; 0D - same as 2
    .byte $00, $00 ; 0E - same as 2
    .byte $00, $00 ; 0F - same as 2

EnemyActiveAnimIndex:
    .byte EnAnim_SidehopperFloorIdle - EnAnimTbl, EnAnim_SidehopperFloorIdle - EnAnimTbl ; 00 - sidehopper
    .byte EnAnim_SidehopperCeilingIdle - EnAnimTbl, EnAnim_SidehopperCeilingIdle - EnAnimTbl ; 01 - ceiling sidehopper
    .byte EnAnim_Waver0FacingRight - EnAnimTbl, EnAnim_Waver0FacingLeft - EnAnimTbl ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnAnim_RipperFacingRight - EnAnimTbl, EnAnim_RipperFacingLeft - EnAnimTbl ; 03 - ripper
    .byte EnAnim_Skree - EnAnimTbl, EnAnim_Skree - EnAnimTbl ; 04 - skree
    .byte EnAnim_ZeelaOnFloor - EnAnimTbl, EnAnim_ZeelaOnFloor - EnAnimTbl ; 05 - crawler
    .byte EnAnim_GeegaFacingLeft - EnAnimTbl, EnAnim_GeegaFacingLeft - EnAnimTbl ; 06 - same as 2
    .byte EnAnim_GeegaFacingRight - EnAnimTbl, EnAnim_GeegaFacingLeft - EnAnimTbl ; 07 - geega
    .byte EnAnim_KraidFacingRight - EnAnimTbl, EnAnim_KraidFacingLeft - EnAnimTbl ; 08 - kraid
    .byte EnAnim_KraidLintFacingRight - EnAnimTbl, EnAnim_KraidLintFacingLeft - EnAnimTbl ; 09 - kraid lint
    .byte EnAnim_KraidNailMovingFacingRight - EnAnimTbl, EnAnim_KraidNailMovingFacingLeft - EnAnimTbl ; 0A - kraid nail
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0B - same as 2
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl ; 0C - same as 2
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
    .byte EnemyMovementChoice_SidehopperFloor - EnemyMovementChoices ; 00 - sidehopper
    .byte EnemyMovementChoice_SidehopperCeiling - EnemyMovementChoices ; 01 - ceiling sidehopper
    .byte $00 ; 02 - unused enemy type that doesn't properly clear itself
    .byte EnemyMovementChoice_Ripper - EnemyMovementChoices ; 03 - ripper
    .byte EnemyMovementChoice_Skree - EnemyMovementChoices ; 04 - skree
    .byte EnemyMovementChoice_Zeela - EnemyMovementChoices ; 05 - crawler (enemy moves manually)
    .byte $00 ; 06 - same as 2
    .byte EnemyMovementChoice_Geega - EnemyMovementChoices ; 07 - geega
    .byte EnemyMovementChoice_Kraid - EnemyMovementChoices ; 08 - kraid
    .byte EnemyMovementChoice_KraidLint - EnemyMovementChoices ; 09 - kraid lint
    .byte EnemyMovementChoice_KraidNail - EnemyMovementChoices ; 0A - kraid nail
    .byte $00 ; 0B - same as 2
    .byte $00 ; 0C - same as 2
    .byte $00 ; 0D - same as 2
    .byte $00 ; 0E - same as 2
    .byte $00 ; 0F - same as 2

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

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_KraidNailMovingFacingLeft - EnAnimTbl, EnAnim_KraidNailIdleFacingLeft - EnAnimTbl
    .byte EnAnim_Memu - EnAnimTbl, EnAnim_Memu - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetX:
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetY:
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

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
EnemyMovementChoice_SidehopperFloor:
    EnemyMovementChoiceEntry $01, $02
EnemyMovementChoice_SidehopperCeiling:
    EnemyMovementChoiceEntry $03, $04
EnemyMovementChoice_Ripper:
    EnemyMovementChoiceEntry $06
EnemyMovementChoice_Skree:
    EnemyMovementChoiceEntry $07
EnemyMovementChoice_Geega:
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Zeela: ; enemy moves manually
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_Kraid:
    EnemyMovementChoiceEntry $0C, $0D
EnemyMovementChoice_KraidLint:
    EnemyMovementChoiceEntry $0E
EnemyMovementChoice_KraidNail:
    EnemyMovementChoiceEntry $0F, $10, $11, $0F

; unused (???)
EnemyMovement00_R:
    SignMagSpeed $20,  2,  2
    EnemyMovementInstr_FE

EnemyMovement00_L:
    SignMagSpeed $20, -2,  2
    EnemyMovementInstr_FE

EnemyMovement01_R:
EnemyMovement01_L:
EnemyMovement02_R:
EnemyMovement02_L:
EnemyMovement03_R:
EnemyMovement03_L:
EnemyMovement04_R:
EnemyMovement04_L:
EnemyMovement05_R:
EnemyMovement05_L:
    ; nothing

; ripper
EnemyMovement06_R:
    SignMagSpeed $01,  1,  0
    EnemyMovementInstr_Restart

EnemyMovement06_L:
    SignMagSpeed $01, -1,  0
    EnemyMovementInstr_Restart

; skree
EnemyMovement07_R:
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

EnemyMovement07_L:
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

EnemyMovement08_R:
EnemyMovement08_L:
EnemyMovement09_R:
EnemyMovement09_L:
EnemyMovement0A_R:
EnemyMovement0A_L:
EnemyMovement0B_R:
EnemyMovement0B_L:
    ; nothing

; kraid
EnemyMovement0C_R:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0C_L:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_R:
    SignMagSpeed $32,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_L:
    SignMagSpeed $32, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32,  1,  1
    EnemyMovementInstr_FE

; kraid lint
EnemyMovement0E_R:
    SignMagSpeed $50,  4,  0
    EnemyMovementInstr_Restart

EnemyMovement0E_L:
    SignMagSpeed $50, -4,  0
    EnemyMovementInstr_Restart

; kraid nail
EnemyMovement0F_R:
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

EnemyMovement0F_L:
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

EnemyMovement10_R:
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

EnemyMovement10_L:
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

EnemyMovement11_R:
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

EnemyMovement11_L:
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

EnemyFireballMovement0:
    SignMagSpeed $04,  3, -3
    SignMagSpeed $05,  3, -2
    SignMagSpeed $06,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $06,  3,  1
    SignMagSpeed $05,  3,  2
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

AreaRoutineStub:
    rts

; What's this table?
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

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "kraid/metatiles.asm"

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

