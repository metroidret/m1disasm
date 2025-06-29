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

;Brinstar structure definitions

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAC84:
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF

;Structure #$01
LAC97:
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $01,  $28
    .byte $01,  $28
    .byte $01,  $28
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $FF

;Structure #$02
LACB0:
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $FF

;Structure #$03
LACC9:
    .byte $01,  $06
    .byte $01,  $06
    .byte $01,  $06
    .byte $FF

;Structure #$04
LACD0:
    .byte $01,  $07
    .byte $01,  $07
    .byte $01,  $07
    .byte $FF

;Structure #$05
LACD7:
    .byte $02,  $31, $32
    .byte $FF

;Structure #$06
LACDB:
    .byte $01,  $08
    .byte $01,  $33
    .byte $01,  $33
    .byte $01,  $33
    .byte $01,  $33
    .byte $FF

;Structure #$07
LACE6:
    .byte $01,  $28
    .byte $01,  $08
    .byte $01,  $1F
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $1F
    .byte $FF

;Structure #$08
LACF3:
    .byte $02,  $0E, $11
    .byte $03,  $0F, $12, $22
    .byte $03,  $10, $13, $14
    .byte $FF

;Structure #$09
LACFF:
    .byte $04,  $08, $35, $35, $08
    .byte $FF

;Structure #$0A
LAD05:
    .byte $03,  $08, $35, $08
    .byte $FF

;Structure #$0B
LAD0A:
    .byte $02,  $36, $36
    .byte $02,  $1C, $08
    .byte $02,  $08, $34
    .byte $02,  $34, $34
    .byte $02,  $08, $08
    .byte $FF

;Structure #$0C
LAD1A:
    .byte $02, $20, $20
    .byte $FF

;Structure #$0D
LAD1E:
    .byte $08,  $08, $1C, $08, $35, $08, $35, $1C, $08
    .byte $FF

;Structure #$0E
LAD28:
    .byte $08,  $1E, $1E, $1C, $1C, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1C, $1E, $1E, $1E
    .byte $08,  $1C, $1E, $1E, $1E, $1E, $1E, $1C, $1E
    .byte $08,  $1E, $1E, $1E, $1C, $1E, $1C, $1C, $1E
    .byte $FF

;Structure #$0F
LAD4D:
    .byte $08,  $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E
    .byte $FF

;Structure #$10
LAD57:
    .byte $08,  $08, $0B, $0B, $0B, $0B, $08, $0B, $0B
    .byte $08,  $08, $08, $1C, $1C, $08, $08, $1C, $08
    .byte $FF

;Structure #$11
LAD6A:
    .byte $08,  $1C, $08, $08, $08, $08, $0A, $08, $1C
    .byte $08,  $08, $0A, $09, $0A, $28, $28, $08, $08
    .byte $01,  $08
    .byte $FF

;Structure #$12
LAD7F:
    .byte $06,  $2C, $2C, $2C, $2C, $15, $2C
    .byte $06,  $2D, $2D, $2D, $2D, $16, $2D
    .byte $FF

;Structure #$13
LAD8E:
    .byte $08,  $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
    .byte $FF

;Structure #$14
LAD98:
    .byte $08,  $1A, $1A, $1A, $1A, $1A, $1A, $1A, $1A
    .byte $FF

;Structure #$15
LADA2:
    .byte $01,  $20
    .byte $01,  $20
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $20
    .byte $FF

;Structure #$16
LADAD:
    .byte $07,  $20, $20, $20, $20, $20, $20, $20
    .byte $07,  $20, $1A, $20, $1F, $20, $1A, $20
    .byte $FF

;Structure #$17
LADBE:
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

;Structure #$18
LADE3:
    .byte $01,  $0D
    .byte $FF

;Structure #$19
LADE6:
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

;Structure #$1A
LADEC:
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $FF

;Structure #$1B
LADF9:
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $05,  $27, $30, $0D, $0D, $30
    .byte $FF

;Structure #$1C
LAE09:
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

;Structure #$1D
LAE13:
    .byte $01,  $0C
    .byte $01,  $1F
    .byte $FF

;Structure #$1E
LAE18:
    .byte $04,  $08, $35, $08, $08
    .byte $04,  $08, $1C, $08, $34
    .byte $04,  $34, $08, $08, $08
    .byte $04,  $08, $08, $1C, $08
    .byte $FF

;Structure #$1F
LAE2D:
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $04,  $1D, $1C, $1C, $1D
    .byte $04,  $1C, $1D, $1C, $1C
    .byte $04,  $1D, $1C, $1D, $1D
    .byte $FF

;Structure #$20
LAE42:
    .byte $04,  $33, $33, $33, $33
    .byte $FF

;Structure #$21
LAE48:
    .byte $01,  $22
    .byte $FF

;Structure #$22
LAE4B:
    .byte $03,  $28, $0E, $08
    .byte $03,  $37, $08, $39
    .byte $03,  $38, $39, $39
    .byte $03,  $28, $3A, $0A
    .byte $02,  $3B, $3C
    .byte $FF

;Structure #$23
LAE5F:
    .byte $03,  $1E, $1E, $1C
    .byte $03,  $39, $08, $1E
    .byte $03,  $0A, $09, $1E
    .byte $03,  $3D, $0B, $0A
    .byte $FF

;Structure #$24
LAE70:
    .byte $04,  $1E, $1E, $1C, $1E
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $04,  $1C, $1E, $1E, $1E
    .byte $04,  $1E, $1E, $1C, $1E
    .byte $FF

;Structure #$25
LAE85:
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $FF

;Structure #$26
LAE8E:
    .byte $02,  $3E, $3F
    .byte $FF

;Structure #$27
LAE92:
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

;Structure #$28
LAEA5:
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $FF

;Structure #$29
LAEB0:
    .byte $01,  $3E
    .byte $FF

;Structure #$2A
LAEB3:
    .byte $04,  $2E, $2A, $2E, $2E
    .byte $04,  $2E, $2E, $2E, $2A
    .byte $FF

;Structure #$2B
LAEBE:
    .byte $08,  $2B, $03, $03, $2B, $03, $03, $03, $2B
    .byte $FF

;Structure #$2C
LAEC8:
    .byte $01,  $1B
    .byte $FF

;Structure #$2D
LAECB:
    .byte $08,  $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
    .byte $08,  $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
    .byte $FF

;Structure #$2E
LAEDE:
    .byte $01,  $2F
    .byte $FF

;Structure #$2F
LAEE1:
    .byte $01,  $1F
    .byte $FF

;Structure #$30
LAEE4:
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $FF

;Structure #$31
LAEED:
    .byte $01,  $24
    .byte $FF

