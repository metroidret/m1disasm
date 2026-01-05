;Brinstar Palettes

;Default room palette.
Palette00_{AREA}:
    VRAMStructData $3F00, undefined, \
        $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38
    VRAMStructEnd


;Samus power suit palette.
Palette01_{AREA}:
    VRAMStructData $3F12, undefined, \
        $19, $27
    VRAMStructEnd

;Samus power suit with missiles selected palette.
Palette03_{AREA}:
    VRAMStructData $3F12, undefined, \
        $2C, $27
    VRAMStructEnd

;Samus varia suit palette.
Palette02_{AREA}:
    VRAMStructData $3F12, undefined, \
        $19, $35
    VRAMStructEnd

;Samus varia suit with missiles selected palette.
Palette04_{AREA}:
    VRAMStructData $3F12, undefined, \
        $2C, $24
    VRAMStructEnd

;Alternate room palette.
Palette05_{AREA}:
    VRAMStructData $3F00, undefined, \
        $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
    VRAMStructData $3F14, undefined, \
        $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
Palette06_{AREA}:
Palette07_{AREA}:
Palette08_{AREA}:
Palette09_{AREA}:
Palette0A_{AREA}:
Palette0B_{AREA}:
Palette0C_{AREA}:
Palette0D_{AREA}:
Palette0E_{AREA}:
Palette0F_{AREA}:
Palette10_{AREA}:
Palette11_{AREA}:
Palette12_{AREA}:
Palette13_{AREA}:
    VRAMStructData $3F11, undefined, \
        $04, $09, $07
    VRAMStructEnd

Palette14_{AREA}:
    VRAMStructData $3F11, undefined, \
        $05, $09, $17
    VRAMStructEnd

Palette15_{AREA}:
    VRAMStructData $3F11, undefined, \
        $06, $0A, $26
    VRAMStructEnd

Palette16_{AREA}:
    VRAMStructData $3F11, undefined, \
        $16, $19, $27
    VRAMStructEnd

;Unused?
Palette17_{AREA}:
    VRAMStructData $3F00, undefined, \
        $0F, $30, $30, $21
    VRAMStructEnd

