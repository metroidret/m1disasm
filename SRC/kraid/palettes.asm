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

;Kraid Palette Data

;Room palette.
Palette00_{AREA}: ; 04:A155
    VRAMStructData $3F00, \
        $0F, $20, $10, $00, $0F, $28, $19, $1A, $0F, $28, $16, $04, $0F, $23, $11, $02, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $1B, $36, $0F, $17, $22, $31
    VRAMStructEnd

;Samus power suit palette.
Palette01_{AREA}: ; 04:A179
    VRAMStructData $3F12, \
        $19, $27
    VRAMStructEnd

;Samus power suit with missiles selected palette.
Palette03_{AREA}: ; 04:A17F
    VRAMStructData $3F12, \
        $2C, $27
    VRAMStructEnd

;Samus varia suit palette.
Palette02_{AREA}: ; 04:A185
    VRAMStructData $3F12, \
        $19, $35
    VRAMStructEnd

;Samus varia suit with missiles selected palette.
Palette04_{AREA}: ; 04:A18B
    VRAMStructData $3F12, \
        $2C, $24
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette05_{AREA}: ; 04:A191
Palette06_{AREA}: ; 04:A191
Palette07_{AREA}: ; 04:A191
Palette08_{AREA}: ; 04:A191
Palette09_{AREA}: ; 04:A191
Palette0A_{AREA}: ; 04:A191
Palette0B_{AREA}: ; 04:A191
Palette0C_{AREA}: ; 04:A191
Palette0D_{AREA}: ; 04:A191
Palette0E_{AREA}: ; 04:A191
Palette0F_{AREA}: ; 04:A191
Palette10_{AREA}: ; 04:A191
Palette11_{AREA}: ; 04:A191
Palette12_{AREA}: ; 04:A191
Palette13_{AREA}: ; 04:A191
    VRAMStructData $3F11, \
        $04, $09, $07
    VRAMStructEnd

Palette14_{AREA}: ; 04:A198
    VRAMStructData $3F11, \
        $05, $09, $17
    VRAMStructEnd

Palette15_{AREA}: ; 04:A19F
    VRAMStructData $3F11, \
        $06, $0A, $26
    VRAMStructEnd

Palette16_{AREA}: ; 04:A1A6
    VRAMStructData $3F11, \
        $16, $19, $27
    VRAMStructEnd

;Unused?
Palette17_{AREA}: ; 04:A1AD
    VRAMStructData $3F00, \
        $0F, $30, $30, $21
    VRAMStructEnd

;Suitless Samus power suit palette.
Palette18_{AREA}: ; 04:A1B5
    VRAMStructData $3F10, \
        $0F, $15, $34, $17
    VRAMStructEnd

;Suitless Samus varia suit palette.
Palette19_{AREA}: ; 04:A1BD
    VRAMStructData $3F10, \
        $0F, $15, $34, $19
    VRAMStructEnd

;Suitless Samus power suit with missiles selected palette.
Palette1A_{AREA}: ; 04:A1C5
    VRAMStructData $3F10, \
        $0F, $15, $34, $28
    VRAMStructEnd

;Suitless Samus varia suit with missiles selected palette.
Palette1B_{AREA}: ; 04:A1CD
    VRAMStructData $3F10, \
        $0F, $15, $34, $29
    VRAMStructEnd

