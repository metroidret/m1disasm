RinkaRoutine:
    ldy EnStatus,X
    cpy #$02
    bne L9AB0
    dey
    cpy $81
    bne L9AB0
    lda #$00
    jsr L99D1
    sta $6AFC,X
    sta $6AFD,X
    lda ObjectX
    sec
    sbc EnXRoomPos,X
    sta $01
    lda $0405,X
    pha
    lsr
    pha
    bcc L9A5A
        lda #$00
        sbc $01
        sta $01
    L9A5A:
    lda ObjectY
    sec
    sbc EnYRoomPos,X
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
        sbc $0407,X
        sta $0407,X
        lda #$00
        sbc EnData03,X
        sta EnData03,X
    L9A9B:
    pla
    lsr
    lsr
    bcc L9AB0
    lda #$00
    sbc $0406,X
    sta $0406,X
    lda #$00
    sbc EnData02,X
    sta EnData02,X
L9AB0:
    lda $0405,X
    asl
    bmi L9AF4
        lda $0406,X
        clc
        adc $6AFC,X
        sta $6AFC,X
        lda EnData02,X
        adc #$00
        sta $04
        lda $0407,X
        clc
        adc $6AFD,X
        sta $6AFD,X
        lda EnData03,X
        adc #$00
        sta $05
        lda EnYRoomPos,X
        sta $08
        lda EnXRoomPos,X
        sta $09
        lda EnNameTable,X
        sta $0B
        jsr CommonJump_0D
        bcs L9AF1
            lda #$00
            sta EnStatus,X
        L9AF1:
        jsr L99F4
    L9AF4:
    lda #$08
    jmp CommonJump_01

L9AF9:
    lda $00
    pha
    jsr Adiv16_
    sta EnData02,X
    pla
    jsr Amul16_
    sta $0406,X
    lda $01
    pha
    jsr Adiv16_
    sta EnData03,X
    pla
    jsr Amul16_
    sta $0407,X
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
