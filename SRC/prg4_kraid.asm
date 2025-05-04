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
    .word EnemyFramePtrTbl1         ;($9CF7)Address table into enemy animation data. Two-->
    .word EnemyFramePtrTbl2         ;($9DF7)tables needed to accommodate all entries.
    .word EnemyPlacePtrTbl          ;($9E25)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($9C86)Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
    jmp L9C49                       ;Area specific routine.

TwosComplement_:
    eor #$FF                        ;
    clc                             ;The following routine returns the twos-->
    adc #$01                        ;complement of the value stored in A.
RTS_95CB:
    rts

L95CC:  .byte $1D                       ;Kraid's room.

L95CD:  .byte $10                       ;Kraid's hideout music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $07                       ;Samus start x coord on world map.
L95D8:  .byte $14                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $43, $00, $00, $00, $00, $00, $00, $64

ChooseEnemyAIRoutine:
    lda EnDataIndex,x
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

L960B:  .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $48, $48, $50, $4E

L961B:  .byte $6D, $6F, $00, $00, $00, $00, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L962B:  .byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $54, $52

L964B:  .byte $67, $6A, $56, $58, $5D, $62, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $4B, $48

L966B:  .byte $67, $6A, $56, $58, $5A, $5F, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

L968B:  .byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

L96AB:  .byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:  .byte $00, $03, $00, $06, $08, $0C, $00, $0A, $0E, $11, $13, $00, $00, $00, $00, $00

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

L978B:  .byte $00, $00, $5F, $62, $64, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word L98C9, L98D8, L98E7, L98F6

L97AF:  .word L9C4A, L9C4F, L9C54, L9C59, L9C5E, L9C63, L9C68, L9C6D
L97BF:  .word L9C72, L9C77, L9C7C, L9C81, L9C86, L9C86, L9C86, L9C86
L97CF:  .word L9C86

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

L98C9:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L98D8:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L98E7:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L98F6:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

CommonEnemyJump_00_01_02:
    lda $81
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

; Area Specific Routine
L9C49:  rts

; What's this table?
L9C4A:  .byte $22, $FF, $FF, $FF, $FF

L9C4F:  .byte $22, $80, $81, $82, $83

L9C54:  .byte $22, $84, $85, $86, $87

L9C59:  .byte $22, $88, $89, $8A, $8B

L9C5E:  .byte $22, $8C, $8D, $8E, $8F

L9C63:  .byte $22, $94, $95, $96, $97

L9C68:  .byte $22, $9C, $9D, $9D, $9C

L9C6D:  .byte $22, $9E, $9F, $9F, $9E

L9C72:  .byte $22, $90, $91, $92, $93

L9C77:  .byte $22, $70, $71, $72, $73

L9C7C:  .byte $22, $74, $75, $76, $77

L9C81:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9C86:  .byte $00, $01, $FF

L9C89:  .byte $02, $FF

L9C8B:  .byte $19, $1A, $FF

L9C8E:  .byte $1A, $1B, $FF

L9C91:  .byte $1C, $1D, $FF

L9C94:  .byte $1D, $1E, $FF

L9C97:  .byte $22, $23, $24, $FF

L9C9B:  .byte $1F, $20, $21, $FF

L9C9F:  .byte $22, $FF

L9CA1:  .byte $1F, $FF

L9CA3:  .byte $23, $04, $FF

L9CA6:  .byte $20, $03, $FF

L9CA9:  .byte $27, $28, $29, $FF

L9CAD:  .byte $37, $FF

L9CAF:  .byte $38, $FF

L9CB1:  .byte $39, $FF

L9CB3:  .byte $3A, $FF

L9CB5:  .byte $3B, $FF

L9CB7:  .byte $3C, $FF

L9CB9:  .byte $3D, $FF

L9CBB:  .byte $58, $59, $FF

L9CBE:  .byte $5A, $5B, $FF

L9CC1:  .byte $5C, $5D, $FF

L9CC4:  .byte $5E, $5F, $FF

L9CC7:  .byte $60, $FF

L9CC9:  .byte $61, $F7, $62, $F7, $FF

L9CCE:  .byte $66, $67, $FF

L9CD1:  .byte $69, $6A, $FF

L9CD4:  .byte $68, $FF

L9CD6:  .byte $6B, $FF

L9CD8:  .byte $66, $FF

L9CDA:  .byte $69, $FF

L9CDC:  .byte $6C, $FF

L9CDE:  .byte $6D, $FF

L9CE0:  .byte $6F, $70, $71, $6E, $FF

L9CE5:  .byte $73, $74, $75, $72, $FF

L9CEA:  .byte $8F, $90, $FF

L9CED:  .byte $91, $92, $FF

L9CF0:  .byte $93, $94, $FF

L9CF3:  .byte $95, $FF

L9CF5:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
    .word L9ED9, L9EDE, L9EE3, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8
    .word L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8
    .word L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8, L9EE8
    .word L9EE8, L9EE8, L9EF6, L9F04, L9F10, L9F1E, L9F2C, L9F38
    .word L9F41, L9F4B, L9F55, L9F5E, L9F68, L9F72, L9F72, L9F72
    .word L9F80, L9F87, L9F90, L9F90, L9F90, L9F90, L9F90, L9F90
    .word L9F90, L9F90, L9F90, L9F90, L9F90, L9F90, L9F90, L9F90
    .word L9FA4, L9FB8, L9FC3, L9FCE, L9FD7, L9FE0, L9FEB, L9FEB
    .word L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB
    .word L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB
    .word L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB, L9FEB
    .word L9FEB, L9FF3, L9FFB, LA003, LA00B, LA013, LA01B, LA023
    .word LA02B, LA033, LA041, LA05B, LA05B, LA05B, LA05B, LA063
    .word LA06B, LA073, LA07B, LA083, LA08B, LA093, LA09B, LA0A3
    .word LA0AB, LA0B3, LA0BB, LA0C3, LA0CB, LA0D3, LA0DB, LA0DB
    .word LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB

EnemyFramePtrTbl2:
    .word LA0DB, LA0E3, LA0E8, LA0E8, LA0E8, LA0E8, LA0E8, LA0E8
    .word LA0E8, LA0E8, LA0ED, LA0ED, LA0ED, LA0ED, LA0ED, LA0ED
    .word LA0F7, LA101, LA111, LA121, LA131, LA141, LA14B

EnemyPlacePtrTbl:
    .word L9E45, L9E47, L9E5F, L9E77, L9E77, L9E77, L9E87, L9E93
    .word L9E9B, L9EA7, L9EA7, L9EC7, L9ED5, L9ED5, L9ED5, L9ED5

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9E45:  .byte $FC, $FC

L9E47:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9E57:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9E5F:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9E6F:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9E77:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9E87:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9E93:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9E9B:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9EA7:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9EB7:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9EC7:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9ED5:  .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

L9ED9:  .byte $00, $02, $02, $14, $FF

L9EDE:  .byte $00, $02, $02, $24, $FF

L9EE3:  .byte $00, $00, $00, $04, $FF

L9EE8:  .byte $25, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9EF6:  .byte $25, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9F04:  .byte $26, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9F10:  .byte $A5, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9F1E:  .byte $A5, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9F2C:  .byte $A6, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9F38:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F41:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

L9F4B:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

L9F55:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F5E:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

L9F68:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

L9F72:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

L9F80:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

L9F87:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

L9F90:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FA0:  .byte $00, $08, $F2, $FF

L9FA4:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
L9FB4:  .byte $00, $08, $E2, $FF

L9FB8:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

L9FC3:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

L9FCE:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

L9FD7:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

L9FE0:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

L9FEB:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FF3:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FFB:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA003:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA00B:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA013:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA01B:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA023:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA02B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA033:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA041:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA051:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA05B:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA063:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA06B:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA073:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA07B:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA083:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA08B:  .byte $20, $02, $04, $FC, $FF

LA090:  .byte $00, $F8, $FF

LA093:  .byte $60, $02, $04, $FC, $FF

LA098:  .byte $00, $F8, $FF

LA09B:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA0A3:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA0AB:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA0B3:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA0BB:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA0C3:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA0CB:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA0D3:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA0DB:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA0E3:  .byte $00, $04, $04, $8A, $FF

LA0E8:  .byte $00, $04, $04, $8A, $FF

LA0ED:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA0F7:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA101:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA111:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA121:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA131:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA141:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA14B:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

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
