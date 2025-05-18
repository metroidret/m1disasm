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
; CodePtr+1              = $0D     ;a routine from a list of routine addresses.

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
; RoomPtr+1              = $34     ;High byte of room pointer address.

StructPtr              = $35     ;Low bute of structure pointer address.
; StructPtr+1            = $36     ;High byte of structure pointer address.

CartRAMWorkPtr         = $37     ;Low byte of pointer to current position in room RAM.
; CartRAMWorkPtr+1       = $38     ;High byte of pointer to current position in room RAM.
                                   ;The CartRAMWorkPtr points to the current memory address-->
                                   ;in the room RAM that is being loaded.

CartRAMPtr             = $39     ;Low byte of pointer to room RAM (#$00).
; CartRAMPtr+1           = $3A     ;High byte of pointer to room RAM (#$60 or #$64).
                                   ;Room RAM is a screen buffer where the objects that make-->
                                   ;up a room are loaded.  There are two room RAM memory-->
                                   ;areas and they are the exact same size as the two name-->
                                   ;tables and attribute tables in the PPU. Once the room-->
                                   ;RAM conatins a completed room in it, the entire contents-->
                                   ;of the room RAM is loaded into the PPU.

RoomPtrTable           = $3B     ;Low byte of start of room pointer table.
; RoomPtrTable+1         = $3C     ;High byte of start of room pointer table.

StructPtrTable         = $3D     ;Low byte of start of structure pointer table.
; StructPtrTable+1       = $3E     ;High byte of structure pointer table.

MacroPtr               = $3F     ;Low byte of pointer into macro definitions.
; MacroPtr+1             = $40     ;High byte of pointer into macro definitions.

EnmyFrameTbl1Ptr       = $41     ;Low byte of pointer into address table to find enemy animations.
; EnmyFrameTbl1Ptr+1     = $42     ;High byte of pointer into address table to find enemy animations.

EnmyFrameTbl2Ptr       = $43     ;Same as above except in a second table because there are-->
; EnmyFrameTbl2Ptr+1     = $44     ;too many entries to fit into one table.

EnmyPlaceTblPtr        = $45     ;Low byte of pointer into enemy frame placement table.
; EnmyPlaceTblPtr+1      = $46     ;High byte of pointer into enemy frame placement table.

EnemyAnimPtr           = $47     ;Low byte of start of EnemyAnimIndexTbl.
; EnemyAnimPtr+1         = $48     ;High byte of start of EnemyAnimIndexTbl.

ScrollDir              = $49     ;0=Up, 1=Down, 2=Left, 3=Right.

TempScrollDir          = $4A     ;Stores ScrollDir when room is initially loaded.

PageIndex              = $4B     ;Index to object data.
                                   ;#$D0, #$E0, #$F0 = projectile indices(including bombs).

ItemIndex              = $4C     ;#$00 or #$08. Added to PowerUpType addresses to determine if-->
                                   ;the first or second item slot is being checked.

SamusDir               = $4D     ;0 = Right, 1 = Left.
SamusDoorDir           = $4E     ;Direction Samus passed through door.
SamusMapPosY           = $4F     ;Current y position on world map.
SamusMapPosX           = $50     ;Current x position on world map.
SamusScrX              = $51     ;Samus x position on screen.
SamusScrY              = $52     ;Samus y position on screen.
WalkSoundDelay         = $53
Statues54              = $54
IsSamus                = $55     ;1=Samus object being accessed, 0=not Samus.
DoorEntryStatus        = $56     ;0=Not in door, 1=In right door, 2=In left door, 3=Scroll up-->
                                   ;4=Scroll down, 5=Exit door, MSB set=Door entered. If value-->
                                   ;is 3 or 4, a door was entered while in a vertical shaft and-->
                                   ;the door was not centered on the screen and up or down-->
                                   ;scrolling needs to occur before scrolling to the next room.
DoorScrollStatus       = $57     ;#$01=Entered right hand door from horizontal area.-->
                                   ;#$02=Entered left hand door from horizontal area.-->
                                   ;#$03=Entered door from vertical shaft and room needs to-->
                                   ;be centered before horizontal scrolling. #$04=Entered-->
                                   ;door from vertical shaft and room was already centered.
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

; 4 slots of 2 bytes each ($5C-$63)
DoorCartRAMPtr         = $5C
; DoorCartRAMPtr+1       = $5D

SamusInLava            = $64     ;#$01=Samus in lava, #$00=She is not.
ObjectCounter          = $65     ;Counts such things as object explosion time.
EnemyMovePixelQty      = $66     ;Quantity of times to call the current EnemyMoveOnePixel routine
ObjectPal              = $67     ;Attrib. table info for room object(#$00 thru #$03).
RoomPal                = $68
TempX                  = $69
TempY                  = $6A
ObjectCntrl            = $6B     ;Controls object properties such as mirroring and color-->
                                   ;bits. Bit 4 controls object mirroring.
                                   ; bit 0 and bit 1 is for the color palette

DoorOnNameTable3       = $6C     ;The following two addresses are used to keep track of the-->
DoorOnNameTable0       = $6D     ;doors loaded on the name tables. The information is used-->
                                   ;in the GetRoomNum routine to prevent the loading of a-->
                                   ;room behind a door when scrolling horizontally. This has-->
                                   ;the effect of stopping scrolling until Samus walks through-->
                                   ;the door. #$01=Left door on name table. #$02=right door-->
                                   ;on name table. #$03 two doors on the same name table.-->
                                   ;#$00 is possible in $6D if 2 doors are on name table 0-->
                                   ;while vertically scrolling.

HealthChange           = $6E     ;Amount to add/subtract from Health.
; HealthChange+1         = $6F

SamusBlink             = $70     ;Samus's invincibility frames delay counter.
UpdatingProjectile     = $71     ;#$01=Projectile update in process. #$00=not in process.
DamagePushDirection    = $72     ;#$00=Push Samus left when hit, #$01=Push right, #$FF=No push.
SamusHurt73            = $73
InArea                 = $74     ;#$10(or #$00)=Brinstar, #$11=Norfair, #$12=Kraid hideout,-->
                                   ;#$13=Tourian, #$14=Ridley hideout.

SpareMem75             = $75     ;Initialized to #$FF in AreaInit. Not used.
PalToggle              = $76

ItemRoomMusicStatus    = $79     ;#$00=Item room music not playing.
                                   ;#$01=Play item room music.
                                   ;#$80=Stop item room music once door scroll complete.
                                   ;#$81=Item room music already playing. Don't restart.

OnFrozenEnemy          = $7D     ;#$01=Samus standing on frozen enemy, #$00=she is not.

KraidLintCounter       = $7E
KraidNailCounter       = $7F
Ridley7E               = $7E
Ridley80               = $80

EnemyMovementPtr       = $81
; EnemyMovementPtr+1     = $82
EnemyStatus81          = $81
Enemy82                = $82

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

; 2 bytes ($85-$86)
EnemyLFB88_85          = $85

Mellow8A               = $8A

MetroidOnSamus         = $92     ;#$01=Metroid on Samus, #$00=Metroid not on Samus.

MissilePickupQtyMax    = $93     ;Maximum missile drops that can be picked up. Randomly-->
                                   ;recalculated whenever Samus goes through a door.
EnergyPickupQtyMax     = $94     ;Maximum energy drops that can be picked up. Randomly-->
                                   ;recalculated whenever Samus goes through a door.
MissilePickupQtyCur    = $95     ;Number of missile drops currently collected by Samus-->
                                   ;Reset to 0 when Samus goes through a door.
EnergyPickupQtyCur     = $96     ;Number of energy drops currently collected by Samus-->
                                   ;Reset to 0 when Samus goes through a door.

CannonIndex            = $97     ;Current cannon being processed

MotherBrainStatus      = $98     ;#$00=Mother brain not in room, #$01=Mother brain in room,-->
                                   ;#$02=Mother brain hit, #$03=Mother brain dying-->
                                   ;#$04=Mother brain dissapearing, #$05=Mother brain gone,-->
                                   ;#$06=Time bomb set, #$07=Time bomb exploded,-->
                                   ;#$08=Initialize mother brain,-->
                                   ;#$09, #$0A=Mother brain already dead.
MotherBrainHits        = $99     ;Number of times mother brain has been hit. Dies at #$20.

MotherBrain9A          = $9A
MotherBrain9B          = $9B
MotherBrainAnimFrameTableID = $9C
MotherBrainNameTable   = $9D
MotherBrain9E          = $9E
MotherBrain9F          = $9F

; 4 slots of 4 bytes each ($A0-$AF)
SkreeProjectileDieDelay= $A0     ;Delay until projectile dies.
SkreeProjectileY       = $A1
SkreeProjectileX       = $A2
SkreeProjectileHi      = $A3

; 4 slots of 8 bytes each ($B0-$CF)
MellowStatus           = $B0
MellowY                = $B1
MellowX                = $B2
MellowHi               = $B3
MellowAttackState      = $B4
MellowAttackTimer      = $B5
MellowB6               = $B6
; $B7 is unused

SpareMemB7             = $B7     ;Written to in title routine and accessed by unused routine.
SpareMemB8             = $B8     ;Written to in title routine and accessed by unused routine.
SpareMemBB             = $BB     ;Written to in title routine, but never accessed.

CrossMsl0to3SlowDelay  = $BC     ;This address holds an 8 frame delay. when the delay is up,-->
                                   ;The crosshair sprites double their speed.
CrossMsl4to7SpawnDelay = $BD     ;This address holds a 32 frame delay.  When the delay is-->
                                   ;up, the second set of crosshair sprites start their movement.
SecondCrosshairSprites = $BF     ;#$01=Second crosshair sprites active in intro.

FlashScreen            = $C0     ;#$01=Flash screen during crosshairs routine.
PalDataIndex           = $C1
ScreenFlashPalIndex    = $C2     ;Index to palette data to flash screen during intro.
IntroStarOffset        = $C3     ;Contains offset into IntroStarPntr table for twinkle effect.
FadeDataIndex          = $C4     ;Index to palette data to fade items in and out during intro.

SpareMemC5             = $C5     ;Written to in title routine, but never accessed.
CrossExplodeLengthIndex= $C6     ;#$00 thru #$04. Index to find cross sprite data.
IsUpdatingCrossExplode = $C7     ;#$01=Draw cross on screen during crosshairs routine.
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

SoundChannelBase       = $E6
; SoundChannelBase+1     = $E7

Cntrl0Data             = $EA     ;Temp storage for data of first address sound channel
VolumeCntrlAddress     = $EB     ;Desired address number in VolumeCntrlAdressTbl

ABStatus               = $F0     ;Stores A and B button status in AreaInit. Never used.
;                             = $F7

MirrorCntrl            = $FA     ;If bit 3 is set, PPU set to horizontal mirroring-->
                                   ;else if bit 3 is clear, PPU is set to vertical-->
                                   ;mirroring. No other bits seem to matter.

ScrollY                = $FC     ;Y value loaded into scroll register.
ScrollX                = $FD     ;X value loaded into scroll register.
PPUMASK_ZP             = $FE     ;Data byte to be loaded into PPU control register 1.
PPUCTRL_ZP             = $FF     ;Data byte to be loaded into PPU control register 0.

Health                 = $0106   ;Lower health digit in upper 4 bits.
; Health+1               = $0107   ;Upper health digit in lower 4 bits-->
                                   ;# of full tanks in upper 4 bits.
MiniBossKillDelayFlag  = $0108   ;Initiate power up music and delay after Kraid/Ridley killed.
PowerUpDelayFlag       = $0109   ;Initiate power up music and delay after item pickup.

EndTimer               = $010A   ;Lower byte of end game escape timer.
; EndTimer+1             = $010B   ;Upper byte of end game escape timer.

MotherBrain010C        = $010C
MotherBrain010D        = $010D

MissileToggle          = $010E   ;0=fire bullets, 1=fire missiles.
SamusHurt010F          = $010F

;-----------------------------------------[ Sprite RAM ]---------------------------------------------

SpriteRAM              = $0200   ;$0200 thru $02FF

;-----------------------------------------[ Object RAM ]---------------------------------------------

; 16 slots of 16 bytes each ($0300-$03FF)
; slot 0 to 1 is for samus
; slot 2 is for elevator
; slot 4 is for power-up
; slot 6 to 7 is for tourian bridge
; slot 8 to B is for doors
; slot D to F is for samus projectiles

;Samus RAM.
ObjAction              = $0300   ;Status of object. 0=object slot not in use.
ObjRadY                = $0301   ;Distance in pixels from object center to top or bottom.
ObjRadX                = $0302   ;Distance in pixels from object center to left or right side.
ObjAnimFrame           = $0303   ;*2 = Index into FramePtrTable for current animation.
ObjAnimDelay           = $0304   ;Number of frames to delay between animation frames.
ObjAnimResetIndex      = $0305   ;Restart index-1 when AnimIndex finished with last frame.
ObjAnimIndex           = $0306   ;Current index into ObjectAnimIndexTbl.
SamusOnElevator        = $0307   ;0=Samus not on elevator, 1=Samus on elevator.
ObjSpeedY              = $0308   ;MSB set=moving up(#$FA max), MSB clear=moving down(#$05 max).
ObjSpeedX              = $0309   ;MSB set=moving lft(#$FE max), MSB clear=moving rt(#$01 max).
SamusHit               = $030A   ;Samus hit by enemy.
ObjOnScreen            = $030B   ;1=Object on screen, 0=Object beyond screen boundaries.
ObjHi                  = $030C   ;0=Object on nametable 0, 1=Object on nametable 3.
ObjY                   = $030D   ;Object y position in room(not actual screen position).
ObjX                   = $030E   ;Object x position in room(not actual screen position).
SamusJumpDsplcmnt      = $030F   ;Number of pixels vertically displaced from jump point.
SamusSubPixelY         = $0310   ;Vertical movement counter. Exponential change in speed.
SamusSubPixelX         = $0311   ;Horizontal movement counter. Exponential change in speed.
SamusSpeedSubPixelY    = $0312   ;Vertical movement counter. Linear change in speed.
SamusSpeedSubPixelX    = $0313   ;Horizontal movement counter. Linear change in speed.
SamusAccelY            = $0314   ;Value used in calculating vertical acceleration on Samus.
SamusAccelX            = $0315   ;Value used in calculating horizontal acceleration on Samus.
SamusHorzSpeedMax      = $0316   ;Used to calc maximum horizontal speed Samus can reach.

;Elevator RAM.
ElevatorStatus         = $0320   ;#$01=Elevator present, #$00=Elevator not present.
Elevator032F           = $032F   ;bit 7 is up(1) or down(0)

;Power-up item RAM.
PowerUpAnimFrame       = $0343   ;*2 = Index into FramePtrTable for current animation.
PowerUpHi              = $034C   ;Name table power up item is located on.
PowerUpY               = $034D   ;Room Y coord of power up item.
PowerUpX               = $034E   ;Room x coord of power up item.

;Statues and bridge RAM
StatueStatus           = $0360
StatueAnimFrame        = $0363
KraidStatueRaiseState  = $0364   ;#$01=Not Raised, #$02=Raising, bit7=Raised.
RidleyStatueRaiseState = $0365
Statue0366             = $0366   ; is this even related to statues?
; Statue0366+1           = $0367
StatueHi               = $036C
StatueY                = $036D   ;Set to either Kraid's Y or Ridley's Y when drawing a statue.
StatueX                = $036E   ;Set to either Kraid's X or Ridley's X when drawing a statue.
KraidStatueY           = $036F
RidleyStatueY          = $0370

;Door RAM
DoorStatus             = $0300
DoorAnimResetIndex     = $0305
DoorAnimIndex          = $0306
DoorType               = $0307  ;#$00=red door, #$01=blue door, #$02=10-missile door
                                  ;#$03=blue door that changes the music
DoorHit                = $030A  ; bit 2 indicates if the door was hit or not
DoorHi                 = $030C
DoorX                  = $030E
DoorHitPoints          = $030F  ;used as re-close delay for blue doors


;Samus projectile RAM
ProjectileDieDelay     = $030F

;-------------------------------------[ Title routine specific ]-------------------------------------

PasswordCursor         = $0320   ;Password write position (#$00 - #$17).
InputRow               = $0321   ;Password character select row (#$00 - #$04).
InputColumn            = $0322   ;Password character select column (#$00 - #$0C).
PasswordStat00         = $0324   ;Does not appear to have a function.
StartContinue          = $0325   ;0=START selected, 1=CONTINUE selected.

;------------------------------------------[ Enemy RAM ]---------------------------------------------

; 16 slots of 16 bytes each ($0400-$04FF)
; slot 0 to 5 is for normal enemies
; slot 6 to B is for enemy fireballs
; slot C to D is for enemy explosions
; slot E is for mother brain
; slot F is for mellow handler enemy
EnY                    = $0400   ;Enemy y position in room.(not actual screen position).
EnX                    = $0401   ;Enemy x position in room.(not actual screen position).
EnSpeedY               = $0402   ; unknown - y speed?
EnSpeedX               = $0403   ; unknown - x speed?
EnData04               = $0404   ; unknown - hurt flag?
EnData05               = $0405   ; L/R facing in LSB ?
; EnCounter              = $0406   ;Counts such things as explosion time. - y counter?
EnSpeedSubPixelY       = $0406   ;Counts such things as explosion time. - y counter?
EnSpeedSubPixelX       = $0407   ; unknown - x counter
EnMovementIndex        = $0408   ;Index into the EnemyMovement table of that enemy.
EnDelay                = $0409   ;Delay counter between enemy actions.
EnData0A               = $040A   ; unknown -- For crawlers, orientation
                                   ; 00-on floor, 01-on wall going down, 02-on ceiling, 03-on wall going up
EnHitPoints            = $040B   ;Current hit points of enemy.
EnPrevStatus           = $040C   ;Enemy status before being hurt. bit 7 and bit 6 is EnSpecialAttribs.
EnData0D               = $040D   ; unknown - Ice Timer? stun timer?
EnWeaponAction         = $040E   ; unknown - What weapon action is currently hitting the enemy?
EnSpecialAttribs       = $040F   ;Bit 7 set=tough version of enemy, bit 6 set=mini boss.

; 4 slots of 8 bytes each ($04C0-$04DF)
EnExplosionY           = $0400
EnExplosionX           = $0401
EnExplosion04C2        = $0402
EnExplosion04C3        = $0403
EnExplosion04C4        = $0404
EnExplosion04C5        = $0405
EnExplosionAnimDelay   = $0406
EnExplosionAnimFrame   = $0407

;----------------------------------------------------------------------------------------------------

;Tile respawning
TileBlastRoutine       = $0500
TileBlastAnimFrame     = $0503
TileBlastAnimDelay     = $0504
TileBlast0505          = $0505
TileBlastAnimIndex     = $0506
TileBlastDelay         = $0507
TileBlastWRAMPtr       = $0508
; TileBlastWRAMPtr+1     = $0509
TileBlastType          = $050A

;---------------------------------[ Sound engine memory addresses ]----------------------------------

MusicSQ1PeriodLow      = $0600   ;Loaded into SQ1_LO when playing music
MusicSQ1PeriodHigh     = $0601   ;Loaded into SQ1_HI when playing music

SFXPaused              = $0602   ;0=Game not paused, 1=Game paused
PauseSFXStatus         = $0603   ;Plays PauseMusic SFX if less than #$12

MusicSQ2PeriodLow      = $0604   ;Loaded into SQ2_LO when playing music
MusicSQ2PeriodHigh     = $0605   ;Loaded into SQ2_HI when playing music

WriteMultiChannelData  = $0607   ;1=data needs to be written, 0=no data to write

MusicTriPeriodLow      = $0608   ;Loaded into TRI_LO when playing music
MisicTriPeriodHigh     = $0609   ;Loaded into TRI_HI when playing music

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

SQ1FrameCountInit      = $0620   ;Holds number of frames to play SQ1 channel data
SQ2FrameCountInit      = $0621   ;Holds number of frames to play SQ2 channel data
TriangleFrameCountInit = $0622   ;Holds number of frames to play Triangle channel data
NoiseFrameCountInit    = $0623   ;Holds number of frames to play Noise channel data

SQ1RepeatCounter       = $0624   ;Number of times to repeat SQ1 music loop
SQ2RepeatCounter       = $0625   ;Number of times to repeat SQ2 music loop
TriangleRepeatCounter  = $0626   ;Number of times to repeat Triangle music loop
NoiseRepeatCounter     = $0627   ;Number of times to repeat Noise music loop

SQ1DutyEnvelope        = $0628   ;Loaded into SQ1_VOL when playing music
SQ2DutyEnvelope        = $0629   ;Loaded into SQ2_VOL when playing music
TriLinearCount         = $062A   ;disable\enable counter, linear count length

NoteLengthTblOffset    = $062B   ;Stores the offset to find proper note length table
MusicRepeat            = $062C   ;0=Music does not repeat, Nonzero=music repeats
TriangleCounterCntrl   = $062D   ;$F0=disable length cntr, $00=long note, $0F=short note
SQ1VolumeCntrl         = $062E   ;Entry number in VolumeCntrlAddressTbl for SQ1
SQ2VolumeCntrl         = $062F   ;Entry number in VolumeCntrlAddressTbl for SQ2
SQ1Base                = $0630   ;Low byte of base address for SQ1 music data
; SQ1Base+1              = $0631   ;High byte of base address for SQ1 music data
SQ2Base                = $0632   ;Low byte of base address for SQ2 music data
; SQ2Base+1              = $0633   ;High byte of base address for SQ2 music data
TriangleBase           = $0634   ;Low byte of base address for Triangle music data
; TriangleBase+1         = $0635   ;High byte of base address for Triangle music data
NoiseBase              = $0636   ;Low byte of base address for Noise music data
; NoiseBase+1            = $0637   ;High byte of base address for Noise music data

SQ1MusicIndexIndex     = $0638   ;Index to find SQ1 sound data index. Base=$630,$631
SQ2MusicIndexIndex     = $0639   ;Index to find SQ2 sound data index. Base=$632,$633
TriangleMusicIndexIndex= $063A   ;Index to find Tri sound data index. Base=$634,$635
NoiseMusicIndexIndex   = $063B   ;Index to find Noise sound data index. Base=$636,$637

SQ1LoopIndex           = $063C   ;SQ1 Loop start index
SQ2LoopIndex           = $063D   ;SQ2 loop start index
TriangleLoopIndex      = $063E   ;Triangle loop start index
NoiseLoopIndex         = $063F   ;Noise loop start index

SQ1MusicFrameCount     = $0640   ;Decrements every sq1 frame. When 0, load new data
SQ2MusicFrameCount     = $0641   ;Decrements every sq2 frame. when 0, load new data
TriangleMusicFrameCount= $0642   ;Decrements every triangle frame. When 0, load new data
NoiseMusicFrameCount   = $0643   ;Decrements every noise frame. When 0, load new data

MusicSQ1Sweep          = $0648   ;Value is loaded into SQ1_SWEEP when playing music
MusicSQ2Sweep          = $0649   ;Value is loaded into SQ2_SWEEP when playing music
TriangleSweep          = $064A   ;Loaded into TRI_UNUSED(not used)

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

ScrewAttack0686        = $0686

NoiseContSFX           = $0688   ;Continuation flags for noise SFX
SQ1ContSFX             = $0689   ;Continuation flags for SQ1 SFX
SQ2ContSFX             = $068A   ;Continuation flags for SQ2 SFX (never used)
TriangleContSFX        = $068B   ;Continuation flags for Triangle SFX
MultiContSFX           = $068C   ;Continuation flags for Multi SFX

CurrentMusic           = $068D   ;Stores the flag of the current music being played

;----------------------------------------------------------------------------------------------------

; used by ZebHole in bank 7
Mem0728                = $0728
Mem0729                = $0729
Mem072A                = $072A
Mem072B                = $072B
Mem072C                = $072C
Mem0730                = $0730
Mem0732                = $0732
Mem0738                = $0738
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

; 5 Zebetite slots of 8 bytes each ($0758-$077F)
ZebetiteStatus         = $0758
ZebetiteVRAMPtr        = $0759   ;Pointer to top-left tile of Zebetite in the nametable.
; ZebetiteVRAMPtr+1      = $075A
ZebetiteHits           = $075B   ;Number of missile hits dealt to Zebetite. Dies at 8 hits.
ZebetiteHealingDelay   = $075C   ;Heals 1 hit when counts down from #$40 to #$00.
ZebetiteJustGotHit     = $075D   ;#$01 if zebetite got hit by a missile this frame, else #$00
; $075E is unused
; $075F is unused

TileSize               = $0780   ;4 MSBs=Y size of tile to erase. 4 LSBs=X size of tile to erase.
TileInfo0              = $0781   ;
TileInfo1              = $0782   ;
TileInfo2              = $0783   ;Tile patterns to replace blasted tiles.
TileInfo3              = $0784   ;
TileInfo4              = $0785   ;
TileInfo5              = $0786   ;

PPUStrIndex            = $07A0   ;# of bytes of data in PPUDataString. #$4F bytes max.

;$07A1 thru $07F0 contain a byte string of data to be written the the PPU. The first
;byte in the string is the upper address byte of the starting point in the PPU to write
;the data.  The second byte is the lower address byte. The third byte is a configuration
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
; SamusAge+1             = $687E   ;Mid byte of Samus' age.
; SamusAge+2             = $687F   ;High byte of Samus' age.
SamusStat01            = $6880   ;Unused memory address for storing Samus info.
SamusStat02            = $6881   ;SamusStat02 and 03 keep track of how many times Samus has-->
SamusStat03            = $6882   ;died, but this info is never accessed anywhere in the game.

AtEnding               = $6883   ;1=End scenes playing, 0=Not at ending.

EraseGame              = $6884   ;MSB set=erase selected saved game(not used in password carts).

DataSlot               = $6885   ;#$00 thru #$02. Stored Samus data to load.
                                   ;Unused leftover from the original FDS version of the game.

NumberOfUniqueItems    = $6886   ;Counts number of power-ups and red doors-->
                                   ;opened.  Does not count different beams-->
                                   ;picked up (ice, long, wave). increments by 2.

UniqueItemHistory      = $6887   ;Thru $68FC. History of Unique items collected.-->
EndItemHistory         = $68FC   ;Two bytes per item.

KraidRidleyPresent     = $6987   ;#$01=Kraid/Ridley present, #$00=Kraid/Ridley not present.

; 18 bytes ($6988-$6999)
PasswordByte           = $6988
; PasswordByte+$00       = $6988   ;Stores status of items 0 thru 7.
; PasswordByte+$01       = $6989   ;Stores status of items 8 thru 15.
; PasswordByte+$02       = $698A   ;Stores status of items 16 thru 23.
; PasswordByte+$03       = $698B   ;Stores status of items 24 thru 31.
; PasswordByte+$04       = $698C   ;Stores status of items 32 thru 39.
; PasswordByte+$05       = $698D   ;Stores status of items 40 thru 47.
; PasswordByte+$06       = $698E   ;Stores status of items 48 thru 55.
; PasswordByte+$07       = $698F   ;Stores status of items 56 thru 58(bits 0 thru 2).
; PasswordByte+$08       = $6990   ;start location(bits 0 thru 5), Samus suit status (bit 7).
; PasswordByte+$09       = $6991   ;Stores SamusGear.
; PasswordByte+$0A       = $6992   ;Stores MissileCount.
; PasswordByte+$0B       = $6993   ;Stores SamusAge.
; PasswordByte+$0C       = $6994   ;Stores SamusAge+1.
; PasswordByte+$0D       = $6995   ;Stores SamusAge+2.
; PasswordByte+$0E       = $6996   ;Stores no data.
; PasswordByte+$0F       = $6997   ;Stores Statue statuses(bits 4 thu 7).
; PasswordByte+$10       = $6998   ;Stores value RandomNumber1.
; PasswordByte+$11       = $6999   ;Stores sum of $6988 thru $6998(Checksum).

; 24 bytes ($699A-$69B1)
;These 24 memory addresses store the 24 characters
;of the password to be displayed on the screen.
;Upper two bits of PasswordChar bytes will always be %00.
PasswordChar           = $699A

NARPASSWORD            = $69B2   ;0 = invinsible Samus not active, 1 = invinsible Samus active.
JustInBailey           = $69B3   ;0 = Samus has suit, 1 = Samus is without suit.
ItemHistory            = $69B4   ;Thru $6A73. Unique item history saved game data (not used).

;---------------------------------------[ More enemy RAM ]-------------------------------------------

; 16 slots of 16 bytes each ($6AF4-$6BF3)
EnStatus               = $6AF4   ;Keeps track of enemy statuses. #$00=Enemy slot not in use,-->
                                   ;#$04=Enemy frozen.
EnRadY                 = $6AF5   ;Distance in pixels from middle of enemy to top or botom.
EnRadX                 = $6AF6   ;Distance in pixels from middle of enemy to left or right.
EnAnimFrame            = $6AF7   ;Index into enemy animation frame data.
EnAnimDelay            = $6AF8   ;Number of frames to delay between animation frames.
EnResetAnimIndex       = $6AF9   ;Index to beginning of animation sequence.
EnAnimIndex            = $6AFA   ;Index to current animation.
EnHi                   = $6AFB   ;#$00=Enemy on name table 0, #$01=Enemy on name table 3.
EnData18               = $6AFC   ; Unknown
EnData19               = $6AFD   ; Unknown
EnAccelY               = $6AFE   ; Unknown
EnAccelX               = $6AFF   ; Unknown
EnData1C               = $6B00   ; Unknown
EnData1D               = $6B01   ; Unknown
EnType                 = $6B02   ;Enemy type used as index into enemy data tables.
EnData1F               = $6B03   ; Unknown

; 4 slots of 8 bytes each ($6BB4-$6BD3)
EnExplosionStatus      = $6AF4
EnExplosion6BB5        = $6AF5
EnExplosion6BB6        = $6AF6
EnExplosion6BB7        = $6AF7
EnExplosion6BB8        = $6AF8
EnExplosion6BB9        = $6AF9
EnExplosion6BBA        = $6AFA
EnExplosionHi          = $6AFB

; 16 slots of 8 bytes each ($6BF4-$6C73)
CannonStatus           = $6BF4
CannonY                = $6BF5
CannonX                = $6BF6
CannonHi               = $6BF7
CannonInstrListID      = $6BF8   ;Type of cannon: determines where it aims and when it shoots.
CannonAngle            = $6BF9
CannonInstrDelay       = $6BFA   ;Number of frames to delay between parsing instructions.
CannonInstrID          = $6BFB

;-------------------------------------[ Intro sprite defines ]---------------------------------------

; 40 slots of 4 bytes each ($6E00-$6E9F)
IntroStarSprite        = $6E00   ;RAM used for storing intro star sprite data.

; 8 slots of 16 bytes each ($6EA0-$6F1F)
;Intro sprite 0 and sparkle sprite.
IntroSprYCoord         = $6EA0   ;Loaded into byte 0 of sprite RAM(Y position).
IntroSprPattTbl        = $6EA1   ;Loaded into byte 1 of sprite RAM(Pattern table index).
IntroSprCntrl          = $6EA2   ;Loaded into byte 2 of sprite RAM(Control byte).
IntroSprXCoord         = $6EA3   ;Loaded into byte 3 of sprite RAM(X position).
IntroSprIndex          = $6EA4   ;Index to next sparkle sprite data byte.
IntroSprNextDelay      = $6EA5   ;Decrements each frame. When 0, load new sparkle sprite data.
SparkleSprYChange      = $6EA6   ;Sparkle sprite y coordinate change.
IntroSprXChange        = $6EA6   ;Intro sprite x total movement distance.
SparkleSprXChange      = $6EA7   ;Sparkle sprite x coordinate change.
IntroSprYChange        = $6EA7   ;Intro sprite y total movement distance.
IntroSprChangeDelay    = $6EA8   ;decrements each frame from #$20. At 0, change sparkle sprite.
IntroSprByteType       = $6EA9   ;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
                                   ;bits for x coord change. if #$00, next data byte contains-->
                                   ;4 bits for x coord change and 4 bits for y coord change.
IntroSprComplete       = $6EAA   ;#$01=sprite has completed its task, #$00 if not complete.
IntroSprSpareB         = $6EAB   ;Not used.
IntroSprXRun           = $6EAC   ;x displacement of sprite movement(run).
IntroSprYRise          = $6EAD   ;y displacement of sprite movement(rise).
IntroSprXDir           = $6EAE   ;MSB set=decrease sprite x pos, else increase sprite x pos.
IntroSprYDir           = $6EAF   ;MSB set=decrease sprite y pos, else increase sprite y pos.

;----------------------------------------------------------------------------------------------------

WorldMapRAM            = $7000   ;Thru $73FF. The map is 1Kb in size (1024 bytes).

MetroidRepelSpeed      = $77F0   ;$77F0 for negative, $77F1 for positive
MetroidAccel           = $77F2   ;$77F2-$77F3 for red metroid, $77F4-$77F5 for green metroid
MetroidMaxSpeed        = $77F6   ;$77F6 for red metroid, $77F7 for green metroid
MetroidLatch0400       = $77F8   ;bits 0-3 is #$0 to #$C, frame counter from touching to fully latched on.
MetroidLatch0410       = $77F9     ;bits 4-6 is #$0 to #$5, count how many bomb hits (5 for separation).
MetroidLatch0420       = $77FA     ;bit 7 is sign of x speed
MetroidLatch0430       = $77FB
MetroidLatch0440       = $77FC
MetroidLatch0450       = $77FD

SamusData              = $77FE   ;Thru $782D. Samus saved game data (not used).

;------------------------------------------[ Misc. defines ]-----------------------------------------

modeTitle              = 1

;Special item types.
it_Squeept             = $1
it_PowerUp             = $2
it_Mellow              = $3
it_Elevator            = $4
it_Cannon              = $5   ;High nibble is CannonInstrListID
it_MotherBrain         = $6
it_Zebetite            = $7   ;High nibble is Zebetite slot ID
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

;unique items IIIIII
ui_BOMBS               = %000000 << 10
ui_HIGHJUMP            = %000001 << 10
ui_LONGBEAM            = %000010 << 10 ;(Not considered a unique item).
ui_SCREWATTACK         = %000011 << 10
ui_MARUMARI            = %000100 << 10
ui_VARIA               = %000101 << 10
ui_WAVEBEAM            = %000110 << 10 ;(Not considered a unique item).
ui_ICEBEAM             = %000111 << 10 ;(Not considered a unique item).
ui_ENERGYTANK          = %001000 << 10
ui_MISSILES            = %001001 << 10
ui_MISSILEDOOR         = %001010 << 10
;ui_BOMBS               = %001100 << 10 ; this doesnt seem to be correct
ui_MOTHERBRAIN         = %001110 << 10
ui_ZEBETITE1           = %001111 << 10
ui_ZEBETITE2           = %010000 << 10
ui_ZEBETITE3           = %010001 << 10
ui_ZEBETITE4           = %010010 << 10
ui_ZEBETITE5           = %010011 << 10

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
wa_RegularBeam         = $01
wa_WaveBeam            = $02
wa_IceBeam             = $03
wa_BulletExplode       = $04
wa_Unknown7            = $07
wa_LayBomb             = $08
wa_BombCount           = $09
wa_BombExplode         = $0A
wa_Missile             = $0B
wa_ScrewAttack         = $81

;Enemy Status
enemyStatus_NoEnemy    = 0
enemyStatus_Resting    = 1
enemyStatus_Active     = 2
enemyStatus_Explode    = 3
enemyStatus_Frozen     = 4
enemyStatus_Pickup     = 5
enemyStatus_Hurt       = 6
; greater than 6 is the same as no enemy

