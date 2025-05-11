RinkaAIRoutine:
    ldy EnStatus,x
    cpy #$02
    bne L9AB0
    dey
    cpy EnemyMovementPtr
    bne L9AB0
    lda #$00
    jsr ClearRinkaSomething ; in metroid.asm
    sta EnData18,x
    sta EnData19,x
    lda ObjX
    sec
    sbc EnXRoomPos,x
    sta $01
    lda EnData05,x
    pha
    lsr
    pha
    bcc L9A5A
        lda #$00
        sbc $01
        sta $01
    L9A5A:
    lda ObjY
    sec
    sbc EnYRoomPos,x
    sta $00
    pla
    lsr
    lsr
    bcc L9A6E
        lda #$00
        sbc $00
        sta $00
    L9A6E:
    lda $00
    ora $01
    ldy #$03
    L9A74:
        asl
        bcs L9A7A
        dey
        bne L9A74
L9A7A:
    dey
    bmi L9A83
        lsr $00
        lsr $01
        bpl L9A7A
    L9A83:
    jsr L9AF9
    pla
    lsr
    pha
    bcc L9A9B
        lda #$00
        sbc EnData07,x
        sta EnData07,x
        lda #$00
        sbc EnData03,x
        sta EnData03,x
    L9A9B:
    pla
    lsr
    lsr
    bcc L9AB0
    lda #$00
    sbc EnCounter,x
    sta EnCounter,x
    lda #$00
    sbc EnData02,x
    sta EnData02,x
L9AB0:
    lda EnData05,x
    asl
    bmi L9AF4
        lda EnCounter,x
        clc
        adc EnData18,x
        sta EnData18,x
        lda EnData02,x
        adc #$00
        sta $04
        lda EnData07,x
        clc
        adc EnData19,x
        sta EnData19,x
        lda EnData03,x
        adc #$00
        sta $05
        lda EnYRoomPos,x
        sta $08
        lda EnXRoomPos,x
        sta $09
        lda EnNameTable,x
        sta $0B
        jsr CommonJump_0D
        bcs L9AF1
            lda #$00
            sta EnStatus,x
        L9AF1:
        jsr LoadPositionFromTemp
    L9AF4:
    lda #$08
    jmp CommonJump_01

L9AF9:
    lda $00
    pha
    jsr Adiv16_
    sta EnData02,x
    pla
    jsr Amul16_
    sta EnCounter,x
    lda $01
    pha
    jsr Adiv16_
    sta EnData03,x
    pla
    jsr Amul16_
    sta EnData07,x
    rts

    lsr
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
