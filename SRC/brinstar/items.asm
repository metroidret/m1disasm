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

;Norfair (memory page 2)

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
;
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

;Elevator to Tourian.
LA3D6:  .byte $02
LA3D7:  .word $A3E4
LA3D9:  .byte $03, $05, $04, $03, $00

;Varia suit.
LA3DE:  .byte $0F, $FF, $02, $05, $37, $00

;Missiles.
LA3E4:  .byte $03
LA3E5:  .word $A3F3
LA3E7:  .byte $18, $06, $02, $09, $67, $00

;Energy tank.
LA3ED:  .byte $1B, $FF, $02, $08, $87, $00

;Long beam.
LA3F3:  .byte $05
LA3F4:  .word $A402
LA3F6:  .byte $07, $06, $02, $02, $37, $00

;Bombs.
LA3FC:  .byte $19, $FF, $02, $00, $37, $00

;Palette change room.
LA402:  .byte $07
LA403:  .word $A40F
LA405:  .byte $0C, $04, $0A, $00

;Energy tank.
LA409:  .byte $19, $FF, $02, $08, $87, $00

;Ice beam.
LA40F:  .byte $09
LA410:  .word $A41C
LA412:  .byte $13, $06, $02, $07, $37, $00

;Mellows.
LA418:  .byte $15, $FF, $03, $00

;Missiles.
LA41C:  .byte $0B
LA41D:  .word $A42A
LA41F:  .byte $12, $06, $02, $09, $67, $00

;Elevator to Norfair.
LA425:  .byte $16, $FF, $04, $01, $00

;Maru Mari.
LA42A:  .byte $0E
LA42B:  .word $A439
LA42D:  .byte $02, $06, $02, $04, $96, $00

;Energy tank.
LA433:  .byte $09, $FF, $02, $08, $12, $00

;Elevator to Kraid.
LA439:  .byte $12
LA43A:  .word $FFFF
LA43C:  .byte $07, $FF, $04, $02, $00