; Lava Seahorse Routine
SeahorseRoutine:
    LDA EnStatus,X
    CMP #$01
    BNE L9AF5
        LDA #$E8
        STA $0400,X
    L9AF5:
    CMP #$02
    BNE L9B4F
    LDA $0406,X
    BEQ L9B4F
    LDA $6B01,X
    BNE L9B4F
    LDA $2D
    AND #$1F
    BNE L9B3C
        LDA $2E
        AND #$03
        BEQ L9B59
        LDA #$02
        STA $87
        LDA #$00
        STA $88
        LDA #$43
        STA $83
        LDA #$47
        STA $84
        LDA #$03
        STA $85
        JSR CommonJump_0B
        LDA $0680
        ORA #$04
        STA $0680
        LDA $0405,X
        AND #$01
        TAY 
        LDA $0083,Y
        JSR CommonJump_05
        BEQ L9B59
    L9B3C:
    CMP #$0F
    BCC L9B59
    LDA $0405,X
    AND #$01
    TAY 
    LDA SeahorseTable,Y
    JSR CommonJump_05
    JMP L9B59

L9B4F:
    LDA EnStatus,X
    CMP #$03
    BEQ L9B59
    JSR CommonJump_0A
L9B59:
    LDA #$01
    STA $00
    STA $01
    JMP CommonEnemyJump_00_01_02

; probably animation frame id table
SeahorseTable:
    .byte $45, $49