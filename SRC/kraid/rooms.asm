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

;Room #$00
LA2B7:  .byte $02                       ;Attribute table data.
;Room object data:
LA2B8:  .byte $40, $01, $03, $48, $01, $03, $50, $04, $02, $5F, $04, $02, $FF

;Room #$01
LA2C5:  .byte $02                       ;Attribute table data.
;Room object data:
LA2C6:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA2CD:  .byte $00                       ;Attribute table data.
;Room object data:
LA2CE:  .byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $06, $00, $42
LA2DE:  .byte $08, $01, $4E, $06, $00, $6D, $09, $01, $75, $0C, $00, $7A, $0C, $00, $90, $06
LA2EE:  .byte $00, $92, $0C, $00, $96, $0D, $00, $9D, $0C, $00, $9E, $06, $00, $E0, $06, $00
LA2FE:  .byte $E1, $0D, $00, $EB, $0D, $00, $EE, $06, $00, $FF

;Room #$03
LA308:  .byte $00                       ;Attribute table data.
;Room object data:
LA309:  .byte $00, $06, $00, $0A, $0D, $00, $0E, $06, $00, $22, $08, $01, $2D, $09, $01, $45
LA319:  .byte $0D, $00, $50, $03, $02, $5F, $03, $02, $80, $10, $00, $8A, $06, $00, $8C, $10
LA329:  .byte $00, $A4, $08, $01, $C0, $10, $00, $C9, $0D, $00, $CC, $10, $00, $DB, $09, $01
LA339:  .byte $E1, $10, $00, $FD
;Room enemy/door data:
LA33D:  .byte $02, $A0, $02, $B1, $31, $85, $37, $FF

;Room #$04
LA345:  .byte $00                       ;Attribute table data.
;Room object data:
LA346:  .byte $00, $06, $00, $07, $06, $00, $0B, $10, $00, $0E, $06, $00, $22, $08, $01, $2A
LA356:  .byte $09, $01, $35, $0D, $00, $50, $03, $02, $57, $06, $00, $5F, $03, $02, $80, $0D
LA366:  .byte $00, $8C, $0D, $00, $8E, $06, $00, $90, $06, $00, $92, $08, $01, $BE, $06, $00
LA376:  .byte $CD, $09, $01, $D0, $06, $00, $FD
;Room enemy/door data:
LA37D:  .byte $02, $A0, $02, $B1, $41, $85, $25, $21, $83, $C8, $FF

;Room #$05
LA388:  .byte $00                       ;Attribute table data.
;Room object data:
LA389:  .byte $00, $10, $00, $0C, $10, $00, $14, $08, $01, $40, $10, $00, $4C, $10, $00, $6B
LA399:  .byte $09, $01, $7C, $10, $00, $80, $10, $00, $94, $08, $01, $BC, $10, $00, $C0, $10
LA3A9:  .byte $00, $DB, $09, $01, $FD
;Room enemy/door data:
LA3AE:  .byte $51, $83, $57, $01, $03, $95, $11, $03, $CA, $FF

;Room #$06
LA3B8:  .byte $00                       ;Attribute table data.
;Room object data:
LA3B9:  .byte $00, $06, $00, $0E, $06, $00, $12, $08, $01, $17, $0E, $00, $1A, $0D, $00, $27
LA3C9:  .byte $0C, $00, $31, $0E, $00, $36, $11, $00, $39, $07, $00, $50, $03, $02, $59, $0E
LA3D9:  .byte $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10, $00
LA3E9:  .byte $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LA3F6:  .byte $02, $A1, $02, $B1, $01, $85, $2A, $51, $85, $26, $FF

;Room #$07
LA401:  .byte $00                       ;Attribute table data.
;Room object data:
LA402:  .byte $00, $10, $00, $0A, $10, $00, $0E, $07, $00, $24, $08, $01, $27, $0E, $00, $40
LA412:  .byte $07, $00, $5F, $03, $02, $62, $10, $00, $8B, $0E, $00, $8E, $07, $00, $90, $07
LA422:  .byte $00, $9D, $09, $01, $B0, $07, $00, $B2, $10, $00, $B6, $0D, $00, $CE, $07, $00
LA432:  .byte $D6, $08, $01, $FD
;Room enemy/door data:
LA436:  .byte $02, $A1, $01, $85, $17, $21, $85, $A8, $31, $03, $87, $FF

;Room #$08
LA442:  .byte $00                       ;Attribute table data.
;Room object data:
LA443:  .byte $00, $10, $00, $03, $10, $00, $0A, $10, $00, $0C, $10, $00, $29, $09, $01, $35
LA453:  .byte $0E, $00, $40, $10, $00, $44, $08, $01, $4C, $10, $00, $79, $0E, $00, $80, $10
LA463:  .byte $00, $8C, $10, $00, $AB, $09, $01, $B0, $10, $00, $B4, $0D, $00, $CC, $10, $00
LA473:  .byte $D4, $08, $01, $FD
;Room enemy/door data:
LA477:  .byte $11, $85, $6A, $41, $85, $A6, $FF

;Room #$09
LA47E:  .byte $00                       ;Attribute table data.
;Room object data:
LA47F:  .byte $00, $07, $00, $0D, $09, $01, $0E, $07, $00, $42, $08, $01, $50, $07, $00, $5F
LA48F:  .byte $03, $02, $8B, $0E, $00, $8E, $07, $00, $9D, $09, $01, $A0, $07, $00, $A6, $0E
LA49F:  .byte $00, $DE, $07, $00, $FD
;Room enemy/door data:
LA4A4:  .byte $02, $A1, $21, $85, $97, $31, $03, $83, $FF

;Room #$0A
LA4AD:  .byte $00                       ;Attribute table data.
;Room object data:
LA4AE:  .byte $00, $07, $00, $0E, $07, $00, $12, $08, $01, $50, $07, $00, $5F, $03, $02, $72
LA4BE:  .byte $08, $01, $87, $0E, $00, $8B, $0E, $00, $8E, $07, $00, $A0, $10, $00, $AD, $09
LA4CE:  .byte $01, $CC, $10, $00, $D4, $00, $02, $E0, $10, $00, $FD
;Room enemy/door data:
LA4D9:  .byte $02, $A1, $01, $85, $78, $11, $03, $28, $FF

;Room #$0B
LA4E2:  .byte $00                       ;Attribute table data.
;Room object data:
LA4E3:  .byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $10, $00, $44
LA4F3:  .byte $10, $00, $48, $10, $00, $4C, $10, $00, $80, $10, $00, $84, $10, $00, $88, $10
LA503:  .byte $00, $8C, $10, $00, $B0, $10, $00, $B4, $10, $00, $B8, $10, $00, $BC, $10, $00
LA513:  .byte $FF

;Room #$0C
LA514:  .byte $00                       ;Attribute table data.
;Room object data:
LA515:  .byte $00, $07, $00, $0A, $11, $00, $0E, $07, $00, $25, $11, $00, $32, $08, $01, $49
LA525:  .byte $11, $00, $50, $03, $02, $5D, $09, $01, $5E, $07, $00, $80, $07, $00, $82, $11
LA535:  .byte $00, $86, $11, $00, $9C, $11, $00, $AE, $07, $00, $BD, $09, $01, $C2, $08, $01
LA545:  .byte $C8, $11, $00, $D0, $07, $00, $D4, $11, $00, $FD
;Room enemy/door data:
LA54F:  .byte $02, $B1, $51, $85, $39, $41, $05, $C4, $FF

;Room #$0D
LA558:  .byte $00                       ;Attribute table data.
;Room object data:
LA559:  .byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $1D, $09, $01, $4A, $0F, $02, $50
LA569:  .byte $03, $02, $5E, $07, $00, $80, $07, $00, $86, $0F, $02, $8A, $0F, $02, $8C, $11
LA579:  .byte $00, $9D, $09, $01, $A2, $11, $00, $AE, $07, $00, $C2, $08, $01, $CA, $0F, $02
LA589:  .byte $D0, $07, $00, $FD
;Room enemy/door data:
LA58D:  .byte $02, $B1, $FF

;Room #$0E
LA590:  .byte $00                       ;Attribute table data.
;Room object data:
LA591:  .byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $2D, $09, $01, $32, $08, $01, $4A
LA5A1:  .byte $0F, $02, $50, $07, $00, $5E, $07, $00, $78, $11, $00, $8A, $0F, $02, $92, $08
LA5B1:  .byte $01, $A0, $07, $00, $AE, $07, $00, $BD, $09, $01, $CA, $0F, $02, $FF

;Room #$0F
LA5BF:  .byte $01                       ;Attribute table data.
;Room object data:
LA5C0:  .byte $00, $1D, $01, $08, $1D, $01, $1E, $1F, $01, $5F, $03, $02, $8C, $1F, $01, $9B
LA5D0:  .byte $09, $01, $C9, $1D, $01, $D0, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA5DC:  .byte $02, $A1, $41, $84, $31, $57, $87, $D5, $07, $87, $D8, $FF

;Room #$10
LA5E8:  .byte $00                       ;Attribute table data.
;Room object data:
LA5E9:  .byte $00, $12, $00, $08, $12, $00, $57, $0C, $00, $75, $0C, $00, $79, $0C, $00, $93
LA5F9:  .byte $0C, $00, $9B, $0C, $00, $B1, $0C, $00, $BD, $0C, $00, $CF, $0C, $00, $D0, $00
LA609:  .byte $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA60E:  .byte $41, $81, $2D, $27, $07, $D4, $17, $87, $DA, $FF

;Room #$11 (not used).
LA618:  .byte $00                       ;Attribute table data.
;Room object data:
LA619:  .byte $00, $07, $00, $02, $08, $01, $0E, $07, $00, $2D, $09, $01, $32, $0E, $00, $50
LA629:  .byte $03, $02, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10
LA639:  .byte $00, $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FF

;Room #$12
LA647:  .byte $00                       ;Attribute table data.
;Room object data:
LA648:  .byte $00, $12, $00, $08, $12, $00, $24, $11, $00, $37, $0C, $00, $45, $0C, $00, $48
LA658:  .byte $0E, $00, $57, $0C, $00, $63, $0C, $00, $65, $0C, $00, $9B, $0E, $00, $A2, $11
LA668:  .byte $00, $C0, $13, $03, $C5, $0E, $00, $C9, $0C, $00, $CC, $13, $03, $D4, $00, $02
LA678:  .byte $FD
;Room enemy/door data:
LA679:  .byte $21, $85, $39, $31, $85, $8C, $41, $85, $B6, $FF

;Room #$13
LA683:  .byte $03                       ;Attribute table data.
;Room object data:
LA684:  .byte $00, $15, $03, $08, $15, $03, $10, $16, $03, $50, $03, $02, $68, $14, $03, $80
LA694:  .byte $16, $03, $93, $14, $03, $AB, $14, $03, $BF, $14, $03, $C0, $16, $03, $D2, $00
LA6A4:  .byte $02, $DA, $00, $02, $FD
;Room enemy/door data:
LA6A9:  .byte $02, $B0, $21, $81, $27, $41, $85, $84, $37, $87, $DD, $FF

;Room #$14
LA6B5:  .byte $03                       ;Attribute table data.
;Room object data:
LA6B6:  .byte $00, $15, $03, $08, $15, $03, $8A, $14, $03, $A4, $14, $03, $AF, $14, $03, $D0
LA6C6:  .byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CC:  .byte $37, $87, $D1, $47, $87, $D7, $57, $87, $DC, $01, $85, $95, $FF

;Room #$15
LA6D9:  .byte $01                       ;Attribute table data.
;Room object data:
LA6DA:  .byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA6EA:  .byte $03, $02, $80, $1D, $01, $87, $20, $01, $88, $1D, $01, $97, $21, $01, $B0, $1D
LA6FA:  .byte $01, $B7, $21, $01, $B8, $1D, $01, $C0, $1D, $01, $C7, $21, $01, $C8, $1D, $01
LA70A:  .byte $FD
;Room enemy/door data:
LA70B:  .byte $02, $A1, $02, $B1, $01, $80, $68, $FF

;Room #$16
LA713:  .byte $03                       ;Attribute table data.
;Room object data:
LA714:  .byte $00, $15, $03, $08, $15, $03, $1E, $16, $03, $5F, $03, $02, $61, $14, $03, $85
LA724:  .byte $14, $03, $8C, $15, $03, $8E, $16, $03, $BA, $14, $03, $CE, $16, $03, $D0, $00
LA734:  .byte $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA739:  .byte $02, $A1, $07, $87, $D3, $17, $07, $D8, $21, $81, $27, $FF

;Room #$17
LA745:  .byte $01                       ;Attribute table data.
;Room object data:
LA746:  .byte $00, $17, $03, $08, $17, $03, $10, $19, $03, $24, $18, $03, $36, $0C, $00, $3B
LA756:  .byte $0C, $00, $50, $03, $02, $80, $19, $03, $AE, $0C, $00, $C0, $19, $03, $D4, $18
LA766:  .byte $03, $D8, $00, $02, $D9, $18, $03, $DB, $05, $02, $DF, $00, $02, $FD, $02, $B1
LA776:  .byte $41, $80, $C5, $57, $87, $DC, $31, $04, $48, $FF

;Room #$18
LA780:  .byte $01                       ;Attribute table data.
;Room object data:
LA781:  .byte $00, $17, $03, $08, $17, $03, $1C, $19, $03, $20, $19, $03, $5F, $03, $02, $8C
LA791:  .byte $19, $03, $CC, $19, $03, $D0, $18, $03, $D3, $00, $02, $D4, $18, $03, $D5, $05
LA7A1:  .byte $02, $FD
;Room enemy/door data:
LA7A3:  .byte $02, $A1, $37, $87, $D6, $21, $84, $62, $11, $84, $25, $01, $84, $29, $FF

;Room #$19
LA7B2:  .byte $03                       ;Attribute table data.
;Room object data:
LA7B3:  .byte $00, $19, $03, $04, $19, $03, $08, $19, $03, $0C, $19, $03, $40, $19, $03, $44
LA7C3:  .byte $19, $03, $48, $19, $03, $4C, $19, $03, $70, $19, $03, $74, $19, $03, $78, $19
LA7D3:  .byte $03, $7C, $19, $03, $90, $1A, $03, $94, $1A, $03, $98, $1A, $03, $9C, $1A, $03
LA7E3:  .byte $B0, $1A, $03, $B8, $1A, $03, $C0, $19, $03, $C4, $19, $03, $C8, $19, $03, $CC
LA7F3:  .byte $19, $03, $FF

;Room #$1A
LA7F6:  .byte $03                       ;Attribute table data.
;Room object data:
LA7F7:  .byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA807:  .byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA817:  .byte $03, $81, $1B, $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $91, $1C, $03
LA827:  .byte $C0, $13, $03, $C1, $1C, $03, $C4, $13, $03, $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA837:  .byte $02, $A0, $02, $B1, $31, $81, $68, $FF

;Room #$1B
LA83F:  .byte $00                       ;Attribute table data.
;Room object data:
LA840:  .byte $00, $1F, $01, $04, $1D, $01, $07, $21, $01, $0C, $1F, $01, $10, $0C, $00, $14
LA850:  .byte $1F, $01, $17, $21, $01, $18, $1F, $01, $1F, $0C, $00, $25, $0B, $02, $2A, $0B
LA860:  .byte $02, $41, $22, $00, $4C, $23, $00, $50, $03, $02, $54, $22, $00, $59, $23, $00
LA870:  .byte $5F, $03, $02, $80, $07, $00, $82, $14, $03, $84, $14, $03, $86, $14, $03, $88
LA880:  .byte $14, $03, $8A, $14, $03, $8C, $14, $03, $8E, $07, $00, $92, $16, $03, $9C, $16
LA890:  .byte $03, $D0, $12, $00, $D4, $00, $02, $DC, $12, $00, $FD
;Room enemy/door data:
LA89B:  .byte $02, $A1, $02, $B0, $27, $07, $D9, $FF

;Room #$1C
LA8A3:  .byte $03                       ;Attribute table data.
;Room object data:
LA8A4:  .byte $00, $17, $03, $08, $17, $03, $B0, $18, $03, $B6, $05, $02, $B8, $18, $03, $D0
LA8B4:  .byte $18, $03, $D8, $18, $03, $FD
;Room enemy/door data:
LA8BA:  .byte $37, $87, $B7, $01, $80, $45, $11, $00, $3B, $21, $81, $9A, $FF

;Room #$1D
LA8C7:  .byte $01                       ;Attribute table data.
;Room object data:
LA8C8:  .byte $00, $15, $03, $08, $15, $03, $10, $24, $03, $13, $0B, $02, $18, $24, $03, $1C
LA8D8:  .byte $0B, $02, $1F, $25, $03, $20, $25, $03, $22, $22, $00, $2B, $23, $00, $5F, $03
LA8E8:  .byte $02, $60, $25, $03, $8E, $25, $03, $8F, $13, $03, $A0, $25, $03, $A2, $11, $00
LA8F8:  .byte $AC, $11, $00, $B3, $12, $00, $BB, $0C, $00, $BE, $1B, $03, $C3, $24, $03, $CE
LA908:  .byte $12, $00, $D1, $00, $02, $D3, $24, $03, $DC, $00, $02, $DE, $12, $00, $E0, $25
LA918:  .byte $03, $E3, $15, $03, $FD
;Room enemy/door data:
LA91D:  .byte $02, $A0, $01, $48, $95, $FF

;Room #$1E
LA923:  .byte $01                       ;Attribute table data.
;Room object data:
LA924:  .byte $00, $1E, $01, $02, $1D, $01, $08, $1D, $01, $1F, $1F, $01, $40, $1E, $01, $5F
LA934:  .byte $03, $02, $77, $0C, $00, $80, $1E, $01, $87, $1E, $01, $8D, $1F, $01, $C0, $1D
LA944:  .byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA949:  .byte $02, $A1, $11, $81, $35, $FF

;Room #$1F
LA94F:  .byte $01                       ;Attribute table data.
;Room object data:
LA950:  .byte $00, $1D, $01, $08, $1D, $01, $10, $1E, $01, $50, $03, $02, $80, $1F, $01, $C0
LA960:  .byte $1D, $01, $C8, $1D, $01, $CC, $05, $02, $FD
;Room enemy/door data:
LA969:  .byte $02, $B1, $01, $88, $AB, $17, $07, $CD, $FF

;Room #$20
LA972:  .byte $01                       ;Attribute table data.
;Room object data:
LA973:  .byte $00, $1D, $01, $08, $1D, $01, $78, $0C, $00, $88, $21, $01, $C0, $1D, $01, $C8
LA983:  .byte $1D, $01, $CD, $05, $02, $FD
;Room enemy/door data:
LA989:  .byte $27, $87, $CE, $41, $80, $BC, $FF

;Room #$21
LA990:  .byte $01                       ;Attribute table data.
;Room object data:
LA991:  .byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA9A1:  .byte $03, $02, $80, $1D, $01, $88, $1D, $01, $B0, $1D, $01, $B8, $1D, $01, $C0, $1D
LA9B1:  .byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA9B6:  .byte $02, $A1, $02, $B1, $21, $81, $68, $FF

;Room #$22
LA9BE:  .byte $03                       ;Attribute table data.
;Room object data:
LA9BF:  .byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA9CF:  .byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA9DF:  .byte $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $C0, $13, $03, $C4, $13, $03
LA9EF:  .byte $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA9F6:  .byte $02, $A1, $02, $B1, $41, $81, $68, $FF

;Room #$23
LA9FE:  .byte $00                       ;Attribute table data.
;Room object data:
LA9FF:  .byte $00, $10, $00, $0E, $06, $00, $16, $0D, $00, $2D, $09, $01, $34, $08, $01, $40
LAA0F:  .byte $10, $00, $4B, $0E, $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10
LAA1F:  .byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $D4, $00, $02, $FD
;Room enemy/door data:
LAA2D:  .byte $02, $A1, $01, $03, $38, $FF

;Room #$24
LAA33:  .byte $00                       ;Attribute table data.
;Room object data:
LAA34:  .byte $00, $07, $00, $0E, $07, $00, $19, $11, $00, $1D, $09, $01, $32, $08, $01, $4C
LAA44:  .byte $11, $00, $50, $03, $02, $5E, $07, $00, $80, $10, $00, $84, $10, $00, $88, $10
LAA54:  .byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LAA5F:  .byte $02, $B1, $41, $80, $75, $51, $00, $7A, $01, $83, $45, $FF