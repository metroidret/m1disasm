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

;The metatile definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the metatile definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile.

MetatileDefs_BANK{BANK}:
    .byte $A7, $A7, $A7, $A7
    .byte $FF, $FF, $A6, $A6
    .byte $A2, $A2, $FF, $FF
    .byte $FF, $FF, $A3, $A3
    .byte $A4, $FF, $A4, $FF
    .byte $FF, $A5, $FF, $A5
    .byte $FF, $79, $FF, $7E
    .byte $4F, $4F, $4F, $4F
    .byte $A0, $A0, $A0, $A0
    .byte $A1, $A1, $A1, $A1
    .byte $04, $05, $06, $07
    .byte $10, $11, $12, $13
    .byte $00, $01, $02, $03
    .byte $08, $08, $08, $08
    .byte $18, $19, $1A, $1B
    .byte $1C, $1D, $1E, $1F
    .byte $0C, $0D, $0E, $0F
    .byte $09, $09, $09, $09
    .byte $7A, $7B, $7F, $5A
    .byte $2A, $2C, $FF, $FF
    .byte $14, $15, $16, $17
    .byte $20, $21, $22, $23
    .byte $24, $25, $20, $21
    .byte $28, $28, $29, $29
    .byte $26, $27, $26, $27
    .byte $2A, $2B, $FF, $FF
    .byte $2B, $2C, $FF, $FF
    .byte $2B, $2B, $FF, $FF
    .byte $FF, $FF, $FF, $FF
    .byte $31, $32, $33, $34
    .byte $35, $36, $37, $38
    .byte $3D, $3E, $3F, $40
    .byte $41, $42, $43, $44
    .byte $39, $3A, $39, $3A
    .byte $3B, $3B, $3C, $3C
    .byte $0B, $0B, $2D, $2E
    .byte $2F, $30, $0B, $0B
    .byte $50, $51, $52, $53
    .byte $54, $55, $54, $55
    .byte $56, $57, $58, $59
    .byte $FF, $FF, $FF, $5E
    .byte $5B, $5C, $5F, $60
    .byte $FF, $FF, $61, $FF
    .byte $5D, $62, $67, $68
    .byte $63, $64, $69, $6A
    .byte $65, $66, $6B, $6C
    .byte $6D, $6E, $73, $74
    .byte $6F, $70, $75, $76
    .byte $71, $72, $77, $78
    .byte $45, $46, $47, $48
    .byte $FF, $98, $FF, $98
    .byte $49, $4A, $4B, $4C
    .byte $90, $91, $90, $91
    .byte $7C, $7D, $4D, $FF

;Not used.
    .byte $1C, $1D, $1E, $17, $18, $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E
    .byte $0F, $FF, $FF, $0C, $0D, $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $30, $FF, $33, $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34
    .byte $35, $37, $38, $3A, $3B, $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80
    .byte $81, $82, $83, $88, $89, $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C
    .byte $5D, $5E, $5F, $B8, $B8, $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36
    .byte $BE, $BC, $BD, $BF, $14, $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2
    .byte $14, $FF, $FF, $30, $13, $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76
    .byte $76, $76, $76, $FF, $FF, $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04
    .byte $05, $06, $07, $FF, $FF, $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90
    .byte $91, $92, $93, $4B, $4C, $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C
    .byte $8D, $8E, $8F, $11, $12, $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3
    .byte $C4, $C5, $C6, $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90
    .byte $91, $92, $93
    
;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif
