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

;Ridley Structure Definitions

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

Structure00:
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $FF

Structure01:
    .byte $01,  $12
    .byte $01,  $12
    .byte $01,  $12
    .byte $FF

Structure02:
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $FF

Structure03:
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $FF

Structure04:
    .byte $02,  $06, $07
    .byte $FF

Structure05:
    .byte $01,  $0A
    .byte $01,  $0A
    .byte $FF

Structure06:
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $FF

Structure07:
    .byte $02,  $08, $08
    .byte $02,  $08, $05
    .byte $02,  $09, $08
    .byte $02,  $08, $08
    .byte $02,  $05, $08
    .byte $FF

Structure08:
    .byte $04,  $08, $08, $08, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $08, $08, $08
    .byte $FF

Structure09:
    .byte $04,  $08, $09, $09, $08
    .byte $FF

Structure0A:
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

Structure0B:
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $FF

Structure0C:
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $FF

Structure0D:
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $FF

Structure0E:
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $FF

Structure0F:
    .byte $04,  $18, $18, $18, $18
    .byte $04,  $19, $19, $19, $19
    .byte $FF

Structure10:
    .byte $01,  $1B
    .byte $FF

Structure11:
    .byte $04,  $1A, $1A, $1A, $1A
    .byte $FF

Structure12:
    .byte $08,  $0F, $0F, $0F, $0F, $10, $10, $10, $10
    .byte $FF

Structure13:
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

Structure14:
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0E, $0E, $0E, $0E, $0E, $0E, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

Structure15:
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $FF

Structure16:
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $FF

Structure17:
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $FF

Structure18:
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $09, $09, $09, $09, $09, $09, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

Structure19:
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

Structure1A:
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $FF

Structure1B:
    .byte $01,  $1F
    .byte $FF

Structure1C:
    .byte $04,  $20, $20, $20, $20
    .byte $FF

