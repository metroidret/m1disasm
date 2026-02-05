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
.redef AREA = {"BANK{BANK}"}
.section "ROM Bank $003" bank 3 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

; 8D60 - Kraid Sprite CHR
GFX_KraidSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "kraid/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "kraid/sprite_tiles_cnsus.chr"
    .endif

; 9160 - Ridley Sprite CHR
GFX_RidleySprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "ridley/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "ridley/sprite_tiles_cnsus.chr"
    .endif

;----------------------------------------------------------------------------------------------------

PalettePtrTable:
    PtrTableEntryArea PalettePtrTable, Palette00                 ;($A718)Room palette.
    PtrTableEntryArea PalettePtrTable, Palette01                 ;($A73C)Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette02                 ;($A748)Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette03                 ;($A742)Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette04                 ;($A74E)Samus varia suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette05                 ;($A754)
    PtrTableEntryArea PalettePtrTable, Palette06                 ;($A754)Mother Brain hurt palette.
    PtrTableEntryArea PalettePtrTable, Palette07                 ;($A759)Mother Brain hurt palette.
    PtrTableEntryArea PalettePtrTable, Palette08                 ;($A75E)Mother Brain dying palette.
    PtrTableEntryArea PalettePtrTable, Palette09                 ;($A773)Mother Brain dying palette.
    PtrTableEntryArea PalettePtrTable, Palette0A                 ;($A788)Time bomb explosion palette.
    PtrTableEntryArea PalettePtrTable, Palette0B                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette0C                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette0D                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette0E                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette0F                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette10                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette11                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette12                 ;($A78D)
    PtrTableEntryArea PalettePtrTable, Palette13                 ;($A78D)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryArea PalettePtrTable, Palette14                 ;($A794)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette15                 ;($A79B)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette16                 ;($A7A2)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette17                 ;($A7A9)Unused?
    PtrTableEntryArea PalettePtrTable, Palette18                 ;($A7B1)Suitless Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette19                 ;($A7B9)Suitless Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette1A                 ;($A7C1)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette1B                 ;($A7C9)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_{AREA}               ;($A83B)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_{AREA}              ;($A7D1)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_{AREA}            ;($A7FB)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_{AREA}              ;($AE49)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_{AREA}          ;($A42C)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_{AREA}          ;($A52C)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_{AREA}           ;($A540)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_{AREA}               ;($A406)Index to values in addr tables for enemy animations.
.ENDST

; Special Tourian Routines
GotoClearCurrentMetroidLatchAndMetroidOnSamus:
    jmp ClearCurrentMetroidLatchAndMetroidOnSamus
GotoClearAllMetroidLatches:
    jmp ClearAllMetroidLatches
GotoDeleteOffscreenRoomSprites_Tourian:
    jmp DeleteOffscreenRoomSprites_Tourian
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

AreaMapPosX:
    .byte $03   ;Samus start x coord on world map.
AreaMapPosY:
    .byte $04   ;Samus start y coord on world map.
AreaSamusY:
    .byte $6E   ;Samus start vertical screen position.

AreaPaletteToggle:
    .byte _id_Palette05+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}

    .byte $00, $00
AreaEnProjectileFallingAnimIndex:
    .byte $00, $00
AreaEnProjectileSplatterAnimIndex:
    .byte $00, EnAnim_CannonBulletExplode_{AREA} - EnAnimTable_{AREA}
AreaMellowAnimIndex:
    .byte $00

; Enemy AI Jump Table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_JumpEngine
        .word MetroidAIRoutine_{AREA} ; 00 - red metroid
        .word MetroidAIRoutine_{AREA} ; 01 - green metroid
        .word L9A27 ; 02 - i dunno but it takes 30 damage with varia
        .word RemoveEnemy__{AREA} ; 03 - disappears
        .word RinkaAIRoutine_{AREA} ; 04 - rinka
        .word RemoveEnemy__{AREA} ; 05 - same as 3
        .word RemoveEnemy__{AREA} ; 06 - same as 3
        .word RemoveEnemy__{AREA} ; 07 - same as 3
        .word RemoveEnemy__{AREA} ; 08 - same as 3
        .word RemoveEnemy__{AREA} ; 09 - same as 3
        .word RemoveEnemy__{AREA} ; 0A - same as 3
        .word RemoveEnemy__{AREA} ; 0B - same as 3
        .word RemoveEnemy__{AREA} ; 0C - same as 3
        .word RemoveEnemy__{AREA} ; 0D - same as 3
        .word RemoveEnemy__{AREA} ; 0E - same as 3
        .word RemoveEnemy__{AREA} ; 0F - same as 3


EnemyDeathAnimIndex:
    .byte EnAnim_MetroidExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_MetroidExplode_{AREA} - EnAnimTable_{AREA} ; 00 - red metroid
    .byte EnAnim_MetroidExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_MetroidExplode_{AREA} - EnAnimTable_{AREA} ; 01 - green metroid
    .byte EnAnim_16_{AREA} - EnAnimTable_{AREA}, EnAnim_16_{AREA} - EnAnimTable_{AREA} ; 02 - i dunno but it takes 30 damage with varia
    .byte EnAnim_18_{AREA} - EnAnimTable_{AREA}, EnAnim_18_{AREA} - EnAnimTable_{AREA} ; 03 - disappears
    .byte EnAnim_RinkaExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_RinkaExplode_{AREA} - EnAnimTable_{AREA} ; 04 - rinka
    .byte $00, $00 ; 05 - same as 3
    .byte $00, $00 ; 06 - same as 3
    .byte $00, $00 ; 07 - same as 3
    .byte $00, $00 ; 08 - same as 3
    .byte $00, $00 ; 09 - same as 3
    .byte $00, $00 ; 0A - same as 3
    .byte $00, $00 ; 0B - same as 3
    .byte $00, $00 ; 0C - same as 3
    .byte $00, $00 ; 0D - same as 3
    .byte $00, $00 ; 0E - same as 3
    .byte $00, $00 ; 0F - same as 3

EnemyHealthTbl:
    .byte $FF ; 00 - red metroid
    .byte $FF ; 01 - green metroid
    .byte $01 ; 02 - i dunno but it takes 30 damage with varia
    .byte $FF ; 03 - disappears
    .byte $01 ; 04 - rinka
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

EnemyRestingAnimIndex:
    .byte EnAnim_Metroid_{AREA} - EnAnimTable_{AREA}, EnAnim_Metroid_{AREA} - EnAnimTable_{AREA} ; 00 - red metroid
    .byte EnAnim_Metroid_{AREA} - EnAnimTable_{AREA}, EnAnim_Metroid_{AREA} - EnAnimTable_{AREA} ; 01 - green metroid
    .byte EnAnim_16_{AREA} - EnAnimTable_{AREA}, EnAnim_16_{AREA} - EnAnimTable_{AREA} ; 02 - i dunno but it takes 30 damage with varia
    .byte EnAnim_18_{AREA} - EnAnimTable_{AREA}, EnAnim_18_{AREA} - EnAnimTable_{AREA} ; 03 - disappears
    .byte EnAnim_RinkaSpawning_{AREA} - EnAnimTable_{AREA}, EnAnim_RinkaSpawning_{AREA} - EnAnimTable_{AREA} ; 04 - rinka
    .byte $00, $00 ; 05 - same as 3
    .byte $00, $00 ; 06 - same as 3
    .byte $00, $00 ; 07 - same as 3
    .byte $00, $00 ; 08 - same as 3
    .byte $00, $00 ; 09 - same as 3
    .byte $00, $00 ; 0A - same as 3
    .byte $00, $00 ; 0B - same as 3
    .byte $00, $00 ; 0C - same as 3
    .byte $00, $00 ; 0D - same as 3
    .byte $00, $00 ; 0E - same as 3
    .byte $00, $00 ; 0F - same as 3

EnemyActiveAnimIndex:
    .byte EnAnim_Metroid_{AREA} - EnAnimTable_{AREA}, EnAnim_Metroid_{AREA} - EnAnimTable_{AREA} ; 00 - red metroid
    .byte EnAnim_Metroid_{AREA} - EnAnimTable_{AREA}, EnAnim_Metroid_{AREA} - EnAnimTable_{AREA} ; 01 - green metroid
    .byte EnAnim_16_{AREA} - EnAnimTable_{AREA}, EnAnim_16_{AREA} - EnAnimTable_{AREA} ; 02 - i dunno but it takes 30 damage with varia
    .byte EnAnim_18_{AREA} - EnAnimTable_{AREA}, EnAnim_18_{AREA} - EnAnimTable_{AREA} ; 03 - disappears
    .byte EnAnim_Rinka_{AREA} - EnAnimTable_{AREA}, EnAnim_Rinka_{AREA} - EnAnimTable_{AREA} ; 04 - rinka
    .byte $00, $00 ; 05 - same as 3
    .byte $00, $00 ; 06 - same as 3
    .byte $00, $00 ; 07 - same as 3
    .byte $00, $00 ; 08 - same as 3
    .byte $00, $00 ; 09 - same as 3
    .byte $00, $00 ; 0A - same as 3
    .byte $00, $00 ; 0B - same as 3
    .byte $00, $00 ; 0C - same as 3
    .byte $00, $00 ; 0D - same as 3
    .byte $00, $00 ; 0E - same as 3
    .byte $00, $00 ; 0F - same as 3

L967B:
    .byte $00 ; 00 - red metroid
    .byte $00 ; 01 - green metroid
    .byte $00 ; 02 - i dunno but it takes 30 damage with varia
    .byte $00 ; 03 - disappears
    .byte $02 ; 04 - rinka
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

L968B:
    .byte %11111110 ; 00 - red metroid
    .byte %11111110 ; 01 - green metroid
    .byte %00000000 ; 02 - i dunno but it takes 30 damage with varia
    .byte %00000000 ; 03 - disappears
    .byte %11000000 ; 04 - rinka
    .byte %00000000 ; 05 - same as 3
    .byte %00000000 ; 06 - same as 3
    .byte %00000000 ; 07 - same as 3
    .byte %00000000 ; 08 - same as 3
    .byte %00000000 ; 09 - same as 3
    .byte %00000000 ; 0A - same as 3
    .byte %00000000 ; 0B - same as 3
    .byte %00000000 ; 0C - same as 3
    .byte %00000000 ; 0D - same as 3
    .byte %00000000 ; 0E - same as 3
    .byte %00000000 ; 0F - same as 3

EnemyForceSpeedTowardsSamusDelayTbl:
    .byte $01 ; 00 - red metroid
    .byte $01 ; 01 - green metroid
    .byte $00 ; 02 - i dunno but it takes 30 damage with varia
    .byte $00 ; 03 - disappears
    .byte $01 ; 04 - rinka
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

EnemyDistanceToSamusThreshold:
    .byte $00 ; 00 - red metroid
    .byte $00 ; 01 - green metroid
    .byte $00 ; 02 - i dunno but it takes 30 damage with varia
    .byte $00 ; 03 - disappears
    .byte $00 ; 04 - rinka
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

EnemyInitDelayTbl:
    .byte $01 ; 00 - red metroid
    .byte $01 ; 01 - green metroid
    .byte $00 ; 02 - i dunno but it takes 30 damage with varia
    .byte $00 ; 03 - disappears
    .byte $01 ; 04 - rinka
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice_MetroidRed_{AREA} - EnemyMovementChoices ; 00 - red metroid
    .byte EnemyMovementChoice_MetroidGreen_{AREA} - EnemyMovementChoices ; 01 - green metroid
    .byte EnemyMovementChoice_MetroidRed_{AREA} - EnemyMovementChoices ; 02 - i dunno but it takes 30 damage with varia (enemy doesn't move)
    .byte EnemyMovementChoice_MetroidRed_{AREA} - EnemyMovementChoices ; 03 - disappears
    .byte EnemyMovementChoice_Rinka_{AREA} - EnemyMovementChoices ; 04 - rinka (enemy moves manually)
    .byte $00 ; 05 - same as 3
    .byte $00 ; 06 - same as 3
    .byte $00 ; 07 - same as 3
    .byte $00 ; 08 - same as 3
    .byte $00 ; 09 - same as 3
    .byte $00 ; 0A - same as 3
    .byte $00 ; 0B - same as 3
    .byte $00 ; 0C - same as 3
    .byte $00 ; 0D - same as 3
    .byte $00 ; 0E - same as 3
    .byte $00 ; 0F - same as 3

EnemyMovementPtrs:
    .word EnemyMovement00_R_{AREA}, EnemyMovement00_L_{AREA}
    .word EnemyMovement01_R_{AREA}, EnemyMovement01_L_{AREA}
    .word EnemyMovement02_R_{AREA}, EnemyMovement02_L_{AREA}
    .word EnemyMovement03_R_{AREA}, EnemyMovement03_L_{AREA}
    .word EnemyMovement04_R_{AREA}, EnemyMovement04_L_{AREA}
    .word EnemyMovement05_R_{AREA}, EnemyMovement05_L_{AREA}
    .word EnemyMovement06_R_{AREA}, EnemyMovement06_L_{AREA}
    .word EnemyMovement07_R_{AREA}, EnemyMovement07_L_{AREA}
    .word EnemyMovement08_R_{AREA}, EnemyMovement08_L_{AREA}
    .word EnemyMovement09_R_{AREA}, EnemyMovement09_L_{AREA}
    .word EnemyMovement0A_R_{AREA}, EnemyMovement0A_L_{AREA}
    .word EnemyMovement0B_R_{AREA}, EnemyMovement0B_L_{AREA}
    .word EnemyMovement0C_R_{AREA}, EnemyMovement0C_L_{AREA}
    .word EnemyMovement0D_R_{AREA}, EnemyMovement0D_L_{AREA}
    .word EnemyMovement0E_R_{AREA}, EnemyMovement0E_L_{AREA}
    .word EnemyMovement0F_R_{AREA}, EnemyMovement0F_L_{AREA}
    .word EnemyMovement10_R_{AREA}, EnemyMovement10_L_{AREA}
    .word EnemyMovement11_R_{AREA}, EnemyMovement11_L_{AREA}
    .word $0000, $0000
    .word $0000, $0000
    
EnAccelYTable:
    .byte $18, $30, $00, $C0, $D0, $00, $00, $7F, $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
EnAccelXTable:
    .byte $18, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedYTable:
    .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
EnSpeedXTable:
    .byte $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

L977B:
    .byte %01010000 ; 00 - red metroid
    .byte %01010000 ; 01 - green metroid
    .byte %00000000 ; 02 - i dunno but it takes 30 damage with varia (enemy doesn't move)
    .byte %00000000 ; 03 - disappears
    .byte %00000000 ; 04 - rinka (enemy moves manually)
    .byte %00000000 ; 05 - same as 3
    .byte %00000000 ; 06 - same as 3
    .byte %00000000 ; 07 - same as 3
    .byte %00000000 ; 08 - same as 3
    .byte %00000000 ; 09 - same as 3
    .byte %00000000 ; 0A - same as 3
    .byte %00000000 ; 0B - same as 3
    .byte %00000000 ; 0C - same as 3
    .byte %00000000 ; 0D - same as 3
    .byte %00000000 ; 0E - same as 3
    .byte %00000000 ; 0F - same as 3

EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_26_{AREA} - EnAnimTable_{AREA}, EnAnim_26_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_26_{AREA} - EnAnimTable_{AREA}, EnAnim_26_{AREA} - EnAnimTable_{AREA}
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetX:
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnProjectilePosOffsetY:
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

EnProjectileMovementPtrTable:
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

VRAMStringPtrTable:
    PtrTableEntryArea VRAMStringPtrTable, VRAMString00
    PtrTableEntryArea VRAMStringPtrTable, VRAMString01
    PtrTableEntryArea VRAMStringPtrTable, VRAMString02
    PtrTableEntryArea VRAMStringPtrTable, VRAMString03
    PtrTableEntryArea VRAMStringPtrTable, VRAMString04
    PtrTableEntryArea VRAMStringPtrTable, VRAMString05
    PtrTableEntryArea VRAMStringPtrTable, VRAMString06
    PtrTableEntryArea VRAMStringPtrTable, VRAMString07
    PtrTableEntryArea VRAMStringPtrTable, VRAMString08
    PtrTableEntryArea VRAMStringPtrTable, VRAMString09
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0A
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0B
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0C
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0D
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0E
    PtrTableEntryArea VRAMStringPtrTable, VRAMString0F
    PtrTableEntryArea VRAMStringPtrTable, VRAMString10

EnemyMovementChoices:
EnemyMovementChoice_MetroidRed_{AREA}:
    EnemyMovementChoiceEntry $00
EnemyMovementChoice_MetroidGreen_{AREA}:
    EnemyMovementChoiceEntry $01
EnemyMovementChoice_Rinka_{AREA}: ; enemy moves manually
    ; nothing

EnemyMovement00_R_{AREA}:
EnemyMovement00_L_{AREA}:
EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
EnemyMovement02_R_{AREA}:
EnemyMovement02_L_{AREA}:
EnemyMovement03_R_{AREA}:
EnemyMovement03_L_{AREA}:
EnemyMovement04_R_{AREA}:
EnemyMovement04_L_{AREA}:
EnemyMovement05_R_{AREA}:
EnemyMovement05_L_{AREA}:
EnemyMovement06_R_{AREA}:
EnemyMovement06_L_{AREA}:
EnemyMovement07_R_{AREA}:
EnemyMovement07_L_{AREA}:
EnemyMovement08_R_{AREA}:
EnemyMovement08_L_{AREA}:
EnemyMovement09_R_{AREA}:
EnemyMovement09_L_{AREA}:
EnemyMovement0A_R_{AREA}:
EnemyMovement0A_L_{AREA}:
EnemyMovement0B_R_{AREA}:
EnemyMovement0B_L_{AREA}:
EnemyMovement0C_R_{AREA}:
EnemyMovement0C_L_{AREA}:
EnemyMovement0D_R_{AREA}:
EnemyMovement0D_L_{AREA}:
EnemyMovement0E_R_{AREA}:
EnemyMovement0E_L_{AREA}:
EnemyMovement0F_R_{AREA}:
EnemyMovement0F_L_{AREA}:
EnemyMovement10_R_{AREA}:
EnemyMovement10_L_{AREA}:
EnemyMovement11_R_{AREA}:
EnemyMovement11_L_{AREA}:
    ; nothing

EnProjectileMovement0_{AREA}:
EnProjectileMovement1_{AREA}:
    SignMagSpeed $50,  2,  2
    .byte $FF

EnProjectileMovement2_{AREA}:
    SignMagSpeed $50,  0,  3
    .byte $FF

EnProjectileMovement3_{AREA}:
    .byte $FF

RemoveEnemy__{AREA}:
    lda #$00
    sta EnsExtra.0.status,x
    rts

CommonEnemyJump_00_01_02_{AREA}:
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
    ldx #_sizeof_Cannons - _sizeof_Cannons.0.b
    @loop:
        jsr @updateIfPossible
        lda CannonIndex
        sec
        sbc #_sizeof_Cannons.0
        tax
        bne @loop

@updateIfPossible:
    stx CannonIndex
    ; update cannon if it exists
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
        lda #_id_EnFrame_CannonTimeBombSet_{AREA}.b
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
        bne @shootEnProjectile
            ; instruction is restart
            ldy Cannons.0.instrListID,x
            ; restart to first instruction
            lda #$00
            sta Cannons.0.instrID,x
            ; go back to get instuction
            beq @getInstruction ; branch always
        @shootEnProjectile:
            ; instruction is shoot projectile
            ; change to next instruction
            inc Cannons.0.instrID,x
            ; shoot
            jsr Cannon_ShootEnProjectile
            ldy Cannons.0.instrListID,x
            ; go back to get instuction
            jmp @getInstruction

    @setAngle:
        sta Cannons.0.angle,x
        rts

Cannon_ShootEnProjectile:
    ; push instruction byte #$FC, #$FD or #$FE
    pha
    ; exit if mother brain is dying or dead
    lda MotherBrainStatus
    cmp #$04
    bcs @exit
    ; loop through all enemy projectiles
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
    ; no projectile slots found, exit
@exit:
    pla
    rts

@slotFound:
    ; store slot
    sty PageIndex
    ; set projectile position to cannon position
    lda Cannons.0.y,x
    sta EnY,y
    lda Cannons.0.x,x
    sta EnX,y
    lda Cannons.0.hi,x
    sta EnsExtra.0.hi,y
    ; set projectile status to active
    lda #enemyStatus_Active
    sta EnsExtra.0.status,y
    ; init projectile animation timers
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
    ; set projectile facing direction
    ora #$02
    sta EnData05,y
    ; set projectile animation
    lda CannonEnProjectileAnimTable-2,x
    sta EnsExtra.0.resetAnimIndex,y
    sta EnsExtra.0.animIndex,y
    ; store offset into temp
    lda CannonEnProjectileXOffsetTable-2,x
    sta Temp05_SpeedX
    lda CannonEnProjectileYOffsetTable-2,x
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
    ; use as projectile position
    jsr LoadEnemyPositionFromTemp_
    ldx CannonIndex
    rts

CannonEnProjectileAnimTable:
    .byte EnAnim_CannonBulletDownRight_{AREA} - EnAnimTable_{AREA} ; cannon instr #$FE : diagonal right
    .byte EnAnim_CannonBulletDownLeft_{AREA} - EnAnimTable_{AREA} ; cannon instr #$FD : diagonal left
    .byte EnAnim_CannonBulletDown_{AREA} - EnAnimTable_{AREA} ; cannon instr #$FC : straight down

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

DeleteOffscreenRoomSprites_Tourian:
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
        adc #_sizeof_Cannons.0
        tay
        bpl @loop_A
    
    ; loop through all zebetites
    ldx #$00
    @loop_B:
        ; branch if zebetite doesn't exist
        lda Zebetites.0.status,x
        beq @endIf_B
        ; branch if zebetite is in the current nametable
        jsr GetRoomRAMPtrHi
        eor Zebetites.0.roomRAMPtr+1,x
        bne @endIf_B
            ; zebetite is in the opposite nametable
            ; clear status
            sta Zebetites.0.status,x
        @endIf_B:
        ; move to next zebetite
        txa
        clc
        adc #_sizeof_Zebetites.0
        tax
        cmp #_sizeof_Zebetites
        bne @loop_B
    
    ; for all rinka spawners
    ldx #$00
    jsr @rinkaSpawner
    ldx #$03
    jsr @rinkaSpawner

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

@rinkaSpawner:
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
        adc #_sizeof_Cannons.0
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
    ; set status to idle
    lda #$01
    sta MotherBrainStatus
    ; set hi position
    jsr GetNameTableAtScrollDir_
    sta MotherBrainHi
    ; lock horizontal scrolling behind mother brain
    eor #$01
    tax
    lda L9D3C
    ora ScrollBlockOnNameTable3,x
    sta ScrollBlockOnNameTable3,x
    ; init anim delays
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
    sta Zebetites.0.roomRAMPtr,x
    jsr GetRoomRAMPtrHi
    sta Zebetites.0.roomRAMPtr+1,x
    
    lda #$01
    sta Zebetites.0.status,x
    
    lda #$00
    sta Zebetites.0.qtyHits,x
    sta Zebetites.0.healingDelay,x
    sta Zebetites.0.isHit,x
    rts

GetRoomRAMPtrHi:
    ; return #$61 for nametable 0 and #$65 for nametable 3
    jsr GetNameTableAtScrollDir_
    asl
    asl
    ora #(>RoomRAMA)+1.b
    rts

;-------------------------------------------------------------------------------
; Rinka Handler
SpawnRinkaSpawnerRoutine:
    ldx #$03
    jsr @endIf_A
        bmi @RTS
        ldx #$00
    @endIf_A:
    lda RinkaSpawners.0.status,x
    bpl @RTS
    lda ($00),y
    jsr Adiv16_
    sta RinkaSpawners.0.status,x
    jsr GetNameTableAtScrollDir_
    sta RinkaSpawners.0.hi,x
    lda #$FF
@RTS:
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
    .byte _id_EnFrame_CannonUp_{AREA}
    .byte _id_EnFrame_CannonUpLeft_{AREA}
    .byte _id_EnFrame_CannonLeft_{AREA}
    .byte _id_EnFrame_CannonDownLeft_{AREA}
    .byte _id_EnFrame_CannonDown_{AREA}
    .byte _id_EnFrame_CannonDownRight_{AREA}
    .byte _id_EnFrame_CannonRight_{AREA}
    .byte _id_EnFrame_CannonUpRight_{AREA}

CannonEnProjectileXOffsetTable:
    .byte $09 ; cannon instr #$FE : diagonal right
    .byte $F7 ; cannon instr #$FD : diagonal left
    .byte $00 ; cannon instr #$FC : straight down
CannonEnProjectileYOffsetTable:
    .byte $09 ; cannon instr #$FE : diagonal right
    .byte $09 ; cannon instr #$FD : diagonal left
    .byte $0B ; cannon instr #$FC : straight down

;-------------------------------------------------------------------------------
; This is code:
MotherBrainStatusHandler:
    lda MotherBrainStatus
    beq RTS_9DF1
    jsr CommonJump_JumpEngine
        .word Exit__    ;#$00=Mother brain not in room,
        .word MotherBrain_Idle     ;#$01=Mother brain in room
        .word MotherBrain_Hurt     ;#$02=Mother brain hit
        .word MotherBrain_Killed     ;#$03=Mother brain dying
        .word MotherBrain_Disappear     ;#$04=Mother brain dissapearing
        .word MotherBrain_TimeBombMessage     ;#$05=Mother brain gone
        .word MotherBrain_SetTimeBomb     ;#$06=Time bomb set,
        .word MotherBrain_TimeBombExploded     ;#$07=Time bomb exploded
        .word MotherBrain_TimeBombMessage_ScrollBackOnScreen     ;#$08=Initialize mother brain already dead (part 1)
        .word MotherBrain_SetTimeBomb_ScrollBackOnScreen     ;#$09=Initialize mother brain already dead (part 2)
        .word Exit__    ;#$0A=Mother brain already dead.
RTS_9DF1:
    rts

;-------------------------------------------------------------------------------
MotherBrain_Idle_CollideWithSamus:
    ; exit if samus is not in the same nametable as mother brain
    lda Samus.hi
    eor MotherBrainHi
    bne RTS_9DF1
    ; exit if samus x pos is not in range #$48 to #$76 inclusive
    lda Samus.x
    sec
    sbc #$48
    cmp #$2F
    bcs RTS_9DF1
    ; exit if samus y pos is not in range #$61 to #$9F inclusive
    lda Samus.y
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
    sta Samus.isHit
    jmp CommonJump_SubtractHealth

;-------------------------------------------------------------------------------
MotherBrain_Idle: ; 03:9E22
    jsr MotherBrain_Idle_CollideWithSamus
    jsr MotherBrain_Idle_HandleBeingHit
    jsr MotherBrain_Idle_UpdateAnimBrain
    jsr MotherBrain_Idle_UpdateAnimEye
L9E2E:
    jsr MotherBrain_DrawSprites
ClearMotherBrainIsHit:
    lda #$00
    sta MotherBrainIsHit
    rts

;-------------------------------------------------------------------------------
MotherBrain_Hurt: ; 03:9E36
    ; update flashing palette
    jsr UpdateMotherBrainFlashDelay
    lda MotherBrainFlashPaletteTable,y
    sta PaletteDataPending
    ; clear is hit flag
    jmp ClearMotherBrainIsHit

MotherBrainFlashPaletteTable: ; 03:9E41
    .byte _id_Palette07+1, _id_Palette06+1

UpdateMotherBrainFlashDelay: ; 03:9E43
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
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        and #$02
        lsr
    .elif BUILDTARGET == "NES_CNSUS"
        NES_CNSUS_IllegalOpcode42
        nop
        nop
    .endif
    tay
    rts

;-------------------------------------------------------------------------------
MotherBrain_Killed: ; 03:9E52
    ; update flashing palette
    jsr UpdateMotherBrainFlashDelay
    lda MotherBrainFlashPaletteTable,y
    sta PaletteDataPending
    ; shake the screen vertically
    tya
    asl
    asl
    sta ScrollY
    ; branch if mother brain status is not idle (flashing is not complete)
    ldy MotherBrainStatus
    dey
    bne @endIf_A
        ; mother brain status is idle, because the UpdateMotherBrainFlashDelay is done flashing
        ; init mother brain death string id to zero, for the disintegration
        sty MotherBrainDeathStringID
        ; despawn all enemies(rinka) and enProjectiles(cannon bullet)
        tya
        tax
        @loop:
            tya
            sta EnsExtra.0.status,x
            jsr Xplus16
            cpx #$C0
            bne @loop
        ; set mother brain status to disappearing
        lda #$04
        sta MotherBrainStatus
        ; set delay until first disintegration to 40 frames
        lda #$28
        sta MotherBrainFlashDelay
        ; silence music
        lda NoiseSFXFlag
        ora #sfxNoise_SilenceMusic
        sta NoiseSFXFlag
    @endIf_A:
    jmp L9E2E

;-------------------------------------------------------------------------------
MotherBrain_Disappear: ; 03:9E86
    ; play BombExplode SFX every frame
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    ; disintegrate mother brain's bg tiles
    jsr MotherBrain_Disappear_Disintegrate
    ; increment disintegrate instruction id
    inc MotherBrainDeathInstrID
    ; decrement mother brain delay and set mb state to idle when it's zero
    jsr UpdateMotherBrainFlashDelay
    ; for the first 4 enemies, if they are pickups, despawn them
    ; (aren't enemies supposed to be all despawned here anyway?)
    ldx #$00
    @loop:
        lda EnsExtra.0.status,x
        cmp #enemyStatus_Pickup
        bne @endIf_A
            lda #enemyStatus_NoEnemy
            sta EnsExtra.0.status,x
        @endIf_A:
        jsr Xplus16
        cmp #$40
        bne @loop
    ; branch if VRAMStructBufferIndex is not zero
    lda VRAMStructBufferIndex
    bne @endIf_B
        ; VRAMStructBufferIndex is zero
        ; flash palette
        lda MotherBrain_Disappear_PaletteTable,y
        sta PaletteDataPending
    @endIf_B:
    ; exit if status is not idle (delay is not yet zero)
    ldy MotherBrainStatus
    dey
    bne @RTS

    ; delay is zero
    ; time to move on to next disintegration batch
    ; set disintegrate instruction id to zero
    sty MotherBrainDeathInstrID
    ; set status to disappearing
    lda #$04
    sta MotherBrainStatus
    ; set delay until next batch to 28 frames
    lda #$1C
    sta MotherBrainFlashDelay
    ; increment death string id
    ldy MotherBrainDeathStringID
    inc MotherBrainDeathStringID
    ; branch if death string id was 4
    cpy #$04
    beq @endIf_C
        ; death string id was not 4
        ; exit if it was less than 4
        ldx #$00
        bcc @RTS
        ; it was more than 4
        ; mother brain is fully disintegrated, let's move on
        jmp @endIf_D

    @endIf_C:
    ; death string id was 4
    ; delay until next batch will be 14 frames instead
    lsr MotherBrainFlashDelay
@RTS:
    rts

@endIf_D: ; 03:9ED6
    ; play escape music
    lda MusicInitFlag
    ora #music_Escape
    sta MusicInitFlag
    ; set mother brain status to gone
    lda #$05
    sta MotherBrainStatus
    ; set time bomb counter to #-$80 (will count up to #$00)
    ; 2.6 seconds until time bomb is set
    lda #-$80
    sta MotherBrainTimeBombCounter
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

MotherBrain_Disappear_PaletteTable: ; 03:9F00
    .byte _id_Palette08+1, _id_Palette09+1

;-------------------------------------------------------------------------------
MotherBrain_TimeBombMessage: ; 03:9F02
MotherBrain_TimeBombMessage_ScrollBackOnScreen:
    ; branch if counter is negative (time bomb has yet to be set)
    lda MotherBrainTimeBombCounter
    bmi @endIf_A
        ; branch if counter is 8
        cmp #$08
        beq @complete
        ; draw the TIME BOMB SET GET OUT FAST! message
        ; there are 8 parts of the message, each in a TileBlast
        ; the MotherBrainTimeBombCounter is used as an index for which part to draw
        tay
        ; set TileBlast frame for this part
        lda @animFrameTable,y
        sta TileBlasts.0.animFrame
        ; set low byte of roomRAM pointer to upper-left tile for TileBlast
        lda @roomRAMPtrTable,y
        clc
        adc #<$6142
        sta TileBlasts.0.roomRAMPtr
        ; save carry to stack
        php
        ; set hi byte of roomRAM pointer from mother brain hi
        ; also add carry from stack
        lda MotherBrainHi
        asl
        asl
        plp
        adc #>$6142
        sta TileBlasts.0.roomRAMPtr+1
        ; prepare to draw TileBlasts.0
        lda #$00
        sta PageIndex
        ; exit if VRAMStructBufferIndex is not zero
        ; (counter will not be incremented, so the same part will be attempted again next frame)
        lda VRAMStructBufferIndex
        bne @RTS
        ; try to draw TileBlast and exit without incrementing counter if failed
        jsr CommonJump_DrawTileBlast
        bcs @RTS
        ; TileBlast was drawn successfully, move on to next part
    @endIf_A:
    ; increment counter
    inc MotherBrainTimeBombCounter
    rts

@complete:
    inc MotherBrainStatus
@RTS:
    rts

@roomRAMPtrTable:
    .byte $6142 - $6142
    .byte $6182 - $6142
    .byte $614A - $6142
    .byte $618A - $6142
    .byte $61C2 - $6142
    .byte $6202 - $6142
    .byte $61CA - $6142
    .byte $620A - $6142

@animFrameTable:
    .byte $08 ; TIME B
    .byte $02 ; GET OU
    .byte $09 ; OMB SET
    .byte $03 ; T FAST!
    .byte $0A
    .byte $04 ; TIME
    .byte $0B
    .byte $05

MotherBrain_SetTimeBomb: ; 03:9F49
    ; try to spawn door until it succeeds
    jsr MotherBrain_SpawnDoor
    bcs @RTS
    ; mother brain status = not in room
    lda #$00
    sta MotherBrainStatus
    ; timer = 9999 frames = 166.65 seconds
    lda #$99
    sta EndTimer
    sta EndTimer+1
    ; enable end timer enemy
    lda #$01
    sta EndTimerEnemyIsEnabled
    ; place end timer enemy
    lda MotherBrainHi
    sta EndTimerEnemyHi
@RTS:
    rts

L9F65: ; 03:9F65
    .byte $80, $B0, $A0, $90

MotherBrain_SpawnDoor: ; 03:9F69
    ; get obj slot
    lda MapPosX
    clc
    adc MapPosY
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
    sta Objects.0.status,x
    ; set door coords
    lda MotherBrainHi
    sta Objects.0.hi,x
    lda #$10
    sta Objects.0.x,x
    lda #$68
    sta Objects.0.y,x
    ; init door animation (because of the 1/2 chance that it plays only for 1 frame,
    ; the first frame has to be $F7)
    lda #ObjAnim_55 - ObjectAnimIndexTbl.b
    sta Objects.0.animResetIndex,x
    sta Objects.0.animIndex,x
    lda #$00
    sta Objects.0.animDelay,x
    lda #$F7
    sta Objects.0.animFrame,x
    ; create door tiles
    lda #$10
    sta TileBlasts.0.animFrame
    lda #$40
    sta TileBlasts.0.roomRAMPtr
    lda MotherBrainHi
    asl
    asl
    ora #$61
    sta TileBlasts.0.roomRAMPtr+1
    lda #$00
    sta PageIndex
    jmp CommonJump_DrawTileBlast

;-------------------------------------------------------------------------------
MotherBrain_TimeBombExploded: ; 03:9FC0
    ; play BombExplode SFX every frame
    lda #sfxNoise_BombExplode
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    ; branch if time bomb is still exploding
    lda Timer3
    bne @RTS
    ; Time bomb finishes exploding
    ; Bug? Doesn't set ObjAnimDelay to 0
    lda #sa_Dead2
    sta Samus.status
    ; mother brain status = already dead (RTS)
    lda #$0A
    sta MotherBrainStatus
    ; reload palette #$00
    lda #_id_Palette00+1.b
    sta PaletteDataPending
@RTS:
    rts

;-------------------------------------------------------------------------------
MotherBrain_SetTimeBomb_ScrollBackOnScreen: ; 03:9FDA
    ; try to spawn door until it succeeds
    jsr MotherBrain_SpawnDoor
    bcs @RTS
    ; door was spawned successfully
    ; place end timer enemy
    lda MotherBrainHi
    sta EndTimerEnemyHi
    ; enable end timer enemy
    ldy #$01
    sty EndTimerEnemyIsEnabled
    ; mother brain status = not in room (RTS)
    dey
    sty MotherBrainStatus
@RTS:
    rts

;-------------------------------------------------------------------------------
MotherBrain_Idle_HandleBeingHit:
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
            sta TileBlasts.0.routine,x
            jsr Xplus16
            cmp #_sizeof_TileBlasts
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
MotherBrain_Idle_UpdateAnimBrain:
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
MotherBrain_Idle_UpdateAnimEye:
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
    .byte _id_EnFrame_MotherBrainPulsations0_{AREA}
    .byte _id_EnFrame_MotherBrainPulsations1_{AREA}
    .byte _id_EnFrame_MotherBrainPulsations2_{AREA}
    .byte _id_EnFrame_MotherBrainPulsations3_{AREA}

; mother brain's eyes
    .byte _id_EnFrame_MotherBrainEyes_{AREA}

MotherBrain_Disappear_Disintegrate:
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
    sta TileBlasts.0.roomRAMPtr
    php
    lda MotherBrainHi
    asl
    asl
    ora #$61
    plp
    adc #$00
    sta TileBlasts.0.roomRAMPtr+1
    ; clear 2x2 tile region at that location
    lda #$00
    sta TileBlasts.0.animFrame
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
    lda UpdatingWeapon
    beq @exit
    ; exit if not a missile
    ldx PageIndex
    lda Objects.0.status,x
    cmp #wa_Missile
    bne @exit
    ; branch if tile id is not #$98 (mother brain glass)
    cpy #$98
    bne @checkZebetite
        ; tile is #$98, mother brain glass must be destroyed
        ; find open TileBlast slot
        ldx #$00
        @loop_Slot:
            lda TileBlasts.0.routine,x
            beq @slotFound
            ; slot occupied, try next slot
            jsr Xplus16
            cmp #_sizeof_TileBlasts
            bne @loop_Slot
        ; no slots found, exit
        beq @exit ; branch always

        @slotFound:
        ; set pointer
        lda #$8C
        sta TileBlasts.0.roomRAMPtr,x
        lda Temp04_RoomRAMPtr+1.b
        sta TileBlasts.0.roomRAMPtr+1,x
        ; set to clear 2x3 tile region
        lda #$01
        sta TileBlasts.0.animFrame,x
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
        lda Temp04_RoomRAMPtr
        lsr
        bcc @endIf_andFE
            dec Temp04_RoomRAMPtr
        @endIf_andFE:
        ; load tile id of left tile of block samus shot
        ldy #$00
        lda (Temp04_RoomRAMPtr),y
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
            lda Zebetites.0.status,y
            beq @notTheRightZebetite
            ; and if missile is touching that zebetite
            lda Temp04_RoomRAMPtr
            and #$9E
            cmp Zebetites.0.roomRAMPtr,y
            bne @notTheRightZebetite
            lda Temp04_RoomRAMPtr+1.b
            cmp Zebetites.0.roomRAMPtr+1,y
            beq @theRightZebetite
            @notTheRightZebetite:
                ; missile is not touching that zebetite
                ; check again for next zebetite
                tya
                clc
                adc #_sizeof_Zebetites.0
                tay
                cmp #_sizeof_Zebetites
                bne @loop_Zebetite
                ; no more zebetites to loop through, exit
                beq @exit
            @theRightZebetite:
                ; set zebetite flag to indicate it got hit
                lda #$01
                sta Zebetites.0.isHit,y
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
    ; exit if we are not updating samus weapon
    lda UpdatingWeapon
    beq @exit
    ldx PageIndex
    ; exit if weapon is not a missile
    lda Objects.0.status,x
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
    sta PaletteDataPending
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
    lda #_id_EnFrame1A_{AREA}.b
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
    ; set tile blast index to 1
    lda #1*_sizeof_TileBlasts.0.b
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
    lda Zebetites.0.status,x
    and #$0F
    cmp #$01
    bne RTS_A28A
    
    ; check if zebetite just got hit
    lda Zebetites.0.isHit,x
    beq LA2F2
    
    ; zebetite was just hit
    ; increase hits count
    inc Zebetites.0.qtyHits,x
    lda Zebetites.0.qtyHits,x
    ; check if hits count is even or odd
    lsr
    bcs LA2F2
    ; hit count is even
    ; update zebetite appearance
    tay
    sbc #$03
    bne LA2BA
    inc Zebetites.0.status,x
LA2BA:
    ; set anim frame
    lda ZebetiteAnimFrameTable,y
    sta TileBlasts.1.animFrame
    ; set vram pointer
    lda Zebetites.0.roomRAMPtr,x
    sta TileBlasts.1.roomRAMPtr
    lda Zebetites.0.roomRAMPtr+1,x
    sta TileBlasts.1.roomRAMPtr+1
    ; if a vram struct is in the buffer, dont update gfx
    lda VRAMStructBufferIndex
    bne LA2DA
        ; vram struct buffer is empty
        ; update zebetite gfx
        txa
        pha
        jsr CommonJump_DrawTileBlast
        pla
        tax
        ; branch if gfx update is successful
        bcc LA2EB
    LA2DA:
    lda Zebetites.0.status,x
    and #$80
    ora #$01
    sta Zebetites.0.status,x
    sta Zebetites.0.isHit,x
    dec Zebetites.0.qtyHits,x
    rts

LA2EB:
    ; reset healing delay to max
    lda #$40
    sta Zebetites.0.healingDelay,x
    bne LA30A ; branch always

LA2F2:
    ; dont heal if at full health
    ldy Zebetites.0.qtyHits,x
    beq LA30A
    ; dont heal if healing delay is not zero
    dec Zebetites.0.healingDelay,x
    bne LA30A
    
    ; reset delay and heal one hit
    lda #$40
    sta Zebetites.0.healingDelay,x
    dey
    tya
    sta Zebetites.0.qtyHits,x
    ; if hits count is odd, update zebetite appearance
    lsr
    tay
    bcc LA2BA
LA30A:
    lda #$00
    sta Zebetites.0.isHit,x
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
    sta MetroidOnSamus
    rts

ClearCurrentMetroidLatchAndMetroidOnSamus:
    txa
    jsr Adiv16_
    tay
    jsr ClearMetroidLatch
    sta MetroidOnSamus
    rts

;-------------------------------------------------------------------------------

VRAMString00_{AREA}:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

VRAMString01_{AREA}:
    .byte $32
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

VRAMString02_{AREA}: ; GET OU
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $E0, $DE, $ED, $FF, $E8, $EE

VRAMString03_{AREA}: ; T FAST!
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $ED, $FF, $DF, $DA, $EC, $ED, $F4, $FF

VRAMString04_{AREA}: ; TIME
    .byte $28
    .byte $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

VRAMString05_{AREA}:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

VRAMString06_{AREA}:
    .byte $62
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

VRAMString07_{AREA}:
    .byte $42
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF

VRAMString08_{AREA}: ; TIME B
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $ED, $E2, $E6, $DE, $FF, $DB

VRAMString09_{AREA}: ; OMB SET
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $E8, $E6, $DB, $FF, $EC, $DE, $ED, $FF

VRAMString0A_{AREA}:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

VRAMString0B_{AREA}:
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

VRAMString0C_{AREA}:
    .byte $42
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91

VRAMString0D_{AREA}:
    .byte $42
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93

VRAMString0E_{AREA}:
    .byte $42
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95

VRAMString0F_{AREA}:
    .byte $42
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97

VRAMString10_{AREA}:
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

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "tourian/metatiles.asm"

;Not used.
    .byte $1C, $1D, $1E, $17, $18, $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E
    .byte $0F, $FF, $FF, $0C, $0D, $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $30, $FF, $33, $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34
    .byte $35, $37, $38, $3A, $3B, $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80
    .byte $81, $82, $83, $88, $89, $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C
    .byte $5D, $5E, $5F, $B8, $B8, $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36
    .byte $BE, $BC, $BD, $BF, $14, $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2
    .byte $14, $FF, $FF, $30, $13, $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76
    .byte $76, $76, $76, $FF, $FF, $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04
    .byte $05, $06, $07, $FF, $FF, $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90
    .byte $91, $92, $93, $4B, $4C, $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C
    .byte $8D, $8E, $8F, $11, $12, $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3
    .byte $C4, $C5, $C6, $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90
    .byte $91, $92, $93
    
;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/escape.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/escape.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/mthr_brn_room.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/mthr_brn_room.asm"
.endif

;Unused tile patterns.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
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

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
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

