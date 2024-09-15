; Ridley Routine
RidleyRoutine:
    lda EnStatus,X
    cmp #$03
    bcc L9A33
    beq L9A20
    cmp #$05
    bne L9A41

L9A20:
    lda #$00
    sta EnStatus+$10
    sta EnStatus+$20
    sta EnStatus+$30
    sta EnStatus+$40
    sta EnStatus+$50
    beq L9A41

L9A33:
    lda #$0B
    sta $85
    lda #$0E
    sta $86
    jsr CommonJump_09
    jsr L9A79

L9A41:
    lda #$03
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballRoutine:
    lda $0405,X
    pha
    lda #$02
    sta $00
    sta $01
    jsr CommonEnemyJump_00_01_02
    pla
    ldx $4B
    eor $0405,X
    lsr
    bcs L9A73
    lda $0405,X
    lsr
    bcs L9A78
    lda $0401,X
    sec
    sbc $030E
    bcc L9A78
    cmp #$20
    bcc L9A78
L9A73:
    lda #$00
    sta EnStatus,X
L9A78:
    rts

;-------------------------------------------------------------------------------
; Ridley Subroutine
L9A79:
    ldy $80
    bne L9A7F
        ldy #$60
    L9A7F:
    lda $2D
    and #$02
    bne L9AA9
    dey
    sty $80
    tya
    asl
    bmi L9AA9
    and #$0F
    cmp #$0A
    bne L9AA9
    ldx #$50
    L9A94:
        lda EnStatus,X
        beq L9AAA
        lda $0405,X
        and #$02
        beq L9AAA
        txa
        sec
        sbc #$10
        tax
        bne L9A94
    inc $7E
L9AA9:
    rts

L9AAA:
    txa
    tay
    ldx #$00
    jsr StorePositionToTemp
    tya
    tax
    lda $0405
    sta $0405,X
    and #$01
    tay
    lda L9ADF,Y
    sta $05
    lda #$F8
    sta $04
    jsr CommonJump_0D
    bcc L9AA9
    lda #$00
    sta $040F,X
    lda #$0A
    sta EnDataIndex,X
    lda #$01
    sta EnStatus,X
    jsr LoadPositionFromTemp
    jmp CommonJump_0E
L9ADF:
    .byte $08, -$08
