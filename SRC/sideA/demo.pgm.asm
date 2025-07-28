
RandomNumbers: ;($6800)
    txa
    pha
    ldx #$0B
    @loop:
        asl RandomNumber1
        rol RandomNumber2
        rol a
        rol a
        eor RandomNumber1
        rol a
        eor RandomNumber1
        lsr a
        lsr a
        eor #$FF
        and #$01
        ora RandomNumber1
        sta RandomNumber1
        dex
        bne @loop
    pla
    tax
    lda RandomNumber1
    rts



DEMO_RESET: ;($6821)
    cld
    L6822:
        lda PPUSTATUS
        bpl L6822
    ldx #$00
    stx PPUCTRL
    stx PPUMASK
    dex
    txs
    ldy #$07
    sty $01
    ldy #$00
    sty $00
    tya
    L683A:
            sta ($00),y
            iny
            bne L683A
            dec $01
            bmi L684F
            ldx $01
            cpx #$01
            bne L683A
        iny
        iny
        iny
        iny
        bne L683A
L684F:
    jsr L69DF
    jsr EraseAllSprites
    ldy #$00
    sty PPUSCROLL
    sty PPUSCROLL
    iny
    sty $1D
    lda #$90
    sta PPUCTRL
    sta PPUCTRL_ZP
    lda #$02
    sta PPUMASK_ZP
    lda #$47
    sta FDS_CTRL
    sta FDS_CTRL_ZP
    bne L68A7 ; branch always



L6874:
    jsr L6AE4
    jsr L695F
    inc $27
    lda #$00
    sta $1A
    ldx #$08
    lda $27
    and #$01
    beq L688A
        ldx #$10
    L688A:
    lda $0183
    sta $0184
    lda $0182
    sta $0183
    lda $0181
    sta $0182
    lda $0180
    sta $0181
    lda #$00
    sta $0180
L68A7:
    tay
    L68A8:
        lda NMIStatus
        bne L68B7
        iny
        cpy #$09
        bne L68A8
    inc $0180
    jmp L68A7
L68B7:
    jsr RandomNumbers
    jmp L6874



DEMO_NMI: ;($68BD)
    cli
    php
    pha
    txa
    pha
    tya
    pha
    lda $1A
    beq L68CB
        sta $02FC
    L68CB:
    lda $1F
    cmp #$15
    bcs L68E5
        lda $5D
        sta $0200
        lda $5E
        sta $0201
        lda $5F
        sta $0202
        lda $60
        sta $0203
    L68E5:
    lda #$00
    sta $2003
    lda #$02
    sta $4014
    lda $1A
    bne L694E
    jsr L6A45
    jsr CheckPPUWrite
    jsr WritePPUCtrl
    jsr L6A71
    lda $2002
    lda $FF
    and #$01
    asl a
    asl a
    clc
    adc #$20
    sta $2006
    lda #$00
    sta $2006
    lda $3F
    sta $FD
    jsr WriteScroll
    lda $43
    beq L694E
    L691E:
        lda $2002
        and #$40
        bne L691E
    lda $1F
    cmp #$09
    bcc L693A
    jsr RemoveIntroSprites



L692E:
    lda #$04
    sta $040E
    jsr L868D
    lda $5C
    bne L693A
L693A:
    jsr $DFF3
L693D:
    lda $2002
    and #$40
    beq L693D
    lda $40
    sta $FD
    jsr WriteScroll
    jmp L6951




L694E:
    jsr $DFF3
L6951:
    lda $4017
    ldy #$01
    sty $1A
    pla
    tay
    pla
    tax
    pla
    plp
    rti



L695F:
    lda $1D
    beq L6966
    jmp L696D



L6966:
    lda $1E
    jsr DEMO_ChooseRoutine
        .word RTS_6D00



L696D:
    ldy $5B
    beq L6988
    dey
    sty $5B
    sty $59
    sty $43
    sty $3F
    sty $40
    lda $FF
    and #$FC
    sta $FF
    lda #$1B
    sta $1F
    bne L6999
L6988:
    jsr L8707
    jsr L86BE
    lda $1F
    cmp #$0A
    bcs L6999
    jsr RemoveIntroSprites
    lda $1F
L6999:
    jsr DEMO_ChooseRoutine
        .word L6999_6D01
        .word L6999_6D69
        .word L6999_6D8C
        .word L6999_6DDF
        .word L6999_6DF5
        .word L6999_6DBC
        .word L6999_6E00
        .word L6999_6E16
        .word L6999_6E35
        .word L6999_6E84
        .word L6999_69DC
        .word L6999_69DC
        .word L6999_6EE3
        .word L6999_6F26
        .word L6999_6F46
        .word L6999_6F66
        .word L6999_69D6
        .word L6999_6FD1
        .word L6999_701C
        .word RTS_7022
        .word RTS_7022
        .word L6999_8899
        .word L6999_893C
        .word L6999_89CE
        .word L6999_89F2
        .word L6999_8BA5
        .word L6999_8BC5
        .word L6999_8847
        .word L6999_6D01



L6999_69D6:
    lda #$00
    sta $53
    sta $51
L6999_69DC:
    inc $1F
    rts


;ClearNameTables
L69DF:
    jsr L69E6
    lda #$02
    bne L69E8
L69E6:
    lda #$01
L69E8:
    sta $01
    lda #$FF
    sta $00
    
    ldx PPUSTATUS
    lda PPUCTRL_ZP
    and #$FB
    sta PPUCTRL_ZP
    sta PPUCTRL
    ldx $01
    dex
    lda HiPPUTable,x
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ldx #$04
    ldy #$00
    lda $00
    L6A0E:
            sta PPUDATA
            dey
            bne L6A0E
        dex
        bne L6A0E
    rts

HiPPUTable: ;($6A18)
    .byte $20, $24, $28, $2C



EraseAllSprites: ;($6A1C)
    ldy #>SpriteRAM.b
    sty $01
    ldy #<SpriteRAM.b
    sty $00
    ldy #$04
    lda #$F0
    @loop:
        sta ($00),y
        iny
        bne @loop
    jmp L84D0

    rts ; unused?



RemoveIntroSprites: ;($6A31)
    ldy #>SpriteRAM.b
    sty $01
    ldy #<SpriteRAM.b
    sty $00
    ldy #$5F
    lda #$F4
    @loop:
        sta ($00),y
        dey
        bpl @loop
    jmp L84D0



L6A45:
    lda $52
    bne L6A56
    ldy $1C
    bne L6A5B
    lda $1F
    cmp #$15
    bcs L6A5A
    jmp L85DB
L6A56:
    lda #$00
    sta $52
L6A5A:
    rts

;LC1FF
L6A5B:
    dey
    tya
    asl a
    tay
    ldx $77EC,y
    lda $77ED,y
    tay
    lda #$00
    sta $1C
L6A6A:
    stx $00
    sty $01
    jmp ProcessPPUString


;ReadJoyPads
L6A71:
    lda $59
    beq L6A78
    jmp L6ACA
L6A78:
    ldx #$00
    stx $01
    jsr L6A83
    ldx $2B
    inc $01
L6A83:
    ldy #$01
    sty JOY1
    dey
    sty JOY1
    ldy #$08
L6A8E:
    pha
    lda JOY1,x
    sta $00
    lsr a
    ora $00
    lsr a
    pla
    rol a
    dey
    bne L6A8E
    ldx $01
    ldy $14,x
    sty $00
    sta $14,x
    eor $00
    beq L6AB1
    lda $00
    and #$BF
    sta $00
    eor $14,x
L6AB1:
    and $14,x
    sta $12,x
    sta $16,x
    ldy #$20
    lda $14,x
    cmp $00
    bne L6AC7
    dec $18,x
    bne RTS_6AC9
    sta $16,x
    ldy #$10
L6AC7:
    sty $18,x
RTS_6AC9:
    rts



L6ACA:
    ldy #$01
    sty $4016
    dey
    sty $4016
    ldy #$04
    L6AD5:
        lda $4016
        dey
        bne L6AD5
    and #$03
    beq RTS_6AC9
    
    iny
    sty $5B
    bne RTS_6AC9
    
L6AE4:
    ldx #$01
    dec $23
    bpl L6AF0
    lda #$09
    sta $23
    ldx #$02
    L6AF0:
        lda $24,x
        beq L6AF6
            dec $24,x
        L6AF6:
        dex
        bpl L6AF0
    rts



DEMO_ChooseRoutine: ;($6AFA)
    ;* 2, each ptr is 2 bytes (16-bit).
    asl
    ;Temp storage. (not pushed to stack, because stack needs to be accessed)
    sty TempY
    stx TempX
    ; y = a+1
    tay
    iny
    ;load ptr table address from stack
    pla
    sta CodePtr
    pla
    sta CodePtr+1.b
    ;Low byte of routine ptr
    lda (CodePtr),y
    tax
    ;High byte of routine ptr.
    iny
    lda (CodePtr),y
    ; save routine ptr to CodePtr
    sta CodePtr+1.b
    stx CodePtr
    ;Restore X and Y.
    ldx TempX
    ldy TempY
    jmp (CodePtr)



WriteScroll: ;($6B1C)
    ;Reset scroll register flip/flop
    lda PPUSTATUS
    ;X and Y scroll offsets are loaded serially.
    lda ScrollX
    sta PPUSCROLL
    lda ScrollY
    sta PPUSCROLL
    rts


AddYToPtr00: ;($6B2A)
    tya
    clc
    adc $00
    sta $00
    bcc RTS_6B34
        inc $01
    RTS_6B34:
    rts



AddYToPtr02: ;($6B35)
    tya
    clc
    adc $02
    sta $02
    bcc RTS_6B3F
        inc $03
    RTS_6B3F:
    rts


L6B40:
    tya
    clc
    adc $04
    sta $04
    bcc RTS_6B3F
    inc $05
    rts
L6B4B:
    eor #$FF
    clc
    adc #$01
    rts



Adiv32: ;($6B51)
    lsr a
Adiv16: ;($6B52)
    lsr a
Adiv8: ;($6B53)
    lsr a
    lsr a
    lsr a
    rts



Amul32: ;($6B57)
    asl a
Amul16: ;($6B58)
    asl a
Amul8: ;($6B59)
    asl a
    asl a
    asl a
    rts



CheckPPUWrite: ;($6B5D)
    ;If zero no PPU data to write, branch to exit.
    lda PPUDataPending
    beq RTS_6B76
    ;Sets up PPU writer to start at address $07A1.
    ;$0000 = ptr to PPU data string ($07A1).
    lda #<PPUDataString.b
    sta $00
    lda #>PPUDataString.b
    sta $01
    ;($C30C)write it to PPU.
    jsr ProcessPPUString
    ;PPU data string has been written so the data stored for the write is now erased.
    lda #$00
    sta PPUStrIndex
    sta PPUDataString
    sta PPUDataPending
RTS_6B76:
    rts



PPUWrite: ;($6B77)
    sta $2006
    iny
    lda ($00),y
    sta $2006
    iny
    lda ($00),y
    asl a
    jsr SetPPUInc
    asl a
    lda ($00),y
    and #$3F
    tax
    bcc L6B90
    iny
L6B90:
    bcs L6B93
    iny
L6B93:
    lda ($00),y
    sta $2007
    dex
    bne L6B90
    iny
    jsr AddYToPtr00



ProcessPPUString: ;($6B9F)
    ldx $2002
    ldy #$00
    lda ($00),y
    bne PPUWrite
    jmp WriteScroll



SetPPUInc:
    pha
    lda PPUCTRL_ZP
    ora #$04
    bcs L6BB4
        and #$FB
    L6BB4:
    sta PPUCTRL
    sta PPUCTRL_ZP
    pla
    rts



EraseTile:
    ldy #$01
    sty PPUDataPending
    dey
    lda ($02),y
    and #$0F
    sta $05
    lda ($02),y
    jsr Adiv16
    sta $04
    ldx PPUStrIndex
    L6BD0:
        lda $01
        jsr WritePPUByte
        lda $00
        jsr WritePPUByte
        lda $05
        sta $06
        jsr WritePPUByte
        L6BE1:
            iny
            lda ($02),y
            jsr WritePPUByte
            dec $06
            bne L6BE1
        stx $07A0
        sty $06
        ldy #$20
        jsr AddYToPtr00
        ldy $06
        dec $04
        bne L6BD0
    jsr EndPPUString

WritePPUByte:
    sta PPUDataString,x

NextPPUByte:
    inx
    cpx #$4F
    bcc RTS_6C10
    ldx PPUStrIndex

EndPPUString:
    lda #$00
    sta PPUDataString,x
    pla
    pla

RTS_6C10:
    rts



L6C11:
    stx $00
    sty $01
    ldx #$80
    stx $02
    ldx #$07
    stx $03
    
PrepPPUPaletteString:
    ldy #$01
    sty PPUDataPending
    dey
    beq L6C5B
    
L6C24:
    sta $04
    lda $01
    jsr WritePPUByte
    lda $00
    jsr WritePPUByte
    lda $04
    jsr SeparateControlBits
    
    bit $04
    bvc WritePaletteStringByte
    iny
    
WritePaletteStringByte:
    bit $04
    bvs L6C3F
        iny
    L6C3F:
    lda ($02),y
    jsr WritePPUByte
    sty $06
    ldy #$01
    bit $04
    bpl L6C4E
        ldy #$20
    L6C4E:
    jsr AddYToPtr00
    ldy $06
    dec $05
    bne WritePaletteStringByte
    stx PPUStrIndex
    iny
L6C5B:
    ldx PPUStrIndex
    lda ($02),y
    bne L6C24
    jsr EndPPUString
    
SeparateControlBits:
    sta $04
    and #$BF
    sta PPUDataString,x
    and #$3F
    sta $05
    jmp NextPPUByte



Base10Add:
    jsr ExtractNibbles
    adc $01
    cmp #$0A
    bcc L6C7E
        adc #$05
    L6C7E:
    clc
    adc $02
    sta $02
    lda $03
    and #$F0
    adc $02
    bcc L6C8F
L6C8B:
    adc #$5F
    sec
    rts
L6C8F:
    cmp #$A0
    bcs L6C8B
    rts



Base10Subtract:
    jsr ExtractNibbles
    sbc $01
    sta $01
    bcs L6CA7
        adc #$0A
        sta $01
        lda $02
        adc #$0F
        sta $02
    L6CA7:
    lda $03
    and #$F0
    sec
    sbc $02
    bcs L6CB3
        adc #$A0
        clc
    L6CB3:
    ora $01
    rts



ExtractNibbles:
    pha
    and #$0F
    sta $01
    pla
    and #$F0
    sta $02
    lda $03
    and #$0F
    rts



WaitNMIPass:
    jsr ClearNMIStat
    L6CC8:
        lda NMIStatus
        beq L6CC8
    rts



ClearNMIStat:
    lda #$00
    sta NMIStatus
    rts



ScreenOff:
    lda PPUMASK_ZP
    and #~(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b

WriteAndWait:
    sta $FE
    
    jsr ClearNMIStat
    L6CDB:
        lda $1A
        beq L6CDB
    rts

L6CE0:
    lda $FF
    and #$F7
    ora #$10
    sta $FF
    sta $2000
    lda $FE
    ora #$1E
    bne WriteAndWait ; branch always



WritePPUCtrl:
    lda PPUCTRL_ZP
    sta PPUCTRL
    lda PPUMASK_ZP
    sta PPUMASK
    lda FDS_CTRL_ZP
    sta FDS_CTRL
RTS_6D00:
    rts



L6999_6D01:
    ldy #$02
    sty $57
    sty $54
    dey
    sty $56
    sty $59
    dey
    sty $58
    sty $55
    sty $5C
    lda #$D0
    sta $5D
    lda #$02
    sta $63
    lda #$19
    sta $5E
    lda #$20
    sta $5F
    lda #$B8
    sta $60
    sty $3F
    sty $40
    sty $49
    sty $4A
    sty $4B
    sty $4C
    sty $00
    ldx #$60
L6D37:
    stx $01
    txa
    and #$03
    asl a
    tay
    sty $02
    lda $6D61,y
    ldy #$00
L6D45:
    sta ($00),y
    iny
    beq L6D57
    cpy #$40
    bne L6D45
    ldy $02
    lda $6D62,y
    ldy #$40
    bpl L6D45
L6D57:
    inx
    cpx #$68
    bne L6D37
    inc $1F
    jmp L84EE

L6D61:
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $C0
    .byte $C4



L6999_6D69:
    lda #$10
    sta $F0
    sta $0684
    jsr ScreenOff
    jsr L69DF
    ldx #$34
    ldy #$7B
    jsr L6A6A
    lda #$01
    sta $1C
    sta $4D
    inc $1F
    lda #$00
    sta $62
    jmp L6CE0


L6999_6D8C:
    lda $62
    cmp #$0D
    bcs L6DB2
    asl a
    tay
    lda L7DAF,y
    sta $02
    lda L7DAF+1,y
    sta $03
    ldy #$00
    lda ($02),y
    sta $01
    iny
    lda ($02),y
    sta $00
    iny
    jsr AddYToPtr02
    inc $62
    jmp PrepPPUPaletteString
L6DB2:
    lda #$08
    sta $26
    lsr a
    sta $49
    inc $1F
    rts



L6999_6DBC:
    lda $27
    and #$03
    bne RTS_6DDE
    lda $49
    and #$03
    sta $49
    jsr L85A0
    lda $26
    bne RTS_6DDE
    lda $49
    cmp #$04
    bne RTS_6DDE
    inc $1F
    jsr L8183
    lda #$18
    sta $26
RTS_6DDE:
    rts



L6999_6DDF:
    lda $26
    bne RTS_6DF4
    lda $27
    and #$0F
    bne RTS_6DF4
    jsr L85A0
    bne RTS_6DF4
    lda #$20
    sta $26
    inc $1F
RTS_6DF4:
    rts



L6999_6DF5:
    lda $26
    bne RTS_6DF4
    lda #$08
    sta $26
    inc $1F
    rts



L6999_6E00:
    lda $26
    bne RTS_6E15
    lda $048A
    and $049A
    cmp #$01
    bne L6E12
    inc $1F
    bne RTS_6E15
L6E12:
    jsr L81A7
RTS_6E15:
    rts



L6999_6E16:
    lda $27
    and #$07
    bne L6E34
    lda $4C
    cmp #$04
    bne L6E31
    jsr L826F
    lda #$08
    sta $26
    sta $44
    lda #$00
    sta $47
    inc $1F
L6E31:
    jsr L8673
L6E34:
    rts



L6999_6E35:
    lda $48
    beq L6E3C
    jsr L85BB
L6E3C:
    lda $26
    bne L6E83
    lda $048A
    and $049A
    and $04AA
    and $04BA
    beq L6E7D
    lda #$01
    cmp $47
    beq L6E5E
    inc $47
    sta $4F
    sta $48
    lda #$00
    sta $4E
L6E5E:
    and $04CA
    and $04DA
    and $04EA
    and $04FA
    beq L6E7D
    lda #$01
    sta $4F
    sta $48
    jsr L84EE
    lda #$00
    sta $4E
    inc $1F
    bne L6E80
L6E7D:
    jsr L82D6
L6E80:
    jsr L834E
L6E83:
    rts



L6999_6E84:
    lda $48
    beq L6E8E
    jsr L834E
    jmp L85BB
L6E8E:
    inc $1F
    lda #$60
    sta $030D
    lda #$7C
    sta $030E
    lda $0305
    sta $0306
    rts
    lda #$01
    sta $43
    lda #$04
    sta $040E
    sta $13
    sta $15
    sta $17
    lda #$03
    sta $0300
    sta $0400
    inc $1F
    rts
    lda $0300
    cmp #$04
    bne RTS_6EE2
    lda #$00
    sta $0300
    lda #$0B
    sta $0305
    lda #$0C
    sta $0306
    lda #$07
    sta $0303
    lda #$08
    sta $26
    lda #$00
    sta $51
    sta $53
    inc $1F
RTS_6EE2:
    rts



L6999_6EE3:
    lda $53
    bne @endIf_A
        lda $27
        and #$0F
        cmp #$01
        bne @RTS
        sta $53
    @endIf_A:
    lda $51
    cmp #$10
    beq @endIf_B
        inc $51
        asl a
        tay
        lda L7F44,y
        sta $02
        lda L7F44+1,y
        sta $03
        ldy #$00
        lda ($02),y
        sta $01
        iny
        lda ($02),y
        sta $00
        iny
        jsr AddYToPtr02
        jmp EraseTile
    @endIf_B:
    inc $1F
    lda #$08
    sta $26
    lda #$06
    sta $4C
    lda #$00
    sta $51
@RTS:
    rts



L6999_6F26:
    lda $26
    bne RTS_6F45
    lda $27
    and #$07
    bne RTS_6F45
    lda $4C
    cmp #$0B
    bne L6F42
    lda #$00
    sta $4C
    lda #$30
    sta $26
    inc $1F
    bne RTS_6F45
L6F42:
    jsr L8673
RTS_6F45:
    rts



L6999_6F46:
    lda $26
    bne RTS_6F65
    lda $27
    and #$07
    bne RTS_6F65
    lda $4C
    cmp #$05
    bne L6F62
    lda #$06
    sta $4C
    lda #$00
    sta $53
    inc $1F
    bne RTS_6F65
L6F62:
    jsr L8673
RTS_6F65:
    rts



L6999_6F66:
    lda $53
    bne @endIf_A
        lda $27
        and #$0F
        cmp #$01
        bne @RTS
        sta $53
    @endIf_A:
    lda $51
    cmp #$0C
    beq @endIf_B
        inc $51
        asl a
        tay
        lda L7F44,y
        sta $04
        lda L7F44+1,y
        sta $05
        ldy #$00
        lda ($04),y
        sta $01
        iny
        lda ($04),y
        sta $00
        lda #$14
        sta $02
        lda #$81
        sta $03
        jmp EraseTile
    @endIf_B:
    lda #$23
    sta $01
    lda #$D0
    sta $00
    lda #$81
    sta $03
    lda #$2D
    sta $02
    jsr PrepPPUPaletteString
    inc $1F
    lda #$10
    sta $26
@RTS:
    rts



L6FB8:
    lda $26
    bne @RTS
    lda $3F
    bne @RTS
    lda $40
    and #$0F
    bne @RTS
    lda #$01
    sta $5A
    lda #$10
    sta $26
    inc $1F
@RTS:
    rts



L6999_6FD1:
    lda $26
    bne @RTS
    sta $5A
    sta $43
    sta $0408
    ldy #$1F
    @loop:
        sta $0300,y
        dey
        bpl @loop
    lda $FF
    and #$FC
    sta $FF
    iny
    sty $3F
    sty $40
    sty $49
    sty $4A
    sty $4B
    sty $4C
    sty $55
    sty $13
    sty $15
    sty $17
    sty $62
    iny
    sty $56
    iny
    sty $54
    sty $57
    sty $1F
    lda $63
    bne @dec63
    lda #$10
    sta $0684
    lda #$02
    sta $63
@RTS:
    rts
@dec63:
    dec $63
    rts



L6999_701C:
    jsr ScreenOff
    inc $1F
    rts



RTS_7022:
    rts



L7023:
    lda #$01
    sta $0680
    rts
    lsr $0416
    lda ($00),y
    and #$C0
    ora $0416
    sta $05
    lda $0416
    ora #$80
    sta $0416
    rts
    ldy #$00
    ldx $040E
L7043:
    lda $70B5,y
    sta $0200,x
    inx
    beq L7051
    iny
    cpy #$1C
    bne L7043
L7051:
    txa
    pha
    ldx $040E
    jsr L70B0
    beq L707E
    lda $0107
    tay
    jsr Adiv16
    jsr L70A9
    jsr L70B0
    beq L707E
    tya
    and #$0F
    jsr L70A9
    jsr L70B0
    beq L707E
    lda $0106
    jsr Adiv16
    jsr L70A9
L707E:
    ldy $0422
    beq L7095
    lda $040E
    clc
    adc #$10
    beq L7095
    tax
    lda $0421
    clc
    adc #$8B
    sta $0201,x
L7095:
    lda $040E
    clc
    adc #$18
    bcs L70A4
    tax
    lda $041E
    jsr L70A9
L70A4:
    pla
    sta $040E
    rts



L70A9:
    clc
    adc #$80
    sta $0201,x
    rts



L70B0:
    inx
    inx
    inx
    inx
    rts


L70B5:
    .byte $10, $8A
    .byte $00
    clc
    .byte $10, $FF
    .byte $00
    jsr $FF10
    .byte $00
    plp
    .byte $10, $FF
    .byte $00
    bmi L70DE
    .byte $FF
    .byte $00
    clc
    clc
    stx $2800
    clc
    .byte $FF
    .byte $00
    .byte $30, $86
    asl $1084
    ldx #$00
    ldy #$08
L70D9:
    lsr a
    bcs L70E0
    inx
    dey
L70DE:
    bne L70D9
L70E0:
    txa
    ldy $10
    ldx $0E
RTS_70E5:
    rts



L70E6:
    ldx $0409
    beq RTS_70E5
    dex
    bne @L70F1
    jmp @L70F4
@L70F1:
    dex
    bne L70FC
@L70F4:
    ldx $3F
    bne L7138
    ldx #$05
    bne L7118
L70FC:
    dex
    bne L7102
    jmp L7105
L7102:
    dex
    bne L7138
L7105:
    ldx $FC
    bne L7138
    stx $0417
    stx $0418
    inx
    lda $030E
    bmi L7130
    inx
    bne L7130
L7118:
    lda #$20
    sta $040D
    lda $040C
    jsr Amul8
    bcs L712C
    ldy $040A
    cpy #$03
    bcc L7130
L712C:
    lda #$47
    bne L7133
L7130:
    jsr L7142
L7133:
    sta $FB
    stx $0409
L7138:
    rts
    lda $030C
    eor #$01
    sta $030C
    rts
L7142:
    lda $0400
    eor #$03
    sta $0400
    lda $FB
    eor #$08
    rts

ObjectAnimIndexTbl: ;($714F)
ObjAnim_00:
    .byte $00, $01, $02, $FF
ObjAnim_04:
    .byte $03, $04, $05, $FF
ObjAnim_08:
    .byte $13, $06, $FF
ObjAnim_0B:
    .byte $07, $FF
ObjAnim_0D:
    .byte $17, $08, $FF
ObjAnim_10:
    .byte $21, $FF
ObjAnim_12:
    .byte $22, $FF
ObjAnim_14:
    .byte $01, $0F, $FF
ObjAnim_17:
    .byte $04, $10, $FF
ObjAnim_1A:
    .byte $13, $14, $15, $16, $FF
ObjAnim_1F:
    .byte $17, $18, $19, $1A, $FF
ObjAnim_24:
    .byte $20, $1F, $FF
ObjAnim_27:
    .byte $00, $13, $FF
ObjAnim_2A:
    .byte $03, $17, $FF
ObjAnim_2D:
    .byte $1B, $1C, $1D, $1E, $FF
ObjAnim_32:
    .byte $1E, $1D, $1C, $1B, $FF
ObjAnim_37:
    .byte $28, $29, $FF
ObjAnim_3A:
    .byte $2A, $FF
ObjAnim_3C:
    .byte $1F, $20, $FF
ObjAnim_3F:
    .byte $11, $FF
ObjAnim_41:
    .byte $12, $FF
ObjAnim_43:
    .byte $09, $0A, $0B, $FF
ObjAnim_47:
    .byte $0C, $0D, $0E, $FF
ObjAnim_4B:
    .byte $2C, $FF
ObjAnim_4D:
    .byte $2C, $2C, $2C, $2C, $2C, $2C, $2C, $2C, $2D, $2D, $2D, $2D, $2D, $2E, $2E, $2E
    .byte $2F, $2F, $FF
ObjAnim_60:
    .byte $2F, $2F, $2E, $2E, $2E, $2D, $2D, $2D, $2D, $2D, $2C, $2C, $2C, $2C, $2C, $2C
    .byte $2C, $2C, $FF
ObjAnim_73:
    .byte $30, $2B, $FF
ObjAnim_76:
    .byte $31, $FF
ObjAnim_78:
    .byte $31, $31, $31, $31, $31, $31, $31, $31, $32, $32, $32, $32, $32, $33, $33, $33
    .byte $34, $34, $FF
ObjAnim_8B:
    .byte $34, $34, $33, $33, $33, $32, $32, $32, $32, $32, $31, $31, $31, $31, $31, $31
    .byte $31, $31, $FF
ObjAnim_9E:
    .byte $35, $FF
ObjAnim_A0:
    .byte $37, $36, $FF
ObjAnim_A3:
    .byte $39, $38, $FF
ObjAnim_A6:
    .byte $3A, $3B, $FF
ObjAnim_A9:
    .byte $3C, $F7, $49, $F7, $FF
ObjAnim_AE:
    .byte $3D, $3E, $3F, $FF
ObjAnim_B2:
    .byte $40, $41, $42, $FF
ObjAnim_B6:
    .byte $43, $FF
ObjAnim_B8:
    .byte $44, $FF
ObjAnim_BA:
    .byte $45, $FF
ObjAnim_BC:
    .byte $46, $FF
ObjAnim_BE:
    .byte $47, $FF
ObjAnim_C0:
    .byte $48, $FF
ObjAnim_C2:
    .byte $07, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $F7, $F7, $07, $F7, $FF
ObjAnim_D1:
    .byte $23, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $F7, $F7, $23, $F7, $FF
ObjAnim_E0:
    .byte $07, $F7, $F7, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $07, $F7, $FF
ObjAnim_EF:
    .byte $23, $F7, $F7, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $23, $F7, $FF
    
ObjFramePtrTable: ;($724D)
    .word ObjFrame00
    .word ObjFrame01
    .word ObjFrame02
    .word ObjFrame03
    .word ObjFrame04
    .word ObjFrame05
    .word ObjFrame06
    .word ObjFrame07
    .word ObjFrame08
    .word ObjFrame09
    .word ObjFrame0A
    .word ObjFrame0B
    .word ObjFrame0C
    .word ObjFrame0D
    .word ObjFrame0E
    .word ObjFrame0F
    .word ObjFrame10
    .word ObjFrame11
    .word ObjFrame12
    .word ObjFrame13
    .word ObjFrame14
    .word ObjFrame15
    .word ObjFrame16
    .word ObjFrame17
    .word ObjFrame18
    .word ObjFrame19
    .word ObjFrame1A
    .word ObjFrame1B
    .word ObjFrame1C
    .word ObjFrame1D
    .word ObjFrame1E
    .word ObjFrame1F
    .word ObjFrame20
    .word ObjFrame21
    .word ObjFrame22
    .word ObjFrame23
    .word ObjFrame24
    .word ObjFrame25
    .word ObjFrame26
    .word ObjFrame27
    .word ObjFrame28
    .word ObjFrame29
    .word ObjFrame2A
    .word ObjFrame2B
    .word ObjFrame2C
    .word ObjFrame2D
    .word ObjFrame2E
    .word ObjFrame2F
    .word ObjFrame30
    .word ObjFrame31
    .word ObjFrame32
    .word ObjFrame33
    .word ObjFrame34
    .word ObjFrame35
    .word ObjFrame36
    .word ObjFrame37
    .word ObjFrame38
    .word ObjFrame39
    .word ObjFrame3A
    .word ObjFrame3B
    .word ObjFrame3C
    .word ObjFrame3D
    .word ObjFrame3E
    .word ObjFrame3F
    .word ObjFrame40
    .word ObjFrame41
    .word ObjFrame42
    .word ObjFrame43
    .word ObjFrame44
    .word ObjFrame45
    .word ObjFrame46
    .word ObjFrame47
    .word ObjFrame48
    .word ObjFrame49
    .word ObjFrame4A

ObjPlacePtrTable: ;($72E3)
    .word ObjPlace0
    .word ObjPlace1
    .word ObjPlace2
    .word ObjPlace3
    .word ObjPlace4
    .word ObjPlace5
    .word ObjPlace6
    .word ObjPlace7

ObjPlace6:
    .byte $E9, $FC, $EB, $FC
ObjPlace0:
    .byte $F1, $F8, $F1, $00, $F9, $F0, $F9, $F8, $F9, $00, $01, $F8, $01, $00, $01, $08
    .byte $09, $F8, $09, $00, $09, $08, $F9, $F4, $F9, $F6, $ED, $F4, $EF, $F4
ObjPlace1:
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00
ObjPlace2:
    .byte $F9, $F6, $F9, $FE, $F9, $06, $01, $F6, $01, $FE, $01, $06
ObjPlace3:
    .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08
ObjPlace4:
    .byte $FC, $FC, $F8, $F8, $F8, $00, $00, $F8, $00, $00
ObjPlace5:
    .byte $E8, $00, $F0, $00, $F8, $00, $00, $00, $08, $00, $10, $00
ObjPlace7:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00



    .byte $FC, $F8, $F4, $F0, $EE, $EC, $EA, $E8, $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
    .byte $E5, $E7, $E9, $EB, $EF, $F3, $F7, $FB, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $ED, $EB, $EA, $E9, $E8, $E7, $E6
    .byte $E6, $E6, $E6, $E6, $E8, $EA, $EC, $EE, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $FC, $FA, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F1, $F0, $F0, $EF, $EF
    .byte $EF, $EF, $EF, $EF, $F0, $F0, $F1, $F2, $00, $00, $00, $00, $00, $00, $00, $00



ObjFrame00:
    .byte $00, $10, $06, $00, $01, $FE, $10, $11, $20, $21, $FE, $FE, $31, $FF
ObjFrame01:
    .byte $00, $10, $06, $02, $03, $FE, $12, $13, $22, $23, $FE, $32, $33, $34, $FF
ObjFrame02:
    .byte $00, $10, $06, $05, $06, $FE, $15, $16, $25, $26, $27, $35, $36, $FF
ObjFrame03:
    .byte $40, $10, $06, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $20, $21, $FE, $FE
    .byte $31, $FF
ObjFrame04:
    .byte $40, $10, $06, $02, $03, $FD, $20, $FE, $43, $42, $FD, $60, $22, $23, $FE, $32
    .byte $33, $34, $FF
ObjFrame05:
    .byte $40, $10, $06, $05, $06, $FD, $20, $FE, $45, $44, $FD, $60, $25, $26, $27, $35
    .byte $36, $FF
ObjFrame06:
    .byte $00, $10, $06, $0B, $0C, $FE, $1B, $1C, $2B, $2C, $FE, $3B, $3C, $FE, $17, $FF
ObjFrame07:
    .byte $00, $10, $06, $09, $FD, $60, $09, $FD, $20, $FE, $19, $FD, $60, $19, $FD, $20
    .byte $29, $2A, $FE, $39, $FD, $60, $39, $FF
ObjFrame08:
    .byte $40, $10, $06, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
    .byte $3C, $FE, $17, $FF
ObjFrame09:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $20, $21, $FE, $FE, $31, $FF
ObjFrame0A:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $22, $23, $FE, $32, $33, $34, $FF
ObjFrame0B:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $25, $26
    .byte $27, $35, $36, $FF
ObjFrame0C:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60
    .byte $20, $21, $FE, $FE, $31, $FF
ObjFrame0D:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49
    .byte $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
ObjFrame0E:
    .byte $40, $10, $06, $00, $01, $FD, $20
    .byte $4B, $4A, $49, $FD, $60, $25, $26, $27, $35, $36, $FF
ObjFrame0F:
    .byte $00, $10, $06, $00, $01
    .byte $FE, $10, $11, $22, $07, $08, $32, $FF
ObjFrame10:
    .byte $40, $10, $06, $00, $01, $FD, $20, $FE
    .byte $41, $40, $FD, $60, $22, $07, $08, $32, $FF
ObjFrame11:
    .byte $00, $10, $06, $00, $01, $46, $47
    .byte $48, $22, $07, $08, $32, $FF
ObjFrame12:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49
    .byte $FD, $60, $22, $07, $08, $32, $FF
ObjFrame13:
    .byte $01, $10, $06, $52, $53, $62, $63, $72, $73
    .byte $FF
ObjFrame14:
    .byte $02, $10, $06, $54, $55, $56, $64, $65, $66, $FF
ObjFrame15:
    .byte $C1, $10, $06, $52, $53
    .byte $62, $63, $72, $73, $FF
ObjFrame16:
    .byte $C2, $10, $06, $54, $55, $56, $64, $65, $66, $FF
ObjFrame17:
    .byte $41
    .byte $10, $06, $52, $53, $62, $63, $72, $73, $FF
ObjFrame18:
    .byte $42, $10, $06, $54, $55, $56, $64
    .byte $65, $66, $FF
ObjFrame19:
    .byte $81, $10, $06, $52, $53, $62, $63, $72, $73, $FF
ObjFrame1A:
    .byte $82, $10, $06
    .byte $54, $55, $56, $64, $65, $66, $FF
ObjFrame1B:
    .byte $01, $08, $06, $FC, $02, $00, $50, $51, $60
    .byte $61, $FF
ObjFrame1C:
    .byte $81, $08, $06, $FC, $FE, $00, $50, $51, $60, $61, $FF
ObjFrame1D:
    .byte $C1, $08, $06
    .byte $FC, $FE, $00, $50, $51, $60, $61, $FF
ObjFrame1E:
    .byte $41, $08, $06, $FC, $02, $00, $50, $51
    .byte $60, $61, $FF
ObjFrame1F:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $FD, $60, $2E
    .byte $2D, $FE, $FD, $20, $3B, $3C, $FF
ObjFrame20:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A
    .byte $5B, $FD, $60, $2E, $2D, $FE, $FD, $20, $3B, $3C, $FF
ObjFrame21:
    .byte $00, $10, $06, $0B, $0C
    .byte $FE, $1B, $1C, $2B, $2C, $FE, $3B, $3C, $FE, $FE, $17, $FF
ObjFrame22:
    .byte $40, $10, $06, $FD
    .byte $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B, $3C, $FE, $FE, $17
    .byte $FF
ObjFrame23:
    .byte $03, $04, $08, $FE, $28, $FD, $60, $28, $FF
ObjFrame24:
    .byte $03, $04, $10, $28, $38, $38
    .byte $FD, $60, $28, $FF
ObjFrame25:
    .byte $01, $10, $08, $4C, $4D, $5C, $5D, $6C, $6D, $FF
ObjFrame26:
    .byte $01, $10
    .byte $08, $4C, $4D, $5C, $5D, $5A, $5B, $FF
ObjFrame27:
    .byte $01, $10, $08, $4C, $4D, $5C, $5D, $6A
    .byte $6B, $FF
ObjFrame28:
    .byte $04, $02, $02, $30, $FF
ObjFrame29:
    .byte $04, $02, $02, $37, $FF
ObjFrame2A:
    .byte $04, $00, $00, $04
    .byte $FF
ObjFrame2B:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE
    .byte $FD, $60, $3B, $3C, $FF
ObjFrame2C:
    .byte $75, $18, $08, $0F, $1F, $2F, $FD, $E3, $2F, $1F, $0F
    .byte $FF
ObjFrame2D:
    .byte $75, $18, $08, $4D, $5D, $6D, $FD, $E3, $6D, $5D, $4D, $FF
ObjFrame2E:
    .byte $75, $18, $04
    .byte $6A, $6B, $6C, $FD, $E3, $6C, $6B, $6A, $FF
ObjFrame2F:
    .byte $75, $00, $00, $3F, $FE, $4F, $FD
    .byte $E3, $4F, $FE, $3F, $FF
ObjFrame30:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE, $78
    .byte $77, $2E, $2D, $FE, $FD, $60, $3B, $3C, $FF
ObjFrame31:
    .byte $35, $18, $08, $0F, $1F, $2F, $FD
    .byte $A3, $2F, $1F, $0F, $FF
ObjFrame32:
    .byte $35, $18, $08, $4D, $5D, $6D, $FD, $A3, $6D, $5D, $4D
    .byte $FF
ObjFrame33:
    .byte $35, $18, $04, $6A, $6B, $6C, $FD, $A3, $6C, $6B, $6A, $FF
ObjFrame34:
    .byte $35, $00, $00
    .byte $3F, $FE, $4F, $FD, $A3, $4F, $FE, $3F, $FF
ObjFrame35:
    .byte $07, $00, $00, $FC, $FC, $00, $09
    .byte $09, $19, $19, $29, $2A, $FF
ObjFrame36:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B
    .byte $22, $07, $08, $32, $FF
ObjFrame37:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $22
    .byte $07, $08, $32, $FF
ObjFrame38:
    .byte $46, $10, $06, $69, $FD, $20, $FE, $7A, $79, $FE, $78, $77
    .byte $FD, $60, $22, $07, $08, $32, $FF
ObjFrame39:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79
    .byte $FE, $78, $77, $FD, $60, $22, $07, $08, $32, $FF
ObjFrame3A:
    .byte $04, $04, $04, $70, $FF
ObjFrame3B:
    .byte $14
    .byte $04, $04, $71, $FF
ObjFrame3C:
    .byte $04, $0C, $0C, $FE, $74, $FD, $60, $74, $FD, $A0, $74, $FD
    .byte $E0, $74, $FF
ObjFrame3D:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $20, $21, $FE
    .byte $FE, $31, $FF
ObjFrame3E:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $22, $23, $FE
    .byte $32, $33, $34, $FF
ObjFrame3F:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $25, $26
    .byte $27, $35, $36, $FF
ObjFrame40:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77
    .byte $FD, $60, $20, $21, $FE, $FE, $31, $FF
ObjFrame41:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A
    .byte $79, $FE, $78, $77, $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
ObjFrame42:
    .byte $46, $10, $06
    .byte $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26, $27, $35, $36
    .byte $FF
ObjFrame43:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $20, $21, $FE, $FE, $31
    .byte $FF
ObjFrame44:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $22, $23, $FE, $32, $33
    .byte $34, $FF
ObjFrame45:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $25, $26, $27, $35
    .byte $36, $FF
ObjFrame46:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60
    .byte $20, $21, $FE, $FE, $31, $FF
ObjFrame47:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE
    .byte $78, $77, $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
ObjFrame48:
    .byte $46, $10, $06, $FE, $69
    .byte $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26, $27, $35, $36, $FF
ObjFrame49:
    .byte $04, $0C, $0C, $FE, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF
ObjFrame4A:
    .byte $04, $04, $04, $8A, $FF

L77EA:
    .byte $00

L77EB:
    .word L77EB_7810
    .word L77EB_7834
    .word L77EB_7858
    .word L77EB_787C
    .word L77EB_78A0
    .word L77EB_78C4
    .word L77EB_78E8
    .word L77EB_790C
    .word L77EB_7930
    .word L77EB_7954
    .word L77EB_7978
    .word L77EB_799C
    .word L77EB_79C0
    .word L77EB_79E4
    .word L77EB_7A08
    .word L77EB_7A2C
    .word L77EB_7A50
    .word L77EB_7A74

L77EB_7810:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $0F, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7834:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $35, $14, $04, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7858:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $39, $29, $09, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_787C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $36, $15, $06, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_78A0:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $27, $21, $12, $0F
    .byte $16, $1A, $27, $0F
    .byte $31, $20, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_78C4:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_78E8:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $01, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_790C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $02, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7930:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $01, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7954:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $12, $12, $02, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7978:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $11, $02, $02, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_799C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $31, $11, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_79C0:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $12, $30, $21, $0F
    .byte $27, $28, $29, $0F
    .byte $31, $11, $01, $0F
    .byte $16, $2A, $27, $0F
    .byte $12, $30, $21, $0F
    .byte $27, $24, $2C, $0F
    .byte $15, $21, $38, $00
L77EB_79E4:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $12, $02, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7A08:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $01, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7A2C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EB_7A50:
    .byte $3F, $00, $20, $30
    .byte $28, $18, $08, $30
    .byte $29, $1B, $1A, $30
    .byte $27, $28, $29, $30
    .byte $30, $30, $30, $30
    .byte $16, $1A, $27, $30
    .byte $37, $3A, $1B, $30
    .byte $17, $31, $37, $30
    .byte $32, $22, $12, $00
L77EB_7A74:
    .byte $3F, $00, $04, $0F
    .byte $30, $30, $21, $00

L7A7C:
    .byte $00, $20, $00, $40, $00, $60, $FF
    .byte $20, $40, $20, $60, $40, $60, $FF

L7A8A:
    lda $030D,x
    sta $07
    lda $030E,x
    sta $09
    lda $030C,x
    sta $0B
    rts

L7A9A:
    lda $030D,y
    sta $06
    lda $030E,y
    sta $08
    lda $030C,y
    sta $0A
    rts

L7AAA:
    lda $0301,x
    clc
    adc $0301,y
    sta $04
    lda $0302,x
    clc
    adc $0302,y
    sta $05
    rts
    lda #$02
    sta $01
    lda $07
    sec
    sbc $06
    sta $02
    lda $03
    bne L7AE3
    lda $0B
    eor $0A
    beq L7AE3
    lda $0B
    sbc $0A
    lsr a
    lda $0A
    eor $FF
    and #$01
    ora $01
    sta $01
    bne L7AEC
L7AE3:
    lda #$00
    sbc #$00
    bpl L7AEB
    inc $01
L7AEB:
    lsr a
L7AEC:
    lda $02
    bcc L7AF5
    beq L7B33
    jsr L6B4B
L7AF5:
    sta $11
    cmp $04
    bcs L7B33
    asl $01
    lda $09
    sec
    sbc $08
    sta $02
    lda $03
    beq L7B1F
    lda $0B
    eor $0A
    beq L7B1F
    lda $0B
    sbc $0A
    lsr a
    lda $0A
    eor $FF
    and #$01
    ora $01
    sta $01
    bne L7B26
L7B1F:
    sbc #$00
    bpl L7B25
    inc $01
L7B25:
    lsr a
L7B26:
    lda $02
    bcc L7B2F
    beq L7B33
    jsr L6B4B
L7B2F:
    sta $0F
    cmp $05
L7B33:
    rts



L7B34:
    PPUStringRepeat $1FF0, undefined, $00, $10
    
    PPUString $23C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    PPUString $23E0, undefined, \
        $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    PPUString $27C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUString $27E0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    PPUString $22E0, undefined, \
        $FF, $FF, $FF, $FF, $FF, $CC, $FF, $FF, $FF, $FF, $FF, $CD, $FF, $FF, $CE, $FF, $FF, $FF, $FF, $FF, $FF, $CC, $FF, $FF, $FF, $FF, $FF, $CD, $FF, $FF, $CE, $FF
    PPUString $2300, undefined, \
        $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1
    PPUString $2320, undefined, \
        $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3
    PPUString $2340, undefined, \
        $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5
    PPUString $2360, undefined, \
        $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7
    PPUString $2380, undefined, \
        $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9
    PPUString $23A0, undefined, \
        $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB
    
    PPUString $26E0, undefined, \
        $FF, $FF, $CC, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $CD, $FF, $FF, $FF, $FF, $FF, $FF, $CE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $CC, $FF, $FF, $FF, $FF
    PPUString $2700, undefined, \
        $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1, $C0, $C1
    PPUString $2720, undefined, \
        $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3, $C2, $C3
    PPUString $2740, undefined, \
        $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5, $C4, $C5
    PPUString $2760, undefined, \
        $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7, $C6, $C7
    PPUString $2780, undefined, \
        $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9, $C8, $C9
    PPUString $27A0, undefined, \
        $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB, $CA, $CB
    
    PPUStringEnd

L7DAF:
    .word L7DAF_7DC9
    .word L7DAF_7DED
    .word L7DAF_7E11
    .word L7DAF_7E35
    .word L7DAF_7E59
    .word L7DAF_7E75
    .word L7DAF_7E91
    .word L7DAF_7EAD
    .word L7DAF_7EC9
    .word L7DAF_7EE5
    .word L7DAF_7F01
    .word L7DAF_7F1D
    .word L7DAF_7F32

L7DAF_7DC9:
    PPUString $23C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    PPUStringEnd
L7DAF_7DED:
    PPUString $23E0, undefined, \
        $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
L7DAF_7E11:
    PPUString $27C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
L7DAF_7E35:
    PPUString $27E0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
L7DAF_7E59:
    PPUString $2124, undefined, \
        $FF, $FF, $FF, $03, $04, $05, $06, $07, $08, $FF, $0A, $0B, $0C, $FF, $FF, $0F, $70, $71, $72, $73, $74, $FF, $FF, $FF
    PPUStringEnd
L7DAF_7E75:
    PPUString $2144, undefined, \
        $FF, $FF, $12, $13, $14, $15, $16, $17, $18, $FF, $1A, $1B, $1C, $1D, $1E, $1F, $80, $81, $82, $83, $84, $85, $FF, $FF
    PPUStringEnd
L7DAF_7E91:
    PPUString $2164, undefined, \
        $FF, $FF, $FF, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $90, $91, $92, $93, $94, $95, $96, $FF
    PPUStringEnd
L7DAF_7EAD:
    PPUString $2184, undefined, \
        $FF, $FF, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $78, $79, $7A, $7B, $7C, $7D, $7E, $FF
    PPUStringEnd
L7DAF_7EC9:
    PPUString $21A4, undefined, \
        $FF, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
    PPUStringEnd
L7DAF_7EE5:
    PPUString $21C4, undefined, \
        $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    PPUStringEnd
L7DAF_7F01:
    PPUString $21E4, undefined, \
        $60, $61, $62, $63, $FF, $65, $66, $67, $FF, $69, $6A, $6B, $6C, $6D, $6E, $6F, $A8, $A9, $AA, $AB, $AC, $AD, $FF, $FF
    PPUStringEnd
L7DAF_7F1D:
    PPUString $2228, charmap_title, \
        "PUSH START BUTTON"
    PPUStringEnd
L7DAF_7F32:
    PPUString $2269, charmap_title, \
        "©1986 NINTENDO"
    PPUStringEnd

L7F44:
    .word L7F44_7F64
    .word L7F44_7F7F
    .word L7F44_7F9A
    .word L7F44_7FB5
    .word L7F44_7FD0
    .word L7F44_7FEB
    .word L7F44_8006
    .word L7F44_8021
    .word L7F44_803C
    .word L7F44_8057
    .word L7F44_8072
    .word L7F44_808D
    .word L7F44_80A8
    .word L7F44_80C3
    .word L7F44_80DE
    .word L7F44_80F9

L7F44_7F64:
    .byte $20, $A4, $46
    .stringmap charmap_title, "キンキュウ "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "     ゛"
    .stringmap charmap_title, "ワクセイ セ"
L7F44_7F7F:
    .byte $20, $AA, $46
    .stringmap charmap_title, "シレイ   "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, " ゛    "
    .stringmap charmap_title, "-へス ノ "
L7F44_7F9A:
    .byte $20, $B0, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "    ゛ "
    .stringmap charmap_title, "メトロイト "
L7F44_7FB5:
    .byte $20, $B6, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ヲ タオシ "
L7F44_7FD0:
    .byte $21, $24, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "キカイセイメ"
    .stringmap charmap_title, "      "
L7F44_7FEB:
    .byte $21, $2A, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "     ゛"
    .stringmap charmap_title, "イタイ マサ"
    .stringmap charmap_title, "      "
L7F44_8006:
    .byte $21, $30, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, " ゛    "
    .stringmap charmap_title, "-フレイン "
    .stringmap charmap_title, "      "
L7F44_8021:
    .byte $21, $36, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ヲ ハカイ "
    .stringmap charmap_title, "      "
L7F44_803C:
    .byte $21, $A4, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "セヨ!   "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
L7F44_8057:
    .byte $21, $AA, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "゛ ゛   "
    .stringmap charmap_title, "キンカ レン"
L7F44_8072:
    .byte $21, $B0, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "゜     "
    .stringmap charmap_title, "ホウ ケイサ"
L7F44_808D:
    .byte $21, $B6, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ツ M510"
L7F44_80A8:
    .byte $22, $24, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
L7F44_80C3:
    .byte $22, $2A, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
L7F44_80DE:
    .byte $22, $30, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
L7F44_80F9:
    .byte $22, $36, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "

L8114:
    .byte $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $51, $81, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00, $00, $03, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00, $00, $03

L8171:
    .word L8171_8179
    .word L8171_817A
    .word L8171_817D
    .word L8171_8180

L8171_8179:
    .byte $00
L8171_817A:
    .byte $18, $CC
    .byte $00
L8171_817D:
    .byte $18, $CD
    .byte $00
L8171_8180:
    .byte $18, $CE
    .byte $00



L8183:
    ldx #$0A
    @loop:
        lda L819C,x
        sta $0480,x
        sta $0490,x
        dex
        bpl @loop
    lda #$6B
    sta $0490
    lda #$DC
    sta $0493
    rts

L819C:
    eor #$E1
    ora ($3D,x)
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    jsr $0000
L81A7:
    ldx #$00
    jsr L81AE
    ldx #$10
L81AE:
    jsr L81B1
L81B1:
    lda $0485,x
    bne @endIf_A
        jsr L81F2
    @endIf_A:
    lda $048A,x
    bne L81F1
    dec $0485,x
    lda $0486,x
    clc
    adc $0480,x
    sta $0480,x
    lda $0487,x
    clc
    adc $0483,x
    sta $0483,x
    dec $0488,x
    bne L81EE
    lda $0481,x
    eor #$03
    sta $0481,x
    lda #$20
    sta $0488,x
    asl a
    eor $0482,x
    sta $0482,x
L81EE:
    jmp L8253
L81F1:
    rts



L81F2:
    txa
    jsr Adiv8
    tay
    lda $83F3,y
    sta $00
    lda $83F4,y
    sta $01
    ldy $0484,x
    lda ($00),y
    bpl L820D
    lda #$01
    sta $0489,x
L820D:
    bne L8214
    lda #$01
    sta $048A,x
L8214:
    sta $0485,x
    iny
    lda ($00),y
    dec $0489,x
    bmi L8228
    lda #$00
    sta $0486,x
    lda ($00),y
    bmi L823F
L8228:
    pha
    pha
    lda #$00
    sta $0489,x
    pla
    jsr Adiv16
    jsr L8249
    sta $0486,x
    pla
    and #$0F
    jsr L8249
L823F:
    sta $0487,x
    inc $0484,x
    inc $0484,x
    rts

L8249:
    cmp #$08
    bcc @RTS
    and #$07
    jsr L6B4B
@RTS:
    rts



L8253:
    lda $0480,x
    sec
    sbc #$01
    sta $0210,x
    lda $0481,x
    sta $0211,x
    lda $0482,x
    sta $0212,x
    lda $0483,x
    sta $0213,x
    rts



L826F:
    lda #$20
    sta $45
    ldx #$3F
    @loop:
        lda L8296,x
        cmp $FF
        beq @endIf_A
            sta $0480,x
            sta $04C0,x
        @endIf_A:
        dex
        bpl @loop
    lda #$B8
    sta $04E0
    sta $04F0
    lda #$16
    sta $04ED
    sta $04FD
    rts

L8296:
    .byte $20, $E0, $80, $00, $FF, $FF, $74, $58, $FF, $FF, $00, $FF, $1D, $0E, $01, $01
    .byte $20, $E0, $C0, $F8, $FF, $FF, $7C, $58, $FF, $FF, $00, $FF, $1F, $0E, $80, $01
    .byte $C8, $E0, $00, $00, $FF, $FF, $74, $60, $FF, $FF, $00, $FF, $1D, $1A, $01, $80
    .byte $C8, $E0, $40, $F8, $FF, $FF, $7C, $60, $FF, $FF, $00, $FF, $1F, $1A, $80, $80

L82D6:
    lda $44
    beq L830E
    dec $44
    bne L830E
    asl $048C
    asl $048D
    asl $049C
    asl $049D
    asl $04AC
    asl $04AD
    asl $04BC
    asl $04BD
    asl $04CC
    asl $04CD
    asl $04DC
    asl $04DD
    asl $04EC
    asl $04ED
    asl $04FC
    asl $04FD
L830E:
    ldx #$00
    jsr L833B
    ldx #$10
    jsr L833B
    ldx #$20
    jsr L833B
    ldx #$30
    lda $45
    beq L8327
    dec $45
    bne L833B
L8327:
    jsr L833B
    ldx #$40
    jsr L833B
    ldx #$50
    jsr L833B
    ldx #$60
    jsr L833B
    ldx #$70
L833B:
    lda $048A,x
    bne L834D
    jsr L8387
    bcs L834A
    lda #$01
    sta $048A,x
L834A:
    jmp L8253
L834D:
    rts
L834E:
    lda $4F
    beq RTS_8381
    ldy $4E
    cpy #$04
    bcc L835E
    bne RTS_8381
    lda #$00
    sta $4F
L835E:
    lda L8382,y
    sta $00
    ldy #$00
L8365:
    ldx $848F,y
    iny
L8369:
    lda $848F,y
    sta $0200,x
    inx
    iny
    txa
    and #$03
    bne L8369
    cpy $00
    bne L8365
    lda $27
    lsr a
    bcc RTS_8381
        inc $4E
    RTS_8381:
    rts

L8382:
    .byte $05, $19, $41, $19, $05

L8387:
    lda $048C,x
    jsr L83DA
    ldy $048E,x
    bpl L8397
    eor #$FF
    clc
    adc #$01
L8397:
    clc
    adc $0483,x
    sta $0483,x
    sec
    sbc $0486,x
    php
    pla
    eor $048E,x
    lsr a
    bcc L83CD
    lda $048D,x
    jsr L83DA
    ldy $048F,x
    bpl L83BA
    eor #$FF
    clc
    adc #$01
L83BA:
    clc
    adc $0480,x
    sta $0480,x
    sec
    sbc $0487,x
    php
    pla
    eor $048F,x
    lsr a
    bcs RTS_83D9
L83CD:
    lda $0487,x
    sta $0480,x
    lda $0486,x
    sta $0483,x
RTS_83D9:
    rts
L83DA:
    sta $04
    lda #$08
    sta $00
L83E0:
    lsr $04
    bcc L83EC
    lda $27
    and $00
    bne L83EC
    inc $04
L83EC:
    lsr $00
    bne L83E0
    lda $04
    rts

L83F3:
    .byte $F7, $83, $2D, $84, $01, $00, $01, $11, $01, $10, $06, $11, $07, $91, $10, $01
    .byte $03, $10, $01, $19, $01, $10, $01, $19, $01, $10, $01, $19, $09, $11, $04, $01
    .byte $02, $91, $01, $90, $01, $91, $06, $90, $01, $91, $06, $90, $15, $01, $06, $10
    .byte $01, $11, $0E, $01, $08, $91, $27, $01, $00, $00, $01, $00, $08, $09, $01, $99
    .byte $01, $09, $01, $99, $01, $09, $01, $99, $01, $09, $01, $99, $01, $09, $01, $99
    .byte $01, $09, $01, $99, $01, $09, $01, $99, $01, $09, $01, $99, $01, $09, $01, $99
    .byte $01, $09, $01, $99, $01, $19, $01, $11, $01, $10, $01, $11, $01, $10, $01, $11
    .byte $01, $10, $01, $11, $01, $10, $01, $11, $01, $10, $01, $11, $01, $10, $01, $11
    .byte $01, $10, $02, $11, $01, $10, $01, $11, $10, $09, $FF, $EF, $11, $09, $FF, $F3
    .byte $1F, $09, $FF, $EC, $0F, $09, $FF, $ED, $16, $09, $00, $00, $10, $5A, $E5, $00
    .byte $79, $14, $52, $E3, $00, $79, $18, $5A, $E7, $40, $71, $1C, $5A, $E7, $00, $81
    .byte $20, $62, $E3, $80, $79, $14, $52, $E4, $00, $79, $18, $5A, $E6, $00, $71, $1C
    .byte $5A, $E6, $00, $81, $20, $62, $E4, $00, $79, $24, $4A, $E3, $00, $79, $28, $5A
    .byte $E7, $40, $69, $2C, $5A, $E7, $00, $89, $30, $6A, $E3, $80, $79



L84D0:
    lda $50
    beq @RTS
    lda $27
    lsr a
    bcs @RTS
    ldx #$9F
    @loop:
        dec L8500,x
        dec $0260,x
        dex
        dex
        dex
        dex
        cpx #$FF
        bne @loop
    lda #$00
    sta $50
@RTS:
    rts

L84EE:
    ldy #$9F
    L84F0:
        lda L8500,y
        sta $0260,y
        dey
        cpy #$FF
        bne L84F0
    lda #$00
    sta $50
    rts

L8500:
    .byte $73, $CC, $22, $F2
    .byte $48, $CD, $63, $EE
    .byte $2A, $CE, $A2, $DC
    .byte $36, $CF, $E2, $C6
    .byte $11, $CC, $23, $B7
    .byte $53, $CD, $63, $A0
    .byte $BB, $CE, $A2, $9A
    .byte $0F, $CF, $E2, $8B
    .byte $85, $CC, $E2, $70
    .byte $9D, $CD, $A3, $6B
    .byte $A0, $CE, $63, $58
    .byte $63, $CF, $23, $4F
    .byte $0A, $CC, $22, $39
    .byte $1F, $CD, $23, $2A
    .byte $7F, $CE, $A3, $1F
    .byte $56, $CF, $A2, $03
    .byte $4D, $CC, $E3, $AF
    .byte $3E, $CD, $63, $2B
    .byte $61, $CE, $E2, $4F
    .byte $29, $CF, $62, $6F
    .byte $8A, $CC, $23, $82
    .byte $98, $CD, $A3, $07
    .byte $AE, $CE, $E2, $CA
    .byte $B6, $CF, $63, $E3
    .byte $0F, $CC, $62, $18
    .byte $1F, $CD, $22, $38
    .byte $22, $CE, $A3, $5F
    .byte $53, $CF, $E2, $78
    .byte $48, $CC, $E3, $94
    .byte $37, $CD, $A3, $B3
    .byte $6F, $CE, $A3, $DC
    .byte $78, $CF, $22, $FE
    .byte $83, $CC, $62, $0B
    .byte $9F, $CD, $23, $26
    .byte $A0, $CE, $62, $39
    .byte $BD, $CF, $A2, $1C
    .byte $07, $CC, $E3, $A4
    .byte $87, $CD, $63, $5D
    .byte $5A, $CE, $62, $4F
    .byte $38, $CF, $23, $85



L85A0:
    ldy $49
    lda L85AE,y
    cmp #$FF
    beq @RTS
        sta $1C
        inc $49
    @RTS:
    rts

L85AE:
    .byte $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0C, $FF



L85BB:
    ldy $4A
    lda L85D1,y
    cmp #$FF
    bne @else_A
        lda #$00
        sta $4A
        sta $48
        beq @endIf_A ; branch always
    @else_A:
        sta $1C
        inc $4A
    @endIf_A:
    rts

L85D1:
    .byte $11, $01, $11, $01, $11, $11, $01, $11, $01, $FF



L85DB:
    lda $27
    and #$0F
    bne L85E6
    lda $07A0
    beq L85E7
L85E6:
    rts
L85E7:
    lda #$19
    sta $00
    lda #$3F
    sta $01
    lda $4B
    and #$07
    asl a
    tay
    lda $8613,y
    sta $02
    lda $8614,y
    sta $03
    inc $4B
    jsr PrepPPUPaletteString
    lda #$1D
    sta $00
    lda #$3F
    sta $01
    iny
    jsr AddYToPtr02
    jmp PrepPPUPaletteString
    .byte $23
    stx $2D
    stx $37
    stx $41
    stx $4B
    stx $55
    stx $5F
    stx $69
    stx $03
    .byte $0F
    .byte $02
    .byte $13
    .byte $00
    .byte $03
    .byte $00
    .byte $34
    .byte $0F
    .byte $00
    .byte $03
    asl $01
    .byte $23
    .byte $00
    .byte $03
    .byte $0F
    .byte $34
    ora #$00
    .byte $03
    asl $0F,x
    .byte $23
    .byte $00
    .byte $03
    .byte $0F
    bit $1A
    .byte $00
    .byte $03
    .byte $17
    .byte $0F
    .byte $13
    .byte $00
    .byte $03
    .byte $00
    .byte $04
    plp
    .byte $00
    .byte $03
    .byte $17
    ora ($14,x)
    .byte $00
    .byte $03
    bpl L8662
    plp
    .byte $00
    .byte $03
    asl $02,x
    .byte $0F
    .byte $00
    .byte $03
    bmi L866C
    .byte $1A
    .byte $00
    .byte $03
    asl $12
L8662:
    .byte $0F
    .byte $00
    .byte $03
    bmi L866B
    ora #$00
    .byte $03
    .byte $0F
L866B:
    .byte $12
L866C:
    .byte $14
    .byte $00
    .byte $03
    bpl L8695
    .byte $0F
    .byte $00
L8673:
    ldy $4C
    lda L8673_8681,y
    cmp #$FF
    beq RTS_8680
    sta $1C
    inc $4C
RTS_8680:
    rts
L8673_8681:
    ora $0F0E
    bpl L8687
    .byte $FF
L8687:
    ora ($10,x)
    .byte $0F
    asl $FF0D
L868D:
    lda $5C
    beq RTS_86BD
    ldx #$01
    lda $13
L8695:
    asl a
    bcs @L869E
    asl a
    bcc RTS_86BD
    inx
    inx
    inx
@L869E:
    ldy #$03
    lda $15
    lsr a
    bcs L86B5
    lsr a
    bcs L86B0
    ldy #$00
    lsr a
    bcs L86B5
    lsr a
    bcc RTS_86BD
L86B0:
    txa
    jsr L6B4B
    tax
L86B5:
    txa
    clc
    adc $005D,y
    sta $005D,y
RTS_86BD:
    rts



L86BE:
    lda $59
    beq RTS_8706
    lda $55
    dec $56
    bne L86DA
    pha
    ldy $57
    lda $873B,y
    sta $55
    ldx $873C,y
    stx $56
    inc $57
    inc $57
    pla
L86DA:
    ldx #$01
    ldy $15
    sty $00
    sta $15
    eor $00
    beq L86EE
    lda $00
    and #$BF
    sta $00
    eor $15
L86EE:
    and $15
    sta $13
    sta $17
    ldy #$20
    lda $15
    cmp $00
    bne L8704
    dec $18,x
    bne RTS_8706
    sta $17
    ldy #$10
L8704:
    sty $18,x
RTS_8706:
    rts



L8707:
    lda $58
    beq RTS_873A
    ldx $57
    lda $15
    cmp L873B,x
    beq L8722
    ldy L873B+1,x
    bne L872A
    dex
    dex
    dec $57
    dec $57
    jmp L872A
L8722:
    inc L873B+1,x
    bne RTS_873A
    dec L873B+3,x
L872A:
    sta L873B+2,x
    inc L873B+3,x
    inc $57
    inc $57
    bne RTS_873A
    lda #$00
    sta $58
RTS_873A:
    rts


L873B:
    .byte $FF
    .byte $FF
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    bcc @L8750
    .byte $0B
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    lda ($01),y
@L8750:
    rol $81,x
    ora $2B01,x
    sta ($1E,x)
    ora ($2A,x)
    sta ($1B,x)
    ora ($28,x)
    sta ($1B,x)
    ora ($3A,x)
    eor ($06,x)
    ora ($05,x)
    eor ($06,x)
    ora ($05,x)
    eor ($05,x)
    ora ($06,x)
    eor ($06,x)
    ora ($07,x)
    eor ($03,x)
    ora ($06,x)
    eor ($06,x)
    ora ($06,x)
    eor ($04,x)
    ora ($06,x)
    eor ($05,x)
    ora ($06,x)
    eor ($05,x)
    ora ($06,x)
    eor ($06,x)
    ora ($1E,x)
    sta ($17,x)
    ora ($25,x)
    sta ($1D,x)
    ora ($25,x)
    sta ($20,x)
    ora ($22,x)
    sta ($25,x)
    ora ($1E,x)
    sta ($20,x)
    ora ($21,x)
    sta ($20,x)
    ora ($20,x)
    sta ($1E,x)
    ora ($22,x)
    sta ($29,x)
    ora ($32,x)
    eor ($08,x)
    ora ($05,x)
    eor ($06,x)
    ora ($05,x)
    eor ($07,x)
    ora ($04,x)
    eor ($06,x)
    ora ($05,x)
    eor ($06,x)
    ora ($2E,x)
    eor ($07,x)
    ora ($06,x)
    eor ($05,x)
    ora ($06,x)
    eor ($06,x)
    ora ($05,x)
    eor ($07,x)
    ora ($27,x)
    sta ($21,x)
    ora ($23,x)
    sta ($19,x)
    ora ($00,x)
    ora ($00,x)
    ora ($20,x)
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00



L883B:
    jsr ScreenOff
    jsr L69DF
    jsr EraseAllSprites
    jmp LCF1D



L6999_8847:
    lda #$FF
    sta $0102
    sta $0103
    jsr L883B
    lda $39
    bne L6999_8899
    lda $2002
    lda #$10
    sta $2006
    lda #$00
    sta $2006
    sta $2F
    tay
    tax
    lda #$15
    sta $2D
    lda #$C6
    sta $2E
L886F:
    lda ($2D),y
    sta $2007
    inc $2D
    lda $2D
    bne @L887C
    inc $2E
@L887C:
    inx
    bne L886F
    inc $2F
    lda $2F
    cmp #$08
    bne L886F
L8887:
    lda ($2D),y
    sta $2007
    inc $2D
    lda $2D
    bne L8894
    inc $2E
L8894:
    inx
    cpx #$20
    bne L8887
L6999_8899:
    lda #$00
    sta $39
    ldx #<L8F31.b
    ldy #>L8F31.b
    jsr L8E39
    inc $36
    jsr L8CF2
    dec $36
    lda $2002
    ldy #$00
L88B0:
    lda SaveData_C5A0,y
    and #$01
    beq L8915
    tya
    asl a
    tax
    jsr L8E70
    jsr L8E90
    lda $8D43,x
    sta $2006
    lda $8D44,x
    clc
    adc #$0F
    sta $2006
    lda $C5DC,x
    sta $2007
    lda $C5DD,x
    jsr L892D
    lda $8D43,x
    sta $2006
    lda $8D44,x
    clc
    adc #$24
    sta $2006
    lda $C5D3,x
    jsr L892D
    lda $C5D4,x
    jsr L892D
    lda $C5D9,y
    beq L8915
    pha
    lda $8D43,x
    sta $2006
    lda $8D44,x
    clc
    adc #$08
    sta $2006
    pla
    tax
L890D:
    lda #$74
    sta $2007
    dex
    bne L890D
L8915:
    iny
    cpy #$03
    bne L88B0
    jsr LL8C77
    sty $38
    lda #$0D
    sta $1C
    lda #$16
    sta $1F
L8927:
    jsr LCF27
    jmp L6CE0



L892D:
    pha
    lsr a
    lsr a
    lsr a
    lsr a
    sta $2007
    pla
    and #$0F
    sta $2007
    rts



L6999_893C:
    lda $12
    and #$30
    cmp #$10
    bne L8956
    ldy $38
    cpy #$03
    bcc L8992
    beq L8950
    ldy #$19
    bne L8952
L8950:
    ldy #$17
L8952:
    sty $1F
    bcs L896C
L8956:
    cmp #$20
    bne L896C
    ldy $38
    iny
    cpy #$05
    bne L8963
    ldy #$00
L8963:
    cpy #$03
    bcs L896A
    jsr L8C79
L896A:
    sty $38
L896C:
    ldy $38
    lda $898D,y
    sta $0200
    lda #$E8
    sta $0201
    lda #$03
    sta $0202
    lda #$18
    sta $0203
    ldx #$38
    ldy #$28
    jsr L8C95
    jmp L8DB1


    rti
    rts
    .byte $80
    ldy #$B8
L8992:
    lda $38
    asl a
    asl a
    asl a
    asl a
    tax
    ldy $C5EE,x
    beq L89A6
    dec $C5EE,x
    lda #$81
    sta $C5F0,x
L89A6:
    ldy #$00
L89A8:
    lda $C5E2,x
    sta $B410,y
    inx
    iny
    cpy #$10
    bne L89A8
    lda $38
    sta $B41F
    tax
    lda SaveData_C5A0,x
    ora $B41E
    sta $B41E
    and #$01
    sta SaveData_C5A0,x
    jsr LCE35
    jmp LCE66



L6999_89CE:
    jsr L883B
    ldx #$42
    ldy #$90
    jsr L8E39
    jsr L8D5E
    jsr L8CF2
    lda #$00
    sta $34
    sta $35
    lda #$80
    sta $33
    jsr L8C86
    sty $37
    inc $1F
    jmp L8927



L6999_89F2:
    jsr EraseAllSprites
    ldx #$30
    ldy #$58
    jsr L8C95
    jsr L8DB1
    ldy $37
    lda $12
    and #$30
    cmp #$10
    bne LL8A39
    cpy #$03
    bne LL8A39
    lda #$1B
    sta $1F
    inc $39
    ldx #$00
    ldy #$00
L8A17:
    lda #$00
    sta $2D
L8A1B:
    lda SaveData_C5A3,y
    cmp #$FF
    beq L8A2A
    lda SaveData_C5A0,x
    ora #$01
    sta SaveData_C5A0,x
L8A2A:
    iny
    inc $2D
    lda $2D
    cmp #$10
    bne L8A1B
    inx
    cpx #$03
    bne L8A17
    rts



LL8A39:
    cmp #$20
    bne @endIf_A
        lda #$80
        sta $33
        iny
        cpy #$04
        bne @endIf_B
            ldy #$00
        @endIf_B:
        cpy #$03
        beq @endIf_C
            jsr L8C88
        @endIf_C:
        sty $37
    @endIf_A:
    cpy #$03
    bne L8A58
    jmp L8AE8
L8A58:
    lda $12
    bpl L8AD5
    ldx $07A0
    tya
    asl a
    tay
    lda $8B81,y
    jsr L8E5C
    lda $33
    lsr a
    lsr a
    lsr a
    adc $8B82,y
    jsr L8E5C
    lda $34
    asl a
    tay
    lda $8FCF,y
    sta $2D
    lda $8FD0,y
    sta $2E
    ldy $35
    lda ($2D),y
    pha
    pha
    cmp #$5B
    beq L8A98
    cmp #$5C
    beq L8A98
    lda #$82
    jsr L8E5C
    lda #$FF
    bne L8A9A
L8A98:
    lda #$01
L8A9A:
    jsr L8E5C
    pla
    jsr L8E5C
    jsr L8E40
    lda $37
    sta $2D
    lda $33
    asl a
    ldx #$00
L8AAD:
    asl a
    rol $2D
    inx
    cpx #$04
    bne L8AAD
    ldx $2D
    pla
    cmp #$5B
    beq L8AC5
    cmp #$5C
    beq L8AC5
    sta SaveData_C5A3,x
    lda #$FF
L8AC5:
    sta $C5AB,x
    lda $33
    clc
    adc #$08
    cmp #$C0
    bne L8AD3
    lda #$80
L8AD3:
    sta $33
L8AD5:
    lda $12
    and #$40
    beq L8AE8
    lda $33
    sec
    sbc #$08
    cmp #$78
    bne @L8AE6
        lda #$B8
    @L8AE6:
    sta $33
L8AE8:
    ldy $37
    lda $8B87,y
    sta $0200
    lda #$E8
    sta $0201
    lda #$03
    sta $0202
    lda #$40
    sta $0203
    cpy #$03
    beq L8B80
    lda $27
    and #$08
    beq L8B1E
    lda $8B87,y
    sta $0204
    lda #$EC
    sta $0205
    lda #$20
    sta $0206
    lda $33
L8B1B:
    sta $0207
L8B1E:
    ldx $34
    ldy $35
    lda $16
    and #$0F
    beq L8B64
    lsr a
    bcc L8B3D
    iny
    cpy #$15
    bne LL8B3B
        inx
        cpx #$05
        bne L8B37
        .byte $A2
    L8B36:
        .byte $00
    L8B37:
        stx $34
        ldy #$00
    LL8B3B:
    sty $35
L8B3D:
    lsr a
    bcc L8B4E
    dey
    bpl L8B4C
    dex
    bpl L8B48
    ldx #$04
L8B48:
    stx $34
    ldy #$14
L8B4C:
    sty $35
L8B4E:
    lsr a
    bcc L8B5A
    inx
    cpx #$05
    bne L8B58
    ldx #$00
L8B58:
    stx $34
L8B5A:
    lsr a
    bcc L8B64
    dex
    bpl L8B62
    ldx #$04
L8B62:
    stx $34
L8B64:
    lda $27
    and #$08
    beq L8B80
    lda $8B8B,x
    sta $0208
    lda #$EC
    sta $0209
    lda #$20
    sta $020A
    lda $8B90,y
L8B7D:
    sta $020B
L8B80:
    rts
    jsr $21C0
    rti
    and ($C0,x)
    .byte $37
    .byte $57
    .byte $77
    .byte $8F
    .byte $A7
    .byte $AF
    .byte $B7
    .byte $BF
    .byte $C7
    jsr $3028
    sec
    rti
    .byte $50, $58
    rts
    pla
    bvs L8B1B
    dey
    bcc L8B36
    ldy #$B0
    clv
    cpy #$C8
    bne L8B7D



L6999_8BA5:
    jsr L883B
    ldx #$42
    ldy #$90
    jsr L8E39
    jsr L8D5E
    ldx #$8E
    ldy #$90
    jsr L8E39
    jsr L8CF2
    lda #$00
    sta $37
    inc $1F
    jmp L8927



L6999_8BC5:
    jsr EraseAllSprites
    ldx #$30
    ldy #$58
    jsr L8C95
    jsr L8DB1
    lda $12
    and #$10
    beq L8C41
    ldy $37
    cpy #$03
    bne L8BE3
    ldy #$17
    sty $1F
    rts
L8BE3:
    lda #$80
    sta SaveData_C5A0,y
    tya
    pha
    pha
    asl a
    tay
    ldx $07A0
    lda $8D49,y
    jsr L8E5C
    lda $8D4A,y
    jsr L8C6A
    lda $8D49,y
    jsr L8E5C
    lda $8D4A,y
    sec
    sbc #$20
    jsr L8C6A
    jsr L8E40
    pla
    asl a
    asl a
    asl a
    asl a
    tay
    ldx #$00
L8C16:
    lda #$FF
    sta SaveData_C5A3,y
    lda #$00
    sta $C5E2,y
    iny
    inx
    cpx #$10
    bne L8C16
    pla
    tay
    lda #$00
    sta $C5D9,y
    sta $C612,y
    tya
    asl a
    tay
    lda #$00
    sta $C5D3,y
    sta $C5D4,y
    sta $C5DC,y
    sta $C5DD,y
L8C41:
    lda $12
    and #$20
    beq L8C52
    ldx $37
    inx
    cpx #$04
    bne L8C50
    ldx #$00
L8C50:
    stx $37
L8C52:
    ldy $37
    lda $8B87,y
    sta $0200
    lda #$E8
    sta $0201
    lda #$03
    sta $0202
    lda #$40
    sta $0203
    rts
L8C6A:
    jsr L8E5C
    lda #$48
    jsr L8E5C
    lda #$FF
    jmp L8E5C
LL8C77:
    ldy #$00
L8C79:
    lda SaveData_C5A0,y
    and #$01
    bne L8C85
    iny
    cpy #$03
    bne L8C79
L8C85:
    rts
L8C86:
    ldy #$00
L8C88:
    lda SaveData_C5A0,y
    and #$01
    beq L8C94
    iny
    cpy #$03
    bne L8C88
L8C94:
    rts
L8C95:
    stx $2D
    sty $2E
    ldx #$80
    stx $2F
L8C9D:
    ldy #$00
L8C9F:
    lda L8CD7,y
    clc
    adc $2D
    sta $0200,x
    inx
    iny
    lda L8CD7,y
    sta $0200,x
    iny
    inx
    lda #$00
    sta $0200,x
    inx
    lda L8CD7,y
    clc
    adc $2E
    sta $0200,x
    iny
    inx
    cpy #$1B
    bne L8C9F
    lda $2D
    clc
    adc #$20
    sta $2D
    inc $2F
    lda $2F
    cmp #$83
    bne L8C9D
    rts

L8CD7:
    .byte $00, $C9, $00
    .byte $00, $CA, $08
    .byte $00, $CB, $10
    .byte $08, $D9, $00
    .byte $08, $DA, $08
    .byte $08, $DB, $10
    .byte $10, $E9, $00
    .byte $10, $EA, $08
    .byte $10, $EB, $10


L8CF2:
    lda $2002
    lda #$00
    tay
    sta $2D
    @loop:
        asl a
        pha
        tax
        lda $36
        beq @else_A
            lda L8D43,x
            sta $2E
            lda L8D43+1,x
            sta $2F
            bne @endIf_A ; branch always
        @else_A:
            lda L8D49,x
            sta $2E
            lda L8D49+1,x
            sta $2F
        @endIf_A:
        lda $2E
        sta $2006
        lda $2F
        sta $2006
        jsr L8D4F
        pla
        tax
        lda $2F
        sec
        sbc #$20
        pha
        lda $2E
        sbc #$00
        sta $2006
        pla
        sta $2006
        jsr L8D4F
        inc $2D
        lda $2D
        cmp #$03
        bne @loop
    rts

L8D43:
    .byte $21, $0A
    .byte $21, $8A
    .byte $22, $0A
L8D49:
    .byte $20, $F0
    .byte $21, $70
    .byte $21, $F0


L8D4F:
    ldx #$00
    @loop:
        lda SaveData_C5A3,y
        sta $2007
        iny
        inx
        cpx #$08
        bne @loop
    rts



L8D5E:
    lda $2002
    ldy #$00
    tya
    sta $2D
    sta $2E
    @loop_A:
        asl a
        tax
        lda L8DA7,x
        sta $2006
        lda L8DA7+1,x
        sta $2006
        @loop_B:
            ldx #$00
            @loop_C:
                lda $8FD9,y
                sta $2007
                iny
                inx
                cpx #$05
                bne @loop_C
            inc $2D
            lda $2D
            cmp #$04
            beq @exitLoop_B
            lda #$FF
            sta $2007
            bne @loop_B
        @exitLoop_B:
        lda $8FD9,y
        sta $2007
        iny
        lda #$00
        sta $2D
        inc $2E
        lda $2E
        cmp #$05
        bne @loop_A
    rts

L8DA7:
    .byte $22, $A4
    .byte $22, $C4
    .byte $22, $E4
    .byte $23, $04
    .byte $23, $24

L8DB1:
    lda $1F
    cmp #$16
    bne L8DBD
    ldy #$40
    sty $30
    bne L8DC3
L8DBD:
    ldy #$70
    lda #$00
    sta $30
L8DC3:
    sty $2F
    ldy #$00
    sty $2E
    ldx #$00
L8DCB:
    lda SaveData_C5A0,y
    and #$01
    beq L8E13
    lda $C612,y
    sta $31
    ldy #$00
    sty $2D
L8DDB:
    ldy $2E
    lda $8E33,y
    ldy $30
    beq L8DE7
    clc
    adc #$08
L8DE7:
    ldy $2D
    clc
    adc $8E36,y
    sta $0220,x
    inx
    lda $31
    asl a
    asl a
    adc $2D
    tay
    lda $8E1C,y
    sta $0220,x
    inx
    lda #$02
    sta $0220,x
    inx
    lda $2F
    sta $0220,x
    inx
    inc $2D
    ldy $2D
    cpy #$03
    bne L8DDB
L8E13:
    inc $2E
    ldy $2E
    cpy #$03
    bne L8DCB
    rts
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    cpy #$D0
    .byte $FF
    .byte $FF
    cmp ($D1,x)
    .byte $FF
    .byte $C3
    .byte $C2
    .byte $D2
    .byte $FF
    cmp $C4
    .byte $D4
    .byte $FF
    .byte $C7
    dec $D6
    bmi L8E85
    bvs L8E37
L8E37:
    .byte $08, $10

L8E39:
    stx $00
    sty $01
    jmp ProcessPPUString

L8E40:
    stx $07A0
    lda #$00
    sta $07A1,x
    lda #$01
    sta $1B
    rts
    sta $32
    and #$F0
    lsr a
    lsr a
    lsr a
    lsr a
    jsr L8E5C
    lda $32
    and #$0F
L8E5C:
    sta $07A1,x
    inx
    txa
    cmp #$55
    bcc L8E6F
    ldx $07A0
L8E68:
    lda #$00
    sta $07A1,x
    beq L8E68
L8E6F:
    rts
L8E70:
    tya
    pha
    jsr Amul16
    tay
    lda $C5EB,y
    sta $0B
    lda $C5EA,y
    sta $0A
    jsr L8EBB
    lda $06
L8E85:
    sta $C5DD,x
    lda $07
    sta $C5DC,x
    pla
    tay
    rts
L8E90:
    tya
    pha
    jsr Amul16
    tay
    lda $C5ED,y
    sta $0B
    lda $C5EC,y
    sta $0A
    jsr L8EBB
    lda $06
    sta $C5D4,x
    lda $07
    sta $C5D3,x
    lda $C5E2,y
    pha
    txa
    lsr a
    tay
    pla
    sta $C5D9,y
    pla
    tay
    rts



L8EBB:
    lda #$FF
    sta $01
    sta $02
    sta $03
    sec
    @loop:
        lda $0A
        sbc #$E8
        sta $0A
        lda $0B
        sbc #$03
        sta $0B
        inc $03
        bcs @loop
    lda $0A
    adc #$E8
    sta $0A
    lda $0B
    adc #$03
    sta $0B
    lda $0A
L8EE2:
    sec
L8EE3:
    sbc #$64
    inc $02
    bcs L8EE3
    dec $0B
    bpl L8EE2
    adc #$64
    sec
L8EF0:
    sbc #$0A
    inc $01
    bcs L8EF0
    adc #$0A
    sta $06
    lda $01
    jsr Amul16
    ora $06
    sta $06
    lda $03
    jsr Amul16
    ora $02
    sta $07
    rts


L8F0D:
    .byte $3F, $00, $20
    .byte $02, $20, $1B, $3A, $02, $20, $21, $01, $02, $2C, $30, $27, $02, $26, $31, $17
    .byte $02, $16, $19, $27, $02, $16, $20, $27, $02, $16, $20, $11, $02, $01, $20, $21
    .byte $00
    
L8F31:
    PPUString $2075, charmap_savemenu, \
        "゛"
    PPUString $2085, charmap_savemenu, \
        $6B, " セ レ ク ト シ テ ク タ サ イ ", $6B
    PPUString $20C2, charmap_savemenu, \
        "┌─────────NAME──ENERGY─DAY─┐"
    PPUStringRepeatVertical $20E2, charmap_savemenu, "│", $12
    PPUStringRepeatVertical $20FD, charmap_savemenu, "│", $12
    PPUStringVertical $2112, charmap_savemenu, \
        $6B, \
        " ", \
        " ", \
        " ", \
        $6B, \
        " ", \
        " ", \
        " ", \
        $6B
    PPUStringVertical $2118, charmap_savemenu, \
        $6B, \
        " ", \
        " ", \
        " ", \
        $6B, \
        " ", \
        " ", \
        " ", \
        $6B
    PPUString $2285, charmap_savemenu, \
        "ナマエ トウロク"
    PPUString $22E5, charmap_savemenu, \
        "KILL MODE"
    PPUString $2322, charmap_savemenu, \
        "└"
    PPUStringRepeat $2323, charmap_savemenu, "─", $1A
    PPUString $233D, charmap_savemenu, \
        "┘"
    
    PPUStringRepeat $23C0, undefined, $00, $14
    PPUString $23D4, undefined, \
        $04, $05, $00, $00, $00, $00, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, \
        $04, $05
    PPUStringRepeat $23E6, undefined, $00, $1A
    
    PPUStringEnd

L8FCF:
    .word L8FCF_8FD9
    .word L8FCF_8FEE
    .word L8FCF_9003
    .word L8FCF_9018
    .word L8FCF_902D

L8FCF_8FD9:
    .stringmap charmap_savemenu, "アイウエオ"
    .stringmap charmap_savemenu, "ハヒフへホ"
    .stringmap charmap_savemenu, "ァィゥェォ"
    .stringmap charmap_savemenu, "ABCDEF"
L8FCF_8FEE:
    .stringmap charmap_savemenu, "カキクケコ"
    .stringmap charmap_savemenu, "マミムメモ"
    .stringmap charmap_savemenu, "ャュョ ッ"
    .stringmap charmap_savemenu, "GHIJKL"
L8FCF_9003:
    .stringmap charmap_savemenu, "サシスセソ"
    .stringmap charmap_savemenu, "ヤ ユ ヨ"
    .stringmap charmap_savemenu, "゛゜-=+"
    .stringmap charmap_savemenu, "MNOPQR"
L8FCF_9018:
    .stringmap charmap_savemenu, "タチツテト"
    .stringmap charmap_savemenu, "ラリルレロ"
    .stringmap charmap_savemenu, "01234"
    .stringmap charmap_savemenu, "STUVWX"
L8FCF_902D:
    .stringmap charmap_savemenu, "ナ二ヌネノ"
    .stringmap charmap_savemenu, "ワ  ヲン"
    .stringmap charmap_savemenu, "56789"
    .stringmap charmap_savemenu, "YZ.?/!"

L9042:
    PPUStringRepeat $23C0, undefined, $00, $20
    PPUStringRepeat $23E0, undefined, $00, $20
    
    PPUStringRepeat $2080, charmap_savemenu, "─", $07
    PPUString $2089, charmap_savemenu, \
        "ナ マ エ ト ウ ロ ク"
    PPUStringRepeat $2099, charmap_savemenu, "─", $07
    PPUString $224B, charmap_savemenu, \
        "トウロク オワル"
    PPUString $2282, charmap_savemenu, \
        "┌"
    PPUStringRepeat $2283, charmap_savemenu, "─", $1A
    PPUString $229D, charmap_savemenu, \
        "┐"
    PPUStringRepeatVertical $22A2, charmap_savemenu, "│", $05
    PPUStringRepeatVertical $22BD, charmap_savemenu, "│", $05
    PPUString $2342, charmap_savemenu, \
        "└"
    PPUStringRepeat $2343, charmap_savemenu, "─", $1A
    PPUString $235D, charmap_savemenu, \
        "┘"
    
    PPUStringEnd

L908E:
    PPUString $2087, charmap_savemenu, \
        "K I L L    M O D E"
    PPUString $224B, charmap_savemenu, \
        "KILL"
    PPUStringEnd

; unreferenced(?) partial duplicate of routines in main.pgm file in side A
;($90AB-$90FF)
    .byte $66, $00, $99, $66, $00
    .byte $60, $20, $DB, $8E, $49, $01, $A8, $A9, $00, $F0, $F2, $A2, $B0, $BD, $00, $03
    .byte $F0, $08, $BD, $0B, $03, $D0, $03, $9D, $00, $03, $20, $E1, $A0, $30, $EE, $60
    .byte $BD, $00, $03, $C9, $05, $90, $0A, $98, $5D, $0C, $03, $4A, $B0, $03, $9D, $00
    .byte $03, $60, $98, $DD, $4B, $07, $D0, $05, $A9, $FF, $9D, $48, $07, $60, $AD, $90
    .byte $B5, $85, $00, $AD, $91, $B5, $85, $01, $A0, $00, $B1, $00, $C5, $49, $F0, $14

