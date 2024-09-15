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
    .byte $02
    .word LA3E4
    ;Elevator to Tourian.
        .byte $03, (LA3DE-*)+1
        .byte it_Elevator, $03
        .byte $00
    ;Varia suit.
    LA3DE:
        .byte $0F, $FF
        .byte it_PowerUp, pu_VARIA, $37
        .byte $00

LA3E4:
    .byte $03
    .word LA3F3
    ;Missiles.
        .byte $18, (LA3ED-*)+1
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Energy tank.
    LA3ED:
        .byte $1B, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

LA3F3:
    .byte $05
    .word LA402
    ;Long beam.
        .byte $07, (LA3FC-*)+1
        .byte it_PowerUp, pu_LONGBEAM, $37
        .byte $00
    ;Bombs.
    LA3FC:
        .byte $19, $FF
        .byte it_PowerUp, pu_BOMBS, $37
        .byte $00

LA402:
    .byte $07
    .word LA40F
    ;Palette change room.
        .byte $0C, (LA409-*)+1
        .byte it_PaletteChange
        .byte $00
    ;Energy tank.
    LA409:
        .byte $19, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $87
        .byte $00

LA40F:
    .byte $09
    .word LA41C
    ;Ice beam.
        .byte $13, (LA418-*)+1
        .byte it_PowerUp, pu_ICEBEAM, $37
        .byte $00
    ;Mellows.
    LA418:
        .byte $15, $FF
        .byte it_Mellow
        .byte $00

LA41C:
    .byte $0B
    .word LA42A
    ;Missiles.
        .byte $12, (LA425-*)+1
        .byte it_PowerUp, pu_MISSILES, $67
        .byte $00
    ;Elevator to Norfair.
    LA425:
        .byte $16, $FF
        .byte it_Elevator, $01
        .byte $00

LA42A:
    .byte $0E
    .word LA439
    ;Maru Mari.
        .byte $02, (LA433-*)+1
        .byte it_PowerUp, pu_MARUMARI, $96
        .byte $00
    ;Energy tank.
    LA433:
        .byte $09, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $12
        .byte $00

LA439:
    .byte $12
    .word $FFFF
    ;Elevator to Kraid.
        .byte $07, $FF
        .byte it_Elevator, $02
        .byte $00