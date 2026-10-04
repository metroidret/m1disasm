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

;The first byte of the structure definition states how many metatiles are in the first row of the
;structure. Then, the number of bytes after the metatile number byte is equal to the value of the metatile
;number byte and those bytes define what each metatile in the row are. For example, if the metatile number
;byte is #$08, the next 8 bytes represent 8 metatiles. The metatile description bytes are the metatile numbers
;and are multiplied by 4 to find the index to the desired metatile in MetatileDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

Structure00_{AREA}: ; 01:AC84
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF

Structure01_{AREA}: ; 01:AC97
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $01,  $28
    .byte $01,  $28
    .byte $01,  $28
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $FF

Structure02_{AREA}: ; 01:ACB0
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $FF

Structure03_{AREA}: ; 01:ACC9
    .byte $01,  $06
    .byte $01,  $06
    .byte $01,  $06
    .byte $FF

Structure04_{AREA}: ; 01:ACD0
    .byte $01,  $07
    .byte $01,  $07
    .byte $01,  $07
    .byte $FF

Structure05_{AREA}: ; 01:ACD7
    .byte $02,  $31, $32
    .byte $FF

Structure06_{AREA}: ; 01:ACDB
    .byte $01,  $08
    .byte $01,  $33
    .byte $01,  $33
    .byte $01,  $33
    .byte $01,  $33
    .byte $FF

Structure07_{AREA}: ; 01:ACE6
    .byte $01,  $28
    .byte $01,  $08
    .byte $01,  $1F
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $1F
    .byte $FF

Structure08_{AREA}: ; 01:ACF3
    .byte $02,  $0E, $11
    .byte $03,  $0F, $12, $22
    .byte $03,  $10, $13, $14
    .byte $FF

Structure09_{AREA}: ; 01:ACFF
    .byte $04,  $08, $35, $35, $08
    .byte $FF

Structure0A_{AREA}: ; 01:AD05
    .byte $03,  $08, $35, $08
    .byte $FF

Structure0B_{AREA}: ; 01:AD0A
    .byte $02,  $36, $36
    .byte $02,  $1C, $08
    .byte $02,  $08, $34
    .byte $02,  $34, $34
    .byte $02,  $08, $08
    .byte $FF

Structure0C_{AREA}: ; 01:AD1A
    .byte $02, $20, $20
    .byte $FF

Structure0D_{AREA}: ; 01:AD1E
    .byte $08,  $08, $1C, $08, $35, $08, $35, $1C, $08
    .byte $FF

Structure0E_{AREA}: ; 01:AD28
    .byte $08,  $1E, $1E, $1C, $1C, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1C, $1E, $1E, $1E
    .byte $08,  $1C, $1E, $1E, $1E, $1E, $1E, $1C, $1E
    .byte $08,  $1E, $1E, $1E, $1C, $1E, $1C, $1C, $1E
    .byte $FF

Structure0F_{AREA}: ; 01:AD4D
    .byte $08,  $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E
    .byte $FF

Structure10_{AREA}: ; 01:AD57
    .byte $08,  $08, $0B, $0B, $0B, $0B, $08, $0B, $0B
    .byte $08,  $08, $08, $1C, $1C, $08, $08, $1C, $08
    .byte $FF

Structure11_{AREA}: ; 01:AD6A
    .byte $08,  $1C, $08, $08, $08, $08, $0A, $08, $1C
    .byte $08,  $08, $0A, $09, $0A, $28, $28, $08, $08
    .byte $01,  $08
    .byte $FF

Structure12_{AREA}: ; 01:AD7F
    .byte $06,  $2C, $2C, $2C, $2C, $15, $2C
    .byte $06,  $2D, $2D, $2D, $2D, $16, $2D
    .byte $FF

Structure13_{AREA}: ; 01:AD8E
    .byte $08,  $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
    .byte $FF

Structure14_{AREA}: ; 01:AD98
    .byte $08,  $1A, $1A, $1A, $1A, $1A, $1A, $1A, $1A
    .byte $FF

Structure15_{AREA}: ; 01:ADA2
    .byte $01,  $20
    .byte $01,  $20
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $20
    .byte $FF

Structure16_{AREA}: ; 01:ADAD
    .byte $07,  $20, $20, $20, $20, $20, $20, $20
    .byte $07,  $20, $1A, $20, $1F, $20, $1A, $20
    .byte $FF

Structure17_{AREA}: ; 01:ADBE
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

Structure18_{AREA}: ; 01:ADE3
    .byte $01,  $0D
    .byte $FF

Structure19_{AREA}: ; 01:ADE6
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

Structure1A_{AREA}: ; 01:ADEC
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $02,  $0D, $0D
    .byte $FF

Structure1B_{AREA}: ; 01:ADF9
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $05,  $27, $30, $0D, $0D, $30
    .byte $FF

Structure1C_{AREA}: ; 01:AE09
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

Structure1D_{AREA}: ; 01:AE13
    .byte $01,  $0C
    .byte $01,  $1F
    .byte $FF

Structure1E_{AREA}: ; 01:AE18
    .byte $04,  $08, $35, $08, $08
    .byte $04,  $08, $1C, $08, $34
    .byte $04,  $34, $08, $08, $08
    .byte $04,  $08, $08, $1C, $08
    .byte $FF

Structure1F_{AREA}: ; 01:AE2D
    .byte $04,  $1D, $1D, $1D, $1D
    .byte $04,  $1D, $1C, $1C, $1D
    .byte $04,  $1C, $1D, $1C, $1C
    .byte $04,  $1D, $1C, $1D, $1D
    .byte $FF

Structure20_{AREA}: ; 01:AE42
    .byte $04,  $33, $33, $33, $33
    .byte $FF

Structure21_{AREA}: ; 01:AE48
    .byte $01,  $22
    .byte $FF

Structure22_{AREA}: ; 01:AE4B
    .byte $03,  $28, $0E, $08
    .byte $03,  $37, $08, $39
    .byte $03,  $38, $39, $39
    .byte $03,  $28, $3A, $0A
    .byte $02,  $3B, $3C
    .byte $FF

Structure23_{AREA}: ; 01:AE5F
    .byte $03,  $1E, $1E, $1C
    .byte $03,  $39, $08, $1E
    .byte $03,  $0A, $09, $1E
    .byte $03,  $3D, $0B, $0A
    .byte $FF

Structure24_{AREA}: ; 01:AE70
    .byte $04,  $1E, $1E, $1C, $1E
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $04,  $1C, $1E, $1E, $1E
    .byte $04,  $1E, $1E, $1C, $1E
    .byte $FF

Structure25_{AREA}: ; 01:AE85
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $FF

Structure26_{AREA}: ; 01:AE8E
    .byte $02,  $3E, $3F
    .byte $FF

Structure27_{AREA}: ; 01:AE92
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

Structure28_{AREA}: ; 01:AEA5
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $01,  $1F
    .byte $FF

Structure29_{AREA}: ; 01:AEB0
    .byte $01,  $3E
    .byte $FF

Structure2A_{AREA}: ; 01:AEB3
    .byte $04,  $2E, $2A, $2E, $2E
    .byte $04,  $2E, $2E, $2E, $2A
    .byte $FF

Structure2B_{AREA}: ; 01:AEBE
    .byte $08,  $2B, $03, $03, $2B, $03, $03, $03, $2B
    .byte $FF

Structure2C_{AREA}: ; 01:AEC8
    .byte $01,  $1B
    .byte $FF

Structure2D_{AREA}: ; 01:AECB
    .byte $08,  $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
    .byte $08,  $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F
    .byte $FF

Structure2E_{AREA}: ; 01:AEDE
    .byte $01,  $2F
    .byte $FF

Structure2F_{AREA}: ; 01:AEE1
    .byte $01,  $1F
    .byte $FF

Structure30_{AREA}: ; 01:AEE4
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $FF

Structure31_{AREA}: ; 01:AEED
    .byte $01,  $24
    .byte $FF

