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

;Kraid Item Data

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

;Elevator from Brinstar.
LA26D:  .byte $12
LA26E:  .word $A275
LA270:  .byte $07, $FF, $04, $81, $00

;Elevator to Brinstar.
LA275:  .byte $14
LA276:  .word $A27D
LA278:  .byte $07, $FF, $04, $82, $00

;Missiles.
LA27D:  .byte $15
LA27E:  .word $A28C
LA27F:  .byte $04, $06, $02, $09, $47, $00

;Missiles.
LA286:  .byte $09, $FF, $02, $09, $47, $00

;Energy tank.
LA28C:  .byte $16
LA28D:  .word $A295
LA28F:  .byte $0A, $FF, $02, $08, $66, $00

;Missiles.
LA295:  .byte $19
LA296:  .word $A29E
LA298:  .byte $0A, $FF, $02, $09, $47, $00

;Missiles.
LA29E:  .byte $1B
LA29F:  .word $A2A7
LA2A1:  .byte $05, $FF, $02, $09, $47, $00

;Memus.
LA2A7:  .byte $1C
LA2A8:  .word $A2AE
LA2A9:  .byte $07, $FF, $03, $00

;Energy tank.
LA2AE:  .byte $1D
LA2AF:  .word $FFFF
LA2B1:  .byte $08, $FF, $02, $08, $BE, $00