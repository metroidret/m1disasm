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

;Brinstar (memory page 1)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

BANK .set 1
.segment "BANK_01_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GFX_TheEndFont
.export GFX_BrinstarSprites

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_TheEndFont:
    .incbin "ending/end_font.chr"       ; 8D60 - "THE END" graphics + partial font
GFX_BrinstarSprites:
    .incbin "brinstar/sprite_tiles.chr" ; 9160 - Brinstar Enemies

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A271)
    .word Palette01                 ;($A295)
    .word Palette02                 ;($A2A1)
    .word Palette03                 ;($A29B)
    .word Palette04                 ;($A2A7)
    .word Palette05                 ;($A2AD)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette07                 ;($A2D7)
    .word Palette08                 ;($A2DE)
    .word Palette09                 ;($A2E5)
    .word Palette0A                 ;($A2EC)
    .word Palette0B                 ;($A2F4)
    .word Palette0C                 ;($A2FC)
    .word Palette0D                 ;($A304)
    .word Palette0E                 ;($A30C)

AreaPointers:
    .word SpecItmsTbl               ;($A3D6)Beginning of special items table.
    .word RmPtrTbl                  ;($A314)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A372)Beginning of structure pointer table.
    .word MacroDefs                 ;($AEF0)Beginning of macro definitions.
    .word EnemyFramePtrTbl1         ;($9DE0)Pointer table into enemy animation data. Two-->
    .word EnemyFramePtrTbl2         ;($9EE0)tables needed to accommodate all entries.
    .word EnemyPlacePtrTbl          ;($9F0E)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($9D6A)index to values in addr tables for enemy animations.

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

AreaRoutine: ; L95C3
    jmp AreaRoutineStub ; Just an RTS

TwosComplement_:
    eor #$FF                        ;
    clc                             ;The following routine returns the twos-->
    adc #$01                        ;complement of the value stored in A.
    rts                             ;

; area init data
    .byte $FF                       ;Not used.

    .byte $01                       ;Brinstar music init flag.

    .byte $80                       ;Base damage caused by area enemies to lower health byte.
    .byte $00                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
    .byte $2B, $2C, $28, $0B, $1C, $0A, $1A

    .byte $03                       ;Samus start x coord on world map.
    .byte $0E                       ;Samus start y coord on world map.
    .byte $B0                       ;Samus start verticle screen position.

    .byte $01, $00, $03, $43, $00
    .byte $00, $00, $00, $00, $00, $69

; Enemy AI jump table
ChooseEnemyRoutine:
    lda EnDataIndex,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorRoutine ; 00 - Sidehopper
        .word SidehopperCeilingRoutine ; 01 - Ceiling sidehopper
        .word WaverRoutine ; 02 - Waver
        .word RipperRoutine ; 03 - Ripper
        .word SkreeRoutine ; 04 - Skree
        .word CrawlerRoutine ; 05 - Zoomer (crawler)
        .word RioRoutine ; 06 - Rio (swoopers)
        .word PipeBugRoutine ; 07 - Zeb
        .word KraidRoutine ; 08 - Kraid (crashes due to bug)
        .word KraidLint ; 09 - Kraid's lint (crashes)
        .word KraidNail ; 0A - Kraid's nail (crashes)
        .word $0000 ; 0B - Null pointers (hard crash)
        .word $0000 ; 0C - Null
        .word $0000 ; 0D - Null
        .word $0000 ; 0E - Null
        .word $0000 ; 0F - Null

; Animation related table ?
L960B:
    .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $4B, $4B, $55, $53
    .byte $72, $74, $00, $00, $00, $00, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

EnemyHitPointTbl:
    .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

; ResetAnimIndex table
L963B:
    .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $59, $57
    .byte $6C, $6F, $5B, $5D, $62, $67, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

; another ResetAnimIndex table
L965B:
    .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $50, $4D
    .byte $6C, $6F, $5B, $5D, $5F, $64, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

;another animation related table
L967B:
    .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

; Screw attack vulnerability? Hit sound?
; Bit 5 (0x20) determines something about how it computes velocity
L968B:
    .byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00

; EnData0D table (set upon load, and a couple other times)
L969B:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00

; Some table referenced when loading an enemy
L96AB:
    .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl:
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

; Index to a table starting at L97D1
L96CB:
    .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

; EnData08*2 + one of the low bits of EnData05 is used as an index to this pointer table
; Pointer table to enemy movement strings
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
; Unused padding to the above?
    .byte $00, $00, $00, $00, $00, $00, $00, $00

; I think these next for tables each have 4 unused bytes at the end
; EnData1A table
L972B:  .byte $7F, $40, $30, $C0, $D0, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
; EnData1B table
L973F:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
; EnData02 table
L9753:  .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
; EnData03 table
L9767:  .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

; Behavior-Related Table?
L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

; Enemy animation related table?
L978B:  .byte $00, $00, $64, $67, $69, $69, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

; Another movement pointer table?
; Referenced using EnData0A
L97A7:  .word L9965, L9974, L9983, L9992
; Referenced by LFE83
L97AF:  .word L9D36, L9D3B, L9D40, L9D45, L9D4A, L9D4F, L9D54, L9D59
L97BF:  .word L9D5D, L9D63, L9D6A, L9D6A, L9D6A, L9D6A, L9D6A, L9D6A
L97CF:  .word L9D6A

; If I'm reading the code correctly, this table is accessed with this formula:
;  EnData08 = L97D1[(L97D1[L96CB[EnemyDataIndex]] and (FrameCount xor RandomNumber1))+1]
L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09
L97E1:  .byte $00, $00, $00, $0B, $01, $0C, $0D, $00, $0E, $03, $0F, $10, $11, $0F

;-------------------------------------------------------------------------------
;I believe this is the point where the level banks don't need to match addresses
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Enemy movement strings (pointed to by the table L96DB)
;  These are decoded/read starting at about L8244 in areas_common.asm
;  An enemy may use these if bit 6 of their value on the table at L977B is set
;  EnCounter determined the offset within the string to be read
;
; Format
; values <0xF0 specify a duration in frames, followed by a bitpacked velocity vector
; 0xFA-0xFE are control codes I haven't deciphered yet
; 0xFF is "restart"

EnemyMovement00:
    SignMagSpeed $20,  2,  2
    .byte $FE

EnemyMovement01:
    SignMagSpeed $20, -2,  2
    .byte $FE

; probably for wavers
EnemyMovement02:
EnemyMovement03:
EnemyMovement04:
EnemyMovement05:
EnemyMovement06:
EnemyMovement07:
EnemyMovement08:
EnemyMovement09:
EnemyMovement0A:
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
    SignMagSpeed $02,  2,  7
    SignMagSpeed $02,  2,  7
    SignMagSpeed $04,  2,  6
    SignMagSpeed $04,  2,  5
    SignMagSpeed $05,  2,  3
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2, -1
    SignMagSpeed $03,  2, -3
    SignMagSpeed $05,  2, -5
    SignMagSpeed $04,  2, -6
    SignMagSpeed $02,  2, -7
    .byte $FD

    SignMagSpeed $03,  2, -5
    SignMagSpeed $06,  2, -3
    SignMagSpeed $08,  2, -1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2,  1
    SignMagSpeed $05,  2,  3
    SignMagSpeed $04,  2,  5
    SignMagSpeed $03,  2,  5
    SignMagSpeed $06,  2,  3
    SignMagSpeed $08,  2,  1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2, -1
    SignMagSpeed $05,  2, -3
    SignMagSpeed $04,  2, -5
    .byte $FD
    .byte $FF

EnemyMovement0B:
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
    SignMagSpeed $02, -2,  7
    SignMagSpeed $02, -2,  7
    SignMagSpeed $04, -2,  6
    SignMagSpeed $04, -2,  5
    SignMagSpeed $05, -2,  3
    SignMagSpeed $03, -2,  1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2, -1
    SignMagSpeed $03, -2, -3
    SignMagSpeed $05, -2, -5
    SignMagSpeed $04, -2, -6
    SignMagSpeed $02, -2, -7
    .byte $FD

    SignMagSpeed $03, -2, -5
    SignMagSpeed $06, -2, -3
    SignMagSpeed $08, -2, -1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2,  1
    SignMagSpeed $05, -2,  3
    SignMagSpeed $04, -2,  5
    SignMagSpeed $03, -2,  5
    SignMagSpeed $06, -2,  3
    SignMagSpeed $08, -2,  1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2, -1
    SignMagSpeed $05, -2, -3
    SignMagSpeed $04, -2, -5
    .byte $FD
    .byte $FF

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
    SignMagSpeed $1E,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E, -1,  1
    .byte $FE

EnemyMovement1B:
    SignMagSpeed $1E, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E,  1,  1
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

;-------------------------------------------------------------------------------

; Instruction (?) strings of a different type pointed to by L97A7
L9965:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L9974:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9983:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9992:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

;-------------------------------------------------------------------------------

CommonEnemyJump_00_01_02:
    lda $81
    cmp #$01
    beq L99B0
    cmp #$03
    beq L99B5
        lda $00
        jmp CommonJump_00
    L99B0:
        lda $01
        jmp CommonJump_01
    L99B5:
        jmp CommonJump_02

.include "enemies/sidehopper.asm"

;-------------------------------------------------------------------------------

.include "enemies/ripper.asm"

;-------------------------------------------------------------------------------

.include "enemies/waver.asm"

;-------------------------------------------------------------------------------
; SkreeRoutine
.include "enemies/skree.asm"
; The crawler routine below depends upon two of the exit labels in skree.asm

;-------------------------------------------------------------------------------

.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------
; Rio/Swooper Routine
.include "enemies/rio.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Brinstar Kraid Routine
.include "enemies/kraid.asm"
; Note: For this bank the functions StorePositionToTemp and LoadPositionFromTemp
;  are in are in kraid.asm. Extract those functions from that file if you plan
;  on removing it.

AreaRoutineStub: ;L9D35
    rts

; More strings pointed to by L97A7
L9D36:  .byte $22, $FF, $FF, $FF, $FF
L9D3B:  .byte $22, $80, $81, $82, $83
L9D40:  .byte $22, $84, $85, $86, $87
L9D45:  .byte $22, $88, $89, $8A, $8B
L9D4A:  .byte $22, $8C, $8D, $8E, $8F
L9D4F:  .byte $22, $94, $95, $96, $97
L9D54:  .byte $22, $9C, $9D, $9D, $9C
L9D59:  .byte $22, $9E, $9F, $9F, $9E
L9D5D:  .byte $22, $90, $91, $92, $93
L9D63:  .byte $32, $4E, $4E, $4E, $4E, $4E, $4E

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:

L9D6A:  .byte $00, $01, $FF

L9D6D:  .byte $02, $FF

L9D6F:  .byte $19, $1A, $FF

L9D72:  .byte $1A, $1B, $FF

L9D75:  .byte $1C, $1D, $FF

L9D78:  .byte $1D, $1E, $FF

L9D7B:  .byte $22, $23, $24, $FF

L9D7F:  .byte $1F, $20, $21, $FF

L9D83:  .byte $22, $FF

L9D85:  .byte $1F, $FF

L9D87:  .byte $23, $04, $FF

L9D8A:  .byte $20, $03, $FF

L9D8D:  .byte $27, $28, $29, $FF

L9D91:  .byte $37, $FF

L9D93:  .byte $38, $FF

L9D95:  .byte $39, $FF

L9D97:  .byte $3A, $FF

L9D99:  .byte $3B, $FF

L9D9B:  .byte $3C, $FF

L9D9D:  .byte $3D, $FF

L9D9F:  .byte $58, $59, $FF

L9DA2:  .byte $5A, $5B, $FF

L9DA5:  .byte $5C, $5D, $FF

L9DA8:  .byte $5E, $5F, $FF

L9DAB:  .byte $60, $FF

L9DAD:  .byte $61, $F7, $62, $F7, $FF

L9DB2:  .byte $63, $64, $FF

L9DB5:  .byte $65, $FF

L9DB7:  .byte $66, $67, $FF

L9DBA:  .byte $69, $6A, $FF

L9DBD:  .byte $68, $FF

L9DBF:  .byte $6B, $FF

L9DC1:  .byte $66, $FF

L9DC3:  .byte $69, $FF

L9DC5:  .byte $6C, $FF

L9DC7:  .byte $6D, $FF

L9DC9:  .byte $6F, $70, $71, $6E, $FF

L9DCE:  .byte $73, $74, $75, $72, $FF

L9DD3:  .byte $8F, $90, $FF

L9DD6:  .byte $91, $92, $FF

L9DD9:  .byte $93, $94, $FF

L9DDC:  .byte $95, $FF

L9DDE:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
    .word L9FC2, L9FC7, L9FCC, L9FD1, L9FDA, L9FE3, L9FE3, L9FE3
    .word L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3
    .word L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3, L9FE3
    .word L9FE3, L9FE3, L9FF1, L9FFF, LA00B, LA019, LA027, LA033
    .word LA03C, LA046, LA050, LA059, LA063, LA06D, LA06D, LA06D
    .word LA07B, LA082, LA08B, LA08B, LA08B, LA08B, LA08B, LA08B
    .word LA08B, LA08B, LA08B, LA08B, LA08B, LA08B, LA08B, LA08B
    .word LA09F, LA0B3, LA0BE, LA0C9, LA0D2, LA0DB, LA0E6, LA0E6
    .word LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6
    .word LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6
    .word LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6
    .word LA0E6, LA0EE, LA0F6, LA0FE, LA106, LA10E, LA116, LA11E
    .word LA126, LA12E, LA13C, LA156, LA162, LA16F, LA177, LA17F
    .word LA187, LA18F, LA197, LA19F, LA1A7, LA1AF, LA1B7, LA1BF
    .word LA1C7, LA1CF, LA1D7, LA1DF, LA1E7, LA1EF, LA1F7, LA1F7
    .word LA1F7, LA1F7, LA1F7, LA1F7, LA1F7, LA1F7, LA1F7, LA1F7

EnemyFramePtrTbl2:
    .word LA1F7, LA1FF, LA204, LA204, LA204, LA204, LA204, LA204
    .word LA204, LA204, LA209, LA209, LA209, LA209, LA209, LA209
    .word LA213, LA21D, LA22D, LA23D, LA24D, LA25D, LA267

EnemyPlacePtrTbl:
    .word L9F2E, L9F30, L9F48, L9F60, L9F60, L9F60, L9F70, L9F7C
    .word L9F84, L9F90, L9F90, L9FB0, L9FBE, L9FBE, L9FBE, L9FBE

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9F2E:  .byte $FC, $FC

;Enemy explode.
L9F30:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9F40:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9F48:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9F58:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9F60:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9F70:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9F7C:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9F84:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9F90:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9FA0:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9FB0:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9FBE:  .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

L9FC2:  .byte $00, $02, $02, $14, $FF

L9FC7:  .byte $00, $02, $02, $24, $FF

L9FCC:  .byte $00, $00, $00, $04, $FF

L9FD1:  .byte $27, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FDA:  .byte $67, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FE3:  .byte $25, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $62, $A3, $B3, $FF

L9FF1:  .byte $25, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $62, $A5, $B3, $FF

L9FFF:  .byte $26, $08, $0A, $B5, $B3, $A4, $B4, $FD, $62, $B5, $B3, $FF

LA00B:  .byte $A5, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $E2, $A3, $B3, $FF

LA019:  .byte $A5, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $E2, $A5, $B3, $FF

LA027:  .byte $A6, $08, $0A, $B5, $B3, $A4, $B4, $FD, $E2, $B5, $B3, $FF

LA033:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA03C:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

LA046:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

LA050:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA059:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

LA063:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

LA06D:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

LA07B:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

LA082:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

LA08B:
    .byte $21, $00, $00, $FC, $08, $FC, $A3, $FC, $00, $08, $A3, $FC, $00, $F8, $B3, $FC
    .byte $00, $08, $B3, $FF

LA09F:
    .byte $21, $00, $00, $FC, $00, $FC, $B3, $FC, $00, $08, $B3, $FC, $00, $F8, $A3, $FC
    .byte $00, $08, $A3, $FF

LA0B3:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

LA0BE:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

LA0C9:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

LA0D2:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

LA0DB:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

LA0E6:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0EE:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0F6:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA0FE:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA106:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA10E:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA116:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA11E:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA126:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA12E:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA13C:
    .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
    .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA156:  .byte $2B, $08, $08, $E2, $E3, $E4, $FE, $FD, $62, $E3, $E4, $FF

LA162:  .byte $2B, $08, $08, $E2, $E3, $FE, $E4, $FD, $62, $E3, $FE, $E4, $FF

LA16F:  .byte $21, $00, $00, $96, $96, $98, $98, $FF

LA177:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA17F:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA187:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA18F:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA197:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA19F:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA1A7:  .byte $20, $02, $04, $FC, $FF

LA1AC:  .byte $00, $F8, $FF

LA1AF:  .byte $60, $02, $04, $FC, $FF

LA1B4:  .byte $00, $F8, $FF

LA1B7:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA1BF:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA1C7:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA1CF:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA1D7:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA1DF:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA1E7:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA1EF:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA1F7:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA1FF:  .byte $00, $04, $04, $8A, $FF

LA204:  .byte $00, $04, $04, $8A, $FF

LA209:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA213:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA21D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA22D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA23D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA24D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA25D:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA267:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

.include "brinstar/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "brinstar/room_ptrs.asm"

.include "brinstar/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "brinstar/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "brinstar/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "brinstar/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "brinstar/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.include "songs/brinstar.asm"

; Errant Mother Brain BG tiles (unused)
    .byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
    .byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
    .byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
    .byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
    .byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
    .byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
    .byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
    .byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
    .byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
    .byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
    .byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
    .byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
; ???
    .byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_01_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
