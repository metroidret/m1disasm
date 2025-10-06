
METHEX_ReadJoyPads: ;($D000)
    ldx #$00
    stx $01
    jsr METHEX_ReadOnePad
    ldx Joy2Port
    inc $01
    ; fallthrough

METHEX_ReadOnePad:
    ;These lines strobe the joystick to enable the program to read the buttons pressed.
    ldy #$01
    sty JOY1
    dey
    sty JOY1
    ;Do 8 buttons.
    ldy #$08
    @loop:
        ;Store A.
        pha
        ;Read button status. Joypad 1 or 2.
        lda JOY1,x
        ;Store button press at location $00.
        sta $00
        ;Also accept button press from joypad that is plugged into the console's expansion port
        lsr
        ora $00
        ;Move button press to carry bit.
        lsr
        ;Restore A.
        pla
        ;Add button press status to A.
        rol
        ;Loop 8 times to get status of all 8 buttons.
        dey
        bne @loop
    ; a now contains the new joypad status
    
    ;Get joypad status of previous refresh.
    ldx $01 ;Joypad #(0 or 1).
    ldy Joy1Status,x
    ;Store at $00.
    sty $00
    
    ;Store current joypad status.
    sta Joy1Status,x
    
    ;Branch if no buttons changed.
    eor $00
    beq @endIf_A
        ;Remove the previous status of the B button.
        lda $00
        and #~BUTTON_B.b
        sta $00
        eor Joy1Status,x
    @endIf_A:
    
    ;Save any button changes from the current frame and the last frame to the joy change addresses.
    and Joy1Status,x
    sta Joy1Change,x
    ;Store any changed buttons in JoyRetrig address.
    sta Joy1Retrig,x
    
    ldy #$20
    ;Checks to see if same buttons are being pressed this frame as last frame.
    lda Joy1Status,x
    cmp $00
    ;If none, branch.
    bne @endIf_B
        ;Decrement RetrigDelay if same buttons pressed.
        dec RetrigDelay1,x
        bne @RTS
        ;Once RetrigDelay=#$00, store buttons to retrigger.
        sta Joy1Retrig,x
        ldy #$10
    @endIf_B:
    ;Reset retrigger delay to #$20(32 frames) or #$10(16 frames) if already retriggering.
    sty RetrigDelay1,x
@RTS:
    rts



METHEX_ScreenOff: ;($D052)
    lda PPUMASK_ZP
    and #~(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b

METHEX_WriteAndWait: ;($D056)
    sta PPUMASK_ZP

METHEX_WaitNMIPass_: ;($D058)
    jsr MAIN_ClearNMIStat
    @loop:
        lda NMIStatus
        beq @loop
    rts



METHEX_ScreenOn: ;($D060)
    lda PPUCTRL_ZP
    and #~PPUCTRL_OBJ_1000.b
    ora #PPUCTRL_BG_1000
    sta PPUCTRL_ZP
    lda PPUMASK_ZP
    ora #(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b
    bne METHEX_WriteAndWait ; branch always



METHEX_WritePPUCtrl: ;($D06E)
    lda PPUCTRL_ZP
    sta PPUCTRL
    lda PPUMASK_ZP
    sta PPUMASK
    lda $73
    sta FDS_CTRL_ZP
    sta FDS_CTRL
RTS_D07F:
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
    bne RTS_D2A6
    lda #$00
    sta $0665,x
RTS_D2A6:
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
    bne RTS_D33D
LD335:
    jsr LD28C
    lda #$10
    sta $400C
RTS_D33D:
    rts
LD33E:
    lda #$03
    ldy #$95
    bne LD32D
    lda $7E8D,x
    lsr $3E46,x
    .byte $00
    jsr LD293
    bne RTS_D367
    ldy $0671
    lda $D344,y
    bne LD35B
    jmp LD38D
LD35B:
    sta $4002
    lda $D0A0
    sta $4003
    inc $0671
RTS_D367:
    rts
LD368:
    lda #$05
    ldy #$9D
    bne LD3BB
    jsr LD293
    bne RTS_D367
    inc $0671
    lda $0671
    cmp #$03
    beq LD38D
    ldy #$99
    jmp LD151
LD382:
    lda #$06
    ldy #$99
    bne LD3BB
    jsr LD293
    bne RTS_D367
LD38D:
    lda #$10
    sta $4000
    lda #$00
    sta $0653
    jsr LD28C
    inc $0607
    rts
LD39E:
    lda #$0C
    ldy #$A9
    bne LD3BB
    lda #$08
    ldy #$AD
    bne LD3BB
    lda $0689
    and #$CC
    bne RTS_D367
    lda #$06
    ldy #$A5
    bne LD3BB
    lda #$0B
    ldy #$A1
LD3BB:
    jmp LD246
LD3BE:
    lda #$16
    ldy #$B1
    bne LD3BB
    lda #$04
    ldy #$B5
    bne LD3BB
    jsr LD293
    bne RTS_D3E1
    inc $0671
    lda $0671
    cmp #$02
    bne LD3DC
    jmp LD38D
LD3DC:
    ldy #$B9
    jsr LD151
RTS_D3E1:
    rts

LD3E2:
    lda $0615
    bne RTS_D3E1
    lda $28
    and #$03
    ora #$03
    ldx #<DataDD0E_D3F4.b
    ldy #>DataDD0E_D3F4.b
    jmp LDD0E

DataDD0E_D3F4:
    .word LDB2C
    .word FDSWaveform_DBAE
    .byte $00, $A0, $00, $07, $00, $A0, $A0, $A8, $02

DataDD0E_D401:
    .word LDB2C
    .word FDSWaveform_DB6E
    .byte $A0, $A0, $00, $10, $00, $A0, $0A, $E0, $01

DataDD0E_D40E:
    .word LDB2C
    .word FDSWaveform_DC2E
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
    bne RTS_D451
    lda $0686
    beq LD41B
    lsr a
    bcs LD43A
RTS_D451:
    rts

LD452:
    lda $0686
    beq LD472
    lsr a
    bcc RTS_D451
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
    .word FDSWaveform_DC2E
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
    .word FDSWaveform_DB6E
    .byte $82, $50, $00, $20, $04, $A0, $A0, $98, $07

LD4C3:
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
    .word FDSWaveform_DBAE
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
    .word FDSWaveform_DBEE
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
    lda NoteLengthsTbl,y
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
RTS_D7B7:
    rts

LD7B8:
    lda $0615
    beq RTS_D7B7
    dec $060A
    bne RTS_D7B7
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
    lda NoteLengthsTbl,y
    sta $060B
    ldy $060C
    inc $060C
    lda ($EE),y
    tay
LD81A:
    lda #$00
    sta $EA
    lda MusicNotesTblFDS+1,y
    beq LD82F
    sta $061D
    lda MusicNotesTblFDS,y
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
    .byte $41, $8F, $34, $27, $1A, $0D, $00, $82, $68, $75, $4E, $5B
    .word LD903
    .word LD8F1
    .word LD910
    .word LDEAF
    .byte $D8, $D2, $D8, $D2, $D1, $DF, $B8, $DF
    .word LD900
    .word LD8EE
    .word LD8EE
    .word LD8EE
    .word LD8FD
    .word LD8FA
    .word LD8EE
    .word LD8FD

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

LD8DD:
    lda $068D
    beq RTS_D8ED
    jmp LD630

LD8E5:
    lda $068D
    ora #$F0
    sta $068D
RTS_D8ED:
    rts

LD8EE:
    jmp LD934

LD8F1:
    jsr LD92E
    ldx #<DataD785_SongPowerUp.b
    ldy #>DataD785_SongPowerUp.b
    bne LD90A
LD8FA:
    jmp LD92A

LD8FD:
    jmp LD926

LD900:
    jmp LD919

LD903:
    jsr LD926
    ldx #<DataD785_SongFadeIn.b
    ldy #>DataD785_SongFadeIn.b
LD90A:
    jsr LD8E5
    jmp LD785

LD910:
    jsr LD92E
    ldx #<DataD785_SongEnd.b
    ldy #>DataD785_SongEnd.b
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


DataD785_SongPowerUp:
    .word SongPowerUpFDS
    .word LDB2C
    .word FDSWaveform_DC6E
    .byte $00, $F3, $80, $80, $00, $13, $00, $86, $44

DataD785_SongFadeIn:
    .word SongFadeInFDS
    .word LDB2C
    .word FDSWaveform_DC6E
    .byte $0B, $F4, $80, $80, $00, $12, $00, $84, $48


VolumeEnvelopePtrTable:
    .word VolumeEnvelope1, VolumeEnvelope2, VolumeEnvelope3, VolumeEnvelope4

VolumeEnvelope1:
    .byte $01, $02, $02, $03, $03, $04, $05, $06, $07, $08, $FF

VolumeEnvelope2:
    .byte $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF

VolumeEnvelope3:
    .byte $00, $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF

VolumeEnvelope4:
    .byte $02, $06, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $04, $04, $04, $03
    .byte $03, $03, $03, $02, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02
    .byte $02, $02, $02, $01, $01, $01, $01, $01, $F0



SongHeaders:

SongMthrBrnRoomHeader:
    SongHeader NoteLengthsTbl@6, $FF, $F5, $00, $00
    .word SongMthrBrnRoomSQ1, SongMthrBrnRoomSQ2, SongMthrBrnRoomTri, $0000

SongEscapeHeader:
    SongHeader NoteLengthsTbl@6, $FF, $00, $02, $02
    .word SongEscapeSQ1, SongEscapeSQ2, SongEscapeTri, SongEscapeNoise

SongNorfairHeader:
    SongHeader NoteLengthsTbl@6, $FF, $F0, $04, $04
    .word SongNorfairSQ1, SongNorfairSQ2, SongNorfairTri, SongNorfairNoise

SongKraidHeader:
    SongHeader NoteLengthsTbl@4, $FF, $F0, $00, $00
    .word SongKraidSQ1, SongKraidSQ2, SongKraidTri, $0000

SongItemRoomHeader:
    SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .word SongItemRoomSQ1, SongItemRoomSQ2, SongItemRoomTri, $0000

SongRidleyHeader:
    SongHeader NoteLengthsTbl@6, $FF, $F0, $01, $01
    .word SongRidleySQ1, SongRidleySQ2, SongRidleyTri, $0000

SongEndHeader:
    SongHeader NoteLengthsTbl@7, $00, $00, $03, $01
    .word SongEndSQ1, SongEndSQ2, SongEndTri, SongEndNoise

SongIntroHeader:
    SongHeader NoteLengthsTbl@7, $00, $F0, $04, $04
    .word SongIntroSQ1, SongIntroSQ2, SongIntroTri, SongIntroNoise

SongFadeInHeader:
    SongHeader NoteLengthsTbl@6, $00, $F0, $01, $01
    .word SongFadeInSQ1, SongFadeInSQ2, SongFadeInTri, $0000

SongPowerUpHeader:
    SongHeader NoteLengthsTbl@4, $00, $F0, $02, $02
    .word SongPowerUpSQ1, SongPowerUpSQ2, SongPowerUpTri, $0000

SongBrinstarHeader:
    SongHeader NoteLengthsTbl@6, $FF, $00, $02, $03
    .word SongBrinstarSQ1, SongBrinstarSQ2, SongBrinstarTri, SongBrinstarNoise

SongTourianHeader:
    SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .word SongTourianSQ1, SongTourianSQ2, SongTourianTri, $0000



.include "songs/item_room.asm"


.include "songs/power_up.asm"


.include "songs/fade_in.asm"


.include "songs/tourian.asm"



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


FDSWaveform_DB6E:
    .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $10, $12, $14, $16, $18, $1A, $1C, $1E
    .byte $1F, $21, $23, $25, $27, $29, $2B, $2D, $2F, $31, $33, $35, $37, $39, $3B, $3D
    .byte $3F, $3D, $3B, $39, $37, $35, $33, $31, $2F, $2D, $2B, $29, $26, $24, $22, $20
    .byte $1E, $1C, $1A, $18, $16, $14, $12, $10, $0E, $0C, $0A, $08, $06, $04, $02, $00
FDSWaveform_DBAE:
    .byte $00, $08, $0E, $13, $17, $1B, $20, $24, $27, $29, $2B, $27, $22, $1E, $1B, $18
    .byte $1D, $24, $2C, $30, $31, $30, $2D, $2B, $29, $28, $27, $26, $25, $24, $23, $22
    .byte $21, $20, $19, $11, $0B, $12, $19, $12, $23, $20, $2F, $34, $37, $3A, $3E, $3F
    .byte $3E, $3A, $34, $30, $2D, $27, $23, $1E, $1B, $16, $13, $0F, $0B, $08, $04, $00
FDSWaveform_DBEE:
    .byte $00, $03, $08, $0B, $0F, $13, $17, $1B, $1E, $23, $27, $2B, $2F, $33, $37, $3B
    .byte $3F, $3B, $37, $33, $2F, $2B, $27, $23, $20, $2B, $18, $14, $10, $0C, $08, $04
    .byte $00, $04, $08, $0C, $10, $14, $18, $1C, $20, $24, $28, $2B, $2F, $33, $37, $3B
    .byte $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3F, $3F, $3F
FDSWaveform_DC2E:
    .byte $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00
    .byte $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00, $00, $3F, $3F, $00
    .byte $00, $3B, $3B, $00, $33, $33, $00, $00, $00, $2D, $2D, $00, $00, $23, $23, $00
    .byte $00, $1C, $1C, $00, $00, $14, $14, $00, $00, $0C, $0C, $00, $00, $04, $04, $00
FDSWaveform_DC6E:
    .byte $00, $3E, $3D, $3C, $3B, $3A, $38, $37, $36, $36, $35, $34, $33, $32, $31, $30
    .byte $2F, $2E, $2D, $2C, $2B, $2A, $29, $28, $27, $26, $25, $24, $23, $22, $21, $20
    .byte $1F, $1E, $1D, $1C, $1B, $1A, $19, $18, $17, $16, $15, $14, $13, $12, $11, $10
    .byte $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $00


;This table is used specifically for the audio channel of the Famicom Disk System.
;The formula for figuring out the frequency is as follows: 1790000*hhhhllllllll/16/262144
MusicNotesTblFDS:
    .byte $07,$F0                       ;867.1Hz (A5)   Index #$00 (Not used)
    .byte $00,$00                       ;No sound       Index #$02
    .byte $00,$A2                       ;69.1Hz (C#2)   Index #$04
    .byte $00,$AC                       ;73.4Hz (D2)    Index #$06
    .byte $00,$C1                       ;82.4Hz (E2)    Index #$08
    .byte $00,$CC                       ;87.0Hz (F2)    Index #$0A
    .byte $00,$D8                       ;92.2Hz (F#2)   Index #$0C
    .byte $00,$E5                       ;97.7Hz (G2)    Index #$0E
    .byte $00,$F3                       ;103.7Hz (Ab2)  Index #$10
    .byte $01,$01                       ;109.7Hz (A2)   Index #$12
    .byte $01,$11                       ;116.5Hz (A#2)  Index #$14
    .byte $01,$21                       ;123.3Hz (B2)   Index #$16
    .byte $01,$32                       ;130.6Hz (C3)   Index #$18
    .byte $01,$44                       ;138.3Hz (C#3)  Index #$1A
    .byte $01,$58                       ;146.8Hz (D3)   Index #$1C
    .byte $01,$6C                       ;155.3Hz (D#3)  Index #$1E
    .byte $01,$82                       ;164.7Hz (E3)   Index #$20
    .byte $01,$99                       ;174.5Hz (F3)   Index #$22
    .byte $01,$B1                       ;184.8Hz (F#3)  Index #$24
    .byte $01,$CB                       ;195.9Hz (G3)   Index #$26
    .byte $01,$E6                       ;207.4Hz (Ab3)  Index #$28
    .byte $02,$03                       ;219.8Hz (A3)   Index #$2A
    .byte $02,$22                       ;233.0Hz (A#3)  Index #$2C
    .byte $02,$42                       ;246.6Hz (B3)   Index #$2E
    .byte $02,$65                       ;261.6Hz (C4)   Index #$30
    .byte $02,$89                       ;276.9Hz (C#4)  Index #$32
    .byte $02,$B0                       ;293.6Hz (D4)   Index #$34
    .byte $02,$D9                       ;311.1Hz (D#4)  Index #$36
    .byte $03,$04                       ;329.4Hz (E4)   Index #$38
    .byte $03,$32                       ;349.1Hz (F4)   Index #$3A
    .byte $03,$63                       ;370.0Hz (F#4)  Index #$3C
    .byte $03,$96                       ;391.7Hz (G4)   Index #$3E
    .byte $03,$CD                       ;415.2Hz (Ab4)  Index #$40
    .byte $04,$07                       ;439.9Hz (A4)   Index #$42
    .byte $04,$44                       ;466.0Hz (A#4)  Index #$44
    .byte $04,$85                       ;493.7Hz (B4)   Index #$46
    .byte $04,$CA                       ;523.2Hz (C5)   Index #$48
    .byte $05,$13                       ;554.3Hz (C#5)  Index #$4A
    .byte $05,$60                       ;587.2Hz (D5)   Index #$4C
    .byte $05,$B2                       ;622.2Hz (D#5)  Index #$4E
    .byte $06,$08                       ;658.8Hz (E5)   Index #$50
    .byte $06,$64                       ;698.1Hz (F5)   Index #$52
    .byte $06,$C6                       ;739.9Hz (F#5)  Index #$54
    .byte $07,$2D                       ;783.9Hz (G5)   Index #$56
    .byte $07,$9A                       ;830.4Hz (Ab5)  Index #$58
    .byte $08,$0E                       ;879.9Hz (A5)   Index #$5A
    .byte $08,$88                       ;931.9Hz (A#5)  Index #$5C
    .byte $09,$0A                       ;987.4Hz (B5)   Index #$5E



LDD0E:
    sta $EA
    stx $E0
    sty $E1
    lda $068A
    and #$FC
    bne @RTS
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
@RTS:
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
    beq @RTS
    @loop:
        inc $065E
        asl a
        bcc @loop
    @RTS:
    rts

LDD9F:
    lda $065E
    clc
    adc #$08
    sta $065E
    rts



;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)
;Note that on PAL consoles, the CPU clock speed is a bit slower, which affects the pitch.
;The formula for PAL is 1663000/16/(hhhllllllll + 1), so all notes play roughly a semitone flat (-128 cents).
MusicNotesTbl: ;($DDA9)
    .byte $07,$F0                       ;55.0Hz (A1)    Index #$00 (Not used)
    .byte $00,$00                       ;No sound       Index #$02
    .byte $06,$4E                       ;69.3Hz (C#2)   Index #$04
    .byte $05,$F3                       ;73.4Hz (D2)    Index #$06
    .byte $05,$4D                       ;82.4Hz (E2)    Index #$08
    .byte $05,$01                       ;87.3Hz (F2)    Index #$0A
    .byte $04,$B9                       ;92.5Hz (F#2)   Index #$0C
    .byte $04,$75                       ;98.0Hz (G2)    Index #$0E
    .byte $04,$35                       ;103.8Hz (Ab2)  Index #$10
    .byte $03,$F8                       ;110.0Hz (A2)   Index #$12
    .byte $03,$BF                       ;116.5Hz (A#2)  Index #$14
    .byte $03,$89                       ;123.5Hz (B2)   Index #$16
    .byte $03,$57                       ;130.7Hz (C3)   Index #$18
    .byte $03,$27                       ;138.5Hz (C#3)  Index #$1A
    .byte $02,$F9                       ;146.8Hz (D3)   Index #$1C
    .byte $02,$CF                       ;155.4Hz (D#3)  Index #$1E
    .byte $02,$A6                       ;164.8Hz (E3)   Index #$20
    .byte $02,$80                       ;174.5Hz (F3)   Index #$22
    .byte $02,$5C                       ;184.9Hz (F#3)  Index #$24
    .byte $02,$3A                       ;196.0Hz (G3)   Index #$26
    .byte $02,$1A                       ;207.6Hz (Ab3)  Index #$28
    .byte $01,$FC                       ;219.8Hz (A3)   Index #$2A
    .byte $01,$DF                       ;233.1Hz (A#3)  Index #$2C
    .byte $01,$C4                       ;247.0Hz (B3)   Index #$2E
    .byte $01,$AB                       ;261.4Hz (C4)   Index #$30
    .byte $01,$93                       ;276.9Hz (C#4)  Index #$32
    .byte $01,$7C                       ;293.6Hz (D4)   Index #$34
    .byte $01,$67                       ;310.8Hz (D#4)  Index #$36
    .byte $01,$52                       ;330.0Hz (E4)   Index #$38
    .byte $01,$3F                       ;349.6Hz (F4)   Index #$3A
    .byte $01,$2D                       ;370.4Hz (F#4)  Index #$3C
    .byte $01,$1C                       ;392.5Hz (G4)   Index #$3E
    .byte $01,$0C                       ;415.9Hz (Ab4)  Index #$40
    .byte $00,$FD                       ;440.4Hz (A4)   Index #$42
    .byte $00,$EE                       ;468.1Hz (A#4)  Index #$44
    .byte $00,$E1                       ;495.0Hz (B4)   Index #$46
    .byte $00,$D4                       ;525.2Hz (C5)   Index #$48
    .byte $00,$C8                       ;556.6Hz (C#5)  Index #$4A
    .byte $00,$BD                       ;588.8Hz (D5)   Index #$4C
    .byte $00,$B2                       ;625.0Hz (D#5)  Index #$4E
    .byte $00,$A8                       ;662.0Hz (E5)   Index #$50
    .byte $00,$9F                       ;699.2Hz (F5)   Index #$52
    .byte $00,$96                       ;740.9Hz (F#5)  Index #$54
    .byte $00,$8D                       ;787.9Hz (G5)   Index #$56
    .byte $00,$85                       ;834.9Hz (Ab5)  Index #$58
    .byte $00,$7E                       ;880.9HZ (A5)   Index #$5A
    .byte $00,$76                       ;940.1Hz (A#5)  Index #$5C
    .byte $00,$70                       ;990.0Hz (B5)   Index #$5E
    .byte $00,$69                       ;1055Hz (C6)    Index #$60
    .byte $00,$63                       ;1118Hz (C#6)   Index #$62
    .byte $00,$5E                       ;1178Hz (D6)    Index #$64
    .byte $00,$58                       ;1257Hz (D#6)   Index #$66
    .byte $00,$53                       ;1332Hz (E6)    Index #$68
    .byte $00,$4F                       ;1398Hz (F6)    Index #$6A
    .byte $00,$4A                       ;1492Hz (F#6)   Index #$6C
    .byte $00,$46                       ;1576Hz (G6)    Index #$6E
    .byte $00,$42                       ;1670Hz (Ab6)   Index #$70
    .byte $00,$3E                       ;1776Hz (A6)    Index #$72
    .byte $00,$3A                       ;1896Hz (A#6)   Index #$74
    .byte $00,$37                       ;1998Hz (B6)    Index #$76
    .byte $00,$34                       ;2111Hz (C7)    Index #$78
    .byte $00,$31                       ;2238Hz (C#7)   Index #$7A
    .byte $00,$2E                       ;2380Hz (D7)    Index #$7C
    .byte $00,$27                       ;2796Hz (F7)    Index #$7E

;The following tables are used to load the music frame count addresses ($0640 thru $0643). The
;larger the number, the longer the music will play a solid note.  The number represents how
;many frames the note will play.  There is a small discrepancy in time length because the
;Nintendo runs at 60 frames pers second and I am using 64 frames per second to make the
;numbers below divide more evenly.

NoteLengthsTbl: ;($DE29)
    ;Used by power up music and Kraid area music.
    @4:
        .byte $04                       ;About    1/16 seconds ($B0)
        .byte $08                       ;About    1/8  seconds ($B1)
        .byte $10                       ;About    1/4  seconds ($B2)
        .byte $20                       ;About    1/2  seconds ($B3)
        .byte $40                       ;About 1       seconds ($B4)
        .byte $18                       ;About    3/8  seconds ($B5)
        .byte $30                       ;About    3/4  seconds ($B6)
        .byte $0C                       ;About    3/16 seconds ($B7)
        .byte $0B                       ;About   11/64 seconds ($B8)
        .byte $05                       ;About    5/64 seconds ($B9)
        .byte $02                       ;About    1/32 seconds ($BA)

    ;Used by item room, fade in, Brinstar music, Ridley area music, Mother brain music,
    ;escape music, Norfair music and Tourian music.
    @6:
        .byte $06                       ;About    3/32 seconds ($B0)
        .byte $0C                       ;About    3/16 seconds ($B1)
        .byte $18                       ;About    3/8  seconds ($B2)
        .byte $30                       ;About    3/4  seconds ($B3)
        .byte $60                       ;About 1  1/2  seconds ($B4)
        .byte $24                       ;About    9/16 seconds ($B5)
        .byte $48                       ;About 1  3/16 seconds ($B6)
        .byte $12                       ;About    9/32 seconds ($B7)
        .byte $10                       ;About    1/4  seconds ($B8)
        .byte $08                       ;About    1/8  seconds ($B9)
        .byte $03                       ;About    3/64 seconds ($BA)
        .byte $10                       ;About    1/4  seconds ($BB)

    ;Used by intro and end game music.
    @7:
        .byte $07                       ;About    7/64 seconds ($B0)
        .byte $0E                       ;About    7/32 seconds ($B1)
        .byte $1C                       ;About    7/16 seconds ($B2)
        .byte $38                       ;About    7/8  seconds ($B3)
        .byte $70                       ;About 1 13/16 seconds ($B4)
        .byte $2A                       ;About   21/32 seconds ($B5)
        .byte $54                       ;About 1  5/16 seconds ($B6)
        .byte $15                       ;About   21/64 seconds ($B7)
        .byte $12                       ;About    9/32 seconds ($B8)
        .byte $02                       ;About    1/32 seconds ($B9)
        .byte $03                       ;About    3/64 seconds ($BA)


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
    .byte $1E, $85, $2E, $04, $81, $32, $28, $22

DataD785_SongIntro:
    .word SongIntroFDS
    .word LDB2C
    .word FDSWaveform_DBAE
    .byte $17, $40, $80, $80, $00, $02, $00, $83, $46

LDEAF:
    jsr LD934
    ldx #<DataD785_SongIntro.b
    ldy #>DataD785_SongIntro.b
    jmp LD90A



.include "songs/intro.asm"



LDFEE:
    .byte $17
    .byte $18
    .byte $19
    .byte $19
    .byte $1A

GotoLD18C: ;($DFF3)
    jmp LD18C


