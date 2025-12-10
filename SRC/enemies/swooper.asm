; Swooper routine
SwooperAIRoutine00_BANK{BANK}:
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
        jsr SwooperChangeEnemyType
@draw:
    jsr UpdateSwooperAnim_BANK{BANK}
    jmp CommonEnemyJump_00_01_02

UpdateSwooperAnim_BANK{BANK}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne @RTS
    
    ; default to swooping animation
    .if BANK == 2
        lda #EnAnim_GerutaSwooping - EnAnimTable.b
    .elif BANK == 5
        lda #EnAnim_HoltzSwooping - EnAnimTable.b
    .endif
    ; branch if y speed is positive (swooper is swooping downwards)
    ldy EnSpeedY,x
    bpl @endIf_A
        ; swooper is not swooping downwards
        ; set animation to idle
        .if BANK == 2
            lda #EnAnim_GerutaIdle - EnAnimTable.b
        .elif BANK == 5
            lda #EnAnim_HoltzIdle - EnAnimTable.b
        .endif
    @endIf_A:
    sta EnsExtra.0.resetAnimIndex,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Swooper Routine 2?
; similar code to RioAIRoutine
SwooperAIRoutine01_BANK{BANK}:
    ; exit if previous status is resting
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SwooperExit_Resting_BANK{BANK}
    
    ; exit if previous status is explode
    cmp #enemyStatus_Explode
    beq SwooperExit_Explode_BANK{BANK}
    
    ; branch if current status is not resting
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Resting
    bne L9923_BANK{BANK}
        ; status changed from active to resting
        ; swoop straight down
        lda #$00
        jsr SwooperChangeEnemyType

SwooperExit_Resting_BANK{BANK}:
    ; change animation frame every 8 frames for resting swooper
    lda #$08
    jmp CommonJump_01


L9923_BANK{BANK}:
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
    sbc ObjY
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
    jsr UpdateSwooperAnim
    ; change animation frame every 3 frames for active swooper
    lda #$03
    jmp CommonJump_00

SwooperExit_Explode_BANK{BANK}:
    jmp CommonJump_02

SwooperChangeEnemyType_BANK{BANK}:
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

