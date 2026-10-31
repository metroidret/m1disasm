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

;Norfair Room Definitions

;The first byte of the room definitions is attribute table data and is used to set the base color of
;the room. The object data is grouped into 3 byte segments and represents a structure in the room.
;The first byte of the structure data has the format yyyyxxxx and contains the y, x location of the
;structure in the room(measured in tiles). The second byte is an index into the StrctPtrTbl and
;identifies which structure to use.  The third byte is an attribute table byte and determines the
;color of the structure.  Most of the time, this byte will have the same value as the attribute byte
;for the base color of the room. Having a room base color byte reduces the calculations required to
;find the proper color for each structure as the structure attribute byte is skipped if it is the same
;as the room attribute byte. #$FD marks the end of the room objects portion of the room definition.
;Using the byte #$FE can be used as an empty place holder in the room data.  For example, if you
;wanted to remove a structure from a room, simply replace the three bytes associated with the structure
;with #$FE. The next portion of the room definition describes the enemies and doors in the room. The
;number of data bytes and their functions vary depending on what type of item is being loaded.

Room00_{AREA}: ; 02:A3AB
    .byte $2
    .byte ($4 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($4 << 4) + $8, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room01_{AREA}: ; 02:A3BE
    .byte $2
    .byte ($0 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte $FF

Room02_{AREA}: ; 02:A3C6
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($4 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($7 << 4) + $6, _id_Structure08_{AREA}, $1
    .byte ($7 << 4) + $9, _id_Structure08_{AREA}, $1
    .byte ($9 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($9 << 4) + $6, _id_Structure09_{AREA}, $0
    .byte ($9 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $8, _id_Structure06_{AREA}, $3
    .byte ($B << 4) + $7, _id_Structure0A_{AREA}, $3
    .byte ($E << 4) + $0, _id_Structure06_{AREA}, $3
    .byte ($E << 4) + $C, _id_Structure06_{AREA}, $3
    .byte $FF

Room03_{AREA}: ; 02:A3F8
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($2 << 4) + $B, _id_Structure06_{AREA}, $3
    .byte ($3 << 4) + $6, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $D, _id_Structure17_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure17_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room04_{AREA}: ; 02:A42F
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0D_{AREA}, $0
    .byte ($1 << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($1 << 4) + $4, _id_Structure0C_{AREA}, $0
    .byte ($1 << 4) + $F, _id_Structure1F_{AREA}, $0
    .byte ($2 << 4) + $5, _id_Structure0F_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($6 << 4) + $3, _id_Structure0D_{AREA}, $0
    .byte ($7 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($7 << 4) + $8, _id_Structure12_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure11_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure12_{AREA}, $0
    .byte ($8 << 4) + $9, _id_Structure0D_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($9 << 4) + $4, _id_Structure0D_{AREA}, $0
    .byte ($9 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($B << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $1, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $7, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte $FF

Room05_{AREA}: ; 02:A473
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $6, _id_Structure13_{AREA}, $2
    .byte ($0 << 4) + $A, _id_Structure14_{AREA}, $2
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($2 << 4) + $B, _id_Structure0C_{AREA}, $0
    .byte ($4 << 4) + $7, _id_Structure13_{AREA}, $2
    .byte ($4 << 4) + $B, _id_Structure14_{AREA}, $2
    .byte ($4 << 4) + $E, _id_Structure0C_{AREA}, $0
    .byte ($4 << 4) + $F, _id_Structure14_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $B, _id_Structure09_{AREA}, $0
    .byte ($7 << 4) + $A, _id_Structure09_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $9, _id_Structure0D_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room06_{AREA}: ; 02:A4AB
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $4, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $8, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $C, _id_Structure16_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure16_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure16_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure16_{AREA}, $3
    .byte ($9 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($9 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte $FF

Room07_{AREA}: ; 02:A4F5
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($7 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte $FF

Room08_{AREA}: ; 02:A527
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $D, _id_Structure18_{AREA}, $1
    .byte ($3 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $6, _id_Structure10_{AREA}, $1
    .byte ($8 << 4) + $D, _id_Structure18_{AREA}, $1
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $9, _id_Structure10_{AREA}, $1
    .byte ($B << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure18_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $41, $02, $8B ; Ripper II
    .byte $51, $06, $76 ; Nova
    .byte $21, $82, $A3 ; Ripper II
    .byte $FF

Room09_{AREA}: ; 02:A55F
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($2 << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($3 << 4) + $3, _id_Structure06_{AREA}, $3
    .byte ($3 << 4) + $5, _id_Structure06_{AREA}, $3
    .byte ($4 << 4) + $3, _id_Structure0A_{AREA}, $3
    .byte ($4 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($6 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $7, _id_Structure06_{AREA}, $3
    .byte ($9 << 4) + $7, _id_Structure0A_{AREA}, $3
    .byte ($B << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure06_{AREA}, $3
    .byte $FD
    .byte $01, $86, $25 ; Nova
    .byte $11, $82, $C5 ; Ripper II
    .byte $41, $06, $79 ; Nova
    .byte $FF

Room0A_{AREA}: ; 02:A598
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $5, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure18_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $7, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure00_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $4, _id_Structure17_{AREA}, $3
    .byte ($A << 4) + $5, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $9, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $9, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure17_{AREA}, $3
    .byte ($E << 4) + $5, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $31, $02, $36 ; Ripper II
    .byte $41, $86, $48 ; Nova
    .byte $FF

Room0B_{AREA}: ; 02:A5D9
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($3 << 4) + $9, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure17_{AREA}, $3
    .byte ($8 << 4) + $D, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $C, _id_Structure17_{AREA}, $3
    .byte ($B << 4) + $D, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($E << 4) + $C, _id_Structure17_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $06, $2B ; Nova
    .byte $51, $02, $1A ; Ripper II
    .byte $FF

Room0C_{AREA}: ; 02:A617
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $D, _id_Structure18_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($4 << 4) + $D, _id_Structure18_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $D, _id_Structure18_{AREA}, $1
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure18_{AREA}, $1
    .byte $FD
    .byte $01, $02, $33 ; Ripper II
    .byte $31, $82, $88 ; Ripper II
    .byte $FF

Room0D_{AREA}: ; 02:A63E
    .byte $3
    .byte ($1 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure17_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($9 << 4) + $7, _id_Structure0A_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure19_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $21, $0D, $E5 ; Dragon
    .byte $FF

Room0E_{AREA}: ; 02:A678
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($2 << 4) + $B, _id_Structure06_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure06_{AREA}, $3
    .byte ($4 << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $5, _id_Structure06_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $11, $86, $A6 ; Nova
    .byte $31, $02, $EA ; Ripper II
    .byte $21, $02, $39 ; Ripper II
    .byte $FF

Room0F_{AREA}: ; 02:A6AA
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0D_{AREA}, $0
    .byte ($1 << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure09_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $2, _id_Structure09_{AREA}, $0
    .byte ($A << 4) + $F, _id_Structure09_{AREA}, $0
    .byte ($B << 4) + $9, _id_Structure09_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($D << 4) + $3, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $B, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $01, $0D, $E7 ; Dragon
    .byte $11, $8D, $ED ; Dragon
    .byte $31, $06, $AA ; Nova
    .byte $FF

Room10_{AREA}: ; 02:A6DF
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($1 << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure09_{AREA}, $0
    .byte ($9 << 4) + $4, _id_Structure09_{AREA}, $0
    .byte ($9 << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $5, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $D, _id_Structure0E_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $21, $0D, $E2 ; Dragon
    .byte $41, $0D, $EA ; Dragon
    .byte $31, $06, $85 ; Nova
    .byte $FF

Room11_{AREA}: ; 02:A70E
    .byte $3
    .byte ($1 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure17_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure19_{AREA}, $2
    .byte ($B << 4) + $C, _id_Structure17_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room12_{AREA}: ; 02:A749
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure1B_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure0A_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1B_{AREA}, $3
    .byte ($9 << 4) + $A, _id_Structure1C_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure1B_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure1C_{AREA}, $3
    .byte ($B << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $9, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $00, $1C ; Geruta
    .byte $41, $00, $18 ; Geruta
    .byte $21, $0D, $EC ; Dragon
    .byte $FF

Room13_{AREA}: ; 02:A77E
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($1 << 4) + $E, _id_Structure1B_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $9, _id_Structure1C_{AREA}, $3
    .byte ($8 << 4) + $D, _id_Structure1B_{AREA}, $3
    .byte ($A << 4) + $3, _id_Structure1D_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure1C_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure1B_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $51, $80, $24 ; Geruta
    .byte $41, $0D, $E2 ; Dragon
    .byte $31, $86, $94 ; Nova
    .byte $11, $86, $69 ; Nova
    .byte $FF

Room14_{AREA}: ; 02:A7B3
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $6, _id_Structure0A_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure1A_{AREA}, $1
    .byte ($3 << 4) + $2, _id_Structure1A_{AREA}, $1
    .byte ($3 << 4) + $A, _id_Structure1A_{AREA}, $1
    .byte ($3 << 4) + $E, _id_Structure1A_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure1A_{AREA}, $1
    .byte ($5 << 4) + $2, _id_Structure1A_{AREA}, $1
    .byte ($5 << 4) + $A, _id_Structure1A_{AREA}, $1
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $1
    .byte ($B << 4) + $7, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $0D, $E6 ; Dragon
    .byte $51, $8D, $EB ; Dragon
    .byte $FF

Room15_{AREA}: ; 02:A7E6
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure0A_{AREA}, $3
    .byte ($5 << 4) + $2, _id_Structure1C_{AREA}, $3
    .byte ($5 << 4) + $8, _id_Structure1C_{AREA}, $3
    .byte ($5 << 4) + $A, _id_Structure1C_{AREA}, $3
    .byte ($6 << 4) + $4, _id_Structure1C_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure1C_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure1C_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure1B_{AREA}, $3
    .byte ($D << 4) + $3, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $4, _id_Structure1B_{AREA}, $3
    .byte ($D << 4) + $7, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $A, _id_Structure1B_{AREA}, $3
    .byte ($D << 4) + $D, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $E, _id_Structure1B_{AREA}, $3
    .byte $FD
    .byte $31, $0C, $1B ; Multiviola
    .byte $01, $86, $54 ; Nova
    .byte $21, $86, $48 ; Nova
    .byte $51, $06, $7C ; Nova
    .byte $FF

Room16_{AREA}: ; 02:A82B
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure0A_{AREA}, $3
    .byte ($A << 4) + $2, _id_Structure1D_{AREA}, $3
    .byte ($A << 4) + $B, _id_Structure1D_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $0D, $E8 ; Dragon
    .byte $11, $86, $94 ; Nova
    .byte $21, $86, $9C ; Nova
    .byte $51, $00, $18 ; Geruta
    .byte $FF

Room17_{AREA}: ; 02:A852
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $6, _id_Structure0A_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure2D_{AREA}, $3
    .byte ($9 << 4) + $1, _id_Structure0A_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure05_{AREA}, $1
    .byte ($C << 4) + $7, _id_Structure1D_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $41, $06, $73 ; Nova
    .byte $51, $86, $7C ; Nova
    .byte $31, $00, $27 ; Geruta
    .byte $27, $87, $B9 ; Enemy spawner: Gamet
    .byte $FF

Room18_{AREA}: ; 02:A87F
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $3
    .byte ($1 << 4) + $A, _id_Structure0A_{AREA}, $3
    .byte ($2 << 4) + $4, _id_Structure1C_{AREA}, $3
    .byte ($3 << 4) + $E, _id_Structure18_{AREA}, $1
    .byte ($5 << 4) + $4, _id_Structure18_{AREA}, $1
    .byte ($7 << 4) + $E, _id_Structure18_{AREA}, $1
    .byte ($A << 4) + $2, _id_Structure1C_{AREA}, $3
    .byte ($A << 4) + $7, _id_Structure1D_{AREA}, $3
    .byte ($B << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $00, $17 ; Geruta
    .byte $41, $06, $97 ; Nova
    .byte $21, $8B, $E6 ; Squeept
    .byte $01, $0D, $EC ; Dragon
    .byte $FF

Room19_{AREA}: ; 02:A8B2
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0D_{AREA}, $0
    .byte ($1 << 4) + $0, _id_Structure1F_{AREA}, $0
    .byte ($4 << 4) + $4, _id_Structure1F_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure12_{AREA}, $0
    .byte ($8 << 4) + $1, _id_Structure0D_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure1F_{AREA}, $0
    .byte ($9 << 4) + $8, _id_Structure1F_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure0D_{AREA}, $0
    .byte ($B << 4) + $B, _id_Structure1F_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $80, $17 ; Geruta
    .byte $FF

Room1A_{AREA}: ; 02:A8DC
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure05_{AREA}, $2
    .byte ($8 << 4) + $6, _id_Structure05_{AREA}, $2
    .byte ($8 << 4) + $8, _id_Structure0D_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure20_{AREA}, $1
    .byte ($9 << 4) + $4, _id_Structure20_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $27, $87, $85 ; Enemy spawner: Gamet
    .byte $37, $87, $87 ; Enemy spawner: Gamet
    .byte $41, $00, $29 ; Geruta
    .byte $51, $00, $2C ; Geruta
    .byte $FF

Room1B_{AREA}: ; 02:A909
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $4, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $C, _id_Structure2E_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure2E_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure2E_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure2E_{AREA}, $1
    .byte ($8 << 4) + $C, _id_Structure21_{AREA}, $1
    .byte ($9 << 4) + $8, _id_Structure20_{AREA}, $1
    .byte ($9 << 4) + $C, _id_Structure2E_{AREA}, $1
    .byte ($A << 4) + $2, _id_Structure20_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure2E_{AREA}, $1
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $0C, $98 ; Multiviola
    .byte $31, $8C, $3A ; Multiviola
    .byte $11, $0C, $38 ; Multiviola
    .byte $41, $8B, $E6 ; Squeept
    .byte $FF

Room1C_{AREA}: ; 02:A947
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($1 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($A << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $1, _id_Structure23_{AREA}, $1
    .byte ($B << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $41, $0E, $B1 ; Polyp
    .byte $31, $00, $49 ; Geruta
    .byte $FF

Room1D_{AREA}: ; 02:A979
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($1 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $D, _id_Structure23_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $0E, $BD ; Polyp
    .byte $21, $00, $49 ; Geruta
    .byte $FF

Room1E_{AREA}: ; 02:A9AB
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $6, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $7, _id_Structure23_{AREA}, $1
    .byte ($C << 4) + $1, _id_Structure22_{AREA}, $2
    .byte ($C << 4) + $B, _id_Structure22_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $51, $0E, $B7 ; Polyp
    .byte $11, $06, $BD ; Nova
    .byte $31, $86, $B3 ; Nova
    .byte $FF

Room1F_{AREA}: ; 02:A9D5
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($9 << 4) + $0, _id_Structure22_{AREA}, $2
    .byte ($9 << 4) + $C, _id_Structure22_{AREA}, $2
    .byte ($A << 4) + $7, _id_Structure23_{AREA}, $1
    .byte ($B << 4) + $4, _id_Structure22_{AREA}, $2
    .byte ($B << 4) + $8, _id_Structure22_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $41, $0E, $A7 ; Polyp
    .byte $11, $02, $99 ; Ripper II
    .byte $FF

Room20_{AREA}: ; 02:A9FF
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $B, _id_Structure06_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure26_{AREA}, $3
    .byte ($2 << 4) + $1, _id_Structure25_{AREA}, $3
    .byte ($2 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure26_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure25_{AREA}, $3
    .byte ($B << 4) + $3, _id_Structure23_{AREA}, $1
    .byte ($B << 4) + $7, _id_Structure24_{AREA}, $3
    .byte ($C << 4) + $2, _id_Structure26_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure26_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $41, $0E, $B3 ; Polyp
    .byte $11, $86, $A9 ; Nova
    .byte $21, $0C, $43 ; Multiviola
    .byte $01, $0B, $EB ; Squeept
    .byte $FF

Room21_{AREA}: ; 02:AA3D
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure26_{AREA}, $3
    .byte ($1 << 4) + $9, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure26_{AREA}, $3
    .byte ($A << 4) + $A, _id_Structure25_{AREA}, $3
    .byte ($B << 4) + $3, _id_Structure24_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure24_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $31, $06, $BE ; Nova
    .byte $51, $86, $9A ; Nova
    .byte $41, $0C, $77 ; Multiviola
    .byte $21, $0C, $38 ; Multiviola
    .byte $FF

Room22_{AREA}: ; 02:AA6F
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($1 << 4) + $7, _id_Structure24_{AREA}, $3
    .byte ($1 << 4) + $E, _id_Structure26_{AREA}, $3
    .byte ($2 << 4) + $3, _id_Structure25_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure26_{AREA}, $3
    .byte ($C << 4) + $2, _id_Structure24_{AREA}, $3
    .byte ($C << 4) + $7, _id_Structure24_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure26_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $86, $B4 ; Nova
    .byte $11, $86, $B8 ; Nova
    .byte $21, $0C, $59 ; Multiviola
    .byte $31, $0C, $55 ; Multiviola
    .byte $FF

Room23_{AREA}: ; 02:AAA7
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($8 << 4) + $D, _id_Structure24_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure29_{AREA}, $3
    .byte ($9 << 4) + $7, _id_Structure24_{AREA}, $3
    .byte ($B << 4) + $1, _id_Structure24_{AREA}, $3
    .byte ($B << 4) + $2, _id_Structure05_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $86, $88 ; Nova
    .byte $41, $06, $7C ; Nova
    .byte $51, $00, $29 ; Geruta
    .byte $17, $87, $B3 ; Enemy spawner: Gamet
    .byte $FF

Room24_{AREA}: ; 02:AAD4
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure2A_{AREA}, $3
    .byte ($5 << 4) + $6, _id_Structure2A_{AREA}, $3
    .byte ($6 << 4) + $3, _id_Structure2A_{AREA}, $3
    .byte ($6 << 4) + $E, _id_Structure2A_{AREA}, $3
    .byte ($7 << 4) + $8, _id_Structure2A_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure2A_{AREA}, $3
    .byte ($9 << 4) + $F, _id_Structure2A_{AREA}, $3
    .byte ($A << 4) + $1, _id_Structure2A_{AREA}, $3
    .byte ($A << 4) + $5, _id_Structure2A_{AREA}, $3
    .byte ($B << 4) + $A, _id_Structure2A_{AREA}, $3
    .byte ($C << 4) + $7, _id_Structure2A_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $0D, $E8 ; Dragon
    .byte $21, $8B, $ED ; Squeept
    .byte $31, $0B, $E9 ; Squeept
    .byte $FF

Room25_{AREA}: ; 02:AB0D
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure2F_{AREA}, $3
    .byte ($0 << 4) + $A, _id_Structure25_{AREA}, $3
    .byte ($9 << 4) + $0, _id_Structure2F_{AREA}, $3
    .byte ($9 << 4) + $9, _id_Structure05_{AREA}, $1
    .byte ($9 << 4) + $B, _id_Structure24_{AREA}, $3
    .byte ($9 << 4) + $F, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $7, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $0C, $27 ; Multiviola
    .byte $37, $07, $9A ; Enemy spawner: Gamet
    .byte $FF

Room26_{AREA}: ; 02:AB34
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($2 << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($2 << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($5 << 4) + $2, _id_Structure1F_{AREA}, $0
    .byte ($6 << 4) + $0, _id_Structure28_{AREA}, $3
    .byte ($6 << 4) + $4, _id_Structure1F_{AREA}, $0
    .byte ($6 << 4) + $F, _id_Structure25_{AREA}, $3
    .byte ($7 << 4) + $F, _id_Structure29_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure1F_{AREA}, $0
    .byte ($9 << 4) + $7, _id_Structure1F_{AREA}, $0
    .byte ($C << 4) + $B, _id_Structure1F_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $86, $54 ; Nova
    .byte $41, $86, $87 ; Nova
    .byte $51, $0D, $E9 ; Dragon
    .byte $01, $8B, $E5 ; Squeept
    .byte $FF

Room27_{AREA}: ; 02:AB70
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $4, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure20_{AREA}, $1
    .byte ($0 << 4) + $C, _id_Structure20_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($8 << 4) + $1, _id_Structure15_{AREA}, $3
    .byte ($8 << 4) + $7, _id_Structure27_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure27_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure27_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure27_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $51, $0D, $E9 ; Dragon
    .byte $FF

Room28_{AREA}: ; 02:ABA5
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($1 << 4) + $7, _id_Structure15_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure20_{AREA}, $1
    .byte ($8 << 4) + $6, _id_Structure2B_{AREA}, $0
    .byte ($8 << 4) + $A, _id_Structure2B_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($B << 4) + $C, _id_Structure2B_{AREA}, $0
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $2
    .byte ($E << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $06, $77 ; Nova
    .byte $11, $86, $7C ; Nova
    .byte $21, $00, $2A ; Geruta
    .byte $FF

Room29_{AREA}: ; 02:ABDA
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $5, _id_Structure15_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($5 << 4) + $5, _id_Structure2B_{AREA}, $0
    .byte ($6 << 4) + $B, _id_Structure2B_{AREA}, $0
    .byte ($9 << 4) + $1, _id_Structure2B_{AREA}, $0
    .byte ($A << 4) + $8, _id_Structure2B_{AREA}, $0
    .byte ($B << 4) + $3, _id_Structure2B_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure2B_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $41, $06, $43 ; Nova
    .byte $51, $86, $47 ; Nova
    .byte $31, $06, $84 ; Nova
    .byte $21, $86, $99 ; Nova
    .byte $FF

Room2A_{AREA}: ; 02:AC0D
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($1 << 4) + $5, _id_Structure15_{AREA}, $3
    .byte ($1 << 4) + $E, _id_Structure2C_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure20_{AREA}, $1
    .byte ($9 << 4) + $7, _id_Structure2B_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure2C_{AREA}, $1
    .byte ($C << 4) + $2, _id_Structure2B_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte ($E << 4) + $E, _id_Structure2C_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $21, $86, $88 ; Nova
    .byte $31, $86, $B3 ; Nova
    .byte $41, $0B, $E0 ; Squeept
    .byte $51, $8B, $EB ; Squeept
    .byte $FF

Room2B_{AREA}: ; 02:AC42
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($2 << 4) + $B, _id_Structure18_{AREA}, $1
    .byte ($5 << 4) + $5, _id_Structure18_{AREA}, $1
    .byte ($6 << 4) + $B, _id_Structure18_{AREA}, $1
    .byte ($9 << 4) + $5, _id_Structure18_{AREA}, $1
    .byte ($A << 4) + $0, _id_Structure2C_{AREA}, $1
    .byte ($A << 4) + $E, _id_Structure2C_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure2C_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $31, $86, $45 ; Nova
    .byte $21, $06, $A9 ; Nova
    .byte $11, $86, $9E ; Nova
    .byte $01, $0B, $E3 ; Squeept
    .byte $FF

Room2C_{AREA}: ; 02:AC72
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure30_{AREA}, $1
    .byte ($4 << 4) + $6, _id_Structure2C_{AREA}, $1
    .byte ($8 << 4) + $6, _id_Structure2C_{AREA}, $1
    .byte ($9 << 4) + $4, _id_Structure20_{AREA}, $1
    .byte ($A << 4) + $F, _id_Structure20_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure30_{AREA}, $1
    .byte ($C << 4) + $B, _id_Structure20_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $5, _id_Structure20_{AREA}, $1
    .byte ($D << 4) + $9, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $0C, $59 ; Multiviola
    .byte $FF

Room2D_{AREA}: ; 02:AC99
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $9, _id_Structure06_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($9 << 4) + $3, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($C << 4) + $7, _id_Structure06_{AREA}, $3
    .byte $FF
