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

Room00_{AREA}:
    .byte $02
    .byte $40, $01, $03
    .byte $48, $01, $03
    .byte $50, $04, $02
    .byte $5F, $04, $02
    .byte $FF

Room01_{AREA}:
    .byte $02
    .byte $07, $02, $02
    .byte $87, $02, $02
    .byte $FF

Room02_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $04, $10, $00
    .byte $08, $10, $00
    .byte $0C, $10, $00
    .byte $40, $06, $00
    .byte $42, $08, $01
    .byte $4E, $06, $00
    .byte $6D, $09, $01
    .byte $75, $0C, $00
    .byte $7A, $0C, $00
    .byte $90, $06, $00
    .byte $92, $0C, $00
    .byte $96, $0D, $00
    .byte $9D, $0C, $00
    .byte $9E, $06, $00
    .byte $E0, $06, $00
    .byte $E1, $0D, $00
    .byte $EB, $0D, $00
    .byte $EE, $06, $00
    .byte $FF

Room03_{AREA}:
    .byte $00
    .byte $00, $06, $00
    .byte $0A, $0D, $00
    .byte $0E, $06, $00
    .byte $22, $08, $01
    .byte $2D, $09, $01
    .byte $45, $0D, $00
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $10, $00
    .byte $8A, $06, $00
    .byte $8C, $10, $00
    .byte $A4, $08, $01
    .byte $C0, $10, $00
    .byte $C9, $0D, $00
    .byte $CC, $10, $00
    .byte $DB, $09, $01
    .byte $E1, $10, $00
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $02, $B1 ; Blue door
    .byte $31, $85, $37 ; Zeela
    .byte $FF

Room04_{AREA}:
    .byte $00
    .byte $00, $06, $00
    .byte $07, $06, $00
    .byte $0B, $10, $00
    .byte $0E, $06, $00
    .byte $22, $08, $01
    .byte $2A, $09, $01
    .byte $35, $0D, $00
    .byte $50, $03, $02
    .byte $57, $06, $00
    .byte $5F, $03, $02
    .byte $80, $0D, $00
    .byte $8C, $0D, $00
    .byte $8E, $06, $00
    .byte $90, $06, $00
    .byte $92, $08, $01
    .byte $BE, $06, $00
    .byte $CD, $09, $01
    .byte $D0, $06, $00
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $02, $B1 ; Blue door
    .byte $41, $85, $25 ; Zeela
    .byte $21, $83, $C8 ; Ripper
    .byte $FF

Room05_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $0C, $10, $00
    .byte $14, $08, $01
    .byte $40, $10, $00
    .byte $4C, $10, $00
    .byte $6B, $09, $01
    .byte $7C, $10, $00
    .byte $80, $10, $00
    .byte $94, $08, $01
    .byte $BC, $10, $00
    .byte $C0, $10, $00
    .byte $DB, $09, $01
    .byte $FD
    .byte $51, $83, $57 ; Ripper
    .byte $01, $03, $95 ; Ripper
    .byte $11, $03, $CA ; Ripper
    .byte $FF

Room06_{AREA}:
    .byte $00
    .byte $00, $06, $00
    .byte $0E, $06, $00
    .byte $12, $08, $01
    .byte $17, $0E, $00
    .byte $1A, $0D, $00
    .byte $27, $0C, $00
    .byte $31, $0E, $00
    .byte $36, $11, $00
    .byte $39, $07, $00
    .byte $50, $03, $02
    .byte $59, $0E, $00
    .byte $5F, $03, $02
    .byte $80, $10, $00
    .byte $84, $10, $00
    .byte $88, $10, $00
    .byte $8C, $10, $00
    .byte $C0, $10, $00
    .byte $C4, $10, $00
    .byte $C8, $10, $00
    .byte $CC, $10, $00
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $01, $85, $2A ; Zeela
    .byte $51, $85, $26 ; Zeela
    .byte $FF

Room07_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $0A, $10, $00
    .byte $0E, $07, $00
    .byte $24, $08, $01
    .byte $27, $0E, $00
    .byte $40, $07, $00
    .byte $5F, $03, $02
    .byte $62, $10, $00
    .byte $8B, $0E, $00
    .byte $8E, $07, $00
    .byte $90, $07, $00
    .byte $9D, $09, $01
    .byte $B0, $07, $00
    .byte $B2, $10, $00
    .byte $B6, $0D, $00
    .byte $CE, $07, $00
    .byte $D6, $08, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $85, $17 ; Zeela
    .byte $21, $85, $A8 ; Zeela
    .byte $31, $03, $87 ; Ripper
    .byte $FF

Room08_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $03, $10, $00
    .byte $0A, $10, $00
    .byte $0C, $10, $00
    .byte $29, $09, $01
    .byte $35, $0E, $00
    .byte $40, $10, $00
    .byte $44, $08, $01
    .byte $4C, $10, $00
    .byte $79, $0E, $00
    .byte $80, $10, $00
    .byte $8C, $10, $00
    .byte $AB, $09, $01
    .byte $B0, $10, $00
    .byte $B4, $0D, $00
    .byte $CC, $10, $00
    .byte $D4, $08, $01
    .byte $FD
    .byte $11, $85, $6A ; Zeela
    .byte $41, $85, $A6 ; Zeela
    .byte $FF

Room09_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0D, $09, $01
    .byte $0E, $07, $00
    .byte $42, $08, $01
    .byte $50, $07, $00
    .byte $5F, $03, $02
    .byte $8B, $0E, $00
    .byte $8E, $07, $00
    .byte $9D, $09, $01
    .byte $A0, $07, $00
    .byte $A6, $0E, $00
    .byte $DE, $07, $00
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $21, $85, $97 ; Zeela
    .byte $31, $03, $83 ; Ripper
    .byte $FF

Room0A_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0E, $07, $00
    .byte $12, $08, $01
    .byte $50, $07, $00
    .byte $5F, $03, $02
    .byte $72, $08, $01
    .byte $87, $0E, $00
    .byte $8B, $0E, $00
    .byte $8E, $07, $00
    .byte $A0, $10, $00
    .byte $AD, $09, $01
    .byte $CC, $10, $00
    .byte $D4, $00, $02
    .byte $E0, $10, $00
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $85, $78 ; Zeela
    .byte $11, $03, $28 ; Ripper
    .byte $FF

Room0B_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $04, $10, $00
    .byte $08, $10, $00
    .byte $0C, $10, $00
    .byte $40, $10, $00
    .byte $44, $10, $00
    .byte $48, $10, $00
    .byte $4C, $10, $00
    .byte $80, $10, $00
    .byte $84, $10, $00
    .byte $88, $10, $00
    .byte $8C, $10, $00
    .byte $B0, $10, $00
    .byte $B4, $10, $00
    .byte $B8, $10, $00
    .byte $BC, $10, $00
    .byte $FF

Room0C_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0A, $11, $00
    .byte $0E, $07, $00
    .byte $25, $11, $00
    .byte $32, $08, $01
    .byte $49, $11, $00
    .byte $50, $03, $02
    .byte $5D, $09, $01
    .byte $5E, $07, $00
    .byte $80, $07, $00
    .byte $82, $11, $00
    .byte $86, $11, $00
    .byte $9C, $11, $00
    .byte $AE, $07, $00
    .byte $BD, $09, $01
    .byte $C2, $08, $01
    .byte $C8, $11, $00
    .byte $D0, $07, $00
    .byte $D4, $11, $00
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $51, $85, $39 ; Zeela
    .byte $41, $05, $C4 ; Zeela
    .byte $FF

Room0D_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0A, $0F, $02
    .byte $0E, $07, $00
    .byte $1D, $09, $01
    .byte $4A, $0F, $02
    .byte $50, $03, $02
    .byte $5E, $07, $00
    .byte $80, $07, $00
    .byte $86, $0F, $02
    .byte $8A, $0F, $02
    .byte $8C, $11, $00
    .byte $9D, $09, $01
    .byte $A2, $11, $00
    .byte $AE, $07, $00
    .byte $C2, $08, $01
    .byte $CA, $0F, $02
    .byte $D0, $07, $00
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $FF

Room0E_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0A, $0F, $02
    .byte $0E, $07, $00
    .byte $2D, $09, $01
    .byte $32, $08, $01
    .byte $4A, $0F, $02
    .byte $50, $07, $00
    .byte $5E, $07, $00
    .byte $78, $11, $00
    .byte $8A, $0F, $02
    .byte $92, $08, $01
    .byte $A0, $07, $00
    .byte $AE, $07, $00
    .byte $BD, $09, $01
    .byte $CA, $0F, $02
    .byte $FF

Room0F_{AREA}:
    .byte $01
    .byte $00, $1D, $01
    .byte $08, $1D, $01
    .byte $1E, $1F, $01
    .byte $5F, $03, $02
    .byte $8C, $1F, $01
    .byte $9B, $09, $01
    .byte $C9, $1D, $01
    .byte $D0, $1F, $01
    .byte $D4, $00, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $41, $84, $31 ; Skree
    .byte $57, $87, $D5 ; Geega
    .byte $07, $87, $D8 ; Geega
    .byte $FF

Room10_{AREA}:
    .byte $00
    .byte $00, $12, $00
    .byte $08, $12, $00
    .byte $57, $0C, $00
    .byte $75, $0C, $00
    .byte $79, $0C, $00
    .byte $93, $0C, $00
    .byte $9B, $0C, $00
    .byte $B1, $0C, $00
    .byte $BD, $0C, $00
    .byte $CF, $0C, $00
    .byte $D0, $00, $02
    .byte $D8, $00, $02
    .byte $FD
    .byte $41, $81, $2D ; Ceiling sidehopper
    .byte $27, $07, $D4 ; Geega
    .byte $17, $87, $DA ; Geega
    .byte $FF

Room11_unused: ; Not used
    .byte $00
    .byte $00, $07, $00
    .byte $02, $08, $01
    .byte $0E, $07, $00
    .byte $2D, $09, $01
    .byte $32, $0E, $00
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $10, $00
    .byte $84, $10, $00
    .byte $88, $10, $00
    .byte $8C, $10, $00
    .byte $C0, $10, $00
    .byte $C4, $10, $00
    .byte $C8, $10, $00
    .byte $CC, $10, $00
    .byte $FF

Room11_{AREA}:
Room12_{AREA}:
    .byte $00
    .byte $00, $12, $00
    .byte $08, $12, $00
    .byte $24, $11, $00
    .byte $37, $0C, $00
    .byte $45, $0C, $00
    .byte $48, $0E, $00
    .byte $57, $0C, $00
    .byte $63, $0C, $00
    .byte $65, $0C, $00
    .byte $9B, $0E, $00
    .byte $A2, $11, $00
    .byte $C0, $13, $03
    .byte $C5, $0E, $00
    .byte $C9, $0C, $00
    .byte $CC, $13, $03
    .byte $D4, $00, $02
    .byte $FD
    .byte $21, $85, $39 ; Zeela
    .byte $31, $85, $8C ; Zeela
    .byte $41, $85, $B6 ; Zeela
    .byte $FF

Room13_{AREA}:
    .byte $03
    .byte $00, $15, $03
    .byte $08, $15, $03
    .byte $10, $16, $03
    .byte $50, $03, $02
    .byte $68, $14, $03
    .byte $80, $16, $03
    .byte $93, $14, $03
    .byte $AB, $14, $03
    .byte $BF, $14, $03
    .byte $C0, $16, $03
    .byte $D2, $00, $02
    .byte $DA, $00, $02
    .byte $FD
    .byte $02, $B0 ; Red door
    .byte $21, $81, $27 ; Ceiling sidehopper
    .byte $41, $85, $84 ; Zeela
    .byte $37, $87, $DD ; Geega
    .byte $FF

Room14_{AREA}:
    .byte $03
    .byte $00, $15, $03
    .byte $08, $15, $03
    .byte $8A, $14, $03
    .byte $A4, $14, $03
    .byte $AF, $14, $03
    .byte $D0, $00, $02
    .byte $D8, $00, $02
    .byte $FD
    .byte $37, $87, $D1 ; Geega
    .byte $47, $87, $D7 ; Geega
    .byte $57, $87, $DC ; Geega
    .byte $01, $85, $95 ; Zeela
    .byte $FF

Room15_{AREA}:
    .byte $01
    .byte $00, $1D, $01
    .byte $08, $1D, $01
    .byte $20, $1D, $01
    .byte $28, $1D, $01
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $1D, $01
    .byte $87, $20, $01
    .byte $88, $1D, $01
    .byte $97, $21, $01
    .byte $B0, $1D, $01
    .byte $B7, $21, $01
    .byte $B8, $1D, $01
    .byte $C0, $1D, $01
    .byte $C7, $21, $01
    .byte $C8, $1D, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $01, $80, $68 ; Sidehopper
    .byte $FF

Room16_{AREA}:
    .byte $03
    .byte $00, $15, $03
    .byte $08, $15, $03
    .byte $1E, $16, $03
    .byte $5F, $03, $02
    .byte $61, $14, $03
    .byte $85, $14, $03
    .byte $8C, $15, $03
    .byte $8E, $16, $03
    .byte $BA, $14, $03
    .byte $CE, $16, $03
    .byte $D0, $00, $02
    .byte $D6, $00, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $07, $87, $D3 ; Geega
    .byte $17, $07, $D8 ; Geega
    .byte $21, $81, $27 ; Ceiling sidehopper
    .byte $FF

Room17_{AREA}:
    .byte $01
    .byte $00, $17, $03
    .byte $08, $17, $03
    .byte $10, $19, $03
    .byte $24, $18, $03
    .byte $36, $0C, $00
    .byte $3B, $0C, $00
    .byte $50, $03, $02
    .byte $80, $19, $03
    .byte $AE, $0C, $00
    .byte $C0, $19, $03
    .byte $D4, $18, $03
    .byte $D8, $00, $02
    .byte $D9, $18, $03
    .byte $DB, $05, $02
    .byte $DF, $00, $02
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $41, $80, $C5 ; Sidehopper
    .byte $57, $87, $DC ; Geega
    .byte $31, $04, $48 ; Skree
    .byte $FF

Room18_{AREA}:
    .byte $01
    .byte $00, $17, $03
    .byte $08, $17, $03
    .byte $1C, $19, $03
    .byte $20, $19, $03
    .byte $5F, $03, $02
    .byte $8C, $19, $03
    .byte $CC, $19, $03
    .byte $D0, $18, $03
    .byte $D3, $00, $02
    .byte $D4, $18, $03
    .byte $D5, $05, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $37, $87, $D6 ; Geega
    .byte $21, $84, $62 ; Skree
    .byte $11, $84, $25 ; Skree
    .byte $01, $84, $29 ; Skree
    .byte $FF

Room19_{AREA}:
    .byte $03
    .byte $00, $19, $03
    .byte $04, $19, $03
    .byte $08, $19, $03
    .byte $0C, $19, $03
    .byte $40, $19, $03
    .byte $44, $19, $03
    .byte $48, $19, $03
    .byte $4C, $19, $03
    .byte $70, $19, $03
    .byte $74, $19, $03
    .byte $78, $19, $03
    .byte $7C, $19, $03
    .byte $90, $1A, $03
    .byte $94, $1A, $03
    .byte $98, $1A, $03
    .byte $9C, $1A, $03
    .byte $B0, $1A, $03
    .byte $B8, $1A, $03
    .byte $C0, $19, $03
    .byte $C4, $19, $03
    .byte $C8, $19, $03
    .byte $CC, $19, $03
    .byte $FF

Room1A_{AREA}:
    .byte $03
    .byte $00, $13, $03
    .byte $04, $13, $03
    .byte $08, $13, $03
    .byte $0C, $13, $03
    .byte $10, $13, $03
    .byte $14, $13, $03
    .byte $18, $13, $03
    .byte $1C, $13, $03
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $13, $03
    .byte $81, $1B, $03
    .byte $84, $13, $03
    .byte $88, $13, $03
    .byte $8C, $13, $03
    .byte $91, $1C, $03
    .byte $C0, $13, $03
    .byte $C1, $1C, $03
    .byte $C4, $13, $03
    .byte $C8, $13, $03
    .byte $CC, $13, $03
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $02, $B1 ; Blue door
    .byte $31, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room1B_{AREA}:
    .byte $00
    .byte $00, $1F, $01
    .byte $04, $1D, $01
    .byte $07, $21, $01
    .byte $0C, $1F, $01
    .byte $10, $0C, $00
    .byte $14, $1F, $01
    .byte $17, $21, $01
    .byte $18, $1F, $01
    .byte $1F, $0C, $00
    .byte $25, $0B, $02
    .byte $2A, $0B, $02
    .byte $41, $22, $00
    .byte $4C, $23, $00
    .byte $50, $03, $02
    .byte $54, $22, $00
    .byte $59, $23, $00
    .byte $5F, $03, $02
    .byte $80, $07, $00
    .byte $82, $14, $03
    .byte $84, $14, $03
    .byte $86, $14, $03
    .byte $88, $14, $03
    .byte $8A, $14, $03
    .byte $8C, $14, $03
    .byte $8E, $07, $00
    .byte $92, $16, $03
    .byte $9C, $16, $03
    .byte $D0, $12, $00
    .byte $D4, $00, $02
    .byte $DC, $12, $00
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B0 ; Red door
    .byte $27, $07, $D9 ; Geega
    .byte $FF

Room1C_{AREA}:
    .byte $03
    .byte $00, $17, $03
    .byte $08, $17, $03
    .byte $B0, $18, $03
    .byte $B6, $05, $02
    .byte $B8, $18, $03
    .byte $D0, $18, $03
    .byte $D8, $18, $03
    .byte $FD
    .byte $37, $87, $B7 ; Geega
    .byte $01, $80, $45 ; Sidehopper
    .byte $11, $00, $3B ; Sidehopper
    .byte $21, $81, $9A ; Ceiling sidehopper
    .byte $FF

Room1D_{AREA}:
    .byte $01
    .byte $00, $15, $03
    .byte $08, $15, $03
    .byte $10, $24, $03
    .byte $13, $0B, $02
    .byte $18, $24, $03
    .byte $1C, $0B, $02
    .byte $1F, $25, $03
    .byte $20, $25, $03
    .byte $22, $22, $00
    .byte $2B, $23, $00
    .byte $5F, $03, $02
    .byte $60, $25, $03
    .byte $8E, $25, $03
    .byte $8F, $13, $03
    .byte $A0, $25, $03
    .byte $A2, $11, $00
    .byte $AC, $11, $00
    .byte $B3, $12, $00
    .byte $BB, $0C, $00
    .byte $BE, $1B, $03
    .byte $C3, $24, $03
    .byte $CE, $12, $00
    .byte $D1, $00, $02
    .byte $D3, $24, $03
    .byte $DC, $00, $02
    .byte $DE, $12, $00
    .byte $E0, $25, $03
    .byte $E3, $15, $03
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $01, $48, $95 ; Kraid
    .byte $FF

Room1E_{AREA}:
    .byte $01
    .byte $00, $1E, $01
    .byte $02, $1D, $01
    .byte $08, $1D, $01
    .byte $1F, $1F, $01
    .byte $40, $1E, $01
    .byte $5F, $03, $02
    .byte $77, $0C, $00
    .byte $80, $1E, $01
    .byte $87, $1E, $01
    .byte $8D, $1F, $01
    .byte $C0, $1D, $01
    .byte $C8, $1D, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $11, $81, $35 ; Ceiling sidehopper
    .byte $FF

Room1F_{AREA}:
    .byte $01
    .byte $00, $1D, $01
    .byte $08, $1D, $01
    .byte $10, $1E, $01
    .byte $50, $03, $02
    .byte $80, $1F, $01
    .byte $C0, $1D, $01
    .byte $C8, $1D, $01
    .byte $CC, $05, $02
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $01, $88, $AB ; Kraid
    .byte $17, $07, $CD ; Geega
    .byte $FF

Room20_{AREA}:
    .byte $01
    .byte $00, $1D, $01
    .byte $08, $1D, $01
    .byte $78, $0C, $00
    .byte $88, $21, $01
    .byte $C0, $1D, $01
    .byte $C8, $1D, $01
    .byte $CD, $05, $02
    .byte $FD
    .byte $27, $87, $CE ; Geega
    .byte $41, $80, $BC ; Sidehopper
    .byte $FF

Room21_{AREA}:
    .byte $01
    .byte $00, $1D, $01
    .byte $08, $1D, $01
    .byte $20, $1D, $01
    .byte $28, $1D, $01
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $1D, $01
    .byte $88, $1D, $01
    .byte $B0, $1D, $01
    .byte $B8, $1D, $01
    .byte $C0, $1D, $01
    .byte $C8, $1D, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $21, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room22_{AREA}:
    .byte $03
    .byte $00, $13, $03
    .byte $04, $13, $03
    .byte $08, $13, $03
    .byte $0C, $13, $03
    .byte $10, $13, $03
    .byte $14, $13, $03
    .byte $18, $13, $03
    .byte $1C, $13, $03
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $13, $03
    .byte $84, $13, $03
    .byte $88, $13, $03
    .byte $8C, $13, $03
    .byte $C0, $13, $03
    .byte $C4, $13, $03
    .byte $C8, $13, $03
    .byte $CC, $13, $03
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $41, $81, $68 ; Ceiling sidehopper
    .byte $FF

Room23_{AREA}:
    .byte $00
    .byte $00, $10, $00
    .byte $0E, $06, $00
    .byte $16, $0D, $00
    .byte $2D, $09, $01
    .byte $34, $08, $01
    .byte $40, $10, $00
    .byte $4B, $0E, $00
    .byte $5F, $03, $02
    .byte $80, $10, $00
    .byte $84, $10, $00
    .byte $88, $10, $00
    .byte $8C, $10, $00
    .byte $C0, $10, $00
    .byte $CC, $10, $00
    .byte $D4, $00, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $03, $38 ; Ripper
    .byte $FF

Room24_{AREA}:
    .byte $00
    .byte $00, $07, $00
    .byte $0E, $07, $00
    .byte $19, $11, $00
    .byte $1D, $09, $01
    .byte $32, $08, $01
    .byte $4C, $11, $00
    .byte $50, $03, $02
    .byte $5E, $07, $00
    .byte $80, $10, $00
    .byte $84, $10, $00
    .byte $88, $10, $00
    .byte $8C, $10, $00
    .byte $C0, $10, $00
    .byte $CC, $10, $00
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $41, $80, $75 ; Sidehopper
    .byte $51, $00, $7A ; Sidehopper
    .byte $01, $83, $45 ; Ripper
    .byte $FF
