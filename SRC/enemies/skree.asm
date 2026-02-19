; SkreeRoutine
SkreeAIRoutine_{AREA}:
    ; skree uses EnemyDistanceToSamusThreshold to see if samus is close enough on the x axis to start falling
    ; when samus gets close enough, bit 3 of EnData05 will get set, which will make the skree active
    
    ; branch if enemy is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SkreeExit_Resting_{AREA}
    ; branch if enemy is exploding
    cmp #enemyStatus_Explode
    beq SkreeExit_Explode_{AREA}
    
    ; branch if skree has not reached the ground
    lda Ens.0.movementInstrIndex,x
    cmp #$0F
    bcc SkreeExit_Active_{AREA}
    ; branch if skree was on the ground for more than 1 frame
    cmp #$11
    bcs SkreeBlowUpIntoProjectiles_{AREA}
    ; skree just landed on the ground
    ; set blow up delay to roughly 1 second
    lda #$3A
    sta EnsExtra.0.jumpDsplcmnt,x
    bne SkreeExit_Active_{AREA}

SkreeBlowUpIntoProjectiles_{AREA}:
    ; decrement blow up delay
    dec EnsExtra.0.jumpDsplcmnt,x
    ; exit if delay is not zero
    bne SkreeExit_Active_{AREA}

    ; remove skree
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    ; spawn 4 projectiles
    ldy #(4-1)*4
    @loop:
        ; projectile is alive for 10 frames
        lda #$0A
        sta SkreeProjectiles.0.dieDelay,y
        ; set projectile position to skree position
        lda Ens.0.y,x
        sta SkreeProjectiles.0.y,y
        lda Ens.0.x,x
        sta SkreeProjectiles.0.x,y
        lda EnsExtra.0.hi,x
        sta SkreeProjectiles.0.hi,y
        ; move to next projectile slot
        dey
        dey
        dey
        dey
        bpl @loop

SkreeExit_Active_{AREA}:
    ; skree is active
    ; change animation frame every 2 frames
    lda #$02
    jmp CommonJump_UpdateEnemyCommon

SkreeExit_Resting_{AREA}:
    ; skree is resting (hanging on the ceiling)
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_UpdateEnemyCommon_noMove

SkreeExit_Explode_{AREA}:
    ; skree is exploding
    jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

