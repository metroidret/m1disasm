RioRoutine:
    lda $81
    cmp #$01
    beq RioExitC

    cmp #$03
    beq RioExitB

    lda #$80
    sta EnData1A,x
    lda EnData02,x ; y speed?
    bmi RioExitA

    lda EnData05,x
    and #$10
    beq RioExitA

    lda EnYRoomPos,x
    sec
    sbc ObjectY ; Compare with Samus' Y position
    bpl RioBranch
        jsr TwosComplement_
    RioBranch:
    cmp #$10
    bcs RioExitA
    lda #$00
    sta EnData1A,x

RioExitA:
    lda #$03
    jmp CommonJump_00

RioExitB:
    jmp CommonJump_02

RioExitC:
    lda #$08
    jmp CommonJump_01
