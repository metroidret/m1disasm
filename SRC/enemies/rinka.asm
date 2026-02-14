RinkaAIRoutine_{AREA}:
    ; branch if enemy is not active
    ldy EnsExtra.0.status,x
    cpy #enemyStatus_Active
    bne @moveRinka

    ; enemy is active
    ; branch if previous status is not resting
    dey ; set y to #$01
    cpy EnemyStatusPreAI
    bne @moveRinka

    ; previous status is resting
    ; that means the rinka's speed vector needs to be initialized
    ; clear rinka acceleration
    ; (this is useless, because rinka isn't using the acceleration movement system)
    lda #$00
    jsr ClearRinkaAcceleration ; in metroid.asm
    ; clear rinka sub-pixel position
    sta EnsExtra.0.subPixelY,x
    sta EnsExtra.0.subPixelX,x

    ; save Samus x pos relative to enemy in $01
    lda Samus.x
    sec
    sbc EnX,x
    sta $01
    ; push EnData05 to stack
    lda EnData05,x
    pha
    ; shift horizontal facing direction into carry
    lsr
    ; push EnData05/2 to stack
    pha
    ; branch if facing right
    bcc @endIf_A
        ; enemy is facing left
        ; negate $01
        lda #$00
        sbc $01
        sta $01
    @endIf_A:
    ; $01 now contains the x distance between Samus and the enemy

    ; save Samus y pos relative to enemy in $00
    lda Samus.y
    sec
    sbc EnY,x
    sta $00
    ; pull EnData05/2 from stack
    pla
    ; shift vertical facing direction into carry
    lsr
    lsr
    ; branch if facing down
    bcc @endIf_B
        ; enemy is facing up
        ; negate $00
        lda #$00
        sbc $00
        sta $00
    @endIf_B:
    ; $00 now contains the y distance between Samus and the enemy

    ; logic or both together
    lda $00
    ora $01
    ; for bits 7, 6, 5 of this
    ldy #$03
    @loop_A:
        ; shift bit into carry
        asl
        ; branch if that bit is set
        bcs @exitLoop_A
        dey
        bne @loop_A
    @exitLoop_A:

    @loop_B:
        ; branch if bits 7, 6, 5 were not set
        dey
        bmi @exitLoop_B
            ; bit 7 or 6 or 5 was set
            ; divide by 2 repeatedly until this isn't the case anymore
            lsr $00
            lsr $01
            bpl @loop_B
    @exitLoop_B:
    ; $00 and $01 now do not have bits 7, 6, 5 set

    ; set rinka speed based on $00 and $01
    jsr SetRinkaSpeed_{AREA}
    
    ; pull EnData05 from stack
    pla
    ; shift horizontal facing direction into carry
    lsr
    ; push EnData05/2 to stack
    pha
    ; branch if facing right
    bcc @endIf_C
        ; enemy is facing left
        ; negate rinka x speed
        lda #$00
        sbc EnSpeedSubPixelX,x
        sta EnSpeedSubPixelX,x
        lda #$00
        sbc EnSpeedX,x
        sta EnSpeedX,x
    @endIf_C:
    ; pull EnData05/2 from stack
    pla
    ; shift vertical facing direction into carry
    lsr
    lsr
    ; branch if facing down
    bcc @endIf_D
        ; enemy is facing up
        ; negate rinka y speed
        lda #$00
        sbc EnSpeedSubPixelY,x
        sta EnSpeedSubPixelY,x
        lda #$00
        sbc EnSpeedY,x
        sta EnSpeedY,x
    @endIf_D:

@moveRinka:
    ; branch if bit 6 of EnData05 is set (30FPS)
    lda EnData05,x
    asl
    bmi @endIf_E
        ; move rinka
        
        ; apply y sub-pixel speed to sub-pixel position
        lda EnSpeedSubPixelY,x
        clc
        adc EnsExtra.0.subPixelY,x
        sta EnsExtra.0.subPixelY,x
        ; if sub-pixel position overflowed, add 1 to temp speed
        lda EnSpeedY,x
        adc #$00
        sta Temp04_SpeedY

        ; apply x sub-pixel speed to sub-pixel position
        lda EnSpeedSubPixelX,x
        clc
        adc EnsExtra.0.subPixelX,x
        sta EnsExtra.0.subPixelX,x
        ; if sub-pixel position overflowed, add 1 to temp speed
        lda EnSpeedX,x
        adc #$00
        sta Temp05_SpeedX

        ; store position to temp
        lda EnY,x
        sta Temp08_PositionY
        lda EnX,x
        sta Temp09_PositionX
        lda EnsExtra.0.hi,x
        sta Temp0B_PositionHi
        ; apply speed
        jsr CommonJump_ApplySpeedToPosition
        ; branch if movement succeeded
        bcs @endIf_F
            ; movement failed, remove rinka
            lda #$00
            sta EnsExtra.0.status,x
        @endIf_F:
        jsr LoadEnemyPositionFromTemp_
    @endIf_E:
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_UpdateEnemyCommon_noMove


SetRinkaSpeed_{AREA}:
    ; load y speed
    lda $00
    pha
    ; write upper nibble to enemy y speed
    jsr Adiv16_
    sta EnSpeedY,x
    pla
    ; write lower nibble to enemy y speed subpixels
    jsr Amul16_
    sta EnSpeedSubPixelY,x

    ; load x speed
    lda $01
    pha
    jsr Adiv16_
    ; write upper nibble to enemy x speed
    sta EnSpeedX,x
    pla
    ; write lower nibble to enemy x speed subpixels
    jsr Amul16_
    sta EnSpeedSubPixelX,x
    rts


    lsr ; unused instruction
Adiv16_:
    lsr
    lsr
    lsr
    lsr
    rts

Amul16_:
    asl
    asl
    asl
    asl
    rts

