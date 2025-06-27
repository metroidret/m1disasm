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
.SECTION "ROM Bank $003" BANK 3 SLOT "ROMSwitchSlot" ORGA $8000 FORCE

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_KraidSprites:
    .incbin "kraid/sprite_tiles.chr" ; 8D60 - Kraid Sprite CHR
GFX_RidleySprites:
    .incbin "ridley/sprite_tiles.chr" ; 9160 - Ridley Sprite CHR

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A718)
    .word Palette01                 ;($A73C)
    .word Palette02                 ;($A748)
    .word Palette03                 ;($A742)
    .word Palette04                 ;($A74E)
    .word Palette05                 ;($A754)
    .word Palette05                 ;($A754)
    .word Palette06                 ;($A759)
    .word Palette07                 ;($A75E)
    .word Palette08                 ;($A773)
    .word Palette09                 ;($A788)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0B                 ;($A794)
    .word Palette0C                 ;($A79B)
    .word Palette0D                 ;($A7A2)
    .word Palette0E                 ;($A7A9)
    .word Palette0F                 ;($A7B1)
    .word Palette10                 ;($A7B9)
    .word Palette11                 ;($A7C1)
    .word Palette12                 ;($A7C9)

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
GotoL9C6F:
    jmp L9C6F
GotoSpawnCannonRoutine:
    jmp SpawnCannonRoutine
GotoSpawnMotherBrainRoutine:
    jmp SpawnMotherBrainRoutine
GotoSpawnZebetiteRoutine:
    jmp SpawnZebetiteRoutine
GotoSpawnRinkaSpawnerRoutine:
    jmp SpawnRinkaSpawnerRoutine
GotoLA0C6:
    jmp LA0C6
GotoUpdateBullet_CollisionWithMotherBrain:
    jmp UpdateBullet_CollisionWithMotherBrain

AreaRoutine:
    jmp L9B25                       ;Area specific routine.

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
    .byte $06

    .byte $00
AreaFireballAnimIndex:
    .byte EnAnim_03 - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_21 - EnAnimTbl

    .byte $00, $00
AreaFireballFallingAnimIndex:
    .byte $00, $00
AreaFireballSplatterAnimIndex:
    .byte $00, $10
AreaMellowAnimIndex:
    .byte $00

; Enemy AI Jump Table
ChooseEnemyAIRoutine:
    lda EnType,x
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

EnemyHitPointTbl:
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

L96AB:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

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
    sta EnStatus,x
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
L9B25:
    jsr L9B37
    jsr MotherBrainStatusHandler
    jsr LA1E7
    jsr LA238
    jsr ZebetiteA28B
    jmp LA15E

;-------------------------------------------------------------------------------
L9B37:
    ldx #$78
    L9B39:
        jsr L9B44
        lda CannonIndex
        sec
        sbc #$08
        tax
        bne L9B39

L9B44:
    stx CannonIndex
    ldy CannonStatus,x
    bne L9B4C
RTS_9B4B:
    rts

L9B4C:
    jsr L9C4D
    tya
    bne RTS_9B4B
    ldy EndTimer+1
    iny
    bne L9B65
    lda CannonInstrListID,x
    cmp #$05
    beq RTS_9B4B
    jsr L9B70
    jmp L9C2B

L9B65:
    lda FrameCount
    and #$02
    bne RTS_9B4B
    lda #$19
    jmp L9C31

L9B70:
    ldy CannonInstrListID,x
    lda CannonInstrDelay,x
    bne L9B81
        lda L9D8F,y
        sta CannonInstrDelay,x
        inc CannonInstrID,x
    L9B81:
    dec CannonInstrDelay,x
L9B84:
    lda CannonInstrListsOffset,y
    clc
    adc CannonInstrID,x
    tay
    lda CannonInstrLists,y
    bpl L9BAB
        cmp #$FF
        bne L9B9F
            ldy CannonInstrListID,x
            lda #$00
            sta CannonInstrID,x
            beq L9B84
        L9B9F:
        inc CannonInstrID,x
        jsr L9BAF
        ldy CannonInstrListID,x
        jmp L9B84

    L9BAB:
        sta CannonAngle,x
        rts

L9BAF:
    pha
    lda MotherBrainStatus
    cmp #$04
    bcs L9BC6
    ldy #$60
    L9BB8:
        lda EnStatus,y
        beq L9BC8
        tya
        clc
        adc #$10
        tay
        cmp #$A0
        bne L9BB8
L9BC6:
    pla
    rts

L9BC8:
    sty PageIndex
    lda CannonY,x
    sta EnY,y
    lda CannonX,x
    sta EnX,y
    lda CannonHi,x
    sta EnHi,y
    lda #$02
    sta EnStatus,y
    lda #$00
    sta EnDelay,y
    sta EnAnimDelay,y
    sta EnMovementIndex,y
    pla
    jsr TwosComplement_
    tax
    sta EnData0A,y
    ora #$02
    sta EnData05,y
    lda L9C28-2,x
    sta EnResetAnimIndex,y
    sta EnAnimIndex,y
    lda L9DCC,x
    sta $05
    lda L9DCF,x
    sta $04
    ldx CannonIndex
    lda CannonY,x
    sta $08
    lda CannonX,x
    sta $09
    lda CannonHi,x
    sta $0B
    tya
    tax
    jsr CommonJump_ApplySpeedToPosition
    jsr LoadPositionFromTemp
    ldx CannonIndex
    rts

L9C28:  .byte $0C, $0A, $0E

L9C2B:
    ldy CannonAngle,x
    lda L9DC6,y
L9C31:
    sta EnAnimFrame+$E0
    lda CannonY,x
    sta EnY+$E0
    lda CannonX,x
    sta EnX+$E0
    lda CannonHi,x
    sta EnHi+$E0
    lda #$E0
    sta PageIndex
    jmp CommonJump_DrawEnemy

L9C4D:
    ldy #$00
    lda CannonX,x
    cmp ScrollX
    lda ScrollDir
    and #$02
    bne L9C5F
        lda CannonY,x
        cmp ScrollY
    L9C5F:
    lda CannonHi,x
    eor PPUCTRL_ZP
    and #$01
    beq L9C6B
        bcs L9C6D
        sec
    L9C6B:
    bcs RTS_9C6E
L9C6D:
    iny
RTS_9C6E:
    rts

;-------------------------------------------------------------------------------
L9C6F:
    sty $02
    ldy #$00
    L9C73:
        lda CannonHi,y
        eor $02
        lsr
        bcs L9C80
            lda #$00
            sta CannonStatus,y
        L9C80:
        tya
        clc
        adc #$08
        tay
        bpl L9C73
    ldx #$00
    L9C89:
        lda ZebetiteStatus,x
        beq L9C99
        jsr GetVRAMPtrHi
        eor ZebetiteVRAMPtr+1,x
        bne L9C99
        sta ZebetiteStatus,x
        L9C99:
        txa
        clc
        adc #$08
        tax
        cmp #$28
        bne L9C89
    ldx #$00
    jsr L9CD6
    ldx #$03
    jsr L9CD6
    lda MotherBrainStatus
    beq L9CC3
    cmp #$07
    beq L9CC3
    cmp #$0A
    beq L9CC3
    lda MotherBrainNameTable
    eor $02
    lsr
    bcs L9CC3
    lda #$00
    sta MotherBrainStatus
L9CC3:
    lda MotherBrain010D
    beq RTS_9CD5
    lda MotherBrain010C
    eor $02
    lsr
    bcs RTS_9CD5
    lda #$00
    sta MotherBrain010D
RTS_9CD5:
    rts

L9CD6:
    lda $8B,x
    bmi RTS_9CE5
    lda $8C,x
    eor $02
    lsr
    bcs RTS_9CE5
    lda #$FF
    sta $8B,x
RTS_9CE5:
    rts

;-------------------------------------------------------------------------------
; Spawns a new Tourian cannon into first available cannon slot
; ($00),y is a pointer to special items data
SpawnCannonRoutine:
    ldx #$00
    @loop:
        lda CannonStatus,x
        beq @spawnCannon
        txa
        clc
        adc #$08
        tax
        bpl @loop
    ; cannon failed to spawn, because all 16 slots are occupied
    bmi @RTS ; always return

@spawnCannon:
    ; high nibble of special item type is CannonInstrListID
    lda ($00),y
    jsr Adiv16_
    sta CannonInstrListID,x
    
    lda #$01
    sta CannonStatus,x
    sta CannonInstrID,x
    
    ; set Y and X
    iny
    lda ($00),y
    pha
    and #$F0
    ora #$07
    sta CannonY,x
    pla
    jsr Amul16_
    ora #$07
    sta CannonX,x
    
    ; set nametable for edge of the screen that scrolls in
    jsr GetNameTable_
    sta CannonHi,x
@RTS:
    rts

;-------------------------------------------------------------------------------
; Mother Brain Handler
SpawnMotherBrainRoutine:
    lda #$01
    sta MotherBrainStatus
    jsr GetNameTable_
    sta MotherBrainNameTable
    eor #$01
    tax
    lda L9D3C
    ora DoorOnNameTable3,x
    sta DoorOnNameTable3,x
    lda #$20
    sta MotherBrain9A
    sta MotherBrain9B
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
    jsr GetNameTable_
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
    lda $8B,x
    bpl RTS_9D87
    lda ($00),y
    jsr Adiv16_
    sta $8B,x
    jsr GetNameTable_
    sta $8C,x
    lda #$FF
RTS_9D87:
    rts

GetNameTable_:
    lda PPUCTRL_ZP
    eor ScrollDir
    and #$01
    rts

L9D8F:  .byte $28, $28, $28, $28, $28

CannonInstrListsOffset:
    .byte CannonInstrList0 - CannonInstrLists
    .byte CannonInstrList1 - CannonInstrLists
    .byte CannonInstrList2 - CannonInstrLists
    .byte CannonInstrList3 - CannonInstrLists
    .byte CannonInstrList4 - CannonInstrLists

; #$00-#$07 is angles, #$FE is shooting a bullet, #$FF is end
CannonInstrLists:
CannonInstrList0: .byte $00, $01, $02, $FD, $03, $04, $FD, $03, $02, $01, $FF
CannonInstrList1: .byte $00, $07, $06, $FE, $05, $04, $FE, $05, $06, $07, $FF
CannonInstrList2: .byte $02, $03, $FC, $04, $05, $06, $05, $FC, $04, $03, $FF
CannonInstrList3: .byte $02, $03, $FC, $04, $03, $FF
CannonInstrList4: .byte $06, $05, $FC, $04, $05, $FF

L9DC6:  .byte $06, $07, $08, $09, $0A, $0B
L9DCC:  .byte $0C, $0D, $09

L9DCF:  .byte $F7, $00, $09, $09, $0B

;-------------------------------------------------------------------------------
; This is code:
MotherBrainStatusHandler:
    lda MotherBrainStatus
    beq RTS_9DF1
    jsr CommonJump_ChooseRoutine
        .word Exit__    ;#$00=Mother brain not in room,
        .word L9E22     ;#$01=Mother brain in room
        .word L9E36     ;#$02=Mother brain hit
        .word L9E52     ;#$03=Mother brain dying
        .word L9E86     ;#$04=Mother brain dissapearing
        .word L9F02     ;#$05=Mother brain gone
        .word L9F49     ;#$06=Time bomb set,
        .word L9FC0     ;#$07=Time bomb exploded
        .word L9F02     ;#$08=Initialize mother brain
        .word L9FDA     ;#$09
        .word Exit__    ;#$0A=Mother brain already dead.
RTS_9DF1:
    rts

;-------------------------------------------------------------------------------
L9DF2:
    lda ObjHi
    eor MotherBrainNameTable
    bne RTS_9DF1
    lda ObjX
    sec
    sbc #$48
    cmp #$2F
    bcs RTS_9DF1
    lda ObjY
    sec
    sbc #$80
    bpl L9E0E
        jsr TwosComplement_
    L9E0E:
    cmp #$20
    bcs RTS_9DF1
    lda #$00
    sta HealthChange
    lda #$02
    sta HealthChange+1.b
    lda #$38
    sta SamusIsHit
    jmp CommonJump_SubtractHealth

;-------------------------------------------------------------------------------
L9E22:
    jsr L9DF2
    jsr L9FED
    jsr LA01B
    jsr LA02E
L9E2E:
    jsr LA041
L9E31:
    lda #$00
    sta MotherBrainIsHit
    rts

;-------------------------------------------------------------------------------
L9E36:
    jsr L9E43
    lda L9E41,y
    sta PalDataPending
    jmp L9E31

L9E41:  .byte $08, $07

L9E43:
    dec MotherBrain9F
    bne L9E4B
        lda #$01
        sta MotherBrainStatus
    L9E4B:
    lda MotherBrain9F
    and #$02
    lsr
    tay
    rts

;-------------------------------------------------------------------------------
L9E52:
    jsr L9E43
    lda L9E41,y
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
        sta EnStatus,x
        jsr L9EF9
        cpx #$C0
        bne L9E68
    lda #$04
    sta MotherBrainStatus
    lda #$28
    sta MotherBrain9F
    lda NoiseSFXFlag
    ora #sfxNoise_SilenceMusic
    sta NoiseSFXFlag
L9E83:
    jmp L9E2E

;-------------------------------------------------------------------------------
L9E86:
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    jsr LA072
    inc MotherBrain9A
    jsr L9E43
    ldx #$00
    L9E98:
        lda EnStatus,x
        cmp #$05
        bne L9EA4
            lda #$00
            sta EnStatus,x
        L9EA4:
        jsr L9EF9
        cmp #$40
        bne L9E98
    lda PPUStrIndex
    bne L9EB5
        lda L9EFF+1,y
        sta $1C
    L9EB5:
    ldy MotherBrainStatus
    dey
    bne RTS_9ED5
    sty MotherBrain9A
    lda #$04
    sta MotherBrainStatus
    lda #$1C
    sta MotherBrain9F
    ldy MotherBrainQtyHits
    inc MotherBrainQtyHits
    cpy #$04
    beq L9ED3
        ldx #$00
        bcc RTS_9ED5
        jmp L9ED6

    L9ED3:
    lsr MotherBrain9F
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

L9EE7:
    pha
    and #$F0
    ora #$07
    sta EnY,x
    pla
    jsr Amul16_
    ora #$07
    sta EnX,x
    rts

L9EF9:
    txa
    clc
    adc #$10
    tax
    rts

L9EFF: .byte $60, $09, $0A

;-------------------------------------------------------------------------------
L9F02:
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
        lda MotherBrainNameTable
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

L9F49:
    jsr L9F69
    bcs RTS_9F64
    lda #$00
    sta MotherBrainStatus
    lda #$99
    sta EndTimer
    sta EndTimer+1
    lda #$01
    sta MotherBrain010D
    lda MotherBrainNameTable
    sta MotherBrain010C
RTS_9F64:
    rts

L9F65:  .byte $80, $B0, $A0, $90

L9F69:
    lda SamusMapPosX
    clc
    adc SamusMapPosY
    sec
    rol
    and #$03
    tay
    ldx L9F65,y
    lda #$01
    sta SamusJumpDsplcmnt,x
    lda #$01
    sta SamusOnElevator,x
    lda #$03
    sta ObjAction,x
    lda MotherBrainNameTable
    sta ObjHi,x
    lda #$10
    sta ObjX,x
    lda #$68
    sta ObjY,x
    lda #$55
    sta ObjAnimResetIndex,x
    sta ObjAnimIndex,x
    lda #$00
    sta ObjAnimDelay,x
    lda #$F7
    sta ObjAnimFrame,x
    lda #$10
    sta TileBlastAnimFrame
    lda #$40
    sta TileBlastWRAMPtr
    lda MotherBrainNameTable
    asl
    asl
    ora #$61
    sta TileBlastWRAMPtr+1
    lda #$00
    sta PageIndex
    jmp CommonJump_DrawTileBlast

;-------------------------------------------------------------------------------
L9FC0:
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    lda Timer3
    bne RTS_9FD9
    lda #$08
    sta ObjAction
    lda #$0A
    sta MotherBrainStatus
    lda #$01
    sta PalDataPending
RTS_9FD9:
    rts

;-------------------------------------------------------------------------------
L9FDA:
    jsr L9F69
    bcs RTS_9FEC
    lda MotherBrainNameTable
    sta MotherBrain010C
    ldy #$01
    sty MotherBrain010D
    dey
    sty MotherBrainStatus
RTS_9FEC:
    rts

;-------------------------------------------------------------------------------
L9FED:
    lda MotherBrainIsHit
    beq RTS_A01A
    lda MultiSFXFlag
    ora #sfxMulti_BossHit
    sta MultiSFXFlag
    inc MotherBrainQtyHits
    lda MotherBrainQtyHits
    cmp #$20
    ldy #$02
    lda #$10
    bcc LA016
    ldx #$00
    LA007:
        lda #$00
        sta TileBlastRoutine,x
        jsr L9EF9
        cmp #$D0
        bne LA007
    iny
    lda #$80
LA016:
    sty MotherBrainStatus
    sta MotherBrain9F
RTS_A01A:
    rts

;-------------------------------------------------------------------------------
LA01B:
    dec MotherBrain9A
    bne RTS_A02D
    lda RandomNumber1
    and #$03
    sta MotherBrainAnimFrameTableID
    lda #$20
    sec
    sbc MotherBrainQtyHits
    lsr
    sta MotherBrain9A
RTS_A02D:
    rts

;-------------------------------------------------------------------------------
LA02E:
    dec MotherBrain9B
    lda MotherBrain9B
    asl
    bne RTS_A040
    lda #$20
    sec
    sbc MotherBrainQtyHits
    ora #$80
    eor MotherBrain9B
    sta MotherBrain9B
RTS_A040:
    rts

;-------------------------------------------------------------------------------
LA041:
    lda #$E0
    sta PageIndex
    lda MotherBrainNameTable
    sta EnHi+$E0
    lda #$70
    sta EnY+$E0
    lda #$48
    sta EnX+$E0
    ldy MotherBrainAnimFrameTableID
    lda LA06D,y
    sta EnAnimFrame+$E0
    jsr CommonJump_DrawEnemy
    lda MotherBrain9B
    bmi RTS_A06C
    lda LA06D+4
    sta EnAnimFrame+$E0
    jsr CommonJump_DrawEnemy
RTS_A06C:
    rts

; animation frame id table
LA06D:
    .byte $13, $14, $15, $16
    .byte $17

LA072:
    ldy MotherBrainQtyHits
    beq RTS_A086
    lda LA0C0,y
    clc
    adc MotherBrain9A
    tay
    lda LA0A3,y
    cmp #$FF
    bne LA087
    dec MotherBrain9A
RTS_A086:
    rts

LA087:
    adc #$44
    sta TileBlastWRAMPtr
    php
    lda MotherBrainNameTable
    asl
    asl
    ora #$61
    plp
    adc #$00
    sta TileBlastWRAMPtr+1
    lda #$00
    sta TileBlastAnimFrame
    sta PageIndex
    jmp CommonJump_DrawTileBlast

LA0A3:  .byte $00, $02, $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27
LA0B3:  .byte $FF, $82, $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86
LA0C0:  .byte $FF, $00, $0C
LA0C3:  .byte $11, $16, $1A

;-------------------------------------------------------------------------------
;$04-$05 is pointer to projectile ??
LA0C6:
    lda UpdatingProjectile
    beq LA13E
    ldx PageIndex
    lda ObjAction,x
    cmp #$0B
    bne LA13E
    cpy #$98
    bne LA103
        ldx #$00
    LA0D9:
        lda TileBlastRoutine,x
        beq LA0E7
            jsr L9EF9
            cmp #$D0
            bne LA0D9
            beq LA13E
        LA0E7:
        lda #$8C
        sta TileBlastWRAMPtr,x
        lda $05
        sta TileBlastWRAMPtr+1,x
        lda #$01
        sta TileBlastAnimFrame,x
        lda PageIndex
        pha
        stx PageIndex
        jsr CommonJump_DrawTileBlast
        pla
        sta PageIndex
        bne LA13E
    LA103:
    lda $04
    lsr
    bcc LA10A
        dec $04
    LA10A:
    ; if projectile is a missile
    ldy #$00
    lda ($04),y
    lsr
    bcs LA13E
    cmp #$48
    bcc LA13E
    cmp #$4C
    bcs LA13E
    LA119:
        ; if zebetite is active
        lda ZebetiteStatus,y
        beq LA12E
        ; and if missile touches zebetite
        lda $04
        and #$9E
        cmp ZebetiteVRAMPtr,y
        bne LA12E
        lda $05
        cmp ZebetiteVRAMPtr+1,y
        beq LA139
        LA12E:
            ; missile is not touching zebetite
            ; check again for next zebetite
            tya
            clc
            adc #$08
            tay
            cmp #$28
            bne LA119
            ; no more zebetites to loop through
            beq LA13E
        LA139:
            ; set zebetite flag to indicate it got hit
            lda #$01
            sta ZebetiteIsHit,y
LA13E:
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
    cmp #$0B
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
LA15E:
    ldy EndTimer+1
    iny
    bne RTS_A1DA
    ldy #$03
    jsr LA16B
        ldy #$00
    LA16B:
    sty PageIndex
    lda $8B,y
    bmi RTS_A15D
    lda $8C,y
    eor FrameCount
    lsr
    bcc RTS_A15D
    lda MotherBrainStatus
    cmp #$04
    bcs RTS_A15D
    lda FrameCount
    and #$06
    bne RTS_A15D
    ldx #$20
    LA188:
        lda EnStatus,x
        beq LA19C
        lda EnData05,x
        and #$02
        beq LA19C
        txa
        sec
        sbc #$10
        tax
        bpl LA188
    rts

LA19C:
    lda #$01
    sta EnStatus,x
    lda #$04
    sta EnType,x
    lda #$00
    sta EnSpecialAttribs,x
    sta EnData04,x
    jsr CommonJump_0E
    lda #$F7
    sta EnAnimFrame,x
    ldy PageIndex
    lda $8C,y
    sta EnHi,x
    lda $8D,y
    asl
    ora $8B,y
    tay
    lda LA1DB,y
    jsr L9EE7
    ldx PageIndex
    inc $8D,x
    lda $8D,x
    cmp #$06
    bne RTS_A1DA
    lda #$00
LA1D8:
    sta $8D,x
RTS_A1DA:
    rts

LA1DB:  .byte $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA, $BA, $BA

;-------------------------------------------------------------------------------
LA1E7:
    ldy EndTimer+1
    iny
    beq RTS_A237
    lda EndTimer
    sta $03
    lda #$01
    sec
    jsr CommonJump_Base10Subtract
    sta EndTimer
    lda EndTimer+1
    sta $03
    lda #$00
    jsr CommonJump_Base10Subtract
    sta EndTimer+1
    lda FrameCount
    and #$1F
    bne LA216
        lda SQ1SFXFlag
        ora #sfxSQ1_OutOfHole
        sta SQ1SFXFlag
    LA216:
    lda EndTimer
    ora EndTimer+1
    bne RTS_A237
    dec EndTimer+1
    sta MotherBrainQtyHits
    lda #$07
    sta MotherBrainStatus
    lda NoiseSFXFlag
    ora #sfxNoise_SilenceMusic
    sta NoiseSFXFlag
    lda #$0C
    sta Timer3
    lda #$0B
    sta PalDataPending
RTS_A237:
    rts

;-------------------------------------------------------------------------------
LA238:
    lda MotherBrain010D
    beq RTS_A28A
    lda MotherBrain010C
    sta EnHi+$E0
    lda #$84
    sta EnY+$E0
    lda #$64
    sta EnX+$E0
    lda #$1A
    sta EnAnimFrame+$E0
    lda #$E0
    sta PageIndex
    lda SpritePagePos
    pha
    jsr CommonJump_DrawEnemy
    pla
    cmp SpritePagePos
    beq RTS_A28A
    tax
    lda EndTimer+1
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+$01,x
    lda EndTimer+1
    and #$0F
    ora #$A0
    sta SpriteRAM+$05,x
    lda EndTimer
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+$09,x
RTS_A28A:
    rts

;-------------------------------------------------------------------------------
ZebetiteA28B:
    lda #$10
    sta PageIndex
    ; run LA29B for all zebetite slots
    ldx #$20
    @loop:
        jsr LA29B
        txa
        sec
        sbc #$08
        tax
        bne @loop
LA29B:
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
    lda ZebetiteAnimFrameTable,y
    sta TileBlastAnimFrame+$10
    lda ZebetiteVRAMPtr,x
    sta TileBlastWRAMPtr+$10
    lda ZebetiteVRAMPtr+1,x
    sta TileBlastWRAMPtr+1+$10
    lda PPUStrIndex
    bne LA2DA
        txa
        pha
        jsr CommonJump_DrawTileBlast
        pla
        tax
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
    lda #$40
    sta ZebetiteHealingDelay,x
    bne LA30A
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

TileBlastFrame02:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $E0, $DE, $ED, $FF, $E8, $EE

TileBlastFrame03:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $ED, $FF, $DF, $DA, $EC, $ED, $F4, $FF

TileBlastFrame04:
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

TileBlastFrame08:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $ED, $E2, $E6, $DE, $FF, $DB

TileBlastFrame09:
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


.ENDS

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC"
    .SECTION "ROM Bank $003 - Music Engine" BANK 3 SLOT "ROMSwitchSlot" ORGA $B200 FORCE
.elif BUILDTARGET == "NES_PAL"
    .SECTION "ROM Bank $003 - Music Engine" BANK 3 SLOT "ROMSwitchSlot" ORGA $B230 FORCE
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ENDS

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.SECTION "ROM Bank $003 - Vectors" BANK 3 SLOT "ROMSwitchSlot" ORGA $BFFA FORCE
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ENDS

