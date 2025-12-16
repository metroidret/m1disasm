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

SpecItmsTbl_{AREA}:
@y02:
    .byte $02
    .word @y03
    ;Elevator to Tourian.
    @@x03:
        .byte $03, @@x0F - @@x03
        .byte it_Elevator, $03
        .byte $00
    ;Varia suit.
    @@x0F:
        .byte $0F, $FF
        .byte it_PowerUp, pu_VARIA, $37
        .byte $00

@y03:
    .byte $03
    .word @y05
    ;Missiles.
    @@x18:
        .byte $18, @@x1B - @@x18
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Energy tank.
    @@x1B:
        .byte $1B, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

@y05:
    .byte $05
    .word @y07
    ;Long beam.
    @@x07:
        .byte $07, @@x19 - @@x07
        .byte it_PowerUp, pu_LONGBEAM, $37
        .byte $00
    ;Bombs.
    @@x19:
        .byte $19, $FF
        .byte it_PowerUp, pu_BOMBS, $37
        .byte $00

@y07:
    .byte $07
    .word @y09
    ;Palette change room.
    @@x0C:
        .byte $0C, @@x19 - @@x0C
        .byte it_PaletteChange
        .byte $00
    ;Energy tank.
    @@x19:
        .byte $19, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

@y09:
    .byte $09
    .word @y0B
    ;Ice beam.
    @@x13:
        .byte $13, @@x15 - @@x13
        .byte it_PowerUp, pu_ICEBEAM, $37
        .byte $00
    ;Mellows.
    @@x15:
        .byte $15, $FF
        .byte it_Mellow
        .byte $00

@y0B:
    .byte $0B
    .word @y0E
    ;Missiles.
    @@x12:
        .byte $12, @@x16 - @@x12
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Elevator to Norfair.
    @@x16:
        .byte $16, $FF
        .byte it_Elevator, $01
        .byte $00

@y0E:
    .byte $0E
    .word @y12
    ;Maru Mari.
    @@x02:
        .byte $02, @@x09 - @@x02
        .byte it_PowerUp, pu_MARUMARI, $96
        .byte $00
    ;Energy tank.
    @@x09:
        .byte $09, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $12
        .byte $00

@y12:
    .byte $12
    .word $FFFF
    ;Elevator to Kraid.
    @@x07:
        .byte $07, $FF
        .byte it_Elevator, $02
        .byte $00
