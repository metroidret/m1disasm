; TODO: Organized this better and maybe split it up more sensibly.

;---------------------------------[ Object animation data tables ]----------------------------------

;The following tables are indices into the ObjFramePtrTable that correspond to various animations. The
;ObjFramePtrTable represents individual frames and the entries in ObjectAnimIndexTbl are the groups of
;frames responsible for animaton Samus, her weapons and other objects.
;$F7 means the frame is invisible, $FF means animation ends.



ObjectAnimIndexTbl:

;Samus run animation.
ObjAnim_SamusRun: ;$00
    .byte _id_ObjFrame_SamusRun0, _id_ObjFrame_SamusRun1, _id_ObjFrame_SamusRun2, $FF

;Samus front animation.
ObjAnim_SamusFront: ;$04
    .byte _id_ObjFrame_SamusFront, $FF

;Samus jump out of ball animation.
ObjAnim_SamusUnroll: ;$06
    .byte _id_ObjFrame_SamusSalto0
;Samus Stand animation.
ObjAnim_SamusStand: ;$07
    .byte _id_ObjFrame_SamusStand, $FF

;Samus stand and fire animation.
ObjAnim_SamusStandFire: ;$09
    .byte _id_ObjFrame_SamusStandFire, $FF

;Samus stand and jump animation.
ObjAnim_SamusJumpTransition: ;$0B
    .byte _id_ObjFrame_SamusRun1
;Samus Jump animation.
ObjAnim_SamusJump: ;$0C
    .byte _id_ObjFrame_SamusJump, $FF

;Samus somersault animation.
ObjAnim_SamusSalto: ;$0E
    .byte _id_ObjFrame_SamusSalto0, _id_ObjFrame_SamusSalto1, _id_ObjFrame_SamusSalto2, _id_ObjFrame_SamusSalto3, $FF

;Samus run and jump animation.
ObjAnim_SamusRunJump: ;$13
    .byte _id_ObjFrame_SamusRun0, _id_ObjFrame_SamusSalto0, $FF

;Samus roll animation.
ObjAnim_SamusRoll: ;$16
    .byte _id_ObjFrame_SamusRoll0, _id_ObjFrame_SamusRoll1, _id_ObjFrame_SamusRoll2, _id_ObjFrame_SamusRoll3, $FF

;Bullet animation.
ObjAnim_RegularBullet: ;$1B
    .byte _id_ObjFrame_RegularBullet, $FF

;Bullet hit animation.
ObjAnim_BulletHit: ;$1D
    .byte _id_ObjFrame_BulletHit, $F7, $FF

;Samus jump and fire animation.
ObjAnim_SamusJumpFire: ;$20
    .byte _id_ObjFrame_SamusJumpFire, $FF

;Samus run and fire animation.
ObjAnim_SamusRunFire: ;$22
    .byte _id_ObjFrame_SamusRunFire0, _id_ObjFrame_SamusRunFire1, _id_ObjFrame_SamusRunFire2, $FF

;Samus point up and shoot animation.
ObjAnim_SamusPntUpFire: ;$26
    .byte _id_ObjFrame_SamusPntUpFire
;Samus point up animation.
ObjAnim_SamusPntUp: ;$27
    .byte _id_ObjFrame_SamusPntUp, $FF

;Door open animation.
ObjAnim_DoorOpen: ;$29
    .byte _id_ObjFrame_DoorClosed, _id_ObjFrame_DoorClosed, _id_ObjFrame_DoorOpenClose
ObjAnim_DoorOpen_Reset: ;$2C
    .byte $F7, $FF

;Door close animation.
ObjAnim_DoorClose: ;$2E
    .byte _id_ObjFrame_DoorOpenClose, _id_ObjFrame_DoorOpenClose
ObjAnim_DoorClose_Reset: ;$30
    .byte _id_ObjFrame_DoorClosed, $FF

;Samus explode animation.
ObjAnim_SamusExplode: ;$32
    .byte _id_ObjFrame_SamusExplode, $FF

;Samus jump and point up animation.
ObjAnim_SamusJumpPntUpFire: ;$34
    .byte _id_ObjFrame_SamusJumpPntUpFire
ObjAnim_SamusJumpPntUp: ;$35
    .byte _id_ObjFrame_SamusJumpPntUp, $FF

;Samus run and point up animation.
ObjAnim_SamusRunPntUp: ;$37
    .byte _id_ObjFrame_SamusRunPntUp0, _id_ObjFrame_SamusRunPntUp1, _id_ObjFrame_SamusRunPntUp2, $FF

;Samus run, point up and shoot animation 1.
ObjAnim_SamusRunPntUpFire1: ;$3B
    .byte _id_ObjFrame_SamusRunPntUpFire0, $FF

;Samus run, point up and shoot animation 2.
ObjAnim_SamusRunPntUpFire2: ;$3D
    .byte _id_ObjFrame_SamusRunPntUpFire1, $FF

;Samus run, point up and shoot animation 3.
ObjAnim_SamusRunPntUpFire3: ;$3F
    .byte _id_ObjFrame_SamusRunPntUpFire2, $FF

;Samus front fade out of old area. (plays for only one frame on NES)
ObjAnim_SamusFadeOutArea: ;$41
    .byte _id_ObjFrame_SamusFront, $F7, $F7, _id_ObjFrame_SamusFront, $F7, $F7, $F7, _id_ObjFrame_SamusFront, $F7, $F7, $F7, $F7, _id_ObjFrame_SamusFront
ObjAnim_SamusFadeOutArea_Reset: ;$4E
    .byte $F7, $FF

;Elevator fade out of old area. (plays for only one frame on NES)
ObjAnim_ElevatorFadeOutArea: ;$50
    .byte _id_ObjFrame_Elevator, $F7, $F7, _id_ObjFrame_Elevator, $F7
ObjAnim_55: ;$55 (referenced in MotherBrain_SpawnDoor)
    .byte $F7, $F7, _id_ObjFrame_Elevator, $F7, $F7, $F7, $F7, _id_ObjFrame_Elevator
ObjAnim_ElevatorFadeOutArea_Reset: ;$5D
    .byte $F7, $FF

;Samus front fade into new area. (plays for only one frame on NES)
ObjAnim_SamusFadeInArea: ;$5F
    .byte _id_ObjFrame_SamusFront, $F7, $F7, $F7, $F7, _id_ObjFrame_SamusFront, $F7, $F7, $F7, _id_ObjFrame_SamusFront, $F7, $F7
ObjAnim_SamusFadeInArea_Reset: ;$6B
    .byte _id_ObjFrame_SamusFront, $F7, $FF

;Elevator fade into new area. (plays for only one frame on NES)
ObjAnim_ElevatorFadeInArea: ;$6E
    .byte _id_ObjFrame_Elevator, $F7, $F7, $F7, $F7, _id_ObjFrame_Elevator, $F7, $F7, $F7, _id_ObjFrame_Elevator, $F7, $F7
ObjAnim_ElevatorFadeInArea_Reset: ;$7A
    .byte _id_ObjFrame_Elevator, $F7, $FF

;Wave beam animation.
ObjAnim_WaveBeam: ;$7D
    .byte _id_ObjFrame_WaveBeam, $FF

;Bomb tick animation.
ObjAnim_BombTick: ;$7F
    .byte _id_ObjFrame_Bomb0, _id_ObjFrame_Bomb1, $FF

;Bomb explode animation.
ObjAnim_BombExplode: ;$82
    .byte _id_ObjFrame_BombExplode0, _id_ObjFrame_BombExplodeBlank, _id_ObjFrame_BombExplode1, _id_ObjFrame_BombExplodeBlank, _id_ObjFrame_BombExplode2, _id_ObjFrame_BombExplodeBlank, _id_ObjFrame_BombExplode2, $F7, $FF

;Missile left animation.
ObjAnim_MissileLeft: ;$8B
    .byte _id_ObjFrame_MissileLeft, $FF

;Missile right animation.
ObjAnim_MissileRight: ;$8D
    .byte _id_ObjFrame_MissileRight, $FF

;Missile up animation.
ObjAnim_MissileUp: ;$8F
    .byte _id_ObjFrame_MissileUp, $FF

;Missile explode animation.
ObjAnim_MissileExplode: ;$91
    .byte _id_ObjFrame_MissileExplode0, _id_ObjFrame_MissileExplode0, _id_ObjFrame_MissileExplode0, _id_ObjFrame_MissileExplode1, _id_ObjFrame_MissileExplode1, _id_ObjFrame69, $F7, $FF

;----------------------------[ Sprite drawing pointer tables ]--------------------------------------

;The above animation pointers provide an index into the following table
;for the animation sequences.
ObjFramePtrTable:
    PtrTableEntry ObjFramePtrTable, ObjFrame00
    PtrTableEntry ObjFramePtrTable, ObjFrame01
    PtrTableEntry ObjFramePtrTable, ObjFrame02
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRun0
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRun1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRun2
    PtrTableEntry ObjFramePtrTable, ObjFrame06
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusFront
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusStand
    PtrTableEntry ObjFramePtrTable, ObjFrame09
    PtrTableEntry ObjFramePtrTable, ObjFrame0A
    PtrTableEntry ObjFramePtrTable, ObjFrame0B
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunFire0
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunFire1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunFire2
    PtrTableEntry ObjFramePtrTable, ObjFrame0F
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusJump
    PtrTableEntry ObjFramePtrTable, ObjFrame11
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusJumpFire
    PtrTableEntry ObjFramePtrTable, ObjFrame13
    PtrTableEntry ObjFramePtrTable, ObjFrame14
    PtrTableEntry ObjFramePtrTable, ObjFrame15
    PtrTableEntry ObjFramePtrTable, ObjFrame16
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusSalto0
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusSalto1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusSalto2
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusSalto3
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRoll3
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRoll2
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRoll1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRoll0
    PtrTableEntry ObjFramePtrTable, ObjFrame1F
    PtrTableEntry ObjFramePtrTable, ObjFrame20
    PtrTableEntry ObjFramePtrTable, ObjFrame21
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusStandFire
    PtrTableEntry ObjFramePtrTable, ObjFrame_Elevator
    PtrTableEntry ObjFramePtrTable, ObjFrame24
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileRight
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileLeft
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileUp
    PtrTableEntry ObjFramePtrTable, ObjFrame_RegularBullet
    PtrTableEntry ObjFramePtrTable, ObjFrame29
    PtrTableEntry ObjFramePtrTable, ObjFrame_BulletHit
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusPntUp
    PtrTableEntry ObjFramePtrTable, ObjFrame2C
    PtrTableEntry ObjFramePtrTable, ObjFrame2D
    PtrTableEntry ObjFramePtrTable, ObjFrame2E
    PtrTableEntry ObjFramePtrTable, ObjFrame2F
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusPntUpFire
    PtrTableEntry ObjFramePtrTable, ObjFrame_DoorClosed
    PtrTableEntry ObjFramePtrTable, ObjFrame32
    PtrTableEntry ObjFramePtrTable, ObjFrame_DoorOpenClose
    PtrTableEntry ObjFramePtrTable, ObjFrame34
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusExplode
    PtrTableEntry ObjFramePtrTable, ObjFrame36
    PtrTableEntry ObjFramePtrTable, ObjFrame37
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusJumpPntUp
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusJumpPntUpFire
    PtrTableEntry ObjFramePtrTable, ObjFrame3A
    PtrTableEntry ObjFramePtrTable, ObjFrame3B
    PtrTableEntry ObjFramePtrTable, ObjFrame_BombExplode0
    PtrTableEntry ObjFramePtrTable, ObjFrame3D
    PtrTableEntry ObjFramePtrTable, ObjFrame3E
    PtrTableEntry ObjFramePtrTable, ObjFrame3F
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUp0
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUp1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUp2
    PtrTableEntry ObjFramePtrTable, ObjFrame43
    PtrTableEntry ObjFramePtrTable, ObjFrame44
    PtrTableEntry ObjFramePtrTable, ObjFrame45
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUpFire0
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUpFire1
    PtrTableEntry ObjFramePtrTable, ObjFrame_SamusRunPntUpFire2
    PtrTableEntry ObjFramePtrTable, ObjFrame_BombExplode1
    PtrTableEntry ObjFramePtrTable, ObjFrame_BombExplodeBlank
    PtrTableEntry ObjFramePtrTable, ObjFrame_WaveBeam
    PtrTableEntry ObjFramePtrTable, ObjFrame4C
    PtrTableEntry ObjFramePtrTable, ObjFrame_BombExplode2
    PtrTableEntry ObjFramePtrTable, ObjFrame_Bomb0
    PtrTableEntry ObjFramePtrTable, ObjFrame_Bomb1
    PtrTableEntry ObjFramePtrTable, ObjFrame_BombItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_HighJumpItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_LongBeamItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_ScrewAttackItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_MaruMariItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_VariaSuitItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_WaveBeamItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_IceBeamItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_EnergyTankItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileItem
    PtrTableEntry ObjFramePtrTable, ObjFrame_SkreeProjectile
    PtrTableEntry ObjFramePtrTable, ObjFrame5B
    PtrTableEntry ObjFramePtrTable, ObjFrame5C
    PtrTableEntry ObjFramePtrTable, ObjFrame5D
    PtrTableEntry ObjFramePtrTable, ObjFrame5E
    PtrTableEntry ObjFramePtrTable, ObjFrame5F
    PtrTableEntry ObjFramePtrTable, ObjFrame60
    PtrTableEntry ObjFramePtrTable, ObjFrame61
    PtrTableEntry ObjFramePtrTable, ObjFrame62
    PtrTableEntry ObjFramePtrTable, ObjFrame63
    PtrTableEntry ObjFramePtrTable, ObjFrame64
    PtrTableEntry ObjFramePtrTable, ObjFrame_KraidStatue
    PtrTableEntry ObjFramePtrTable, ObjFrame_RidleyStatue
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileExplode0
    PtrTableEntry ObjFramePtrTable, ObjFrame_MissileExplode1
    PtrTableEntry ObjFramePtrTable, ObjFrame69

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.
ObjPlacePtrTable:
    PtrTableEntry ObjPlacePtrTable, ObjPlace0
    PtrTableEntry ObjPlacePtrTable, ObjPlace1
    PtrTableEntry ObjPlacePtrTable, ObjPlace2
    PtrTableEntry ObjPlacePtrTable, ObjPlace3
    PtrTableEntry ObjPlacePtrTable, ObjPlace4
    PtrTableEntry ObjPlacePtrTable, ObjPlace5
    PtrTableEntry ObjPlacePtrTable, ObjPlace6
    PtrTableEntry ObjPlacePtrTable, ObjPlace7
    PtrTableEntry ObjPlacePtrTable, ObjPlace8
    PtrTableEntry ObjPlacePtrTable, ObjPlace9
    PtrTableEntry ObjPlacePtrTable, ObjPlaceA
    PtrTableEntry ObjPlacePtrTable, ObjPlaceB
    PtrTableEntry ObjPlacePtrTable, ObjPlaceC
    PtrTableEntry ObjPlacePtrTable, ObjPlaceD
    PtrTableEntry ObjPlacePtrTable, ObjPlaceE

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
ObjPlace6:
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
ObjPlace0:
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
;          |        |        |
;          |        *        |
;          |       2|       3|
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       4|       5|
;          +--------+--------+
ObjPlace1:
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
ObjPlace2:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
    .byte $F8, $F6, $F8, $FE, $F8, $06, $00, $F6, $00, $FE, $00, $06

;Elevator frame.
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;          |        |        |        |        |        |        |        |        |
;          |        |        |        |        |        |        |        |        |
;          |        |        *        |        |        |        |        |        |
;          |       0|       1|       2|       3|       4|       5|       6|       7|
;          +--------+--------+--------+--------+--------+--------+--------+--------+
ObjPlace3:
;          +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
    .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08, $FC, $10, $FC, $18, $FC, $20, $FC, $28

;Several projectile frames.
;          +--------+
;          |        |
;          |        |
;          |    *   |
;          |       0|
;          +--------+
ObjPlace4:
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
ObjPlaceD:
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
ObjPlace5:
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
ObjPlace7:
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
ObjPlace8:
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
ObjPlace9:
;          +--0--+   +--1--+
    .byte $F8, $FC, $00, $FC

;Missile left/right and missile explode frames.
;          +--------+--------+        +--------+--------+
;          |        |        |        |        |        |
;          |        |        |        |        |        |
;          |        *        |        |        |        |
;          |       0|       1|        |       2|       3|
;          +--------+--------+        +--------+--------+
ObjPlaceA:
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
ObjPlaceB:
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
ObjPlaceC:
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
ObjPlaceE:
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
;by 2 and used as an index into the ObjPlacePtrTable to find the proper placement data for the
;current frame.  The second byte is saved as the object's y radius and the third byte is saved
;as the object's x radius.

;Samus run.
ObjFrame00:
ObjFrame01:
ObjFrame02:
ObjFrame_SamusRun0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $41
    .byte $40
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run.
ObjFrame_SamusRun1:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $02
    .byte $03
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $43
    .byte $42
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run.
ObjFrame_SamusRun2:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $05
    .byte $06
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $45
    .byte $44
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus facing forward.
ObjFrame06:
ObjFrame_SamusFront:
    .byte ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $09
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $09
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $19
    .byte $1A
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $29
    .byte $2A
    .byte $FE
    .byte $39
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $39
    .byte $FF

;Samus stand.
ObjFrame_SamusStand:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $0E
    .byte $0D
    .byte $FE
    .byte $1E
    .byte $1D
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3B
    .byte $3C
    .byte $FE
    .byte $17
    .byte $FF

;Samus run and fire.
ObjFrame09:
ObjFrame0A:
ObjFrame0B:
ObjFrame_SamusRunFire0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run and fire.
ObjFrame_SamusRunFire1:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run and fire.
ObjFrame_SamusRunFire2:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus stand and jump.
ObjFrame0F:
ObjFrame_SamusJump:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $41
    .byte $40
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus jump and fire.
ObjFrame11:
ObjFrame_SamusJumpFire:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $00
    .byte $01
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $4B
    .byte $4A
    .byte $49
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus somersault.
ObjFrame13:
ObjFrame14:
ObjFrame15:
ObjFrame16:
ObjFrame_SamusSalto0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
ObjFrame_SamusSalto1:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus somersault.
ObjFrame_SamusSalto2:
    .byte OAMDATA_VFLIP + ($0 << 4) + _id_ObjPlace1, $0F, $04
    .byte $52
    .byte $53
    .byte $62
    .byte $63
    .byte $72
    .byte $73
    .byte $FF

;Samus somersault.
ObjFrame_SamusSalto3:
    .byte OAMDATA_VFLIP + ($0 << 4) + _id_ObjPlace2, $0F, $04
    .byte $54
    .byte $55
    .byte $56
    .byte $64
    .byte $65
    .byte $66
    .byte $FF

;Samus roll.
ObjFrame_SamusRoll3:
    .byte ($0 << 4) + _id_ObjPlace1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
ObjFrame_SamusRoll2:
    .byte OAMDATA_VFLIP + ($0 << 4) + _id_ObjPlace1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
ObjFrame_SamusRoll1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace1, $08, $04
    .byte $FC, $FD, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus roll.
ObjFrame_SamusRoll0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace1, $08, $04
    .byte $FC, $03, $00
    .byte $50
    .byte $51
    .byte $60
    .byte $61
    .byte $FF

;Samus stand and fire.
ObjFrame1F:
ObjFrame20:
ObjFrame21:
ObjFrame_SamusStandFire:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace0, $0F, $04
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $0E
    .byte $0D
    .byte $FE
    .byte $1E
    .byte $1D
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3B
    .byte $3C
    .byte $FE
    .byte $FE
    .byte $17
    .byte $FF

;Elevator.
ObjFrame_Elevator:
    .byte ($0 << 4) + _id_ObjPlace3, $04, $10
    .byte $28
    .byte $38
    .byte $38
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $28
    .byte $FF

;Missile right.
ObjFrame24:
ObjFrame_MissileRight:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlaceA, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile left.
ObjFrame_MissileLeft:
    .byte ($0 << 4) + _id_ObjPlaceA, $04, $08
    .byte $5E
    .byte $5F
    .byte $FF

;Missile up.
ObjFrame_MissileUp:
    .byte ($0 << 4) + _id_ObjPlace9, $08, $04
    .byte $14
    .byte $24
    .byte $FF

;Bullet fire.
ObjFrame_RegularBullet:
    .byte ($0 << 4) + _id_ObjPlace4, $02, $02
    .byte $30
    .byte $FF

;Bullet hit.
ObjFrame29:
ObjFrame_BulletHit:
    .byte ($0 << 4) + _id_ObjPlace4, $00, $00
    .byte $04
    .byte $FF

;Samus stand and point up.
ObjFrame_SamusPntUp:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3B
    .byte $3C
    .byte $FF

;Samus from ball to pointing up.
ObjFrame2C:
ObjFrame2D:
ObjFrame2E:
ObjFrame2F:
ObjFrame_SamusPntUpFire:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $2E
    .byte $2D
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3B
    .byte $3C
    .byte $FF

;Door closed.
ObjFrame_DoorClosed:
    .byte ($3 << 4) + _id_ObjPlace5, $18, $08
    .byte $0F
    .byte $1F
    .byte $2F
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $3
    .byte $2F
    .byte $1F
    .byte $0F
    .byte $FF

;Door open/close.
ObjFrame32:
ObjFrame_DoorOpenClose:
    .byte ($3 << 4) + _id_ObjPlace5, $18, $04
    .byte $6A
    .byte $6B
    .byte $6C
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $3
    .byte $6C
    .byte $6B
    .byte $6A
    .byte $FF

;Samus explode.
ObjFrame34:
ObjFrame_SamusExplode:
    .byte ($0 << 4) + _id_ObjPlace7, $00, $00
    .byte $FC, $FC, $00
    .byte $0B
    .byte $0C
    .byte $1B
    .byte $1C
    .byte $2B
    .byte $2C
    .byte $FF

;Samus jump and point up.
ObjFrame36:
ObjFrame37:
ObjFrame_SamusJumpPntUp:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $FE
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Samus jump and point up.
ObjFrame_SamusJumpPntUpFire:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $07
    .byte $08
    .byte $32
    .byte $FF

;Bomb explode.
ObjFrame3A:
ObjFrame3B:
ObjFrame_BombExplode0:
    .byte ($0 << 4) + _id_ObjPlaceD, $0C, $0C
    .byte $74
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $74
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $74
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $74
    .byte $FF

;Samus run and point up.
ObjFrame3D:
ObjFrame3E:
ObjFrame3F:
ObjFrame_SamusRunPntUp0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus run and point up.
ObjFrame_SamusRunPntUp1:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus run and point up.
ObjFrame_SamusRunPntUp2:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $69
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Samus run and point up.
ObjFrame43:
ObjFrame44:
ObjFrame45:
ObjFrame_SamusRunPntUpFire0:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $20
    .byte $21
    .byte $FE
    .byte $FE
    .byte $31
    .byte $FF

;Samus point up, run and fire.
ObjFrame_SamusRunPntUpFire1:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $22
    .byte $23
    .byte $FE
    .byte $32
    .byte $33
    .byte $34
    .byte $FF

;Samus point up, run and fire.
ObjFrame_SamusRunPntUpFire2:
    .byte OAMDATA_HFLIP + ($0 << 4) + _id_ObjPlace6, $0F, $04
    .byte $FE
    .byte $69
    .byte $FD, OAMDATA_PRIORITY + $0
    .byte $7A
    .byte $79
    .byte $FE
    .byte $78
    .byte $77
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $25
    .byte $26
    .byte $27
    .byte $35
    .byte $36
    .byte $FF

;Bomb explode.
ObjFrame_BombExplode1:
    .byte ($0 << 4) + _id_ObjPlaceD, $0C, $0C
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

;Bomb explode.
ObjFrame_BombExplodeBlank:
    .byte ($0 << 4) + _id_ObjPlace0, $00, $00
    .byte $FF

;Wave beam.
ObjFrame_WaveBeam:
    .byte ($0 << 4) + _id_ObjPlace4, $04, $04
    .byte $4C
    .byte $FF

;Bomb explode.
ObjFrame4C:
ObjFrame_BombExplode2:
    .byte ($0 >> 4) + _id_ObjPlace8, $10, $10
    .byte $3D
    .byte $3E
    .byte $4E
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3E
    .byte $3D
    .byte $4E
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $4E
    .byte $3E
    .byte $3D
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $4E
    .byte $3D
    .byte $3E
    .byte $FF

;Bomb tick.
ObjFrame_Bomb0:
    .byte ($0 << 4) + _id_ObjPlace4, $04, $04
    .byte $70
    .byte $FF

;Bomb tick.
ObjFrame_Bomb1:
    .byte ($0 << 4) + _id_ObjPlace4, $04, $04
    .byte $71
    .byte $FF

;Bomb item.
ObjFrame_BombItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $86
    .byte $87
    .byte $96
    .byte $97
    .byte $FF

;High jump item.
ObjFrame_HighJumpItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $7B
    .byte $7C
    .byte $8B
    .byte $8C
    .byte $FF

;Long beam item.
ObjFrame_LongBeamItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $88
    .byte $67
    .byte $98
    .byte $99
    .byte $FF

;Screw attack item.
ObjFrame_ScrewAttackItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $80
    .byte $81
    .byte $90
    .byte $91
    .byte $FF

;Maru Mari item.
ObjFrame_MaruMariItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $7D
    .byte $7E
    .byte $8D
    .byte $8E
    .byte $FF

;Varia item.
ObjFrame_VariaSuitItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $82
    .byte $83
    .byte $92
    .byte $93
    .byte $FF

;Wave beam item.
ObjFrame_WaveBeamItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $88
    .byte $89
    .byte $98
    .byte $99
    .byte $FF

;Ice beam item.
ObjFrame_IceBeamItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $88
    .byte $68
    .byte $98
    .byte $99
    .byte $FF

;Energy tank item.
ObjFrame_EnergyTankItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $84
    .byte $85
    .byte $94
    .byte $95
    .byte $FF

;Missile item.
ObjFrame_MissileItem:
    .byte ($0 << 4) + _id_ObjPlaceD, $03, $03
    .byte $3F
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $3F
    .byte $FD, $0
    .byte $4F
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $4F
    .byte $FF

;Skree burrow.
ObjFrame_SkreeProjectile:
    .byte ($3 << 4) + _id_ObjPlace4, $04, $04
    .byte $F2
    .byte $FF

;Not used.
ObjFrame5B:
    .byte ($0 << 4) + _id_ObjPlace4, $00, $00
    .byte $5A
    .byte $FF
ObjFrame5C:
    .byte ($1 << 4) + _id_ObjPlace3, $00, $00
    .byte $B0
    .byte $B1
    .byte $B2
    .byte $B3
    .byte $FF
ObjFrame5D:
    .byte ($1 << 4) + _id_ObjPlace3, $00, $00
    .byte $B4
    .byte $B5
    .byte $B6
    .byte $B7
    .byte $B8
    .byte $B6
    .byte $B9
    .byte $B3
    .byte $FF
ObjFrame5E:
    .byte ($1 << 4) + _id_ObjPlace3, $00, $00
    .byte $B3
    .byte $BA
    .byte $BA
    .byte $FE
    .byte $80
    .byte $80
    .byte $FF

;Kraid statue.
ObjFrame5F:
ObjFrame60:
ObjFrame61:
ObjFrame62:
ObjFrame63:
ObjFrame64:
ObjFrame_KraidStatue:
    .byte ($1 << 4) + _id_ObjPlaceE, $00, $08
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
ObjFrame_RidleyStatue:
    .byte ($1 << 4) + _id_ObjPlaceE, $00, $08
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
ObjFrame_MissileExplode0:
    .byte ($0 << 4) + _id_ObjPlaceA, $04, $08
    .byte $FD, $0
    .byte $57
    .byte $FD
    .byte $40
    .byte $57
    .byte $FF

;Missile explode.
ObjFrame_MissileExplode1:
    .byte ($0 << 4) + _id_ObjPlaceB, $04, $0C
    .byte $FD, $0
    .byte $57
    .byte $18
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $18
    .byte $57
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $18
    .byte $18
    .byte $FF

;Missile explode.
ObjFrame69:
    .byte ($0 << 4) + _id_ObjPlaceC, $04, $10
    .byte $FD, $0
    .byte $57
    .byte $18
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $18
    .byte $57
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $18
    .byte $18
    .byte $FF
