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

Room00:
    .byte $02
    .byte $40, $01, $03
    .byte $48, $01, $03
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $FF

Room01:
    .byte $02
    .byte $07, $02, $02
    .byte $87, $02, $02
    .byte $FF

Room02:
    .byte $03
    .byte $00, $0C, $03
    .byte $08, $0C, $03
    .byte $0F, $09, $03
    .byte $5F, $04, $02
    .byte $62, $13, $02
    .byte $6A, $13, $02
    .byte $82, $0E, $02
    .byte $85, $12, $01
    .byte $8A, $0E, $02
    .byte $8D, $12, $01
    .byte $8F, $09, $03
    .byte $C4, $0F, $03
    .byte $C8, $0F, $03
    .byte $D3, $10, $03
    .byte $DB, $0A, $03
    .byte $E0, $0A, $03
    .byte $E8, $0A, $03
    .byte $FF

Room03:
    .byte $00
    .byte $00, $0C, $03
    .byte $08, $0C, $03
    .byte $62, $13, $02
    .byte $6A, $13, $02
    .byte $82, $0E, $02
    .byte $85, $12, $01
    .byte $8A, $0E, $02
    .byte $8D, $12, $01
    .byte $C4, $0F, $03
    .byte $C8, $0F, $03
    .byte $D0, $0D, $02
    .byte $D3, $10, $03
    .byte $DB, $0A, $03
    .byte $E2, $0A, $03
    .byte $EA, $0A, $03
    .byte $FF

Room04:
    .byte $03
    .byte $00, $09, $03
    .byte $01, $0A, $03
    .byte $03, $11, $03
    .byte $08, $0C, $03
    .byte $0E, $1C, $03
    .byte $52, $07, $01
    .byte $53, $08, $02
    .byte $6A, $13, $02
    .byte $80, $09, $03
    .byte $8A, $0E, $02
    .byte $8D, $12, $01
    .byte $91, $0B, $03
    .byte $CB, $1C, $03
    .byte $CC, $1C, $03
    .byte $D8, $0D, $02
    .byte $DB, $00, $02
    .byte $E0, $0A, $03
    .byte $FF

Room05:
    .byte $03
    .byte $00, $14, $03
    .byte $08, $14, $03
    .byte $50, $04, $02
    .byte $80, $14, $03
    .byte $88, $14, $03
    .byte $D0, $14, $03
    .byte $D8, $14, $03
    .byte $FF

Room06:
    .byte $03
    .byte $00, $14, $03
    .byte $08, $14, $03
    .byte $95, $14, $03
    .byte $D0, $14, $03
    .byte $D8, $14, $03
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $B3 ; Green metroid
    .byte $FF

Room07:
    .byte $03
    .byte $00, $16, $03
    .byte $08, $16, $03
    .byte $30, $15, $03
    .byte $38, $15, $03
    .byte $D0, $15, $03
    .byte $D8, $15, $03
    .byte $FD
    .byte $31, $01, $69 ; Green metroid
    .byte $41, $00, $B5 ; Red metroid
    .byte $FF

Room08:
    .byte $01
    .byte $00, $16, $03
    .byte $08, $16, $03
    .byte $30, $15, $03
    .byte $38, $15, $03
    .byte $D0, $17, $03
    .byte $D4, $00, $02
    .byte $D7, $17, $03
    .byte $DC, $17, $03
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $D4 ; Green metroid
    .byte $FF

Room09:
    .byte $01
    .byte $00, $16, $03
    .byte $08, $16, $03
    .byte $30, $15, $03
    .byte $38, $15, $03
    .byte $5F, $03, $02
    .byte $8C, $17, $03
    .byte $B8, $17, $03
    .byte $CC, $17, $03
    .byte $D0, $00, $02
    .byte $D2, $17, $03
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $FF

Room0A:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1A, $03
    .byte $04, $1B, $01
    .byte $09, $12, $01
    .byte $0E, $1A, $03
    .byte $0F, $19, $03
    .byte $34, $12, $01
    .byte $4B, $1B, $01
    .byte $50, $03, $02
    .byte $5E, $1A, $03
    .byte $80, $19, $03
    .byte $81, $1A, $03
    .byte $82, $1B, $01
    .byte $88, $18, $03
    .byte $8F, $19, $03
    .byte $B1, $18, $03
    .byte $B8, $18, $03
    .byte $FD
    .byte $02, $B0 ; Red door
    .byte $31, $01, $A5 ; Green metroid
    .byte $41, $00, $48 ; Red metroid
    .byte $51, $01, $6A ; Green metroid
    .byte $FF

Room0B:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1A, $03
    .byte $09, $12, $01
    .byte $0E, $1A, $03
    .byte $0F, $19, $03
    .byte $23, $12, $01
    .byte $4B, $12, $01
    .byte $51, $1A, $03
    .byte $5E, $1A, $03
    .byte $66, $1B, $01
    .byte $80, $19, $03
    .byte $82, $12, $01
    .byte $8F, $19, $03
    .byte $98, $12, $01
    .byte $A1, $1A, $03
    .byte $AE, $1A, $03
    .byte $CB, $1B, $01
    .byte $D5, $12, $01
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $21, $01, $D4 ; Green metroid
    .byte $FF

Room0C:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1A, $03
    .byte $02, $1E, $03
    .byte $0E, $1A, $03
    .byte $0F, $19, $03
    .byte $36, $1E, $03
    .byte $3E, $1C, $03
    .byte $51, $1A, $03
    .byte $5E, $1A, $03
    .byte $71, $1C, $03
    .byte $72, $1E, $03
    .byte $80, $19, $03
    .byte $8F, $19, $03
    .byte $A1, $1A, $03
    .byte $A6, $1E, $03
    .byte $AE, $1A, $03
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $51, $00, $CB ; Red metroid
    .byte $FF

Room0D:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $18, $03
    .byte $08, $18, $03
    .byte $0F, $19, $03
    .byte $11, $18, $03
    .byte $18, $18, $03
    .byte $50, $03, $02
    .byte $5E, $1A, $03
    .byte $80, $19, $03
    .byte $81, $1A, $03
    .byte $82, $1E, $03
    .byte $8F, $19, $03
    .byte $AE, $1A, $03
    .byte $B6, $1E, $03
    .byte $BE, $1C, $03
    .byte $D1, $1A, $03
    .byte $FD
    .byte $02, $B0 ; Red door
    .byte $FF

Room0E:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $18, $03
    .byte $08, $18, $03
    .byte $0F, $19, $03
    .byte $41, $1A, $03
    .byte $4E, $1A, $03
    .byte $80, $19, $03
    .byte $86, $1D, $03
    .byte $8F, $19, $03
    .byte $91, $1A, $03
    .byte $9E, $1A, $03
    .byte $BB, $1B, $01
    .byte $C3, $1B, $01
    .byte $E1, $1A, $03
    .byte $EE, $1A, $03
    .byte $FF

Room0F:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1A, $03
    .byte $0E, $1A, $03
    .byte $0F, $19, $03
    .byte $12, $12, $01
    .byte $28, $12, $01
    .byte $4C, $1B, $01
    .byte $51, $1A, $03
    .byte $55, $1B, $01
    .byte $5F, $03, $02
    .byte $80, $19, $03
    .byte $83, $1B, $01
    .byte $8B, $12, $01
    .byte $8E, $1A, $03
    .byte $8F, $19, $03
    .byte $A1, $1A, $03
    .byte $B1, $18, $03
    .byte $B8, $18, $03
    .byte $FF

Room10:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1A, $03
    .byte $0E, $1A, $03
    .byte $0F, $19, $03
    .byte $1A, $05, $01
    .byte $4D, $05, $01
    .byte $51, $1A, $03
    .byte $5E, $1A, $03
    .byte $80, $19, $03
    .byte $8A, $05, $01
    .byte $8F, $19, $03
    .byte $95, $05, $01
    .byte $A1, $1A, $03
    .byte $AE, $1A, $03
    .byte $CA, $05, $01
    .byte $E7, $05, $01
    .byte $FF

Room11:
    .byte $03
    .byte $00, $19, $03
    .byte $01, $1F, $01
    .byte $09, $1F, $01
    .byte $11, $1E, $03
    .byte $19, $1E, $03
    .byte $50, $03, $02
    .byte $80, $19, $03
    .byte $81, $1F, $01
    .byte $A1, $1E, $03
    .byte $B8, $1A, $03
    .byte $D1, $1F, $01
    .byte $D9, $1F, $01
    .byte $FD
    .byte $02, $B2 ; 10-missile door
    .byte $FF

Room12:
    .byte $01
    .byte $00, $1F, $01
    .byte $08, $1F, $01
    .byte $0F, $19, $03
    .byte $10, $1E, $03
    .byte $17, $1E, $03
    .byte $5F, $03, $02
    .byte $87, $1F, $01
    .byte $8F, $19, $03
    .byte $A7, $1A, $03
    .byte $C5, $1F, $01
    .byte $D0, $1F, $01
    .byte $D7, $1F, $01
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $FF

Room13:
    .byte $00
    .byte $00, $1F, $01
    .byte $08, $1F, $01
    .byte $10, $1E, $03
    .byte $18, $1E, $03
    .byte $D0, $00, $02
    .byte $D3, $1F, $01
    .byte $D8, $00, $02
    .byte $DC, $1F, $01
    .byte $FD
    .byte $01, $01, $45 ; Green metroid
    .byte $11, $00, $89 ; Red metroid
    .byte $FF

Room14:
    .byte $00
    .byte $00, $1F, $01
    .byte $08, $1F, $01
    .byte $10, $1E, $03
    .byte $18, $1E, $03
    .byte $94, $06, $03
    .byte $98, $06, $03
    .byte $9C, $06, $03
    .byte $D0, $1F, $01
    .byte $D3, $00, $02
    .byte $DB, $00, $02
    .byte $FD
    .byte $21, $00, $47 ; Red metroid
    .byte $31, $01, $6A ; Green metroid
    .byte $FF
