MultiviolaAIRoutine:
    lda EnStatus,x
    cmp #enemyStatus_Active
    bne L9AE0
        ; enemy is active, call CommonJump_0A
        jsr CommonJump_0A
    L9AE0:
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02
