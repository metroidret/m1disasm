; Ridley Routine
RidleyAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc RidleyBranch_Normal_{AREA}
    beq RidleyBranch_Explode_{AREA}
    cmp #enemyStatus_Pickup
    bne RidleyBranch_Exit_{AREA}

RidleyBranch_Explode_{AREA}:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq RidleyBranch_Exit_{AREA}

RidleyBranch_Normal_{AREA}:
    lda #EnAnim_RidleyHopping_R_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_RidleyHopping_L_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    jsr CommonJump_EnemyFlipAfterDisplacement
    jsr RidleyTryToLaunchProjectile_{AREA}

RidleyBranch_Exit_{AREA}:
    ; change animation frame every 3 frames
    lda #$03
    sta $00
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballAIRoutine_{AREA}:
    ; push EnData05 to stack
    lda EnData05,x
    pha
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jsr UpdateEnemyCommon_Decide_{AREA}
    ; compare past EnData05 to current EnData05
    pla
    ldx PageIndex
    eor EnData05,x
    ; branch if they differ in the horizontal facing direction
    lsr
    bcs @RemoveProjectile
    ; exit if projectile faces left
    lda EnData05,x
    lsr
    bcs @RTS
    ; exit if projectile is to the left of Samus
    lda EnX,x
    sec
    sbc Samus.x
    bcc @RTS
    ; exit if projectile is not #$20 or more pixels (2 blocks) to the right of Samus
    cmp #$20
    bcc @RTS
    ; fallthrough
@RemoveProjectile:
    ; remove projectile
    lda #$00
    sta EnsExtra.0.status,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Ridley Subroutine
RidleyTryToLaunchProjectile_{AREA}:
    ; load projectile counter into y (#$60 if it is zero)
    ldy RidleyProjectileCounter
    bne @endIf_A
        ldy #$60
    @endIf_A:
    ; exit if bit 1 of FrameCount is set
    lda FrameCount
    and #$02
    bne @RTS
    ; decrement projectile counter
    dey
    sty RidleyProjectileCounter
    ; a = projectile counter * 2, to compensate for exiting when bit 1 of FrameCount is set
    tya
    asl
    ; exit if (projectile counter * 2) is not #$0A, #$1A, #$2A, #$3A, #$4A, #$5A, #$6A or #$7A
    ; projectile will try firing every 16 frames 8 times, then will pause for 128 frames, in a cycle
    bmi @RTS
    and #$0F
    cmp #$0A
    bne @RTS

    ; loop for all projectiles
    ldx #$50
    @loop_A:
        ; branch if no projectile in enemy slot
        lda EnsExtra.0.status,x
        beq RidleyTryToLaunchProjectile_FoundEnemySlot_{AREA}
        ; branch if projectile is invisible
        lda EnData05,x
        and #$02
        beq RidleyTryToLaunchProjectile_FoundEnemySlot_{AREA}
        ; enemy slot is occupied, check the next slot
        txa
        sec
        sbc #$10
        tax
        bne @loop_A
    
    ; all projectiles are currently launched
    ; undo decrement projectile counter so that it will try to launch again the next frame
    ; (BUG! this is actually Kraid's lint counter, probably a remnant-->
    ; of copy-pasting the KraidTryToLaunchLint routine to make this one)
    inc KraidLintCounter
@RTS:
    rts

RidleyTryToLaunchProjectile_FoundEnemySlot_{AREA}:
    ; set y to x
    txa
    tay
    ; put ridley's position in temp
    ldx #$00
    jsr StoreEnemyPositionToTemp__{AREA}
    ; set x to y
    tya
    tax
    ; set projectile's EnData05 to Ridley's EnData05
    lda EnData05
    sta EnData05,x
    ; set x offset based on horizontal facing direction
    and #$01
    tay
    lda RidleyProjectileOffsetX_{AREA},y
    sta Temp05_SpeedX
    ; set y offset
    lda #$F8
    sta Temp04_SpeedY
    ; apply offset to ridley's position for use as projectile's position
    jsr CommonJump_ApplySpeedToPosition
    ; exit if projectile's initial position is out of bounds
    bcc RidleyTryToLaunchProjectile_{AREA}@RTS
    ; set EnSpecialAttribs to #$00
    lda #$00
    sta EnSpecialAttribs,x
    ; set enemy type to ridley projectile
    lda #$0A
    sta EnsExtra.0.type,x
    ; set enemy status to resting
    lda #enemyStatus_Resting
    sta EnsExtra.0.status,x
    ; set projectile's position to its initial position
    jsr LoadEnemyPositionFromTemp__{AREA}
    jmp CommonJump_0E

RidleyProjectileOffsetX_{AREA}:
    .byte $08, -$08

