; TODO: Organized this better and maybe split it up more sensibly.

;---------------------------------[ Object animation data tables ]----------------------------------

;The following tables are indices into the FramePtrTable that correspond to various animations. The
;FramePtrTable represents individual frames and the entries in ObjectAnimIndexTbl are the groups of
;frames responsible for animaton Samus, her weapons and other objects.
;$F7 means the frame is invisible, $FF means animation ends.

ObjectAnimIndexTbl:

;Samus run animation.
L8572:  .byte _id_Frame03, _id_Frame04, _id_Frame05, $FF

;Samus front animation.
L8576:  .byte _id_Frame07, $FF

;Samus jump out of ball animation.
L8578:  .byte _id_Frame17

;Samus Stand animation.
L8579:  .byte _id_Frame08, $FF

;Samus stand and fire animation.
L857B:  .byte _id_Frame22, $FF

;Samus stand and jump animation.
L857D:  .byte _id_Frame04

;Samus Jump animation.
L857E:  .byte _id_Frame10, $FF

;Samus somersault animation.
L8580:  .byte _id_Frame17, _id_Frame18, _id_Frame19, _id_Frame1A, $FF

;Samus run and jump animation.
L8585:  .byte _id_Frame03, _id_Frame17, $FF

;Samus roll animation.
L8588:  .byte _id_Frame1E, _id_Frame1D, _id_Frame1C, _id_Frame1B, $FF

;Bullet animation.
L858D:  .byte _id_Frame28, $FF

;Bullet hit animation.
L858F:  .byte _id_Frame2A, $F7, $FF

;Samus jump and fire animation.
L8592:  .byte _id_Frame12, $FF

;Samus run and fire animation.
L8594:  .byte _id_Frame0C, _id_Frame0D, _id_Frame0E, $FF

;Samus point up and shoot animation.
L8598:  .byte _id_Frame30

;Samus point up animation.
L8599:  .byte _id_Frame2B, $FF

;Door open animation.
L859B:  .byte _id_Frame31, _id_Frame31, _id_Frame33, $F7, $FF

;Door close animation.
L85A0:  .byte _id_Frame33, _id_Frame33, _id_Frame31, $FF

;Samus explode animation.
L85A4: .byte _id_Frame35, $FF

;Samus jump and point up animation.
L85A6: .byte _id_Frame39, _id_Frame38, $FF

;Samus run and point up animation.
L85A9:  .byte _id_Frame40, _id_Frame41, _id_Frame42, $FF

;Samus run, point up and shoot animation 1.
L85AD:  .byte _id_Frame46, $FF

;Samus run, point up and shoot animation 2.
L85AF:  .byte _id_Frame47, $FF

;Samus run, point up and shoot animation 3.
L85B1:  .byte _id_Frame48, $FF

;Samus on elevator animation 1.
L85B3:  .byte _id_Frame07, $F7, $F7, _id_Frame07, $F7, $F7, $F7, _id_Frame07, $F7, $F7, $F7, $F7, _id_Frame07, $F7, $FF

;Samus on elevator animation 2.
L85C2:  .byte _id_Frame23, $F7, $F7, _id_Frame23, $F7, $F7, $F7, _id_Frame23, $F7, $F7, $F7, $F7, _id_Frame23, $F7, $FF

;Samus on elevator animation 3.
L85D1:  .byte _id_Frame07, $F7, $F7, $F7, $F7, _id_Frame07, $F7, $F7, $F7, _id_Frame07, $F7, $F7, _id_Frame07, $F7, $FF

;Samus on elevator animation 4.
L85E0:  .byte _id_Frame23, $F7, $F7, $F7, $F7, _id_Frame23, $F7, $F7, $F7, _id_Frame23, $F7, $F7, _id_Frame23, $F7, $FF

;Wave beam animation.
L85EF:  .byte _id_Frame4B, $FF

;Bomb tick animation.
L85F1:  .byte _id_Frame4E, _id_Frame4F, $FF

;Bomb explode animation.
L85F4:  .byte _id_Frame3C, _id_Frame4A, _id_Frame49, _id_Frame4A, _id_Frame4D, _id_Frame4A, _id_Frame4D, $F7, $FF

;Missile left animation.
L85FD:  .byte _id_Frame26, $FF

;Missile right animation.
L85FF:  .byte _id_Frame25, $FF

;Missile up animation.
L8601:  .byte _id_Frame27, $FF

;Missile explode animation.
L8603:  .byte _id_Frame67, _id_Frame67, _id_Frame67, _id_Frame68, _id_Frame68, _id_Frame69, $F7, $FF

;----------------------------[ Sprite drawing pointer tables ]--------------------------------------

;The above animation pointers provide an index into the following table
;for the animation sequences.

FramePtrTable:
    PtrTableEntry FramePtrTable, Frame00
    PtrTableEntry FramePtrTable, Frame01
    PtrTableEntry FramePtrTable, Frame02
    PtrTableEntry FramePtrTable, Frame03
    PtrTableEntry FramePtrTable, Frame04
    PtrTableEntry FramePtrTable, Frame05
    PtrTableEntry FramePtrTable, Frame06
    PtrTableEntry FramePtrTable, Frame07
    PtrTableEntry FramePtrTable, Frame08
    PtrTableEntry FramePtrTable, Frame09
    PtrTableEntry FramePtrTable, Frame0A
    PtrTableEntry FramePtrTable, Frame0B
    PtrTableEntry FramePtrTable, Frame0C
    PtrTableEntry FramePtrTable, Frame0D
    PtrTableEntry FramePtrTable, Frame0E
    PtrTableEntry FramePtrTable, Frame0F
    PtrTableEntry FramePtrTable, Frame10
    PtrTableEntry FramePtrTable, Frame11
    PtrTableEntry FramePtrTable, Frame12
    PtrTableEntry FramePtrTable, Frame13
    PtrTableEntry FramePtrTable, Frame14
    PtrTableEntry FramePtrTable, Frame15
    PtrTableEntry FramePtrTable, Frame16
    PtrTableEntry FramePtrTable, Frame17
    PtrTableEntry FramePtrTable, Frame18
    PtrTableEntry FramePtrTable, Frame19
    PtrTableEntry FramePtrTable, Frame1A
    PtrTableEntry FramePtrTable, Frame1B
    PtrTableEntry FramePtrTable, Frame1C
    PtrTableEntry FramePtrTable, Frame1D
    PtrTableEntry FramePtrTable, Frame1E
    PtrTableEntry FramePtrTable, Frame1F
    PtrTableEntry FramePtrTable, Frame20
    PtrTableEntry FramePtrTable, Frame21
    PtrTableEntry FramePtrTable, Frame22
    PtrTableEntry FramePtrTable, Frame23
    PtrTableEntry FramePtrTable, Frame24
    PtrTableEntry FramePtrTable, Frame25
    PtrTableEntry FramePtrTable, Frame26
    PtrTableEntry FramePtrTable, Frame27
    PtrTableEntry FramePtrTable, Frame28
    PtrTableEntry FramePtrTable, Frame29
    PtrTableEntry FramePtrTable, Frame2A
    PtrTableEntry FramePtrTable, Frame2B
    PtrTableEntry FramePtrTable, Frame2C
    PtrTableEntry FramePtrTable, Frame2D
    PtrTableEntry FramePtrTable, Frame2E
    PtrTableEntry FramePtrTable, Frame2F
    PtrTableEntry FramePtrTable, Frame30
    PtrTableEntry FramePtrTable, Frame31
    PtrTableEntry FramePtrTable, Frame32
    PtrTableEntry FramePtrTable, Frame33
    PtrTableEntry FramePtrTable, Frame34
    PtrTableEntry FramePtrTable, Frame35
    PtrTableEntry FramePtrTable, Frame36
    PtrTableEntry FramePtrTable, Frame37
    PtrTableEntry FramePtrTable, Frame38
    PtrTableEntry FramePtrTable, Frame39
    PtrTableEntry FramePtrTable, Frame3A
    PtrTableEntry FramePtrTable, Frame3B
    PtrTableEntry FramePtrTable, Frame3C
    PtrTableEntry FramePtrTable, Frame3D
    PtrTableEntry FramePtrTable, Frame3E
    PtrTableEntry FramePtrTable, Frame3F
    PtrTableEntry FramePtrTable, Frame40
    PtrTableEntry FramePtrTable, Frame41
    PtrTableEntry FramePtrTable, Frame42
    PtrTableEntry FramePtrTable, Frame43
    PtrTableEntry FramePtrTable, Frame44
    PtrTableEntry FramePtrTable, Frame45
    PtrTableEntry FramePtrTable, Frame46
    PtrTableEntry FramePtrTable, Frame47
    PtrTableEntry FramePtrTable, Frame48
    PtrTableEntry FramePtrTable, Frame49
    PtrTableEntry FramePtrTable, Frame4A
    PtrTableEntry FramePtrTable, Frame4B
    PtrTableEntry FramePtrTable, Frame4C
    PtrTableEntry FramePtrTable, Frame4D
    PtrTableEntry FramePtrTable, Frame4E
    PtrTableEntry FramePtrTable, Frame4F
    PtrTableEntry FramePtrTable, Frame50
    PtrTableEntry FramePtrTable, Frame51
    PtrTableEntry FramePtrTable, Frame52
    PtrTableEntry FramePtrTable, Frame53
    PtrTableEntry FramePtrTable, Frame54
    PtrTableEntry FramePtrTable, Frame55
    PtrTableEntry FramePtrTable, Frame56
    PtrTableEntry FramePtrTable, Frame57
    PtrTableEntry FramePtrTable, Frame58
    PtrTableEntry FramePtrTable, Frame59
    PtrTableEntry FramePtrTable, Frame5A
    PtrTableEntry FramePtrTable, Frame5B
    PtrTableEntry FramePtrTable, Frame5C
    PtrTableEntry FramePtrTable, Frame5D
    PtrTableEntry FramePtrTable, Frame5E
    PtrTableEntry FramePtrTable, Frame5F
    PtrTableEntry FramePtrTable, Frame60
    PtrTableEntry FramePtrTable, Frame61
    PtrTableEntry FramePtrTable, Frame62
    PtrTableEntry FramePtrTable, Frame63
    PtrTableEntry FramePtrTable, Frame64
    PtrTableEntry FramePtrTable, Frame65
    PtrTableEntry FramePtrTable, Frame66
    PtrTableEntry FramePtrTable, Frame67
    PtrTableEntry FramePtrTable, Frame68
    PtrTableEntry FramePtrTable, Frame69

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.

PlacePtrTable:
    PtrTableEntry PlacePtrTable, Place0
    PtrTableEntry PlacePtrTable, Place1
    PtrTableEntry PlacePtrTable, Place2
    PtrTableEntry PlacePtrTable, Place3
    PtrTableEntry PlacePtrTable, Place4
    PtrTableEntry PlacePtrTable, Place5
    PtrTableEntry PlacePtrTable, Place6
    PtrTableEntry PlacePtrTable, Place7
    PtrTableEntry PlacePtrTable, Place8
    PtrTableEntry PlacePtrTable, Place9
    PtrTableEntry PlacePtrTable, PlaceA
    PtrTableEntry PlacePtrTable, PlaceB
    PtrTableEntry PlacePtrTable, PlaceC
    PtrTableEntry PlacePtrTable, PlaceD
    PtrTableEntry PlacePtrTable, PlaceE

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
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85

;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

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
Frame00:
Frame01:
Frame02:
Frame03:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame04:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame05:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame06:
Frame07:
    .byte ($0 << 4) + _id_Place0, $0F, $04
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
Frame08:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame09:
Frame0A:
Frame0B:
Frame0C:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame0D:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame0E:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame0F:
Frame10:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame11:
Frame12:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame13:
Frame14:
Frame15:
Frame16:
Frame17:
    .byte ($4 << 4) + _id_Place1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
Frame18:
    .byte ($4 << 4) + _id_Place2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus somersault.
Frame19:
    .byte ($8 << 4) + _id_Place1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
Frame1A:
    .byte ($8 << 4) + _id_Place2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus roll.
Frame1B:
    .byte ($0 << 4) + _id_Place1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame1C:
    .byte ($8 << 4) + _id_Place1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame1D:
    .byte ($C << 4) + _id_Place1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
Frame1E:
    .byte ($4 << 4) + _id_Place1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus stand and fire.
Frame1F:
Frame20:
Frame21:
Frame22:
    .byte ($4 << 4) + _id_Place0, $0F, $04
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
Frame23:
    .byte ($0 << 4) + _id_Place3, $04, $10
    .byte $28
    .byte $38
    .byte $38
    .byte $FD, $6 << 4
    .byte $28
    .byte $FF

;Missile right.
Frame24:
Frame25:
    .byte ($4 << 4) + _id_PlaceA, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile left.
Frame26:
    .byte ($0 << 4) + _id_PlaceA, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile up.
Frame27:
    .byte ($0 << 4) + _id_Place9, $08, $04
    .byte $14
    .byte $24
    .byte $FF

;Bullet fire.
Frame28:
    .byte ($0 << 4) + _id_Place4, $02, $02
    .byte $30
    .byte $FF

;Bullet hit.
Frame29:
Frame2A:
    .byte ($0 << 4) + _id_Place4, $00, $00
    .byte $04
    .byte $FF

;Samus stand and point up.
Frame2B:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame2C:
Frame2D:
Frame2E:
Frame2F:
Frame30:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame31:
    .byte ($3 << 4) + _id_Place5, $18, $08
    .byte $0F
    .byte $1F
    .byte $2F
    .byte $FD, ($A << 4) + $3
    .byte $2F
    .byte $1F
    .byte $0F
    .byte $FF

;Door open/close.
Frame32:
Frame33:
    .byte ($3 << 4) + _id_Place5, $18, $04
    .byte $6A
    .byte $6B
    .byte $6C
    .byte $FD, ($A << 4) + $3
    .byte $6C
    .byte $6B
    .byte $6A
    .byte $FF

;Samus explode.
Frame34:
Frame35:
    .byte ($0 << 4) + _id_Place7, $00, $00
    .byte $FC, $FC, $00
    .byte $0B
    .byte $0C
    .byte $1B
    .byte $1C
    .byte $2B
    .byte $2C
    .byte $FF

;Samus jump and point up.
Frame36:
Frame37:
Frame38:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame39:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame3A:
Frame3B:
Frame3C:
    .byte ($0 << 4) + _id_PlaceD, $0C, $0C
    .byte $74
    .byte $FD, $6 << 4
    .byte $74
    .byte $FD, $A << 4
    .byte $74
    .byte $FD, $E << 4
    .byte $74
    .byte $FF

;Samus run and point up.
Frame3D:
Frame3E:
Frame3F:
Frame40:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame41:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame42:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame43:
Frame44:
Frame45:
Frame46:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame47:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame48:
    .byte ($4 << 4) + _id_Place6, $0F, $04
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
Frame49:
    .byte ($0 << 4) + _id_PlaceD, $0C, $0C
    .byte $75
    .byte $FD, $6 << 4
    .byte $75
    .byte $FD, $A << 4
    .byte $75
    .byte $FD, $E << 4
    .byte $75
    .byte $FF

;Bomb explode.
Frame4A:
    .byte ($0 << 4) + _id_Place0, $00, $00
    .byte $FF

;Wave beam.
Frame4B:
    .byte ($0 << 4) + _id_Place4, $04, $04
    .byte $4C
    .byte $FF

;Bomb explode.
Frame4C:
Frame4D:
    .byte ($0 >> 4) + _id_Place8, $10, $10
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
Frame4E:
    .byte ($0 << 4) + _id_Place4, $04, $04
    .byte $70
    .byte $FF

;Bomb tick.
Frame4F:
    .byte ($0 << 4) + _id_Place4, $04, $04
    .byte $71
    .byte $FF

;Bomb item.
Frame50:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $86
    .byte $87
    .byte $96
    .byte $97
    .byte $FF

;High jump item.
Frame51:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $7B
    .byte $7C
    .byte $8B
    .byte $8C
    .byte $FF

;Frame_ong beam item.
Frame52:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $88
    .byte $67
    .byte $98
    .byte $99
    .byte $FF

;Screw attack item.
Frame53:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $80
    .byte $81
    .byte $90
    .byte $91
    .byte $FF

;Maru Mari item.
Frame54:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $7D
    .byte $7E
    .byte $8D
    .byte $8E
    .byte $FF

;Varia item.
Frame55:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $82
    .byte $83
    .byte $92
    .byte $93
    .byte $FF

;Wave beam item.
Frame56:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $88
    .byte $89
    .byte $98
    .byte $99
    .byte $FF

;Ice beam item.
Frame57:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $88
    .byte $68
    .byte $98
    .byte $99
    .byte $FF

;Energy tank item.
Frame58:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $84
    .byte $85
    .byte $94
    .byte $95
    .byte $FF

;Missile item.
Frame59:
    .byte ($0 << 4) + _id_PlaceD, $03, $03
    .byte $3F
    .byte $FD, $4 << 4
    .byte $3F
    .byte $FD, $0 << 4
    .byte $4F
    .byte $FD, $4 << 4
    .byte $4F
    .byte $FF

;Skree burrow.
Frame5A:
    .byte ($3 << 4) + _id_Place4, $04, $04
    .byte $F2
    .byte $FF

;Not used.
Frame5B:
    .byte ($0 << 4) + _id_Place4, $00, $00
    .byte $5A
    .byte $FF
Frame5C:
    .byte ($1 << 4) + _id_Place3, $00, $00
    .byte $B0
    .byte $B1
    .byte $B2
    .byte $B3
    .byte $FF
Frame5D:
    .byte ($1 << 4) + _id_Place3, $00, $00
    .byte $B4
    .byte $B5
    .byte $B6
    .byte $B7
    .byte $B8
    .byte $B6
    .byte $B9
    .byte $B3
    .byte $FF
Frame5E:
    .byte ($1 << 4) + _id_Place3, $00, $00
    .byte $B3
    .byte $BA
    .byte $BA
    .byte $FE
    .byte $80
    .byte $80
    .byte $FF

;Kraid statue.
Frame5F:
Frame60:
Frame61:
Frame62:
Frame63:
Frame64:
Frame65:
    .byte ($1 << 4) + _id_PlaceE, $00, $08
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
Frame66:
    .byte ($1 << 4) + _id_PlaceE, $00, $08
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
Frame67:
    .byte ($0 << 4) + _id_PlaceA, $04, $08
    .byte $FD, $0 << 4
    .byte $57
    .byte $FD
    .byte $40
    .byte $57
    .byte $FF

;Missile explode.
Frame68:
    .byte ($0 << 4) + _id_PlaceB, $04, $0C
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
Frame69:
    .byte ($0 << 4) + _id_PlaceC, $04, $10
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
