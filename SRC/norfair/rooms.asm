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

;Norfair Room Definitions

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
LA3AB:  .byte $02                       ;Attribute table data.
;Room object data:
LA3AC:  .byte $40, $01, $02, $48, $01, $02, $50, $04, $02, $5F, $04, $02, $FD, $02, $A1, $02
LA3BC:  .byte $B1, $FF

;Room #$01
LA3BE:  .byte $02                       ;Attribute table data.
;Room object data:
LA3BF:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA3C6:  .byte $03                       ;Attribute table data.
;Room object data:
LA3C7:  .byte $00, $0B, $03, $04, $06, $03, $08, $06, $03, $0C, $0B, $03, $40, $07, $03, $4E
LA3D7:  .byte $07, $03, $76, $08, $01, $79, $08, $01, $90, $07, $03, $96, $09, $00, $9E, $07
LA3E7:  .byte $03, $A4, $06, $03, $A8, $06, $03, $B7, $0A, $03, $E0, $06, $03, $EC, $06, $03
LA3F7:  .byte $FF

;Room #$03
LA3F8:  .byte $03                       ;Attribute table data.
;Room object data:
LA3F9:  .byte $00, $07, $03, $0E, $07, $03, $2B, $06, $03, $36, $06, $03, $50, $03, $02, $5F
LA409:  .byte $03, $02, $80, $0B, $03, $84, $0B, $03, $88, $0B, $03, $8C, $0B, $03, $8D, $17
LA419:  .byte $03, $C0, $0B, $03, $C4, $0B, $03, $C8, $0B, $03, $CC, $0B, $03, $CD, $17, $03
LA429:  .byte $FD
;Enemy/door data.
LA42A:  .byte $02, $A1, $02, $B1, $FF

;Room #$04
LA42F:  .byte $00                       ;Attribute table data.
;Room object data:
LA430:  .byte $00, $0D, $00, $08, $0D, $00, $10, $0C, $00, $14, $0C, $00, $1F, $1F, $00, $25
LA440:  .byte $0F, $02, $50, $0D, $00, $5F, $04, $02, $63, $0D, $00, $70, $0D, $00, $78, $12
LA450:  .byte $00, $80, $11, $00, $88, $12, $00, $89, $0D, $00, $90, $0E, $00, $94, $0D, $00
LA460:  .byte $9C, $0E, $00, $B0, $0C, $00, $BF, $0C, $00, $D1, $00, $02, $D7, $00, $02, $FD
;Enemy/door data.
LA470:  .byte $02, $A0, $FF

;Room #$05
LA473:  .byte $00                       ;Attribute table data.
;Room object data:
LA474:  .byte $00, $07, $03, $02, $06, $03, $06, $13, $02, $0A, $14, $02, $0E, $07, $03, $12
LA484:  .byte $0A, $03, $2B, $0C, $00, $47, $13, $02, $4B, $14, $02, $4E, $0C, $00, $4F, $14
LA494:  .byte $02, $50, $03, $02, $6B, $09, $00, $7A, $09, $00, $80, $0D, $00, $87, $02, $02
LA4A4:  .byte $89, $0D, $00, $FD, $02, $B1, $FF

;Room #$06
LA4AB:  .byte $03                       ;Attribute table data.
;Room object data:
LA4AC:  .byte $00, $0B, $03, $04, $0B, $03, $08, $0B, $03, $0C, $0B, $03, $30, $16, $03, $34
LA4BC:  .byte $16, $03, $38, $16, $03, $3C, $16, $03, $40, $0B, $03, $44, $0B, $03, $48, $0B
LA4CC:  .byte $03, $4C, $0B, $03, $80, $16, $03, $84, $16, $03, $88, $16, $03, $8C, $16, $03
LA4DC:  .byte $90, $0B, $03, $94, $0B, $03, $98, $0B, $03, $9C, $0B, $03, $D0, $0B, $03, $D4
LA4EC:  .byte $0B, $03, $D8, $0B, $03, $DC, $0B, $03, $FF

;Room #$07
LA4F5:  .byte $03                       ;Attribute table data.
;Room object data:
LA4F6:  .byte $00, $0B, $03, $04, $0B, $03, $08, $0B, $03, $0C, $0B, $03, $40, $0B, $03, $44
LA506:  .byte $0B, $03, $48, $0B, $03, $4C, $0B, $03, $74, $0B, $03, $80, $0B, $03, $88, $0B
LA516:  .byte $03, $8C, $0B, $03, $B0, $0B, $03, $B4, $0B, $03, $BC, $0B, $03, $C8, $0B, $03
LA526:  .byte $FF

;Room #$08
LA527:  .byte $03                       ;Attribute table data.
;Room object data:
LA528:  .byte $00, $07, $03, $08, $06, $03, $0E, $07, $03, $1D, $18, $01, $32, $06, $03, $50
LA538:  .byte $07, $03, $5F, $03, $02, $86, $10, $01, $8D, $18, $01, $8E, $07, $03, $A0, $07
LA548:  .byte $03, $A9, $10, $01, $BE, $0B, $03, $CD, $18, $01, $FD
;Enemy/door data.
LA553:  .byte $02, $A1, $41, $02, $8B, $51, $06, $76, $21, $82, $A3, $FF

;Room #$09
LA55F:  .byte $03                       ;Attribute table data.
;Room object data:
LA560:  .byte $00, $07, $03, $0E, $0B, $03, $2A, $06, $03, $33, $06, $03, $35, $06, $03, $43
LA570:  .byte $0A, $03, $4E, $0B, $03, $50, $07, $03, $6E, $07, $03, $80, $07, $03, $87, $06
LA580:  .byte $03, $97, $0A, $03, $BE, $0B, $03, $C0, $07, $03, $D4, $06, $03, $FD
;Enemy/door data.
LA58E:  .byte $01, $86, $25, $11, $82, $C5, $41, $06, $79, $FF

;Room #$0A
LA598:  .byte $02                       ;Attribute table data.
;Room object data:
LA599:  .byte $00, $07, $03, $05, $06, $03, $0C, $18, $01, $0E, $07, $03, $40, $07, $03, $57
LA5A9:  .byte $06, $03, $5F, $03, $02, $80, $0B, $03, $84, $00, $02, $8C, $0B, $03, $A4, $17
LA5B9:  .byte $03, $A5, $0B, $03, $A9, $0B, $03, $C0, $0B, $03, $C9, $0B, $03, $CD, $0B, $03
LA5C9:  .byte $D4, $17, $03, $E5, $0B, $03, $FD
;Enemy/door data.
LA5D0:  .byte $02, $A1, $31, $02, $36, $41, $86, $48, $FF

;Room #$0B
LA5D9:  .byte $01                       ;Attribute table data.
;Room object data:
LA5DA:  .byte $00, $07, $03, $0E, $07, $03, $12, $06, $03, $39, $06, $03, $50, $03, $02, $5E
LA5EA:  .byte $0B, $03, $80, $0B, $03, $84, $0B, $03, $88, $0B, $03, $8C, $17, $03, $8D, $0B
LA5FA:  .byte $03, $B0, $0B, $03, $B8, $0B, $03, $BC, $17, $03, $BD, $0B, $03, $C4, $0B, $03
LA60A:  .byte $EC, $17, $03, $FD
;Enemy/door data.
LA60E:  .byte $02, $B1, $41, $06, $2B, $51, $02, $1A, $FF

;Room #$0C
LA617:  .byte $03                       ;Attribute table data.
;Room object data:
LA618:  .byte $00, $07, $03, $0D, $18, $01, $0E, $07, $03, $4D, $18, $01, $50, $07, $03, $5E
LA628:  .byte $07, $03, $8D, $18, $01, $A0, $07, $03, $AE, $07, $03, $CD, $18, $01, $FD
;Enemy/door data.
LA637:  .byte $01, $02, $33, $31, $82, $88, $FF

;Room #$0D
LA63E:  .byte $03                       ;Attribute table data.
;Room object data:
LA63F:  .byte $10, $0B, $03, $14, $0B, $03, $18, $0B, $03, $1C, $0B, $03, $50, $03, $02, $5F
LA64F:  .byte $03, $02, $80, $07, $03, $81, $17, $03, $82, $06, $03, $86, $06, $03, $8A, $06
LA65F:  .byte $03, $8E, $07, $03, $97, $0A, $03, $C0, $0B, $03, $CC, $0B, $03, $D4, $19, $02
LA66F:  .byte $FD
;Enemy/door data.
LA670:  .byte $02, $A1, $02, $B1, $21, $0D, $E5, $FF

;Room #$0E
LA678:  .byte $03                       ;Attribute table data.
;Room object data:
LA679:  .byte $00, $07, $03, $0E, $07, $03, $2B, $06, $03, $30, $06, $03, $4A, $06, $03, $50
LA689:  .byte $03, $02, $5E, $07, $03, $80, $07, $03, $81, $06, $03, $AE, $07, $03, $B0, $07
LA699:  .byte $03, $B5, $06, $03, $FD
;Enemy/door data.
LA69E:  .byte $02, $B1, $11, $86, $A6, $31, $02, $EA, $21, $02, $39, $FF

;Room #$0F
LA6AA:  .byte $00                       ;Attribute table data.
;Room object data:
LA6AB:  .byte $00, $0E, $00, $04, $0D, $00, $0C, $0D, $00, $10, $0C, $00, $50, $04, $02, $80
LA6BB:  .byte $09, $00, $90, $0C, $00, $92, $09, $00, $AF, $09, $00, $B9, $09, $00, $D0, $0E
LA6CB:  .byte $00, $D3, $00, $02, $DB, $00, $02, $FD
;Enemy/door data.
LA6D3:  .byte $02, $B0, $01, $0D, $E7, $11, $8D, $ED, $31, $06, $AA, $FF

;Room #$10
LA6DF:  .byte $01                       ;Attribute table data.
;Room object data:
LA6E0:  .byte $00, $0D, $00, $04, $0D, $00, $0C, $0E, $00, $1F, $0C, $00, $5F, $03, $02, $8C
LA6F0:  .byte $09, $00, $94, $09, $00, $9F, $0C, $00, $D0, $00, $02, $D5, $00, $02, $DD, $0E
LA700:  .byte $00, $FD
;Enemy/door data.
LA702:  .byte $02, $A1, $21, $0D, $E2, $41, $0D, $EA, $31, $06, $85, $FF

;Room #$11
LA70E:  .byte $03                       ;Attribute table data.
;Room object data:
LA70F:  .byte $10, $0B, $03, $14, $0B, $03, $18, $0B, $03, $1C, $0B, $03, $50, $03, $02, $5C
LA71F:  .byte $0B, $03, $80, $07, $03, $81, $17, $03, $82, $06, $03, $86, $06, $03, $8A, $06
LA72F:  .byte $03, $8C, $0B, $03, $B0, $0B, $03, $B4, $19, $02, $BC, $17, $03, $CD, $0B, $03
LA73F:  .byte $D4, $0B, $03, $D8, $0B, $03, $FD
;Enemy/door data.
LA746:  .byte $02, $B1, $FF

;Room #$12
LA749:  .byte $03                       ;Attribute table data.
;Room object data:
LA74A:  .byte $00, $2D, $03, $08, $2D, $03, $10, $1B, $03, $14, $0A, $03, $50, $03, $02, $80
LA75A:  .byte $1B, $03, $9A, $1C, $03, $B0, $1B, $03, $B6, $1C, $03, $BE, $1C, $03, $C4, $1C
LA76A:  .byte $03, $D4, $00, $02, $D9, $00, $02, $FD
;Enemy/door data.
LA772:  .byte $02, $B1, $01, $00, $1C, $41, $00, $18, $21, $0D, $EC, $FF

;Room #$13
LA77E:  .byte $03                       ;Attribute table data.
;Room object data:
LA77F:  .byte $00, $2D, $03, $08, $2D, $03, $12, $0A, $03, $1E, $1B, $03, $5F, $03, $02, $69
LA78F:  .byte $1C, $03, $8D, $1B, $03, $A3, $1D, $03, $B0, $1C, $03, $CE, $1B, $03, $D0, $00
LA79F:  .byte $02, $D6, $00, $02, $FD
;Enemy/door data.
LA7A4:  .byte $02, $A1, $51, $80, $24, $41, $0D, $E2, $31, $86, $94, $11, $86, $69, $FF

;Room #$14
LA7B3:  .byte $03                       ;Attribute table data.
;Room object data:
LA7B4:  .byte $00, $2D, $03, $08, $2D, $03, $16, $0A, $03, $30, $1A, $01, $32, $1A, $01, $3A
LA7C4:  .byte $1A, $01, $3E, $1A, $01, $50, $1A, $01, $52, $1A, $01, $5A, $1A, $01, $5E, $1A
LA7D4:  .byte $01, $B7, $1C, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA7DF:  .byte $31, $0D, $E6, $51, $8D, $EB, $FF

;Room #$15
LA7E6:  .byte $01                       ;Attribute table data.
;Room object data:
LA7E7:  .byte $00, $2D, $03, $08, $2D, $03, $1C, $0A, $03, $52, $1C, $03, $58, $1C, $03, $5A
LA7F7:  .byte $1C, $03, $64, $1C, $03, $86, $1C, $03, $8C, $1C, $03, $8E, $1C, $03, $A0, $1C
LA807:  .byte $03, $D0, $1B, $03, $D3, $00, $02, $D4, $1B, $03, $D7, $00, $02, $DA, $1B, $03
LA817:  .byte $DD, $00, $02, $DE, $1B, $03, $FD
;Enemy/door data.
LA81E:  .byte $31, $0C, $1B, $01, $86, $54, $21, $86, $48, $51, $06, $7C, $FF

;Room #$16
LA82B:  .byte $03                       ;Attribute table data.
;Room object data:
LA82C:  .byte $00, $2D, $03, $08, $2D, $03, $12, $0A, $03, $1C, $0A, $03, $A2, $1D, $03, $AB
LA83C:  .byte $1D, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA845:  .byte $01, $0D, $E8, $11, $86, $94, $21, $86, $9C, $51, $00, $18, $FF

;Room #$17
LA852:  .byte $03                       ;Attribute table data.
;Room object data:
LA853:  .byte $00, $2D, $03, $08, $2D, $03, $16, $0A, $03, $80, $2D, $03, $8A, $2D, $03, $91
LA863:  .byte $0A, $03, $B8, $05, $01, $C7, $1D, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA872:  .byte $41, $06, $73, $51, $86, $7C, $31, $00, $27, $27, $87, $B9, $FF

;Room #$18
LA87F:  .byte $03                       ;Attribute table data.
;Room object data:
LA880:  .byte $00, $2D, $03, $08, $2D, $03, $1A, $0A, $03, $24, $1C, $03, $3E, $18, $01, $54
LA890:  .byte $18, $01, $7E, $18, $01, $A2, $1C, $03, $A7, $1D, $03, $BE, $1C, $03, $D0, $00
LA8A0:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8A5:  .byte $31, $00, $17, $41, $06, $97, $21, $8B, $E6, $01, $0D, $EC, $FF

;Room #$19
LA8B2:  .byte $00                       ;Attribute table data.
;Room object data:
LA8B3:  .byte $00, $0D, $00, $08, $0D, $00, $10, $1F, $00, $44, $1F, $00, $80, $12, $00, $81
LA8C3:  .byte $0D, $00, $90, $1F, $00, $98, $1F, $00, $AE, $0D, $00, $BB, $1F, $00, $D0, $00
LA8D3:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8D8:  .byte $31, $80, $17, $FF

;Room #$1A
LA8DC:  .byte $03                       ;Attribute table data.
;Room object data:
LA8DD:  .byte $00, $30, $01, $08, $30, $01, $80, $0D, $00, $84, $05, $02, $86, $05, $02, $88
LA8ED:  .byte $0D, $00, $8C, $20, $01, $94, $20, $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8FC:  .byte $27, $87, $85, $37, $87, $87, $41, $00, $29, $51, $00, $2C, $FF

;Room #$1B
LA909:  .byte $00                       ;Attribute table data.
;Room object data:
LA90A:  .byte $00, $20, $01, $04, $20, $01, $08, $20, $01, $0C, $2E, $01, $10, $2E, $01, $4C
LA91A:  .byte $2E, $01, $50, $03, $02, $80, $2E, $01, $8C, $21, $01, $98, $20, $01, $9C, $2E
LA92A:  .byte $01, $A2, $20, $01, $C0, $2E, $01, $D2, $00, $02, $DA, $00, $02, $FD
;Enemy/door data.
LA938:  .byte $02, $B1, $01, $0C, $98, $31, $8C, $3A, $11, $0C, $38, $41, $8B, $E6, $FF

;Room #$1C
LA947:  .byte $02                       ;Attribute table data.
;Room object data:
LA948:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $1C, $22, $02, $5F
LA958:  .byte $03, $02, $8C, $22, $02, $A8, $22, $02, $B0, $22, $02, $B1, $23, $01, $B4, $22
LA968:  .byte $02, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA970:  .byte $02, $A1, $41, $0E, $B1, $31, $00, $49, $FF

;Room #$1D
LA979:  .byte $02                       ;Attribute table data.
;Room object data:
LA97A:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $10, $22, $02, $50
LA98A:  .byte $03, $02, $80, $22, $02, $B4, $22, $02, $B8, $22, $02, $BC, $22, $02, $BD, $23
LA999:  .byte $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA9A2:  .byte $02, $B1, $01, $0E, $BD, $21, $00, $49, $FF

;Room #$1E
LA9AB:  .byte $02                       ;Attribute table data.
;Room object data:
LA9AC:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $B6, $22, $02, $B7
LA9BC:  .byte $23, $01, $C1, $22, $02, $CB, $22, $02, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA9CB:  .byte $51, $0E, $B7, $11, $06, $BD, $31, $86, $B3, $FF

;Room #$1F
LA9D5:  .byte $02                       ;Attribute table data.
;Room object data:
LA9D6:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $90, $22, $02, $9C
LA9E6:  .byte $22, $02, $A7, $23, $01, $B4, $22, $02, $B8, $22, $02, $D0, $00, $02, $D8, $00
LA9F6:  .byte $02, $FD
;Enemy/door data.
LA9F8:  .byte $41, $0E, $A7, $11, $02, $99, $FF

;Room #$20
LA9FF:  .byte $00                       ;Attribute table data.
;Room object data:
LAA00:  .byte $00, $2F, $03, $08, $2F, $03, $0B, $06, $03, $1C, $26, $03, $21, $25, $03, $22
LAA10:  .byte $06, $03, $5F, $04, $02, $8C, $26, $03, $B0, $25, $03, $B3, $23, $01, $B7, $24
LAA20:  .byte $03, $C2, $26, $03, $CE, $26, $03, $D0, $00, $02, $D6, $00, $02, $FD
;Enemy/door data.
LAA2E:  .byte $02, $A1, $41, $0E, $B3, $11, $86, $A9, $21, $0C, $43, $01, $0B, $EB, $FF

;Room #$21
LAA3D:  .byte $03                       ;Attribute table data.
;Room object data:
LAA3E:  .byte $00, $2F, $03, $08, $2F, $03, $10, $26, $03, $19, $06, $03, $50, $03, $02, $80
LAA4E:  .byte $26, $03, $AA, $25, $03, $B3, $24, $03, $CE, $24, $03, $D0, $00, $02, $D8, $00
LAA5E:  .byte $02, $FD
;Enemy/door data.
LAA60:  .byte $02, $B1, $31, $06, $BE, $51, $86, $9A, $41, $0C, $77, $21, $0C, $38, $FF

;Room #$22
LAA6F:  .byte $03                       ;Attribute table data.
;Room object data:
LAA70:  .byte $00, $2F, $03, $08, $2F, $03, $14, $06, $03, $17, $24, $03, $1E, $26, $03, $23
LAA80:  .byte $25, $03, $5F, $03, $02, $8D, $26, $03, $C2, $24, $03, $C7, $24, $03, $CC, $26
LAA90:  .byte $03, $D0, $00, $02, $D6, $00, $02, $FD
;Enemy/door data.
LAA98:  .byte $02, $A1, $01, $86, $B4, $11, $86, $B8, $21, $0C, $59, $31, $0C, $55, $FF

;Room #$23
LAAA7:  .byte $03                       ;Attribute table data.
;Room object data:
LAAA8:  .byte $00, $2F, $03, $08, $2F, $03, $14, $06, $03, $8D, $24, $03, $8F, $29, $03, $97
LAAB8:  .byte $24, $03, $B1, $24, $03, $B2, $05, $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAAC7:  .byte $31, $86, $88, $41, $06, $7C, $51, $00, $29, $17, $87, $B3, $FF

;Room #$24
LAAD4:  .byte $03                       ;Attribute table data.
;Room object data:
LAAD5:  .byte $00, $2F, $03, $08, $2F, $03, $50, $2A, $03, $56, $2A, $03, $63, $2A, $03, $6E
LAAE5:  .byte $2A, $03, $78, $2A, $03, $8C, $2A, $03, $9F, $2A, $03, $A1, $2A, $03, $A5, $2A
LAAF5:  .byte $03, $BA, $2A, $03, $C7, $2A, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB03:  .byte $01, $0D, $E8, $21, $8B, $ED, $31, $0B, $E9, $FF

;Room #$25
LAB0D:  .byte $00                       ;Attribute table data.
;Room object data:
LAB0E:  .byte $00, $2F, $03, $08, $2F, $03, $0A, $25, $03, $90, $2F, $03, $99, $05, $01, $9B
LAB1E:  .byte $24, $03, $9F, $06, $03, $A7, $06, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB2D:  .byte $01, $0C, $27, $37, $07, $9A, $FF

;Room #$26
LAB34:  .byte $00                       ;Attribute table data.
;Room object data:
LAB35:  .byte $00, $0E, $00, $04, $0D, $00, $0C, $0E, $00, $20, $0C, $00, $2F, $0C, $00, $52
LAB45:  .byte $1F, $00, $60, $28, $03, $64, $1F, $00, $6F, $25, $03, $7F, $29, $03, $8E, $1F
LAB55:  .byte $00, $97, $1F, $00, $CB, $1F, $00, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB63:  .byte $31, $86, $54, $41, $86, $87, $51, $0D, $E9, $01, $8B, $E5, $FF

;Room #$27
LAB70:  .byte $02                       ;Attribute table data.
;Room object data:
LAB71:  .byte $00, $20, $01, $04, $20, $01, $08, $20, $01, $0C, $20, $01, $10, $2C, $01, $50
LAB81:  .byte $04, $02, $80, $2C, $01, $81, $15, $03, $87, $27, $03, $8A, $27, $03, $8C, $27
LAB91:  .byte $03, $8E, $27, $03, $C0, $2C, $01, $D2, $00, $02, $DA, $00, $02, $FD
;Enemy/door data.
LAB9F:  .byte $02, $B1, $51, $0D, $E9, $FF

;Room #$28
LABA5:  .byte $02                       ;Attribute table data.
;Room object data:
LABA6:  .byte $00, $30, $01, $08, $30, $01, $10, $2C, $01, $17, $15, $03, $50, $03, $02, $80
LABB6:  .byte $20, $01, $86, $2B, $00, $8A, $2B, $00, $A0, $2C, $01, $BC, $2B, $00, $D2, $00
LABC6:  .byte $02, $DA, $00, $02, $E0, $2C, $01, $FD
;Enemy/door data.
LABCE:  .byte $02, $B1, $01, $06, $77, $11, $86, $7C, $21, $00, $2A, $FF

;Room #$29
LABDA:  .byte $00                       ;Attribute table data.
;Room object data:
LABDB:  .byte $00, $30, $01, $05, $15, $03, $08, $30, $01, $50, $2B, $00, $55, $2B, $00, $6B
LABEB:  .byte $2B, $00, $91, $2B, $00, $A8, $2B, $00, $B3, $2B, $00, $CC, $2B, $00, $D0, $00
LABFB:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LAC00:  .byte $41, $06, $43, $51, $86, $47, $31, $06, $84, $21, $86, $99, $FF

;Room #$2A
LAC0D:  .byte $02                       ;Attribute table data.
;Room object data:
LAC0E:  .byte $00, $30, $01, $08, $30, $01, $15, $15, $03, $1E, $2C, $01, $5F, $03, $02, $8C
LAC1E:  .byte $20, $01, $97, $2B, $00, $AE, $2C, $01, $C2, $2B, $00, $D0, $00, $02, $D6, $00
LAC2E:  .byte $02, $EE, $2C, $01, $FD
;Enemy/door data.
LAC33:  .byte $02, $A1, $21, $86, $88, $31, $86, $B3, $41, $0B, $E0, $51, $8B, $EB, $FF

;Room #$2B
LAC42:  .byte $00                       ;Attribute table data.
;Room object data:
LAC43:  .byte $00, $30, $01, $08, $30, $01, $2B, $18, $01, $55, $18, $01, $6B, $18, $01, $95
LAC53:  .byte $18, $01, $A0, $2C, $01, $AE, $2C, $01, $B8, $2C, $01, $D0, $00, $02, $D8, $00
LAC63:  .byte $02, $FD
;Enemy/door data.
LAC65:  .byte $31, $86, $45, $21, $06, $A9, $11, $86, $9E, $01, $0B, $E3, $FF

;Room #$2C
LAC72:  .byte $00                       ;Attribute table data.
;Room object data:
LAC73:  .byte $00, $30, $01, $08, $30, $01, $46, $2C, $01, $86, $2C, $01, $94, $20, $01, $AF
LAC83:  .byte $20, $01, $C0, $30, $01, $CB, $20, $01, $D0, $00, $02, $D5, $20, $01, $D9, $00
LAC93:  .byte $02, $FD
;Enemy/door data.
LAC95:  .byte $01, $0C, $59, $FF

;Room #$2D
LAC99:  .byte $03                       ;Attribute table data.
;Room object data:
LAC9A:  .byte $00, $07, $03, $0E, $07, $03, $19, $06, $03, $44, $06, $03, $50, $07, $03, $5E
LACAA:  .byte $07, $03, $93, $06, $03, $A0, $07, $03, $AE, $07, $03, $C7, $06, $03, $FF
