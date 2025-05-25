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

;Tourian Palette Data

Palette00:
    PPUString $3F00, {$0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00, $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37}

    .byte $00                       ;End Palette00 info.

Palette01:
    PPUString $3F12, {$19, $27}

    .byte $00                       ;End Palette01 info.

Palette03:
    PPUString $3F12, {$2C, $27}

    .byte $00                       ;End Palette03 info.

Palette02:
    PPUString $3F12, {$19, $35}

    .byte $00                       ;End Palette02 info.

Palette04:
    PPUString $3F12, {$2C, $24}

    .byte $00                       ;End Palette04 info.

Palette05:
    PPUString $3F0A, {$27}

    .byte $00                       ;End Palette05 info.

Palette06:
    PPUString $3F0A, {$20}

    .byte $00                       ;End Palette06 info.

Palette07:
    PPUString $3F00, {$0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00, $0F}

    .byte $00                       ;End Palette07 info.

Palette08:
    PPUString $3F00, {$20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00, $20}

    .byte $00                       ;End Palette08 info.

Palette09:
    PPUStringRepeat $3F00, $20, $20

    .byte $00                       ;End Palette09 info.

Palette0A:
    PPUString $3F11, {$04, $09, $07}

    .byte $00                       ;End Palette0A info.

Palette0B:
    PPUString $3F11, {$05, $09, $17}

    .byte $00                       ;End Palette0B info.

Palette0C:
    PPUString $3F11, {$06, $0A, $26}

    .byte $00                       ;End Palette0C info.

Palette0D:
    PPUString $3F11, {$16, $19, $27}

    .byte $00                       ;End Palette0D info.

Palette0E:
    PPUString $3F00, {$0F, $30, $30, $21}

    .byte $00                       ;End Palette0E info.

Palette0F:
    PPUString $3F10, {$0F, $15, $34, $17}

    .byte $00                       ;End Palette0F info.

Palette10:
    PPUString $3F10, {$0F, $15, $34, $19}

    .byte $00                       ;End Palette10 info.

Palette11:
    PPUString $3F10, {$0F, $15, $34, $28}

    .byte $00                       ;End Palette11 info.

Palette12:
    PPUString $3F10, {$0F, $15, $34, $29}

    .byte $00                       ;End Palette12 info.
