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

BANK .set 5
.segment "BANK_05_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GFX_CREBG1
.export GFX_TourianFont

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_CREBG1:
    .incbin "common_chr/bg_CRE.chr" ; 8D60 - Common Room Elements (loaded everywhere except Tourian)

GFX_TourianFont:
    .incbin "tourian/font_chr.chr" ; 91B0 - Game over, Japanese font tiles (only loaded in Tourian?)

;Unused tile patterns.
    .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A0EB)
    .word Palette01                 ;($A10F)
    .word Palette02                 ;($A11B)
    .word Palette03                 ;($A115)
    .word Palette04                 ;($A121)
    .word Palette05                 ;($A127)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette07                 ;($A142)
    .word Palette08                 ;($A149)
    .word Palette09                 ;($A150)
    .word Palette0A                 ;($A157)
    .word Palette0B                 ;($A15F)
    .word Palette0C                 ;($A167)
    .word Palette0D                 ;($A16F)
    .word Palette0E                 ;($A177)

AreaPointers:
    .word SpecItmsTbl               ;($A20D)Beginning of special items table.
    .word RmPtrTbl                  ;($A17F)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A1D3)Beginning of structure pointer table.
    .word MacroDefs                 ;($AB23)Beginning of macro definitions.
    .word EnFramePtrTable1         ;($9BF0)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2         ;($9CF0)tables needed to accommodate all entries.
    .word EnPlacePtrTable          ;($9D04)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($9B85)Index to values in addr tables for enemy animations.

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
    jmp RTS_Polyp                       ;Area specific routine.

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts

L95CC:  .byte $12                       ;Ridley's room.

L95CD:  .byte $80                       ;Ridley hideout music init flag.

AreaEnemyDamage:  .word $0240                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

AreaSamusMapPosX:   .byte $19   ;Samus start x coord on world map.
AreaSamusMapPosY:   .byte $18   ;Samus start y coord on world map.
AreaSamusY:         .byte $6E   ;Samus start vertical screen position.

L95DA:  .byte $06, $00, $03, $58, $44, $4A, $48, $4A, $4A, $36, $25

ChooseEnemyAIRoutine:
    lda EnType,x
    jsr CommonJump_ChooseRoutine
        .word SwooperAIRoutine ; 00 - swooper
        .word SwooperAIRoutine2 ; 01 - becomes swooper ?
        .word SidehopperFloorAIRoutine ; 02 - dessgeegas
        .word SidehopperCeilingAIRoutine ; 03 - ceiling dessgeegas
        .word InvalidEnemy ; 04 - disappears
        .word InvalidEnemy ; 05 - same as 4
        .word CrawlerAIRoutine ; 06 - crawler
        .word PipeBugAIRoutine ; 07 - zebbo
        .word InvalidEnemy ; 08 - same as 4
        .word RidleyAIRoutine ; 09 - ridley
        .word RidleyFireballAIRoutine ; 0A - ridley fireball
        .word InvalidEnemy ; 0B - same as 4
        .word MultiviolaAIRoutine ; 0C - bouncy orbs
        .word InvalidEnemy ; 0D - same as 4
        .word PolypAIRoutine ; 0E - ???
        .word InvalidEnemy ; 0F - same as 4

L960B:  .byte $23, $23, $23, $23, $3A, $3A, $3C, $3C, $00, $00, $00, $00, $56, $56, $65, $63

L961B:  .byte $00, $00, $11, $11, $13, $18, $28, $28, $32, $32, $34, $34, $00, $00, $00, $00

L962B:  .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $1D, $1D, $1D, $1D, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $69, $67

L964B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L965B:  .byte $20, $20, $20, $20, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $60, $5D

L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

L96BB:  .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $18, $1A, $00, $03, $00, $00, $08, $08, $00, $0A, $0C, $0F, $14, $16, $18, $00

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

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $7F, $7F, $81, $81
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01
L9773:  .byte $01, $00, $00, $00, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $34, $34, $44, $4A, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8

EnemyFireballMovementPtrTable:
    .word EnemyFireballMovement0
    .word EnemyFireballMovement0
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

L97D1:  .byte $01, $04, $05, $01, $06, $07, $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03
L97E1:  .byte $00, $01, $02, $03, $00, $10, $00, $11, $00, $00, $00, $01

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
    beq L983F
    cmp #$03
    beq L9844
        lda $00
        jmp CommonJump_00
    L983F:
        lda $01
        jmp CommonJump_01
    L9844:
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
; Bouncy Orb Routine
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
.include "enemies/polyp.asm"

;-------------------------------------------------------------------------------

TileBlastFrame00:
    .byte $22, $FF, $FF, $FF, $FF

TileBlastFrame01:
    .byte $22, $80, $81, $82, $83

TileBlastFrame02:
    .byte $22, $84, $85, $86, $87

TileBlastFrame03:
    .byte $22, $88, $89, $8A, $8B

TileBlastFrame04:
    .byte $22, $8C, $8D, $8E, $8F

TileBlastFrame05:
    .byte $22, $94, $95, $96, $97

TileBlastFrame06:
    .byte $22, $9C, $9D, $9D, $9C

TileBlastFrame07:
    .byte $22, $9E, $9F, $9F, $9E

TileBlastFrame08:
    .byte $22, $90, $91, $92, $93

TileBlastFrame09:
    .byte $22, $70, $71, $72, $73

TileBlastFrame0A:
    .byte $22, $74, $75, $76, $77

TileBlastFrame0B:
    .byte $22, $78, $79, $7A, $7B

TileBlastFrame0C:
TileBlastFrame0D:
TileBlastFrame0E:
TileBlastFrame0F:
TileBlastFrame10:
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

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "ridley/metatiles.asm"

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

.segment "BANK_05_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
