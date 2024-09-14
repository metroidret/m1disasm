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

;Brinstar Metatiles

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile.

LAEF0:  .byte $F1, $F1, $F1, $F1
LAEF4:  .byte $FF, $FF, $F0, $F0
LAEF8:  .byte $64, $64, $64, $64
LAEFC:  .byte $D5, $D6, $CB, $CC
LAF00:  .byte $A4, $FF, $A4, $FF
LAF04:  .byte $FF, $A5, $FF, $A5
LAF08:  .byte $A0, $A0, $A0, $A0
LAF0C:  .byte $A1, $A1, $A1, $A1
LAF10:  .byte $00, $01, $02, $03
LAF14:  .byte $0B, $00, $FF, $0B
LAF18:  .byte $03, $0A, $0A, $FF
LAF1C:  .byte $08, $09, $02, $03
LAF20:  .byte $0E, $0F, $10, $11
LAF24:  .byte $12, $13, $14, $0C
LAF28:  .byte $FF, $FF, $FF, $30
LAF2C:  .byte $FF, $33, $FF, $36
LAF30:  .byte $FF, $39, $FF, $3D
LAF34:  .byte $FF, $FF, $31, $32
LAF38:  .byte $34, $35, $37, $38
LAF3C:  .byte $3A, $3B, $3E, $3F
LAF40:  .byte $3C, $41, $40, $42
LAF44:  .byte $FF, $FF, $43, $43
LAF48:  .byte $44, $44, $44, $44
LAF4C:  .byte $45, $46, $45, $46
LAF50:  .byte $FF, $47, $47, $48
LAF54:  .byte $48, $FF, $47, $48
LAF58:  .byte $48, $47, $47, $48
LAF5C:  .byte $49, $49, $4A, $4A
LAF60:  .byte $4B, $4C, $4D, $50
LAF64:  .byte $51, $52, $53, $54
LAF68:  .byte $55, $56, $57, $58
LAF6C:  .byte $59, $5B, $59, $5B
LAF70:  .byte $5C, $5D, $5E, $5F
LAF74:  .byte $4F, $4F, $4F, $4F
LAF78:  .byte $88, $89, $8A, $8B
LAF7C:  .byte $84, $85, $86, $87
LAF80:  .byte $8C, $8D, $8E, $8F
LAF84:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF88:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF8C:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF90:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF94:  .byte $B0, $B1, $B2, $B3
LAF98:  .byte $B4, $B5, $B6, $B7
LAF9C:  .byte $B8, $B8, $B9, $B9
LAFA0:  .byte $FF, $FF, $BA, $BA
LAFA4:  .byte $BB, $BB, $BB, $BB
LAFA8:  .byte $C7, $C8, $C9, $CA
LAFAC:  .byte $94, $95, $96, $97
LAFB0:  .byte $0D, $FF, $FF, $FF
LAFB4:  .byte $FF, $FF, $59, $5A
LAFB8:  .byte $FF, $FF, $5A, $5B
LAFBC:  .byte $80, $81, $82, $83
LAFC0:  .byte $04, $05, $04, $05
LAFC4:  .byte $06, $06, $07, $07
LAFC8:  .byte $60, $61, $62, $63
LAFCC:  .byte $C1, $00, $00, $08
LAFD0:  .byte $0B, $BE, $BC, $BD
LAFD4:  .byte $BF, $01, $02, $03
LAFD8:  .byte $C0, $01, $C0, $03
LAFDC:  .byte $FF, $C1, $FF, $FF
LAFE0:  .byte $C2, $01, $FF, $FF
LAFE4:  .byte $30, $00, $BC, $BD
LAFE8:  .byte $CD, $CE, $CF, $D0
LAFEC:  .byte $D1, $D2, $D3, $D4
LAFF0:  .byte $90, $91, $92, $93
;Not used.
LAFF4:  .byte $20, $20, $20, $20
LAFF8:  .byte $C0, $C0, $C0, $C0
LAFFC:  .byte $C0, $C0, $C0, $C0