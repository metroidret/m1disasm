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

;Norfair Structure Definitions

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LACB9:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LACC9:  .byte $00, $00, $FF

;Structure #$01
LACCC:  .byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $0A, $01, $0A, $01, $0A, $08
LACDC:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LACE5:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LACF5:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LACFE:  .byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LAD05:  .byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LAD0C:  .byte $02, $08, $09, $FF

;Structure #$06
LAD10:  .byte $04, $0B, $0B, $0B, $0B, $FF

;Structure #$07
LAD16:  .byte $02, $0B, $0F, $02, $0C, $0B, $02, $0F, $0C, $02, $0B, $0B, $02, $0C, $0F, $FF 

;Structure #$08
LAD26:  .byte $01, $0D, $01, $0E, $FF

;Structure #$09
LAD2B:  .byte $04, $10, $10, $10, $10, $FF

;Structure #$0A
LAD31:  .byte $04, $12, $13, $11, $13, $01, $13, $FF

;Structure #$0B
LAD39:  .byte $04, $0F, $0C, $0C, $0B, $04, $0B, $0F, $0B, $0C, $04, $0C, $0F, $0C, $0B, $04
LAD49:  .byte $0F, $0B, $0F, $0C, $FF

;Structure #$0C
LAD4E:  .byte $01, $1F, $01, $1F, $01, $1F, $01, $1F, $FF

;Structure #$0D
LAD57:  .byte $08, $20, $20, $20, $20, $20, $20, $20, $20, $FF

;Structure #$0E
LAD61:  .byte $04, $21, $21, $21, $21, $04, $21, $21, $21, $21, $FF

;Structure #$0F
LAD6C:  .byte $02, $15, $18, $03, $16, $19, $1E, $03, $17, $1A, $1B, $FF

;Structure #$10
LAD78:  .byte $01, $1E, $FF

;Structure #$11
LAD7B:  .byte $08, $22, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$12
LAD85:  .byte $01, $23, $FF

;Structure #$13
LAD88:  .byte $04, $24, $26, $26, $26, $04, $25, $26, $26, $26, $13, $27, $26, $26, $04, $28
LAD98:  .byte $29, $26, $2A, $FF

;Structure #$14
LAD9C:  .byte $04, $26, $26, $26, $26, $04, $26, $26, $26, $26, $04, $26, $26, $26, $26, $04
LADAC:  .byte $26, $26, $26, $26, $FF

;Structure #$15
LADB1:  .byte $04, $0F, $0F, $0F, $0F, $FF

;Structure #$16
LADB7:  .byte $04, $2D, $3D, $2C, $3D, $FF

;Structure #$17
LADBD:  .byte $01, $2D, $01, $3D, $01, $2C, $01, $3D, $FF

;Structure #$18
LADC6:  .byte $01, $1D, $01, $1D, $01, $1D, $01, $1D, $FF

;Structure #$19
LADCF:  .byte $08, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $08, $2F, $2F, $2F, $2F, $2F, $2F
LADDF:  .byte $2F, $2F, $FF

;Structure #$1A
LADE2:  .byte $04, $1D, $1D, $1D, $1D, $04, $1D, $1D, $1D, $1D, $04, $1D, $1D, $1D, $1D, $04
LADF2:  .byte $1D, $1D, $1D, $1D, $FF

;Structure #$1B
LADF7:  .byte $04, $31, $30, $31, $30, $04, $30, $30, $30, $30, $04, $31, $30, $31, $31, $04
LAE07:  .byte $30, $31, $30, $30, $FF

;Structure #$1C
LAE0C:  .byte $01, $30, $01, $31, $01, $30, $01, $30, $01, $31, $01, $31, $01, $30, $01, $30
LAE1C:  .byte $FF

;Structure #$1D
LAE1D:  .byte $04, $30, $31, $30, $30, $FF

;Structure #$1E
LAE23:  .byte $01, $1C, $FF

;Structure #$1F
LAE26:  .byte $01, $21, $01, $1F, $01, $1F, $01, $21, $FF

;Structure #$20
LAE2F:  .byte $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $FF

;Structure #$21
LAE3A:  .byte $04, $35, $35, $35, $35, $FF

;Structure #$22
LAE40:  .byte $04, $37, $37, $37, $37, $04, $37, $36, $37, $36, $04, $36, $37, $36, $37, $04
LAE50:  .byte $37, $37, $36, $37, $FF

;Structure #$23
LAE55:  .byte $02, $32, $33, $FF

;Structure #$24
LAE59:  .byte $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $FF

;Structure #$25
LAE64:  .byte $01, $2B, $01, $2B, $01, $2B, $01, $2B, $FF

;Structure #$26
LAE6D:  .byte $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $04
LAE7D:  .byte $2B, $2B, $2B, $2B, $FF

;Structure #$27
LAE82:  .byte $01, $14, $FF

;Structure #$28
LAE85:  .byte $01, $2B, $01, $2B, $01, $2B, $01, $2B, $FF

;Structure #$29
LAE8E:  .byte $01, $39, $FF

;Structure #$2A
LAE91:  .byte $01, $38, $FF

;Structure #$2B
LAE94:  .byte $04, $3A, $3B, $3B, $3C, $FF

;Structure #$2C
LAE9A:  .byte $02, $34, $34, $02, $34, $34, $02, $34, $34, $02, $34, $34, $FF

;Structure #$2D
LAEA7:  .byte $08, $30, $31, $30, $31, $30, $30, $31, $30, $FF

;Structure #$2E
LAEB1:  .byte $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $04
LAEC1:  .byte $34, $34, $34, $34, $FF

;Structure #$2F
LAEC6:  .byte $08, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $08, $2B, $2B, $2B, $2B, $2B, $2B
LAED6:  .byte $2B, $2B, $FF

;Structure #$30
LAED9:  .byte $08, $34, $34, $34, $34, $34, $34, $34, $34, $08, $34, $34, $34, $34, $34, $34
LAEE9:  .byte $34, $34, $FF
