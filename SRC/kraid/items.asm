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
    .byte $12
    .word LA275
    ;Elevator from Brinstar.
        .byte $07, $FF
        .byte it_Elevator, $81
        .byte $00

LA275:
    .byte $14
    .word LA27D
    ;Elevator to Brinstar.
        .byte $07, $FF
        .byte it_Elevator, $82
        .byte $00

LA27D:
    .byte $15
    .word LA28C
    ;Missiles.
        .byte $04, (LA286-*)+1
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

    ;Missiles.
    LA286:
        .byte $09, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

LA28C:
    .byte $16
    .word LA295
    ;Energy tank.
        .byte $0A, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $66
        .byte $00

LA295:
    .byte $19
    .word LA29E
    ;Missiles.
        .byte $0A, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

LA29E:
    .byte $1B
    .word LA2A7
    ;Missiles.
        .byte $05, $FF
        .byte it_PowerUp, pu_MISSILES, $47
        .byte $00

LA2A7:
    .byte $1C
    .word LA2AE
    ;Memus.
        .byte $07, $FF
        .byte it_Mellow
        .byte $00

;Energy tank.
LA2AE:
    .byte $1D
    .word $FFFF
        .byte $08, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $BE
        .byte $00