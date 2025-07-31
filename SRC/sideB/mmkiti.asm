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


SongMthrBrnRoomTri:
    SongRepeatSetup $20
        SongNoteLength $A ;3/64 seconds
        SongNote "A3"
        SongNote "C#3"
        SongRest
        SongNote "F4"
        SongNote "G#4"
        SongRest
        SongNote "D3"
        SongNote "B3"
        SongNote "E4"
        SongNote "A#3"
        SongNote "F#4"
        SongNote "E4"
        SongRest
        SongNote "G#4"
        SongNote "A#4"
        SongNote "B4"
        SongRest
        SongNote "D#3"
        SongRest
        SongNote "A#3"
        SongNote "E4"
        SongNote "B4"
        SongNote "G3"
        SongRest
        SongNote "F4"
        SongNote "E3"
        SongRest
        SongNote "G#3"
        SongNote "B3"
        SongRest
        SongNote "C3"
        SongNote "A#4"
        SongRest
        SongNote "B4"
        SongNote "C5"
        SongNote "C#5"
        SongNote "D5"
        SongRest
        SongNote "C3"
        SongNote "D#3"
    SongRepeat


SongMthrBrnRoomSQ1:
    SongNoteLength $8 ;1/4 seconds
    SongRest
    ;SQ1 music data runs down into the SQ2 music data.

SongMthrBrnRoomSQ2:
    SongRepeatSetup $8
        SongNoteLength $0 ;3/32 seconds
        SongNote "F2"
        SongNote "F#2"
    SongRepeat
    SongRepeatSetup $8
        SongNote "G2"
        SongNote "F#2"
    SongRepeat
    SongRepeatSetup $8
        SongNote "G#2"
        SongNote "G2"
    SongRepeat
    SongRepeatSetup $8
        SongNote "G2"
        SongNote "F#2"
    SongRepeat
    SongEnd ;End mother brain room music.


    .byte $A2, $BF, $A0, $DF, $4C, $85, $D7, $CE
    .byte $DF, $2C, $DB, $EE, $DB, $00, $01, $A0, $A0, $00, $B5, $03, $94, $94, $B7, $44
    .byte $00, $A2, $D7, $A0, $DF, $D0, $E5, $E6, $DF, $4D, $DB, $AE, $DB, $00, $02, $98
    .byte $41, $00, $11, $00, $94, $A0, $B0, $14, $2E, $B5, $38, $00, $FF, $FF, $FF, $FF

