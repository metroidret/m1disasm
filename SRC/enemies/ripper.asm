; RipperRoutine
RipperRoutine:
    LDA EnStatus,X
    CMP #$03
    BEQ Ripper01
        JSR CommonJump_0A
    Ripper01:
    .if BANK = 1 || BANK = 4
        JMP CommonEnemyStub2
    .elseif BANK = 2
        LDA #$03
        STA $00
        STA $01
        JMP CommonEnemyJump_00_01_02
    .endif