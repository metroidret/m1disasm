; SkreeRoutine
SkreeRoutine:
    lda $81
    cmp #$01
    beq SkreeExitB
    cmp #$03
    beq SkreeExitC
    lda EnCounter,x
    cmp #$0F
    bcc SkreeExitA
    cmp #$11
    bcs SkreeBranch
    lda #$3A
    sta EnData1D,x
    bne SkreeExitA

SkreeBranch:
    dec EnData1D,x
    bne SkreeExitA
    lda #$00
    sta EnStatus,x
    ldy #$0C

SkreeLoop:
    lda #$0A
    sta $A0,y
    lda EnYRoomPos,x
    sta $A1,y
    lda EnXRoomPos,x
    sta $A2,y
    lda EnNameTable,x
    sta $A3,y
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
