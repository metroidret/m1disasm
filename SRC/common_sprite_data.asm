; TODO: Organized this better and maybe split it up more sensibly.

;---------------------------------[ Object animation data tables ]----------------------------------

;The following tables are indices into the FramePtrTable that correspond to various animations. The
;FramePtrTable represents individual frames and the entries in ObjectAnimIndexTbl are the groups of
;frames responsible for animaton Samus, her weapons and other objects.

ObjectAnimIndexTbl:

;Samus run animation.
L8572:  .byte $03, $04, $05, $FF

;Samus front animation.
L8576:  .byte $07, $FF

;Samus jump out of ball animation.
L8578:  .byte $17

;Samus Stand animation.
L8579:  .byte $08, $FF

;Samus stand and fire animation.
L857B:  .byte $22, $FF

;Samus stand and jump animation.
L857D:  .byte $04

;Samus Jump animation.
L857E:  .byte $10, $FF

;Samus somersault animation.
L8580:  .byte $17, $18, $19, $1A, $FF

;Samus run and jump animation.
L8585:  .byte $03, $17, $FF

;Samus roll animation.
L8588:  .byte $1E, $1D, $1C, $1B, $FF

;Bullet animation.
L858D:  .byte $28, $FF

;Bullet hit animation.
L858F:  .byte $2A, $F7, $FF

;Samus jump and fire animation.
L8592:  .byte $12, $FF

;Samus run and fire animation.
L8594:  .byte $0C, $0D, $0E, $FF

;Samus point up and shoot animation.
L8598:  .byte $30

;Samus point up animation.
L8599:  .byte $2B, $FF

;Door open animation.
L859B:  .byte $31, $31, $33, $F7, $FF

;Door close animation.
L85A0:  .byte $33, $33, $31, $FF

;Samus explode animation.
L85A4: .byte $35, $FF

;Samus jump and point up animation.
L85A6: .byte $39, $38, $FF

;Samus run and point up animation.
L85A9:  .byte $40, $41, $42, $FF

;Samus run, point up and shoot animation 1.
L85AD:  .byte $46, $FF

;Samus run, point up and shoot animation 2.
L85AF:  .byte $47, $FF

;Samus run, point up and shoot animation 3.
L85B1:  .byte $48, $FF

;Samus on elevator animation 1.
L85B3:  .byte $07, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 2.
L85C2:  .byte $23, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $F7, $F7, $23, $F7, $FF

;Samus on elevator animation 3.
L85D1:  .byte $07, $F7, $F7, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 4.
L85E0:  .byte $23, $F7, $F7, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $23, $F7, $FF

;Wave beam animation.
L85EF:  .byte $4B, $FF

;Bomb tick animation.
L85F1:  .byte $4E, $4F, $FF

;Bomb explode animation.
L85F4:  .byte $3C, $4A, $49, $4A, $4D, $4A, $4D, $F7, $FF

;Missile left animation.
L85FD:  .byte $26, $FF

;Missile right animation.
L85FF:  .byte $25, $FF

;Missile up animation.
L8601:  .byte $27, $FF

;Missile explode animation.
L8603:  .byte $67, $67, $67, $68, $68, $69, $F7, $FF

;----------------------------[ Sprite drawing pointer tables ]--------------------------------------

;The above animation pointers provide an index into the following table
;for the animation sequences.

FramePtrTable:
    .word Frame_87CB, Frame_87CB, Frame_87CB, Frame_87CB, Frame_87DD, Frame_87F0, Frame_8802, Frame_8802
    .word Frame_8818, Frame_882C, Frame_882C, Frame_882C, Frame_882C, Frame_883E, Frame_8851, Frame_8863
    .word Frame_8863, Frame_8874, Frame_8874, Frame_8885, Frame_8885, Frame_8885, Frame_8885, Frame_8885
    .word Frame_888F, Frame_8899, Frame_88A3, Frame_88AD, Frame_88B8, Frame_88C3, Frame_88CE, Frame_88D9
    .word Frame_88D9, Frame_88D9, Frame_88D9, Frame_88EE, Frame_88F8, Frame_88F8, Frame_88FE, Frame_8904
    .word Frame_890A, Frame_890F, Frame_890F, Frame_8914, Frame_8928, Frame_8928, Frame_8928, Frame_8928
    .word Frame_8928, Frame_893C, Frame_8948, Frame_8948, Frame_8954, Frame_8954, Frame_8961, Frame_8961
    .word Frame_8961, Frame_8974, Frame_8987, Frame_8987, Frame_8987, Frame_8995, Frame_8995, Frame_8995
    .word Frame_8995, Frame_89A9, Frame_89BE, Frame_89D2, Frame_89D2, Frame_89D2, Frame_89D2, Frame_89E6
    .word Frame_89FB, Frame_8A0F, Frame_8A1D, Frame_8A21, Frame_8A26, Frame_8A26, Frame_8A3C, Frame_8A41
    .word Frame_8A46, Frame_8A4E, Frame_8A56, Frame_8A5E, Frame_8A66, Frame_8A6E, Frame_8A76, Frame_8A7E
    .word Frame_8A86, Frame_8A8E, Frame_8A9C, Frame_8AA1, Frame_8AA6, Frame_8AAE, Frame_8ABA, Frame_8AC4
    .word Frame_8AC4, Frame_8AC4, Frame_8AC4, Frame_8AC4, Frame_8AC4, Frame_8AC4, Frame_8AD8, Frame_8AE9
    .word Frame_8AF3, Frame_8B03

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.

PlacePtrTable:
    .word Place0, Place1, Place2, Place3, Place4, Place5, Place6, Place7
    .word Place8, Place9, PlaceA, PlaceB, PlaceC, PlaceD, PlaceE

;------------------------------[ Sprite placement data tables ]-------------------------------------

;Sprite placement data. The placement data is grouped into two byte segments. The first byte is the
;y placement byte and the second is the x placement byte.  If the MSB is set in the byte, the byte
;is in twos compliment format so when it is added to the object position, the end result is to
;decrease the x or y position of the sprite.  The Samus explode table is a special case with special
;data bytes. The format of those data bytes is listed just above the Samus explode data. Each data
;table has a graphical representation above it to show how the sprites are laid out with respect to
;the object position, which is represented by a * in the table. The numbers in the lower right corner
;of the boxes indicates which segment of the data table represents which box in the graphic. Each box
;is filled with an 8x8 sprite.

;Samus pointing up frames. Added to the main Samus animation table below.
;          +--------+ <----0
;          +--------+ <----1
;          |        |
;          |        |
;          |        |
;          +--------+
;          +--------+
;
;
;
;
;
;
;
;
;               *
Place6:
;          +--0--+   +--1--+
    .byte $E8, $FC, $EA, $FC

;Several Samus frames.
;      +-------+ <---------------D
;      +-------+ <---------------E
;      |       |
;      |   +---+----+--------+
;      |   |   |    |        |
;      +-------+    |        |
;      +-------+    |        |
;          |       0|       1|
; +----+-+-+----+-+-+--------+
; |    | | |    | | |        |
; |    | | |    | | |        |
; |    | | |    | | |        |
; |    | |2|   B|C|3|       4|
; +----+-+-+----+-+-*--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       5|       6|       7|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       8|       9|       A|
;          +--------+--------+--------+
Place0:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00, $00, $F8, $00, $00, $00, $08
;          +--8--+   +--9--+   +--A--+   +--B--+   +--C--+   +--D--+   +--E--+
    .byte $08, $F8, $08, $00, $08, $08, $F8, $F4, $F8, $F6, $EC, $F4, $EE, $F4

;Samus somersault and roll frames.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------+--------+
;          |        |        |
;          +--------+--------+
;          |        *        |
;          |       2|       3|
;          +--------+--------+
;          |       4|       5|
;          +--------+--------+
Place1:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $F3, $F8, $F3, $00, $FB, $F8, $FB, $00, $03, $F8, $03, $00

;Samus somersault frame.
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       0|       1|       2|
;          +--------+-*------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       3|       4|       5|
;          +--------+--------+--------+
Place2:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $F8, $F6, $F8, $FE, $F8, $06, $00, $F6, $00, $FE, $00, $06

;Elevator frame.
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;          |        |        |        |        |        |        |        |        |
;          |        |        |        |        |        |        |        |        |
;          |        |        *        |        |        |        |        |        |
;          |       0|       1|       2|       3|       4|       5|       6|       7|
;          +--------+--------+--------+--------+--------+--------+--------+--------+
Place3:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08, $FC, $10, $FC, $18, $FC, $20, $FC, $28

;Several projectile frames.
;          +--------+
;          |        |
;          |        |
;          |    *   |
;          |       0|
;          +--------+
Place4:
;          +--0--+
    .byte $FC, $FC

;Power-up items and bomb explode frames.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------*--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       2|       3|
;          +--------+--------+
PlaceD:
;          +--0--+   +--1--+   +--2--+   +--3--+
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

;Door frames.
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       0|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       1|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       2|
;          *--------+
;          |        |
;          |        |
;          |        |
;          |       3|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       4|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       5|
;          +--------+
Place5:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $E8, $00, $F0, $00, $F8, $00, $00, $00, $08, $00, $10, $00

;Samus explode. Special case. The bytes that are #$8X indicate displacement data will be loaded
;from a table for the y direction and from a counter for the x direction.  The initial displacement
;bytes start at $8769.  If the LSB is clear in the bytes where the upper nibble is #$8, those
;data bytes will be used to decrease the x position of the sprite each frame. If the LSB is set,
;the data bytes will increase the x position of the sprite each frame.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        *        |
;          |       2|       3|
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       4|       5|
;          +--------+--------+
Place7:
;                                                                      +--0--+   +--1--+
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
;          +--2--+   +--3--+   +--4--+   +--5--+
    .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Bomb explode frame.
;          +--------+--------+--------+--------+
;          |        |        |        |        |
;          |        |        |        |        |
;          |        |        |        |        |
;          |       3|       4|       0|       1|
;          +--------+--------+--------+--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |                 |        |
;          |       5|                 |       2|
;          +--------+        *        +--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |                 |        |
;          |       6|                 |       9|
;          +--------+--------+--------+--------+
;          |        |        |        |        |
;          |        |        |        |        |
;          |        |        |        |        |
;          |       7|       8|       A|       B|
;          +--------+--------+--------+--------+
Place8:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $F0, $00, $F0, $08, $F8, $08, $F0, $F0, $F0, $F8, $F8, $F0, $00, $F0, $08, $F0
;          +--8--+   +--9--+   +--A--+   +--B--+
    .byte $08, $F8, $00, $08, $08, $00, $08, $08

;Missile up frame.
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       0|
;          +----*---+
;          |        |
;          |        |
;          |        |
;          |       1|
;          +--------+
Place9:
;          +--0--+   +--1--+
    .byte $F8, $FC, $00, $FC

;Missile left/right and missile explode frames.
;          +--------+--------+        +--------+--------+
;          |        |        |        |        |        |
;          |        |        |        |        |        |
;          |        *        |        |        |        |
;          |       0|       1|        |       2|       3|
;          +--------+--------+        +--------+--------+
PlaceA:
;          +--0--+   +--1--+   +--2--+   +--3--+
    .byte $FC, $F8, $FC, $00, $FC, $10, $FC, $18

;Missile explode frame.
;                   +--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       1|       2|
;          +--------+--------+--------+--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |        *        |        |
;          |       0|                 |       3|
;          +--------+--------+--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       4|       5|
;                   +--------+--------+
PlaceB:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $FC, $F0, $F4, $F8, $F4, $00, $FC, $08, $04, $F8, $04, $00

;Missile explode frame.
;                    +--------+                 +--------+
;                    |        |                 |        |
;                    |        |                 |        |
;                    |        |                 |        |
;                    |       1|                 |       2|
;                    +--------+                 +--------+
;
;
;
;
;          +--------+                                     +--------+
;          |        |                                     |        |
;          |        |                                     |        |
;          |        |                  *                  |        |
;          |       0|                                     |       3|
;          +--------+                                     +--------+
;
;
;
;
;                    +--------+                 +--------+
;                    |        |                 |        |
;                    |        |                 |        |
;                    |        |                 |        |
;                    |       4|                 |       5|
;                    +--------+                 +--------+
PlaceC:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $FC, $E8, $EC, $F0, $EC, $08, $FC, $10, $0C, $F0, $0C, $08

;Statue frames.
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       4|       5|       6|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       7|       8|       9|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       A|       B|       C|
;          +--------+--------*--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       0|       1|
;                   +--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       2|       3|
;                   +--------+--------+
PlaceE:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $00, $F8, $00, $00, $08, $F8, $08, $00, $E8, $F0, $E8, $F8, $E8, $00, $F0, $F0
;          +--8--+   +--9--+   +--A--+   +--B--+   +--C--+
    .byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00

;-------------------------------[ Sprite frame data tables ]---------------------------------------

;Frame drawing data. The format for the frame drawing data is as follows:
;There are 4 control bytes associated with the frame data and they are #$FC, #$FD, #$FE and #$FF.
;
;#$FC displaces the location of the object in the x and y direction.  The first byte following #$FC
;is the y displacement of the object and the second byte is the x displacement. any further bytes
;are pattern table index bytes until the next control byte is reached.
;
;#$FD tells the program to change the sprite control byte.  The next byte after #$FD is the new
;control byte.  Only the 4 upper bits are used. Any further bytes are pattern table index bytes
;until the next control byte is reached.
;
;#$FE causes the next placement position to be skipped.  Any further bytes are pattern table index
;bytes until the next control byte is reached.
;
;#$FF ends the frame drawing data segment.
;
;The first 3 bytes are unique.  The first byte contains two parts: AAAABBBB. The upper 4 bits
;are sprite control data which control mirroring and color bits.  The lower 4 bits are multiplied
;by 2 and used as an index into the PlacePtrTable to find the proper placement data for the
;current frame.  The second byte is saved as the object's y radius and the third byte is saved
;as the object's x radius.

;Samus run.
Frame_87CB:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $FE
    .byte $41
    .byte $40
    .byte $FD, $6 << 4
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run.
Frame_87DD:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $02
    .byte $03
    .byte $FD, $2 << 4
    .byte $FE
    .byte $43
    .byte $42
    .byte $FD, $6 << 4
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run.
Frame_87F0:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $05
    .byte $06
    .byte $FD, $2 << 4
    .byte $FE
    .byte $45
    .byte $44
    .byte $FD, $6 << 4
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus facing forward.
Frame_8802:
    .byte ($0 << 4) + $0, $0F, $04
    .byte $09
    .byte $FD, $6 << 4
    .byte $09
    .byte $FD, $2 << 4
    .byte $FE
    .byte $19
    .byte $1A
    .byte $FD, $2 << 4
    .byte $29
    .byte $2A
    .byte $FE
    .byte $39
    .byte $FD, $6 << 4
    .byte $39
    .byte $FF

;Samus stand.
Frame_8818:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $FD, $2 << 4
    .byte $0E
    .byte $0D
    .byte $FE
    .byte $1E
    .byte $1D
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, $6 << 4
    .byte $3B
    .byte $3C
    .byte $FE
    .byte $17
    .byte $FF

;Samus run and fire.
Frame_882C:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, $6 << 4
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run and fire.
Frame_883E:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, $6 << 4
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run and fire.
Frame_8851:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, $6 << 4
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus stand and jump.
Frame_8863:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $FE
    .byte $41
    .byte $40
    .byte $FD, $6 << 4
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus jump and fire.
Frame_8874:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $2 << 4
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, $6 << 4
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus somersault.
Frame_8885:
    .byte ($4 << 4) + $1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
Frame_888F:
    .byte ($4 << 4) + $2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus somersault.
Frame_8899:
    .byte ($8 << 4) + $1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
Frame_88A3:
    .byte ($8 << 4) + $2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus roll.
Frame_88AD:
    .byte ($0 << 4) + $1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame_88B8:
    .byte ($8 << 4) + $1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame_88C3:
    .byte ($C << 4) + $1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame_88CE:
    .byte ($4 << 4) + $1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus stand and fire.
Frame_88D9:
    .byte ($4 << 4) + $0, $0F, $04
    .byte $FD, $2 << 4
    .byte $0E
    .byte $0D
    .byte $FE
    .byte $1E
    .byte $1D
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, $6 << 4
    .byte $3B
    .byte $3C
    .byte $FE
    .byte $FE
    .byte $17
    .byte $FF

;Elevator.
Frame_88EE:
    .byte ($0 << 4) + $3, $04, $10
    .byte $28
    .byte $38
    .byte $38
    .byte $FD, $6 << 4
    .byte $28
    .byte $FF

;Missile right.
Frame_88F8:
    .byte ($4 << 4) + $A, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile left.
Frame_88FE:
    .byte ($0 << 4) + $A, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile up.
Frame_8904:
    .byte ($0 << 4) + 9, $08, $04
    .byte $14
    .byte $24
    .byte $FF

;Bullet fire.
Frame_890A:
    .byte ($0 << 4) + 4, $02, $02
    .byte $30
    .byte $FF

;Bullet hit.
Frame_890F:
    .byte ($0 << 4) + 4, $00, $00
    .byte $04
    .byte $FF

;Samus stand and point up.
Frame_8914:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, $6 << 4
    .byte $3B
    .byte $3C
    .byte $FF

;Samus from ball to pointing up.
Frame_8928:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, $6 << 4
    .byte $3B
    .byte $3C
    .byte $FF

;Door closed.
Frame_893C:
    .byte ($3 << 4) + $5, $18, $08
    .byte $0F
    .byte $1F
    .byte $2F
    .byte $FD, ($A << 4) + $3
    .byte $2F
    .byte $1F
    .byte $0F
    .byte $FF

;Door open/close.
Frame_8948:
    .byte ($3 << 4) + $5, $18, $04
    .byte $6A
    .byte $6B
    .byte $6C
    .byte $FD, ($A << 4) + $3
    .byte $6C
    .byte $6B
    .byte $6A
    .byte $FF

;Samus explode.
Frame_8954:
    .byte ($0 << 4) + $7, $00, $00
    .byte $FC, $FC, $00
    .byte $0B
    .byte $0C
    .byte $1B
    .byte $1C
    .byte $2B
    .byte $2C
    .byte $FF

;Samus jump and point up.
Frame_8961:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $69
    .byte $FD, $2 << 4
    .byte $FE
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus jump and point up.
Frame_8974:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Bomb explode.
Frame_8987:
    .byte ($0 << 4) + $D, $0C, $0C
    .byte $74
    .byte $FD, $6 << 4
    .byte $74
    .byte $FD, $A << 4
    .byte $74
    .byte $FD, $E << 4
    .byte $74
    .byte $FF

;Samus run and point up.
Frame_8995:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run and point up.
Frame_89A9:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run and point up.
Frame_89BE:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus run and point up.
Frame_89D2:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus point up, run and fire.
Frame_89E6:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus point up, run and fire.
Frame_89FB:
    .byte ($4 << 4) + $6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, $2 << 4
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, $6 << 4
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Bomb explode.
Frame_8A0F:
    .byte ($0 << 4) + $D, $0C, $0C
    .byte $75
    .byte $FD, $6 << 4
    .byte $75
    .byte $FD, $A << 4
    .byte $75
    .byte $FD, $E << 4
    .byte $75
    .byte $FF

;Bomb explode.
Frame_8A1D:
    .byte ($0 << 4) + $0, $00, $00
    .byte $FF

;Wave beam.
Frame_8A21:
    .byte ($0 << 4) + $4, $04, $04
    .byte $4C
    .byte $FF

;Bomb explode.
Frame_8A26:
    .byte ($0 >> 4) + $8, $10, $10
    .byte $3D
    .byte $3E
    .byte $4E
    .byte $FD, $6 << 4
    .byte $3E
    .byte $3D
    .byte $4E
    .byte $FD, $E << 4
    .byte $4E
    .byte $3E
    .byte $3D
    .byte $FD, $A << 4
    .byte $4E
    .byte $3D
    .byte $3E
    .byte $FF

;Bomb tick.
Frame_8A3C:
    .byte ($0 << 4) + $4, $04, $04
    .byte $70
    .byte $FF

;Bomb tick.
Frame_8A41:
    .byte ($0 << 4) + $4, $04, $04
    .byte $71
    .byte $FF

;Bomb item.
Frame_8A46:
    .byte ($0 << 4) + $D, $03, $03
    .byte $86
    .byte $87
    .byte $96
    .byte $97
    .byte $FF

;High jump item.
Frame_8A4E:
    .byte ($0 << 4) + $D, $03, $03
    .byte $7B
    .byte $7C
    .byte $8B
    .byte $8C
    .byte $FF

;Frame_ong beam item.
Frame_8A56:
    .byte ($0 << 4) + $D, $03, $03
    .byte $88
    .byte $67
    .byte $98
    .byte $99
    .byte $FF

;Screw attack item.
Frame_8A5E:
    .byte ($0 << 4) + $D, $03, $03
    .byte $80
    .byte $81
    .byte $90
    .byte $91
    .byte $FF

;Maru Mari item.
Frame_8A66:
    .byte ($0 << 4) + $D, $03, $03
    .byte $7D
    .byte $7E
    .byte $8D
    .byte $8E
    .byte $FF

;Varia item.
Frame_8A6E:
    .byte ($0 << 4) + $D, $03, $03
    .byte $82
    .byte $83
    .byte $92
    .byte $93
    .byte $FF

;Wave beam item.
Frame_8A76:
    .byte ($0 << 4) + $D, $03, $03
    .byte $88
    .byte $89
    .byte $98
    .byte $99
    .byte $FF

;Ice beam item.
Frame_8A7E:
    .byte ($0 << 4) + $D, $03, $03
    .byte $88
    .byte $68
    .byte $98
    .byte $99
    .byte $FF

;Energy tank item.
Frame_8A86:
    .byte ($0 << 4) + $D, $03, $03
    .byte $84
    .byte $85
    .byte $94
    .byte $95
    .byte $FF

;Missile item.
Frame_8A8E:
    .byte ($0 << 4) + $D, $03, $03
    .byte $3F
    .byte $FD, $4 << 4
    .byte $3F
    .byte $FD, $0 << 4
    .byte $4F
    .byte $FD, $4 << 4
    .byte $4F
    .byte $FF

;Skree burrow.
Frame_8A9C:
    .byte ($3 << 4) + $4, $04, $04
    .byte $F2
    .byte $FF

;Not used.
Frame_8AA1:
    .byte ($0 << 4) + $4, $00, $00
    .byte $5A
    .byte $FF
Frame_8AA6:
    .byte ($1 << 4) + $3, $00, $00
    .byte $B0
    .byte $B1
    .byte $B2
    .byte $B3
    .byte $FF
Frame_8AAE:
    .byte ($1 << 4) + $3, $00, $00
    .byte $B4
    .byte $B5
    .byte $B6
    .byte $B7
    .byte $B8
    .byte $B6
    .byte $B9
    .byte $B3
    .byte $FF
Frame_8ABA:
    .byte ($1 << 4) + $3, $00, $00
    .byte $B3
    .byte $BA
    .byte $BA
    .byte $FE
    .byte $80
    .byte $80
    .byte $FF

;Kraid statue.
Frame_8AC4:
    .byte ($1 << 4) + $E, $00, $08
    .byte $FA
    .byte $FB
    .byte $FA
    .byte $FB
    .byte $FC, $00, $04
    .byte $C5
    .byte $C6
    .byte $C7
    .byte $D5
    .byte $D6
    .byte $D7
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $FF

;Ridley statue.
Frame_8AD8:
    .byte ($1 << 4) + $E, $00, $08
    .byte $FA
    .byte $FB
    .byte $FA
    .byte $FB
    .byte $FE
    .byte $C8
    .byte $C9
    .byte $EB
    .byte $D8
    .byte $D9
    .byte $EA
    .byte $E8
    .byte $E9
    .byte $FF

;Missile explode.
Frame_8AE9:
    .byte ($0 << 4) + $A, $04, $08
    .byte $FD, $0 << 4
    .byte $57
    .byte $FD
    .byte $40
    .byte $57
    .byte $FF

;Missile explode.
Frame_8AF3:
    .byte ($0 << 4) + $B, $04, $0C
    .byte $FD, $0 << 4
    .byte $57
    .byte $18
    .byte $FD, $4 << 4
    .byte $18
    .byte $57
    .byte $FD, $C << 4
    .byte $18
    .byte $18
    .byte $FF

;Missile explode.
Frame_8B03:
    .byte ($0 << 4) + $C, $04, $10
    .byte $FD, $0 << 4
    .byte $57
    .byte $18
    .byte $FD, $4 << 4
    .byte $18
    .byte $57
    .byte $FD, $C << 4
    .byte $18
    .byte $18
    .byte $FF
