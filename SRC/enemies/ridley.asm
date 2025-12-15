; Ridley Routine
RidleyAIRoutine_BANK{BANK}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc RidleyBranch_Normal_BANK{BANK}
    beq RidleyBranch_Explode_BANK{BANK}
    cmp #enemyStatus_Pickup
    bne RidleyBranch_Exit_BANK{BANK}

RidleyBranch_Explode_BANK{BANK}:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq RidleyBranch_Exit_BANK{BANK}

RidleyBranch_Normal_BANK{BANK}:
    lda #EnAnim_RidleyHopping_R_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_RidleyHopping_L_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    jsr CommonJump_EnemyFlipAfterDisplacement
    jsr RidleyTryToLaunchProjectile_BANK{BANK}

RidleyBranch_Exit_BANK{BANK}:
    ; change animation frame every 3 frames
    lda #$03
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02_BANK{BANK}

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballAIRoutine_BANK{BANK}:
    ; push EnData05 to stack
    lda EnData05,x
    pha
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jsr CommonEnemyJump_00_01_02_BANK{BANK}
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
    sbc ObjX
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
RidleyTryToLaunchProjectile_BANK{BANK}:
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
        beq RidleyTryToLaunchProjectile_FoundEnemySlot_BANK{BANK}
        ; branch if projectile is invisible
        lda EnData05,x
        and #$02
        beq RidleyTryToLaunchProjectile_FoundEnemySlot_BANK{BANK}
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

RidleyTryToLaunchProjectile_FoundEnemySlot_BANK{BANK}:
    ; set y to x
    txa
    tay
    ; put ridley's position in temp
    ldx #$00
    jsr StoreEnemyPositionToTemp__BANK{BANK}
    ; set x to y
    tya
    tax
    ; set projectile's EnData05 to Ridley's EnData05
    lda EnData05
    sta EnData05,x
    ; set x offset based on horizontal facing direction
    and #$01
    tay
    lda RidleyProjectileOffsetX_BANK{BANK},y
    sta Temp05_SpeedX
    ; set y offset
    lda #$F8
    sta Temp04_SpeedY
    ; apply offset to ridley's position for use as projectile's position
    jsr CommonJump_ApplySpeedToPosition
    ; exit if projectile's initial position is out of bounds
    bcc RidleyTryToLaunchProjectile_BANK{BANK}@RTS
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
    jsr LoadEnemyPositionFromTemp__BANK{BANK}
    jmp CommonJump_0E

RidleyProjectileOffsetX_BANK{BANK}:
    .byte $08, -$08

