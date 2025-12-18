
SpecItmsTbl_{AREA}:
@y12:
    .byte $12
    .word @y14
    ;Elevator from Brinstar.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $81
        .byte $00

@y14:
    .byte $14
    .word @y15
    ;Elevator to Brinstar.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $82
        .byte $00

@y15:
    .byte $15
    .word @y16
    ;Missiles.
    @@x04:
        .byte $04, @@x09 - @@x04
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

    ;Missiles.
    @@x09:
        .byte $09, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y16:
    .byte $16
    .word @y19
    ;Energy tank.
    @@x0A:
        .byte $0A, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $66
        .byte $00

@y19:
    .byte $19
    .word @y1B
    ;Missiles.
    @@x0A:
        .byte $0A, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y1B:
    .byte $1B
    .word @y1C
    ;Missiles.
    @@x05:
        .byte $05, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y1C:
    .byte $1C
    .word @y1D
    ;Memus.
    @@x07:
        .byte $07, $FF
        .byte it_Mellow
        .byte $00

@y1D:
    .byte $1D
    .word $FFFF
    ;Energy tank.
    @@x08:
        .byte $08, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $BE
        .byte $00
