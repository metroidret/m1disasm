; Lava Jumper Routine
SqueeptAIRoutine_{AREA}:
    ; branch if previous status is not resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    bne @endIf_A
    
    ; previous status is resting
    ; exit if current status is explode
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq SqueeptExit_Resting_{AREA}
    
    ; branch if current status is not active
    cmp #enemyStatus_Active
    bne @endIf_A
        ; status changed from resting to active
        ; squeept must jump
        
        ; set initial jump velocity
        ldy EnMovementIndex,x
        lda SqueeptSpeedYTable_{AREA},y
        sta EnSpeedY,x
        ; set jump gravity
        lda #$40
        sta EnsExtra.0.accelY,x
        ; clear sub-pixel speed
        lda #$00
        sta EnSpeedSubPixelY,x
@endIf_A:
    ; exit if current status is explode
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq SqueeptExit_Resting_{AREA}
    
    ; exit if previous status is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SqueeptExit_Resting_{AREA}
    
    ; exit if previous status is explode (this is redundant, right?)
    cmp #enemyStatus_Explode
    beq SqueeptExit_Explode_{AREA}
    
    ; make squeept move in their jump trajectory
    ; apply gravity to y speed and get delta y
    jsr CommonJump_EnemyGetDeltaY_UsingAcceleration
    
    ldx PageIndex
    ; set x speed to 0
    lda #$00
    sta Temp05_SpeedX
    
    ; default to jumping animation
    lda #EnAnim_SqueeptJumping_{AREA} - EnAnimTable_{AREA}.b
    ; set y speed to delta y
    ldy $00
    sty Temp04_SpeedY
    ; branch if delta y is negative (squeept is rising)
    bmi @endIf_B
        ; delta y is not negative (squeept is falling)
        ; use falling animation
        lda #EnAnim_SqueeptFalling_{AREA} - EnAnimTable_{AREA}.b
    @endIf_B:
    sta EnsExtra.0.resetAnimIndex,x
    
    ; apply speed
    jsr StoreEnemyPositionToTemp__{AREA}
    jsr CommonJump_ApplySpeedToPosition
    
    ; load lava y position
    lda #$E8
    ; branch if squeept moved out of bounds
    bcc @then_C
        ; compare new position with lava level
        cmp Temp08_PositionY
        ; branch if position is above lava
        bcs @endIf_C
        ; fallthrough
    @then_C:
        ; squeept y position is below lava or out of bounds
        ; set squeept y position to lava y position
        sta Temp08_PositionY
        ; trigger status change of squeept to resting
        lda EnData05,x
        ora #$20
        sta EnData05,x
    @endIf_C:
    jsr LoadEnemyPositionFromTemp__{AREA}

SqueeptExit_Resting_{AREA}:
    ; squeept is resting (jumping and falling)
    ; change animation frame every 2 frames
    lda #$02
    jmp CommonJump_UpdateEnemyCommon_noMove

SqueeptExit_Explode_{AREA}:
    ; squeept is exploding
    jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

SqueeptSpeedYTable_{AREA}:
    .byte $F6, $F8, $F6, $FA

