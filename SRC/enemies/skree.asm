; SkreeRoutine
SkreeAIRoutine:
    lda EnemyStatus81
    cmp #enemyStatus_Resting
    beq SkreeExitB
    cmp #enemyStatus_Explode
    beq SkreeExitC
    
    lda EnSpeedSubPixelY,x
    cmp #$0F
    bcc SkreeExitA
    cmp #$11
    bcs SkreeBlowUpIntoProjectiles
    lda #$3A
    sta EnData1D,x
    bne SkreeExitA

SkreeBlowUpIntoProjectiles:
    dec EnData1D,x
    bne SkreeExitA
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

SkreeExitA:
    lda #$02
    jmp CommonJump_00

SkreeExitB:
    lda #$08
    jmp CommonJump_01

SkreeExitC:
    jmp CommonJump_02
