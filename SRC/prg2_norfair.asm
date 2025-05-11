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
ChooseEnemyAIRoutine:
    lda EnDataIndex,x
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
L9BDA:  .byte _id_EnFrame00, _id_EnFrame01, $FF

L9BDD:  .byte _id_EnFrame02, $FF

L9BDF:  .byte _id_EnFrame03, _id_EnFrame04, $FF

L9BE2:  .byte _id_EnFrame07, _id_EnFrame08, $FF

L9BE5:  .byte _id_EnFrame05, _id_EnFrame06, $FF

L9BE8:  .byte _id_EnFrame09, _id_EnFrame0A, $FF

L9BEB:  .byte _id_EnFrame0B, $FF

L9BED:  .byte _id_EnFrame0C, _id_EnFrame0D, _id_EnFrame0E, _id_EnFrame0F, $FF

L9BF2:  .byte _id_EnFrame10, _id_EnFrame11, _id_EnFrame12, _id_EnFrame13, $FF

L9BF7:  .byte _id_EnFrame15, _id_EnFrame14, $FF

L9BFA:  .byte _id_EnFrame16, $FF

L9BFC:  .byte _id_EnFrame17, _id_EnFrame18, $FF

L9BFF:  .byte _id_EnFrame19, _id_EnFrame1A, $FF

L9C02:  .byte _id_EnFrame1B, $FF

L9C04:  .byte _id_EnFrame1C, _id_EnFrame1D, $FF

L9C07:  .byte _id_EnFrame1E, _id_EnFrame1F, $FF

L9C0A:  .byte _id_EnFrame20, $FF

L9C0C:  .byte _id_EnFrame21, _id_EnFrame22, $FF

L9C0F:  .byte _id_EnFrame23, $FF

L9C11:  .byte _id_EnFrame27, _id_EnFrame28, _id_EnFrame29, _id_EnFrame2A, $FF

L9C16:  .byte _id_EnFrame2B, _id_EnFrame2C, _id_EnFrame2D, _id_EnFrame2E, $FF

L9C1B:  .byte _id_EnFrame2F, $FF

L9C1D:  .byte _id_EnFrame30, $FF

L9C1F:  .byte _id_EnFrame31, $FF

L9C21:  .byte _id_EnFrame32, $FF

L9C23:  .byte _id_EnFrame33, $FF

L9C25:  .byte _id_EnFrame34, $FF

L9C27:  .byte _id_EnFrame42, $FF

L9C29:  .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

L9C2D:  .byte _id_EnFrame3B, $FF

L9C2F:  .byte _id_EnFrame3C, $FF

L9C31:  .byte _id_EnFrame3D, $FF, _id_EnFrame3E, $FF

L9C35:  .byte _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame41, _id_EnFrame41, _id_EnFrame41, _id_EnFrame41, _id_EnFrame40, _id_EnFrame40, _id_EnFrame40, $F7, $FF

L9C43:  .byte _id_EnFrame58, _id_EnFrame59, $FF

L9C46:  .byte _id_EnFrame5A, _id_EnFrame5B, $FF

L9C49:  .byte _id_EnFrame5C, _id_EnFrame5D, $FF

L9C4C:  .byte _id_EnFrame5E, _id_EnFrame5F, $FF

L9C4F:  .byte _id_EnFrame60, $FF

L9C51:  .byte _id_EnFrame61, $F7, _id_EnFrame62, $F7, $FF

L9C56:  .byte _id_EnFrame66, _id_EnFrame67, $FF

L9C59:  .byte _id_EnFrame69, _id_EnFrame6A, $FF

L9C5C:  .byte _id_EnFrame68, $FF

L9C5E:  .byte _id_EnFrame6B, $FF

L9C60:  .byte _id_EnFrame66, $FF

L9C62:  .byte _id_EnFrame69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame02
    PtrTableEntry EnFramePtrTable1, EnFrame03
    PtrTableEntry EnFramePtrTable1, EnFrame04
    PtrTableEntry EnFramePtrTable1, EnFrame05
    PtrTableEntry EnFramePtrTable1, EnFrame06
    PtrTableEntry EnFramePtrTable1, EnFrame07
    PtrTableEntry EnFramePtrTable1, EnFrame08
    PtrTableEntry EnFramePtrTable1, EnFrame09
    PtrTableEntry EnFramePtrTable1, EnFrame0A
    PtrTableEntry EnFramePtrTable1, EnFrame0B
    PtrTableEntry EnFramePtrTable1, EnFrame0C
    PtrTableEntry EnFramePtrTable1, EnFrame0D
    PtrTableEntry EnFramePtrTable1, EnFrame0E
    PtrTableEntry EnFramePtrTable1, EnFrame0F
    PtrTableEntry EnFramePtrTable1, EnFrame10
    PtrTableEntry EnFramePtrTable1, EnFrame11
    PtrTableEntry EnFramePtrTable1, EnFrame12
    PtrTableEntry EnFramePtrTable1, EnFrame13
    PtrTableEntry EnFramePtrTable1, EnFrame14
    PtrTableEntry EnFramePtrTable1, EnFrame15
    PtrTableEntry EnFramePtrTable1, EnFrame16
    PtrTableEntry EnFramePtrTable1, EnFrame17
    PtrTableEntry EnFramePtrTable1, EnFrame18
    PtrTableEntry EnFramePtrTable1, EnFrame19
    PtrTableEntry EnFramePtrTable1, EnFrame1A
    PtrTableEntry EnFramePtrTable1, EnFrame1B
    PtrTableEntry EnFramePtrTable1, EnFrame1C
    PtrTableEntry EnFramePtrTable1, EnFrame1D
    PtrTableEntry EnFramePtrTable1, EnFrame1E
    PtrTableEntry EnFramePtrTable1, EnFrame1F
    PtrTableEntry EnFramePtrTable1, EnFrame20
    PtrTableEntry EnFramePtrTable1, EnFrame21
    PtrTableEntry EnFramePtrTable1, EnFrame22
    PtrTableEntry EnFramePtrTable1, EnFrame23
    PtrTableEntry EnFramePtrTable1, EnFrame24
    PtrTableEntry EnFramePtrTable1, EnFrame25
    PtrTableEntry EnFramePtrTable1, EnFrame26
    PtrTableEntry EnFramePtrTable1, EnFrame27
    PtrTableEntry EnFramePtrTable1, EnFrame28
    PtrTableEntry EnFramePtrTable1, EnFrame29
    PtrTableEntry EnFramePtrTable1, EnFrame2A
    PtrTableEntry EnFramePtrTable1, EnFrame2B
    PtrTableEntry EnFramePtrTable1, EnFrame2C
    PtrTableEntry EnFramePtrTable1, EnFrame2D
    PtrTableEntry EnFramePtrTable1, EnFrame2E
    PtrTableEntry EnFramePtrTable1, EnFrame2F
    PtrTableEntry EnFramePtrTable1, EnFrame30
    PtrTableEntry EnFramePtrTable1, EnFrame31
    PtrTableEntry EnFramePtrTable1, EnFrame32
    PtrTableEntry EnFramePtrTable1, EnFrame33
    PtrTableEntry EnFramePtrTable1, EnFrame34
    PtrTableEntry EnFramePtrTable1, EnFrame35
    PtrTableEntry EnFramePtrTable1, EnFrame36
    PtrTableEntry EnFramePtrTable1, EnFrame37
    PtrTableEntry EnFramePtrTable1, EnFrame38
    PtrTableEntry EnFramePtrTable1, EnFrame39
    PtrTableEntry EnFramePtrTable1, EnFrame3A
    PtrTableEntry EnFramePtrTable1, EnFrame3B
    PtrTableEntry EnFramePtrTable1, EnFrame3C
    PtrTableEntry EnFramePtrTable1, EnFrame3D
    PtrTableEntry EnFramePtrTable1, EnFrame3E
    PtrTableEntry EnFramePtrTable1, EnFrame3F
    PtrTableEntry EnFramePtrTable1, EnFrame40
    PtrTableEntry EnFramePtrTable1, EnFrame41
    PtrTableEntry EnFramePtrTable1, EnFrame42
    PtrTableEntry EnFramePtrTable1, EnFrame43
    PtrTableEntry EnFramePtrTable1, EnFrame44
    PtrTableEntry EnFramePtrTable1, EnFrame45
    PtrTableEntry EnFramePtrTable1, EnFrame46
    PtrTableEntry EnFramePtrTable1, EnFrame47
    PtrTableEntry EnFramePtrTable1, EnFrame48
    PtrTableEntry EnFramePtrTable1, EnFrame49
    PtrTableEntry EnFramePtrTable1, EnFrame4A
    PtrTableEntry EnFramePtrTable1, EnFrame4B
    PtrTableEntry EnFramePtrTable1, EnFrame4C
    PtrTableEntry EnFramePtrTable1, EnFrame4D
    PtrTableEntry EnFramePtrTable1, EnFrame4E
    PtrTableEntry EnFramePtrTable1, EnFrame4F
    PtrTableEntry EnFramePtrTable1, EnFrame50
    PtrTableEntry EnFramePtrTable1, EnFrame51
    PtrTableEntry EnFramePtrTable1, EnFrame52
    PtrTableEntry EnFramePtrTable1, EnFrame53
    PtrTableEntry EnFramePtrTable1, EnFrame54
    PtrTableEntry EnFramePtrTable1, EnFrame55
    PtrTableEntry EnFramePtrTable1, EnFrame56
    PtrTableEntry EnFramePtrTable1, EnFrame57
    PtrTableEntry EnFramePtrTable1, EnFrame58
    PtrTableEntry EnFramePtrTable1, EnFrame59
    PtrTableEntry EnFramePtrTable1, EnFrame5A
    PtrTableEntry EnFramePtrTable1, EnFrame5B
    PtrTableEntry EnFramePtrTable1, EnFrame5C
    PtrTableEntry EnFramePtrTable1, EnFrame5D
    PtrTableEntry EnFramePtrTable1, EnFrame5E
    PtrTableEntry EnFramePtrTable1, EnFrame5F
    PtrTableEntry EnFramePtrTable1, EnFrame60
    PtrTableEntry EnFramePtrTable1, EnFrame61
    PtrTableEntry EnFramePtrTable1, EnFrame62
    PtrTableEntry EnFramePtrTable1, EnFrame63
    PtrTableEntry EnFramePtrTable1, EnFrame64
    PtrTableEntry EnFramePtrTable1, EnFrame65
    PtrTableEntry EnFramePtrTable1, EnFrame66
    PtrTableEntry EnFramePtrTable1, EnFrame67
    PtrTableEntry EnFramePtrTable1, EnFrame68
    PtrTableEntry EnFramePtrTable1, EnFrame69
    PtrTableEntry EnFramePtrTable1, EnFrame6A
    PtrTableEntry EnFramePtrTable1, EnFrame6B
    PtrTableEntry EnFramePtrTable1, EnFrame6C
    PtrTableEntry EnFramePtrTable1, EnFrame6D
    PtrTableEntry EnFramePtrTable1, EnFrame6E
    PtrTableEntry EnFramePtrTable1, EnFrame6F
    PtrTableEntry EnFramePtrTable1, EnFrame70
    PtrTableEntry EnFramePtrTable1, EnFrame71
    PtrTableEntry EnFramePtrTable1, EnFrame72
    PtrTableEntry EnFramePtrTable1, EnFrame73
    PtrTableEntry EnFramePtrTable1, EnFrame74
    PtrTableEntry EnFramePtrTable1, EnFrame75
    PtrTableEntry EnFramePtrTable1, EnFrame76
    PtrTableEntry EnFramePtrTable1, EnFrame77
    PtrTableEntry EnFramePtrTable1, EnFrame78
    PtrTableEntry EnFramePtrTable1, EnFrame79
    PtrTableEntry EnFramePtrTable1, EnFrame7A
    PtrTableEntry EnFramePtrTable1, EnFrame7B
    PtrTableEntry EnFramePtrTable1, EnFrame7C
    PtrTableEntry EnFramePtrTable1, EnFrame7D
    PtrTableEntry EnFramePtrTable1, EnFrame7E
    PtrTableEntry EnFramePtrTable1, EnFrame7F

EnFramePtrTable2:
    PtrTableEntry EnFramePtrTable1, EnFrame80
    PtrTableEntry EnFramePtrTable1, EnFrame81
    PtrTableEntry EnFramePtrTable1, EnFrame82
    PtrTableEntry EnFramePtrTable1, EnFrame83
    PtrTableEntry EnFramePtrTable1, EnFrame84
    PtrTableEntry EnFramePtrTable1, EnFrame85
    PtrTableEntry EnFramePtrTable1, EnFrame86
    PtrTableEntry EnFramePtrTable1, EnFrame87
    PtrTableEntry EnFramePtrTable1, EnFrame88
    PtrTableEntry EnFramePtrTable1, EnFrame89

EnPlacePtrTable:
    PtrTableEntry EnPlacePtrTable, EnPlace0
    PtrTableEntry EnPlacePtrTable, EnPlace1
    PtrTableEntry EnPlacePtrTable, EnPlace2
    PtrTableEntry EnPlacePtrTable, EnPlace3
    PtrTableEntry EnPlacePtrTable, EnPlace4
    PtrTableEntry EnPlacePtrTable, EnPlace5
    PtrTableEntry EnPlacePtrTable, EnPlace6
    PtrTableEntry EnPlacePtrTable, EnPlace7
    PtrTableEntry EnPlacePtrTable, EnPlace8
    PtrTableEntry EnPlacePtrTable, EnPlace9
    PtrTableEntry EnPlacePtrTable, EnPlaceA
    PtrTableEntry EnPlacePtrTable, EnPlaceB
    PtrTableEntry EnPlacePtrTable, EnPlaceC
    PtrTableEntry EnPlacePtrTable, EnPlaceD

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace2:
EnPlace3:
    .byte $F4, $F4, $F4, $04

EnPlace5:
    .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

EnPlace6:
    .byte $FC, $F8, $FC, $00

EnPlace4:
    .byte $F0, $F8, $F0, $00

EnPlace7:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

EnPlace8:
    .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC:
    .byte $F8, $FC, $00, $FC

EnPlaceD:
    ;nothing

;Enemy frame drawing data.

EnFrame00:
    .byte $00, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte $00, $02, $02
    .byte $24
    .byte $FF

EnFrame02:
    .byte $00, $00, $00
    .byte $04
    .byte $FF

EnFrame03:
    .byte $22, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $F9
    .byte $F8
    .byte $FF

EnFrame04:
    .byte $22, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $FF

EnFrame05:
    .byte $22, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $F9
    .byte $F8
    .byte $FE
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame06:
    .byte $22, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame07:
    .byte $62, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $F9
    .byte $F8
    .byte $FF

EnFrame08:
    .byte $62, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $FF

EnFrame09:
    .byte $62, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $F9
    .byte $F8
    .byte $FE
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame0A:
    .byte $62, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame0B:
    .byte $21, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame0C:
    .byte $20, $04, $04
    .byte $EC
    .byte $FF

EnFrame0D:
    .byte $20, $04, $04
    .byte $FB
    .byte $FF

EnFrame0E:
    .byte $E0, $04, $04
    .byte $EC
    .byte $FF

EnFrame0F:
    .byte $E0, $04, $04
    .byte $FB
    .byte $FF

EnFrame10:
    .byte $60, $04, $04
    .byte $EC
    .byte $FF

EnFrame11:
    .byte $60, $04, $04
    .byte $FB
    .byte $FF

EnFrame12:
    .byte $A0, $04, $04
    .byte $EC
    .byte $FF

EnFrame13:
    .byte $A0, $04, $04
    .byte $FB
    .byte $FF

EnFrame14:
    .byte $27, $08, $08
    .byte $EA
    .byte $FD, $62
    .byte $EA
    .byte $FD, $22
    .byte $FB
    .byte $FD, $62
    .byte $FB
    .byte $FF

EnFrame15:
    .byte $27, $08, $08
    .byte $EA
    .byte $FD, $62
    .byte $EA
    .byte $FD, $22
    .byte $FA
    .byte $FD, $62
    .byte $FA
    .byte $FF

EnFrame16:
    .byte $27, $08, $08
    .byte $EA
    .byte $FD, $62
    .byte $EA
    .byte $FD, $22
    .byte $EB
    .byte $FD, $62
    .byte $EB
    .byte $FF

EnFrame17:
    .byte $25, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, $62
    .byte $CE
    .byte $FD, $22
    .byte $DF
    .byte $FD, $62
    .byte $DF
    .byte $FF

EnFrame18:
    .byte $25, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, $62
    .byte $CE
    .byte $FD, $22
    .byte $DE
    .byte $FD, $62
    .byte $DE
    .byte $FF

EnFrame19:
    .byte $A5, $08, $08
    .byte $FD, $22
    .byte $CE
    .byte $CF
    .byte $FD, $62
    .byte $CE
    .byte $FD, $A2
    .byte $DF
    .byte $FD, $E2
    .byte $DF
    .byte $FF

EnFrame1A:
    .byte $A5, $08, $08
    .byte $FD, $22
    .byte $CE
    .byte $CF
    .byte $FD, $62
    .byte $CE
    .byte $FD, $A2
    .byte $DE
    .byte $FD, $E2
    .byte $DE
    .byte $FF

EnFrame1B:
    .byte $21, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

EnFrame1C:
    .byte $39, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame1D:
    .byte $39, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

EnFrame1E:
    .byte $79, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame1F:
    .byte $79, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

EnFrame20:
    .byte $31, $00, $00
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame21:
    .byte $29, $04, $08
    .byte $E6
    .byte $FD, $62
    .byte $E6
    .byte $FF

EnFrame22:
    .byte $29, $04, $08
    .byte $E5
    .byte $FD, $62
    .byte $E5
    .byte $FF

EnFrame23:
    .byte $21, $00, $00
    .byte $EA
    .byte $EA
    .byte $EB
    .byte $EB
    .byte $FF

EnFrame24:
EnFrame25:
EnFrame26:
EnFrame27:
    .byte $27, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, $E2
    .byte $EF
    .byte $FD, $A2
    .byte $EF
    .byte $FF

EnFrame28:
    .byte $27, $08, $08
    .byte $FD, $62
    .byte $EF
    .byte $FD, $22
    .byte $EF
    .byte $ED
    .byte $FD, $A2
    .byte $EF
    .byte $FF

EnFrame29:
    .byte $27, $08, $08
    .byte $FD, $62
    .byte $EF
    .byte $FD, $22
    .byte $EF
    .byte $FD, $E2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2A:
    .byte $27, $08, $08
    .byte $FD, $62
    .byte $EF
    .byte $FD, $E2
    .byte $ED
    .byte $EF
    .byte $FD, $A2
    .byte $EF
    .byte $FF

EnFrame2B:
    .byte $67, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, $A2
    .byte $EF
    .byte $FD, $E2
    .byte $EF
    .byte $FF

EnFrame2C:
    .byte $67, $08, $08
    .byte $FD, $22
    .byte $EF
    .byte $FD, $62
    .byte $EF
    .byte $ED
    .byte $FD, $E2
    .byte $EF
    .byte $FF

EnFrame2D:
    .byte $67, $08, $08
    .byte $FD, $22
    .byte $EF
    .byte $FD, $62
    .byte $EF
    .byte $FD, $A2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2E:
    .byte $67, $08, $08
    .byte $FD, $22
    .byte $EF
    .byte $FD, $A2
    .byte $ED
    .byte $EF
    .byte $FD, $E2
    .byte $EF
    .byte $FF

EnFrame2F:
    .byte $21, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

EnFrame30:
    .byte $24, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame31:
    .byte $24, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C7
    .byte $D8
    .byte $D7
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame32:
    .byte $64, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame33:
    .byte $64, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C7
    .byte $D8
    .byte $D7
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame34:
    .byte $21, $00, $00
    .byte $FC, $FC, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $FF

EnFrame35:
EnFrame36:
EnFrame37:
EnFrame38:
EnFrame39:
EnFrame3A:
EnFrame3B:
    .byte $37, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3C:
    .byte $B7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3D:
    .byte $77, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3E:
    .byte $F7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3F:
    .byte $37, $00, $00
    .byte $E2
    .byte $FD, $63
    .byte $E2
    .byte $FF

EnFrame40:
    .byte $38, $00, $00
    .byte $E2
    .byte $FD, $62
    .byte $E2
    .byte $FF

EnFrame41:
    .byte $38, $00, $00
    .byte $FE
    .byte $FE
    .byte $E2
    .byte $FD, $62
    .byte $E2
    .byte $FF

EnFrame42:
    .byte $30, $04, $04
    .byte $C0
    .byte $FF

EnFrame43:
    .byte $30, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44:
    .byte $33, $00, $00
    .byte $D1
    .byte $FD, $63
    .byte $D1
    .byte $FF

EnFrame45:
EnFrame46:
EnFrame47:
EnFrame48:
EnFrame49:
EnFrame4A:
EnFrame4B:
EnFrame4C:
EnFrame4D:
EnFrame4E:
EnFrame4F:
EnFrame50:
EnFrame51:
EnFrame52:
EnFrame53:
EnFrame54:
EnFrame55:
EnFrame56:
EnFrame57:
EnFrame58:
    .byte $27, $08, $08
    .byte $CC
    .byte $FD, $62
    .byte $CC
    .byte $FD, $22
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame59:
    .byte $67, $08, $08
    .byte $FD, $22
    .byte $CD
    .byte $FD, $62
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5A:
    .byte $27, $08, $08
    .byte $FD, $A2
    .byte $DA
    .byte $FD, $22
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5B:
    .byte $A7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, $22
    .byte $CA
    .byte $FD, $A2
    .byte $DB
    .byte $FF

EnFrame5C:
    .byte $A7, $08, $08
    .byte $CC
    .byte $FD, $E2
    .byte $CC
    .byte $FD, $A2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5D:
    .byte $E7, $08, $08
    .byte $FD, $A2
    .byte $CD
    .byte $FD, $E2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5E:
    .byte $67, $08, $08
    .byte $FD, $E2
    .byte $DA
    .byte $FD, $62
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5F:
    .byte $E7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, $62
    .byte $CA
    .byte $FD, $E2
    .byte $DB
    .byte $FF

EnFrame60:
    .byte $21, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame61:
    .byte $0A, $00, $00
    .byte $75
    .byte $FD, $60
    .byte $75
    .byte $FD, $A0
    .byte $75
    .byte $FD, $E0
    .byte $75
    .byte $FF

EnFrame62:
    .byte $0A, $00, $00
    .byte $FE
    .byte $FE
    .byte $FE
    .byte $FE
    .byte $3D
    .byte $3E
    .byte $4E
    .byte $FD, $60
    .byte $3E
    .byte $3D
    .byte $4E
    .byte $FD, $E0
    .byte $4E
    .byte $3E
    .byte $3D
    .byte $FD, $A0
    .byte $4E
    .byte $3D
    .byte $3E
    .byte $FF

EnFrame63:
EnFrame64:
EnFrame65:
EnFrame66:
    .byte $2A, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame67:
    .byte $2A, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame68:
    .byte $21, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame69:
    .byte $6A, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame6A:
    .byte $6A, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6B:
    .byte $61, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6C:
EnFrame6D:
EnFrame6E:
EnFrame6F:
EnFrame70:
EnFrame71:
EnFrame72:
EnFrame73:
EnFrame74:
EnFrame75:
EnFrame76:
EnFrame77:
EnFrame78:
EnFrame79:
EnFrame7A:
EnFrame7B:
EnFrame7C:
EnFrame7D:
EnFrame7E:
EnFrame7F:
EnFrame80:
    .byte $0C, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame81:
    .byte $00, $04, $04
    .byte $8A
    .byte $FF

EnFrame82:
EnFrame83:
EnFrame84:
EnFrame85:
EnFrame86:
EnFrame87:
EnFrame88:
EnFrame89:
    .byte $00, $04, $04
    .byte $8A
    .byte $FF

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
