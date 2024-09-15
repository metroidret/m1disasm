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

;Room #$00
LA23F:  .byte $02                       ;Attribute table data.
;Room object data:
LA240:  .byte $07, $03, $02, $87, $03, $02, $FF

;Room #$01
LA247:  .byte $03                       ;Attribute table data.
;Room object data:
LA248:  .byte $00, $07, $03, $01, $08, $03, $06, $09, $03, $0B, $08, $03, $0E, $07, $03, $50
LA258:  .byte $07, $03, $5E, $07, $03, $93, $0A, $00, $96, $09, $03, $9C, $0A, $00, $A0, $07
LA268:  .byte $03, $AE, $07, $03, $E2, $08, $03, $EA, $08, $03, $FF

;Room #$02
LA273:  .byte $03                       ;Attribute table data.
;Room object data:
LA274:  .byte $00, $07, $03, $0E, $07, $03, $46, $08, $03, $50, $01, $02, $5F, $01, $02, $80
LA284:  .byte $08, $03, $84, $09, $03, $88, $09, $03, $8C, $08, $03, $B0, $08, $03, $BC, $08
LA294:  .byte $03, $D4, $00, $03, $FD
;Room enemy/door data:
LA299:  .byte $02, $A1, $02, $B1, $FF

;Room #$03
LA29E:  .byte $03                       ;Attribute table data.
;Room object data:
LA29F:  .byte $00, $07, $03, $0E, $07, $03, $50, $07, $03, $5E, $07, $03, $A0, $07, $03, $AE
LA2AF:  .byte $07, $03, $FF

;Room #$04
LA2B2:  .byte $03                       ;Attribute table data.
;Room object data:
LA2B3:  .byte $00, $08, $03, $04, $08, $03, $08, $08, $03, $0C, $08, $03, $40, $08, $03, $44
LA2C3:  .byte $08, $03, $48, $08, $03, $4C, $08, $03, $70, $08, $03, $74, $08, $03, $78, $08
LA2D3:  .byte $03, $7C, $08, $03, $B0, $08, $03, $B4, $08, $03, $B8, $08, $03, $BC, $08, $03
LA2E3:  .byte $FF

;Room #$05
LA2E4:  .byte $03                       ;Attribute table data.
;Room object data:
LA2E5:  .byte $00, $07, $03, $05, $08, $03, $0E, $07, $03, $50, $01, $02, $5F, $01, $02, $68
LA2F5:  .byte $08, $03, $80, $07, $03, $82, $09, $03, $8C, $09, $03, $8E, $07, $03, $AE, $07
LA305:  .byte $03, $B0, $07, $03, $FD
;Room enemy/door data:
LA30A:  .byte $02, $A1, $02, $B1, $FF

;Room #$06
LA30F:  .byte $03                       ;Attribute table data.
;Room object data:
LA310:  .byte $00, $07, $03, $0E, $07, $03, $26, $04, $03, $35, $09, $03, $50, $01, $02, $5E
LA320:  .byte $07, $03, $80, $07, $03, $82, $09, $03, $89, $09, $03, $AE, $07, $03, $B2, $05
LA330:  .byte $01, $C4, $09, $03, $D0, $07, $03, $DC, $04, $03, $EB, $09, $03, $FD
;Room enemy/door data:
LA33E:  .byte $02, $B1, $07, $87, $27, $17, $87, $DD, $21, $86, $B5, $31, $86, $7B, $FF

;Room #$07
LA34D:  .byte $03                       ;Attribute table data.
;Room object data:
LA34E:  .byte $00, $07, $03, $0E, $07, $03, $22, $05, $01, $26, $09, $03, $50, $07, $03, $5E
LA35E:  .byte $07, $03, $62, $09, $03, $79, $09, $03, $95, $04, $03, $A0, $07, $03, $A4, $09
LA36E:  .byte $03, $AE, $07, $03, $E8, $09, $03, $FD
;Room enemy/door data:
LA376:  .byte $51, $06, $17, $01, $86, $6B, $11, $86, $DA, $27, $87, $96, $FF

;Room #$08
LA383:  .byte $03                       ;Attribute table data.
;Room object data:
LA384:  .byte $00, $07, $03, $0E, $07, $03, $26, $09, $03, $2D, $06, $01, $50, $01, $02, $5C
LA394:  .byte $09, $03, $5E, $07, $03, $80, $08, $03, $84, $08, $03, $88, $08, $03, $8C, $08
LA3A4:  .byte $03, $C0, $08, $03, $CC, $08, $03, $D4, $00, $03, $FD
;Room enemy/door data:
LA3AF:  .byte $02, $B1, $31, $86, $18, $41, $86, $78, $FF

;Room #$09
LA3B8:  .byte $00                       ;Attribute table data.
;Room object data:
LA3B9:  .byte $00, $07, $03, $07, $19, $00, $0E, $07, $03, $45, $19, $00, $4C, $19, $00, $50
LA3C9:  .byte $07, $03, $5F, $01, $02, $72, $19, $00, $8C, $09, $03, $8E, $07, $03, $A0, $07
LA3D9:  .byte $03, $AB, $19, $00, $B4, $19, $00, $BE, $07, $03, $E8, $19, $00, $FD
;Room enemy/door data:
LA3E7:  .byte $02, $A1, $01, $06, $34, $11, $86, $3C, $21, $06, $9B, $31, $86, $A4, $51, $86
LA3F7:  .byte $D8, $FF

;Room #$0A
LA3F9:  .byte $03                       ;Attribute table data.
;Room object data:
LA3FA:  .byte $00, $07, $03, $0E, $07, $03, $16, $19, $00, $50, $07, $03, $53, $19, $00, $5E
LA40A:  .byte $07, $03, $86, $19, $00, $A0, $07, $03, $AE, $07, $03, $B9, $19, $00, $BD, $06
LA41A:  .byte $01, $FD
;Room enemy/door data:
LA41C:  .byte $41, $86, $06, $01, $06, $43, $11, $86, $76, $21, $86, $A9, $FF

;Room #$0B
LA429:  .byte $03                       ;Attribute table data.
;Room object data:
LA42A:  .byte $00, $07, $03, $0E, $07, $03, $50, $07, $03, $5F, $01, $02, $80, $08, $03, $84
LA43A:  .byte $08, $03, $88, $09, $03, $8C, $08, $03, $C0, $08, $03, $CC, $08, $03, $D4, $00
LA44A:  .byte $03, $FD
;Room enemy/door data:
LA44C:  .byte $02, $A1, $31, $82, $74, $41, $82, $79, $FF

;Room #$0C
LA455:  .byte $00                       ;Attribute table data.
;Room object data:
LA456:  .byte $00, $0B, $00, $04, $0B, $00, $08, $0B, $00, $0C, $0B, $00, $50, $01, $02, $5F
LA466:  .byte $01, $02, $80, $0B, $00, $82, $0B, $00, $86, $0C, $00, $88, $0B, $00, $8C, $0B
LA476:  .byte $00, $C0, $0B, $00, $C2, $0B, $00, $C6, $0C, $00, $D8, $0B, $00, $DC, $0B, $00
LA486:  .byte $FD
;Room enemy/door data:
LA487:  .byte $02, $A0, $02, $B1, $FF

;Room #$0D
LA48C:  .byte $00                       ;Attribute table data.
;Room object data:
LA48D:  .byte $00, $0B, $00, $04, $0B, $00, $08, $0B, $00, $0C, $0B, $00, $0E, $0D, $00, $1E
LA49D:  .byte $0D, $00, $50, $01, $02, $5F, $01, $02, $80, $0B, $00, $84, $0B, $00, $88, $0B
LA4AD:  .byte $00, $8C, $0B, $00, $C0, $0B, $00, $C4, $0B, $00, $C8, $0B, $00, $CC, $0B, $00
LA4BD:  .byte $FD
;Room enemy/door data:
LA4BE:  .byte $02, $A1, $02, $B1, $FF

;Room #$0E
LA4C3:  .byte $00                       ;Attribute table data.
;Room object data:
LA4C4:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $7D, $0A, $00, $B0
LA4D4:  .byte $0B, $00, $B4, $0B, $00, $B8, $0C, $00, $B9, $0B, $00, $BE, $0B, $00, $BF, $0C
LA4E4:  .byte $00, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA4EC:  .byte $51, $80, $27, $01, $02, $A4, $11, $02, $AA, $FF

;Room #$0F
LA4F6:  .byte $00                       ;Attribute table data.
;Room object data:
LA4F7:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0B, $0E, $00, $0F, $0A, $00, $5F
LA507:  .byte $02, $02, $8C, $08, $03, $CC, $08, $03, $D0, $0F, $03, $D4, $00, $03, $D8, $0F
LA517:  .byte $03, $FD
;Room enemy/door data:
LA519:  .byte $02, $A2, $51, $80, $27, $21, $80, $29, $11, $80, $2B, $FF

;Room #$10
LA525:  .byte $03                       ;Attribute table data.
;Room object data:
LA526:  .byte $00, $08, $03, $04, $08, $03, $08, $0E, $00, $0C, $0E, $00, $40, $08, $03, $42
LA536:  .byte $0B, $00, $70, $08, $03, $72, $0B, $00, $76, $0A, $00, $B0, $08, $03, $B4, $08
LA546:  .byte $03, $D8, $0F, $03, $DC, $0F, $03, $FD
;Room enemy/door data:
LA54E:  .byte $31, $80, $2E, $41, $80, $2B, $FF

;Room #$11
LA555:  .byte $03                       ;Attribute table data.
;Room object data:
LA556:  .byte $00, $07, $03, $02, $11, $03, $06, $11, $03, $0A, $11, $03, $0E, $07, $03, $13
LA566:  .byte $10, $03, $14, $12, $03, $1C, $10, $03, $22, $0A, $00, $50, $02, $02, $5F, $02
LA576:  .byte $02, $80, $07, $03, $84, $11, $03, $8F, $07, $03, $92, $19, $00, $95, $11, $03
LA586:  .byte $99, $11, $03, $AE, $19, $00, $C0, $07, $03, $D2, $00, $03, $D7, $00, $03, $DF
LA596:  .byte $07, $03, $FD
;Room enemy/door data:
LA599:  .byte $02, $A1, $02, $B2, $01, $49, $66, $FF

;Room #$12
LA5A1:  .byte $01                       ;Attribute table data.
;Room object data:
LA5A2:  .byte $00, $07, $03, $01, $0E, $00, $05, $0E, $00, $09, $0E, $00, $0D, $0E, $00, $22
LA5B2:  .byte $11, $03, $26, $11, $03, $50, $02, $02, $80, $07, $03, $81, $11, $03, $8B, $0A
LA5C2:  .byte $00, $A7, $0A, $00, $B0, $07, $03, $BF, $0A, $00, $D2, $00, $03, $DA, $00, $03
LA5D2:  .byte $FD
;Room enemy/door data:
LA5D3:  .byte $02, $B1, $11, $86, $97, $21, $06, $7B, $31, $86, $AF, $41, $80, $35, $51, $83
LA5E3:  .byte $3E, $FF

;Room #$13
LA5E5:  .byte $01                       ;Attribute table data.
;Room object data:
LA5E6:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $86, $0A, $00, $8A
LA5F6:  .byte $0A, $00, $A2, $0A, $00, $A3, $0A, $00, $BE, $0A, $00, $D0, $00, $03, $D8, $00
LA606:  .byte $03, $FD
;Room enemy/door data:
LA608:  .byte $01, $86, $92, $11, $86, $76, $21, $86, $7A, $31, $06, $AE, $41, $80, $27, $FF

;Room #$14
LA618:  .byte $01                       ;Attribute table data.
;Room object data:
LA619:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0B, $00, $5F, $01, $02, $85
LA629:  .byte $0A, $00, $86, $0A, $00, $8C, $11, $03, $9E, $07, $03, $A2, $0A, $00, $B9, $0A
LA639:  .byte $00, $CE, $07, $03, $D0, $00, $03, $D6, $00, $03, $FD
;Room enemy/door data:
LA644:  .byte $02, $A1, $51, $86, $92, $01, $86, $75, $21, $80, $23, $31, $80, $28, $FF

;Room #$15
LA653:  .byte $01                       ;Attribute table data.
;Room object data:
LA654:  .byte $00, $14, $01, $08, $14, $01, $10, $13, $01, $50, $01, $02, $80, $13, $01, $94
LA664:  .byte $05, $01, $C0, $14, $01, $CA, $14, $01, $D8, $00, $03, $FD
;Room enemy/door data:
LA670:  .byte $02, $B1, $41, $80, $37, $51, $80, $3C, $01, $80, $3E, $FF

;Room #$16
LA67C:  .byte $01                       ;Attribute table data.
;Room object data:
LA67D:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $90, $14, $01, $92
La68D:  .byte $04, $03, $94, $04, $03, $98, $14, $01, $9B, $04, $03, $C0, $14, $01, $C8, $14
LA69D:  .byte $01, $FD
;Room enemy/door data:
LA69F:  .byte $17, $87, $93, $27, $07, $95, $37, $87, $9C, $FF

;Room #$17
LA6A9:  .byte $01                       ;Attribute table data.
;Room object data:
LA6AA:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $52, $13, $01, $5A
LA6BA:  .byte $13, $01, $61, $06, $01, $C0, $14, $01, $C3, $04, $03, $C8, $14, $01, $CB, $04
LA6CA:  .byte $03, $FD
;Room enemy/door data:
LA6CC:  .byte $47, $87, $C4, $57, $87, $CC, $01, $80, $67, $FF

;Room #$18
LA6D6:  .byte $01                       ;Attribute table data.
;Room object data:
LA6D7:  .byte $00, $14, $01, $08, $14, $01, $1C, $13, $01, $5F, $01, $02, $8C, $13, $01, $C0
LA6E7:  .byte $14, $01, $CA, $14, $01, $D0, $00, $03, $D5, $00, $03, $FD
;Room enemy/door data:
LA6F3:  .byte $02, $A1, $11, $80, $33, $21, $00, $35, $31, $80, $37, $FF

;Room #$19
LA6FF:  .byte $00                       ;Attribute table data.
;Room object data:
LA700:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $D0, $00, $03, $D2
LA710:  .byte $13, $01, $D7, $13, $01, $D8, $04, $03, $DB, $00, $03, $DC, $13, $01, $FD
;Room enemy/door data:
LA71E:  .byte $41, $00, $64, $51, $80, $68, $01, $00, $6C, $17, $87, $D9, $FF

;Room #$1A
LA72C:  .byte $01                       ;Attribute table data.
;Room object data:
LA72D:  .byte $00, $14, $01, $08, $14, $01, $30, $13, $01, $34, $13, $01, $38, $13, $01, $3C
LA73D:  .byte $13, $01, $40, $16, $01, $41, $15, $01, $44, $15, $01, $48, $15, $01, $4C, $15
LA74D:  .byte $01, $4F, $16, $01, $90, $14, $01, $92, $04, $03, $98, $14, $01, $9B, $04, $03
LA75D:  .byte $C0, $14, $01, $C8, $14, $01, $FD
;Room enemy/door data:
LA764:  .byte $27, $87, $93, $37, $87, $9C, $FF

;Room #$1B
LA76B:  .byte $02                       ;Attribute table data.
;Room object data:
LA76C:  .byte $00, $18, $02, $08, $18, $02, $20, $18, $02, $28, $0A, $00, $50, $01, $02, $5F
LA77C:  .byte $19, $00, $80, $17, $02, $8C, $19, $00, $C0, $18, $02, $CA, $18, $02, $D8, $00
LA78C:  .byte $03, $FD
;Room enemy/door data:
LA78E:  .byte $02, $B1, $01, $8C, $39, $11, $0C, $3D, $21, $8C, $6B, $31, $0C, $66, $FF

;Room #$1C
LA79D:  .byte $02                       ;Attribute table data.
;Room object data:
LA79E:  .byte $00, $18, $02, $08, $18, $02, $28, $18, $02, $5F, $01, $02, $70, $19, $00, $8C
LA7AE:  .byte $17, $02, $94, $19, $00, $B8, $17, $02, $BC, $17, $02, $C0, $18, $02, $D0, $00
LA7BE:  .byte $03, $FD
;Room enemy/door data:
LA7C0:  .byte $02, $A1, $01, $8C, $33, $11, $0C, $36, $41, $8C, $92, $51, $0C, $A6, $FF

;Room #$1D
LA7CF:  .byte $00                       ;Attribute table data.
;Room object data:
LA7D0:  .byte $00, $18, $02, $08, $18, $02, $30, $0A, $00, $49, $19, $00, $55, $0A, $00, $5D
LA7E0:  .byte $0A, $00, $A0, $18, $02, $A8, $18, $02, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA7F1:  .byte $21, $8C, $38, $31, $0C, $97, $41, $8C, $99, $51, $0C, $9B, $FF

;Room #$1E
LA7FC:  .byte $02                       ;Attribute table data.
;Room object data:
LA7FD:  .byte $00, $17, $02, $04, $17, $02, $08, $17, $02, $0C, $17, $02, $70, $17, $02, $74
LA80D:  .byte $17, $02, $78, $17, $02, $7C, $17, $02, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA81C:  .byte $01, $8C, $42, $11, $0C, $45, $21, $8C, $48, $FF

;Room #$1F
LA826:  .byte $00                       ;Attribute table data.
;Room object data:
LA827:  .byte $00, $0B, $00, $04, $18, $02, $0C, $0B, $00, $50, $01, $02, $80, $0B, $00, $C0
LA837:  .byte $18, $02, $C8, $18, $02, $FD
;Room enemy/door data:
LA83D:  .byte $02, $B1, $21, $82, $5B, $31, $03, $85, $41, $83, $88, $FF

;Room #$20
LA849:  .byte $02                       ;Attribute table data.
;Room object data:
LA84A:  .byte $20, $18, $02, $28, $18, $02, $A0, $18, $02, $A8, $18, $02, $D0, $00, $03, $D8
LA85A:  .byte $00, $03, $FD
;Room enemy/door data:
LA85D:  .byte $01, $82, $98, $11, $02, $9E, $41, $83, $53, $FF

;Room #$21
LA867:  .byte $00                       ;Attribute table data.
;Room object data:
LA868:  .byte $00, $0B, $00, $04, $18, $02, $0C, $0B, $00, $5F, $01, $02, $8C, $0B, $00, $C0
LA878:  .byte $18, $02, $C8, $18, $02, $FD
;Room enemy/door data:
LA87E:  .byte $02, $A1, $11, $02, $57, $31, $83, $85, $41, $83, $88, $51, $03, $8A, $FF

;Room #$22
LA88D:  .byte $00                       ;Attribute table data.
;Room object data:
LA88E:  .byte $00, $07, $03, $02, $12, $03, $0A, $12, $03, $50, $01, $02, $80, $07, $03, $82
LA89E:  .byte $0B, $00, $8F, $0B, $00, $B0, $07, $03, $B9, $0B, $00, $D2, $00, $03, $DA, $00
LA8AE:  .byte $03, $FD
;Room enemy/door data:
LA8B0:  .byte $02, $B1, $01, $80, $18, $11, $80, $1E, $21, $86, $AB, $31, $86, $7F, $FF

;Room #$23
LA8BF:  .byte $01                       ;Attribute table data.
;Room object data:
LA8C0:  .byte $00, $12, $03, $08, $12, $03, $92, $04, $03, $94, $04, $03, $99, $0B, $00, $A2
LA8D0:  .byte $0B, $00, $BF, $0B, $00, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA8DC:  .byte $07, $87, $93, $11, $00, $1A, $21, $80, $1F, $47, $87, $95, $51, $86, $8B, $FF

;Room #$24
LA8EC:  .byte $02                       ;Attribute table data.
;Room object data:
LA8ED:  .byte $00, $0B, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $37, $0A, $00, $50
LA8FD:  .byte $01, $02, $77, $0A, $00, $80, $17, $02, $8D, $1A, $01, $C0, $18, $02, $C4, $1B
LA90D:  .byte $02, $C8, $18, $02, $D4, $1C, $02, $D8, $1C, $02, $DC, $1C, $02, $FD
;Room enemy/door data:
LA91B:  .byte $02, $B0, $01, $82, $27, $11, $82, $2B, $21, $83, $B5, $31, $83, $BA, $FF

;Room #$25
LA92A:  .byte $02                       ;Attribute table data.
;Room object data:
LA92B:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $87, $1A, $01, $C0
LA93B:  .byte $18, $02, $C8, $18, $02, $CF, $1B, $02, $D0, $1C, $02, $D4, $1C, $02, $D8, $1C
LA94B:  .byte $02, $DC, $1C, $02, $FD
;Room enemy/door data:
LA950:  .byte $21, $82, $26, $31, $02, $2B, $41, $83, $B3, $51, $03, $BC, $FF

;Room #$26
LA95D:  .byte $01                       ;Attribute table data.
;Room object data:
LA95E:  .byte $00, $14, $01, $08, $14, $01, $B2, $04, $03, $C0, $14, $01, $C9, $14, $01, $D0
LA96E:  .byte $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA974:  .byte $07, $87, $B3, $11, $03, $29, $FF

;Room #$27
LA97B:  .byte $01                       ;Attribute table data.
;Room object data:
LA97C:  .byte $00, $14, $01, $08, $14, $01, $10, $0A, $00, $60, $0A, $00, $B0, $0A, $00, $B5
LA98C:  .byte $04, $03, $C1, $14, $01, $CA, $14, $01, $D1, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA99B:  .byte $27, $87, $B6, $11, $82, $B7, $11, $80, $27, $FF

;Room #$28
LA9A5:  .byte $00                       ;Attribute table data.
;Room object data:
LA9A6:  .byte $00, $0B, $00, $0C, $0B, $00, $50, $01, $02, $5C, $0B, $00, $80, $0B, $00, $AF
LA9B6:  .byte $0B, $00, $D0, $0B, $00, $FD
;Room enemy/door data:
LA9BC:  .byte $02, $B1, $FF