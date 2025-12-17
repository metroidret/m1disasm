
SpecItmsTbl_{AREA}:
@y02:
    .byte $02
    .word @y03
    ;Elevator to Tourian.
    @@x03:
        .byte $03, @@x0F - @@x03
        .byte it_Elevator, $03
        .byte $00
    ;Varia suit.
    @@x0F:
        .byte $0F, $FF
        .byte it_PowerUp, pu_VARIA, $37
        .byte $00

@y03:
    .byte $03
    .word @y05
    ;Missiles.
    @@x18:
        .byte $18, @@x1B - @@x18
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Energy tank.
    @@x1B:
        .byte $1B, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

@y05:
    .byte $05
    .word @y07
    ;Long beam.
    @@x07:
        .byte $07, @@x19 - @@x07
        .byte it_PowerUp, pu_LONGBEAM, $37
        .byte $00
    ;Bombs.
    @@x19:
        .byte $19, $FF
        .byte it_PowerUp, pu_BOMBS, $37
        .byte $00

@y07:
    .byte $07
    .word @y09
    ;Palette change room.
    @@x0C:
        .byte $0C, @@x19 - @@x0C
        .byte it_PaletteChange
        .byte $00
    ;Energy tank.
    @@x19:
        .byte $19, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

@y09:
    .byte $09
    .word @y0B
    ;Ice beam.
    @@x13:
        .byte $13, @@x15 - @@x13
        .byte it_PowerUp, pu_ICEBEAM, $37
        .byte $00
    ;Mellows.
    @@x15:
        .byte $15, $FF
        .byte it_Mellow
        .byte $00

@y0B:
    .byte $0B
    .word @y0E
    ;Missiles.
    @@x12:
        .byte $12, @@x16 - @@x12
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Elevator to Norfair.
    @@x16:
        .byte $16, $FF
        .byte it_Elevator, $01
        .byte $00

@y0E:
    .byte $0E
    .word @y12
    ;Maru Mari.
    @@x02:
        .byte $02, @@x09 - @@x02
        .byte it_PowerUp, pu_MARUMARI, $96
        .byte $00
    ;Energy tank.
    @@x09:
        .byte $09, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $12
        .byte $00

@y12:
    .byte $12
    .word $FFFF
    ;Elevator to Kraid.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $02
        .byte $00

