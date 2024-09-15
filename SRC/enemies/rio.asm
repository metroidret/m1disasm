RioRoutine:
    lda $81
    cmp #$01
    beq RioExitC

    cmp #$03
    beq RioExitB

    lda #$80
    sta EnData1A,X
    lda EnData02,X ; y speed?
    bmi RioExitA

    lda EnData05,X
    and #$10
    beq RioExitA

    lda EnYRoomPos,X
    sec
    sbc ObjectY ; Compare with Samus' Y position
    bpl RioBranch
        jsr TwosCompliment_
    RioBranch:
    cmp #$10
    bcs RioExitA
    lda #$00
    sta EnData1A,X

RioExitA:
    lda #$03
    jmp CommonJump_00

RioExitB:
    jmp CommonJump_02

RioExitC:
    lda #$08
    jmp CommonJump_01
