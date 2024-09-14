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

;Tourian Item Data

;The way the bytes work int the special items table is as follows:
;Long entry(one with a data word in it):
;Byte 0=Y coordinate of room on the world map.
;Word 0=Address of next entry in the table that has a different Y coordinate.--> 
;       $FFFF=No more items with different Y coordinates.
;Byte 1=X coordinate of room in the world map.
;Byte 2=byte offset-1 of next special item in the table that has the same-->
;       Y coordinate(short entry). $FF=No more items with different X-->
;       coordinates until next long entry.
;Byte 3=Item type. See list below for special item types.
;Bytes 4 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;       It is possible to have multiple special items in one room.
;Short entry(one without a data word in it):
;Byte 0=X coordinate of room in the world map(Y coordinate is the same-->
;       as the last long item entry in the table).
;Byte 1=byte offset-1 of next special item in the table that has the same-->
;       Y coordinate(short entry). $FF=No more items with different X-->
;       coordinates until next long entry.
;Byte 2=Item type. See list below for special item types.
;Bytes 3 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;       It is possible to have multiple special items in one room.
;
;Special item types:
;#$01=Squeept.
;#$02=Power up.
;#$03=Mellows, Memus or Melias.
;#$04=Elevator.
;#$05=Mother brain room cannon.
;#$06=Mother brain.
;#$07=Zeebetite.
;#$08=Rinka.
;#$09=Door.
;#$0A=Palette change room.

SpecItmsTbl:

;Elevator to end.
LA83B:  .byte $03
LA83C:  .word $A843
LA83E:  .byte $01, $FF, $04, $8F, $00 

;Elevator to Brinstar.
LA843:  .byte $04
LA844:  .word $A84B
LA846:  .byte $03, $FF, $04, $83, $00

;10 missile door.
LA84B:  .byte $07
LA84C:  .word $A85B
LA84E:  .byte $03, $05, $09, $A2, $00

;Rinkas
LA853:  .byte $04, $04, $08, $00

;Rinkas
LA857:  .byte $09, $FF, $08, $00

;Rinkas
LA85B:  .byte $08
LA85C:  .word $A862
LA85E:  .byte $0A, $FF, $18, $00

;Rinkas
LA862:  .byte $09
LA863:  .word $A869
LA865:  .byte $0A, $FF, $08, $00

;Rinkas
LA869:  .byte $0A
LA86A:  .word $A870
LA86C:  .byte $0A, $FF, $18, $00

;Door at bottom of escape shaft.
LA870:  .byte $0B
LA871:  .word $FFFF
LA873:  .byte $01, $05, $09, $A3, $00

;Mother brain, Zeebetite, 3 cannons and Rinkas.
LA878:  .byte $02, $0C, $06, $47, $18, $05, $49, $15, $4B, $25, $3E, $00

;2 Zeebetites, 6 cannons and Rinkas.
LA884:  .byte $03, $12, $37, $27, $08, $05, $41, $15, $43, $25, $36, $05, $49, $15, $4B, $35
LA894:  .byte $3E, $00

;Right door, 2 Zeebetites, 6 cannons and Rinkas.
LA896:  .byte $04, $14, $09, $A3, $17, $07, $08, $05, $41, $15, $43, $25, $36, $05, $49, $15
LA8A6:  .byte $4B, $35, $3E, $00

;Left door.
LA8AA:  .byte $05, $FF, $09, $B3, $00 