; Swooper routine
SwooperRoutine:
    LDA #$03
    STA $00
    LDA #$08
    STA $01
    LDA EnStatus,X
    CMP #$01
    BNE L98EE
    LDA $0405,X
    AND #$10
    BEQ L98EE
    LDA #$01
    JSR L9954
L98EE:
    JSR L98F4
    JMP CommonEnemyJump_00_01_02
L98F4:
    LDA EnStatus,X
    CMP #$02
    BNE L9907
    .if BANK = 2
        LDA #$25
    .elseif BANK = 5
        LDA #$20
    .endif
    LDY $0402,X
    BPL L9904
        .if BANK = 2
            LDA #$22
        .elseif BANK = 5
            LDA #$1D
        .endif
    L9904:
    STA EnResetAnimIndex,X
L9907:
    RTS

;-------------------------------------------------------------------------------
; Swooper Routine 2?
SwooperRoutine2:
    LDA $81
    CMP #$01
    BEQ SwooperExitA
        CMP #$03
        BEQ SwooperExitB
        LDA EnStatus,X
        CMP #$01
        BNE L9923
        LDA #$00
        JSR L9954
    SwooperExitA:
    LDA #$08
    JMP CommonJump_01

L9923:
    LDA #$80
    STA EnData1A,X
    LDA $0402,X
    BMI L9949
    LDA $0405,X
    AND #$10
    BEQ L9949
    LDA $0400,X
    SEC 
    SBC $030D
    BPL L9940
        JSR TwosCompliment_
    L9940:
    CMP #$10
    BCS L9949
    LDA #$00
    STA EnData1A,X
L9949:
    JSR L98F4
    LDA #$03
    JMP CommonJump_00

SwooperExitB:
    JMP CommonJump_02

L9954:
    STA EnDataIndex,X
    LDA $040B,X
    PHA 
    JSR CommonJump_0E
    PLA 
    STA $040B,X
    RTS
