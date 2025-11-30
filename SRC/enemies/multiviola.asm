MultiviolaAIRoutine:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne L9AE0
        ; enemy is active, set animation to active
        jsr CommonJump_InitEnActiveAnimIndex_NoL967BOffset
    L9AE0:
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02

