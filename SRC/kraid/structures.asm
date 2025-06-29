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

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAA6B:
    .byte $08,  $01, $01, $01, $01, $01, $01, $01, $01
    .byte $08,  $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF

;Structure #$01
LAA7E:
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $01,  $1C
    .byte $01,  $1C
    .byte $01,  $1C
    .byte $08,  $02, $02, $02, $02, $02, $02, $02, $02
    .byte $FF

;Structure #$02
LAA97:
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
LAAB0:
    .byte $01,  $06
    .byte $01,  $06
    .byte $01,  $06
    .byte $FF

;Structure #$04
LAAB7:
    .byte $01,  $07
    .byte $01,  $07
    .byte $01,  $07
    .byte $FF

;Structure #$05
LAABE:
    .byte $02,  $14, $15
    .byte $FF

;Structure #$06
LAAC2:
    .byte $02,  $17, $17
    .byte $02,  $17, $1B
    .byte $02,  $17, $1B
    .byte $02,  $1B, $17
    .byte $02,  $17, $17
    .byte $FF

;Structure #$07
LAAD2:
    .byte $02,  $1A, $17
    .byte $02,  $17, $17
    .byte $02,  $1B, $1A
    .byte $02,  $17, $17
    .byte $02,  $1A, $1B
    .byte $FF

;Structure #$08
LAAE2:
    .byte $01,  $18
    .byte $01,  $18
    .byte $FF

;Structure #$09
LAAE7:
    .byte $01,  $19
    .byte $01,  $19
    .byte $FF

;Structure #$0A
LAAEC:
    .byte $01,  $09
    .byte $FF

;Structure #$0B
LAAEF:
    .byte $01,  $0A
    .byte $FF

;Structure #$0C
LAAF2:
    .byte $01,  $1E
    .byte $01,  $1A
    .byte $01,  $1A
    .byte $01,  $1A
    .byte $01,  $1E
    .byte $FF

;Structure #$0D
LAAFD:
    .byte $04,  $17, $17, $17, $17
    .byte $FF

;Structure #$0E
LAB03:
    .byte $03,  $17, $1D, $17
    .byte $FF

;Structure #$0F
LAB08:
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $01,  $0B
    .byte $FF

;Structure #$10
LAB11:
    .byte $04,  $17, $17, $1B, $17
    .byte $04,  $1B, $17, $17, $17
    .byte $04,  $1B, $17, $1B, $1B
    .byte $04,  $17, $1B, $17, $17
    .byte $FF

;Structure #$11
LAB26:
    .byte $01,  $17
    .byte $FF

;Structure #$12
LAB29:
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $08,  $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E
    .byte $FF

;Structure #$13
LAB3C:
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $04,  $0F, $0F, $0F, $0F
    .byte $FF

;Structure #$14
LAB51:
    .byte $02,  $12, $12
    .byte $FF

;Structure #$15
LAB55:
    .byte $08,  $10, $10, $10, $10, $10, $10, $10, $10
    .byte $08,  $10, $10, $10, $10, $10, $10, $10, $10
    .byte $FF

;Structure #$16
LAB68:
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $02,  $10, $10
    .byte $FF

;Structure #$17
LAB75:
    .byte $08,  $13, $0E, $13, $0E, $0E, $13, $0E, $0E
    .byte $08,  $0E, $0E, $13, $13, $0E, $0E, $13, $13
    .byte $FF

;Structure #$18
LAB88:
    .byte $08,  $11, $11, $11, $11, $11, $11, $11, $11
    .byte $08,  $11, $11, $11, $11, $11, $11, $11, $11
    .byte $FF

;Structure #$19
LAB9B:
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $04,  $11, $11, $11, $11
    .byte $FF

;Structure #$1A
LABB0:
    .byte $08,  $20, $22, $22, $22, $22, $22, $22, $22
    .byte $FF

;Structure #$1B
LABBA:
    .byte $01,  $1F
    .byte $FF

;Structure #$1C
LABBD:
    .byte $01,  $21
    .byte $01,  $21
    .byte $01,  $21
    .byte $FF

;Structure #$1D
LABC4:
    .byte $08,  $23, $23, $23, $23, $23, $23, $23, $23
    .byte $08,  $23, $24, $24, $24, $24, $24, $24, $23
    .byte $08,  $23, $23, $23, $23, $23, $23, $23, $23
    .byte $FF

;Structure #$1E
LABE0:
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $01,  $23
    .byte $FF

;Structure #$1F
LABE9:
    .byte $04,  $23, $23, $23, $23
    .byte $04,  $23, $24, $24, $23
    .byte $04,  $23, $24, $24, $23
    .byte $04,  $23, $23, $23, $23
    .byte $FF

;Structure #$20
LABFE:
    .byte $01,  $25
    .byte $FF

;Structure #$21
LAC01:
    .byte $01,  $26
    .byte $01,  $26
    .byte $01,  $26
    .byte $01,  $26
    .byte $FF

;Structure #$22
LAC0A:
    .byte $03,  $27, $27, $27
    .byte $FF

;Structure #$23
LAC0F:
    .byte $03,  $28, $28, $28
    .byte $FF

;Structure #$24
LAC14:
    .byte $08,  $13, $13, $13, $13, $13, $13, $13, $13
    .byte $FF

;Structure #$25
LAC1E:
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $01,  $13
    .byte $FF

;Structure #$26
LAC27:
    .byte $04,  $0C, $0C, $0C, $0C
    .byte $04,  $0D, $0D, $0D, $0D
    .byte $FF

