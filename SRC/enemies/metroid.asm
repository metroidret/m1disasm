MetroidRoutine:
    LDY $010B
    INY 
    BEQ L9804
        LDA #$00
        STA EnStatus,X
    L9804:
    LDA #$0F
    STA $00
    STA $01
    LDA $0405,X
    ASL 
    BMI CommonEnemyJump_00_01_02
    LDA EnStatus,X
    CMP #$03
    BEQ CommonEnemyJump_00_01_02
    JSR L99B7
    LDA $77F8,Y
    BEQ L9822
        JMP L9899

    L9822:
    LDY $0408,X
    LDA $77F6,Y
    PHA 
    LDA EnData02,X
    BPL L983B
        PLA 
        JSR TwosCompliment_
        PHA 
        LDA #$00
        CMP $0406,X
        SBC EnData02,X
    L983B:
    CMP $77F6,Y
    PLA 
    BCC L9849
        STA EnData02,X
        LDA #$00
        STA $0406,X
    L9849:
    LDA $77F6,Y
    PHA 
    LDA EnData03,X
    BPL L985F
        PLA 
        JSR TwosCompliment_
        PHA 
        LDA #$00
        CMP $0407,X
        SBC EnData03,X
    L985F:
    CMP $77F6,Y
    PLA 
    BCC L986D
        STA EnData03,X
        LDA #$00
        STA $0407,X
    L986D:
    LDA $0405,X
    PHA 
    JSR L9A06
    STA $6AFF,X
    PLA 
    LSR 
    LSR 
    JSR L9A06
    STA $6AFE,X
    LDA EnStatus,X
    CMP #$04
    BNE L9894
        LDY $040B,X
        INY 
        BNE L9899
        LDA #$05
        STA $040B,X
        BNE L9899
    L9894:
    LDA #$FF
    STA $040B,X
L9899:
    LDA $81
    CMP #$06
    BNE L98A9
    CMP EnStatus,X
    BEQ L98A9
    LDA #$04
    STA EnStatus,X
L98A9:
    LDA $0404,X
    AND #$20
    BEQ L990F
        JSR L99B7
        LDA $77F8,Y
        BEQ L98EF
            LDA $040E,X
            CMP #$07
            BEQ L98C3
                CMP #$0A
                BNE L9932
            L98C3:
            LDA $2D
            AND #$02
            BNE L9932
            LDA $77F8,Y
            CLC 
            ADC #$10
            STA $77F8,Y
            AND #$70
            CMP #$50
            BNE L9932
            LDA #$02
            ORA $040F,X
            STA $040C,X
            LDA #$06
            STA EnStatus,X
            LDA #$20
            STA $040F,X
            LDA #$01
            STA $040D,X
        L98EF:
        LDA #$00
        STA $0404,X
        STA $77F8,Y
        STA $0406,X
        STA $0407,X
        LDA $6AFE,X
        JSR L9A10
        STA EnData02,X
        LDA $6AFF,X
        JSR L9A10
        STA EnData03,X
    L990F:
    JSR L99B7
    LDA $77F8,Y
    BNE L9932
    LDA $0404,X
    AND #$04
    BEQ L9964
    LDA EnData03,X
    AND #$80
    ORA #$01
    TAY 
    JSR L99C3
    JSR L99BD
    TYA 
    STA $77F8,X
    TXA 
    TAY 
L9932:
    TYA 
    TAX 
    LDA $77F8,X
    PHP 
    AND #$0F
    CMP #$0C
    BEQ L9941
        INC $77F8,X
    L9941:
    TAY 
    LDA L99D7,Y
    STA $04
    STY $05
    LDA #$0C
    SEC 
    SBC $05
    LDX $4B
    PLP 
    BMI L9956
        JSR TwosCompliment_
    L9956:
    STA $05
    JSR L99E4
    JSR CommonJump_0D
    JSR L99F4
    JMP L9967

L9964:
    JSR L99AE
L9967:
    LDA EnStatus,X
    CMP #$03
    BNE L9971
        JSR L99AE
    L9971:
    LDY #$00
    LDA $77F8
    ORA $77F9
    ORA $77FA
    ORA $77FB
    ORA $77FC
    ORA $77FD
    AND #$0C
    CMP #$0C
    BNE L999E
    LDA $0106
    ORA $0107
    BEQ L999E
    STY $6F
    LDY #$04
    STY $6E
    JSR CommonJump_SubtractHealth
    LDY #$01
L999E:
    STY $92
    LDA $6B
    BMI L99AB
        LDA $6B02,X
        ORA #$A2
        STA $6B
    L99AB:
    JMP CommonEnemyJump_00_01_02

L99AE:
    JSR L99B7
MetroidRoutine_L99B1:
    LDA #$00
    STA $77F8,Y
    RTS

L99B7:
    TXA 
    JSR Adiv16_
    TAY 
    RTS

L99BD:
    TXA 
    JSR Adiv16_
    TAX 
    RTS

L99C3:
    LDA #$00
    STA EnData02,X
    STA EnData03,X
    STA $0407,X
    STA $0406,X
L99D1:
    STA $6AFF,X
    STA $6AFE,X
L99D7:
    RTS

    .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8
 
L99E4:
    LDA ObjectX
    STA $09
    LDA ObjectY
    STA $08
    LDA $030C
    STA $0B
    RTS

L99F4:
    LDA $09
    STA EnXRoomPos,X
    LDA $08
    STA EnYRoomPos,X
    LDA $0B
    AND #$01
    STA EnNameTable,X
    RTS

L9A06:
    LSR 
    LDA $0408,X
    ROL 
    TAY 
    LDA $77F2,Y
    RTS

L9A10:
    ASL 
    ROL 
    AND #$01
    TAY 
    LDA $77F0,Y
    RTS

    .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00