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
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Norfair Metatile Definitions

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile.

MacroDefs:
    .byte $F1, $F1, $F1, $F1
    .byte $FF, $FF, $F0, $F0
    .byte $64, $64, $64, $64
    .byte $FF, $FF, $64, $64
    .byte $A4, $FF, $A4, $FF
    .byte $FF, $A5, $FF, $A5
    .byte $A0, $A0, $A0, $A0
    .byte $A1, $A1, $A1, $A1
    .byte $FF, $FF, $59, $5A
    .byte $FF, $FF, $5A, $5B
    .byte $FF, $FF, $FF, $FF
    .byte $10, $10, $10, $10
    .byte $23, $24, $25, $0B
    .byte $1B, $1C, $1D, $1E
    .byte $17, $18, $19, $1A
    .byte $1F, $20, $21, $22
    .byte $60, $61, $62, $63
    .byte $0E, $0F, $FF, $FF
    .byte $0C, $0D, $0D, $0D
    .byte $10, $0D, $FF, $10
    .byte $10, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $30
    .byte $FF, $33, $FF, $36
    .byte $FF, $39, $FF, $3D
    .byte $FF, $FF, $31, $32
    .byte $34, $35, $37, $38
    .byte $3A, $3B, $3E, $3F
    .byte $3C, $41, $40, $42
    .byte $84, $85, $86, $87
    .byte $80, $81, $82, $83
    .byte $88, $89, $8A, $8B
    .byte $45, $46, $45, $46
    .byte $47, $48, $48, $47
    .byte $5C, $5D, $5E, $5F
    .byte $B8, $B8, $B9, $B9
    .byte $74, $75, $75, $74
    .byte $C1, $13, $13, $13
    .byte $36, $BE, $BC, $BD
    .byte $BF, $14, $15, $14
    .byte $C0, $14, $C0, $16
    .byte $FF, $C1, $FF, $FF
    .byte $C2, $14, $FF, $FF
    .byte $30, $13, $BC, $BD
    .byte $13, $14, $15, $16
    .byte $D7, $D7, $D7, $D7
    .byte $76, $76, $76, $76
    .byte $FF, $FF, $BA, $BA
    .byte $BB, $BB, $BB, $BB
    .byte $00, $01, $02, $03
    .byte $04, $05, $06, $07
    .byte $FF, $FF, $08, $09
    .byte $FF, $FF, $09, $0A
    .byte $55, $56, $57, $58
    .byte $90, $91, $92, $93
    .byte $4B, $4C, $4D, $50
    .byte $51, $52, $53, $54
    .byte $70, $71, $72, $73
    .byte $8C, $8D, $8E, $8F
    .byte $11, $12, $FF, $11
    .byte $11, $12, $12, $11
    .byte $11, $12, $12, $FF
    .byte $C3, $C4, $C5, $C6

    .byte $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93
;Not used.
.if BUILDTARGET == "NES_NTSC"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif
