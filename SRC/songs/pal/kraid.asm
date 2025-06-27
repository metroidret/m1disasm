; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Kraid Music Data

SongKraidSQ1:
    SongNoteLength $8 ;11/64 seconds
    SongRest
    ;SQ1 music data runs down into the SQ2 music data.

SongKraidSQ2:
    SongRepeatSetup $4
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C#4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "B4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "G#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "C#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;1/2 seconds
        SongNote "A4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C#4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "G#4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "B4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "F#4"
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $1 ;1/8 seconds
        SongNote "A4"
        SongNote "C#4"
        SongNote "A4"
        SongNote "C#4"
        SongNote "A4"
        SongNote "C#4"
        SongNote "C5"
        SongNote "F#4"
        SongNote "C5"
        SongNote "F#4"
        SongNote "C5"
        SongNote "F#4"
        SongNote "B4"
        SongNote "D4"
        SongNote "B4"
        SongNote "D4"
        SongNote "B4"
        SongNote "D4"
        SongNote "B4"
        SongNote "F4"
        SongNote "G#4"
        SongNote "F4"
        SongNote "C#5"
        SongNote "F4"
    SongRepeat
    SongRepeatSetup $2
        SongNote "G#4"
        SongNote "A4"
        SongNote "B4"
        SongNote "C#5"
        SongNote "E5"
        SongNote "C#5"
        SongNote "G#5"
        SongNote "E5"
        SongNote "B4"
        SongNote "A4"
        SongNote "G#4"
        SongNote "C#5"
        SongNote "B5"
        SongNote "G#5"
        SongNote "E5"
        SongNote "B4"
        SongNote "A4"
        SongNote "G#4"
        SongNote "F#4"
        SongNote "A4"
        SongNote "B4"
        SongNote "E5"
        SongNote "F#5"
        SongRest
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $1 ;1/8 seconds
        SongNote "B5"
        SongRest
        SongNote "A5"
        SongRest
        SongNote "G#5"
        SongRest
        SongNote "F#5"
        SongRest
        SongNote "G#5"
        SongRest
        SongNote "A5"
        SongRest
    SongRepeat
    SongEnd

SongKraidTri:
    SongRepeatSetup $10
        SongNoteLength $2 ;1/4 seconds
        SongNote "F#3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#4"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $2 ;1/4 seconds
        SongNote "D3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "D3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "E4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "E3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "E4"
    SongRepeat
    SongRepeatSetup $4
        SongNoteLength $2 ;1/4 seconds
        SongNote "F#3"
        SongNote "F#4"
        SongNote "F#5"
        SongNote "G#3"
        SongNote "G#4"
        SongNote "G#5"
        SongNote "G3"
        SongNote "G4"
        SongNote "G5"
        SongNote "C#3"
        SongNote "C#4"
        SongNote "C#5"
    SongRepeat
    SongRepeatSetup $2
        SongNoteLength $3 ;1/2 seconds
        SongNote "F#3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C#4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D4"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C#4"
        SongNoteLength $3 ;1/2 seconds
        SongNote "D3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "A3"
        SongNoteLength $3 ;1/2 seconds
        SongNote "B3"
        SongNoteLength $2 ;1/4 seconds
        SongNote "C#4"
    SongRepeat
    SongRepeatSetup $8
        SongNoteLength $4 ;1 second
        SongNote "F#2"
    SongRepeat
