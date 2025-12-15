; Waver Routine
WaverAIRoutine_BANK{BANK}:
    lda #EnAnim_Waver2_R_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_Waver2_L_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @endIf_A
        jsr CommonJump_EnemyFlipAfterDisplacement
    @endIf_A:
    jmp CommonEnemyStub2_BANK{BANK}

