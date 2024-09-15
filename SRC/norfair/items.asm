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
    .byte $0A
    .word LA2E8
    ;Missiles.
        .byte $1B, (LA2E2-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    LA2E2:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

LA2E8:
    .byte $0B
    .word LA302
    ;Elevator from Brinstar.
        .byte $16, (LA2F0-*)+1
        .byte it_Elevator, $81
        .byte $00
    ;Missiles.
    LA2F0:
        .byte $1A, (LA2F6-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    LA2F6:
        .byte $1B, (LA2FC-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    LA2FC:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

LA302:
    .byte $0C
    .word LA30B
    ;Ice beam.
        .byte $1A, $FF
        .byte it_PowerUp, pu_ICEBEAM, $37
        .byte $00

LA30B:
    .byte $0D
    .word LA313
    ;Elevator to Brinstar.
        .byte $16, $FF
        .byte it_Elevator, $81
        .byte $00

LA313:
    .byte $0E
    .word LA31C
    ;Missiles.
        .byte $12, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

LA31C:
    .byte $0F
    .word LA33B
    ;Missiles and Melias.
        .byte $11, (LA326-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte it_Mellow
        .byte $00
    ;Missiles.
    LA326:
        .byte $13, (LA32C-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    LA32C:
        .byte $14, (LA332-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Squeept.
    LA332:
        .byte $15, $FF
        .byte it_Squeept | $40, $8B, $E9
        .byte it_Squeept | $50, $02, $9B
        .byte $00

LA33B:
    .byte $10
    .word LA344
    ;Screw attack.
        .byte $0F, $FF
        .byte it_PowerUp, pu_SCREWATTACK, $37
        .byte $00

LA344:
    .byte $11
    .word LA36D
    ;Palette change room.
        .byte $16, (LA34B-*)+1
        .byte it_PaletteChange
        .byte $00
    ;Squeept.
    LA34B:
        .byte $18, (LA354-*)+1
        .byte it_Squeept | $30, $0B, $E9
        .byte it_Squeept | $40, $02, $9A
        .byte $00
    ;Squeept.
    LA354:
        .byte $19, (LA35D-*)+1
        .byte it_Squeept | $20, $8B, $E9
        .byte it_Squeept | $50, $02, $9A
        .byte $00
    ;High jump.
    LA35D:
        .byte $1B, (LA363-*)+1
        .byte it_PowerUp, pu_HIGHJUMP, $37
        .byte $00
    ;Right door.
    LA363:
        .byte $1D, (LA368-*)+1
        .byte it_Door, $A0
        .byte $00
    ;Left door.
    LA368:
        .byte $1E, $FF
        .byte it_Door, $B0
        .byte $00

LA36D:
    .byte $13
    .word LA376
    ;Energy tank.
        .byte $1A, $FF
        .byte it_PowerUp, pu_ENERGYTANK, $42
        .byte $00

LA376:
    .byte $14
    .word LA389
    ;Right door.
        .byte $0D, (LA37E-*)+1
        .byte it_Door, $A0
        .byte $00
    ;Left door.
    LA37E:
        .byte $0E, (LA383-*)+1
        .byte it_Door, $B0
        .byte $00
    ;Missiles.
    LA383:
        .byte $1C, $FF
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00

LA389:
    .byte $15
    .word LA397
    ;Wave beam.
        .byte $12, (LA392-*)+1
        .byte it_PowerUp, pu_WAVEBEAM, $37
        .byte $00
    ;Right door(undefined room).
    LA392:
        .byte $17, $FF
        .byte it_Door, $A0
        .byte $00

LA397:
    .byte $16
    .word $FFFF
    ;Missiles.
        .byte $13, (LA3A0-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Missiles.
    LA3A0:
        .byte $14, (LA3A6-*)+1
        .byte it_PowerUp, pu_MISSILES, $34
        .byte $00
    ;Elevator to Ridley hideout.
    LA3A6:
        .byte $19, $FF
        .byte it_Elevator, $04
        .byte $00