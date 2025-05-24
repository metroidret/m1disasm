; Polyp Routine (mini volcano)
PolypAIRoutine:
    lda #$00
    sta EnRadY,x
    sta EnRadX,x
    lda #$10
    sta EnData05,x
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
    adc FrameCount
    .if BANK = 2
        adc $00
        and #$47
    .elseif BANK = 5
        and #$07
    .endif
    bne RTS_Polyp
    lsr EnData05,x
    lda #$03
    sta SpawnFireball_87
    lda RandomNumber1
    lsr
    rol EnData05,x
    and #$03
    beq RTS_Polyp
    sta SpawnFireball_EnData0A
    lda #$02
    sta SpawnFireball_AnimTableIndex
    jmp CommonJump_SpawnFireball

RTS_Polyp:
    rts
