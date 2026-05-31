    .byte $AC, $0B, $01
    .byte $C8
    .byte $F0, $05
        .byte $A9, $00
        .byte $9D, $60, $B4
    
    .byte $A9, $0F
    .byte $85, $00
    .byte $85, $01
    .byte $BD, $05, $04
    .byte $0A
    .byte $30, $D2
    .byte $BD, $60, $B4
    .byte $C9, $03
    .byte $F0, $CB
    
    .byte $20, $AF, $B9
    .byte $B9, $19, $BA
    .byte $F0, $03
        .byte $4C, $91, $B8
    
    ; red or green
    .byte $BC, $08, $04
    
    .byte $B9, $17, $BA
    .byte $48
    
    .byte $BD, $02, $04
    .byte $10, $0D
        .byte $68
        .byte $20, $BE, $B5
        .byte $48
        .byte $A9, $00
        .byte $DD, $06, $04
        .byte $FD, $02, $04
    .byte $D9, $17, $BA
    .byte $68
    .byte $90, $08
        .byte $9D, $02, $04
        .byte $A9, $00
        .byte $9D, $06, $04
    
    ; max x speed push
    .byte $B9, $17, $BA
    .byte $48
    
    .byte $BD, $03, $04
    .byte $10, $0D
        .byte $68
        .byte $20, $BE, $B5
        .byte $48
        .byte $A9, $00
        .byte $DD, $07, $04
        .byte $FD, $03, $04
    .byte $D9, $17, $BA
    .byte $68
    .byte $90, $08
        .byte $9D, $03, $04
        .byte $A9, $00
        .byte $9D, $07, $04
    
    ; load accel
    .byte $BD, $05, $04
    .byte $48
    .byte $20, $FE, $B9
    .byte $9D, $6B, $B4
    .byte $68
    .byte $4A
    .byte $4A
    .byte $20, $FE, $B9
    .byte $9D, $6A, $B4
    
    .byte $BD, $60, $B4
    .byte $C9, $04
    .byte $D0, $0D
        .byte $BC, $0B, $04
        .byte $C8
        .byte $D0, $0C
            .byte $A9, $05
            .byte $9D, $0B, $04
            .byte $D0, $05
        .byte $A9, $FF
        .byte $9D, $0B, $04
    
    ; lacth active
    .byte $A5, $7C
    .byte $C9, $06
    .byte $D0, $0A
        .byte $DD, $60, $B4
        .byte $F0, $05
            .byte $A9, $04
            .byte $9D, $60, $B4
    
    .byte $BD, $04, $04
    .byte $29, $20
    .byte $F0, $5F
        .byte $20, $AF, $B9
        .byte $B9, $19, $BA
        .byte $F0, $37
            .byte $BD, $0E, $04
            .byte $C9, $07
            .byte $F0, $04
                .byte $C9, $0A
                .byte $D0, $6F
            
            .byte $A5, $27
            .byte $29, $02
            .byte $D0, $69
            .byte $B9, $19, $BA
            .byte $18
            .byte $69, $10
            .byte $99, $19, $BA
            
            .byte $29, $70
            .byte $C9, $50
            .byte $D0, $5A
            
            .byte $A9, $02
            .byte $1D, $0F, $04
            .byte $9D, $0C, $04
            .byte $A9, $06
            .byte $9D, $60, $B4
            .byte $A9, $20
            .byte $9D, $0F, $04
            .byte $A9, $01
            .byte $9D, $0D, $04
        .byte $A9, $00
        .byte $9D, $04, $04
        .byte $99, $19, $BA
        .byte $9D, $06, $04
        .byte $9D, $07, $04
    
        .byte $BD, $6A, $B4
        .byte $20, $08, $BA
        .byte $9D, $02, $04
        .byte $BD, $6B, $B4
        .byte $20, $08, $BA
        .byte $9D, $03, $04
    ; check if metroid is latched onto Samus (again)
    .byte $20, $AF, $B9
    .byte $B9, $19, $BA
    .byte $D0, $1B
        .byte $BD, $04, $04
        .byte $29, $04
        .byte $F0, $46
        .byte $BD, $03, $04
        .byte $29, $80
        .byte $09, $01
        .byte $A8
        .byte $20, $BB, $B9
        .byte $20, $B5, $B9
        .byte $98
        .byte $9D, $19, $BA
        .byte $8A
        .byte $A8
    
    .byte $98
    .byte $AA
    .byte $BD, $19, $BA
    .byte $08
    .byte $29, $0F
    .byte $C9, $0C
    .byte $F0, $03
        .byte $FE, $19, $BA
    .byte $A8
    .byte $B9, $CF, $B9
    .byte $85, $04
    
    .byte $84, $05
    .byte $A9, $0C
    .byte $38
    .byte $E5, $05
    .byte $A6, $45
    
    .byte $28
    .byte $30, $03
        .byte $20, $BE, $B5
    .byte $85, $05
    .byte $20, $DC, $B9
    .byte $20, $27, $6C
    .byte $20, $EC, $B9
    .byte $4C, $5F, $B9
    
    ; clear latch
    .byte $20, $A6, $B9
    
    .byte $BD, $60, $B4
    .byte $C9, $03
    .byte $D0, $03
        .byte $20, $A6, $B9
    
    .byte $A0, $00
    
    .byte $AD, $19, $BA
    .byte $0D, $1A, $BA
    .byte $0D, $1B, $BA
    .byte $0D, $1C, $BA
    .byte $0D, $1D, $BA
    .byte $0D, $1E, $BA
    .byte $29, $0C
    .byte $C9, $0C
    .byte $D0, $13
        .byte $AD, $06, $01
        .byte $0D, $07, $01
        .byte $F0, $0B
            .byte $84, $69
            .byte $A0, $04
            .byte $84, $68
            .byte $20, $42, $6C
            .byte $A0, $01
    .byte $84, $8D
    .byte $A5, $65
    .byte $30, $07
        .byte $BD, $6E, $B4
        .byte $09, $A2
        .byte $85, $65
    .byte $4C, $DA, $B7
    
    .byte $20, $AF, $B9
    .byte $A9, $00
    .byte $99, $19, $BA
    .byte $60
    
    .byte $8A
    .byte $20, $13, $BB
    .byte $A8
    .byte $60
    
    .byte $8A
    .byte $20, $13, $BB
    .byte $AA
    .byte $60
    
    .byte $A9, $00
    .byte $9D, $02, $04
    .byte $9D, $03, $04
    .byte $9D, $07, $04
    .byte $9D, $06, $04
    .byte $9D, $6B, $B4
    .byte $9D, $6A, $B4
    .byte $60
    
    .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8
    
    .byte $AD, $0E, $03, $85
    .byte $09, $AD, $0D, $03, $85, $08, $AD, $0C, $03, $85, $0B, $60, $A5, $09, $9D, $01
    .byte $04, $A5, $08, $9D, $00, $04, $A5, $0B, $29, $01, $9D, $67, $B4, $60, $4A, $BD
    .byte $08, $04, $2A, $A8, $B9, $13, $BA, $60, $0A, $2A, $29, $01, $A8, $B9, $11, $BA
    .byte $60
    
    .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00
