
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

