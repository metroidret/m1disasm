SongNorfairSQ1: ;($DEA0)
    SongRepeatSetup $3
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "G3"
        SongNoteLength $3 ;3/4 seconds
        SongNote "F3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A#3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "G3"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "F3"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "C4"
        SongNote "D4"
        SongNoteLength $3 ;3/4 seconds
        SongNote "F4"
        SongNoteLength $1 ;3/16 seconds
        SongNote "E4"
        SongNote "D4"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "A3"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;3/4 seconds
        SongNote "A3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "B3"
        SongNoteLength $3 ;3/4 seconds
        SongNote "G3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "F3"
        SongRest
    SongRepeat
    SongEnd

SongNorfairSQ2: ;($DEC6)
    SongRepeatSetup $3
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "D#3"
        SongNoteLength $3 ;3/4 seconds
        SongNote "C#3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "F#3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "D#3"
        SongNoteLength $4 ;1 1/2 seconds
        SongNote "C#3"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "G3"
        SongNote "A3"
        SongNote "C4"
        SongNoteLength $1 ;3/16 seconds
        SongNote "E3"
        SongNote "D3"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "E3"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $1 ;3/16 seconds
        SongNote "E3"
        SongNote "A2"
        SongNote "B2"
        SongNote "E3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "F#3"
        SongNoteLength $1 ;3/16 seconds
        SongNote "D3"
        SongNote "G2"
        SongNote "A2"
        SongNote "D3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "E3"
        SongNoteLength $1 ;3/16 seconds
        SongNote "C3"
        SongNote "A2"
        SongNote "A#2"
        SongNote "C3"
        SongNote "A#2"
        SongNoteLength $6 ;1 3/16 seconds
        SongNote "A2"
        SongNoteLength $1 ;3/16 seconds
        SongRest
    SongRepeat

SongNorfairTri: ;($DEF7)
    SongRepeatSetup $3
        SongNoteLength $1 ;3/16 seconds
        SongNote "D4"
        SongRest
        SongNote "G4"
        SongRest
        SongNote "A4"
        SongRest
        SongNoteLength $3 ;3/4 seconds
        SongNote "C4"
        SongNoteLength $1 ;3/16 seconds
        SongNote "F4"
        SongRest
        SongNoteLength $2 ;3/8 seconds
        SongNote "D4"
        SongNoteLength $3 ;3/4 seconds
        SongRest
        SongNote "C4"
        SongRest
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $2 ;3/8 seconds
        SongNote "F3"
        SongNote "C4"
        SongNote "D4"
        SongNote "G3"
        SongNote "D4"
        SongNote "E4"
        SongNote "A#3"
        SongNote "D4"
        SongNote "F4"
        SongNoteLength $3 ;3/4 seconds
        SongNote "C3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "A3"
        SongRest
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;3/4 seconds
        SongNote "D3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "E3"
        SongNoteLength $3 ;3/4 seconds
        SongNote "C3"
        SongNoteLength $2 ;3/8 seconds
        SongNote "D3"
        SongNote "A#2"
        SongNote "A#2"
        SongRest
        SongNoteLength $6 ;1 3/16 seconds
        SongRest
    SongRepeat

SongNorfairNoise: ;($DF2B)
    SongRepeatSetup $20
        SongNoteLength $2 ;3/8 seconds
        .byte $01
        .byte $04
        .byte $04
        .byte $01
        .byte $04
        .byte $04
        SongNoteLength $6 ;1 3/16 seconds
        .byte $04
        .byte $04
        SongNoteLength $2 ;3/8 seconds
        .byte $01
    SongRepeat

; remnants of brinstar song data
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $42, $3E, $42, $B3, $44, $B2, $3A, $B9, $3A, $44, $48, $B4, $4C, $B3, $48, $46
    .byte $B6, $48, $B9, $4E, $4C, $48, $B3, $4C, $B2, $44, $B9, $44, $4C, $52, $B4, $54
    .byte $54, $C4, $B4, $02, $FF, $C3, $B2, $26, $B9, $26, $3E, $34, $B2, $26, $B9, $26
    .byte $34, $26, $B2, $2C, $B9, $2C, $3A, $2C, $B2, $2C, $B9, $2C, $3A, $2C, $FF, $C4
    .byte $B2, $26, $B9, $34, $26, $26, $FF, $D0, $B9, $18, $26, $18, $B2, $18, $FF, $C2
    .byte $B2, $1E, $B9, $1E, $18, $1E, $B2, $1E, $B9, $1E, $18, $1E, $B2, $1C, $B9, $1C
    .byte $14, $1C, $B2, $1C, $B9, $1C, $14, $1C, $FF, $B2, $26, $12, $16, $18, $1C, $20
    .byte $24, $26, $B2, $28, $B9, $28, $1E, $18, $B2, $10, $B9, $30, $2C, $28, $B2, $1E
    .byte $1C, $18, $14, $2A, $2A, $2A, $2A, $CC, $B9, $2A, $FF, $E8, $B2, $04, $04, $04
    .byte $B9, $04, $04, $04, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $CA, $B1, $04, $04, $04, $07, $04, $04, $FF, $E0, $B4, $04, $FF, $17, $18

