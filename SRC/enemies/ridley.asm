; Ridley Routine
RidleyAIRoutine:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc RidleyBranch_Normal
    beq RidleyBranch_Explode
    cmp #enemyStatus_Pickup
    bne RidleyBranch_Exit

RidleyBranch_Explode:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status+$10
    sta EnsExtra.0.status+$20
    sta EnsExtra.0.status+$30
    sta EnsExtra.0.status+$40
    sta EnsExtra.0.status+$50
    beq RidleyBranch_Exit

RidleyBranch_Normal:
    lda #EnAnim_0B - EnAnimTbl.b
    sta EnemyLFB88_85
    lda #EnAnim_0E - EnAnimTbl.b
    sta EnemyLFB88_85+1.b
    jsr CommonJump_09
    jsr RidleyTryToLaunchProjectile

RidleyBranch_Exit:
    ; change animation frame every 3 frames
    lda #$03
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyProjectileAIRoutine:
    ; push EnData05 to stack
    lda EnData05,x
    pha
    ; change animation frame every 2 frames
    lda #$02
    sta $00
    sta $01
    jsr CommonEnemyJump_00_01_02
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
RidleyTryToLaunchProjectile:
    ; load projectile counter into y (#$60 if it is zero)
    ldy RidleyProjectileCounter
    bne L9A7F
        ldy #$60
    L9A7F:
    ; exit if bit 1 of FrameCount is set
    lda FrameCount
    and #$02
    bne RTS_9AA9
    ; decrement projectile counter
    dey
    sty RidleyProjectileCounter
    ; a = projectile counter * 2, to compensate for exiting when bit 1 of FrameCount is set
    tya
    asl
    ; exit if (projectile counter * 2) is not #$0A, #$1A, #$2A, #$3A, #$4A, #$5A, #$6A or #$7A
    ; projectile will try firing every 16 frames 8 times, then will pause for 128 frames, in a cycle
    bmi RTS_9AA9
    and #$0F
    cmp #$0A
    bne RTS_9AA9

    ; loop for all projectiles
    ldx #$50
    L9A94:
        ; branch if no projectile in enemy slot
        lda EnsExtra.0.status,x
        beq RidleyTryToLaunchProjectile_FoundEnemySlot
        ; branch if projectile is invisible
        lda EnData05,x
        and #$02
        beq RidleyTryToLaunchProjectile_FoundEnemySlot
        ; enemy slot is occupied, check the next slot
        txa
        sec
        sbc #$10
        tax
        bne L9A94
    
    ; all projectiles are currently launched
    ; undo decrement projectile counter so that it will try to launch again the next frame
    ; (BUG! this is actually Kraid's lint counter, probably a remnant-->
    ; of copy-pasting the KraidTryToLaunchLint routine to make this one)
    inc KraidLintCounter
RTS_9AA9:
    rts

RidleyTryToLaunchProjectile_FoundEnemySlot:
    ; set y to x
    txa
    tay
    ; put ridley's position in temp
    ldx #$00
    jsr StorePositionToTemp
    ; set x to y
    tya
    tax
    ; set projectile's EnData05 to Ridley's EnData05
    lda EnData05
    sta EnData05,x
    ; set x offset based on horizontal facing direction
    and #$01
    tay
    lda RidleyProjectileOffsetX,y
    sta Temp05_SpeedX
    ; set y offset
    lda #$F8
    sta Temp04_SpeedY
    ; apply offset to ridley's position for use as projectile's position
    jsr CommonJump_ApplySpeedToPosition
    ; exit if projectile's initial position is out of bounds
    bcc RTS_9AA9
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
    jsr LoadPositionFromTemp
    jmp CommonJump_0E

RidleyProjectileOffsetX:
    .byte $08, -$08

