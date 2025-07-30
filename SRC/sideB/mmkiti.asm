MMKITI_DataDD0E_DEA0:
    .word LDB2C
    .word LDC2E
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



SongEscapeSQ2:
    SongRepeatSetup $4
        SongNoteLength $3 ;3/4 seconds
        SongNote "G4"
        SongNote "A#4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "A4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "C4"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "C4"
        SongNote "D#4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "D4"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "C4"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "C4"
        SongNote "D#4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "D4"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "C4"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "C4"
        SongNote "E4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "D4"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "C4"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "C4"
        SongNote "E4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "D4"
    SongRepeat
    SongEnd

SongEscapeSQ1:
    SongRepeatSetup $4
        SongNoteLength $3 ;3/4 seconds
        SongNote "D4"
        SongNote "F4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "C#4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "A3"
        SongNote "G#3"
        SongNote "A3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "G#3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "F#3"
        SongNote "F3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "E3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "F3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "G#3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G3"
        SongNote "F#3"
        SongNote "F3"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "G3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "F3"
        SongNote "E3"
        SongNote "F3"
        SongNote "G3"
        SongNote "F3"
        SongNote "G3"
        SongNote "A3"
        SongNote "G3"
        SongNote "A3"
        SongNote "B3"
        SongNote "A3"
        SongNote "B3"
    SongRepeat

SongEscapeTri:
    SongRepeatSetup $10
        SongNoteLength $2 ;3/8 seconds
        SongNote "G4"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G4"
        SongNote "G4"
        SongNote "G4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "A3"
        SongNote "A2"
        SongNote "A3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNote "A3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "A3"
        SongNote "A2"
        SongNote "A3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "G3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G2"
        SongNote "G3"
        SongNote "G3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "G3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "G2"
        SongNote "G3"
        SongNote "G3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "F3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "F2"
        SongNote "F3"
        SongNote "F3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "F3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "F2"
        SongNote "F3"
        SongNote "F3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "E3"
        SongNote "E3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "E3"
        SongNote "E3"
        SongNote "E3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "E3"
        SongNoteLength $9 ;1/8 seconds
        SongNote "D4"
        SongNote "C4"
        SongNote "D4"
        SongNote "E4"
        SongNote "D4"
        SongNote "E4"
        SongNote "F4"
        SongNote "E4"
        SongNote "F4"
        SongNote "G4"
        SongNote "F4"
        SongNote "G4"
    SongRepeat

SongEscapeNoise:
    SongRepeatSetup $30
        SongNoteLength $2 ;3/8 seconds
        .byte $01
        .byte $04
        .byte $01
        .byte $04
    SongRepeat


    .byte $E0, $BA, $2A, $1A, $02, $3A, $40
    .byte $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C, $38
    .byte $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A, $4C
    .byte $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF, $C8
    .byte $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $A2, $BF, $A0, $DF, $4C, $85, $D7, $CE
    .byte $DF, $2C, $DB, $EE, $DB, $00, $01, $A0, $A0, $00, $B5, $03, $94, $94, $B7, $44
    .byte $00, $A2, $D7, $A0, $DF, $D0, $E5, $E6, $DF, $4D, $DB, $AE, $DB, $00, $02, $98
    .byte $41, $00, $11, $00, $94, $A0, $B0, $14, $2E, $B5, $38, $00, $FF, $FF, $FF, $FF

