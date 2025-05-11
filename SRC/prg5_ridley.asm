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

TwosComplement_:
    eor #$FF                        ;
    clc                             ;The following routine returns the twos-->
    adc #$01                        ;complement of the value stored in A.
    rts                             ;

L95CC:  .byte $12                       ;Ridley's room.

L95CD:  .byte $80                       ;Ridley hideout music init flag.

L95CE:  .byte $40                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $19                       ;Samus start x coord on world map.
L95D8:  .byte $18                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $58, $44, $4A, $48, $4A, $4A, $36, $25

ChooseEnemyAIRoutine:
    lda EnDataIndex,x
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

L97A7:  .word L97FD, L97FD, L980C, L981B

L97AF:  .word L9B49, L9B4E, L9B53, L9B58, L9B5D, L9B62, L9B67, L9B6C
L97BF:  .word L9B71, L9B76, L9B7B, L9B80, L9B85, L9B85, L9B85, L9B85
L97CF:  .word L9B85

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

L97FD:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L980C:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L981B:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

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
; Bouncy Orb Routine
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
.include "enemies/polyp.asm"

;-------------------------------------------------------------------------------

L9B49:  .byte $22, $FF, $FF, $FF, $FF

L9B4E:  .byte $22, $80, $81, $82, $83

L9B53:  .byte $22, $84, $85, $86, $87

L9B58:  .byte $22, $88, $89, $8A, $8B

L9B5D:  .byte $22, $8C, $8D, $8E, $8F

L9B62:  .byte $22, $94, $95, $96, $97

L9B67:  .byte $22, $9C, $9D, $9D, $9C

L9B6C:  .byte $22, $9E, $9F, $9F, $9E

L9B71:  .byte $22, $90, $91, $92, $93

L9B76:  .byte $22, $70, $71, $72, $73

L9B7B:  .byte $22, $74, $75, $76, $77

L9B80:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9B85:  .byte _id_EnFrame00, _id_EnFrame01, $FF

L9B88:  .byte _id_EnFrame02, $FF

L9B8A:  .byte _id_EnFrame03, _id_EnFrame04, $FF

L9B8D:  .byte _id_EnFrame07, _id_EnFrame08, $FF

L9B90:  .byte _id_EnFrame05, _id_EnFrame06, $FF

L9B93:  .byte _id_EnFrame09, _id_EnFrame0A, $FF

L9B96:  .byte _id_EnFrame0B, $FF

L9B98:  .byte _id_EnFrame0C, _id_EnFrame0D, _id_EnFrame0E, _id_EnFrame0F, $FF

L9B9D:  .byte _id_EnFrame10, _id_EnFrame11, _id_EnFrame12, _id_EnFrame13, $FF

L9BA2:  .byte _id_EnFrame17, _id_EnFrame18, $FF

L9BA5:  .byte _id_EnFrame19, _id_EnFrame1A, $FF

L9BA8:  .byte _id_EnFrame1B, $FF

L9BAA:  .byte _id_EnFrame21, _id_EnFrame22, $FF

L9BAD:  .byte _id_EnFrame27, _id_EnFrame28, _id_EnFrame29, _id_EnFrame2A, $FF

L9BB2:  .byte _id_EnFrame2B, _id_EnFrame2C, _id_EnFrame2D, _id_EnFrame2E, $FF

L9BB7:  .byte _id_EnFrame2F, $FF

L9BB9:  .byte _id_EnFrame42, $FF

L9BBB:  .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

L9BBF:  .byte _id_EnFrame37, $FF, _id_EnFrame38, $FF

L9BC3:  .byte _id_EnFrame30, _id_EnFrame31, $FF

L9BC6:  .byte _id_EnFrame31, _id_EnFrame32, $FF

L9BC9:  .byte _id_EnFrame33, _id_EnFrame34, $FF

L9BCC:  .byte _id_EnFrame34, _id_EnFrame35, $FF

L9BCF:  .byte _id_EnFrame58, _id_EnFrame59, $FF

L9BD2:  .byte _id_EnFrame5A, _id_EnFrame5B, $FF

L9BD5:  .byte _id_EnFrame5C, _id_EnFrame5D, $FF

L9BD8:  .byte _id_EnFrame5E, _id_EnFrame5F, $FF

L9BDB:  .byte _id_EnFrame60, $FF

L9BDD:  .byte _id_EnFrame61, $F7, _id_EnFrame62, $F7, $FF

L9BE2:  .byte _id_EnFrame66, _id_EnFrame67, $FF

L9BE5:  .byte _id_EnFrame69, _id_EnFrame6A, $FF

L9BE8:  .byte _id_EnFrame68, $FF

L9BEA:  .byte _id_EnFrame6B, $FF

L9BEC:  .byte _id_EnFrame66, $FF

L9BEE:  .byte _id_EnFrame69, $FF

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
    PtrTableEntry EnPlacePtrTable, EnPlaceE

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace2:
    .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
    .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
    .byte $12, $E8, $14, $F8

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
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlaceE:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

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
    .byte $22, $13, $14
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
    .byte $22, $13, $14
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
    .byte $22, $13, $14
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
    .byte $22, $13, $14
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
    .byte $62, $13, $14
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
    .byte $62, $13, $14
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
    .byte $62, $13, $14
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
    .byte $62, $13, $14
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
    .byte $30, $07, $07
    .byte $EC
    .byte $FF

EnFrame0D:
    .byte $30, $07, $07
    .byte $FB
    .byte $FF

EnFrame0E:
    .byte $F0, $07, $07
    .byte $EC
    .byte $FF

EnFrame0F:
    .byte $F0, $07, $07
    .byte $FB
    .byte $FF

EnFrame10:
    .byte $70, $07, $07
    .byte $EC
    .byte $FF

EnFrame11:
    .byte $70, $07, $07
    .byte $FB
    .byte $FF

EnFrame12:
    .byte $B0, $07, $07
    .byte $EC
    .byte $FF

EnFrame13:
    .byte $B0, $07, $07
    .byte $FB
    .byte $FF

EnFrame14:
EnFrame15:
EnFrame16:
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
EnFrame1D:
EnFrame1E:
EnFrame1F:
EnFrame20:
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
    .byte $2D, $08, $0A
    .byte $E2
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FE
    .byte $FE
    .byte $FD, $62
    .byte $E2
    .byte $F2
    .byte $FF

EnFrame31:
    .byte $2D, $08, $0A
    .byte $E4
    .byte $F2
    .byte $FE
    .byte $FE
    .byte $E3
    .byte $F3
    .byte $FD, $62
    .byte $E4
    .byte $F2
    .byte $FF

EnFrame32:
    .byte $2E, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, $62
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame33:
    .byte $AD, $08, $0A
    .byte $E2
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FE
    .byte $FE
    .byte $FD, $E2
    .byte $E2
    .byte $F2
    .byte $FF

EnFrame34:
    .byte $AD, $08, $0A
    .byte $E4
    .byte $F2
    .byte $FE
    .byte $FE
    .byte $E3
    .byte $F3
    .byte $FD, $E2
    .byte $E4
    .byte $F2
    .byte $FF

EnFrame35:
    .byte $AE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, $E2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame36:
EnFrame37:
    .byte $21, $00, $00
    .byte $FC, $08, $FC
    .byte $E2
    .byte $FC, $00, $08
    .byte $E2
    .byte $FC, $00, $F8
    .byte $F2
    .byte $FC, $00, $08
    .byte $F2
    .byte $FF

EnFrame38:
    .byte $21, $00, $00
    .byte $FC, $00, $FC
    .byte $F2
    .byte $FC, $00, $08
    .byte $F2
    .byte $FC, $00, $F8
    .byte $E2
    .byte $FC, $00, $08
    .byte $E2
    .byte $FF

EnFrame39:
EnFrame3A:
EnFrame3B:
EnFrame3C:
EnFrame3D:
EnFrame3E:
EnFrame3F:
EnFrame40:
EnFrame41:
EnFrame42:
    .byte $20, $04, $04
    .byte $C0
    .byte $FF

EnFrame43:
    .byte $20, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44:
    .byte $23, $00, $00
    .byte $D1
    .byte $FD, $62
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
