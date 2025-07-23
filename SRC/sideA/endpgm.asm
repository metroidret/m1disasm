
ENDPGM_RESET:
    cld
    ldx #$00
    stx $2000
    stx $2001
L6009:
    lda $2002
    bpl L6009
    dex
    txs
    ldx $2F
    ldy #$07
    sty $01
    lda #$00
    sta $00
    tay
L601B:
    sta ($00),y
    dey
    bne L601B
    dec $01
    bpl L601B
    txa
    bne L6029
    ldx #$5F
L6029:
    stx $0618
    lda #$4F
    sta $4025
    sta $FA
    jsr L65DC
    jsr L6630
    ldy #$00
    lda $C3F2
    sta $00
    lda $C3F3
    sta $01
    lda #$60
    sta ($00),y
    ldy #$00
    sty $2005
    sty $2005
    sty $3C
    iny
    sty $3A
    lda #$90
    sta $2000
    sta $FF
    lda #$06
    sta $FE
    lda #$C0
    sta $0100
    lda #$80
    sta $0101
    lda #$35
    sta $0102
    lda #$53
    sta $0103
L6075:
    jsr L66EA
    jsr L6144
    jsr L6080
    beq L6075
L6080:
    lda #$01
    sta $32
L6084:
    jsr L6777
    jsr L6777
    lda $30
    beq L6084
    inc $2F
    dec $32
    lda #$00
    sta $30
    rts
L6097:
    lda #$00
    sta $1A
L609B:
    lda $1A
    beq L609B
RTS_609F:
    rts

L60A0:
    lda $40
    and #$10
    beq RTS_609F
    jmp ($C3F0)
L60A9:
    jsr L6097
    lda $FE
    and #$E1
L60B0:
    sta $2001
    sta $FE
    rts
L60B6:
    jsr L6097
    jsr L676A
    lda $FE
    ora #$1E
    bne L60B0
L60C2:
    lda $2002
    and #$80
    bne L60C2
    lda $FF
    ora #$80
    bne L60D3
    lda $FF
    and #$7F
L60D3:
    sta $2000
    sta $FF
    rts



ENDPGM_NMI:
    cli
    pha
    txa
    pha
    tya
    pha
    lda #$00
    sta $2003
    lda #$02
    sta $4014
    lda $32
    beq L612D
    jsr L62CD
    lda $AE
    beq L6104
    cmp #$05
    bcs L6104
        asl a
        tay
        ldx EndMessageStringTbl0-2,y
        lda EndMessageStringTbl0-1,y
        tay
        jsr L671E
L6104:
    lda $AF
    beq L6118
    cmp #$05
    bcs L6118
        asl a
        tay
        ldx EndMessageStringTbl1-2,y
        lda EndMessageStringTbl1-1,y
        tay
        jsr L671E
L6118:
    jsr L663B
    jsr L66CB
    jsr L676A
    lda $FE
    sta $2001
    jsr L6672
    ldy #$01
    sty $30
L612D:
    lda $FE
    sta $2001
    lda $FF
    sta $2000
    jsr $DFF3
    lda #$01
    sta $1A
    pla
    tay
    pla
    tax
    pla
ENDPGM_IRQ:
    rti



L6144:
    jsr L6532
    lda $AD
    bne L615D
    lda $2F
    and #$0F
    bne L615D
    inc $34
    lda $34
    cmp #$09
    bne L615D
    lda #$01
    sta $34
L615D:
    lda $3C
    jsr ENDPGM_ChooseRoutine
        .word L6172
        .word L61AC
        .word L61C4
        .word L6222
        .word L625C
        .word L628B
        .word L60A0
        .word RTS_609F
    
L6172:
    jsr L60A9
    jsr L65E7
    jsr L6630
    ldx #$6F
    ldy #$68
    jsr L671E
    lda #$20
    sta $0684
    lda #$60
    sta $2D
    lda #$36
    sta $A6
    lda #$00
    sta $AA
    sta $A7
    sta $A9
    sta $AD
    sta $AE
    sta $AF
    sta $B0
    lda #$01
    sta $34
    lda #$08
    sta $A8
    inc $3C
    jmp L60B6



L61AC:
    jsr L6322
    lda $2D
    bne L61B6
    inc $3C
    rts
L61B6:
    cmp #$50
    bne L61BD
    inc $AE
    rts
L61BD:
    cmp #$01
    bne L61C3
    inc $AF
L61C3:
    rts



L61C4:
    lda $2F
    and #$3F
    bne L61F8
    inc $A9
    lda $A9
    cmp #$08
    bne L61E1
    lda $B41D
    cmp #$03
    bne L61DA
    rts
L61DA:
    asl a
    sta $AA
    lda #$36
    sta $A6
L61E1:
    cmp #$10
    bne L61F8
    sta $2D
    ldy #$00
    lda $B41D
    cmp #$04
    bcc L61F1
    iny
L61F1:
    sty $A7
    inc $3C
    jmp L6630
L61F8:
    dec $A8
    bne L620F
    ldy $A9
    lda L6212,y
    sta $A8
    inc $A7
    lda $A7
    cmp #$03
    bne L620F
    lda #$00
    sta $A7
L620F:
    jmp L6322

L6212:
    .byte $08, $07, $06, $05, $04, $03, $02, $01, $01, $02, $03, $04, $05, $06, $07, $08



L6222:
    lda $2D
    bne L6231
    lda #$10
    sta $2D
    lda #$08
    sta $34
    inc $3C
    rts
L6231:
    lda $B41D
    cmp #$04
    bcs L623B
    jmp L6322
L623B:
    sbc #$04
    asl a
    asl a
    sta $AB
    lda $2F
    and #$08
    bne L624D
    ldy #$10
    sty $AC
    bne L6255
L624D:
    inc $AB
    inc $AB
    ldy #$10
    sty $AC
L6255:
    lda #$2D
    sta $A6
    jmp L6307



L625C:
    lda $2D
    bne L627E
    lda $AD
    bne L626A
    lda #$08
    sta $34
    inc $AD
L626A:
    lda $2F
    and #$07
    bne L627E
    inc $34
    lda $34
    cmp #$0B
    bne L627E
    lda #$10
    sta $2D
    inc $3C
L627E:
    lda $B41D
    cmp #$04
    bcs L6288
    jmp L6322
L6288:
    jmp L6307



L628B:
    lda $2D
    beq L629F
    cmp #$02
    bne L62CC
    jsr L60A9
    jsr L65E7
    jsr L6630
    jmp L60B6
L629F:
    lda $B0
    bne L62A5
    inc $B0
L62A5:
    cmp #$06
    bne L62B2
    lda $FC
    cmp #$88
    bcc L62B2
    inc $3C
    rts
L62B2:
    lda $2F
    and #$03
    bne L62CC
    inc $FC
    lda $FC
    cmp #$F0
    bne L62CC
    inc $B0
    lda #$00
    sta $FC
    lda $FF
    eor #$02
    sta $FF
L62CC:
    rts
L62CD:
    ldy $B0
    beq L6306
    cpy #$07
    bcs L6306
    ldx #$00
    lda $FC
    bpl L62DF
    inx
    sec
    sbc #$80
L62DF:
    cmp #$04
    bcs L6306
    sta $01
    dey
    txa
    bne L62F4
    dey
    bmi L6306
    tya
    asl a
    asl a
    asl a
    adc #$04
    bne L62F8
L62F4:
    tya
    asl a
    asl a
    asl a
L62F8:
    adc $01
    asl a
    tay
    ldx CreditsPointerTbl,y
    lda CreditsPointerTbl+1,y
    tay
    jmp L671E
L6306:
    rts



L6307:
    ldx $AB
    lda L639A,x
    sta $00
    lda L639A+1,x
    sta $01
    ldx #$20
    ldy #$00
    L6317:
        lda ($00),y
        sta $0200,x
        inx
        iny
        cpy $AC
        bne L6317
L6322:
    ldx #$30
    ldy $AA
    lda L63E2,y
    sta $00
    lda L63E2+1,y
L632E:
    sta $01
    ldy #$00
L6332:
    lda ($00),y
    sta $0200,x
    inx
    iny
    lda ($00),y
    bpl L6348
    and #$7F
    sta $0200,x
    lda $A7
    eor #$40
    bne L634D
L6348:
    sta $0200,x
    lda $A7
L634D:
    inx
    sta $0200,x
    iny
    inx
    lda ($00),y
    sta $0200,x
    iny
    inx
    cpy $A6
    bne L6332
    lda $3C
    cmp #$02
    bcc L6381
    lda $A9
    cmp #$08
    bcc L6381
    lda $B41D
    cmp #$03
    bne L6381
    ldy #$00
    ldx #$00
    L6375:
        lda L6382,y
        sta $0200,x
        iny
        inx
        cpy #$18
        bne L6375
L6381:
    rts

L6382:
    .byte $93, $36, $01, $70
    .byte $93, $37, $01, $78
    .byte $93, $38, $01, $80
    .byte $9B, $46, $01, $70
    .byte $9B, $47, $01, $78
    .byte $9B, $48, $01, $80

L639A:
    .word L639A_63A2
    .word L639A_63B2
    .word L639A_63C2
    .word L639A_63D2

L639A_63A2:
    .byte $9B, $1F, $01, $80
    .byte $A3, $2F, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80
L639A_63B2:
    .byte $9B, $2A, $01, $80
    .byte $9B, $2B, $01, $88
    .byte $A3, $3A, $01, $80
    .byte $AB, $3F, $01, $80
L639A_63C2:
    .byte $9B, $0C, $01, $80
    .byte $A3, $1C, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80
L639A_63D2:
    .byte $9B, $4A, $01, $80
    .byte $9B, $4B, $01, $88
    .byte $A3, $5A, $01, $80
    .byte $AB, $3F, $01, $80

L63E2:
    .word L63E2_63EE
    .word L63E2_6424
    .word L63E2_645A
    .word L63E2_6490
    .word L63E2_64C6
    .word L63E2_64FC

L63E2_63EE:
    .byte $93, $00, $70
    .byte $93, $01, $78
    .byte $93, $80, $80
    .byte $9B, $10, $70
    .byte $9B, $11, $78
    .byte $9B, $90, $80
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $22, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $32, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80
    .byte $BB, $50, $70
    .byte $BB, $51, $78
    .byte $BB, $D0, $80
L63E2_6424:
    .byte $93, $02, $70
    .byte $93, $03, $78
    .byte $93, $04, $80
    .byte $9B, $12, $70
    .byte $9B, $13, $78
    .byte $9B, $14, $80
    .byte $A3, $05, $70
    .byte $A3, $06, $78
    .byte $A3, $07, $80
    .byte $AB, $15, $70
    .byte $AB, $16, $78
    .byte $AB, $17, $80
    .byte $B3, $08, $70
    .byte $B3, $09, $78
    .byte $B3, $88, $80
    .byte $BB, $18, $70
    .byte $BB, $19, $78
    .byte $BB, $98, $80
L63E2_645A:
    .byte $93, $00, $70
    .byte $93, $01, $78
    .byte $93, $34, $80
    .byte $9B, $10, $70
    .byte $9B, $11, $78
    .byte $9B, $44, $80
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $33, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $43, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80
    .byte $BB, $50, $70
    .byte $BB, $51, $78
    .byte $BB, $D0, $80
L63E2_6490:
    .byte $93, $00, $70
    .byte $93, $01, $78
    .byte $93, $34, $80
    .byte $9B, $53, $70
    .byte $9B, $54, $78
    .byte $9B, $55, $80
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $22, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $32, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80
    .byte $BB, $50, $70
    .byte $BB, $51, $78
    .byte $BB, $D0, $80
L63E2_64C6:
    .byte $93, $0D, $70
    .byte $93, $0E, $78
    .byte $93, $0F, $80
    .byte $9B, $1D, $70
    .byte $9B, $1E, $78
    .byte $A3, $2D, $70
    .byte $A3, $2E, $78
    .byte $AB, $3D, $70
    .byte $AB, $3E, $78
    .byte $B3, $4D, $70
    .byte $B3, $4E, $78
    .byte $B3, $4F, $80
    .byte $BB, $5D, $70
    .byte $BB, $5E, $78
    .byte $BB, $5F, $80
    .byte $9B, $29, $80
    .byte $A3, $39, $80
    .byte $AB, $4C, $80
L63E2_64FC:
    .byte $93, $0D, $70
    .byte $93, $0E, $78
    .byte $93, $0F, $80
    .byte $9B, $0A, $70
    .byte $9B, $0B, $78
    .byte $A3, $1A, $70
    .byte $A3, $1B, $78
    .byte $AB, $3D, $70
    .byte $AB, $3E, $78
    .byte $B3, $4D, $70
    .byte $B3, $4E, $78
    .byte $B3, $4F, $80
    .byte $BB, $5D, $70
    .byte $BB, $5E, $78
    .byte $BB, $5F, $80
    .byte $9B, $2C, $80
    .byte $A3, $3C, $80
    .byte $AB, $4C, $80



L6532:
    ldy #$00
    L6534:
        lda L6540,y
        sta $0270,y
        iny
        cpy #$9C
        bne L6534
    rts

; copied to oam ($0270-$030C, slightly out of bounds)
L6540:
    .byte $08, $23, $22, $10
    .byte $68, $23, $23, $60
    .byte $00, $23, $22, $60
    .byte $7F, $23, $23, $6A
    .byte $7F, $23, $22, $D4
    .byte $33, $23, $23, $B2
    .byte $93, $23, $22, $47
    .byte $B3, $23, $23, $95
    .byte $0B, $23, $22, $E2
    .byte $1C, $23, $23, $34
    .byte $84, $23, $22, $18
    .byte $B2, $23, $23, $EE
    .byte $40, $23, $22, $22
    .byte $5A, $23, $23, $68
    .byte $1A, $23, $22, $90
    .byte $AA, $23, $23, $22
    .byte $81, $24, $22, $88
    .byte $6A, $24, $23, $D0
    .byte $A8, $24, $22, $A0
    .byte $10, $24, $23, $70
    .byte $15, $25, $22, $42
    .byte $4A, $25, $23, $7D
    .byte $30, $25, $22, $50
    .byte $5A, $25, $23, $49
    .byte $50, $25, $22, $B9
    .byte $91, $25, $23, $B0
    .byte $19, $25, $22, $C0
    .byte $53, $25, $23, $BA
    .byte $A4, $25, $22, $D6
    .byte $98, $25, $23, $1A
    .byte $68, $25, $22, $0C
    .byte $97, $25, $23, $EA
    .byte $33, $25, $22, $92
    .byte $43, $25, $23, $65
    .byte $AC, $25, $22, $4A
    .byte $2A, $25, $23, $71
    .byte $7C, $26, $22, $B2
    .byte $73, $26, $23, $E7
    .byte $0C, $26, $22, $AA



L65DC:
    jsr L65E7
    lda #$28
    ldx #$FF
    ldy #$00
    beq L65ED
L65E7:
    lda #$20
    ldx #$FF
    ldy #$00
L65ED:
    stx $02
    sty $03
    sta $01
    lda $2002
    lda $FF
    and #$FB
    sta $2000
    sta $FF
    lda $01
    sta $2006
    lda #$00
    sta $2006
    ldx #$04
    ldy #$00
    lda $02
L660F:
    sta $2007
    dey
    bne L660F
    dex
    bne L660F
    lda $01
    clc
    adc #$03
    sta $2006
    lda #$C0
    sta $2006
    ldy #$40
    lda $03
L6629:
    sta $2007
    dey
    bne L6629
    rts
L6630:
    ldy #$00
    lda #$F4
L6634:
    sta $0200,y
    dey
    bne L6634
L663A:
    rts
L663B:
    lda $34
    beq L663A
    asl a
    tay
    lda EndGamePalPntrTbl-1,y
    ldx EndGamePalPntrTbl-2,y
    tay
    jsr L671E
    lda #$3F
    sta $2006
    lda #$00
    sta $2006
    sta $2006
    sta $2006
    rts

EndGamePalPntrTbl: ;($665C)
    .word EndGamePal00
    .word EndGamePal01
    .word EndGamePal02
    .word EndGamePal03
    .word EndGamePal04
    .word EndGamePal05
    .word EndGamePal06
    .word EndGamePal07
    .word EndGamePal08
    .word EndGamePal09
    .word EndGamePal0A

L6672:
    ldx #$01
    stx $4016
    dex
    txa
    sta $4016
    jsr L6680
    inx
L6680:
    ldy #$08
L6682:
    pha
    lda $4016,x
    sta $00
    lsr a
    ora $00
    lsr a
    pla
    rol a
    dey
    bne L6682
    ldy $40,x
    sty $00
    cmp $48,x
    bne L66A6
    inc $4A,x
    ldy $4A,x
    cpy #$03
    bcc L66AC
    sta $4C,x
    jmp L66A8
L66A6:
    sta $48,x
L66A8:
    lda #$00
    sta $4A,x
L66AC:
    lda $4C,x
    sta $40,x
    eor $00
    and $40,x
    sta $42,x
    sta $44,x
    ldy #$40
    lda $40,x
    cmp $00
    bne L66C8
    dec $46,x
    bne L66CA
    sta $44,x
    ldy #$08
L66C8:
    sty $46,x
L66CA:
    rts
L66CB:
    lda $31
    beq L66E0
    ldx #$61
    ldy #$06
    jsr L671E
    lda #$00
    sta $0660
    sta $0661
    sta $31
L66E0:
    lda $FF
    and #$FB
    sta $FF
    sta $2000
    rts
L66EA:
    ldx #$03
    dec $28
    bpl L66F6
    lda #$0A
    sta $28
    ldx #$05
L66F6:
    lda $29,x
    beq L66FC
    dec $29,x
L66FC:
    dex
    bpl L66F6
    rts



ENDPGM_ChooseRoutine:
    stx $E0
    sty $E1
    asl a
    tay
    iny
    pla
    sta $14
    pla
    sta $15
    lda ($14),y
    tax
    iny
    lda ($14),y
    sta $15
    stx $14
    ldx $E0
    ldy $E1
    jmp ($0014)



L671E:
    stx $00
    sty $01
    jmp L6761



L6725:
    sta $2006
    iny
    lda ($00),y
    sta $2006
    iny
    lda ($00),y
    asl a
    pha
    lda $FF
    ora #$04
    bcs L673B
    and #$FB
L673B:
    sta $2000
    sta $FF
    pla
    asl a
    bcc L6747
    ora #$02
    iny
L6747:
    lsr a
    lsr a
    tax
L674A:
    bcs L674D
    iny
L674D:
    lda ($00),y
    sta $2007
    dex
    bne L674A
    sec
    tya
    adc $00
    sta $00
    lda #$00
    adc $01
    sta $01
L6761:
    ldx $2002
    ldy #$00
    lda ($00),y
    bne L6725
L676A:
    pha
    lda #$00
    sta $2005
    lda $FC
    sta $2005
    pla
    rts
L6777:
    lda $0618
    clc
    adc #$0F
    adc $0619
    adc $061A
    adc $061B
    sta $0618
    lda $0619
    adc #$11
    sta $0619
    eor $0618
    clc
    bpl L6798
    sec
L6798:
    ror $061A
    ror $061B
    lda $0618
    rts
    stx $0660
    lda #$00
    sta $0661,x
    lda #$01
    sta $31
    rts
    sta $0661,x
    inx
    txa
    cmp #$55
    bcc L67C2
    ldx $0660
L67BB:
    lda #$00
    sta $0661,x
    beq L67BB
L67C2:
    rts



EndGamePal00:
    PPUString $3F00, undefined, \
        $0F, $21, $11, $02, $0F, $29, $1B, $1A, $0F, $27, $28, $29, $0F, $28, $18, $08, \
        $0F, $16, $19, $27, $0F, $36, $15, $17, $0F, $12, $21, $20, $0F, $35, $12, $16
    PPUStringEnd
    
EndGamePal01:
    PPUString $3F19, undefined, \
        $10, $20, $30, $0F, $0F, $0F, $0F
    PPUStringEnd
    
EndGamePal02:
    PPUString $3F19, undefined, \
        $12, $22, $32, $0F, $0B, $1B, $2B
    PPUStringEnd
    
EndGamePal03:
    PPUString $3F19, undefined, \
        $14, $24, $34, $0F, $09, $19, $29
    PPUStringEnd
    
EndGamePal04:
    PPUString $3F19, undefined, \
        $16, $26, $36, $0F, $07, $17, $27
    PPUStringEnd
    
EndGamePal05:
    PPUString $3F19, undefined, \
        $18, $28, $38, $0F, $05, $15, $25
    PPUStringEnd
    
EndGamePal06:
    PPUString $3F19, undefined, \
        $1A, $2A, $3A, $0F, $03, $13, $13
    PPUStringEnd
    
EndGamePal07:
    PPUString $3F19, undefined, \
        $1C, $2C, $3C, $0F, $01, $11, $21
    PPUStringEnd
    
EndGamePal08:
    PPUString $3F0D, undefined, \
        $18, $08, $07
    PPUString $3F11, undefined, \
        $26, $05, $07, $0F, $26, $05, $07, $0F, $01, $01, $05, $0F, $13, $1C, $0C
    PPUStringEnd
    
EndGamePal09:
    PPUString $3F0D, undefined, \
        $08, $07, $0F
    PPUString $3F11, undefined, \
        $06, $08, $0F, $0F, $06, $08, $0F, $0F, $00, $10, $0F, $0F, $01, $0C, $0F
    PPUStringEnd
    
EndGamePal0A:
    PPUStringRepeat $3F0D, undefined, $0F, $03
    PPUStringRepeat $3F11, undefined, $0F, $0F
    PPUStringEnd



L686F:
    PPUString $2300, undefined, \
        $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, \
        $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31
    PPUString $2320, undefined, \
        $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, \
        $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33
    PPUString $2340, undefined, \
        $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, \
        $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35
    PPUString $2360, undefined, \
        $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, \
        $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37
    PPUString $2380, undefined, \
        $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, \
        $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39
    PPUString $23A0, undefined, \
        $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, \
        $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B
    PPUStringRepeat $23F0, charmap_ending, " ", $10
    PPUString $282E, charmap_ending, \
        "STAFF"
    PPUString $28A8, charmap_ending, \
        "SCENARIO WRITTEN BY"
    PPUString $28EE, charmap_ending, \
        "KANOH"
    PPUString $2966, charmap_ending, \
        "CHARACTER DESIGNED BY"
    PPUString $29AC, charmap_ending, \
        "KIYOTAKE"
    PPUString $2A2B, charmap_ending, \
        "NEW MATSUOKA"
    PPUString $2A6C, charmap_ending, \
        "SHIKAMOTO"
    PPUString $2AEC, charmap_ending, \
        "MUSIC BY"
    PPUString $2B2B, charmap_ending, \
        "HIP TANAKA"
    PPUString $2BA7, charmap_ending, \
        "MAIN PROGRAMMED BY"
    PPUStringEnd
    
EndMessageStringTbl0: ;($69D7)
    .word EndMessageStringTbl0_69DF
    .word EndMessageStringTbl0_6A08
    .word EndMessageStringTbl0_6A30
    .word EndMessageStringTbl0_6A61

EndMessageStringTbl0_69DF:
    PPUString $206D, charmap_ending, \
        "GREAT !!"
    PPUString $20C3, charmap_ending, \
        "YOU FULFILED YOUR MISSION."
    PPUStringEnd
    
EndMessageStringTbl0_6A08:
    PPUString $2103, charmap_ending, \
        "IT WILL REVIVE PEACE IN"
    PPUString $2142, charmap_ending, \
        "THE SPACE."
    PPUStringEnd

EndMessageStringTbl0_6A30:
    PPUString $2183, charmap_ending, \
        "BUT,IT MAY BE INVADED BY"
    PPUString $21C2, charmap_ending, \
        "THE OTHER METROID."
    PPUStringEnd
    
EndMessageStringTbl0_6A61:
    PPUString $2203, charmap_ending, \
        "PRAY FOR A TRUE PEACE IN"
    PPUString $2242, charmap_ending, \
        "THE SPACE!"
    PPUStringEnd

EndMessageStringTbl1: ;($6A8A)
    .word EndMessageStringTbl1_6A92
    .word EndMessageStringTbl1_6A9B
    .word EndMessageStringTbl1_6AA4
    .word EndMessageStringTbl1_6AAD
    
EndMessageStringTbl1_6A92:
    PPUStringRepeat $206D, charmap_ending, " ", $08
    PPUStringRepeat $20C3, charmap_ending, " ", $1A
    PPUStringEnd

EndMessageStringTbl1_6A9B:
    PPUStringRepeat $2103, charmap_ending, " ", $17
    PPUStringRepeat $2142, charmap_ending, " ", $0A
    PPUStringEnd

EndMessageStringTbl1_6AA4:
    PPUStringRepeat $2183, charmap_ending, " ", $18
    PPUStringRepeat $21C2, charmap_ending, " ", $12
    PPUStringEnd

EndMessageStringTbl1_6AAD:
    PPUStringRepeat $2203, charmap_ending, " ", $18
    PPUStringRepeat $2242, charmap_ending, " ", $0A
    PPUStringEnd

CreditsPointerTbl: ;($6AB6)
    .word PPUString_Credits00
    .word PPUString_Credits01
    .word PPUString_Credits02
    .word PPUString_Credits03
    .word PPUString_Credits04
    .word PPUString_Credits05
    .word PPUString_Credits06
    .word PPUString_Credits07
    .word PPUString_Credits08
    .word PPUString_Credits09
    .word PPUString_Credits0A
    .word PPUString_Credits0B
    .word PPUString_Credits0C
    .word PPUString_Credits0D
    .word PPUString_Credits0E
    .word PPUString_Credits0F
    .word PPUString_Credits10
    .word PPUString_Credits11
    .word PPUString_Credits12
    .word PPUString_Credits13
    .word PPUString_Credits14
    .word PPUString_Credits15
    .word PPUString_Credits16
    .word PPUString_Credits17
    .word PPUString_Credits18
    .word PPUString_Credits19
    .word PPUString_Credits1A
    .word PPUString_Credits1B
    .word PPUString_Credits1C
    .word PPUString_Credits1D
    .word PPUString_Credits1E
    .word PPUString_Credits1F
    .word PPUString_Credits20
    .word PPUString_Credits21
    .word PPUString_Credits22
    .word PPUString_Credits23
    .word PPUString_Credits24
    .word PPUString_Credits25
    .word PPUString_Credits24
    .word PPUString_Credits25
    .word PPUString_Credits28
    .word PPUString_Credits29
    .word PPUString_Credits28
    .word PPUString_Credits29

PPUString_Credits00:
    ;Writes credits on name table 0 in row $2020 (2nd row from top).
    PPUString $202C, charmap_ending, \
        "HAI YUKAMI"

    ;Clears attribute table 0 starting at $23C0.
    PPUStringRepeat $23C0, charmap_ending, $00, $20

    PPUStringEnd

PPUString_Credits01:
    ;Writes credits on name table 0 in row $2060 (4th row from top)
    PPUString $206A, charmap_ending, \
        "ZARU SOBAJIMA"

    ;Writes credits on name table 0 in row $20A0 (6th row from top).
    PPUString $20AB, charmap_ending, \
        "GPZ SENGOKU"

    PPUStringEnd

PPUString_Credits02:
    PPUStringEnd

PPUString_Credits03:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    PPUString $216A, charmap_ending, \
        "N.SHIOTANI"

    ;Clears attribute table 0 starting at $23E0
    PPUStringRepeat $23E0, charmap_ending, $00, $20

    PPUStringEnd

;Writes credits on name table 0 in row $21E0 (16th row from top).
PPUString_Credits04:
    PPUString $21EB, charmap_ending, \
        "M.HOUDAI"

    PPUStringEnd

PPUString_Credits05:
    ;Writes credits on name table 0 in row $22A0 (22nd row from top).
    PPUString $22A7, charmap_ending, \
        "SPECIAL THANKS  TO"

    PPUStringEnd

PPUString_Credits06:
    ;Writes credits on name table 0 in row $22E0 (24nd row from top).
    PPUString $22EC, charmap_ending, \
        "KEN ZURI"

    ;Writes credits on name table 0 in row $2320 (26nd row from top).
    PPUString $232E, charmap_ending, \
        "SUMI"

    PPUStringEnd

PPUString_Credits07:
    ;Writes credits on name table 0 in row $2360 (28nd row from top).
    PPUString $236C, charmap_ending, \
        "INUSAWA"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    PPUString $23AD, charmap_ending, \
        "KACHO"

    PPUStringEnd

PPUString_Credits08:
    ;Writes credits on name table 2 in row $2820 (2nd row from top).
    PPUStringRepeat $2828, charmap_ending, " ", $0E

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    PPUString $286C, charmap_ending, \
        "HYAKKAN"

    PPUStringEnd

PPUString_Credits09:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    PPUString $28A8, charmap_ending, \
        "     GOYAKE        "

    ;Writes credits on name table 2 in row $28E0 (8th row from top).
    PPUStringRepeat $28E8, charmap_ending, " ", $0F

    PPUStringEnd

PPUString_Credits0A:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    PPUString $292C, charmap_ending, \
        "HARADA "

    PPUStringEnd

PPUString_Credits0B:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    PPUString $2966, charmap_ending, \
        "       PENPEN         "

    ;Writes credits on name table 2 in row $29A0 (14th row from top).
    PPUStringRepeat $29A8, charmap_ending, " ", $0F

    PPUStringEnd

PPUString_Credits0C:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    PPUString $29EA, charmap_ending, \
        "TOHRYU  MAKO"

    PPUStringEnd

PPUString_Credits0D:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    PPUString $2A26, charmap_ending, \
        "       BENKEI    "

    ;Writes credits on name table 2 in row $2A60 (20th row from top).
    PPUStringRepeat $2A67, charmap_ending, " ", $11

    PPUStringEnd

PPUString_Credits0E:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    PPUString $2AEB, charmap_ending, \
        "ASSISTED BY"

    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    PPUString $2B28, charmap_ending, \
        "   MAKOTO KANOH"

    PPUStringEnd

PPUString_Credits0F:
    ;Writes credits on name table 2 in row $2BA0 (bottom row).
    PPUStringRepeat $2BA6, charmap_ending, " ", $13

    PPUStringEnd

PPUString_Credits10:
    ;Writes credits on name table 0 in row $2020 (2nd row from the top).
    PPUString $202B, charmap_ending, \
        "DIRECTED BY"

    PPUStringEnd

PPUString_Credits11:
    ;Writes credits on name table 0 in row $2060 (4th row from the top).
    PPUString $2067, charmap_ending, \
        "     YAMAMOTO       "

    ;Writes credits on name table 0 in row $20A0 (6th row from the top).
    PPUStringRepeat $20AA, charmap_ending, " ", $0E

    PPUStringEnd

PPUString_Credits12:
    ;Writes credits on name table 0 in row $2120 (10th row from the top).
    PPUString $2127, charmap_ending, \
        "CHIEF DIRECTED BY"

    ;Writes credits on name table 0 in row $2160 (12th row from the top).
    PPUString $2168, charmap_ending, \
        "  SATORU OKADA   "

    PPUStringEnd

PPUString_Credits13:
    ;Writes credits on name table 0 in row $21E0 (16th row from the top).
    PPUStringRepeat $21E6, charmap_ending, " ", $18

    PPUStringEnd

PPUString_Credits14:
    ;Writes credits on name table 0 in row $2220 (18th row from the top).
    PPUString $222B, charmap_ending, \
        "PRODUCED BY     "

    ;Writes credits on name table 0 in row $2260 (20th row from the top).
    PPUString $226A, charmap_ending, \
        "GUNPEI YOKOI"

    PPUStringEnd

PPUString_Credits15:
    ;Writes credits on name table 0 in row $22A0 (22nd row from the top).
    PPUStringRepeat $22A6, charmap_ending, " ", $13

    ;Writes credits on name table 0 in row $22E0 (24th row from the top).
    PPUStringRepeat $22E8, charmap_ending, " ", $0F

    PPUStringEnd

PPUString_Credits16:
    ;Writes credits on name table 0 in row $2320 (26th row from the top).
    PPUStringRepeat $2329, charmap_ending, " ", $0D

    ;Writes credits on name table 0 in row $2340 (27th row from the top).
    PPUString $234B, charmap_ending, \
        "COPYRIGHT"

    PPUStringEnd

PPUString_Credits17:
    ;Writes credits on name table 0 in row $2360 (28th row from the top).
    PPUStringRepeat $236B, charmap_ending, " ", $0A

    ;Writes credits on name table 0 in row $2380 (29th row from the top).
    PPUString $238E, charmap_ending, \
        "1986"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    PPUStringRepeat $23A8, charmap_ending, " ", $0F

    PPUStringEnd

PPUString_Credits18:
    ;Writes credits on name table 2 in row $2800 (top row)
    PPUString $280C, charmap_ending, \
        "NINTENDO"

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    PPUStringRepeat $2866, charmap_ending, " ", $11

    PPUStringEnd

PPUString_Credits19:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    PPUStringRepeat $28AA, charmap_ending, " ", $0C

    PPUStringEnd

PPUString_Credits1A:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    PPUStringRepeat $2926, charmap_ending, " ", $1B

    PPUStringEnd

PPUString_Credits1B:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    PPUStringRepeat $2967, charmap_ending, " ", $12

    PPUStringEnd

PPUString_Credits1C:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    PPUStringRepeat $29E6, charmap_ending, " ", $14

    PPUStringEnd

PPUString_Credits1D:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    PPUStringRepeat $2A28, charmap_ending, " ", $15

    PPUStringEnd

PPUString_Credits1E:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    PPUStringRepeat $2AE6, charmap_ending, " ", $10

    PPUStringEnd

PPUString_Credits1F:
    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    PPUStringRepeat $2B29, charmap_ending, " ", $0E

PPUString_Credits20:
    PPUStringEnd

;Writes the top half of 'The End' on name table 0 in row $2020 (2nd row from top).
PPUString_Credits21:
    PPUString $2026, charmap_ending, \
        "     ", $24, $25, $26, $27, "  ", $2C, $2D, $2E, $2F, "     "

    PPUStringEnd

;Writes the bottom half of 'The End' on name table 0 in row $2040 (3rd row from top).
PPUString_Credits22:
    PPUString $204B, charmap_ending, \
        $28, $29, $2A, $2B, "  ", $02, $03, $04, $05

    ;Writes credits on name table 0 in row $2060 (4th row from top).
    PPUStringRepeat $206A, charmap_ending, " ", $0C

    PPUStringEnd

PPUString_Credits23:
    ;Writes credits on name table 0 in row $2120 (10th row from top).
    PPUStringRepeat $2126, charmap_ending, " ", $13

    PPUStringEnd

PPUString_Credits24:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    PPUStringRepeat $216A, charmap_ending, " ", $0C

    PPUStringEnd

PPUString_Credits25:
    ;Writes credits on name table 0 in row $2180 (13th row from top).
    PPUString $2188, charmap_ending, \
        "PUSH START BUTTON"

PPUString_Credits28:
    ;Writes credits on name table 0 in row $2220 (18th row from top).
    PPUStringRepeat $2226, charmap_ending, " ", $0B

    PPUStringEnd

PPUString_Credits29:
    PPUStringEnd

L6D63:
    .byte $60, $A6, $27, $D0, $1C, $20, $BE, $6D, $AD, $16, $B4, $C9, $C2, $D0, $12, $AD
    .byte $17, $B4, $E9, $01, $D0, $0B, $8D, $16, $B4, $8D, $17, $B4, $A2

