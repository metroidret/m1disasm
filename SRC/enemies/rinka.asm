RinkaAIRoutine:
    ; branch if enemy is not active
    ldy EnsExtra.0.status,x
    cpy #enemyStatus_Active
    bne L9AB0

    ; enemy is active
    ; branch if previous status is not resting
    dey ; set y to #$01
    cpy EnemyStatusPreAI
    bne L9AB0

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
    lda ObjX
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
    bcc L9A5A
        ; enemy is facing left
        ; negate $01
        lda #$00
        sbc $01
        sta $01
    L9A5A:
    ; $01 now contains the x distance between Samus and the enemy

    ; save Samus y pos relative to enemy in $00
    lda ObjY
    sec
    sbc EnY,x
    sta $00
    ; pull EnData05/2 from stack
    pla
    ; shift vertical facing direction into carry
    lsr
    lsr
    ; branch if facing down
    bcc L9A6E
        ; enemy is facing up
        ; negate $00
        lda #$00
        sbc $00
        sta $00
    L9A6E:
    ; $00 now contains the y distance between Samus and the enemy

    ; logic or both together
    lda $00
    ora $01
    ; for bits 7, 6, 5 of this
    ldy #$03
    L9A74:
        ; shift bit into carry
        asl
        ; branch if that bit is set
        bcs L9A7A
        dey
        bne L9A74
L9A7A:
    ; branch if bits 7, 6, 5 were not set
    dey
    bmi L9A83
        ; bit 7 or 6 or 5 was set
        ; divide by 2 repeatedly until this isn't the case anymore
        lsr $00
        lsr $01
        bpl L9A7A
    L9A83:
    ; $00 and $01 now do not have bits 7, 6, 5 set

    ; set rinka speed based on $00 and $01
    jsr SetRinkaSpeed
    
    ; pull EnData05 from stack
    pla
    ; shift horizontal facing direction into carry
    lsr
    ; push EnData05/2 to stack
    pha
    ; branch if facing right
    bcc endIf9A9B
        ; enemy is facing left
        ; negate rinka x speed
        lda #$00
        sbc EnSpeedSubPixelX,x
        sta EnSpeedSubPixelX,x
        lda #$00
        sbc EnSpeedX,x
        sta EnSpeedX,x
    endIf9A9B:
    ; pull EnData05/2 from stack
    pla
    ; shift vertical facing direction into carry
    lsr
    lsr
    ; branch if facing down
    bcc endIf9AB0
        ; enemy is facing up
        ; negate rinka y speed
        lda #$00
        sbc EnSpeedSubPixelY,x
        sta EnSpeedSubPixelY,x
        lda #$00
        sbc EnSpeedY,x
        sta EnSpeedY,x
    endIf9AB0:

L9AB0:
    ; branch if bit 6 of EnData05 is set (30FPS)
    lda EnData05,x
    asl
    bmi L9AF4
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
        bcs L9AF1
            ; movement failed, remove rinka
            lda #$00
            sta EnsExtra.0.status,x
        L9AF1:
        jsr LoadEnemyPositionFromTemp_
    L9AF4:
    ; change animation frame every 8 frames
    lda #$08
    jmp CommonJump_01


SetRinkaSpeed:
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

