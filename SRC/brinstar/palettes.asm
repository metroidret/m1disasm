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

;Brinstar Palettes

Palette00:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
;The following values are written to the background palette:
    .byte $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C
;The following values are written to the sprite palette:
    .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38

    .byte $00                       ;End Palette00 info.

Palette01:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $12                       ;Lower byte of PPU palette adress.
    .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $19, $27

    .byte $00                       ;End Palette01 info.

Palette03:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $12                       ;Lower byte of PPU palette adress.
    .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $2C, $27

    .byte $00                       ;End Palette02 info.

Palette02:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $12                       ;Lower byte of PPU palette adress.
    .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $19, $35

    .byte $00                       ;End Palette03 info.

Palette04:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $12                       ;Lower byte of PPU palette adress.
    .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $2C, $24

    .byte $00                       ;End Palette04 info.

Palette05:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $10                       ;Palette data length.
;The following values are written to the background palette:
    .byte $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $14                       ;Lower byte of PPU palette adress.
    .byte $0C                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38

    .byte $00                       ;End Palette05 info.

Palette06:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $11                       ;Lower byte of PPU palette adress.
    .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $04, $09, $07

    .byte $00                       ;End Palette06 info.

Palette07:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $11                       ;Lower byte of PPU palette adress.
    .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $05, $09, $17

    .byte $00                       ;End Palette07 info.

Palette08:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $11                       ;Lower byte of PPU palette adress.
    .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $06, $0A, $26

    .byte $00                       ;End Palette08 info.

Palette09:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $11                       ;Lower byte of PPU palette adress.
    .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $16, $19, $27

    .byte $00                       ;End Palette09 info.

Palette0A:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
;The following values are written to the background palette:
    .byte $0F, $30, $30, $21

    .byte $00                       ;End Palette0A info.

Palette0B:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $10                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $0F, $15, $34, $17

    .byte $00                       ;End Palette0B info.

Palette0C:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $10                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $0F, $15, $34, $19

    .byte $00                       ;End Palette0C info.

Palette0D:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $10                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $0F, $15, $34, $28

    .byte $00                       ;End Palette0D info.

Palette0E:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $10                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
    .byte $0F, $15, $34, $29

    .byte $00                       ;End Palette0E info.