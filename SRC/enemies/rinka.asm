RinkaRoutine:
    LDY EnStatus,X
    CPY #$02
    BNE L9AB0
    DEY 
    CPY $81
    BNE L9AB0
    LDA #$00
    JSR L99D1
    STA $6AFC,X
    STA $6AFD,X
    LDA ObjectX
    SEC 
    SBC EnXRoomPos,X
    STA $01
    LDA $0405,X
    PHA 
    LSR 
    PHA 
    BCC L9A5A
        LDA #$00
        SBC $01
        STA $01
    L9A5A:
    LDA ObjectY
    SEC 
    SBC EnYRoomPos,X
    STA $00
    PLA 
    LSR 
    LSR 
    BCC L9A6E
        LDA #$00
        SBC $00
        STA $00
    L9A6E:
    LDA $00
    ORA $01
    LDY #$03
    L9A74:
        ASL 
        BCS L9A7A
        DEY 
        BNE L9A74
L9A7A:
    DEY 
    BMI L9A83
        LSR $00
        LSR $01
        BPL L9A7A
    L9A83:
    JSR L9AF9
    PLA 
    LSR 
    PHA 
    BCC L9A9B
        LDA #$00
        SBC $0407,X
        STA $0407,X
        LDA #$00
        SBC EnData03,X
        STA EnData03,X
    L9A9B:
    PLA 
    LSR 
    LSR 
    BCC L9AB0
    LDA #$00
    SBC $0406,X
    STA $0406,X
    LDA #$00
    SBC EnData02,X
    STA EnData02,X
L9AB0:
    LDA $0405,X
    ASL 
    BMI L9AF4
        LDA $0406,X
        CLC 
        ADC $6AFC,X
        STA $6AFC,X
        LDA EnData02,X
        ADC #$00
        STA $04
        LDA $0407,X
        CLC 
        ADC $6AFD,X
        STA $6AFD,X
        LDA EnData03,X
        ADC #$00
        STA $05
        LDA EnYRoomPos,X
        STA $08
        LDA EnXRoomPos,X
        STA $09
        LDA EnNameTable,X
        STA $0B
        JSR CommonJump_0D
        BCS L9AF1
            LDA #$00
            STA EnStatus,X
        L9AF1:
        JSR L99F4
    L9AF4:
    LDA #$08
    JMP CommonJump_01

L9AF9:
    LDA $00
    PHA 
    JSR Adiv16_
    STA EnData02,X
    PLA 
    JSR Amul16_
    STA $0406,X
    LDA $01
    PHA 
    JSR Adiv16_
    STA EnData03,X
    PLA 
    JSR Amul16_
    STA $0407,X
    RTS

    LSR 
Adiv16_:
    LSR 
    LSR 
    LSR 
    LSR 
    RTS

Amul16_:
    ASL 
    ASL 
    ASL 
    ASL 
    RTS