SongFadeInSQ2:
    SongRepeatSetup $4
        SongNoteLength $0 ;3/32 seconds
        SongNote "G4"
        SongNote "C4"
    SongRepeat
        SongRepeatSetup $4
        SongNote "A4"
        SongNote "C4"
    SongRepeat
        SongRepeatSetup $4
        SongNote "F4"
        SongNote "A#3"
    SongRepeat
        SongRepeatSetup $4
        SongNote "E4"
        SongNote "G3"
    SongRepeat
        SongRepeatSetup $4
        SongNote "D4"
        SongNote "E3"
    SongRepeat
        SongRepeatSetup $20 ; only 12 out of 32 repetitions play before the song ends
        SongNote "D4"
        SongNote "F#3"
    SongRepeat

SongFadeInTri:
    SongNoteLength $3 ;3/4 seconds
    SongNote "D#4"
    SongNote "D4"
    SongNote "C4"
    SongNote "A3"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "D3"
    SongNote "D3"

SongFadeInSQ1:
    SongNoteLength $3 ;3/4 seconds
    SongNote "D4"
    SongNote "F4"
    SongNote "D4"
    SongNote "C4"
    SongNoteLength $4 ;1 1/2 seconds
    SongNote "A3"
    SongNote "A3"
    SongEnd ;End fade in music.
