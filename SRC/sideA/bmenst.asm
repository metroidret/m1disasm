BMENST_RESET: ;($C000)
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
    jsr ClearNameTables
    jsr MAIN_EraseAllSprites
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
    sta $73
    sta FDS_CTRL_ZP
    sta RandomNumber1
    jmp WaitNMIEnd


LC058:
    jsr ClearScreenData
    lda #<PPUString_C06C.b
    sta $00
    lda #>PPUString_C06C.b
    sta $01
    jsr MAIN_ProcessPPUString
    jsr METHEX_ScreenOn
    jmp LB310

; "Bメンヲ セットシテクダサイ" message (switch to disk side B)
PPUString_C06C:
    PPUString $21D4, charmap_savemenu, \
        "゛"
    PPUString $21E9, charmap_savemenu, \
        "Bメンヲ セットシテクタサイ"
    PPUStringEnd


LC082:
    lda #$01
    sta $70
    inc MainRoutine
    lda Joy1Status
    and #$C0
    sta $F0
    jsr LC058
    jsr MAIN_EraseAllSprites
    lda #$10
    jmp LB261

; is this data?
DataC099:
    .byte $C1, $38, $C1, $40, $C1, $A9, $02, $8D, $F7, $07, $20, $F4, $C0, $D0, $90, $20
    .byte $CA, $C0, $F0, $05, $A9, $00, $8D, $9F, $D2, $AD, $9F, $D2, $18, $69, $01, $C9
    .byte $19, $90, $02, $A9, $18, $8D, $9F

