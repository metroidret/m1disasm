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
    .word Place_8701, Place_871F, Place_872B, Place_8737, Place_8747, Place_8751, Place_86FD, Place_875D
    .word Place_8775, Place_878D, Place_8791, Place_8799, Place_87A5, Place_8749, Place_87B1

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
Place_86FD:
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
Place_8701:
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
Place_871F:
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
Place_872B:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $F8, $F6, $F8, $FE, $F8, $06, $00, $F6, $00, $FE, $00, $06

;Elevator frame.
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;          |        |        |        |        |        |        |        |        |
;          |        |        |        |        |        |        |        |        |
;          |        |        *        |        |        |        |        |        |
;          |       0|       1|       2|       3|       4|       5|       6|       7|
;          +--------+--------+--------+--------+--------+--------+--------+--------+
Place_8737:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08, $FC, $10, $FC, $18, $FC, $20, $FC, $28

;Several projectile frames.
;          +--------+
;          |        |
;          |        |
;          |    *   |
;          |       0|
;          +--------+
Place_8747:
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
Place_8749:
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
Place_8751:
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
Place_875D:
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
Place_8775:
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
Place_878D:
;          +--0--+   +--1--+
    .byte $F8, $FC, $00, $FC

;Missile left/right and missile explode frames.
;          +--------+--------+        +--------+--------+
;          |        |        |        |        |        |
;          |        |        |        |        |        |
;          |        *        |        |        |        |
;          |       0|       1|        |       2|       3|
;          +--------+--------+        +--------+--------+
Place_8791:
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
Place_8799:
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
Place_87A5:
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
Place_87B1:
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
    .byte $40, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, $20
    .byte $FE
    .byte $41
    .byte $40
    .byte $FD, $60
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run.
Frame_87DD:
    .byte $40, $0F, $04
    .byte $02
    .byte $03
    .byte $FD, $20
    .byte $FE
    .byte $43
    .byte $42
    .byte $FD, $60
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run.
Frame_87F0:
    .byte $40, $0F, $04, $05, $06, $FD, $20, $FE, $45, $44, $FD, $60, $25, $26, $27, $35
    .byte $36, $FF

;Samus facing forward.
Frame_8802:
    .byte $00, $0F, $04, $09, $FD, $60, $09, $FD, $20, $FE, $19, $1A, $FD, $20, $29, $2A
    .byte $FE, $39, $FD, $60, $39, $FF

;Samus stand.
Frame_8818:
    .byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
    .byte $3C, $FE, $17, $FF

;Samus run and fire.
Frame_882C:
    .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $20, $21, $FE, $FE
    .byte $31, $FF

;Samus run and fire.
Frame_883E:
    .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $23, $FE, $32
    .byte $33, $34, $FF

;Samus run and fire.
Frame_8851:
    .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $25, $26, $27, $35
    .byte $36, $FF

;Samus stand and jump.
Frame_8863:
    .byte $40, $0F, $04, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $22, $07, $08, $32
    .byte $FF

;Samus jump and fire.
Frame_8874:
    .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $07, $08, $32
    .byte $FF

;Samus somersault.
Frame_8885:
    .byte $41, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus somersault.
Frame_888F:
    .byte $42, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus somersault.
Frame_8899:
    .byte $81, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus somersault.
Frame_88A3:
    .byte $82, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus roll.
Frame_88AD:
    .byte $01, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus roll.
Frame_88B8:
    .byte $81, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
Frame_88C3:
    .byte $C1, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
Frame_88CE:
    .byte $41, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus stand and fire.
Frame_88D9:
    .byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
    .byte $3C, $FE, $FE, $17, $FF

;Elevator.
Frame_88EE:
    .byte $03, $04, $10, $28, $38, $38, $FD, $60, $28, $FF

;Missile right.
Frame_88F8:
    .byte $4A, $04, $08, $5E, $5F, $FF

;Missile left.
Frame_88FE:
    .byte $0A, $04, $08, $5E, $5F, $FF

;Missile up.
Frame_8904:
    .byte $09, $08, $04, $14, $24, $FF

;Bullet fire.
Frame_890A:
    .byte $04, $02, $02, $30, $FF

;Bullet hit.
Frame_890F:
    .byte $04, $00, $00, $04, $FF

;Samus stand and point up.
Frame_8914:
    .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
    .byte $60, $3B, $3C, $FF

;Samus from ball to pointing up.
Frame_8928:
    .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
    .byte $60, $3B, $3C, $FF

;Door closed.
Frame_893C:
    .byte $35, $18, $08, $0F, $1F, $2F, $FD, $A3, $2F, $1F, $0F, $FF

;Door open/close.
Frame_8948:
    .byte $35, $18, $04, $6A, $6B, $6C, $FD, $A3, $6C, $6B, $6A, $FF

;Samus explode.
Frame_8954:
    .byte $07, $00, $00, $FC, $FC, $00, $0B, $0C, $1B, $1C, $2B, $2C, $FF

;Samus jump and point up.
Frame_8961:
    .byte $46, $0F, $04, $69, $FD, $20, $FE, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
    .byte $08, $32, $FF

;Samus jump and point up.
Frame_8974:
    .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
    .byte $08, $32, $FF

;Bomb explode.
Frame_8987:
    .byte $0D, $0C, $0C, $74, $FD, $60, $74, $FD, $A0, $74, $FD, $E0, $74, $FF

;Samus run and point up.
Frame_8995:
    .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
    .byte $FE, $FE, $31, $FF

;Samus run and point up.
Frame_89A9:
    .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
    .byte $FE, $32, $33, $34, $FF

;Samus run and point up.
Frame_89BE:
    .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
    .byte $27, $35, $36, $FF

;Samus run and point up.
Frame_89D2:
    .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
    .byte $FE, $FE, $31, $FF

;Samus point up, run and fire.
Frame_89E6:
    .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
    .byte $FE, $32, $33, $34, $FF

;Samus point up, run and fire.
Frame_89FB:
    .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
    .byte $27, $35, $36, $FF

;Bomb explode.
Frame_8A0F:
    .byte $0D, $0C, $0C, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

;Bomb explode.
Frame_8A1D:
    .byte $00, $00, $00, $FF

;Wave beam.
Frame_8A21:
    .byte $04, $04, $04, $4C, $FF

;Bomb explode.
Frame_8A26:
    .byte $08, $10, $10, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD, $E0, $4E, $3E, $3D
    .byte $FD, $A0, $4E, $3D, $3E, $FF

;Bomb tick.
Frame_8A3C:
    .byte $04, $04, $04, $70, $FF

;Bomb tick.
Frame_8A41:
    .byte $04, $04, $04, $71, $FF

;Bomb item.
Frame_8A46:
    .byte $0D, $03, $03, $86, $87, $96, $97, $FF

;High jump item.
Frame_8A4E:
    .byte $0D, $03, $03, $7B, $7C, $8B, $8C, $FF

;Frame_ong beam item.
Frame_8A56:
    .byte $0D, $03, $03, $88, $67, $98, $99, $FF

;Screw attack item.
Frame_8A5E:
    .byte $0D, $03, $03, $80, $81, $90, $91, $FF

;Maru Mari item.
Frame_8A66:
    .byte $0D, $03, $03, $7D, $7E, $8D, $8E, $FF

;Varia item.
Frame_8A6E:
    .byte $0D, $03, $03, $82, $83, $92, $93, $FF

;Wave beam item.
Frame_8A76:
    .byte $0D, $03, $03, $88, $89, $98, $99, $FF

;Ice beam item.
Frame_8A7E:
    .byte $0D, $03, $03, $88, $68, $98, $99, $FF

;Energy tank item.
Frame_8A86:
    .byte $0D, $03, $03, $84, $85, $94, $95, $FF

;Missile item.
Frame_8A8E:
    .byte $0D, $03, $03, $3F, $FD, $40, $3F, $FD, $00, $4F, $FD, $40, $4F, $FF

;Skree burrow.
Frame_8A9C:
    .byte $34, $04, $04, $F2, $FF

;Not used.
Frame_8AA1:
    .byte $04, $00, $00, $5A, $FF
Frame_8AA6:
    .byte $13, $00, $00, $B0, $B1, $B2, $B3, $FF
Frame_8AAE:
    .byte $13, $00, $00, $B4, $B5, $B6, $B7, $B8, $B6, $B9, $B3, $FF
Frame_8ABA:
    .byte $13, $00, $00, $B3, $BA, $BA, $FE, $80, $80, $FF

;Kraid statue.
Frame_8AC4:
    .byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FC, $00, $04, $C5, $C6, $C7, $D5, $D6, $D7
    .byte $E5, $E6, $E7, $FF

;Ridley statue.
Frame_8AD8:
    .byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FE, $C8, $C9, $EB, $D8, $D9, $EA, $E8, $E9
    .byte $FF

;Missile explode.
Frame_8AE9:
    .byte $0A, $04, $08, $FD, $00, $57, $FD, $40, $57, $FF

;Missile explode.
Frame_8AF3:
    .byte $0B, $04, $0C, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF

;Missile explode.
Frame_8B03:
    .byte $0C, $04, $10, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF
