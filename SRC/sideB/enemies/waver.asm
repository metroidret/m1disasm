WaverAIRoutine:
    lda #$21
    sta $80
    lda #$1E
    sta $81
    lda $B460,x
    cmp #$03
    beq LB9EF
        jsr $6C1B
    LB9EF:
    jmp CommonEnemyStub2

