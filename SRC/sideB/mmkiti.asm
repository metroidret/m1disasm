DataDD0E_MetroidHit:
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

MetroidHitSFXStart:
    lda #$20
    ldx #<DataDD0E_MetroidHit.b
    ldy #>DataDD0E_MetroidHit.b
    jmp LDD0E

MetroidHitSFXContinue:
    jsr $D293
    bne LDEBE
        jmp $D4F3
    LDEBE:
    lda $28
    sta $4085
    rts



.include "songs/escape.asm"


.include "songs/mthr_brn_room.asm"


MusicFDSInitSongEscapeAlarmSFX: ;($DFB8)
    ldx #<DataD785_SongEscapeAlarmSFX.b
    ldy #>DataD785_SongEscapeAlarmSFX.b
LDFBC:
    jmp LD785

DataD785_SongEscapeAlarmSFX:
    .word SongEscapeAlarmSFXFDS
    .word LDB2C
    .word FDSWaveform_DBEE
    .byte $00, $01, $A0, $A0, $00, $B5, $03, $94, $94

SongEscapeAlarmSFXFDS: ;($DFCE)
    SongNoteLength $7
    SongNote "A#4"
    SongEnd


MusicFDSInitSongMotherBrainHitSFX: ;($DFD1)
    ldx #<DataD785_SongMotherBrainHitSFX.b
    ldy #>DataD785_SongMotherBrainHitSFX.b
    bne LDFBC ; branch always

DataD785_SongMotherBrainHitSFX:
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

