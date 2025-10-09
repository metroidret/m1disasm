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


LDFB8:
    ldx #<DataD785_DFBF.b
    ldy #>DataD785_DFBF.b
LDFBC:
    jmp LD785

DataD785_DFBF:
    .word SongEscapeAlarmSFXFDS
    .word LDB2C
    .word FDSWaveform_DBEE
    .byte $00, $01, $A0, $A0, $00, $B5, $03, $94, $94

SongEscapeAlarmSFXFDS: ;($DFCE)
    SongNoteLength $7
    SongNote "A#4"
    SongEnd

LDFD1:
    ldx #<DataD785_DFD7.b
    ldy #>DataD785_DFD7.b
    bne LDFBC ; branch always

DataD785_DFD7:
    .word SongMotherBrainHitSFXFDS
    .word LDB4D
    .word FDSWaveform_DBAE
    .byte $00, $02, $98, $41, $00, $11, $00, $94, $A0

SongMotherBrainHitSFXFDS: ;($DFE6)
    SongNoteLength $0
    SongNote "A#2"
    SongNote "B3"
    SongNoteLength $5
    SongNote "E4"
    SongEnd



    .byte $FF, $FF, $FF, $FF

