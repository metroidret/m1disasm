; Waver Routine
WaverAIRoutine:
    lda #EnAnim_Waver2_R - EnAnimTable.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_Waver2_L - EnAnimTable.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq L99F7
        jsr CommonJump_EnemyFlipAfterDisplacement
    L99F7:
    jmp CommonEnemyStub2

