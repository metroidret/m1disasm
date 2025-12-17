; Pipe Bug AI Handler

PipeBugAIRoutine_{AREA}:
    .byte $BD, $60, $B4
    .byte $C9, $02
    .byte $D0, $38
    
    .byte $BD, $03, $04
    .byte $D0, $33
    
    .byte $BD, $6A, $B4
    .byte $D0, $12
    
    .byte $AD, $0D, $03
    .byte $38
    .byte $FD, $00, $04
    .byte $C9, $40
    .byte $B0, $23
    
    .byte $A9, $7F
    .byte $9D, $6A, $B4
    .byte $D0, $1C

@checkIfGoForwards:
    .byte $BD, $02, $04
    .byte $30, $17
    .byte $A9, $00
    .byte $9D, $02, $04
    .byte $9D, $06, $04
    .byte $9D, $6A, $B4
    .byte $BD, $05, $04
    .byte $29, $01
    .byte $A8
    .byte $B9, $98, $BB
    .byte $9D, $03, $04
@applySpeed:
    .byte $BD, $05, $04
    .byte $0A
    .byte $30, $1E
    
    .byte $BD, $60, $B4
    .byte $C9, $02
    .byte $D0, $17
    
    .byte $20, $36, $6C
    .byte $48
    .byte $20, $39, $6C
    .byte $85, $05
    .byte $68
    .byte $85, $04
    
    .byte $20, $A0, $BC
    .byte $20, $27, $6C
    .byte $90, $08
    .byte $20, $8E, $BC

@exit:
    .byte $A9, $03
    .byte $4C, $03, $6C

@delete:
    .byte $A9, $00
    .byte $9D, $60, $B4
    .byte $60

@speedXTable:
    .byte $04, $FC

