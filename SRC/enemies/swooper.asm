; Swooper routine
SwooperAIRoutine00_{AREA}:
    ; change animation frame every 3 frames for active swooper
    lda #$03
    sta $00
    ; change animation frame every 8 frames for resting swooper
    lda #$08
    sta $01
    
    ; branch if swooper is not resting
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Resting
    bne @draw
    
    ; swooper is resting
    ; branch if bit 4 of EnData05 is clear
    lda EnData05,x
    and #$10
    beq @draw
        ; bit 4 of EnData05 is set
        ; swoop towards samus
        lda #$01
        jsr SwooperChangeEnemyType_{AREA}
@draw:
    jsr UpdateSwooperAnim_{AREA}
    jmp UpdateEnemyCommon_Decide_{AREA}

UpdateSwooperAnim_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne @RTS
    
    ; default to swooping animation
    .if BANK == 2
        lda #EnAnim_GerutaSwooping_{AREA} - EnAnimTable_{AREA}.b
    .elif BANK == 5
        lda #EnAnim_HoltzSwooping_{AREA} - EnAnimTable_{AREA}.b
    .endif
    ; branch if y speed is positive (swooper is swooping downwards)
    ldy EnSpeedY,x
    bpl @endIf_A
        ; swooper is not swooping downwards
        ; set animation to idle
        .if BANK == 2
            lda #EnAnim_GerutaIdle_{AREA} - EnAnimTable_{AREA}.b
        .elif BANK == 5
            lda #EnAnim_HoltzIdle_{AREA} - EnAnimTable_{AREA}.b
        .endif
    @endIf_A:
    sta EnsExtra.0.resetAnimIndex,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Swooper Routine 2?
; similar code to RioAIRoutine
SwooperAIRoutine01_{AREA}:
    ; exit if previous status is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SwooperExit_Resting_{AREA}
    
    ; exit if previous status is explode
    cmp #enemyStatus_Explode
    beq SwooperExit_Explode_{AREA}
    
    ; branch if current status is not resting
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Resting
    bne L9923_{AREA}
        ; status changed from active to resting
        ; swoop straight down
        lda #$00
        jsr SwooperChangeEnemyType_{AREA}

SwooperExit_Resting_{AREA}:
    ; change animation frame every 8 frames for resting swooper
    lda #$08
    jmp CommonJump_UpdateEnemyCommon_noMove


L9923_{AREA}:
    ; set gravity to negative #$80 (gravity pulls towards ceiling)
    lda #$80
    sta EnsExtra.0.accelY,x
    ; branch if y speed is negative (swooper is moving upwards)
    lda EnSpeedY,x
    bmi @endIf_A
    
    ; branch if bit 4 of EnData05 is clear
    lda EnData05,x
    and #$10
    beq @endIf_A
    
    ; get position relative to samus
    lda EnY,x
    sec
    sbc Samus.y
    ; branch if swooper is under samus
    bpl @endIf_B
        ; swooper is above samus
        ; negate relative position
        jsr TwosComplement_
    @endIf_B:
    ; now a contains the distance between samus and swooper on the y axis
    ; branch if Samus is not within a block's distance
    cmp #$10
    bcs @endIf_A
        ; Samus is vertically aligned with the enemy
        ; stop applying gravity to enemy speed
        lda #$00
        sta EnsExtra.0.accelY,x
@endIf_A:
    jsr UpdateSwooperAnim_{AREA}
    ; change animation frame every 3 frames for active swooper
    lda #$03
    jmp CommonJump_UpdateEnemyCommon

SwooperExit_Explode_{AREA}:
    jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

SwooperChangeEnemyType_{AREA}:
    ; set enemy type (either #$00 or #$01)
    sta EnsExtra.0.type,x
    
    ; push current health
    lda EnHealth,x
    pha
    ; initialize new enemy type's properties
    ; this triggers a swoop downwards, either straight down or towards samus
    jsr CommonJump_0E
    ; restore current health
    pla
    sta EnHealth,x
    rts

