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

;Tourian (memory page 3)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 3
.section "ROM Bank $003" bank 3 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_KraidSprites:
    .incbin "kraid/sprite_tiles.chr" ; 8D60 - Kraid Sprite CHR
GFX_RidleySprites:
    .incbin "ridley/sprite_tiles.chr" ; 9160 - Ridley Sprite CHR

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    PtrTableEntry PalPntrTbl, Palette00                 ;($A718)Room palette.
    PtrTableEntry PalPntrTbl, Palette01                 ;($A73C)Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette02                 ;($A748)Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette03                 ;($A742)Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette04                 ;($A74E)Samus varia suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette05                 ;($A754)
    PtrTableEntry PalPntrTbl, Palette06                 ;($A754)Mother Brain hurt palette.
    PtrTableEntry PalPntrTbl, Palette07                 ;($A759)Mother Brain hurt palette.
    PtrTableEntry PalPntrTbl, Palette08                 ;($A75E)Mother Brain dying palette.
    PtrTableEntry PalPntrTbl, Palette09                 ;($A773)Mother Brain dying palette.
    PtrTableEntry PalPntrTbl, Palette0A                 ;($A788)Time bomb explosion palette.
    PtrTableEntry PalPntrTbl, Palette0B                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette0C                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette0D                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette0E                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette0F                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette10                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette11                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette12                 ;($A78D)
    PtrTableEntry PalPntrTbl, Palette13                 ;($A78D)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntry PalPntrTbl, Palette14                 ;($A794)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette15                 ;($A79B)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette16                 ;($A7A2)Samus fade in palette.
    PtrTableEntry PalPntrTbl, Palette17                 ;($A7A9)Unused?
    PtrTableEntry PalPntrTbl, Palette18                 ;($A7B1)Suitless Samus power suit palette.
    PtrTableEntry PalPntrTbl, Palette19                 ;($A7B9)Suitless Samus varia suit palette.
    PtrTableEntry PalPntrTbl, Palette1A                 ;($A7C1)Suitless Samus power suit with missiles selected palette.
    PtrTableEntry PalPntrTbl, Palette1B                 ;($A7C9)Suitless Samus varia suit with missiles selected palette.

AreaPointers:
    .word SpecItmsTbl               ;($A83B)Beginning of special items table.
    .word RmPtrTbl                  ;($A7D1)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A7FB)Beginning of structure pointer table.
    .word MacroDefs                 ;($AE49)Beginning of macro definitions.
    .word EnFramePtrTable1          ;($A42C)Address table into enemy animation data. Two-->
    .word EnFramePtrTable2          ;($A52C)tables needed to accommodate all entries.
    .word EnPlacePtrTable           ;($A540)Pointers to enemy frame placement data.
    .word EnAnimTbl                 ;($A406)Index to values in addr tables for enemy animations.

; Special Tourian Routines
GotoClearCurrentMetroidLatchAndMetroidOnSamus:
    jmp ClearCurrentMetroidLatchAndMetroidOnSamus
GotoClearAllMetroidLatches:
    jmp ClearAllMetroidLatches
GotoUpdateRoomSpriteInfo_Tourian:
    jmp UpdateRoomSpriteInfo_Tourian
GotoSpawnCannonRoutine:
    jmp SpawnCannonRoutine
GotoSpawnMotherBrainRoutine:
    jmp SpawnMotherBrainRoutine
GotoSpawnZebetiteRoutine:
    jmp SpawnZebetiteRoutine
GotoSpawnRinkaSpawnerRoutine:
    jmp SpawnRinkaSpawnerRoutine
GotoUpdateBullet_CollisionWithZebetiteAndMotherBrainGlass:
    jmp UpdateBullet_CollisionWithZebetiteAndMotherBrainGlass
GotoUpdateBullet_CollisionWithMotherBrain:
    jmp UpdateBullet_CollisionWithMotherBrain

AreaRoutine:
    jmp AreaRoutine_Tourian                       ;Area specific routine.

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
Exit__:
    rts

L95CC:
    .byte $FF                       ;Not used.
AreaMusicFlag:
    .byte music_Tourian             ;Tourian music init flag.
AreaEnemyDamage:
    .word $0300                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

AreaSamusMapPosX:
    .byte $03   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $04   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPalToggle:
    .byte _id_Palette05+1

    .byte $00
AreaFireballKilledAnimIndex:
    .byte EnAnim_FireballKilled - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_21 - EnAnimTbl

    .byte $00, $00
AreaFireballFallingAnimIndex:
    .byte $00, $00
AreaFireballSplatterAnimIndex:
    .byte $00, EnAnim_10 - EnAnimTbl
AreaMellowAnimIndex:
    .byte $00

; Enemy AI Jump Table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word MetroidAIRoutine ; 00 - red metroid
        .word MetroidAIRoutine ; 01 - green metroid
        .word L9A27 ; 02 - i dunno but it takes 30 damage with varia
        .word InvalidEnemy ; 03 - disappears
        .word RinkaAIRoutine ; 04 - rinka
        .word InvalidEnemy ; 05 - same as 3
        .word InvalidEnemy ; 06 - same as 3
        .word InvalidEnemy ; 07 - same as 3
        .word InvalidEnemy ; 08 - same as 3
        .word InvalidEnemy ; 09 - same as 3
        .word InvalidEnemy ; 0A - same as 3
        .word InvalidEnemy ; 0B - same as 3
        .word InvalidEnemy ; 0C - same as 3
        .word InvalidEnemy ; 0D - same as 3
        .word InvalidEnemy ; 0E - same as 3
        .word InvalidEnemy ; 0F - same as 3


EnemyDeathAnimIndex:
    .byte EnAnim_08 - EnAnimTbl, EnAnim_08 - EnAnimTbl
    .byte EnAnim_08 - EnAnimTbl, EnAnim_08 - EnAnimTbl
    .byte EnAnim_16 - EnAnimTbl, EnAnim_16 - EnAnimTbl
    .byte EnAnim_18 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_1F - EnAnimTbl, EnAnim_1F - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

EnemyHealthTbl:
    .byte $FF, $FF, $01, $FF, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyRestingAnimIndex:
    .byte EnAnim_05 - EnAnimTbl, EnAnim_05 - EnAnimTbl
    .byte EnAnim_05 - EnAnimTbl, EnAnim_05 - EnAnimTbl
    .byte EnAnim_16 - EnAnimTbl, EnAnim_16 - EnAnimTbl
    .byte EnAnim_18 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_1B - EnAnimTbl, EnAnim_1B - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

EnemyActiveAnimIndex:
    .byte EnAnim_05 - EnAnimTbl, EnAnim_05 - EnAnimTbl
    .byte EnAnim_05 - EnAnimTbl, EnAnim_05 - EnAnimTbl
    .byte EnAnim_16 - EnAnimTbl, EnAnim_16 - EnAnimTbl
    .byte EnAnim_18 - EnAnimTbl, EnAnim_18 - EnAnimTbl ; unused enemy
    .byte EnAnim_1D - EnAnimTbl, EnAnim_1D - EnAnimTbl
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy
    .byte $00, $00 ; unused enemy

L967B:
    .byte $00
    .byte $00
    .byte $00
    .byte $00 ; unused enemy
    .byte $02
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy

L968B:
    .byte $FE, $FE, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyData0DTbl:
    .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyDistanceToSamusThreshold:
    .byte $00
    .byte $00
    .byte $00
    .byte $00 ; unused enemy
    .byte $00
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy

EnemyInitDelayTbl:
    .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice00 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice01 - EnemyMovementChoices ; enemy can't use movement strings
    .byte EnemyMovementChoice00 - EnemyMovementChoices ; enemy doesn't move
    .byte EnemyMovementChoice00 - EnemyMovementChoices ; unused enemy
    .byte EnemyMovementChoice02 - EnemyMovementChoices ; enemy moves manually
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy
    .byte $00 ; unused enemy

EnemyMovementPtrs:
    .word EnemyMovement00_R, EnemyMovement00_L
    .word EnemyMovement01_R, EnemyMovement01_L
    .word EnemyMovement02_R, EnemyMovement02_L
    .word EnemyMovement03_R, EnemyMovement03_L
    .word EnemyMovement04_R, EnemyMovement04_L
    .word EnemyMovement05_R, EnemyMovement05_L
    .word EnemyMovement06_R, EnemyMovement06_L
    .word EnemyMovement07_R, EnemyMovement07_L
    .word EnemyMovement08_R, EnemyMovement08_L
    .word EnemyMovement09_R, EnemyMovement09_L
    .word EnemyMovement0A_R, EnemyMovement0A_L
    .word EnemyMovement0B_R, EnemyMovement0B_L
    .word EnemyMovement0C_R, EnemyMovement0C_L
    .word EnemyMovement0D_R, EnemyMovement0D_L
    .word EnemyMovement0E_R, EnemyMovement0E_L
    .word EnemyMovement0F_R, EnemyMovement0F_L
    .word EnemyMovement10_R, EnemyMovement10_L
    .word EnemyMovement11_R, EnemyMovement11_L
    .byte $00, $00, $00, $00, $00, $00, $00, $00
    
EnAccelYTable:
    .byte $18, $30, $00, $C0, $D0, $00, $00, $7F, $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable:
    .byte $18, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable:
    .byte $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

L977B:
    .byte $50, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_26 - EnAnimTbl, EnAnim_26 - EnAnimTbl
    .byte EnAnim_26 - EnAnimTbl, EnAnim_26 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetX:
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetY:
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

EnemyFireballMovementPtrTable:
    .word EnemyFireballMovement0
    .word EnemyFireballMovement1
    .word EnemyFireballMovement2
    .word EnemyFireballMovement3

TileBlastFramePtrTable:
    .word TileBlastFrame00
    .word TileBlastFrame01
    .word TileBlastFrame02
    .word TileBlastFrame03
    .word TileBlastFrame04
    .word TileBlastFrame05
    .word TileBlastFrame06
    .word TileBlastFrame07
    .word TileBlastFrame08
    .word TileBlastFrame09
    .word TileBlastFrame0A
    .word TileBlastFrame0B
    .word TileBlastFrame0C
    .word TileBlastFrame0D
    .word TileBlastFrame0E
    .word TileBlastFrame0F
    .word TileBlastFrame10

EnemyMovementChoices:
EnemyMovementChoice00:
    EnemyMovementChoiceEntry $00
EnemyMovementChoice01: ; enemy can't use movement strings
    EnemyMovementChoiceEntry $01
EnemyMovementChoice02: ; enemy moves manually
    ; nothing

EnemyMovement00_R:
EnemyMovement00_L:
EnemyMovement01_R:
EnemyMovement01_L:
EnemyMovement02_R:
EnemyMovement02_L:
EnemyMovement03_R:
EnemyMovement03_L:
EnemyMovement04_R:
EnemyMovement04_L:
EnemyMovement05_R:
EnemyMovement05_L:
EnemyMovement06_R:
EnemyMovement06_L:
EnemyMovement07_R:
EnemyMovement07_L:
EnemyMovement08_R:
EnemyMovement08_L:
EnemyMovement09_R:
EnemyMovement09_L:
EnemyMovement0A_R:
EnemyMovement0A_L:
EnemyMovement0B_R:
EnemyMovement0B_L:
EnemyMovement0C_R:
EnemyMovement0C_L:
EnemyMovement0D_R:
EnemyMovement0D_L:
EnemyMovement0E_R:
EnemyMovement0E_L:
EnemyMovement0F_R:
EnemyMovement0F_L:
EnemyMovement10_R:
EnemyMovement10_L:
EnemyMovement11_R:
EnemyMovement11_L:
    ; nothing

EnemyFireballMovement0:
EnemyFireballMovement1:
    SignMagSpeed $50,  2,  2
    .byte $FF

EnemyFireballMovement2:
    SignMagSpeed $50,  0,  3
    .byte $FF

EnemyFireballMovement3:
    .byte $FF

InvalidEnemy:
    lda #$00
    sta EnsExtra.0.status,x
    rts

CommonEnemyJump_00_01_02:
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq @resting
    cmp #enemyStatus_Explode
    beq @explode
        ; enemy default
        lda $00
        jmp CommonJump_00
    @resting:
        ; enemy resting
        lda $01
        jmp CommonJump_01
    @explode:
        ; enemy explode
        jmp CommonJump_02

;-------------------------------------------------------------------------------
; Metroid Routine
.include "enemies/metroid.asm"

;-------------------------------------------------------------------------------
; ???
L9A27:
    lda #$01
    jmp CommonJump_01

;-------------------------------------------------------------------------------
; Rinka Routine??
.include "enemies/rinka.asm"

;-------------------------------------------------------------------------------
; Tourian specific routine -- called every active frame
AreaRoutine_Tourian:
    jsr UpdateAllCannons
    jsr MotherBrainStatusHandler
    jsr UpdateEndTimer
    jsr DrawEndTimerEnemy
    jsr UpdateAllZebetites
    jmp UpdateAllRinkaSpawners

;-------------------------------------------------------------------------------
UpdateAllCannons:
    ldx #$78
    @loop:
        jsr @updateIfPossible
        lda CannonIndex
        sec
        sbc #$08
        tax
        bne @loop

@updateIfPossible:
    stx CannonIndex
    ldy Cannons.0.status,x
    bne UpdateCannon
RTS_9B4B:
    rts

UpdateCannon:
    ; exit if cannon is offscreen
    jsr UpdateCannon_CheckIfOnScreen
    tya
    bne RTS_9B4B
    ; branch if escape timer is active
    ldy EndTimer+1
    iny
    bne @escape
        ; escape timer is not active, behave normally
        ; exit if cannon instr list is 5 (unused?)
        lda Cannons.0.instrListID,x
        cmp #$05
        beq RTS_9B4B
        ; run instructions
        jsr UpdateCannon_RunInstructions
        jmp DrawCannon_Normal
    @escape:
        ; escape timer is active, flash and do nothing
        lda FrameCount
        and #$02
        bne RTS_9B4B
        lda #_id_EnFrame19.b
        jmp DrawCannon_Escape

UpdateCannon_RunInstructions:
    ldy Cannons.0.instrListID,x
    ; branch if instruction delay is not zero (continue running current angle instruction)
    lda Cannons.0.instrDelay,x
    bne @endIf_A
        ; instruction delay is zero
        ; reset delay (always to 40 frames)
        lda CannonInstrDelayTable,y
        sta Cannons.0.instrDelay,x
        ; change to next instruction
        inc Cannons.0.instrID,x
    @endIf_A:
    ; decrement delay
    dec Cannons.0.instrDelay,x
@getInstruction:
    ; get cannon instruction from instruction list
    lda CannonInstrListsOffset,y
    clc
    adc Cannons.0.instrID,x
    tay
    lda CannonInstrLists,y
    ; branch if it's an angle instruction
    bpl @setAngle
        cmp #$FF
        bne @shootFireball
            ; instruction is restart
            ldy Cannons.0.instrListID,x
            ; restart to first instruction
            lda #$00
            sta Cannons.0.instrID,x
            ; go back to get instuction
            beq @getInstruction ; branch always
        @shootFireball:
            ; instruction is shoot fireball
            ; change to next instruction
            inc Cannons.0.instrID,x
            ; shoot
            jsr Cannon_ShootFireball
            ldy Cannons.0.instrListID,x
            ; go back to get instuction
            jmp @getInstruction

    @setAngle:
        sta Cannons.0.angle,x
        rts

Cannon_ShootFireball:
    ; push instruction byte #$FC, #$FD or #$FE
    pha
    ; exit if mother brain is dying or dead
    lda MotherBrainStatus
    cmp #$04
    bcs @exit
    ; loop through all enemy fireballs
    ldy #$60
    @loop:
        ; branch if slot is empty
        lda EnsExtra.0.status,y
        beq @slotFound
        ; slot is not empty, check next slot
        tya
        clc
        adc #$10
        tay
        cmp #$A0
        bne @loop
    ; no fireball slots found, exit
@exit:
    pla
    rts

@slotFound:
    ; store slot
    sty PageIndex
    ; set fireball position to cannon position
    lda Cannons.0.y,x
    sta EnY,y
    lda Cannons.0.x,x
    sta EnX,y
    lda Cannons.0.hi,x
    sta EnsExtra.0.hi,y
    ; set fireball status to active
    lda #enemyStatus_Active
    sta EnsExtra.0.status,y
    ; init fireball animation timers
    lda #$00
    sta EnDelay,y
    sta EnsExtra.0.animDelay,y
    sta EnMovementIndex,y
    ; pop instruction byte #$FC, #$FD or #$FE
    pla
    ; #$FC, #$FD or #$FE becomes #$04, #$03 or #$02
    jsr TwosComplement_
    ; save to x and EnData0A
    tax
    sta EnData0A,y
    ; set fireball facing direction
    ora #$02
    sta EnData05,y
    ; set fireball animation
    lda CannonFireballAnimTable-2,x
    sta EnsExtra.0.resetAnimIndex,y
    sta EnsExtra.0.animIndex,y
    ; store offset into temp
    lda CannonFireballXOffsetTable-2,x
    sta Temp05_SpeedX
    lda CannonFireballYOffsetTable-2,x
    sta Temp04_SpeedY
    ; store cannon position into temp
    ldx CannonIndex
    lda Cannons.0.y,x
    sta Temp08_PositionY
    lda Cannons.0.x,x
    sta Temp09_PositionX
    lda Cannons.0.hi,x
    sta Temp0B_PositionHi
    tya
    tax
    ; apply offset to cannon position
    jsr CommonJump_ApplySpeedToPosition
    ; use as fireball position
    jsr LoadPositionFromTemp
    ldx CannonIndex
    rts

CannonFireballAnimTable:
    .byte EnAnim_0C - EnAnimTbl ; cannon instr #$FE : diagonal right
    .byte EnAnim_0A - EnAnimTbl ; cannon instr #$FD : diagonal left
    .byte EnAnim_0E - EnAnimTbl ; cannon instr #$FC : straight down

DrawCannon_Normal:
    ldy Cannons.0.angle,x
    lda CannonAnimFrameTable,y
DrawCannon_Escape:
    sta EnsExtra.14.animFrame
    lda Cannons.0.y,x
    sta EnY+$E0
    lda Cannons.0.x,x
    sta EnX+$E0
    lda Cannons.0.hi,x
    sta EnsExtra.14.hi
    lda #$E0
    sta PageIndex
    jmp CommonJump_DrawEnemy

; return y=#$00 if cannon is on screen and y=#$01 if not
UpdateCannon_CheckIfOnScreen:
    ldy #$00
    ; set carry if Cannons.0.x >= ScrollX
    lda Cannons.0.x,x
    cmp ScrollX
    ; branch if room is horizontal (in vanilla, this is always the case)
    lda ScrollDir
    and #$02
    bne @endIf_A
        ; set carry if Cannons.0.y >= ScrollY
        lda Cannons.0.y,x
        cmp ScrollY
    @endIf_A:
    ; return y=#$00 if same hi and carry set
    ; return y=#$00 if different hi and carry not set
    ; return y=#$01 if same hi and carry not set
    ; return y=#$01 if different hi and carry set
    ; in effect, return y=#$00 if cannon is on screen and y=#$01 if not
    lda Cannons.0.hi,x
    eor PPUCTRL_ZP
    and #$01
    beq @endIf_B
        bcs @return_y1
        sec
    @endIf_B:
    bcs @return_y0
@return_y1:
    iny
@return_y0:
    rts

;-------------------------------------------------------------------------------

UpdateRoomSpriteInfo_Tourian:
    ; save opposite nametable in $02
    sty $02
    
    ; loop through all cannons
    ldy #$00
    @loop_A:
        ; branch if cannon is in the current nametable
        lda Cannons.0.hi,y
        eor $02
        lsr
        bcs @endIf_A
            ; cannon is in the opposite nametable
            ; clear status
            lda #$00
            sta Cannons.0.status,y
        @endIf_A:
        ; go to next cannon
        tya
        clc
        adc #$08
        tay
        bpl @loop_A
    
    ; loop through all zebetites
    ldx #$00
    @loop_B:
        ; branch if zebetite doesn't exist
        lda ZebetiteStatus,x
        beq @endIf_B
        ; branch if zebetite is in the current nametable
        jsr GetVRAMPtrHi
        eor ZebetiteVRAMPtr+1,x
        bne @endIf_B
            ; zebetite is in the opposite nametable
            ; clear status
            sta ZebetiteStatus,x
        @endIf_B:
        ; move to next zebetite
        txa
        clc
        adc #$08
        tax
        cmp #$28
        bne @loop_B
    
    ; for all rinka spawners
    ldx #$00
    jsr UpdateRoomSpriteInfo_Tourian_RinkaSpawner
    ldx #$03
    jsr UpdateRoomSpriteInfo_Tourian_RinkaSpawner

    ; for mother brain
    ; branch if mother brain doesnt exist
    lda MotherBrainStatus
    beq @endIf_C
    ; branch if time bomb exploded
    cmp #$07
    beq @endIf_C
    ; branch if mother brain is dead
    cmp #$0A
    beq @endIf_C
    ; branch if mother brain is in the current nametable
    lda MotherBrainHi
    eor $02
    lsr
    bcs @endIf_C
        ; mother brain is in the opposite nametable
        ; clear status
        lda #$00
        sta MotherBrainStatus
    @endIf_C:

    ; for end timer enemy
    ; branch if timer enemy doesn't exist
    lda EndTimerEnemyIsEnabled
    beq @endIf_D
    ; branch if timer enemy is in the current nametable
    lda EndTimerEnemyHi
    eor $02
    lsr
    bcs @endIf_D
        ; timer enemy is in the opposite nametable
        ; clear status
        lda #$00
        sta EndTimerEnemyIsEnabled
    @endIf_D:
    rts

UpdateRoomSpriteInfo_Tourian_RinkaSpawner:
    ; exit if rinka spawner doesn't exist
    lda RinkaSpawners.0.status,x
    bmi @RTS
    ; exit if rinka is in the current nametable
    lda RinkaSpawners.0.hi,x
    eor $02
    lsr
    bcs @RTS
        ; rinka is in the opposite nametable
        ; clear status
        lda #$FF
        sta RinkaSpawners.0.status,x
    @RTS:
    rts

;-------------------------------------------------------------------------------
; Spawns a new Tourian cannon into first available cannon slot
; ($00),y is a pointer to special items data
SpawnCannonRoutine:
    ldx #$00
    @loop:
        lda Cannons.0.status,x
        beq @spawnCannon
        txa
        clc
        adc #$08
        tax
        bpl @loop
    ; cannon failed to spawn, because all 16 slots are occupied
    bmi @RTS ; always return

@spawnCannon:
    ; high nibble of special item type is Cannons.0.instrListID
    lda ($00),y
    jsr Adiv16_
    sta Cannons.0.instrListID,x
    
    lda #$01
    sta Cannons.0.status,x
    sta Cannons.0.instrID,x
    
    ; set Y and X
    iny
    lda ($00),y
    pha
    and #$F0
    ora #$07
    sta Cannons.0.y,x
    pla
    jsr Amul16_
    ora #$07
    sta Cannons.0.x,x
    
    ; set nametable for edge of the screen that scrolls in
    jsr GetNameTableAtScrollDir_
    sta Cannons.0.hi,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Mother Brain Handler
SpawnMotherBrainRoutine:
    lda #$01
    sta MotherBrainStatus
    jsr GetNameTableAtScrollDir_
    sta MotherBrainHi
    eor #$01
    tax
    lda L9D3C
    ora ScrollBlockOnNameTable3,x
    sta ScrollBlockOnNameTable3,x
    lda #$20
    sta MotherBrainAnimBrainDelay
    sta MotherBrainAnimEyeDelay
    rts

L9D3B:  .byte $02
L9D3C:  .byte $01

;-------------------------------------------------------------------------------
; Spawns a new Zebetite into Zebetite slot
; ($00),y is a pointer to special items data
SpawnZebetiteRoutine:
    ; get zebetite slot from special item type high nibble
    lda ($00),y
    and #$F0
    lsr
    tax
    ; set vram pointer to zebetite's top-left tile in the nametable
    asl
    and #$10
    eor #$10
    ora #$84
    sta ZebetiteVRAMPtr,x
    jsr GetVRAMPtrHi
    sta ZebetiteVRAMPtr+1,x
    
    lda #$01
    sta ZebetiteStatus,x
    
    lda #$00
    sta ZebetiteQtyHits,x
    sta ZebetiteHealingDelay,x
    sta ZebetiteIsHit,x
    rts

GetVRAMPtrHi:
    jsr GetNameTableAtScrollDir_
    asl
    asl
    ora #$21+$40
    rts

;-------------------------------------------------------------------------------
; Rinka Handler
SpawnRinkaSpawnerRoutine:
    ldx #$03
    jsr L9D75
        bmi RTS_9D87
        ldx #$00
    L9D75:
    lda RinkaSpawners.0.status,x
    bpl RTS_9D87
    lda ($00),y
    jsr Adiv16_
    sta RinkaSpawners.0.status,x
    jsr GetNameTableAtScrollDir_
    sta RinkaSpawners.0.hi,x
    lda #$FF
RTS_9D87:
    rts

GetNameTableAtScrollDir_:
    lda PPUCTRL_ZP
    eor ScrollDir
    and #$01
    rts

CannonInstrDelayTable:
    .byte $28
    .byte $28
    .byte $28
    .byte $28
    .byte $28

CannonInstrListsOffset:
    .byte CannonInstrList0 - CannonInstrLists
    .byte CannonInstrList1 - CannonInstrLists
    .byte CannonInstrList2 - CannonInstrLists
    .byte CannonInstrList3 - CannonInstrLists
    .byte CannonInstrList4 - CannonInstrLists

; #$00-#$07 is angles, #$FC-$FE is shooting a bullet, #$FF is end
CannonInstrLists:
CannonInstrList0: .byte $00, $01, $02, $FD, $03, $04, $FD, $03, $02, $01, $FF
CannonInstrList1: .byte $00, $07, $06, $FE, $05, $04, $FE, $05, $06, $07, $FF
CannonInstrList2: .byte $02, $03, $FC, $04, $05, $06, $05, $FC, $04, $03, $FF
CannonInstrList3: .byte $02, $03, $FC, $04, $03, $FF
CannonInstrList4: .byte $06, $05, $FC, $04, $05, $FF
; cannon instr list 5 means the cannon won't do anything

CannonAnimFrameTable:
    .byte _id_EnFrame06
    .byte _id_EnFrame07
    .byte _id_EnFrame08
    .byte _id_EnFrame09
    .byte _id_EnFrame0A
    .byte _id_EnFrame0B
    .byte _id_EnFrame0C
    .byte _id_EnFrame0D

CannonFireballXOffsetTable:
    .byte $09 ; cannon instr #$FE : diagonal right
    .byte $F7 ; cannon instr #$FD : diagonal left
    .byte $00 ; cannon instr #$FC : straight down
CannonFireballYOffsetTable:
    .byte $09 ; cannon instr #$FE : diagonal right
    .byte $09 ; cannon instr #$FD : diagonal left
    .byte $0B ; cannon instr #$FC : straight down

;-------------------------------------------------------------------------------
; This is code:
MotherBrainStatusHandler:
    lda MotherBrainStatus
    beq RTS_9DF1
    jsr CommonJump_ChooseRoutine
        .word Exit__    ;#$00=Mother brain not in room,
        .word MotherBrain_9E22     ;#$01=Mother brain in room
        .word MotherBrain_9E36     ;#$02=Mother brain hit
        .word MotherBrain_9E52     ;#$03=Mother brain dying
        .word MotherBrain_9E86     ;#$04=Mother brain dissapearing
        .word MotherBrain_9F02_05     ;#$05=Mother brain gone
        .word MotherBrain_9F49     ;#$06=Time bomb set,
        .word MotherBrain_9FC0     ;#$07=Time bomb exploded
        .word MotherBrain_9F02_08     ;#$08=Initialize mother brain
        .word MotherBrain_9FDA     ;#$09
        .word Exit__    ;#$0A=Mother brain already dead.
RTS_9DF1:
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E22_CollideWithSamus:
    ; exit if samus is not in the same nametable as mother brain
    lda ObjHi
    eor MotherBrainHi
    bne RTS_9DF1
    ; exit if samus x pos is not in range #$48 to #$76 inclusive
    lda ObjX
    sec
    sbc #$48
    cmp #$2F
    bcs RTS_9DF1
    ; exit if samus y pos is not in range #$61 to #$9F inclusive
    lda ObjY
    sec
    sbc #$80
    bpl L9E0E
        jsr TwosComplement_
    L9E0E:
    cmp #$20
    bcs RTS_9DF1
    
    ; samus is touching mother brain
    ; deal 20 damage to samus
    lda #$00
    sta HealthChange
    lda #$02
    sta HealthChange+1.b
    lda #$38
    sta SamusIsHit
    jmp CommonJump_SubtractHealth

;-------------------------------------------------------------------------------
MotherBrain_9E22:
    jsr MotherBrain_9E22_CollideWithSamus
    jsr MotherBrain_9E22_HandleBeingHit
    jsr MotherBrain_9E22_UpdateAnimBrain
    jsr MotherBrain_9E22_UpdateAnimEye
L9E2E:
    jsr MotherBrain_DrawSprites
ClearMotherBrainIsHit:
    lda #$00
    sta MotherBrainIsHit
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E36:
    jsr UpdateMotherBrainFlashDelay
    lda MotherBrainFlashPalettesTable,y
    sta PalDataPending
    jmp ClearMotherBrainIsHit

MotherBrainFlashPalettesTable:
    .byte _id_Palette07+1, _id_Palette06+1

UpdateMotherBrainFlashDelay:
    ; decrement delay
    dec MotherBrainFlashDelay
    ; branch if delay is not zero
    bne L9E4B
        ; flash delay is zero, mother brain stops flashing
        ; change state of mother brain to idle
        lda #$01
        sta MotherBrainStatus
    L9E4B:
    ; save bit 1 of delay to y
    lda MotherBrainFlashDelay
    and #$02
    lsr
    tay
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E52:
    jsr UpdateMotherBrainFlashDelay
    lda MotherBrainFlashPalettesTable,y
    sta PalDataPending
    tya
    asl
    asl
    sta ScrollY
    ldy MotherBrainStatus
    dey
    bne L9E83
    sty MotherBrainQtyHits
    tya
    tax
    L9E68:
        tya
        sta EnsExtra.0.status,x
        jsr Xplus16
        cpx #$C0
        bne L9E68
    lda #$04
    sta MotherBrainStatus
    lda #$28
    sta MotherBrainFlashDelay
    lda NoiseSFXFlag
    ora #sfxNoise_SilenceMusic
    sta NoiseSFXFlag
L9E83:
    jmp L9E2E

;-------------------------------------------------------------------------------
MotherBrain_9E86:
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    jsr MotherBrain_Disintegrate
    inc MotherBrainAnimBrainDelay
    jsr UpdateMotherBrainFlashDelay
    ldx #$00
    L9E98:
        lda EnsExtra.0.status,x
        cmp #$05
        bne L9EA4
            lda #$00
            sta EnsExtra.0.status,x
        L9EA4:
        jsr Xplus16
        cmp #$40
        bne L9E98
    lda PPUStrIndex
    bne L9EB5
        lda L9F00,y
        sta PalDataPending
    L9EB5:
    ldy MotherBrainStatus
    dey
    bne RTS_9ED5
    sty MotherBrainAnimBrainDelay
    lda #$04
    sta MotherBrainStatus
    lda #$1C
    sta MotherBrainFlashDelay
    ldy MotherBrainQtyHits
    inc MotherBrainQtyHits
    cpy #$04
    beq L9ED3
        ldx #$00
        bcc RTS_9ED5
        jmp L9ED6

    L9ED3:
    lsr MotherBrainFlashDelay
RTS_9ED5:
    rts

L9ED6:
    lda MusicInitFlag
    ora #music_Escape
    sta MusicInitFlag
    lda #$05
    sta MotherBrainStatus
    lda #$80
    sta MotherBrainQtyHits
    rts

; high nybble of a is y position
; low nybble of a is x position
SpawnRinka_InitPositionXY:
    pha
    ; y position = (high nybble * #$10) + #$07
    and #$F0
    ora #$07
    sta EnY,x
    pla
    ; x position = (low nybble * #$10) + #$07
    jsr Amul16_
    ora #$07
    sta EnX,x
    rts

Xplus16:
    txa
    clc
    adc #$10
    tax
    rts

    ; unused
    rts

L9F00: .byte _id_Palette08+1, _id_Palette09+1

;-------------------------------------------------------------------------------
MotherBrain_9F02_05:
MotherBrain_9F02_08:
    lda MotherBrainQtyHits
    bmi L9F33
        cmp #$08
        beq L9F36
        tay
        lda L9F41,y
        sta TileBlastAnimFrame
        lda L9F39,y
        clc
        adc #$42
        sta TileBlastWRAMPtr
        php
        lda MotherBrainHi
        asl
        asl
        plp
        adc #$61
        sta TileBlastWRAMPtr+1
        lda #$00
        sta PageIndex
        lda PPUStrIndex
        bne RTS_9F38
        jsr CommonJump_DrawTileBlast
        bcs RTS_9F38
    L9F33:
    inc MotherBrainQtyHits
    rts

L9F36:
    inc MotherBrainStatus
RTS_9F38:
    rts

L9F39:  .byte $00, $40, $08, $48, $80, $C0, $88, $C8
L9F41:  .byte $08, $02, $09, $03, $0A, $04, $0B, $05

MotherBrain_9F49:
    jsr MotherBrain_SpawnDoor
    bcs RTS_9F64
    lda #$00
    sta MotherBrainStatus
    lda #$99
    sta EndTimer
    sta EndTimer+1
    lda #$01
    sta EndTimerEnemyIsEnabled
    lda MotherBrainHi
    sta EndTimerEnemyHi
RTS_9F64:
    rts

L9F65:  .byte $80, $B0, $A0, $90

MotherBrain_SpawnDoor:
    ; get obj slot
    lda SamusMapPosX
    clc
    adc SamusMapPosY
    sec
    rol
    and #$03
    tay
    ldx L9F65,y
    ; door closes immediately
    lda #$01
    sta DoorHitPoints,x
    ; blue door
    lda #$01
    sta DoorType,x
    ; door action = open
    lda #$03
    sta ObjAction,x
    ; set door coords
    lda MotherBrainHi
    sta ObjHi,x
    lda #$10
    sta ObjX,x
    lda #$68
    sta ObjY,x
    ; init door animation (garbage, 1/2 chance it plays only for 1 frame)
    lda #ObjAnim_55 - ObjectAnimIndexTbl.b
    sta ObjAnimResetIndex,x
    sta ObjAnimIndex,x
    lda #$00
    sta ObjAnimDelay,x
    lda #$F7
    sta ObjAnimFrame,x
    ; create door tiles
    lda #$10
    sta TileBlastAnimFrame
    lda #$40
    sta TileBlastWRAMPtr
    lda MotherBrainHi
    asl
    asl
    ora #$61
    sta TileBlastWRAMPtr+1
    lda #$00
    sta PageIndex
    jmp CommonJump_DrawTileBlast

;-------------------------------------------------------------------------------
MotherBrain_9FC0:
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    lda Timer3
    bne RTS_9FD9
    lda #$08
    sta ObjAction
    lda #$0A
    sta MotherBrainStatus
    lda #_id_Palette00+1.b
    sta PalDataPending
RTS_9FD9:
    rts

;-------------------------------------------------------------------------------
MotherBrain_9FDA:
    jsr MotherBrain_SpawnDoor
    bcs RTS_9FEC
    lda MotherBrainHi
    sta EndTimerEnemyHi
    ldy #$01
    sty EndTimerEnemyIsEnabled
    dey
    sty MotherBrainStatus
RTS_9FEC:
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E22_HandleBeingHit:
    ; exit if mother brain was not hit
    lda MotherBrainIsHit
    beq @RTS
    
    ; play boss hit sfx
    lda MultiSFXFlag
    ora #sfxMulti_BossHit
    sta MultiSFXFlag
    ; increment mother brain hits quantity
    inc MotherBrainQtyHits
    ; exit if hits quantity is less than 32
    lda MotherBrainQtyHits
    cmp #$20
    ldy #$02 ; default mb status to hit
    lda #$10 ; default mb flash time to 16 frames
    bcc @notDead
        ; hits quantity is 32 or greater
        ; mother brain must start to die
        
        ; clear all tile blasts
        ldx #$00
        @loop:
            lda #$00
            sta TileBlastRoutine,x
            jsr Xplus16
            cmp #$D0
            bne @loop
        ; set mother brain status to dying
        iny
        ; set flashing delay to 128 frames
        lda #$80
    @notDead:
    sty MotherBrainStatus
    sta MotherBrainFlashDelay
@RTS:
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E22_UpdateAnimBrain:
    ; decrement brain delay
    dec MotherBrainAnimBrainDelay
    ; exit if brain delay is not zero
    bne @RTS
    
    ; set brain frame to one of four randomly chosen frames from MotherBrainAnimFrameTable
    lda RandomNumber1
    and #$03
    sta MotherBrainAnimFrameTableID
    
    ; set brain delay depending on how many hits are left until mother brain dies
    lda #$20
    sec
    sbc MotherBrainQtyHits
    lsr
    sta MotherBrainAnimBrainDelay
@RTS:
    rts

;-------------------------------------------------------------------------------
MotherBrain_9E22_UpdateAnimEye:
    ; decrement eye delay
    dec MotherBrainAnimEyeDelay
    ; exit if eye delay is not #$00 or #$80
    lda MotherBrainAnimEyeDelay
    asl
    bne @RTS
    
    ; set eye delay depending on how many hits are left until mother brain dies
    ; also toggle bit 7 of eye delay
    lda #$20
    sec
    sbc MotherBrainQtyHits
    ora #$80
    eor MotherBrainAnimEyeDelay
    sta MotherBrainAnimEyeDelay
@RTS:
    rts

;-------------------------------------------------------------------------------
MotherBrain_DrawSprites:
    ; set PageIndex to mother brain enemy slot
    lda #$E0
    sta PageIndex
    ; set mother brain enemy pos to hardcoded constants
    lda MotherBrainHi
    sta EnsExtra.14.hi
    lda #$70
    sta EnY+$E0
    lda #$48
    sta EnX+$E0
    ; update mother brain anim frame
    ldy MotherBrainAnimFrameTableID
    lda MotherBrainAnimFrameTable,y
    sta EnsExtra.14.animFrame
    ; draw mother brain enemy
    jsr CommonJump_DrawEnemy
    
    ; branch if bit 7 of eye delay is set
    lda MotherBrainAnimEyeDelay
    bmi @endIf_A
        ; bit 7 is not set, eyes are open
        ; draw the eyes of mother brain
        lda MotherBrainAnimFrameTable+4
        sta EnsExtra.14.animFrame
        jsr CommonJump_DrawEnemy
    @endIf_A:
    rts

; animation frame id table
MotherBrainAnimFrameTable:
; pulsations on the brain
    .byte _id_EnFrame13
    .byte _id_EnFrame14
    .byte _id_EnFrame15
    .byte _id_EnFrame16

; mother brain's eyes
    .byte _id_EnFrame17

MotherBrain_Disintegrate:
    ; exit if mother brain disintegration step is zero
    ldy MotherBrainDeathStringID
    beq @RTS
    ; get MotherBrainDeathString offset
    lda MotherBrainDeathStringOffsets-1,y
    clc
    adc MotherBrainDeathInstrID
    tay
    ; get byte from MotherBrainDeathString
    lda MotherBrainDeathString,y
    ; branch if not #$FF
    cmp #$FF
    bne @disintegrate
    ; byte is #$FF, the instruction string has ended
    ; dont increment to next byte
    dec MotherBrainDeathInstrID
@RTS:
    rts

@disintegrate:
    ; add ($6144 + MotherBrainHi*$0400) to byte
    adc #$44
    sta TileBlastWRAMPtr
    php
    lda MotherBrainHi
    asl
    asl
    ora #$61
    plp
    adc #$00
    sta TileBlastWRAMPtr+1
    ; clear 2x2 tile region at that location
    lda #$00
    sta TileBlastAnimFrame
    sta PageIndex
    jmp CommonJump_DrawTileBlast

MotherBrainDeathString:
MotherBrainDeathString_1:
    .byte $6144 - $6144
    .byte $6146 - $6144
    .byte $6148 - $6144
    .byte $614A - $6144
    .byte $614C - $6144
    .byte $6184 - $6144
    .byte $61C4 - $6144
    .byte $6204 - $6144
    .byte $618C - $6144
    .byte $61CC - $6144
    .byte $620C - $6144
    .byte $FF
MotherBrainDeathString_2:
    .byte $6186 - $6144
    .byte $61C5 - $6144
    .byte $6205 - $6144
    .byte $616B - $6144
    .byte $FF
MotherBrainDeathString_3:
    .byte $61C6 - $6144
    .byte $6187 - $6144
    .byte $6169 - $6144
    .byte $618B - $6144
    .byte $FF
MotherBrainDeathString_4:
    .byte $6206 - $6144
    .byte $6208 - $6144
    .byte $620A - $6144
    .byte $FF
MotherBrainDeathString_5:
    .byte $61C8 - $6144
    .byte $6189 - $6144
    .byte $61CA - $6144
    .byte $FF

MotherBrainDeathStringOffsets:
    .byte MotherBrainDeathString_1 - MotherBrainDeathString
    .byte MotherBrainDeathString_2 - MotherBrainDeathString
    .byte MotherBrainDeathString_3 - MotherBrainDeathString
    .byte MotherBrainDeathString_4 - MotherBrainDeathString
    .byte MotherBrainDeathString_5 - MotherBrainDeathString

;-------------------------------------------------------------------------------
;$04-$05 is pointer to projectile's location in the room vram buffers
UpdateBullet_CollisionWithZebetiteAndMotherBrainGlass:
    ; exit if not updating a projectile
    lda UpdatingProjectile
    beq @exit
    ; exit if not a missile
    ldx PageIndex
    lda ObjAction,x
    cmp #wa_Missile
    bne @exit
    ; branch if tile id is not #$98 (mother brain glass)
    cpy #$98
    bne @checkZebetite
        ; tile is #$98, mother brain glass must be destroyed
        ; find open TileBlast slot
        ldx #$00
        @loop_Slot:
            lda TileBlastRoutine,x
            beq @slotFound
            ; slot occupied, try next slot
            jsr Xplus16
            cmp #$D0
            bne @loop_Slot
        ; no slots found, exit
        beq @exit ; branch always

        @slotFound:
        ; set pointer
        lda #$8C
        sta TileBlastWRAMPtr,x
        lda Temp04_CartRAMPtr+1.b
        sta TileBlastWRAMPtr+1,x
        ; set to clear 2x3 tile region
        lda #$01
        sta TileBlastAnimFrame,x
        ; push current samus projectile slot
        lda PageIndex
        pha
        ; set TileBlast slot
        stx PageIndex
        ; go remove the glass shield
        jsr CommonJump_DrawTileBlast
        ; restore projectile slot
        pla
        sta PageIndex
        bne @exit ; branch always

    @checkZebetite:
        ; tile is not #$98, check if samus shot a zebetite
        ; $04 = $04 & #$FE
        lda Temp04_CartRAMPtr
        lsr
        bcc @endIf_andFE
            dec Temp04_CartRAMPtr
        @endIf_andFE:
        ; load tile id of left tile of block samus shot
        ldy #$00
        lda (Temp04_CartRAMPtr),y
        ; exit if bit 0 of tile id is set (not the case for zebetites)
        lsr
        bcs @exit
        ; exit if not in the range #$90 to #$97 inclusive
        cmp #$90>>1
        bcc @exit
        cmp #$98>>1
        bcs @exit
        ; samus shot a zebetite tile with a missile
        ; loop through zebetites to find the one she shot
        @loop_Zebetite:
            ; if zebetite is active
            lda ZebetiteStatus,y
            beq @notTheRightZebetite
            ; and if missile is touching that zebetite
            lda Temp04_CartRAMPtr
            and #$9E
            cmp ZebetiteVRAMPtr,y
            bne @notTheRightZebetite
            lda Temp04_CartRAMPtr+1.b
            cmp ZebetiteVRAMPtr+1,y
            beq @theRightZebetite
            @notTheRightZebetite:
                ; missile is not touching that zebetite
                ; check again for next zebetite
                tya
                clc
                adc #$08
                tay
                cmp #$28
                bne @loop_Zebetite
                ; no more zebetites to loop through, exit
                beq @exit
            @theRightZebetite:
                ; set zebetite flag to indicate it got hit
                lda #$01
                sta ZebetiteIsHit,y
@exit:
    pla
    pla
    clc
    rts

;-------------------------------------------------------------------------------
; params: a is tile id
UpdateBullet_CollisionWithMotherBrain:
    ; y = tile id
    tay
    ; exit if we are not updating samus projectile
    lda UpdatingProjectile
    beq @exit
    ldx PageIndex
    ; exit if projectile status is not #$0B (missile?)
    lda ProjectileStatus,x
    cmp #wa_Missile
    bne @exit
    ; exit if tile id < $5E
    cpy #$5E
    bcc @exit
    ; exit if tile id >= $72
    cpy #$72
    bcs @exit
    ; bullet is overlapping mother brain's tiles
    ; mother brain is hit!
    lda #$01
    sta MotherBrainIsHit
@exit:
    ; a = tile id
    tya
RTS_A15D:
    rts

;-------------------------------------------------------------------------------
UpdateAllRinkaSpawners:
    ; exit if timer is active
    ldy EndTimer+1
    iny
    bne RTS_A1DA
    
    ; run subroutine for the second rinka spawner
    ldy #$03
    jsr @subroutine
    
    ; run subroutine for the first rinka spawner
    ldy #$00
@subroutine:
    sty PageIndex
    
    ; exit if rinka spawner is inactive
    lda RinkaSpawners.0.status,y
    bmi RTS_A15D
    
    ; exit if RinkaSpawners.0.hi == bit 0 of FrameCount
    ; (maybe to alternate which rinka spawner is processed each frame?)
    lda RinkaSpawners.0.hi,y
    eor FrameCount
    lsr
    bcc RTS_A15D
    
    ; exit if mother brain is dying or dead
    lda MotherBrainStatus
    cmp #$04
    bcs RTS_A15D
    
    ; exit if framecount modulo 8 is not 0 or 1
    lda FrameCount
    and #$06
    bne RTS_A15D
    
    ; attempt to spawn a rinka
    ; search for an open enemy slot in the first three enemy slots
    ldx #$20
    @loop:
        ; use slot if no enemy in slot or enemy is invisible
        lda EnsExtra.0.status,x
        beq @slotFound
        lda EnData05,x
        and #$02
        beq @slotFound
        ; slot occupied, try next slot
        txa
        sec
        sbc #$10
        tax
        bpl @loop
    ; no open slot found, exiting
    rts

@slotFound:
    ; set rinka status to resting
    lda #enemyStatus_Resting
    sta EnsExtra.0.status,x
    ; set rinka enemy type to rinka
    lda #$04
    sta EnsExtra.0.type,x
    ; init more rinka stuff idk
    lda #$00
    sta EnSpecialAttribs,x
    sta EnIsHit,x
    jsr CommonJump_0E
    ; set rinka frame to nothing (it will fade into view)
    lda #$F7
    sta EnsExtra.0.animFrame,x
    ; init rinka position
    ldy PageIndex
    lda RinkaSpawners.0.hi,y
    sta EnsExtra.0.hi,x
    lda RinkaSpawners.0.posIndex,y
    asl
    ora RinkaSpawners.0.status,y
    tay
    lda RinkaSpawnPosTbl,y
    jsr SpawnRinka_InitPositionXY
    ; increment rinka spawner position id
    ldx PageIndex
    inc RinkaSpawners.0.posIndex,x
    lda RinkaSpawners.0.posIndex,x
    cmp #$06
    bne RTS_A1DA
    lda #$00
LA1D8:
    sta RinkaSpawners.0.posIndex,x
RTS_A1DA:
    rts

; X in low nibble, Y in high nibble
RinkaSpawnPosTbl:
    .byte $22, $2A
    .byte $2A, $BA
    .byte $B2, $2A
    .byte $C4, $2A
    .byte $C8, $BA
    .byte $BA, $BA

;-------------------------------------------------------------------------------
UpdateEndTimer:
    ; exit if timer is inactive
    ldy EndTimer+1
    iny
    beq @RTS
    
    ; BCD decrement low byte of timer
    lda EndTimer
    sta $03
    lda #$01
    sec
    jsr CommonJump_Base10Subtract
    sta EndTimer
    ; BCD decrement high byte of timer if overflow
    lda EndTimer+1
    sta $03
    lda #$00
    jsr CommonJump_Base10Subtract
    sta EndTimer+1
    
    ; play alarm sound effect every 32 frames
    lda FrameCount
    and #$1F
    bne @endIf_A
        lda SQ1SFXFlag
        ora #sfxSQ1_OutOfHole
        sta SQ1SFXFlag
    @endIf_A:
    
    ; exit if timer didn't become zero
    lda EndTimer
    ora EndTimer+1
    bne @RTS
    
    ; timer became zero, the time bomb exploded and samus failed to escape in time
    ; disable timer
    dec EndTimer+1
    ; reset mother brain health
    sta MotherBrainQtyHits
    ; set mother brain state to bomb exploded
    lda #$07
    sta MotherBrainStatus
    ; silence music
    lda NoiseSFXFlag
    ora #sfxNoise_SilenceMusic
    sta NoiseSFXFlag
    ; set timer for 120 frames (2 seconds)
    lda #$0C
    sta Timer3
    ; set palette to all white
    lda #_id_Palette0A+1.b
    sta PalDataPending
@RTS:
    rts

;-------------------------------------------------------------------------------
; the end timer that is part of the "TIME BOMB SET" message
DrawEndTimerEnemy:
    ; exit if end timer enemy is not enabled
    lda EndTimerEnemyIsEnabled
    beq RTS_A28A

    ; attempt to draw end timer enemy sprite
    lda EndTimerEnemyHi
    sta EnsExtra.14.hi
    lda #$84
    sta EnY+$E0
    lda #$64
    sta EnX+$E0
    lda #_id_EnFrame1A.b
    sta EnsExtra.14.animFrame
    lda #$E0
    sta PageIndex
    ; remember page pos for later
    lda SpritePagePos
    pha
    jsr CommonJump_DrawEnemy
    ; exit if past page pos is the same as current page pos (sprite failed to draw)
    pla
    cmp SpritePagePos
    beq RTS_A28A
    
    tax
    ; set tile of hundreds digit
    lda EndTimer+1
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+($00<<2)+$01,x
    ; set tile of tens digit
    lda EndTimer+1
    and #$0F
    ora #$A0
    sta SpriteRAM+($01<<2)+$01,x
    ; set tile of ones digit
    lda EndTimer
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+($02<<2)+$01,x
RTS_A28A:
    rts

;-------------------------------------------------------------------------------
UpdateAllZebetites:
    lda #$10
    sta PageIndex
    ; run UpdateZebetite for all zebetite slots
    ldx #$20
    @loop:
        jsr UpdateZebetite
        txa
        sec
        sbc #$08
        tax
        bne @loop
UpdateZebetite:
    ; return if status is not #$x1
    lda ZebetiteStatus,x
    and #$0F
    cmp #$01
    bne RTS_A28A
    
    ; check if zebetite just got hit
    lda ZebetiteIsHit,x
    beq LA2F2
    
    ; zebetite was just hit
    ; increase hits count
    inc ZebetiteQtyHits,x
    lda ZebetiteQtyHits,x
    ; check if hits count is even or odd
    lsr
    bcs LA2F2
    ; hit count is even
    ; update zebetite appearance
    tay
    sbc #$03
    bne LA2BA
    inc ZebetiteStatus,x
LA2BA:
    ; set anim frame
    lda ZebetiteAnimFrameTable,y
    sta TileBlastAnimFrame+$10
    ; set vram pointer
    lda ZebetiteVRAMPtr,x
    sta TileBlastWRAMPtr+$10
    lda ZebetiteVRAMPtr+1,x
    sta TileBlastWRAMPtr+1+$10
    ; if a ppu string is in the buffer, dont update gfx
    lda PPUStrIndex
    bne LA2DA
        ; ppu string buffer is empty
        ; update zebetite gfx
        txa
        pha
        jsr CommonJump_DrawTileBlast
        pla
        tax
        ; (when is the carry flag set/unset here?)
        bcc LA2EB
    LA2DA:
    lda ZebetiteStatus,x
    and #$80
    ora #$01
    sta ZebetiteStatus,x
    sta ZebetiteIsHit,x
    dec ZebetiteQtyHits,x
    rts

LA2EB:
    ; reset healing delay to max
    lda #$40
    sta ZebetiteHealingDelay,x
    bne LA30A ; branch always

LA2F2:
    ; dont heal if at full health
    ldy ZebetiteQtyHits,x
    beq LA30A
    ; dont heal if healing delay is not zero
    dec ZebetiteHealingDelay,x
    bne LA30A
    
    ; reset delay and heal one hit
    lda #$40
    sta ZebetiteHealingDelay,x
    dey
    tya
    sta ZebetiteQtyHits,x
    ; if hits count is odd, update zebetite appearance
    lsr
    tay
    bcc LA2BA
LA30A:
    lda #$00
    sta ZebetiteIsHit,x
    rts

ZebetiteAnimFrameTable:
    .byte $0C, $0D, $0E, $0F, $07

;-------------------------------------------------------------------------------
; Samus no longer has a metroid on her
ClearAllMetroidLatches:
    ldy #$05
    LA317:
        jsr ClearMetroidLatch
        dey
        bpl LA317
    sta $92
    rts

ClearCurrentMetroidLatchAndMetroidOnSamus:
    txa
    jsr Adiv16_
    tay
    jsr ClearMetroidLatch
    sta MetroidOnSamus
    rts

;-------------------------------------------------------------------------------

TileBlastFrame00:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01:
    .byte $32
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame02: ; GET OU
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $E0, $DE, $ED, $FF, $E8, $EE

TileBlastFrame03: ; T FAST!
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $ED, $FF, $DF, $DA, $EC, $ED, $F4, $FF

TileBlastFrame04: ; TIME
    .byte $28
    .byte $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

TileBlastFrame05:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

TileBlastFrame06:
    .byte $62
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame07:
    .byte $42
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame08: ; TIME B
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $ED, $E2, $E6, $DE, $FF, $DB

TileBlastFrame09: ; OMB SET
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $E8, $E6, $DB, $FF, $EC, $DE, $ED, $FF

TileBlastFrame0A:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

TileBlastFrame0B:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

TileBlastFrame0C:
    .byte $42
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91

TileBlastFrame0D:
    .byte $42
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93

TileBlastFrame0E:
    .byte $42
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95

TileBlastFrame0F:
    .byte $42
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97

TileBlastFrame10:
    .byte $62
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0

.include "tourian/enemy_sprite_data.asm"

;-----------------------------------------[ Palette data ]-------------------------------------------

.include "tourian/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "tourian/room_ptrs.asm"

.include "tourian/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "tourian/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "tourian/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "tourian/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "tourian/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/escape.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/escape.asm"
.endif

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/mthr_brn_room.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/mthr_brn_room.asm"
.endif

;Unused tile patterns.
.if BUILDTARGET == "NES_NTSC"
    .byte $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0
    .byte $2C, $23, $20, $20, $30, $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30
    .byte $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $01, $00, $00, $00, $00, $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80
    .byte $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04
    .byte $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $CA, $F0, $05, $4A, $4A
.endif


.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .section "ROM Bank $003 - Music Engine" bank 3 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $003 - Music Engine" bank 3 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $003 - Vectors" bank 3 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

