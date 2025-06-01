; SkreeRoutine
SkreeAIRoutine:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SkreeExit_Resting
    cmp #enemyStatus_Explode
    beq SkreeExit_Explode
    
    lda EnSpeedSubPixelY,x
    cmp #$0F
    bcc SkreeExit_Active
    cmp #$11
    bcs SkreeBlowUpIntoProjectiles
    lda #$3A
    sta EnData1D,x
    bne SkreeExit_Active

SkreeBlowUpIntoProjectiles:
    dec EnData1D,x
    bne SkreeExit_Active
    lda #enemyStatus_NoEnemy
    sta EnStatus,x
    ldy #(4-1)*4
    SkreeLoop:
        lda #$0A ; projectile is alive for 10 frames
        sta SkreeProjectileDieDelay,y
        lda EnY,x
        sta SkreeProjectileY,y
        lda EnX,x
        sta SkreeProjectileX,y
        lda EnHi,x
        sta SkreeProjectileHi,y
        dey
        dey
        dey
        dey
        bpl SkreeLoop

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
