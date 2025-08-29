RipperAIRoutine:
    lda $B460,x
    cmp #$03
    beq LB9DA
        jsr $6C1E
    LB9DA:
    jmp CommonEnemyStub2
