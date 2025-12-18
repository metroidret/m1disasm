

SpecItmsTbl_{AREA}:
@y18:
    .byte $18
    .word @y19
    ;Missiles.
    @@x12:
        .byte $12, @@x19 - @@x12
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00
    ;Elevator to Norfair.
    @@x19:
        .byte $19, $FF
        .byte it_Elevator, $84
        .byte $00

@y19:
    .byte $19
    .word @y1B
    ;Energy tank.
    @@x11:
        .byte $11, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $74
        .byte $00

@y1B:
    .byte $1B
    .word @y1D
    ;Missiles.
    @@x18:
        .byte $18, $FF
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00

@y1D:
    .byte $1D
    .word @y1E
    ;Energy tank.
    @@x0F:
        .byte $0F, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $66
        .byte $00

@y1E:
    .byte $1E
    .word $FFFF
    ;Missiles.
    @@x14:
        .byte $14, $FF
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00
