RipperAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #$03
    beq @dontUpdateAnim
        jsr CommonJump_InitEnActiveAnimIndex_NoL967BOffset
    @dontUpdateAnim:
    jmp CommonEnemyStub2_{AREA}
