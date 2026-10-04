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

;Default room palette.
Palette00_{AREA}: ; 01:A271
    VRAMStructData $3F00, \
        $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38
    VRAMStructEnd

;Samus power suit palette.
Palette01_{AREA}: ; 01:A295
    VRAMStructData $3F12, \
        $19, $27
    VRAMStructEnd

;Samus power suit with missiles selected palette.
Palette03_{AREA}: ; 01:A29B
    VRAMStructData $3F12, \
        $2C, $27
    VRAMStructEnd

;Samus varia suit palette.
Palette02_{AREA}: ; 01:A2A1
    VRAMStructData $3F12, \
        $19, $35
    VRAMStructEnd

;Samus varia suit with missiles selected palette.
Palette04_{AREA}: ; 01:A2A7
    VRAMStructData $3F12, \
        $2C, $24
    VRAMStructEnd

;Alternate room palette.
Palette05_{AREA}: ; 01:A2AD
    VRAMStructData $3F00, \
        $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
    VRAMStructData $3F14, \
        $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette06_{AREA}: ; 01:A2D0
Palette07_{AREA}: ; 01:A2D0
Palette08_{AREA}: ; 01:A2D0
Palette09_{AREA}: ; 01:A2D0
Palette0A_{AREA}: ; 01:A2D0
Palette0B_{AREA}: ; 01:A2D0
Palette0C_{AREA}: ; 01:A2D0
Palette0D_{AREA}: ; 01:A2D0
Palette0E_{AREA}: ; 01:A2D0
Palette0F_{AREA}: ; 01:A2D0
Palette10_{AREA}: ; 01:A2D0
Palette11_{AREA}: ; 01:A2D0
Palette12_{AREA}: ; 01:A2D0
Palette13_{AREA}: ; 01:A2D0
    VRAMStructData $3F11, \
        $04, $09, $07
    VRAMStructEnd

Palette14_{AREA}: ; 01:A2D7
    VRAMStructData $3F11, \
        $05, $09, $17
    VRAMStructEnd

Palette15_{AREA}: ; 01:A2DE
    VRAMStructData $3F11, \
        $06, $0A, $26
    VRAMStructEnd

Palette16_{AREA}: ; 01:A2E5
    VRAMStructData $3F11, \
        $16, $19, $27
    VRAMStructEnd

;Unused?
Palette17_{AREA}: ; 01:A2EC
    VRAMStructData $3F00, \
        $0F, $30, $30, $21
    VRAMStructEnd

;Suitless Samus power suit palette.
Palette18_{AREA}: ; 01:A2F4
    VRAMStructData $3F10, \
        $0F, $15, $34, $17
    VRAMStructEnd

;Suitless Samus varia suit palette.
Palette19_{AREA}: ; 01:A2FC
    VRAMStructData $3F10, \
        $0F, $15, $34, $19
    VRAMStructEnd

;Suitless Samus power suit with missiles selected palette.
Palette1A_{AREA}: ; 01:A304
    VRAMStructData $3F10, \
        $0F, $15, $34, $28
    VRAMStructEnd

;Suitless Samus varia suit with missiles selected palette.
Palette1B_{AREA}: ; 01:A30C
    VRAMStructData $3F10, \
        $0F, $15, $34, $29
    VRAMStructEnd

