
;-------------------------------------------[ Structs ]----------------------------------------------

.struct OAMSprite
    y                      db
    tileID                 db
    attrib                 db
    x                      db
.endst

.struct SamusStat
    TankCount          db
    SamusGear          db
    MissileCount       db
    MaxMissiles        db
    byte4              db
    byte5              db
    SamusAge           ds 4      ;In-game time
    GameOverCount      dw
    byteC              db
    EndingType         db
    byteE              db
    SaveSlot           db
.endst

.struct SkreeProjectile
    dieDelay               db   ;Delay until projectile dies.
    y                      db
    x                      db
    hi                     db
.endst

.struct En
    y                      db   ;Enemy y position in room.(not actual screen position).
    x                      db   ;Enemy x position in room.(not actual screen position).
    speedY                 db   ; unknown - y speed?
    speedX                 db   ; unknown - x speed?
    isHit                  db   ;bit2: touching Samus
                                  ;bit1 set: touch Samus from the top
                                  ;bit0 set: touch Samus from the left
                                  ;bit5: hit by samus weapon (projectile or screw attack)
                                  ;bit4 set: hit by samus weapon from the top
                                  ;bit3 set: hit by samus weapon from the left
    data05                 db   ;bit0: 0=facing right, 1=facing left
                                  ;bit1: IsObjectVisible
                                  ;bit2: 0=facing down, 1=facing up (can desync with sign of y speed for multiviolas)
                                  ;bit3: does the enemy become active if it's resting and EnDelay becomes zero. 0=no, 1=yes
                                  ;bit4: is samus close enough to the enemy (EnemyDistanceToSamusThreshold). 0=no, 1=yes
                                  ;  depending on the threshold, bit 3 may be used instead, which will allow -->
                                  ;  the enemy to become active when samus gets close.
                                  ;bit5: when active, this bit being set will trigger a resting period
                                  ;bit6: toggles every frame for some enemy routines to run at 30FPS
                                  ;bit7: when this is set, some routines use bit2 as facing direction instead of bit0
    chunkyExplosionTimer   .db  ;Counts such things as explosion time.
    movementInstrIndex     .db
    speedSubPixelY         db   ;- y counter?
    speedSubPixelX         db   ; unknown - x counter
    movementIndex          db   ;Index into the EnemyMovement table of that enemy.
    delay                  db   ;Delay counter between enemy actions.
    data0A                 db   ; unknown -- For crawlers, orientation
                                  ; (#$00 = forwards on floor, #$01 = moving down a wall, #$02 = backwards on ceiling, #$03 = moving up an opposite wall)
                                  ; For enProjectiles, it's the EnProjectileMovement id
    health                 db   ;Current health of enemy.
    prevStatus             db   ;Enemy status before being hurt. bit 7 and bit 6 is EnSpecialAttribs.
    data0D                 db   ;Resting: force speed towards samus delay
                                  ;Frozen: frozen timer (* 8)
                                  ;Pickup: die delay (* 4)
    weaponAction           db   ; unknown - What weapon action is currently hitting the enemy?
    specialAttribs         db   ;Bit 7 set=tough version of enemy, bit 6 set=mini boss.
                                  ;When enemy is hurt, this is used as hitstun delay
.endst

.struct EnExtra
    status                 db   ;Keeps track of enemy statuses. #$00=Enemy slot not in use,-->
                                  ;#$04=Enemy frozen.
    radiusY                db   ;Distance in pixels from middle of enemy to top or botom.
    radiusX                db   ;Distance in pixels from middle of enemy to left or right.
    animFrame              db   ;Index into enemy animation frame data.
    animDelay              db   ;Number of frames to delay between animation frames.
    resetAnimIndex         db   ;Index to beginning of animation sequence.
    animIndex              db   ;Index to current animation.
    hi                     db   ;#$00=Enemy on name table 0, #$01=Enemy on name table 3.
    subPixelY              db   ; Unknown
    subPixelX              db   ; Unknown
    accelY                 db   ; Unknown
    accelX                 db   ; Unknown
    data1C                 db   ; Unused
    jumpDsplcmnt           db   ;Number of pixels vertically/horizontally displaced from jump point; skree blow up delay
    type                   db   ;Enemy type used as index into enemy data tables.
    data1F                 db   ;For EnemyFlipAfterDisplacement:
                                  ;#$00:         displacement = abs(jumpDsplcmnt)
                                  ;#$40:         displacement = jumpDsplcmnt
                                  ;#$80 or #$C0: displacement = -jumpDsplcmnt
                                ;For EnemyIfMoveFailed:
                                  ;#$00:         bounce
                                  ;#$40:         land on floor/right wall
                                  ;#$80 or #$C0: land on ceiling/left wall
.endst

.struct EnExplosion
    y                      db   ;Enemy y position in room.(not actual screen position).
    x                      db   ;Enemy x position in room.(not actual screen position).
    unused                 ds 3
    data05                 db   ;bit1: IsObjectVisible
    delay                  db   ;delay until the current singular explosion ends
    quantity               db   ;quantity of explosions to display
.endst

.struct EnExplosionExtra
    status                 db
    radiusY                db   ;Distance in pixels from middle of enemy to top or botom.
    radiusX                db   ;Distance in pixels from middle of enemy to left or right.
    animFrame              db   ;Index into enemy animation frame data.
    animDelay              db   ;Number of frames to delay between animation frames.
    resetAnimIndex         db   ;Index to beginning of animation sequence.
    animIndex              db   ;Index to current animation.
    hi                     db   ;#$00=Enemy on name table 0, #$01=Enemy on name table 3.
.endst

.struct Object
    status                 db   ;$0300   ;Status of object. 0=object slot not in use.
    radiusY                db   ;$0301   ;Distance in pixels from object center to top or bottom.
    radiusX                db   ;$0302   ;Distance in pixels from object center to left or right side.
    animFrame              db   ;$0303   ;*2 = Index into FramePtrTable for current animation.
    animDelay              db   ;$0304   ;Number of frames to delay between animation frames.
    animResetIndex         db   ;$0305   ;Restart index-1 when AnimIndex finished with last frame.
    animIndex              db   ;$0306   ;Current index into ObjectAnimIndexTbl.
    data07                 db   ;
    speedY                 db   ;$0308   ;MSB set=moving up(#$FA max), MSB clear=moving down(#$05 max).
    speedX                 db   ;$0309   ;MSB set=moving lft(#$FE max), MSB clear=moving rt(#$01 max).
    isHit                  db   ;$030A   ;Samus hit by enemy.
                                       ;$20: hit by bomb
                                       ;$30: hit by enemy
                                       ; +$08: hit towards the right
                                       ;$44: touch solid entity (frozen enemy or elevator, is $00 if standing on it)
                                       ; +$01: touch solid entity from the right
                                       ; +$02: touch solid entity from the bottom
    onScreen               db   ;$030B   ;1=Object on screen, 0=Object beyond screen boundaries.
    hi                     db   ;$030C   ;0=Object on nametable 0, 1=Object on nametable 3.
    y                      db   ;$030D   ;Object y position in room(not actual screen position).
    x                      db   ;$030E   ;Object x position in room(not actual screen position).
    data0F                 db   ;
.endst

;-------------------------------------------[ Defines ]----------------------------------------------

; LoadPositionFromTemp/StorePositionToTemp/ApplySpeedToPosition
Temp02_ScrollDir       = $02     ; #$00=vertical room, #$02=horizontal room
Temp04_SpeedY          = $04
Temp05_SpeedX          = $05
Temp08_PositionY       = $08
Temp09_PositionX       = $09
Temp0B_PositionHi      = $0B


JumpEngineRoutinePtr   = $0C     ;Points to address to jump to when choosing-->
; JumpEngineRoutinePtr+1 = $0D     ;a routine from a list of routine addresses.


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

MainRoutine            = $1E
TitleRoutine           = $1F
NextRoutine            = $20

TimerDelay             = $23     ;Count down from 9 to 0. Decremented every frame.
Timer1                 = $24     ;Decremented every frame after set.
Timer2                 = $25     ;Decremented every frame after set.
Timer3                 = $26     ;Decremented every 10 frames after set.
FrameCount             = $27
RandomNumber1          = $28     ;Random numbers used-->
RandomNumber2          = $29     ;throughout the game.

Joy2Port               = $2B     ;Controller port from which to read Joypad 2 (0=Joypad 1 port, 1=Joypad 2 port)
GamePaused             = $2B

ScrollDir              = $43     ;0=Up, 1=Down, 2=Left, 3=Right.

PageIndex              = $45     ;Index to object data.
                                   ;#$D0, #$E0, #$F0 = projectile indices(including bombs).

SpriteLoadPending      = $50     ;Set to #$00 after sprite RAM load complete.

SpritePagePos          = $55     ;Index into sprite RAM used to load object sprite data.

UnusedAttractModeJoyStatus = $55     ;Joypad status of current instruction played.
UnusedAttractModeDelay = $56     ;Delay until next instruction to play.
UnusedAttractModeInstrID = $57     ; index into UnusedAttractMode_InputList
UnusedAttractModeIsRecording = $58     ;Are we recording a movie file for attract mode? (0=no, non-0=yes)
UnusedAttractModeIsPlaying = $59     ;Are we playing back a movie file for attract mode? (0=no, non-0=yes)


IntroMusicRestart      = $63


ObjectCntrl            = $65     ;Controls object properties such as mirroring and color-->
                                       ;bits. Bit 4 controls object horizontal mirroring.
                                       ;If bit 7 set, these attributes apply:
                                       ;bit 5 is priority
                                       ;bit 0 and bit 1 is for the color palette


HealthChange           = $68     ;Amount to add/subtract from Health.
; HealthChange+1         = $69


KraidLintCounter       = $79     ;Used to determine when to fire Kraid's lint. Accidentally used by Ridley too.
KraidNailCounter       = $7A     ;Used to determine when to fire Kraid's nail.
RidleyFireballCounter  = $7B     ;Used to determine when to fire Ridley's fireball.

EnemyStatusPreAI       = $7C     ;set to enemy status before enemy ai routine is run


SpawnEnProjectile_AnimIndex = $7E     ;right facing anim index for enemy that shoots the projectile
; SpawnEnProjectile_AnimIndex+1 = $7F     ;left facing anim index for enemy that shoots the projectile
SpawnEnProjectile_AnimTableIndex = $80 ;index into EnProjectileRisingAnimIndexTable
EnemyFlipAfterDisplacementAnimIndex = $80 ;right facing anim index for enemy using EnemyFlipAfterDisplacement routine
; EnemyFlipAfterDisplacementAnimIndex+1 = $81 ;left facing anim index for enemy using EnemyFlipAfterDisplacement routine
SpawnEnProjectile_ExpectedStatus = $82 ;expected status for the enemy that shoots an enProjectile, won't shoot if status doesn't match
                                                ;this functionnality is not used: the expected status is always the current status
SpawnEnProjectile_EnData0A = $83


MetroidOnSamus         = $8D     ;#$01=Metroid on Samus, #$00=Metroid not on Samus.


MotherBrainStatus      = $98

.enum $A0 export

; 4 slots of 4 bytes each ($A0-$AF)
SkreeProjectiles       instanceof SkreeProjectile 4 startfrom 0

.ende

FDSBase                = $EE     ;Low byte of base address for FDS music data
; FDSBase+1              = $EF     ;High byte of base address for FDS music data

FDS_CTRL_ZP            = $FB
ScrollY                = $FC     ;Y value loaded into scroll register.
ScrollX                = $FD     ;X value loaded into scroll register.
PPUMASK_ZP             = $FE     ;Data byte to be loaded into PPU control register 1.
PPUCTRL_ZP             = $FF     ;Data byte to be loaded into PPU control register 0.

;--------------------------------------------[ Onepage ]--------------------------------------------

Health                 = $0106   ;Lower health digit in upper 4 bits.
; Health+1               = $0107   ;Upper health digit in lower 4 bits-->
                                   ;# of full tanks in upper 4 bits.

EndTimer               = $010A   ;Lower byte of end game escape timer.
; EndTimer+1             = $010B   ;Upper byte of end game escape timer.

MissileToggle          = $010E   ;0=fire bullets, 1=fire missiles.

;-----------------------------------------[ Sprite RAM ]---------------------------------------------

.enum $0200 export

;$0200 thru $02FF
SpriteRAM              instanceof OAMSprite $40 startfrom 0

.ende

;-----------------------------------------[ Object RAM ]---------------------------------------------

; 16 slots of 16 bytes each ($0300-$03FF)
; slot 0 to 1 is for samus
; slot 2 is for elevator
; slot 4 is for drawing power-ups and skree projectiles
; slot 6 to 7 is for tourian bridge
; slot 8 to B is for doors
; slot D to F is for samus weapon projectiles

.enum $0300 export

Objects              .instanceof Object $10 startfrom 0
Samus                instanceof Object
Object0310           instanceof Object
Elevator             instanceof Object
Object0330           instanceof Object
PowerUpDraw          instanceof Object
Object0350           instanceof Object
Statue               instanceof Object
Object0370           instanceof Object
Doors                instanceof Object 4 startfrom 0
Object03C0           instanceof Object
SamusProjectiles     instanceof Object 3 startfrom 0

.ende


;Samus RAM. ($0300-$0316)
SamusOnElevator = Samus.data07 ;$0307   ;0=Samus not on elevator, 1=Samus on elevator.
;Samus.isHit            db   ;$030A   ;Samus hit by enemy.
                                       ;$20: hit by bomb
                                       ;$30: hit by enemy
                                       ; +$08: hit towards the right
                                       ;$44: touch solid entity (frozen enemy or elevator, is $00 if standing on it)
                                       ; +$01: touch solid entity from the right
                                       ; +$02: touch solid entity from the bottom
SamusJumpDsplcmnt = Samus.data0F ;$030F   ;Number of pixels vertically displaced from jump point.

.enum $0310 export

SamusSubPixelY         db   ;$0310   ;Vertical movement counter. Exponential change in speed.
SamusSubPixelX         db   ;$0311   ;Horizontal movement counter. Exponential change in speed.
SamusSpeedSubPixelY    db   ;$0312   ;Vertical movement counter. Linear change in speed.
SamusSpeedSubPixelX    db   ;$0313   ;Horizontal movement counter. Linear change in speed.
SamusAccelY            db   ;$0314   ;Value used in calculating vertical acceleration on Samus.
SamusAccelX            db   ;$0315   ;Value used in calculating horizontal acceleration on Samus.
SamusHorzSpeedMax      db   ;$0316   ;Used to calc maximum horizontal speed Samus can reach.

.ende


;Elevator RAM. ($0320-$032F)
;Elevator.speedY        db   ;$0328   ;when starting to move, #$00 is written, but this is never read
ElevatorType = Elevator.data0F       ;bit 7 is up(1) or down(0)
                                       ;low nybble is which elevator it is
                                       ;#$0=Brinstar/Brinstar
                                       ;#$1=Brinstar/Norfair
                                       ;#$2=Brinstar/Kraid
                                       ;#$3=Brinstar/Tourian
                                       ;#$4=Norfair/Ridley
                                       ;elevator type #$8F is for the ending elevator


;Temp RAM for drawing power-up item and skree projectile. ($0340-$034F)
; just a regular object


;Statues and bridge RAM ($0360-$0370)
KraidStatueRaiseState = Statue.animDelay   ;#$01=Not Raised, #$02=Raising, bit7=Raised.
RidleyStatueRaiseState = Statue.animResetIndex
KraidStatueIsHit = Statue.animIndex   ;#$00=not hit, #$01=hit
RidleyStatueIsHit = Statue.data07   ;#$00=not hit, #$01=hit
;Statue.y                = $036D   ;Set to either Kraid's Y or Ridley's Y when drawing a statue.
;Statue.x                = $036E   ;Set to either Kraid's X or Ridley's X when drawing a statue.
KraidStatueY = Statue.data0F

.enum $0370 export

RidleyStatueY          db   ;$0370

.ende


;Door RAM
DoorType = Objects.0.data07          ;#$00=red door, #$01=blue door, #$02=10-missile door
                                       ;#$03=blue door that changes the music
;Door.isHit             db   ;$030A   ; bit 2 indicates if the door was hit or not
DoorHitPoints = Objects.0.data0F     ;used as re-close delay for blue doors


;Samus weapon projectiles RAM
SamusProjectileDieDelay = Objects.0.data0F   ;delay until short beam projectile dies

;------------------------------------------[ Enemy RAM ]---------------------------------------------

.enum $0400 export

; 16 slots of 16 bytes each ($0400-$04FF)
; slot 0 to 5 is for normal enemies
; slot 6 to B is for enemy projectiles
; slot C to D is for enemy explosions (4 slots of 8 bytes each ($04C0-$04DF))
; slot E is for mother brain
; slot F is for mellow handler enemy

Ens                    instanceof En $6 startfrom 0
EnProjectiles          instanceof En $6 startfrom 0
EnExplosions           instanceof EnExplosion $4 startfrom 0
EnMotherBrain          instanceof En
EnMellowHandler        instanceof En

.ende

;----------------------------------------------------------------------------------------------------

TempX                  = $0414
TempY                  = $0415

;----------------------------------------------------------------------------------------------------

Sound0680              = $0680
SQ1SFXFlag             = $0681
FDSSFXFlag             = $0682
MusicFDSInitFlag       = $0684
MusicInitFlag          = $0685

ScrewOrBallSFXFlag     = $0686   ;Controls which SFX plays for FDSSFXFlag bit 1. 0=Screw Attack, 1=Morph

Sound0688              = $0688
SQ1ContSFX             = $0689
FDSContSFX             = $068A
Sound068C              = $068C   ; unused
CurrentMusic           = $068D

;----------------------------------------------------------------------------------------------------

PPUStrIndex            = $07A0   ;# of bytes of data in PPUDataString. #$4F bytes max.

;$07A1 thru $07F0 contain a byte string of data to be written the the PPU. 
;The first two bytes in the string are the address of the starting point in the PPU to write -->
;the data (high byte, low byte).
;The third byte is a configuration byte.
; If the MSB of this byte is set, the PPU is incremented by 32 after each byte write (vertical write).
; If the MSB is cleared, the PPU is incremented by 1 after each write (horizontal write).
; If bit 6 is set, the next data byte is repeated multiple times during successive PPU writes.
; The number of times the next byte is repeated is based on bits 0-5 of the configuration byte.
; Those bytes are a repetition counter.
;Any following bytes are the actual data bytes to be written to the PPU.
;#$00 separates the data chunks.

PPUDataString          = $07A1   ;Thru $07F0. String of data bytes to be written to PPU.

;----------------------------------------------------------------------------------------------------

RoomRAMA               = $6000   ;Thru $63FF. Used to load room before it is put into the PPU.
RoomRAMB               = $6400   ;Thru $67FF. Used to load room before it is put into the PPU.

;----------------------------------------------------------------------------------------------------

.enum $B410 export

;$B410-$B41F
CurSamusStat           instanceof SamusStat

.ende

.enum $B460 export

; 16 slots of 16 bytes each ($B460-$B55F)
EnsExtra               instanceof EnExtra 6 startfrom 0
EnProjectilesExtra     instanceof EnExtra 6 startfrom 0
EnExplosionsExtra      instanceof EnExplosionExtra 4 startfrom 0
EnMotherBrainExtra     instanceof EnExtra
EnMellowHandlerExtra   instanceof EnExtra

.ende



.enum $BA11 export

MetroidRepelSpeed      dw   ;$BA11 for negative, $BA12 for positive
MetroidAccel           ds 4 ;$BA13-$BA14 for red metroid, $BA15-$BA16 for green metroid
MetroidMaxSpeed        dw   ;$BA17 for red metroid, $BA18 for green metroid
MetroidLatch0400       db   ;$BA19   ;bits 0-3 is #$0 to #$C, frame counter from touching to fully latched on.
MetroidLatch0410       db   ;$BA1A   ;bits 4-6 is #$0 to #$5, count how many bomb hits (5 for separation).
MetroidLatch0420       db   ;$BA1B   ;bit 7 is sign of x speed
MetroidLatch0430       db   ;$BA1C
MetroidLatch0440       db   ;$BA1D
MetroidLatch0450       db   ;$BA1E

.ende

