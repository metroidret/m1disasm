RioAIRoutine_{AREA}:
    ; branch if enemy is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq RioExit_Resting_{AREA}

    ; branch if enemy is exploding
    cmp #enemyStatus_Explode
    beq RioExit_Explode_{AREA}

    ; set gravity to negative #$80 (gravity pulls towards ceiling)
    lda #$80
    sta EnsExtra.0.accelY,x
    ; branch if y speed is negative
    lda Ens.0.speedY,x
    bmi RioExit_Active_{AREA}

    ; y speed is positive
    ; exit if bit 4 of Ens.0.data05 is unset
    lda Ens.0.data05,x
    and #$10
    beq RioExit_Active_{AREA}

    ; get Samus position relative to enemy
    lda Ens.0.y,x
    sec
    sbc Samus.y
    ; branch if Samus is under enemy
    bpl @endIf_A
        ; negate a
        jsr TwosComplement_
    @endIf_A:
    ; a now contains the y distance between Samus and the enemy
    ; branch if Samus is not within a block's distance 
    cmp #$10
    bcs RioExit_Active_{AREA}
    ; Samus is vertically aligned with the enemy
    ; stop applying gravity to enemy speed
    lda #$00
    sta EnsExtra.0.accelY,x

RioExit_Active_{AREA}:
    ; change animation frame every 3 frames
    lda #$03
    jmp CommonJump_UpdateEnemyCommon

RioExit_Explode_{AREA}:
    jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

RioExit_Resting_{AREA}:
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_UpdateEnemyCommon_noMove

