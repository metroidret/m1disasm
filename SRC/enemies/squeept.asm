; Lava Jumper Routine
SqueeptAIRoutine:
    ; branch if previous status is not resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    bne L9A88
    
    ; previous status is resting
    ; exit if current status is explode
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq SqueeptExit_Resting
    
    ; branch if current status is not active
    cmp #enemyStatus_Active
    bne L9A88
        ; status changed from resting to active
        ; squeept must jump
        
        ; set initial jump velocity
        ldy EnMovementIndex,x
        lda SqueeptSpeedYTable,y
        sta EnSpeedY,x
        ; set jump gravity
        lda #$40
        sta EnsExtra.0.accelY,x
        ; clear sub-pixel speed
        lda #$00
        sta EnSpeedSubPixelY,x
L9A88:
    ; exit if current status is explode
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq SqueeptExit_Resting
    
    ; exit if previous status is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SqueeptExit_Resting
    
    ; exit if previous status is explode (this is redundant, right?)
    cmp #enemyStatus_Explode
    beq SqueeptExit_Explode
    
    ; make squeept move in their jump trajectory
    ; apply gravity to y speed and get delta y
    jsr CommonJump_EnemyGetDeltaY_UsingAcceleration
    
    ldx PageIndex
    ; set x speed to 0
    lda #$00
    sta Temp05_SpeedX
    
    ; default to jumping animation
    lda #EnAnim_SqueeptJumping - EnAnimTbl.b
    ; set y speed to delta y
    ldy $00
    sty Temp04_SpeedY
    ; branch if delta y is negative (squeept is rising)
    bmi L9AAC
        ; delta y is not negative (squeept is falling)
        ; use falling animation
        lda #EnAnim_SqueeptFalling - EnAnimTbl.b
    L9AAC:
    sta EnsExtra.0.resetAnimIndex,x
    
    ; apply speed
    jsr StorePositionToTemp
    jsr CommonJump_ApplySpeedToPosition
    
    ; load lava y position
    lda #$E8
    ; branch if squeept moved out of bounds
    bcc L9ABD
    
    ; compare new position with lava level
    cmp Temp08_PositionY
    ; branch if position is above lava
    bcs L9AC7
    L9ABD:
        ; squeept y position is below lava or out of bounds
        ; set squeept y position to lava y position
        sta Temp08_PositionY
        ; trigger status change of squeept to resting
        lda EnData05,x
        ora #$20
        sta EnData05,x
    L9AC7:
    jsr LoadPositionFromTemp

SqueeptExit_Resting:
    ; squeept is resting (jumping and falling)
    ; change animation frame every 2 frames
    lda #$02
    jmp CommonJump_01

SqueeptExit_Explode:
    ; squeept is exploding
    jmp CommonJump_02

SqueeptSpeedYTable:
    .byte $F6, $F8, $F6, $FA

