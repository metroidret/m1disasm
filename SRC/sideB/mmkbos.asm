DataDD0E_DEA0:
    .word LDB4D
    .word LDBAE
    .byte $82
    .byte $50
    .byte $00
    .byte $0A
    .byte $00
    .byte $A0
    .byte $A0
    .byte $48
    .byte $03

LDEAD:
    lda #$28
    ldx #<DataDD0E_DEA0.b
    ldy #>DataDD0E_DEA0.b
    jsr LDD0E
    lda #$16
    sta $067E
    lda #$00
    sta $067F
    lda #$B0
    sta $0672
    rts

LDEC6:
    jsr LD293
    bne LDECE
        jmp LD4F3
    LDECE:
    jsr LD56D
    jsr LD54C
    dec $0672
    lda $0672
    sta $4086
    rts


SongRidleyTri: ;($DEDE)
    SongNoteLength $6 ;1 3/16 seconds
    SongNote "E3"
    SongNoteLength $2 ;3/8 seconds
    SongNote "G#3"
    SongNoteLength $3 ;3/4 seconds
    SongNote "A#3"
    SongNote "D4"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "C4"
    SongNote "C4"
    SongNoteLength $3 ;3/4 seconds
    SongNote "F#4"
    SongNote "E4"
    SongNote "C4"
    SongNote "G#3"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "F#3"
    SongNote "F#3"
    SongNote "D#3"
    SongNoteLength $3 ;3/4 seconds
    SongNote "A3"
    SongNote "G3"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "B3"
    SongNote "B3"
    SongNoteLength $3 ;3/4 seconds
    SongNote "C#4"
    SongNote "D#4"
    SongNote "B3"
    SongNote "C#4"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "A3"
    SongNote "A3"
    SongEnd

SongRidleySQ1: ;($DF00)
    SongNoteLength $A ;3/64 seconds
    SongRest
    SongRepeatSetup $10
        SongNoteLength $1 ;3/16 seconds
        SongNote "F#4"
        SongNote "G#4"
        SongNote "A#4"
        SongNote "G#4"
    SongRepeat
    SongRepeatSetup $10
        SongNote "A4"
        SongNote "B4"
        SongNote "C#5"
        SongNote "B4"
    SongRepeat

SongRidleySQ2: ;($DF0F)
    SongRepeatSetup $10
        SongNoteLength $1 ;3/16 seconds
        SongNote "Bb4"
        SongNote "C5"
        SongNote "D5"
        SongNote "C5"
    SongRepeat
    SongRepeatSetup $10
        SongNote "Db5"
        SongNote "Eb5"
        SongNote "F5"
        SongNote "Eb5"
    SongRepeat
    SongEnd

SongKraidSQ1: ;($DF1D)
    SongNoteLength $8 ;11/64 seconds
    SongRest
    ;SQ1 music data runs down into the SQ2 music data.

SongKraidSQ2: ;($DF1F)
    SongRepeatSetup $4
        SongNoteLength $3 ;1/2 seconds
        SongNote "E4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "B3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "A4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "B3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "A#3"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;1/2 seconds
        SongNote "G4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "E4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "B3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "A4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E4"
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $1 ;1/8 seconds
        SongNote "G4"
        SongNote "B3"
        SongNote "G4"
        SongNote "B3"
        SongNote "G4"
        SongNote "B3"
        SongNote "A#4"
        SongNote "E4"
        SongNote "A#4"
        SongNote "E4"
        SongNote "A#4"
        SongNote "E4"
        SongNote "A4"
        SongNote "C4"
        SongNote "A4"
        SongNote "C4"
        SongNote "A4"
        SongNote "C4"
        SongNote "A4"
        SongNote "D#4"
        SongNote "F#4"
        SongNote "D#4"
        SongNote "B4"
        SongNote "D#4"
    SongRepeat
    SongRepeatSetup $2
        SongNote "F#4"
        SongNote "G4"
        SongNote "A4"
        SongNote "B4"
        SongNote "D5"
        SongNote "B4"
        SongNote "F#5"
        SongNote "D5"
        SongNote "A4"
        SongNote "G4"
        SongNote "F#4"
        SongNote "B4"
        SongNote "A5"
        SongNote "F#5"
        SongNote "D5"
        SongNote "A4"
        SongNote "G4"
        SongNote "F#4"
        SongNote "E4"
        SongNote "G4"
        SongNote "A4"
        SongNote "D5"
        SongNote "E5"
        SongRest
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $1 ;1/8 seconds
        SongNote "A5"
        SongRest
        SongNote "G5"
        SongRest
        SongNote "F#5"
        SongRest
        SongNote "E5"
        SongRest
        SongNote "F#5"
        SongRest
        SongNote "G5"
        SongRest
    SongRepeat
    SongEnd

SongKraidTri: ;($DF88)
    SongRepeatSetup $10
        SongNoteLength $2 ;1/4 seconds
        SongNote "E3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "E4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $2 ;1/4 seconds
        SongNote "C3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "C4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "C4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D4"
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $2 ;1/4 seconds
        SongNote "E3"
        SongNote "E4"
        SongNote "E5"
        SongNote "F#3"
        SongNote "F#4"
        SongNote "F#5"
        SongNote "F3"
        SongNote "F4"
        SongNote "F5"
        SongNote "B2"
        SongNote "B3"
        SongNote "B4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;1/2 seconds
        SongNote "E3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "B3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "C4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "B3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "C3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "G3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "A3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "B3"
    SongRepeat
    SongRepeatSetup $8
        SongNoteLength $4 ;1 second
        SongNote "E2"
    SongRepeat


    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $A2, $D7, $A0, $DF, $D0, $E5, $E6, $DF, $4D, $DB, $AE, $DB, $00, $02, $98
    .byte $41, $00, $11, $00, $94, $A0, $B0, $14, $2E, $B5, $38, $00, $FF, $FF, $FF, $FF

