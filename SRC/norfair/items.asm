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

;Norfair Item Definitions

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

;Missiles.
LA2D9:  .byte $0A
LA2DA:  .word $A2E8
LA2DC:  .byte $1B, $06, $02, $09, $34, $00

;Missiles.
LA2E2:  .byte $1C, $FF, $02, $09, $34, $00

;Elevator from Brinstar.
LA2E8:  .byte $0B
LA2E9:  .word $A302
LA2EB:  .byte $16, $05, $04, $81, $00

;Missiles.
LA2F0:  .byte $1A, $06, $02, $09, $34, $00

;Missiles.
LA2F6:  .byte $1B, $06, $02, $09, $34, $00

;Missiles.
LA2FC:  .byte $1C, $FF, $02, $09, $34, $00

;Ice beam.
LA302:  .byte $0C
LA303:  .word $A30B
LA305:  .byte $1A, $FF, $02, $07, $37, $00

;Elevator to Brinstar.
LA30B:  .byte $0D
LA30C:  .word $A313
LA30E:  .byte $16, $FF, $04, $81, $00

;Missiles.
LA313:  .byte $0E
LA314:  .word $A31C
LA316:  .byte $12, $FF, $02, $09, $34, $00

;Missiles and Melias.
LA31C:  .byte $0F
LA31D:  .word $A33B
LA31F:  .byte $11, $07, $02, $09, $34, $03, $00

;Missiles.
LA326:  .byte $13, $06, $02, $09, $34, $00

;Missiles.
LA32C:  .byte $14, $06, $02, $09, $34, $00

;Squeept.
LA332:  .byte $15, $FF, $41, $8B, $E9, $51, $02, $9B, $00

;Screw attack.
LA33B:  .byte $10
LA33C:  .word $A344
LA33E:  .byte $0F, $FF, $02, $03, $37, $00

;Palette change room.
LA344:  .byte $11
LA345:  .word $A36D
LA347:  .byte $16, $04, $0A, $00

;Squeept.
LA34B:  .byte $18, $09, $31, $0B, $E9, $41, $02, $9A, $00

;Squeept.
LA354:  .byte $19, $09, $21, $8B, $E9, $51, $02, $9A, $00

;High jump.
LA35D:  .byte $1B, $06, $02, $01, $37, $00

;Right door.
LA363:  .byte $1D, $05, $09, $A0, $00

;Left door.
LA368:  .byte $1E, $FF, $09, $B0, $00

;Energy tank.
LA36D:  .byte $13
LA36E:  .word $A376
LA370:  .byte $1A, $FF, $02, $08, $42, $00

;Right door.
LA376:  .byte $14
LA377:  .word $A389
LA379:  .byte $0D, $05, $09, $A0, $00

;Left door.
LA37E:  .byte $0E, $05, $09, $B0, $00

;Missiles.
LA383:  .byte $1C, $FF, $02, $09, $34, $00

;Wave beam.
LA389:  .byte $15
LA38A:  .word $A397
LA38C:  .byte $12, $06, $02, $06, $37, $00

;Right door(undefined room).
LA392:  .byte $17, $FF, $09, $A0, $00

;Missiles.
LA397:  .byte $16
LA398:  .word $FFFF
LA39A:  .byte $13, $06, $02, $09, $34, $00

;Missiles.
LA3A0:  .byte $14, $06, $02, $09, $34, $00

;Elevator to Ridley hideout.
LA3A6:  .byte $19, $FF, $04, $04, $00