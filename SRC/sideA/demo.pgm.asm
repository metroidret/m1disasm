
DEMO_RandomNumbers: ;($6800)
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
    jsr DEMO_ClearNameTables
    jsr DEMO_EraseAllSprites
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
    jsr DEMO_UpdateTimer
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
    jsr DEMO_RandomNumbers
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
    sta OAMADDR
    lda #$02
    sta OAMDMA
    lda $1A
    bne L694E
    jsr L6A45
    jsr DEMO_CheckPPUWrite
    jsr DEMO_WritePPUCtrl
    jsr L6A71
    lda PPUSTATUS
    lda $FF
    and #$01
    asl a
    asl a
    clc
    adc #$20
    sta PPUADDR
    lda #$00
    sta PPUADDR
    lda $3F
    sta $FD
    jsr DEMO_WriteScroll
    lda $43
    beq L694E
    L691E:
        lda PPUSTATUS
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
    jsr GotoLD18C
    L693D:
        lda PPUSTATUS
        and #$40
        beq L693D
    lda $40
    sta $FD
    jsr DEMO_WriteScroll
    jmp L6951




L694E:
    jsr GotoLD18C
L6951:
    lda JOY2
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
        jmp MainTitleRoutine
    L6966:
    lda MainRoutine
    jsr DEMO_ChooseRoutine
        .word RTS_6D00



MainTitleRoutine: ;($696D)
    ldy $5B
    beq L6988
        dey
        sty $5B
        sty $59
        sty $43
        sty $3F
        sty $40
        lda PPUCTRL_ZP
        and #$FC
        sta PPUCTRL_ZP
        lda #$1B
        sta TitleRoutine
        bne L6999
    L6988:
        jsr UnusedAttractMode_RecordMovie
        jsr UnusedAttractMode_PlayMovie
        lda TitleRoutine
        cmp #$0A
        bcs L6999
        jsr RemoveIntroSprites
        lda TitleRoutine
L6999:
    jsr DEMO_ChooseRoutine
        .word L6999_InitializeAfterReset00
        .word L6999_DrawIntroBackground
        .word L6999_6D8C
        .word L6999_6DDF
        .word L6999_6DF5
        .word L6999_6DBC
        .word L6999_6E00
        .word L6999_6E16
        .word L6999_6E35
        .word L6999_6E84
        .word L6999_IncTitleRoutine0A
        .word L6999_IncTitleRoutine0B
        .word L6999_6EE3
        .word L6999_6F26
        .word L6999_6F46
        .word L6999_6F66
        .word L6999_ClearSpareMem
        .word L6999_PrepIntroRestart
        .word L6999_TitleScreenOff
        .word L6999_TitleRoutineReturn13
        .word L6999_TitleRoutineReturn14
        .word L6999_8899
        .word L6999_893C
        .word L6999_89CE
        .word L6999_89F2
        .word L6999_8BA5
        .word L6999_8BC5
        .word L6999_8847
        .word L6999_InitializeAfterReset1C



L6999_ClearSpareMem:
    lda #$00
    sta $53
    sta $51
L6999_IncTitleRoutine0A:
L6999_IncTitleRoutine0B:
    inc TitleRoutine
    rts


DEMO_ClearNameTables: ;($69DF)
    jsr L69E6
    lda #$02
    bne L69E8 ; branch always
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



DEMO_EraseAllSprites: ;($6A1C)
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
    jmp DecSpriteYCoord

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
    jmp DecSpriteYCoord



L6A45:
    lda $52
    bne L6A56
    ldy $1C
    bne L6A5B
    lda $1F
    cmp #$15
    bcs RTS_6A5A
    jmp L85DB
L6A56:
    lda #$00
    sta $52
RTS_6A5A:
    rts

;LC1FF
L6A5B:
    dey
    tya
    asl a
    tay
    ldx L77EC,y
    lda L77EC+1,y
    tay
    lda #$00
    sta $1C
DEMO_PreparePPUProcess_:
    stx $00
    sty $01
    jmp DEMO_ProcessPPUString


;ReadJoyPads
L6A71:
    lda $59
    beq DEMO_ReadJoyPads
    jmp CheckIfStartIsPressed

DEMO_ReadJoyPads: ;($6A78)
    ldx #$00
    stx $01
    jsr DEMO_ReadOnePad
    ldx Joy2Port
    inc $01
    ; fallthrough

DEMO_ReadOnePad:
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
        bne RTS_6AC9
        ;Once RetrigDelay=#$00, store buttons to retrigger.
        sta Joy1Retrig,x
        ldy #$10
    @endIf_B:
    ;Reset retrigger delay to #$20(32 frames) or #$10(16 frames) if already retriggering.
    sty RetrigDelay1,x
RTS_6AC9:
    rts



CheckIfStartIsPressed: ;($6ACA)
    ldy #$01
    sty JOY1
    dey
    sty JOY1
    ldy #BUTTONBIT_START
    @loop:
        lda JOY1
        dey
        bne @loop
    and #$03
    beq RTS_6AC9
    
    iny
    sty $5B
    bne RTS_6AC9 ; branch always



DEMO_UpdateTimer:
    ; Default to only decrementing Timer2 and Timer1.
    ldx #$01
    ; branch if timer delay is not zero
    dec TimerDelay
    bpl @endIf_A
        ;TimerDelay hits #$00 every 10th frame.
        ;Reset TimerDelay after it hits #$00.
        lda #$09
        sta TimerDelay
        ;Decrement Timer3 every 10 frames.
        ldx #$02
    @endIf_A:
    
    ; decrement the chosen timers
    @loop_decTimer:
        ;Don't decrease if timer is already zero.
        lda Timer1,x
        beq @endIf_B
            dec Timer1,x
        @endIf_B:
        dex
        bpl @loop_decTimer
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



DEMO_WriteScroll: ;($6B1C)
    ;Reset scroll register flip/flop
    lda PPUSTATUS
    ;X and Y scroll offsets are loaded serially.
    lda ScrollX
    sta PPUSCROLL
    lda ScrollY
    sta PPUSCROLL
    rts


DEMO_AddYToPtr00: ;($6B2A)
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



AddYToPtr04: ;($6B40)
    tya
    clc
    adc $04
    sta $04
    bcc RTS_6B3F
        inc $05
    rts



DEMO_TwosComplement:
    eor #$FF
    clc
    adc #$01
    rts



DEMO_Adiv32: ;($6B51)
    lsr a
DEMO_Adiv16: ;($6B52)
    lsr a
DEMO_Adiv8: ;($6B53)
    lsr a
    lsr a
    lsr a
    rts



DEMO_Amul32: ;($6B57)
    asl a
DEMO_Amul16: ;($6B58)
    asl a
DEMO_Amul8: ;($6B59)
    asl a
    asl a
    asl a
    rts



DEMO_CheckPPUWrite: ;($6B5D)
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
    jsr DEMO_ProcessPPUString
    ;PPU data string has been written so the data stored for the write is now erased.
    lda #$00
    sta PPUStrIndex
    sta PPUDataString
    sta PPUDataPending
RTS_6B76:
    rts



DEMO_PPUWrite: ;($6B77)
    sta PPUADDR
    iny
    lda ($00),y
    sta PPUADDR
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
    jsr DEMO_AddYToPtr00



DEMO_ProcessPPUString: ;($6B9F)
    ldx PPUSTATUS
    ldy #$00
    lda ($00),y
    bne DEMO_PPUWrite
    jmp DEMO_WriteScroll



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



WriteTileBlast:
    ldy #$01
    sty PPUDataPending
    dey
    lda ($02),y
    and #$0F
    sta $05
    lda ($02),y
    jsr DEMO_Adiv16
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
        stx PPUStrIndex
        sty $06
        ldy #$20
        jsr DEMO_AddYToPtr00
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
    jsr DEMO_AddYToPtr00
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



DEMO_Base10Add:
    jsr DEMO_ExtractNibbles
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



DEMO_Base10Subtract:
    jsr DEMO_ExtractNibbles
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



DEMO_ExtractNibbles:
    pha
    and #$0F
    sta $01
    pla
    and #$F0
    sta $02
    lda $03
    and #$0F
    rts



DEMO_WaitNMIPass: ;($6CC5)
    jsr DEMO_ClearNMIStat
    @loop:
        lda NMIStatus
        beq @loop
    rts



DEMO_ClearNMIStat: ;($6CCD)
    lda #$00
    sta NMIStatus
    rts



DEMO_ScreenOff: ;($6CD2)
    lda PPUMASK_ZP
    and #~(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b

DEMO_WriteAndWait: ;($6CD6)
    sta PPUMASK_ZP
    
DEMO_WaitNMIPass_: ;($6CD8)
    jsr DEMO_ClearNMIStat
    @loop:
        lda NMIStatus
        beq @loop
    rts



DEMO_ScreenOn: ;($6CE0)
    lda PPUCTRL_ZP
    and #~PPUCTRL_OBJ_1000.B
    ora #PPUCTRL_BG_1000
    sta PPUCTRL_ZP
    sta PPUCTRL
    lda PPUMASK_ZP
    ora #PPUMASK_OBJ_ON | PPUMASK_BG_ON | PPUMASK_SHOW8OBJ | PPUMASK_SHOW8BG.b
    bne DEMO_WriteAndWait ; branch always



DEMO_WritePPUCtrl: ;($6CF1)
    lda PPUCTRL_ZP
    sta PPUCTRL
    lda PPUMASK_ZP
    sta PPUMASK
    lda FDS_CTRL_ZP
    sta FDS_CTRL
RTS_6D00:
    rts



L6999_InitializeAfterReset00: ;($6D01)
L6999_InitializeAfterReset1C:
    ldy #UnusedAttractMode_InputList@L873D - UnusedAttractMode_InputList.b
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
    @loop_A:
        stx $01
        txa
        and #$03
        asl a
        tay
        sty $02
        lda RamValueTbl,y
        ldy #$00
        @loop_B:
            sta ($00),y
            iny
            beq @exitloop_B
            cpy #$40
            bne @loop_B
            ldy $02
            lda RamValueTbl+1,y
            ldy #$40
            bpl @loop_B
        @exitloop_B:
        inx
        cpx #$68
        bne @loop_A
    inc TitleRoutine
    jmp LoadStarSprites

RamValueTbl: ;($6D61)
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $C0, $C4



L6999_DrawIntroBackground: ;($6D69)
    lda #$10
    sta $F0
    sta MusicFDSInitFlag
    jsr DEMO_ScreenOff
    jsr DEMO_ClearNameTables
    ldx #<PPUString_DrawIntroGround.b
    ldy #>PPUString_DrawIntroGround.b
    jsr DEMO_PreparePPUProcess_
    lda #$01
    sta PalDataPending
    sta $4D
    inc TitleRoutine
    lda #$00
    sta $62
    jmp DEMO_ScreenOn



L6999_6D8C:
    lda $62
    cmp #$0D
    bcs L6DB2
        asl a
        tay
        lda PPUStringTable_DrawIntroLogo,y
        sta $02
        lda PPUStringTable_DrawIntroLogo+1,y
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
    bne RTS_6E34
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
RTS_6E34:
    rts



L6999_6E35:
    lda $48
    beq L6E3C
        jsr L85BB
    L6E3C:
    lda $26
    bne RTS_6E83
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
    jsr LoadStarSprites
    lda #$00
    sta $4E
    inc $1F
    bne L6E80
L6E7D:
    jsr L82D6
L6E80:
    jsr L834E
RTS_6E83:
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

L6EA1:
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

L6EBB:
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
        lda TileBlastTable_DrawIntroMessage,y
        sta $02
        lda TileBlastTable_DrawIntroMessage+1,y
        sta $03
        ldy #$00
        lda ($02),y
        sta $01
        iny
        lda ($02),y
        sta $00
        iny
        jsr AddYToPtr02
        jmp WriteTileBlast
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
        lda TileBlastTable_DrawIntroMessage,y
        sta $04
        lda TileBlastTable_DrawIntroMessage+1,y
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
        jmp WriteTileBlast
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



L6999_PrepIntroRestart: ;($6FD1)
    lda Timer3
    bne @RTS
    
    sta $5A
    sta $43
    sta $0408
    
    ldy #$1F
    @loop:
        sta ObjAction,y
        dey
        bpl @loop
    lda PPUCTRL_ZP
    and #$FC
    sta PPUCTRL_ZP
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
    sty TitleRoutine
    lda IntroMusicRestart
    bne @dec63
        lda #$10
        sta $0684
        lda #$02
        sta $63
    @RTS:
        rts

    @dec63:
        dec IntroMusicRestart
        rts



L6999_TitleScreenOff: ;($701C)
    jsr DEMO_ScreenOff
    inc TitleRoutine
    rts



L6999_TitleRoutineReturn13: ;($7022)
L6999_TitleRoutineReturn14:
    rts



L7023:
    lda #$01
    sta $0680
    rts

L7029:
    lsr $0416
    lda ($00),y
    and #$C0
    ora $0416
    sta $05
    lda $0416
    ora #$80
    sta $0416
    rts

L703E:
    ldy #$00
    ldx $040E
    L7043:
        lda L70B5,y
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
    jsr DEMO_Adiv16
    jsr L70A9
    jsr L70B0
    beq L707E
    tya
    and #$0F
    jsr L70A9
    jsr L70B0
    beq L707E
    lda $0106
    jsr DEMO_Adiv16
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
    .byte $10, $8A, $00, $18
    .byte $10, $FF, $00, $20
    .byte $10, $FF, $00, $28
    .byte $10, $FF, $00, $30
    .byte $18, $FF, $00, $18
    .byte $18, $8E, $00, $28
    .byte $18, $FF, $00, $30

L70D1:
    stx $0E
    sty $10
    ldx #$00
    ldy #$08
    L70D9:
        lsr a
        bcs L70E0
        inx
        dey
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
    bne RTS_7138
    ldx #$05
    bne L7118
L70FC:
    dex
    bne L7102
    jmp L7105
    L7102:
        dex
        bne RTS_7138
L7105:
    ldx $FC
    bne RTS_7138
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
    jsr DEMO_Amul8
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
RTS_7138:
    rts

L7139:
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

UnknownAnimIndexTbl: ;($714F)
UnkAnim_00:
    .byte $00, $01, $02, $FF
UnkAnim_04:
    .byte $03, $04, $05, $FF
UnkAnim_08:
    .byte $13, $06, $FF
UnkAnim_0B:
    .byte $07, $FF
UnkAnim_0D:
    .byte $17, $08, $FF
UnkAnim_10:
    .byte $21, $FF
UnkAnim_12:
    .byte $22, $FF
UnkAnim_14:
    .byte $01, $0F, $FF
UnkAnim_17:
    .byte $04, $10, $FF
UnkAnim_1A:
    .byte $13, $14, $15, $16, $FF
UnkAnim_1F:
    .byte $17, $18, $19, $1A, $FF
UnkAnim_24:
    .byte $20, $1F, $FF
UnkAnim_27:
    .byte $00, $13, $FF
UnkAnim_2A:
    .byte $03, $17, $FF
UnkAnim_2D:
    .byte $1B, $1C, $1D, $1E, $FF
UnkAnim_32:
    .byte $1E, $1D, $1C, $1B, $FF
UnkAnim_37:
    .byte $28, $29, $FF
UnkAnim_3A:
    .byte $2A, $FF
UnkAnim_3C:
    .byte $1F, $20, $FF
UnkAnim_3F:
    .byte $11, $FF
UnkAnim_41:
    .byte $12, $FF
UnkAnim_43:
    .byte $09, $0A, $0B, $FF
UnkAnim_47:
    .byte $0C, $0D, $0E, $FF
UnkAnim_4B:
    .byte $2C, $FF
UnkAnim_4D:
    .byte $2C, $2C, $2C, $2C, $2C, $2C, $2C, $2C, $2D, $2D, $2D, $2D, $2D, $2E, $2E, $2E
    .byte $2F, $2F, $FF
UnkAnim_60:
    .byte $2F, $2F, $2E, $2E, $2E, $2D, $2D, $2D, $2D, $2D, $2C, $2C, $2C, $2C, $2C, $2C
    .byte $2C, $2C, $FF
UnkAnim_73:
    .byte $30, $2B, $FF
UnkAnim_76:
    .byte $31, $FF
UnkAnim_78:
    .byte $31, $31, $31, $31, $31, $31, $31, $31, $32, $32, $32, $32, $32, $33, $33, $33
    .byte $34, $34, $FF
UnkAnim_8B:
    .byte $34, $34, $33, $33, $33, $32, $32, $32, $32, $32, $31, $31, $31, $31, $31, $31
    .byte $31, $31, $FF
UnkAnim_9E:
    .byte $35, $FF
UnkAnim_A0:
    .byte $37, $36, $FF
UnkAnim_A3:
    .byte $39, $38, $FF
UnkAnim_A6:
    .byte $3A, $3B, $FF
UnkAnim_A9:
    .byte $3C, $F7, $49, $F7, $FF
UnkAnim_AE:
    .byte $3D, $3E, $3F, $FF
UnkAnim_B2:
    .byte $40, $41, $42, $FF
UnkAnim_B6:
    .byte $43, $FF
UnkAnim_B8:
    .byte $44, $FF
UnkAnim_BA:
    .byte $45, $FF
UnkAnim_BC:
    .byte $46, $FF
UnkAnim_BE:
    .byte $47, $FF
UnkAnim_C0:
    .byte $48, $FF
UnkAnim_C2:
    .byte $07, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $F7, $F7, $07, $F7, $FF
UnkAnim_D1:
    .byte $23, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $F7, $F7, $23, $F7, $FF
UnkAnim_E0:
    .byte $07, $F7, $F7, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $07, $F7, $FF
UnkAnim_EF:
    .byte $23, $F7, $F7, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $23, $F7, $FF
    
UnkFramePtrTable: ;($724D)
    .word UnkFrame00
    .word UnkFrame01
    .word UnkFrame02
    .word UnkFrame03
    .word UnkFrame04
    .word UnkFrame05
    .word UnkFrame06
    .word UnkFrame07
    .word UnkFrame08
    .word UnkFrame09
    .word UnkFrame0A
    .word UnkFrame0B
    .word UnkFrame0C
    .word UnkFrame0D
    .word UnkFrame0E
    .word UnkFrame0F
    .word UnkFrame10
    .word UnkFrame11
    .word UnkFrame12
    .word UnkFrame13
    .word UnkFrame14
    .word UnkFrame15
    .word UnkFrame16
    .word UnkFrame17
    .word UnkFrame18
    .word UnkFrame19
    .word UnkFrame1A
    .word UnkFrame1B
    .word UnkFrame1C
    .word UnkFrame1D
    .word UnkFrame1E
    .word UnkFrame1F
    .word UnkFrame20
    .word UnkFrame21
    .word UnkFrame22
    .word UnkFrame23
    .word UnkFrame24
    .word UnkFrame25
    .word UnkFrame26
    .word UnkFrame27
    .word UnkFrame28
    .word UnkFrame29
    .word UnkFrame2A
    .word UnkFrame2B
    .word UnkFrame2C
    .word UnkFrame2D
    .word UnkFrame2E
    .word UnkFrame2F
    .word UnkFrame30
    .word UnkFrame31
    .word UnkFrame32
    .word UnkFrame33
    .word UnkFrame34
    .word UnkFrame35
    .word UnkFrame36
    .word UnkFrame37
    .word UnkFrame38
    .word UnkFrame39
    .word UnkFrame3A
    .word UnkFrame3B
    .word UnkFrame3C
    .word UnkFrame3D
    .word UnkFrame3E
    .word UnkFrame3F
    .word UnkFrame40
    .word UnkFrame41
    .word UnkFrame42
    .word UnkFrame43
    .word UnkFrame44
    .word UnkFrame45
    .word UnkFrame46
    .word UnkFrame47
    .word UnkFrame48
    .word UnkFrame49
    .word UnkFrame4A

UnkPlacePtrTable: ;($72E3)
    .word UnkPlace0
    .word UnkPlace1
    .word UnkPlace2
    .word UnkPlace3
    .word UnkPlace4
    .word UnkPlace5
    .word UnkPlace6
    .word UnkPlace7

UnkPlace6:
    .byte $E9, $FC, $EB, $FC
UnkPlace0:
    .byte $F1, $F8, $F1, $00, $F9, $F0, $F9, $F8, $F9, $00, $01, $F8, $01, $00, $01, $08
    .byte $09, $F8, $09, $00, $09, $08, $F9, $F4, $F9, $F6, $ED, $F4, $EF, $F4
UnkPlace1:
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00
UnkPlace2:
    .byte $F9, $F6, $F9, $FE, $F9, $06, $01, $F6, $01, $FE, $01, $06
UnkPlace3:
    .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08
UnkPlace4:
    .byte $FC, $FC, $F8, $F8, $F8, $00, $00, $F8, $00, $00
UnkPlace5:
    .byte $E8, $00, $F0, $00, $F8, $00, $00, $00, $08, $00, $10, $00
UnkPlace7:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00



L7363:
    .byte $FC, $F8, $F4, $F0, $EE, $EC, $EA, $E8, $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
    .byte $E5, $E7, $E9, $EB, $EF, $F3, $F7, $FB, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $ED, $EB, $EA, $E9, $E8, $E7, $E6
    .byte $E6, $E6, $E6, $E6, $E8, $EA, $EC, $EE, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $FC, $FA, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F1, $F0, $F0, $EF, $EF
    .byte $EF, $EF, $EF, $EF, $F0, $F0, $F1, $F2, $00, $00, $00, $00, $00, $00, $00, $00



UnkFrame00:
    .byte $00, $10, $06, $00, $01, $FE, $10, $11, $20, $21, $FE, $FE, $31, $FF
UnkFrame01:
    .byte $00, $10, $06, $02, $03, $FE, $12, $13, $22, $23, $FE, $32, $33, $34, $FF
UnkFrame02:
    .byte $00, $10, $06, $05, $06, $FE, $15, $16, $25, $26, $27, $35, $36, $FF
UnkFrame03:
    .byte $40, $10, $06, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $20, $21, $FE, $FE
    .byte $31, $FF
UnkFrame04:
    .byte $40, $10, $06, $02, $03, $FD, $20, $FE, $43, $42, $FD, $60, $22, $23, $FE, $32
    .byte $33, $34, $FF
UnkFrame05:
    .byte $40, $10, $06, $05, $06, $FD, $20, $FE, $45, $44, $FD, $60, $25, $26, $27, $35
    .byte $36, $FF
UnkFrame06:
    .byte $00, $10, $06, $0B, $0C, $FE, $1B, $1C, $2B, $2C, $FE, $3B, $3C, $FE, $17, $FF
UnkFrame07:
    .byte $00, $10, $06, $09, $FD, $60, $09, $FD, $20, $FE, $19, $FD, $60, $19, $FD, $20
    .byte $29, $2A, $FE, $39, $FD, $60, $39, $FF
UnkFrame08:
    .byte $40, $10, $06, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
    .byte $3C, $FE, $17, $FF
UnkFrame09:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $20, $21, $FE, $FE, $31, $FF
UnkFrame0A:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $22, $23, $FE, $32, $33, $34, $FF
UnkFrame0B:
    .byte $00, $10, $06, $00, $01, $46, $47, $48, $25, $26
    .byte $27, $35, $36, $FF
UnkFrame0C:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60
    .byte $20, $21, $FE, $FE, $31, $FF
UnkFrame0D:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49
    .byte $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
UnkFrame0E:
    .byte $40, $10, $06, $00, $01, $FD, $20
    .byte $4B, $4A, $49, $FD, $60, $25, $26, $27, $35, $36, $FF
UnkFrame0F:
    .byte $00, $10, $06, $00, $01
    .byte $FE, $10, $11, $22, $07, $08, $32, $FF
UnkFrame10:
    .byte $40, $10, $06, $00, $01, $FD, $20, $FE
    .byte $41, $40, $FD, $60, $22, $07, $08, $32, $FF
UnkFrame11:
    .byte $00, $10, $06, $00, $01, $46, $47
    .byte $48, $22, $07, $08, $32, $FF
UnkFrame12:
    .byte $40, $10, $06, $00, $01, $FD, $20, $4B, $4A, $49
    .byte $FD, $60, $22, $07, $08, $32, $FF
UnkFrame13:
    .byte $01, $10, $06, $52, $53, $62, $63, $72, $73
    .byte $FF
UnkFrame14:
    .byte $02, $10, $06, $54, $55, $56, $64, $65, $66, $FF
UnkFrame15:
    .byte $C1, $10, $06, $52, $53
    .byte $62, $63, $72, $73, $FF
UnkFrame16:
    .byte $C2, $10, $06, $54, $55, $56, $64, $65, $66, $FF
UnkFrame17:
    .byte $41
    .byte $10, $06, $52, $53, $62, $63, $72, $73, $FF
UnkFrame18:
    .byte $42, $10, $06, $54, $55, $56, $64
    .byte $65, $66, $FF
UnkFrame19:
    .byte $81, $10, $06, $52, $53, $62, $63, $72, $73, $FF
UnkFrame1A:
    .byte $82, $10, $06
    .byte $54, $55, $56, $64, $65, $66, $FF
UnkFrame1B:
    .byte $01, $08, $06, $FC, $02, $00, $50, $51, $60
    .byte $61, $FF
UnkFrame1C:
    .byte $81, $08, $06, $FC, $FE, $00, $50, $51, $60, $61, $FF
UnkFrame1D:
    .byte $C1, $08, $06
    .byte $FC, $FE, $00, $50, $51, $60, $61, $FF
UnkFrame1E:
    .byte $41, $08, $06, $FC, $02, $00, $50, $51
    .byte $60, $61, $FF
UnkFrame1F:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $FD, $60, $2E
    .byte $2D, $FE, $FD, $20, $3B, $3C, $FF
UnkFrame20:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A
    .byte $5B, $FD, $60, $2E, $2D, $FE, $FD, $20, $3B, $3C, $FF
UnkFrame21:
    .byte $00, $10, $06, $0B, $0C
    .byte $FE, $1B, $1C, $2B, $2C, $FE, $3B, $3C, $FE, $FE, $17, $FF
UnkFrame22:
    .byte $40, $10, $06, $FD
    .byte $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B, $3C, $FE, $FE, $17
    .byte $FF
UnkFrame23:
    .byte $03, $04, $08, $FE, $28, $FD, $60, $28, $FF
UnkFrame24:
    .byte $03, $04, $10, $28, $38, $38
    .byte $FD, $60, $28, $FF
UnkFrame25:
    .byte $01, $10, $08, $4C, $4D, $5C, $5D, $6C, $6D, $FF
UnkFrame26:
    .byte $01, $10
    .byte $08, $4C, $4D, $5C, $5D, $5A, $5B, $FF
UnkFrame27:
    .byte $01, $10, $08, $4C, $4D, $5C, $5D, $6A
    .byte $6B, $FF
UnkFrame28:
    .byte $04, $02, $02, $30, $FF
UnkFrame29:
    .byte $04, $02, $02, $37, $FF
UnkFrame2A:
    .byte $04, $00, $00, $04
    .byte $FF
UnkFrame2B:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE
    .byte $FD, $60, $3B, $3C, $FF
UnkFrame2C:
    .byte $75, $18, $08, $0F, $1F, $2F, $FD, $E3, $2F, $1F, $0F
    .byte $FF
UnkFrame2D:
    .byte $75, $18, $08, $4D, $5D, $6D, $FD, $E3, $6D, $5D, $4D, $FF
UnkFrame2E:
    .byte $75, $18, $04
    .byte $6A, $6B, $6C, $FD, $E3, $6C, $6B, $6A, $FF
UnkFrame2F:
    .byte $75, $00, $00, $3F, $FE, $4F, $FD
    .byte $E3, $4F, $FE, $3F, $FF
UnkFrame30:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE, $78
    .byte $77, $2E, $2D, $FE, $FD, $60, $3B, $3C, $FF
UnkFrame31:
    .byte $35, $18, $08, $0F, $1F, $2F, $FD
    .byte $A3, $2F, $1F, $0F, $FF
UnkFrame32:
    .byte $35, $18, $08, $4D, $5D, $6D, $FD, $A3, $6D, $5D, $4D
    .byte $FF
UnkFrame33:
    .byte $35, $18, $04, $6A, $6B, $6C, $FD, $A3, $6C, $6B, $6A, $FF
UnkFrame34:
    .byte $35, $00, $00
    .byte $3F, $FE, $4F, $FD, $A3, $4F, $FE, $3F, $FF
UnkFrame35:
    .byte $07, $00, $00, $FC, $FC, $00, $09
    .byte $09, $19, $19, $29, $2A, $FF
UnkFrame36:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B
    .byte $22, $07, $08, $32, $FF
UnkFrame37:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $22
    .byte $07, $08, $32, $FF
UnkFrame38:
    .byte $46, $10, $06, $69, $FD, $20, $FE, $7A, $79, $FE, $78, $77
    .byte $FD, $60, $22, $07, $08, $32, $FF
UnkFrame39:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79
    .byte $FE, $78, $77, $FD, $60, $22, $07, $08, $32, $FF
UnkFrame3A:
    .byte $04, $04, $04, $70, $FF
UnkFrame3B:
    .byte $14
    .byte $04, $04, $71, $FF
UnkFrame3C:
    .byte $04, $0C, $0C, $FE, $74, $FD, $60, $74, $FD, $A0, $74, $FD
    .byte $E0, $74, $FF
UnkFrame3D:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $20, $21, $FE
    .byte $FE, $31, $FF
UnkFrame3E:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $22, $23, $FE
    .byte $32, $33, $34, $FF
UnkFrame3F:
    .byte $06, $10, $06, $69, $FE, $58, $59, $FE, $5A, $5B, $25, $26
    .byte $27, $35, $36, $FF
UnkFrame40:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77
    .byte $FD, $60, $20, $21, $FE, $FE, $31, $FF
UnkFrame41:
    .byte $46, $10, $06, $69, $FE, $FD, $20, $7A
    .byte $79, $FE, $78, $77, $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
UnkFrame42:
    .byte $46, $10, $06
    .byte $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26, $27, $35, $36
    .byte $FF
UnkFrame43:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $20, $21, $FE, $FE, $31
    .byte $FF
UnkFrame44:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $22, $23, $FE, $32, $33
    .byte $34, $FF
UnkFrame45:
    .byte $06, $10, $06, $FE, $69, $58, $59, $FE, $5A, $5B, $25, $26, $27, $35
    .byte $36, $FF
UnkFrame46:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60
    .byte $20, $21, $FE, $FE, $31, $FF
UnkFrame47:
    .byte $46, $10, $06, $FE, $69, $FD, $20, $7A, $79, $FE
    .byte $78, $77, $FD, $60, $22, $23, $FE, $32, $33, $34, $FF
UnkFrame48:
    .byte $46, $10, $06, $FE, $69
    .byte $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26, $27, $35, $36, $FF
UnkFrame49:
    .byte $04, $0C, $0C, $FE, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF
UnkFrame4A:
    .byte $04, $04, $04, $8A, $FF

L77EB:
    .byte $00

L77EC:
    .word L77EC_7810
    .word L77EC_7834
    .word L77EC_7858
    .word L77EC_787C
    .word L77EC_78A0
    .word L77EC_78C4
    .word L77EC_78E8
    .word L77EC_790C
    .word L77EC_7930
    .word L77EC_7954
    .word L77EC_7978
    .word L77EC_799C
    .word L77EC_79C0
    .word L77EC_79E4
    .word L77EC_7A08
    .word L77EC_7A2C
    .word L77EC_7A50
    .word L77EC_7A74

L77EC_7810:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $0F, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7834:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $35, $14, $04, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7858:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $39, $29, $09, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_787C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $36, $15, $06, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_78A0:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $27, $21, $12, $0F
    .byte $16, $1A, $27, $0F
    .byte $31, $20, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_78C4:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_78E8:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $01, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_790C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $02, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7930:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $01, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7954:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $12, $12, $02, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7978:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $11, $02, $02, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_799C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $31, $11, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_79C0:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $12, $30, $21, $0F
    .byte $27, $28, $29, $0F
    .byte $31, $11, $01, $0F
    .byte $16, $2A, $27, $0F
    .byte $12, $30, $21, $0F
    .byte $27, $24, $2C, $0F
    .byte $15, $21, $38, $00
L77EC_79E4:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $12, $02, $01, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7A08:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $02, $01, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7A2C:
    .byte $3F, $00, $20, $0F
    .byte $28, $18, $08, $0F
    .byte $29, $1B, $1A, $0F
    .byte $27, $28, $29, $0F
    .byte $01, $0F, $0F, $0F
    .byte $16, $1A, $27, $0F
    .byte $37, $3A, $1B, $0F
    .byte $17, $31, $37, $0F
    .byte $32, $22, $12, $00
L77EC_7A50:
    .byte $3F, $00, $20, $30
    .byte $28, $18, $08, $30
    .byte $29, $1B, $1A, $30
    .byte $27, $28, $29, $30
    .byte $30, $30, $30, $30
    .byte $16, $1A, $27, $30
    .byte $37, $3A, $1B, $30
    .byte $17, $31, $37, $30
    .byte $32, $22, $12, $00
L77EC_7A74:
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

L7ABD:
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
    beq RTS_7B33
    jsr DEMO_TwosComplement
L7AF5:
    sta $11
    cmp $04
    bcs RTS_7B33
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
    beq RTS_7B33
    jsr DEMO_TwosComplement
L7B2F:
    sta $0F
    cmp $05
RTS_7B33:
    rts



PPUString_DrawIntroGround: ;($7B34)
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

PPUStringTable_DrawIntroLogo: ;($7DAF)
    .word PPUStringTable_DrawIntroLogo_7DC9
    .word PPUStringTable_DrawIntroLogo_7DED
    .word PPUStringTable_DrawIntroLogo_7E11
    .word PPUStringTable_DrawIntroLogo_7E35
    .word PPUStringTable_DrawIntroLogo_7E59
    .word PPUStringTable_DrawIntroLogo_7E75
    .word PPUStringTable_DrawIntroLogo_7E91
    .word PPUStringTable_DrawIntroLogo_7EAD
    .word PPUStringTable_DrawIntroLogo_7EC9
    .word PPUStringTable_DrawIntroLogo_7EE5
    .word PPUStringTable_DrawIntroLogo_7F01
    .word PPUStringTable_DrawIntroLogo_7F1D
    .word PPUStringTable_DrawIntroLogo_7F32

PPUStringTable_DrawIntroLogo_7DC9:
    PPUString $23C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7DED:
    PPUString $23E0, undefined, \
        $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7E11:
    PPUString $27C0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7E35:
    PPUString $27E0, undefined, \
        $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7E59:
    PPUString $2124, undefined, \
        $FF, $FF, $FF, $03, $04, $05, $06, $07, $08, $FF, $0A, $0B, $0C, $FF, $FF, $0F, $70, $71, $72, $73, $74, $FF, $FF, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7E75:
    PPUString $2144, undefined, \
        $FF, $FF, $12, $13, $14, $15, $16, $17, $18, $FF, $1A, $1B, $1C, $1D, $1E, $1F, $80, $81, $82, $83, $84, $85, $FF, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7E91:
    PPUString $2164, undefined, \
        $FF, $FF, $FF, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $90, $91, $92, $93, $94, $95, $96, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7EAD:
    PPUString $2184, undefined, \
        $FF, $FF, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $78, $79, $7A, $7B, $7C, $7D, $7E, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7EC9:
    PPUString $21A4, undefined, \
        $FF, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7EE5:
    PPUString $21C4, undefined, \
        $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7F01:
    PPUString $21E4, undefined, \
        $60, $61, $62, $63, $FF, $65, $66, $67, $FF, $69, $6A, $6B, $6C, $6D, $6E, $6F, $A8, $A9, $AA, $AB, $AC, $AD, $FF, $FF
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7F1D:
    PPUString $2228, charmap_title, \
        "PUSH START BUTTON"
    PPUStringEnd
PPUStringTable_DrawIntroLogo_7F32:
    PPUString $2269, charmap_title, \
        "©1986 NINTENDO"
    PPUStringEnd

TileBlastTable_DrawIntroMessage: ;($7F44)
    .word TileBlastTable_DrawIntroMessage_7F64
    .word TileBlastTable_DrawIntroMessage_7F7F
    .word TileBlastTable_DrawIntroMessage_7F9A
    .word TileBlastTable_DrawIntroMessage_7FB5
    .word TileBlastTable_DrawIntroMessage_7FD0
    .word TileBlastTable_DrawIntroMessage_7FEB
    .word TileBlastTable_DrawIntroMessage_8006
    .word TileBlastTable_DrawIntroMessage_8021
    .word TileBlastTable_DrawIntroMessage_803C
    .word TileBlastTable_DrawIntroMessage_8057
    .word TileBlastTable_DrawIntroMessage_8072
    .word TileBlastTable_DrawIntroMessage_808D
    .word TileBlastTable_DrawIntroMessage_80A8
    .word TileBlastTable_DrawIntroMessage_80C3
    .word TileBlastTable_DrawIntroMessage_80DE
    .word TileBlastTable_DrawIntroMessage_80F9

TileBlastTable_DrawIntroMessage_7F64:
    .byte $20, $A4, $46
    .stringmap charmap_title, "キンキュウ "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "     ゛"
    .stringmap charmap_title, "ワクセイ セ"
TileBlastTable_DrawIntroMessage_7F7F:
    .byte $20, $AA, $46
    .stringmap charmap_title, "シレイ   "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, " ゛    "
    .stringmap charmap_title, "-へス ノ "
TileBlastTable_DrawIntroMessage_7F9A:
    .byte $20, $B0, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "    ゛ "
    .stringmap charmap_title, "メトロイト "
TileBlastTable_DrawIntroMessage_7FB5:
    .byte $20, $B6, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ヲ タオシ "
TileBlastTable_DrawIntroMessage_7FD0:
    .byte $21, $24, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "キカイセイメ"
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_7FEB:
    .byte $21, $2A, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "     ゛"
    .stringmap charmap_title, "イタイ マサ"
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_8006:
    .byte $21, $30, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, " ゛    "
    .stringmap charmap_title, "-フレイン "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_8021:
    .byte $21, $36, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ヲ ハカイ "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_803C:
    .byte $21, $A4, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "セヨ!   "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_8057:
    .byte $21, $AA, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "゛ ゛   "
    .stringmap charmap_title, "キンカ レン"
TileBlastTable_DrawIntroMessage_8072:
    .byte $21, $B0, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "゜     "
    .stringmap charmap_title, "ホウ ケイサ"
TileBlastTable_DrawIntroMessage_808D:
    .byte $21, $B6, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "ツ M510"
TileBlastTable_DrawIntroMessage_80A8:
    .byte $22, $24, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_80C3:
    .byte $22, $2A, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_80DE:
    .byte $22, $30, $46
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
    .stringmap charmap_title, "      "
TileBlastTable_DrawIntroMessage_80F9:
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
    .byte $49, $E1, $01, $3D, $00, $00, $00, $00, $20, $00, $00



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
    bne RTS_81F1
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
RTS_81F1:
    rts



L81F2:
    txa
    jsr DEMO_Adiv8
    tay
    lda SparkleAddressTbl,y
    sta $00
    lda SparkleAddressTbl+1,y
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
    jsr DEMO_Adiv16
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
    jsr DEMO_TwosComplement
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
    bne RTS_834D
    jsr UpdateCrossMissileCoords
    bcs L834A
    lda #$01
    sta $048A,x
L834A:
    jmp L8253
RTS_834D:
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
    lda CrossExplodeLengthTbl,y
    sta $00
    ldy #$00
L8365:
    ldx CrossExplodeDataTbl,y
    iny
L8369:
    lda CrossExplodeDataTbl,y
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

CrossExplodeLengthTbl: ;($8382)
    .byte CrossExplodeDataTbl@end_0 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_1 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_2 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_1 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_0 - CrossExplodeDataTbl



UpdateCrossMissileCoords: ;($8387)
    lda $048C,x
    jsr CalcDisplacement
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
        jsr CalcDisplacement
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



CalcDisplacement: ;($83DA)
    sta $04
    lda #$08
    sta $00
    L83E0:
        lsr $04
        bcc L83EC
        lda FrameCount
        and $00
        bne L83EC
        inc $04
    L83EC:
        lsr $00
        bne L83E0
    lda $04
    rts



SparkleAddressTbl: ;($83F3)
    .word TopSparkleDataTbl
    .word BottomSparkleDataTbl

TopSparkleDataTbl: ;($83F7)
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $06,  1,  1
    SignMagSpeed $07,  1, -1
    SignMagSpeed $10,  1,  0
    SignMagSpeed $03,  0,  1
    SignMagSpeed $01, -1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01, -1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01, -1,  1
    SignMagSpeed $09,  1,  1
    SignMagSpeed $04,  1,  0
    SignMagSpeed $02,  1, -1
    SignMagSpeed $01,  0, -1
    SignMagSpeed $01,  1, -1
    SignMagSpeed $06,  0, -1
    SignMagSpeed $01,  1, -1
    SignMagSpeed $06,  0, -1
    SignMagSpeed $15,  1,  0
    SignMagSpeed $06,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $0E,  1,  0
    SignMagSpeed $08,  1, -1
    SignMagSpeed $27,  1,  0
    SignMagSpeed $00,  0,  0

BottomSparkleDataTbl: ;($842D)
    SignMagSpeed $01,  0,  0
    SignMagSpeed $08, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $02,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $10, -1,  0
    .byte $FF, $EF
    SignMagSpeed $11, -1,  0
    .byte $FF, $F3
    SignMagSpeed $1F, -1,  0
    .byte $FF, $EC
    SignMagSpeed $0F, -1,  0
    .byte $FF, $ED
    SignMagSpeed $16, -1,  0
    SignMagSpeed $00,  0,  0



CrossExplodeDataTbl: ;($848F)
    .byte $10
    .byte $5A, $E5, $00, $79
    @end_0:
    .byte $14
    .byte $52, $E3, $00, $79
    .byte $18
    .byte $5A, $E7, $40, $71
    .byte $1C
    .byte $5A, $E7, $00, $81
    .byte $20
    .byte $62, $E3, $80, $79
    @end_1:
    .byte $14
    .byte $52, $E4, $00, $79
    .byte $18
    .byte $5A, $E6, $00, $71
    .byte $1C
    .byte $5A, $E6, $00, $81
    .byte $20
    .byte $62, $E4, $00, $79
    .byte $24
    .byte $4A, $E3, $00, $79
    .byte $28
    .byte $5A, $E7, $40, $69
    .byte $2C
    .byte $5A, $E7, $00, $89
    .byte $30
    .byte $6A, $E3, $80, $79
    @end_2:



DecSpriteYCoord: ;($84D0)
    lda $50
    beq @RTS
    lda FrameCount
    lsr a
    bcs @RTS
    ldx #$9F
    @loop:
        dec IntroStarsData,x
        dec SpriteRAM+$60,x
        dex
        dex
        dex
        dex
        cpx #$FF
        bne @loop
    lda #$00
    sta SpriteLoadPending
@RTS:
    rts

LoadStarSprites: ;($84EE)
    ldy #$9F
    @loop:
        lda IntroStarsData,y
        sta SpriteRAM+$60,y
        dey
        cpy #$FF
        bne @loop
    lda #$00
    sta SpriteLoadPending
    rts

IntroStarsData: ;($8500)
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
    bne RTS_85E6
    lda $07A0
    beq L85E7
RTS_85E6:
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
    lda L8613,y
    sta $02
    lda L8613+1,y
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

L8613:
    .word L8613_8623
    .word L8613_862D
    .word L8613_8637
    .word L8613_8641
    .word L8613_864B
    .word L8613_8655
    .word L8613_865F
    .word L8613_8669

L8613_8623:
    .byte $03, $0F, $02, $13, $00, $03, $00, $34, $0F, $00
L8613_862D:
    .byte $03, $06, $01, $23, $00, $03, $0F, $34, $09, $00
L8613_8637:
    .byte $03, $16, $0F, $23, $00, $03, $0F, $24, $1A, $00
L8613_8641:
    .byte $03, $17, $0F, $13, $00, $03, $00, $04, $28, $00
L8613_864B:
    .byte $03, $17, $01, $14, $00, $03, $10, $0F, $28, $00
L8613_8655:
    .byte $03, $16, $02, $0F, $00, $03, $30, $0F, $1A, $00
L8613_865F:
    .byte $03, $06, $12, $0F, $00, $03, $30, $04, $09, $00
L8613_8669:
    .byte $03, $0F, $12, $14, $00, $03, $10, $24, $0F, $00



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
    .byte $0D, $0E, $0F, $10, $01, $FF
    .byte $01, $10, $0F, $0E, $0D, $FF



L868D:
    lda $5C
    beq RTS_86BD
    ldx #$01
    lda $13
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
    jsr DEMO_TwosComplement
    tax
L86B5:
    txa
    clc
    adc $005D,y
    sta $005D,y
RTS_86BD:
    rts



; routine to force a sequence of joypad inputs into ram
; only used on the title screen, where those ram addresses are ignored anyway
UnusedAttractMode_PlayMovie: ;($86BE)
    ; exit if not playing back the inputs
    lda UnusedAttractModeIsPlaying
    beq @RTS
    
    lda UnusedAttractModeJoyStatus
    ; branch if delay didnt run out
    dec UnusedAttractModeDelay
    bne @endIf_A
        ; delay ran out
        pha
        ldy UnusedAttractModeInstrID
        ; update attract mode joypad
        lda UnusedAttractMode_InputList,y
        sta UnusedAttractModeJoyStatus
        ; set up new delay
        ldx UnusedAttractMode_InputList+1,y
        stx UnusedAttractModeDelay
        ; increment instruction index to next instruction
        inc UnusedAttractModeInstrID
        inc UnusedAttractModeInstrID
        pla
    @endIf_A:
    
    ;Get joypad status of previous refresh.
    ldx #$01
    ldy Joy2Status
    ;Store at $00.
    sty $00
    
    ;Store current joypad status.
    sta Joy2Status
    
    ;Branch if no buttons changed.
    eor $00
    beq @endIf_B
        ;Remove the previous status of the B button.
        lda $00
        and #~BUTTON_B.b
        sta $00
        eor Joy2Status
    @endIf_B:
    
    ;Save any button changes from the current frame and the last frame to the joy change addresses.
    and Joy2Status
    sta Joy2Change
    ;Store any changed buttons in JoyRetrig address.
    sta Joy2Retrig
    
    ldy #$20
    ;Checks to see if same buttons are being pressed this frame as last frame.
    lda Joy2Status
    cmp $00
    ;If none, branch.
    bne @endIf_C
        ;Decrement RetrigDelay if same buttons pressed.
        dec RetrigDelay1,x
        bne @RTS
        ;Once RetrigDelay=#$00, store buttons to retrigger.
        sta Joy2Retrig
        ldy #$10
    @endIf_C:
    ;Reset retrigger delay to #$20(32 frames) or #$10(16 frames) if already retriggering.
    sty RetrigDelay1,x
@RTS:
    rts



UnusedAttractMode_RecordMovie: ;($8707)
    ; exit if not recording the inputs
    lda UnusedAttractModeIsRecording
    beq @RTS
    
    ; branch if current joypad input is equal to current instruction's input
    ldx UnusedAttractModeInstrID
    lda Joy2Status
    cmp UnusedAttractMode_InputList,x
    beq @else_A
        ; they are different
        ; if time is not zero, create new instruction after the current one
        ldy UnusedAttractMode_InputList+1,x
        bne @endIf_A
        ; time is zero, new instruction overwrites current instruction
        dex
        dex
        dec UnusedAttractModeInstrID
        dec UnusedAttractModeInstrID
        jmp @endIf_A
    @else_A:
        ; they are the same
        ; increase time for current instruction
        inc UnusedAttractMode_InputList+1,x
        ; exit if time is < $100
        bne @RTS
        ; time is $100, we must create a new instruction with time of zero to prolong the input
        dec UnusedAttractMode_InputList+3,x
    @endIf_A:
    sta UnusedAttractMode_InputList+2,x
    inc UnusedAttractMode_InputList+3,x
    inc UnusedAttractModeInstrID
    inc UnusedAttractModeInstrID
    ; branch if we're not at the end of the input list
    bne @RTS
        ; we're at the end of the list, we can't record any extra instructions
        ; stop recording
        lda #$00
        sta UnusedAttractModeIsRecording
@RTS:
    rts



UnusedAttractMode_InputList: ;($873B)
    .byte $FF, $FF
@L873D:
    ;       controller input        time
    .byte $00,                     $100 & $FF
    .byte $00,                     $100 & $FF
    .byte $00,                     $100 & $FF
    .byte $00,                     $100 & $FF
    .byte $00,                      $90
    .byte BUTTON_UP,                $0B
    .byte $00,                     $100 & $FF
    .byte $00,                     $100 & $FF
    .byte $00,                      $B1
    .byte BUTTON_RIGHT,             $36
    .byte BUTTON_RIGHT | BUTTON_A,  $1D
    .byte BUTTON_RIGHT,             $2B ; title screen restarts in the middle of this instruction, so the rest are fully unused
    .byte BUTTON_RIGHT | BUTTON_A,  $1E
    .byte BUTTON_RIGHT,             $2A
    .byte BUTTON_RIGHT | BUTTON_A,  $1B
    .byte BUTTON_RIGHT,             $28
    .byte BUTTON_RIGHT | BUTTON_A,  $1B
    .byte BUTTON_RIGHT,             $3A
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $05
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $07
    .byte BUTTON_RIGHT | BUTTON_B,  $03
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $04
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $05
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $05
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $1E
    .byte BUTTON_RIGHT | BUTTON_A,  $17
    .byte BUTTON_RIGHT,             $25
    .byte BUTTON_RIGHT | BUTTON_A,  $1D
    .byte BUTTON_RIGHT,             $25
    .byte BUTTON_RIGHT | BUTTON_A,  $20
    .byte BUTTON_RIGHT,             $22
    .byte BUTTON_RIGHT | BUTTON_A,  $25
    .byte BUTTON_RIGHT,             $1E
    .byte BUTTON_RIGHT | BUTTON_A,  $20
    .byte BUTTON_RIGHT,             $21
    .byte BUTTON_RIGHT | BUTTON_A,  $20
    .byte BUTTON_RIGHT,             $20
    .byte BUTTON_RIGHT | BUTTON_A,  $1E
    .byte BUTTON_RIGHT,             $22
    .byte BUTTON_RIGHT | BUTTON_A,  $29
    .byte BUTTON_RIGHT,             $32
    .byte BUTTON_RIGHT | BUTTON_B,  $08
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $07
    .byte BUTTON_RIGHT,             $04
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $2E
    .byte BUTTON_RIGHT | BUTTON_B,  $07
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $05
    .byte BUTTON_RIGHT,             $06
    .byte BUTTON_RIGHT | BUTTON_B,  $06
    .byte BUTTON_RIGHT,             $05
    .byte BUTTON_RIGHT | BUTTON_B,  $07
    .byte BUTTON_RIGHT,             $27
    .byte BUTTON_RIGHT | BUTTON_A,  $21
    .byte BUTTON_RIGHT,             $23
    .byte BUTTON_RIGHT | BUTTON_A,  $19
    .byte BUTTON_RIGHT,            $100 & $FF
    .byte BUTTON_RIGHT,            $100 & $FF
    .byte BUTTON_RIGHT,             $20
    .byte $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00



L883B:
    jsr DEMO_ScreenOff
    jsr DEMO_ClearNameTables
    jsr DEMO_EraseAllSprites
    jmp VBOffAndHorzWrite



L6999_8847:
    lda #$FF
    sta FDS_RESETFLAG
    sta FDS_RESETTYPE
    jsr L883B
    lda $39
    bne L6999_8899
    lda PPUSTATUS
    lda #$10
    sta PPUADDR
    lda #$00
    sta PPUADDR
    sta $2F
    tay
    tax
    lda #<LC615.b
    sta $2D
    lda #>LC615.b
    sta $2E
L886F:
    lda ($2D),y
    sta PPUDATA
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
    sta PPUDATA
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
    ldx #<PPUString_8F31.b
    ldy #>PPUString_8F31.b
    jsr DEMO_PreparePPUProcess
    inc $36
    jsr L8CF2
    dec $36
    lda PPUSTATUS
    ldy #$00
L88B0:
    lda SaveData@enable,y
    and #$01
    beq L8915
    tya
    asl a
    tax
    jsr UpdateSaveDataDay
    jsr UpdateSaveDataGameOverCountAndEnergyTank
    lda L8D43,x
    sta PPUADDR
    lda L8D43+1,x
    clc
    adc #$0F
    sta PPUADDR
    lda SaveData@day,x
    sta PPUDATA
    lda SaveData@day+1,x
    jsr L892D
    lda L8D43,x
    sta PPUADDR
    lda L8D43+1,x
    clc
    adc #$24
    sta PPUADDR
    lda SaveData@gameOverCount,x
    jsr L892D
    lda SaveData@gameOverCount+1,x
    jsr L892D
    lda SaveData@energyTank,y
    beq L8915
    pha
    lda L8D43,x
    sta PPUADDR
    lda L8D43+1,x
    clc
    adc #$08
    sta PPUADDR
    pla
    tax
    L890D:
        lda #$74
        sta PPUDATA
        dex
        bne L890D
L8915:
    iny
    cpy #$03
    bne L88B0
    jsr LL8C77
    sty $38
    lda #$0D
    sta PalDataPending
    lda #$16
    sta $1F
L8927:
    jsr NMIOn
    jmp DEMO_ScreenOn



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
    lda L898D,y
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

L898D:
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
    ldy SaveData@samusStat@0.byteC,x
    beq L89A6
    dec SaveData@samusStat@0.byteC,x
    lda #$81
    sta SaveData@samusStat@0.byteE,x
L89A6:
    ldy #$00
    L89A8:
        lda SaveData@samusStat,x
        sta CurSamusStat,y
        inx
        iny
        cpy #$10
        bne L89A8
    lda $38
    sta CurSamusStat+$F
    tax
    lda SaveData@enable,x
    ora CurSamusStat+$E
    sta CurSamusStat+$E
    and #$01
    sta SaveData@enable,x
    jsr LCE35
    jmp LCE66



L6999_89CE:
    jsr L883B
    ldx #<PPUString_9042.b
    ldy #>PPUString_9042.b
    jsr DEMO_PreparePPUProcess
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
    jsr DEMO_EraseAllSprites
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
            lda SaveData@name,y
            cmp #$FF
            beq L8A2A
                lda SaveData@enable,x
                ora #$01
                sta SaveData@enable,x
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
    bpl CheckBackspace
    ldx PPUStrIndex
    tya
    asl a
    tay
    lda L8B81,y
    jsr UnusedIntroRoutine5@subroutine
    lda $33
    lsr a
    lsr a
    lsr a
    adc L8B81+1,y
    jsr UnusedIntroRoutine5@subroutine
    lda $34
    asl a
    tay
    lda L8FCF,y
    sta $2D
    lda L8FCF+1,y
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
        jsr UnusedIntroRoutine5@subroutine
        lda #$FF
        bne L8A9A
    L8A98:
        lda #$01
    L8A9A:
    jsr UnusedIntroRoutine5@subroutine
    pla
    jsr UnusedIntroRoutine5@subroutine
    jsr UnusedIntroRoutine4
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
    sta SaveData@name,x
    lda #$FF
L8AC5:
    sta SaveData@name+$8,x
    lda $33
    clc
    adc #$08
    cmp #$C0
    bne L8AD3
        lda #$80
    L8AD3:
    sta $33

CheckBackspace: ;($8AD5)
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
    lda SaveDataYTbl,y
    sta SpriteRAM+$00+0
    lda #$E8
    sta SpriteRAM+$00+1
    lda #$03
    sta SpriteRAM+$00+2
    lda #$40
    sta SpriteRAM+$00+3
    cpy #$03
    beq RTS_8B80
    lda $27
    and #$08
    beq L8B1E
        lda SaveDataYTbl,y
        sta SpriteRAM+$04+0
        lda #$EC
        sta SpriteRAM+$04+1
        lda #$20
        sta SpriteRAM+$04+2
        lda $33
        sta SpriteRAM+$04+3
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
                ldx #$00
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
    beq RTS_8B80
    lda CharSelectYTbl,x
    sta SpriteRAM+$08+0
    lda #$EC
    sta SpriteRAM+$08+1
    lda #$20
    sta SpriteRAM+$08+2
    lda CharSelectXTbl,y
    sta SpriteRAM+$08+3
RTS_8B80:
    rts

L8B81: ;($8B81)
    .byte $20, $C0
    .byte $21, $40
    .byte $21, $C0

SaveDataYTbl: ;($8B87)
    .byte $37, $57, $77, $8F

CharSelectYTbl: ;($8B8B)
    .byte $A7, $AF, $B7, $BF, $C7

CharSelectXTbl: ;($8B90)
    .byte $20,$28,$30,$38,$40,   $50,$58,$60,$68,$70,   $80,$88,$90,$98,$A0,   $B0,$B8,$C0,$C8,$D0,$D8



L6999_8BA5:
    jsr L883B
    ldx #<PPUString_9042.b
    ldy #>PPUString_9042.b
    jsr DEMO_PreparePPUProcess
    jsr L8D5E
    ldx #<PPUString_908E.b
    ldy #>PPUString_908E.b
    jsr DEMO_PreparePPUProcess
    jsr L8CF2
    lda #$00
    sta $37
    inc $1F
    jmp L8927



L6999_8BC5:
    jsr DEMO_EraseAllSprites
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
    sta SaveData@enable,y
    tya
    pha
    pha
    asl a
    tay
    ldx $07A0
    lda L8D49,y
    jsr UnusedIntroRoutine5@subroutine
    lda L8D49+1,y
    jsr L8C6A
    lda L8D49,y
    jsr UnusedIntroRoutine5@subroutine
    lda L8D49+1,y
    sec
    sbc #$20
    jsr L8C6A
    jsr UnusedIntroRoutine4
    pla
    asl a
    asl a
    asl a
    asl a
    tay
    ldx #$00
    L8C16:
        lda #$FF
        sta SaveData@name,y
        lda #$00
        sta SaveData@samusStat,y
        iny
        inx
        cpx #$10
        bne L8C16
    pla
    tay
    lda #$00
    sta SaveData@energyTank,y
    sta SaveData@moneyBags,y
    tya
    asl a
    tay
    lda #$00
    sta SaveData@gameOverCount,y
    sta SaveData@gameOverCount+1,y
    sta SaveData@day,y
    sta SaveData@day+1,y
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
    lda SaveDataYTbl,y
    sta SpriteRAM+$00+0
    lda #$E8
    sta SpriteRAM+$00+1
    lda #$03
    sta SpriteRAM+$00+2
    lda #$40
    sta SpriteRAM+$00+3
    rts

L8C6A:
    jsr UnusedIntroRoutine5@subroutine
    lda #$48
    jsr UnusedIntroRoutine5@subroutine
    lda #$FF
    jmp UnusedIntroRoutine5@subroutine

LL8C77:
    ldy #$00
    L8C79:
        lda SaveData@enable,y
        and #$01
        bne RTS_8C85
        iny
        cpy #$03
        bne L8C79
RTS_8C85:
    rts

L8C86:
    ldy #$00
    L8C88:
        lda SaveData@enable,y
        and #$01
        beq RTS_8C94
        iny
        cpy #$03
        bne L8C88
RTS_8C94:
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
    lda PPUSTATUS
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
        sta PPUADDR
        lda $2F
        sta PPUADDR
        jsr L8D4F
        pla
        tax
        lda $2F
        sec
        sbc #$20
        pha
        lda $2E
        sbc #$00
        sta PPUADDR
        pla
        sta PPUADDR
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
        lda SaveData@name,y
        sta PPUDATA
        iny
        inx
        cpx #$08
        bne @loop
    rts



L8D5E:
    lda PPUSTATUS
    ldy #$00
    tya
    sta $2D
    sta $2E
    @loop_A:
        asl a
        tax
        lda L8DA7,x
        sta PPUADDR
        lda L8DA7+1,x
        sta PPUADDR
        @loop_B:
            ldx #$00
            @loop_C:
                lda L8FCF_8FD9,y
                sta PPUDATA
                iny
                inx
                cpx #$05
                bne @loop_C
            inc $2D
            lda $2D
            cmp #$04
            beq @exitLoop_B
            lda #$FF
            sta PPUDATA
            bne @loop_B
        @exitLoop_B:
        lda L8FCF_8FD9,y
        sta PPUDATA
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
    lda TitleRoutine
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
    lda SaveData@enable,y
    and #$01
    beq L8E13
    lda SaveData@moneyBags,y
    sta $31
    ldy #$00
    sty $2D
    L8DDB:
        ldy $2E
        lda L8E33,y
        ldy $30
        beq L8DE7
            clc
            adc #$08
        L8DE7:
        ldy $2D
        clc
        adc L8E36,y
        sta $0220,x
        inx
        lda $31
        asl a
        asl a
        adc $2D
        tay
        lda L8E1C,y
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

; money bag pile tile id table
L8E1C:
    .byte $FF, $FF, $FF, $FF ; 0 bags of money
    .byte $FF, $C0, $D0, $FF ; 1 bag of money
    .byte $FF, $C1, $D1, $FF ; 2 bags of money
    .byte $C3, $C2, $D2, $FF ; 3 bags of money
    .byte $C5, $C4, $D4, $FF ; 4 bags of money
    .byte $C7, $C6, $D6      ; 5 bags of money

; money bag pile y offset per save slot
L8E33:
    .byte $30, $50, $70
; money bag pile y offset per sprite
L8E36:
    .byte $00, $08, $10

DEMO_PreparePPUProcess: ;($8E39)
    stx $00
    sty $01
    jmp DEMO_ProcessPPUString

UnusedIntroRoutine4: ;($8E40)
    stx PPUStrIndex
    lda #$00
    sta PPUDataString,x
    lda #$01
    sta $1B
    rts

UnusedIntroRoutine5: ;($8E4D)
    sta $32
    and #$F0
    lsr a
    lsr a
    lsr a
    lsr a
    jsr @subroutine
    ; run subroutine for low nybble
    lda $32
    and #$0F
    ; fallthrough

@subroutine: ;($8E5C)
    ; store nybble to current location in PPUDataString buffer
    sta PPUDataString,x
    ; move to next byte in buffer
    inx
    ; exit if we haven't moved outside the bounds of the buffer
    txa
    cmp #$55
    bcc @RTS
    
    ; oh no. we are out of bounds
    ; cancel writing the current ppu string to the buffer
    ldx PPUStrIndex
    @loop_infinite:
        ; cancel repeatedly forever
        ; pretty sure this is a bug
        lda #$00 
        sta PPUDataString,x
        beq @loop_infinite
@RTS:
    rts



UpdateSaveDataDay: ;($8E70)
    tya
    pha
    jsr DEMO_Amul16
    tay
    lda SaveData@samusStat@0.SamusAge+3,y
    sta $0B
    lda SaveData@samusStat@0.SamusAge+2,y
    sta $0A
    jsr Hex16ToDec
    lda $06
    sta SaveData@day+1,x
    lda $07
    sta SaveData@day,x
    pla
    tay
    rts



UpdateSaveDataGameOverCountAndEnergyTank: ;($8E90)
    tya
    pha
    jsr DEMO_Amul16
    tay
    lda SaveData@samusStat@0.GameOverCount+1,y
    sta $0B
    lda SaveData@samusStat@0.GameOverCount,y
    sta $0A
    jsr Hex16ToDec
    lda $06
    sta SaveData@gameOverCount+1,x
    lda $07
    sta SaveData@gameOverCount,x
    lda SaveData@samusStat,y
    pha
    txa
    lsr a
    tay
    pla
    sta SaveData@energyTank,y
    pla
    tay
    rts



;Convert 16-bit value in $0A-$0B to 4 decimal digits.
;Stored as a 16-bit BCD value in $06-$07.
Hex16ToDec: ;($8EB8)
    lda #$FF
    sta $01
    sta $02
    sta $03
    sec
    @loop_A:
        ; subtract 1000 from $0A-$0B
        lda $0A
        sbc #$E8
        sta $0A
        lda $0B
        sbc #$03
        sta $0B
        ; increment the thousands digit
        inc $03
        bcs @loop_A
    ; undo the last subtraction
    lda $0A
    adc #$E8
    sta $0A
    lda $0B
    adc #$03
    sta $0B
    ; hundreds
    lda $0A
    @loop_B:
        sec
        @loop_C:
            sbc #$64
            inc $02
            bcs @loop_C
        dec $0B
        bpl @loop_B
    ; undo the last subtraction
    adc #$64
    ; tens
    sec
    @loop_D:
        sbc #$0A
        inc $01
        bcs @loop_D
    ; undo the last subtraction
    adc #$0A
    
    ; all digits have now been isolated:
    ; thousands in $03, hundreds in $02, tens in $01, ones in a
    
    ; store ones in $06
    sta $06
    ; add tens multiplied by 16 to $06
    lda $01
    jsr DEMO_Amul16
    ora $06
    sta $06
    ; store thousands multiplied by 16 + hundreds in $07
    lda $03
    jsr DEMO_Amul16
    ora $02
    sta $07
    rts



PPUString_8F0D:
    PPUString $3F00, undefined, \
        $02, $20, $1B, $3A, $02, $20, $21, $01, $02, $2C, $30, $27, $02, $26, $31, $17, \
        $02, $16, $19, $27, $02, $16, $20, $27, $02, $16, $20, $11, $02, $01, $20, $21
    PPUStringEnd
    
PPUString_8F31:
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

PPUString_9042:
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

PPUString_908E:
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

