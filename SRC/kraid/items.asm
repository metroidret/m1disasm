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

SpecItmsTbl:
@y12:
    .byte $12
    .word @y14
    ;Elevator from Brinstar.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $81
        .byte $00

@y14:
    .byte $14
    .word @y15
    ;Elevator to Brinstar.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $82
        .byte $00

@y15:
    .byte $15
    .word @y16
    ;Missiles.
    @@x04:
        .byte $04, @@x09 - @@x04
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

    ;Missiles.
    @@x09:
        .byte $09, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y16:
    .byte $16
    .word @y19
    ;Energy tank.
    @@x0A:
        .byte $0A, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $66
        .byte $00

@y19:
    .byte $19
    .word @y1B
    ;Missiles.
    @@x0A:
        .byte $0A, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y1B:
    .byte $1B
    .word @y1C
    ;Missiles.
    @@x05:
        .byte $05, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

@y1C:
    .byte $1C
    .word @y1D
    ;Memus.
    @@x07:
        .byte $07, $FF
        .byte it_Mellow
        .byte $00

@y1D:
    .byte $1D
    .word $FFFF
    ;Energy tank.
    @@x08:
        .byte $08, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $BE
        .byte $00
