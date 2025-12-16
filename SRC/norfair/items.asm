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

SpecItmsTbl_{AREA}:
@y0A:
    .byte $0A
    .word @y0B
    ;Missiles.
    @@x1B:
        .byte $1B, @@x1C - @@x1B
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    @@x1C:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

@y0B:
    .byte $0B
    .word @y0C
    ;Elevator from Brinstar.
    @@x16:
        .byte $16, @@x1A - @@x16
        .byte it_Elevator, $81
        .byte $00
    ;Missiles.
    @@x1A:
        .byte $1A, @@x1B - @@x1A
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    @@x1B:
        .byte $1B, @@x1C - @@x1B
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    @@x1C:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

@y0C:
    .byte $0C
    .word @y0D
    ;Ice beam.
    @@x1A:
        .byte $1A, $FF
        .byte it_PowerUp, pu_ICEBEAM, $37
        .byte $00

@y0D:
    .byte $0D
    .word @y0E
    ;Elevator to Brinstar.
    @@x16:
        .byte $16, $FF
        .byte it_Elevator, $81
        .byte $00

@y0E:
    .byte $0E
    .word @y0F
    ;Missiles.
    @@x12:
        .byte $12, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

@y0F:
    .byte $0F
    .word @y10
    ;Missiles and Melias.
    @@x11:
        .byte $11, @@x13 - @@x11
        .byte it_PowerUp, pu_MISSILES, $34
        .byte it_Mellow
        .byte $00
    ;Missiles.
    @@x13:
        .byte $13, @@x14 - @@x13
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    @@x14:
        .byte $14, @@x15 - @@x14
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Squeept.
    @@x15:
        .byte $15, $FF
        .byte it_Squeept | $40, $8B, $E9
        .byte it_Squeept | $50, $02, $9B
        .byte $00

@y10:
    .byte $10
    .word @y11
    ;Screw attack.
    @@x0F:
        .byte $0F, $FF
        .byte it_PowerUp, pu_SCREWATTACK, $37
        .byte $00

@y11:
    .byte $11
    .word @y13
    ;Palette change room.
    @@x16:
        .byte $16, @@x18 - @@x16
        .byte it_PaletteChange
        .byte $00
    ;Squeept.
    @@x18:
        .byte $18, @@x19 - @@x18
        .byte it_Squeept | $30, $0B, $E9
        .byte it_Squeept | $40, $02, $9A
        .byte $00
    ;Squeept.
    @@x19:
        .byte $19, @@x1B - @@x19
        .byte it_Squeept | $20, $8B, $E9
        .byte it_Squeept | $50, $02, $9A
        .byte $00
    ;High jump.
    @@x1B:
        .byte $1B, @@x1D - @@x1B
        .byte it_PowerUp, pu_HIGHJUMP, $37
        .byte $00
    ;Right door.
    @@x1D:
        .byte $1D, @@x1E - @@x1D
        .byte it_Door, $A0
        .byte $00
    ;Left door.
    @@x1E:
        .byte $1E, $FF
        .byte it_Door, $B0
        .byte $00

@y13:
    .byte $13
    .word @y14
    ;Energy tank.
    @@x1A:
        .byte $1A, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $42
        .byte $00

@y14:
    .byte $14
    .word @y15
    ;Right door.
    @@x0D:
        .byte $0D, @@x0E - @@x0D
        .byte it_Door, $A0
        .byte $00
    ;Left door.
    @@x0E:
        .byte $0E, @@x1C - @@x0E
        .byte it_Door, $B0
        .byte $00
    ;Missiles.
    @@x1C:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

@y15:
    .byte $15
    .word @y16
    ;Wave beam.
    @@x12:
        .byte $12, @@x17 - @@x12
        .byte it_PowerUp, pu_WAVEBEAM, $37
        .byte $00
    ;Right door(undefined room).
    @@x17:
        .byte $17, $FF
        .byte it_Door, $A0
        .byte $00

@y16:
    .byte $16
    .word $FFFF
    ;Missiles.
    @@x13:
        .byte $13, @@x14 - @@x13
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    @@x14:
        .byte $14, @@x19 - @@x14
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Elevator to Ridley hideout.
    @@x19:
        .byte $19, $FF
        .byte it_Elevator, $04
        .byte $00
