; Waver Routine
WaverAIRoutine:
    lda #EnAnim_21 - EnAnimTbl.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_1E - EnAnimTbl.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq L99F7
        jsr CommonJump_EnemyFlipAfterDisplacement
    L99F7:
    jmp CommonEnemyStub2

