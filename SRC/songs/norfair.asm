
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

