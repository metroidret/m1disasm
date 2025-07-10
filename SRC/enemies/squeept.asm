; Lava Jumper Routine
SqueeptAIRoutine:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    bne L9A88
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq L9ACA
    cmp #enemyStatus_Active
    bne L9A88
    ldy EnMovementIndex,x
    lda L9AD2,y
    sta EnSpeedY,x
    lda #$40
    sta EnAccelY,x
    lda #$00
    sta EnSpeedSubPixelY,x
L9A88:
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq L9ACA
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq L9ACA
    cmp #enemyStatus_Explode
    beq L9ACF
    jsr CommonJump_12
    ldx PageIndex
    lda #$00
    sta $05
    lda #$1D
    ldy $00
    sty $04
    bmi L9AAC
        lda #$20
    L9AAC:
    sta EnResetAnimIndex,x
    jsr StorePositionToTemp
    jsr CommonJump_ApplySpeedToPosition
    lda #$E8
    bcc L9ABD
        cmp $08
        bcs L9AC7
    L9ABD:
    sta $08
    lda EnData05,x
    ora #$20
    sta EnData05,x
L9AC7:
    jsr LoadPositionFromTemp
L9ACA:
    lda #$02
    jmp CommonJump_01

L9ACF:
    jmp CommonJump_02

L9AD2:
    .byte $F6, $F8, $F6, $FA
