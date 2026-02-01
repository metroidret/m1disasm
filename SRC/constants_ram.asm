;-------------------------------------------[ Structs ]----------------------------------------------

.struct OAMSprite
    y                      db
    tileID                 db
    attrib                 db
    x                      db
.endst

.struct RinkaSpawner
    status                 db   ;#$00=use even indices to RinkaSpawnPosTbl,-->
                                  ;#$01=use odd indices to RinkaSpawnPosTbl,-->
                                  ;#$FF=inactive
    hi                     db
    posIndex               db
.endst

.struct SkreeProjectile
    dieDelay               db   ;Delay until projectile dies.
    y                      db
    x                      db
    hi                     db
.endst

.struct Mellow
    status                 db
    y                      db
    x                      db
    hi                     db
    attackState            db
    attackTimer            db
    isHit                  db
    unused                 db
.endst

.struct TileBlast
    routine                db
    spare01                dw
    animFrame              db   ;VRAMString index
    animDelay              db
    spare05                db
    animIndex              db
    delay                  db
    roomRAMPtr             dw
    type                   db
    spare0B                ds 5
.endst

.struct Struct0700 ; unused
    data00                 db
    data01                 db
    data02                 db
    data03                 db
    data04                 db
    data05                 db
.endst

.struct PipeBugHole
    status                 db   ;bit0-3: spawned enemy type (often $7, pipe bug)
                                  ;bit7: strong variant
                                  ;#$FF=no hole
    enemySlot              db   ; enemy slot to spawn pipe bug in
    y                      db   ; y position of hole
    x                      db   ; x position of hole
    hi                     db   ; nametable position of hole
    unused                 ds 3
.endst

.struct PowerUp
    type                   db   ;Holds the byte describing what power-up is on name table.
    y                      db   ;Y coordinate of the power-up.
    x                      db   ;X coordiante of the power-up
    hi                     db   ;#$00 if on name table 0, #$01 if on name table 3.
    unused                 ds 3
    data07                 db   ;stored to A before ObjDrawFrame immediately overwrites it
.endst

.struct Zebetite
    status                 db
    roomRAMPtr             dw   ;Pointer to top-left tile of Zebetite in the nametable.
    qtyHits                db   ;Number of missile hits dealt to Zebetite. Dies at 8 hits.
    healingDelay           db   ;Heals 1 hit when counts down from #$40 to #$00.
    isHit                  db   ;#$01 if zebetite got hit by a missile this frame, else #$00
    unused                 dw
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

.struct Cannon
    status                 db
    y                      db
    x                      db
    hi                     db
    instrListID            db
    angle                  db
    instrDelay             db
    instrID                db
.endst

.struct IntroSpr
    y                      db   ;Loaded into byte 0 of sprite RAM(Y position).
    tileID                 db   ;Loaded into byte 1 of sprite RAM(Pattern table index).
    attrib                 db   ;Loaded into byte 2 of sprite RAM(Control byte).
    x                      db   ;Loaded into byte 3 of sprite RAM(X position).
    index                  db   ;Index to next sparkle sprite data byte.
    nextDelay              db   ;Decrements each frame. When 0, load new sparkle sprite data.
    sparkleYChange         .db  ;Sparkle sprite y coordinate change.
    crossMissileXChange    db   ;Cross missile sprite x total movement distance.
    sparkleXChange         .db  ;Sparkle sprite x coordinate change.
    crossMissileYChange    db   ;Cross missile sprite y total movement distance.
    changeDelay            db   ;decrements each frame from #$20. At 0, change sparkle sprite.
    byteType               db   ;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
                                  ;bits for x coord change. if #$00, next data byte contains-->
                                  ;4 bits for x coord change and 4 bits for y coord change.
    complete               db   ;#$01=sprite has completed its task, #$00 if not complete.
    spareB                 db   ;Not used.
    speedX                 db   ;x speed of sprite movement (in 16ths of pixel per frame).
    speedY                 db   ;y speed of sprite movement (in 16ths of pixel per frame).
    dirX                   db   ;MSB set=decrease sprite x pos, else increase sprite x pos.
    dirY                   db   ;MSB set=decrease sprite y pos, else increase sprite y pos.
.endst

.struct AreaPointersStruct
    RoomPtrTable           dw   ;$3B     ;Start of room pointer table.
    StructPtrTable         dw   ;$3D     ;Start of structure pointer table.
    MetatileDefs           dw   ;$3F     ;Pointer into metatile definitions.
    EnFramePtrTable1       dw   ;$41     ;Pointer into address table to find enemy animations.
    EnFramePtrTable2       dw   ;$43     ;Same as above except in a second table because there are-->
                                           ;too many entries to fit into one table.
    EnPlacePtrTable        dw   ;$45     ;Pointer into enemy frame placement table.
    EnAnimTable            dw   ;$47     ;Start of EnemyAnimIndexTbl.
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
;--------------------------------------------[ Zeropage ]--------------------------------------------

; Temps ($00-$0B and $0E-$11)

; (BUG! NMI routine overwrites Temp00 and Temp01 without restoring their value.
;  Routines that can be interrupted by NMI (like UpdateAttrib) will lose the values in those variables.)

; entity to entity collision detection
Temp00_Diff            = $00
Temp01_DiffHi          = $01
Temp03_ScrollDir       = $03     ; #$00=vertical room, #$02=horizontal room
Temp04_YSlotRadY       = $04
Temp05_YSlotRadX       = $05
Temp06_YSlotPositionY  = $06
Temp07_XSlotPositionY  = $07
Temp08_YSlotPositionX  = $08
Temp09_XSlotPositionX  = $09
Temp0A_YSlotPositionHi = $0A
Temp0B_XSlotPositionHi = $0B
Temp0F_DistX           = $0F
Temp10_DistHi          = $10     ;bit7-3 is clear, bit 2 is set
                                   ;bit 1 is dist hi y (%0=y slot is above x slot, %1=y slot is below x slot)
                                   ;bit 0 is dist hi x (%0=y slot is left of x slot, %1=y slot is right of x slot)
Temp11_DistY           = $11

; LoadPositionFromTemp/StorePositionToTemp/ApplySpeedToPosition
Temp02_ScrollDir       = $02     ; #$00=vertical room, #$02=horizontal room
Temp04_SpeedY          = $04
Temp05_SpeedX          = $05
Temp08_PositionY       = $08
Temp09_PositionX       = $09
Temp0B_PositionHi      = $0B

; MakeRoomRAMPtr
Temp02_PositionY       = $02
Temp03_PositionX       = $03
Temp04_RoomRAMPtr      = $04
; Temp04_RoomRAMPtr+1    = $05
;Temp0B_PositionHi      = $0B

; IsObjectVisible
Temp06_PositionHi      = $06
Temp08_RadiusY         = $08
Temp09_RadiusX         = $09
Temp0A_PositionY       = $0A
Temp0B_PositionX       = $0B

; WriteSpriteRAM
Temp00_FramePtr        = $00
; Temp00_FramePtr+1      = $01
Temp02_PlacePtr        = $02
; Temp02_PlacePtr+1      = $03
Temp04_MetaspriteFlipFlags = $04 ;Bit 7=vflip, bit 6=hflip
Temp05_Cntrl           = $05
Temp0E_ScreenX         = $0E     ;X position of object relative to screen.
Temp0F_PlaceIndex      = $0F
Temp10_ScreenY         = $10     ;Y position of object relative to screen.
Temp11_FrameIndex      = $11

; unique item history
Temp06_ItemID          = $06
; Temp06_ItemID+1        = $07
Temp06_ItemY           = $06
Temp07_ItemX           = $07
Temp08_ItemHi          = $08
Temp09_ItemType        = $09

; BG collision
Temp00_CollisionPointYMod8 = $00
Temp01_CollisionPointXMod8 = $01
Temp02_DistToCenterY   = $02
Temp03_DistToCenterX   = $03
Temp04_NumBlocksToCheck = $04
Temp06_NextPointYOffset = $06    ; either 0 or 8 when checking vertically and horizontally respectively
Temp07_NextPointXOffset = $07    ; either 8 or 0 when checking vertically and horizontally respectively

; UpdateNameTable
Temp00_RoomRAMPtr      = $00
; Temp00_RoomRAMPtr+1    = $01
Temp02_PPURAMPtr       = $02
; Temp02_PPURAMPtr+1     = $03
Temp04_ControlBits     = $04
Temp05_BytesCounter    = $05
Temp06_Zero            = $06

; DrawMetatile
;Temp00_RoomRAMPtr      = $00
; Temp00_RoomRAMPtr+1    = $01
Temp02_AttribPtr       = $02
; Temp03_AttribPtr+1     = $03
Temp0E_MetatileCounter = $0E
Temp10_StructIndex     = $10
Temp11_MetatileIndex   = $11

; UpdateCrossMissileCoords@CalcDisplacement
Temp00_FrameCountMask  = $00
Temp04_Displacement    = $04

; ProcessUniqueItems/LoadUniqueItems
Temp00_ItemData        = $00
; Temp00_ItemData+1      = $01
Temp02_ItemDataIndex5MSB = $02
Temp03_NumberOfUniqueItems = $03
Temp04_UniqueItemIndex = $04
Temp05_PasswordByteIndex = $05
Temp06_PasswordBitIndex = $06
Temp07_ItemDataIndexMax = $07
Temp08_PasswordByte    = $08
Temp09_ItemDataIndex   = $09

; LoadTanksAndMissiles
Temp00_KraidStatueStatus = $00
Temp02_RidleyStatueStatus = $02
Temp00_EnergyTankCount = $00
Temp02_MissileTankCount = $02

; PasswordScramble/UnscramblePassword
Temp00_PasswordByte    = $00
Temp02_ScrambleCount   = $02

; PasswordScramble/UnscramblePassword
Temp00_FillValue       = $00
Temp01_NameTablePlus1  = $01

; VRAMStruct
Temp00_VRAMStructPtr   = $00
; Temp00_VRAMStructPtr+1 = $01
; bank switching
Temp00_Bank            = $00
Temp0A_BankInitPtr     = $0A
; Temp0A_BankInitPtr+1   = $0B

; GFXInfo
;Temp00_Bank            = $00
Temp01_GFXSource       = $01
; Temp01_GFXSourcePtr+1  = $02
Temp03_GFXDestination  = $03
; Temp03_GFXDestination+1 = $04
Temp05_GFXSize         = $05
; Temp05_GFXSize+1       = $06

; DrawTileBlast/VRAMString
;Temp00_RoomRAMPtr      = $00
; Temp00_RoomRAMPtr+1    = $01
Temp00_PPURAMPtr       = $00
; Temp00_PPURAMPtr+1     = $01
Temp02_VRAMStringPtr   = $02
; Temp02_VRAMStringPtr+1 = $03
Temp04_VRAMStringHeight = $04
Temp05_VRAMStringWidth = $05
Temp06_XCounter        = $06
Temp10_VRAMStringIndex = $10
Temp11_RoomRAMIndex    = $11

; UpdateTileBlast
;Temp00_RoomRAMPtr      = $00
; Temp00_RoomRAMPtr+1    = $01
Temp02_MetatileCenterY = $02
Temp03_MetatileCenterX = $03



JumpEngineRoutinePtr   = $0C     ;Points to address to jump to when choosing-->
; JumpEngineRoutinePtr+1 = $0D     ;a routine from a list of routine addresses.


.enum $12 export
;The bits of the change and status addresses represent the following joypad buttons:
;bit 7=A, bit 6=B, bit 5=SELECT, bit 4=START, bit 3=Up, bit 2=Down, bit 1=Left, bit 0=Right.

Joy1Change             db   ;$12     ;These addresses store any button changes-->
Joy2Change             db   ;$13     ;that happened since last frame(pads 1 and 2).
Joy1Status             db   ;$14     ;These two addresses store all buttons-->
Joy2Status             db   ;$15     ;currently being pressed on the two controllers.
Joy1Retrig             db   ;$16     ;These two addresses store any buttons that need-->
Joy2Retrig             db   ;$17     ;to retrigger after being held down by player.
RetrigDelay1           db   ;$18     ;These two addresses are counters that control-->
RetrigDelay2           db   ;$19     ;The retriggering of held down buttons.

NMIStatus              db   ;$1A     ;0=NMI in progress. anything else, NMI not in progress.
PPUDataPending         db   ;$1B     ;1=not PPU data pending, 1=data pending.
PaletteDataPending     db   ;$1C     ;Pending palette data. Palette # = PaletteDataPending - 1.
GameMode               db   ;$1D     ;0 = Game is playing, 1 = At title/password screen
MainRoutine            db   ;$1E     ;5 = Game paused, 3 = Game engine running
TitleRoutine           db   ;$1F     ;Stores title routine number currently running.
NextRoutine            db   ;$20     ;Stores next routine to jump to after WaitTimer expires.

SpareMem21             dw   ;$21

CurrentBank            db   ;$23     ;0 thru 7. current memory page in lower memory block.
BankSwitchPending      db   ;$24     ;Switch memory page. Page # = BankSwitchPending - 1.
MMC1CTRL_ZP            db   ;$25     ;Stores bits to be loaded into MMC1 Register 0.

SpareMem26             dw   ;$26

SwitchUpperBits        db   ;$28     ;Used to store bits 3 and 4 for MMC1 register 3.  Bits-->
                                       ;3 and 4 should always be 0 under normal conditions.

TimerDelay             db   ;$29     ;Count down from 9 to 0. Decremented every frame.
Timer1                 db   ;$2A     ;Decremented every frame after set.
Timer2                 db   ;$2B     ;Decremented every frame after set.
Timer3                 db   ;$2C     ;Decremented every 10 frames after set.

FrameCount             db   ;$2D     ;Increments every frame(overflows every 256 frames).

RandomNumber1          db   ;$2E     ;Random numbers used-->
RandomNumber2          db   ;$2F     ;throughout the game.

SpareMem30             db   ;$30     ;Written to, but never accessed.
GamePaused             db   ;$31     ;#$00=Game running, #$01=Game paused.

SpareMem32             db   ;$32

RoomPtr                dw   ;$33     ;Low byte of room pointer address.
; RoomPtr+1                    $34     ;High byte of room pointer address.

StructPtr              dw   ;$35     ;Low bute of structure pointer address.
; StructPtr+1                  $36     ;High byte of structure pointer address.

RoomRAMWorkPtr         dw   ;$37     ;Low byte of pointer to current position in room RAM.
; RoomRAMWorkPtr+1             $38     ;High byte of pointer to current position in room RAM.
                                       ;The RoomRAMWorkPtr points to the current memory address-->
                                       ;in the room RAM that is being loaded.

RoomRAMPtr             dw   ;$39     ;Low byte of pointer to room RAM (#$00).
; RoomRAMPtr+1                 $3A     ;High byte of pointer to room RAM (#$60 or #$64).
                                       ;Room RAM is a screen buffer where the objects that make-->
                                       ;up a room are loaded.  There are two room RAM memory-->
                                       ;areas and they are the exact same size as the two name-->
                                       ;tables and attribute tables in the PPU. Once the room-->
                                       ;RAM conatins a completed room in it, the entire contents-->
                                       ;of the room RAM is loaded into the PPU.

AreaPointers_RAM       instanceof AreaPointersStruct ;$3B-$48

ScrollDir              db   ;$49     ;0=Up, 1=Down, 2=Left, 3=Right.

TempScrollDir          db   ;$4A     ;Stores ScrollDir when room is initially loaded.

PageIndex              db   ;$4B     ;Index to object data.
                                       ;#$D0, #$E0, #$F0 = projectile indices(including bombs).

ItemIndex              db   ;$4C     ;#$00 or #$08. Added to PowerUpType addresses to determine if-->
                                       ;the first or second item slot is being checked.

SamusDir               db   ;$4D     ;0 = Right, 1 = Left.
SamusDoorDir           db   ;$4E     ;Direction Samus passed through door.
MapPosY                db   ;$4F     ;Current y position on world map of the screen to load into VRAM.
MapPosX                db   ;$50     ;Current x position on world map of the screen to load into VRAM.
SamusScrX              db   ;$51     ;Samus x position on screen.
SamusScrY              db   ;$52     ;Samus y position on screen.
WalkSoundDelay         db   ;$53
StatuesBridgeIsSpawned db   ;$54     ;0=Bridge is not spawned, 1=Bridge is spawned and will build itself.
IsSamus                db   ;$55     ;1=Samus object being accessed, 0=not Samus.
DoorEntryStatus        db   ;$56     ;0=Not in door, 1=In right door, 2=In left door, 3=Scroll up-->
                                       ;4=Scroll down, 5=Exit door, MSB set=Door entered. If value-->
                                       ;is 3 or 4, a door was entered while in a vertical shaft and-->
                                       ;the door was not centered on the screen and up or down-->
                                       ;scrolling needs to occur before scrolling to the next room.
DoorScrollStatus       db   ;$57     ;#$01=Entered right hand door from horizontal area.-->
                                       ;#$02=Entered left hand door from horizontal area.-->
                                       ;#$03=Entered door from vertical shaft and room needs to-->
                                       ;be centered before horizontal scrolling. #$04=Entered-->
                                       ;door from vertical shaft and room was already centered.
SamusDoorData          db   ;$58     ;The upper 4 bits store either 1 or 2. If 1 is stored(bit 4-->
                                       ;set), the scrolling after Samus exits the door is toggled.-->
                                       ;If 2 is stored(bit 5 set), the scrolling is set to-->
                                       ;horizontal scrolling after Samus exits the door. This-->
                                       ;happens mostly in item rooms. The lower 4 bits store Samus'-->
                                       ;action status as she enters the door. This is used to set-->
                                       ;Samus' action after she exits and keeps her looking the same.
DoorDelay              db   ;$59     ;Number of frames to delay when Samus entering/exiting doors.
RoomNumber             db   ;$5A     ;Room number currently being loaded. #$FF=no room requested.
SpritePagePos          db   ;$5B     ;Index into sprite RAM used to load object sprite data.

; 4 slots of 2 bytes each ($5C-$63)
DoorRoomRAMPtr         dsw 4;$5C
; DoorRoomRAMPtr+1             $5D

SamusInLava            db   ;$64     ;#$01=Samus in lava, #$00=She is not.
ObjectCounter          db   ;$65     ;Counts such things as object explosion time.
EnemyMovePixelQty      db   ;$66     ;Quantity of times to call the current EnemyMoveOnePixel routine
ObjectPalette          db   ;$67     ;Attrib. table info for room object(#$00 thru #$03).
RoomPalette            db   ;$68
TempX                  db   ;$69
TempY                  db   ;$6A
ObjectCntrl            db   ;$6B     ;Controls object properties such as mirroring and color-->
                                       ;bits. Bit 4 controls object horizontal mirroring.
                                       ;If bit 7 set, these attributes apply:
                                       ;bit 5 is priority
                                       ;bit 0 and bit 1 is for the color palette

ScrollBlockOnNameTable3 db  ;$6C     ;The following two addresses are used to keep track of the-->
ScrollBlockOnNameTable0 db  ;$6D       ;doors loaded on the name tables. The information is used-->
                                       ;in the GetRoomNum routine to prevent the loading of a-->
                                       ;room behind a door when scrolling horizontally. This has-->
                                       ;the effect of stopping scrolling until Samus walks through-->
                                       ;the door. #$01=Left door on name table. #$02=right door-->
                                       ;on name table. #$03 two doors on the same name table.-->
                                       ;#$00 is possible in $6D if 2 doors are on name table 0-->
                                       ;while vertically scrolling.

HealthChange           dw   ;$6E     ;Amount to add/subtract from Health.
; HealthChange+1               $6F

SamusInvincibleDelay   db   ;$70     ;Samus's invincibility frames delay counter.
UpdatingProjectile     db   ;$71     ;#$01=Projectile update in process. #$00=not in process.
SamusKnockbackDir      db   ;$72     ;#$00=Push Samus left when hit, #$01=Push right, #$FF=No push.
                                       ; i think there may something more to this variable, but im not sure what
SamusKnockbackIsBomb   db   ;$73     ;bit 7: 0=samus was hurt, 1=samus was bombed
                                       ;bit 0: 0=diagonal knockback, 1=vertical knockback
InArea                 db   ;$74     ;#$10(or #$00)=Brinstar, #$11=Norfair, #$12=Kraid hideout,-->
                                       ;#$13=Tourian, #$14=Ridley hideout.

SpareMem75             db   ;$75     ;Initialized to #$FF in AreaInit. Not used.
PaletteToggle          db   ;$76
SamusKnockbackIsBomb77 db   ;$77     ;set to SamusKnockbackIsBomb

SpareMem78             db   ;$78

ItemRoomMusicStatus    db   ;$79     ;#$00=Item room music not playing.
                                       ;#$01=Play item room music.
                                       ;#$80=Stop item room music once door scroll complete.
                                       ;#$81=Item room music already playing. Don't restart.

; $7A-$DE cleared in MoreInit (should clear $DF, off-by-one bug?)
.union
    SpareMem7A             db   ;$7A     ;cleared in MoreInit, never used in gameplay

    SpareMem7B             dw   ;$7B

    OnFrozenEnemy          db   ;$7D     ;#$01=Samus standing on frozen enemy, #$00=she is not.

    KraidLintCounter       db   ;$7E     ;Used to determine when to fire Kraid's lint. Accidentally used by Ridley too.
    KraidNailCounter       db   ;$7F     ;Used to determine when to fire Kraid's nail.
    RidleyProjectileCounter db  ;$80     ;Used to determine when to fire Ridley's projectile.

    EnemyMovementPtr       .dw  ;$81
    ; EnemyMovementPtr+1           $82
    EnemyStatusPreAI       db   ;$81     ;set to enemy status before enemy ai routine is run
    Enemy82                db   ;$82

    SpawnEnProjectile_AnimIndex dw ;$83     ;right facing anim index for enemy that shoots the projectile
    ; SpawnEnProjectile_AnimIndex+1   $84     ;left facing anim index for enemy that shoots the projectile
    SpawnEnProjectile_AnimTableIndex .db ;$85 ;index into EnProjectileRisingAnimIndexTable
    EnemyFlipAfterDisplacementAnimIndex dw ;$85 ;right facing anim index for enemy using EnemyFlipAfterDisplacement routine
    ; EnemyFlipAfterDisplacementAnimIndex+1   $86 ;left facing anim index for enemy using EnemyFlipAfterDisplacement routine
    SpawnEnProjectile_ExpectedStatus db ;$87 ;expected status for the enemy that shoots an enProjectile, won't shoot if status doesn't match
                                                ;this functionnality is not used: the expected status is always the current status
    SpawnEnProjectile_EnData0A db   ;$88

    SpareMem89             db   ;$89

    MellowRandomNumber     db   ;$8A

    ; 2 slots of 3 bytes each ($8B-$90)
    RinkaSpawners          instanceof RinkaSpawner 2 startfrom 0
.nextu
    ;--------------------------------------[ End routine specific ]--------------------------------------

    EndMsgWrite            db   ;$7A     ;0=don't write end message, 1=write end message.
    IsCredits              db   ;$7B     ;0=credits not rolling, 1=credits rolling.
    SpriteByteCounter      db   ;$7C     ;Used to indicate when Samus sprite load complete.
    SpritePointerIndex     db   ;$7D     ;Index to proper Samus sprite graphics at end game.
    SpriteAttribByte       db   ;$7E     ;#$00.  Attribute byte of some sprites.
    ColorCntIndex          db   ;$7F     ;Index for finding count number for ClrChangeCounter.
    CreditPageNumber       db   ;$80     ;Stores current page of credits(#$00 thru #$06).
    HideShowEndMsg         db   ;$81     ;0=show end message, 1=erase end message.
    ClrChangeCounter       db   ;$82     ;When=#$00, change end Samus sprite colors.
    WaveSpritePointer      db   ;$83     ;Address pointer to Samus hand waving sprites in end.
    WaveSpriteCounter      db   ;$84     ;Stores length of wave sprite data (#$10).
.endu

;----------------------------------------------------------------------------------------------------

DoorPaletteChangeDir   db   ;$91     ;When Samus enters a palette change room, this stores the ScrollDir
                                       ;she entered with, so that if the next door she enters is also
                                       ;in that direction, we can change the palette.

MetroidOnSamus         db   ;$92     ;#$01=Metroid on Samus, #$00=Metroid not on Samus.

MissilePickupQtyMax    db   ;$93     ;Maximum missile drops that can be picked up. Randomly-->
                                       ;recalculated whenever Samus goes through a door.
EnergyPickupQtyMax     db   ;$94     ;Maximum energy drops that can be picked up. Randomly-->
                                       ;recalculated whenever Samus goes through a door.
MissilePickupQtyCur    db   ;$95     ;Number of missile drops currently collected by Samus-->
                                       ;Reset to 0 when Samus goes through a door.
EnergyPickupQtyCur     db   ;$96     ;Number of energy drops currently collected by Samus-->
                                       ;Reset to 0 when Samus goes through a door.

CannonIndex            db   ;$97     ;Current cannon being processed

MotherBrainStatus      db   ;$98     ;#$00=Mother brain not in room, #$01=Mother brain in room,-->
                                       ;#$02=Mother brain hit, #$03=Mother brain dying-->
                                       ;#$04=Mother brain dissapearing, #$05=Mother brain gone,-->
                                       ;#$06=Time bomb set, #$07=Time bomb exploded,-->
                                       ;#$08=Initialize mother brain,-->
                                       ;#$09, #$0A=Mother brain already dead.

.union
    ; when mother brain is alive
    MotherBrainQtyHits     db   ;$99     ;Number of times mother brain has been hit. Dies at #$20.

    MotherBrainAnimBrainDelay db ;$9A    ; delay until next brain frame. depends on mother brain health
    MotherBrainAnimEyeDelay db  ;$9B     ; delay until eye opens or closes. depends on mother brain health
                                           ; bit7=is eye open? #%0=yes, #%1=no
    MotherBrainAnimFrameTableID db ;$9C  ; current id in MotherBrainAnimFrameTable for the brain pulsations
    MotherBrainHi          db   ;$9D
    MotherBrainIsHit       db   ;$9E     ;Was mother brain hit by a missile? #$00=no, #$01=yes
.nextu
    ; when mother brain is disappearing
    MotherBrainDeathStringID db ;$99     ; disintegration batch id used to get the right string of instructions
    MotherBrainDeathInstrID db  ;$9A     ; current disintegration instruction id
.nextu
    ; when mother brain is dead
    MotherBrainTimeBombCounter db ;$99     ; counts from #-$80 up to #$00 until time bomb is set
.endu
MotherBrainFlashDelay  db   ;$9F     ;Primarily delay until mother brain no longer flashes from being hit. 
                                       ;Also delay until the next batch of disintegration.

; 4 slots of 4 bytes each ($A0-$AF)
SkreeProjectiles       instanceof SkreeProjectile 4 startfrom 0

.union
    ; 4 slots of 8 bytes each ($B0-$CF)
    Mellows                instanceof Mellow 4 startfrom 0
.nextu

    SpareMemB0             ds 7 ;$B0
    SpareMemB7             db   ;$B7     ;Written to in title routine and accessed by unused routine.
    SpareMemB8             ds 3 ;$B8     ;Written to in title routine and accessed by unused routine.
    SpareMemBB             db   ;$BB     ;Written to in title routine, but never accessed.

    CrossMsl0to3SlowDelay  db   ;$BC     ;This address holds an 8 frame delay. when the delay is up,-->
                                           ;The crosshair sprites double their speed.
    CrossMsl4to7SpawnDelay db   ;$BD     ;This address holds a 32 frame delay.  When the delay is-->
                                           ;up, the second set of crosshair sprites start their movement.
    SpareMemBE             db   ;$BE
    SecondCrosshairSprites db   ;$BF     ;#$01=Second crosshair sprites active in intro.

    FlashScreen            db   ;$C0     ;#$01=Flash screen during crosshairs routine.
    PaletteDataIndex       db   ;$C1
    ScreenFlashPaletteIndex db  ;$C2     ;Index to palette data to flash screen during intro.
    IntroStarOffset        db   ;$C3     ;Contains offset into IntroStarPntr table for twinkle effect.
    FadeDataIndex          db   ;$C4     ;Index to palette data to fade items in and out during intro.

    SpareMemC5             db   ;$C5     ;Written to in title routine, but never accessed.
    CrossExplodeLengthIndex db  ;$C6     ;#$00 thru #$04. Index to find cross sprite data.
    IsUpdatingCrossExplode db   ;$C7     ;#$01=Draw cross on screen during crosshairs routine.
    SpriteLoadPending      db   ;$C8     ;Set to #$00 after sprite RAM load complete.
    SpareMemC9             dw   ;$C9     ;Written to in title routine, but never accessed.
    SpareMemCB             db   ;$CB     ;Written to in title routine, but never accessed.
    SpareMemCC             db   ;$CC     ;Written to in title routine, but never accessed.
    SpareMemCD             db   ;$CD     ;Written to in title routine, but never accessed.
    SpareMemCE             db   ;$CE     ;Written to in title routine, but never accessed.
    SpareMemCF             db   ;$CF     ;Written to in title routine, but never accessed.
    SpareMemD0             db   ;$D0     ;Written to in title routine, but never accessed.
    SpareMemD1             db   ;$D1     ;Written to in title routine, but never accessed.
    SpareMemD2             db   ;$D2     ;Written to in title routine, but never accessed.
    SpareMemD3             ds 4 ;$D3     ;Written to in title routine, but never accessed.
    SpareMemD7             db   ;$D7     ;Written to in title routine, but never accessed.
    IntroMusicRestart      db   ;$D8     ;After all title routines run twice, restarts intro music.
    SpareMemD9             ds 7 ;$D9
.endu

SoundE0                dw   ;$E0
; SoundE0+1                    $E1

SoundE2                dw   ;$E2
; SoundE2+1                    $E3

SoundE4                dw   ;$E4
; SoundE4+1                    $E5

SoundChannelBase       dw   ;$E6
; SoundChannelBase+1           $E7

SpareMemE8             dw   ;$E8

Cntrl0Data             db   ;$EA     ;Temp storage for data of first address sound channel
VolumeEnvelopeIndex    db   ;$EB     ;Desired address number in VolumeCntrlAdressTbl

VolumeEnvelopePtr      dw   ;$EC
; VolumeEnvelopePtr+1          $ED

SpareMemEE             dw   ;$EE

ABStatus               db   ;$F0     ;Stores A and B button status in AreaInit. Never used.

SpareMemF1             ds 9 ;$F1

MirrorCntrl            db   ;$FA     ;If bit 3 is set, PPU set to horizontal mirroring-->
                                       ;else if bit 3 is clear, PPU is set to vertical-->
                                       ;mirroring. No other bits seem to matter.

SpareMemFB             db   ;$FB

ScrollY                db   ;$FC     ;Y value loaded into scroll register.
ScrollX                db   ;$FD     ;X value loaded into scroll register.
PPUMASK_ZP             db   ;$FE     ;Data byte to be loaded into PPU control register 1.
PPUCTRL_ZP             db   ;$FF     ;Data byte to be loaded into PPU control register 0.

.ende

;--------------------------------------------[ Onepage ]--------------------------------------------

.enum $0106 export

Health                 dw   ;$0106   ;Lower health digit in upper 4 bits.
; Health+1                     $0107   ;Upper health digit in lower 4 bits-->
                                       ;# of full tanks in upper 4 bits.
MiniBossKillDelayFlag  db   ;$0108   ;Initiate power up music and delay after Kraid/Ridley killed.
PowerUpDelayFlag       db   ;$0109   ;Initiate power up music and delay after item pickup.

EndTimer               dw   ;$010A   ;Lower byte of end game escape timer.
; EndTimer+1                   $010B   ;Upper byte of end game escape timer.

EndTimerEnemyHi        db   ;$010C
EndTimerEnemyIsEnabled db   ;$010D   ;the end timer in the "TIME BOMB SET" message. #$00=no, #$01=yes

MissileToggle          db   ;$010E   ;0=fire bullets, 1=fire missiles.
SamusHurt010F          db   ;$010F   ;never read. takes on different values depending on how samus was hit.

.ende

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
; slot D to F is for samus projectiles

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
Projectile           instanceof Object 3 startfrom 0

.ende


;Samus RAM.
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


;Elevator RAM.
;Elevator.speedY        db   ;$0328   ;when starting to move, #$00 is written, but this is never read
ElevatorType = Elevator.data0F       ;bit 7 is up(1) or down(0)
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

;-------------------------------------[ Title routine specific ]-------------------------------------

PasswordCursor         = $0320   ;Password write position (#$00 - #$17).
InputRow               = $0321   ;Password character select row (#$00 - #$04).
InputColumn            = $0322   ;Password character select column (#$00 - #$0C).
PasswordStat00         = $0324   ;Does not appear to have a function.
StartContinue          = $0325   ;0=START selected, 1=CONTINUE selected.

;------------------------------------------[ Enemy RAM ]---------------------------------------------

; 16 slots of 16 bytes each ($0400-$04FF)
; slot 0 to 5 is for normal enemies
; slot 6 to B is for enemy projectiles
; slot C to D is for enemy explosions
; slot E is for mother brain
; slot F is for mellow handler enemy
EnY                    = $0400   ;Enemy y position in room.(not actual screen position).
EnX                    = $0401   ;Enemy x position in room.(not actual screen position).
EnSpeedY               = $0402   ; unknown - y speed?
EnSpeedX               = $0403   ; unknown - x speed?
EnIsHit                = $0404   ;bit2: touching Samus
                                   ;bit1 set: touch Samus from the top
                                   ;bit0 set: touch Samus from the left
                                   ;bit5: hit by weapon (projectile or screw attack) (except enemy projectiles)
                                   ;bit4 set: hit by weapon from the top
                                   ;bit3 set: hit by weapon from the left
EnData05               = $0405   ;bit0: 0=facing right, 1=facing left
                                   ;bit1: IsObjectVisible
                                   ;bit2: 0=facing down, 1=facing up (can desync with sign of y speed for multiviolas)
                                   ;bit3: does the enemy become active if it's resting and EnDelay becomes zero. 0=no, 1=yes
                                   ;bit4: is samus close enough to the enemy (EnemyDistanceToSamusThreshold). 0=no, 1=yes
                                   ;  depending on the threshold, bit 3 may be used instead, which will allow -->
                                   ;  the enemy to become active when samus gets close.
                                   ;bit5: when active, this bit being set will trigger a resting period
                                   ;bit6: toggles every frame for some enemy routines to run at 30FPS
                                   ;bit7: when this is set, some routines use bit2 as facing direction instead of bit0
EnMovementInstrIndex   = $0406   ;Counts such things as explosion time.
EnSpeedSubPixelY       = $0406   ;- y counter?
EnSpeedSubPixelX       = $0407   ; unknown - x counter
EnMovementIndex        = $0408   ;Index into the EnemyMovement table of that enemy.
EnDelay                = $0409   ;Delay counter between enemy actions.
EnData0A               = $040A   ; unknown -- For crawlers, orientation
                                   ; (#$00 = forwards on floor, #$01 = moving down a wall, #$02 = backwards on ceiling, #$03 = moving up an opposite wall)
                                   ; For enProjectiles, it's the EnProjectileMovement id
EnHealth               = $040B   ;Current health of enemy.
EnPrevStatus           = $040C   ;Enemy status before being hurt. bit 7 and bit 6 is EnSpecialAttribs.
EnData0D               = $040D   ;Resting: force speed towards samus delay
                                   ;Frozen: frozen timer (* 8)
                                   ;Pickup: die delay (* 4)
EnWeaponAction         = $040E   ; unknown - What weapon action is currently hitting the enemy?
EnSpecialAttribs       = $040F   ;Bit 7 set=tough version of enemy, bit 6 set=mini boss.
                                   ;When enemy is hurt, this is used as hitstun delay

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

.enum $0500 export

;Tile respawning
; 13 slots of 16 bytes each ($0500-$05CF)
TileBlasts             instanceof TileBlast $D startfrom 0

.ende

TileBlastType          = $050A

;Samus projectiles extra RAM for wave beam
; 3 slots of 16 bytes each ($05D0-$05FF)
ProjectileWaveInstrID  = $0500   ; instruction id for movement string of wave bullet trajectory
ProjectileWaveInstrTimer = $0501   ; count frames up to current instruction duration, then increment instr id
ProjectileWaveDir      = $0502   ; bullet direction, used to get movement string. #$00=right, #$01=left, #$02=up

;---------------------------------[ Sound engine memory addresses ]----------------------------------

.enum $0600 export

MusicSQ1PeriodLow      db   ;$0600   ;Loaded into SQ1_LO when playing music
MusicSQ1PeriodHigh     db   ;$0601   ;Loaded into SQ1_HI when playing music

SFXPaused              db   ;$0602   ;0=Game not paused, 1=Game paused
PauseSFXStatus         db   ;$0603   ;Plays PauseMusic SFX if less than #$12

MusicSQ2PeriodLow      db   ;$0604   ;Loaded into SQ2_LO when playing music
MusicSQ2PeriodHigh     db   ;$0605   ;Loaded into SQ2_HI when playing music

Mem0606                db   ;$0606   ;Don't remove it, it's needed (by what?)

WriteMultiChannelData  db   ;$0607   ;1=data needs to be written, 0=no data to write

MusicTriPeriodLow      db   ;$0608   ;Loaded into TRI_LO when playing music
MisicTriPeriodHigh     db   ;$0609   ;Loaded into TRI_HI when playing music

SpareMem060A           ds 6 ;$060A

TriPeriodLow           db   ;$0610   ;Stores triangle SFX period low for processing
TriPeriodHigh          db   ;$0611   ;Stroes triangle SFX period high for processing
TriChangeLow           db   ;$0612   ;Stores triangle SFX change in period low
TriChangeHigh          db   ;$0613   ;Stores triangle SFX change in period high

TriPeriodDividedLow    db   ;$0614   ;Low result of DivideTriPeriods division. Used as TriChangeLow.
TriPeriodDividedHigh   db   ;$0615   ;High result of DivideTriPeriods division. Used as TriChangeHigh.
TriPeriodDivisor       db   ;$0616   ;Used in DivideTriPeriods as divisor for TriPeriod values.
DivideData             db   ;$0617    ;Used in DivideTriPeriods

SpareMem0618           ds 7 ;$0618

HasBeamSFX             db   ;$061F   ;Bit 7 set=has long beam, bit 0 set=has ice beam

;The following addresses are loaded into $0640 thru $0643 when those
;addresses decrement to zero.  These addresses do not decrement.

SQ1FrameCountInit      db   ;$0620   ;Holds number of frames to play SQ1 channel data
SQ2FrameCountInit      db   ;$0621   ;Holds number of frames to play SQ2 channel data
TriFrameCountInit      db   ;$0622   ;Holds number of frames to play Triangle channel data
NoiseFrameCountInit    db   ;$0623   ;Holds number of frames to play Noise channel data

SQ1RepeatCounter       db   ;$0624   ;Number of times to repeat SQ1 music loop
SQ2RepeatCounter       db   ;$0625   ;Number of times to repeat SQ2 music loop
TriRepeatCounter       db   ;$0626   ;Number of times to repeat Triangle music loop
NoiseRepeatCounter     db   ;$0627   ;Number of times to repeat Noise music loop

SQ1DutyEnvelope        db   ;$0628   ;Loaded into SQ1_VOL when playing music
SQ2DutyEnvelope        db   ;$0629   ;Loaded into SQ2_VOL when playing music
TriLinearCount         db   ;$062A   ;disable\enable counter, linear count length

NoteLengthTblOffset    db   ;$062B   ;Stores the offset to find proper note length table
MusicRepeat            db   ;$062C   ;0=Music does not repeat, Nonzero=music repeats
TriCounterCntrl        db   ;$062D   ;$F0=disable length cntr, $00=long note, $0F=short note
SQ1VolumeEnvelopeIndex db   ;$062E   ;Entry number in VolumeEnvelopePtrTable for SQ1
SQ2VolumeEnvelopeIndex db   ;$062F   ;Entry number in VolumeEnvelopePtrTable for SQ2
SQ1Base                dw   ;$0630   ;Low byte of base address for SQ1 music data
; SQ1Base+1                    $0631   ;High byte of base address for SQ1 music data
SQ2Base                dw   ;$0632   ;Low byte of base address for SQ2 music data
; SQ2Base+1                    $0633   ;High byte of base address for SQ2 music data
TriBase                dw   ;$0634   ;Low byte of base address for Triangle music data
; TriBase+1                    $0635   ;High byte of base address for Triangle music data
NoiseBase              dw   ;$0636   ;Low byte of base address for Noise music data
; NoiseBase+1                  $0637   ;High byte of base address for Noise music data

SQ1MusicIndexIndex     db   ;$0638   ;Index to find SQ1 sound data index. Base=$630,$631
SQ2MusicIndexIndex     db   ;$0639   ;Index to find SQ2 sound data index. Base=$632,$633
TriMusicIndexIndex     db   ;$063A   ;Index to find Tri sound data index. Base=$634,$635
NoiseMusicIndexIndex   db   ;$063B   ;Index to find Noise sound data index. Base=$636,$637

SQ1LoopIndex           db   ;$063C   ;SQ1 Loop start index
SQ2LoopIndex           db   ;$063D   ;SQ2 loop start index
TriLoopIndex           db   ;$063E   ;Triangle loop start index
NoiseLoopIndex         db   ;$063F   ;Noise loop start index

SQ1MusicFrameCount     db   ;$0640   ;Decrements every sq1 frame. When 0, load new data
SQ2MusicFrameCount     db   ;$0641   ;Decrements every sq2 frame. when 0, load new data
TriMusicFrameCount     db   ;$0642   ;Decrements every triangle frame. When 0, load new data
NoiseMusicFrameCount   db   ;$0643   ;Decrements every noise frame. When 0, load new data

SpareMem0644           ds 4 ;$0644

MusicSQ1Sweep          db   ;$0648   ;Value is loaded into SQ1_SWEEP when playing music
MusicSQ2Sweep          db   ;$0649   ;Value is loaded into SQ2_SWEEP when playing music
TriSweep               db   ;$064A   ;Loaded into TRI_UNUSED(not used)

ThisSoundChannel       db   ;$064B   ;Least sig. byte of current channel(00,04,08 or 0C)

SpareMem064C           db   ;$064C

CurrentSFXFlags        db   ;$064D   ;Stores flags of SFX currently being processed.

SpareMem064E           ds 4 ;$064E

NoiseInUse             db   ;$0652   ;Noise in use? (Not used)
SQ1InUse               db   ;$0653   ;1=SQ1 channel being used by SFX, 0=not in use
SQ2InUse               db   ;$0654   ;2=SQ2 channel being used by SFX, 0=not in use
TriInUse               db   ;$0655   ;3=Triangle channel being used by SFX, 0=not in use

SpareMem0656           ds 6 ;$0656

ChannelType            db   ;$065C   ;Stores channel type being processed(0,1,2,3 or 4)
CurrentMusicRepeat     db   ;$065D   ;Stores flags of music to repeat
MusicInitIndex         db   ;$065E   ;index for loading $62B thru $637(base=$BD31).

SpareMem065F           db   ;$065F

NoiseSFXLength         db   ;$0660   ;Stores number of frames to play Noise SFX
SQ1SFXLength           db   ;$0661   ;Stores number of frames to play SQ1 SFX
SQ2SFXLngth            db   ;$0662   ;Stores number of frames to play SQ2 SFX
TriSFXLength           db   ;$0663   ;Stores number of frames to play Triangle SFX
MultiSFXLength         db   ;$0664   ;Stores number of frames to play Multi SFX

ThisNoiseFrame         db   ;$0665   ;Stores current frame number for noise SFX
ThisSQ1Frame           db   ;$0666   ;Stores current frame number for sq1 SFX
ThisSQ2Frame           db   ;$0667   ;Stores current frame number for SQ2 SFX
ThisTriFrame           db   ;$0668   ;Stores current frame number for triangle SFX
ThisMultiFrame         db   ;$0669   ;Stores current frame number for Multi SFX

SQ1VolumeIndex         db   ;$066A   ;Stores index to SQ1 volume data in a volume data tbl
SQ2VolumeIndex         db   ;$066B   ;Stores index to SQ2 volume data in a volume data tbl

SQ1VolumeData          db   ;$066C   ;stores duty cycle and this frame volume data of SQ1
SQ2VolumeData          db   ;$066D   ;Stores duty cycle and this frame volume data of SQ2

SpareMem066E           dw   ;$066E   ;$066E is unknowingly written to by "sta SQ1VolumeData,x", but never read

NoiseSFXData           db   ;$0670   ;Stores additional info for Noise SFX
SQ1SFXData             db   ;$0671   ;Stores additional info for SQ1 SFX
SQ2SFXData             db   ;$0672   ;Stores additional info for SQ2 SFX
TriSFXData             db   ;$0673   ;Stores additional info for triangle SFX

NoiseSFXData1          db   ;$0674   ;Stores additional info for Noise SFX
SQ1SFXData1            .db  ;$0675   ;Stores additional info for SQ1 SFX
SQ1SQ2SFXData          db   ;$0675   ;Stores additional info for SQ1 and SQ2 SFX (for multi SFX)
SQ2SFXData1            db   ;$0676   ;Stores additional info for SQ2 SFX
TriSFXData1            db   ;$0677   ;Stores additional info for triangle SFX

NoiseSFXData2          db   ;$0678   ;Contains extra data for screw attack SFX
SQ1SFXData2            .db  ;$0679   ;Stores additional info for SQ1 SFX
SQ1SFXPeriodLow        db   ;$0679   ;Period low data for processing multi SFX routines
SQ2SFXData2            db   ;$067A   ;Stores additional info for SQ2 SFX
TriSFXData2            db   ;$067B   ;Stores additional info for triangle SFX

SpareMem067C           ds 4 ;$067C

NoiseSFXFlag           db   ;$0680   ;Initialization flags for noise SFX
SQ1SFXFlag             db   ;$0681   ;Initialization flags for SQ1 SFX
SQ2SFXFlag             db   ;$0682   ;Initialization flags for SQ2 SFX(never used)
TriSFXFlag             db   ;$0683   ;Initialization flags for triangle SFX
MultiSFXFlag           db   ;$0684   ;Initialization Flags for SFX and some music

MusicInitFlag          db   ;$0685   ;Music init flags

ScrewAttack0686        db   ;$0686

SpareMem0687           db   ;$0687

NoiseContSFX           db   ;$0688   ;Continuation flags for noise SFX
SQ1ContSFX             db   ;$0689   ;Continuation flags for SQ1 SFX
SQ2ContSFX             db   ;$068A   ;Continuation flags for SQ2 SFX (never used)
TriContSFX             db   ;$068B   ;Continuation flags for Triangle SFX
MultiContSFX           db   ;$068C   ;Continuation flags for Multi SFX

CurrentMusic           db   ;$068D   ;Stores the flag of the current music being played

.ende

;----------------------------------------------------------------------------------------------------

.enum $0700 export

; 6 slots of 6 bytes each ($0700-$0723)
Mem0700                instanceof Struct0700 6 startfrom 0

SpareMem0724           ds 4   ;$0724

; 4 slots of 8 bytes each ($0728-$0747)
PipeBugHoles           instanceof PipeBugHole 4 startfrom 0

; 2 slots of 8 bytes each ($0748-$0757)
PowerUps               instanceof PowerUp 2 startfrom 0

; 5 Zebetite slots of 8 bytes each ($0758-$077F)
Zebetites              instanceof Zebetite 5 startfrom 0

TileSize               db   ;$0780   ;4 MSBs=Y size of tile to erase. 4 LSBs=X size of tile to erase.
TileInfo0              db   ;$0781   ;
TileInfo1              db   ;$0782   ;
TileInfo2              db   ;$0783   ;Tile patterns to replace blasted tiles.
TileInfo3              db   ;$0784   ;
TileInfo4              db   ;$0785   ;
TileInfo5              db   ;$0786   ;

SpareMem0787           ds $19 ;$0787

VRAMStructBufferIndex  db   ;$07A0   ;# of bytes of data in VRAMStructBuffer. #$4F bytes max.

;$07A1-$07EF contain a byte string of data to be written the the PPU.
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

VRAMStructBuffer       ds $4F ;$07A1-$07EF ;String of data bytes to be written to PPU.

.ende

;----------------------------------------------------------------------------------------------------

RoomRAMA               = $6000   ;Thru $63FF. Used to load room before it is put into the PPU.
RoomRAMB               = $6400   ;Thru $67FF. Used to load room before it is put into the PPU.


; ??? slots of ??? bytes each
UnusedIntro6833        = $6833   ;Unused. Would have contained a BCD version of the number in -->
; UnusedIntro6833+1      = $6834   ;UnusedIntro684C. (high, low)

; ??? slots of ???(at least 2) bytes each
UnusedIntro6839        = $6839   ;Unused.

; ??? slots of ??? bytes each
UnusedIntro683C        = $683C   ;Unused. Would have contained a BCD version of the number in -->
; UnusedIntro683C+1      = $683D   ;UnusedIntro684A. (high, low)

; ??? slots of 16 bytes each
UnusedIntro6842        = $6842   ;Unused.
UnusedIntro684A        = $684A   ;Unused. Would have contained a 16bit hex number to be converted -->
; UnusedIntro684A+1      = $684B   ;to decimal by UnusedIntroRoutine8.
UnusedIntro684C        = $684C   ;Unused. Would have contained a 16bit hex number to be converted -->
; UnusedIntro684C+1      = $684C   ;to decimal by UnusedIntroRoutine8.

.enum $6872 export

EndingType             db   ;$6872   ;1=worst ending, 5=best ending

SpareMem6873           ds 2 ;$6873

SamusDataIndex         db   ;$6875   ;Index for Samus saved game stats(not used). #$00, #$10, #$20.

SamusStat00            db   ;$6876   ;Unused memory address for storing Samus info.
EnergyTankCount        db   ;$6877   ;Number of energy tanks.
SamusGear              db   ;$6878   ;Stores power-up items Samus has.
MissileCount           db   ;$6879   ;Stores current number of missiles.
MaxMissiles            db   ;$687A   ;Maximum amount of missiles Samus can carry
KraidStatueStatus      db   ;$687B   ;bit 0 set, the statues blink, -->
RidleyStatueStatus     db   ;$687C   ;bit 7 set, statues are up.
SamusAge               ds 4 ;$687D   ;In-game time used for ending. Units of 256 frames.
; SamusAge+1                   $687E   ;Units of 53248 frames.
; SamusAge+2                   $687F   ;Units of 13631488 frames.
; SamusAge+3                   $6880   ;Units of 3489660928 frames. Not considered for ending.
SamusStat0B            dw   ;$6881   ;SamusStat0B keeps track of how many times Samus has-->
; SamusStat0B+1                $6882   ;died, but this info is never accessed anywhere in the game.

AtEnding               db   ;$6883   ;1=End scenes playing, 0=Not at ending.

EraseGame              db   ;$6884   ;MSB set=erase selected saved game(not used in password carts).

DataSlot               db   ;$6885   ;#$00 thru #$02. Stored Samus data to load.
                                       ;Unused leftover from the original FDS version of the game.

NumberOfUniqueItems    db   ;$6886   ;Counts number of power-ups and red doors-->
                                       ;opened.  Does not count different beams-->
                                       ;picked up (ice, long, wave). increments by 2.

UniqueItemHistory      ds $100   ;$6887-$68FC. History of Unique items collected. Two bytes per item.

KraidRidleyPresent     db   ;$6987   ;#$01=Kraid/Ridley present, #$00=Kraid/Ridley not present.

; 18 bytes ($6988-$6999)
PasswordByte           ds $12
; PasswordByte+$00             $6988   ;Stores status of items 0 thru 7.
; PasswordByte+$01             $6989   ;Stores status of items 8 thru 15.
; PasswordByte+$02             $698A   ;Stores status of items 16 thru 23.
; PasswordByte+$03             $698B   ;Stores status of items 24 thru 31.
; PasswordByte+$04             $698C   ;Stores status of items 32 thru 39.
; PasswordByte+$05             $698D   ;Stores status of items 40 thru 47.
; PasswordByte+$06             $698E   ;Stores status of items 48 thru 55.
; PasswordByte+$07             $698F   ;Stores status of items 56 thru 58(bits 0 thru 2).
; PasswordByte+$08             $6990   ;start location(bits 0 thru 5), Samus suit status (bit 7).
; PasswordByte+$09             $6991   ;Stores SamusGear.
; PasswordByte+$0A             $6992   ;Stores MissileCount.
; PasswordByte+$0B             $6993   ;Stores SamusAge.
; PasswordByte+$0C             $6994   ;Stores SamusAge+1.
; PasswordByte+$0D             $6995   ;Stores SamusAge+2.
; PasswordByte+$0E             $6996   ;Stores SamusAge+3.
; PasswordByte+$0F             $6997   ;Stores Statue statuses(bits 4 thu 7).
; PasswordByte+$10             $6998   ;Stores value RandomNumber1.
; PasswordByte+$11             $6999   ;Stores sum of $6988 thru $6998(Checksum).

; 24 bytes ($699A-$69B1)
;These 24 memory addresses store the 24 characters
;of the password to be displayed on the screen.
;Upper two bits of PasswordChar bytes will always be %00.
PasswordChar           ds $18

NARPASSWORD            db   ;$69B2   ;0 = invinsible Samus not active, 1 = invinsible Samus active.
JustInBailey           db   ;$69B3   ;0 = Samus has suit, 1 = Samus is without suit.
ItemHistory            ds $100   ;$69B4-$6A73. Unique item history saved game data (not used).

SpareMem6AB4           ds $40   ;$6AB4

;---------------------------------------[ More enemy RAM ]-------------------------------------------

; 16 slots of 16 bytes each ($6AF4-$6BF3)
EnsExtra               instanceof EnExtra $10 startfrom 0

; 16 slots of 8 bytes each ($6BF4-$6C73)
Cannons                instanceof Cannon $10 startfrom 0

SpareRAM6C74           ds $18C   ;$6C74

;-------------------------------------[ Intro sprite defines ]---------------------------------------

; 40 slots of 4 bytes each ($6E00-$6E9F)
IntroStarSprite        instanceof OAMSprite $28 startfrom 0        ;RAM used for storing intro star sprite data.

; 8 slots of 16 bytes each ($6EA0-$6F1F)
;Intro sprite 0 and sparkle sprite.
IntroSprs              instanceof IntroSpr 8 startfrom 0

.ende

;----------------------------------------------------------------------------------------------------

WorldMapRAM            = $7000   ;Thru $73FF. The map is 1Kb in size (1024 bytes).

.enum $77F0 export

MetroidRepelSpeed      dw        ;$77F0 for negative, $77F1 for positive
MetroidAccel           ds 4      ;$77F2-$77F3 for red metroid, $77F4-$77F5 for green metroid
MetroidMaxSpeed        dw        ;$77F6 for red metroid, $77F7 for green metroid
MetroidLatch0400       db   ;$77F8   ;bits 0-3 is #$0 to #$C, frame counter from touching to fully latched on.
MetroidLatch0410       db   ;$77F9   ;bits 4-6 is #$0 to #$5, count how many bomb hits (5 for separation).
MetroidLatch0420       db   ;$77FA   ;bit 7 is sign of x speed
MetroidLatch0430       db   ;$77FB
MetroidLatch0440       db   ;$77FC
MetroidLatch0450       db   ;$77FD

.ende

; 3 slots of 16 bytes each ($77FE-$782D)
;Samus saved game data (not used).
SamusData00            = $77FE
SamusData01            = $77FF
SamusData02            = $7800
SamusData03            = $7801
SamusData04            = $7802
SamusData05            = $7803
SamusData06            = $7804
SamusData07            = $7805
SamusData08            = $7806
SamusData09            = $7807
SamusData0A            = $7808
SamusData0B            = $7809
SamusData0C            = $780A
SamusData0D            = $780B
SamusData0E            = $780C
SamusData0F            = $780D

