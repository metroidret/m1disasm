; Waver Routine
WaverAIRoutine:
    lda #EnAnim_21 - EnAnimTbl.b
    sta EnemyLFB88_85
    lda #EnAnim_1E - EnAnimTbl.b
    sta EnemyLFB88_85+1.b
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq L99F7
        jsr CommonJump_09
    L99F7:
    jmp CommonEnemyStub2
