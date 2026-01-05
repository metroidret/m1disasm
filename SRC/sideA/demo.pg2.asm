; side A file $04 - demo.pg2 (prgram $C5A0-$CF5F)
; Title screen code - part 2

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_00
    .ascstr "DEMO.PG2"
FDSFileMacroPart2 $C5A0, FDSFileType_PRGRAM



; placeholder to be overwritten with real save data from savedata.asm
;@C5A0:
    .byte $80
    .byte $80
    .byte $80
;@C5A3:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
;@C5D3:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
;@C5D9:
    .byte $00
    .byte $00
    .byte $00
;@C5DC:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
;@C5E2:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;@C612:
    .byte $00
    .byte $00
    .byte $00



LC615:
    .incbin "sideA/demo.pg2_font_savemenu.chr"



LCE35:
    ldx #<DEMO_SaveDataFileHeader.b
    ldy #>DEMO_SaveDataFileHeader.b
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
            .word DEMO_SaveDataFileHeader
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
    sta LoadList_Title
    LCE71:
        jsr DEMO_WaitNMIPass_
        jsr VBOffAndHorzWrite
        jsr L7023
        jsr GotoLD18C
        jsr FDSBIOS_LoadFiles
            .word DEMO_DiskID
            .word LoadList_Title
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
    sta VRAMStruct_CF03+7
    pla
    and #$0F
    ora #$80
    sta VRAMStruct_CF03+7+1
    jsr L883B
    lda #$12
    sta PalDataPending
    ldx #<VRAMStruct_CF03.b
    ldy #>VRAMStruct_CF03.b
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
    ldx #<VRAMStruct_CF0D.b
    ldy #>VRAMStruct_CF0D.b
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
VRAMStruct_CF03:
    VRAMStructData $21F3, charmap_gameover, \
        "ERR ", $21, $21
    VRAMStructEnd

; "おまちください" message (waiting during disk access)
VRAMStruct_CF0D:
    VRAMStructData $21CC, charmap_gameover, \
        "おまちください"
    VRAMStructData $23DB, undefined, \
        $00, $00
    VRAMStructEnd



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
    .byte $00 ; side A
    .byte $00
    .byte $00
    .byte $00

LoadList_Title: ;($CF3E)
    .byte FDSFileID_Side00_00
    .byte FDSFileID_EndList

DEMO_SaveDataFileHeader: ;($CF40)
    .byte FDSFileID_Side00_0E
    .ascstr $01, $01, $01, $01, $01, $01, $01, $01
    .word SaveData
    .word SaveData@end - SaveData
    .byte FDSFileType_PRGRAM
    .word SaveData
    .byte FDSFileType_PRGRAM

LCF51:
    .byte $02, $42, $42, $42, $42, $42, $02, $FF, $B4, $2A, $B2, $02, $B0, $2A, $02



FDSFileMacroPart3

