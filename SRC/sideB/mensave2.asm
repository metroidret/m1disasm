
LC3F0:
    .word LC461
LC3F2:
    .word LB32D



LC3F4:
    jsr ClearScreenData
    lda #<PPUString_C40B.b
    sta $00
    lda #>PPUString_C40B.b
    sta $01
    jsr MAIN_ProcessPPUString
    jsr LD060
    jsr LB310
    jmp LC425

; "Aメンヲ セットシテクダサイ" message (switch to disk side A)
PPUString_C40B:
    PPUString $21D4, charmap_gameover, \
        "゛"
    PPUString $21E9, charmap_gameover, \
        "aメンヲ セットシテクタサイ"
    PPUStringRepeat $23D0, undefined, $00, $20
    PPUStringEnd

LC425:
    jsr LB32D
    ldx #<LB3E6.b
    ldy #>LB3E6.b
    jsr LB2B6
    jsr LC568
    ldy $B41F
    lda $B41D
    sta $C612,y
    tya
    asl a
    asl a
    asl a
    asl a
    tax
    ldy #$00
LC443:
    lda $B410,y
    sta $C5E2,x
    inx
    iny
    cpy #$10
    bne LC443
    ldx #$EC
    ldy #$B3
    lda #$0E
    jsr LB22B
    ldx #$EA
    ldy #$B3
    lda $B41C
    bne LC465
LC461:
    ldx #$E8
    ldy #$B3
LC465:
    jsr $B2B6
    jmp ($DFFC)
    pha
    pha
    cpy #$02
    beq LC4AB
    lda $B41F
    pha
    lda #$02
    sta $B41F
LC47A:
    jsr LC50B
    jsr LC516
    lda #$00
    sta $C3C0,y
    sta $C3C1,y
    sta $C3C2,y
    lda $B41F
    sta $C3C3,y
    dec $B41F
    bpl LC47A
    pla
    sta $B41F
    jsr LC50B
    jsr LC4F6
    lda #$01
    sta $B41E
    ldy $C50A
    sta $C3CE,y
LC4AB:
    jsr LC50B
    lda $B41E
    bpl LC4C0
    and #$01
    sta $B41E
    jsr LC516
    lda #$01
    sta $C3C2,y
LC4C0:
    lda $1E
    cmp #$01
    beq LC4E6
    lda $6E
    jsr LC53B
    ldy #$3F
LC4CD:
    lda $B420,y
    sta ($00),y
    dey
    bpl LC4CD
    ldy $C50A
    ldx #$00
LC4DA:
    lda $B410,x
    sta $C3C0,y
    iny
    inx
    cpx #$10
    bne LC4DA
LC4E6:
    pla
    jsr LC53B
    ldy #$3F
LC4EC:
    lda ($00),y
    sta $B420,y
    dey
    bpl LC4EC
    bmi LC4F7
LC4F6:
    pha
LC4F7:
    ldy $C50A
    ldx #$00
LC4FC:
    lda $C3C0,y
    sta $B410,x
    iny
    inx
    cpx #$10
    bne LC4FC
    pla
    rts
    .byte $00
LC50B:
    lda $B41F
    asl a
    asl a
    asl a
    asl a
    sta $C50A
    rts
LC516:
    lda #$00
    jsr LC53B
    inc $03
    ldy #$00
    tya
LC520:
    sta ($00),y
    cpy #$40
    bcs LC528
    sta ($02),y
LC528:
    iny
    bne LC520
    ldy $C50A
    ldx #$00
    txa
LC531:
    sta $C3C0,y
    iny
    inx
    cpx #$0C
    bne LC531
    rts
LC53B:
    pha
    ldx $B41F
    lda $C562,x
    sta $00
    sta $02
    lda $C565,x
    sta $01
    sta $03
    pla
    and #$0F
    tax
    beq LC561
LC553:
    lda $00
    clc
    adc #$40
    sta $00
    bcc LC55E
    inc $01
LC55E:
    dex
    bne LC553
LC561:
    rts
    .byte $00
    rti
    .byte $80
    cpy #$C1
    .byte $C2
LC568:
    ldy $B41C
    bne LC56E
    rts
LC56E:
    ldy $B41D
    bne LC585
    beq LC584
LC575:
    lda #$00
    cmp $B419
    bcc LC589
    lda LC598-1,y
    cmp $B418
    bcc LC589
LC584:
    iny
LC585:
    cpy #$05
    bne LC575
LC589:
    sty $B41D
    ldy #$00
    tya
LC58F:
    sta $B410,y
    iny
    cpy #$0C
    bne LC58F
    rts

LC598:
    .byte $3C, $0A, $04, $02, $0A, $00, $B0, $07

