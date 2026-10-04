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

;Ridley Palette Data

;Default room palette.
Palette00_{AREA}: ; 05:A0EB
    VRAMStructData $3F00, \
        $0F, $20, $10, $00, $0F, $21, $14, $13, $0F, $28, $1B, $02, $0F, $15, $16, $04, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $13, $29, $0F, $13, $15, $27
    VRAMStructEnd

;Samus power suit palette.
Palette01_{AREA}: ; 05:A10F
    VRAMStructData $3F12, \
        $19, $27
    VRAMStructEnd

;Samus power suit with missiles selected palette.
Palette03_{AREA}: ; 05:A115
    VRAMStructData $3F12, \
        $2C, $27
    VRAMStructEnd

;Samus varia suit palette.
Palette02_{AREA}: ; 05:A11B
    VRAMStructData $3F12, \
        $19, $35
    VRAMStructEnd

;Samus varia suit with missiles selected palette.
Palette04_{AREA}: ; 05:A121
    VRAMStructData $3F12, \
        $2C, $24
    VRAMStructEnd

;Alternate room palette.
Palette05_{AREA}: ; 05:A127
    VRAMStructData $3F00, \
        $0F, $20, $16, $04, $0F, $21, $14, $13, $0F, $27, $16, $02, $0F, $15, $16, $04
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette06_{AREA}: ; 05:A13B
Palette07_{AREA}: ; 05:A13B
Palette08_{AREA}: ; 05:A13B
Palette09_{AREA}: ; 05:A13B
Palette0A_{AREA}: ; 05:A13B
Palette0B_{AREA}: ; 05:A13B
Palette0C_{AREA}: ; 05:A13B
Palette0D_{AREA}: ; 05:A13B
Palette0E_{AREA}: ; 05:A13B
Palette0F_{AREA}: ; 05:A13B
Palette10_{AREA}: ; 05:A13B
Palette11_{AREA}: ; 05:A13B
Palette12_{AREA}: ; 05:A13B
Palette13_{AREA}: ; 05:A13B
    VRAMStructData $3F11, \
        $04, $09, $07
    VRAMStructEnd

Palette14_{AREA}: ; 05:A142
    VRAMStructData $3F11, \
        $05, $09, $17
    VRAMStructEnd

Palette15_{AREA}: ; 05:A149
    VRAMStructData $3F11, \
        $06, $0A, $26
    VRAMStructEnd

Palette16_{AREA}: ; 05:A150
    VRAMStructData $3F11, \
        $16, $19, $27
    VRAMStructEnd

;Unused?
Palette17_{AREA}: ; 05:A157
    VRAMStructData $3F00, \
        $0F, $30, $30, $21
    VRAMStructEnd

;Suitless Samus power suit palette.
Palette18_{AREA}: ; 05:A15F
    VRAMStructData $3F10, \
        $0F, $15, $34, $17
    VRAMStructEnd

;Suitless Samus varia suit palette.
Palette19_{AREA}: ; 05:A167
    VRAMStructData $3F10, \
        $0F, $15, $34, $19
    VRAMStructEnd

;Suitless Samus power suit with missiles selected palette.
Palette1A_{AREA}: ; 05:A16F
    VRAMStructData $3F10, \
        $0F, $15, $34, $28
    VRAMStructEnd

;Suitless Samus varia suit with missiles selected palette.
Palette1B_{AREA}: ; 05:A177
    VRAMStructData $3F10, \
        $0F, $15, $34, $29
    VRAMStructEnd

