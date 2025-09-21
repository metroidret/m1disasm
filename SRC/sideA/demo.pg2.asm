; placeholder to be overwritten with real save data from savedata.asm
SaveData:
@C5A0:
    .byte $80
    .byte $80
    .byte $80
@C5A3:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
@C5D3:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
@C5D9:
    .byte $00
    .byte $00
    .byte $00
@C5DC:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
@C5E2:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
@C612:
    .byte $00
    .byte $00
    .byte $00
@end:


LC615:
    .incbin "sideA/demo.pg2_font_savemenu.chr"

LCE35:
    ldx #<LCF40.b
    ldy #>LCF40.b
    jmp LCE3C
LCE3C:
    stx LCE58
    sty LCE58+1
    jsr LCEDC
LCE45:
    jsr DEMO_WaitNMIPass_
    jsr LCF1D
    jsr L7023
    jsr GotoLD18C
    lda #$0E
    jsr FDSBIOS_WriteFile
        .word LCF34
LCE58:
        .word LCF40
    beq LCE62
    jsr LCE90
    jmp LCE45
LCE62:
    jsr LCF27
    rts

LCE66:
    lda #$20
    jsr LCE6E
    jmp ($DFFC) ; reset vector

LCE6E:
    sta LCF3E
LCE71:
    jsr DEMO_WaitNMIPass_
    jsr LCF1D
    jsr L7023
    jsr GotoLD18C
    jsr FDSBIOS_LoadFiles
        .word LCF34
        .word LCF3E
    beq LCE8C
    jsr LCE90
    jmp LCE71
LCE8C:
    jsr LCF27
    rts

LCE90:
    pha
    jsr LCF27
    pla
    pha
    lsr
    lsr
    lsr
    lsr
    ora #$80
    sta PPUString_CF03+7
    pla
    and #$0F
    ora #$80
    sta PPUString_CF03+7+1
    jsr L883B
    lda #$12
    sta PalDataPending
    ldx #<PPUString_CF03.b
    ldy #>PPUString_CF03.b
    jsr L8E39
    jsr LCF27
    jsr DEMO_WaitNMIPass_
    jsr FDSBIOS_EnPFObj
    LCEBE:
        lda DRIVESTATUS
        and #$01
        beq LCEBE
LCEC5:
    lda #$20
    pha
LCEC8:
    jsr DEMO_WaitNMIPass_
    pla
    beq LCED1
    tay
    dey
    tya
LCED1:
    pha
    lda DRIVESTATUS
    and #$01
    bne LCEC8
    pla
    bne LCEC5
LCEDC:
    jsr L883B
    lda #$F4
    sta SpriteRAM
    lda #$12
    sta PalDataPending
    ldx #<PPUString_CF0D.b
    ldy #>PPUString_CF0D.b
    jsr L8E39
    lda PPUCTRL_ZP
    and #~PPUCTRL_BG_1000.b
    ora #PPUCTRL_OBJ_1000
    sta PPUCTRL_ZP
    sta PPUCTRL
    jsr LCF27
    jsr DEMO_WaitNMIPass_
    jmp FDSBIOS_EnPFObj

; "ERR --" message (disk error)
PPUString_CF03:
    PPUString $21F3, charmap_gameover, \
        "ERR ", $21, $21
    PPUStringEnd

; "おまちください" message (waiting during disk access)
PPUString_CF0D:
    PPUString $21CC, charmap_gameover, \
        "おまちください"
    PPUString $23DB, undefined, \
        $00, $00
    PPUStringEnd

LCF1D:
    ; turn v-blank nmi off and set ppu increment to 1
    lda PPUCTRL_ZP
    and #~(PPUCTRL_VBLKNMI_ON | PPUCTRL_INCR_DOWN).b
LCF21:
    sta PPUCTRL
    sta PPUCTRL_ZP
    rts

LCF27:
    ; wait for v-blank
    @loop:
        lda PPUSTATUS
        and #PPUSTATUS_VBLK
        bne @loop
    ; turn v-blank nmi on
    lda PPUCTRL_ZP
    ora #PPUCTRL_VBLKNMI_ON
    bne LCF21 ; branch always

LCF34:
    .byte $01
    .ascstr "MET "
    .byte $02
    .byte $00
    .byte $00
    .byte $00
    .byte $00

LCF3E:
    .byte $00
    .byte $FF

LCF40:
    .byte $0E
    .ascstr $01, $01, $01, $01, $01, $01, $01, $01
    .word SaveData
    .word SaveData@end - SaveData
    .byte $00
    .word SaveData
    .byte $00

LCF51:
    .byte $02, $42, $42, $42, $42, $42, $02, $FF, $B4, $2A, $B2, $02, $B0, $2A, $02



