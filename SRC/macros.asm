.macro assertMsg args condition, message
    .if !(condition)
        .fail message
    .endif
.endm

.macro SignMagSpeed args duration, xSpd, ySpd
    assertMsg duration >= $00 && duration < $F0, "duration must be from $00 to $EF frames inclusive"
    assertMsg xSpd > -8 && xSpd < 8, "xSpd must be from -7 to 7 inclusive"
    assertMsg ySpd > -8 && ySpd < 8, "ySpd must be from -7 to 7 inclusive"

    .def absXSpd = xSpd
    .def absYSpd = ySpd
    .def signXSpd = 0
    .def signYSpd = 0

    .if xSpd < 0
        .redef signXSpd = 1
        .redef absXSpd = -xSpd
    .endif
    .if ySpd < 0
        .redef signYSpd = 1
        .redef absYSpd = -ySpd
    .endif

    .byte duration
    .byte ((($8 * signYSpd) | absYSpd) << 4) + (($8 * signXSpd) | absXSpd)
    
    .undef absXSpd, absYSpd, signXSpd, signYSpd
.endm


.macro VRAMStructData args ppuAddress ; , charmap , vramStructData
    assertMsg (\?2 != ARG_NUMBER), "charmap was a number"
    
    .byte >ppuAddress, <ppuAddress
    .def charmap = "\2"
    .shift
    .shift
    
    .byte @VRAMStructData\@_end - @VRAMStructData\@_start
    @VRAMStructData\@_start:
    .repeat NARGS
        .if (\?1 == ARG_IMMEDIATE) || (\?1 == ARG_NUMBER)
            .db \1
        .elif \?1 == ARG_STRING
            .stringmap charmap, \1
        .else
            .print \?1, "\n"
            .fail "VRAMStructData: bad data argument type"
        .endif
        .shift
    .endr
    @VRAMStructData\@_end:
    
    .undef charmap
    
    .if (@VRAMStructData\@_end - @VRAMStructData\@_start < 1) || (@VRAMStructData\@_end - @VRAMStructData\@_start > 256)
        .print @VRAMStructData\@_end - @VRAMStructData\@_start, "\n"
        .fail "VRAMStructData: bad string length"
    .endif
    
.endm

.macro VRAMStructDataRepeat args ppuAddress, charmap, repetitions, ppuByte
    assertMsg repetitions >= $00 && repetitions < $40, "repetitions must be from $00 to $3F times inclusive"
    assertMsg (\?2 != ARG_NUMBER), "charmap was a number"
    
    .byte >ppuAddress, <ppuAddress
    .byte repetitions | $40
    .if (\?4 == ARG_IMMEDIATE) || (\?4 == ARG_NUMBER)
        .db ppuByte
    .elif \?4 == ARG_STRING
        .stringmap charmap, ppuByte
    .else
        .print \?4, "\n"
        .fail "VRAMStructData: bad data argument type"
    .endif
.endm

.macro VRAMStructDataVertical args ppuAddress ; , charmap , vramStructData
    assertMsg (\?2 != ARG_NUMBER), "charmap was a number"
    
    .byte >ppuAddress, <ppuAddress
    .def charmap = "\2"
    .shift
    .shift
    
    .byte (@VRAMStructData\@_end - @VRAMStructData\@_start) | $80
    @VRAMStructData\@_start:
    .repeat NARGS
        .if (\?1 == ARG_IMMEDIATE) || (\?1 == ARG_NUMBER)
            .db \1
        .elif \?1 == ARG_STRING
            .stringmap charmap, \1
        .else
            .print \?1, "\n"
            .fail "VRAMStructData: bad data argument type"
        .endif
        .shift
    .endr
    @VRAMStructData\@_end:
    
    .undef charmap
    
    .if (@VRAMStructData\@_end - @VRAMStructData\@_start < 1) || (@VRAMStructData\@_end - @VRAMStructData\@_start > 256)
        .print @VRAMStructData\@_end - @VRAMStructData\@_start, "\n"
        .fail "VRAMStructData: bad string length"
    .endif
    
.endm

.macro VRAMStructDataRepeatVertical args ppuAddress, charmap, repetitions, ppuByte
    assertMsg repetitions >= $00 && repetitions < $40, "repetitions must be from $00 to $3F times inclusive"
    assertMsg (\?2 != ARG_NUMBER), "charmap was a number"
    
    .byte >ppuAddress, <ppuAddress
    .byte repetitions | $40 | $80
    .if (\?4 == ARG_IMMEDIATE) || (\?4 == ARG_NUMBER)
        .db ppuByte
    .elif \?4 == ARG_STRING
        .stringmap charmap, ppuByte
    .else
        .print \?4, "\n"
        .fail "VRAMStructData: bad data argument type"
    .endif
.endm

.macro VRAMStructEnd
    .byte $00
.endm


.macro PtrTableEntry args ptrTable, ptr
    .ifndef _id_\2
        .ifdef _entryNumber_\1
            .redef _entryNumber_\1 = _entryNumber_\1 + 1
        .else
            .def _entryNumber_\1 = 0
        .endif
        
        .def _id_\2 = _entryNumber_\1
    .endif
    .word ptr
.endm

.macro PtrTableEntryArea args ptrTable, ptr
    .ifndef _id_\2
        .ifdef _entryNumber_\1
            .redef _entryNumber_\1 = _entryNumber_\1 + 1
        .else
            .def _entryNumber_\1 = 0
        .endif
        
        .def _id_\2 = _entryNumber_\1 export
    .endif
    .word \2_{AREA}
.endm

.macro EnemyMovementChoiceEntry ; args enemyMovementIndexList
    assertMsg NARGS >= 1 && NARGS <= 256, "number of choices must be from 1 to 256 inclusive"
    
    .def NARGS2 = NARGS
    .repeat 8
        .if (NARGS2 & 1) == 0
            .redef NARGS2 = NARGS2 >> 1
        .endif
    .endr
    assertMsg NARGS2 == 1, "number of choices must be a power of 2"
    .undef NARGS2

    .byte NARGS - 1
    .repeat NARGS
        .byte \1
        .shift
    .endr
.endm

.macro EnemyMovementInstr_StopMovementDragon
    .byte $FA
.endm

.macro EnemyMovementInstr_StopMovement
    .byte $FB
.endm

.macro EnemyMovementInstr_RepeatPreviousUntilFailure
    .byte $FC
.endm

.macro EnemyMovementInstr_ClearEnJumpDsplcmnt
    .byte $FD
.endm

.macro EnemyMovementInstr_FE ; some form of end
    .byte $FE
.endm

.macro EnemyMovementInstr_Restart
    .byte $FF
.endm


;There are 3 control bytes associated with the music data and the rest are musical note indexes.
;If the byte has the binary format 1011xxxx ($Bx), then the byte is an index into the corresponding
;musical notes table and is used to set the note length until it is set by another note length
;byte. The lower 4 bits are the index into the note length table. Another control byte is the loop
;and counter btye. The loop and counter byte has the format 11xxxxxx. Bits 0 thru 6 contain the
;number of times to loop.  The third control byte is #$FF. This control byte marks the end of a loop
;and decrements the loop counter. If #$00 is found in the music data, the music has reached the end.
;A #$00 in any of the different music channel data segments will mark the end of the music. The
;remaining bytes are indexes into the MusicNotesTbl and should only be even numbers as there are 2
;bytes of data per musical note.

.macro SongHeader args noteLengthsTable, repeatFlag, triangleLength, sq1Envelope, sq2Envelope
    ; wla-dx weird pointer math forces me to get low byte
    .byte <(noteLengthsTable - NoteLengthsTbl)
    
    .byte repeatFlag, triangleLength, sq1Envelope, sq2Envelope
.endm

.macro SongEnd
    .byte $00
.endm

.macro SongRest
    .byte $02
.endm

.macro SongNote args noteName
    assertMsg \?1 == ARG_STRING, "noteName must be a string"
    
    .def note = -1
    .def octave = -1

    .if substring(noteName, 0, 2) == noteName
        .def noteNameLen = 2
    .elif substring(noteName, 0, 3) == noteName
        .def noteNameLen = 3
    .else
        .fail "SongNote: bad noteName string length"
    .endif
    
    ; weird that i need to precalculate these values
    .def noteNameLenMinusOne = noteNameLen - 1
    .def noteNameLenMinusTwo = noteNameLen - 2
    
    .def strNote = substring(noteName, 0, 1)
    .def strAccidental = substring(noteName, 1, noteNameLenMinusTwo)
    .def strOctave = substring(noteName, noteNameLenMinusOne, 1)
    
    .undef noteNameLen, noteNameLenMinusOne, noteNameLenMinusTwo

    ; notes
    .if strNote == "C"
        .redef note = 0
    .elif strNote == "D"
        .redef note = 2
    .elif strNote == "E"
        .redef note = 4
    .elif strNote == "F"
        .redef note = 5
    .elif strNote == "G"
        .redef note = 7
    .elif strNote == "A"
        .redef note = 9
    .elif strNote == "B"
        .redef note = 11
    .else
        .fail "noteName note is invalid"
    .endif
    
    ; accidentals
    .if strAccidental == "s" || strAccidental == "#"
        .redef note = note + 1
    .elif strAccidental == "b"
        .redef note = note - 1
    .elif strAccidental == ""
        ; nothing
    .else
        .fail "noteName accidental is invalid"
    .endif
    
    ; octave (there must be a way to parse integer, this is stupid)
    .if strOctave == "2"
        .redef octave = 2
    .elif strOctave == "3"
        .redef octave = 3
    .elif strOctave == "4"
        .redef octave = 4
    .elif strOctave == "5"
        .redef octave = 5
    .elif strOctave == "6"
        .redef octave = 6
    .elif strOctave == "7"
        .redef octave = 7
    .else
        .fail "noteName octave is invalid"
    .endif

    .def noteID = (note + (octave - 2) * 12) * 2

    ; MusicNotesTbl weirdness
    .if noteID == $7E || noteID == $80
        .fail "the note D#7 was replaced by F7 in the MusicNotesTbl, so D#7 and E7 don't exist"
    .elif noteID == $82
        .redef noteID = $7E
    .endif

    .if noteID == $06
        .fail "the note D#2 was skipped in the MusicNotesTbl, so it doesn't exist"
    .elif noteID == $04 || noteID == $02
        .redef noteID = noteID + 2
    .endif

    assertMsg noteID >= $04 && noteID < $80, "noteID not in range"
    .byte noteID
    
    .undef note, octave, strNote, strAccidental, strOctave, noteID
.endm

.macro SongNoteLength args lengthIndex
    assertMsg lengthIndex < $10, "Invalid note length index"
    .byte $B0 | lengthIndex
.endm

.macro SongRepeatSetup args repetitions
    assertMsg repetitions < $3F, "Invalid number of repetitions"
    .byte $C0 | repetitions
.endm

.macro SongRepeat
    .byte $FF
.endm


.macro FDSFileMacroPart1 args FDSFile_ID
    .section "Side{FDSFile_Side}-FileNumber{%.2X{FDSFile_Number}}-Header" bank FDSFile_Bank slot "DummySlot"
        .byte $03, FDSFile_Number, FDSFile_ID
.endm

.macro FDSFileMacroPart2 args FDSFile_Dest, FDSFile_Type
        .word FDSFile_Dest, Side{FDSFile_Side}File{%.2X{FDSFile_Number}}_End - Side{FDSFile_Side}File{%.2X{FDSFile_Number}}_Start
        .byte FDSFile_Type, $04
    .ends
    .redef FDSFile_Bank = FDSFile_Bank + 1

    .if FDSFile_Type == 0
        .section "Side{FDSFile_Side}-FileNumber{%.2X{FDSFile_Number}}-FileData" bank FDSFile_Bank slot "RAMDiskSysSlot" ORGA FDSFile_Dest FORCE
    .else
        .section "Side{FDSFile_Side}-FileNumber{%.2X{FDSFile_Number}}-FileData" bank FDSFile_Bank slot "DummySlot"
    .endif
    Side{FDSFile_Side}File{%.2X{FDSFile_Number}}_Start:
.endm

.macro FDSFileMacroPart3
    Side{FDSFile_Side}File{%.2X{FDSFile_Number}}_End:
    .ends
    ;.redef FDSFile_Bank = FDSFile_Bank + 1
    ;.redef FDSFile_Number = FDSFile_Number + 1
.endm



