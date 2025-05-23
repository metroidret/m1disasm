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

BANK .set 2
.segment "BANK_02_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GFX_NorfairSprites
.export GFX_TourianSprites

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Norfair enemy tile patterns.
GFX_NorfairSprites:
    .incbin "norfair/sprite_tiles.chr"

;Tourian enemy tile patterns.
GFX_TourianSprites:
    .incbin "tourian/sprite_tiles.chr"

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A178)
    .word Palette01                 ;($A19C)
    .word Palette02                 ;($A1A8)
    .word Palette03                 ;($A1A2)
    .word Palette04                 ;($A1AE)
    .word Palette05                 ;($A1B4)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette06                 ;($A1D7)
    .word Palette07                 ;($A1DE)
    .word Palette08                 ;($A1E5)
    .word Palette09                 ;($A1EC)
    .word Palette0A                 ;($A1F3)
    .word Palette0B                 ;($A1FB)
    .word Palette0C                 ;($A203)
    .word Palette0D                 ;($A20B)
    .word Palette0E                 ;($A213)

AreaPointers:
    .word SpecItmsTbl               ;($A2D9)Beginning of special items table.
    .word RmPtrTbl                  ;($A21B)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A277)Beginning of structure pointer table.
    .word MacroDefs                 ;($AEEC)Beginning of macro definitions.
    .word EnFramePtrTable1         ;($9C64)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2         ;($9D64)tables needed to accommodate all entries.
    .word EnPlacePtrTable          ;($9D78)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($9BDA)Index to values in addr tables for enemy animations.

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
    .byte $08                       ;Norfair music init flag.
AreaEnemyDamage:
    .word $0100                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $10, $05, $27, $04, $0F, $FF, $FF

AreaSamusMapPosX:
    .byte $16   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $0D   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte $01

    .byte $00
AreaFireballAnimIndex:
    .byte EnemyAnim_9BDD - EnemyAnimIndexTbl
AreaExplosionAnimIndex:
    .byte EnemyAnim_9C51 - EnemyAnimIndexTbl

    .byte $53, $57

    .byte $55, $59

    .byte $5B, $4F
AreaMellowAnimIndex:
    .byte EnemyAnim_9C0C - EnemyAnimIndexTbl

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnType,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine ; 00 - swooper
        .word SwooperAIRoutine2 ; 01 - becomes swooper?
        .word RipperAIRoutine ; 02 - ripper
        .word InvalidEnemy ; 03 - disappears
        .word InvalidEnemy ; 04 - same as 3
        .word InvalidEnemy ; 05 - same as 3
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - gamet
        .word InvalidEnemy ; 08 - same as 3
        .word InvalidEnemy ; 09 - same as 3
        .word InvalidEnemy ; 0A - same as 3
        .word SqueeptAIRoutine ; 0B - lava jumper
        .word MultiviolaAIRoutine ; 0C - bouncy orb
        .word SeahorseAIRoutine ; 0D - seahorse
        .word PolypAIRoutine ; 0E - rock launcher thing
        .word InvalidEnemy ; 0F - same as 3

L960B:
    .byte $28, $28, $28, $28, $30, $30, $00, $00, $00, $00, $00, $00, $75, $75, $84, $82
    .byte $00, $00, $11, $11, $13, $18, $35, $35, $41, $41, $4B, $4B, $00, $00, $00, $00

EnemyHitPointTbl:
    .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

L963B:
    .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86
    .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00

L965B:
    .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C
    .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00

L967B:
    .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:
    .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:
    .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00

EnemyInitDelayTbl:
    .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:
    .byte $12, $14, $00, $00, $00, $00, $02, $02, $00, $04, $06, $09, $0E, $10, $12, $00

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

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01
L9773:  .byte $01, $00, $01, $01, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $4D, $4D, $53, $57, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8

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

L97D1:  .byte $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03, $00, $01, $02, $03, $00, $10
L97E1:  .byte $00, $11, $00, $00, $00, $01

EnemyMovement00:
EnemyMovement01:
EnemyMovement02:
EnemyMovement03:
EnemyMovement04:
    SignMagSpeed $01,  3,  0
    .byte $FF

EnemyMovement05:
    SignMagSpeed $01, -3,  0
    .byte $FF

EnemyMovement06:
EnemyMovement07:
EnemyMovement08:
EnemyMovement09:
EnemyMovement0A:
EnemyMovement0B:
EnemyMovement0C:
EnemyMovement0D:
EnemyMovement0E:
EnemyMovement0F:
EnemyMovement10:
EnemyMovement11:
EnemyMovement12:
EnemyMovement13:
EnemyMovement14:
EnemyMovement15:
EnemyMovement16:
EnemyMovement17:
EnemyMovement18:
EnemyMovement19:
EnemyMovement1A:
EnemyMovement1B:
EnemyMovement1C:
EnemyMovement1D:
EnemyMovement1E:
EnemyMovement1F:
EnemyMovement20:
EnemyMovement21:
EnemyMovement22:
EnemyMovement23:
    SignMagSpeed $14,  0, -1
    SignMagSpeed $0A,  0,  0
    .byte $FD
    SignMagSpeed $30,  0,  0
    SignMagSpeed $14,  0,  1
    .byte $FA

EnemyFireballMovement0:
    SignMagSpeed $0A,  3, -5
    SignMagSpeed $07,  3, -3
    SignMagSpeed $07,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $07,  3,  1
    SignMagSpeed $07,  3,  2
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

;-------------------------------------------------------------------------------
InvalidEnemy:
    lda #$00
    sta EnStatus,x
    rts

CommonEnemyJump_00_01_02:
    lda EnemyMovementPtr
    cmp #$01
    beq L9848
    cmp #$03
    beq L984D
        lda $00
        jmp CommonJump_00
    L9848:
        lda $01
        jmp CommonJump_01
    L984D:
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
    jsr CommonJump_09
    lda #$06
    sta $00
    jmp CommonEnemyJump_00_01_02
    jsr CommonJump_09
    lda #$06
    sta $00
    jmp CommonEnemyJump_00_01_02
    jsr CommonJump_09
    lda #$06
    sta $00
    lda EnemyMovementPtr
    cmp #$02
    bne L9993
    cmp EnStatus,x
    bne L9993
    jsr CommonJump_03
    and #$03
    bne L9993
    jmp L984D
L9993:
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

StorePositionToTemp:
    lda EnY,x
    sta $08
    lda EnX,x
    sta $09
    lda EnHi,x
    sta $0B
    rts

LoadPositionFromTemp:
    lda $0B
    and #$01
    sta EnHi,x
    lda $08
    sta EnY,x
    lda $09
    sta EnX,x
    rts

;-------------------------------------------------------------------------------

.include "enemies/squeept.asm"

;-------------------------------------------------------------------------------
; Bouncy Orb Routine (Multiviola?)
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------

.include "enemies/seahorse.asm"

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

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "norfair/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.include "songs/norfair.asm"

;Unused. (B099)
    .byte $B9, $30, $3A, $3E, $B6, $42, $B9, $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A
    .byte $44, $48, $B4, $4C, $B3, $48, $46, $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2
    .byte $44, $B9, $44, $4C, $52, $B4, $54, $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9
    .byte $26, $3E, $34, $B2, $26, $B9, $26, $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2
    .byte $2C, $B9, $2C, $3A, $2C, $FF, $C4, $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9
    .byte $18, $26, $18, $B2, $18, $FF, $C2, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9
    .byte $1E, $18, $1E, $B2, $1C, $B9, $1C, $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF
    .byte $B2, $26, $12, $16, $18, $1C, $20, $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2
    .byte $10, $B9, $30, $2C, $28, $B2, $1E, $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9
    .byte $2A, $FF, $E8, $B2, $04, $04, $04, $B9, $04, $04, $04, $FF, $E0, $E0, $F0, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05, $26, $52, $63, $00
    .byte $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B, $8D, $A7, $B1, $00
    .byte $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0, $F0, $F8, $FC, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07, $03, $03, $01, $00
    .byte $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7, $CF, $FE, $EC, $00
    .byte $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9, $1E, $0E, $44, $07
    .byte $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B
    .byte $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF, $C7, $00
    .byte $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $80
    .byte $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A
    .byte $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8
    .byte $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_02_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
