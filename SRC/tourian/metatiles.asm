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

;Tourian Metatile Data

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

LAE49:  .byte $A7, $A7, $A7, $A7
LAE4D:  .byte $FF, $FF, $A6, $A6
LAE51:  .byte $A2, $A2, $FF, $FF
LAE55:  .byte $FF, $FF, $A3, $A3
LAE59:  .byte $A4, $FF, $A4, $FF
LAE5D:  .byte $FF, $A5, $FF, $A5
LAE61:  .byte $FF, $79, $FF, $7E
LAE65:  .byte $4F, $4F, $4F, $4F
LAE69:  .byte $A0, $A0, $A0, $A0
LAE6D:  .byte $A1, $A1, $A1, $A1
LAE71:  .byte $04, $05, $06, $07
LAE75:  .byte $10, $11, $12, $13
LAE79:  .byte $00, $01, $02, $03
LAE7D:  .byte $08, $08, $08, $08
LAE81:  .byte $18, $19, $1A, $1B
LAE85:  .byte $1C, $1D, $1E, $1F
LAE89:  .byte $0C, $0D, $0E, $0F
LAE8D:  .byte $09, $09, $09, $09
LAE91:  .byte $7A, $7B, $7F, $5A
LAE95:  .byte $2A, $2C, $FF, $FF
LAE99:  .byte $14, $15, $16, $17
LAE9D:  .byte $20, $21, $22, $23
LAEA1:  .byte $24, $25, $20, $21
LAEA5:  .byte $28, $28, $29, $29
LAEA9:  .byte $26, $27, $26, $27
LAEAD:  .byte $2A, $2B, $FF, $FF
LAEB1:  .byte $2B, $2C, $FF, $FF
LAEB5:  .byte $2B, $2B, $FF, $FF
LAEB9:  .byte $FF, $FF, $FF, $FF
LAEBD:  .byte $31, $32, $33, $34
LAEC1:  .byte $35, $36, $37, $38
LAEC5:  .byte $3D, $3E, $3F, $40
LAEC9:  .byte $41, $42, $43, $44
LAECD:  .byte $39, $3A, $39, $3A
LAED1:  .byte $3B, $3B, $3C, $3C
LAED5:  .byte $0B, $0B, $2D, $2E
LAED9:  .byte $2F, $30, $0B, $0B
LAEDD:  .byte $50, $51, $52, $53
LAEE1:  .byte $54, $55, $54, $55
LAEE5:  .byte $56, $57, $58, $59
LAEE9:  .byte $FF, $FF, $FF, $5E
LAEED:  .byte $5B, $5C, $5F, $60
LAEF1:  .byte $FF, $FF, $61, $FF
LAEF5:  .byte $5D, $62, $67, $68
LAEF9:  .byte $63, $64, $69, $6A
LAEFD:  .byte $65, $66, $6B, $6C
LAF01:  .byte $6D, $6E, $73, $74
LAF05:  .byte $6F, $70, $75, $76
LAF09:  .byte $71, $72, $77, $78
LAF0D:  .byte $45, $46, $47, $48
LAF11:  .byte $FF, $98, $FF, $98
LAF15:  .byte $49, $4A, $4B, $4C
LAF19:  .byte $90, $91, $90, $91
LAF1D:  .byte $7C, $7D, $4D, $FF

;Not used.
LAF21:  .byte $1C, $1D, $1E, $17, $18, $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E
LAF31:  .byte $0F, $FF, $FF, $0C, $0D, $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF
LAF41:  .byte $FF, $FF, $30, $FF, $33, $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34
LAF51:  .byte $35, $37, $38, $3A, $3B, $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80
LAF61:  .byte $81, $82, $83, $88, $89, $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C
LAF71:  .byte $5D, $5E, $5F, $B8, $B8, $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36
LAF81:  .byte $BE, $BC, $BD, $BF, $14, $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2
LAF91:  .byte $14, $FF, $FF, $30, $13, $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76
LAFA1:  .byte $76, $76, $76, $FF, $FF, $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04
LAFB1:  .byte $05, $06, $07, $FF, $FF, $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90
LAFC1:  .byte $91, $92, $93, $4B, $4C, $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C
LAFD1:  .byte $8D, $8E, $8F, $11, $12, $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3
LAFE1:  .byte $C4, $C5, $C6, $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90
LAFF1:  .byte $91, $92, $93, $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0