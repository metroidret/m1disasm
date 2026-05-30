SidehopperFloorAIRoutine_{AREA}:
    lda #$09
Sidehopper_Common_{AREA}:
    sta $80
    sta $81
    lda EnsExtra.0.status,x
    cmp #$03
    beq CommonEnemyStub2_{AREA}
        jsr CommonJump_EnemyFlipAfterDisplacement
CommonEnemyStub2_{AREA}:
    lda #$06
    sta $00
    lda #$08
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

SidehopperCeilingAIRoutine_{AREA}:
    lda #$0F
    jmp Sidehopper_Common_{AREA}

