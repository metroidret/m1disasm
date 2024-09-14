MultiviolaRoutine:
    LDA EnStatus,X
    CMP #$02
    BNE L9AE0
        JSR CommonJump_0A
    L9AE0:
    LDA #$02
    STA $00
    STA $01
    JMP CommonEnemyJump_00_01_02
