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

;Norfair Palette Definitions

Palette00:
    PPUString $3F00, \
        $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $31, $13, $15, $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

    .byte $00                       ;End Palette00 info.

Palette01:
    PPUString $3F12, \
        $19, $27

    .byte $00                       ;End Palette01 info.

Palette03:
    PPUString $3F12, \
        $2C, $27

    .byte $00                       ;End Palette02 info.

Palette02:
    PPUString $3F12, \
        $19, $35

    .byte $00                       ;End Palette03 info.

Palette04:
    PPUString $3F12, \
        $2C, $24

    .byte $00                       ;End Palette04 info.

Palette05:
    PPUString $3F00, \
        $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $35, $1B, $16
    PPUString $3F14, \
        $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

    .byte $00                       ;End Palette05 info.

Palette06:
    PPUString $3F11, \
        $04, $09, $07

    .byte $00                       ;End Palette06 info.

Palette07:
    PPUString $3F11, \
        $05, $09, $17

    .byte $00                       ;End Palette07 info.

Palette08:
    PPUString $3F11, \
        $06, $0A, $26

    .byte $00                       ;End Palette08 info.

Palette09:
    PPUString $3F11, \
        $16, $19, $27

    .byte $00                       ;End Palette09 info.

Palette0A:
    PPUString $3F00, \
        $0F, $30, $30, $21

    .byte $00                       ;End Palette0A info.

Palette0B:
    PPUString $3F10, \
        $0F, $15, $34, $17

    .byte $00                       ;End Palette0B info.

Palette0C:
    PPUString $3F10, \
        $0F, $15, $34, $19

    .byte $00                       ;End Palette0C info.

Palette0D:
    PPUString $3F10, \
        $0F, $15, $34, $28

    .byte $00                       ;End Palette0D info.

Palette0E:
    PPUString $3F10, \
        $0F, $15, $34, $29

    .byte $00                       ;End Palette0E info.
