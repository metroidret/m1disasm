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

;Room #$00
LA8AF:  .byte $02                       ;Attribute table data.
;Room object data:
LA8B0:  .byte $40, $01, $03, $48, $01, $03, $50, $03, $02, $5F, $03, $02, $FF

;Room #$01
LA8BD:  .byte $02                       ;Attribute table data.
;Room object data:
LA8BE:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA8C5:  .byte $03                       ;Attribute table data.
;Room object data:
LA8C6:  .byte $00, $0C, $03, $08, $0C, $03, $0F, $09, $03, $5F, $04, $02, $62, $13, $02, $6A
LA8D6:  .byte $13, $02, $82, $0E, $02, $85, $12, $01, $8A, $0E, $02, $8D, $12, $01, $8F, $09
LA8E6:  .byte $03, $C4, $0F, $03, $C8, $0F, $03, $D3, $10, $03, $DB, $0A, $03, $E0, $0A, $03
LA8F6:  .byte $E8, $0A, $03, $FF

;Room #$03
LA8FA:  .byte $00                       ;Attribute table data.
;Room object data:
LA8FB:  .byte $00, $0C, $03, $08, $0C, $03, $62, $13, $02, $6A, $13, $02, $82, $0E, $02, $85
LA90B:  .byte $12, $01, $8A, $0E, $02, $8D, $12, $01, $C4, $0F, $03, $C8, $0F, $03, $D0, $0D
LA91B:  .byte $02, $D3, $10, $03, $DB, $0A, $03, $E2, $0A, $03, $EA, $0A, $03, $FF

;Room #$04
LA929:  .byte $03                       ;Attribute table data.
;Room object data:
LA92A:  .byte $00, $09, $03, $01, $0A, $03, $03, $11, $03, $08, $0C, $03, $0E, $1C, $03, $52
LA93A:  .byte $07, $01, $53, $08, $02, $6A, $13, $02, $80, $09, $03, $8A, $0E, $02, $8D, $12
LA94A:  .byte $01, $91, $0B, $03, $CB, $1C, $03, $CC, $1C, $03, $D8, $0D, $02, $DB, $00, $02
LA95A:  .byte $E0, $0A, $03, $FF

;Room #$05
LA95E:  .byte $03                       ;Attribute table data.
;Room object data:
LA95F:  .byte $00, $14, $03, $08, $14, $03, $50, $04, $02, $80, $14, $03, $88, $14, $03, $D0
LA96F:  .byte $14, $03, $D8, $14, $03, $FF

;Room #$06
LA975:  .byte $03                       ;Attribute table data.
;Room object data:
LA976:  .byte $00, $14, $03, $08, $14, $03, $95, $14, $03, $D0, $14, $03, $D8, $14, $03, $FD
;Room enemy/door data:
LA986:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $B3, $FF

;Room #$07
LA990:  .byte $03                       ;Attribute table data.
;Room object data:
LA991:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $D0, $15, $03, $D8
LA9A1:  .byte $15, $03, $FD
;Room enemy/door data:
LA9A4:  .byte $31, $01, $69, $41, $00, $B5, $FF

;Room #$08
LA9AB:  .byte $01                       ;Attribute table data.
;Room object data:
LA9AC:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $D0, $17, $03, $D4
LA9BC:  .byte $00, $02, $D7, $17, $03, $DC, $17, $03, $FD
;Room enemy/door data:
LA9C5:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $D4, $FF

;Room #$09
LA9CF:  .byte $01                       ;Attribute table data.
;Room object data:
LA9D0:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $5F, $03, $02, $8C
LA9E0:  .byte $17, $03, $B8, $17, $03, $CC, $17, $03, $D0, $00, $02, $D2, $17, $03, $FD
;Room enemy/door data:
LA9EF:  .byte $02, $A0, $FF

;Room #$0A
LA9F2:  .byte $03                       ;Attribute table data.
;Room object data:
LA9F3:  .byte $00, $19, $03, $01, $1A, $03, $04, $1B, $01, $09, $12, $01, $0E, $1A, $03, $0F
LAA03:  .byte $19, $03, $34, $12, $01, $4B, $1B, $01, $50, $03, $02, $5E, $1A, $03, $80, $19
LAA13:  .byte $03, $81, $1A, $03, $82, $1B, $01, $88, $18, $03, $8F, $19, $03, $B1, $18, $03
LAA23:  .byte $B8, $18, $03, $FD
;Room enemy/door data:
LAA27:  .byte $02, $B0, $31, $01, $A5, $41, $00, $48, $51, $01, $6A, $FF

;Room #$0B
LAA33:  .byte $03                       ;Attribute table data.
;Room object data:
LAA34:  .byte $00, $19, $03, $01, $1A, $03, $09, $12, $01, $0E, $1A, $03, $0F, $19, $03, $23
LAA44:  .byte $12, $01, $4B, $12, $01, $51, $1A, $03, $5E, $1A, $03, $66, $1B, $01, $80, $19
LAA54:  .byte $03, $82, $12, $01, $8F, $19, $03, $98, $12, $01, $A1, $1A, $03, $AE, $1A, $03
LAA64:  .byte $CB, $1B, $01, $D5, $12, $01, $FD
;Room enemy/door data:
LAA6B:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $D4, $FF

;Room #$0C
LAA75:  .byte $03                       ;Attribute table data.
;Room object data:
LAA76:  .byte $00, $19, $03, $01, $1A, $03, $02, $1E, $03, $0E, $1A, $03, $0F, $19, $03, $36
LAA86:  .byte $1E, $03, $3E, $1C, $03, $51, $1A, $03, $5E, $1A, $03, $71, $1C, $03, $72, $1E
LAA96:  .byte $03, $80, $19, $03, $8F, $19, $03, $A1, $1A, $03, $A6, $1E, $03, $AE, $1A, $03
LAAA6:  .byte $FD
;Room enemy/door data:
LAAA7:  .byte $01, $01, $45, $51, $00, $CB, $FF

;Room #$0D
LAAAE:  .byte $03                       ;Attribute table data.
;Room object data:
LAAAF:  .byte $00, $19, $03, $01, $18, $03, $08, $18, $03, $0F, $19, $03, $11, $18, $03, $18
LAABF:  .byte $18, $03, $50, $03, $02, $5E, $1A, $03, $80, $19, $03, $81, $1A, $03, $82, $1E
LAACF:  .byte $03, $8F, $19, $03, $AE, $1A, $03, $B6, $1E, $03, $BE, $1C, $03, $D1, $1A, $03
LAADF:  .byte $FD
;Room enemy/door data:
LAAE0:  .byte $02, $B0, $FF

;Room #$0E
LAAE3:  .byte $03                       ;Attribute table data.
;Room object data:
LAAE4:  .byte $00, $19, $03, $01, $18, $03, $08, $18, $03, $0F, $19, $03, $41, $1A, $03, $4E
LAAF4:  .byte $1A, $03, $80, $19, $03, $86, $1D, $03, $8F, $19, $03, $91, $1A, $03, $9E, $1A
LAB04:  .byte $03, $BB, $1B, $01, $C3, $1B, $01, $E1, $1A, $03, $EE, $1A, $03, $FF

;Room #$0F
LAB12:  .byte $03                       ;Attribute table data.
;Room object data:
LAB13:  .byte $00, $19, $03, $01, $1A, $03, $0E, $1A, $03, $0F, $19, $03, $12, $12, $01, $28
LAB23:  .byte $12, $01, $4C, $1B, $01, $51, $1A, $03, $55, $1B, $01, $5F, $03, $02, $80, $19
LAB33:  .byte $03, $83, $1B, $01, $8B, $12, $01, $8E, $1A, $03, $8F, $19, $03, $A1, $1A, $03
LAB43:  .byte $B1, $18, $03, $B8, $18, $03, $FF

;Room #$10
LAB4A:  .byte $03                       ;Attribute table data.
;Room object data:
LAB4B:  .byte $00, $19, $03, $01, $1A, $03, $0E, $1A, $03, $0F, $19, $03, $1A, $05, $01, $4D
LAB5B:  .byte $05, $01, $51, $1A, $03, $5E, $1A, $03, $80, $19, $03, $8A, $05, $01, $8F, $19
LAB6B:  .byte $03, $95, $05, $01, $A1, $1A, $03, $AE, $1A, $03, $CA, $05, $01, $E7, $05, $01
LAB7B:  .byte $FF

;Room #$11
LAB7C:  .byte $03                       ;Attribute table data.
;Room object data:
LAB7D:  .byte $00, $19, $03, $01, $1F, $01, $09, $1F, $01, $11, $1E, $03, $19, $1E, $03, $50
LAB8D:  .byte $03, $02, $80, $19, $03, $81, $1F, $01, $A1, $1E, $03, $B8, $1A, $03, $D1, $1F
LAB9D:  .byte $01, $D9, $1F, $01, $FD
;Room enemy/door data:
LABA2:  .byte $02, $B2, $FF

;Room #$12
LABA5:  .byte $01                       ;Attribute table data.
;Room object data:
LABA6:  .byte $00, $1F, $01, $08, $1F, $01, $0F, $19, $03, $10, $1E, $03, $17, $1E, $03, $5F
LABB6:  .byte $03, $02, $87, $1F, $01, $8F, $19, $03, $A7, $1A, $03, $C5, $1F, $01, $D0, $1F
LABC6:  .byte $01, $D7, $1F, $01, $FD
;Room enemy/door data:
LABCB:  .byte $02, $A0, $FF

;Room #$13
LABCE:  .byte $00                       ;Attribute table data.
;Room object data:
LABCF:  .byte $00, $1F, $01, $08, $1F, $01, $10, $1E, $03, $18, $1E, $03, $D0, $00, $02, $D3
LABDF:  .byte $1F, $01, $D8, $00, $02, $DC, $1F, $01, $FD
;Room enemy/door data:
LABE8:  .byte $01, $01, $45, $11, $00, $89, $FF

;Room #$14
LABEF:  .byte $00                       ;Attribute table data.
;Room object data:
LABF0:  .byte $00, $1F, $01, $08, $1F, $01, $10, $1E, $03, $18, $1E, $03, $94, $06, $03, $98
LAC00:  .byte $06, $03, $9C, $06, $03, $D0, $1F, $01, $D3, $00, $02, $DB, $00, $02, $FD
;Room enemy/door data:
LAC0F:  .byte $21, $00, $47, $31, $01, $6A, $FF