; Pipe Bug AI Handler

PipeBugAIRoutine:
    ; branch if pipe bug is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne PipeBugApplySpeed

    ; if pipe bug is going forward, apply speed
    lda EnSpeedX,x
    bne PipeBugApplySpeed

    ; if EnsExtra.0.accelY is in effect, we need to check if y speed became positive
    lda EnsExtra.0.accelY,x
    bne PipeBugCheckIfGoForwards

    ; branch if pipe bug is more than #$40 pixels (4 blocks) below Samus
    ; while this is true, pipe bug will continue to rise at a fixed y speed
    lda ObjY
    sec
    sbc EnY,x
    cmp #$40
    bcs PipeBugApplySpeed

    ; set EnsExtra.0.accelY to #$7F
    ; eventually, this gravity will make y speed positive
    lda #$7F
    sta EnsExtra.0.accelY,x
    bne PipeBugApplySpeed ; branch always

PipeBugCheckIfGoForwards:
    ; branch if y speed is negative (pipe bug is still rising)
    lda EnSpeedY,x
    bmi PipeBugApplySpeed
        ; y speed is not negative, we must stop moving vertically and go forwards
        ; set y speed and acceleration to 0
        lda #$00
        sta EnSpeedY,x
        sta EnSpeedSubPixelY,x
        sta EnsExtra.0.accelY,x
        ; set pipe bug x speed depending on its facing direction
        lda EnData05,x
        and #$01
        tay
        lda PipeBugSpeedXTable,y
        sta EnSpeedX,x
PipeBugApplySpeed:
    ; exit if bit 7 of EnData05 is set
    lda EnData05,x
    asl
    bmi PipeBugExit
    
    ; exit if pipe bug is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne PipeBugExit
    
    ; get y speed
    jsr CommonJump_EnemyGetDeltaY_UsingAcceleration
    ; push y speed to stack
    pha
    ; get x speed
    jsr CommonJump_EnemyGetDeltaX_UsingAcceleration
    ; set x speed
    sta Temp05_SpeedX
    ; set y speed
    pla
    sta Temp04_SpeedY

    ; apply speed
    jsr StoreEnemyPositionToTemp_
    jsr CommonJump_ApplySpeedToPosition
    ; remove bug if it is out of bounds
    bcc PipeBugDelete
    jsr LoadEnemyPositionFromTemp_
    ; fallthrough

;Exit 1
PipeBugExit:
    ; change animation frame every 3 frames
    lda #$03
    jmp CommonJump_01 ; Common Enemy Handler

;Exit 2
PipeBugDelete:
    ; Set enemy status to 0
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    rts

PipeBugSpeedXTable:
.if BANK == 1 ; Brinstar
    .byte $04, -$04
.else ; Norfair, Kraid, Ridley
    .byte $08, -$08
.endif

