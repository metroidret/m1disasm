; Ridley Routine
RidleyAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc @normal
    beq @explode
    cmp #enemyStatus_Pickup
    bne @exit

@explode:
    ; delete fireballs
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq @exit

@normal:
    lda #EnAnim_RidleyHopping_R_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex
    lda #EnAnim_RidleyHopping_L_{AREA} - EnAnimTable_{AREA}.b
    sta EnemyFlipAfterDisplacementAnimIndex+1
    jsr CommonJump_EnemyFlipAfterDisplacement
    jsr RidleyTryToLaunchFireball_{AREA}

@exit:
    ; change animation frame every 3 frames
    lda #$03
    sta $00
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballAIRoutine_{AREA}:
    ; push Ens.0.data05 to stack
    lda Ens.0.data05,x
    pha
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jsr UpdateEnemyCommon_Decide_{AREA}
    ; compare past Ens.0.data05 to current Ens.0.data05
    pla
    ldx PageIndex
    eor Ens.0.data05,x
    ; branch if they differ in the horizontal facing direction
    lsr
    bcs @RemoveFireball
    ; exit if fireball faces left
    lda Ens.0.data05,x
    lsr
    bcs @RTS
    ; exit if fireball is to the left of Samus
    lda Ens.0.x,x
    sec
    sbc Samus.x
    bcc @RTS
    ; exit if fireball is not #$20 or more pixels (2 blocks) to the right of Samus
    cmp #$20
    bcc @RTS
    ; fallthrough
@RemoveFireball:
    ; remove fireball
    lda #$00
    sta EnsExtra.0.status,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Ridley Subroutine
RidleyTryToLaunchFireball_{AREA}:
    ; load fireball counter into y (#$60 if it is zero)
    ldy RidleyFireballCounter
    bne @endIf_A
        ldy #$60
    @endIf_A:
    ; exit if bit 1 of FrameCount is set
    lda FrameCount
    and #$02
    bne @RTS
    ; decrement fireball counter
    dey
    sty RidleyFireballCounter
    ; a = fireball counter * 2, to compensate for exiting when bit 1 of FrameCount is set
    tya
    asl
    ; exit if (fireball counter * 2) is not #$0A, #$1A, #$2A, #$3A, #$4A, #$5A, #$6A or #$7A
    ; fireball will try firing every 16 frames 8 times, then will pause for 128 frames, in a cycle
    bmi @RTS
    and #$0F
    cmp #$0A
    bne @RTS

    ; loop for all fireballs
    ldx #$50
    @loop_A:
        ; branch if no fireball in enemy slot
        lda EnsExtra.0.status,x
        beq RidleyTryToLaunchFireball_FoundEnemySlot_{AREA}
        ; branch if fireball is invisible
        lda Ens.0.data05,x
        and #$02
        beq RidleyTryToLaunchFireball_FoundEnemySlot_{AREA}
        ; enemy slot is occupied, check the next slot
        txa
        sec
        sbc #$10
        tax
        bne @loop_A
    
    ; all fireballs are currently launched
    ; undo decrement fireball counter so that it will try to launch again the next frame
    ; (BUG! this is actually Kraid's lint counter, probably a remnant-->
    ; of copy-pasting the KraidTryToLaunchLint routine to make this one)
    inc KraidLintCounter
@RTS:
    rts

RidleyTryToLaunchFireball_FoundEnemySlot_{AREA}:
    ; set y to x
    txa
    tay
    ; put ridley's position in temp
    ldx #$00
    jsr StoreEnemyPositionToTemp__{AREA}
    ; set x to y
    tya
    tax
    ; set fireball's Ens.0.data05 to Ridley's Ens.0.data05
    lda Ens.0.data05
    sta Ens.0.data05,x
    ; set x offset based on horizontal facing direction
    and #$01
    tay
    lda RidleyFireballOffsetX_{AREA},y
    sta Temp05_SpeedX
    ; set y offset
    lda #$F8
    sta Temp04_SpeedY
    ; apply offset to ridley's position for use as fireball's position
    jsr CommonJump_ApplySpeedToPosition
    ; exit if fireball's initial position is out of bounds
    bcc RidleyTryToLaunchFireball_{AREA}@RTS
    ; set Ens.0.specialAttribs to #$00
    lda #$00
    sta Ens.0.specialAttribs,x
    ; set enemy type to ridley fireball
    lda #$0A
    sta EnsExtra.0.type,x
    ; set enemy status to resting
    lda #enemyStatus_Resting
    sta EnsExtra.0.status,x
    ; set fireball's position to its initial position
    jsr LoadEnemyPositionFromTemp__{AREA}
    jmp CommonJump_0E

RidleyFireballOffsetX_{AREA}:
    .byte $08, -$08

