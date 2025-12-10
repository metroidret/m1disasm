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

SpecItmsTbl_BANK{BANK}:
@y03:
    .byte $03
    .word @y04
    ;Elevator to end.
    @@x01:
        .byte $01, $FF
        .byte it_Elevator, $8F
        .byte $00

@y04:
    .byte $04
    .word @y07
    ;Elevator to Brinstar.
    @@x03:
        .byte $03, $FF
        .byte it_Elevator, $83
        .byte $00

@y07:
    .byte $07
    .word @y08
    ;10 missile door.
    @@x03:
        .byte $03, @@x04 - @@x03
        .byte it_Door, $A2
        .byte $00
    ;Rinkas
    @@x04:
        .byte $04, @@x09 - @@x04
        .byte it_RinkaSpawner
        .byte $00
    ;Rinkas
    @@x09:
        .byte $09, $FF
        .byte it_RinkaSpawner
        .byte $00

@y08:
    .byte $08
    .word @y09
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner | $10
        .byte $00

@y09:
    .byte $09
    .word @y0A
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner
        .byte $00

@y0A:
    .byte $0A
    .word @y0B
    ;Rinkas
    @@x0A:
        .byte $0A, $FF
        .byte it_RinkaSpawner | $10
        .byte $00

@y0B:
    .byte $0B
    .word $FFFF
    ;Door at bottom of escape shaft.
    @@x01:
        .byte $01, @@x02 - @@x01
        .byte it_Door, $A3
        .byte $00
    ;Mother brain, Zebetite, 3 cannons and Rinkas.
    @@x02:
        .byte $02, @@x03 - @@x02
        .byte it_MotherBrain
        .byte it_Zebetite | $40
        .byte it_RinkaSpawner | $10
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $20, $3E
        .byte $00
    ;2 Zebetites, 6 cannons and Rinkas.
    @@x03:
        .byte $03, @@x04 - @@x03
        .byte it_Zebetite | $30
        .byte it_Zebetite | $20
        .byte it_RinkaSpawner
        .byte it_Cannon | $00, $41
        .byte it_Cannon | $10, $43
        .byte it_Cannon | $20, $36
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $30, $3E
        .byte $00
    ;Right door, 2 Zebetites, 6 cannons and Rinkas.
    @@x04:
        .byte $04, @@x05 - @@x04
        .byte it_Door, $A3
        .byte it_Zebetite | $10
        .byte it_Zebetite | $00
        .byte it_RinkaSpawner
        .byte it_Cannon | $00, $41
        .byte it_Cannon | $10, $43
        .byte it_Cannon | $20, $36
        .byte it_Cannon | $00, $49
        .byte it_Cannon | $10, $4B
        .byte it_Cannon | $30, $3E
        .byte $00
    ;Left door.
    @@x05:
        .byte $05, $FF
        .byte it_Door, $B3
        .byte $00
