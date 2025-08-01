
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

