
;-------------------------------------------[ Structs ]----------------------------------------------

.struct SamusStat
    TankCount          db
    SamusGear          db
    byte2              db
    byte3              db
    byte4              db
    byte5              db
    SamusAge           ds 4      ;In-game time
    GameOverCount      dw
    byteC              db
    byteD              db
    byteE              db
    byteF              db
.endst

;-------------------------------------------[ Defines ]----------------------------------------------

CodePtr                = $0C     ;Points to address to jump to when choosing-->
; CodePtr+1              = $0D     ;a routine from a list of routine addresses.


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

SpriteLoadPending      = $50

SpritePagePos          = $55     ;Index into sprite RAM used to load object sprite data.

IntroMusicRestart      = $63

HealthChange           = $68     ;Amount to add/subtract from Health.
; HealthChange+1         = $69

MotherBrainStatus      = $98

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

SpriteRAM              = $0200   ;$0200 thru $02FF

;-----------------------------------------[ Object RAM ]---------------------------------------------

; 16 slots of 16 bytes each ($0300-$03FF)
; slot 0 to 1 is for samus
; slot 2 is for elevator
; slot 4 is for drawing power-ups and skree projectiles
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
SamusIsHit             = $030A   ;Samus hit by enemy.
                                   ;$20: hit by bomb
                                   ;$30: hit by enemy
                                   ; +$08: hit towards the right
                                   ;$44: touch frozen enemy
                                   ; +$01: touch enemy from the right
                                   ; +$02: touch enemy from the bottom
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
ElevatorAnimFrame      = $0323   ;*2 = Index into FramePtrTable for current animation.
ElevatorAnimResetIndex = $0325   ;Restart index-1 when AnimIndex finished with last frame.
ElevatorAnimIndex      = $0326   ;Current index into ObjectAnimIndexTbl.
ElevatorUnused0328     = $0328   ;when starting to move, #$00 is written, but this is never read
ElevatorType           = $032F   ;bit 7 is up(1) or down(0)
                                   ;low nybble is which elevator it is
                                   ;#$0=Brinstar/Brinstar
                                   ;#$1=Brinstar/Norfair
                                   ;#$2=Brinstar/Kraid
                                   ;#$3=Brinstar/Tourian
                                   ;#$4=Norfair/Ridley
                                   ;elevator type #$8F is for the ending elevator

;Power-up item temp RAM for drawing.
PowerUpDrawAnimFrame   = $0343   ;*2 = Index into FramePtrTable for current animation.
PowerUpDrawHi          = $034C   ;Name table power up item is located on.
PowerUpDrawY           = $034D   ;Room Y coord of power up item.
PowerUpDrawX           = $034E   ;Room x coord of power up item.

;Statues and bridge RAM
StatueStatus           = $0360
StatueAnimFrame        = $0363
KraidStatueRaiseState  = $0364   ;#$01=Not Raised, #$02=Raising, bit7=Raised.
RidleyStatueRaiseState = $0365
KraidStatueIsHit       = $0366   ;#$00=not hit, #$01=hit
RidleyStatueIsHit      = $0367   ;#$00=not hit, #$01=hit
StatueHi               = $036C
StatueY                = $036D   ;Set to either Kraid's Y or Ridley's Y when drawing a statue.
StatueX                = $036E   ;Set to either Kraid's X or Ridley's X when drawing a statue.
KraidStatueY           = $036F
RidleyStatueY          = $0370

;Door RAM
DoorStatus             = $0300
DoorAnimResetIndex     = $0305
DoorAnimIndex          = $0306
DoorType               = $0307   ;#$00=red door, #$01=blue door, #$02=10-missile door
                                   ;#$03=blue door that changes the music
DoorIsHit              = $030A   ; bit 2 indicates if the door was hit or not
DoorOnScreen           = $030B   ;1=Object on screen, 0=Object beyond screen boundaries.
DoorHi                 = $030C
DoorX                  = $030E
DoorHitPoints          = $030F   ;used as re-close delay for blue doors


;Samus projectile RAM
ProjectileStatus       = $0300
ProjectileRadY         = $0301   ;Distance in pixels from object center to top or bottom.
ProjectileRadX         = $0302   ;Distance in pixels from object center to left or right side.
ProjectileAnimFrame    = $0303   ;*2 = Index into FramePtrTable for current animation.
ProjectileAnimDelay    = $0304   ;Number of frames to delay between animation frames.
ProjectileAnimResetIndex = $0305   ;Restart index-1 when AnimIndex finished with last frame.
ProjectileAnimIndex    = $0306   ;Current index into ObjectAnimIndexTbl.
ProjectileIsHit        = $030A
ProjectileHi           = $030C   ;0=Object on nametable 0, 1=Object on nametable 3.
ProjectileDieDelay     = $030F   ;delay until short beam projectile dies

;----------------------------------------------------------------------------------------------------

TempX                  = $0414
TempY                  = $0415

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


.enum $B410 export

;$B410-$B41F
CurSamusStat           instanceof SamusStat

.ende


