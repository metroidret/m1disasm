; side A file $04 - demo.pg2 (prgram $C5A0-$CF5F)
; Title screen code - part 2

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $00
    .ascstr "DEMO.PG2"
FDSFileMacroPart2 $C5A0, $00



; placeholder to be overwritten with real save data from savedata.asm
SaveData:
@enable: ;($C5A0)
    ; bit 7: slot was once accessed to start a game? %1=no, %0=yes
    ; bit 0: slot is named? %1=yes, %0=no
    @@0:
        .byte $80
    @@1:
        .byte $80
    @@2:
        .byte $80
@name: ;($C5A3)
    ; first 8 bytes is save slot name, last 8 bytes is save slot name's dakuten accents
    @@0:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    @@1:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    @@2:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
@gameOverCount: ;($C5D3)
    @@0:
        .byte $00, $00
    @@1:
        .byte $00, $00
    @@2:
        .byte $00, $00
@energyTank: ;($C5D9)
    ; only for save menu, real etank count is in samus stat
    @@0:
        .byte $00
    @@1:
        .byte $00
    @@2:
        .byte $00
@day: ;($C5DC)
    ; day count is SamusAge+2
    @@0:
        .byte $00, $00
    @@1:
        .byte $00, $00
    @@2:
        .byte $00, $00
@samusStat: ;($C5E2)
    .dstruct @@0 instanceof SamusStat values
    .endst
    .dstruct @@1 instanceof SamusStat values
    .endst
    .dstruct @@2 instanceof SamusStat values
    .endst
@moneyBags: ;($C612)
    @@0:
        .byte $00
    @@1:
        .byte $00
    @@2:
        .byte $00
@end:


LC615:
    .incbin "sideA/demo.pg2_font_savemenu.chr"

LCE35:
    ldx #<SaveDataFileHeader.b
    ldy #>SaveDataFileHeader.b
    jmp LCE3C
    LCE3C:
    stx LCE58
    sty LCE58+1
    jsr LCEDC
    LCE45:
        jsr DEMO_WaitNMIPass_
        jsr VBOffAndHorzWrite
        jsr L7023
        jsr GotoLD18C
        lda #$0E
        jsr FDSBIOS_WriteFile
            .word DEMO_DiskID
LCE58:
            .word SaveDataFileHeader
        beq LCE62
        jsr LCE90
        jmp LCE45
LCE62:
    jsr NMIOn
    rts

LCE66:
    lda #$20
    jsr LCE6E
    jmp ($DFFC) ; reset vector

LCE6E:
    sta LoadList
    LCE71:
        jsr DEMO_WaitNMIPass_
        jsr VBOffAndHorzWrite
        jsr L7023
        jsr GotoLD18C
        jsr FDSBIOS_LoadFiles
            .word DEMO_DiskID
            .word LoadList
        beq LCE8C
        jsr LCE90
        jmp LCE71
LCE8C:
    jsr NMIOn
    rts

LCE90:
    pha
    jsr NMIOn
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
    jsr DEMO_PreparePPUProcess
    jsr NMIOn
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
    jsr DEMO_PreparePPUProcess
    lda PPUCTRL_ZP
    and #~PPUCTRL_BG_1000.b
    ora #PPUCTRL_OBJ_1000
    sta PPUCTRL_ZP
    sta PPUCTRL
    jsr NMIOn
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



VBOffAndHorzWrite: ;($CF1D)
    ; turn v-blank nmi off and set ppu increment to 1
    lda PPUCTRL_ZP
    and #~(PPUCTRL_VBLKNMI_ON | PPUCTRL_INCR_DOWN).b
LCF21:
    sta PPUCTRL
    sta PPUCTRL_ZP
    rts



NMIOn: ;($CF27)
    ; wait for v-blank
    @loop:
        lda PPUSTATUS
        and #PPUSTATUS_VBLK
        bne @loop
    ; turn v-blank nmi on
    lda PPUCTRL_ZP
    ora #PPUCTRL_VBLKNMI_ON
    bne LCF21 ; branch always



DEMO_DiskID: ;($CF34)
    .byte $01
    .ascstr "MET"
    .ascstr " "
    .byte $02
    .byte $00
    .byte $00
    .byte $00
    .byte $00

LoadList: ;($CF3E)
    .byte $00
    .byte $FF

SaveDataFileHeader: ;($CF40)
    .byte $0E
    .ascstr $01, $01, $01, $01, $01, $01, $01, $01
    .word SaveData
    .word SaveData@end - SaveData
    .byte $00
    .word SaveData
    .byte $00

LCF51:
    .byte $02, $42, $42, $42, $42, $42, $02, $FF, $B4, $2A, $B2, $02, $B0, $2A, $02



FDSFileMacroPart3

