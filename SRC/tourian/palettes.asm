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
Palette00_{AREA}: ; 03:A718
    VRAMStructData $3F00, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37
    VRAMStructEnd

;Samus power suit palette.
Palette01_{AREA}: ; 03:A73C
    VRAMStructData $3F12, \
        $19, $27
    VRAMStructEnd

;Samus power suit with missiles selected palette.
Palette03_{AREA}: ; 03:A742
    VRAMStructData $3F12, \
        $2C, $27
    VRAMStructEnd

;Samus varia suit palette.
Palette02_{AREA}: ; 03:A748
    VRAMStructData $3F12, \
        $19, $35
    VRAMStructEnd

;Samus varia suit with missiles selected palette.
Palette04_{AREA}: ; 03:A74E
    VRAMStructData $3F12, \
        $2C, $24
    VRAMStructEnd

;Mother Brain hurt palettes.
Palette05_{AREA}: ; 03:A754
Palette06_{AREA}: ; 03:A754
    VRAMStructData $3F0A, \
        $27
    VRAMStructEnd

Palette07_{AREA}: ; 03:A759
    VRAMStructData $3F0A, \
        $20
    VRAMStructEnd

;Mother Brain dying palettes.
Palette08_{AREA}: ; 03:A75E
    VRAMStructData $3F00, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00, $0F
    VRAMStructEnd

Palette09_{AREA}: ; 03:A773
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G"
        VRAMStructData $3F00, \
            $20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00, $20
    .elif BUILDTARGET == "NES_CNS"
        VRAMStructData $3F00, \
            $00, $02, $16, $00, $00, $02, $11, $00, $00, $02, $16, $00, $00, $02, $10, $00, $00
    .endif
    VRAMStructEnd

;Time bomb explosion palette.
Palette0A_{AREA}: ; 03:A788
    VRAMStructDataRepeat $3F00, \
        $20, $20
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette0B_{AREA}: ; 03:A78D
Palette0C_{AREA}: ; 03:A78D
Palette0D_{AREA}: ; 03:A78D
Palette0E_{AREA}: ; 03:A78D
Palette0F_{AREA}: ; 03:A78D
Palette10_{AREA}: ; 03:A78D
Palette11_{AREA}: ; 03:A78D
Palette12_{AREA}: ; 03:A78D
Palette13_{AREA}: ; 03:A78D
    VRAMStructData $3F11, \
        $04, $09, $07
    VRAMStructEnd

Palette14_{AREA}: ; 03:A794
    VRAMStructData $3F11, \
        $05, $09, $17
    VRAMStructEnd

Palette15_{AREA}: ; 03:A79B
    VRAMStructData $3F11, \
        $06, $0A, $26
    VRAMStructEnd

Palette16_{AREA}: ; 03:A7A2
    VRAMStructData $3F11, \
        $16, $19, $27
    VRAMStructEnd

;Unused?
Palette17_{AREA}: ; 03:A7A9
    VRAMStructData $3F00, \
        $0F, $30, $30, $21
    VRAMStructEnd

;Suitless Samus power suit palette.
Palette18_{AREA}: ; 03:A7B1
    VRAMStructData $3F10, \
        $0F, $15, $34, $17
    VRAMStructEnd

;Suitless Samus varia suit palette.
Palette19_{AREA}: ; 03:A7B9
    VRAMStructData $3F10, \
        $0F, $15, $34, $19
    VRAMStructEnd

;Suitless Samus power suit with missiles selected palette.
Palette1A_{AREA}: ; 03:A7C1
    VRAMStructData $3F10, \
        $0F, $15, $34, $28
    VRAMStructEnd

;Suitless Samus varia suit with missiles selected palette.
Palette1B_{AREA}: ; 03:A7C9
    VRAMStructData $3F10, \
        $0F, $15, $34, $29
    VRAMStructEnd

