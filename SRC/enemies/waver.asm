; Waver Routine
WaverAIRoutine:
    lda #$21
    sta EnemyLFB88_85
    lda #$1E
    sta EnemyLFB88_85+1
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq L99F7
        jsr CommonJump_09
    L99F7:
    jmp CommonEnemyStub2
