; Lava Jumper Routine
SqueeptRoutine:
    LDA $81
    CMP #$01
    BNE L9A88
    LDA EnStatus,X
    CMP #$03
    BEQ L9ACA
    CMP #$02
    BNE L9A88
    LDY $0408,X
    LDA L9AD2,Y
    STA $0402,X
    LDA #$40
    STA $6AFE,X
    LDA #$00
    STA $0406,X
L9A88:
    LDA EnStatus,X
    CMP #$03
    BEQ L9ACA
    LDA $81
    CMP #$01
    BEQ L9ACA
    CMP #$03
    BEQ L9ACF
    JSR CommonJump_12
    LDX $4B
    LDA #$00
    STA $05
    LDA #$1D
    LDY $00
    STY $04
    BMI L9AAC
        LDA #$20
    L9AAC:
    STA $6AF9,X
    JSR StorePositionToTemp
    JSR CommonJump_0D
    LDA #$E8
    BCC L9ABD
        CMP $08
        BCS L9AC7
    L9ABD:
    STA $08
    LDA $0405,X
    ORA #$20
    STA $0405,X
L9AC7:
    JSR LoadPositionFromTemp
L9ACA:
    LDA #$02
    JMP CommonJump_01

L9ACF:
    JMP CommonJump_02

L9AD2:
    INC $F8,X
    INC $FA,X