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

;The first byte of the structure definition states how many metatiles are in the first row of the
;structure. Then, the number of bytes after the metatile number byte is equal to the value of the metatile
;number byte and those bytes define what each metatile in the row are. For example, if the metatile number
;byte is #$08, the next 8 bytes represent 8 metatiles. The metatile description bytes are the metatile numbers
;and are multiplied by 4 to find the index to the desired metatile in MetatileDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

Structure00_{AREA}:
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF

Structure01_{AREA}:
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $01,  $0A
    .byte $01,  $0A
    .byte $01,  $0A
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $FF

Structure02_{AREA}:
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $FF

Structure03_{AREA}:
    .byte $01,  $06
    .byte $01,  $06
    .byte $01,  $06
    .byte $FF

Structure04_{AREA}:
    .byte $01,  $07
    .byte $01,  $07
    .byte $01,  $07
    .byte $FF

Structure05_{AREA}:
    .byte $02,  $08, $09
    .byte $FF

Structure06_{AREA}:
    .byte $04,  $0B, $0B, $0B, $0B
    .byte $FF

Structure07_{AREA}:
    .byte $02,  $0B, $0F
    .byte $02,  $0C, $0B
    .byte $02,  $0F, $0C
    .byte $02,  $0B, $0B
    .byte $02,  $0C, $0F
    .byte $FF

Structure08_{AREA}:
    .byte $01,  $0D
    .byte $01,  $0E
    .byte $FF

Structure09_{AREA}:
    .byte $04,  $10, $10, $10, $10
    .byte $FF

Structure0A_{AREA}:
    .byte $04,  $12, $13, $11, $13
    .byte $01,  $13
    .byte $FF

Structure0B_{AREA}:
    .byte $04,  $0F, $0C, $0C, $0B
    .byte $04,  $0B, $0F, $0B, $0C
    .byte $04,  $0C, $0F, $0C, $0B
    .byte $04,  $0F, $0B, $0F, $0C
    .byte $FF

Structure0C_{AREA}:
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $FF

Structure0D_{AREA}:
    .byte $08,  $20, $20, $20, $20, $20, $20, $20, $20
    .byte $FF

Structure0E_{AREA}:
    .byte $04,  $21, $21, $21, $21
    .byte $04,  $21, $21, $21, $21
    .byte $FF

Structure0F_{AREA}:
    .byte $02,  $15, $18
    .byte $03,  $16, $19, $1E
    .byte $03,  $17, $1A, $1B
    .byte $FF

Structure10_{AREA}:
    .byte $01,  $1E
    .byte $FF

Structure11_{AREA}:
    .byte $08,  $22, $22, $22, $22, $22, $22, $22, $22
    .byte $FF

Structure12_{AREA}:
    .byte $01,  $23
    .byte $FF

Structure13_{AREA}:
    .byte $04,  $24, $26, $26, $26
    .byte $04,  $25, $26, $26, $26
    .byte $13,       $27, $26, $26
    .byte $04,  $28, $29, $26, $2A
    .byte $FF

Structure14_{AREA}:
    .byte $04,  $26, $26, $26, $26
    .byte $04,  $26, $26, $26, $26
    .byte $04,  $26, $26, $26, $26
    .byte $04,  $26, $26, $26, $26
    .byte $FF

Structure15_{AREA}:
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $FF

Structure16_{AREA}:
    .byte $04,  $2D, $3D, $2C, $3D
    .byte $FF

Structure17_{AREA}:
    .byte $01,  $2D
    .byte $01,  $3D
    .byte $01,  $2C
    .byte $01,  $3D
    .byte $FF

Structure18_{AREA}:
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $FF

Structure19_{AREA}:
    .byte $08,  $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E
    .byte $08,  $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F
    .byte $FF

Structure1A_{AREA}:
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $FF

Structure1B_{AREA}:
    .byte $04,  $31, $30, $31, $30
    .byte $04,  $30, $30, $30, $30
    .byte $04,  $31, $30, $31, $31
    .byte $04,  $30, $31, $30, $30
    .byte $FF

Structure1C_{AREA}:
    .byte $01,  $30
    .byte $01,  $31
    .byte $01,  $30
    .byte $01,  $30
    .byte $01,  $31
    .byte $01,  $31
    .byte $01,  $30
    .byte $01,  $30
    .byte $FF

Structure1D_{AREA}:
    .byte $04,  $30, $31, $30, $30
    .byte $FF

Structure1E_{AREA}:
    .byte $01,  $1C
    .byte $FF

Structure1F_{AREA}:
    .byte $01,  $21
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $21
    .byte $FF

Structure20_{AREA}:
    .byte $04,  $34, $34, $34, $34
    .byte $04,  $34, $34, $34, $34
    .byte $FF

Structure21_{AREA}:
    .byte $04,  $35, $35, $35, $35
    .byte $FF

Structure22_{AREA}:
    .byte $04,  $37, $37, $37, $37
    .byte $04,  $37, $36, $37, $36
    .byte $04,  $36, $37, $36, $37
    .byte $04,  $37, $37, $36, $37
    .byte $FF

Structure23_{AREA}:
    .byte $02,  $32, $33
    .byte $FF

Structure24_{AREA}:
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $FF

Structure25_{AREA}:
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $FF

Structure26_{AREA}:
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $04,  $2B, $2B, $2B, $2B
    .byte $FF

Structure27_{AREA}:
    .byte $01,  $14
    .byte $FF

Structure28_{AREA}:
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $01,  $2B
    .byte $FF

Structure29_{AREA}:
    .byte $01,  $39
    .byte $FF

Structure2A_{AREA}:
    .byte $01,  $38
    .byte $FF

Structure2B_{AREA}:
    .byte $04,  $3A, $3B, $3B, $3C
    .byte $FF

Structure2C_{AREA}:
    .byte $02,  $34, $34
    .byte $02,  $34, $34
    .byte $02,  $34, $34
    .byte $02,  $34, $34
    .byte $FF

Structure2D_{AREA}:
    .byte $08,  $30, $31, $30, $31, $30, $30, $31, $30
    .byte $FF

Structure2E_{AREA}:
    .byte $04,  $34, $34, $34, $34
    .byte $04,  $34, $34, $34, $34
    .byte $04,  $34, $34, $34, $34
    .byte $04,  $34, $34, $34, $34
    .byte $FF

Structure2F_{AREA}:
    .byte $08,  $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
    .byte $08,  $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
    .byte $FF

Structure30_{AREA}:
    .byte $08,  $34, $34, $34, $34, $34, $34, $34, $34
    .byte $08,  $34, $34, $34, $34, $34, $34, $34, $34
    .byte $FF

