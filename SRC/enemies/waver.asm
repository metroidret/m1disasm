; Waver Routine
WaverAIRoutine_{AREA}: ; 01:99E5
    lda #EnAnim_Waver2_R_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_Waver2_L_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @endIf_A
        jsr CommonJump_EnemyFlipAfterDisplacement
    @endIf_A: ; 01:99F7
    jmp CommonEnemyStub2_{AREA}

