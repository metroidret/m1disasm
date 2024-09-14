RioRoutine:
    LDA $81
    CMP #$01
    BEQ RioExitC

    CMP #$03
    BEQ RioExitB

    LDA #$80
    STA EnData1A,X
    LDA EnData02,X ; y speed?
    BMI RioExitA

    LDA EnData05,X
    AND #$10
    BEQ RioExitA

    LDA EnYRoomPos,X
    SEC 
    SBC ObjectY ; Compare with Samus' Y position
    BPL RioBranch
        JSR TwosCompliment_
    RioBranch:
    CMP #$10
    BCS RioExitA
    LDA #$00
    STA EnData1A,X

RioExitA:
    LDA #$03
    JMP CommonJump_00

RioExitB:
    JMP CommonJump_02

RioExitC:
    LDA #$08
    JMP CommonJump_01