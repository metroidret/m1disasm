
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

