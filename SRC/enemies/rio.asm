RioAIRoutine:
    ; branch if enemy is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq RioExit_Resting

    ; branch if enemy is exploding
    cmp #enemyStatus_Explode
    beq RioExit_Explode

    ; set gravity to negative #$80 (gravity pulls towards ceiling)
    lda #$80
    sta EnsExtra.0.accelY,x
    ; branch if y speed is negative
    lda EnSpeedY,x
    bmi RioExitA

    ; y speed is positive
    ; exit if bit 4 of EnData05 is unset
    lda EnData05,x
    and #$10
    beq RioExitA

    ; get Samus position relative to enemy
    lda EnY,x
    sec
    sbc ObjY
    ; branch if Samus is under enemy
    bpl RioBranch
        ; negate a
        jsr TwosComplement_
    RioBranch:
    ; a now contains the y distance between Samus and the enemy
    ; branch if Samus is not within a block's distance 
    cmp #$10
    bcs RioExitA
    ; Samus is vertically aligned with the enemy
    ; stop applying gravity to enemy speed
    lda #$00
    sta EnsExtra.0.accelY,x

RioExitA:
    ; change animation frame every 3 frames
    lda #$03
    jmp CommonJump_00

RioExit_Explode:
    jmp CommonJump_02

RioExit_Resting:
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_01

