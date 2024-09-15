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

;Room #$00
LA441:
    .byte $02                               ;Attribute table data.
;Room object data:
LAA42:  .byte $40, $01, $02, $48, $01, $02, $50, $03, $02, $5F, $03, $02, $FD
;Room enemy/door data:
LAA4F:  .byte $02, $A1, $02, $B1, $FF

;Room #$01
LA454:  .byte $02                               ;Attribute table data.
;Room object data:
LA455:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA45C:  .byte $03                               ;Attribute table data.
;Room object data:
LA45D:  .byte $00, $0B, $03, $0E, $0B, $03, $50, $0B, $03, $5E, $0B, $03, $A0, $0B, $03, $AE
LA46D:  .byte $0B, $03, $FD
;Room enemy/door data:
LA470:  .byte $01, $03, $42, $11, $83, $8A, $21, $03, $B5, $31, $02, $59, $41, $02, $A3, $FF

;Room #$03
LA480:  .byte $02                               ;Attribute table data.
;Room object data:
LA481:  .byte $00, $0B, $03, $02, $09, $03, $0E, $0B, $03, $50, $0B, $03, $56, $0A, $03, $5F
LA491:  .byte $03, $02, $8B, $0A, $03, $8E, $0B, $03, $92, $0A, $03, $A0, $0B, $03, $C7, $09
LA4A1:  .byte $03, $DE, $0B, $03, $FD
;Room enemy/door data:
LA4A6:  .byte $02, $A1, $01, $85, $47, $11, $05, $BA, $21, $03, $08, $31, $83, $53, $41, $83
LA4B6:  .byte $97, $51, $03, $C5, $FF

;Room #$04
LA4BB:  .byte $03                               ;Attribute table data.
;Room object data:
LA4BC:  .byte $00, $0B, $03, $04, $0A, $03, $0E, $0B, $03, $47, $09, $03, $50, $03, $02, $5E
LA4CC:  .byte $0B, $03, $80, $0B, $03, $82, $0A, $03, $9C, $0A, $03, $AE, $0B, $03, $B6, $0A
LA4DC:  .byte $03, $C0, $0B, $03, $FD
;Room enemy/door data:
LA4E1:  .byte $02, $B1, $41, $03, $45, $51, $03, $BB, $31, $05, $39, $FF

;Room #$05
LA4ED:  .byte $03                               ;Attribute table data.
;Room object data:
LA4EE:  .byte $00, $0B, $03, $0E, $0B, $03, $15, $09, $03, $50, $03, $02, $57, $0A, $03, $5F
LA4FE:  .byte $03, $02, $80, $0B, $03, $82, $0A, $03, $8B, $0A, $03, $8E, $0B, $03, $B0, $0B
LA50E:  .byte $03, $C6, $09, $03, $CE, $0B, $03, $FD
;Room enemy/door data:
LA516:  .byte $02, $A1, $02, $B1, $01, $83, $43, $31, $85, $48, $51, $05, $B7, $FF

;Room #$06
LA524:  .byte $03                               ;Attribute table data.
;Room object data:
LA525:  .byte $00, $0B, $03, $0E, $0B, $03, $12, $0A, $03, $37, $0A, $03, $50, $0B, $03, $5E
LA535:  .byte $0B, $03, $73, $0A, $03, $8A, $0A, $03, $A0, $0B, $03, $AE, $0B, $03, $B6, $09
LA545:  .byte $03, $FD
;Room enemy/door data:
LA547:  .byte $01, $03, $B3, $11, $03, $3C, $21, $05, $A8, $31, $05, $64, $51, $85, $7B, $41
LA557:  .byte $05, $28, $FF

;Room #$07
LA55A:  .byte $03                               ;Attribute table data.
;Room object data:
LA55B:  .byte $00, $0D, $03, $08, $0D, $03, $54, $06, $03, $5A, $06, $03, $67, $07, $03, $A0
LA56B:  .byte $0B, $03, $AE, $0B, $03, $C2, $06, $03, $CD, $06, $03, $D2, $00, $02, $D6, $00
LA57B:  .byte $02, $FD
;Room enemy/door data:
LA57D:  .byte $51, $05, $B2, $41, $05, $BD, $31, $05, $67, $FF

;Room #$08
LA587:  .byte $03                               ;Attribute table data.
;Room object data:
LA588:  .byte $00, $1E, $03, $04, $1E, $03, $08, $1E, $03, $0C, $1E, $03, $38, $1E, $03, $40
LA598:  .byte $1E, $03, $44, $1E, $03, $4C, $1E, $03, $74, $1E, $03, $78, $1E, $03, $80, $1E
LA5A8:  .byte $03, $8C, $1E, $03, $B0, $1E, $03, $B4, $1E, $03, $B8, $1E, $03, $CC, $1E, $03
LA5B8:  .byte $FF

;Room #$09(Starting room).
LA5B9:  .byte $03                               ;Attribute table data.
;Room object data:
LA5BA:  .byte $00, $11, $01, $08, $11, $01, $35, $1D, $03, $3B, $1D, $03, $55, $0B, $03, $5A
LA5CA:  .byte $0B, $03, $C5, $16, $00, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA5D6:  .byte $51, $05, $25, $41, $05, $2B, $FF

;Room #$0A
LA5DD:  .byte $00                               ;Attribute table data.
;Room object data:
LA5DE:  .byte $00, $14, $00, $08, $14, $00, $0F, $15, $00, $10, $15, $00, $14, $15, $00, $25
LA5EE:  .byte $08, $03, $50, $14, $00, $58, $0C, $00, $5F, $04, $02, $60, $14, $00, $70, $13
LA5FE:  .byte $00, $80, $14, $00, $88, $14, $00, $90, $16, $00, $99, $16, $00, $B3, $15, $00
LA60E:  .byte $BC, $15, $00, $FD
;Room enemy/door data:
LA612:  .byte $02, $A0, $FF

;Room #$0B
LA615:  .byte $00                               ;Attribute table data.
;Room object data:
LA616:  .byte $00, $15, $00, $01, $16, $00, $08, $16, $00, $0F, $15, $00, $4F, $15, $00, $50
LA626:  .byte $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $FD
;Room enemy/door data:
LA632:  .byte $02, $B1, $FF

;Room #$0C
LA635:  .byte $02                               ;Attribute table data.
;Room object data:
LA636:  .byte $00, $1B, $02, $08, $1B, $02, $10, $1A, $02, $50, $03, $02, $80, $1A, $02, $82
LA646:  .byte $19, $02, $BC, $19, $02, $C0, $1A, $02, $C6, $1B, $02, $D1, $00, $02, $D9, $00
LA656:  .byte $02, $FD
;Room enemy/door data:
LA658:  .byte $02, $B1, $51, $02, $5A, $31, $02, $AA, $FF

;Room #$0D
LA661:  .byte $02                               ;Attribute table data.
;Room object data:
LA662:  .byte $00, $1B, $02, $08, $1B, $02, $1E, $1A, $02, $5F, $03, $02, $8C, $19, $02, $8E
LA672:  .byte $1A, $02, $B7, $1A, $02, $C2, $1A, $02, $CE, $1A, $02, $D0, $00, $02, $D7, $00
LA682:  .byte $02, $FD
;Room enemy/door data:
LA684:  .byte $02, $A1, $31, $05, $B3, $51, $02, $44, $FF

;Room #$0E
LA68D:  .byte $02                               ;Attribute table data.
;Room object data:
LA68E:  .byte $00, $1B, $02, $08, $1B, $02, $AC, $19, $02, $B4, $19, $02, $B8, $1A, $02, $D0
LA69E:  .byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6A4:  .byte $01, $82, $28, $11, $05, $A5, $21, $02, $8B, $31, $02, $BD, $FF

;Room #$0F
LA6B1:  .byte $03                               ;Attribute table data.
;Room object data:
LA6B2:  .byte $00, $1B, $02, $08, $1B, $02, $59, $06, $03, $92, $19, $02, $AC, $19, $02, $BB
LA6C2:  .byte $19, $02, $C0, $06, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CE:  .byte $01, $02, $3B, $11, $02, $B8, $51, $85, $84, $41, $05, $49, $FF

;Room #$10
LA6DB:  .byte $02                               ;Attribute table data.
;Room object data:
LA6DC:  .byte $00, $17, $02, $08, $17, $02, $10, $17, $02, $18, $17, $02, $50, $03, $02, $5F
LA6EC:  .byte $03, $02, $80, $1A, $02, $82, $19, $02, $86, $2E, $02, $87, $1B, $02, $8E, $1A
LA6FC:  .byte $02, $C0, $1A, $02, $CE, $1A, $02, $D2, $12, $02, $D8, $12, $02, $FD
;Room enemy/door data:
LA70A:  .byte $02, $A1, $02, $B1, $01, $02, $5C, $11, $02, $A7, $FF

;Room #$11
LA715:  .byte $03                               ;Attribute table data.
;Room object data:
LA716:  .byte $00, $0B, $03, $02, $06, $03, $0E, $0B, $03, $50, $0B, $03, $52, $06, $03, $5E
LA726:  .byte $0B, $03, $A0, $0B, $03, $A2, $06, $03, $AE, $0B, $03, $FD
;Room enemy/door data:
LA732:  .byte $01, $83, $DD, $11, $03, $35, $21, $02, $7D, $FF

;Room #$12
LA73C:  .byte $03                               ;Attribute table data.
;Room object data:
LA73D:  .byte $00, $0B, $03, $02, $11, $01, $0A, $11, $01, $50, $03, $02, $80, $0B, $03, $82
LA74D:  .byte $0A, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA756:  .byte $02, $B1, $01, $05, $C7, $11, $05, $CB, $51, $04, $3A, $41, $04, $29, $31, $04
LA766:  .byte $1E, $FF

;Room #$13
LA768:  .byte $03                               ;Attribute table data.
;Room object data:
LA769:  .byte $00, $11, $01, $07, $10, $03, $0E, $0B, $03, $5F, $03, $02, $8A, $09, $03, $8E
LA779:  .byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA782:  .byte $02, $A1, $01, $05, $7B, $11, $05, $C8, $FF

;Room #$14
LA78B:  .byte $01                               ;Attribute table data.
;Room object data:
LA78C:  .byte $00, $11, $01, $08, $11, $01, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA799:  .byte $51, $04, $14, $21, $04, $38, $41, $04, $2E, $FF

;Room #$15
LA7A3:  .byte $03                               ;Attribute table data.
;Room object data:
LA7A4:  .byte $00, $10, $03, $08, $10, $03, $90, $1F, $01, $96, $1F, $01, $AA, $05, $03, $AC
LA7B4:  .byte $1F, $01, $BA, $10, $03, $C4, $05, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA7C3:  .byte $51, $05, $89, $37, $87, $AB, $21, $06, $23, $17, $07, $C5, $FF

;Room #$16
LA7D0:  .byte $01                               ;Attribute table data.
;Room object data:
LA7D1:  .byte $00, $11, $01, $08, $11, $01, $B0, $1F, $01, $B6, $05, $03, $B8, $05, $03, $BC
LA7E1:  .byte $1F, $01, $C6, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA7EA:  .byte $07, $07, $B7, $47, $87, $B9, $FF

;Room #$17
LA7F1:  .byte $03                               ;Attribute table data.
;Room object data:
LA7F2:  .byte $00, $11, $01, $08, $10, $03, $4A, $1E, $03, $6B, $1E, $03, $8C, $1E, $03, $A6
LA802:  .byte $15, $00, $B3, $1D, $03, $B9, $1D, $03, $C3, $0C, $00, $C8, $0C, $00, $D0, $10
LA812:  .byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA817:  .byte $41, $05, $B4, $FF

;Room #$18
LA81B:  .byte $01                               ;Attribute table data.
;Room object data:
LA81C:  .byte $00, $0B, $03, $01, $11, $01, $09, $11, $01, $0E, $0B, $03, $50, $03, $02, $5F
LA82C:  .byte $03, $02, $64, $0D, $03, $66, $20, $01, $80, $1F, $01, $84, $20, $01, $88, $20
LA83C:  .byte $01, $8C, $1E, $03, $A6, $20, $01, $B0, $0B, $03, $BE, $0B, $03, $E6, $20, $01
LA84C:  .byte $FD
;Room enemy/door data:
LA84D:  .byte $02, $A1, $02, $B1, $31, $05, $56, $01, $85, $5A, $21, $05, $D9, $FF

;Room #$19
LA85B:  .byte $01                               ;Attribute table data.
;Room object data:
LA85C:  .byte $00, $10, $03, $04, $1F, $01, $08, $1F, $01, $0C, $11, $01, $12, $31, $03, $44
LA86C:  .byte $1F, $01, $48, $1F, $01, $84, $1F, $01, $88, $1F, $01, $D0, $1F, $01, $D4, $1F
LA87C:  .byte $01, $D8, $10, $03, $FD
;Room enemy/door data:
LA881:  .byte $51, $05, $C0, $41, $05, $CA, $31, $06, $3C, $FF

;Room #$1A
LA88B:  .byte $02                               ;Attribute table data.
;Room object data:
LA88C:  .byte $00, $28, $02, $01, $2D, $02, $09, $2D, $02, $50, $04, $02, $80, $28, $02, $81
LA89C:  .byte $14, $00, $95, $15, $00, $D0, $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LA8A8:  .byte $02, $B0, $01, $05, $C7, $11, $85, $CA, $FF

;Room #$1B
LA8B1:  .byte $00                               ;Attribute table data.
;Room object data:
LA8B2:  .byte $00, $14, $00, $04, $15, $00, $08, $14, $00, $0A, $15, $00, $97, $06, $03, $A0
LA8C2:  .byte $0B, $03, $A6, $15, $00, $A8, $15, $00, $AE, $0B, $03, $B4, $06, $03, $BA, $06
LA8D2:  .byte $03, $C2, $06, $03, $D2, $00, $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA8DD:  .byte $41, $05, $AA, $21, $06, $17, $11, $05, $A4, $FF

;Room #$1C
LA8E7:  .byte $00                               ;Attribute table data.
;Room object data:
LA8E8:  .byte $00, $15, $00, $01, $0D, $03, $09, $0E, $01, $2A, $23, $01, $37, $22, $03, $4D
LA8F8:  .byte $0E, $01, $50, $03, $02, $6A, $16, $00, $6D, $0E, $01, $80, $14, $00, $87, $02
LA908:  .byte $02, $89, $14, $00, $FD
;Room enemy/door data:
LA90D:  .byte $02, $B1, $FF

;Room #$1D
LA910:  .byte $01                               ;Attribute table data.
;Room object data:
LA911:  .byte $00, $0E, $01, $08, $0E, $01, $44, $0E, $01, $84, $0F, $01, $94, $0E, $01, $B0
LA921:  .byte $0E, $01, $B8, $0E, $01, $FD
;Room enemy/door data:
LA927:  .byte $31, $06, $42, $FF

;Room #$1E
LA92B:  .byte $01                               ;Attribute table data.
;Room object data:
LA92C:  .byte $00, $0E, $01, $02, $2A, $01, $07, $25, $01, $08, $0E, $01, $10, $0E, $01, $12
LA93c:  .byte $2A, $01, $17, $25, $01, $18, $0E, $01, $50, $03, $02, $5F, $03, $02, $74, $26
LA94C:  .byte $01, $78, $26, $01, $80, $0E, $01, $88, $0E, $01, $C0, $24, $01, $CC, $24, $01
LA95C:  .byte $D4, $00, $02, $FD
;Room enemy/door data:
LA960:  .byte $02, $A1, $02, $B1, $11, $02, $52, $01, $03, $C8, $FF

;Room #$1F
LA96B:  .byte $01                               ;Attribute table data.
;Room object data:
LA96C:  .byte $00, $27, $01, $08, $27, $01, $10, $24, $01, $50, $03, $02, $80, $24, $01, $A6
LA97C:  .byte $26, $01, $B0, $0E, $01, $CA, $26, $01, $D8, $0E, $01, $FD
;Room enemy/door data:
LA988:  .byte $02, $B1, $01, $02, $2B, $11, $02, $BB, $21, $82, $5B, $31, $02, $8B, $FF

;Room #$20
LA997:  .byte $01                               ;Attribute table data.
;Room object data:
LA998:  .byte $00, $27, $01, $08, $27, $01, $1C, $24, $01, $20, $24, $01, $5F, $03, $02, $8C
LA9A8:  .byte $24, $01, $BA, $26, $01, $C4, $26, $01, $C8, $0E, $01, $D0, $0E, $01, $FD
;Room enemy/door data:
LA9B7:  .byte $02, $A1, $51, $02, $85, $41, $02, $C5, $31, $05, $BA, $21, $05, $C5, $FF

;Room #$21
LA9C6:  .byte $01                               ;Attribute table data.
;Room object data:
LA9C7:  .byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $38, $0E, $01, $A7, $26, $01, $B0
LA9D7:  .byte $24, $01, $B6, $24, $01, $BC, $24, $01, $C4, $05, $03, $D4, $27, $01, $DA, $00
LA9E7:  .byte $02, $FD
;Room enemy/door data:
LA9E9:  .byte $07, $07, $C5, $11, $05, $AC, $21, $05, $A8, $51, $06, $7A, $FF

;Room #$22
LA9F6:  .byte $01                               ;Attribute table data.
;Room object data:
LA9F7:  .byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $37, $25, $01, $48, $2A, $01, $4C
LAA07:  .byte $2A, $01, $68, $0E, $01, $78, $0E, $01, $A3, $26, $01, $B0, $0E, $01, $B8, $0E
LAA17:  .byte $01, $FD
;Room enemy/door data:
LAA19:  .byte $41, $06, $75, $21, $03, $85, $FF

;Room #$23
LAA20:  .byte $02                               ;Attribute table data.
;Room object data:
LAA21:  .byte $00, $27, $01, $08, $27, $01, $63, $29, $01, $73, $28, $02, $8B, $29, $01, $9B
LAA31:  .byte $28, $02, $C0, $26, $01, $C6, $26, $01, $D0, $0E, $01, $D8, $00, $02, $D9, $0E
LAA41:  .byte $01, $DE, $05, $03, $FD
;Room enemy/door data:
LAA46:  .byte $01, $85, $63, $11, $05, $8B, $21, $02, $6E, $47, $07, $DF, $31, $83, $A8, $FF

;Room #$24
LAA56:  .byte $01                               ;Attribute table data.
;Room object data:
LAA57:  .byte $00, $0E, $01, $08, $0E, $01, $40, $2B, $00, $48, $2B, $00, $50, $0E, $01, $53
LAA67:  .byte $20, $01, $58, $0E, $01, $5B, $20, $01, $60, $2B, $00, $68, $13, $00, $70, $27
LAA77:  .byte $01, $78, $27, $01, $80, $2B, $00, $88, $2B, $00, $90, $27, $01, $98, $27, $01
LAA87:  .byte $A0, $13, $00, $A8, $2B, $00, $B0, $0E, $01, $B8, $0E, $01, $FD
;Room enemy/door data:
LAA94:  .byte $01, $05, $4D, $11, $85, $6C, $21, $05, $8A, $31, $85, $AF, $41, $05, $47, $FF

;Room #$25
LAAA4:  .byte $02                               ;Attribute table data.
;Room object data:
LAAA5:  .byte $00, $27, $01, $05, $27, $01, $0A, $0E, $01, $23, $24, $01, $4A, $13, $00, $52
LAAB5:  .byte $24, $01, $59, $20, $01, $5A, $0E, $01, $6A, $2B, $00, $79, $0E, $01, $89, $2B
LAAC5:  .byte $00, $90, $28, $02, $94, $06, $03, $98, $0E, $01, $A8, $13, $00, $B0, $0E, $01
LAAD5:  .byte $B8, $0E, $01, $FD
;Room enemy/door data:
LAAD9:  .byte $51, $05, $4F, $41, $05, $6E, $31, $05, $8E, $21, $02, $48, $FF

;Room #$26
LAAE6:  .byte $01                               ;Attribute table data.
;Room object data:
LAAE7:  .byte $00, $0E, $01, $08, $27, $01, $40, $2B, $00, $50, $0E, $01, $56, $20, $01, $60
LAAF7:  .byte $2B, $00, $68, $2C, $00, $80, $27, $01, $8B, $24, $01, $D0, $00, $02, $D8, $00
LAB07:  .byte $02, $FD
;Room enemy/door data:
LAB09:  .byte $51, $05, $67, $41, $05, $7E, $21, $05, $7B, $31, $03, $49, $11, $02, $C6, $FF

;Room #$27
LAB19:  .byte $03                               ;Attribute table data.
;Room object data:
LAB1A:  .byte $00, $0B, $03, $02, $11, $01, $09, $11, $01, $50, $04, $02, $80, $0B, $03, $82
LAB2A:  .byte $1E, $03, $B6, $1D, $03, $B7, $1D, $03, $C2, $09, $03, $C8, $1D, $03, $D0, $10
LAB3A:  .byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAB3F:  .byte $02, $B0, $11, $04, $38, $31, $06, $27, $FF

;Room #$28
LAB48:  .byte $00                               ;Attribute table data.
;Room object data:
LAB49:  .byte $00, $2D, $02, $08, $2D, $02, $0F, $28, $02, $5F, $03, $02, $87, $14, $00, $8F
LAB59:  .byte $28, $02, $9A, $15, $00, $C3, $26, $01, $D0, $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LAB68:  .byte $02, $A1, $01, $06, $23, $31, $05, $7D, $FF

;Room #$29
LAB71:  .byte $02                               ;Attribute table data.
;Room object data:
LAB72:  .byte $00, $2D, $02, $08, $2D, $02, $C2, $26, $01, $C7, $26, $01, $C9, $26, $01, $D0
LAB82:  .byte $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LAB88:  .byte $41, $86, $25, $51, $06, $2A, $21, $05, $CB, $FF

;Room #$2A
LAB92:  .byte $00                               ;Attribute table data.
;Room object data:
LAB93:  .byte $00, $11, $01, $08, $11, $01, $68, $21, $02, $78, $15, $00, $95, $15, $00, $A0
LABA3:  .byte $0B, $03, $AE, $0B, $03, $BB, $15, $00, $C2, $06, $03, $D2, $00, $02, $D6, $00
LABB3:  .byte $02, $FD
;Room enemy/door data:
LABB5:  .byte $01, $05, $58, $11, $05, $85, $31, $06, $26, $FF

;Room #$2B(Bridge to Tourian).
LABBF:  .byte $02                               ;Attribute table data.
;Room object data:
LABC0:  .byte $00, $30, $00, $01, $1A, $02, $02, $30, $00, $03, $1A, $02, $05, $1C, $02, $0A
LABD0:  .byte $1B, $02, $0F, $30, $00, $10, $30, $00, $14, $30, $00, $1F, $30, $00, $2C, $18
LABE0:  .byte $02, $35, $18, $02, $41, $19, $02, $44, $2F, $02, $45, $18, $02, $46, $2F, $02
LABF0:  .byte $50, $04, $02, $53, $19, $02, $5F, $04, $02, $64, $1C, $02, $65, $1C, $02, $68
LAC00:  .byte $2F, $02, $80, $15, $00, $81, $19, $02, $8D, $19, $02, $9C, $19, $02, $9F, $15
LAC10:  .byte $00, $C0, $30, $00, $D1, $00, $02, $D7, $00, $02, $DF, $30, $00, $FD
;Room enemy/door data:
LAC1E:  .byte $02, $A0, $02, $B1, $06, $FF

;Room #$2C
LAC24:  .byte $00                               ;Attribute table data.
;Room object data:
LAC25:  .byte $00, $16, $00, $07, $16, $00, $0E, $16, $00, $1F, $15, $00, $20, $15, $00, $40
LAC35:  .byte $30, $00, $5F, $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $A0, $15
LAC45:  .byte $00, $AF, $15, $00, $FD
;Room enemy/door data:
LAC4A:  .byte $02, $A1, $FF

;Room #$2D
LAC4D:  .byte $03                               ;Attribute table data.
;Room object data:
LAC4E:  .byte $00, $11, $01, $08, $11, $01, $1E, $1E, $03, $5F, $04, $02, $8B, $10, $03, $9E
LAC5E:  .byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAC67:  .byte $02, $A1, $FF

;Room #$2E
LAC6A:  .byte $03                               ;Attribute table data.
;Room object data:
LAC6B:  .byte $00, $0B, $03, $0E, $0B, $03, $50, $03, $02, $5E, $0B, $03, $80, $0B, $03, $AE
LAC7B:  .byte $0B, $03, $D0, $0B, $03, $FD
;Room enemy/door data:
LAC81:  .byte $02, $B1, $FF