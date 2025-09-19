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

MacroDefs:
    .byte $F1, $F1, $F1, $F1
    .byte $FF, $FF, $F0, $F0
    .byte $64, $64, $64, $64
    .byte $D5, $D6, $CB, $CC
    .byte $A4, $FF, $A4, $FF
    .byte $FF, $A5, $FF, $A5
    .byte $A0, $A0, $A0, $A0
    .byte $A1, $A1, $A1, $A1
    .byte $00, $01, $02, $03
    .byte $0B, $00, $FF, $0B
    .byte $03, $0A, $0A, $FF
    .byte $08, $09, $02, $03
    .byte $0E, $0F, $10, $11
    .byte $12, $13, $14, $0C
    .byte $FF, $FF, $FF, $30
    .byte $FF, $33, $FF, $36
    .byte $FF, $39, $FF, $3D
    .byte $FF, $FF, $31, $32
    .byte $34, $35, $37, $38
    .byte $3A, $3B, $3E, $3F
    .byte $3C, $41, $40, $42
    .byte $FF, $FF, $43, $43
    .byte $44, $44, $44, $44
    .byte $45, $46, $45, $46
    .byte $FF, $47, $47, $48
    .byte $48, $FF, $47, $48
    .byte $48, $47, $47, $48
    .byte $49, $49, $4A, $4A
    .byte $4B, $4C, $4D, $50
    .byte $51, $52, $53, $54
    .byte $55, $56, $57, $58
    .byte $59, $5B, $59, $5B
    .byte $5C, $5D, $5E, $5F
    .byte $4F, $4F, $4F, $4F
    .byte $88, $89, $8A, $8B
    .byte $84, $85, $86, $87
    .byte $8C, $8D, $8E, $8F
    .byte $FF, $FF, $FF, $FF        ;Not used.
    .byte $FF, $FF, $FF, $FF        ;Not used.
    .byte $FF, $FF, $FF, $FF        ;Not used.
    .byte $FF, $FF, $FF, $FF        ;Not used.
    .byte $B0, $B1, $B2, $B3
    .byte $B4, $B5, $B6, $B7
    .byte $B8, $B8, $B9, $B9
    .byte $FF, $FF, $BA, $BA
    .byte $BB, $BB, $BB, $BB
    .byte $C7, $C8, $C9, $CA
    .byte $94, $95, $96, $97
    .byte $0D, $FF, $FF, $FF
    .byte $FF, $FF, $59, $5A
    .byte $FF, $FF, $5A, $5B
    .byte $80, $81, $82, $83
    .byte $04, $05, $04, $05
    .byte $06, $06, $07, $07
    .byte $60, $61, $62, $63
    .byte $C1, $00, $00, $08
    .byte $0B, $BE, $BC, $BD
    .byte $BF, $01, $02, $03
    .byte $C0, $01, $C0, $03
    .byte $FF, $C1, $FF, $FF
    .byte $C2, $01, $FF, $FF
    .byte $30, $00, $BC, $BD
    .byte $CD, $CE, $CF, $D0
    .byte $D1, $D2, $D3, $D4
    .byte $90, $91, $92, $93
;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif

