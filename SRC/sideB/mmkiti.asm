MMKITI_DataDD0E_DEA0:
    .word LDB2C
    .word FDSWaveform_DC2E
    .byte $00
    .byte $88
    .byte $00
    .byte $10
    .byte $00
    .byte $00
    .byte $94
    .byte $40
    .byte $02

MMKITI_LDEAD:
    lda #$20
    ldx #<MMKITI_DataDD0E_DEA0.b
    ldy #>MMKITI_DataDD0E_DEA0.b
    jmp LDD0E

LDEB6:
    jsr $D293
    bne LDEBE
        jmp $D4F3
    LDEBE:
    lda $28
    sta $4085
    rts



.include "songs/escape.asm"


.include "songs/mthr_brn_room.asm"



    .byte $A2, $BF, $A0, $DF, $4C, $85, $D7, $CE
    .byte $DF, $2C, $DB, $EE, $DB, $00, $01, $A0, $A0, $00, $B5, $03, $94, $94, $B7, $44
    .byte $00, $A2, $D7, $A0, $DF, $D0, $E5, $E6, $DF, $4D, $DB, $AE, $DB, $00, $02, $98
    .byte $41, $00, $11, $00, $94, $A0, $B0, $14, $2E, $B5, $38, $00, $FF, $FF, $FF, $FF

