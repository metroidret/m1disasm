RioAIRoutine:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq RioExitC

    cmp #enemyStatus_Explode
    beq RioExitB

    lda #$80
    sta EnAccelY,x
    lda EnSpeedY,x ; y speed?
    bmi RioExitA

    lda EnData05,x
    and #$10
    beq RioExitA

    lda EnY,x
    sec
    sbc ObjY ; Compare with Samus' Y position
    bpl RioBranch
        jsr TwosComplement_
    RioBranch:
    cmp #$10
    bcs RioExitA
    lda #$00
    sta EnAccelY,x

RioExitA:
    lda #$03
    jmp CommonJump_00

RioExitB:
    jmp CommonJump_02

RioExitC:
    lda #$08
    jmp CommonJump_01
