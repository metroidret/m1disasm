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

;Ridley Room Data

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

Room00_{AREA}: ; 05:A23F
Room01_{AREA}: ; 05:A23F
    .byte $2
    .byte ($0 << 4) + $7, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure03_{AREA}, $2
    .byte $FF

Room02_{AREA}: ; 05:A247
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $6, _id_Structure09_{AREA}, $3
    .byte ($0 << 4) + $B, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($9 << 4) + $3, _id_Structure0A_{AREA}, $0
    .byte ($9 << 4) + $6, _id_Structure09_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure0A_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($E << 4) + $2, _id_Structure08_{AREA}, $3
    .byte ($E << 4) + $A, _id_Structure08_{AREA}, $3
    .byte $FF

Room03_{AREA}: ; 05:A273
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($4 << 4) + $6, _id_Structure08_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room04_{AREA}: ; 05:A29E
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte $FF

Room05_{AREA}: ; 05:A2B2
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($4 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($7 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($7 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($7 << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($7 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $C, _id_Structure08_{AREA}, $3
    .byte $FF

Room06_{AREA}: ; 05:A2E4
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $5, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($6 << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure07_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room07_{AREA}: ; 05:A30F
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($2 << 4) + $6, _id_Structure04_{AREA}, $3
    .byte ($3 << 4) + $5, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $9, _id_Structure09_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $2, _id_Structure05_{AREA}, $1
    .byte ($C << 4) + $4, _id_Structure09_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure04_{AREA}, $3
    .byte ($E << 4) + $B, _id_Structure09_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $07, $87, $27 ; Enemy spawner: Zebbo
    .byte $17, $87, $DD ; Enemy spawner: Zebbo
    .byte $21, $86, $B5 ; Viola
    .byte $31, $86, $7B ; Viola
    .byte $FF

Room08_{AREA}: ; 05:A34D
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($2 << 4) + $2, _id_Structure05_{AREA}, $1
    .byte ($2 << 4) + $6, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($6 << 4) + $2, _id_Structure09_{AREA}, $3
    .byte ($7 << 4) + $9, _id_Structure09_{AREA}, $3
    .byte ($9 << 4) + $5, _id_Structure04_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $4, _id_Structure09_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($E << 4) + $8, _id_Structure09_{AREA}, $3
    .byte $FD
    .byte $51, $06, $17 ; Viola
    .byte $01, $86, $6B ; Viola
    .byte $11, $86, $DA ; Viola
    .byte $27, $87, $96 ; Enemy spawner: Zebbo
    .byte $FF

Room09_{AREA}: ; 05:A383
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($2 << 4) + $6, _id_Structure09_{AREA}, $3
    .byte ($2 << 4) + $D, _id_Structure06_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $C, _id_Structure09_{AREA}, $3
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $31, $86, $18 ; Viola
    .byte $41, $86, $78 ; Viola
    .byte $FF

Room0A_{AREA}: ; 05:A3B8
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $7, _id_Structure19_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($4 << 4) + $5, _id_Structure19_{AREA}, $0
    .byte ($4 << 4) + $C, _id_Structure19_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($7 << 4) + $2, _id_Structure19_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $B, _id_Structure19_{AREA}, $0
    .byte ($B << 4) + $4, _id_Structure19_{AREA}, $0
    .byte ($B << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($E << 4) + $8, _id_Structure19_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $06, $34 ; Viola
    .byte $11, $86, $3C ; Viola
    .byte $21, $06, $9B ; Viola
    .byte $31, $86, $A4 ; Viola
    .byte $51, $86, $D8 ; Viola
    .byte $FF

Room0B_{AREA}: ; 05:A3F9
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $6, _id_Structure19_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $3, _id_Structure19_{AREA}, $0
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure19_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $9, _id_Structure19_{AREA}, $0
    .byte ($B << 4) + $D, _id_Structure06_{AREA}, $1
    .byte $FD
    .byte $41, $86, $06 ; Viola
    .byte $01, $06, $43 ; Viola
    .byte $11, $86, $76 ; Viola
    .byte $21, $86, $A9 ; Viola
    .byte $FF

Room0C_{AREA}: ; 05:A429
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure09_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $31, $82, $74 ; Dessgeega
    .byte $41, $82, $79 ; Dessgeega
    .byte $FF

Room0D_{AREA}: ; 05:A455
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $6, _id_Structure0C_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $6, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($D << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room0E_{AREA}: ; 05:A48C
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure0D_{AREA}, $0
    .byte ($1 << 4) + $E, _id_Structure0D_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $4, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $8, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room0F_{AREA}: ; 05:A4C3
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($7 << 4) + $D, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $4, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $8, _id_Structure0C_{AREA}, $0
    .byte ($B << 4) + $9, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $E, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $51, $80, $27 ; Holtz
    .byte $01, $02, $A4 ; Dessgeega
    .byte $11, $02, $AA ; Dessgeega
    .byte $FF

Room10_{AREA}: ; 05:A4F6
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $B, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $F, _id_Structure0A_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure08_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure0F_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure0F_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_TenMissile
    .byte $51, $80, $27 ; Holtz
    .byte $21, $80, $29 ; Holtz
    .byte $11, $80, $2B ; Holtz
    .byte $FF

Room11_{AREA}: ; 05:A525
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($4 << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($7 << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($7 << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($7 << 4) + $6, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure08_{AREA}, $3
    .byte ($B << 4) + $4, _id_Structure08_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure0F_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure0F_{AREA}, $3
    .byte $FD
    .byte $31, $80, $2E ; Holtz
    .byte $41, $80, $2B ; Holtz
    .byte $FF

Room12_{AREA}: ; 05:A555
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure11_{AREA}, $3
    .byte ($0 << 4) + $6, _id_Structure11_{AREA}, $3
    .byte ($0 << 4) + $A, _id_Structure11_{AREA}, $3
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($1 << 4) + $3, _id_Structure10_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure12_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure10_{AREA}, $3
    .byte ($2 << 4) + $2, _id_Structure0A_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure02_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure11_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure07_{AREA}, $3
    .byte ($9 << 4) + $2, _id_Structure19_{AREA}, $0
    .byte ($9 << 4) + $5, _id_Structure11_{AREA}, $3
    .byte ($9 << 4) + $9, _id_Structure11_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure19_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $7, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $F, _id_Structure07_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_TenMissile
    .byte $01, $49, $66 ; Ridley
    .byte $FF

Room13_{AREA}: ; 05:A5A1
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $1, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $5, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $9, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $D, _id_Structure0E_{AREA}, $0
    .byte ($2 << 4) + $2, _id_Structure11_{AREA}, $3
    .byte ($2 << 4) + $6, _id_Structure11_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure11_{AREA}, $3
    .byte ($8 << 4) + $B, _id_Structure0A_{AREA}, $0
    .byte ($A << 4) + $7, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $F, _id_Structure0A_{AREA}, $0
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $11, $86, $97 ; Viola
    .byte $21, $06, $7B ; Viola
    .byte $31, $86, $AF ; Viola
    .byte $41, $80, $35 ; Holtz
    .byte $51, $83, $3E ; Ceiling dessgeega
    .byte $FF

Room14_{AREA}: ; 05:A5E5
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $6, _id_Structure0A_{AREA}, $0
    .byte ($8 << 4) + $A, _id_Structure0A_{AREA}, $0
    .byte ($A << 4) + $2, _id_Structure0A_{AREA}, $0
    .byte ($A << 4) + $3, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $E, _id_Structure0A_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $01, $86, $92 ; Viola
    .byte $11, $86, $76 ; Viola
    .byte $21, $86, $7A ; Viola
    .byte $31, $06, $AE ; Viola
    .byte $41, $80, $27 ; Holtz
    .byte $FF

Room15_{AREA}: ; 05:A618
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $5, _id_Structure0A_{AREA}, $0
    .byte ($8 << 4) + $6, _id_Structure0A_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure11_{AREA}, $3
    .byte ($9 << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($A << 4) + $2, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $9, _id_Structure0A_{AREA}, $0
    .byte ($C << 4) + $E, _id_Structure07_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $51, $86, $92 ; Viola
    .byte $01, $86, $75 ; Viola
    .byte $21, $80, $23 ; Holtz
    .byte $31, $80, $28 ; Holtz
    .byte $FF

Room16_{AREA}: ; 05:A653
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure13_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure13_{AREA}, $1
    .byte ($9 << 4) + $4, _id_Structure05_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure14_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $80, $37 ; Holtz
    .byte $51, $80, $3C ; Holtz
    .byte $01, $80, $3E ; Holtz
    .byte $FF

Room17_{AREA}: ; 05:A67C
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($9 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($9 << 4) + $2, _id_Structure04_{AREA}, $3
    .byte ($9 << 4) + $4, _id_Structure04_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($9 << 4) + $B, _id_Structure04_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure14_{AREA}, $1
    .byte $FD
    .byte $17, $87, $93 ; Enemy spawner: Zebbo
    .byte $27, $07, $95 ; Enemy spawner: Zebbo
    .byte $37, $87, $9C ; Enemy spawner: Zebbo
    .byte $FF

Room18_{AREA}: ; 05:A6A9
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($5 << 4) + $2, _id_Structure13_{AREA}, $1
    .byte ($5 << 4) + $A, _id_Structure13_{AREA}, $1
    .byte ($6 << 4) + $1, _id_Structure06_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $3, _id_Structure04_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $B, _id_Structure04_{AREA}, $3
    .byte $FD
    .byte $47, $87, $C4 ; Enemy spawner: Zebbo
    .byte $57, $87, $CC ; Enemy spawner: Zebbo
    .byte $01, $80, $67 ; Holtz
    .byte $FF

Room19_{AREA}: ; 05:A6D6
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($1 << 4) + $C, _id_Structure13_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure13_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure14_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $5, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $11, $80, $33 ; Holtz
    .byte $21, $00, $35 ; Holtz
    .byte $31, $80, $37 ; Holtz
    .byte $FF

Room1A_{AREA}: ; 05:A6FF
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure13_{AREA}, $1
    .byte ($D << 4) + $7, _id_Structure13_{AREA}, $1
    .byte ($D << 4) + $8, _id_Structure04_{AREA}, $3
    .byte ($D << 4) + $B, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure13_{AREA}, $1
    .byte $FD
    .byte $41, $00, $64 ; Holtz
    .byte $51, $80, $68 ; Holtz
    .byte $01, $00, $6C ; Holtz
    .byte $17, $87, $D9 ; Enemy spawner: Zebbo
    .byte $FF

Room1B_{AREA}: ; 05:A72C
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($3 << 4) + $0, _id_Structure13_{AREA}, $1
    .byte ($3 << 4) + $4, _id_Structure13_{AREA}, $1
    .byte ($3 << 4) + $8, _id_Structure13_{AREA}, $1
    .byte ($3 << 4) + $C, _id_Structure13_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure16_{AREA}, $1
    .byte ($4 << 4) + $1, _id_Structure15_{AREA}, $1
    .byte ($4 << 4) + $4, _id_Structure15_{AREA}, $1
    .byte ($4 << 4) + $8, _id_Structure15_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure15_{AREA}, $1
    .byte ($4 << 4) + $F, _id_Structure16_{AREA}, $1
    .byte ($9 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($9 << 4) + $2, _id_Structure04_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($9 << 4) + $B, _id_Structure04_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure14_{AREA}, $1
    .byte $FD
    .byte $27, $87, $93 ; Enemy spawner: Zebbo
    .byte $37, $87, $9C ; Enemy spawner: Zebbo
    .byte $FF

Room1C_{AREA}: ; 05:A76B
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($2 << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($2 << 4) + $8, _id_Structure0A_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure19_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure19_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $A, _id_Structure18_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $8C, $39 ; Multiviola
    .byte $11, $0C, $3D ; Multiviola
    .byte $21, $8C, $6B ; Multiviola
    .byte $31, $0C, $66 ; Multiviola
    .byte $FF

Room1D_{AREA}: ; 05:A79D
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($2 << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($7 << 4) + $0, _id_Structure19_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure17_{AREA}, $2
    .byte ($9 << 4) + $4, _id_Structure19_{AREA}, $0
    .byte ($B << 4) + $8, _id_Structure17_{AREA}, $2
    .byte ($B << 4) + $C, _id_Structure17_{AREA}, $2
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $8C, $33 ; Multiviola
    .byte $11, $0C, $36 ; Multiviola
    .byte $41, $8C, $92 ; Multiviola
    .byte $51, $0C, $A6 ; Multiviola
    .byte $FF

Room1E_{AREA}: ; 05:A7CF
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($3 << 4) + $0, _id_Structure0A_{AREA}, $0
    .byte ($4 << 4) + $9, _id_Structure19_{AREA}, $0
    .byte ($5 << 4) + $5, _id_Structure0A_{AREA}, $0
    .byte ($5 << 4) + $D, _id_Structure0A_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($A << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $21, $8C, $38 ; Multiviola
    .byte $31, $0C, $97 ; Multiviola
    .byte $41, $8C, $99 ; Multiviola
    .byte $51, $0C, $9B ; Multiviola
    .byte $FF

Room1F_{AREA}: ; 05:A7FC
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($0 << 4) + $4, _id_Structure17_{AREA}, $2
    .byte ($0 << 4) + $8, _id_Structure17_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure17_{AREA}, $2
    .byte ($7 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($7 << 4) + $4, _id_Structure17_{AREA}, $2
    .byte ($7 << 4) + $8, _id_Structure17_{AREA}, $2
    .byte ($7 << 4) + $C, _id_Structure17_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $01, $8C, $42 ; Multiviola
    .byte $11, $0C, $45 ; Multiviola
    .byte $21, $8C, $48 ; Multiviola
    .byte $FF

Room20_{AREA}: ; 05:A826
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure18_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $8, _id_Structure18_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $21, $82, $5B ; Dessgeega
    .byte $31, $03, $85 ; Ceiling dessgeega
    .byte $41, $83, $88 ; Ceiling dessgeega
    .byte $FF

Room21_{AREA}: ; 05:A849
    .byte $2
    .byte ($2 << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($2 << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($A << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($A << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $01, $82, $98 ; Dessgeega
    .byte $11, $02, $9E ; Dessgeega
    .byte $41, $83, $53 ; Ceiling dessgeega
    .byte $FF

Room22_{AREA}: ; 05:A867
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure18_{AREA}, $2
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $8, _id_Structure18_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $11, $02, $57 ; Dessgeega
    .byte $31, $83, $85 ; Ceiling dessgeega
    .byte $41, $83, $88 ; Ceiling dessgeega
    .byte $51, $03, $8A ; Ceiling dessgeega
    .byte $FF

Room23_{AREA}: ; 05:A88D
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($0 << 4) + $2, _id_Structure12_{AREA}, $3
    .byte ($0 << 4) + $A, _id_Structure12_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($8 << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $F, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure07_{AREA}, $3
    .byte ($B << 4) + $9, _id_Structure0B_{AREA}, $0
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $80, $18 ; Holtz
    .byte $11, $80, $1E ; Holtz
    .byte $21, $86, $AB ; Viola
    .byte $31, $86, $7F ; Viola
    .byte $FF

Room24_{AREA}: ; 05:A8BF
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure12_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure12_{AREA}, $3
    .byte ($9 << 4) + $2, _id_Structure04_{AREA}, $3
    .byte ($9 << 4) + $4, _id_Structure04_{AREA}, $3
    .byte ($9 << 4) + $9, _id_Structure0B_{AREA}, $0
    .byte ($A << 4) + $2, _id_Structure0B_{AREA}, $0
    .byte ($B << 4) + $F, _id_Structure0B_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $07, $87, $93 ; Enemy spawner: Zebbo
    .byte $11, $00, $1A ; Holtz
    .byte $21, $80, $1F ; Holtz
    .byte $47, $87, $95 ; Enemy spawner: Zebbo
    .byte $51, $86, $8B ; Viola
    .byte $FF

Room25_{AREA}: ; 05:A8EC
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($3 << 4) + $7, _id_Structure0A_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($7 << 4) + $7, _id_Structure0A_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure17_{AREA}, $2
    .byte ($8 << 4) + $D, _id_Structure1A_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $4, _id_Structure1B_{AREA}, $2
    .byte ($C << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($D << 4) + $4, _id_Structure1C_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure1C_{AREA}, $2
    .byte ($D << 4) + $C, _id_Structure1C_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $01, $82, $27 ; Dessgeega
    .byte $11, $82, $2B ; Dessgeega
    .byte $21, $83, $B5 ; Ceiling dessgeega
    .byte $31, $83, $BA ; Ceiling dessgeega
    .byte $FF

Room26_{AREA}: ; 05:A92A
    .byte $2
    .byte ($0 << 4) + $0, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $7, _id_Structure1A_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $8, _id_Structure18_{AREA}, $2
    .byte ($C << 4) + $F, _id_Structure1B_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure1C_{AREA}, $2
    .byte ($D << 4) + $4, _id_Structure1C_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure1C_{AREA}, $2
    .byte ($D << 4) + $C, _id_Structure1C_{AREA}, $2
    .byte $FD
    .byte $21, $82, $26 ; Dessgeega
    .byte $31, $02, $2B ; Dessgeega
    .byte $41, $83, $B3 ; Ceiling dessgeega
    .byte $51, $03, $BC ; Ceiling dessgeega
    .byte $FF

Room27_{AREA}: ; 05:A95D
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($B << 4) + $2, _id_Structure04_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $9, _id_Structure14_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $07, $87, $B3 ; Enemy spawner: Zebbo
    .byte $11, $03, $29 ; Ceiling dessgeega
    .byte $FF

Room28_{AREA}: ; 05:A97B
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure14_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure14_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure0A_{AREA}, $0
    .byte ($6 << 4) + $0, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure0A_{AREA}, $0
    .byte ($B << 4) + $5, _id_Structure04_{AREA}, $3
    .byte ($C << 4) + $1, _id_Structure14_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure14_{AREA}, $1
    .byte ($D << 4) + $1, _id_Structure00_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $3
    .byte $FD
    .byte $27, $87, $B6 ; Enemy spawner: Zebbo
    .byte $11, $82, $B7 ; Dessgeega
    .byte $11, $80, $27 ; Holtz
    .byte $FF

Room29_{AREA}: ; 05:A9A5
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure01_{AREA}, $2
    .byte ($5 << 4) + $C, _id_Structure0B_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte ($A << 4) + $F, _id_Structure0B_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure0B_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF
