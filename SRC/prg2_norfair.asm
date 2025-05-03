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
    .word EnemyFramePtrTbl1         ;($9C64)Address table into enemy animation data. Two-->
    .word EnemyFramePtrTbl2         ;($9D64)tables needed to accommodate all entries.
    .word EnemyPlacePtrTbl          ;($9D78)Pointers to enemy frame placement data.
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

TwosComplement_:
    eor #$FF                        ;
    clc                             ;The following routine returns the twos-->
    adc #$01                        ;complement of the value stored in A.
    rts                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $08                       ;Norfair music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $01                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $10, $05, $27, $04, $0F, $FF, $FF

L95D7:  .byte $16                       ;Samus start x coord on world map.
L95D8:  .byte $0D                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $01, $00, $03, $77, $53, $57, $55, $59, $5B, $4F, $32

; Enemy AI jump table
ChooseEnemyRoutine:
    lda EnDataIndex,x
    jsr CommonJump_ChooseRoutine
        .word SwooperRoutine ; 00 - swooper
        .word SwooperRoutine2 ; 01 - becomes swooper?
        .word RipperRoutine ; 02 - ripper
        .word InvalidEnemy ; 03 - disappears
        .word InvalidEnemy ; 04 - same as 3
        .word InvalidEnemy ; 05 - same as 3
        .word CrawlerRoutine ; 06 - crawler
        .word PipeBugRoutine ; 07 - gamet
        .word InvalidEnemy ; 08 - same as 3
        .word InvalidEnemy ; 09 - same as 3
        .word InvalidEnemy ; 0A - same as 3
        .word SqueeptRoutine ; 0B - lava jumper
        .word MultiviolaRoutine ; 0C - bouncy orb
        .word SeahorseRoutine ; 0D - seahorse
        .word PolypRoutine ; 0E - rock launcher thing
        .word InvalidEnemy ; 0F - same as 3

L960B:  .byte $28, $28, $28, $28, $30, $30, $00, $00, $00, $00, $00, $00, $75, $75, $84, $82
L961B:  .byte $00, $00, $11, $11, $13, $18, $35, $35, $41, $41, $4B, $4B, $00, $00, $00, $00

EnemyHitPointTbl:
L962B:  .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86
L964B:  .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00

L965B:  .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C
L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00

L967B:  .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00

L96BB:  .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $12, $14, $00, $00, $00, $00, $02, $02, $00, $04, $06, $09, $0E, $10, $12, $00

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

L97A7:  .word L97F7, L9806, L9815, L9824

L97AF:  .word L9B9E, L9BA3, L9BA8, L9BAD, L9BB2, L9BB7, L9BBC, L9BC1
L97BF:  .word L9BC6, L9BCB, L9BD0, L9BD5, L9BDA, L9BDA, L9BDA, L9BDA
L97CF:  .word L9BDA

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

L97F7:  .byte $0A, $D3, $07, $B3, $07, $93, $07, $03, $07, $13, $07, $23, $50, $33, $FF

L9806:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9815:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9824:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

;-------------------------------------------------------------------------------
InvalidEnemy:
    lda #$00
    sta EnStatus,x
    rts

CommonEnemyJump_00_01_02:
    lda $81
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
    lda $81
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
    lda EnYRoomPos,x
    sta $08
    lda EnXRoomPos,x
    sta $09
    lda EnNameTable,x
    sta $0B
    rts

LoadPositionFromTemp:
    lda $0B
    and #$01
    sta EnNameTable,x
    lda $08
    sta EnYRoomPos,x
    lda $09
    sta EnXRoomPos,x
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

L9B9E:  .byte $22, $FF, $FF, $FF, $FF

L9BA3:  .byte $22, $80, $81, $82, $83

L9BA8:  .byte $22, $84, $85, $86, $87

L9BAD:  .byte $22, $88, $89, $8A, $8B

L9BB2:  .byte $22, $8C, $8D, $8E, $8F

L9BB7:  .byte $22, $94, $95, $96, $97

L9BBC:  .byte $22, $9C, $9D, $9D, $9C

L9BC1:  .byte $22, $9E, $9F, $9F, $9E

L9BC6:  .byte $22, $90, $91, $92, $93

L9BCB:  .byte $22, $70, $71, $72, $73

L9BD0:  .byte $22, $74, $75, $75, $74

L9BD5:  .byte $22, $76, $76, $76, $76

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9BDA:  .byte $00, $01, $FF

L9BDD:  .byte $02, $FF

L9BDF:  .byte $03, $04, $FF

L9BE2:  .byte $07, $08, $FF

L9BE5:  .byte $05, $06, $FF

L9BE8:  .byte $09, $0A, $FF

L9BEB:  .byte $0B, $FF

L9BED:  .byte $0C, $0D, $0E, $0F, $FF

L9BF2:  .byte $10, $11, $12, $13, $FF

L9BF7:  .byte $15, $14, $FF

L9BFA:  .byte $16, $FF

L9BFC:  .byte $17, $18, $FF

L9BFF:  .byte $19, $1A, $FF

L9C02:  .byte $1B, $FF

L9C04:  .byte $1C, $1D, $FF

L9C07:  .byte $1E, $1F, $FF

L9C0A:  .byte $20, $FF

L9C0C:  .byte $21, $22, $FF

L9C0F:  .byte $23, $FF

L9C11:  .byte $27, $28, $29, $2A, $FF

L9C16:  .byte $2B, $2C, $2D, $2E, $FF

L9C1B:  .byte $2F, $FF

L9C1D:  .byte $30, $FF

L9C1F:  .byte $31, $FF

L9C21:  .byte $32, $FF

L9C23:  .byte $33, $FF

L9C25:  .byte $34, $FF

L9C27:  .byte $42, $FF

L9C29:  .byte $43, $44, $F7, $FF

L9C2D:  .byte $3B, $FF

L9C2F:  .byte $3C, $FF

L9C31:  .byte $3D, $FF, $3E, $FF

L9C35:  .byte $3F, $3F, $3F, $3F, $3F, $41, $41, $41, $41, $40, $40, $40, $F7, $FF

L9C43:  .byte $58, $59, $FF

L9C46:  .byte $5A, $5B, $FF

L9C49:  .byte $5C, $5D, $FF

L9C4C:  .byte $5E, $5F, $FF

L9C4F:  .byte $60, $FF

L9C51:  .byte $61, $F7, $62, $F7, $FF

L9C56:  .byte $66, $67, $FF

L9C59:  .byte $69, $6A, $FF

L9C5C:  .byte $68, $FF

L9C5E:  .byte $6B, $FF

L9C60:  .byte $66, $FF

L9C62:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
    .word L9E0A, L9E0F, L9E14, L9E19, L9E2C, L9E40, L9E56, L9E6C
    .word L9E7F, L9E93, L9EA9, L9EBF, L9EC9, L9ECE, L9ED3, L9ED8
    .word L9EDD, L9EE2, L9EE7, L9EEC, L9EF1, L9EFF, L9F0D, L9F1B
    .word L9F2A, L9F39, L9F4A, L9F5B, L9F63, L9F69, L9F6F, L9F75
    .word L9F7B, L9F81, L9F89, L9F91, L9F99, L9F99, L9F99, L9F99
    .word L9FA5, L9FB3, L9FC1, L9FCF, L9FDB, L9FE9, L9FF7, LA005
    .word LA010, LA01F, LA02E, LA03D, LA04C, LA059, LA059, LA059
    .word LA059, LA059, LA059, LA059, LA061, LA069, LA071, LA079
    .word LA081, LA089, LA093, LA098, LA0A0, LA0A8, LA0A8, LA0A8
    .word LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8
    .word LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8, LA0A8
    .word LA0A8, LA0B4, LA0C0, LA0CC, LA0D8, LA0E4, LA0F0, LA0FC
    .word LA108, LA110, LA11E, LA138, LA138, LA138, LA138, LA140
    .word LA148, LA150, LA158, LA160, LA168, LA168, LA168, LA168
    .word LA168, LA168, LA168, LA168, LA168, LA168, LA168, LA168
    .word LA168, LA168, LA168, LA168, LA168, LA168, LA168, LA168

EnemyFramePtrTbl2:
    .word LA168, LA16E, LA173, LA173, LA173, LA173, LA173, LA173
    .word LA173, LA173

EnemyPlacePtrTbl:
    .word L9D94, L9D96, L9DAE, L9DAE, L9DC0, L9DB2, L9DBC, L9DC4
    .word L9DD0, L9DD8, L9DD8, L9DF8, L9E06, L9E0A

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D94:  .byte $FC, $FC

L9D96:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9DA6:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9DAE:  .byte $F4, $F4, $F4, $04

L9DB2:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9DBC:  .byte $FC, $F8, $FC, $00

L9DC0:  .byte $F0, $F8, $F0, $00

L9DC4:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9DD0:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9DD8:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9DE8:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DF8:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9E06:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

L9E0A:  .byte $00, $02, $02, $14, $FF

L9E0F:  .byte $00, $02, $02, $24, $FF

L9E14:  .byte $00, $00, $00, $04, $FF

L9E19:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E29:  .byte $F9, $F8, $FF

L9E2C:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E3C:  .byte $D8, $FE, $E8, $FF

L9E40:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E50:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E56:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E66:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E6C:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E7C:  .byte $F9, $F8, $FF

L9E7F:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E8F:  .byte $D8, $FE, $E8, $FF

L9E93:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EA3:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9EA9:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EB9:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9EBF:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9EC9:  .byte $20, $04, $04, $EC, $FF

L9ECE:  .byte $20, $04, $04, $FB, $FF

L9ED3:  .byte $E0, $04, $04, $EC, $FF

L9ED8:  .byte $E0, $04, $04, $FB, $FF

L9EDD:  .byte $60, $04, $04, $EC, $FF

L9EE2:  .byte $60, $04, $04, $FB, $FF

L9EE7:  .byte $A0, $04, $04, $EC, $FF

L9EEC:  .byte $A0, $04, $04, $FB, $FF

L9EF1:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FB, $FD, $62, $FB, $FF

L9EFF:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FA, $FD, $62, $FA, $FF

L9F0D:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $EB, $FD, $62, $EB, $FF

L9F1B:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9F2A:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9F39:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9F49:  .byte $FF

L9F4A:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9F5A:  .byte $FF

L9F5B:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F63:  .byte $39, $04, $08, $F6, $F7, $FF

L9F69:  .byte $39, $04, $08, $E7, $F7, $FF

L9F6F:  .byte $79, $04, $08, $F6, $F7, $FF

L9F75:  .byte $79, $04, $08, $E7, $F7, $FF

L9F7B:  .byte $31, $00, $00, $F6, $F7, $FF

L9F81:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F89:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF

L9F91:  .byte $21, $00, $00, $EA, $EA, $EB, $EB, $FF

L9F99:  .byte $27, $08, $08, $EE, $EF, $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9FA5:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9FB3:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9FC1:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9FCF:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9FDB:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9FE9:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9FF7:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

LA005:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

LA010:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA01F:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA02E:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA03D:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA04C:  .byte $21, $00, $00, $FC, $FC, $00, $C8, $C9, $D8, $D9, $E8, $E9, $FF

LA059:  .byte $37, $04, $04, $E0, $E1, $F0, $F1, $FF

LA061:  .byte $B7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA069:  .byte $77, $04, $04, $E0, $E1, $F0, $F1, $FF

LA071:  .byte $F7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA079:  .byte $37, $00, $00, $E2, $FD, $63, $E2, $FF

LA081:  .byte $38, $00, $00, $E2, $FD, $62, $E2, $FF

LA089:  .byte $38, $00, $00, $FE, $FE, $E2, $FD, $62, $E2, $FF

LA093:  .byte $30, $04, $04, $C0, $FF

LA098:  .byte $30, $00, $00, $FC, $F8, $00, $D0, $FF

LA0A0:  .byte $33, $00, $00, $D1, $FD, $63, $D1, $FF

LA0A8:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA0B4:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA0C0:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA0CC:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA0D8:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA0E4:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA0F0:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA0FC:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA108:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA110:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA11E:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA12E:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA138:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA140:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA148:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA150:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA158:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA160:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA168:  .byte $0C, $08, $04, $14, $24, $FF

LA16E:  .byte $00, $04, $04, $8A, $FF

LA173:  .byte $00, $04, $04, $8A, $FF

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
