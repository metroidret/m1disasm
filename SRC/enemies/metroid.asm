MetroidRoutine:
    ldy $010B
    iny
    beq L9804
        lda #$00
        sta EnStatus,X
    L9804:
    lda #$0F
    sta $00
    sta $01
    lda $0405,X
    asl
    bmi CommonEnemyJump_00_01_02
    lda EnStatus,X
    cmp #$03
    beq CommonEnemyJump_00_01_02
    jsr L99B7
    lda $77F8,Y
    beq L9822
        jmp L9899

    L9822:
    ldy $0408,X
    lda $77F6,Y
    pha
    lda EnData02,X
    bpl L983B
        pla
        jsr TwosCompliment_
        pha
        lda #$00
        cmp $0406,X
        sbc EnData02,X
    L983B:
    cmp $77F6,Y
    pla
    bcc L9849
        sta EnData02,X
        lda #$00
        sta $0406,X
    L9849:
    lda $77F6,Y
    pha
    lda EnData03,X
    bpl L985F
        pla
        jsr TwosCompliment_
        pha
        lda #$00
        cmp $0407,X
        sbc EnData03,X
    L985F:
    cmp $77F6,Y
    pla
    bcc L986D
        sta EnData03,X
        lda #$00
        sta $0407,X
    L986D:
    lda $0405,X
    pha
    jsr L9A06
    sta $6AFF,X
    pla
    lsr
    lsr
    jsr L9A06
    sta $6AFE,X
    lda EnStatus,X
    cmp #$04
    bne L9894
        ldy $040B,X
        iny
        bne L9899
        lda #$05
        sta $040B,X
        bne L9899
    L9894:
    lda #$FF
    sta $040B,X
L9899:
    lda $81
    cmp #$06
    bne L98A9
    cmp EnStatus,X
    beq L98A9
    lda #$04
    sta EnStatus,X
L98A9:
    lda $0404,X
    and #$20
    beq L990F
        jsr L99B7
        lda $77F8,Y
        beq L98EF
            lda $040E,X
            cmp #$07
            beq L98C3
                cmp #$0A
                bne L9932
            L98C3:
            lda $2D
            and #$02
            bne L9932
            lda $77F8,Y
            clc
            adc #$10
            sta $77F8,Y
            and #$70
            cmp #$50
            bne L9932
            lda #$02
            ora $040F,X
            sta $040C,X
            lda #$06
            sta EnStatus,X
            lda #$20
            sta $040F,X
            lda #$01
            sta $040D,X
        L98EF:
        lda #$00
        sta $0404,X
        sta $77F8,Y
        sta $0406,X
        sta $0407,X
        lda $6AFE,X
        jsr L9A10
        sta EnData02,X
        lda $6AFF,X
        jsr L9A10
        sta EnData03,X
    L990F:
    jsr L99B7
    lda $77F8,Y
    bne L9932
    lda $0404,X
    and #$04
    beq L9964
    lda EnData03,X
    and #$80
    ora #$01
    tay
    jsr L99C3
    jsr L99BD
    tya
    sta $77F8,X
    txa
    tay
L9932:
    tya
    tax
    lda $77F8,X
    php
    and #$0F
    cmp #$0C
    beq L9941
        inc $77F8,X
    L9941:
    tay
    lda L99D7,Y
    sta $04
    sty $05
    lda #$0C
    sec
    sbc $05
    ldx $4B
    plp
    bmi L9956
        jsr TwosCompliment_
    L9956:
    sta $05
    jsr L99E4
    jsr CommonJump_0D
    jsr L99F4
    jmp L9967

L9964:
    jsr L99AE
L9967:
    lda EnStatus,X
    cmp #$03
    bne L9971
        jsr L99AE
    L9971:
    ldy #$00
    lda $77F8
    ora $77F9
    ora $77FA
    ora $77FB
    ora $77FC
    ora $77FD
    and #$0C
    cmp #$0C
    bne L999E
    lda $0106
    ora $0107
    beq L999E
    sty $6F
    ldy #$04
    sty $6E
    jsr CommonJump_SubtractHealth
    ldy #$01
L999E:
    sty $92
    lda $6B
    bmi L99AB
        lda $6B02,X
        ora #$A2
        sta $6B
    L99AB:
    jmp CommonEnemyJump_00_01_02

L99AE:
    jsr L99B7
MetroidRoutine_L99B1:
    lda #$00
    sta $77F8,Y
    rts

L99B7:
    txa
    jsr Adiv16_
    tay
    rts

L99BD:
    txa
    jsr Adiv16_
    tax
    rts

L99C3:
    lda #$00
    sta EnData02,X
    sta EnData03,X
    sta $0407,X
    sta $0406,X
L99D1:
    sta $6AFF,X
    sta $6AFE,X
L99D7:
    rts

    .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8

L99E4:
    lda ObjectX
    sta $09
    lda ObjectY
    sta $08
    lda $030C
    sta $0B
    rts

L99F4:
    lda $09
    sta EnXRoomPos,X
    lda $08
    sta EnYRoomPos,X
    lda $0B
    and #$01
    sta EnNameTable,X
    rts

L9A06:
    lsr
    lda $0408,X
    rol
    tay
    lda $77F2,Y
    rts

L9A10:
    asl
    rol
    and #$01
    tay
    lda $77F0,Y
    rts

    .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00
