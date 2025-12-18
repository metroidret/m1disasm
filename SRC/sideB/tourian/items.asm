
SpecItmsTbl_{AREA}:
@y03:
    .byte $03
    .word @y04
    ;Elevator to end.
    @@x01:
        .byte $01, $FF
        .byte it_Elevator, $8F
        .byte $00

@y04:
    .byte $04
    .word @y07
    ;Elevator to Brinstar.
    @@x03:
        .byte $03, $FF
        .byte it_Elevator, $83
        .byte $00

@y07:
    .byte $07
    .word @y08
    ;10 missile door.
    @@x03:
        .byte $03, @@x04 - @@x03
        .byte it_Door, $A2
        .byte $00
    ;Rinkas
    @@x04:
        .byte $04, @@x09 - @@x04
        .byte it_RinkaSpawner
        .byte $00
    ;Rinkas
    @@x09:
        .byte $09, $FF
        .byte it_RinkaSpawner
        .byte $00

@y08:
    .byte $08
    .word @y09
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner | $10
        .byte $00

@y09:
    .byte $09
    .word @y0A
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner
        .byte $00

@y0A:
    .byte $0A
    .word @y0B
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner | $10
        .byte $00

@y0B:
    .byte $0B
    .word $FFFF
    ;Door at bottom of escape shaft.
    @@x01:
        .byte $01, @@x02 - @@x01
        .byte it_Door, $A3
        .byte $00
    ;Mother brain, Zebetite, 3 cannons and Rinkas.
    @@x02:
        .byte $02, @@x03 - @@x02
        .byte it_MotherBrain
        .byte it_Zebetite | $40
        .byte it_RinkaSpawner | $10
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $20, $3E
        .byte $00
    ;2 Zebetites, 6 cannons and Rinkas.
    @@x03:
        .byte $03, @@x04 - @@x03
        .byte it_Zebetite | $30
        .byte it_Zebetite | $20
        .byte it_RinkaSpawner
        .byte it_Cannon | $00, $41
        .byte it_Cannon | $10, $43
        .byte it_Cannon | $20, $36
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $30, $3E
        .byte $00
    ;Right door, 2 Zebetites, 6 cannons and Rinkas.
    @@x04:
        .byte $04, @@x05 - @@x04
        .byte it_Door, $A3
        .byte it_Zebetite | $10
        .byte it_Zebetite | $00
        .byte it_RinkaSpawner
        .byte it_Cannon | $00, $41
        .byte it_Cannon | $10, $43
        .byte it_Cannon | $20, $36
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $30, $3E
        .byte $00
    ;Left door.
    @@x05:
        .byte $05, $FF
        .byte it_Door, $B3
        .byte $00
