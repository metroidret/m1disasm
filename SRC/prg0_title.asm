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

;Title/end (memory page 0)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.def BANK = 0
.def AREA = {"BANK{BANK}"}
.section "ROM Bank $000" bank 0 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

MainTitleRoutine: ; 00:8000
    ;If intro routines not running, branch.
    lda TitleRoutine
    cmp #_id_StartContinueScreen15.b
    bcs L8027
    ;if start has not been pressed, branch.
    lda Joy1Change
    and #BUTTON_START
    beq L8022
        ; clear unused variables
        ldy #$00
        sty SpareMemD1
        sty SpareMemBB
        sty SpareMemB7
        sty SpareMemB8
        ;Set name table to name table 0.
        lda PPUCTRL_ZP
        and #$FC
        sta PPUCTRL_ZP
        ;start was pressed, load START/CONTINUE screen.
        lda #_id_StartContinueScreen1B.b
        sta TitleRoutine
        bne L8027 ;Branch always.
    L8022:
        ;($C1BC)Remove sparkle and crosshair sprites from screen.
        jsr RemoveIntroSprites
        lda TitleRoutine
L8027:
    jsr JumpEngine
    TitleRoutinePtrTable:
        PtrTableEntry TitleRoutinePtrTable, InitializeAfterReset      ;($8071)First routine after reset.
        PtrTableEntry TitleRoutinePtrTable, DrawIntroBackground       ;($80D0)Draws ground on intro screen.
        PtrTableEntry TitleRoutinePtrTable, FadeInDelay               ;($80F9)Sets up METROID fade in delay.
        PtrTableEntry TitleRoutinePtrTable, METROIDFadeIn             ;($812C)Fade METROID onto screen.
        PtrTableEntry TitleRoutinePtrTable, LoadFlashTimer            ;($8142)Load timer for METROID flash.
        PtrTableEntry TitleRoutinePtrTable, FlashEffect               ;($8109)Makes METROID flash.
        PtrTableEntry TitleRoutinePtrTable, METROIDSparkle            ;($814D)Top and bottom "sparkles" on METROID.
        PtrTableEntry TitleRoutinePtrTable, METROIDFadeOut            ;($8163)Fades METROID off the screen.
        PtrTableEntry TitleRoutinePtrTable, Crosshairs                ;($8182)Displays "crosshairs" effect on screen.
        PtrTableEntry TitleRoutinePtrTable, MoreCrosshairs            ;($81D1)Continue "crosshairs" effect.
        PtrTableEntry TitleRoutinePtrTable, IncTitleRoutine0A         ;($806E)Increment TitleRoutine.
        PtrTableEntry TitleRoutinePtrTable, IncTitleRoutine0B         ;($806E)Increment TitleRoutine.
        PtrTableEntry TitleRoutinePtrTable, ChangeIntroNameTable      ;($822E)Change from name table 0 to name table 1.
        PtrTableEntry TitleRoutinePtrTable, MessageFadeIn             ;($8243)Fade in intro sequence message.
        PtrTableEntry TitleRoutinePtrTable, MessageFadeOut            ;($8263)Fade out intro sequence message.
        PtrTableEntry TitleRoutinePtrTable, DelayIntroReplay          ;($8283)Set Delay time before intro sequence restarts.
        PtrTableEntry TitleRoutinePtrTable, ClearSpareMem             ;($8068)clears some memory addresses not used by game.
        PtrTableEntry TitleRoutinePtrTable, PrepIntroRestart          ;($82A3)Prepare to restart intro routines.
        PtrTableEntry TitleRoutinePtrTable, TitleScreenOff            ;($82ED)Turn screen off.
        PtrTableEntry TitleRoutinePtrTable, TitleRoutineReturn13      ;($82F3)Rts.
        PtrTableEntry TitleRoutinePtrTable, TitleRoutineReturn14      ;($82F3)Rts.
        PtrTableEntry TitleRoutinePtrTable, StartContinueScreen15     ;($90BA)Displays START/Continue screen.
        PtrTableEntry TitleRoutinePtrTable, ChooseStartContinue       ;($90D7)player chooses between START and CONTINUE.
        PtrTableEntry TitleRoutinePtrTable, LoadPasswordScreen        ;($911A)Loads password entry screen.
        PtrTableEntry TitleRoutinePtrTable, EnterPassword             ;($9147)User enters password.
        PtrTableEntry TitleRoutinePtrTable, DisplayPassword           ;($9359)After game over, display password on screen.
        PtrTableEntry TitleRoutinePtrTable, WaitForSTART              ;($9394)Wait for START when showing password.
        PtrTableEntry TitleRoutinePtrTable, StartContinueScreen1B     ;($90BA)Displays START/Continue screen.
        PtrTableEntry TitleRoutinePtrTable, GameOver                  ;($939E)Displays "GAME OVER".
        PtrTableEntry TitleRoutinePtrTable, EndGame                   ;($9AA7)Show ending of the game.
        PtrTableEntry TitleRoutinePtrTable, SetTimer                  ;($C4AA)Set delay timer.

;----------------------------------------[ Intro routines ]------------------------------------------

ClearSpareMem: ; 00:8068
    ;Clears two memory addresses not used by the game.
    lda #$00
    sta SpareMemCB
    sta SpareMemC9
    ;Next routine is PrepIntroRestart.

IncTitleRoutine0A: ; 00:806E
IncTitleRoutine0B:
    ;Increment to next title routine.
    inc TitleRoutine
    rts

InitializeAfterReset: ; 00:8071
    ldy #$02
    sty SpareMemCF
    sty SpareMemCC
    dey ;Y=1.
    sty SpareMemCE
    sty SpareMemD1
    dey ;Y=0.
    sty SpareMemD0
    sty SpareMemCD
    sty SpareMemD3
    sty NARPASSWORD                 ;Set NARPASSWORD not active.
    sty SpareMemCB
    sty SpareMemC9
    lda #$02                        ;A=2.
    sta IntroMusicRestart           ;Title rountines cycle twice before restart of music.
    sty SpareMemB7
    sty SpareMemB8
    sty PaletteDataIndex                ;Reset index to palette data.
    sty ScreenFlashPaletteIndex         ;Reset index into screen flash palette data.
    sty IntroStarOffset             ;Reset index into IntroStarPalettePtrTable table.
    sty FadeDataIndex               ;Reset index into fade out palette data.

    ;Set $0000 to point to address $6000.
    sty $00
    ldx #>RoomRAMA
    ;The following loop Loads the RAM with the following values:
    ;$6000 thru $62FF = #$00.
    ;$6300 thru $633F = #$C0.
    ;$6340 thru $63FF = #$C4.
    ;$6400 thru $66FF = #$00.
    ;$6700 thru $673F = #$C0.
    ;$6740 thru $67FF = #$C4.
    @loop_A:
        ; save high byte to $01
        stx $01
        ; y = ((high byte) & $03) * 2
        txa
        and #$03
        asl
        tay
        ; save to $02
        sty $02
        ; load fill byte into a
        lda RamValueTbl,y
        ; loop through 256 bytes
        ldy #$00
        @loop_B:
            ; write fill byte
            sta ($00),y
            ; exit if we went through 256 bytes
            iny
            beq @exitloop_B
            ; branch if y is not #$40
            cpy #$40
            bne @loop_B
            ; y is #$40, we must change the fill byte
            ldy $02
            lda RamValueTbl+1,y
            ldy #$40
            bpl @loop_B
        @exitloop_B:
        ; exit loop when next high byte is #$68
        inx
        cpx #$68
        bne @loop_A
    ;Increment to next routine. DrawIntroBackground
    inc TitleRoutine
    ;Loads stars on intro screen.
    jmp LoadStarSprites

;The following table is used by the code above for writing values to RAM.
RamValueTbl: ; 00:80C8
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $C0, $C4

DrawIntroBackground: ; 00:80D0
    ;Initiates intro music.
    lda #sfxMulti_IntroMusic
    sta ABStatus ;Never accessed by game.
    sta MultiSFXFlag
    ;Turn screen off to draw on the screen.
    jsr ScreenOff
    ;Erase name table data.
    jsr ClearNameTables
    ;Write background of intro screen to name tables.
    ldx #<VRAMStruct_DrawIntroBackground.b
    ldy #>VRAMStruct_DrawIntroBackground.b
    jsr PreparePPUProcess
    ;Prepare to load palette data.
    lda #_id_Palette00+1.b
    sta PaletteDataPending
    sta SpareMemC5 ;Not accessed by game.
    ;Switch to name table 0
    lda PPUCTRL_ZP
    and #$FC
    sta PPUCTRL_ZP
    ;Next routine sets up METROID fade in delay. FadeInDelay
    inc TitleRoutine
    ;Not accessed by game.
    lda #$00
    sta SpareMemD7
    ;Turn screen back on.
    jmp ScreenOn

FadeInDelay: ; 00:80F9
    ;Switch to name table 0 or 2. (useless, PPUCTRL_ZP is always #$90 here)
    lda PPUCTRL_ZP
    and #$FE
    sta PPUCTRL_ZP
    ;Loads Timer3 with #$08. Delays Fade in routine by 80 frames (1.3 seconds).
    lda #$08
    sta Timer3
    ;Loads PaletteDataIndex with #$04
    lsr
    sta PaletteDataIndex
    ;Increment to next routine. METROIDFadeIn
    inc TitleRoutine
    rts

FlashEffect: ; 00:8109
    ;Every fourth frame, run change palette. Creates METROID flash effect.
    lda FrameCount
    and #$03
    bne @RTS
    ;Uses only the first four palette data sets in the flash routine.
    lda PaletteDataIndex
    and #$03
    sta PaletteDataIndex
    jsr LoadPalData
    ;If 80 frames (1.3 seconds) have not elapsed, branch so routine will keep running.
    lda Timer3
    bne @RTS
    ;Ensures the palette index was 3 when LoadPalData was called.
    lda PaletteDataIndex
    cmp #$04
    bne @RTS
    ;Increment to next routine. METROIDSparkle
    inc TitleRoutine
    jsr LoadSparkleData             ;($87AB) Loads data for next routine.
    ;Sets Timer 3 for a delay of 240 frames (4 seconds).
    lda #$18
    sta Timer3
@RTS:
    rts

METROIDFadeIn: ; 00:812C
    ; exit if 80 frames (1.3 seconds) have not elapsed yet.
    lda Timer3
    bne RTS_8141
    ;Every 16th FrameCount, Change palette. Causes the fade in effect.
    lda FrameCount
    and #$0F
    bne RTS_8141
    ;Load data into Palettes.
    jsr LoadPalData
    ; exit if the fade in still has more palettes to go through
    bne RTS_8141
    ; fade in is completed
    ;Set timer delay for METROID flash effect. Delays flash by 320 frames (5.3 seconds).
    lda #$20
    sta Timer3
    ;Increment to next routine. LoadFlashTimer
    inc TitleRoutine
RTS_8141:
    rts

LoadFlashTimer: ; 00:8142
    ;If 320 frames have not passed, exit
    lda Timer3
    bne RTS_8141
    ;Stores a value of 80 frames in Timer3 (1.3 seconds).
    lda #$08
    sta Timer3
    ;Increment to next routine. FlashEffect
    inc TitleRoutine
    rts

METROIDSparkle: ; 00:814D
    ;Wait until 3 seconds have passed since last routine before continuing.
    lda Timer3
    bne @RTS

    ;Check if sparkle sprites are done moving.
    lda IntroSprs.0.complete
    and IntroSprs.1.complete
    cmp #$01
    bne @endIf_A
        ; sparkle sprites are done moving, sparkle routine is finished
        ;Increment to next routine. METROIDFadeOut
        inc TitleRoutine
        bne @RTS
    @endIf_A:
    ; sparkle sprites are not done moving, continue with sparkle routine.
    ;Update sparkle sprites on the screen.
    jsr UpdateSparkleSprites
@RTS:
    rts

METROIDFadeOut: ; 00:8163
    ;Wait until the frame count is a multiple of eight before proceeding.
    lda FrameCount
    and #$07
    bne @RTS
    ;If FadeDataIndex is less than #$04, keep doing the palette changing routine.
    lda FadeDataIndex
    cmp #$04;
    bne @endIf_A
        ;($8897)Load initial sprite values for crosshair routine.
        jsr InitCrossMissiles
        ;Load Timer3 with a delay of 80 frames(1.3 seconds).
        lda #$08
        sta Timer3
        ;Set counter for slow sprite movement for 8 frames,
        sta CrossMsl0to3SlowDelay
        ;Set SecondCrosshairSprites = #$00
        lda #$00
        sta SecondCrosshairSprites
        ;Increment to next routine. Crosshairs
        inc TitleRoutine
    @endIf_A:
    ;Fades METROID off the screen.
    jsr DoFadeOut
@RTS:
    rts

Crosshairs: ; 00:8182
    ;Is it time to flash the screen white? If not, branch.
    lda FlashScreen
    beq @endIf_A
        ;Flash screen white.
        jsr FlashIntroScreen
    @endIf_A:
    ;Wait 80 frames from last routine before running this one.
    lda Timer3
    bne @RTS

    ;Check if first 4 sprites have completed their movements.  If not, branch.
    lda IntroSprs.0.complete
    and IntroSprs.1.complete
    and IntroSprs.2.complete
    and IntroSprs.3.complete
    beq @notComplete

    ;Prepare to flash screen and draw cross.
    ;Branch if second crosshair sprites are already active.
    lda #$01
    cmp SecondCrosshairSprites
    beq @endIf_B
        ;Indicates second crosshair sprites are active.
        inc SecondCrosshairSprites
        ;Draw cross animation on screen.
        sta IsUpdatingCrossExplode
        ;Flash screen white.
        sta FlashScreen
        ;Reset index to cross sprite data.
        lda #$00
        sta CrossExplodeLengthIndex
    @endIf_B:
    ;Check if second 4 sprites have completed their movements.  If not, branch.
    and IntroSprs.4.complete
    and IntroSprs.5.complete
    and IntroSprs.6.complete
    and IntroSprs.7.complete
    beq @notComplete

    ;Prepare to flash screen and draw cross.
    ;Draw cross animation on screen.
    lda #$01
    sta IsUpdatingCrossExplode
    ;Flash screen white.
    sta FlashScreen
    ;Loads stars on intro screen. (useless, stars are already on the screen at this point)
    jsr LoadStarSprites
    ;Reset index to cross sprite data.
    lda #$00
    sta CrossExplodeLengthIndex
    ;Increment to next routine. MoreCrosshairs
    inc TitleRoutine
    bne @complete ;Branch always.
@notComplete:
    ;Draw sprites that converge in center of screen.
    jsr UpdateCrossMissiles
@complete:
    ;Draw cross sprites in middle of the screen.
    jsr UpdateCrossExplode
@RTS:
    rts

MoreCrosshairs: ; 00:81D1
    ;Is it time to flash the screen white? If not, branch.
    lda FlashScreen
    beq @endIf_A
        ;Draw cross sprites in middle of the screen.
        jsr UpdateCrossExplode
        ;Flash screen white.
        jmp FlashIntroScreen
    @endIf_A:
    ;Increment to next routine. ChangeIntroNameTable
    inc TitleRoutine
    ;These values are written into memory, but they are not used later in the title routine.
    ;This is the remnants of some abandoned code.
    lda #$60
    sta Samus.y
    lda #$7C
    sta Samus.x
    lda Samus.animResetIndex
    sta Samus.animIndex
    rts

;Unused intro routine.
UnusedIntroRoutine1: ; 00:81EE
    lda #$01
    sta SpareMemBB
    lda #$04
    sta SpritePagePos
    sta Joy1Change
    sta Joy1Status
    sta Joy1Retrig
    lda #$03
    sta Samus.status
    sta ScrollDir
    inc TitleRoutine
    rts

;Unused intro routine. It looks like this routine-->
;was going to be used to manipulate sprite objects.
UnusedIntroRoutine2: ; 00:8206
    lda Samus.status
    cmp #$04
    bne RTS_822D
    lda #$00
    sta Samus.status
    lda #ObjAnim_SamusJumpTransition - ObjectAnimIndexTbl.b
    sta Samus.animResetIndex
    lda #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
    sta Samus.animIndex
    lda #_id_ObjFrame_SamusFront.b
    sta Samus.animFrame
    lda #$08
    sta Timer3
    lda #$00
    sta SpareMemC9 ;Not accessed by game.
    sta SpareMemCB ;Not accessed by game.
    inc TitleRoutine
RTS_822D:
    rts

ChangeIntroNameTable: ; 00:822E
    ;Change to name table 1.
    lda PPUCTRL_ZP
    ora #$01
    sta PPUCTRL_ZP
    ;Next routine to run is MessageFadeIn.
    inc TitleRoutine
    ;Set Timer3 for 80 frames(1.33 seconds).
    lda #$08
    sta Timer3
    ;Index to FadeInPaletteData.
    lda #$06
    sta FadeDataIndex
    lda #$00
    sta SpareMemC9 ;Not accessed by game.
    rts

MessageFadeIn: ; 00:8243
    ;Check if delay timer has expired.  If not, branch to exit.
    lda Timer3
    bne @RTS
    ;Perform next step of fade every 8th frame.
    lda FrameCount
    and #$07
    bne @RTS
    ;Has end of fade in palette data been reached? If not, branch.
    lda FadeDataIndex
    cmp #$0B
    bne @endIf_A
        ;Clear FadeDataIndex.
        lda #$00
        sta FadeDataIndex
        ;Set Timer3 to 480 frames(8 seconds).
        lda #$30
        sta Timer3
        ;Next routine is MessageFadeOut.
        inc TitleRoutine
        bne @RTS ;Branch always.
    @endIf_A:
    ;Fade message onto screen.
    jsr DoFadeOut
@RTS:
    rts

MessageFadeOut: ; 00:8263
    ;Check if delay timer has expired.  If not, branch to exit.
    lda Timer3
    bne @RTS
    ;Perform next step of fade every 8th frame.
    lda FrameCount
    and #$07
    bne @RTS
    ;Has end of fade out palette data been reached? If not, branch.
    lda FadeDataIndex
    cmp #$05
    bne @endIf_A
        ;Set index to start of fade in data.
        lda #$06
        sta FadeDataIndex
        lda #$00
        sta SpareMemCB ;Not accessed by game.
        ;Next routine is DelayIntroReplay.
        inc TitleRoutine
        bne @RTS ;Branch always.
    @endIf_A:
    ;Fade message off of screen.
    jsr DoFadeOut
@RTS:
    rts

DelayIntroReplay: ; 00:8283
    ;Increment to next routine. ClearSpareMem
    inc TitleRoutine
    ;Set Timer3 for a delay of 160 frames(2.6 seconds).
    lda #$10
    sta Timer3
    rts

;Unused intro routine.
UnusedIntroRoutine3: ; 00:828A
    lda Timer3
    bne RTS_82A2
    lda SpareMemB7
    bne RTS_82A2
    lda SpareMemB8
    and #$0F
    bne RTS_82A2
    lda #$01
    sta SpareMemD2
    lda #$10
    sta Timer3
    inc TitleRoutine
RTS_82A2:
    rts

PrepIntroRestart: ; 00:82A3
    ;Check if delay timer has expired.  If not, branch to exit.
    lda Timer3
    bne @RTS

    sta SpareMemD2 ;Not accessed by game.
    sta SpareMemBB ;Not accessed by game.
    sta IsSamus ;Clear IsSamus memory address.
    ;Clear RAM $0300 thru $031F.
    ldy #$1F
    @loop:
        sta Objects.0.status,y
        dey
        bpl @loop
    ;Change to name table 0.
    lda PPUCTRL_ZP
    and #$FC
    sta PPUCTRL_ZP
    ;Clear all index values from these addresses.
    iny ;Y=0.
    sty SpareMemB7 ;Accessed by unused routine.
    sty SpareMemB8 ;Accessed by unused routine.
    sty PaletteDataIndex
    sty ScreenFlashPaletteIndex
    sty IntroStarOffset
    sty FadeDataIndex
    sty SpareMemCD ;Not accessed by game.
    sty Joy1Change
    sty Joy1Status
    sty Joy1Retrig
    sty SpareMemD7 ;Not accessed by game.
    iny ;Y=1.
    sty SpareMemCE ;Not accessed by game.
    iny ;Y=2.
    sty SpareMemCC ;Not accessed by game.
    sty SpareMemCF ;Not accessed by game.
    ;Next routine sets up METROID fade in delay.
    sty TitleRoutine
    ;Check to see if intro music needs to be restarted. Branch if not.
    lda IntroMusicRestart
    bne @else_A
        ;Restart intro music.
        lda #sfxMulti_IntroMusic
        sta MultiSFXFlag
        ;Set restart of intro music after another two cycles of the title routines.
        lda #$02
        sta IntroMusicRestart
    @RTS:
        rts

    @else_A:
        ;One title routine cycle complete. Decrement intro music restart counter.
        dec IntroMusicRestart
        rts

TitleScreenOff: ; 00:82ED
    ;This routine should not be reached.
    ;Turn screen off.
    jsr ScreenOff
    ;Next routine is TitleRoutineReturn.
    inc TitleRoutine
    rts

TitleRoutineReturn13: ; 00:82F3
TitleRoutineReturn14:
    ;Last title routine function. Should not be reached.
    rts

;The following data fills name table 0 with the intro screen background graphics.
VRAMStruct_DrawIntroBackground: ; 00:82F4
    ;Information to be stored in attribute table 0.
    VRAMStructData $23C0, \
        $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

    VRAMStructData $23E0, \
        $FF, $FF, $BF, $AF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    ;Writes row $22E0 (24th row from top).
    VRAMStructData $22E0, \
        $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

    ;Writes row $2300 (25th row from top).
    VRAMStructData $2300, \
        $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

    ;Writes row $2320 (26th row from top).
    VRAMStructData $2320, \
        $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

    ;Writes row $2340 (27th row from top).
    VRAMStructData $2340, \
        $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

    ;Writes row $2360 (28th row from top).
    VRAMStructData $2360, \
        $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

    ;Writes row $2380 (29th row from top).
    VRAMStructData $2380, \
        $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

    ;Writes row $23A0 (Bottom row).
    VRAMStructData $23A0, \
        $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

    ;Writes some blank spaces in row $20A0 (6th row from top).
    VRAMStructDataRepeat $20A8, $0F, \
        " "

    ;Writes METROID graphics in row $2100 (9th row from top).
    VRAMStructData $2103, \
        $40, $5D, $56, $5D, $43, $40, $5D, $43, $40, $5D, $5D, $43, $40, $5D, $5D, $63, $62, $5D, $5D, $63, $40, $43, $40, $5D, $5D, $63, $1D, $16

    ;Writes METROID graphics in row $2120 (10th row from top).
    VRAMStructData $2123, \
        $44, $50, $50, $50, $47, $44, $57, $58, $74, $75, $76, $77, $44, $57, $69, $47, $44, $57, $69, $47, $44, $47, $44, $68, $69, $47

    ;Writes METROID graphics in row $2140 (11th row from top).
    VRAMStructData $2143, \
        $44, $41, $7E, $49, $47, $44, $59, $5A, $78, $79, $7A, $7B, $44, $59, $6D, $70, $44, $73, $72, $47, $44, $47, $44, $73, $72, $47

    ;Writes METROID graphics in row $2160 (12th row from top).
    VRAMStructData $2163, \
        $44, $42, $7F, $4A, $47, $44, $5B, $5C, $FF, $44, $47, $FF, $44, $5B, $6F, $71, $44, $45, $46, $47, $44, $47, $44, $45, $46, $47

    ;Writes METROID graphics in row $2180 (13th row from top).
    VRAMStructData $2183, \
        $44, $47, $FF, $44, $47, $44, $5F, $60, $FF, $44, $47, $FF, $44, $7D, $7C, $47, $44, $6A, $6B, $47, $44, $47, $44, $6A, $6B, $47

    ;Writes METROID graphics in row $21A0 (14th row from top).
    VRAMStructData $21A3, \
        $4C, $4F, $FF, $4C, $4F, $4C, $5E, $4F, $FF, $4C, $4F, $FF, $4C, $4D, $4E, $4F, $66, $5E, $5E, $64, $4C, $4F, $4C, $5E, $5E, $64

    ;Writes METROID graphics in row $21C0 (15th row from top).
    VRAMStructData $21C3, \
        $51, $52, $FF, $51, $52, $51, $61, $52, $FF, $51, $52, $FF, $51, $53, $54, $52, $67, $61, $61, $65, $51, $52, $51, $61, $61, $65

    ;Writes PUSH START BUTTON in row $2220 (18th row from top).
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        VRAMStructData $2227, \
            " PUSH START BUTTON   "
    .elif BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        VRAMStructData $2227, \
            "    PRESS START      "
    .endif


    ;Writes C 1986 NINTENDO in row $2260 (20th row from top).
    VRAMStructData $2269, \
        "< 1986 NINTENDO   "

;The following data fills name table 1 with the intro screen background graphics.

    ;Information to be stored in attribute table 1.
    VRAMStructData $27C0, \
        $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

    ;Writes row $27E0 (24th row from top).
    VRAMStructData $27E0, \
        $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    ;Writes row $26E0 (24th row from top).
    VRAMStructData $26E0, \
        $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

    ;Writes row $2700 (25th row from top).
    VRAMStructData $2700, \
        $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

    ;Writes row $2720 (26th row from top).
    VRAMStructData $2720, \
        $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

    ;Writes row $2740 (27th row from top).
    VRAMStructData $2740, \
        $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

    ;Writes row $2760 (28th row from top).
    VRAMStructData $2760, \
        $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

    ;Writes row $2780 (29th row from top).
    VRAMStructData $2780, \
        $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

    ;Writes row $27A0 (bottom row).
    VRAMStructData $27A0, \
        $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

    ;Writes row $2480 (5th row from top).
    VRAMStructData $2488, \
        "EMERGENCY ORDER"

    ;Writes row $2500 (9th row from top).
    VRAMStructData $2504, \
        "DEFEAT THE METROID OF       "

    ;Writes row $2540 (11th row from top).
    VRAMStructData $2544, \
        "THE PLANET ZEBETH AND     "

    ;Writes row $2580 (13th row from top).
    VRAMStructData $2584, \
        "DESTROY THE MOTHER BRAIN  "

    ;Writes row $25C0 (15th row from top).
    VRAMStructData $25C4, \
        "THE MECHANICAL LIFE VEIN  "

    ;Writes row $2620 (18th row from top).
    VRAMStructData $2627, \
        "GALAXY FEDERAL POLICE"

    ;Writes row $2660 (20th row from top).
    VRAMStructData $2669, \
        "              M510"

    VRAMStructEnd

;The following data does not appear to be used.
    .byte $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $20, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;The following error message is diplayed if the player enters an incorrect password.
PasswordErrorMessage: ; 00:8759
    .stringmap charmap, "ERROR TRY AGAIN"

;If the error message above is not being displayed on the password
;screen, the following fifteen blanks spaces are used to cover it up.
PasswordNoErrorMessage: ; 00:8768
    .stringmap charmap, "               "

;Not used.
    .byte $79, $87, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $A1, $87, $A2, $87, $A5, $87, $A8, $87, $00, $18, $CC, $00, $18, $CD
    .byte $00, $18, $CE, $00

LoadSparkleData: ; 00:87AB
    ldx #$0A
    L87AD:
        lda InitSparkleDataTbl,x
        sta IntroSprs.0.y,x            ;Loads $6EA0 thru $6EAA with the table below.
        sta IntroSprs.1.y,x            ;Loads $6EB0 thru $6EBA with the table below.
        dex
        ;Loop until all values from table below are loaded.
        bpl L87AD
    ;$6EA0 thru $6EAA = #$3C, #$C6, #$01, #$18, #$00, #$00, #$00, #$00, #$20, #$00, #$00, initial.
    ;$6EB0 thru $6EBA = #$6B, #$C6, #$01, #$DC, #$00, #$00, #$00, #$00, #$20, #$00, #$00, initial.
    lda #$6B
    sta IntroSprs.1.y
    lda #$DC
    sta IntroSprs.1.x
    rts

;Used by above routine to load Metroid initial sparkle data into $6EA0
;thru $6EAA and $6EB0 thru $6EBA.

InitSparkleDataTbl: ; 00:87C4
    .byte $3C, $C6, $01, $18, $00, $00, $00, $00, $20, $00, $00

UpdateSparkleSprites: ; 00:87CF
    ;Performs calculations on top sparkle sprite.
    ldx #$00
    jsr DoTwoSparkleUpdates
    ;Performs calculations on bottom sparkle sprite.
    ldx #$10
    ; fallthrough
DoTwoSparkleUpdates: ; 00:87D6
    jsr SparkleUpdate               ;($87D9)Update sparkle sprite data.
    ; fallthrough
SparkleUpdate: ; 00:87D9
    ;If $6EA5 has not reached #$00, skip next routine.
    lda IntroSprs.0.nextDelay,x
    bne @endIf_A
        ;($881A)Update sparkle sprite screen position.
        jsr DoSparkleSpriteCoord
    @endIf_A:

    ;If sprite is already done, skip routine.
    lda IntroSprs.0.complete,x
    bne @RTS

    dec IntroSprs.0.nextDelay,x

    ;Updates sparkle sprite Y coord.
    lda IntroSprs.0.sparkleYChange,x
    clc
    adc IntroSprs.0.y,x
    sta IntroSprs.0.y,x

    ;Updates sparkle sprite X coord.
    lda IntroSprs.0.sparkleXChange,x
    clc
    adc IntroSprs.0.x,x
    sta IntroSprs.0.x,x

    ;Decrement IntroSprChangeDelay.
    dec IntroSprs.0.changeDelay,x
    ;If 0, time to change sprite graphic.
    bne @endIf_B
        ;The sparkle sprite graphic is-->
        ;changed back and forth between pattern table-->
        ;graphic $C6 and $C5. (BUG! Should be $C6 and $C7)
        lda IntroSprs.0.tileID,x
        eor #$C6~$C5
        sta IntroSprs.0.tileID,x
        ;IntroSprChangeDelay is reset to #$20.
        lda #$20
        sta IntroSprs.0.changeDelay,x
        ;Flips pattern at $C5 in pattern table-->
        ;horizontally when displayed.
        asl ; a = #OAMDATA_HFLIP
        eor IntroSprs.0.attrib,x
        sta IntroSprs.0.attrib,x
    @endIf_B:
    jmp WriteIntroSprite ;($887B)Transfer sprite info into sprite RAM.
@RTS:
    rts


DoSparkleSpriteCoord: ; 00:881A
    ;($C2C0)Y=0 when working with top sparkle sprite and y=2 when working with bottom sparkle sprite.
    txa
    jsr Adiv8
    tay
    ; loads either TopSparkleDataTbl or BottomSparkleDataTbl into $00 depending on-->
    ; which sparkle we're processing
    lda SparkleAddressTbl,y
    sta $00
    lda SparkleAddressTbl+1,y
    sta $01
    ;Loads index for finding sparkle data (x=$00 or $10).
    ldy IntroSprs.0.index,x
    lda ($00),y
    ;If data byte MSB is set, set $6EA9 to #$01 and move to next index for sparkle sprite data.
    bpl @endIf_A
        lda #$01
        sta IntroSprs.0.byteType,x
    @endIf_A:
    ;If value is equal to zero, sparkle sprite processing is complete.
    bne @endIf_B
        lda #$01
        sta IntroSprs.0.complete,x
    @endIf_B:
    sta IntroSprs.0.nextDelay,x
    iny
    ;Get x/y position byte.
    lda ($00),y
    ;decrement byteType
    dec IntroSprs.0.byteType,x
    ;If byteType was zero, branch.
    bmi @else_C
        ;This code is run when the MSB of the first byte is set.
        ;This allows the sprite to change X coord by more than 7.
        ;Ensures Y coord does not change.
        lda #$00
        sta IntroSprs.0.sparkleYChange,x
        ; second byte is used as sparkleXChange
        lda ($00),y
        bmi @endIf_C ; branch always
    @else_C:
        ;Parse sign-magnitude speeds
        ;Store value twice so X and Y coordinates can be extracted.
        pha
        pha
        ;Set IntroSpr0ByteType to #$00 after processing.
        lda #$00
        sta IntroSprs.0.byteType,x

        pla
        ;Get high nibble for y
        jsr Adiv16
        ;Check if nibble to be converted to twos complement.
        jsr @NibbleSubtract
        ;Store amount to move sprite in y direction.
        sta IntroSprs.0.sparkleYChange,x

        pla
        ;Get low nibble for x
        and #$0F
        ;Check if nibble to be converted to twos complement.
        jsr @NibbleSubtract
    @endIf_C:
    ;Store amount to move sprite in x direction.
    sta IntroSprs.0.sparkleXChange,x
    ;Add two to find index for next instruction.
    inc IntroSprs.0.index,x
    inc IntroSprs.0.index,x
    rts

@NibbleSubtract: ; 00:8871
    ; return nibble if sign bit of the nibble isn't set (if value is positive)
    cmp #$08
    bcc @RTS
    ; value is negative
    ; return negation of lower three bits of nibble
    and #$07
    jsr TwosComplement
@RTS:
    rts


;Load the four bytes for the intro sprites into sprite RAM.
WriteIntroSprite: ; 00:887B
    lda IntroSprs.0.y,x
    sec ;Subtract #$01 from first byte to get proper y coordinate.
    sbc #$01
    sta SpriteRAM.4.y,x

    lda IntroSprs.0.tileID,x
    sta SpriteRAM.4.tileID,x

    lda IntroSprs.0.attrib,x
    sta SpriteRAM.4.attrib,x

    lda IntroSprs.0.x,x
    sta SpriteRAM.4.x,x

    rts


InitCrossMissiles: ; 00:8897
    ;Set delay for second 4 sprites to 32 frames.
    lda #$20
    sta CrossMsl4to7SpawnDelay
    ;Prepare to loop 64 times.
    ldx #$3F

    @loop:
        ;Load data from tables below.
        lda InitCrossMissile0and4Tbl,x
        ;BUG: supposed to be #$FF. Expected behavior:-->
        ;if #$FF, skip loading that byte and continue to next byte.
        ;PPUCTRL_ZP's value is #$90 here.
        cmp PPUCTRL_ZP
        beq @endIf_A
            ;Store initial values for sprites 0 thru 3.
            sta IntroSprs.0.y,x
            ;Store initial values for sprites 4 thru 7.
            sta IntroSprs.4.y,x
        @endIf_A:
        ;Loop until all data is loaded.
        dex
        bpl @loop

    ;Special case for sprite 6 and 7.
    ;Change sprite 6 and 7 initial y position.
    lda #$B8
    sta IntroSprs.6.y
    sta IntroSprs.7.y
    ;Change sprite 6 and 7 y displacement.
    ;The combination of these two changes the slope of the sprite movement.
    lda #$16
    sta IntroSprs.6.speedY
    sta IntroSprs.7.speedY
    rts

;The following tables are loaded into RAM as initial sprite control values for the crosshair sprites.

InitCrossMissile0and4Tbl: ; 00:88BE
    .byte $20                       ;Initial starting y screen position.
    .byte $C5                       ;Sprite pattern table index.
    .byte $80                       ;Sprite control byte.
    .byte $00                       ;Initial starting x screen position.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $74                       ;Intro sprite x total movement distance.
    .byte $58                       ;Intro sprite y total movement distance.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $00                       ;Sprite task complete idicator.
    .byte $FF                       ;Not used.
    .byte $1D                       ;x displacement of sprite movement(run).
    .byte $0E                       ;y displacement of sprite movement(rise).
    .byte $01                       ;Change sprite x coord in positive direction.
    .byte $01                       ;Change sprite y coord in positive direction.

InitCrossMissile1and5Tbl: ; 00:88CE
    .byte $20                       ;Initial starting y screen position.
    .byte $C5                       ;Sprite pattern table index.
    .byte $C0                       ;Sprite control byte.
    .byte $F8                       ;Initial starting x screen position.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $7C                       ;Intro sprite x total movement distance.
    .byte $58                       ;Intro sprite y total movement distance.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $00                       ;Sprite task complete idicator.
    .byte $FF                       ;Not used.
    .byte $1F                       ;x displacement of sprite movement(run).
    .byte $0E                       ;y displacement of sprite movement(rise).
    .byte $80                       ;Change sprite x coord in negative direction.
    .byte $01                       ;Change sprite y coord in positive direction.

InitCrossMissile2and6Tbl: ; 00:88DE
    .byte $C8                       ;Initial starting y screen position.
    .byte $C5                       ;Sprite pattern table index.
    .byte $00                       ;Sprite control byte.
    .byte $00                       ;Initial starting x screen position.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $74                       ;Intro sprite x total movement distance.
    .byte $60                       ;Intro sprite y total movement distance.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $00                       ;Sprite task complete idicator.
    .byte $FF                       ;Not used.
    .byte $1D                       ;x displacement of sprite movement(run).
    .byte $1A                       ;y displacement of sprite movement(rise).
    .byte $01                       ;Change sprite x coord in positive direction.
    .byte $80                       ;Change sprite y coord in negative direction.

InitCrossMissile3and7Tbl: ; 00:88EE
    .byte $C8                       ;Initial starting y screen position.
    .byte $C5                       ;Sprite pattern table index.
    .byte $40                       ;Sprite control byte.
    .byte $F8                       ;Initial starting x screen position.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $7C                       ;Intro sprite x total movement distance.
    .byte $60                       ;Intro sprite y total movement distance.
    .byte $FF                       ;Not used.
    .byte $FF                       ;Not used.
    .byte $00                       ;Sprite task complete idicator.
    .byte $FF                       ;Not used.
    .byte $1F                       ;x displacement of sprite movement(run).
    .byte $1A                       ;y displacement of sprite movement(rise).
    .byte $80                       ;Change sprite x coord in negative direction.
    .byte $80                       ;Change sprite y coord in negative direction.

; this is for the two volleys of 4 missiles colliding in the title screen
UpdateCrossMissiles: ; 00:88FE
    ;Has CrossMsl0to3SlowDelay already hit 0? If so, branch.
    lda CrossMsl0to3SlowDelay
    beq L8936

    dec CrossMsl0to3SlowDelay
    ;Is CrossMsl0to3SlowDelay now equal to 0? if not, branch.
    bne L8936

    ;Multiply the rise and run of the 8 sprites by 2.-->
    ;This doubles their speed.
    asl IntroSprs.0.speedX
    asl IntroSprs.0.speedY
    asl IntroSprs.1.speedX
    asl IntroSprs.1.speedY
    asl IntroSprs.2.speedX
    asl IntroSprs.2.speedY
    asl IntroSprs.3.speedX
    asl IntroSprs.3.speedY
    asl IntroSprs.4.speedX
    asl IntroSprs.4.speedY
    asl IntroSprs.5.speedX
    asl IntroSprs.5.speedY
    asl IntroSprs.6.speedX
    asl IntroSprs.6.speedY
    asl IntroSprs.7.speedX
    asl IntroSprs.7.speedY

L8936: ; 00:8936
    ;Move sprite 0.
    ldx #$00
    jsr UpdateCrossMissile
    ;Move sprite 1.
    ldx #$10
    jsr UpdateCrossMissile
    ;Move sprite 2.
    ldx #$20
    jsr UpdateCrossMissile
    ;Move sprite 3.
    ldx #$30
    ;Check to see if the delay to start movement of the second-->
    ;4 sprites has ended.
    lda CrossMsl4to7SpawnDelay
    beq L894F
        ;If not, return after moving sprite 3.
        dec CrossMsl4to7SpawnDelay
        bne UpdateCrossMissile
    L894F:
    ;If so, start moving those sprites.
    jsr UpdateCrossMissile
    ;Move sprite 4.
    ldx #$40
    jsr UpdateCrossMissile
    ;Move sprite 5.
    ldx #$50
    jsr UpdateCrossMissile
    ;Move sprite 6.
    ldx #$60
    jsr UpdateCrossMissile
    ;Move sprite 7.
    ldx #$70
    ; fallthrough
UpdateCrossMissile: ; 00:8963
    ;If the current sprite has finished its movements, exit this routine.
    lda IntroSprs.0.complete,x
    bne @RTS

    ;Calculate new sprite position.
    jsr UpdateCrossMissileCoords
    ;If sprite not at final position, branch to move next frame.
    bcs @endIf_A
        ;Sprite movement complete.
        lda #$01
        sta IntroSprs.0.complete,x
    @endIf_A:
    ;($887B)Write sprite data to sprite RAM.
    jmp WriteIntroSprite

@RTS:
    rts

UpdateCrossExplode: ; 00:8976
    ;If not ready to draw crosshairs, branch to exit.
    lda IsUpdatingCrossExplode
    beq RTS_89A9

    ;Check to see if before last index in table.
    ldy CrossExplodeLengthIndex
    cpy #$04
    ;If so, branch to draw cross sprites.
    bcc L8986
        ;If beyond last index, branch to exit.
        bne RTS_89A9
        ;If at last index, clear indicator to draw cross sprites.
        lda #$00
        sta IsUpdatingCrossExplode
    L8986:
    lda CrossExplodeLengthTbl,y
    sta $00
    ldy #$00 ;Reset index into CrossExplodeDataTbl

    L898D:
        ;Get offset into sprite RAM to load sprite.
        ldx CrossExplodeDataTbl,y
        iny
        L8991:
            ;Store sprite data byte in sprite RAM.
            lda CrossExplodeDataTbl,y
            sta SpriteRAM,x
            inx ;Move to next sprite RAM address.
            iny ;Move to next data byte in table.
            ;Is new sprite position reached?-->
            txa
            and #$03
            ;if not, branch to load next sprite data byte.
            bne L8991
        ;Has all the sprites been loaded for cross graphic?-->
        cpy $00
        ;If not, branch to load next set of sprite data.
        bne L898D

    ;Increment index into CrossExplodeLengthTbl every other frame.
    ;This updates the cross sprites every two frames.
    lda FrameCount
    lsr
    bcc RTS_89A9
    inc CrossExplodeLengthIndex
RTS_89A9:
    rts

;The following table tells the routine above how many data bytes to load from CrossExplodeDataTbl.
;The more data that is loaded, the bigger the cross that is drawn on the screen.
;The table below starts the cross out small, it then grows bigger and gets small again.

CrossExplodeLengthTbl: ; 00:89AA
    .byte CrossExplodeDataTbl@end_0 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_1 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_2 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_1 - CrossExplodeDataTbl
    .byte CrossExplodeDataTbl@end_0 - CrossExplodeDataTbl

;The following table is used to find the data for the sparkle routine in the table below:

SparkleAddressTbl: ; 00:89AF
    .word TopSparkleDataTbl         ;($89B3)Table for top sparkle data.
    .word BottomSparkleDataTbl      ;($89E9)Table for bottom sparkle data.

;The following two tables are the data tables for controlling the movement of the sparkle sprites
;in the title routine.  Here's how the data in the tables work: The first byte is a counter byte.
;It is loaded into a memory address and decremented every frame. Whilt that value is not 0, the
;second byte is used to change the sprite's x and y coordinates in the screen.  The upper 4 bits
;of the second byte are amount to change the y coordinates every frame.  If bit 7 is set, the
;y coordinates of the sprite are reduced every frame by the amount stored in bits 4,5 and 6. The
;lower 4 bits of the second byte are used to change the x coordinates of the sprite in the same
;manner.  If bit 3 is set, the x coordinates of the sprite are reduced every frame by the amount
;stored in bits 0, 1 and 2.
;Special case: If MSB of the first byte is set(in the case of this data, the first byte is #$FF),
;The counter byte is set to only 1 frame and the second byte contains only x coordinates to move
;the sprite.  The y coordinates do not change.  This allows 8 bytes to move the x coordinate
;instead of only 4.  This allows the sprite to "jump" across the edges of the letters. If the MSB
;of the second byte is set, the x coordinate of the sprite is decreased by the amount stored in
;the other seven bytes.

TopSparkleDataTbl: ; 00:89B3
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  1,  0
    SignMagSpeed $06,  0,  0
    SignMagSpeed $07,  1,  0
    SignMagSpeed $10,  1,  0
    SignMagSpeed $03,  1,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  1,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  1,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $09,  1,  0
    SignMagSpeed $04,  0,  0
    SignMagSpeed $27,  1,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $06,  1,  0
    SignMagSpeed $01,  0,  0
    SignMagSpeed $15,  1,  0
    SignMagSpeed $06,  0,  0
    SignMagSpeed $01,  1,  0
    SignMagSpeed $08,  1,  0
    SignMagSpeed $0E,  2,  0
    SignMagSpeed $02,  3,  0
    SignMagSpeed $06,  4,  0
    SignMagSpeed $00,  0,  0

BottomSparkleDataTbl: ; 00:89E9
    SignMagSpeed $01,  0,  0
    SignMagSpeed $08, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  0
    SignMagSpeed $01, -1, -1
    SignMagSpeed $01, -1,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $02,  1,  1
    SignMagSpeed $01,  0,  1
    SignMagSpeed $01,  1,  1
    SignMagSpeed $10, -1,  0
    .byte $FF, -17 ;MSB of first byte set. move sprite x pos -17 pixels.
    SignMagSpeed $11, -1,  0
    .byte $FF, -13 ;MSB of first byte set. move sprite x pos -13 pixels.
    SignMagSpeed $1F, -1,  0
    .byte $FF, -20 ;MSB of first byte set. move sprite x pos -20 pixels.
    SignMagSpeed $0F, -1,  0
    .byte $FF, -19 ;MSB of first byte set. move sprite x pos -19 pixels.
    SignMagSpeed $16, -1,  0
    SignMagSpeed $00,  0,  0

;The following table is used by the UpdateCrossExplode routine to draw the sprites on the screen that
;make up the cross that appears during the Crosshairs routine.  The single byte is the index into
;the sprite RAM where the sprite data is to be written.  The 4 bytes that follow it are the actual
;sprite data bytes.

CrossExplodeDataTbl: ; 00:8A4B
    .byte $10                       ;Load following sprite data into Sprite04RAM.
    .byte $5A, $C0, $00, $79        ;Sprite data.
    @end_0:
    .byte $14                       ;Load following sprite data into Sprite05RAM.
    .byte $52, $C8, $00, $79        ;Sprite data.
    .byte $18                       ;Load following sprite data into Sprite06RAM.
    .byte $5A, $C2, $40, $71        ;Sprite data.
    .byte $1C                       ;Load following sprite data into Sprite07RAM.
    .byte $5A, $C2, $00, $81        ;Sprite data.
    .byte $20                       ;Load following sprite data into Sprite08RAM.
    .byte $62, $C8, $80, $79        ;Sprite data.
    @end_1:
    .byte $14                       ;Load following sprite data into Sprite05RAM.
    .byte $52, $C9, $00, $79        ;Sprite data.
    .byte $18                       ;Load following sprite data into Sprite06RAM.
    .byte $5A, $C1, $00, $71        ;Sprite data.
    .byte $1C                       ;Load following sprite data into Sprite07RAM.
    .byte $5A, $C1, $00, $81        ;Sprite data.
    .byte $20                       ;Load following sprite data into Sprite08RAM.
    .byte $62, $C9, $00, $79        ;Sprite data.
    .byte $24                       ;Load following sprite data into Sprite09RAM.
    .byte $4A, $C8, $00, $79        ;Sprite data.
    .byte $28                       ;Load following sprite data into Sprite0ARAM.
    .byte $5A, $C2, $40, $69        ;Sprite data.
    .byte $2C                       ;Load following sprite data into Sprite0BRAM.
    .byte $5A, $C2, $00, $89        ;Sprite data.
    .byte $30                       ;Load following sprite data into Sprite0CRAM.
    .byte $6A, $C8, $80, $79        ;Sprite data.
    @end_2:

LoadPalData: ; 00:8A8C
    ;Chooses which set of palette data to load from the table below.
    ldy PaletteDataIndex
    lda @PalSelectTbl,y
    cmp #$FF
    beq @RTS
    ;Prepare to write palette data.
    sta PaletteDataPending
    inc PaletteDataIndex
@RTS:
    rts

;The table below is used by above routine to pick the proper palette.
@PalSelectTbl: ; 00:8A9A
    .byte _id_Palette01+1
    .byte _id_Palette02+1
    .byte _id_Palette03+1
    .byte _id_Palette04+1
    .byte _id_Palette05+1
    .byte _id_Palette06+1
    .byte _id_Palette07+1
    .byte _id_Palette08+1
    .byte _id_Palette09+1
    .byte _id_Palette0A+1
    .byte _id_Palette0B+1
    .byte _id_Palette0B+1
    .byte $FF


FlashIntroScreen: ; 00:8AA7
    ldy ScreenFlashPaletteIndex         ;Load index into table below.
    lda @ScreenFlashPalTbl,y         ;Load palette data byte.
    cmp #$FF                        ;Has the end of the table been reached?-->
    bne @else_A                     ;If not, branch.
        ;Clear screen flash palette index and reset screen flash control address.
        lda #$00
        sta ScreenFlashPaletteIndex
        sta FlashScreen
        beq @RTS ;Branch always.
    @else_A:
        ;Store palette change data.
        sta PaletteDataPending
        ;Increment index into table below.
        inc ScreenFlashPaletteIndex
@RTS:
    rts

@ScreenFlashPalTbl: ; 00:8ABD
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .byte _id_Palette10+1
    .byte _id_Palette00+1
    .byte _id_Palette10+1
    .byte _id_Palette00+1
    .byte _id_Palette10+1
    .byte _id_Palette10+1
    .byte _id_Palette00+1
    .byte _id_Palette10+1
    .byte _id_Palette00+1
    .byte $FF
.elif BUILDTARGET == "NES_CNSUS"
    .byte _id_Palette10+1
    .byte _id_Palette10+1
    .byte _id_Palette10+1
    .byte _id_Palette00+1
    .byte _id_Palette00+1
    .byte _id_Palette00+1
    .byte _id_Palette00+1
    .byte _id_Palette00+1
    .byte _id_Palette00+1
    .byte $FF
.endif


;----------------------------------[ Intro star palette routines ]-----------------------------------

StarPaletteSwitch: ; 00:8AC7
    ;Change star palette every 16th frame.
    lda FrameCount
    and #$0F
    bne @RTS
    ;Is any other PPU data waiting? If so, exit.
    lda VRAMStructBufferIndex
    beq @checkSuccess
@RTS:
    rts

@checkSuccess:
    ;Prepare to write to the sprite palette starting at address $3F19.
    lda #$19
    sta $00
    lda #$3F
    sta $01
    ;Use only first 3 bits of byte since the pointer table only has 8 entries.
    lda IntroStarOffset
    and #$07
    ;*2 to find entry in IntroStarPalettePtrTable.
    asl
    tay
    ;Stores starting address of palette data to write into $02 and $03 from IntroStarPalettePtrTable.
    lda IntroStarPalettePtrTable,y
    sta $02
    lda IntroStarPalettePtrTable+1,y
    sta $03
    ;Increment index for next palette change.
    inc IntroStarOffset
    jsr PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.
    ;Prepare another write to the sprite palette. This time, starting at address $3F1D.
    lda #$1D
    sta $00
    lda #$3F
    sta $01
    iny
    jsr AddYToPtr02                 ;($C2B3)Find new data base of palette data.
    jmp PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.

;The following table is a list of pointers into the table below.
;It contains the palette data for the twinkling stars in the intro scene.
;The palette data is changed every 16 frames by the above routine.

IntroStarPalettePtrTable: ; 00:8AFF
    .word IntroStarPalette0
    .word IntroStarPalette1
    .word IntroStarPalette2
    .word IntroStarPalette3
    .word IntroStarPalette4
    .word IntroStarPalette5
    .word IntroStarPalette6
    .word IntroStarPalette7

;The following table contains the palette data that is changed in the intro
;scene to give the stars a twinkling effect. All entries in the table are
;non-repeating.

; 00:8B0F
IntroStarPalette0:  .byte $03, $0F, $02, $13, $00, $03, $00, $34, $0F, $00
IntroStarPalette1:  .byte $03, $06, $01, $23, $00, $03, $0F, $34, $09, $00
IntroStarPalette2:  .byte $03, $16, $0F, $23, $00, $03, $0F, $24, $1A, $00
IntroStarPalette3:  .byte $03, $17, $0F, $13, $00, $03, $00, $04, $28, $00
IntroStarPalette4:  .byte $03, $17, $01, $14, $00, $03, $10, $0F, $28, $00
IntroStarPalette5:  .byte $03, $16, $02, $0F, $00, $03, $30, $0F, $1A, $00
IntroStarPalette6:  .byte $03, $06, $12, $0F, $00, $03, $30, $04, $09, $00
IntroStarPalette7:  .byte $03, $0F, $12, $14, $00, $03, $10, $24, $0F, $00

;----------------------------------------------------------------------------------------------------

DoFadeOut: ; 00:8B5F
    ;Load palette data from table below.
    ldy FadeDataIndex
    lda FadeOutPaletteData,y
    ;If palette data = #$FF, exit.
    cmp #$FF
    beq @RTS
        ;Store new palette data.
        sta PaletteDataPending
        inc FadeDataIndex
    @RTS:
    rts

FadeOutPaletteData: ; 00:8B6D
    .byte _id_Palette0C+1
    .byte _id_Palette0D+1
    .byte _id_Palette0E+1
    .byte _id_Palette0F+1
    .byte _id_Palette00+1
    .byte $FF

FadeInPaletteData: ; 00:8B73
    .byte _id_Palette00+1
    .byte _id_Palette0F+1
    .byte _id_Palette0E+1
    .byte _id_Palette0D+1
    .byte _id_Palette0C+1
    .byte $FF

;----------------------------------------[ Password routines ]---------------------------------------

ProcessUniqueItems: ; 00:8B79
    ;Store NumberOfUniqueItems at $03.
    lda NumberOfUniqueItems
    sta Temp03_NumberOfUniqueItems
    ;Set $04 to #$00.
    ldy #$00
    sty Temp04_UniqueItemIndex
    @loop:
        ;Use $04 at index into unique item list.
        ldy Temp04_UniqueItemIndex
        ;Load the two bytes representing the aquired Unique item and store them in $00 and $01.
        iny
        lda UniqueItemHistory-1,y
        sta Temp00_ItemData
        iny
        lda UniqueItemHistory-1,y
        sta Temp00_ItemData+1
        ;Increment $04 by two (load unique item complete).
        sty Temp04_UniqueItemIndex
        ;Find unique item.
        jsr UniqueItemSearch
        ;If all unique items processed, return, else branch to process next unique item.
        ldy Temp04_UniqueItemIndex
        cpy Temp03_NumberOfUniqueItems
        bcc @loop
    rts

UniqueItemSearch: ; 00:8B9C
    ldx #$00
    L8B9E:
        ; y = x*2
        txa
        asl
        tay
        ;Load unique item reference starting at $9029(2 bytes).
        lda ItemData,y
        cmp Temp00_ItemData
        bne L8BAF
            ;Get next byte of unique item.
            lda ItemData+1,y
            cmp Temp00_ItemData+1
            ;If unique item found, branch to UniqueItemFound.
            beq UniqueItemFound
        L8BAF:
        ;If we've gone through all items, return, else branch to find next unique item.
        ;(BUG! This checks one item too many and goes oob of the ItemData table)
        inx
        cpx #(ItemData@end - ItemData) / 2 + 1.b
        bcc L8B9E
    rts

;The following routine sets the item bits for aquired items in addresses $6988 thru $698E.-->
;Items 0 thru 7 masked in $6988, 8 thru 15 in $6989, etc.
UniqueItemFound: ; 00:8BB5
    ;Shifts 5 MSBs to LSBs of item # and saves results in $05.
    txa
    jsr Adiv8
    sta Temp05_PasswordByteIndex
    ;Restores 5 MSBs of item # and drops 3 LSBs; saves in $02.
    jsr Amul8
    sta Temp02_ItemDataIndex5MSB
    ;Remove 5 MSBs and stores 3 LSBs in $06.
    txa
    sec
    sbc Temp02_ItemDataIndex5MSB
    sta Temp06_PasswordBitIndex
    ;Masks each unique item in the proper item address (addresses $6988 thru $698E).
    ldx Temp05_PasswordByteIndex
    lda PasswordByte,x
    ldy Temp06_PasswordBitIndex
    ora PasswordBitmaskTbl,y
    sta PasswordByte,x
    rts


LoadUniqueItems: ; 00:8BD4
    lda #$00
    sta NumberOfUniqueItems
    ;$05 offset of password byte currently processing(0 thru 7).
    sta Temp05_PasswordByteIndex
    ;$06 bit of password byte currently processing(0 thru 7).
    sta Temp06_PasswordBitIndex
    ;Maximum number of unique items(59 or #$3B).
    lda #(ItemData@end - ItemData) / 2.b
    sta Temp07_ItemDataIndexMax
    ;$08 stores contents of password byte currently processing.
    ldy Temp05_PasswordByteIndex
    lda PasswordByte,y
    sta Temp08_PasswordByte
    ;Stores number of unique items processed(#$0 thru #$3B).
    ldx #$00
    stx Temp09_ItemDataIndex
    ;If start of new byte, branch. (this is always the case)
    ldx Temp06_PasswordBitIndex
    beq @processItemBit

    ;This code does not appear to ever be executed.
    ldx #$01
    stx $02
    clc
    @loop_unused:
        ror
        sta $08
        ldx $02
        cpx $06
        beq @processItemBit
        inc $02
        jmp @loop_unused

@processItemByte: ; 00:8C03
    ;Locates next password byte to process and loads it into $08.
    ldy Temp05_PasswordByteIndex
    lda PasswordByte,y
    sta Temp08_PasswordByte

@processItemBit: ; 00:8C0A
        ;Rotates next bit to be processed to the carry flag.
        lda Temp08_PasswordByte
        ror
        sta Temp08_PasswordByte
        ;If Samus has this item, store item in unique item history.
        bcc @endIf_A
            jsr SamusHasItem
        @endIf_A:
        ;If last bit of item byte has been checked, move to next byte.
        ldy Temp06_PasswordBitIndex
        cpy #$07
        bcs @moveToNextByte
        ; move to next bit
        inc Temp06_PasswordBitIndex
        ;If all 59 unique items have been searched through, exit.
        inc Temp09_ItemDataIndex
        ldx Temp09_ItemDataIndex
        cpx Temp07_ItemDataIndexMax
        bcs @RTS
        ;Repeat routine for next item bit.
        jmp @processItemBit

@moveToNextByte:
    ; move to bit 0 of next byte
    ldy #$00
    sty Temp06_PasswordBitIndex
    inc Temp05_PasswordByteIndex
    ;If all 59 unique items have been searched through, exit.
    inc Temp09_ItemDataIndex
    ldx Temp09_ItemDataIndex
    cpx Temp07_ItemDataIndexMax
    bcs @RTS
    ;Process next item byte.
    jmp @processItemByte

@RTS:
    rts

SamusHasItem: ; 00:8C39
    ;Reconstitute ItemDataIndex from $05 and $06
    lda Temp05_PasswordByteIndex
    jsr Amul8
    clc
    adc Temp06_PasswordBitIndex
    ;* 2. Each item is two bytes in length.
    asl
    tay
    ;$00 and $01 store the two bytes of the unique item to process.
    lda ItemData+1,y
    sta Temp00_ItemData+1
    lda ItemData,y
    sta Temp00_ItemData
    ;Store the two bytes of the unique item in RAM in the unique item history.
    ldy NumberOfUniqueItems
    sta UniqueItemHistory,y
    lda $01
    iny
    sta UniqueItemHistory,y
    iny
    ;Keeps a running total of unique items.
    sty NumberOfUniqueItems
    rts

CheckPassword: ; 00:8C5E
    jsr ConsolidatePassword         ;($8F60)Convert password characters to password bytes.
    jsr ValidatePassword            ;($8DDE)Verify password is correct.
    ;Branch if incorrect password.
    bcs L8C69
        jmp InitializeGame              ;($92D4)Preliminary housekeeping before game starts.
    L8C69:
    ;Set IncorrectPassword SFX flag.
    lda MultiSFXFlag
    ora #sfxMulti_IncorrectPassword
    sta MultiSFXFlag
    ;Set Timer3 time for 120 frames (2 seconds).
    lda #$0C
    sta Timer3
    ;Run EnterPassword routine.
    lda #_id_EnterPassword.b
    sta TitleRoutine
    rts

CalculatePassword: ; 00:8C7A
    lda #$00
    ldy #$0F
    ;Clears the 16 first password bytes (and also the 16 first password characters, for some reason)
    @loop_A:
        sta PasswordByte,y
        sta PasswordChar,y
        dey
        bpl @loop_A

    jsr ProcessUniqueItems          ;($8B79)Determine what items Samus has collected.
    ;Branch if mother brain has not been defeated
    lda PasswordByte+(((ItemData@MotherBrain-ItemData)/2)/8)
    and #1<<(((ItemData@MotherBrain-ItemData)/2)&7).b
    beq @endIf_A
        ;Mother brain was defeated
        ;Restore mother brain, zebetites and all missile doors in Tourian as punishment for-->
        ;dying in the escape.
        ;Only reset in the password.  Continuing without resetting will not restore those items.
        lda #$00
        sta PasswordByte+$07
        lda PasswordByte+$06
        and #$03
        sta PasswordByte+$06
    @endIf_A:

    ;Store InArea in bits 0 thru 5 in address $6990.
    lda InArea
    and #$3F
    ;Sets MSB of $6990 is Samus is suitless.
    ldy JustInBailey
    beq @endIf_suitless
        ora #$80
    @endIf_suitless:
    sta PasswordByte+$08

    ;SamusGear stored in $6991.
    lda SamusGear
    sta PasswordByte+$09

    ;MissileCount stored in $6992.
    lda MissileCount
    sta PasswordByte+$0A

    lda #$00
    sta $00
    ;Set bit 7 of $00 if Kraid statue is up.
    lda KraidStatueStatus
    and #$80
    beq @endIf_statueBit7
        lda $00
        ora #$80
        sta $00
    @endIf_statueBit7:
    ;Set bit 6 of $00 if Kraid is defeated.
    lda KraidStatueStatus
    and #$01
    beq @endIf_statueBit6
        lda $00
        ora #$40
        sta $00
    @endIf_statueBit6:
    ;Set bit 5 of $00 if Ridley statue is up.
    lda RidleyStatueStatus
    and #$80
    beq @endIf_statueBit5
        lda $00
        ora #$20
        sta $00
    @endIf_statueBit5:
    ;Set bit 4 of $00 if Ridley is defeated.
    lda RidleyStatueStatus
    and #$02
    beq @endIf_statueBit4
        lda $00
        ora #$10
        sta $00
    @endIf_statueBit4:
    ;Stores statue statuses in 4 MSB at $6997.
    lda $00
    sta PasswordByte+$0F

    ;Store SamusAge in $6993, SamusAge+1 in $6994, SamusAge+2 in $6995 and SamusAge+3 in $6996.
    ldy #$03
    @loop_SamusAge:
        lda SamusAge,y
        sta PasswordByte+$0B,y
        dey
        bpl @loop_SamusAge

    ;Store the value of $2E at $6998 when any of the 4 LSB are set.
    ;(Does not allow RandomNumber1 to be a multiple of 16).
    @loop_random:
        jsr RandomNumbers
        lda RandomNumber1
        and #$0F
        beq @loop_random
    sta PasswordByte+$10

    jsr PasswordChecksumAndScramble ;($8E17)Calculate checksum and scramble password.
    jmp LoadPasswordChar            ;($8E6C)Calculate password characters.

LoadPasswordData: ; 00:8D12
    ;If invincible Samus active, skip further password processing.
    lda NARPASSWORD
    bne RTS_8D3C

    jsr LoadUniqueItems             ;($8BD4)Load unique items from password.
    jsr LoadTanksAndMissiles        ;($8D3D)Calculate number of missiles from password.

    ;If MSB in PasswordByte08 is set, Samus is not wearing her suit.
    ldy #$00
    lda PasswordByte+$08
    and #$80
    beq L8D27
        iny
    L8D27:
    sty JustInBailey

    ;Extract first 5 bits from PasswordByte08 and use it to determine starting area.
    lda PasswordByte+$08
    and #$3F
    sta InArea

    ;Load Samus' age.
    ldy #$03
    L8D33:
        ;Loop to load all 4 age bytes.
        lda PasswordByte+$0B,y
        sta SamusAge,y
        dey
        bpl L8D33
RTS_8D3C:
    rts

LoadTanksAndMissiles: ; 00:8D3D
    ;Loads Samus gear from password.
    lda PasswordByte+$09
    sta SamusGear
    ;Loads current number of missiles from password.
    lda PasswordByte+$0A
    sta MissileCount

    ;initialize temp vars for kraid and ridley statues's state
    lda #$00
    sta Temp00_KraidStatueStatus
    sta Temp02_RidleyStatueStatus
    ;If MSB is set, Kraid statue is up.
    lda PasswordByte+$0F
    and #$80
    beq @endIf_kraidRaised
        ;Kraid statue is up, set MSB in $00.
        lda Temp00_KraidStatueStatus
        ora #$80
        sta Temp00_KraidStatueStatus
    @endIf_kraidRaised:
    ;If bit 6 is set, Kraid is defeated.
    lda PasswordByte+$0F
    and #$40
    beq @endIf_kraidKilled
        ;Kraid is defeated, set LSB in $00.
        lda Temp00_KraidStatueStatus
        ora #$01
        sta Temp00_KraidStatueStatus
    @endIf_kraidKilled:
    ;Store Kraid status.
    lda Temp00_KraidStatueStatus
    sta KraidStatueStatus
    ;If bit 5 is set, Ridley statue is up.
    lda PasswordByte+$0F
    and #$20
    beq @endIf_ridleyRaised
        ;Ridley statue is up, set MSB in $02.
        lda Temp02_RidleyStatueStatus
        ora #$80
        sta Temp02_RidleyStatueStatus
    @endIf_ridleyRaised:
    ;If bit 4 is set, Ridley is defeated.
    lda PasswordByte+$0F
    and #$10
    beq @endIf_ridleyKilled
        ;Ridley is defeated, set bit 1 of $02.
        lda Temp02_RidleyStatueStatus
        ora #$02
        sta Temp02_RidleyStatueStatus
    @endIf_ridleyKilled:
    ;Store Ridley status.
    lda Temp02_RidleyStatueStatus
    sta RidleyStatueStatus

    ;initialize temp vars for energy tank count and missile tank count
    lda #$00
    sta Temp00_EnergyTankCount
    sta Temp02_MissileTankCount
    ldy #$00
    @loop_tanks:
        ;Load second byte of item
        lda UniqueItemHistory+1,y
        ;Compare the 6 MSBs to #$20. If it matches, an energy tank has been found.
        and #$FC
        cmp #>ui_ENERGYTANK
        bne @endIf_etank
            ;Increment number of energy tanks found.
            inc Temp00_EnergyTankCount
            jmp @IncrementToNextItem
        @endIf_etank:
        ;Compare the 6 MSBs to #$24. If it matches, missiles have been found.
        cmp #>ui_MISSILES
        bne @IncrementToNextItem
            ;Increment number of missiles found.
            inc Temp02_MissileTankCount
    @IncrementToNextItem: ; 00:8DA9
        ;Increment twice. Each item is 2 bytes.
        ;7 extra item slots in unique item history.
        ;Loop until all unique item history checked.
        iny
        iny
        cpy #$84
        bcc @loop_tanks
    ;Ensure the Tank Count does not exceed 6 tanks.
    lda Temp00_EnergyTankCount
    cmp #$06
    bcc @endIf_A
        lda #$06
    @endIf_A:
    ;Then stores the number of energy tanks found in EnergyTankCount.
    sta EnergyTankCount
    ;init missile max count to 0
    lda #$00
    ;Branch if no missile tanks found.
    ldy Temp02_MissileTankCount
    beq @endIf_B
        clc
        ;For every missile tank found, this loop adds 5 missiles to MaxMissiles.
        @loop_mul5:
            adc #$05
            dey
            bne @loop_mul5
    @endIf_B:
    ;75 missiles are added to MaxMissiles if Kraid has been defeated
    ldy KraidStatueStatus
    beq @endIf_C
        adc #$4B
        bcs @capMaxMissiles
    @endIf_C:
    ;another 75 missiles are added if the ridley has been defeated.
    ldy RidleyStatueStatus
    beq @endIf_D
        adc #$4B
        bcc @endIf_D
    @capMaxMissiles:
        ;If number of missiles exceeds 255, it stays at 255.
        lda #$FF
@endIf_D:
    sta MaxMissiles
    rts

ValidatePassword: ; 00:8DDE
    ;If invincible Samus already active, branch.
    lda NARPASSWORD
    bne @passwordIsNotNARPASSWORD

    ;Check if NARPASSWORD was entered at the password screen
    ldy #$0F
    @loop_NARPASSWORD:
        lda PasswordChar,y
        cmp NARPASSWORDTbl,y
        bne @passwordIsNotNARPASSWORD
        dey
        bpl @loop_NARPASSWORD

    ;NARPASSWORD was entered, activate invincible Samus
    lda #$01
    sta NARPASSWORD
    bne @validPassword ; branch always

@passwordIsNotNARPASSWORD:
    ;NARPASSWORD was not entered, continue to process password
    jsr UnscramblePassword          ;($8E4E)Unscramble password.
    jsr PasswordChecksum            ;($8E21)Calculate password checksum.
    cmp PasswordByte+$11            ;Verify proper checksum.
    beq @validPassword
    ;If password is invalid, sets carry flag.
    sec
    bcs @RTS ; branch always
@validPassword:
    ;If password is valid, clears carry flag.
    clc
@RTS:
    rts

;The table below is used by the code above. It checks to see if NARPASSWORD has been entered.
;NOTE: any characters after the 16th character will be ignored if the first 16 characters
;match the values below.

NARPASSWORDTbl: ; 00:8E07
    .stringmap charmap, "NARPASSWORD00000"

PasswordChecksumAndScramble: ; 00:8E17
    ;Store the combined added value of addresses $6988 thu $6998 in $6999.
    jsr PasswordChecksum
    sta PasswordByte+$11
    ;Scramble password.
    jsr PasswordScramble
    rts

;Add the values at addresses $6988 thru $6998 together.
PasswordChecksum: ; 00:8E21
    ldy #$10
    lda #$00
    @loop:
        clc
        adc PasswordByte,y
        dey
        bpl @loop
    rts

PasswordScramble: ; 00:8E2D
    lda PasswordByte+$10
    sta Temp02_ScrambleCount
    @loop_A:
        ;Store contents of $6988 in $00 for further processing after rotation.
        lda PasswordByte
        sta Temp00_PasswordByte
        ldx #$00
        ldy #$0F
        @loop_B:
            ;Rotate right, including carry, all values in addresses $6988 thru $6997.
            ror PasswordByte,x
            inx
            dey
            bpl @loop_B
        ;Rotate right $6988 to ensure the LSB from address $6997 is rotated to the MSB of $6988.
        ror Temp00_PasswordByte
        lda Temp00_PasswordByte
        sta PasswordByte
        ;Continue rotating until $02 = 0.
        dec Temp02_ScrambleCount
        bne @loop_A
    rts

UnscramblePassword: ; 00:8E4E
    ;Stores random number used to scramble the password.
    lda PasswordByte+$10
    sta Temp02_ScrambleCount
    @loop_A:
        ;Preserve MSB that may have been rolled from $6988.
        lda PasswordByte+$0F
        sta Temp00_PasswordByte
        ldx #$0F
        @loop_B:
            ;The following loop rolls left the first 16 bytes of the password one time.
            rol PasswordByte,x
            dex
            bpl @loop_B
        ;Rolls byte in $6997 to ensure MSB from $6988 is not lost.
        rol Temp00_PasswordByte
        lda Temp00_PasswordByte
        sta PasswordByte+$0F
        ;Loop repeats the number of times decided by the random-->
        ;number in $6998 to properly unscramble the password.
        dec Temp02_ScrambleCount
        bne @loop_A
    rts

;The following code takes the 18 password bytes and converts them into 24 characters
;to be displayed to the player as the password.  NOTE: the two MSBs will always be 0.

LoadPasswordChar: ; 00:8E6C
    .repeat 6 index I
        ;%XXXXXX-- %-------- %--------
        ldy #I*3+0
        jsr SixUpperBits
        sta PasswordChar+I*4+0
        ;%------XX %XXXX---- %--------
        ldy #I*3+0
        jsr TwoLowerAndFourUpper
        sta PasswordChar+I*4+1
        ;%-------- %----XXXX %XX------
        ldy #I*3+1
        jsr FourLowerAndTwoUpper
        sta PasswordChar+I*4+2
        ;%-------- %-------- %--XXXXXX
        ldy #I*3+2
        jsr SixLowerBits
        sta PasswordChar+I*4+3
    .endr
    rts

SixUpperBits: ; 00:8F2D
    ;Uses six upper bits to create a new byte.
    ;Bits are right shifted twice and two lower bits are discarded.
    lda PasswordByte,y
    lsr
    lsr
    rts

TwoLowerAndFourUpper: ; 00:8F33
    ;Saves two lower bits and stores them in bits 4 and 5.
    lda PasswordByte,y
    and #$03                        
    jsr Amul16
    sta $00
    ;Saves upper 4 bits and stores them bits 0, 1, 2 and 3.
    lda PasswordByte+1,y            
    jsr Adiv16
    ;Add two sets of bits together to make a byte where bits 6 and 7 = 0.
    ora $00
    rts

FourLowerAndTwoUpper: ; 00:8F46
    ;Keep lower 4 bits.
    ;Move lower 4 bits to bits 5, 4, 3 and 2.
    lda PasswordByte,y
    and #$0F
    asl
    asl
    sta $00
    ;Move upper two bits to bits 1 and 0.
    lda PasswordByte+1,y            
    rol
    rol
    rol
    and #$03
    ;Add two sets of bits together to make a byte where bits 6 and 7 = 0.
    ora $00
    rts

SixLowerBits: ; 00:8F5A
    ;Discard bits 6 and 7.
    lda PasswordByte,y
    and #$3F
    rts

;The following routine converts the 24 user entered password characters into the 18 password
;bytes used by the program to store Samus' stats and unique item history.

ConsolidatePassword: ; 00:8F60
    .repeat 6 index I
        ;%00XXXXXX %00XX---- %00------ %00------
        ldy #I*4+0
        jsr SixLowerAndTwoUpper
        sta PasswordByte+I*3+0
        ;%00------ %00--XXXX %00XXXX-- %00------
        ldy #I*4+1
        jsr FourLowerAndFiveThruTwo
        sta PasswordByte+I*3+1
        ;%00------ %00------ %00----XX %00XXXXXX
        ldy #I*4+2
        jsr TwoLowerAndSixLower
        sta PasswordByte+I*3+2
    .endr
    rts

SixLowerAndTwoUpper: ; 00:8FF1
    ;Remove upper two bits and transfer lower six bits to upper six bits.
    lda PasswordChar,y
    asl
    asl
    sta $00
    ;Move bits 4 and 5 to lower two bits and discard the rest.
    lda PasswordChar+1,y
    jsr Adiv16
    ;Combine the two bytes together.
    ora $00
    rts

FourLowerAndFiveThruTwo: ; 00:9001
    ;Take four lower bits and transfer them to upper four bits. Discard the rest.
    lda PasswordChar,y
    jsr Amul16
    sta $00
    ;Remove two lower bits and transfer bits 5 thru 2 to lower four bits.
    lda PasswordChar+1,y
    lsr
    lsr
    ;Combine the two bytes together.
    ora $00
    rts

TwoLowerAndSixLower: ; 00:9011
    ;Shifts two lower bits to two higest bits and discards the rest
    lda PasswordChar,y
    ror
    ror
    ror
    and #$C0
    sta $00
    ;Add six lower bits to previous results.
    lda PasswordChar+1,y
    ora $00
    rts

PasswordBitmaskTbl: ; 00:9021
    .byte $01, $02, $04, $08, $10, $20, $40, $80

;The following table contains the unique items in the game.  The two bytes can be deciphered
;as follows:IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
;on world map. See constants.asm for values of IIIIII.

ItemData: ; 00:9029
@MaruMari:
    .word ui_MARUMARI    + ($02 << 5) + $0E  ;Maru Mari at coord 02,0E                    (Item 0)

    .word ui_MISSILES    + ($12 << 5) + $0B  ;Missiles at coord 12,0B                     (Item 1)
    .word ui_MISSILEDOOR + ($07 << 5) + $05  ;Red door to long beam at coord 07,05        (Item 2)
    .word ui_MISSILEDOOR + ($04 << 5) + $02  ;Red door to Tourian elevator at coord 05,02 (Item 3)
    .word ui_ENERGYTANK  + ($19 << 5) + $07  ;Energy tank at coord 19,07                  (Item 4)
    .word ui_MISSILEDOOR + ($19 << 5) + $05  ;Red door to bombs at coord 1A,05            (Item 5)

@Bombs:
    .word ui_BOMBS       + ($19 << 5) + $05  ;Bombs at coord 19,05                        (Item 6)

    .word ui_MISSILEDOOR + ($13 << 5) + $09  ;Red door to ice beam at coord 13,09         (Item 7)
    .word ui_MISSILES    + ($18 << 5) + $03  ;Missiles at coord 18,03                     (Item 8)
    .word ui_ENERGYTANK  + ($1B << 5) + $03  ;Energy tank at coord 1B,03                  (Item 9)
    .word ui_MISSILEDOOR + ($0F << 5) + $02  ;Red door to varia suit at coord 0F,02       (Item 10)

@Varia:
    .word ui_VARIA       + ($0F << 5) + $02  ;Varia suit at coord 0F,02                   (Item 11)

    .word ui_ENERGYTANK  + ($09 << 5) + $0E  ;Energy tank at coord 09,0E                  (Item 12)
    .word ui_MISSILES    + ($12 << 5) + $0E  ;Missiles at coord 12,0E                     (Item 13)
    .word ui_MISSILES    + ($11 << 5) + $0F  ;Missiles at coord 11,0F                     (Item 14)
    .word ui_MISSILEDOOR + ($1A << 5) + $0C  ;Red door to ice beam at coord 1B,0C         (Item 15)
    .word ui_MISSILES    + ($1B << 5) + $0A  ;Missiles at coord 1B,0A                     (Item 16)
    .word ui_MISSILES    + ($1C << 5) + $0A  ;Missiles at coord 1C,0A                     (Item 17)
    .word ui_MISSILES    + ($1C << 5) + $0B  ;Missiles at coord 1C,0B                     (Item 18)
    .word ui_MISSILES    + ($1B << 5) + $0B  ;Missiles at coord 1B,0B                     (Item 19)
    .word ui_MISSILES    + ($1A << 5) + $0B  ;Missiles at coord 1A,0B                     (Item 20)
    .word ui_MISSILES    + ($14 << 5) + $0F  ;Missiles at coord 14,0F                     (Item 21)
    .word ui_MISSILES    + ($13 << 5) + $0F  ;Missiles at coord 13,0F                     (Item 22)
    .word ui_MISSILEDOOR + ($1B << 5) + $11  ;Red door to high jump at coord 1C,11        (Item 23)

@HighJump:
    .word ui_HIGHJUMP    + ($1B << 5) + $11  ;High jump at coord 1B,11                    (Item 24)

    .word ui_MISSILEDOOR + ($0F << 5) + $10  ;Red door to screw attack at coord 0E,10     (Item 25)

@ScrewAttack:
    .word ui_SCREWATTACK + ($0F << 5) + $10  ;Screw attack at coord 0D,1D                 (Item 26)

    .word ui_MISSILES    + ($13 << 5) + $16  ;Missiles at coord 13,16                     (Item 27)
    .word ui_MISSILES    + ($14 << 5) + $16  ;Misslies at coord 14,16                     (Item 28)
    .word ui_MISSILEDOOR + ($12 << 5) + $15  ;Red door to wave beam at coord 1C,15        (Item 29)
    .word ui_ENERGYTANK  + ($1A << 5) + $13  ;Energy tank at coord 1A,13                  (Item 30)
    .word ui_MISSILES    + ($1C << 5) + $14  ;Missiles at coord 1C,14                     (Item 31)
    .word ui_MISSILEDOOR + ($07 << 5) + $15  ;Red door at coord 07,15                     (Item 32)
    .word ui_MISSILES    + ($09 << 5) + $15  ;Missiles at coord 09,15                     (Item 33)
    .word ui_MISSILES    + ($04 << 5) + $15  ;Missiles at coord 04,15                     (Item 34)
    .word ui_MISSILEDOOR + ($07 << 5) + $16  ;Red door at coord 07,16                     (Item 35)
    .word ui_ENERGYTANK  + ($0A << 5) + $16  ;Energy tank at coord 0A,16                  (Item 36)
    .word ui_MISSILEDOOR + ($07 << 5) + $18  ;Red door at coord 07,18                     (Item 37)
    .word ui_MISSILEDOOR + ($03 << 5) + $1B  ;Red door at coord 03,1B                     (Item 38)
    .word ui_MISSILES    + ($05 << 5) + $1B  ;Missiles at coord 05,1B                     (Item 39)
    .word ui_MISSILES    + ($0A << 5) + $19  ;Missiles at coord 0A,19                     (Item 40)
    .word ui_MISSILEDOOR + ($08 << 5) + $1D  ;Red door to Kraid at coord 08,1D            (Item 41)
    .word ui_ENERGYTANK  + ($08 << 5) + $1D  ;Energy tank at coord 08,1D(Kraid's room)    (Item 42)
    .word ui_MISSILES    + ($12 << 5) + $18  ;Missiles at coord 12,18                     (Item 43)
    .word ui_MISSILEDOOR + ($11 << 5) + $19  ;Red door at coord 11,19                     (Item 44)
    .word ui_ENERGYTANK  + ($11 << 5) + $19  ;Energy tank at coord 11,19                  (Item 45)
    .word ui_MISSILES    + ($14 << 5) + $1E  ;Missiles at coord 14,1E                     (Item 46)
    .word ui_MISSILEDOOR + ($10 << 5) + $1D  ;Purple door at coord 10,1D(Ridley's room)   (Item 47)
    .word ui_ENERGYTANK  + ($0F << 5) + $1D  ;Energy tank at coord 0F,1D                  (Item 48)
    .word ui_MISSILES    + ($18 << 5) + $1B  ;Missile at coord 18,1B                      (Item 49)
    .word ui_MISSILEDOOR + ($03 << 5) + $07  ;Orange door at coord 03,07                  (Item 50)
    .word ui_MISSILEDOOR + ($09 << 5) + $07  ;Red door at coord 09,07                     (Item 51)
    .word ui_MISSILEDOOR + ($09 << 5) + $0B  ;Red door at coord 0A,0B                     (Item 52)
    .word ui_ZEBETITE1                       ;1st Zebetite in mother brain room           (Item 53)
    .word ui_ZEBETITE2                       ;2nd Zebetite in mother brain room           (Item 54)
    .word ui_ZEBETITE3                       ;3rd Zebetite in mother brain room           (Item 55)
    .word ui_ZEBETITE4                       ;4th Zebetite in mother brain room           (Item 56)
    .word ui_ZEBETITE5                       ;5th Zebetite in mother brain room           (Item 57)

@MotherBrain:
    .word ui_MOTHERBRAIN                     ;Mother brain                                (Item 58)

@end:

ClearAll: ; 00:909F
    ;Turn off screen, clear sprites and name tables.
    jsr ScreenOff
    jsr ClearNameTables
    jsr EraseAllSprites             ;
    lda PPUCTRL_ZP                  ;Set Name table address to $2000.
    and #$FC                        ;
    sta PPUCTRL_ZP                  ;
    lda #$00                        ;
    sta ScrollY                     ;Reset scroll offsets.
    sta ScrollX                     ;
    jsr WaitNMIPass                 ;($C42C)Wait for NMI to end.
    jmp VBOffAndHorzWrite           ;($C47D)Set PPU for horizontal write and turn off VBlank.

StartContinueScreen15: ; 00:90BA
StartContinueScreen1B:
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #<L9984.b                     ;Low address for PPU write.
    ldy #>L9984.b                     ;High address for PPU write.
    jsr PreparePPUProcess_          ;($9449)Clears screen and writes "START CONTINUE".
    ldy #$00                        ;
    sty StartContinue               ;Set selection sprite at START.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        lda #_id_Palette0C+1.b
    .elif BUILDTARGET == "NES_CNSUS"
        NES_CNSUS_IllegalOpcode42
        .byte _id_Palette0C+1
    .endif
    sta PaletteDataPending              ;Change palette and title routine.
    lda #_id_ChooseStartContinue.b  ;Next routine is ChooseStartContinue.
    sta TitleRoutine                ;

TurnOnDisplay: ; 00:90D1
    jsr NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    jmp ScreenOn                    ;($C447)Turn screen on.

ChooseStartContinue: ; 00:90D7
    ;Checks both select and start buttons.
    lda Joy1Change
    and #BUTTON_START | BUTTON_SELECT
    ;Branch if START not pressed.
    cmp #BUTTON_START
    bne @endIf_A
        ;if CONTINUE selected, branch.
        ldy StartContinue
        bne @endIf_B
            ;Zero out all stats.
            jmp InitializeStats
        @endIf_B:
        ;Next routine is LoadPasswordScreen.
        ldy #_id_LoadPasswordScreen.b
        sty TitleRoutine
    @endIf_A:
    ;Branch if SELECT not pressed.
    cmp #BUTTON_SELECT
    bne @endIf_C
        ;Toggles between START and CONTINUE on game select screen.
        lda StartContinue
        eor #$01
        sta StartContinue
        ;Set SFX flag for select being pressed. Uses triangle channel.
        lda TriSFXFlag
        ora #sfxTri_Beep
        sta TriSFXFlag
    @endIf_C:
    ldy StartContinue
    ;Load sprite info for square selection sprite.
    lda StartContTbl,y
    sta SpriteRAM.0.y
    lda #$6E
    sta SpriteRAM.0.tileID
    lda #$03
    sta SpriteRAM.0.attrib
    lda #$50
    sta SpriteRAM.0.x
    rts

StartContTbl: ; 00:9118
    .byte $60                       ;Y sprite position for START.
    .byte $78                       ;Y sprite position for CONTINUE.

LoadPasswordScreen: ; 00:911A
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #<L99E3.b                     ;Loads PPU with info to display-->
    ldy #>L99E3.b                     ;PASS WORD PLEASE.
    jsr PreparePPUProcess_          ;($9449)Load "PASSWORD PLEASE" on screen.
    jsr InitPasswordFontGFX                    ;($C6D6)Loads the font for the password.
    jsr DisplayInputCharacters      ;($940B)Write password character to screen.
    lda #_id_Palette12+1.b
    sta PaletteDataPending              ;Change palette.
    lda #$00                        ;
    sta InputRow                    ;Sets character select cursor to-->
    sta InputColumn                 ;upper left character (0).
    sta Timer3                      ;
    lda #$00                        ;
    sta PasswordCursor              ;Sets password cursor to password character 0.
    ldy #$00                        ;
    sty PasswordStat00              ;Appears to have no function.
    inc TitleRoutine                ;
    jmp TurnOnDisplay               ;($90D1)Turn on screen and NMI.

EnterPassword: ; 00:9147
    ;($C1A3)Remove sprites from screen.
    jsr EraseAllSprites

    ;Check to see if START has been pressed.
    lda Joy1Change
    and #BUTTON_START
    ;If not, branch.
    beq @endIf_A
        ;Check if password is correct.
        jmp CheckPassword
    @endIf_A:

    ;Prepare to write the password screen data to PPU.
    ldx #$01
    stx PPUDataPending
    ldx VRAMStructBufferIndex

    ;Upper byte of PPU address.
    lda #>$21A8
    jsr WritePPUByte
    ;Lower byte of PPU address.
    lda #<$21A8
    jsr WritePPUByte
    ;VRAM structure data length.
    lda #$0F
    jsr WritePPUByte

    lda Timer3
    beq @else_B
        ;Writes 'ERROR TRY AGAIN' on the screen if Timer3 is anything but #$00.
        lda #<PasswordErrorMessage.b
        sta $02
        lda #>PasswordErrorMessage.b
        sta $03
        jmp @endIf_B
    @else_B:
        ;Writes the blank lines that cover the message 'ERROR TRY AGAIN'.
        lda #<PasswordNoErrorMessage.b
        sta $02
        lda #>PasswordNoErrorMessage.b
        sta $03
    @endIf_B:
    ; loop to write all the bytes from those strings to vram structure buffer
    ldy #$00
    @loop:
        lda ($02),y
        jsr WritePPUByte
        iny
        cpy #$0F
        bne @loop

    ;If button A pressed, branch.
    lda Joy1Change
    bmi @endIf_C
        ;Check if backspace pressed.
        jmp CheckBackspace
    @endIf_C:

    ;Initiate BombLaunch SFX if a character has been written to the screen.
    lda TriSFXFlag
    ora #sfxTri_BombLaunch
    sta TriSFXFlag

    ;Check to see if password cursor is on character 19 thru 24.  If not, branch.
    lda PasswordCursor
    cmp #$12
    bcc L91A8
    ;Will equal #$50 thru #$55.
    clc
    adc #$3E
    jmp LoadRowAndColumn

L91A8:
    ;Check to see if password cursor is on character 13 thru 18.  If not, branch.
    cmp #$0C
    bcc L91B2
    ;Will equal #$49 thru #$4E.
    clc
    adc #$3D
    jmp LoadRowAndColumn

L91B2:
    ;Check to see if password cursor is on character 7 thru 12.  If not, branch.
    cmp #$06
    bcc L91BC
    ;Will equal #$10 thru #$15.
    clc
    adc #$0A
    jmp LoadRowAndColumn

L91BC:
    ;Will equal #$09 thru #$0E.
    clc
    adc #$09

LoadRowAndColumn: ; 00:91BF
    sta $06
    lda InputRow
    asl ;*2. address pointer is two bytes.
    tay
    ;Store lower byte of row pointer.
    lda PasswordRowTbl,y
    sta $00
    ;Store upper byte of row pointer.
    lda PasswordRowTbl+1,y
    sta $01
    ;Uses InputColumn value to find proper index of current character selected.
    ldy InputColumn
    lda ($00),y
    ;Temp storage of A.
    pha
    ;Store value of current character selected.
    sta TileInfo0
    ;Replace password character tile with the one selected by the player.
    lda #$11
    sta TileSize
    ldx $06
    ldy #$21
    jsr PrepareEraseTiles           ;($9450)
    ldx PasswordCursor
    ;Store the currently selected password character in the proper PasswordChar RAM location.
    pla
    sta PasswordChar,x

    ;Increment PasswordCursor.
    lda PasswordCursor
    clc
    adc #$01
    ;If at last character, loop back to the first character.
    cmp #$18
    bcc L91F8
        lda #$00
    L91F8:
    sta PasswordCursor

CheckBackspace: ; 00:91FB
    ;If button B (backspace) has not been pressed, branch.
    lda Joy1Change
    and #BUTTON_B
    beq L920E
        ;Subtract 1 from PasswordCursor.
        lda PasswordCursor
        sec
        sbc #$01
        ;If PasswordCursor is negative, load PasswordCursor with #$17 (last character).
        bcs L920B
            lda #$17
        L920B:
        sta PasswordCursor
    L920E:
    ldy PasswordStat00 ;Appears to have no function.
    ;If FrameCount bit 3 not set, branch.
    ;This flashes the cursor on and off.
    lda FrameCount
    and #$08
    beq L923F
        ;Set cursor y position to #$3F if PasswordCursor is on character 0 thru 11,
        ;else set it to #$4F.
        lda #$3F
        ldx PasswordCursor
        cpx #$0C
        bcc L9222
            lda #$4F
        L9222:
        sta SpriteRAM.1.y
        ;Set pattern for password cursor sprite.
        lda #$6E
        sta SpriteRAM.1.tileID
        ;Set attributes for password cursor sprite.
        lda #OAMDATA_PRIORITY
        sta SpriteRAM.1.attrib
        ; load cursor position
        lda PasswordCursor
        cmp #$0C
        ;If the password cursor is at the 12th character or less, branch.
        bcc L9238
            ;Cursor is on the second row of password.
            ;Calculate how many characters the password cursor is from the left.
            sbc #$0C
        L9238:
        tax
        ;Set X position of PasswordCursor based on this.
        lda CursorPosXTbl,x
        sta SpriteRAM.1.x
    L923F:
    ldx InputRow                    ;Load X and Y with row and column-->
    ldy InputColumn                 ;of current character selected.
    lda Joy1Retrig                  ;
    and #$0F                        ;If no directional buttons are in-->
    beq L9297                       ;retrigger mode, branch.
    pha                             ;Temp storage of A.
    lda TriSFXFlag                  ;Initiate BeepSFX when the player pushes-->
    ora #sfxTri_Beep                ;a button on the directional pad.
    sta TriSFXFlag                  ;
    pla                             ;Restore A.
    lsr                             ;Put status of right directional button in carry bit.
    bcc L926C                       ;Branch if right button has not been pressed.
        iny                             ;
        cpy #$0D                        ;Increment Y(column).  If Y is greater than #$0C,-->
        bne L9269                       ;increment X(Row).  If X is greater than #$04,-->
            inx                             ;set X to #$00(start back at top row) and store-->
            cpx #$05                        ;new row in InputRow.
            bne L9264                       ;
                ldx #$00                        ;
            L9264:
            stx InputRow                    ;
            ldy #$00                        ;Store new column in InputColumn.
        L9269:
        sty InputColumn                 ;
    L926C:
    lsr                             ;Put status of left directional button in carry bit.
    bcc L927F                       ;Branch if left button has not been pressed.
        dey                             ;
        bpl L927C                       ;Decrement Y(column).  If Y is less than #$00,-->
            dex                             ;Decrement X(row).  If X is less than #$00,-->
            bpl L9277                       ;set X to #$04(last row) and store new row-->
                ldx #$04                        ;in InputRow.
            L9277:
            stx InputRow                    ;
            ldy #$0C                        ;Store new column in InputColumn.
        L927C:
        sty InputColumn                 ;
    L927F:
    lsr                             ;Put status of down directional button in carry bit.
    bcc L928C                       ;Branch if down button has not been pressed.
        inx                             ;
        cpx #$05                        ;Increment X(row).  if X is greater than #$04,-->
        bne L9289                       ;set X to #$00(first row) and store new-->
            ldx #$00                        ;row in InputRow.
        L9289:
        stx InputRow                    ;
    L928C:
    lsr                             ;Put status of up directional button in carry bit.
    bcc L9297                       ;Branch if up button has not been pressed.
        dex                             ;
        bpl L9294                       ;Decrement X(row).  if X is less than #$00,-->
            ldx #$04                        ;set X to #$04(last row) and store new-->
        L9294:
        stx InputRow                    ;row in InputRow.
    L9297:
    ;If FrameCount bit 3 not set, branch.
    lda FrameCount
    and #$08
    beq RTS_92B3
        ;Set Y-coord of character selection sprite.
        lda CharSelectYTbl,x
        sta SpriteRAM.2.y
        ;Set pattern for character selection sprite.
        lda #$6E
        sta SpriteRAM.2.tileID
        ;Set attributes for character selection sprite.
        lda #$20
        sta SpriteRAM.2.attrib
        ;Set x-Coord of character selection sprite.
        lda CharSelectXTbl,y
        sta SpriteRAM.2.x
    RTS_92B3:
    rts

;The following data does not appear to be used in the program.
    .byte $21, $20

;The following table is used to determine the proper Y position of the character
;selection sprite on password entry screen.
CharSelectYTbl: ; 00:92B6
    .byte $77, $87, $97, $A7, $B7

;The following table is used to determine the proper X position of the character
;selection sprite on password entry screen.
CharSelectXTbl: ; 00:92BB
    .byte $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0

;When the PasswordCursor is on the second row of the password, the following table is used
;to determine the proper x position of the password cursor sprite(password characters 12-23).
CursorPosXTbl: ; 00:92C8
    .byte $48, $50, $58, $60, $68, $70, $80, $88, $90, $98, $A0, $A8

InitializeGame: ; 00:92D4
    jsr ClearRAM_33_DF              ;($C1D4)Clear RAM.
    jsr ClearSamusStats             ;($C578)Reset Samus stats for a new game.
    jsr LoadPasswordData            ;($8D12)Load data from password.
    ;Clear object data.
    ldy #$00
    sty SpritePagePos
    sty PageIndex
    sty ObjectCntrl
    sty Samus.hi
    jsr SilenceMusic                ;($CB8E)Turn off music.
    ;Set animframe index. changed by initializing routines.
    lda #_id_ObjFrame_SkreeProjectile.b
    sta Samus.animFrame
    ;x is the index into the position tables below.
    ;If in area other than Brinstar, get second item in tables.
    ldx #$01
    lda InArea
    and #$0F
    bne L92F9
        ;Starting in Brinstar. Get first item in each table.
        dex
    L92F9:

    ;Set Samus restart position on screen.
    lda RestartYPosTbl,x
    sta Samus.y
    lda RestartXPosTbl,x
    sta Samus.x

    ;SamusStat0B's low and high bytes keep track of how many times Samus has-->
    ;died or beaten the game as they are incremented every time this routine-->
    ;is run, but they are not accessed anywhere else.
    inc SamusStat0B
    bne L930D
        inc SamusStat0B+1
    L930D:

    ;Initialize starting area.
    lda #_id_MoreInit.b
    sta MainRoutine
    ;($C45D)Turn off screen.
    jsr ScreenNmiOff
    ;($C5DC)Load Samus GFX into pattern table.
    jsr LoadSamusGFX
    ;($C487)Turn on the non-maskable interrupt.
    jsr NMIOn
    ;Load area Samus is to start in.
    lda InArea
    and #$0F
    tay
    ;Change to proper memory page.
    lda BankTable,y
    sta BankSwitchPending
RTS_9324:
    rts

;The following two tables are used to find Samus y and x positions on the screen after the game
;restarts.  The third entry in each table are not used.

RestartYPosTbl: ; 00:9325
    .byte $64                       ;Brinstar
    .byte $8C                       ;All other areas.
    .byte $5C                       ;Not used.

RestartXPosTbl: ; 00:9328
    .byte $78                       ;Brinstar
    .byte $78                       ;All other areas.
    .byte $5C                       ;Not used.

InitializeStats: ; 00:932B
    ;Set all of Samus' stats to 0 when starting new game.
    lda #$00
    sta SamusStat00
    sta EnergyTankCount
    sta SamusGear
    sta MissileCount
    sta MaxMissiles
    sta KraidStatueStatus
    sta RidleyStatueStatus
    sta SamusAge
    sta SamusAge+1
    sta SamusAge+2
    sta SamusAge+3
    sta AtEnding
    sta JustInBailey
    ;Prepare to switch to Brinstar memory page.
    lda #$01+1
    sta BankSwitchPending
    rts

DisplayPassword: ; 00:9359
    ;Wait for "GAME OVER" to be displayed for 160 frames (2.6 seconds).
    lda Timer3
    bne RTS_9324

    ;Turn off screen, erase sprites and nametables.
    jsr ClearAll
    ;Clears screen and writes "PASS WORD".
    ldx #<@VRAMStruct.b
    ldy #>@VRAMStruct.b
    jsr PreparePPUProcess_
    jsr InitPasswordFontGFX
    ; calculate and display password to screen
    jsr CalculatePassword
    jsr NMIOn
    jsr PasswordToScreen
    jsr WaitNMIPass
    ;Change palette.
    lda #_id_Palette12+1.b
    sta PaletteDataPending
    ;Next routine is WaitForSTART.
    inc TitleRoutine
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        jmp ScreenOn                    ;($C447)Turn screen on.
    .elif BUILDTARGET == "NES_CNSUS"
        NES_CNSUS_IllegalOpcode42
        .word ScreenOn
    .endif

@VRAMStruct:
    ;Information below is for above routine to display "PASS WORD" on the screen.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        VRAMStructData $214B, \
            "PASS WORD"
    .elif BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        VRAMStructData $214B, \
            " PASSWORD"
    .endif

    ;Information to be stored in attribute table 0.
    VRAMStructDataRepeat $23D0, $08, \
        $00

    ;Turn color on to display password characters.
    VRAMStructDataRepeat $23D8, $20, \
        $55

    VRAMStructEnd

WaitForSTART: ; 00:9394
    ;Waits for START to be ressed proceed past the GAME OVER screen.
    lda Joy1Change
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        and #BUTTON_START
    .elif BUILDTARGET == "NES_CNSUS"
        ;START has no effect
        NES_CNSUS_IllegalOpcode42
        .byte BUTTON_START
    .endif
    ;If start not pressed, branch.
    beq @RTS
        ;Check if password is correct.
        jmp CheckPassword
    @RTS:
    rts

GameOver: ; 00:939E
    ;Turn off screen, erase sprites and nametables.
    jsr ClearAll
    ;Clears screen and writes "GAME OVER".
    ldx #<@VRAMStruct.b
    ldy #>@VRAMStruct.b
    jsr PreparePPUProcess_
    ; load font
    jsr InitPasswordFontGFX
    jsr NMIOn
    ;Load Timer3 with a delay of 160 frames (2.6 seconds) for displaying "GAME OVER".
    lda #$10
    sta Timer3
    ;Next routine is DisplayPassword.
    lda #_id_DisplayPassword.b
    sta TitleRoutine
    jmp ScreenOn

@VRAMStruct:
    ;Information below is for above routine to display "GAME OVER" on the screen.
    VRAMStructData $218C, \
        "GAME OVER"

    VRAMStructEnd


PasswordToScreen: ; 00:93C6
    jsr WaitNMIPass                 ;($C42C)Wait for NMI to end.

    ldy #$05                        ;Index to find password characters(base=$699A).
    jsr LoadPasswordTiles           ;($93F9)Load tiles on screen.
    ldx #$A9                        ;PPU low address byte.
    ldy #$21                        ;PPU high address byte.
    jsr PrepareEraseTiles           ;($9450)Erase tiles on screen.

    ldy #$0B                        ;Index to find password characters(base=$699A).
    jsr LoadPasswordTiles           ;($93F9)Load tiles on screen.
    ldx #$B0                        ;PPU low address byte.
    ldy #$21                        ;PPU high address byte.
    jsr PrepareEraseTiles           ;($9450)Erase tiles on screen.

    ldy #$11                        ;Index to find password characters(base=$699A).
    jsr LoadPasswordTiles           ;($93F9)Load tiles on screen.
    ldx #$E9                        ;PPU low address byte.
    ldy #$21                        ;PPU high address byte.
    jsr PrepareEraseTiles           ;($9450)Erase tiles on screen.

    ldy #$17                        ;Index to find password characters(base=$699A).
    jsr LoadPasswordTiles           ;($93F9)Load tiles on screen.
    ldx #$F0                        ;PPU low address byte.
    ldy #$21                        ;PPU high address byte.
    jmp PrepareEraseTiles           ;($9450)Erase tiles on screen.


LoadPasswordTiles: ; 00:93F9
    ;Tiles to replace are one block high and 6 blocks long.
    lda #$16
    sta TileSize
    ldx #$05

    ;Transfer password characters to TileInfo addresses.
    @loop:
        lda PasswordChar,y
        sta TileInfo0,x
        dey
        dex
        bpl @loop
    rts

DisplayInputCharacters: ; 00:940B
    lda PPUSTATUS                   ;Clear address latches.
    ldy #$00                        ;
    tya                             ;Initially sets $00 an $01.
    sta $00                         ;to #$00.
    sta $01                         ;Also, initially sets x and y to #$00.
    L9415:
        asl                             ;
        tax                             ;
        lda PasswordRowsTbl,x           ;
        sta PPUADDR                     ;
        lda PasswordRowsTbl+1,x         ;Displays the list of characters -->
        sta PPUADDR                     ;to choose from on the password-->
        ldx #$00                        ;entry screen.
        L9425:
            lda PasswordRow0,y              ;Base is $99A2.
            sta PPUDATA                     ;
            lda #$FF                        ;Blank tile.
            sta PPUDATA                     ;
            iny                             ;
            inx                             ;
            cpx #$0D                        ;13 characters in current row?
            bne L9425                       ;if not, add another character.
        inc $01                         ;
        lda $01                         ;
        cmp #$05                        ;5 rows?
        bne L9415                       ;If not, go to next row.
    rts

;The table below is used by the code above to determine the positions
;of the five character rows on the password entry screen.
;The two entries in each row are the upper and lower address bytes to start writing to the name table, respectively.
PasswordRowsTbl: ; 00:943F
    .byte $21, $E4
    .byte $22, $24
    .byte $22, $64
    .byte $22, $A4
    .byte $22, $E4


PreparePPUProcess_: ; 00:9449
    ;Lower byte of pointer to VRAM structure
    stx Temp00_VRAMStructPtr
    ;Upper byte of pointer to VRAM structure
    sty Temp00_VRAMStructPtr+1
    ;Write VRAM structure to PPU.
    jmp VRAMStructWrite

PrepareEraseTiles: ; 00:9450
    ;PPU low address byte
    stx Temp00_PPURAMPtr
    ;PPU high address byte
    sty Temp00_PPURAMPtr+1

    ;Address of byte where tile size of tile to be erased is stored.
    ldx #<TileSize
    ldy #>TileSize
    stx Temp02_VRAMStringPtr
    sty Temp02_VRAMStringPtr+1
    jmp WriteVRAMString              ;($C328)Erase the selected tiles.

;---------------------------------------[ Unused intro routines ]------------------------------------

;The following routines are intro routines that are not used in this version of the game.  It
;appears that the intro routine was originally going to be more complex with a more advanced
;sprite control mechanism and name table writing routines. The intro routines are a mess! In
;addition to unused routines, there are several unused memory addresses that are written to but
;never read.

;The following unused routine writes something to the-->
;VRAM structure buffer and prepares for a PPU write.
UnusedIntroRoutine4: ; 00:945F
    stx VRAMStructBufferIndex
    lda #$00
    sta VRAMStructBuffer,x
    lda #$01
    sta PPUDataPending
    rts


;Unused intro routine. It looks like originally the-->
;title routines were going to write data to the name-->
;tables in the middle of the title sequences.
UnusedIntroRoutine5: ; 00:946C
    ; run subroutine for high nybble
    sta $05
    and #$F0
    lsr
    lsr
    lsr
    lsr
    jsr @subroutine
    ; run subroutine for low nybble
    lda $05
    and #$0F
    ; fallthrough

@subroutine:
    ; store nybble to current location in VRAMStructBuffer buffer
    sta VRAMStructBuffer,x
    ; move to next byte in buffer
    inx
    ; exit if we haven't moved outside the bounds of the buffer
    txa
    cmp #$55
    bcc @RTS

    ; oh no. we are out of bounds
    ; cancel writing the current vram structure data to the buffer
    ldx VRAMStructBufferIndex
    @loop_infinite:
        ; cancel repeatedly forever
        ; pretty sure this is a bug
        lda #$00
        sta VRAMStructBuffer,x
        beq @loop_infinite
@RTS:
    rts

;Another unused intro routine.
UpdateSaveDataDay: ; 00:948F
    ; push y
    tya
    pha

    ; y = y*16
    jsr Amul16
    tay
    ; load hex day count into $0A-$0B
    lda UnusedSaveData_samusStat+$8+1,y
    sta $0B
    lda UnusedSaveData_samusStat+$8,y
    sta $0A
    ; transform into BCD
    jsr Hex16ToDec
    ; save BCD to save menu mirror of day count
    lda $06
    sta UnusedSaveData_day+1,x
    lda $07
    sta UnusedSaveData_day,x

    ; pop y
    pla
    tay
    rts

;Another unused intro routine.
UpdateSaveDataGameOverCountAndEnergyTank: ; 00:94AF
    ; push y
    tya
    pha

    ; y = y*16
    jsr Amul16
    tay
    ; load hex game over count into $0A-$0B
    lda UnusedSaveData_samusStat+$A+1,y
    sta $0B
    lda UnusedSaveData_samusStat+$A,y
    sta $0A
    ; transform into BCD
    jsr Hex16ToDec
    ; save BCD to save menu mirror of game over count
    lda $06
    sta UnusedSaveData_gameOverCount+1,x
    lda $07
    sta UnusedSaveData_gameOverCount,x

    ; push energy tank count to stack
    lda UnusedSaveData_samusStat+$0,y
    pha
    ; y = x*2
    txa
    lsr
    tay
    ; save to save menu mirror of energy tank count
    pla
    sta UnusedSaveData_energyTank,y

    ; pop y
    pla
    tay
    rts

;Unused intro routine. A 16-bit version of HexToDec.
;Convert 16-bit value in $0A-$0B to 4 decimal digits.
;Stored as a 16-bit BCD value in $06-$07.
Hex16ToDec: ; 00:94DA
    lda #$FF
    sta $01
    sta $02
    sta $03
    sec
    @loop_A:
        ; subtract 1000 from $0A-$0B
        lda $0A
        sbc #$E8
        sta $0A
        lda $0B
        sbc #$03
        sta $0B
        ; increment the thousands digit
        inc $03
        bcs @loop_A
    ; undo the last subtraction
    lda $0A
    adc #$E8
    sta $0A
    lda $0B
    adc #$03
    sta $0B
    ; hundreds
    lda $0A
    @loop_B:
        sec
        @loop_C:
            sbc #$64
            inc $02
            bcs @loop_C
        dec $0B
        bpl @loop_B
    ; undo the last subtraction
    adc #$64
    ; tens
    sec
    @loop_D:
        sbc #$0A
        inc $01
        bcs @loop_D
    ; undo the last subtraction
    adc #$0A

    ; all digits have now been isolated:
    ; thousands in $03, hundreds in $02, tens in $01, ones in a

    ; store ones in $06
    sta $06
    ; add tens multiplied by 16 to $06
    lda $01
    jsr Amul16
    ora $06
    sta $06
    ; store thousands multiplied by 16 + hundreds in $07
    lda $03
    jsr Amul16
    ora $02
    sta $07
    rts

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $63, $D6, $88, $D0, $3A, $A9, $00, $9D, $D0, $05, $A5, $03, $18, $69, $09, $48
    .byte $A5, $04, $29, $02, $F0, $05, $68, $18, $69, $05, $48, $68, $9D, $C0, $05, $A5
    .byte $02, $18, $69, $08, $9D, $B0, $05, $A9, $22, $9D, $E0, $05, $A9, $08, $85, $4A
    .byte $C6, $50, $20, $6E
.endif


;--------------------------------------[ Palette data ]---------------------------------------------

;The following table points to the palette data
;used in the intro and ending portions of the game.

PalettePtrTable: ; 00:9560
    PtrTableEntryArea PalettePtrTable, Palette00             ; Title Screen black
    PtrTableEntryArea PalettePtrTable, Palette01             ; Title Screen purple
    PtrTableEntryArea PalettePtrTable, Palette02             ; Title Screen green
    PtrTableEntryArea PalettePtrTable, Palette03             ; Title Screen magenta
    PtrTableEntryArea PalettePtrTable, Palette04             ; Title Screen warm blue
    PtrTableEntryArea PalettePtrTable, Palette05             ; Title Screen cool blue fade in 1
    PtrTableEntryArea PalettePtrTable, Palette06             ; Title Screen cool blue fade in 2
    PtrTableEntryArea PalettePtrTable, Palette07             ; Title Screen cool blue fade in 3
    PtrTableEntryArea PalettePtrTable, Palette08             ; Title Screen cool blue fade in 4
    PtrTableEntryArea PalettePtrTable, Palette09             ; Title Screen cool blue fade in 5
    PtrTableEntryArea PalettePtrTable, Palette0A             ; Title Screen cool blue fade in 6
    PtrTableEntryArea PalettePtrTable, Palette0B             ; Title Screen cool blue
    PtrTableEntryArea PalettePtrTable, Palette0C             ; Title Screen warm blue fade out 1 / fade in 4 / Start&Continue Menu
    PtrTableEntryArea PalettePtrTable, Palette0D             ; Title Screen warm blue fade out 2 / fade in 3
    PtrTableEntryArea PalettePtrTable, Palette0E             ; Title Screen warm blue fade out 3 / fade in 2
    PtrTableEntryArea PalettePtrTable, Palette0F             ; Title Screen warm blue fade out 4 / fade in 1
    PtrTableEntryArea PalettePtrTable, Palette10             ; Title Screen flash white
    PtrTableEntryArea PalettePtrTable, Palette11             ; ???
    PtrTableEntryArea PalettePtrTable, Palette12             ; Password Screens

Palette00_{AREA}: ; 00:9586
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette01_{AREA}: ; 00:95AA
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $35, $35, $04, $0F, $35, $14, $04, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette02_{AREA}: ; 00:95CE
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $39, $39, $09, $0F, $39, $29, $09, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette03_{AREA}: ; 00:95F2
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $36, $36, $06, $0F, $36, $15, $06, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette04_{AREA}: ; 00:9616
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $27, $27, $12, $0F, $27, $21, $12, \
        $0F, $16, $1A, $27, $0F, $31, $20, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette05_{AREA}: ; 00:963A
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette06_{AREA}: ; 00:965E
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $01, $0F, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette07_{AREA}: ; 00:9682
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $02, $01, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette08_{AREA}: ; 00:96A6
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $01, $01, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette09_{AREA}: ; 00:96CA
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $02, $0F, $12, $12, $02, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette0A_{AREA}: ; 00:96EE
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $11, $11, $02, $0F, $11, $02, $02, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette0B_{AREA}: ; 00:9712
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $31, $31, $01, $0F, $31, $11, $01, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette0C_{AREA}: ; 00:9736
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $12, $30, $21, $0F, $27, $28, $29, $0F, $31, $31, $01, \
        $0F, $16, $2A, $27, $0F, $12, $30, $21, $0F, $27, $24, $2C, $0F, $15, $21, $38
    VRAMStructEnd

Palette0D_{AREA}: ; 00:975A
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $01, $0F, $12, $02, $01, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette0E_{AREA}: ; 00:977E
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $0F, $0F, $02, $01, $0F, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette0F_{AREA}: ; 00:97A2
    VRAMStructData $3F00, \
        $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F, \
        $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12
    VRAMStructEnd

Palette10_{AREA}: ; 00:97C6
    VRAMStructData $3F00, \
        $30, $28, $18, $08, $30, $29, $1B, $1A, $30, $30, $30, $30, $30, $30, $30, $30, \
        $30, $16, $1A, $27, $30, $37, $3A, $1B, $30, $17, $31, $37, $30, $32, $22, $12
    VRAMStructEnd

Palette11_{AREA}: ; 00:97EA
    VRAMStructData $3F00, \
        $0F, $30, $30, $21
    VRAMStructEnd

Palette12_{AREA}: ; 00:97F2
    VRAMStructData $3F00, \
        $0F, $30, $30, $0F, $0F, $2A, $2A, $21, $0F, $31, $31, $0F, $0F, $2A, $2A, $21
    VRAMStructEnd

EndGamePalette0B:
    VRAMStructData $3F00, \
        $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C
    VRAMStructDataRepeat $3F10, $10, \
        $0F
    VRAMStructEnd


UpdateCrossMissileCoords: ; 00:981E
    ;Load sprite run(sprite x component).
    lda IntroSprs.0.speedX,x
    ;Calculate sprite displacement in x direction.
    jsr @CalcDisplacement
    ;Get byte describing if sprite increasing or decreasing pos.
    ldy IntroSprs.0.dirX,x
    bpl @endIf_A
        ;If MSB is set, sprite is decreasing position.
        ;negate sprite displacement.
        eor #$FF
        clc
        adc #$01
    @endIf_A:
    ;Add displacement to sprite x coord.
    clc
    adc IntroSprs.0.x,x
    sta IntroSprs.0.x,x
    ;Subtract total sprite movemnt value from current sprite x pos.
    sec
    sbc IntroSprs.0.crossMissileXChange,x
    ;Transfer processor status to A.
    php
    pla
    ;Eor carry bit with direction byte to see if sprite has reached its end point.
    eor IntroSprs.0.dirX,x
    lsr
    ;Branch if sprite has reached the end of x movement.
    bcc @endIf_B
        ;Load sprite rise(sprite y component).
        lda IntroSprs.0.speedY,x
        ;Calculate sprite displacement in y direction.
        jsr @CalcDisplacement
        ;Get byte describing if sprite increasing or decreasing pos.
        ldy IntroSprs.0.dirY,x
        bpl @endIf_C
            ;If MSB is set, sprite is decreasing position.
            ;negate sprite displacement.
            eor #$FF
            clc
            adc #$01
        @endIf_C:
        ;Add displacement to sprite y coord.
        clc
        adc IntroSprs.0.y,x
        sta IntroSprs.0.y,x
        ;Subtract total sprite movemnt value from current sprite y pos.
        sec
        sbc IntroSprs.0.crossMissileYChange,x
        ;Transfer processor status to A.
        php
        pla
        ;Eor carry bit with direction byte to see if sprite has reached its end point.
        eor IntroSprs.0.dirY,x
        lsr
        ;Branch if sprite has not reached the end of y movement.
        bcs @RTS
    @endIf_B:
    ;After sprite has reached its final position, this code explicitly writes final x and y coords
    ;to the sprite position addresses to make sure the sprites don't overshoot their mark.
    lda IntroSprs.0.crossMissileYChange,x
    sta IntroSprs.0.y,x
    lda IntroSprs.0.crossMissileXChange,x
    sta IntroSprs.0.x,x
@RTS:
    rts

@CalcDisplacement: ; 00:9871
    ;store sprite speed
    sta Temp04_Displacement
    ;Time division. The higher the number, the slower the sprite.
    ;time division in this case is #$08.
    ;the real divisor will be the closest power of two above this number (#$10).
    lda #$08
    sta Temp00_FrameCountMask
    @loop:
        ;Calculate the change in the sprite position by dividing speed
        lsr Temp04_Displacement
        bcc @endIf_D
        ; the frame count is used to dither the division result over time
        ; the greater the fractional part of the result is, the greater chances 1 will be added to the result.
        lda FrameCount
        and Temp00_FrameCountMask
        bne @endIf_D
        inc Temp04_Displacement
    @endIf_D:
        lsr Temp00_FrameCountMask
        bne @loop
    ;Return displacement (speed/16).
    lda Temp04_Displacement
    rts


;This function decrements the y coordinate of the 40 intro star sprites.
DecSpriteYCoord: ; 00:988A
    ;If the end game is playing, branch to exit.
    lda TitleRoutine
    cmp #_id_EndGame.b
    bcs @RTS
    ;If no sprite load is pending, branch to exit.
    lda SpriteLoadPending
    beq @RTS
    ;If not on an odd numbered frame, branch to exit.
    lda FrameCount
    lsr
    bcs @RTS
    ;Decrement y coord of the intro star sprites.
    ldx #$9F
    @loop:
        ;Decrement y coord of 40 sprites.
        dec IntroStarSprite,x
        dec SpriteRAM.24,x
        ;Move to next sprite.
        dex
        dex
        dex
        dex
        ;Loop 40 times.
        cpx #$FF
        bne @loop
    ;Sprite RAM load complete.
    lda #$00
    sta SpriteLoadPending
@RTS:
    rts


LoadStarSprites: ; 00:98AE
    ;Store RAM contents of $6E00 thru $6E9F in sprite RAM at locations $0260 thru $02FF.
    ldy #$9F
    @loop:
        lda IntroStarSprite,y
        sta SpriteRAM.24,y
        dey
        cpy #$FF
        bne @loop
    ;Sprite RAM load complete.
    lda #$00
    sta SpriteLoadPending
    rts

;The following values are loaded into RAM $6E00 thru $6E9F in InitBank0
;routine.  These values are then loaded into sprite RAM at $0260 thru $02FF
;in above routine.  They are the stars in the title screen.
IntroStarsData: ; 00:98C0
    .byte $73, $CC, $22, $F2
    .byte $48, $CD, $63, $EE
    .byte $2A, $CE, $A2, $DC
    .byte $36, $CF, $E2, $C6
    .byte $11, $CC, $23, $B7
    .byte $53, $CD, $63, $A0
    .byte $BB, $CE, $A2, $9A
    .byte $0F, $CF, $E2, $8B
    .byte $85, $CC, $E2, $70
    .byte $9D, $CD, $A3, $6B
    .byte $A0, $CE, $63, $58
    .byte $63, $CF, $23, $4F
    .byte $0A, $CC, $22, $39
    .byte $1F, $CD, $23, $2A
    .byte $7F, $CE, $A3, $1F
    .byte $56, $CF, $A2, $03
    .byte $4D, $CC, $E3, $AF
    .byte $3E, $CD, $63, $2B
    .byte $61, $CE, $E2, $4F
    .byte $29, $CF, $62, $6F
    .byte $8A, $CC, $23, $82
    .byte $98, $CD, $A3, $07
    .byte $AE, $CE, $E2, $CA
    .byte $B6, $CF, $63, $E3
    .byte $0F, $CC, $62, $18
    .byte $1F, $CD, $22, $38
    .byte $22, $CE, $A3, $5F
    .byte $53, $CF, $E2, $78
    .byte $48, $CC, $E3, $94
    .byte $37, $CD, $A3, $B3
    .byte $6F, $CE, $A3, $DC
    .byte $78, $CF, $22, $FE
    .byte $83, $CC, $62, $0B
    .byte $9F, $CD, $23, $26
    .byte $A0, $CE, $62, $39
    .byte $BD, $CF, $A2, $1C
    .byte $07, $CC, $E3, $A4
    .byte $87, $CD, $63, $5D
    .byte $5A, $CE, $62, $4F
    .byte $38, $CF, $23, $85

;Not used.
    VRAMStructData $3F00, \
        $02, $20, $1B, $3A, $02, $20, $21, $01, $02, $2C, $30, $27, $02, $26, $31, $17, \
        $02, $16, $19, $27, $02, $16, $20, $27, $02, $16, $20, $11, $02, $01, $20, $21
    VRAMStructEnd

L9984: ; 00:9984
    VRAMStructData $218C, \
        "START"

    VRAMStructData $21EC, \
        "CONTINUE"

    VRAMStructEnd

;The following pointer table is used to find the start
;of each row on the password screen in the data below.
PasswordRowTbl: ; 00:9998
    .word PasswordRow0              ;($99A2)
    .word PasswordRow1              ;($99AF)
    .word PasswordRow2              ;($99BC)
    .word PasswordRow3              ;($99C9)
    .word PasswordRow4              ;($99D6)

;The following data is used to load the name table With the password characters:
PasswordRow0: .stringmap charmap, "0123456789ABC"
PasswordRow1: .stringmap charmap, "DEFGHIJKLMNOP"
PasswordRow2: .stringmap charmap, "QRSTUVWXYZabc"
PasswordRow3: .stringmap charmap, "defghijklmnop"
PasswordRow4: .stringmap charmap, "qrstuvwxyz?- "

;Writes 'PASSWORD PLEASE' on name table 0 in row $2080 (5th row from top).
L99E3:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        VRAMStructData $2088, \
            "PASS WORD PLEASE"
    .elif BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        VRAMStructData $20A8, \
            "PASSWORD PLEASE "
    .endif

    ;Clears attribute table 0 starting at address $23C0.
    VRAMStructDataRepeat $23C0, $10, \
        $00

    ;Writes to attribute table 0 starting at address $23D0.
    VRAMStructDataRepeat $23D0, $08, \
        $55

    ;Writes to attribute table 0 starting at address $23D8.
    VRAMStructDataRepeat $23D8, $20, \
        $FF

    ;Writes to attribute table 0 starting at address $23DA.
    VRAMStructDataRepeat $23DA, $04, \
        $F0

    VRAMStructEnd

;----------------------------------------[ Ending routines ]-----------------------------------------

;The following routine is accessed via the NMI routine every frame.
NMIScreenWrite: ; 00:9A07
    ;If titleRoutine not at end game, exit.
    lda TitleRoutine
    cmp #$1D
    bcc Exit100

    jsr LoadCredits                 ;($9C45)Display end credits on screen.
    ;If not time to write end message, branch
    lda EndMsgWrite
    beq L9A24
    ;If end message is finished being written, branch
    cmp #$05
    bcs L9A24
        ;Writes the end message on name table 0
        asl
        tay
        ldx EndMessageWritePtrTable-2,y
        lda EndMessageWritePtrTable-1,y
        tay
        jsr PreparePPUProcess           ;($C20E)Prepare to write to PPU.
    L9A24:
    ;If not time to erase end message, branch
    lda HideShowEndMsg
    beq Exit100
    ;If end message is finished being erased, branch
    cmp #$05
    bcs Exit100
        ;Erases the end message on name table 0
        asl
        tay
        ldx EndMessageErasePtrTable-2,y
        lda EndMessageErasePtrTable-1,y
        tay
        jmp PreparePPUProcess           ;($C20E)Prepare to write to PPU.
Exit100:
    rts                             ;Exit from above and below routines.

Restart: ; 00:9A39
    ;If start has not been pressed, branch to exit.
    lda Joy1Status
    and #BUTTON_START
    beq Exit100

    ;Erase PasswordByte00 thru PasswordByte11.
    ldy #$11
    lda #$00
    @loop_erasePassword:
        sta PasswordByte,y
        dey
        bpl @loop_erasePassword

    ;Erase Unique item history.
    iny ;Y = #$00.
    @loop_eraseUniqueItemHistory:
        sta UniqueItemHistory,y
        iny
        bne @loop_eraseUniqueItemHistory

    ;If Samus does not have Maru Mari, branch.
    lda SamusGear
    and #gr_MARUMARI
    beq @endIf_MaruMari
        ;Else load Maru Mari data into PasswordByte00.
        lda #1<<(((ItemData@MaruMari-ItemData)/2)&7).b
        sta PasswordByte+(((ItemData@MaruMari-ItemData)/2)/8)
    @endIf_MaruMari:

    ;If Samus does not have bombs, branch.
    lda SamusGear
    and #gr_BOMBS
    beq @endIf_Bombs
        ;Else load bomb data into PasswordByte00.
        lda PasswordByte+(((ItemData@Bombs-ItemData)/2)/8)
        ora #1<<(((ItemData@Bombs-ItemData)/2)&7).b
        sta PasswordByte+(((ItemData@Bombs-ItemData)/2)/8)
    @endIf_Bombs:

    ;If Samus does not have varia suit, branch.
    lda SamusGear
    and #gr_VARIA
    beq @endIf_Varia
        ;Else load varia suit data into PasswordByte01.
        lda #1<<(((ItemData@Varia-ItemData)/2)&7).b
        sta PasswordByte+(((ItemData@Varia-ItemData)/2)/8)
    @endIf_Varia:

    ;If Samus does not have high jump, branch.
    lda SamusGear
    and #gr_HIGHJUMP
    beq @endIf_HighJump
        ;Else load high jump data into PasswordByte03.
        lda #1<<(((ItemData@HighJump-ItemData)/2)&7).b
        sta PasswordByte+(((ItemData@HighJump-ItemData)/2)/8)
    @endIf_HighJump:

    ;If Samus does not have Maru Mari, branch.
    lda SamusGear
    ;(BUG! Should check for whether Samus has Screw Attack.
    ; This bug, combined with the fact that Maru Mari is required, makes Screw Attack
    ; unobtainable in "New Game Plus" playthroughs, even if you don't already have it.)
    and #gr_MARUMARI
    beq @endIf_ScrewAttack
        ;Else load screw attack data into PasswordByte03.
        lda PasswordByte+(((ItemData@ScrewAttack-ItemData)/2)/8)
        ora #1<<(((ItemData@ScrewAttack-ItemData)/2)&7).b
        sta PasswordByte+(((ItemData@ScrewAttack-ItemData)/2)/8)
    @endIf_ScrewAttack:

    ;Store Samus gear data in PasswordByte09.
    lda SamusGear
    sta PasswordByte+$09
    ;If Samus is wearing suit, branch.
    ;Else load suitless Samus data into PasswordByte08.
    lda #$00
    ldy JustInBailey
    beq @endIf_JustInBailey
        lda #$80
    @endIf_JustInBailey:
    sta PasswordByte+$08

    jmp InitializeGame              ;($92D4)Clear RAM to restart game at beginning.

EndGame: ; 00:9AA7
    ;($9EAA)Load stars in end scene onto screen.
    jsr LoadEndStarSprites
    ;Skips palette change when rolling credits.
    lda IsCredits
    bne @jumpEngine
    ;Changes star palettes every 16th frame.
    lda FrameCount
    and #$0F
    bne @jumpEngine
    inc PaletteDataPending
    ;Reset palette data to #$01 after it reaches #$09.
    lda PaletteDataPending
    cmp #_id_EndGamePalette08+1.b
    bne @jumpEngine
    lda #_id_EndGamePalette00+1.b
    sta PaletteDataPending
@jumpEngine:
    ;RoomPtr used in end of game to determine which subroutine to run below.
    lda RoomPtr
    jsr JumpEngine
        .word LoadEndGFX                ;($9AD5)Load end GFX to pattern tables.
        .word ShowEndSamus              ;($9B1C)Show Samus and end message.
        .word EndSamusFlash             ;($9B34)Samus flashes and changes.
        .word SamusWave                 ;($9B93)Samus waving in ending if suitless.
        .word EndFadeOut                ;($9BCD)Fade out Samus in ending.
        .word RollCredits               ;($9BFC)Rolls ending credits.
        .word Restart                   ;($9A39)Starts at beginning after game completed.
        .word ExitSub                   ;($C45C)Rts.

LoadEndGFX: ; 00:9AD5
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    jsr InitEndGFX                  ;($C5D0)Prepare to load end GFX.
    lda #$04                        ;
    ldy JustInBailey                ;Checks if game was played as suitless-->
    bne L9AE4                       ;Samus.  If so, branch.
        lda #$00                        ;Loads SpritePointerIndex with #$00(suit on).
    L9AE4:
    sta EndingType                  ;
    asl                             ;Loads SpritePointerIndex with #$08(suitless).
    sta SpritePointerIndex          ;
    ;Loads the screen where Samus stands on the surface of the planet in end of game.
    ldx #<VRAMStruct_EndBackground.b
    ldy #>VRAMStruct_EndBackground.b
    jsr PreparePPUProcess           ;($C20E)Prepare to write to PPU.
    jsr NMIOn                       ;($C487)Turn on non-maskable interrupt.
    ;Initiate end game music.
    lda #sfxMulti_EndMusic
    sta MultiSFXFlag
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        ;Loads Timer3 with a delay of 960 frames (16 seconds).
        lda #$60
    .elif BUILDTARGET == "NES_PAL"
        lda #$38
    .endif
    sta Timer3
    ;#$36/#$03 = #$12.  Number of sprites used to draw end graphic of Samus.
    lda #$36
    sta SpriteByteCounter
    ;The following values are initialized to #$00.
    lda #$00
    sta SpriteAttribByte
    sta ColorCntIndex
    sta IsCredits
    sta EndMsgWrite
    sta HideShowEndMsg
    sta CreditPageNumber
    ;Change palette.
    lda #_id_EndGamePalette00+1.b
    sta PaletteDataPending
    ;Initialize ClrChangeCounter with #$08.
    lda #$08
    sta ClrChangeCounter
    inc RoomPtr
    ;Turn screen on.
    jmp ScreenOn

ShowEndSamus: ; 00:9B1C
    jsr LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    lda Timer3                      ;Once 960 frames (16 seconds) have expired,-->
    bne L9B26                       ;Move to EndSamusFlash routine.
        inc RoomPtr
        rts

    L9B26:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        ;After 160 frames have passed (2.6 seconds), write end message.
        cmp #$50
    .elif BUILDTARGET == "NES_PAL"
        cmp #$30
    .endif
    bne L9B2D
        inc EndMsgWrite
        rts

    L9B2D:
    ;After 950 frames have passed (15.8 seconds), erase end message.
    cmp #$01
    bne L9B33
        inc HideShowEndMsg
    L9B33:
    rts

EndSamusFlash: ; 00:9B34
    ;If FrameCount not divisible by 32, branch.
    lda FrameCount
    and #$1F
    bne L9B69
        ;Every 32 frames, increment the ColorCntIndex value.
        ;Flashing Samus lasts for 512 frames (8.5 seconds).
        inc ColorCntIndex
        lda ColorCntIndex
        cmp #$08
        bne L9B52
            ;When EndSamusFlash routine is half way done, ->
            ;this code will calculate the password and choose the proper ending.
            
            ;($CAF5)Choose which Samus ending to show.
            jsr ChooseEnding
            ;($8C7A)Calculate game password.
            jsr CalculatePassword
            ; choose samus's sprite depending on which ending it is
            lda EndingType
            asl
            sta SpritePointerIndex
            lda #$36
            sta SpriteByteCounter
        L9B52:
        cmp #$10
        bne L9B69
            ;Once flashing Samus is complete, set Timer3 for a 160 frame(2.6 seconds) delay.
            sta Timer3
            ldy #$00
            ;If one of the suitless Samus endings, increment sprite color for proper color to be displayed.
            lda EndingType
            cmp #$04
            bcc L9B62
                iny 
            L9B62:
            sty SpriteAttribByte
            ; increment RoomPtr
            inc RoomPtr
            ;($C1A3)Clear all sprites off the screen.
            jmp EraseAllSprites
    L9B69:
    ;Decrement ClrChangeCounter.
    dec ClrChangeCounter
    bne L9B80
        ;When ClrChangeCounter=#$00, fetch new ClrChangeCounter value. and increment sprite color.
        ldy ColorCntIndex
        lda PaletteChangeTable,y
        sta ClrChangeCounter
        inc SpriteAttribByte
        lda SpriteAttribByte
        cmp #$03
        bne L9B80
            ;If sprite color=#$03, set sprite color to #$00.
            lda #$00
            sta SpriteAttribByte
    L9B80:
    ;($9C9A)Load end image of Samus.
    jmp LoadEndSamusSprites

;The following table is used by the above routine to load ClrChangeCounter.  ClrChangeCounter
;decrements every frame, When ClrChangeCounter reaches zero, the sprite colors for Samus
;changes.  This has the effect of making Samus flash.  The flashing starts slow, speeds up,
;then slows down again.
PaletteChangeTable: ; 00:9B83
    .byte $08, $07, $06, $05, $04, $03, $02, $01, $01, $02, $03, $04, $05, $06, $07, $08

SamusWave: ; 00:9B93
    ;If 160 frame timer from previous routine has not expired, branch(waves for 2.6 seconds).
    lda Timer3
    bne L9BA2
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        ;Load Timer3 with 160 frame delay (2.6 seconds).
        lda #$10
    .elif BUILDTARGET == "NES_PAL"
        lda #$08
    .endif
    sta Timer3
    ;Change palette
    lda #_id_EndGamePalette07+1.b
    sta PaletteDataPending
    ;Increment RoomPtr
    inc RoomPtr
    rts

L9BA2:
    ;If suitless Samus ending, branch.
    lda EndingType
    cmp #$04
    bcs L9BAC
        jmp LoadEndSamusSprites
    L9BAC:
    ;If jumpsuit Samus ending, WaveSpritePointer=#$00
    ;if bikini Samus ending, WaveSpritePointer=#$04.
    sbc #$04
    asl
    asl
    sta WaveSpritePointer
    ;Every eight frames, change wave sprite data.
    lda FrameCount
    and #$08
    bne L9BBE
        ldy #$10                        ;Load WaveSpriteCounter with #$10(16 bytes of-->
        sty WaveSpriteCounter           ;sprite data to be loaded).
        bne L9BC6                       ;Branch always.
    L9BBE:
        inc WaveSpritePointer           ;
        inc WaveSpritePointer           ;When bit 3 of FrameCount is not set,-->
        ldy #$10                        ;Samus' waving hand is down.
        sty WaveSpriteCounter           ;
    L9BC6:
    lda #$2D                        ;Load SpriteByteCounter in preparation for-->
    sta SpriteByteCounter           ;refreshing Samus sprite bytes.
    jmp LoadWaveSprites             ;($9C7F)Load sprites for waving Samus.

EndFadeOut: ; 00:9BCD
    ;If 160 frame delay from last routine has not yet expired, branch.
    lda Timer3
    bne L9BEF
    ;Branch always.
    lda IsCredits
    bne L9BDB
        ;*This code does not appear to be used.
        ;*Change palette.
        lda #_id_EndGamePalette07+1.b
        sta PaletteDataPending
        ;*Increment IsCredits.
        inc IsCredits

    L9BDB:
    ;Every eight frame, increment the palette info.
    lda FrameCount
    and #$07
    bne L9BEF
    ;If PaletteDataPending is not equal to #$0C, keep incrementing every eight frame until it does.
    ;This creates the fade out effect.
    inc PaletteDataPending
    lda PaletteDataPending
    cmp #_id_EndGamePalette0B+1.b
    bne L9BEF
        .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
            ;After fadeout complete, load Timer3 with 160 frame delay(2.6 seconds) and increment RoomPtr.
            lda #$10
        .elif BUILDTARGET == "NES_PAL"
            lda #$08
        .endif
        sta Timer3
        inc RoomPtr
    L9BEF:
    ;If suitless Samus ending, load hand wave sprites, else just load regular Samus sprites
    lda EndingType
    cmp #$04
    bcs L9BF9
        jmp LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    L9BF9:
        jmp LoadWaveSprites             ;($9C7F)Load sprites for waving Samus.

RollCredits: ; 00:9BFC
    ;If 160 frame timer delay from previous routine has expired, branch.
    lda Timer3
    beq @endIf_A
        ;If not 20 frames left in Timer3, branch to exit.
        cmp #$02
        bne @RTS
        ;When 20 frames left in Timer3, clear name table 0 and sprites. prepares screen for credits.
        jsr ScreenOff
        jsr ClearNameTables@nameTable0
        jsr EraseAllSprites
        ;Change to proper palette for credits.
        lda #_id_EndGamePalette0B+1+1.b
        sta PaletteDataPending
        ;Turn screen on. Wait for NMI to end.
        jsr ScreenOn
        jmp WaitNMIPass_
    @endIf_A:
    
    ;If first page of credits has not started to roll, start it now, else branch.
    lda CreditPageNumber
    bne @endIf_B
        inc CreditPageNumber
    @endIf_B:
    
    ;If not at last page of credits, branch.
    cmp #$06
    bne @endIf_C
        ;If last page of credits is not finished scrolling, branch.
        lda ScrollY
        cmp #$88
        bcc @endIf_C
            ; Else increment to next routine.
            inc RoomPtr
            rts
    @endIf_C:
    
    ;credits scroll up one position every 4 frames
    ;exit if not ready to scroll
    lda FrameCount
    and #$03
    bne @RTS

    inc ScrollY
    ;Load ScrollY and check it to see if its position is at the very bottom on name table.
    lda ScrollY
    cmp #$F0
    ;if not, branch.
    bne @RTS
    
    ;When ScrollY is at bottom of the name table, Swap to next name table(0 or 2) and increment CreditPageNumber.
    inc CreditPageNumber
    lda #$00
    sta ScrollY
    lda PPUCTRL_ZP
    eor #$02
    sta PPUCTRL_ZP
@RTS:
    rts

;The following routine is checked every frame and is accessed via the NMIScreenWrite routine.
;The LoadCredits routine works like this: The Y scroll position is checked every frame.  When
;it is in the first four positions of the current name table (0, 1, 2 or 3), or the four
;positions right after 127 (128, 129, 130 and 131), the routine will then load the ending
;credits into the positions on the name table that were just scrolled over.  For example, If
;the scroll window is currently half way down name table 0, the LoadCredits routine will load
;the contents of the upper half of name table 0.  Also, name table 0 contains odd numbered
;pages and name table 2 contains even numbered pages.

LoadCredits: ; 00:9C45
    ;If credits are not being displayed, exit.
    ldy CreditPageNumber
    beq @RTS
    ;If CreditPageNumber is higher than #$06, exit.
    cpy #$07
    bcs @RTS
    ;If ScrollY is less than #$80 (128), branch.
    ldx #$00
    lda ScrollY
    bpl @endIf_A
        ;Load X with sign bit (#$01) and remove sign bit from A.
        inx
        sec
        sbc #$80
    @endIf_A:
    ;If (ScrollY & #$7F) is greater or equal to #$04, branch to exit.
    cmp #$04
    bcs @RTS
    ;Store #$00, #$01, #$02 or #$03 in address $01.
    sta $01
    ;Y now contains CreditPageNumber - 1.
    dey
    ;If ScrollY is #$80 (128) or greater, branch.
    txa
    bne @else_B
        ;Y now contains CreditPageNumber - 2.
        dey
        ;If on Credit page less than two, branch to exit.
        bmi @RTS
        ;Start with ((CreditPageNumber - 2) * 8 + 4 + $01) * 2.
        ;Equivalent to CreditPageNumber * 16 - 22
        ;This formula is used when ScrollY = 0, 1, 2 and 3.
        ;Result is index to find proper credits to load.
        tya
        asl
        asl
        asl
        adc #$04
        bne @endIf_B ;Branch always.
    @else_B:
        ;Start with ((CreditPageNumber - 1) * 8 + $01) * 2.
        ;Equivalent to CreditPageNumber * 16 - 14
        ;This formula is used when ScrollY = 128, 129, 130 and 131.
        ;Result is index to find proper credits to load.
        tya
        asl
        asl
        asl
    @endIf_B:
    adc $01
    asl
    tay
    ;Load pointer to VRAM structure into x and y.
    ldx CreditsPtrTable,y
    lda CreditsPtrTable+1,y
    tay
    ;Prepare to write to PPU.
    jmp PreparePPUProcess
@RTS:
    rts

LoadWaveSprites: ; 00:9C7F
    ;Load pointer to wave sprite data into addresses $00 and $01.
    ldx WaveSpritePointer
    lda WavePointerTable,x
    sta $00
    lda WavePointerTable+1,x
    sta $01
    ;Offset for sprite RAM load.
    ldx #<SpriteRAM.8
    ldy #$00
    @loop:
        ;Load wave sprites into sprite RAM starting at location $0220 (SpriteRAM.8).
        lda ($00),y
        sta SpriteRAM,x
        inx
        iny
        ;Check to see if sprite RAM load complete. If not, branch and load another byte.
        cpy WaveSpriteCounter
        bne @loop

LoadEndSamusSprites: ; 00:9C9A
    ;Index for loading Samus sprite data into sprite RAM.
    ldx #SpriteRAM.12 - SpriteRAM
    ldy SpritePointerIndex
    ;Load $00 and $01 with pointer to the sprite data that shows Samus at the end of the game.
    lda EndSamusAddrTbl,y
    sta $00
    lda EndSamusAddrTbl+1,y
    sta $01
    ;Load sprite data starting at Sprite0CRAM.
    ldy #$00
    @loop_A:
        ;Load sprite Y-coord.
        lda ($00),y
        sta SpriteRAM,x
        ;Increment X and Y.
        inx
        iny
        ;If sprite pattern byte MSB cleared, branch.
        lda ($00),y
        bpl @else_A
            ;Remove MSB and write sprite pattern data to sprite RAM.
            and #$7F
            sta SpriteRAM,x
            ; msb is set, so h-flip sprite
            lda SpriteAttribByte
            eor #OAMDATA_HFLIP
            bne @endIf_A ; branch always
        @else_A:
            ;Writes sprite pattern byte to sprite RAM.
            sta SpriteRAM,x
            ; msb is cleared, so don't h-flip sprite
            lda SpriteAttribByte
        @endIf_A:
        ;Writes sprite attribute byte to sprite RAM.
        inx
        sta SpriteRAM,x
        ;Increment X and Y.
        iny
        inx
        ;Load sprite X-coord.
        lda ($00),y
        sta SpriteRAM,x
        ;Increment X and Y.
        iny
        inx
        ;Repeat until sprite load is complete.
        cpy SpriteByteCounter
        bne @loop_A
    
    ; exit if not running the EndSamusFlash routine
    lda RoomPtr
    cmp #$02
    bcc @RTS
    ; exit if EndSamusFlash routine is not more than half way done
    lda ColorCntIndex
    cmp #$08
    bcc @RTS
    ; EndSamusFlash routine is more than half way done
    ; Exit if ending type is not the Samus helmet off ending.
    lda EndingType
    cmp #$03
    bne @RTS
    
    ldy #$00
    ldx #$00
    @loop_B:
        ;The following code loads the sprite graphics when the helmet off ending is playing.
        ;The sprites below keep Samus head from flashing while the rest of her body does.
        lda SamusHeadSpriteTable,y
        sta SpriteRAM,x
        iny
        inx
        cpy #$18
        bne @loop_B
@RTS:
    rts

;The following table is used by the routine above to keep Samus'
;head from flashing during the helmet off ending.

SamusHeadSpriteTable: ; 00:9CFA
    .byte $93, $36, $01, $70        ;Sprite00RAM
    .byte $93, $37, $01, $78        ;Sprite01RAM
    .byte $93, $38, $01, $80        ;Sprite02RAM
    .byte $9B, $46, $01, $70        ;Sprite03RAM
    .byte $9B, $47, $01, $78        ;Sprite04RAM
    .byte $9B, $48, $01, $80        ;Sprite05RAM

;The following table is a pointer table to the sprites that makes Samus wave in the end
;of the game when she is suitless.  The top two pointers are for when she is in the jumpsuit
;and the bottom two pointers are for when she is in the bikini.

WavePointerTable: ; 00:9D12
    .word JsHandUpTable                     ;Jumpsuit Samus hand up.
    .word JsHandDownTable                     ;Jumpsuit Samus hand down.
    .word BkHandUpTable                     ;Bikini Samus hand up.
    .word BkHandDownTable                     ;Bikini Samus hand down.

;Sprite data table used when Samus is in jumpsuit and her waving hand is up.
JsHandUpTable: ; 00:9D1A
    .byte $9B, $1F, $01, $80
    .byte $A3, $2F, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80

;Sprite data table used when Samus is in jumpsuit and her waving hand is down.
JsHandDownTable: ; 00:9D2A
    .byte $9B, $2A, $01, $80
    .byte $9B, $2B, $01, $88
    .byte $A3, $3A, $01, $80
    .byte $AB, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is up.
BkHandUpTable: ; 00:9D3A
    .byte $9B, $0C, $01, $80
    .byte $A3, $1C, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is down.
BkHandDownTable: ; 00:9D4A
    .byte $9B, $4A, $01, $80
    .byte $9B, $4B, $01, $88
    .byte $A3, $4D, $01, $80
    .byte $AB, $3F, $01, $80

EndSamusAddrTbl: ; 00:9D5A
    .word NormalSamus               ;($9D66)Pointer to end graphic of Samus wearing suit.
    .word BackTurnedSamus           ;($9D9C)Pointer to end graphic of back turned Samus.
    .word FistRaisedSamus           ;($9DD2)Pointer to end graphic of fist raised Samus.
    .word HelmetOffSamus            ;($9E08)Pointer to end graphic of helmet off Samus.
    .word JumpsuitSamus             ;($9E3E)Pointer to end graphic of jumpsuit Samus.
    .word BikiniSamus               ;($9E74)Pointer to end graphic of bikini Samus.

;The following three bytes are loaded into sprite RAM.  The third byte (attribute byte) is
;not included.  Instead, if the MSB of the second byte (pattern byte) is set, the pattern
;byte is flipped horizontally (mirror image).  If pattern byte MSB is not set, the attribute
;byte is stored as #$00.  This is done so the code can generate the flashing Samus effect at
;the end of the game.

NormalSamus: ; 00:9D66
    .byte $93, $00, $70
    .byte $93, $01, $78
    .byte $93, $80, $80             ;Mirrored pattern at pattern table location $00.
    .byte $9B, $10, $70
    .byte $9B, $11, $78
    .byte $9B, $90, $80             ;Mirrored pattern at pattern table location $10.
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $22, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $32, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80
    .byte $BB, $50, $70
    .byte $BB, $49, $78
    .byte $BB, $D0, $80             ;Mirrored pattern at pattern table location $50.

BackTurnedSamus: ; 00:9D9C
    .byte $93, $02, $70
    .byte $93, $03, $78
    .byte $93, $04, $80
    .byte $9B, $12, $70
    .byte $9B, $13, $78
    .byte $9B, $14, $80
    .byte $A3, $05, $70
    .byte $A3, $06, $78
    .byte $A3, $07, $80
    .byte $AB, $15, $70
    .byte $AB, $16, $78
    .byte $AB, $17, $80
    .byte $B3, $08, $70
    .byte $B3, $09, $78
    .byte $B3, $88, $80             ;Mirrored pattern at pattern table location $08.
    .byte $BB, $18, $70
    .byte $BB, $19, $78
    .byte $BB, $98, $80             ;Mirrored pattern at pattern table location $18.

FistRaisedSamus: ; 00:9DD2
    .byte $93, $00, $70
    .byte $93, $01, $78
    .byte $93, $34, $80
    .byte $9B, $10, $70
    .byte $9B, $11, $78
    .byte $9B, $44, $80
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $33, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $43, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80             ;Mirrored pattern at pattern table location $40.
    .byte $BB, $50, $70
    .byte $BB, $49, $78
    .byte $BB, $D0, $80             ;Mirrored pattern at pattern table location $50.

HelmetOffSamus: ; 00:9E08
    .byte $93, $0D, $70
    .byte $93, $0E, $78
    .byte $93, $0F, $80
    .byte $9B, $35, $70
    .byte $9B, $27, $78
    .byte $9B, $28, $80
    .byte $A3, $20, $70
    .byte $A3, $21, $78
    .byte $A3, $22, $80
    .byte $AB, $30, $70
    .byte $AB, $31, $78
    .byte $AB, $32, $80
    .byte $B3, $40, $70
    .byte $B3, $41, $78
    .byte $B3, $C0, $80             ;Mirrored pattern at pattern table location $40.
    .byte $BB, $50, $70
    .byte $BB, $49, $78
    .byte $BB, $D0, $80             ;Mirrored pattern at pattern table location $50.

JumpsuitSamus: ; 00:9E3E
    .byte $93, $0D, $70
    .byte $93, $0E, $78
    .byte $93, $0F, $80
    .byte $9B, $1D, $70
    .byte $9B, $1E, $78
    .byte $A3, $2D, $70
    .byte $A3, $2E, $78
    .byte $AB, $3D, $70
    .byte $AB, $3E, $78
    .byte $B3, $08, $70
    .byte $B3, $4E, $78
    .byte $B3, $4F, $80
    .byte $BB, $45, $70
    .byte $BB, $3B, $78
    .byte $BB, $51, $80
    .byte $9B, $29, $80
    .byte $A3, $39, $80
    .byte $AB, $4C, $80

BikiniSamus: ; 00:9E74
    .byte $93, $0D, $70
    .byte $93, $0E, $78
    .byte $93, $0F, $80
    .byte $9B, $0A, $70
    .byte $9B, $0B, $78
    .byte $A3, $1A, $70
    .byte $A3, $1B, $78
    .byte $AB, $3D, $70
    .byte $AB, $3E, $78
    .byte $B3, $08, $70
    .byte $B3, $4E, $78
    .byte $B3, $4F, $80
    .byte $BB, $45, $70
    .byte $BB, $3B, $78
    .byte $BB, $51, $80
    .byte $9B, $2C, $80
    .byte $A3, $3C, $80
    .byte $AB, $4C, $80

LoadEndStarSprites: ; 00:9EAA
    ;Load the table below into sprite RAM starting at address $0270.
    ldy #$00
    @loop:
        lda EndStarDataTable,y
        sta SpriteRAM.28,y
        iny
        cpy #$9C
        bne @loop
    rts

;Loaded into sprite RAM by routine above. Displays stars at the end of the game.

EndStarDataTable: ; 00:9EB8
    .byte $08, $23, $22, $10
    .byte $68, $23, $23, $60
    .byte $00, $23, $22, $60
    .byte $7F, $23, $23, $6A
    .byte $7F, $23, $22, $D4
    .byte $33, $23, $23, $B2
    .byte $93, $23, $22, $47
    .byte $B3, $23, $23, $95
    .byte $0B, $23, $22, $E2
    .byte $1C, $23, $23, $34
    .byte $84, $23, $22, $18
    .byte $B2, $23, $23, $EE
    .byte $40, $23, $22, $22
    .byte $5A, $23, $23, $68
    .byte $1A, $23, $22, $90
    .byte $AA, $23, $23, $22
    .byte $81, $24, $22, $88
    .byte $6A, $24, $23, $D0
    .byte $A8, $24, $22, $A0
    .byte $10, $24, $23, $70
    .byte $15, $25, $22, $42
    .byte $4A, $25, $23, $7D
    .byte $30, $25, $22, $50
    .byte $5A, $25, $23, $49
    .byte $50, $25, $22, $B9
    .byte $91, $25, $23, $B0
    .byte $19, $25, $22, $C0
    .byte $53, $25, $23, $BA
    .byte $A4, $25, $22, $D6
    .byte $98, $25, $23, $1A
    .byte $68, $25, $22, $0C
    .byte $97, $25, $23, $EA
    .byte $33, $25, $22, $92
    .byte $43, $25, $23, $65
    .byte $AC, $25, $22, $4A
    .byte $2A, $25, $23, $71
    .byte $7C, $26, $22, $B2
    .byte $73, $26, $23, $E7
    .byte $0C, $26, $22, $AA

EndGamePaletteWrite: ; 00:9F54
    ;If no palette data pending, branch to exit.
    lda PaletteDataPending
    beq @RTS
    ;If PaletteDataPending has loaded last palette, branch to exit.
    cmp #_id_EndGamePalette0B+1.b
    beq @RTS
    ;Once end palettes have been cycled through, start over.
    cmp #_id_EndGamePalette0B+1+1.b
    bne @endIf_A
        ldy #$00
        sty PaletteDataPending
    @endIf_A:
    ;* 2, pointer is two bytes.
    asl
    tay
    lda EndGamePalettePtrTable-1,y       ;High byte of PPU data pointer.
    ldx EndGamePalettePtrTable-2,y       ;Low byte of PPU data pointer.
    tay
    jsr PreparePPUProcess           ;($C20E)Prepare to write data string to PPU.
    ;Set PPU address to $3F00.
    lda #$3F
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ;Set PPU address to $0000.
    sta PPUADDR
    sta PPUADDR
@RTS:
    rts

;The following pointer table is used by the routine above to
;find the proper palette data during the EndGame routine.

EndGamePalettePtrTable: ; 00:9F81
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette00              ;($9F9B)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette01              ;($9FBF)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette02              ;($9FCB)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette03              ;($9FD7)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette04              ;($9FE3)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette05              ;($9FEF)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette06              ;($9FFB)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette07              ;($A007)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette08              ;($A013)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette09              ;($A02E)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette0A              ;($A049)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette0A              ;($A049)
    PtrTableEntry EndGamePalettePtrTable, EndGamePalette0B              ;($9806)

EndGamePalette00:
    VRAMStructData $3F00, \
        $0F, $21, $11, $02, $0F, $29, $1B, $1A, $0F, $27, $28, $29, $0F, $28, $18, $08, \
        $0F, $16, $19, $27, $0F, $36, $15, $17, $0F, $12, $21, $20, $0F, $35, $12, $16
    VRAMStructEnd

EndGamePalette01:
    VRAMStructData $3F18, \
        $0F, $10, $20, $30, $0F, $0F, $0F, $0F
    VRAMStructEnd

EndGamePalette02:
    VRAMStructData $3F18, \
        $0F, $12, $22, $32, $0F, $0B, $1B, $2B
    VRAMStructEnd

EndGamePalette03:
    VRAMStructData $3F18, \
        $0F, $14, $24, $34, $0F, $09, $19, $29
    VRAMStructEnd

EndGamePalette04:
    VRAMStructData $3F18, \
        $0F, $16, $26, $36, $0F, $07, $17, $27
    VRAMStructEnd

EndGamePalette05:
    VRAMStructData $3F18, \
        $0F, $18, $28, $38, $0F, $05, $15, $25
    VRAMStructEnd

EndGamePalette06:
    VRAMStructData $3F18, \
        $0F, $1A, $2A, $3A, $0F, $03, $13, $13
    VRAMStructEnd

EndGamePalette07:
    VRAMStructData $3F18, \
        $0F, $1C, $2C, $3C, $0F, $01, $11, $21
    VRAMStructEnd

EndGamePalette08:
    VRAMStructData $3F0C, \
        $0F, $18, $08, $07
    VRAMStructData $3F10, \
        $0F, $26, $05, $07, $0F, $26, $05, $07, $0F, $01, $01, $05, $0F, $13, $1C, $0C
    VRAMStructEnd

EndGamePalette09:
    VRAMStructData $3F0C, \
        $0F, $08, $07, $0F
    VRAMStructData $3F10, \
        $0F, $06, $08, $0F, $0F, $06, $08, $0F, $0F, $00, $10, $0F, $0F, $01, $0C, $0F
    VRAMStructEnd

EndGamePalette0A:
    VRAMStructDataRepeat $3F0C, $04, \
        $0F
    VRAMStructDataRepeat $3F10, $10, \
        $0F
    VRAMStructEnd

;The following data writes the end game background graphics.

;Writes ground graphics on name table 0 in row $2300 (25th row from top).
VRAMStruct_EndBackground: ;($A052)
    VRAMStructData $2300, \
        $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31

    ;Writes ground graphics on name table 0 in row $2320 (26th row from top).
    VRAMStructData $2320, \
        $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33

    ;Writes ground graphics on name table 0 in row $2340 (27th row from top).
    VRAMStructData $2340, \
        $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35

    ;Writes ground graphics on name table 0 in row $2360 (28th row from top).
    VRAMStructData $2360, \
        $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37

    ;Writes ground graphics on name table 0 in row $2380 (29th row from top).
    VRAMStructData $2380, \
        $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39

    ;Writes ground graphics on name table 0 in row $23A0 (bottom row).
    VRAMStructData $23A0, \
        $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B

    ;Sets all color bits in attribute table 0 starting at $23F0.
    VRAMStructDataRepeat $23F0, $10, \
        $FF

    ;Writes credits on name table 2 in row $2820 (2nd row from top).
    VRAMStructData $282E, \
        "STAFF"

    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    VRAMStructData $28A8, \
        "SCENARIO WRITTEN BY"

    ;Writes credits on name table 2 in row $28E0 (8th row from top).
    VRAMStructData $28EE, \
        "KANOH"

    ;Writes credits on name table 2 in row $2960 (12th row from top).
    VRAMStructData $2966, \
        "CHARACTER DESIGNED BY"

    ;Writes credits on name table 2 in row $29A0 (14th row from top).
    VRAMStructData $29AC, \
        "KIYOTAKE"

    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    VRAMStructData $2A2B, \
        "NEW MATSUOKA"

    ;Writes credits on name table 2 in row $2A60 (20th row from top).
    VRAMStructData $2A6C, \
        "SHIKAMOTO"

    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    VRAMStructData $2AEC, \
        "MUSIC BY"

    ;Writes credits on name table 2 in row $2B20 (26th row from top)
    VRAMStructData $2B2B, \
        "HIP TANAKA"

    ;Writes credits on name table 2 in row $2BA0 (bottom row).
    VRAMStructData $2BA7, \
        " MAIN PROGRAMMERS "

    VRAMStructEnd


;The following pointer table is accessed by the NMIScreenWrite routine.
;It is used to locate the start of the VRAM structures below.
EndMessageWritePtrTable:
    .word VRAMStruct_EndMessageWrite0
    .word VRAMStruct_EndMessageWrite1
    .word VRAMStruct_EndMessageWrite2
    .word VRAMStruct_EndMessageWrite3

VRAMStruct_EndMessageWrite0:
    ;Writes end message on name table 0 in row $2060 (4th row from top).
    VRAMStructData $206D, \
        "GREAT !!"

    ;Writes end message on name table 0 in row $20C0 (7th row from top).
    VRAMStructData $20C3, \
        "YOU FULFILED YOUR MISSION."

    VRAMStructEnd

VRAMStruct_EndMessageWrite1:
    ;Writes end message on name table 0 in row $2100 (9th row from top).
    VRAMStructData $2103, \
        "IT WILL REVIVE PEACE IN"

    ;Writes end message on name table 0 in row $2140 (11th row from top).
    VRAMStructData $2142, \
        "SPACE."

    VRAMStructEnd

VRAMStruct_EndMessageWrite2:
    ;Writes end message on name table 0 in row $2180 (13th row from top).
    VRAMStructData $2183, \
        "BUT,IT MAY BE INVADED BY"

    ;Writes end message on name table 0 in row $21C0 (15th row from top).
    VRAMStructData $21C2, \
        "THE OTHER METROID."

    VRAMStructEnd

VRAMStruct_EndMessageWrite3:
    ;Writes end message on name table 0 in row $2200 (18th row from top).
    VRAMStructData $2203, \
        "PRAY FOR A TRUE PEACE IN"

    ;Writes end message on name table 0 in row $2240 (19th row from top).
    VRAMStructData $2242, \
        "SPACE!"

    VRAMStructEnd


;The following pointer table is accessed by the NMIScreenWrite routine.
;It is used to locate the start of the VRAM structures below.
EndMessageErasePtrTable: ; 00:A265
    .word VRAMStruct_EndMessageErase0
    .word VRAMStruct_EndMessageErase1
    .word VRAMStruct_EndMessageErase2
    .word VRAMStruct_EndMessageErase3

VRAMStruct_EndMessageErase0:
    ;Erases end message on name table 0 in row $2060 (4th row from top).
    VRAMStructDataRepeat $206D, $08, \
        " "

    ;Erases end message on name table 0 in row $20C0 (7th row from top).
    VRAMStructDataRepeat $20C3, $1A, \
        " "

    VRAMStructEnd

VRAMStruct_EndMessageErase1:
    ;Erases end message on name table 0 in row $2100 (9th row from top).
    VRAMStructDataRepeat $2103, $17, \
        " "

    ;Erases end message on name table 0 in row $2140 (11th row from top).
    VRAMStructDataRepeat $2142, $0A, \
        " "

    VRAMStructEnd

VRAMStruct_EndMessageErase2:
    ;Erases end message on name table 0 in row $2180 (13th row from top).
    VRAMStructDataRepeat $2183, $18, \
        " "

    ;Erases end message on name table 0 in row $21C0 (15th row from top).
    VRAMStructDataRepeat $21C2, $12, \
        " "

    VRAMStructEnd

VRAMStruct_EndMessageErase3:
    ;Erases end message on name table 0 in row $2200 (18th row from top).
    VRAMStructDataRepeat $2203, $18, \
        " "

    ;Erases end message on name table 0 in row $2240 (19th row from top).
    VRAMStructDataRepeat $2242, $0A, \
        " "

    VRAMStructEnd


;The following table is used by the LoadCredits routine to load the end credits on the screen.
CreditsPtrTable: ; 00:A291
    .word VRAMStruct_Credits00
    .word VRAMStruct_Credits01
    .word VRAMStruct_Credits02
    .word VRAMStruct_Credits03
    .word VRAMStruct_Credits04
    .word VRAMStruct_Credits05
    .word VRAMStruct_Credits06
    .word VRAMStruct_Credits07
    .word VRAMStruct_Credits08
    .word VRAMStruct_Credits09
    .word VRAMStruct_Credits0A
    .word VRAMStruct_Credits0B
    .word VRAMStruct_Credits0C
    .word VRAMStruct_Credits0D
    .word VRAMStruct_Credits0E
    .word VRAMStruct_Credits0F
    .word VRAMStruct_Credits10
    .word VRAMStruct_Credits11
    .word VRAMStruct_Credits12
    .word VRAMStruct_Credits13
    .word VRAMStruct_Credits14
    .word VRAMStruct_Credits15
    .word VRAMStruct_Credits16
    .word VRAMStruct_Credits17
    .word VRAMStruct_Credits18
    .word VRAMStruct_Credits19
    .word VRAMStruct_Credits1A
    .word VRAMStruct_Credits1B
    .word VRAMStruct_Credits1C
    .word VRAMStruct_Credits1D
    .word VRAMStruct_Credits1E
    .word VRAMStruct_Credits1F
    .word VRAMStruct_Credits20
    .word VRAMStruct_Credits21
    .word VRAMStruct_Credits22
    .word VRAMStruct_Credits23
    .word VRAMStruct_Credits24
    .word VRAMStruct_Credits25
    .word VRAMStruct_Credits24
    .word VRAMStruct_Credits25
    .word VRAMStruct_Credits28
    .word VRAMStruct_Credits29
    .word VRAMStruct_Credits28
    .word VRAMStruct_Credits29

VRAMStruct_Credits00:
    ;Writes credits on name table 0 in row $2020 (2nd row from top).
    VRAMStructData $202C, \
        "HAI YUKAMI"

    ;Clears attribute table 0 starting at $23C0.
    VRAMStructDataRepeat $23C0, $20, \
        $00

    VRAMStructEnd

VRAMStruct_Credits01:
    ;Writes credits on name table 0 in row $2060 (4th row from top)
    VRAMStructData $206A, \
        "ZARU SOBAJIMA"

    ;Writes credits on name table 0 in row $20A0 (6th row from top).
    VRAMStructData $20AB, \
        "GPZ SENGOKU"

    VRAMStructEnd

VRAMStruct_Credits02:
    VRAMStructEnd

VRAMStruct_Credits03:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    VRAMStructData $216A, \
        "N.SHIOTANI"

    ;Clears attribute table 0 starting at $23E0
    VRAMStructDataRepeat $23E0, $20, \
        $00

    VRAMStructEnd

;Writes credits on name table 0 in row $21E0 (16th row from top).
VRAMStruct_Credits04:
    VRAMStructData $21EB, \
        "M.HOUDAI"

    VRAMStructEnd

VRAMStruct_Credits05:
    ;Writes credits on name table 0 in row $22A0 (22nd row from top).
    VRAMStructData $22A7, \
        "SPECIAL THANKS  TO"

    VRAMStructEnd

VRAMStruct_Credits06:
    ;Writes credits on name table 0 in row $22E0 (24nd row from top).
    VRAMStructData $22EC, \
        "KEN ZURI"

    ;Writes credits on name table 0 in row $2320 (26nd row from top).
    VRAMStructData $232E, \
        "SUMI"

    VRAMStructEnd

VRAMStruct_Credits07:
    ;Writes credits on name table 0 in row $2360 (28nd row from top).
    VRAMStructData $236C, \
        "INUSAWA"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    VRAMStructData $23AD, \
        "KACHO"

    VRAMStructEnd

VRAMStruct_Credits08:
    ;Writes credits on name table 2 in row $2820 (2nd row from top).
    VRAMStructDataRepeat $2828, $0E, \
        " "

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    VRAMStructData $286C, \
        "HYAKKAN"

    VRAMStructEnd

VRAMStruct_Credits09:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    VRAMStructData $28A8, \
        "     GOYAKE        "

    ;Writes credits on name table 2 in row $28E0 (8th row from top).
    VRAMStructDataRepeat $28E8, $0F, \
        " "

    VRAMStructEnd

VRAMStruct_Credits0A:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    VRAMStructData $292C, \
        "HARADA "

    VRAMStructEnd

VRAMStruct_Credits0B:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    VRAMStructData $2966, \
        "       PENPEN         "

    ;Writes credits on name table 2 in row $29A0 (14th row from top).
    VRAMStructDataRepeat $29A8, $0F, \
        " "

    VRAMStructEnd

VRAMStruct_Credits0C:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    VRAMStructData $29EA, \
        "CONVERTED BY"

    VRAMStructEnd

VRAMStruct_Credits0D:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    VRAMStructData $2A26, \
        "     T.NARIHIRO  "

    ;Writes credits on name table 2 in row $2A60 (20th row from top).
    VRAMStructDataRepeat $2A67, $11, \
        " "

    VRAMStructEnd

VRAMStruct_Credits0E:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    VRAMStructData $2AEB, \
        "ASSISTED BY"

    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    VRAMStructData $2B28, \
        "   MAKOTO KANOH"

    VRAMStructEnd

VRAMStruct_Credits0F:
    ;Writes credits on name table 2 in row $2BA0 (bottom row).
    VRAMStructDataRepeat $2BA6, $13, \
        " "

    VRAMStructEnd

VRAMStruct_Credits10:
    ;Writes credits on name table 0 in row $2020 (2nd row from the top).
    VRAMStructData $202B, \
        "DIRECTED BY"

    VRAMStructEnd

VRAMStruct_Credits11:
    ;Writes credits on name table 0 in row $2060 (4th row from the top).
    VRAMStructData $2067, \
        "     YAMAMOTO       "

    ;Writes credits on name table 0 in row $20A0 (6th row from the top).
    VRAMStructDataRepeat $20AA, $0E, \
        " "

    VRAMStructEnd

VRAMStruct_Credits12:
    ;Writes credits on name table 0 in row $2120 (10th row from the top).
    VRAMStructData $2127, \
        "  CHIEF DIRECTOR "

    ;Writes credits on name table 0 in row $2160 (12th row from the top).
    VRAMStructData $2168, \
        "  SATORU OKADA   "

    VRAMStructEnd

VRAMStruct_Credits13:
    ;Writes credits on name table 0 in row $21E0 (16th row from the top).
    VRAMStructDataRepeat $21E6, $18, \
        " "

    VRAMStructEnd

VRAMStruct_Credits14:
    ;Writes credits on name table 0 in row $2220 (18th row from the top).
    VRAMStructData $222B, \
        "PRODUCED BY     "

    ;Writes credits on name table 0 in row $2260 (20th row from the top).
    VRAMStructData $226A, \
        "GUNPEI YOKOI"

    VRAMStructEnd

VRAMStruct_Credits15:
    ;Writes credits on name table 0 in row $22A0 (22nd row from the top).
    VRAMStructDataRepeat $22A6, $13, \
        " "

    ;Writes credits on name table 0 in row $22E0 (24th row from the top).
    VRAMStructDataRepeat $22E8, $0F, \
        " "

    VRAMStructEnd

VRAMStruct_Credits16:
    ;Writes credits on name table 0 in row $2320 (26th row from the top).
    VRAMStructDataRepeat $2329, $0D, \
        " "

    ;Writes credits on name table 0 in row $2340 (27th row from the top).
    VRAMStructData $234B, \
        "COPYRIGHT"

    VRAMStructEnd

VRAMStruct_Credits17:
    ;Writes credits on name table 0 in row $2360 (28th row from the top).
    VRAMStructDataRepeat $236B, $0A, \
        " "

    ;Writes credits on name table 0 in row $2380 (29th row from the top).
    VRAMStructData $238E, \
        "1986"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    VRAMStructDataRepeat $23A8, $0F, \
        " "

    VRAMStructEnd

VRAMStruct_Credits18:
    ;Writes credits on name table 2 in row $2800 (top row)
    VRAMStructData $280C, \
        "NINTENDO"

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    VRAMStructDataRepeat $2866, $11, \
        " "

    VRAMStructEnd

VRAMStruct_Credits19:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    VRAMStructDataRepeat $28AA, $0C, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1A:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    VRAMStructDataRepeat $2926, $1B, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1B:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    VRAMStructDataRepeat $2967, $12, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1C:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    VRAMStructDataRepeat $29E6, $14, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1D:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    VRAMStructDataRepeat $2A28, $15, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1E:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    VRAMStructDataRepeat $2AE6, $10, \
        " "

    VRAMStructEnd

VRAMStruct_Credits1F:
    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    VRAMStructDataRepeat $2B29, $0E, \
        " "

VRAMStruct_Credits20:
    VRAMStructEnd

;Writes the top half of 'The End' on name table 0 in row $2020 (2nd row from top).
VRAMStruct_Credits21:
    VRAMStructData $2026, \
        "     ", $24, $25, $26, $27, "  ", $2C, $2D, $2E, $2F, "     "

    VRAMStructEnd

;Writes the bottom half of 'The End' on name table 0 in row $2040 (3rd row from top).
VRAMStruct_Credits22:
    VRAMStructData $204B, \
        $28, $29, $2A, $2B, "  ", $02, $03, $04, $05

    ;Writes credits on name table 0 in row $2060 (4th row from top).
    VRAMStructDataRepeat $206A, $0C, \
        " "

    VRAMStructEnd

VRAMStruct_Credits23:
    ;Writes credits on name table 0 in row $2120 (10th row from top).
    VRAMStructDataRepeat $2126, $13, \
        " "

    VRAMStructEnd

VRAMStruct_Credits24:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    VRAMStructDataRepeat $216A, $0C, \
        " "

    VRAMStructEnd

VRAMStruct_Credits25:
    ;Writes credits on name table 0 in row $2180 (13th row from top).
    VRAMStructData $2188, \
        "                 "

VRAMStruct_Credits28:
    ;Writes credits on name table 0 in row $2220 (18th row from top).
    VRAMStructDataRepeat $2226, $0B, \
        " "

    VRAMStructEnd

VRAMStruct_Credits29:
    VRAMStructEnd

;-------------------------------------------[ World map ]--------------------------------------------

WorldMap: ; 00:A53E
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $2C, $2B, $27, $15, $15, $16, $14, $13, $04, $FF, $06, $08, $0A, $1A, $29, $29, $28, $2E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
    .byte $FF, $0E, $FF, $01, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $03, $1F, $23, $25, $24, $26, $20, $1E, $1F, $21, $21, $07, $22, $1D, $1B, $21, $20, $04, $FF
    .byte $FF, $10, $FF, $0E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $02, $FF
    .byte $FF, $10, $FF, $0B, $FF, $FF, $08, $0A, $1A, $29, $28, $04, $FF, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $0A, $1A, $29, $29, $28, $04, $FF
    .byte $FF, $10, $FF, $0B, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $08, $FF, $FF, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF
    .byte $FF, $10, $FF, $0F, $11, $13, $14, $14, $13, $12, $0D, $03, $00, $05, $0C, $0E, $0E, $0D, $10, $0C, $0F, $0D, $10, $0C, $0E, $1B, $0F, $0E, $0F, $0D, $04, $FF
    .byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF, $FF, $FF, $11, $FF, $FF, $FF, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
    .byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF, $FF, $FF, $11, $0A, $1A, $28, $04, $FF, $06, $FF, $FF, $FF, $FF, $FF, $06, $FF
    .byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF, $FF, $FF, $08, $FF, $FF, $FF, $08, $FF, $08, $1B, $06, $19, $19, $2A, $0B, $FF
    .byte $FF, $0F, $04, $03, $02, $05, $06, $07, $08, $09, $0A, $06, $FF, $03, $12, $14, $15, $14, $07, $16, $15, $13, $0B, $FF, $0C, $07, $19, $19, $19, $2A, $0E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $01, $FF, $0A, $1B, $04, $0F, $06, $2A, $0E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $02, $FF, $06, $FF, $FF, $FF, $FF, $FF, $09, $FF
    .byte $FF, $08, $17, $09, $14, $13, $18, $12, $14, $19, $13, $04, $FF, $08, $1D, $1F, $06, $1F, $19, $1E, $1E, $1C, $03, $28, $29, $29, $29, $2B, $29, $2A, $0E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $FF, $FF, $FF, $08, $FF, $08, $1D, $1F, $1E, $19, $07, $19, $19, $2C, $06, $06, $2B, $2B, $1A, $1A, $1A, $2A, $0B, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $0B, $FF, $FF, $0B, $FF, $06, $07, $04, $0F, $10, $0B, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $09, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $07, $17, $18, $0C, $FF, $08, $21, $25, $25, $22, $03, $21, $25, $20, $00, $27, $2C, $2C, $06, $04, $0F, $10, $0E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $03, $1C, $07, $17, $18, $0C, $FF, $0A, $21, $23, $25, $22, $03, $21, $24, $24, $24, $23, $23, $06, $24, $25, $22, $11, $2D, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $08, $01, $07, $17, $18, $0C, $FF, $09, $FF, $FF, $FF, $06, $06, $FF, $FF, $FF, $FF, $FF, $FF, $07, $26, $25, $22, $0B, $2D, $FF
    .byte $FF, $0B, $FF, $FF, $FF, $FF, $FF, $02, $0B, $FF, $FF, $08, $FF, $0A, $12, $14, $13, $03, $12, $15, $13, $0D, $12, $14, $06, $14, $18, $15, $19, $07, $09, $FF
    .byte $FF, $09, $17, $1C, $10, $19, $18, $03, $13, $10, $18, $0C, $FF, $06, $FF, $FF, $FF, $09, $04, $0F, $10, $0B, $FF, $FF, $08, $12, $16, $16, $16, $13, $0E, $FF
    .byte $FF, $0A, $17, $1C, $1C, $1C, $18, $03, $13, $19, $12, $0B, $FF, $00, $FF, $FF, $0B, $08, $12, $19, $19, $07, $FF, $FF, $08, $05, $FF, $FF, $FF, $FF, $06, $FF
    .byte $FF, $05, $FF, $FF, $0B, $FF, $FF, $08, $FF, $FF, $FF, $FF, $0B, $FF, $FF, $FF, $FF, $06, $FF, $FF, $FF, $FF, $FF, $05, $06, $01, $FF, $FF, $FF, $FF, $0B, $FF
    .byte $FF, $05, $FF, $FF, $07, $17, $18, $04, $13, $14, $14, $16, $0C, $FF, $05, $FF, $FF, $05, $0F, $18, $17, $18, $19, $29, $05, $02, $FF, $FF, $FF, $FF, $05, $FF
    .byte $FF, $05, $FF, $FF, $08, $FF, $FF, $05, $FF, $0B, $10, $18, $0D, $FF, $0A, $20, $22, $0D, $25, $26, $26, $26, $1D, $0E, $0E, $03, $23, $24, $24, $15, $07, $FF
    .byte $FF, $05, $FF, $FF, $23, $17, $18, $06, $22, $0C, $FF, $0B, $0E, $FF, $0B, $FF, $FF, $04, $FF, $FF, $FF, $FF, $05, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
    .byte $FF, $23, $22, $1A, $13, $10, $14, $1C, $16, $06, $21, $0C, $0E, $FF, $0A, $1C, $1D, $03, $20, $21, $21, $22, $06, $23, $0F, $28, $27, $27, $27, $19, $07, $FF
    .byte $FF, $0B, $FF, $1E, $1F, $20, $20, $20, $0F, $15, $21, $24, $0E, $FF, $04, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $04, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $1D, $1B, $17, $18, $0C, $FF, $04, $11, $10, $12, $13, $14, $14, $15, $03, $1C, $1E, $1E, $1F, $1F, $1F, $1D, $07, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0B, $FF, $0C, $16, $18, $17, $18, $17, $0F, $17, $17, $1A, $1A, $17, $1B, $1B, $17, $19, $09, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

;Loads contents of world map into RAM at addresses $7000 thru $73FF.
CopyMap: ; 00:A93E
    lda #<WorldMap.b
    sta Temp00_WorldMapPtr
    lda #>WorldMap.b
    sta Temp00_WorldMapPtr+1
    lda #<WorldMapRAM
    sta Temp02_WorldMapRAMPtr
    lda #>WorldMapRAM
    sta Temp02_WorldMapRAMPtr+1
    ldx #$04
    @loop:
        ldy #$00
        @endIf_A:
            lda (Temp00_WorldMapPtr),y
            sta (Temp02_WorldMapRAMPtr),y
            iny
            bne @endIf_A
        inc Temp00_WorldMapPtr+1
        inc Temp02_WorldMapRAMPtr+1
        dex
        bne @loop
    rts

;Unused tile patterns.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .incbin "norfair/bg_chr_2.chr" skip $11
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        .incbin "common_chr/bg_boss_areas.chr" read $240
    .elif BUILDTARGET == "NES_CNSUS"
        .incbin "common_chr/bg_boss_areas_cnsus.chr" read $240
    .endif
.elif BUILDTARGET == "NES_PAL"
    .byte $A9, $01, $85, $10, $A5, $05, $29, $01, $85, $05, $A0, $17, $B9, $00, $03, $30
    .byte $4F, $F0, $66, $C9, $03, $90, $62, $A5, $10, $D0, $49, $B9, $00, $03, $C9, $0F
    .byte $F0, $57, $BD, $A8, $05, $C9, $03, $D0, $3B, $BD, $B8, $05, $19, $90, $03, $D0
    .byte $48, $BD, $B0, $05, $18, $69, $10, $B0, $40, $38, $F9, $78, $03, $90, $3A, $C9
    .byte $28, $B0, $36, $BD, $C0, $05, $18, $69, $10, $38, $F9, $A8, $03, $90, $2A, $C9
    .byte $28, $B0, $26, $B9, $18, $03, $85, $04, $B9, $30, $03, $85, $05, $4C, $DD, $E9
    .byte $A5, $10, $F0, $15, $B9, $90, $03, $C9, $01, $F0, $0E, $B9, $18, $03, $C5, $04
    .byte $D0, $07, $B9, $30, $03, $C5, $05, $F0, $03, $4C, $F3, $EA, $8A, $48, $A5, $10
    .byte $F0, $25, $10, $14, $B9, $00, $03, $C9, $0F, $D0, $19, $B9, $F0, $03, $D0, $05
    .byte $A9, $01, $99, $F0, $03, $4C, $F1, $EA, $B9, $00, $03, $10, $07, $B9, $F0, $03
    .byte $D0, $02, $F0, $1B, $4C, $F1, $EA, $38, $BD, $A8, $05, $AA, $B9, $F0, $03, $CA
    .byte $D0, $05, $E5, $4D, $4C, $1B, $EA, $FD, $49, $DF, $99, $F0, $03, $B0, $E5, $A5
    .byte $05, $18, $69, $06, $85, $05, $20, $1F, $EB, $E8, $D0, $03, $4C, $EE, $EA, $A5
    .byte $10, $F0, $73, $10, $03, $4C, $9F, $EA, $B9, $00, $03, $29, $0F, $C9, $04, $D0
    .byte $31, $A5, $34, $18, $69, $08, $C9, $81, $90, $02, $A9, $79, $85, $34, $D0, $45
    .byte $A5, $B6, $4A, $B0, $14, $A9, $04, $20, $ED, $E1, $A5, $B6, $C9, $02, $D0, $01
    .byte $2C, $A9, $00, $8D, $64, $04, $4C, $96, $EA, $E6, $55, $D0, $02, $C6, $55, $4C
    .byte $96, $EA, $C9, $0D, $F0, $DA, $38, $E9, $05, $AA, $B5, $4D, $18, $7D, $09, $EC
    .byte $90, $02, $A9, $FF, $95, $4D, $E8, $CA, $D0, $08, $C9, $1F, $90, $04, $A9, $1E
    .byte $85, $4D, $20, $14, $E2, $98, $48, $A9, $0B, $20, $71, $87, $68, $A8, $A9, $00
    .byte $99, $00, $03, $AA, $F0, $45, $B9, $00, $03, $48, $09, $80, $99, $00, $03, $A9
    .byte $0B, $99, $F0, $03, $68, $A2, $00, $C9, $03, $F0, $07, $C9, $0E, $D0, $1A, $A9
    .byte $00, $2C, $A9, $05, $20, $A2, $E2, $98, $48, $A9, $09, $20, $71, $87, $68, $A8
    .byte $A9, $FF, $99, $30, $03, $A9, $00, $F0, $12, $A9, $05, $20, $A2, $E2, $98, $48
    .byte $A9, $09, $20, $71, $87, $68, $A8, $A1, $04, $29, $F0, $81, $04, $68, $AA, $60
    .byte $68, $AA, $88, $30, $03, $4C, $6D, $E9, $60, $A2, $01, $A9, $C0, $95, $6B, $A9
    .byte $FF, $95, $69, $A9, $20, $95, $AA, $95, $AE, $A9, $00, $95, $A8, $95, $AC, $9D
    .byte $5B, $04, $95, $A0, $95, $A2, $95, $A4, $95, $A6, $CA, $10, $DE, $60, $A2, $01
    .byte $B5, $AA, $C9, $20, $F0, $03, $4C, $02, $EC, $B9, $60, $03, $95, $AA, $48, $B9
    .byte $48, $03, $95, $A8, $18, $69, $20, $95, $AC, $68, $69, $00, $95, $AE, $98, $48
    .byte $B9, $00, $03, $A8, $B9, $48, $00, $85, $0F, $98, $0A, $0A, $A8, $C0, $3C, $F0
    .byte $04, $A5, $10, $F0, $04, $A0, $04, $D0, $04, $C0, $0C, $D0, $60, $AD, $63, $04
    .byte $0A, $A8, $90, $20, $B9, $4C, $F4, $95, $A0, $B9, $C8, $F4, $95, $A2, $B9, $4D
    .byte $F4, $95, $A4, $B9, $C9, $F4, $95, $A6, $AD, $63, $04, $4A, $4A, $A8, $B9, $3C
    .byte $F4, $4C, $A2, $EB, $B9, $CC, $95, $95, $A0, $B9, $B2, $96, $95, $A2, $B9, $CD
    .byte $95, $95, $A4, $B9, $B3, $96, $95, $A6, $AD, $63, $04, $4A, $4A, $A8, $B9, $AF
    .byte $95, $85, $02, $AD, $63, $04, $29, $03, $F0, $08, $A8, $46, $02, $46, $02, $88
    .byte $D0, $F9, $A5, $02, $29, $03, $A8, $B9, $11, $EC, $4C, $E8, $EB, $A5, $0F, $D0
    .byte $10, $A9, $38, $95, $A0, $A9, $48, $95, $A2, $A9, $39, $95, $A4, $A9, $49, $D0
    .byte $12, $B9, $AC, $E4, $95, $A0, $B9, $AD, $E4, $95, $A2, $B9, $AE, $E4, $95, $A4
    .byte $B9, $AF, $E4, $95, $A6, $A9, $00, $85, $02, $68, $A8, $B9, $C0, $03, $95, $6B
    .byte $B9, $D8, $03, $95, $69, $49, $FF, $25, $02, $9D, $5B, $04, $A9, $20, $4C
.endif


;------------------------------------------[ Area music data ]---------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/end.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/end.asm"
.endif

;Unused tile patterns.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .incbin "tourian/bg_chr.chr" skip $263 read $FD
.elif BUILDTARGET == "NES_CNSUS"
    .incbin "tourian/bg_chr.chr" skip $263 read $D
    .incbin "tourian/bg_chr_cnsus.chr" skip $270 read $F0
.elif BUILDTARGET == "NES_PAL"
    .byte $02, $A8, $B9, $D9, $93, $85, $7A, $B9, $DA, $93, $85, $7B, $BD, $4A, $F6, $8D
    .byte $61, $04, $A9, $00, $85, $7D, $8D, $12, $04, $60, $85, $7D, $0A, $A8, $B1, $7A
    .byte $C8, $85, $3B, $B1, $7A, $85, $3C, $A9, $00, $85, $16, $85, $17, $85, $18, $85
    .byte $19, $85, $1A, $85, $46, $85, $3D, $85, $59, $85, $1D, $A9, $90, $85, $1E, $A9
    .byte $07, $85, $73, $A9, $08, $85, $72, $A9, $24, $85, $37, $A9, $DF, $85, $36, $A9
    .byte $9F, $85, $38, $A9, $27, $85, $3A, $A9, $00, $A2, $07, $95, $F8, $CA, $10, $FB
    .byte $A9, $FF, $85, $74, $20, $47, $EF, $60, $A2, $00, $A9, $00, $9D, $00, $06, $E8
    .byte $D0, $FA, $9D, $00, $07, $E8, $D0, $FA, $60, $A5, $1E, $8D, $00, $20, $A5, $17
    .byte $4A, $A5, $16, $6A, $8D, $05, $20, $A9, $00, $8D, $05, $20, $60, $A6, $1D, $A9
    .byte $60, $CA, $F0, $02, $A9, $90, $85, $02, $A5, $2E, $4A, $A5, $2D, $6A, $C5, $02
    .byte $D0, $08, $A5, $33, $29, $01, $C5, $1D, $F0, $07, $A9, $00, $85, $45, $4C, $FC
    .byte $EF, $C9, $01, $D0, $00, $AD, $5A, $04, $F0, $05, $A9, $00, $85, $45, $60, $A5
    .byte $31, $4A, $4A, $4A, $18, $65, $46, $85, $46, $A5, $49, $4A, $90, $0C, $A5, $46
    .byte $4A, $4A, $85, $45, $A5, $46, $29, $03, $85, $46, $A5, $16, $18, $65, $45, $85
    .byte $16, $90, $14, $A5, $17, $69, $00, $85, $17, $C9, $02, $D0, $0A, $29, $01, $85
    .byte $17, $A5, $1E, $49, $01, $85, $1E, $A5, $45, $18, $65, $1A, $85, $1A, $38, $E9
    .byte $10, $90, $0D, $85, $1A, $E6, $3D, $A5, $3D, $29, $3F, $85, $3D, $20, $18, $F0
    .byte $A5, $45, $F0, $09, $A9, $08, $85, $72, $A9, $07, $85, $73, $60, $C6, $72, $D0
    .byte $17
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/intro.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/intro.asm"
.endif

;Unused tile patterns.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .incbin "tourian/bg_chr.chr" skip $495 read $CB
.elif BUILDTARGET == "NES_CNSUS"
    .incbin "tourian/bg_chr_cnsus.chr" skip $495 read $CB
.elif BUILDTARGET == "NES_PAL"
    .byte $3B, $C8, $48, $B1, $3B, $85, $3C, $68, $85, $3B, $A0, $00, $4C, $54, $F0, $E6
    .byte $3B, $D0, $02, $E6, $3C, $85, $74, $0A, $AA, $90, $15, $BD, $0B, $99, $85, $75
    .byte $BD, $0C, $99, $85, $76, $BD, $3C, $95, $85, $56, $BD, $3D, $95, $4C, $77, $F1
    .byte $BD, $0B, $98, $85, $75, $BD, $0C, $98, $85, $76, $BD, $3C, $94, $85, $56, $BD
    .byte $3D, $94, $85, $57, $A9, $00, $85, $58, $84, $02, $84, $59, $A9, $01, $85, $03
    .byte $A9, $0C, $85, $11, $B1, $75, $10, $14, $C9, $FF, $D0, $05, $85, $74, $4C, $49
    .byte $F0, $C8, $E6, $59, $29, $7F, $85, $0F, $B1, $75, $D0, $04, $85, $0F, $A9, $01
    .byte $85, $10, $C8, $E6, $59, $A9, $00, $85, $08, $A5, $0F, $48, $0A, $AA, $A5, $38
    .byte $4A, $A5, $6D, $D0, $16, $90, $0A, $BD, $77, $F3, $48, $BD, $76, $F3, $4C, $FB
    .byte $F1, $BD, $F3, $F2, $48, $BD, $F2, $F2, $4C, $FB, $F1, $30, $16, $90, $0A, $BD
    .byte $B3, $96, $48, $BD, $B2, $96, $4C, $FB, $F1, $BD, $CD, $95, $48, $BD, $CC, $95
    .byte $4C, $FB, $F1, $90, $0A, $BD, $C9, $F4, $48, $BD, $C8, $F4, $4C, $FB, $F1, $BD
    .byte $4D, $F4, $48, $BD, $4C, $F4, $A6, $02, $95, $E0, $E8, $68, $95, $E0, $E8, $86
    .byte $02, $68, $85, $05, $48, $4A, $4A, $AA, $A5, $6D, $D0, $06, $BD, $E1, $F2, $4C
    .byte $22, $F2, $30, $06, $BD, $AF, $95, $4C, $22, $F2, $BD, $3C, $F4, $85, $04, $68
    .byte $29, $03, $AA, $E8, $A5, $04, $CA, $F0, $05, $4A, $4A
.endif

.ends

;------------------------------------------[ Sound Engine ]------------------------------------------

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .section "ROM Bank $000 - Music Engine" bank 0 slot "ROMSwitchSlot" orga $B200 force
.elif BUILDTARGET == "NES_PAL"
    .section "ROM Bank $000 - Music Engine" bank 0 slot "ROMSwitchSlot" orga $B230 force
.endif

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $000 - Vectors" bank 0 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

