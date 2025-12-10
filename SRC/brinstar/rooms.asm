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

Room00_BANK{BANK}:
    .byte $02
    .byte $40, $01, $02
    .byte $48, $01, $02
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $FF

Room01_BANK{BANK}:
    .byte $02
    .byte $07, $02, $02
    .byte $87, $02, $02
    .byte $FF

Room02_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $0E, $0B, $03
    .byte $50, $0B, $03
    .byte $5E, $0B, $03
    .byte $A0, $0B, $03
    .byte $AE, $0B, $03
    .byte $FD
    .byte $01, $03, $42 ; Ripper
    .byte $11, $83, $8A ; Ripper
    .byte $21, $03, $B5 ; Ripper
    .byte $31, $02, $59 ; Waver
    .byte $41, $02, $A3 ; Waver
    .byte $FF

Room03_BANK{BANK}:
    .byte $02
    .byte $00, $0B, $03
    .byte $02, $09, $03
    .byte $0E, $0B, $03
    .byte $50, $0B, $03
    .byte $56, $0A, $03
    .byte $5F, $03, $02
    .byte $8B, $0A, $03
    .byte $8E, $0B, $03
    .byte $92, $0A, $03
    .byte $A0, $0B, $03
    .byte $C7, $09, $03
    .byte $DE, $0B, $03
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $85, $47 ; Zoomer
    .byte $11, $05, $BA ; Zoomer
    .byte $21, $03, $08 ; Ripper
    .byte $31, $83, $53 ; Ripper
    .byte $41, $83, $97 ; Ripper
    .byte $51, $03, $C5 ; Ripper
    .byte $FF

Room04_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $04, $0A, $03
    .byte $0E, $0B, $03
    .byte $47, $09, $03
    .byte $50, $03, $02
    .byte $5E, $0B, $03
    .byte $80, $0B, $03
    .byte $82, $0A, $03
    .byte $9C, $0A, $03
    .byte $AE, $0B, $03
    .byte $B6, $0A, $03
    .byte $C0, $0B, $03
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $41, $03, $45 ; Ripper
    .byte $51, $03, $BB ; Ripper
    .byte $31, $05, $39 ; Zoomer
    .byte $FF

Room05_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $0E, $0B, $03
    .byte $15, $09, $03
    .byte $50, $03, $02
    .byte $57, $0A, $03
    .byte $5F, $03, $02
    .byte $80, $0B, $03
    .byte $82, $0A, $03
    .byte $8B, $0A, $03
    .byte $8E, $0B, $03
    .byte $B0, $0B, $03
    .byte $C6, $09, $03
    .byte $CE, $0B, $03
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $01, $83, $43 ; Ripper
    .byte $31, $85, $48 ; Zoomer
    .byte $51, $05, $B7 ; Zoomer
    .byte $FF

Room06_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $0E, $0B, $03
    .byte $12, $0A, $03
    .byte $37, $0A, $03
    .byte $50, $0B, $03
    .byte $5E, $0B, $03
    .byte $73, $0A, $03
    .byte $8A, $0A, $03
    .byte $A0, $0B, $03
    .byte $AE, $0B, $03
    .byte $B6, $09, $03
    .byte $FD
    .byte $01, $03, $B3 ; Ripper
    .byte $11, $03, $3C ; Ripper
    .byte $21, $05, $A8 ; Zoomer
    .byte $31, $05, $64 ; Zoomer
    .byte $51, $85, $7B ; Zoomer
    .byte $41, $05, $28 ; Zoomer
    .byte $FF

Room07_BANK{BANK}:
    .byte $03
    .byte $00, $0D, $03
    .byte $08, $0D, $03
    .byte $54, $06, $03
    .byte $5A, $06, $03
    .byte $67, $07, $03
    .byte $A0, $0B, $03
    .byte $AE, $0B, $03
    .byte $C2, $06, $03
    .byte $CD, $06, $03
    .byte $D2, $00, $02
    .byte $D6, $00, $02
    .byte $FD
    .byte $51, $05, $B2 ; Zoomer
    .byte $41, $05, $BD ; Zoomer
    .byte $31, $05, $67 ; Zoomer
    .byte $FF

Room08_BANK{BANK}:
    .byte $03
    .byte $00, $1E, $03
    .byte $04, $1E, $03
    .byte $08, $1E, $03
    .byte $0C, $1E, $03
    .byte $38, $1E, $03
    .byte $40, $1E, $03
    .byte $44, $1E, $03
    .byte $4C, $1E, $03
    .byte $74, $1E, $03
    .byte $78, $1E, $03
    .byte $80, $1E, $03
    .byte $8C, $1E, $03
    .byte $B0, $1E, $03
    .byte $B4, $1E, $03
    .byte $B8, $1E, $03
    .byte $CC, $1E, $03
    .byte $FF

Room09_BANK{BANK}:
    .byte $03
    .byte $00, $11, $01
    .byte $08, $11, $01
    .byte $35, $1D, $03
    .byte $3B, $1D, $03
    .byte $55, $0B, $03
    .byte $5A, $0B, $03
    .byte $C5, $16, $00
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $51, $05, $25 ; Zoomer
    .byte $41, $05, $2B ; Zoomer
    .byte $FF

Room0A_BANK{BANK}:
    .byte $00
    .byte $00, $14, $00
    .byte $08, $14, $00
    .byte $0F, $15, $00
    .byte $10, $15, $00
    .byte $14, $15, $00
    .byte $25, $08, $03
    .byte $50, $14, $00
    .byte $58, $0C, $00
    .byte $5F, $04, $02
    .byte $60, $14, $00
    .byte $70, $13, $00
    .byte $80, $14, $00
    .byte $88, $14, $00
    .byte $90, $16, $00
    .byte $99, $16, $00
    .byte $B3, $15, $00
    .byte $BC, $15, $00
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $FF

Room0B_BANK{BANK}:
    .byte $00
    .byte $00, $15, $00
    .byte $01, $16, $00
    .byte $08, $16, $00
    .byte $0F, $15, $00
    .byte $4F, $15, $00
    .byte $50, $04, $02
    .byte $80, $16, $00
    .byte $87, $02, $02
    .byte $89, $16, $00
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $FF

Room0C_BANK{BANK}:
    .byte $02
    .byte $00, $1B, $02
    .byte $08, $1B, $02
    .byte $10, $1A, $02
    .byte $50, $03, $02
    .byte $80, $1A, $02
    .byte $82, $19, $02
    .byte $BC, $19, $02
    .byte $C0, $1A, $02
    .byte $C6, $1B, $02
    .byte $D1, $00, $02
    .byte $D9, $00, $02
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $51, $02, $5A ; Waver
    .byte $31, $02, $AA ; Waver
    .byte $FF

Room0D_BANK{BANK}:
    .byte $02
    .byte $00, $1B, $02
    .byte $08, $1B, $02
    .byte $1E, $1A, $02
    .byte $5F, $03, $02
    .byte $8C, $19, $02
    .byte $8E, $1A, $02
    .byte $B7, $1A, $02
    .byte $C2, $1A, $02
    .byte $CE, $1A, $02
    .byte $D0, $00, $02
    .byte $D7, $00, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $31, $05, $B3 ; Zoomer
    .byte $51, $02, $44 ; Waver
    .byte $FF

Room0E_BANK{BANK}:
    .byte $02
    .byte $00, $1B, $02
    .byte $08, $1B, $02
    .byte $AC, $19, $02
    .byte $B4, $19, $02
    .byte $B8, $1A, $02
    .byte $D0, $00, $02
    .byte $D8, $00, $02
    .byte $FD
    .byte $01, $82, $28 ; Waver
    .byte $11, $05, $A5 ; Zoomer
    .byte $21, $02, $8B ; Waver
    .byte $31, $02, $BD ; Waver
    .byte $FF

Room0F_BANK{BANK}:
    .byte $03
    .byte $00, $1B, $02
    .byte $08, $1B, $02
    .byte $59, $06, $03
    .byte $92, $19, $02
    .byte $AC, $19, $02
    .byte $BB, $19, $02
    .byte $C0, $06, $03
    .byte $D0, $00, $02
    .byte $D8, $00, $02
    .byte $FD
    .byte $01, $02, $3B ; Waver
    .byte $11, $02, $B8 ; Waver
    .byte $51, $85, $84 ; Zoomer
    .byte $41, $05, $49 ; Zoomer
    .byte $FF

Room10_BANK{BANK}:
    .byte $02
    .byte $00, $17, $02
    .byte $08, $17, $02
    .byte $10, $17, $02
    .byte $18, $17, $02
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $80, $1A, $02
    .byte $82, $19, $02
    .byte $86, $2E, $02
    .byte $87, $1B, $02
    .byte $8E, $1A, $02
    .byte $C0, $1A, $02
    .byte $CE, $1A, $02
    .byte $D2, $12, $02
    .byte $D8, $12, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $01, $02, $5C ; Waver
    .byte $11, $02, $A7 ; Waver
    .byte $FF

Room11_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $02, $06, $03
    .byte $0E, $0B, $03
    .byte $50, $0B, $03
    .byte $52, $06, $03
    .byte $5E, $0B, $03
    .byte $A0, $0B, $03
    .byte $A2, $06, $03
    .byte $AE, $0B, $03
    .byte $FD
    .byte $01, $83, $DD ; Ripper
    .byte $11, $03, $35 ; Ripper
    .byte $21, $02, $7D ; Waver
    .byte $FF

Room12_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $02, $11, $01
    .byte $0A, $11, $01
    .byte $50, $03, $02
    .byte $80, $0B, $03
    .byte $82, $0A, $03
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $01, $05, $C7 ; Zoomer
    .byte $11, $05, $CB ; Zoomer
    .byte $51, $04, $3A ; Skree
    .byte $41, $04, $29 ; Skree
    .byte $31, $04, $1E ; Skree
    .byte $FF

Room13_BANK{BANK}:
    .byte $03
    .byte $00, $11, $01
    .byte $07, $10, $03
    .byte $0E, $0B, $03
    .byte $5F, $03, $02
    .byte $8A, $09, $03
    .byte $8E, $0B, $03
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $05, $7B ; Zoomer
    .byte $11, $05, $C8 ; Zoomer
    .byte $FF

Room14_BANK{BANK}:
    .byte $01
    .byte $00, $11, $01
    .byte $08, $11, $01
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $51, $04, $14 ; Skree
    .byte $21, $04, $38 ; Skree
    .byte $41, $04, $2E ; Skree
    .byte $FF

Room15_BANK{BANK}:
    .byte $03
    .byte $00, $10, $03
    .byte $08, $10, $03
    .byte $90, $1F, $01
    .byte $96, $1F, $01
    .byte $AA, $05, $03
    .byte $AC, $1F, $01
    .byte $BA, $10, $03
    .byte $C4, $05, $03
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $51, $05, $89 ; Zoomer
    .byte $37, $87, $AB ; Zeb
    .byte $21, $06, $23 ; Rio
    .byte $17, $07, $C5 ; Zeb
    .byte $FF

Room16_BANK{BANK}:
    .byte $01
    .byte $00, $11, $01
    .byte $08, $11, $01
    .byte $B0, $1F, $01
    .byte $B6, $05, $03
    .byte $B8, $05, $03
    .byte $BC, $1F, $01
    .byte $C6, $1F, $01
    .byte $D4, $00, $02
    .byte $FD
    .byte $07, $07, $B7 ; Zeb
    .byte $47, $87, $B9 ; Zeb
    .byte $FF

Room17_BANK{BANK}:
    .byte $03
    .byte $00, $11, $01
    .byte $08, $10, $03
    .byte $4A, $1E, $03
    .byte $6B, $1E, $03
    .byte $8C, $1E, $03
    .byte $A6, $15, $00
    .byte $B3, $1D, $03
    .byte $B9, $1D, $03
    .byte $C3, $0C, $00
    .byte $C8, $0C, $00
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $41, $05, $B4 ; Zoomer
    .byte $FF

Room18_BANK{BANK}:
    .byte $01
    .byte $00, $0B, $03
    .byte $01, $11, $01
    .byte $09, $11, $01
    .byte $0E, $0B, $03
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $64, $0D, $03
    .byte $66, $20, $01
    .byte $80, $1F, $01
    .byte $84, $20, $01
    .byte $88, $20, $01
    .byte $8C, $1E, $03
    .byte $A6, $20, $01
    .byte $B0, $0B, $03
    .byte $BE, $0B, $03
    .byte $E6, $20, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $31, $05, $56 ; Zoomer
    .byte $01, $85, $5A ; Zoomer
    .byte $21, $05, $D9 ; Zoomer
    .byte $FF

Room19_BANK{BANK}:
    .byte $01
    .byte $00, $10, $03
    .byte $04, $1F, $01
    .byte $08, $1F, $01
    .byte $0C, $11, $01
    .byte $12, $31, $03
    .byte $44, $1F, $01
    .byte $48, $1F, $01
    .byte $84, $1F, $01
    .byte $88, $1F, $01
    .byte $D0, $1F, $01
    .byte $D4, $1F, $01
    .byte $D8, $10, $03
    .byte $FD
    .byte $51, $05, $C0 ; Zoomer
    .byte $41, $05, $CA ; Zoomer
    .byte $31, $06, $3C ; Rio
    .byte $FF

Room1A_BANK{BANK}:
    .byte $02
    .byte $00, $28, $02
    .byte $01, $2D, $02
    .byte $09, $2D, $02
    .byte $50, $04, $02
    .byte $80, $28, $02
    .byte $81, $14, $00
    .byte $95, $15, $00
    .byte $D0, $2D, $02
    .byte $D8, $2D, $02
    .byte $FD
    .byte $02, $B0 ; Red door
    .byte $01, $05, $C7 ; Zoomer
    .byte $11, $85, $CA ; Zoomer
    .byte $FF

Room1B_BANK{BANK}:
    .byte $00
    .byte $00, $14, $00
    .byte $04, $15, $00
    .byte $08, $14, $00
    .byte $0A, $15, $00
    .byte $97, $06, $03
    .byte $A0, $0B, $03
    .byte $A6, $15, $00
    .byte $A8, $15, $00
    .byte $AE, $0B, $03
    .byte $B4, $06, $03
    .byte $BA, $06, $03
    .byte $C2, $06, $03
    .byte $D2, $00, $02
    .byte $D6, $00, $02
    .byte $FD
    .byte $41, $05, $AA ; Zoomer
    .byte $21, $06, $17 ; Rio
    .byte $11, $05, $A4 ; Zoomer
    .byte $FF

Room1C_BANK{BANK}:
    .byte $00
    .byte $00, $15, $00
    .byte $01, $0D, $03
    .byte $09, $0E, $01
    .byte $2A, $23, $01
    .byte $37, $22, $03
    .byte $4D, $0E, $01
    .byte $50, $03, $02
    .byte $6A, $16, $00
    .byte $6D, $0E, $01
    .byte $80, $14, $00
    .byte $87, $02, $02
    .byte $89, $14, $00
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $FF

Room1D_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $08, $0E, $01
    .byte $44, $0E, $01
    .byte $84, $0F, $01
    .byte $94, $0E, $01
    .byte $B0, $0E, $01
    .byte $B8, $0E, $01
    .byte $FD
    .byte $31, $06, $42 ; Rio
    .byte $FF

Room1E_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $02, $2A, $01
    .byte $07, $25, $01
    .byte $08, $0E, $01
    .byte $10, $0E, $01
    .byte $12, $2A, $01
    .byte $17, $25, $01
    .byte $18, $0E, $01
    .byte $50, $03, $02
    .byte $5F, $03, $02
    .byte $74, $26, $01
    .byte $78, $26, $01
    .byte $80, $0E, $01
    .byte $88, $0E, $01
    .byte $C0, $24, $01
    .byte $CC, $24, $01
    .byte $D4, $00, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $02, $B1 ; Blue door
    .byte $11, $02, $52 ; Waver
    .byte $01, $03, $C8 ; Ripper
    .byte $FF

Room1F_BANK{BANK}:
    .byte $01
    .byte $00, $27, $01
    .byte $08, $27, $01
    .byte $10, $24, $01
    .byte $50, $03, $02
    .byte $80, $24, $01
    .byte $A6, $26, $01
    .byte $B0, $0E, $01
    .byte $CA, $26, $01
    .byte $D8, $0E, $01
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $01, $02, $2B ; Waver
    .byte $11, $02, $BB ; Waver
    .byte $21, $82, $5B ; Waver
    .byte $31, $02, $8B ; Waver
    .byte $FF

Room20_BANK{BANK}:
    .byte $01
    .byte $00, $27, $01
    .byte $08, $27, $01
    .byte $1C, $24, $01
    .byte $20, $24, $01
    .byte $5F, $03, $02
    .byte $8C, $24, $01
    .byte $BA, $26, $01
    .byte $C4, $26, $01
    .byte $C8, $0E, $01
    .byte $D0, $0E, $01
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $51, $02, $85 ; Waver
    .byte $41, $02, $C5 ; Waver
    .byte $31, $05, $BA ; Zoomer
    .byte $21, $05, $C5 ; Zoomer
    .byte $FF

Room21_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $08, $0E, $01
    .byte $30, $0E, $01
    .byte $38, $0E, $01
    .byte $A7, $26, $01
    .byte $B0, $24, $01
    .byte $B6, $24, $01
    .byte $BC, $24, $01
    .byte $C4, $05, $03
    .byte $D4, $27, $01
    .byte $DA, $00, $02
    .byte $FD
    .byte $07, $07, $C5 ; Zeb
    .byte $11, $05, $AC ; Zoomer
    .byte $21, $05, $A8 ; Zoomer
    .byte $51, $06, $7A ; Rio
    .byte $FF

Room22_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $08, $0E, $01
    .byte $30, $0E, $01
    .byte $37, $25, $01
    .byte $48, $2A, $01
    .byte $4C, $2A, $01
    .byte $68, $0E, $01
    .byte $78, $0E, $01
    .byte $A3, $26, $01
    .byte $B0, $0E, $01
    .byte $B8, $0E, $01
    .byte $FD
    .byte $41, $06, $75 ; Rio
    .byte $21, $03, $85 ; Ripper
    .byte $FF

Room23_BANK{BANK}:
    .byte $02
    .byte $00, $27, $01
    .byte $08, $27, $01
    .byte $63, $29, $01
    .byte $73, $28, $02
    .byte $8B, $29, $01
    .byte $9B, $28, $02
    .byte $C0, $26, $01
    .byte $C6, $26, $01
    .byte $D0, $0E, $01
    .byte $D8, $00, $02
    .byte $D9, $0E, $01
    .byte $DE, $05, $03
    .byte $FD
    .byte $01, $85, $63 ; Zoomer
    .byte $11, $05, $8B ; Zoomer
    .byte $21, $02, $6E ; Waver
    .byte $47, $07, $DF ; Zeb
    .byte $31, $83, $A8 ; Ripper
    .byte $FF

Room24_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $08, $0E, $01
    .byte $40, $2B, $00
    .byte $48, $2B, $00
    .byte $50, $0E, $01
    .byte $53, $20, $01
    .byte $58, $0E, $01
    .byte $5B, $20, $01
    .byte $60, $2B, $00
    .byte $68, $13, $00
    .byte $70, $27, $01
    .byte $78, $27, $01
    .byte $80, $2B, $00
    .byte $88, $2B, $00
    .byte $90, $27, $01
    .byte $98, $27, $01
    .byte $A0, $13, $00
    .byte $A8, $2B, $00
    .byte $B0, $0E, $01
    .byte $B8, $0E, $01
    .byte $FD
    .byte $01, $05, $4D ; Zoomer
    .byte $11, $85, $6C ; Zoomer
    .byte $21, $05, $8A ; Zoomer
    .byte $31, $85, $AF ; Zoomer
    .byte $41, $05, $47 ; Zoomer
    .byte $FF

Room25_BANK{BANK}:
    .byte $02
    .byte $00, $27, $01
    .byte $05, $27, $01
    .byte $0A, $0E, $01
    .byte $23, $24, $01
    .byte $4A, $13, $00
    .byte $52, $24, $01
    .byte $59, $20, $01
    .byte $5A, $0E, $01
    .byte $6A, $2B, $00
    .byte $79, $0E, $01
    .byte $89, $2B, $00
    .byte $90, $28, $02
    .byte $94, $06, $03
    .byte $98, $0E, $01
    .byte $A8, $13, $00
    .byte $B0, $0E, $01
    .byte $B8, $0E, $01
    .byte $FD
    .byte $51, $05, $4F ; Zoomer
    .byte $41, $05, $6E ; Zoomer
    .byte $31, $05, $8E ; Zoomer
    .byte $21, $02, $48 ; Waver
    .byte $FF

Room26_BANK{BANK}:
    .byte $01
    .byte $00, $0E, $01
    .byte $08, $27, $01
    .byte $40, $2B, $00
    .byte $50, $0E, $01
    .byte $56, $20, $01
    .byte $60, $2B, $00
    .byte $68, $2C, $00
    .byte $80, $27, $01
    .byte $8B, $24, $01
    .byte $D0, $00, $02
    .byte $D8, $00, $02
    .byte $FD
    .byte $51, $05, $67 ; Zoomer
    .byte $41, $05, $7E ; Zoomer
    .byte $21, $05, $7B ; Zoomer
    .byte $31, $03, $49 ; Ripper
    .byte $11, $02, $C6 ; Waver
    .byte $FF

Room27_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $02, $11, $01
    .byte $09, $11, $01
    .byte $50, $04, $02
    .byte $80, $0B, $03
    .byte $82, $1E, $03
    .byte $B6, $1D, $03
    .byte $B7, $1D, $03
    .byte $C2, $09, $03
    .byte $C8, $1D, $03
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $02, $B0 ; Red door
    .byte $11, $04, $38 ; Skree
    .byte $31, $06, $27 ; Rio
    .byte $FF

Room28_BANK{BANK}:
    .byte $00
    .byte $00, $2D, $02
    .byte $08, $2D, $02
    .byte $0F, $28, $02
    .byte $5F, $03, $02
    .byte $87, $14, $00
    .byte $8F, $28, $02
    .byte $9A, $15, $00
    .byte $C3, $26, $01
    .byte $D0, $2D, $02
    .byte $D8, $2D, $02
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $01, $06, $23 ; Rio
    .byte $31, $05, $7D ; Zoomer
    .byte $FF

Room29_BANK{BANK}:
    .byte $02
    .byte $00, $2D, $02
    .byte $08, $2D, $02
    .byte $C2, $26, $01
    .byte $C7, $26, $01
    .byte $C9, $26, $01
    .byte $D0, $2D, $02
    .byte $D8, $2D, $02
    .byte $FD
    .byte $41, $86, $25 ; Rio
    .byte $51, $06, $2A ; Rio
    .byte $21, $05, $CB ; Zoomer
    .byte $FF

Room2A_BANK{BANK}:
    .byte $00
    .byte $00, $11, $01
    .byte $08, $11, $01
    .byte $68, $21, $02
    .byte $78, $15, $00
    .byte $95, $15, $00
    .byte $A0, $0B, $03
    .byte $AE, $0B, $03
    .byte $BB, $15, $00
    .byte $C2, $06, $03
    .byte $D2, $00, $02
    .byte $D6, $00, $02
    .byte $FD
    .byte $01, $05, $58 ; Zoomer
    .byte $11, $05, $85 ; Zoomer
    .byte $31, $06, $26 ; Rio
    .byte $FF

Room2B_BANK{BANK}:
    .byte $02
    .byte $00, $30, $00
    .byte $01, $1A, $02
    .byte $02, $30, $00
    .byte $03, $1A, $02
    .byte $05, $1C, $02
    .byte $0A, $1B, $02
    .byte $0F, $30, $00
    .byte $10, $30, $00
    .byte $14, $30, $00
    .byte $1F, $30, $00
    .byte $2C, $18, $02
    .byte $35, $18, $02
    .byte $41, $19, $02
    .byte $44, $2F, $02
    .byte $45, $18, $02
    .byte $46, $2F, $02
    .byte $50, $04, $02
    .byte $53, $19, $02
    .byte $5F, $04, $02
    .byte $64, $1C, $02
    .byte $65, $1C, $02
    .byte $68, $2F, $02
    .byte $80, $15, $00
    .byte $81, $19, $02
    .byte $8D, $19, $02
    .byte $9C, $19, $02
    .byte $9F, $15, $00
    .byte $C0, $30, $00
    .byte $D1, $00, $02
    .byte $D7, $00, $02
    .byte $DF, $30, $00
    .byte $FD
    .byte $02, $A0 ; Red door
    .byte $02, $B1 ; Blue door
    .byte $06 ; Statues
    .byte $FF

Room2C_BANK{BANK}:
    .byte $00
    .byte $00, $16, $00
    .byte $07, $16, $00
    .byte $0E, $16, $00
    .byte $1F, $15, $00
    .byte $20, $15, $00
    .byte $40, $30, $00
    .byte $5F, $04, $02
    .byte $80, $16, $00
    .byte $87, $02, $02
    .byte $89, $16, $00
    .byte $A0, $15, $00
    .byte $AF, $15, $00
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $FF

Room2D_BANK{BANK}:
    .byte $03
    .byte $00, $11, $01
    .byte $08, $11, $01
    .byte $1E, $1E, $03
    .byte $5F, $04, $02
    .byte $8B, $10, $03
    .byte $9E, $0B, $03
    .byte $D0, $10, $03
    .byte $D8, $10, $03
    .byte $FD
    .byte $02, $A1 ; Blue door
    .byte $FF

Room2E_BANK{BANK}:
    .byte $03
    .byte $00, $0B, $03
    .byte $0E, $0B, $03
    .byte $50, $03, $02
    .byte $5E, $0B, $03
    .byte $80, $0B, $03
    .byte $AE, $0B, $03
    .byte $D0, $0B, $03
    .byte $FD
    .byte $02, $B1 ; Blue door
    .byte $FF
