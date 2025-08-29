SidehopperFloorAIRoutine:
    lda #$09
Sidehopper_Common:
    sta $80
    sta $81
    lda $B460,x
    cmp #$03
    beq CommonEnemyStub2
        jsr $6C1B
CommonEnemyStub2: ;($B9C0)
    lda #$06
    sta $00
    lda #$08
    sta $01
    jmp CommonEnemyJump_00_01_02

SidehopperCeilingAIRoutine:
    lda #$0F
    jmp Sidehopper_Common

