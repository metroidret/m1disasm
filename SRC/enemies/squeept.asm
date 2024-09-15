; Lava Jumper Routine
SqueeptRoutine:
    lda $81
    cmp #$01
    bne L9A88
    lda EnStatus,X
    cmp #$03
    beq L9ACA
    cmp #$02
    bne L9A88
    ldy $0408,X
    lda L9AD2,Y
    sta $0402,X
    lda #$40
    sta $6AFE,X
    lda #$00
    sta $0406,X
L9A88:
    lda EnStatus,X
    cmp #$03
    beq L9ACA
    lda $81
    cmp #$01
    beq L9ACA
    cmp #$03
    beq L9ACF
    jsr CommonJump_12
    ldx $4B
    lda #$00
    sta $05
    lda #$1D
    ldy $00
    sty $04
    bmi L9AAC
        lda #$20
    L9AAC:
    sta $6AF9,X
    jsr StorePositionToTemp
    jsr CommonJump_0D
    lda #$E8
    bcc L9ABD
        cmp $08
        bcs L9AC7
    L9ABD:
    sta $08
    lda $0405,X
    ora #$20
    sta $0405,X
L9AC7:
    jsr LoadPositionFromTemp
L9ACA:
    lda #$02
    jmp CommonJump_01

L9ACF:
    jmp CommonJump_02

L9AD2:
    inc $F8,X
    inc $FA,X
