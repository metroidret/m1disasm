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

;Ridley Item Data

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
;#$07=Zebetite.
;#$08=Rinka.
;#$09=Door.
;#$0A=Palette change room.

SpecItmsTbl:
@y18:
    .byte $18
    .word @y19
    ;Missiles.
    @@x12:
        .byte $12, @@x19 - @@x12
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00
    ;Elevator to Norfair.
    @@x19:
        .byte $19, $FF
        .byte it_Elevator, $84
        .byte $00

@y19:
    .byte $19
    .word @y1B
    ;Energy tank.
    @@x11:
        .byte $11, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $74
        .byte $00

@y1B:
    .byte $1B
    .word @y1D
    ;Missiles.
    @@x18:
        .byte $18, $FF
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00

@y1D:
    .byte $1D
    .word @y1E
    ;Energy tank.
    @@x0F:
        .byte $0F, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $66
        .byte $00

@y1E:
    .byte $1E
    .word $FFFF
    ;Missiles.
    @@x14:
        .byte $14, $FF
        .byte it_PowerUp, pu_MISSILES, $6D
        .byte $00
