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
;Disassembled, reconstructed and commented
;by SnowBro [Kent Hansen] <kentmhan@online.no>
;Continued by Dirty McDingus (nmikstas@yahoo.com)
;A work in progress.

;Metroid defines.

;-------------------------------------------[ Feature ]----------------------------------------------

.feature   force_range on        ;Allows negative numbers for signed values

;-------------------------------------------[ Charmap ]----------------------------------------------

.charmap '0', $00
.charmap '1', $01
.charmap '2', $02
.charmap '3', $03
.charmap '4', $04
.charmap '5', $05
.charmap '6', $06
.charmap '7', $07
.charmap '8', $08
.charmap '9', $09
.charmap 'A', $0A
.charmap 'B', $0B
.charmap 'C', $0C
.charmap 'D', $0D
.charmap 'E', $0E
.charmap 'F', $0F
.charmap 'G', $10
.charmap 'H', $11
.charmap 'I', $12
.charmap 'J', $13
.charmap 'K', $14
.charmap 'L', $15
.charmap 'M', $16
.charmap 'N', $17
.charmap 'O', $18
.charmap 'P', $19
.charmap 'Q', $1A
.charmap 'R', $1B
.charmap 'S', $1C
.charmap 'T', $1D
.charmap 'U', $1E
.charmap 'V', $1F
.charmap 'W', $20
.charmap 'X', $21
.charmap 'Y', $22
.charmap 'Z', $23
.charmap 'a', $24
.charmap 'b', $25
.charmap 'c', $26
.charmap 'd', $27
.charmap 'e', $28
.charmap 'f', $29
.charmap 'g', $2A
.charmap 'h', $2B
.charmap 'i', $2C
.charmap 'j', $2D
.charmap 'k', $2E
.charmap 'l', $2F
.charmap 'm', $30
.charmap 'n', $31
.charmap 'o', $32
.charmap 'p', $33
.charmap 'q', $34
.charmap 'r', $35
.charmap 's', $36
.charmap 't', $37
.charmap 'u', $38
.charmap 'v', $39
.charmap 'w', $3A
.charmap 'x', $3B
.charmap 'y', $3C
.charmap 'z', $3D
.charmap '?', $3E
.charmap '-', $3F

.charmap ',', $00
.charmap '.', $07
.charmap '!', $3F
.charmap '<', $8F ; i am using < instead of ©, because the latter doesn't work as a char constant
.charmap ' ', $FF


;-------------------------------------------[ Defines ]----------------------------------------------

CodePtr                = $0C     ;Points to address to jump to when choosing-->
;      CodePtr+1              = $0D     ;a routine from a list of routine addresses.

;The bits of the change and status addresses represent the following joypad buttons:
;bit 7=A, bit 6=B, bit 5=SELECT, bit 4=START, bit 3=Up, bit 2=Down, bit 1=Left, bit 0=Right.

Joy1Change             = $12     ;These addresses store any button changes-->
Joy2Change             = $13     ;that happened since last frame(pads 1 and 2).
Joy1Status             = $14     ;These two addresses store all buttons-->
Joy2Status             = $15     ;currently being pressed on the two controllers.
Joy1Retrig             = $16     ;These two addresses store any buttons that need-->
Joy2Retrig             = $17     ;to retrigger after being held down by player.
RetrigDelay1           = $18     ;These two addresses are counters that control-->
RetrigDelay2           = $19     ;The retriggering of held down buttons.

NMIStatus              = $1A     ;0=NMI in progress. anything else, NMI not in progress.
PPUDataPending         = $1B     ;1=not PPU data pending, 1=data pending.
PalDataPending         = $1C     ;Pending palette data. Palette # = PalDataPending - 1.
GameMode               = $1D     ;0 = Game is playing, 1 = At title/password screen
MainRoutine            = $1E     ;5 = Game paused, 3 = Game engine running
TitleRoutine           = $1F     ;Stores title routine number currently running.
NextRoutine            = $20     ;Stores next routine to jump to after WaitTimer expires.
CurrentBank            = $23     ;0 thru 7. current memory page in lower memory block.
SwitchPending          = $24     ;Switch memory page. Page # = SwitchPending - 1.
MMCReg0Cntrl           = $25     ;Stores bits to be loaded into MMC1 Register 0.
SwitchUpperBits        = $28     ;Used to store bits 3 and 4 for MMC1 register 3.  Bits-->
                                        ;3 and 4 should always be 0 under normal conditions.

TimerDelay             = $29     ;Count down from 9 to 0. Decremented every frame.
Timer1                 = $2A     ;Decremented every frame after set.
Timer2                 = $2B     ;Decremented every frame after set.
Timer3                 = $2C     ;Decremented every 10 frames after set.

FrameCount             = $2D     ;Increments every frame(overflows every 256 frames).

RandomNumber1          = $2E     ;Random numbers used-->         
RandomNumber2          = $2F     ;throughout the game.

SpareMem30             = $30     ;Written to, but never accessed.
GamePaused             = $31     ;#$00=Game running, #$01=Game paused.

RoomPtr                = $33     ;Low byte of room pointer address.
;      RoomPtr+1              = $34     ;High byte of room pointer address.

StructPtr              = $35     ;Low bute of structure pointer address.
;      StructPtr+1            = $36     ;High byte of structure pointer address.
                                
CartRAMWorkPtr         = $37     ;Low byte of pointer to current position in room RAM.
;      CartRAMWorkPtr+1       = $38     ;High byte of pointer to current position in room RAM.
                                        ;The CartRAMWorkPtr points to the current memory address-->
                                        ;in the room RAM that is being loaded.

CartRAMPtr             = $39     ;Low byte of pointer to room RAM (#$00).
;      CartRAMPtr+1           = $3A     ;High byte of pointer to room RAM (#$60 or #$64).
                                        ;Room RAM is a screen buffer where the objects that make-->
                                        ;up a room are loaded.  There are two room RAM memory-->
                                        ;areas and they are the exact same size as the two name-->
                                        ;tables and attribute tables in the PPU. Once the room-->
                                        ;RAM conatins a completed room in it, the entire contents-->
                                        ;of the room RAM is loaded into the PPU. 

RoomPtrTable           = $3B     ;Low byte of start of room pointer table.
;      RoomPtrTable+1         = $3C     ;High byte of start of room pointer table.

StructPtrTable         = $3D     ;Low byte of start of structure pointer table.
;      StructPtrTable+1       = $3E     ;High byte of structure pointer table.

MacroPtr               = $3F     ;Low byte of pointer into macro definitions.
;      MacroPtr+1             = $40     ;High byte of pointer into macro definitions.

EnmyFrameTbl1Ptr       = $41     ;Low byte of pointer into address table to find enemy animations.
;      EnmyFrameTbl1Ptr+1     = $42     ;High byte of pointer into address table to find enemy animations.

EnmyFrameTbl2Ptr       = $43     ;Same as above except in a second table because there are-->
;      EnmyFrameTbl2Ptr+1     = $44     ;too many entries to fit into one table.

EnmyPlaceTblPtr        = $45     ;Low byte of pointer into enemy frame placement table.
;      EnmyPlaceTblPtr+1      = $46     ;High byte of pointer into enemy frame placement table.

EnemyAnimPtr           = $47     ;Low byte of start of EnemyAnimIndexTbl.
;      EnemyAnimPtr+1         = $48     ;High byte of start of EnemyAnimIndexTbl.

ScrollDir              = $49     ;0=Up, 1=Down, 2=Left, 3=Right.

TempScrollDir          = $4A     ;Stores ScrollDir when room is initially loaded.

PageIndex              = $4B     ;Index to object data.
                                        ;#$D0, #$E0, #$F0 = projectile indices(including bombs).
                                        ;
ItemIndex              = $4C     ;#$00 or #$08. Added to PowerUpType addresses to determine if-->
                                        ;the first or second item slot is being checked. 

SamusDir               = $4D     ;0 = Right, 1 = Left.
SamusDoorDir           = $4E     ;Direction Samus passed through door.
MapPosY                = $4F     ;Current y position on world map.
MapPosX                = $50     ;Current x position on world map.
SamusScrX              = $51     ;Samus x position on screen.
SamusScrY              = $52     ;Samus y position on screen.
WalkSoundDelay         = $53
IsSamus                = $55     ;1=Samus object being accessed, 0=not Samus.
DoorStatus             = $56     ;0=Not in door, 1=In right door, 2=In left door, 3=Scroll up-->
                                        ;4=Scroll down, 5=Exit door, MSB set=Door entered. If value-->
                                        ;is 3 or 4, a door was entered while in a verticle shaft and-->
                                        ;the door was not centered on the screen and up or down-->
                                        ;scrolling needs to occur before scrolling to the next room.
DoorScrollStatus       = $57     ;#$01=Entered right hand door from horizontal area.-->
                                        ;#$02=Entered left hand door from horizontal area.-->
                                        ;#$03=Entered door from verticle shaft and room needs to-->
                                        ;be centered before horizontal scrolling. #$04=Entered-->
                                        ;door from verticle shaft and room was already centered.
SamusDoorData          = $58     ;The upper 4 bits store either 1 or 2. If 1 is stored(bit 4-->
                                        ;set), the scrolling after Samus exits the door is toggled.-->
                                        ;If 2 is stored(bit 5 set), the scrolling is set to-->
                                        ;horizontal scrolling after Samus exits the door. This-->
                                        ;happens mostly in item rooms. The lower 4 bits store Samus'-->
                                        ;action status as she enters the door. This is used to set-->
                                        ;Samus' action after she exits and keeps her looking the same.
DoorDelay              = $59     ;Number of frames to delay when Samus entering/exiting doors.
RoomNumber             = $5A     ;Room number currently being loaded.
SpritePagePos          = $5B     ;Index into sprite RAM used to load object sprite data.
SamusInLava            = $64     ;#$01=Samus in lava, #$00=She is not.
ObjectCounter          = $65     ;Counts such things as object explosion time.
ObjectPal              = $67     ;Attrib. table info for room object(#$00 thru #$03).
RoomPal                = $68
TempX                  = $69
TempY                  = $6A
ObjectCntrl            = $6B     ;Controls object properties such as mirroring and color-->
                                        ;bits. Bit 4 controls object mirroring.

DoorOnNameTable3       = $6C     ;The following two addresses are used to keep track of the-->
DoorOnNameTable0       = $6D     ;doors loaded on the name tables. The information is used-->
                                        ;in the GetRoomNum routine to prevent the loading of a-->
                                        ;room behind a door when scrolling horizontally. This has-->
                                        ;the effect of stopping scrolling until Samus walks through-->
                                        ;the door. #$01=Left door on name table. #$02=right door-->
                                        ;on name table. #$03 two doors on the same name table.-->
                                        ;#$00 is possible in $6D if 2 doors are on name table 0-->
                                        ;while vertically scrolling.

HealthLoChange         = $6E     ;Amount to add/subtract from HealthLo.
HealthHiChange         = $6F     ;Amount to add/subtract from HealthHi.

SamusBlink             = $70
UpdatingProjectile     = $71     ;#$01=Projectile update in process. #$00=not in process.
DamagePushDirection    = $72     ;#$00=Push Samus left when hit, #$01=Push right, #$FF=No push. 
InArea                 = $74     ;#$10(or #$00)=Brinstar, #$11=Norfair, #$12=Kraid hideout,-->
                                        ;#$13=Tourian, #$14=Ridley hideout.

SpareMem75             = $75     ;Initialized to #$FF in AreaInit. Not used.
PalToggle              = $76

ItemRoomMusicStatus    = $79     ;#$00=Item room music not playing. 
                                        ;#$01=Play item room music.
                                        ;#$80=Stop item room music once door scroll complete. 
                                        ;#$81=Item room music already playing. Don't restart.

OnFrozenEnemy          = $7D     ;#$01=Samus standing on frozen enemy, #$00=she is not.

;--------------------------------------[ End routine specific ]--------------------------------------

EndMsgWrite            = $7A     ;0=don't write end message, 1=write end message.
IsCredits              = $7B     ;0=credits not rolling, 1=credits rolling.
SpriteByteCounter      = $7C     ;Used to indicate when Samus sprite load complete.
SpritePointerIndex     = $7D     ;Index to proper Samus sprite graphics at end game.
SpriteAttribByte       = $7E     ;#$00.  Attribute byte of some sprites.
ColorCntIndex          = $7F     ;Index for finding count number for ClrChangeCounter.
CreditPageNumber       = $80     ;Stores current page of credits(#$00 thru #$06).
HideShowEndMsg         = $81     ;0=show end message, 1=erase end message.
ClrChangeCounter       = $82     ;When=#$00, change end Samus sprite colors.
WaveSpritePointer      = $83     ;Address pointer to Samus hand waving sprites in end.
WaveSpriteCounter      = $84     ;Stores length of wave sprite data (#$10).

;----------------------------------------------------------------------------------------------------

MetroidOnSamus         = $92     ;#$01=Metroid on Samus, #$00=Metroid not on Samus.

MaxMissilePickup       = $93     ;Maximum missiles power-ups that can be picked up. Randomly-->
                                        ;recalculated whenever Samus goes through a door.
MaxEnergyPickup        = $94     ;Maximum energy power-ups that can be picked up. Randomly-->
                                        ;recalculated whenever Samus goes through a door.
CurrentMissilePickups  = $95     ;Number of missile power-ups currently collected by Samus-->
                                        ;Reset to 0 when Samus goes through a door.
CurrentEnergyPickups   = $96     ;Number of energy power-ups currently collected by Samus-->
                                        ;Reset to 0 when Samus goes through a door.

MotherBrainStatus      = $98     ;#$00=Mother brain not in room, #$01=Mother brain in room,-->
                                        ;#$02=Mother brain hit, #$03=Mother brain dying-->
                                        ;#$04=Mother brain dissapearing, #$05=Mother brain gone,-->
                                        ;#$06=Time bomb set, #$07=Time bomb exploded,-->
                                        ;#$08=Initialize mother brain,-->
                                        ;#$09, #$0A=Mother brain already dead.
MotherBrainHits        = $99     ;Number of times mother brain has been hit. Dies at #$20.

SpareMemB7             = $B7     ;Written to in title routine and accessed by unsed routine.
SpareMemB8             = $B8     ;Written to in title routine and accessed by unsed routine.
SpareMemBB             = $BB     ;Written to in title routine, but never accessed.

First4SlowCntr         = $BC     ;This address holds an 8 frame delay. when the delay is up,-->
                                        ;The crosshair sprites double their speed.
Second4Delay           = $BD     ;This address holds a 32 frame delay.  When the delay is-->
                                        ;up, the second set of crosshair sprites start their movement.
SecondCrosshairSprites = $BF     ;#$01=Second crosshair sprites active in intro.

FlashScreen            = $C0     ;#$01=Flash screen during crosshairs routine.
PalDataIndex           = $C1
ScreenFlashPalIndex    = $C2     ;Index to palette data to flash screen during intro.
IntroStarOffset        = $C3     ;Contains offset into IntroStarPntr table for twinkle effect.
FadeDataIndex          = $C4     ;Index to palette data to fade items in and out during intro.

SpareMemC5             = $C5     ;Written to in title routine, but never accessed.
CrossDataIndex         = $C6     ;#$00 thru #$04. Index to find cross sprite data.
DrawCross              = $C7     ;#$01=Draw cross on screen during crosshairs routine.
SpriteLoadPending      = $C8     ;Set to #$00 after sprite RAM load complete.
SpareMemC9             = $C9     ;Written to in title routine, but never accessed.
SpareMemCB             = $CB     ;Written to in title routine, but never accessed.
SpareMemCC             = $CC     ;Written to in title routine, but never accessed.
SpareMemCD             = $CD     ;Written to in title routine, but never accessed.
SpareMemCE             = $CE     ;Written to in title routine, but never accessed.
SpareMemCF             = $CF     ;Written to in title routine, but never accessed.
SpareMemD0             = $D0     ;Written to in title routine, but never accessed.
SpareMemD1             = $D1     ;Written to in title routine, but never accessed.
SpareMemD2             = $D2     ;Written to in title routine, but never accessed.
SpareMemD3             = $D3     ;Written to in title routine, but never accessed.
SpareMemD7             = $D7     ;Written to in title routine, but never accessed.
IntroMusicRestart      = $D8     ;After all title routines run twice, restarts intro music.

ABStatus               = $F0     ;Stores A and B button status in AreaInit. Never used.
;                             = $F7

MirrorCntrl            = $FA     ;If bit 3 is set, PPU set to horizontal mirroring-->
                                        ;else if bit 3 is clear, PPU is set to vertical-->
                                        ;mirroring. No other bits seem to matter.

ScrollY                = $FC     ;Y value loaded into scroll register. 
ScrollX                = $FD     ;X value loaded into scroll register.
PPUMASK_ZP              = $FE     ;Data byte to be loaded into PPU control register 1.
PPUCTRL_ZP              = $FF     ;Data byte to be loaded into PPU control register 0.

HealthLo               = $0106   ;Lower health digit in upper 4 bits.
HealthHi               = $0107   ;Upper health digit in lower 4 bits-->
                                        ;# of full tanks in upper 4 bits.
MiniBossKillDelay      = $0108   ;Initiate power up music and delay after Kraid/Ridley killed.
PowerUpDelay           = $0109   ;Initiate power up music and delay after item pickup.

EndTimerLo             = $010A   ;Lower byte of end game escape timer.
EndTimerHi             = $010B   ;Upper byte of end game escape timer.

MissileToggle          = $010E   ;0=fire bullets, 1=fire missiles.

;-----------------------------------------[ Sprite RAM ]---------------------------------------------

Sprite00RAM            = $0200   ;$0200 thru $02FF
Sprite01RAM            = $0204   ;
Sprite02RAM            = $0208   ;
Sprite03RAM            = $020C   ;
Sprite04RAM            = $0210   ;
Sprite05RAM            = $0214   ;
Sprite06RAM            = $0218   ;
Sprite07RAM            = $021C   ;
Sprite08RAM            = $0220   ;
Sprite09RAM            = $0224   ;
Sprite0ARAM            = $0228   ;
Sprite0BRAM            = $022C   ;
Sprite0CRAM            = $0230   ;
Sprite0DRAM            = $0234   ;
Sprite0ERAM            = $0238   ;
Sprite0FRAM            = $023C   ;
Sprite10RAM            = $0240   ;
Sprite11RAM            = $0244   ;
Sprite12RAM            = $0248   ;
Sprite13RAM            = $024C   ;
Sprite14RAM            = $0250   ;
Sprite15RAM            = $0254   ;
Sprite16RAM            = $0258   ;
Sprite17RAM            = $025C   ;
Sprite18RAM            = $0260   ;
Sprite19RAM            = $0264   ;
Sprite1ARAM            = $0268   ;These 256 bytes of memory are loaded into sprite
Sprite1BRAM            = $026C   ;RAM using the DMA sprite register $4014.
Sprite1CRAM            = $0270   ;
Sprite1DRAM            = $0274   ;
Sprite1ERAM            = $0278   ;
Sprite1FRAM            = $027C   ;
Sprite20RAM            = $0280   ;
Sprite21RAM            = $0284   ;
Sprite22RAM            = $0288   ;
Sprite23RAM            = $028C   ;
Sprite24RAM            = $0290   ;
Sprite25RAM            = $0294   ;
Sprite26RAM            = $0298   ;
Sprite27RAM            = $029C   ;
Sprite28RAM            = $02A0   ;
Sprite29RAM            = $02A4   ;
Sprite2ARAM            = $02A8   ;
Sprite2BRAM            = $02AC   ;
Sprite2CRAM            = $02B0   ;
Sprite2DRAM            = $02B4   ;
Sprite2ERAM            = $02B8   ;
Sprite2FRAM            = $02BC   ;
Sprite30RAM            = $02C0   ;
Sprite31RAM            = $02C4   ;
Sprite32RAM            = $02C8   ;
Sprite33RAM            = $02CC   ;
Sprite34RAM            = $02D0   ;
Sprite35RAM            = $02D4   ;
Sprite36RAM            = $02D8   ;
Sprite37RAM            = $02DC   ;
Sprite38RAM            = $02E0   ;
Sprite39RAM            = $02E4   ;
Sprite3ARAM            = $02E8   ;
Sprite3BRAM            = $02EC   ;
Sprite3CRAM            = $02F0   ;
Sprite3DRAM            = $02F4   ;
Sprite3ERAM            = $02F8   ;
Sprite3FRAM            = $02FC   ;

;-----------------------------------------[ Object RAM ]---------------------------------------------

;Samus RAM.
ObjAction              = $0300   ;Status of object. 0=object slot not in use.
ObjRadY                = $0301   ;Distance in pixels from object center to top or bottom.
ObjRadX                = $0302   ;Distance in pixels from object center to left or right side.
AnimFrame              = $0303   ;*2 = Index into FramePtrTable for current animation.
AnimDelay              = $0304   ;Number of frames to delay between animation frames.
AnimResetIndex         = $0305   ;Restart index-1 when AnimIndex finished with last frame. 
AnimIndex              = $0306   ;Current index into ObjectAnimIndexTbl.
SamusOnElevator        = $0307   ;0=Samus not on elevator, 1=Samus on elevator.
ObjVertSpeed           = $0308   ;MSB set=moving up(#$FA max), MSB clear=moving down(#$05 max).
ObjHorzSpeed           = $0309   ;MSB set=moving lft(#$FE max), MSB clear=moving rt(#$01 max).
SamusHit               = $030A   ;Samus hit by enemy.
ObjectOnScreen         = $030B   ;1=Object on screen, 0=Object beyond screen boundaries.
ObjectHi               = $030C   ;0=Object on nametable 0, 1=Object on nametable 3.
ObjectY                = $030D   ;Object y position in room(not actual screen position).
ObjectX                = $030E   ;Object x position in room(not actual screen position).
SamusJumpDsplcmnt      = $030F   ;Number of pixels vertically displaced from jump point.
VertCntrNonLinear      = $0310   ;Verticle movement counter. Exponential change in speed.
HorzCntrNonLinear      = $0311   ;Horizontal movement counter. Exponential change in speed.
VertCntrLinear         = $0312   ;Verticle movement counter. Linear change in speed.
HorzCntrLinear         = $0313   ;Horizontal movement counter. Linear change in speed.
SamusGravity           = $0314   ;Value used in calculating vertical acceleration on Samus.
SamusHorzAccel         = $0315   ;Value used in calculating horizontal acceleration on Samus.
SamusHorzSpeedMax      = $0316   ;Used to calc maximum horizontal speed Samus can reach.

;Elevator RAM.
ElevatorStatus         = $0320   ;#$01=Elevator present, #$00=Elevator not present.

;Power-up item RAM.
PowerUpAnimFrame       = $0343   ;*2 = Index into FramePtrTable for current animation.
PowerUpHi              = $034C   ;Name table power up item is located on.
PowerUpY               = $034D   ;Room Y coord of power up item.
PowerUpX               = $034E   ;Room x coord of power up item.

;-------------------------------------[ Title routine specific ]-------------------------------------

PasswordCursor         = $0320   ;Password write position (#$00 - #$17).
InputRow               = $0321   ;Password character select row (#$00 - #$04).
InputColumn            = $0322   ;Password character select column (#$00 - #$0C).
PasswordStat00         = $0324   ;Does not appear to have a function.
StartContinue          = $0325   ;0=START selected, 1=CONTINUE selected.

;------------------------------------------[ Enemy RAM ]---------------------------------------------

EnYRoomPos             = $0400   ;Enemy y position in room.(not actual screen position).
EnXRoomPos             = $0401   ;Enemy x position in room.(not actual screen position).
EnData02               = $0402   ; unknown - y speed? 
EnData03               = $0403   ; unknown - x speed?
EnData04               = $0404   ; unknown - hurt flag?
EnData05               = $0405   ; L/R facing in LSB ?
EnCounter              = $0406   ;Counts such things as explosion time. - y counter?
EnData07               = $0407   ; unknown - x counter
EnData08               = $0408   ; unknown
EnDelay                = $0409   ;Delay counter between enemy actions.
EnData0A               = $040A   ; unknown -- For crawlers, orientation
                                 ; 00-on floor, 01-on wall going down, 02-on ceiling, 03-on wall going up 
EnHitPoints            = $040B   ;Current hit points of enemy.
EnData0C               = $040C   ; unknown
EnData0D               = $040D   ; unknown - Ice Timer? stun timer?
EnData0E               = $040E   ; unknown
EnSpecialAttribs       = $040F   ;Bit 7 set=tough version of enemy, bit 6 set=mini boss.

;----------------------------------------------------------------------------------------------------

;Tile respawning
TileRoutine            = $0500
TileAnimFrame          = $0503
TileAnimDelay          = $0504
TileAnimIndex          = $0506
TileDelay              = $0507
TileWRAMLo             = $0508
TileWRAMHi             = $0509
TileType               = $050A

;---------------------------------[ Sound engine memory addresses ]----------------------------------

Cntrl0Data             = $EA     ;Temp storage for data of first address sound channel
VolumeCntrlAddress     = $EB     ;Desired address number in VolumeCntrlAdressTbl

MusicSQ1PeriodLow      = $0600   ;Loaded into SQ1Cntrl2 when playing music
MusicSQ1PeriodHigh     = $0601   ;Loaded into SQ1Cntrl3 when playing music

SFXPaused              = $0602   ;0=Game not paused, 1=Game paused
PauseSFXStatus         = $0603   ;Plays PauseMusic SFX if less than #$12

MusicSQ2PeriodLow      = $0604   ;Loaded into SQ2Cntrl2 when playing music
MusicSQ2PeriodHigh     = $0605   ;Loaded into SQ2Cntrl3 when playing music

WriteMultiChannelData  = $0607   ;1=data needs to be written, 0=no data to write

MusicTriPeriodLow      = $0608   ;Loaded into TriangleCntrl2 when playing music
MisicTriPeriodHigh     = $0609   ;Loaded into TriangleCntrl3 when playing music 

TrianglePeriodLow      = $0610   ;Stores triangle SFX period low for processing
TrianglePeriodHigh     = $0611   ;Stroes triangle SFX period high for processing
TriangleChangeLow      = $0612   ;Stores triangle SFX change in period low
TriangleChangeHigh     = $0613   ;Stores triangle SFX change in period high

TriangleLowPercentage  = $0614   ;Stores percent to change period low by each frame
TriangleHighPercentage = $0615   ;Stores percent to change period high by each frame 
PercentDifference      = $0616   ;if=5, percent=1/5(20%), if=0A, percent=1/10(10%), etc
DivideData             = $0617   ;Used in DivideTrianglePeriods

HasBeamSFX             = $061F   ;Bit 7 set=has long beam, bit 0 set=has ice beam

;The following addresses are loaded into $0640 thru $0643 when those 
;addresses decrement to zero.  These addresses do not decrement.

SQ1FrameCountInit      = $0620   ;Holds number of frames to play sq1 channel data
SQ2FrameCountInit      = $0621   ;Holds number of frames to play sq2 channel data
TriangleFrameCountInit = $0622   ;Holds number of frames to play triangle channel data
NoiseFrameCountInit    = $0623   ;Holds number of frames to play noise channel data

SQ1RepeatCounter       = $0624   ;Number of times to repeat SQ1 music loop
SQ2RepeatCounter       = $0625   ;Number of times to repeat SQ2 music loop
TriangleRepeatCounter  = $0626   ;Number of times to repeat Triangle music loop
NoiseRepeatCounter     = $0627   ;Number of times to repeat Noise music loop

SQ1DutyEnvelope        = $0628   ;Loaded into SQ1Cntrl0 when playing music
SQ2DutyEnvelope        = $0629   ;Loaded into SQ2Cntrl0 when playing music
TriLinearCount         = $062A   ;disable\enable counter, linear count length

NoteLengthTblOffset    = $062B   ;Stores the offset to find proper note length table
MusicRepeat            = $062C   ;0=Music does not repeat, Nonzero=music repeats
TriangleCounterCntrl   = $062D   ;$F0=disable length cntr, $00=long note, $0F=short note
SQ1VolumeCntrl         = $062E   ;Entry number in VolumeCntrlAdressTbl for SQ1
SQ2VolumeCntrl         = $062F   ;Entry number in VolumeCntrlAdressTbl for SQ2
SQ1LowBaseByte         = $0630   ;low byte of base address for SQ1 music data
SQ1HighBaseByte        = $0631   ;High byte of base address for SQ1 music data
SQ2LowBaseByte         = $0632   ;low byte of base address for SQ2 music data
SQ2HighBaseByte        = $0633   ;High byte of base address for SQ2 music data
TriangleLowBaseByte    = $0634   ;low byte of base address for Triangle music data
TriangleHighBaseByte   = $0635   ;High byte of base address for Triangle music data
NoiseLowBaseByte       = $0636   ;low byte of base address for Noise music data
NoiseHighBaseByte      = $0637   ;High byte of base address for Noise music data

SQ1MusicIndexIndex     = $0638   ;Index to find sQ1 sound data index. Base=$630,$631
SQ2MusicIndexIndex     = $0639   ;Index to find SQ2 sound data index. Base=$632,$633
TriangleMusicIndexIndex = $063A   ;Index to find Tri sound data index. Base=$634,$635
NoiseMusicIndexIndex   = $063B   ;Index to find Noise sound data index. Base=$636,$637

SQ1LoopIndex           = $063C   ;SQ1 Loop start index
SQ2LoopIndex           = $063D   ;SQ2 loop start index
TriangleLoopIndex      = $063E   ;Triangle loop start index
NoiseLoopIndex         = $063F   ;Noise loop start index

SQ1MusicFrameCount     = $0640   ;Decrements every sq1 frame. When 0, load new data
SQ2MusicFrameCount     = $0641   ;Decrements every sq2 frame. when 0, load new data
TriangleMusicFrameCount= $0642   ;Decrements every triangle frame. When 0, load new data
NoiseMusicFrameCount   = $0643   ;Decrements every noise frame. When 0, load new data

MusicSQ1Sweep          = $0648   ;Value is loaded into SQ1Cntrl1 when playing music
MusicSQ2Sweep          = $0649   ;Value is loaded into SQ2Cntrl1 when playing music
TriangleSweep          = $064A   ;Loaded into TriangleCntrl1(not used)

ThisSoundChannel       = $064B   ;Least sig. byte of current channel(00,04,08 or 0C)

CurrentSFXFlags        = $064D   ;Stores flags of SFX currently being processed.

NoiseInUse             = $0652   ;Noise in use? (Not used)
SQ1InUse               = $0653   ;1=SQ1 channel being used by SFX, 0=not in use
SQ2InUse               = $0654   ;2=SQ2 channel being used by SFX, 0=not in use
TriangleInUse          = $0655   ;3=Triangle channel being used by SFX, 0=not in use

ChannelType            = $065C   ;Stores channel type being processed(0,1,2,3 or 4)
CurrentMusicRepeat     = $065D   ;Stores flags of music to repeat
MusicInitIndex         = $065E   ;index for loading $62B thru $637(base=$BD31).

NoiseSFXLength         = $0660   ;Stores number of frames to play Noise SFX
SQ1SFXLength           = $0661   ;Stores number of frames to play SQ1 SFX
SQ2SFXLngth            = $0662   ;Stores number of frames to play SQ2 SFX
TriangleSFXLength      = $0663   ;Stores number of frames to play Triangle SFX
MultiSFXLength         = $0664   ;Stores number of frames to play Multi SFX

ThisNoiseFrame         = $0665   ;Stores current frame number for noise SFX
ThisSQ1Frame           = $0666   ;Stores current frame number for sq1 SFX
ThisSQ2Frame           = $0667   ;Stores current frame number for SQ2 SFX
ThisTriangleFrame      = $0668   ;Stores current frame number for triangle SFX
ThisMultiFrame         = $0669   ;Stores current frame number for Multi SFX

SQ1VolumeIndex         = $066A   ;Stores index to SQ1 volume data in a volume data tbl
SQ2VolumeIndex         = $066B   ;Stores index to SQ2 volume data in a volume data tbl

SQ1VolumeData          = $066C   ;stores duty cycle and this frame volume data of SQ1
SQ2VolumeData          = $066D   ;Stores duty cycle and this frame volume data of SQ2

NoiseSFXData           = $0670   ;Stores additional info for Noise SFX
SQ1SFXData             = $0671   ;Stores additional info for SQ1 SFX
SQ2SFXData             = $0672   ;Stores additional info for SQ2 SFX
TriangleSFXData        = $0673   ;Stores additional info for triangle SFX
MultiSFXData           = $0674   ;Stores additional info for Multi SFX
SQ1SQ2SFXData          = $0675   ;Stores additional info for SQ1 and SQ2 SFX

ScrewAttackSFXData     = $0678   ;Contains extra data for screw attack SFX
SQ1SFXPeriodLow        = $0679   ;Period low data for processing multi SFX routines

NoiseSFXFlag           = $0680   ;Initialization flags for noise SFX
SQ1SFXFlag             = $0681   ;Initialization flags for SQ1 SFX
SQ2SFXFlag             = $0682   ;Initialization flags for SQ2 SFX(never used)
TriangleSFXFlag        = $0683   ;Initialization flags for triangle SFX
MultiSFXFlag           = $0684   ;Initialization Flags for SFX and some music

MusicInitFlag          = $0685   ;Music init flags

NoiseContSFX           = $0688   ;Continuation flags for noise SFX
SQ1ContSFX             = $0689   ;Continuation flags for SQ1 SFX
SQ2ContSFX             = $068A   ;Continuation flags for SQ2 SFX (never used)
TriangleContSFX        = $068B   ;Continuation flags for Triangle SFX
MultiContSFX           = $068C   ;Continuation flags for Multi SFX

CurrentMusic           = $068D   ;Stores the flag of the current music being played 

;----------------------------------------------------------------------------------------------------

PowerUpType            = $0748   ;Holds the byte describing what power-up is on name table.
PowerUpYCoord          = $0749   ;Y coordinate of the power-up.
PowerUpXCoord          = $074A   ;X coordiante of the power-up
PowerUpNameTable       = $074B   ;#$00 if on name table 0, #$01 if on name table 3.
PowerUpAnimIndex       = $074F   ;Entry into FramePtrTable for item animation.

PowerUpBType           = $0750   ;Holds the description byte of a second power-up(if any).
PowerUpBYCoord         = $0751   ;Y coordinate of second power-up.
PowerUpBXCoord         = $0752   ;X coordiante of second power-up.
PowerUpBNameTable      = $0753   ;#$00 if on name table 0, #$01 if on name table 3.
PowerUpBAnimIndex      = $0757   ;Entry into FramePtrTable for item animation.

TileSize               = $0780   ;4 MSBs=Y size of tile to erase.4 LSBs=X size of tile to erase.
TileInfo0              = $0781   ;
TileInfo1              = $0782   ;
TileInfo2              = $0783   ;Tile patterns to replace blasted tiles.
TileInfo3              = $0784   ;
TileInfo4              = $0785   ;
TileInfo5              = $0786   ;

PPUStrIndex            = $07A0   ;# of bytes of data in PPUDataString. #$4F bytes max.

;$07A1 thru $07F0 contain a byte string of data to be written the the PPU. The first
;byte in the string is the upper address byte of the starting point in the PPU to write
;the data.  The second bye is the lower address byte. The third byte is a configuration
;byte. if the MSB of this byte is set, the PPU is incremented by 32 after each byte write
;(vertical write).  It the MSB is cleared, the PPU is incremented by 1 after each write
;(horizontal write). If bit 6 is set, the next data byte is repeated multiple times during
;successive PPU writes.  The number of times the next byte is repeated is based on bits
;0-5 of the configuration byte.  Those bytes are a repitition counter. Any following bytes
;are the actual data bytes to be written to the PPU. #$00 separates the data chunks.

PPUDataString          = $07A1   ;Thru $07F0. String of data bytes to be written to PPU.



;----------------------------------------------------------------------------------------------------

RoomRAMA               = $6000   ;Thru $63FF. Used to load room before it is put into the PPU.
RoomRAMB               = $6400   ;Thru $67FF. Used to load room before it is put into the PPU.

EndingType             = $6872   ;1=worst ending, 5=best ending

SamusDataIndex         = $6875   ;Index for Samus saved game stats(not used). #$00, #$10, #$20.

SamusStat00            = $6876   ;Unused memory address for storing Samus info.
TankCount              = $6877   ;Number of energy tanks.
SamusGear              = $6878   ;Stores power-up items Samus has.
MissileCount           = $6879   ;Stores current number of missiles.
MaxMissiles            = $687A   ;Maximum amount of missiles Samus can carry
KraidStatueStatus      = $687B   ;bit 0 set, the statues blink, -->
RidleyStatueStatus     = $687C   ;bit 7 set, statues are up.
SamusAge               = $687D   ;Low byte of Samus' age.
;      SamusAge+1             = $687E   ;Mid byte of Samus' age.
;      SamusAge+2             = $687F   ;High byte of Samus' age.
SamusStat01            = $6880   ;Unused memory address for storing Samus info.
SamusStat02            = $6881   ;SamusStat02 and 03 keep track of how many times Samus has-->
SamusStat03            = $6882   ;died, but this info is never accessed anywhere in the game.

AtEnding               = $6883   ;1=End scenes playing, 0=Not at ending.

EraseGame              = $6884   ;MSB set=erase selected saved game(not used in password carts).

DataSlot               = $6885   ;#$00 thru #$02. Stored Samus data to load. Apparently a save-->
                                        ;game system was going to be used instead of a password routine.-->
                                        ;The code that uses this memory address is never accessed in-->
                                        ;the actual game. It looks like three player slots were going-->
                                        ;to be used to store game data(like Zelda).  

NumberOfUniqueItems    = $6886   ;Counts number of power-ups and red doors-->
                                        ;opened.  Does not count different beams-->
                                        ;picked up (ice, long, wave). increments by 2.

UniqueItemHistory      = $6887   ;Thru $68FC. History of Unique items collected.-->
EndItemHistory         = $68FC   ;Two bytes per item.

KraidRidleyPresent     = $6987   ;#$01=Kraid/Ridley present, #$00=Kraid/Ridley not present.

PasswordBytes          = $6988
PasswordByte00         = $6988   ;Stores status of items 0 thru 7.
PasswordByte01         = $6989   ;Stores status of items 8 thru 15.
PasswordByte02         = $698A   ;Stores status of items 16 thru 23.
PasswordByte03         = $698B   ;Stores status of items 24 thru 31.
PasswordByte04         = $698C   ;Stores status of items 32 thru 39.
PasswordByte05         = $698D   ;Stores status of items 40 thru 47.
PasswordByte06         = $698E   ;Stores status of items 48 thru 55.
PasswordByte07         = $698F   ;Stores status of items 56 thru 58(bits 0 thru 2).
PasswordByte08         = $6990   ;start location(bits 0 thru 5), Samus suit status (bit 7).
PasswordByte09         = $6991   ;Stores SamusGear.
PasswordByte0A         = $6992   ;Stores MissileCount.
PasswordByte0B         = $6993   ;Stores SamusAge.
PasswordByte0C         = $6994   ;Stores SamusAge+1.
PasswordByte0D         = $6995   ;Stores SamusAge+2.
PasswordByte0E         = $6996   ;Stores no data.
PasswordByte0F         = $6997   ;Stores Statue statuses(bits 4 thu 7).
PasswordByte10         = $6998   ;Stores value RandomNumber1.
PasswordByte11         = $6999   ;Stores sum of $6988 thru $6998(Checksum).

;Upper two bits of PasswordChar bytes will always be 00.
PasswordChars          = $699A
PasswordChar00         = $699A   ;
PasswordChar01         = $699B   ;
PasswordChar02         = $699C   ;
PasswordChar03         = $699D   ;
PasswordChar04         = $699E   ;
PasswordChar05         = $699F   ;
PasswordChar06         = $69A0   ;
PasswordChar07         = $69A1   ;
PasswordChar08         = $69A2   ;
PasswordChar09         = $69A3   ;
PasswordChar0A         = $69A4   ;These 18 memory addresses store the 18 characters-->
PasswordChar0B         = $69A5   ;of the password to be displayed on the screen.
PasswordChar0C         = $69A6   ;
PasswordChar0D         = $69A7   ;
PasswordChar0E         = $69A8   ;
PasswordChar0F         = $69A9   ;
PasswordChar10         = $69AA   ;
PasswordChar11         = $69AB   ;
PasswordChar12         = $69AC   ;
PasswordChar13         = $69AD   ;
PasswordChar14         = $69AE   ;
PasswordChar15         = $69AF   ;
PasswordChar16         = $69B0   ;
PasswordChar17         = $69B1   ;

NARPASSWORD            = $69B2   ;0 = invinsible Samus not active, 1 = invinsible Samus active.
JustInBailey           = $69B3   ;0 = Samus has suit, 1 = Samus is without suit.
ItemHistory            = $69B4   ;Thru $6A73. Unique item history saved game data (not used).

;---------------------------------------[ More enemy RAM ]-------------------------------------------

EnStatus               = $6AF4   ;Keeps track of enemy statuses. #$00=Enemy slot not in use,-->
                                        ;#$04=Enemy frozen.
EnRadY                 = $6AF5   ;Distance in pixels from middle of enemy to top or botom.
EnRadX                 = $6AF6   ;Distance in pixels from middle of enemy to left or right.
EnAnimFrame            = $6AF7   ;Index into enemy animation frame data.
EnAnimDelay            = $6AF8   ;Number of frames to delay between animation frames.
EnResetAnimIndex       = $6AF9   ;Index to beginning of animation sequence.
EnAnimIndex            = $6AFA   ;Index to current animation.
EnNameTable            = $6AFB   ;#$00=Enemy on name table 0, #$01=Enemy on name table 3.
EnData18               = $6AFC   ; Unknown
EnData19               = $6AFD   ; Unknown
EnData1A               = $6AFE   ; Unknown
EnData1B               = $6AFF   ; Unknown
EnData1C               = $6B00   ; Unknown
EnData1D               = $6B01   ; Unknown
EnDataIndex            = $6B02   ;Contains index into enemy data tables.
EnData1F               = $6B03   ; Unknown

;-------------------------------------[ Intro sprite defines ]---------------------------------------

IntroStarSprite00      = $6E00   ;thru $6E9F
IntroStarSprite01      = $6E04   ;
IntroStarSprite02      = $6E08   ;
IntroStarSprite03      = $6E0C   ;
IntroStarSprite04      = $6E10   ;
IntroStarSprite05      = $6E14   ;
IntroStarSprite06      = $6E18   ;
IntroStarSprite07      = $6E1C   ;
IntroStarSprite08      = $6E20   ;
IntroStarSprite09      = $6E24   ;
IntroStarSprite0A      = $6E28   ;
IntroStarSprite0B      = $6E2C   ;
IntroStarSprite0C      = $6E30   ;
IntroStarSprite0D      = $6E34   ;
IntroStarSprite0E      = $6E38   ;
IntroStarSprite0F      = $6E3C   ;
IntroStarSprite10      = $6E40   ;
IntroStarSprite11      = $6E44   ;
IntroStarSprite12      = $6E48   ;
IntroStarSprite13      = $6E4C   ;
IntroStarSprite14      = $6E50   ;RAM used for storing intro star sprite data.
IntroStarSprite15      = $6E54   ;
IntroStarSprite16      = $6E58   ;
IntroStarSprite17      = $6E5C   ;
IntroStarSprite18      = $6E60   ;
IntroStarSprite19      = $6E64   ;
IntroStarSprite1A      = $6E68   ;
IntroStarSprite1B      = $6E6C   ;
IntroStarSprite1C      = $6E70   ;
IntroStarSprite1D      = $6E74   ;
IntroStarSprite1E      = $6E78   ;
IntroStarSprite1F      = $6E7C   ;
IntroStarSprite20      = $6E80   ;
IntroStarSprite21      = $6E84   ;
IntroStarSprite22      = $6E88   ;
IntroStarSprite23      = $6E8C   ;
IntroStarSprite24      = $6E90   ;
IntroStarSprite25      = $6E94   ;
IntroStarSprite26      = $6E98   ;
IntroStarSprite27      = $6E9C   ;

;Intro sprite 0 and sparkle sprite.
IntroSpr0YCoord        = $6EA0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr0PattTbl       = $6EA1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr0Cntrl         = $6EA2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr0XCoord        = $6EA3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr0Index         = $6EA4   ;Index to next sparkle sprite data byte.
IntroSpr0NextCntr      = $6EA5   ;Decrements each frame. When 0, load new sparkle sprite data.
SparkleSpr0YChange     = $6EA6   ;Sparkle sprite y coordinate change.
IntroSpr0XChange       = $6EA6   ;Intro sprite x total movement distance.
SparkleSpr0XChange     = $6EA7   ;Sparkle sprite x coordinate change.
IntroSpr0YChange       = $6EA7   ;Intro sprite y total movement distance.
IntroSpr0ChngCntr      = $6EA8   ;decrements each frame from #$20. At 0, change sparkle sprite.
IntroSpr0ByteType      = $6EA9   ;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
                                        ;bits for x coord change. if #$00, next data byte contains-->
                                        ;4 bits for x coord change and 4 bits for y coord change.
IntroSpr0Complete      = $6EAA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr0SpareB        = $6EAB   ;Not used.
IntroSpr0XRun          = $6EAC   ;x displacement of sprite movement(run).
IntroSpr0YRise         = $6EAD   ;y displacement of sprite movement(rise).
IntroSpr0XDir          = $6EAE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr0YDir          = $6EAF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 1 and sparkle sprite.
IntroSpr1YCoord        = $6EB0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr1PattTbl       = $6EB1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr1Cntrl         = $6EB2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr1XCoord        = $6EB3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr1Index         = $6EB4   ;Index to next sparkle sprite data byte.
IntroSpr1NextCntr      = $6EB5   ;Decrements each frame. When 0, load new sparkle sprite data.
SparkleSpr1YChange     = $6EB6   ;Sparkle sprite y coordinate change.
IntroSpr1XChange       = $6EB6   ;Intro sprite x total movement distance.
SparkleSpr1XChange     = $6EB7   ;Sparkle sprite x coordinate change.
IntroSpr1YChange       = $6EB7   ;Intro sprite y total movement distance.
IntroSpr1ChngCntr      = $6EB8   ;decrements each frame from #$20. At 0, change sparkle sprite.
IntroSpr1ByteType      = $6EB9   ;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
                                        ;bits for x coord change. if #$00, next data byte contains-->
                                        ;4 bits for x coord change and 4 bits for y coord change.
IntroSpr1Complete      = $6EBA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr1SpareB        = $6EBB   ;Not used.
IntroSpr1XRun          = $6EBC   ;x displacement of sprite movement(run).
IntroSpr1YRise         = $6EBD   ;y displacement of sprite movement(rise).
IntroSpr1XDir          = $6EBE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr1YDir          = $6EBF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 2.
IntroSpr2YCoord        = $6EC0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr2PattTbl       = $6EC1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr2Cntrl         = $6EC2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr2XCoord        = $6EC3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr2Spare5        = $6EC4   ;Not used.
IntroSpr2Spare6        = $6EC5   ;Not used.
IntroSpr2XChange       = $6EC6   ;Intro sprite x total movement distance.
IntroSpr2YChange       = $6EC7   ;Intro sprite y total movement distance.
IntroSpr2Spare8        = $6EC8   ;Not used.
IntroSpr2Spare9        = $6EC9   ;Not used.
IntroSpr2Complete      = $6ECA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr2SpareB        = $6ECB   ;Not used.
IntroSpr2XRun          = $6ECC   ;x displacement of sprite movement(run).
IntroSpr2YRise         = $6ECD   ;y displacement of sprite movement(rise).
IntroSpr2XDir          = $6ECE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr2YDir          = $6ECF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 3.
IntroSpr3YCoord        = $6ED0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr3PattTbl       = $6ED1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr3Cntrl         = $6ED2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr3XCoord        = $6ED3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr3Spare5        = $6ED4   ;Not used.
IntroSpr3Spare6        = $6ED5   ;Not used.
IntroSpr3XChange       = $6ED6   ;Intro sprite x total movement distance.
IntroSpr3YChange       = $6ED7   ;Intro sprite y total movement distance.
IntroSpr3Spare8        = $6ED8   ;Not used.
IntroSpr3Spare9        = $6ED9   ;Not used.
IntroSpr3Complete      = $6EDA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr3SpareB        = $6EDB   ;Not used.
IntroSpr3XRun          = $6EDC   ;x displacement of sprite movement(run).
IntroSpr3YRise         = $6EDD   ;y displacement of sprite movement(rise).
IntroSpr3XDir          = $6EDE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr3YDir          = $6EDF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 4.
IntroSpr4YCoord        = $6EE0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr4PattTbl       = $6EE1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr4Cntrl         = $6EE2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr4XCoord        = $6EE3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr4Spare5        = $6EE4   ;Not used.
IntroSpr4Spare6        = $6EE5   ;Not used.
IntroSpr4XChange       = $6EE6   ;Intro sprite x total movement distance.
IntroSpr4YChange       = $6EE7   ;Intro sprite y total movement distance.
IntroSpr4Spare8        = $6EE8   ;Not used.
IntroSpr4Spare9        = $6EE9   ;Not used.
IntroSpr4Complete      = $6EEA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr4SpareB        = $6EEB   ;Not used.
IntroSpr4XRun          = $6EEC   ;x displacement of sprite movement(run).
IntroSpr4YRise         = $6EED   ;y displacement of sprite movement(rise).
IntroSpr4XDir          = $6EEE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr4YDir          = $6EEF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 5.
IntroSpr5YCoord        = $6EF0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr5PattTbl       = $6EF1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr5Cntrl         = $6EF2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr5XCoord        = $6EF3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr5Spare5        = $6EF4   ;Not used.
IntroSpr5Spare6        = $6EF5   ;Not used.
IntroSpr5XChange       = $6EF6   ;Intro sprite x total movement distance.
IntroSpr5YChange       = $6EF7   ;Intro sprite y total movement distance.
IntroSpr5Spare8        = $6EF8   ;Not used.
IntroSpr5Spare9        = $6EF9   ;Not used.
IntroSpr5Complete      = $6EFA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr5SpareB        = $6EFB   ;Not used.
IntroSpr5XRun          = $6EFC   ;x displacement of sprite movement(run).
IntroSpr5YRise         = $6EFD   ;y displacement of sprite movement(rise).
IntroSpr5XDir          = $6EFE   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr5YDir          = $6EFF   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 6.
IntroSpr6YCoord        = $6F00   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr6PattTbl       = $6F01   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr6Cntrl         = $6F02   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr6XCoord        = $6F03   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr6Spare5        = $6F04   ;Not used.
IntroSpr6Spare6        = $6F05   ;Not used.
IntroSpr6XChange       = $6F06   ;Intro sprite x total movement distance.
IntroSpr6YChange       = $6F07   ;Intro sprite y total movement distance.
IntroSpr6Spare8        = $6F08   ;Not used.
IntroSpr6Spare9        = $6F09   ;Not used.
IntroSpr6Complete      = $6F0A   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr6SpareB        = $6F0B   ;Not used.
IntroSpr6XRun          = $6F0C   ;x displacement of sprite movement(run).
IntroSpr6YRise         = $6F0D   ;y displacement of sprite movement(rise).
IntroSpr6XDir          = $6F0E   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr6YDir          = $6F0F   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 7.
IntroSpr7YCoord        = $6F10   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSpr7PattTbl       = $6F11   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSpr7Cntrl         = $6F12   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSpr7XCoord        = $6F13   ;Loaded into byte 3 of sprite RAM(X position).
IntroSpr7Spare5        = $6F14   ;Not used.
IntroSpr7Spare6        = $6F15   ;Not used.
IntroSpr7XChange       = $6F16   ;Intro sprite x total movement distance.
IntroSpr7YChange       = $6F17   ;Intro sprite y total movement distance.
IntroSpr7Spare8        = $6F18   ;Not used.
IntroSpr7Spare9        = $6F19   ;Not used.
IntroSpr7Complete      = $6F1A   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSpr7SpareB        = $6F1B   ;Not used.
IntroSpr7XRun          = $6F1C   ;x displacement of sprite movement(run).
IntroSpr7YRise         = $6F1D   ;y displacement of sprite movement(rise).
IntroSpr7XDir          = $6F1E   ;MSB set=decrease sprite x pos, else increase sprite  x pos.
IntroSpr7YDir          = $6F1F   ;MSB set=decrease sprite y pos, else increase sprite  y pos.

;----------------------------------------------------------------------------------------------------

WorldMapRAM            = $7000   ;Thru $73FF. The map is 1Kb in size (1024 bytes).

SamusData              = $77FE   ;Thru $782D. Samus saved game data (not used).

;------------------------------------------[ Misc. defines ]-----------------------------------------

modeTitle              = 1

;Special item types.
it_Squeept             = $1
it_PowerUp             = $2
it_Mellow              = $3
it_Elevator            = $4
it_Cannon              = $5
it_MotherBrain         = $6
it_Zebetite            = $7
it_RinkaSpawner        = $8
it_Door                = $9
it_PaletteChange       = $A

;Power up id for items
pu_BOMBS               = $00
pu_HIGHJUMP            = $01
pu_LONGBEAM            = $02
pu_SCREWATTACK         = $03
pu_MARUMARI            = $04
pu_VARIA               = $05
pu_WAVEBEAM            = $06
pu_ICEBEAM             = $07
pu_ENERGYTANK          = $08
pu_MISSILES            = $09

;Bitmask defs used for SamusGear.
gr_BOMBS               = %00000001
gr_HIGHJUMP            = %00000010
gr_LONGBEAM            = %00000100
gr_SCREWATTACK         = %00001000
gr_MARUMARI            = %00010000
gr_VARIA               = %00100000
gr_WAVEBEAM            = %01000000
gr_ICEBEAM             = %10000000

;Samus action handlers.
sa_Stand               = 0
sa_Run                 = 1       ;Also run and jump.
sa_Jump                = 2
sa_Roll                = 3
sa_PntUp               = 4
sa_Door                = 5
sa_PntJump             = 6
sa_Dead                = 7
sa_Dead2               = 8
sa_Elevator            = 9
sa_FadeIn0             = 20
sa_FadeIn1             = 21
sa_FadeIn2             = 22
sa_FadeIn3             = 23
sa_FadeIn4             = 24
sa_Begin               = 255

;Animations
an_SamusRun            = $00
an_SamusFront          = $04
an_SamusStand          = $07
an_SamusJump           = $0C
an_SamusSalto          = $0E
an_SamusRunJump        = $13
an_SamusRoll           = $16
an_Bullet              = $1B
an_SamusFireJump       = $20
an_SamusFireRun        = $22
an_SamusPntUp          = $27
an_Explode             = $32
an_SamusJumpPntUp      = $35
an_SamusRunPntUp       = $37
an_WaveBeam            = $7D
an_BombTick            = $7F
an_BombExplode         = $82
an_MissileLeft         = $8B
an_MissileRight        = $8D
an_MissileExplode      = $91

;Weapon action handlers.
wa_RegularBeam         = 1
wa_WaveBeam            = 2
wa_IceBeam             = 3
wa_BulletExplode       = 4
wa_LayBomb             = 8
wa_BombCount           = 9
wa_BombExplode         = 10
wa_Missile             = 11
