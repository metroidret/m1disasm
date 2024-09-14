; Polyp Routine (mini volcano)
PolypRoutine:
    LDA #$00
    STA EnRadY,X
    STA EnRadX,X
    LDA #$10
    STA $0405,X
    .if BANK = 2
        TXA 
        ASL 
        ASL 
        STA $00
    .endif
    TXA 
    LSR 
    LSR 
    LSR 
    LSR 
    ADC $2D
    .if BANK = 2
        ADC $00
        AND #$47
    .elseif BANK = 5
        AND #$07
    .endif
    BNE PolypRTS
    LSR $0405,X
    LDA #$03
    STA $87
    LDA $2E
    LSR 
    ROL $0405,X
    AND #$03
    BEQ PolypRTS
    STA $88
    LDA #$02
    STA $85
    JMP CommonJump_0B

PolypRTS:
    RTS