; SkreeRoutine
SkreeRoutine:
    LDA $81
    CMP #$01
    BEQ SkreeExitB
    CMP #$03
    BEQ SkreeExitC
    LDA EnCounter,X
    CMP #$0F
    BCC SkreeExitA
    CMP #$11
    BCS SkreeBranch
    LDA #$3A
    STA EnData1D,X
    BNE SkreeExitA

SkreeBranch:
    DEC EnData1D,X
    BNE SkreeExitA
    LDA #$00
    STA EnStatus,X
    LDY #$0C

SkreeLoop:
    LDA #$0A
    STA $A0,Y
    LDA EnYRoomPos,X
    STA $A1,Y
    LDA EnXRoomPos,X
    STA $A2,Y
    LDA EnNameTable,X
    STA $A3,Y
    DEY 
    DEY 
    DEY 
    DEY 
    BPL SkreeLoop

SkreeExitA:
    LDA #$02
    JMP CommonJump_00

SkreeExitB:
    LDA #$08
    JMP CommonJump_01

SkreeExitC:
    JMP CommonJump_02