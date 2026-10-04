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

;The first byte of the structure definition states how many metatiles are in the first row of the
;structure. The the number of bytes after the metatile number byte is equal to the value of the metatile
;number byte and those bytes define what each metatile in the row are. For example, if the metatile number
;byte is #$08, the next 8 bytes represent 8 metatiles. The metatile description bytes are the metatile numbers
;and are multiplied by 4 to find the index to the desired metatile in MetatileDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

Structure00_{AREA}: ; 05:A9BF
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $FF

Structure01_{AREA}: ; 05:A9D2
    .byte $01,  $12
    .byte $01,  $12
    .byte $01,  $12
    .byte $FF

Structure02_{AREA}: ; 05:A9D9
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $FF

Structure03_{AREA}: ; 05:A9E0
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $FF

Structure04_{AREA}: ; 05:A9F9
    .byte $02,  $06, $07
    .byte $FF

Structure05_{AREA}: ; 05:A9FD
    .byte $01,  $0A
    .byte $01,  $0A
    .byte $FF

Structure06_{AREA}: ; 05:AA02
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $FF

Structure07_{AREA}: ; 05:AA07
    .byte $02,  $08, $08
    .byte $02,  $08, $05
    .byte $02,  $09, $08
    .byte $02,  $08, $08
    .byte $02,  $05, $08
    .byte $FF

Structure08_{AREA}: ; 05:AA17
    .byte $04,  $08, $08, $08, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $08, $08, $08
    .byte $FF

Structure09_{AREA}: ; 05:AA2C
    .byte $04,  $08, $09, $09, $08
    .byte $FF

Structure0A_{AREA}: ; 05:AA32
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

Structure0B_{AREA}: ; 05:AA3D
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $FF

Structure0C_{AREA}: ; 05:AA57
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $FF

Structure0D_{AREA}: ; 05:AA64
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $FF

Structure0E_{AREA}: ; 05:AA6D
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $FF

Structure0F_{AREA}: ; 05:AA78
    .byte $04,  $18, $18, $18, $18
    .byte $04,  $19, $19, $19, $19
    .byte $FF

Structure10_{AREA}: ; 05:AA83
    .byte $01,  $1B
    .byte $FF

Structure11_{AREA}: ; 05:AA86
    .byte $04,  $1A, $1A, $1A, $1A
    .byte $FF

Structure12_{AREA}: ; 05:AA8C
    .byte $08,  $0F, $0F, $0F, $0F, $10, $10, $10, $10
    .byte $FF

Structure13_{AREA}: ; 05:AA96
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

Structure14_{AREA}: ; 05:AAAB
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0E, $0E, $0E, $0E, $0E, $0E, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

Structure15_{AREA}: ; 05:AAC7
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $FF

Structure16_{AREA}: ; 05:AAD2
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $FF

Structure17_{AREA}: ; 05:AAD9
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $FF

Structure18_{AREA}: ; 05:AAEE
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $09, $09, $09, $09, $09, $09, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

Structure19_{AREA}: ; 05:AB0A
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

Structure1A_{AREA}: ; 05:AB11
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $FF

Structure1B_{AREA}: ; 05:AB1A
    .byte $01,  $1F
    .byte $FF

Structure1C_{AREA}: ; 05:AB1D
    .byte $04,  $20, $20, $20, $20
    .byte $FF

