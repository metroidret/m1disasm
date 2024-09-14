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
LAA6B:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAA7B:  .byte $00, $00, $FF

;Structure #$01
LAA7E:  .byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $1C, $01, $1C, $01, $1C, $08
LAA8E:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LAA97:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LAAA7:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LAAB0:  .byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LAAB7:  .byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LAABE:  .byte $02, $14, $15, $FF

;Structure #$06
LAAC2:  .byte $02, $17, $17, $02, $17, $1B, $02, $17, $1B, $02, $1B, $17, $02, $17, $17, $FF

;Structure #$07
LAAD2:  .byte $02, $1A, $17, $02, $17, $17, $02, $1B, $1A, $02, $17, $17, $02, $1A, $1B, $FF

;Structure #$08
LAAE2:  .byte $01, $18, $01, $18, $FF

;Structure #$09
LAAE7:  .byte $01, $19, $01, $19, $FF

;Structure #$0A
LAAEC:  .byte $01, $09, $FF

;Structure #$0B
LAAEF:  .byte $01, $0A, $FF

;Structure #$0C
LAAF2:  .byte $01, $1E, $01, $1A, $01, $1A, $01, $1A, $01, $1E, $FF

;Structure #$0D
LAAFD:  .byte $04, $17, $17, $17, $17, $FF

;Structure #$0E
LAB03:  .byte $03, $17, $1D, $17, $FF

;Structure #$0F
LAB08:  .byte $01, $0B, $01, $0B, $01, $0B, $01, $0B, $FF

;Structure #$10
LAB11:  .byte $04, $17, $17, $1B, $17, $04, $1B, $17, $17, $17, $04, $1B, $17, $1B, $1B, $04
LAB21:  .byte $17, $1B, $17, $17, $FF

;Structure #$11
LAB26:  .byte $01, $17, $FF

;Structure #$12
LAB29:  .byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E
LAB39:  .byte $1E, $1E, $FF

;Structure #$13
LAB3C:  .byte $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04
LAB4C:  .byte $0F, $0F, $0F, $0F, $FF

;Structure #$14
LAB51:  .byte $02, $12, $12, $FF

;Structure #$15
LAB55:  .byte $08, $10, $10, $10, $10, $10, $10, $10, $10, $08, $10, $10, $10, $10, $10, $10
LAB65:  .byte $10, $10, $FF

;Structure #$16
LAB68:  .byte $02, $10, $10, $02, $10, $10, $02, $10, $10, $02, $10, $10, $FF

;Structure #$17
LAB75:  .byte $08, $13, $0E, $13, $0E, $0E, $13, $0E, $0E, $08, $0E, $0E, $13, $13, $0E, $0E
LAB85:  .byte $13, $13, $FF

;Structure #$18
LAB88:  .byte $08, $11, $11, $11, $11, $11, $11, $11, $11, $08, $11, $11, $11, $11, $11, $11
LAB98:  .byte $11, $11, $FF

;Structure #$19
LAB9B:  .byte $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04
LABAB:  .byte $11, $11, $11, $11, $FF

;Structure #$1A
LABB0:  .byte $08, $20, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$1B
LABBA:  .byte $01, $1F, $FF

;Structure #$1C
LABBD:  .byte $01, $21, $01, $21, $01, $21, $FF

;Structure #$1D
LABC4:  .byte $08, $23, $23, $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24
LABD4:  .byte $24, $23, $08, $23, $23, $23, $23, $23, $23, $23, $23, $FF

;Structure #$1E
LABE0:  .byte $01, $23, $01, $23, $01, $23, $01, $23, $FF

;Structure #$1F
LABE9:  .byte $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24, $23, $04
LABF9:  .byte $23, $23, $23, $23, $FF

;Structure #$20
LABFE:  .byte $01, $25, $FF

;Structure #$21
LAC01:  .byte $01, $26, $01, $26, $01, $26, $01, $26, $FF

;Structure #$22
LAC0A:  .byte $03, $27, $27, $27, $FF

;Structure #$23
LAC0F:  .byte $03, $28, $28, $28, $FF

;Structure #$24
LAC14:  .byte $08, $13, $13, $13, $13, $13, $13, $13, $13, $FF

;Structure #$25
LAC1E:  .byte $01, $13, $01, $13, $01, $13, $01, $13, $FF

;Structure #$26
LAC27:  .byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF