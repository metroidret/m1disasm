    ; * = $C000
    cld
    ; wait for vblank
    LC001:
        lda PPUSTATUS
        bpl LC001
    ldx #$00
    stx PPUCTRL
    stx PPUMASK
    dex
    txs
    ; clear $0000-$00FF and $0104-$07FF
    ldy #$07
    sty $01
    ldy #$00
    sty $00
    tya
    LC019:
                sta ($00),Y
                iny
                bne LC019
            dec $01
            bmi LC02E
            ldx $01
            cpx #$01
            bne LC019
        iny
        iny
        iny
        iny
        bne LC019
LC02E:
    jsr $941D
    jsr $6F3B
    ldy #$00
    sty PPUSCROLL
    sty PPUSCROLL
    iny
    sty $1D
    lda #$90
    sta PPUCTRL
    sta $FF
    lda #$02
    sta $FE
    lda #$47
    sta FDS_CTRL
    sta $73
    sta $FB
    sta $28
    jmp $9388


LC058:
    jsr $6EE4
    lda #<DataC06C.b
    sta $00
    lda #>DataC06C.b
    sta $01
    jsr $94BC
    jsr $D060
    jmp $B310

DataC06C:
    .byte $21, $D4, $01, $5B, $21, $E9, $0E, $0B, $4F, $5A, $24, $FF, $3B, $2D, $41, $39
    .byte $40, $35, $3D, $38, $2F, $00


LC082:
    lda #$01
    sta $70
    inc $1E
    lda $14
    and #$C0
    sta $F0
    jsr LC058
    jsr $6F3B
    lda #$10
    jmp $B261

; is this data?
DataC099:
    .byte $C1, $38, $C1, $40, $C1, $A9, $02, $8D, $F7, $07, $20, $F4, $C0, $D0, $90, $20
    .byte $CA, $C0, $F0, $05, $A9, $00, $8D, $9F, $D2, $AD, $9F, $D2, $18, $69, $01, $C9
    .byte $19, $90, $02, $A9, $18, $8D, $9F

