; SkreeRoutine
SkreeRoutine:
    lda $81
    cmp #$01
    beq SkreeExitB
    cmp #$03
    beq SkreeExitC
    lda EnCounter,X
    cmp #$0F
    bcc SkreeExitA
    cmp #$11
    bcs SkreeBranch
    lda #$3A
    sta EnData1D,X
    bne SkreeExitA

SkreeBranch:
    dec EnData1D,X
    bne SkreeExitA
    lda #$00
    sta EnStatus,X
    ldy #$0C

SkreeLoop:
    lda #$0A
    sta $A0,Y
    lda EnYRoomPos,X
    sta $A1,Y
    lda EnXRoomPos,X
    sta $A2,Y
    lda EnNameTable,X
    sta $A3,Y
    dey
    dey
    dey
    dey
    bpl SkreeLoop

SkreeExitA:
    lda #$02
    jmp CommonJump_00

SkreeExitB:
    lda #$08
    jmp CommonJump_01

SkreeExitC:
    jmp CommonJump_02
