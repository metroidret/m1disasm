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

