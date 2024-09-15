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

;Tourian Structure Data

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAC16:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAC26:  .byte $00, $00, $FF

;Structure #$01
LAC29:  .byte $08, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $08, $02, $02, $02, $02, $02, $02
LAC39:  .byte $02, $02, $01, $1C, $08, $03, $03, $03, $03, $03, $03, $03, $03, $08, $0A, $0A
LAC49:  .byte $0A, $0A, $0A, $0A, $0A, $0A, $FF

;Structure #$02
LAC50:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LAC60:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LAC69:  .byte $01, $08, $01, $08, $01, $08, $FF

;Structure #$04
LAC70:  .byte $01, $09, $01, $09, $01, $09, $FF

;Structure #$05
LAC77:  .byte $01, $13, $FF

;Structure #$06
LAC7A:  .byte $03, $1D, $17, $1E, $03, $21, $1C, $21, $03, $21, $1C, $21, $03, $1F, $17, $20
LAC8A:  .byte $FF

;Structure #$07
LAC8B:  .byte $05, $25, $1C, $1C, $1C, $31, $05, $26, $1C, $1C, $1C, $32, $05, $26, $1C, $1C
LAC9B:  .byte $1C, $32, $05, $27, $1C, $1C, $1C, $33, $FF

;Structure #$08
LACA4:  .byte $03, $28, $29, $2A, $03, $2B, $2C, $2D, $03, $2E, $2F, $30, $03, $06, $12, $35
LACB4:  .byte $FF

;Structure #$09
LACB5:  .byte $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B
LACC5:  .byte $FF

;Structure #$0A
LACC6:  .byte $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $FF

;Structure #$0B
LACD0:  .byte $07, $1D, $0D, $16, $16, $16, $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21
LACE0:  .byte $07, $21, $21, $15, $14, $15, $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D
LACF0:  .byte $07, $1F, $0D, $20, $10, $1F, $0D, $20, $FF

;Structure #$0C
LACF9:  .byte $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21, $1C, $1C, $21
LAD09:  .byte $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C, $1C, $21, $1C
LAD19:  .byte $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF

;Structure #$0D
LAD26:  .byte $02, $01, $01, $02, $00, $00, $FF

;Structure #$0E
LAD2D:  .byte $01, $16, $01, $21, $01, $21, $01, $0C, $01, $21, $01, $0D, $01, $21, $FF

;Structure #$0F
LAD3C:  .byte $01, $0C, $FF

;Structure #$10
LAD3F:  .byte $07, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$11
LAD48:  .byte $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21, $11, $0D
LAD58:  .byte $03, $11, $21, $11, $03, $23, $23, $23, $FF

;Structure #$12
LAD61:  .byte $03, $19, $1B, $1A, $FF

;Structure #$13
LAD66:  .byte $01, $34, $01, $34, $FF

;Structure #$14
LAD6B:  .byte $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D, $22, $17, $20, $21, $14
LAD7B:  .byte $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21, $08, $21, $1F, $17, $0D
LAD8B:  .byte $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22, $20, $11, $FF

;Structure #$15
LAD99:  .byte $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17, $17, $17, $17
LADA9:  .byte $17, $0D, $FF

;Structure #$16
LADAC:  .byte $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08, $18, $21, $1C, $21, $21, $1C
LADBC:  .byte $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C, $1F, $FF

;Structure #$17
LADC8:  .byte $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18, $18, $04
LADD8:  .byte $18, $18, $18, $18, $FF

;Structure #$18
LADDD:  .byte $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07, $0D, $17, $17, $17, $17, $17, $0D
LADED:  .byte $07, $18, $0A, $10, $0A, $0A, $10, $18, $07, $0D, $17, $17, $17, $17, $17, $0D
LADFD:  .byte $FF

;Structure #$19
LADFE:  .byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A
LAE0E:  .byte $FF

;Structure #$1A
LAE0F:  .byte $01, $0D, $01, $18, $01, $18, $01, $18, $01, $18, $FF

;Structure #$1B
LAE1A:  .byte $02, $19, $1A, $FF

;Structure #$1C
LAE1E:  .byte $01, $0D, $FF

;Structure #$1D
LAE21:  .byte $04, $14, $1C, $1C, $14, $04, $0A, $0A, $0A, $0A, $FF

;Structure #$1E
LAE2C:  .byte $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF

;Structure #$1F
LAE36:  .byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
LAE46:  .byte $0E, $10, $FF