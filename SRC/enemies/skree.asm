; SkreeRoutine
SkreeAIRoutine:
    ; skree uses EnemyDistanceToSamusThreshold to see if samus is close enough on the x axis to start falling
    ; when samus gets close enough, bit 3 of EnData05 will get set, which will make the skree active
    
    ; branch if enemy is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SkreeExit_Resting
    ; branch if enemy is exploding
    cmp #enemyStatus_Explode
    beq SkreeExit_Explode
    
    ; branch if skree has not reached the ground
    lda EnMovementInstrIndex,x
    cmp #$0F
    bcc SkreeExit_Active
    ; branch if skree was on the ground for more than 1 frame
    cmp #$11
    bcs SkreeBlowUpIntoProjectiles
    ; skree just landed on the ground
    ; set blow up delay to roughly 1 second
    lda #$3A
    sta EnJumpDsplcmnt,x
    bne SkreeExit_Active

SkreeBlowUpIntoProjectiles:
    ; decrement blow up delay
    dec EnJumpDsplcmnt,x
    ; exit if delay is not zero
    bne SkreeExit_Active

    ; remove skree
    lda #enemyStatus_NoEnemy
    sta EnStatus,x
    ; spawn 4 projectiles
    ldy #(4-1)*4
    @loop:
        ; projectile is alive for 10 frames
        lda #$0A
        sta SkreeProjectileDieDelay,y
        ; set projectile position to skree position
        lda EnY,x
        sta SkreeProjectileY,y
        lda EnX,x
        sta SkreeProjectileX,y
        lda EnHi,x
        sta SkreeProjectileHi,y
        ; move to next projectile slot
        dey
        dey
        dey
        dey
        bpl @loop

SkreeExit_Active:
    ; skree is active
    ; change animation frame every 2 frames
    lda #$02
    jmp CommonJump_00

SkreeExit_Resting:
    ; skree is resting (hanging on the ceiling)
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_01

SkreeExit_Explode:
    ; skree is exploding
    jmp CommonJump_02

