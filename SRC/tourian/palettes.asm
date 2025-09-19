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

;Room palette.
Palette00:
    PPUString $3F00, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00, $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37
    PPUStringEnd

;Samus power suit palette.
Palette01:
    PPUString $3F12, \
        $19, $27
    PPUStringEnd

;Samus power suit with missiles selected palette.
Palette03:
    PPUString $3F12, \
        $2C, $27
    PPUStringEnd

;Samus varia suit palette.
Palette02:
    PPUString $3F12, \
        $19, $35
    PPUStringEnd

;Samus varia suit with missiles selected palette.
Palette04:
    PPUString $3F12, \
        $2C, $24
    PPUStringEnd

;Mother Brain hurt palettes.
Palette05:
Palette06:
    PPUString $3F0A, \
        $27
    PPUStringEnd

Palette07:
    PPUString $3F0A, \
        $20
    PPUStringEnd

;Mother Brain dying palettes.
Palette08:
    PPUString $3F00, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00, $0F
    PPUStringEnd

Palette09:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        PPUString $3F00, \
            $20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00, $20
    .elif BUILDTARGET == "NES_CNSUS"
        PPUString $3F00, \
            $00, $02, $16, $00, $00, $02, $11, $00, $00, $02, $16, $00, $00, $02, $10, $00, $00
    .endif
    PPUStringEnd

;Time bomb explosion palette.
Palette0A:
    PPUStringRepeat $3F00, \
        $20, $20
    PPUStringEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette0B:
Palette0C:
Palette0D:
Palette0E:
Palette0F:
Palette10:
Palette11:
Palette12:
Palette13:
    PPUString $3F11, \
        $04, $09, $07
    PPUStringEnd

Palette14:
    PPUString $3F11, \
        $05, $09, $17
    PPUStringEnd

Palette15:
    PPUString $3F11, \
        $06, $0A, $26
    PPUStringEnd

Palette16:
    PPUString $3F11, \
        $16, $19, $27
    PPUStringEnd

;Unused?
Palette17:
    PPUString $3F00, \
        $0F, $30, $30, $21
    PPUStringEnd

;Suitless Samus power suit palette.
Palette18:
    PPUString $3F10, \
        $0F, $15, $34, $17
    PPUStringEnd

;Suitless Samus varia suit palette.
Palette19:
    PPUString $3F10, \
        $0F, $15, $34, $19
    PPUStringEnd

;Suitless Samus power suit with missiles selected palette.
Palette1A:
    PPUString $3F10, \
        $0F, $15, $34, $28
    PPUStringEnd

;Suitless Samus varia suit with missiles selected palette.
Palette1B:
    PPUString $3F10, \
        $0F, $15, $34, $29
    PPUStringEnd

