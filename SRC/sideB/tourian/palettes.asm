;Tourian Palette Data

;Room palette.
Palette00_{AREA}:
    VRAMStructData $3F00, undefined, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00, \
        $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37
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

;Mother Brain hurt palettes.
Palette05_{AREA}:
Palette06_{AREA}:
    VRAMStructData $3F0A, undefined, \
        $27
    VRAMStructEnd

Palette07_{AREA}:
    VRAMStructData $3F0A, undefined, \
        $20
    VRAMStructEnd

;Mother Brain dying palettes.
Palette08_{AREA}:
    VRAMStructData $3F00, undefined, \
        $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00, $0F
    VRAMStructEnd

Palette09_{AREA}:
    VRAMStructData $3F00, undefined, \
        $20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00, $20
    VRAMStructEnd

;Time bomb explosion palette.
Palette0A_{AREA}:
    VRAMStructDataRepeat $3F00, undefined, \
        $20, $20
    VRAMStructEnd

;Samus fade in palettes. Same regardless of varia suit and suitless.
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
