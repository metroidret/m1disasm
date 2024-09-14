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

LAEEC:  .byte $F1, $F1, $F1, $F1
LAEF0:  .byte $FF, $FF, $F0, $F0
LAEF4:  .byte $64, $64, $64, $64
LAEF8:  .byte $FF, $FF, $64, $64
LAEFC:  .byte $A4, $FF, $A4, $FF
LAF00:  .byte $FF, $A5, $FF, $A5
LAF04:  .byte $A0, $A0, $A0, $A0
LAF08:  .byte $A1, $A1, $A1, $A1
LAF0C:  .byte $FF, $FF, $59, $5A
LAF10:  .byte $FF, $FF, $5A, $5B
LAF14:  .byte $FF, $FF, $FF, $FF
LAF18:  .byte $10, $10, $10, $10
LAF1C:  .byte $23, $24, $25, $0B
LAF20:  .byte $1B, $1C, $1D, $1E
LAF24:  .byte $17, $18, $19, $1A
LAF28:  .byte $1F, $20, $21, $22
LAF2C:  .byte $60, $61, $62, $63
LAF30:  .byte $0E, $0F, $FF, $FF
LAF34:  .byte $0C, $0D, $0D, $0D
LAF38:  .byte $10, $0D, $FF, $10
LAF3C:  .byte $10, $FF, $FF, $FF
LAF40:  .byte $FF, $FF, $FF, $30
LAF44:  .byte $FF, $33, $FF, $36
LAF48:  .byte $FF, $39, $FF, $3D
LAF4C:  .byte $FF, $FF, $31, $32
LAF50:  .byte $34, $35, $37, $38
LAF54:  .byte $3A, $3B, $3E, $3F
LAF58:  .byte $3C, $41, $40, $42
LAF5C:  .byte $84, $85, $86, $87
LAF60:  .byte $80, $81, $82, $83
LAF64:  .byte $88, $89, $8A, $8B
LAF68:  .byte $45, $46, $45, $46
LAF6C:  .byte $47, $48, $48, $47
LAF70:  .byte $5C, $5D, $5E, $5F
LAF74:  .byte $B8, $B8, $B9, $B9
LAF78:  .byte $74, $75, $75, $74
LAF7C:  .byte $C1, $13, $13, $13
LAF80:  .byte $36, $BE, $BC, $BD
LAF84:  .byte $BF, $14, $15, $14
LAF88:  .byte $C0, $14, $C0, $16
LAF8C:  .byte $FF, $C1, $FF, $FF
LAF90:  .byte $C2, $14, $FF, $FF
LAF94:  .byte $30, $13, $BC, $BD
LAF98:  .byte $13, $14, $15, $16
LAF9C:  .byte $D7, $D7, $D7, $D7
LAFA0:  .byte $76, $76, $76, $76
LAFA4:  .byte $FF, $FF, $BA, $BA
LAFA8:  .byte $BB, $BB, $BB, $BB
LAFAC:  .byte $00, $01, $02, $03
LAFB0:  .byte $04, $05, $06, $07
LAFB4:  .byte $FF, $FF, $08, $09
LAFB8:  .byte $FF, $FF, $09, $0A
LAFBC:  .byte $55, $56, $57, $58
LAFC0:  .byte $90, $91, $92, $93
LAFC4:  .byte $4B, $4C, $4D, $50
LAFC8:  .byte $51, $52, $53, $54
LAFCC:  .byte $70, $71, $72, $73
LAFD0:  .byte $8C, $8D, $8E, $8F
LAFD4:  .byte $11, $12, $FF, $11
LAFD8:  .byte $11, $12, $12, $11
LAFDC:  .byte $11, $12, $12, $FF
LAFE0:  .byte $C3, $C4, $C5, $C6

LAFE4:  .byte $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93
LAFF4:  .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0