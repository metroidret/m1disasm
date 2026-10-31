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

;Tourian Room Data

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

Room00_{AREA}: ; 03:A8AF
    .byte $2
    .byte ($4 << 4) + $0, _id_Structure01_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure01_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte $FF

Room01_{AREA}: ; 03:A8BD
    .byte $2
    .byte ($0 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte $FF

Room02_{AREA}: ; 03:A8C5
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0C_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0C_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($6 << 4) + $2, _id_Structure13_{AREA}, $2
    .byte ($6 << 4) + $A, _id_Structure13_{AREA}, $2
    .byte ($8 << 4) + $2, _id_Structure0E_{AREA}, $2
    .byte ($8 << 4) + $5, _id_Structure12_{AREA}, $1
    .byte ($8 << 4) + $A, _id_Structure0E_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure12_{AREA}, $1
    .byte ($8 << 4) + $F, _id_Structure09_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure0F_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure0F_{AREA}, $3
    .byte ($D << 4) + $3, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $B, _id_Structure0A_{AREA}, $3
    .byte ($E << 4) + $0, _id_Structure0A_{AREA}, $3
    .byte ($E << 4) + $8, _id_Structure0A_{AREA}, $3
    .byte $FF

Room03_{AREA}: ; 03:A8FA
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0C_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0C_{AREA}, $3
    .byte ($6 << 4) + $2, _id_Structure13_{AREA}, $2
    .byte ($6 << 4) + $A, _id_Structure13_{AREA}, $2
    .byte ($8 << 4) + $2, _id_Structure0E_{AREA}, $2
    .byte ($8 << 4) + $5, _id_Structure12_{AREA}, $1
    .byte ($8 << 4) + $A, _id_Structure0E_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure12_{AREA}, $1
    .byte ($C << 4) + $4, _id_Structure0F_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure0F_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure0D_{AREA}, $2
    .byte ($D << 4) + $3, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $B, _id_Structure0A_{AREA}, $3
    .byte ($E << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($E << 4) + $A, _id_Structure0A_{AREA}, $3
    .byte $FF

Room04_{AREA}: ; 03:A929
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure09_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure0A_{AREA}, $3
    .byte ($0 << 4) + $3, _id_Structure11_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0C_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($5 << 4) + $2, _id_Structure07_{AREA}, $1
    .byte ($5 << 4) + $3, _id_Structure08_{AREA}, $2
    .byte ($6 << 4) + $A, _id_Structure13_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure0E_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure12_{AREA}, $1
    .byte ($9 << 4) + $1, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $B, _id_Structure1C_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure0D_{AREA}, $2
    .byte ($D << 4) + $B, _id_Structure00_{AREA}, $2
    .byte ($E << 4) + $0, _id_Structure0A_{AREA}, $3
    .byte $FF

Room05_{AREA}: ; 03:A95E
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure14_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure14_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure14_{AREA}, $3
    .byte $FF

Room06_{AREA}: ; 03:A975
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $3
    .byte ($9 << 4) + $5, _id_Structure14_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure14_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure14_{AREA}, $3
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $B3 ; Green metroid
    .byte $FF

Room07_{AREA}: ; 03:A990
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($3 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure15_{AREA}, $3
    .byte $FD
    .byte $31, $01, $69 ; Green metroid
    .byte $41, $00, $B5 ; Red metroid
    .byte $FF

Room08_{AREA}: ; 03:A9AB
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($3 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure17_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $7, _id_Structure17_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure17_{AREA}, $3
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $D4 ; Green metroid
    .byte $FF

Room09_{AREA}: ; 03:A9CF
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure16_{AREA}, $3
    .byte ($3 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($3 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure17_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure17_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure17_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $2, _id_Structure17_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte $FF

Room0A_{AREA}: ; 03:A9F2
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure1B_{AREA}, $1
    .byte ($0 << 4) + $9, _id_Structure12_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($3 << 4) + $4, _id_Structure12_{AREA}, $1
    .byte ($4 << 4) + $B, _id_Structure1B_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure1B_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure18_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($B << 4) + $1, _id_Structure18_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure18_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $31, $01, $A5 ; Green metroid
    .byte $41, $00, $48 ; Red metroid
    .byte $51, $01, $6A ; Green metroid
    .byte $FF

Room0B_{AREA}: ; 03:AA33
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $9, _id_Structure12_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($2 << 4) + $3, _id_Structure12_{AREA}, $1
    .byte ($4 << 4) + $B, _id_Structure12_{AREA}, $1
    .byte ($5 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($6 << 4) + $6, _id_Structure1B_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure12_{AREA}, $1
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure12_{AREA}, $1
    .byte ($A << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($C << 4) + $B, _id_Structure1B_{AREA}, $1
    .byte ($D << 4) + $5, _id_Structure12_{AREA}, $1
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $D4 ; Green metroid
    .byte $FF

Room0C_{AREA}: ; 03:AA75
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure1E_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($3 << 4) + $6, _id_Structure1E_{AREA}, $3
    .byte ($3 << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($5 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($7 << 4) + $1, _id_Structure1C_{AREA}, $3
    .byte ($7 << 4) + $2, _id_Structure1E_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($A << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($A << 4) + $6, _id_Structure1E_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $51, $00, $CB ; Red metroid
    .byte $FF

Room0D_{AREA}: ; 03:AAAE
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure18_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure18_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($1 << 4) + $1, _id_Structure18_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure18_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure1E_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $E, _id_Structure1C_{AREA}, $3
    .byte ($D << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $FF

Room0E_{AREA}: ; 03:AAE3
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure18_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure18_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($4 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($4 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure1D_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($9 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($9 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($B << 4) + $B, _id_Structure1B_{AREA}, $1
    .byte ($C << 4) + $3, _id_Structure1B_{AREA}, $1
    .byte ($E << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($E << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte $FF

Room0F_{AREA}: ; 03:AB12
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure12_{AREA}, $1
    .byte ($2 << 4) + $8, _id_Structure12_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure1B_{AREA}, $1
    .byte ($5 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($5 << 4) + $5, _id_Structure1B_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $3, _id_Structure1B_{AREA}, $1
    .byte ($8 << 4) + $B, _id_Structure12_{AREA}, $1
    .byte ($8 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($A << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($B << 4) + $1, _id_Structure18_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure18_{AREA}, $3
    .byte $FF

Room10_{AREA}: ; 03:AB4A
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($1 << 4) + $A, _id_Structure05_{AREA}, $1
    .byte ($4 << 4) + $D, _id_Structure05_{AREA}, $1
    .byte ($5 << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure05_{AREA}, $1
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($9 << 4) + $5, _id_Structure05_{AREA}, $1
    .byte ($A << 4) + $1, _id_Structure1A_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure1A_{AREA}, $3
    .byte ($C << 4) + $A, _id_Structure05_{AREA}, $1
    .byte ($E << 4) + $7, _id_Structure05_{AREA}, $1
    .byte $FF

Room11_{AREA}: ; 03:AB7C
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $9, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $1, _id_Structure1E_{AREA}, $3
    .byte ($1 << 4) + $9, _id_Structure1E_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure1F_{AREA}, $1
    .byte ($A << 4) + $1, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure1A_{AREA}, $3
    .byte ($D << 4) + $1, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $9, _id_Structure1F_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_TenMissile
    .byte $FF

Room12_{AREA}: ; 03:ABA5
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($1 << 4) + $7, _id_Structure1E_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure1F_{AREA}, $1
    .byte ($8 << 4) + $F, _id_Structure19_{AREA}, $3
    .byte ($A << 4) + $7, _id_Structure1A_{AREA}, $3
    .byte ($C << 4) + $5, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $7, _id_Structure1F_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte $FF

Room13_{AREA}: ; 03:ABCE
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $3, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $C, _id_Structure1F_{AREA}, $1
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $FF

Room14_{AREA}: ; 03:ABEF
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($9 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure06_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $3, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $B, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $21, $00, $47 ; Red metroid
    .byte $31, $01, $6A ; Green metroid
    .byte $FF
