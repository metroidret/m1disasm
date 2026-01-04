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
;Disassembled using TRaCER.

;Brinstar (memory page 1)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 1
.redef AREA = {"BANK{BANK}"}
.section "ROM Bank $001" bank 1 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

; 8D60 - "THE END" graphics + partial font
GFX_TheEndFont:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "ending/end_font.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "ending/end_font_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "ending/end_font_cnsus.chr"
    .endif

; 9160 - Brinstar Enemies
GFX_BrinstarSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "brinstar/sprite_tiles.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "brinstar/sprite_tiles_cnsus.chr"
    .endif

;----------------------------------------------------------------------------------------------------

PalettePtrTable:
    PtrTableEntryArea PalettePtrTable, Palette00                 ;($A271)Default room palette.
    PtrTableEntryArea PalettePtrTable, Palette01                 ;($A295)Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette02                 ;($A2A1)Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette03                 ;($A29B)Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette04                 ;($A2A7)Samus varia suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette05                 ;($A2AD)Alternate room palette.
    PtrTableEntryArea PalettePtrTable, Palette06                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette07                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette08                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette09                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0A                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0B                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0C                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0D                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0E                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette0F                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette10                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette11                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette12                 ;($A2D0)
    PtrTableEntryArea PalettePtrTable, Palette13                 ;($A2D0)Samus fade in palette. Same regardless of varia suit and suitless.
    PtrTableEntryArea PalettePtrTable, Palette14                 ;($A2D7)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette15                 ;($A2DE)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette16                 ;($A2E5)Samus fade in palette.
    PtrTableEntryArea PalettePtrTable, Palette17                 ;($A2EC)Unused?
    PtrTableEntryArea PalettePtrTable, Palette18                 ;($A2F4)Suitless Samus power suit palette.
    PtrTableEntryArea PalettePtrTable, Palette19                 ;($A2FC)Suitless Samus varia suit palette.
    PtrTableEntryArea PalettePtrTable, Palette1A                 ;($A304)Suitless Samus power suit with missiles selected palette.
    PtrTableEntryArea PalettePtrTable, Palette1B                 ;($A30C)Suitless Samus varia suit with missiles selected palette.

SpecItmsTblPtr:
    .word SpecItmsTbl_{AREA}               ;($A3D6)Beginning of special items table.

.DSTRUCT AreaPointers_ROM INSTANCEOF AreaPointersStruct VALUES
    RoomPtrTable:       .word RoomPtrTable_{AREA}              ;($A314)Beginning of room pointer table.
    StructPtrTable:     .word StructPtrTable_{AREA}            ;($A372)Beginning of structure pointer table.
    MetatileDefs:       .word MetatileDefs_{AREA}              ;($AEF0)Beginning of metatile definitions.
    EnFramePtrTable1:   .word EnFramePtrTable1_{AREA}          ;($9DE0)Pointer table into enemy animation data. Two-->
    EnFramePtrTable2:   .word EnFramePtrTable2_{AREA}          ;($9EE0)tables needed to accommodate all entries.
    EnPlacePtrTable:    .word EnPlacePtrTable_{AREA}           ;($9F0E)Pointers to enemy frame placement data.
    EnAnimTable:        .word EnAnimTable_{AREA}               ;($9D6A)Index to values in addr tables for enemy animations.
.ENDST

; Tourian-specific jump table (dummied out in other banks)
;  Each line is RTS, NOP, NOP in this bank
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA

AreaRoutine: ; L95C3
    jmp AreaRoutineStub_{AREA} ; Just an RTS

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts

; area init data
    .byte $FF                       ;Not used.
AreaMusicFlag:
    .byte music_Brinstar            ;Brinstar music init flag.
AreaEnemyDamage:
    .word $0080                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $2B, $2C, $28, $0B, $1C, $0A, $1A

AreaMapPosX:
    .byte $03   ;Samus start x coord on world map.
AreaMapPosY:
    .byte $0E   ;Samus start y coord on world map.
AreaSamusY:
    .byte $B0   ;Samus start vertical screen position.

AreaPaletteToggle:
    .byte _id_Palette00+1

    .byte $00
AreaEnProjectileKilledAnimIndex:
    .byte EnAnim_EnProjectileKilled_{AREA} - EnAnimTable_{AREA}
AreaExplosionAnimIndex:
    .byte EnAnim_Explosion_{AREA} - EnAnimTable_{AREA}

    .byte $00, $00
AreaEnProjectileFallingAnimIndex:
    .byte $00, $00
AreaEnProjectileSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine_{AREA} ; 00 - Sidehopper (unused)
        .word SidehopperCeilingAIRoutine_{AREA} ; 01 - Ceiling sidehopper (unused)
        .word WaverAIRoutine_{AREA} ; 02 - Waver
        .word RipperAIRoutine_{AREA} ; 03 - Ripper
        .word SkreeAIRoutine_{AREA} ; 04 - Skree
        .word CrawlerAIRoutine_{AREA} ; 05 - Zoomer (crawler)
        .word RioAIRoutine_{AREA} ; 06 - Rio (swoopers)
        .word PipeBugAIRoutine_{AREA} ; 07 - Zeb
        .word KraidAIRoutine_{AREA} ; 08 - Kraid (crashes due to bug)
        .word KraidLintAIRoutine_{AREA} ; 09 - Kraid's lint (crashes)
        .word KraidNailAIRoutine_{AREA} ; 0A - Kraid's nail (crashes)
        .word $0000 ; 0B - Null pointers (hard crash)
        .word $0000 ; 0C - Null
        .word $0000 ; 0D - Null
        .word $0000 ; 0E - Null
        .word $0000 ; 0F - Null

; Animation related table ?
EnemyDeathAnimIndex:
    .byte EnAnim_SidehopperFloorExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorExplode_{AREA} - EnAnimTable_{AREA} ; 00 - Sidehopper (unused)
    .byte EnAnim_SidehopperCeilingExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingExplode_{AREA} - EnAnimTable_{AREA} ; 01 - Ceiling sidehopper (unused)
    .byte EnAnim_WaverExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_WaverExplode_L_{AREA} - EnAnimTable_{AREA} ; 02 - Waver
    .byte EnAnim_RipperExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_RipperExplode_L_{AREA} - EnAnimTable_{AREA} ; 03 - Ripper
    .byte EnAnim_SkreeExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_SkreeExplode_{AREA} - EnAnimTable_{AREA} ; 04 - Skree
    .byte EnAnim_ZoomerExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_ZoomerExplode_{AREA} - EnAnimTable_{AREA} ; 05 - Zoomer (crawler)
    .byte EnAnim_RioExplode_{AREA} - EnAnimTable_{AREA}, EnAnim_RioExplode_{AREA} - EnAnimTable_{AREA} ; 06 - Rio (swoopers)
    .byte EnAnim_ZebExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_ZebExplode_L_{AREA} - EnAnimTable_{AREA} ; 07 - Zeb
    .byte EnAnim_KraidExplode_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidExplode_L_{AREA} - EnAnimTable_{AREA} ; 08 - Kraid (crashes due to bug)
    .byte $00, $00 ; 09 - Kraid's lint (crashes)
    .byte $00, $00 ; 0A - Kraid's nail (crashes)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0B - Null pointers (hard crash)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0C - Null
    .byte $00, $00 ; 0D - Null
    .byte $00, $00 ; 0E - Null
    .byte $00, $00 ; 0F - Null

EnemyHealthTbl:
    .byte $08 ; 00 - Sidehopper (unused)
    .byte $08 ; 01 - Ceiling sidehopper (unused)
    .byte $04 ; 02 - Waver
    .byte $FF ; 03 - Ripper
    .byte $02 ; 04 - Skree
    .byte $02 ; 05 - Zoomer (crawler)
    .byte $04 ; 06 - Rio (swoopers)
    .byte $01 ; 07 - Zeb
    .byte $20 ; 08 - Kraid (crashes due to bug)
    .byte $FF ; 09 - Kraid's lint (crashes)
    .byte $FF ; 0A - Kraid's nail (crashes)
    .byte $04 ; 0B - Null pointers (hard crash)
    .byte $01 ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

; ResetAnimIndex table for resting enemy
EnemyRestingAnimIndex:
    .byte EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA} ; 00 - Sidehopper (unused)
    .byte EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA} ; 01 - Ceiling sidehopper (unused)
    .byte EnAnim_Waver0_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Waver0_L_{AREA} - EnAnimTable_{AREA} ; 02 - Waver
    .byte EnAnim_Ripper_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Ripper_L_{AREA} - EnAnimTable_{AREA} ; 03 - Ripper
    .byte EnAnim_Skree_{AREA} - EnAnimTable_{AREA}, EnAnim_Skree_{AREA} - EnAnimTable_{AREA} ; 04 - Skree
    .byte EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA} ; 05 - Zoomer (crawler)
    .byte EnAnim_Rio_{AREA} - EnAnimTable_{AREA}, EnAnim_Rio_{AREA} - EnAnimTable_{AREA} ; 06 - Rio (swoopers)
    .byte EnAnim_ZebResting_R_{AREA} - EnAnimTable_{AREA}, EnAnim_ZebResting_L_{AREA} - EnAnimTable_{AREA} ; 07 - Zeb
    .byte EnAnim_Kraid_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Kraid_L_{AREA} - EnAnimTable_{AREA} ; 08 - Kraid (crashes due to bug)
    .byte EnAnim_KraidLint_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidLint_L_{AREA} - EnAnimTable_{AREA} ; 09 - Kraid's lint (crashes)
    .byte EnAnim_KraidNailIdle_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailIdle_L_{AREA} - EnAnimTable_{AREA} ; 0A - Kraid's nail (crashes)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0B - Null pointers (hard crash)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0C - Null
    .byte $00, $00 ; 0D - Null
    .byte $00, $00 ; 0E - Null
    .byte $00, $00 ; 0F - Null

; ResetAnimIndex table for active enemy
EnemyActiveAnimIndex:
    .byte EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperFloorIdle_{AREA} - EnAnimTable_{AREA} ; 00 - Sidehopper (unused)
    .byte EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA}, EnAnim_SidehopperCeilingIdle_{AREA} - EnAnimTable_{AREA} ; 01 - Ceiling sidehopper (unused)
    .byte EnAnim_Waver0_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Waver0_L_{AREA} - EnAnimTable_{AREA} ; 02 - Waver
    .byte EnAnim_Ripper_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Ripper_L_{AREA} - EnAnimTable_{AREA} ; 03 - Ripper
    .byte EnAnim_Skree_{AREA} - EnAnimTable_{AREA}, EnAnim_Skree_{AREA} - EnAnimTable_{AREA} ; 04 - Skree
    .byte EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA}, EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA} ; 05 - Zoomer (crawler)
    .byte EnAnim_Rio_{AREA} - EnAnimTable_{AREA}, EnAnim_Rio_{AREA} - EnAnimTable_{AREA} ; 06 - Rio (swoopers)
    .byte EnAnim_Zeb_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Zeb_L_{AREA} - EnAnimTable_{AREA} ; 07 - Zeb
    .byte EnAnim_Kraid_R_{AREA} - EnAnimTable_{AREA}, EnAnim_Kraid_L_{AREA} - EnAnimTable_{AREA} ; 08 - Kraid (crashes due to bug)
    .byte EnAnim_KraidLint_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidLint_L_{AREA} - EnAnimTable_{AREA} ; 09 - Kraid's lint (crashes)
    .byte EnAnim_KraidNailMoving_R_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailMoving_L_{AREA} - EnAnimTable_{AREA} ; 0A - Kraid's nail (crashes)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0B - Null pointers (hard crash)
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA} ; 0C - Null
    .byte $00, $00 ; 0D - Null
    .byte $00, $00 ; 0E - Null
    .byte $00, $00 ; 0F - Null

;another animation related table
L967B:
    .byte $00 ; 00 - Sidehopper (unused)
    .byte $00 ; 01 - Ceiling sidehopper (unused)
    .byte $00 ; 02 - Waver
    .byte $00 | $80 ; 03 - Ripper
    .byte $00 ; 04 - Skree
    .byte $00 ; 05 - Zoomer (crawler)
    .byte $00 ; 06 - Rio (swoopers)
    .byte $00 ; 07 - Zeb
    .byte $00 ; 08 - Kraid (crashes due to bug)
    .byte $00 ; 09 - Kraid's lint (crashes)
    .byte $00 ; 0A - Kraid's nail (crashes)
    .byte $00 ; 0B - Null pointers (hard crash)
    .byte $00 | $80 ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

; Bit 7: for when bit 1 is set, 0=force y axis only, 1=force y and x axis
; Bit 5: 0=enemy bounces, 1=enemy doesn't bounce
; Bit 5: EnemyMovementInstr_FE failure -> 0=nothing. 1=set EnData05 to (~(facing dir bits) | (bits 0-4 of this)) 
; Bits 0-4 are used when bit 5 is set
; Bit 4: don't do normal enemy touch Samus reaction, let the AI do a custom touch reaction
; Bits 2-3: #%00,#%01=normal enemy hit sound, #%10=big enemy hit sound, #%11=metroid hit sound
; Bit 1: force enemy speed to point towards samus
; Bit 0: can drop big energy
L968B:
    .byte %00000001 ; 00 - Sidehopper (unused)
    .byte %00000001 ; 01 - Ceiling sidehopper (unused)
    .byte %00000001 ; 02 - Waver
    .byte %00000000 ; 03 - Ripper
    .byte %10000110 ; 04 - Skree
    .byte %00000100 ; 05 - Zoomer (crawler)
    .byte %10001001 ; 06 - Rio (swoopers)
    .byte %10000000 ; 07 - Zeb
    .byte %10000001 ; 08 - Kraid (crashes due to bug)
    .byte %00000000 ; 09 - Kraid's lint (crashes)
    .byte %00000000 ; 0A - Kraid's nail (crashes)
    .byte %00000000 ; 0B - Null pointers (hard crash)
    .byte %10000010 ; 0C - Null
    .byte %00000000 ; 0D - Null
    .byte %00000000 ; 0E - Null
    .byte %00000000 ; 0F - Null

; EnData0D table (set upon load, and a couple other times)
EnemyForceSpeedTowardsSamusDelayTbl:
    .byte $01 ; 00 - Sidehopper (unused)
    .byte $01 ; 01 - Ceiling sidehopper (unused)
    .byte $01 ; 02 - Waver
    .byte $01 ; 03 - Ripper
    .byte $01 ; 04 - Skree
    .byte $01 ; 05 - Zoomer (crawler)
    .byte $01 ; 06 - Rio (swoopers)
    .byte $01 ; 07 - Zeb
    .byte $20 ; 08 - Kraid (crashes due to bug)
    .byte $01 ; 09 - Kraid's lint (crashes)
    .byte $01 ; 0A - Kraid's nail (crashes)
    .byte $01 ; 0B - Null pointers (hard crash)
    .byte $40 ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

; Update EnData05 bit 4 or bit 3 depending on whether samus is close enough to the enemy
; bit 7: 0=EnData05 bit 4, 1=EnData05 bit 3
; bit 4-6: zero
; bit 0-3: number of blocks distance threshold in the axis indicated by EnData05 bit 7
EnemyDistanceToSamusThreshold:
    .byte $00 ; 00 - Sidehopper (unused)
    .byte $00 ; 01 - Ceiling sidehopper (unused)
    .byte $6 | (0 << 7) ; 02 - Waver
    .byte $00 ; 03 - Ripper
    .byte $3 | (1 << 7) ; 04 - Skree
    .byte $00 ; 05 - Zoomer (crawler)
    .byte $8 | (1 << 7) ; 06 - Rio (swoopers)
    .byte $00 ; 07 - Zeb
    .byte $00 ; 08 - Kraid (crashes due to bug)
    .byte $00 ; 09 - Kraid's lint (crashes)
    .byte $00 ; 0A - Kraid's nail (crashes)
    .byte $00 ; 0B - Null pointers (hard crash)
    .byte $00 ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

EnemyInitDelayTbl:
    .byte $08 ; 00 - Sidehopper (unused)
    .byte $08 ; 01 - Ceiling sidehopper (unused)
    .byte $01 ; 02 - Waver
    .byte $01 ; 03 - Ripper
    .byte $01 ; 04 - Skree
    .byte $01 ; 05 - Zoomer (crawler)
    .byte $10 ; 06 - Rio (swoopers)
    .byte $08 ; 07 - Zeb
    .byte $10 ; 08 - Kraid (crashes due to bug)
    .byte $00 ; 09 - Kraid's lint (crashes)
    .byte $00 ; 0A - Kraid's nail (crashes)
    .byte $01 ; 0B - Null pointers (hard crash)
    .byte $01 ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

; Index to a table starting at EnemyMovementChoices
EnemyMovementChoiceOffset:
    .byte EnemyMovementChoice_SidehopperFloor_{AREA} - EnemyMovementChoices ; 00 - Sidehopper (unused)
    .byte EnemyMovementChoice_SidehopperCeiling_{AREA} - EnemyMovementChoices ; 01 - Ceiling sidehopper (unused)
    .byte EnemyMovementChoice_Waver_{AREA} - EnemyMovementChoices ; 02 - Waver
    .byte EnemyMovementChoice_Ripper_{AREA} - EnemyMovementChoices ; 03 - Ripper
    .byte EnemyMovementChoice_Skree_{AREA} - EnemyMovementChoices ; 04 - Skree
    .byte EnemyMovementChoice_Zoomer_{AREA} - EnemyMovementChoices ; 05 - Zoomer (crawler) (enemy moves manually)
    .byte EnemyMovementChoice_Rio_{AREA} - EnemyMovementChoices ; 06 - Rio (swoopers)
    .byte EnemyMovementChoice_Zeb_{AREA} - EnemyMovementChoices ; 07 - Zeb
    .byte EnemyMovementChoice_Kraid_{AREA} - EnemyMovementChoices ; 08 - Kraid (crashes due to bug)
    .byte EnemyMovementChoice_KraidLint_{AREA} - EnemyMovementChoices ; 09 - Kraid's lint (crashes)
    .byte EnemyMovementChoice_KraidNail_{AREA} - EnemyMovementChoices ; 0A - Kraid's nail (crashes)
    .byte EnemyMovementChoice_Zoomer_{AREA} - EnemyMovementChoices ; 0B - Null pointers (hard crash)
    .byte EnemyMovementChoice08_{AREA} - EnemyMovementChoices ; 0C - Null
    .byte $00 ; 0D - Null
    .byte $00 ; 0E - Null
    .byte $00 ; 0F - Null

; EnData08*2 + one of the low bits of EnData05 is used as an index to this pointer table
; Pointer table to enemy movement strings
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

; enemy accel y table ($972B)
EnAccelYTable:
    .byte $7F, $40, $30, $C0, $D0, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
; enemy accel x table ($973F)
EnAccelXTable:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
; enemy speed y table ($9753)
EnSpeedYTable:
    .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
; enemy speed x table ($9767)
EnSpeedXTable:
    .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

; Behavior-Related Table?
; bit7: bit7 of EnData05 for pipe bug
; bit6: 0=enemy uses movement strings. 1=enemy uses acceleration and speed and subpixels.
; bit4: 0=is not metroid, 1=is metroid
; bit2-3: bit6-7 of EnsExtra.0.data1F for resting enemies
; bit1: toggle bit2 of EnData05 in EnemyIfMoveFailedDown/EnemyIfMoveFailedUp
; bit0: toggle bit0 of EnData05 in EnemyIfMoveFailedRight/EnemyIfMoveFailedLeft
L977B:
    .byte %01100100 ; 00 - Sidehopper (unused)
    .byte %01101100 ; 01 - Ceiling sidehopper (unused)
    .byte %00100001 ; 02 - Waver
    .byte %00000001 ; 03 - Ripper
    .byte %00000100 ; 04 - Skree
    .byte %00000000 ; 05 - Zoomer (crawler)
    .byte %01001100 ; 06 - Rio (swoopers)
    .byte %01000000 ; 07 - Zeb
    .byte %00000100 ; 08 - Kraid (crashes due to bug)
    .byte %00000000 ; 09 - Kraid's lint (crashes)
    .byte %00000000 ; 0A - Kraid's nail (crashes)
    .byte %01000000 ; 0B - Null pointers (hard crash)
    .byte %01000000 ; 0C - Null
    .byte %00000000 ; 0D - Null
    .byte %00000000 ; 0E - Null
    .byte %00000000 ; 0F - Null

; Enemy animation related table?
EnProjectileRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_KraidNailMoving_L_{AREA} - EnAnimTable_{AREA}, EnAnim_KraidNailIdle_L_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}, EnAnim_Mellow_{AREA} - EnAnimTable_{AREA}
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

; Another movement pointer table?
; Referenced using EnData0A
EnProjectileMovementPtrTable:
    .word EnProjectileMovement0_{AREA}
    .word EnProjectileMovement1_{AREA}
    .word EnProjectileMovement2_{AREA}
    .word EnProjectileMovement3_{AREA}

; Referenced by LFE83
TileBlastFramePtrTable:
    .word TileBlastFrame00_{AREA}
    .word TileBlastFrame01_{AREA}
    .word TileBlastFrame02_{AREA}
    .word TileBlastFrame03_{AREA}
    .word TileBlastFrame04_{AREA}
    .word TileBlastFrame05_{AREA}
    .word TileBlastFrame06_{AREA}
    .word TileBlastFrame07_{AREA}
    .word TileBlastFrame08_{AREA}
    .word TileBlastFrame09_{AREA}
    .word TileBlastFrame0A_{AREA}
    .word TileBlastFrame0B_{AREA}
    .word TileBlastFrame0C_{AREA}
    .word TileBlastFrame0D_{AREA}
    .word TileBlastFrame0E_{AREA}
    .word TileBlastFrame0F_{AREA}
    .word TileBlastFrame10_{AREA}

; If I'm reading the code correctly, this table is accessed with this formula:
;  EnData08 = EnemyMovementChoices[(EnemyMovementChoices[EnemyMovementChoiceOffset[EnemyDataIndex]] and (FrameCount xor RandomNumber1))+1]
; These values are used as indexes into EnAccelYTable, EnAccelXTable, EnSpeedYTable, EnSpeedXTable.
EnemyMovementChoices:
EnemyMovementChoice_SidehopperFloor_{AREA}:
    EnemyMovementChoiceEntry $01, $02
EnemyMovementChoice_SidehopperCeiling_{AREA}:
    EnemyMovementChoiceEntry $03, $04
EnemyMovementChoice_Waver_{AREA}:
    EnemyMovementChoiceEntry $05
EnemyMovementChoice_Ripper_{AREA}:
    EnemyMovementChoiceEntry $06
EnemyMovementChoice_Skree_{AREA}:
    EnemyMovementChoiceEntry $07
EnemyMovementChoice_Rio_{AREA}:
    EnemyMovementChoiceEntry $08
EnemyMovementChoice_Zeb_{AREA}:
    EnemyMovementChoiceEntry $09
EnemyMovementChoice_Zoomer_{AREA}: ; enemy moves manually
    EnemyMovementChoiceEntry $00
EnemyMovementChoice08_{AREA}: ; unused
    EnemyMovementChoiceEntry $0B
EnemyMovementChoice_Kraid_{AREA}: ; unused
    EnemyMovementChoiceEntry $0C, $0D
EnemyMovementChoice_KraidLint_{AREA}: ; unused
    EnemyMovementChoiceEntry $0E
EnemyMovementChoice_KraidNail_{AREA}: ; unused
    EnemyMovementChoiceEntry $0F, $10, $11, $0F

;-------------------------------------------------------------------------------
;I believe this is the point where the level banks don't need to match addresses
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Enemy movement strings (pointed to by the table L96DB)
;  These are decoded/read starting at about L8244 in areas_common.asm
;  An enemy may use these if bit 6 of their value on the table at L977B is set
;  EnCounter determined the offset within the string to be read
;
; Format
; values <0xF0 specify a duration in frames, followed by a bitpacked velocity vector
; 0xFA-0xFE are control codes I haven't deciphered yet
; 0xFF is "restart"

; unused (???)
EnemyMovement00_R_{AREA}:
    SignMagSpeed $20,  2,  2
    EnemyMovementInstr_FE

EnemyMovement00_L_{AREA}:
    SignMagSpeed $20, -2,  2
    EnemyMovementInstr_FE

EnemyMovement01_R_{AREA}:
EnemyMovement01_L_{AREA}:
EnemyMovement02_R_{AREA}:
EnemyMovement02_L_{AREA}:
EnemyMovement03_R_{AREA}:
EnemyMovement03_L_{AREA}:
EnemyMovement04_R_{AREA}:
EnemyMovement04_L_{AREA}:
    ; nothing

; waver
EnemyMovement05_R_{AREA}:
    SignMagSpeed $02,  2, -7
    SignMagSpeed $04,  2, -6
    SignMagSpeed $04,  2, -5
    SignMagSpeed $05,  2, -3
    SignMagSpeed $03,  2, -1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2,  1
    SignMagSpeed $03,  2,  3
    SignMagSpeed $05,  2,  5
    SignMagSpeed $04,  2,  6
    SignMagSpeed $02,  2,  7
    SignMagSpeed $02,  2,  7
    SignMagSpeed $04,  2,  6
    SignMagSpeed $04,  2,  5
    SignMagSpeed $05,  2,  3
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2, -1
    SignMagSpeed $03,  2, -3
    SignMagSpeed $05,  2, -5
    SignMagSpeed $04,  2, -6
    SignMagSpeed $02,  2, -7
    EnemyMovementInstr_ClearEnJumpDsplcmnt

    SignMagSpeed $03,  2, -5
    SignMagSpeed $06,  2, -3
    SignMagSpeed $08,  2, -1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2,  1
    SignMagSpeed $05,  2,  3
    SignMagSpeed $04,  2,  5
    SignMagSpeed $03,  2,  5
    SignMagSpeed $06,  2,  3
    SignMagSpeed $08,  2,  1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2, -1
    SignMagSpeed $05,  2, -3
    SignMagSpeed $04,  2, -5
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    EnemyMovementInstr_Restart

EnemyMovement05_L_{AREA}:
    SignMagSpeed $02, -2, -7
    SignMagSpeed $04, -2, -6
    SignMagSpeed $04, -2, -5
    SignMagSpeed $05, -2, -3
    SignMagSpeed $03, -2, -1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2,  1
    SignMagSpeed $03, -2,  3
    SignMagSpeed $05, -2,  5
    SignMagSpeed $04, -2,  6
    SignMagSpeed $02, -2,  7
    SignMagSpeed $02, -2,  7
    SignMagSpeed $04, -2,  6
    SignMagSpeed $04, -2,  5
    SignMagSpeed $05, -2,  3
    SignMagSpeed $03, -2,  1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2, -1
    SignMagSpeed $03, -2, -3
    SignMagSpeed $05, -2, -5
    SignMagSpeed $04, -2, -6
    SignMagSpeed $02, -2, -7
    EnemyMovementInstr_ClearEnJumpDsplcmnt

    SignMagSpeed $03, -2, -5
    SignMagSpeed $06, -2, -3
    SignMagSpeed $08, -2, -1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2,  1
    SignMagSpeed $05, -2,  3
    SignMagSpeed $04, -2,  5
    SignMagSpeed $03, -2,  5
    SignMagSpeed $06, -2,  3
    SignMagSpeed $08, -2,  1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2, -1
    SignMagSpeed $05, -2, -3
    SignMagSpeed $04, -2, -5
    EnemyMovementInstr_ClearEnJumpDsplcmnt
    EnemyMovementInstr_Restart

; ripper
EnemyMovement06_R_{AREA}:
    SignMagSpeed $01,  1,  0
    EnemyMovementInstr_Restart

EnemyMovement06_L_{AREA}:
    SignMagSpeed $01, -1,  0
    EnemyMovementInstr_Restart

; skree
EnemyMovement07_R_{AREA}:
    SignMagSpeed $04,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  6
    SignMagSpeed $01,  2,  4
    SignMagSpeed $04,  2,  6
    EnemyMovementInstr_RepeatPreviousUntilFailure
    SignMagSpeed $01,  0,  0
    SignMagSpeed $64,  0,  0
    EnemyMovementInstr_StopMovement

EnemyMovement07_L_{AREA}:
    SignMagSpeed $04, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  6
    SignMagSpeed $01, -2,  4
    SignMagSpeed $04, -2,  6
    EnemyMovementInstr_RepeatPreviousUntilFailure
    SignMagSpeed $01,  0,  0
    SignMagSpeed $64,  0,  0
    EnemyMovementInstr_StopMovement


EnemyMovement08_R_{AREA}:
EnemyMovement08_L_{AREA}:
EnemyMovement09_R_{AREA}:
EnemyMovement09_L_{AREA}:
EnemyMovement0A_R_{AREA}:
EnemyMovement0A_L_{AREA}:
EnemyMovement0B_R_{AREA}:
EnemyMovement0B_L_{AREA}:
    ; nothing

; unused (kraid)
EnemyMovement0C_R_{AREA}:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0C_L_{AREA}:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_R_{AREA}:
    SignMagSpeed $1E,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E, -1,  1
    EnemyMovementInstr_FE

EnemyMovement0D_L_{AREA}:
    SignMagSpeed $1E, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E,  1,  1
    EnemyMovementInstr_FE

; unused (kraid lint)
EnemyMovement0E_R_{AREA}:
    SignMagSpeed $50,  4,  0
    EnemyMovementInstr_Restart

EnemyMovement0E_L_{AREA}:
    SignMagSpeed $50, -4,  0
    EnemyMovementInstr_Restart

; unused (kraid nail)
EnemyMovement0F_R_{AREA}:
    SignMagSpeed $02,  3, -7
    SignMagSpeed $04,  3, -6
    SignMagSpeed $04,  3, -5
    SignMagSpeed $05,  3, -3
    SignMagSpeed $03,  3, -1
    SignMagSpeed $04,  3,  0
    SignMagSpeed $05,  3,  1
    SignMagSpeed $03,  3,  3
    SignMagSpeed $05,  3,  5
    SignMagSpeed $04,  3,  6
    SignMagSpeed $50,  3,  7
    EnemyMovementInstr_Restart

EnemyMovement0F_L_{AREA}:
    SignMagSpeed $02, -3, -7
    SignMagSpeed $04, -3, -6
    SignMagSpeed $04, -3, -5
    SignMagSpeed $05, -3, -3
    SignMagSpeed $03, -3, -1
    SignMagSpeed $04, -3,  0
    SignMagSpeed $05, -3,  1
    SignMagSpeed $03, -3,  3
    SignMagSpeed $05, -3,  5
    SignMagSpeed $04, -3,  6
    SignMagSpeed $50, -3,  7
    EnemyMovementInstr_Restart

EnemyMovement10_R_{AREA}:
    SignMagSpeed $02,  4, -7
    SignMagSpeed $04,  4, -6
    SignMagSpeed $04,  4, -5
    SignMagSpeed $05,  4, -3
    SignMagSpeed $03,  4, -1
    SignMagSpeed $04,  4,  0
    SignMagSpeed $05,  4,  1
    SignMagSpeed $03,  4,  3
    SignMagSpeed $05,  4,  5
    SignMagSpeed $04,  4,  6
    SignMagSpeed $50,  4,  7
    EnemyMovementInstr_Restart

EnemyMovement10_L_{AREA}:
    SignMagSpeed $02, -4, -7
    SignMagSpeed $04, -4, -6
    SignMagSpeed $04, -4, -5
    SignMagSpeed $05, -4, -3
    SignMagSpeed $03, -4, -1
    SignMagSpeed $04, -4,  0
    SignMagSpeed $05, -4,  1
    SignMagSpeed $03, -4,  3
    SignMagSpeed $05, -4,  5
    SignMagSpeed $04, -4,  6
    SignMagSpeed $50, -4,  7
    EnemyMovementInstr_Restart

EnemyMovement11_R_{AREA}:
    SignMagSpeed $02,  2, -7
    SignMagSpeed $04,  2, -6
    SignMagSpeed $04,  2, -5
    SignMagSpeed $05,  2, -3
    SignMagSpeed $03,  2, -1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2,  1
    SignMagSpeed $03,  2,  3
    SignMagSpeed $05,  2,  5
    SignMagSpeed $04,  2,  6
    SignMagSpeed $50,  2,  7
    EnemyMovementInstr_Restart

EnemyMovement11_L_{AREA}:
    SignMagSpeed $02, -2, -7
    SignMagSpeed $04, -2, -6
    SignMagSpeed $04, -2, -5
    SignMagSpeed $05, -2, -3
    SignMagSpeed $03, -2, -1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2,  1
    SignMagSpeed $03, -2,  3
    SignMagSpeed $05, -2,  5
    SignMagSpeed $04, -2,  6
    SignMagSpeed $50, -2,  7
    EnemyMovementInstr_Restart

;-------------------------------------------------------------------------------

; Instruction (?) strings of a different type pointed to by EnProjectileMovementPtrTable
EnProjectileMovement0_{AREA}:
    SignMagSpeed $04,  3, -3
    SignMagSpeed $05,  3, -2
    SignMagSpeed $06,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $06,  3,  1
    SignMagSpeed $05,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

EnProjectileMovement1_{AREA}:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement2_{AREA}:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnProjectileMovement3_{AREA}:
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

;-------------------------------------------------------------------------------

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

.include "enemies/sidehopper.asm"

;-------------------------------------------------------------------------------

.include "enemies/ripper.asm"

;-------------------------------------------------------------------------------

.include "enemies/waver.asm"

;-------------------------------------------------------------------------------
; SkreeRoutine
.include "enemies/skree.asm"
; The crawler routine below depends upon two of the exit labels in skree.asm

;-------------------------------------------------------------------------------

.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------
; Rio/Swooper Routine
.include "enemies/rio.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Brinstar Kraid Routine
.include "enemies/kraid.asm"
; Note: For this bank the functions StorePositionToTemp and LoadPositionFromTemp
;  are in are in kraid.asm. Extract those functions from that file if you plan
;  on removing it.

AreaRoutineStub_{AREA}: ;L9D35
    rts

; Strings pointed to by TileBlastFramePtrTable
TileBlastFrame00_{AREA}:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01_{AREA}:
    .byte $22
    .byte $80, $81
    .byte $82, $83

TileBlastFrame02_{AREA}:
    .byte $22
    .byte $84, $85
    .byte $86, $87

TileBlastFrame03_{AREA}:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

TileBlastFrame04_{AREA}:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

TileBlastFrame05_{AREA}:
    .byte $22
    .byte $94, $95
    .byte $96, $97

TileBlastFrame06_{AREA}:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

TileBlastFrame07_{AREA}:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

TileBlastFrame08_{AREA}:
    .byte $22
    .byte $90, $91
    .byte $92, $93

TileBlastFrame09_{AREA}:
    .byte $32
    .byte $4E, $4E
    .byte $4E, $4E
    .byte $4E, $4E

TileBlastFrame0A_{AREA}:
TileBlastFrame0B_{AREA}:
TileBlastFrame0C_{AREA}:
TileBlastFrame0D_{AREA}:
TileBlastFrame0E_{AREA}:
TileBlastFrame0F_{AREA}:
TileBlastFrame10_{AREA}:
    ; nothing

.include "brinstar/enemy_sprite_data.asm"

;----------------------------------------[ Palette data ]--------------------------------------------

.include "brinstar/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "brinstar/room_ptrs.asm"

.include "brinstar/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "brinstar/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "brinstar/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "brinstar/structures.asm"

;----------------------------------------[ Metatile definitions ]---------------------------------------

.include "brinstar/metatiles.asm"

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0
.elif BUILDTARGET == "NES_PAL"
    .byte $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0, $17
.endif

;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/brinstar.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/brinstar.asm"
.endif

; Errant Mother Brain BG tiles (unused)
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .incbin "tourian/bg_chr.chr" skip $495 read $CB
.elif BUILDTARGET == "NES_CNSUS"
    .incbin "tourian/bg_chr_cnsus.chr" skip $495 read $CB
.elif BUILDTARGET == "NES_PAL"
    .byte $85, $03, $A9, $0C, $85, $11, $B1, $75, $10, $14, $C9, $FF, $D0, $05, $85, $74
    .byte $4C, $49, $F0, $C8, $E6, $59, $29, $7F, $85, $0F, $B1, $75, $D0, $04, $85, $0F
    .byte $A9, $01, $85, $10, $C8, $E6, $59, $A9, $00, $85, $08, $A5, $0F, $48, $0A, $AA
    .byte $A5, $38, $4A, $A5, $6D, $D0, $16, $90, $0A, $BD, $77, $F3, $48, $BD, $76, $F3
    .byte $4C, $FB, $F1, $BD, $F3, $F2, $48, $BD, $F2, $F2, $4C, $FB, $F1, $30, $16, $90
    .byte $0A, $BD, $B3, $96, $48, $BD, $B2, $96, $4C, $FB, $F1, $BD, $CD, $95, $48, $BD
    .byte $CC, $95, $4C, $FB, $F1, $90, $0A, $BD, $C9, $F4, $48, $BD, $C8, $F4, $4C, $FB
    .byte $F1, $BD, $4D, $F4, $48, $BD, $4C, $F4, $A6, $02, $95, $E0, $E8, $68, $95, $E0
    .byte $E8, $86, $02, $68, $85, $05, $48, $4A, $4A, $AA, $A5, $6D, $D0, $06, $BD, $E1
    .byte $F2, $4C, $22, $F2, $30, $06, $BD, $AF, $95, $4C, $22, $F2, $BD, $3C, $F4, $85
    .byte $04, $68, $29, $03, $AA, $E8, $A5, $04, $CA, $F0, $05, $4A, $4A
.endif


.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .section "ROM Bank $001 - Music Engine" bank 1 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $001 - Music Engine" bank 1 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $001 - Vectors" bank 1 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

