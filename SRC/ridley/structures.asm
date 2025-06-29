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

;Structure #$00
LA9BF:
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $FF

;Structure #$01
LA9D2:
    .byte $01,  $12
    .byte $01,  $12
    .byte $01,  $12
    .byte $FF

;Structure #$02
LA9D9:
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $FF

;Structure #$03
LA9E0:
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $02,  $02, $03
    .byte $FF

;Structure #$04
LA9F9:
    .byte $02,  $06, $07
    .byte $FF

;Structure #$05
LA9FD:
    .byte $01,  $0A
    .byte $01,  $0A
    .byte $FF

;Structure #$06
LAA02:
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $FF

;Structure #$07
LAA07:
    .byte $02,  $08, $08
    .byte $02,  $08, $05
    .byte $02,  $09, $08
    .byte $02,  $08, $08
    .byte $02,  $05, $08
    .byte $FF

;Structure #$08
LAA17:
    .byte $04,  $08, $08, $08, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $09, $09, $08
    .byte $04,  $08, $08, $08, $08
    .byte $FF

;Structure #$09
LAA2C:
    .byte $04,  $08, $09, $09, $08
    .byte $FF

;Structure #$0A
LAA32:
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

;Structure #$0B
LAA3D:
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $04,  $15, $15, $15, $15
    .byte $FF

;Structure #$0C
LAA57:
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $02,  $16, $16
    .byte $FF

;Structure #$0D
LAA64:
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $01,  $17
    .byte $FF

;Structure #$0E
LAA6D:
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $FF

;Structure #$0F
LAA78:
    .byte $04,  $18, $18, $18, $18
    .byte $04,  $19, $19, $19, $19
    .byte $FF

;Structure #$10
LAA83:
    .byte $01,  $1B
    .byte $FF

;Structure #$11
LAA86:
    .byte $04,  $1A, $1A, $1A, $1A
    .byte $FF

;Structure #$12
LAA8C:
    .byte $08,  $0F, $0F, $0F, $0F, $10, $10, $10, $10
    .byte $FF

;Structure #$13
LAA96:
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0E, $0E, $0D
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

;Structure #$14
LAAAB:
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $08,  $0D, $0E, $0E, $0E, $0E, $0E, $0E, $0D
    .byte $08,  $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    .byte $FF

;Structure #$15
LAAC7:
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $04,  $1C, $1C, $1C, $1C
    .byte $FF

;Structure #$16
LAAD2:
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $01,  $1D
    .byte $FF

;Structure #$17
LAAD9:
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $05, $05, $1E
    .byte $04,  $1E, $1E, $1E, $1E
    .byte $FF

;Structure #$18
LAAEE:
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $09, $09, $09, $09, $09, $09, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

;Structure #$19
LAB0A:
    .byte $01,  $14
    .byte $01,  $05
    .byte $01,  $14
    .byte $FF

;Structure #$1A
LAB11:
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $01,  $04
    .byte $FF

;Structure #$1B
LAB1A:
    .byte $01,  $1F
    .byte $FF

;Structure #$1C
LAB1D:
    .byte $04,  $20, $20, $20, $20
    .byte $FF

