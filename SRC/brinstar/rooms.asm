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

;Brinstar Room Definitions

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

Room00_{AREA}: ; 01:A441
    .byte $2
    .byte ($4 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($4 << 4) + $8, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room01_{AREA}: ; 01:A454
    .byte $2
    .byte ($0 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte $FF

Room02_{AREA}: ; 01:A45C
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte $01, $03, $42 ; Ripper
    .byte $11, $83, $8A ; Ripper
    .byte $21, $03, $B5 ; Ripper
    .byte $31, $02, $59 ; Waver
    .byte $41, $02, $A3 ; Waver
    .byte $FF

Room03_{AREA}: ; 01:A480
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure09_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $6, _id_Structure0A_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $B, _id_Structure0A_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($9 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $7, _id_Structure09_{AREA}, $3
    .byte ($D << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $85, $47 ; Zoomer
    .byte $11, $05, $BA ; Zoomer
    .byte $21, $03, $08 ; Ripper
    .byte $31, $83, $53 ; Ripper
    .byte $41, $83, $97 ; Ripper
    .byte $51, $03, $C5 ; Ripper
    .byte $FF

Room04_{AREA}: ; 01:A4BB
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure0A_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($4 << 4) + $7, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure0A_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure0A_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $03, $45 ; Ripper
    .byte $51, $03, $BB ; Ripper
    .byte $31, $05, $39 ; Zoomer
    .byte $FF

Room05_{AREA}: ; 01:A4ED
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $5, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $7, _id_Structure0A_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($8 << 4) + $B, _id_Structure0A_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $6, _id_Structure09_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $83, $43 ; Ripper
    .byte $31, $85, $48 ; Zoomer
    .byte $51, $05, $B7 ; Zoomer
    .byte $FF

Room06_{AREA}: ; 01:A524
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($1 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($3 << 4) + $7, _id_Structure0A_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($7 << 4) + $3, _id_Structure0A_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure0A_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure09_{AREA}, $3
    .byte $FD
    .byte $01, $03, $B3 ; Ripper
    .byte $11, $03, $3C ; Ripper
    .byte $21, $05, $A8 ; Zoomer
    .byte $31, $05, $64 ; Zoomer
    .byte $51, $85, $7B ; Zoomer
    .byte $41, $05, $28 ; Zoomer
    .byte $FF

Room07_{AREA}: ; 01:A55A
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0D_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0D_{AREA}, $3
    .byte ($5 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($6 << 4) + $7, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($C << 4) + $D, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $51, $05, $B2 ; Zoomer
    .byte $41, $05, $BD ; Zoomer
    .byte $31, $05, $67 ; Zoomer
    .byte $FF

Room08_{AREA}: ; 01:A587
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure1E_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte ($3 << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure1E_{AREA}, $3
    .byte ($4 << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte ($7 << 4) + $4, _id_Structure1E_{AREA}, $3
    .byte ($7 << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure1E_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte $FF

Room09_{AREA}: ; 01:A5B9
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure11_{AREA}, $1
    .byte ($3 << 4) + $5, _id_Structure1D_{AREA}, $3
    .byte ($3 << 4) + $B, _id_Structure1D_{AREA}, $3
    .byte ($5 << 4) + $5, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $A, _id_Structure0B_{AREA}, $3
    .byte ($C << 4) + $5, _id_Structure16_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte $51, $05, $25 ; Zoomer
    .byte $41, $05, $2B ; Zoomer
    .byte $FF

Room0A_{AREA}: ; 01:A5DD
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $0
    .byte ($0 << 4) + $F, _id_Structure15_{AREA}, $0
    .byte ($1 << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($1 << 4) + $4, _id_Structure15_{AREA}, $0
    .byte ($2 << 4) + $5, _id_Structure08_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($5 << 4) + $8, _id_Structure0C_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($6 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($7 << 4) + $0, _id_Structure13_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure14_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure16_{AREA}, $0
    .byte ($9 << 4) + $9, _id_Structure16_{AREA}, $0
    .byte ($B << 4) + $3, _id_Structure15_{AREA}, $0
    .byte ($B << 4) + $C, _id_Structure15_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte $FF

Room0B_{AREA}: ; 01:A615
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($0 << 4) + $1, _id_Structure16_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure16_{AREA}, $0
    .byte ($0 << 4) + $F, _id_Structure15_{AREA}, $0
    .byte ($4 << 4) + $F, _id_Structure15_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure16_{AREA}, $0
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $9, _id_Structure16_{AREA}, $0
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $FF

Room0C_{AREA}: ; 01:A635
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure1B_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure1B_{AREA}, $2
    .byte ($1 << 4) + $0, _id_Structure1A_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1A_{AREA}, $2
    .byte ($8 << 4) + $2, _id_Structure19_{AREA}, $2
    .byte ($B << 4) + $C, _id_Structure19_{AREA}, $2
    .byte ($C << 4) + $0, _id_Structure1A_{AREA}, $2
    .byte ($C << 4) + $6, _id_Structure1B_{AREA}, $2
    .byte ($D << 4) + $1, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $9, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $51, $02, $5A ; Waver
    .byte $31, $02, $AA ; Waver
    .byte $FF

Room0D_{AREA}: ; 01:A661
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure1B_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure1B_{AREA}, $2
    .byte ($1 << 4) + $E, _id_Structure1A_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure19_{AREA}, $2
    .byte ($8 << 4) + $E, _id_Structure1A_{AREA}, $2
    .byte ($B << 4) + $7, _id_Structure1A_{AREA}, $2
    .byte ($C << 4) + $2, _id_Structure1A_{AREA}, $2
    .byte ($C << 4) + $E, _id_Structure1A_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $7, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $31, $05, $B3 ; Zoomer
    .byte $51, $02, $44 ; Waver
    .byte $FF

Room0E_{AREA}: ; 01:A68D
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure1B_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure1B_{AREA}, $2
    .byte ($A << 4) + $C, _id_Structure19_{AREA}, $2
    .byte ($B << 4) + $4, _id_Structure19_{AREA}, $2
    .byte ($B << 4) + $8, _id_Structure1A_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $82, $28 ; Waver
    .byte $11, $05, $A5 ; Zoomer
    .byte $21, $02, $8B ; Waver
    .byte $31, $02, $BD ; Waver
    .byte $FF

Room0F_{AREA}: ; 01:A6B1
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure1B_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure1B_{AREA}, $2
    .byte ($5 << 4) + $9, _id_Structure06_{AREA}, $3
    .byte ($9 << 4) + $2, _id_Structure19_{AREA}, $2
    .byte ($A << 4) + $C, _id_Structure19_{AREA}, $2
    .byte ($B << 4) + $B, _id_Structure19_{AREA}, $2
    .byte ($C << 4) + $0, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $02, $3B ; Waver
    .byte $11, $02, $B8 ; Waver
    .byte $51, $85, $84 ; Zoomer
    .byte $41, $05, $49 ; Zoomer
    .byte $FF

Room10_{AREA}: ; 01:A6DB
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure17_{AREA}, $2
    .byte ($1 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($1 << 4) + $8, _id_Structure17_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1A_{AREA}, $2
    .byte ($8 << 4) + $2, _id_Structure19_{AREA}, $2
    .byte ($8 << 4) + $6, _id_Structure2E_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure1B_{AREA}, $2
    .byte ($8 << 4) + $E, _id_Structure1A_{AREA}, $2
    .byte ($C << 4) + $0, _id_Structure1A_{AREA}, $2
    .byte ($C << 4) + $E, _id_Structure1A_{AREA}, $2
    .byte ($D << 4) + $2, _id_Structure12_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure12_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $02, $5C ; Waver
    .byte $11, $02, $A7 ; Waver
    .byte $FF

Room11_{AREA}: ; 01:A715
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte $01, $83, $DD ; Ripper
    .byte $11, $03, $35 ; Ripper
    .byte $21, $02, $7D ; Waver
    .byte $FF

Room12_{AREA}: ; 01:A73C
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $A, _id_Structure11_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure0A_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $05, $C7 ; Zoomer
    .byte $11, $05, $CB ; Zoomer
    .byte $51, $04, $3A ; Skree
    .byte $41, $04, $29 ; Skree
    .byte $31, $04, $1E ; Skree
    .byte $FF

Room13_{AREA}: ; 01:A768
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $7, _id_Structure10_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $A, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $05, $7B ; Zoomer
    .byte $11, $05, $C8 ; Zoomer
    .byte $FF

Room14_{AREA}: ; 01:A78B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure11_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte $51, $04, $14 ; Skree
    .byte $21, $04, $38 ; Skree
    .byte $41, $04, $2E ; Skree
    .byte $FF

Room15_{AREA}: ; 01:A7A3
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure10_{AREA}, $3
    .byte ($9 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($9 << 4) + $6, _id_Structure1F_{AREA}, $1
    .byte ($A << 4) + $A, _id_Structure05_{AREA}, $3
    .byte ($A << 4) + $C, _id_Structure1F_{AREA}, $1
    .byte ($B << 4) + $A, _id_Structure10_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure05_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte $51, $05, $89 ; Zoomer
    .byte $37, $87, $AB ; Enemy spawner: Zeb
    .byte $21, $06, $23 ; Rio
    .byte $17, $07, $C5 ; Enemy spawner: Zeb
    .byte $FF

Room16_{AREA}: ; 01:A7D0
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure11_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($B << 4) + $6, _id_Structure05_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure05_{AREA}, $3
    .byte ($B << 4) + $C, _id_Structure1F_{AREA}, $1
    .byte ($C << 4) + $6, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $07, $07, $B7 ; Enemy spawner: Zeb
    .byte $47, $87, $B9 ; Enemy spawner: Zeb
    .byte $FF

Room17_{AREA}: ; 01:A7F1
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure10_{AREA}, $3
    .byte ($4 << 4) + $A, _id_Structure1E_{AREA}, $3
    .byte ($6 << 4) + $B, _id_Structure1E_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte ($A << 4) + $6, _id_Structure15_{AREA}, $0
    .byte ($B << 4) + $3, _id_Structure1D_{AREA}, $3
    .byte ($B << 4) + $9, _id_Structure1D_{AREA}, $3
    .byte ($C << 4) + $3, _id_Structure0C_{AREA}, $0
    .byte ($C << 4) + $8, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte $41, $05, $B4 ; Zoomer
    .byte $FF

Room18_{AREA}: ; 01:A81B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $9, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $4, _id_Structure0D_{AREA}, $3
    .byte ($6 << 4) + $6, _id_Structure20_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($8 << 4) + $4, _id_Structure20_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure20_{AREA}, $1
    .byte ($8 << 4) + $C, _id_Structure1E_{AREA}, $3
    .byte ($A << 4) + $6, _id_Structure20_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($E << 4) + $6, _id_Structure20_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $31, $05, $56 ; Zoomer
    .byte $01, $85, $5A ; Zoomer
    .byte $21, $05, $D9 ; Zoomer
    .byte $FF

Room19_{AREA}: ; 01:A85B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $C, _id_Structure11_{AREA}, $1
    .byte ($1 << 4) + $2, _id_Structure31_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure1F_{AREA}, $1
    .byte ($4 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($8 << 4) + $4, _id_Structure1F_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $4, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte $51, $05, $C0 ; Zoomer
    .byte $41, $05, $CA ; Zoomer
    .byte $31, $06, $3C ; Rio
    .byte $FF

Room1A_{AREA}: ; 01:A88B
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure28_{AREA}, $2
    .byte ($0 << 4) + $1, _id_Structure2D_{AREA}, $2
    .byte ($0 << 4) + $9, _id_Structure2D_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure28_{AREA}, $2
    .byte ($8 << 4) + $1, _id_Structure14_{AREA}, $0
    .byte ($9 << 4) + $5, _id_Structure15_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure2D_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure2D_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $01, $05, $C7 ; Zoomer
    .byte $11, $85, $CA ; Zoomer
    .byte $FF

Room1B_{AREA}: ; 01:A8B1
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure15_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure15_{AREA}, $0
    .byte ($9 << 4) + $7, _id_Structure06_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $6, _id_Structure15_{AREA}, $0
    .byte ($A << 4) + $8, _id_Structure15_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($B << 4) + $A, _id_Structure06_{AREA}, $3
    .byte ($C << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $41, $05, $AA ; Zoomer
    .byte $21, $06, $17 ; Rio
    .byte $11, $05, $A4 ; Zoomer
    .byte $FF

Room1C_{AREA}: ; 01:A8E7
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($0 << 4) + $1, _id_Structure0D_{AREA}, $3
    .byte ($0 << 4) + $9, _id_Structure0E_{AREA}, $1
    .byte ($2 << 4) + $A, _id_Structure23_{AREA}, $1
    .byte ($3 << 4) + $7, _id_Structure22_{AREA}, $3
    .byte ($4 << 4) + $D, _id_Structure0E_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $A, _id_Structure16_{AREA}, $0
    .byte ($6 << 4) + $D, _id_Structure0E_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure14_{AREA}, $0
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $9, _id_Structure14_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room1D_{AREA}: ; 01:A910
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($4 << 4) + $4, _id_Structure0E_{AREA}, $1
    .byte ($8 << 4) + $4, _id_Structure0F_{AREA}, $1
    .byte ($9 << 4) + $4, _id_Structure0E_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte $31, $06, $42 ; Rio
    .byte $FF

Room1E_{AREA}: ; 01:A92B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $2, _id_Structure2A_{AREA}, $1
    .byte ($0 << 4) + $7, _id_Structure25_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($1 << 4) + $2, _id_Structure2A_{AREA}, $1
    .byte ($1 << 4) + $7, _id_Structure25_{AREA}, $1
    .byte ($1 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($7 << 4) + $4, _id_Structure26_{AREA}, $1
    .byte ($7 << 4) + $8, _id_Structure26_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure24_{AREA}, $1
    .byte ($C << 4) + $C, _id_Structure24_{AREA}, $1
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $11, $02, $52 ; Waver
    .byte $01, $03, $C8 ; Ripper
    .byte $FF

Room1F_{AREA}: ; 01:A96B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure24_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure24_{AREA}, $1
    .byte ($A << 4) + $6, _id_Structure26_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure26_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $02, $2B ; Waver
    .byte $11, $02, $BB ; Waver
    .byte $21, $82, $5B ; Waver
    .byte $31, $02, $8B ; Waver
    .byte $FF

Room20_{AREA}: ; 01:A997
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($1 << 4) + $C, _id_Structure24_{AREA}, $1
    .byte ($2 << 4) + $0, _id_Structure24_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure24_{AREA}, $1
    .byte ($B << 4) + $A, _id_Structure26_{AREA}, $1
    .byte ($C << 4) + $4, _id_Structure26_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $51, $02, $85 ; Waver
    .byte $41, $02, $C5 ; Waver
    .byte $31, $05, $BA ; Zoomer
    .byte $21, $05, $C5 ; Zoomer
    .byte $FF

Room21_{AREA}: ; 01:A9C6
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($3 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($A << 4) + $7, _id_Structure26_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure24_{AREA}, $1
    .byte ($B << 4) + $6, _id_Structure24_{AREA}, $1
    .byte ($B << 4) + $C, _id_Structure24_{AREA}, $1
    .byte ($C << 4) + $4, _id_Structure05_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure27_{AREA}, $1
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $07, $07, $C5 ; Enemy spawner: Zeb
    .byte $11, $05, $AC ; Zoomer
    .byte $21, $05, $A8 ; Zoomer
    .byte $51, $06, $7A ; Rio
    .byte $FF

Room22_{AREA}: ; 01:A9F6
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($3 << 4) + $7, _id_Structure25_{AREA}, $1
    .byte ($4 << 4) + $8, _id_Structure2A_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure2A_{AREA}, $1
    .byte ($6 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($7 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($A << 4) + $3, _id_Structure26_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte $41, $06, $75 ; Rio
    .byte $21, $03, $85 ; Ripper
    .byte $FF

Room23_{AREA}: ; 01:AA20
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($6 << 4) + $3, _id_Structure29_{AREA}, $1
    .byte ($7 << 4) + $3, _id_Structure28_{AREA}, $2
    .byte ($8 << 4) + $B, _id_Structure29_{AREA}, $1
    .byte ($9 << 4) + $B, _id_Structure28_{AREA}, $2
    .byte ($C << 4) + $0, _id_Structure26_{AREA}, $1
    .byte ($C << 4) + $6, _id_Structure26_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $9, _id_Structure0E_{AREA}, $1
    .byte ($D << 4) + $E, _id_Structure05_{AREA}, $3
    .byte $FD
    .byte $01, $85, $63 ; Zoomer
    .byte $11, $05, $8B ; Zoomer
    .byte $21, $02, $6E ; Waver
    .byte $47, $07, $DF ; Enemy spawner: Zeb
    .byte $31, $83, $A8 ; Ripper
    .byte $FF

Room24_{AREA}: ; 01:AA56
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($4 << 4) + $8, _id_Structure2B_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($5 << 4) + $3, _id_Structure20_{AREA}, $1
    .byte ($5 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($5 << 4) + $B, _id_Structure20_{AREA}, $1
    .byte ($6 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($6 << 4) + $8, _id_Structure13_{AREA}, $0
    .byte ($7 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($7 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($8 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure2B_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($9 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($A << 4) + $0, _id_Structure13_{AREA}, $0
    .byte ($A << 4) + $8, _id_Structure2B_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte $01, $05, $4D ; Zoomer
    .byte $11, $85, $6C ; Zoomer
    .byte $21, $05, $8A ; Zoomer
    .byte $31, $85, $AF ; Zoomer
    .byte $41, $05, $47 ; Zoomer
    .byte $FF

Room25_{AREA}: ; 01:AAA4
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($0 << 4) + $5, _id_Structure27_{AREA}, $1
    .byte ($0 << 4) + $A, _id_Structure0E_{AREA}, $1
    .byte ($2 << 4) + $3, _id_Structure24_{AREA}, $1
    .byte ($4 << 4) + $A, _id_Structure13_{AREA}, $0
    .byte ($5 << 4) + $2, _id_Structure24_{AREA}, $1
    .byte ($5 << 4) + $9, _id_Structure20_{AREA}, $1
    .byte ($5 << 4) + $A, _id_Structure0E_{AREA}, $1
    .byte ($6 << 4) + $A, _id_Structure2B_{AREA}, $0
    .byte ($7 << 4) + $9, _id_Structure0E_{AREA}, $1
    .byte ($8 << 4) + $9, _id_Structure2B_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure28_{AREA}, $2
    .byte ($9 << 4) + $4, _id_Structure06_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte ($A << 4) + $8, _id_Structure13_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure0E_{AREA}, $1
    .byte $FD
    .byte $51, $05, $4F ; Zoomer
    .byte $41, $05, $6E ; Zoomer
    .byte $31, $05, $8E ; Zoomer
    .byte $21, $02, $48 ; Waver
    .byte $FF

Room26_{AREA}: ; 01:AAE6
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure27_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure0E_{AREA}, $1
    .byte ($5 << 4) + $6, _id_Structure20_{AREA}, $1
    .byte ($6 << 4) + $0, _id_Structure2B_{AREA}, $0
    .byte ($6 << 4) + $8, _id_Structure2C_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure27_{AREA}, $1
    .byte ($8 << 4) + $B, _id_Structure24_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $51, $05, $67 ; Zoomer
    .byte $41, $05, $7E ; Zoomer
    .byte $21, $05, $7B ; Zoomer
    .byte $31, $03, $49 ; Ripper
    .byte $11, $02, $C6 ; Waver
    .byte $FF

Room27_{AREA}: ; 01:AB19
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $9, _id_Structure11_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure1E_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure1D_{AREA}, $3
    .byte ($B << 4) + $7, _id_Structure1D_{AREA}, $3
    .byte ($C << 4) + $2, _id_Structure09_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $11, $04, $38 ; Skree
    .byte $31, $06, $27 ; Rio
    .byte $FF

Room28_{AREA}: ; 01:AB48
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $2
    .byte ($0 << 4) + $F, _id_Structure28_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure14_{AREA}, $0
    .byte ($8 << 4) + $F, _id_Structure28_{AREA}, $2
    .byte ($9 << 4) + $A, _id_Structure15_{AREA}, $0
    .byte ($C << 4) + $3, _id_Structure26_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure2D_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure2D_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $06, $23 ; Rio
    .byte $31, $05, $7D ; Zoomer
    .byte $FF

Room29_{AREA}: ; 01:AB71
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure2D_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure2D_{AREA}, $2
    .byte ($C << 4) + $2, _id_Structure26_{AREA}, $1
    .byte ($C << 4) + $7, _id_Structure26_{AREA}, $1
    .byte ($C << 4) + $9, _id_Structure26_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure2D_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure2D_{AREA}, $2
    .byte $FD
    .byte $41, $86, $25 ; Rio
    .byte $51, $06, $2A ; Rio
    .byte $21, $05, $CB ; Zoomer
    .byte $FF

Room2A_{AREA}: ; 01:AB92
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure11_{AREA}, $1
    .byte ($6 << 4) + $8, _id_Structure21_{AREA}, $2
    .byte ($7 << 4) + $8, _id_Structure15_{AREA}, $0
    .byte ($9 << 4) + $5, _id_Structure15_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($B << 4) + $B, _id_Structure15_{AREA}, $0
    .byte ($C << 4) + $2, _id_Structure06_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $01, $05, $58 ; Zoomer
    .byte $11, $05, $85 ; Zoomer
    .byte $31, $06, $26 ; Rio
    .byte $FF

Room2B_{AREA}: ; 01:ABBF
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure30_{AREA}, $0
    .byte ($0 << 4) + $1, _id_Structure1A_{AREA}, $2
    .byte ($0 << 4) + $2, _id_Structure30_{AREA}, $0
    .byte ($0 << 4) + $3, _id_Structure1A_{AREA}, $2
    .byte ($0 << 4) + $5, _id_Structure1C_{AREA}, $2
    .byte ($0 << 4) + $A, _id_Structure1B_{AREA}, $2
    .byte ($0 << 4) + $F, _id_Structure30_{AREA}, $0
    .byte ($1 << 4) + $0, _id_Structure30_{AREA}, $0
    .byte ($1 << 4) + $4, _id_Structure30_{AREA}, $0
    .byte ($1 << 4) + $F, _id_Structure30_{AREA}, $0
    .byte ($2 << 4) + $C, _id_Structure18_{AREA}, $2
    .byte ($3 << 4) + $5, _id_Structure18_{AREA}, $2
    .byte ($4 << 4) + $1, _id_Structure19_{AREA}, $2
    .byte ($4 << 4) + $4, _id_Structure2F_{AREA}, $2
    .byte ($4 << 4) + $5, _id_Structure18_{AREA}, $2
    .byte ($4 << 4) + $6, _id_Structure2F_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($5 << 4) + $3, _id_Structure19_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($6 << 4) + $4, _id_Structure1C_{AREA}, $2
    .byte ($6 << 4) + $5, _id_Structure1C_{AREA}, $2
    .byte ($6 << 4) + $8, _id_Structure2F_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($8 << 4) + $1, _id_Structure19_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure19_{AREA}, $2
    .byte ($9 << 4) + $C, _id_Structure19_{AREA}, $2
    .byte ($9 << 4) + $F, _id_Structure15_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure30_{AREA}, $0
    .byte ($D << 4) + $1, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $7, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $F, _id_Structure30_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $06 ; Statues
    .byte $FF

Room2C_{AREA}: ; 01:AC24
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure16_{AREA}, $0
    .byte ($0 << 4) + $7, _id_Structure16_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure16_{AREA}, $0
    .byte ($1 << 4) + $F, _id_Structure15_{AREA}, $0
    .byte ($2 << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure30_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure16_{AREA}, $0
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $9, _id_Structure16_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure15_{AREA}, $0
    .byte ($A << 4) + $F, _id_Structure15_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $FF

Room2D_{AREA}: ; 01:AC4D
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure11_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure11_{AREA}, $1
    .byte ($1 << 4) + $E, _id_Structure1E_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte ($8 << 4) + $B, _id_Structure10_{AREA}, $3
    .byte ($9 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure10_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure10_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $FF

Room2E_{AREA}: ; 01:AC6A
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0B_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure0B_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF
