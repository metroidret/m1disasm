; Sidehopper Routine
; Bank 5 is Dessgeega
SidehopperFloorRoutine:
    .if BANK = 1 || BANK = 4
        LDA #$09
    .elseif BANK = 5
        LDA #$42
    .endif
Sidehopper_Common:
    STA $85
    STA $86
    LDA EnStatus,X
    CMP #$03
    BEQ CommonEnemyStub2
        JSR CommonJump_09
CommonEnemyStub2:
    LDA #$06
    STA $00
CommonEnemyStub:
    LDA #$08
    STA $01
    JMP CommonEnemyJump_00_01_02

; Ceiling Sidehopper Routine
SidehopperCeilingRoutine:
    .if BANK = 1 || BANK = 4
        LDA #$0F
    .elseif BANK = 5
        LDA #$48
    .endif
    JMP Sidehopper_Common