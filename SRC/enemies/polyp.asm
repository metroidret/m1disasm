; Polyp Routine (mini volcano)
PolypAIRoutine:
    lda #$00
    sta EnRadY,x
    sta EnRadX,x
    lda #$10
    sta $0405,x
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
    bne RTS_Polyp
    lsr $0405,x
    lda #$03
    sta $87
    lda $2E
    lsr
    rol $0405,x
    and #$03
    beq RTS_Polyp
    sta $88
    lda #$02
    sta $85
    jmp CommonJump_0B

RTS_Polyp:
    rts
