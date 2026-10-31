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

;Kraid Room Data

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

Room00_{AREA}: ; 04:A2B7
    .byte $2
    .byte ($4 << 4) + $0, _id_Structure01_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure01_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure04_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure04_{AREA}, $2
    .byte $FF

Room01_{AREA}: ; 04:A2C5
    .byte $2
    .byte ($0 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte ($8 << 4) + $7, _id_Structure02_{AREA}, $2
    .byte $FF

Room02_{AREA}: ; 04:A2CD
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($4 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($6 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($7 << 4) + $5, _id_Structure0C_{AREA}, $0
    .byte ($7 << 4) + $A, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($9 << 4) + $2, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $6, _id_Structure0D_{AREA}, $0
    .byte ($9 << 4) + $D, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($E << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($E << 4) + $1, _id_Structure0D_{AREA}, $0
    .byte ($E << 4) + $B, _id_Structure0D_{AREA}, $0
    .byte ($E << 4) + $E, _id_Structure06_{AREA}, $0
    .byte $FF

Room03_{AREA}: ; 04:A308
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure0D_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($2 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($2 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($4 << 4) + $5, _id_Structure0D_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $A, _id_Structure06_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($A << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $9, _id_Structure0D_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($D << 4) + $B, _id_Structure09_{AREA}, $1
    .byte ($E << 4) + $1, _id_Structure10_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $31, $85, $37 ; Zeela
    .byte $FF

Room04_{AREA}: ; 04:A345
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($0 << 4) + $7, _id_Structure06_{AREA}, $0
    .byte ($0 << 4) + $B, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($2 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($2 << 4) + $A, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $5, _id_Structure0D_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $7, _id_Structure06_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure0D_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure0D_{AREA}, $0
    .byte ($8 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($9 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($B << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($C << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure06_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $85, $25 ; Zeela
    .byte $21, $83, $C8 ; Ripper
    .byte $FF

Room05_{AREA}: ; 04:A388
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($1 << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($6 << 4) + $B, _id_Structure09_{AREA}, $1
    .byte ($7 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($9 << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($B << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($D << 4) + $B, _id_Structure09_{AREA}, $1
    .byte $FD
    .byte $51, $83, $57 ; Ripper
    .byte $01, $03, $95 ; Ripper
    .byte $11, $03, $CA ; Ripper
    .byte $FF

Room06_{AREA}: ; 04:A3B8
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure06_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($1 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($1 << 4) + $7, _id_Structure0E_{AREA}, $0
    .byte ($1 << 4) + $A, _id_Structure0D_{AREA}, $0
    .byte ($2 << 4) + $7, _id_Structure0C_{AREA}, $0
    .byte ($3 << 4) + $1, _id_Structure0E_{AREA}, $0
    .byte ($3 << 4) + $6, _id_Structure11_{AREA}, $0
    .byte ($3 << 4) + $9, _id_Structure07_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $9, _id_Structure0E_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $85, $2A ; Zeela
    .byte $51, $85, $26 ; Zeela
    .byte $FF

Room07_{AREA}: ; 04:A401
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($2 << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($2 << 4) + $7, _id_Structure0E_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $2, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $B, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($9 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($9 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($B << 4) + $2, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $6, _id_Structure0D_{AREA}, $0
    .byte ($C << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($D << 4) + $6, _id_Structure08_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $85, $17 ; Zeela
    .byte $21, $85, $A8 ; Zeela
    .byte $31, $03, $87 ; Ripper
    .byte $FF

Room08_{AREA}: ; 04:A442
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $3, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($2 << 4) + $9, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $5, _id_Structure0E_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($7 << 4) + $9, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($A << 4) + $B, _id_Structure09_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $4, _id_Structure0D_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($D << 4) + $4, _id_Structure08_{AREA}, $1
    .byte $FD
    .byte $11, $85, $6A ; Zeela
    .byte $41, $85, $A6 ; Zeela
    .byte $FF

Room09_{AREA}: ; 04:A47E
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA} $00
    .byte ($0 << 4) + $D, _id_Structure09_{AREA} $01
    .byte ($0 << 4) + $E, _id_Structure07_{AREA} $00
    .byte ($4 << 4) + $2, _id_Structure08_{AREA} $01
    .byte ($5 << 4) + $0, _id_Structure07_{AREA} $00
    .byte ($5 << 4) + $F, _id_Structure03_{AREA} $02
    .byte ($8 << 4) + $B, _id_Structure0E_{AREA} $00
    .byte ($8 << 4) + $E, _id_Structure07_{AREA} $00
    .byte ($9 << 4) + $D, _id_Structure09_{AREA} $01
    .byte ($A << 4) + $0, _id_Structure07_{AREA} $00
    .byte ($A << 4) + $6, _id_Structure0E_{AREA} $00
    .byte ($D << 4) + $E, _id_Structure07_{AREA} $00
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $21, $85, $97 ; Zeela
    .byte $31, $03, $83 ; Ripper
    .byte $FF

Room0A_{AREA}: ; 04:A4AD
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($1 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($7 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($8 << 4) + $7, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $B, _id_Structure0E_{AREA}, $0
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($A << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($A << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte ($E << 4) + $0, _id_Structure10_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $85, $78 ; Zeela
    .byte $11, $03, $28 ; Ripper
    .byte $FF

Room0B_{AREA}: ; 04:A4E2
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($B << 4) + $C, _id_Structure10_{AREA}, $0
    .byte $FF

Room0C_{AREA}: ; 04:A514
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure11_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($2 << 4) + $5, _id_Structure11_{AREA}, $0
    .byte ($3 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $9, _id_Structure11_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $2, _id_Structure11_{AREA}, $0
    .byte ($8 << 4) + $6, _id_Structure11_{AREA}, $0
    .byte ($9 << 4) + $C, _id_Structure11_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($B << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($C << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure11_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($D << 4) + $4, _id_Structure11_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $51, $85, $39 ; Zeela
    .byte $41, $05, $C4 ; Zeela
    .byte $FF

Room0D_{AREA}: ; 04:A558
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($1 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($4 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $6, _id_Structure0F_{AREA}, $2
    .byte ($8 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure11_{AREA}, $0
    .byte ($9 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($A << 4) + $2, _id_Structure11_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($C << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($D << 4) + $0, _id_Structure07_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $FF

Room0E_{AREA}: ; 04:A590
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($2 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($5 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($7 << 4) + $8, _id_Structure11_{AREA}, $0
    .byte ($8 << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte ($9 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($A << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($A << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($B << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($C << 4) + $A, _id_Structure0F_{AREA}, $2
    .byte $FF

Room0F_{AREA}: ; 04:A5BF
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($1 << 4) + $E, _id_Structure1F_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure1F_{AREA}, $1
    .byte ($9 << 4) + $B, _id_Structure09_{AREA}, $1
    .byte ($C << 4) + $9, _id_Structure1D_{AREA}, $1
    .byte ($D << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $41, $84, $31 ; Skree
    .byte $57, $87, $D5 ; Enemy spawner: Geega
    .byte $07, $87, $D8 ; Enemy spawner: Geega
    .byte $FF

Room10_{AREA}: ; 04:A5E8
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure12_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure12_{AREA}, $0
    .byte ($5 << 4) + $7, _id_Structure0C_{AREA}, $0
    .byte ($7 << 4) + $5, _id_Structure0C_{AREA}, $0
    .byte ($7 << 4) + $9, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $3, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $B, _id_Structure0C_{AREA}, $0
    .byte ($B << 4) + $1, _id_Structure0C_{AREA}, $0
    .byte ($B << 4) + $D, _id_Structure0C_{AREA}, $0
    .byte ($C << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $41, $81, $2D ; Ceiling sidehopper
    .byte $27, $07, $D4 ; Enemy spawner: Geega
    .byte $17, $87, $DA ; Enemy spawner: Geega
    .byte $FF

Room11_unused: ; 04:A618
    ; Not used
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($2 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $2, _id_Structure0E_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte $FF

Room11_{AREA}: ; 04:A647
Room12_{AREA}: ; 04:A647
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure12_{AREA}, $0
    .byte ($0 << 4) + $8, _id_Structure12_{AREA}, $0
    .byte ($2 << 4) + $4, _id_Structure11_{AREA}, $0
    .byte ($3 << 4) + $7, _id_Structure0C_{AREA}, $0
    .byte ($4 << 4) + $5, _id_Structure0C_{AREA}, $0
    .byte ($4 << 4) + $8, _id_Structure0E_{AREA}, $0
    .byte ($5 << 4) + $7, _id_Structure0C_{AREA}, $0
    .byte ($6 << 4) + $3, _id_Structure0C_{AREA}, $0
    .byte ($6 << 4) + $5, _id_Structure0C_{AREA}, $0
    .byte ($9 << 4) + $B, _id_Structure0E_{AREA}, $0
    .byte ($A << 4) + $2, _id_Structure11_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $5, _id_Structure0E_{AREA}, $0
    .byte ($C << 4) + $9, _id_Structure0C_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $21, $85, $39 ; Zeela
    .byte $31, $85, $8C ; Zeela
    .byte $41, $85, $B6 ; Zeela
    .byte $FF

Room13_{AREA}: ; 04:A683
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $8, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($9 << 4) + $3, _id_Structure14_{AREA}, $3
    .byte ($A << 4) + $B, _id_Structure14_{AREA}, $3
    .byte ($B << 4) + $F, _id_Structure14_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure16_{AREA}, $3
    .byte ($D << 4) + $2, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $A, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $21, $81, $27 ; Ceiling sidehopper
    .byte $41, $85, $84 ; Zeela
    .byte $37, $87, $DD ; Enemy spawner: Geega
    .byte $FF

Room14_{AREA}: ; 04:A6B5
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure14_{AREA}, $3
    .byte ($A << 4) + $4, _id_Structure14_{AREA}, $3
    .byte ($A << 4) + $F, _id_Structure14_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte $37, $87, $D1 ; Enemy spawner: Geega
    .byte $47, $87, $D7 ; Enemy spawner: Geega
    .byte $57, $87, $DC ; Enemy spawner: Geega
    .byte $01, $85, $95 ; Zeela
    .byte $FF

Room15_{AREA}: ; 04:A6D9
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($2 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($2 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($8 << 4) + $7, _id_Structure20_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($9 << 4) + $7, _id_Structure21_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($B << 4) + $7, _id_Structure21_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $7, _id_Structure21_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $80, $68 ; Sidehopper
    .byte $FF

Room16_{AREA}: ; 04:A713
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($1 << 4) + $E, _id_Structure16_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $1, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $5, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure15_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure16_{AREA}, $3
    .byte ($B << 4) + $A, _id_Structure14_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure16_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $6, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $07, $87, $D3 ; Enemy spawner: Geega
    .byte $17, $07, $D8 ; Enemy spawner: Geega
    .byte $21, $81, $27 ; Ceiling sidehopper
    .byte $FF

Room17_{AREA}: ; 04:A745
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure17_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure17_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($2 << 4) + $4, _id_Structure18_{AREA}, $3
    .byte ($3 << 4) + $6, _id_Structure0C_{AREA}, $0
    .byte ($3 << 4) + $B, _id_Structure0C_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($A << 4) + $E, _id_Structure0C_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($D << 4) + $4, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $9, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $B, _id_Structure05_{AREA}, $2
    .byte ($D << 4) + $F, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $80, $C5 ; Sidehopper
    .byte $57, $87, $DC ; Enemy spawner: Geega
    .byte $31, $04, $48 ; Skree
    .byte $FF

Room18_{AREA}: ; 04:A780
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure17_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure17_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($2 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $3, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $4, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $5, _id_Structure05_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $37, $87, $D6 ; Enemy spawner: Geega
    .byte $21, $84, $62 ; Skree
    .byte $11, $84, $25 ; Skree
    .byte $01, $84, $29 ; Skree
    .byte $FF

Room19_{AREA}: ; 04:A7B2
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure19_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($4 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($4 << 4) + $4, _id_Structure19_{AREA}, $3
    .byte ($4 << 4) + $8, _id_Structure19_{AREA}, $3
    .byte ($4 << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($7 << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($7 << 4) + $4, _id_Structure19_{AREA}, $3
    .byte ($7 << 4) + $8, _id_Structure19_{AREA}, $3
    .byte ($7 << 4) + $C, _id_Structure19_{AREA}, $3
    .byte ($9 << 4) + $0, _id_Structure1A_{AREA}, $3
    .byte ($9 << 4) + $4, _id_Structure1A_{AREA}, $3
    .byte ($9 << 4) + $8, _id_Structure1A_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure1A_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure1A_{AREA}, $3
    .byte ($B << 4) + $8, _id_Structure1A_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure19_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure19_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure19_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure19_{AREA}, $3
    .byte $FF

Room1A_{AREA}: ; 04:A7F6
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $1, _id_Structure1B_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($9 << 4) + $1, _id_Structure1C_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $1, _id_Structure1C_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure13_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $31, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room1B_{AREA}: ; 04:A83F
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($0 << 4) + $4, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $7, _id_Structure21_{AREA}, $1
    .byte ($0 << 4) + $C, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure0C_{AREA}, $0
    .byte ($1 << 4) + $4, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $7, _id_Structure21_{AREA}, $1
    .byte ($1 << 4) + $8, _id_Structure1F_{AREA}, $1
    .byte ($1 << 4) + $F, _id_Structure0C_{AREA}, $0
    .byte ($2 << 4) + $5, _id_Structure0B_{AREA}, $2
    .byte ($2 << 4) + $A, _id_Structure0B_{AREA}, $2
    .byte ($4 << 4) + $1, _id_Structure22_{AREA}, $0
    .byte ($4 << 4) + $C, _id_Structure23_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $4, _id_Structure22_{AREA}, $0
    .byte ($5 << 4) + $9, _id_Structure23_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $2, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $6, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $A, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure14_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($9 << 4) + $2, _id_Structure16_{AREA}, $3
    .byte ($9 << 4) + $C, _id_Structure16_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure12_{AREA}, $0
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $C, _id_Structure12_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Red
    .byte $27, $07, $D9 ; Enemy spawner: Geega
    .byte $FF

Room1C_{AREA}: ; 04:A8A3
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure17_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure17_{AREA}, $3
    .byte ($B << 4) + $0, _id_Structure18_{AREA}, $3
    .byte ($B << 4) + $6, _id_Structure05_{AREA}, $2
    .byte ($B << 4) + $8, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $0, _id_Structure18_{AREA}, $3
    .byte ($D << 4) + $8, _id_Structure18_{AREA}, $3
    .byte $FD
    .byte $37, $87, $B7 ; Enemy spawner: Geega
    .byte $01, $80, $45 ; Sidehopper
    .byte $11, $00, $3B ; Sidehopper
    .byte $21, $81, $9A ; Ceiling sidehopper
    .byte $FF

Room1D_{AREA}: ; 04:A8C7
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure15_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure15_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure24_{AREA}, $3
    .byte ($1 << 4) + $3, _id_Structure0B_{AREA}, $2
    .byte ($1 << 4) + $8, _id_Structure24_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure0B_{AREA}, $2
    .byte ($1 << 4) + $F, _id_Structure25_{AREA}, $3
    .byte ($2 << 4) + $0, _id_Structure25_{AREA}, $3
    .byte ($2 << 4) + $2, _id_Structure22_{AREA}, $0
    .byte ($2 << 4) + $B, _id_Structure23_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($6 << 4) + $0, _id_Structure25_{AREA}, $3
    .byte ($8 << 4) + $E, _id_Structure25_{AREA}, $3
    .byte ($8 << 4) + $F, _id_Structure13_{AREA}, $3
    .byte ($A << 4) + $0, _id_Structure25_{AREA}, $3
    .byte ($A << 4) + $2, _id_Structure11_{AREA}, $0
    .byte ($A << 4) + $C, _id_Structure11_{AREA}, $0
    .byte ($B << 4) + $3, _id_Structure12_{AREA}, $0
    .byte ($B << 4) + $B, _id_Structure0C_{AREA}, $0
    .byte ($B << 4) + $E, _id_Structure1B_{AREA}, $3
    .byte ($C << 4) + $3, _id_Structure24_{AREA}, $3
    .byte ($C << 4) + $E, _id_Structure12_{AREA}, $0
    .byte ($D << 4) + $1, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $3, _id_Structure24_{AREA}, $3
    .byte ($D << 4) + $C, _id_Structure00_{AREA}, $2
    .byte ($D << 4) + $E, _id_Structure12_{AREA}, $0
    .byte ($E << 4) + $0, _id_Structure25_{AREA}, $3
    .byte ($E << 4) + $3, _id_Structure15_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Red
    .byte $01, $48, $95 ; Kraid
    .byte $FF

Room1E_{AREA}: ; 04:A923
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1E_{AREA}, $1
    .byte ($0 << 4) + $2, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($1 << 4) + $F, _id_Structure1F_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure1E_{AREA}, $1
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($7 << 4) + $7, _id_Structure0C_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure1E_{AREA}, $1
    .byte ($8 << 4) + $7, _id_Structure1E_{AREA}, $1
    .byte ($8 << 4) + $D, _id_Structure1F_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $11, $81, $35 ; Ceiling sidehopper
    .byte $FF

Room1F_{AREA}: ; 04:A94F
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($1 << 4) + $0, _id_Structure1E_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1F_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $C, _id_Structure05_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $01, $88, $AB ; Kraid
    .byte $17, $07, $CD ; Enemy spawner: Geega
    .byte $FF

Room20_{AREA}: ; 04:A972
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($7 << 4) + $8, _id_Structure0C_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure21_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $D, _id_Structure05_{AREA}, $2
    .byte $FD
    .byte $27, $87, $CE ; Enemy spawner: Geega
    .byte $41, $80, $BC ; Sidehopper
    .byte $FF

Room21_{AREA}: ; 04:A990
    .byte $1
    .byte ($0 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($0 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($2 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($2 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($8 << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($B << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($B << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $0, _id_Structure1D_{AREA}, $1
    .byte ($C << 4) + $8, _id_Structure1D_{AREA}, $1
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $21, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room22_{AREA}: ; 04:A9BE
    .byte $3
    .byte ($0 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($0 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($1 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($8 << 4) + $C, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $0, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $4, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $8, _id_Structure13_{AREA}, $3
    .byte ($C << 4) + $C, _id_Structure13_{AREA}, $3
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room23_{AREA}: ; 04:A9FE
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure06_{AREA}, $0
    .byte ($1 << 4) + $6, _id_Structure0D_{AREA}, $0
    .byte ($2 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $4, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($4 << 4) + $B, _id_Structure0E_{AREA}, $0
    .byte ($5 << 4) + $F, _id_Structure03_{AREA}, $2
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($D << 4) + $4, _id_Structure00_{AREA}, $2
    .byte $FD
    .byte re_Door, $A0 | (0 << 4) | doorType_Blue
    .byte $01, $03, $38 ; Ripper
    .byte $FF

Room24_{AREA}: ; 04:AA33
    .byte $0
    .byte ($0 << 4) + $0, _id_Structure07_{AREA}, $0
    .byte ($0 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($1 << 4) + $9, _id_Structure11_{AREA}, $0
    .byte ($1 << 4) + $D, _id_Structure09_{AREA}, $1
    .byte ($3 << 4) + $2, _id_Structure08_{AREA}, $1
    .byte ($4 << 4) + $C, _id_Structure11_{AREA}, $0
    .byte ($5 << 4) + $0, _id_Structure03_{AREA}, $2
    .byte ($5 << 4) + $E, _id_Structure07_{AREA}, $0
    .byte ($8 << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $4, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $8, _id_Structure10_{AREA}, $0
    .byte ($8 << 4) + $C, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $0, _id_Structure10_{AREA}, $0
    .byte ($C << 4) + $C, _id_Structure10_{AREA}, $0
    .byte $FD
    .byte re_Door, $A0 | (1 << 4) | doorType_Blue
    .byte $41, $80, $75 ; Sidehopper
    .byte $51, $00, $7A ; Sidehopper
    .byte $01, $83, $45 ; Ripper
    .byte $FF
