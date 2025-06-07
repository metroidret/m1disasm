
.macro SignMagSpeed duration, xSpd, ySpd
    .assert duration < $FF, error, "duration must be smaller than $FF"
    .assert xSpd > -8 && xSpd < 8, error, "xSpd must be from -7 to 7 inclusive"
    .assert ySpd > -8 && ySpd < 8, error, "ySpd must be from -7 to 7 inclusive"

    absXSpd .set xSpd
    absYSpd .set ySpd
    signXSpd .set 0
    signYSpd .set 0

    .if xSpd < 0
        signXSpd .set 1
        absXSpd .set -xSpd
    .endif
    .if ySpd < 0
        signYSpd .set 1
        absYSpd .set -ySpd
    .endif

    .byte duration
    ;.out .sprintf("spdByte = $%02X", ((($8*signYSpd)|absYSpd)<<4) + (($8*signXSpd)|absXSpd))
    .byte ((($8*signYSpd)|absYSpd)<<4) + (($8*signXSpd)|absXSpd)
.endmacro

.macro PPUString ppuAddress, ppuString
    .byte .hibyte(ppuAddress), .lobyte(ppuAddress)
    
    ppuStringLen .set 0
    .repeat .tcount(ppuString), tokenID
        .if .match({.mid(tokenID, 1, ppuString)}, "")
            ppuStringLen .set ppuStringLen+.strlen(.mid(tokenID, 1, ppuString))
        .elseif .match({.mid(tokenID, 1, ppuString)}, $00)
            ; assume the number is a byte
            ppuStringLen .set ppuStringLen+1
        .elseif .match({.mid(tokenID, 1, ppuString)}, {,})
            ; ignore comma token
        .else
            .error "all elements in ppuString must be strings or bytes"
        .endif
    .endrep
    
    .assert ppuStringLen >= 1 && ppuStringLen <= 256, error, "ppuStringLen must be from 1 to 256 inclusive"
    
    .byte ppuStringLen
    .byte ppuString
.endmacro

.macro PPUStringRepeat ppuAddress, ppuByte, repetitions
    .byte .hibyte(ppuAddress), .lobyte(ppuAddress)
    .byte repetitions | $40
    .byte ppuByte
.endmacro

.macro PtrTableEntry ptrTable, ptr
    .ident(.concat("_id_", .string(ptr))) .set (* - ptrTable) / 2
    .word ptr
.endmacro

.macro EnemyMovementChoiceEntry enemyMovementIndexList
    enemyMovementIndexListLen .set 0
    .repeat .tcount(enemyMovementIndexList), tokenID
        .if .match({.mid(tokenID, 1, enemyMovementIndexList)}, $00)
            ; assume the number is a byte
            enemyMovementIndexListLen .set enemyMovementIndexListLen+1
        .elseif .match({.mid(tokenID, 1, enemyMovementIndexList)}, {,})
            ; ignore comma token
        .else
            .error "all elements in enemyMovementIndexList must be bytes"
        .endif
    .endrep

    .assert enemyMovementIndexListLen >= 1 && enemyMovementIndexListLen <= 256, error, "enemyMovementIndexListLen must be from 1 to 256 inclusive"
    
    enemyMovementIndexListLen2 .set enemyMovementIndexListLen
    .repeat 8
        .if (enemyMovementIndexListLen2 & 1) = 0
            enemyMovementIndexListLen2 .set enemyMovementIndexListLen2>>1
        .endif
    .endrep
    .assert enemyMovementIndexListLen2 = 1, error, "enemyMovementIndexListLen must be a power of 2"
    
    .byte enemyMovementIndexListLen - 1
    .byte enemyMovementIndexList
.endmacro

.macro EnemyMovementInstr_StopMovementSeahorse
    .byte $FA
.endmacro

.macro EnemyMovementInstr_StopMovement
    .byte $FB
.endmacro

.macro EnemyMovementInstr_RepeatPreviousUntilFailure
    .byte $FC
.endmacro

.macro EnemyMovementInstr_ClearEnData1D
    .byte $FD
.endmacro

.macro EnemyMovementInstr_FE ; some form of end
    .byte $FE
.endmacro

.macro EnemyMovementInstr_Restart
    .byte $FF
.endmacro


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

.macro SongHeader noteLengthsTable, repeatFlag, triangleLength, sq1Envelope, sq2Envelope
    .byte noteLengthsTable - NoteLengthsTbl, repeatFlag, triangleLength, sq1Envelope, sq2Envelope
.endmacro

.macro SongEnd
    .byte $00
.endmacro

.macro SongRest
    .byte $02
.endmacro

.macro SongNote noteName
    .assert .match(noteName, ""), error, "noteName must be a string"
    noteNameLen .set .strlen(noteName)
    note .set -1
    octave .set -1

    .repeat noteNameLen, i
        .if i = 0
            ; notes
            .if .strat(noteName, i) = 'C'
                note .set 0
            .elseif .strat(noteName, i) = 'D'
                note .set 2
            .elseif .strat(noteName, i) = 'E'
                note .set 4
            .elseif .strat(noteName, i) = 'F'
                note .set 5
            .elseif .strat(noteName, i) = 'G'
                note .set 7
            .elseif .strat(noteName, i) = 'A'
                note .set 9
            .elseif .strat(noteName, i) = 'B'
                note .set 11
            .else
                .error "noteName note is invalid"
            .endif
        .elseif i = noteNameLen-1
            ; octave (there must be a way to parse integer, this is stupid)
            .if .strat(noteName, i) = '2'
                octave .set 2
            .elseif .strat(noteName, i) = '3'
                octave .set 3
            .elseif .strat(noteName, i) = '4'
                octave .set 4
            .elseif .strat(noteName, i) = '5'
                octave .set 5
            .elseif .strat(noteName, i) = '6'
                octave .set 6
            .elseif .strat(noteName, i) = '7'
                octave .set 7
            .else
                .error "noteName octave is invalid"
            .endif
        .else
            ; accidentals
            .if .strat(noteName, i) = 's' || .strat(noteName, i) = '#'
                note .set note+1
            .elseif .strat(noteName, i) = 'b'
                note .set note-1
            .else
                .error "noteName accidental is invalid"
            .endif
        .endif
    .endrepeat

    noteID .set (note + (octave-2)*12) * 2
    ;.out .sprintf("noteID = $%02X", noteID)

    ; MusicNotesTbl weirdness
    .if noteID = $7E || noteID = $80
        .error "the note D#7 was replaced by F7 in the MusicNotesTbl, so D#7 and E7 don't exist"
    .elseif noteID = $82
        noteID .set $7E
    .endif

    .if noteID = $06
        .error "the note D#2 was skipped in the MusicNotesTbl, so it doesn't exist"
    .elseif noteID = $04 || noteID = $02
        noteID .set noteID+2
    .endif

    .assert noteID >= $04 && noteID < $80, error, "noteID not in range"
    .byte noteID
.endmacro

.macro SongNoteLength lengthIndex
    .assert lengthIndex < $10, error, "Invalid note length index"
    .byte $B0 | lengthIndex
.endmacro

.macro SongRepeatSetup repetitions
    .assert repetitions < $3F, error, "Invalid number of repetitions"
    .byte $C0 | repetitions
.endmacro

.macro SongRepeat
    .byte $FF
.endmacro
