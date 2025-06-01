; Polyp Routine (mini volcano)
PolypAIRoutine:
    ; set radius to 0
    lda #$00
    sta EnRadY,x
    sta EnRadX,x
    ; set EnData05 to #$10
    ; the enemy is invisible and will remain resting
    lda #$10
    sta EnData05,x

    .if BANK = 2
        ; put bit 4 of enemy slot offset in bit 6
        txa
        asl
        asl
        sta $00
    .endif
    ; get enemy slot id
    txa
    lsr
    lsr
    lsr
    lsr
    ; add framecount
    adc FrameCount
    .if BANK = 2
        ; polyps in norfair will try shooting 8 times every 8 frames, then stop trying for 64 frames
        ; when polyps of even enemy slot id stops trying, polyps of odd enemy slot id will start trying, and vice versa
        adc $00
        and #$47
    .elseif BANK = 5
        ; polyps in ridley will always try to shoot every 8 frames
        ; (there arent any in ridley though)
        and #$07
    .endif
    ; exit if polyp isn't trying to shoot
    bne RTS_Polyp

    ; polyp is trying to shoot
    ; rotate horizontal facing flag into carry
    lsr EnData05,x
    ; set SpawnFireball_87 to #$03
    lda #$03
    sta SpawnFireball_87
    ; set horizontal facing flag to a random bit
    lda RandomNumber1
    lsr
    rol EnData05,x
    ; exit if misfired (25% random chance)
    and #$03
    beq RTS_Polyp
    ; store random number (1, 2 or 3) into SpawnFireball_EnData0A
    sta SpawnFireball_EnData0A
    ; set fireball animation
    lda #$02
    sta SpawnFireball_AnimTableIndex
    ; spawn fireball
    jmp CommonJump_SpawnFireball

RTS_Polyp:
    rts
