
LD000:
    ldx #$00
    stx $01
    jsr LD00B
    ldx $2B
    inc $01
LD00B:
    ldy #$01
    sty $4016
    dey
    sty $4016
    ldy #$08
LD016:
    pha
    lda $4016,x
    sta $00
    lsr a
    ora $00
    lsr a
    pla
    rol a
    dey
    bne LD016
    ldx $01
    ldy $14,x
    sty $00
    sta $14,x
    eor $00
    beq LD039
    lda $00
    and #$BF
    sta $00
    eor $14,x
LD039:
    and $14,x
    sta $12,x
    sta $16,x
    ldy #$20
    lda $14,x
    cmp $00
    bne LD04F
    dec $18,x
    bne LD051
    sta $16,x
    ldy #$10
LD04F:
    sty $18,x
LD051:
    rts
    lda $FE
    and #$E7
LD056:
    sta $FE
    jsr $95A1
LD05B:
    lda $1A
    beq LD05B
    rts
    lda $FF
    and #$F7
    ora #$10
    sta $FF
    lda $FE
    ora #$18
    bne LD056
    lda $FF
    sta $2000
    lda $FE
    sta $2001
    lda $73
    sta $FB
    sta $4025
    rts

LD080:
    .byte $00, $10, $01, $18, $00, $01, $38, $01, $02, $40, $00, $09, $58, $18, $7F, $0F
    .byte $A0, $0D, $7F, $0F, $08, $1B, $7F, $0B, $18, $89, $7F, $67, $18, $8B, $7F, $FD
    .byte $28, $02, $7F, $A8, $F8, $F6, $83, $58, $78, $96, $8C, $40, $B9, $1D, $9A, $20
    .byte $8F, $16, $8D, $E0, $42, $9A, $7F, $D8, $28, $9A, $7F, $E0, $28, $E0, $D0, $27
    .byte $D1, $01, $F0, $D0, $D8, $D2, $01, $00, $D1, $35, $D1, $02, $10, $D1, $D8, $D2
    .byte $02, $A8, $D8, $D8, $D2, $04, $B8, $D8, $DD, $D8, $00, $B8, $D8, $CF, $D8, $00
    .byte $68, $D3, $82, $D3, $B7, $D3, $AA, $D3, $BE, $D3, $A4, $D3, $9E, $D3, $C4, $D3
    .byte $4B, $D3, $6E, $D3, $88, $D3, $88, $D3, $88, $D3, $88, $D3, $88, $D3, $CA, $D3
    .byte $C3, $D4, $E2, $D3, $A0, $D4, $AD, $DE, $AD, $DE, $11, $D5, $44, $D4, $3C, $D5
    .byte $D9, $D4, $EE, $D4, $AE, $D4, $C6, $DE, $B6, $DE, $1A, $D5, $52, $D4, $EE, $D4

LD120:
    lda $0681
    ldx #$BD
    bne LD13A
    lda $0689
    ldx #$C2
    bne LD13A
LD12E:
    lda $0682
    ldx #$C7
    bne LD13A
    lda $068A
    ldx #$CC
LD13A:
    jsr LD2A7
    jmp ($00E2)
LD140:
    lda $0684
    ldx #$D1
    jsr LD2A7
    jsr LDD8E
    jsr LDD9F
    jmp ($00E2)
LD151:
    lda #$00
    beq LD157
LD155:
    lda #$0C
LD157:
    sta $E0
    lda #$40
    sta $E1
    sty $E2
    lda #$D0
    sta $E3
    ldy #$00
LD165:
    lda ($E2),y
    sta ($E0),y
    iny
    tya
    cmp #$04
    bne LD165
    rts
LD170:
    inc $0602
    jsr LD229
    sta $0603
    rts
LD17A:
    lda $0680
    and #$FD
    sta $0680
    lda $0602
    beq LD170
    lda #$00
    sta $0602
LD18C:
    lda #$C0
    sta $4017
    lda $0680
    lsr a
    bcs LD1C3
    lsr a
    bcs LD17A
    lda $0602
    bne LD1C8
    jsr LD304
    jsr LD140
    jsr LD12E
    jsr LD120
    jsr LD8C8
    jsr LD7B8
LD1B1:
    lda #$00
    sta $0680
    sta $0681
    sta $0682
    sta $0684
    sta $0685
    rts
LD1C3:
    jsr LD1F2
    beq LD1B1
LD1C8:
    lda $0603
    cmp #$12
    beq LD1DD
    and #$03
    cmp #$03
    bne LD1DA
    ldy #$99
    jsr LD151
LD1DA:
    inc $0603
LD1DD:
    rts
LD1DE:
    lda $062C
    beq LD1F2
    lda $068D
    sta $065D
    rts
LD1EA:
    lda $068D
    cmp $064D
    beq LD1F8
LD1F2:
    jsr LD20B
    jsr LD229
LD1F8:
    jsr LD1FC
    rts
LD1FC:
    lda #$00
    sta $062D
    sta $0602
    sta $065D
    sta $062C
    rts
LD20B:
    lda #$00
    sta $0653
    sta $0656
    sta $0615
    sta $0607
    sta $0688
    sta $0689
    sta $068A
    sta $068C
    sta $068D
    rts
LD229:
    jsr LD240
    lda #$10
    sta $4000
    sta $4004
    sta $400C
    lda #$00
    sta $4008
    sta $4011
    rts
LD240:
    lda #$80
    sta $4080
    rts
LD246:
    ldx $065C
    sta $0660,x
    txa
    beq LD261
    cmp #$01
    beq LD258
    cmp #$02
    beq LD25E
    rts
LD258:
    jsr LD151
    jmp LD264
LD25E:
    jmp LD264
LD261:
    jsr LD155
LD264:
    jsr LD27D
    txa
    sta $0652,x
    lda #$00
    sta $0665,x
    sta $0670,x
    sta $0674,x
    sta $0678,x
    sta $0607
    rts
LD27D:
    ldx $065C
    lda $0688,x
    and #$00
    ora $064D
    sta $0688,x
    rts
LD28C:
    lda #$00
    sta $064D
    beq LD27D
LD293:
    ldx $065C
    inc $0665,x
    lda $0665,x
    cmp $0660,x
    bne LD2A6
    lda #$00
    sta $0665,x
LD2A6:
    rts
LD2A7:
    sta $064D
    stx $E4
    ldy #$D0
    sty $E5
    ldy #$00
LD2B2:
    lda ($E4),y
    sta $00E0,y
    iny
    tya
    cmp #$04
    bne LD2B2
    lda ($E4),y
    sta $065C
    ldy #$00
    lda $064D
    pha
LD2C8:
    asl $064D
    bcs LD2D9
    iny
    iny
    tya
    cmp #$10
    bne LD2C8
LD2D4:
    pla
    sta $064D
    rts
LD2D9:
    lda ($E0),y
    sta $E2
    iny
    lda ($E0),y
    sta $E3
    jmp LD2D4
LD2E5:
    inc $0670
    lda $0670
    sta $400E
    rts
LD2EF:
    lda #$16
    ldy #$8D
    jsr LD32D
    lda #$0A
    sta $0670
    rts
LD2FC:
    jsr LD293
    bne LD2E5
    jmp LD335
LD304:
    lda #$00
    sta $065C
    lda $0680
    sta $064D
    asl a
    asl a
    asl a
    bcs LD2EF
    asl a
    bcs LD329
    asl a
    bcs LD33E
    lda $0688
    and #$20
    bne LD2FC
    lda $0688
    and #$DC
    bne LD330
    rts
LD329:
    lda #$30
    ldy #$91
LD32D:
    jmp LD246
LD330:
    jsr LD293
    bne LD33D
LD335:
    jsr LD28C
    lda #$10
    sta $400C
LD33D:
    rts
LD33E:
    lda #$03
    ldy #$95
    bne LD32D
    lda $7E8D,x
    lsr $3E46,x
    .byte $00
    jsr LD293
    bne LD367
    ldy $0671
    lda $D344,y
    bne LD35B
    jmp LD38D
LD35B:
    sta $4002
    lda $D0A0
    sta $4003
    inc $0671
LD367:
    rts
    lda #$05
    ldy #$9D
    bne LD3BB
    jsr LD293
    bne LD367
    inc $0671
    lda $0671
    cmp #$03
    beq LD38D
    ldy #$99
    jmp LD151
    lda #$06
    ldy #$99
    bne LD3BB
    jsr LD293
    bne LD367
LD38D:
    lda #$10
    sta $4000
    lda #$00
    sta $0653
    jsr LD28C
    inc $0607
    rts
    lda #$0C
    ldy #$A9
    bne LD3BB
    lda #$08
    ldy #$AD
    bne LD3BB
    lda $0689
    and #$CC
    bne LD367
    lda #$06
    ldy #$A5
    bne LD3BB
    lda #$0B
    ldy #$A1
LD3BB:
    jmp LD246
    lda #$16
    ldy #$B1
    bne LD3BB
    lda #$04
    ldy #$B5
    bne LD3BB
    jsr LD293
    bne LD3E1
    inc $0671
    lda $0671
    cmp #$02
    bne LD3DC
    jmp LD38D
LD3DC:
    ldy #$B9
    jsr LD151
LD3E1:
    rts

LD3E2:
    lda $0615
    bne LD3E1
    lda $28
    and #$03
    ora #$03
    ldx #<DataDD0E_D3F4.b
    ldy #>DataDD0E_D3F4.b
    jmp LDD0E

DataDD0E_D3F4:
    .word LDB2C
    .word LDBAE
    .byte $00, $A0, $00, $07, $00, $A0, $A0, $A8, $02

DataDD0E_D401:
    .word LDB2C
    .word LDB6E
    .byte $A0, $A0, $00, $10, $00, $A0, $0A, $E0, $01

DataDD0E_D40E:
    .word LDB2C
    .word LDC2E
    .byte $82, $47, $00, $06, $00, $87, $87, $02, $00

LD41B:
    lda #$26
    ldx #<DataDD0E_D40E.b
    ldy #>DataDD0E_D40E.b
    jsr LDD0E
    lda #$09
    sta $0676
    lda $D415
    sta $0672
    lda #$08
LD431:
    sta $067E
    lda #$00
    sta $067F
    rts
LD43A:
    lda #$0E
    ldx #<DataDD0E_D401.b
    ldy #>DataDD0E_D401.b
    jsr LDD0E
    rts

LD444:
    lda $0615
    bne LD451
    lda $0686
    beq LD41B
    lsr a
    bcs LD43A
LD451:
    rts
    lda $0686
    beq LD472
    lsr a
    bcc LD451
    jsr LD293
    bne LD462
LD45F:
    jmp LD4F3
LD462:
    inc $0672
    lda $0672
    sta $4086
LD46B:
    jsr LD559
    jsr LD54C
    rts
LD472:
    jsr LD293
    beq LD45F
    lda $0667
    cmp #$19
    bne LD483
    lda #$F7
    sta $0676
LD483:
    lda $0672
    clc
    adc $0676
    sta $0672
    sta $4086
    jmp LD46B

DataDD0E_D493:
    .word LDB2C
    .word LDC2E
    .byte $82, $4A, $00, $70, $00, $80, $60, $10, $00

LD4A0:
    lda #$30
    ldx #<DataDD0E_D493.b
    ldy #>DataDD0E_D493.b
    jsr LDD0E
    lda #$28
    jmp LD431

LD4AE:
    jsr LD293
    bne LD46B
    jmp LD4F3

DataDD0E_D4B6:
    .word LDB4D
    .word LDB6E
    .byte $82, $50, $00

LD4BD:
    jsr $A004
    ldy #$98
    .byte $07
    jsr LD1F2
    lda #$50
    ldx #<DataDD0E_D4B6.b
    ldy #>DataDD0E_D4B6.b
    jsr LDD0E
    lda #$E0
    sta $0672
    lda #$1E
    jmp LD431
    jsr LD293
    beq LD4F3
    jsr LD56D
    jsr LD54C
    dec $0672
    lda $0672
    sta $4086
    rts
    jsr LD293
    bne RTS_D503
LD4F3:
    lda #$80
    sta $4080
    jsr LD28C
    lda #$00
    sta $0656
    sta $0606
RTS_D503:
    rts

DataDD0E_D504:
    .word LDB2C
    .word LDBAE
    .byte $9B, $07, $00, $71, $00, $00, $A0, $F8, $02

LD511:
    lda #$10
    ldx #<DataDD0E_D504.b
    ldy #>DataDD0E_D504.b
    jmp LDD0E
    jsr LD293
    bne LD522
    jmp LD4F3
LD522:
    lda $0672
    clc
    adc #$12
    sta $0672
    sta $4082
RTS_D52E:
    rts

DataDD0E_D52F:
    .word LDB2C
    .word LDBEE
    .byte $00, $A0, $00, $27, $00, $00, $8B, $FF, $07

LD53C:
    lda $068A
    and #$1C
    bne RTS_D52E
    lda #$0E
    ldx #<DataDD0E_D52F.b
    ldy #>DataDD0E_D52F.b
    jmp LDD0E



LD54C:
    lda $067C
    sta $4082
    lda $067D
    sta $4083
    rts



LD559:
    clc
    lda $067C
    adc $067E
    sta $067C
    lda $067D
    adc $067F
    sta $067D
    rts



LD56D:
    sec
    lda $067C
    sbc $067E
    sta $067C
    lda $067D
    sbc $067F
    sta $067D
    rts



LD581:
    lda #$7F
    sta $0648
    sta $0649
    stx $0628
    sty $0629
    rts



LD590:
    lda $0640
    cmp #$01
    bne LD59A
        sta $066A
    LD59A:
    lda $0641
    cmp #$01
    bne @RTS
        sta $066B
    @RTS:
    rts



LD5A5:
    lda $0607
    beq @RTS
    lda #$00
    sta $0607
    lda $0648
    sta $4001
    lda $0600
    sta $4002
    lda $0601
    sta $4003
@RTS:
    rts



LD5C2:
    ldx #$00
    jsr LD5CC
    inx
    jsr LD5CC
    rts

LD5CC:
    lda $062E,x
    beq RTS_D616
    sta $EB
    jsr LD5A5
    lda $066C,x
    cmp #$10
    beq LD624
    ldy #$00
LD5DF:
    dec $EB
    beq LD5E7
    iny
    iny
    bne LD5DF
LD5E7:
    lda $D958,y
    sta $EC
    lda $D959,y
    sta $ED
    ldy $066A,x
    lda ($EC),y
    sta $EA
    cmp #$FF
    beq LD61B
    cmp #$F0
    beq LD620
    lda $0628,x
    and #$F0
    ora $EA
    tay
LD608:
    inc $066A,x
LD60B:
    lda $0653,x
    bne RTS_D616
    txa
    beq LD617
    sty $4004
RTS_D616:
    rts
LD617:
    sty $4000
    rts
LD61B:
    ldy $0628,x
    bne LD60B
LD620:
    ldy #$10
    bne LD60B
LD624:
    ldy #$10
    bne LD608
LD628:
    jsr LD1DE
    rts
LD62C:
    jsr LD5C2
    rts
LD630:
    jsr LD590
    lda #$00
    tax
    sta $064B
    beq LD64D
LD63B:
    txa
    lsr a
    tax
LD63E:
    inx
    txa
    cmp #$04
    beq LD62C
    lda $064B
    clc
    adc #$04
    sta $064B
LD64D:
    txa
    asl a
    tax
    lda $0630,x
    sta $E6
    lda $0631,x
    sta $E7
    lda $0631,x
    beq LD63B
    txa
    lsr a
    tax
    dec $0640,x
    bne LD63E
LD667:
    ldy $0638,x
    inc $0638,x
    lda ($E6),y
    beq LD628
    tay
    cmp #$FF
    beq LD67F
    and #$C0
    cmp #$C0
    beq LD68F
    jmp LD6A7
LD67F:
    lda $0624,x
    beq LD69E
    dec $0624,x
    lda $063C,x
    sta $0638,x
    bne LD69E
LD68F:
    tya
    and #$3F
    sta $0624,x
    dec $0624,x
    lda $0638,x
    sta $063C,x
LD69E:
    jmp LD667
LD6A1:
    jmp LD769
LD6A4:
    jmp LD742
LD6A7:
    tya
    and #$B0
    cmp #$B0
    bne LD6CB
    tya
    and #$0F
    clc
    adc $062B
    tay
    lda $DE29,y
    sta $0620,x
    tay
    txa
    cmp #$02
    beq LD6A4
LD6C2:
    ldy $0638,x
    inc $0638,x
    lda ($E6),y
    tay
LD6CB:
    txa
    cmp #$03
    beq LD6A1
    pha
    ldx $064B
    lda $DDAA,y
    beq LD6E4
    sta $0600,x
    lda $DDA9,y
    ora #$08
    sta $0601,x
LD6E4:
    tay
    pla
    tax
    tya
    bne LD6F9
    lda #$00
    sta $EA
    txa
    cmp #$02
    beq LD6FE
    lda #$10
    sta $EA
    bne LD6FE
LD6F9:
    lda $0628,x
    sta $EA
LD6FE:
    txa
    dec $0653,x
    cmp $0653,x
    beq LD73C
    inc $0653,x
    ldy $064B
    txa
    cmp #$02
    beq LD717
    lda $062E,x
    bne LD71C
LD717:
    lda $EA
    sta $4000,y
LD71C:
    lda $EA
    sta $066C,x
    lda $0600,y
    sta $4002,y
    lda $0601,y
    sta $4003,y
    lda $0648,x
    sta $4001,y
LD733:
    lda $0620,x
    sta $0640,x
    jmp LD63E
LD73C:
    inc $0653,x
    jmp LD733
LD742:
    lda $062D
    and #$0F
    bne LD763
    lda $062D
    and #$F0
    bne LD754
    tya
    jmp LD758
LD754:
    lda #$FF
    bne LD763
LD758:
    clc
    adc #$FF
    asl a
    asl a
    cmp #$3C
    bcc LD763
    lda #$3C
LD763:
    sta $062A
    jmp LD6C2
LD769:
    lda $0688
    and #$FC
    bne LD782
    lda $D080,y
    sta $400C
    lda $D081,y
    sta $400E
    lda $D082,y
    sta $400F
LD782:
    jmp LD733
LD785:
    stx $E0
    sty $E1
    ldy #$00
    lda ($E0),y
    sta $EE
    iny
    lda ($E0),y
    sta $EF
    ldx #$0D
    iny
LD797:
    lda ($E0),y
    sta $060E,y
    iny
    dex
    bne LD797
    ldy #$00
    sty $060C
    sty $0606
    iny
    sty $060A
    rts
LD7AD:
    lda #$00
    sta $0615
    lda #$80
    sta $4080
LD7B7:
    rts
LD7B8:
    lda $0615
    beq LD7B7
    dec $060A
    bne LD7B7
LD7C2:
    ldy $060C
    inc $060C
    lda ($EE),y
    beq LD7AD
    tay
    cmp #$FF
    beq LD7DA
    and #$C0
    cmp #$C0
    beq LD7EA
    jmp LD7FC
LD7DA:
    lda $060D
    beq LD7F9
    dec $060D
    lda $060E
    sta $060C
    bne LD7F9
LD7EA:
    tya
    and #$3F
    sta $060D
    dec $060D
    lda $060C
    sta $060E
LD7F9:
    jmp LD7C2
LD7FC:
    tya
    and #$B0
    cmp #$B0
    bne LD81A
    tya
    and #$0F
    clc
    adc $0614
    tay
    lda $DE29,y
    sta $060B
    ldy $060C
    inc $060C
    lda ($EE),y
    tay
LD81A:
    lda #$00
    sta $EA
    lda $DCAF,y
    beq LD82F
    sta $061D
    lda $DCAE,y
    sta $061E
    jmp LD833
LD82F:
    lda #$FF
    sta $EA
LD833:
    lda $0656
    bne LD891
    lda $0606
    bne LD857
    inc $0606
    ldx $0610
    ldy $0611
    jsr LDAF4
    ldx $0612
    ldy $0613
    jsr LDB11
    lda #$01
    sta $4089
LD857:
    lda $0616
    sta $4084
    lda $0617
    sta $4084
    lda $0618
    sta $4085
    lda $0619
    sta $4086
    lda $061A
    sta $4087
    lda $061B
    sta $4080
    lda $EA
    bne LD898
    lda $061C
LD882:
    sta $4080
    lda $061D
    sta $4082
    lda $061E
    sta $4083
LD891:
    lda $060B
    sta $060A
    rts
LD898:
    lda #$80
    bne LD882 ; branch always

LD89C:
    .byte $41, $8F, $34, $27, $1A, $0D, $00, $82, $68, $75, $4E, $5B, $03, $D9, $F1, $D8
    .byte $10, $D9, $AF, $DE, $D8, $D2, $D8, $D2, $D1, $DF, $B8, $DF, $00, $D9, $EE, $D8
    .byte $EE, $D8, $EE, $D8, $FD, $D8, $FA, $D8, $EE, $D8, $FD, $D8

LD8C8:
    lda $065D
    ldx #$DB
    bne LD8D4
    lda $0685
    ldx #$D6
LD8D4:
    jsr LD2A7
    jsr LDD8E
    jmp ($00E2)
    lda $068D
    beq LD8ED
    jmp LD630
LD8E5:
    lda $068D
    ora #$F0
    sta $068D
LD8ED:
    rts
    jmp LD934
    jsr LD92E
    ldx #$3A
    ldy #$D9
    bne LD90A
    jmp LD92A
    jmp LD926
    jmp LD919
    jsr LD926
    ldx #$49
    ldy #$D9
LD90A:
    jsr LD8E5
    jmp LD785
    jsr LD92E
    ldx #$00
    ldy #$CC
    bne LD90A
LD919:
    lda #$B3
LD91B:
    tax
    tay
LD91D:
    jsr LD581
    jsr LDE4B
    jmp LD630
LD926:
    lda #$34
    bne LD91B
LD92A:
    lda #$F4
    bne LD91B
LD92E:
    ldx #$F5
    ldy #$F6
    bne LD91D
LD934:
    ldx #$92
    ldy #$96
    bne LD91D

LD93A:
    .byte $93, $DA, $2C, $DB, $6E, $DC, $00, $F3, $80, $80, $00, $13, $00, $86, $44, $BC
    .byte $DA, $2C, $DB, $6E, $DC, $0B, $F4, $80, $80, $00, $12, $00, $84, $48, $60, $D9
    .byte $6B, $D9, $75, $D9, $80, $D9, $01, $02, $02, $03, $03, $04, $05, $06, $07, $08
    .byte $FF, $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF, $00, $0D, $09, $07, $06
    .byte $05, $05, $05, $04, $04, $FF, $02, $06, $07, $07, $07, $06, $06, $06, $06, $05
    .byte $05, $05, $04, $04, $04, $03, $03, $03, $03, $02, $03, $03, $03, $03, $03, $02
    .byte $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $F0, $0B
    .byte $FF, $F5, $00, $00, $A4, $DF, $A6, $DF, $79, $DF, $00, $00, $0B, $FF, $00, $02
    .byte $02, $EE, $DE, $C4, $DE, $1A, $DF, $72, $DF, $0B, $FF, $F0, $04, $04, $A0, $DE
    .byte $C6, $DE, $F7, $DE, $2B, $DF, $00, $FF, $F0, $00, $00, $1D, $DF, $1F, $DF, $88
    .byte $DF, $00, $00, $0B, $FF, $03, $00, $00, $52, $DA, $54, $DA, $45, $DA, $00, $00
    .byte $0B, $FF, $F0, $01, $01, $00, $DF, $0F, $DF, $DE, $DE, $00, $00, $17, $00, $00
    .byte $03, $01, $CE, $CD, $C5, $CE, $FE, $CC, $64, $CF, $17, $00, $F0, $04, $04, $B9
    .byte $DE, $BB, $DE, $2F, $DF, $CE, $DF, $0B, $00, $F0, $01, $01, $A2, $DA, $AB, $DA
    .byte $B4, $DA, $00, $00, $00, $00, $F0, $02, $02, $6F, $DA, $7F, $DA, $8E, $DA, $00
    .byte $00, $0B, $FF, $00, $02, $03, $A0, $DE, $F7, $DE, $61, $DF, $CB, $DF, $0B, $FF
    .byte $03, $00, $00, $D6, $DA, $C4, $DA, $DF, $DA, $00, $00, $C8, $B0, $38, $3A, $3C
    .byte $3E, $40, $3E, $3C, $3A, $B6, $02, $FF, $B8, $02, $B3, $02, $B2, $74, $02, $6A
    .byte $02, $72, $02, $62, $B4, $02, $B2, $60, $02, $6C, $02, $76, $B3, $02, $B2, $7E
    .byte $02, $7C, $B3, $02, $00, $B3, $52, $42, $B2, $48, $3E, $38, $3E, $B2, $44, $4C
    .byte $B3, $4C, $B4, $38, $00, $B3, $48, $3A, $B2, $3E, $38, $30, $38, $B2, $3E, $44
    .byte $B3, $42, $B4, $3C, $B4, $2C, $2A, $1E, $1C, $B2, $22, $2C, $30, $34, $38, $30
    .byte $26, $30, $3A, $34, $2C, $26, $B4, $2A, $B3, $3E, $42, $3A, $38, $B4, $34, $34
    .byte $00, $B3, $30, $30, $2C, $26, $20, $B4, $24, $24, $B3, $36, $34, $30, $2A, $B4
    .byte $1C, $1C, $B3, $34, $3A, $34, $30, $B4, $2A, $2A, $B4, $12, $B3, $10, $18, $16
    .byte $0A, $B4, $14, $12, $B3, $10, $06, $0E, $04, $B4, $0C, $00, $E0, $B0, $54, $4E
    .byte $48, $42, $48, $4E, $FF, $E0, $B3, $02, $B0, $3C, $40, $44, $4A, $4E, $54, $58
    .byte $5C, $62, $66, $6C, $70, $74, $7A, $B3, $02, $FF

LDAF4:
    lda #$80
    sta $4087
    stx $E2
    sty $E3
    ldy #$00
LDAFF:
    lda ($E2),y
    cmp #$FF
    beq LDB0B
    sta $4088
    iny
    bne LDAFF
LDB0B:
    lda #$00
    sta $4087
    rts
LDB11:
    lda #$81
    sta $4089
    stx $E2
    sty $E3
    ldy #$FF
LDB1C:
    iny
    lda ($E2),y
    sta $4040,y
    cpy #$3F
    bne LDB1C
    lda #$00
    sta $4089
    rts

LDB2C:
    .byte $07, $07, $07, $07, $07, $07, $07, $07, $01, $01, $01, $01, $01, $01, $01, $01
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $07, $07, $07, $07, $07, $07, $07, $07
    .byte $FF
LDB4D:
    .byte $01, $07, $07, $01, $01, $07, $07, $06, $06, $06, $07, $03, $03, $03, $03, $05
    .byte $05, $05, $05, $03, $03, $03, $03, $05, $05, $05, $03, $03, $05, $05, $03, $01
    .byte $FF

LDB6E:
    .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C, $1E
    .byte $1F, $21, $23, $25, $27, $29, $2B, $2D, $2F, $31, $33, $35, $37, $39, $3B, $3D
    .byte $3F, $3D, $3B, $39, $37, $35, $33, $31, $2F, $2D, $2B, $29, $26, $24, $22, $20
    .byte $1E, $1C, $1A, $18, $16, $14, $12, $10, $0E, $0C, $0A, $08, $06, $04, $02, $00
LDBAE:
    .byte $00, $08, $0E, $13, $17, $1B, $20, $24, $27, $29, $2B, $27, $22, $1E, $1B, $18
    .byte $1D, $24, $2C, $30, $31, $30, $2D, $2B, $29, $28, $27, $26, $25, $24, $23, $22
    .byte $21, $20, $19, $11, $0B, $12, $19, $12, $23, $20, $2F, $34, $37, $3A, $3E, $3F
    .byte $3E, $3A, $34, $30, $2D, $27, $23, $1E, $1B, $16, $13, $0F, $0B, $08, $04, $00
LDBEE:
    .byte $00, $03, $08, $0B, $0F, $13, $17, $1B, $1E, $23, $27, $2B, $2F, $33, $37, $3B
    .byte $3F, $3B, $37, $33, $2F, $2B, $27, $23, $20, $2B, $18, $14, $10, $0C, $08, $04
    .byte $00, $04, $08, $0C, $10, $14, $18, $1C, $20, $24, $28, $2B, $2F, $33, $37, $3B
    .byte $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $3F, $3F
LDC2E:
    .byte $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00
    .byte $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00
    .byte $00, $3B, $3B, $00, $33, $33, $00, $00, $00, $2D, $2D, $00, $00, $23, $23, $00
    .byte $00, $1C, $1C, $00, $00, $14, $14, $00, $00, $0C, $0C, $00, $00, $04, $04, $00
    .byte $00, $3E, $3D, $3C, $3B, $3A, $38, $37, $36, $36, $35, $34, $33, $32, $31, $30
    .byte $2F, $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20
    .byte $1F, $1E, $1D, $1C, $1B, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11, $10
    .byte $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $00
    .byte $07, $F0, $00, $00, $00, $A2, $00, $AC, $00, $C1, $00, $CC, $00, $D8, $00, $E5
    .byte $00, $F3, $01, $01, $01, $11, $01, $21, $01, $32, $01, $44, $01, $58, $01, $6C
    .byte $01, $82, $01, $99, $01, $B1, $01, $CB, $01, $E6, $02, $03, $02, $22, $02, $42
    .byte $02, $65, $02, $89, $02, $B0, $02, $D9, $03, $04, $03, $32, $03, $63, $03, $96
    .byte $03, $CD, $04, $07, $04, $44, $04, $85, $04, $CA, $05, $13, $05, $60, $05, $B2
    .byte $06, $08, $06, $64, $06, $C6, $07, $2D, $07, $9A, $08, $0E, $08, $88, $09, $0A

LDD0E:
    sta $EA
    stx $E0
    sty $E1
    lda $068A
    and #$FC
    bne LDD61
    ldy #$00
    jsr LDD62
    tay
    jsr LDAF4
    ldy #$02
    jsr LDD62
    tay
    jsr LDB11
    ldy #$04
    jsr LDD62
    sta $EB
    iny
    lda ($E0),y
    ldy $EB
    jsr LDD70
    ldy #$07
    jsr LDD62
    jsr LDD69
    iny
    jsr LDD62
    jsr LDD7A
    iny
    jsr LDD62
    jsr LDD81
    lda $EA
    jsr LD246
    lda #$00
    sta $0654
    lda #$05
    sta $0656
LDD61:
    rts
LDD62:
    lda ($E0),y
    tax
    iny
    lda ($E0),y
    rts
LDD69:
    stx $4086
    sta $4087
    rts
LDD70:
    stx $4084
    sty $4084
    sta $4085
    rts
LDD7A:
    stx $4080
    sta $4080
    rts
LDD81:
    stx $4082
    stx $067C
    sta $4083
    sta $067D
    rts
LDD8E:
    lda #$FF
    sta $065E
    lda $064D
    beq LDD9E
LDD98:
    inc $065E
    asl a
    bcc LDD98
LDD9E:
    rts
LDD9F:
    lda $065E
    clc
    adc #$08
    sta $065E
    rts


LDDA9:
    .byte $07, $F0, $00, $00, $06, $4E, $05, $F3, $05, $4D, $05, $01, $04, $B9, $04, $75
    .byte $04, $35, $03, $F8, $03, $BF, $03, $89, $03, $57, $03, $27, $02, $F9, $02, $CF
    .byte $02, $A6, $02, $80, $02, $5C, $02, $3A, $02, $1A, $01, $FC, $01, $DF, $01, $C4
    .byte $01, $AB, $01, $93, $01, $7C, $01, $67, $01, $52, $01, $3F, $01, $2D, $01, $1C
    .byte $01, $0C, $00, $FD, $00, $EE, $00, $E1, $00, $D4, $00, $C8, $00, $BD, $00, $B2
    .byte $00, $A8, $00, $9F, $00, $96, $00, $8D, $00, $85, $00, $7E, $00, $76, $00, $70
    .byte $00, $69, $00, $63, $00, $5E, $00, $58, $00, $53, $00, $4F, $00, $4A, $00, $46
    .byte $00, $42, $00, $3E, $00, $3A, $00, $37, $00, $34, $00, $31, $00, $2E, $00, $27
    .byte $04, $08, $10, $20, $40, $18, $30, $0C, $0B, $05, $02, $06, $0C, $18, $30, $60
    .byte $24, $48, $12, $10, $08, $03, $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12
    .byte $02, $03


LDE4B:
    jsr LD1EA
    lda $064D
    sta $068D
    lda $065E
    tay
    lda LD89C,y
    tay
    ldx #$00
LDE5E:
    lda $D9A9,y
    sta $062B,x
    iny
    inx
    txa
    cmp #$0D
    bne LDE5E
    lda #$01
    sta $0640
LDE70:
    sta $0641
    sta $0642
    sta $0643
    lda #$00
    sta $0638
    sta $0639
    sta $063A
    sta $063B
    rts

LDE88:
    .byte $81, $2C, $22, $1C, $2C, $22, $1C, $85, $2C, $04, $81, $2E, $24, $1E, $2E, $24
    .byte $1E, $85, $2E, $04, $81, $32, $28, $22, $72, $DF, $2C, $DB, $AE, $DB, $17, $40
    .byte $80, $80, $00, $02, $00, $83, $46

LDEAF:
    jsr LD934
    ldx #$A0
    ldy #$DE
    jmp LD90A

LDEB9:
    .byte $B7, $02, $C2, $B4, $64, $74, $6A, $02, $64, $78, $74, $02, $FF, $C2, $B2, $72
    .byte $5A, $6E, $56, $6C, $54, $68, $50, $6E, $56, $6C, $54, $68, $50, $64, $4C, $FF
    .byte $C4, $72, $5A, $6E, $5A, $6C, $5A, $68, $5A, $6E, $56, $6C, $56, $68, $56, $64
    .byte $56, $FF, $B2, $5A, $B1, $42, $B2, $56, $B1, $42, $B2, $54, $B1, $42, $B2, $50
    .byte $B1, $42, $B2, $5A, $B1, $42, $B2, $56, $B1, $42, $B2, $52, $B1, $42, $B2, $50
    .byte $B1, $42, $B2, $5A, $B1, $44, $B2, $56, $B1, $44, $B2, $52, $B1, $44, $B2, $56
    .byte $B1, $44, $C4, $5A, $50, $46, $FF, $C3, $58, $50, $46, $FF, $58, $50, $B0, $46
    .byte $02, $E0, $B4, $02, $FF, $00, $D0, $B6, $2A, $B1, $2A, $B1, $02, $FF, $B4, $4C
    .byte $60, $5E, $5C, $54, $60, $5C, $56, $C2, $34, $48, $46, $44, $3C, $48, $44, $3E
    .byte $FF, $C2, $B2, $34, $B1, $42, $B5, $4C, $FF, $C2, $B2, $2C, $B1, $3A, $B5, $48
    .byte $FF, $C2, $B2, $1E, $B1, $2C, $B5, $36, $FF, $C4, $B2, $20, $B1, $2E, $B5, $38
    .byte $FF, $E0, $B6, $2A, $B1, $2A, $B1, $02, $FF, $D0, $B6, $06, $B2, $02, $FF, $C8
    .byte $B4, $02, $FF, $B2, $24, $26, $2A, $2E, $34, $38, $3C, $3E, $B6, $42, $B1, $3E
    .byte $3C, $B6, $3E, $B1, $3C, $38, $B6, $34, $B2, $42, $B4, $4C, $B3, $44, $42, $3E
    .byte $3C, $B6, $38, $B2, $3C, $B6, $42, $B2, $4C, $B6, $38, $B2, $3C, $B4, $34, $B3
    .byte $2A, $2E, $34, $38, $B6, $34, $B2, $2C, $B4, $26, $B5, $38, $3C, $42, $4C, $34
    .byte $3A, $48, $42, $36, $3E, $4C, $44, $42, $38, $2E, $38, $40, $38, $2E, $38, $E0
    .byte $B6, $06, $B2, $02, $FF, $D0, $B4, $04, $FF, $CC, $B2, $04, $04, $B5, $07, $B0
    .byte $04, $04, $B6, $04, $B1, $04, $04, $FF, $CA, $B1, $04, $04, $04, $07, $04, $04
    .byte $FF, $E0, $B4, $04, $FF, $17, $18, $19, $19, $1A

LDFF3: ;($DFF3)
    jmp LD18C


