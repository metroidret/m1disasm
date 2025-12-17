WaverAIRoutine_{AREA}:
    lda #$21
    sta $80
    lda #$1E
    sta $81
    lda EnsExtra.0.status,x
    cmp #$03
    beq @dontUpdateAnim
        jsr CommonJump_6C1B
    @dontUpdateAnim:
    jmp CommonEnemyStub2_{AREA}

