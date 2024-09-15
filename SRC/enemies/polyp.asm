; Polyp Routine (mini volcano)
PolypRoutine:
    lda #$00
    sta EnRadY,X
    sta EnRadX,X
    lda #$10
    sta $0405,X
    .if BANK = 2
        txa
        asl
        asl
        sta $00
    .endif
    txa
    lsr
    lsr
    lsr
    lsr
    adc $2D
    .if BANK = 2
        adc $00
        and #$47
    .elseif BANK = 5
        and #$07
    .endif
    bne PolypRTS
    lsr $0405,X
    lda #$03
    sta $87
    lda $2E
    lsr
    rol $0405,X
    and #$03
    beq PolypRTS
    sta $88
    lda #$02
    sta $85
    jmp CommonJump_0B

PolypRTS:
    rts
