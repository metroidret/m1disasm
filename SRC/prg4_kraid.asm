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

BANK .set 4
.segment "BANK_04_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GFX_EndingSprites
.export GFX_KraiBG3

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Samus end tile patterns.
GFX_EndingSprites:
    .incbin "ending/sprite_tiles.chr"

;Unused tile patterns (needed so the Palette Pointer Table, etc. below are properly aligned)
    .incbin "kraid/unused_tiles.chr"

GFX_KraiBG3:
    .incbin "kraid/bg_chr_3.chr" ; 9360 - Misc Kraid BG CHR

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A155)
    .word Palette01                 ;($A179)
    .word Palette02                 ;($A185)
    .word Palette03                 ;($A17F)
    .word Palette04                 ;($A18B)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette05                 ;($A191)
    .word Palette06                 ;($A198)
    .word Palette07                 ;($A19F)
    .word Palette08                 ;($A1A6)
    .word Palette09                 ;($A1AD)
    .word Palette0A                 ;($A1B5)
    .word Palette0B                 ;($A1BD)
    .word Palette0C                 ;($A1C5)
    .word Palette0D                 ;($A1CD)

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
    .byte $10                       ;Kraid's hideout music init flag.
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
    .byte $06

    .byte $00
AreaFireballAnimIndex:
    .byte EnAnim_9C89 - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_9CC9 - EnAnimTbl

    .byte $00, $00
AreaFireballFallingAnimIndex:
    .byte $00, $00
AreaFireballSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_9CEA - EnAnimTbl

ChooseEnemyAIRoutine:
    lda EnType,x
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
        .word KraidLintAIRoutine ; 09 - kraid projectile? lint or nail?
        .word KraidNailAIRoutine ; 0a - kraid projectile?
        .word RTS_95CB ; 0b - same as 2
        .word RTS_95CB ; 0c - same as 2
        .word RTS_95CB ; 0d - same as 2
        .word RTS_95CB ; 0e - same as 2
        .word RTS_95CB ; 0f - same as 2

EnemyDeathAnimIndex:
    .byte EnAnim_9CAD - EnAnimTbl, EnAnim_9CAD - EnAnimTbl
    .byte EnAnim_9CAF - EnAnimTbl, EnAnim_9CAF - EnAnimTbl
    .byte EnAnim_9CB3 - EnAnimTbl, EnAnim_9CB1 - EnAnimTbl
    .byte EnAnim_9CB7 - EnAnimTbl, EnAnim_9CB5 - EnAnimTbl
    .byte EnAnim_9CB9 - EnAnimTbl, EnAnim_9CB9 - EnAnimTbl
    .byte EnAnim_9CC7 - EnAnimTbl, EnAnim_9CC7 - EnAnimTbl
    .byte EnAnim_9CCE - EnAnimTbl, EnAnim_9CCE - EnAnimTbl
    .byte EnAnim_9CD6 - EnAnimTbl, EnAnim_9CD4 - EnAnimTbl
    .byte EnAnim_9CF3 - EnAnimTbl, EnAnim_9CF5 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

EnemyHitPointTbl:
    .byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

EnemyAnimIndex_963B:
    .byte EnAnim_9C8B - EnAnimTbl, EnAnim_9C8B - EnAnimTbl
    .byte EnAnim_9C91 - EnAnimTbl, EnAnim_9C91 - EnAnimTbl
    .byte EnAnim_9C9D - EnAnimTbl, EnAnim_9C99 - EnAnimTbl
    .byte EnAnim_9CA1 - EnAnimTbl, EnAnim_9C9F - EnAnimTbl
    .byte EnAnim_9CA9 - EnAnimTbl, EnAnim_9CA9 - EnAnimTbl
    .byte EnAnim_9CBB - EnAnimTbl, EnAnim_9CBB - EnAnimTbl
    .byte EnAnim_9CCE - EnAnimTbl, EnAnim_9CCE - EnAnimTbl
    .byte EnAnim_9CDA - EnAnimTbl, EnAnim_9CD8 - EnAnimTbl
    .byte EnAnim_9CED - EnAnimTbl, EnAnim_9CF0 - EnAnimTbl
    .byte EnAnim_9CDC - EnAnimTbl, EnAnim_9CDE - EnAnimTbl
    .byte EnAnim_9CE3 - EnAnimTbl, EnAnim_9CE8 - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

EnemyAnimIndex_965B:
    .byte EnAnim_9C8B - EnAnimTbl, EnAnim_9C8B - EnAnimTbl
    .byte EnAnim_9C91 - EnAnimTbl, EnAnim_9C91 - EnAnimTbl
    .byte EnAnim_9C9D - EnAnimTbl, EnAnim_9C99 - EnAnimTbl
    .byte EnAnim_9CA1 - EnAnimTbl, EnAnim_9C9F - EnAnimTbl
    .byte EnAnim_9CA9 - EnAnimTbl, EnAnim_9CA9 - EnAnimTbl
    .byte EnAnim_9CBB - EnAnimTbl, EnAnim_9CBB - EnAnimTbl
    .byte EnAnim_9CCE - EnAnimTbl, EnAnim_9CCE - EnAnimTbl
    .byte EnAnim_9CD1 - EnAnimTbl, EnAnim_9CCE - EnAnimTbl
    .byte EnAnim_9CED - EnAnimTbl, EnAnim_9CF0 - EnAnimTbl
    .byte EnAnim_9CDC - EnAnimTbl, EnAnim_9CDE - EnAnimTbl
    .byte EnAnim_9CE0 - EnAnimTbl, EnAnim_9CE5 - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

L967B:
    .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

L968B:
    .byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

EnemyData0DTbl:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

L96AB:
    .byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl:
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:
    .byte $00, $03, $00, $06, $08, $0C, $00, $0A, $0E, $11, $13, $00, $00, $00, $00, $00

EnemyMovementPtrs:
    .word EnemyMovement00
    .word EnemyMovement01
    .word EnemyMovement02
    .word EnemyMovement03
    .word EnemyMovement04
    .word EnemyMovement05
    .word EnemyMovement06
    .word EnemyMovement07
    .word EnemyMovement08
    .word EnemyMovement09
    .word EnemyMovement0A
    .word EnemyMovement0B
    .word EnemyMovement0C
    .word EnemyMovement0D
    .word EnemyMovement0E
    .word EnemyMovement0F
    .word EnemyMovement10
    .word EnemyMovement11
    .word EnemyMovement12
    .word EnemyMovement13
    .word EnemyMovement14
    .word EnemyMovement15
    .word EnemyMovement16
    .word EnemyMovement17
    .word EnemyMovement18
    .word EnemyMovement19
    .word EnemyMovement1A
    .word EnemyMovement1B
    .word EnemyMovement1C
    .word EnemyMovement1D
    .word EnemyMovement1E
    .word EnemyMovement1F
    .word EnemyMovement20
    .word EnemyMovement21
    .word EnemyMovement22
    .word EnemyMovement23

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $70, $70, $90, $90, $00, $00, $7F
L9733:  .byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_9CE5 - EnAnimTbl, EnAnim_9CE8 - EnAnimTbl
    .byte EnAnim_9CEA - EnAnimTbl, EnAnim_9CEA - EnAnimTbl
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

L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $06, $00, $07, $00, $09, $00, $00, $01, $0C
L97E1:  .byte $0D, $00, $0E, $03, $0F, $10, $11, $0F

EnemyMovement00:
    SignMagSpeed $20,  2,  2
    .byte $FE

EnemyMovement01:
    SignMagSpeed $20, -2,  2
    .byte $FE

EnemyMovement02:
EnemyMovement03:
EnemyMovement04:
EnemyMovement05:
EnemyMovement06:
EnemyMovement07:
EnemyMovement08:
EnemyMovement09:
EnemyMovement0A:
EnemyMovement0B:
EnemyMovement0C:
    SignMagSpeed $01,  1,  0
    .byte $FF

EnemyMovement0D:
    SignMagSpeed $01, -1,  0
    .byte $FF

EnemyMovement0E:
    SignMagSpeed $04,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  6
    SignMagSpeed $01,  2,  4
    SignMagSpeed $04,  2,  6
    .byte $FC, $01, $00, $64, $00, $FB

EnemyMovement0F:
    SignMagSpeed $04, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  6
    SignMagSpeed $01, -2,  4
    SignMagSpeed $04, -2,  6
    .byte $FC, $01, $00, $64, $00, $FB

EnemyMovement10:
EnemyMovement11:
EnemyMovement12:
EnemyMovement13:
EnemyMovement14:
EnemyMovement15:
EnemyMovement16:
EnemyMovement17:
EnemyMovement18:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    .byte $FE

EnemyMovement19:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    .byte $FE

EnemyMovement1A:
    SignMagSpeed $32,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32, -1,  1
    .byte $FE

EnemyMovement1B:
    SignMagSpeed $32, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $32,  1,  1
    .byte $FE

EnemyMovement1C:
    SignMagSpeed $50,  4,  0
    .byte $FF

EnemyMovement1D:
    SignMagSpeed $50, -4,  0
    .byte $FF

EnemyMovement1E:
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
    .byte $FF

EnemyMovement1F:
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
    .byte $FF

EnemyMovement20:
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
    .byte $FF

EnemyMovement21:
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
    .byte $FF

EnemyMovement22:
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
    .byte $FF

EnemyMovement23:
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
    .byte $FF

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
    lda EnemyMovementPtr
    cmp #$01
    beq L9914
    cmp #$03
    beq L9919
        lda $00
        jmp CommonJump_00
    L9914:
        lda $01
        jmp CommonJump_01
    L9919:
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

.include "songs/ridley.asm"

.include "songs/kraid.asm"

;Not used.
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

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_04_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
