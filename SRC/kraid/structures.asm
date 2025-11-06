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

;Kraid Structure Definitions

;The first byte of the structure definition states how many metatiles are in the first row of the
;structure. Then, the number of bytes after the metatile number byte is equal to the value of the metatile
;number byte and those bytes define what each metatile in the row are. For example, if the metatile number
;byte is #$08, the next 8 bytes represent 8 metatiles. The metatile description bytes are the metatile numbers
;and are multiplied by 4 to find the index to the desired metatile in MetatileDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

Structure00:
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF

Structure01:
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $01,  $1C
    .byte $01,  $1C
    .byte $01,  $1C
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $FF

Structure02:
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $02,  $04, $05
    .byte $FF

Structure03:
    .byte $01,  $06
    .byte $01,  $06
    .byte $01,  $06
    .byte $FF

Structure04:
    .byte $01,  $07
    .byte $01,  $07
    .byte $01,  $07
    .byte $FF

Structure05:
    .byte $02,  $14, $15
    .byte $FF

Structure06:
    .byte $02,  $17, $17
    .byte $02,  $17, $1B
    .byte $02,  $17, $1B
    .byte $02,  $1B, $17
    .byte $02,  $17, $17
    .byte $FF

Structure07:
    .byte $02,  $1A, $17
    .byte $02,  $17, $17
    .byte $02,  $1B, $1A
    .byte $02,  $17, $17
    .byte $02,  $1A, $1B
    .byte $FF

Structure08:
    .byte $01,  $18
    .byte $01,  $18
    .byte $FF

Structure09:
    .byte $01,  $19
    .byte $01,  $19
    .byte $FF

Structure0A:
    .byte $01,  $09
    .byte $FF

Structure0B:
    .byte $01,  $0A
    .byte $FF

Structure0C:
    .byte $01,  $1E
    .byte $01,  $1A
    .byte $01,  $1A
    .byte $01,  $1A
    .byte $01,  $1E
    .byte $FF

Structure0D:
    .byte $04,  $17, $17, $17, $17
    .byte $FF

Structure0E:
    .byte $03,  $17, $1D, $17
    .byte $FF

Structure0F:
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $FF

Structure10:
    .byte $04,  $17, $17, $1B, $17
    .byte $04,  $1B, $17, $17, $17
    .byte $04,  $1B, $17, $1B, $1B
    .byte $04,  $17, $1B, $17, $17
    .byte $FF

Structure11:
    .byte $01,  $17
    .byte $FF

Structure12:
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

Structure13:
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $FF

Structure14:
    .byte $02,  $12, $12
    .byte $FF

Structure15:
    .byte $08,  $10, $10, $10, $10, $10, $10, $10, $10
    .byte $08,  $10, $10, $10, $10, $10, $10, $10, $10
    .byte $FF

Structure16:
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $FF

Structure17:
    .byte $08,  $13, $0E, $13, $0E, $0E, $13, $0E, $0E
    .byte $08,  $0E, $0E, $13, $13, $0E, $0E, $13, $13
    .byte $FF

Structure18:
    .byte $08,  $11, $11, $11, $11, $11, $11, $11, $11
    .byte $08,  $11, $11, $11, $11, $11, $11, $11, $11
    .byte $FF

Structure19:
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $FF

Structure1A:
    .byte $08,  $20, $22, $22, $22, $22, $22, $22, $22
    .byte $FF

Structure1B:
    .byte $01,  $1F
    .byte $FF

Structure1C:
    .byte $01,  $21
    .byte $01,  $21
    .byte $01,  $21
    .byte $FF

Structure1D:
    .byte $08,  $23, $23, $23, $23, $23, $23, $23, $23
    .byte $08,  $23, $24, $24, $24, $24, $24, $24, $23
    .byte $08,  $23, $23, $23, $23, $23, $23, $23, $23
    .byte $FF

Structure1E:
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $FF

Structure1F:
    .byte $04,  $23, $23, $23, $23
    .byte $04,  $23, $24, $24, $23
    .byte $04,  $23, $24, $24, $23
    .byte $04,  $23, $23, $23, $23
    .byte $FF

Structure20:
    .byte $01,  $25
    .byte $FF

Structure21:
    .byte $01,  $26
    .byte $01,  $26
    .byte $01,  $26
    .byte $01,  $26
    .byte $FF

Structure22:
    .byte $03,  $27, $27, $27
    .byte $FF

Structure23:
    .byte $03,  $28, $28, $28
    .byte $FF

Structure24:
    .byte $08,  $13, $13, $13, $13, $13, $13, $13, $13
    .byte $FF

Structure25:
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $FF

Structure26:
    .byte $04,  $0C, $0C, $0C, $0C
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

