; Waver Routine
WaverRoutine:
    LDA #$21
    STA $85
    LDA #$1E
    STA $86
    LDA EnStatus,X
    CMP #$03
    BEQ L99F7
        JSR CommonJump_09
    L99F7:
    JMP CommonEnemyStub2
