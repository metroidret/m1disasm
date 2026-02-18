MultiviolaAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne @dontUpdateAnim
        ; enemy is active, set animation to active
        jsr CommonJump_InitEnActiveAnimIndex_NoL967BOffset
    @dontUpdateAnim:
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

