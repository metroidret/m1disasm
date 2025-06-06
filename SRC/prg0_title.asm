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

BANK .set 0
.segment "BANK_00_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export MainTitleRoutine
.export StarPalSwitch
.export DecSpriteYCoord
.export NMIScreenWrite
.export EndGamePalWrite
.export CopyMap
.export IntroStarsData

;---------------------------------------------[ Import ]---------------------------------------------

.import Startup
.import NMI
.import ClearNameTables
.import ClearNameTable0
.import EraseAllSprites
.import RemoveIntroSprites
.import ClearRAM_33_DF
.import PreparePPUProcess_
.import ChooseRoutine
.import AddYToPtr02
.import Adiv16
.import Adiv8
.import Amul16
.import Amul8
.import ProcessPPUString
.import EraseTile
.import WritePPUByte
.import PrepPPUPaletteString
.import TwosComplement
.import WaitNMIPass
.import ScreenOff
.import WaitNMIPass_
.import ScreenOn
.import ExitSub
.import ScreenNmiOff
.import VBOffAndHorzWrite
.import NMIOn
.import SetTimer
.import ClearSamusStats
.import InitEndGFX
.import LoadSamusGFX
.import InitGFX7
.import BankTable
.import ChooseEnding
.import SilenceMusic

;------------------------------------------[ Start of code ]-----------------------------------------

MainTitleRoutine:
    lda TitleRoutine                ;
    cmp #$15                        ;If intro routines not running, branch.
    bcs L8027                       ;
    lda Joy1Change                  ;
    and #$10                        ;if start has not been pressed, branch.
    beq L8022                       ;
        ldy #$00                        ;
        sty SpareMemD1                  ;Not accessed by game.
        sty SpareMemBB                  ;Not accessed by game.
        sty SpareMemB7                  ;Accessed by unused routine.
        sty SpareMemB8                  ;Accessed by unused routine.
        lda PPUCTRL_ZP                  ;
        and #$FC                        ;Set name table to name table 0.
        sta PPUCTRL_ZP                  ;
        lda #$1B                        ;If start pressed, load START/CONTINUE screen.
        sta TitleRoutine                ;
        bne L8027                       ;Branch always.
    L8022:
        jsr RemoveIntroSprites          ;($C1BC)Remove sparkle and crosshair sprites from screen.
        lda TitleRoutine                ;
L8027:
    jsr ChooseRoutine               ;($C27C)Jump to proper routine below.
        .word InitializeAfterReset      ;($8071)First routine after reset.
        .word DrawIntroBackground       ;($80D0)Draws ground on intro screen.
        .word FadeInDelay               ;($80F9)Sets up METROID fade in delay.
        .word METROIDFadeIn             ;($812C)Fade METROID onto screen.
        .word LoadFlashTimer            ;($8142)Load timer for METROID flash.
        .word FlashEffect               ;($8109)Makes METROID flash.
        .word METROIDSparkle            ;($814D)Top and bottom "sparkles" on METROID.
        .word METROIDFadeOut            ;($8163)Fades METROID off the screen.
        .word Crosshairs                ;($8182)Displays "crosshairs" effect on screen.
        .word MoreCrosshairs            ;($81D1)Continue "crosshairs" effect.
        .word IncTitleRoutine           ;($806E)Increment TitleRoutine.
        .word IncTitleRoutine           ;($806E)Increment TitleRoutine.
        .word ChangeIntroNameTable      ;($822E)Change from name table 0 to name table 1.
        .word MessageFadeIn             ;($8243)Fade in intro sequence message.
        .word MessageFadeOut            ;($8263)Fade out intro sequence message.
        .word DelayIntroReplay          ;($8283)Set Delay time before intro sequence restarts.
        .word ClearSpareMem             ;($8068)clears some memory addresses not used by game.
        .word PrepIntroRestart          ;($82A3)Prepare to restart intro routines.
        .word TitleScreenOff            ;($82ED)Turn screen off.
        .word TitleRoutineReturn        ;($82F3)Rts.
        .word TitleRoutineReturn        ;($82F3)Rts.
        .word StartContinueScreen       ;($90BA)Displays START/Continue screen.
        .word ChooseStartContinue       ;($90D7)player chooses between START and CONTINUE.
        .word LoadPasswordScreen        ;($911A)Loads password entry screen.
        .word EnterPassword             ;($9147)User enters password.
        .word DisplayPassword           ;($9359)After game over, display password on screen.
        .word WaitForSTART              ;($9394)Wait for START when showing password.
        .word StartContinueScreen       ;($90BA)Displays START/Continue screen.
        .word GameOver                  ;($939E)Displays "GAME OVER".
        .word EndGame                   ;($9AA7)Show ending of the game.
        .word SetTimer                  ;($C4AA)Set delay timer.

;----------------------------------------[ Intro routines ]------------------------------------------

ClearSpareMem:
    lda #$00                        ;
    sta SpareMemCB                  ;Clears two memory addresses not used by the game.
    sta SpareMemC9                  ;

IncTitleRoutine:
    inc TitleRoutine                ;Increment to next title routine.
    rts                             ;

InitializeAfterReset:
    ldy #$02                        ;Y=2.
    sty SpareMemCF                  ;Not accessed by game.
    sty SpareMemCC                  ;Not accessed by game.
    dey                             ;Y=1.
    sty SpareMemCE                  ;Not accessed by game.
    sty SpareMemD1                  ;Not accessed by game.
    dey                             ;Y=0.
    sty SpareMemD0                  ;Not accessed by game.
    sty SpareMemCD                  ;Not accessed by game.
    sty SpareMemD3                  ;Not accessed by game.
    sty NARPASSWORD                 ;Set NARPASSWORD not active.
    sty SpareMemCB                  ;Not accessed by game.
    sty SpareMemC9                  ;Not accessed by game.
    lda #$02                        ;A=2.
    sta IntroMusicRestart           ;Title rountines cycle twice before restart of music.
    sty SpareMemB7                  ;Accessed by unused routine.
    sty SpareMemB8                  ;Accessed by unused routine.
    sty PalDataIndex                ;Reset index to palette data.
    sty ScreenFlashPalIndex         ;Reset index into screen flash palette data.
    sty IntroStarOffset             ;Reset index into IntroStarPntr table.
    sty FadeDataIndex               ;Reset index into fade out palette data.
    sty $00                         ;
    ldx #$60                        ;Set $0000 to point to address $6000.

    L809E:
        stx $01                         ;
        txa                             ;
        and #$03                        ;
        asl                             ;
        tay                             ;The following loop Loads the -->
        sty $02                         ;RAM with the following values: -->
        lda RamValueTbl, y              ;$6000 thru $62FF = #$00.
        ldy #$00                        ;$6300 thru $633F = #$C0.
        L80AC:
            sta ($00), y                    ;$6340 thru $63FF = #$C4.
            iny                             ;$6400 thru $66FF = #$00.
            beq L80BE                       ;$6700 thru $673F = #$C0.
            cpy #$40                        ;$6740 thru $67FF = #$C4.
            bne L80AC                       ;
            ldy $02                         ;
            lda RamValueTbl+1, y            ;
            ldy #$40                        ;
            bpl L80AC                       ;
        L80BE:
        inx                             ;
        cpx #$68                        ;
        bne L809E                       ;

    inc TitleRoutine                ;Draw intro background next.
    jmp LoadStarSprites             ;($98AE)Loads stars on intro screen.

;The following table is used by the code above for writing values to RAM.

RamValueTbl: ;$80C8
    .byte $00, $00, $00, $00, $00, $00, $C0, $C4

DrawIntroBackground:
    lda #sfxMulti_IntroMusic        ;Intro music flag.
    sta ABStatus                    ;Never accessed by game.
    sta MultiSFXFlag                ;Initiates intro music.
    jsr ScreenOff                   ;($C439)Turn screen off.
    jsr ClearNameTables             ;($C158)Erase name table data.
    ldx #.lobyte(L82F4)             ;Lower address of PPU information.
    ldy #.hibyte(L82F4)             ;Upper address of PPU information.
    jsr PreparePPUProcess_          ;($C20E) Writes background of intro screen to name tables.
    lda #$01                        ;
    sta PalDataPending              ;Prepare to load palette data.
    sta SpareMemC5                  ;Not accessed by game.
    lda PPUCTRL_ZP                  ;
    and #$FC                        ;Switch to name table 0
    sta PPUCTRL_ZP                  ;
    inc TitleRoutine                ;Next routine sets up METROID fade in delay.
    lda #$00                        ;
    sta SpareMemD7                  ;Not accessed by game.
    jmp ScreenOn                    ;($C447)Turn screen on.

FadeInDelay:
    lda PPUCTRL_ZP                  ;
    and #$FE                        ;Switch to name table 0 or 2.
    sta PPUCTRL_ZP                  ;
    lda #$08                        ;Loads Timer3 with #$08. Delays Fade in routine.-->
    sta Timer3                      ;Delays fade in by 80 frames (1.3 seconds).
    lsr                             ;
    sta PalDataIndex                ;Loads PalDataIndex with #$04
    inc TitleRoutine                ;Increment to next routine.
    rts

FlashEffect:
    lda FrameCount                  ;Every third frame, run change palette-->
    and #$03                        ;Creates METROID flash effect.
    bne RTS_812B                    ;
    lda PalDataIndex                ;Uses only the first three palette-->
    and #$03                        ;data sets in the flash routine.
    sta PalDataIndex                ;
    jsr LoadPalData                 ;
    lda Timer3                      ;If Timer 3 has not expired, branch-->
    bne RTS_812B                    ;so routine will keep running.
    lda PalDataIndex                ;
    cmp #$04                        ;Ensures the palette index is back at 0.
    bne RTS_812B                    ;
    inc TitleRoutine                ;Increment to next routine.
    jsr LoadSparkleData             ;($87AB) Loads data for next routine.
    lda #$18                        ;Sets Timer 3 for a delay of 240 frames-->
    sta Timer3                      ;(4 seconds).
RTS_812B:
    rts

METROIDFadeIn:
    lda Timer3                      ;
    bne RTS_8141                    ;
    lda FrameCount                  ;Every 16th FrameCount, Change palette.-->
    and #$0F                        ;Causes the fade in effect.
    bne RTS_8141                    ;
    jsr LoadPalData                 ;($8A8C)Load data into Palettes.
    bne RTS_8141                    ;
    lda #$20                        ;Set timer delay for METROID flash effect.-->
    sta Timer3                      ;Delays flash by 320 frames (5.3 seconds).
    inc TitleRoutine                ;
RTS_8141:
    rts

LoadFlashTimer:
    ;If 320 frames have not passed, exit
    lda Timer3
    bne RTS_8141
    ;Stores a value of 80 frames in Timer3 (1.3 seconds).
    lda #$08
    sta Timer3
    inc TitleRoutine
    rts

METROIDSparkle:
    lda Timer3                      ;Wait until 3 seconds have passed since-->
    bne RTS_8162                    ;last routine before continuing.
    lda IntroSprComplete            ;Check if sparkle sprites are done moving.
    and IntroSprComplete+$10        ;
    cmp #$01                        ;Is sparkle routine finished? If so,-->
    bne L815F                       ;go to next title routine, else continue-->
    inc TitleRoutine                ;with sparkle routine.
    bne RTS_8162                    ;
L815F:
    jsr UpdateSparkleSprites        ;($87CF)Update sparkle sprites on the screen.
RTS_8162:
    rts

METROIDFadeOut:
    lda FrameCount                  ;Wait until the frame count is a multiple-->
    and #$07                        ;of eight before proceeding.
    bne RTS_8181                    ;
    lda FadeDataIndex               ;If FadeDataIndex is less than #$04, keep-->
    cmp #$04                        ;doing the palette changing routine.
    bne L817E                       ;
    jsr InitCrossMissiles           ;($8897)Load initial sprite values for crosshair routine.
    lda #$08                        ;
    sta Timer3                      ;Load Timer3 with a delay of 80 frames(1.3 seconds).
    sta CrossMsl0to3SlowDelay       ;Set counter for slow sprite movement for 8 frames,
    lda #$00                        ;
    sta SecondCrosshairSprites      ;Set SecondCrosshairSprites = #$00
    inc TitleRoutine                ;Move to next routine
L817E:
    jsr DoFadeOut                   ;($8B5F)Fades METROID off the screen.
RTS_8181:
    rts

Crosshairs:
    lda FlashScreen                 ;Is it time to flash the screen white?-->
    beq L8189                       ;If not, branch.
    jsr FlashIntroScreen            ;($8AA7)Flash screen white.
L8189:
    lda Timer3                      ;Wait 80 frames from last routine-->
    bne RTS_81D0                    ;before running this one.
    lda IntroSprComplete            ;
    and IntroSprComplete+$10        ;Check if first 4 sprites have completed-->
    and IntroSprComplete+$20        ;their movements.  If not, branch.
    and IntroSprComplete+$30        ;
    beq L81CA                       ;
    lda #$01                        ;Prepare to flash screen and draw cross.
    cmp SecondCrosshairSprites      ;Branch if second crosshair sprites are already-->
    beq L81AB                       ;active.
    inc SecondCrosshairSprites      ;Indicates second crosshair sprites are active.
    sta IsUpdatingCrossExplode            ;Draw cross animation on screen.
    sta FlashScreen                 ;Flash screen white.
    lda #$00                        ;
    sta CrossExplodeLengthIndex              ;Reset index to cross sprite data.
L81AB:
    and IntroSprComplete+$40        ;
    and IntroSprComplete+$50        ;Check if second 4 sprites have completed-->
    and IntroSprComplete+$60        ;their movements.  If not, branch.
    and IntroSprComplete+$70        ;
    beq L81CA                       ;
    lda #$01                        ;Prepare to flash screen and draw cross.
    sta IsUpdatingCrossExplode            ;Draw cross animation on screen.
    sta FlashScreen                 ;Flash screen white.
    jsr LoadStarSprites             ;($98AE)Loads stars on intro screen.
    lda #$00                        ;
    sta CrossExplodeLengthIndex              ;Reset index to cross sprite data.
    inc TitleRoutine                ;Do MoreCrosshairs next frame.
    bne L81CD                       ;Branch always.
L81CA:
    jsr UpdateCrossMissiles         ;($88FE)Draw sprites that converge in center of screen.
L81CD:
    jsr UpdateCrossExplode          ;($8976)Draw cross sprites in middle of the screen.
RTS_81D0:
    rts

MoreCrosshairs:
    lda FlashScreen                 ;Is it time to flash the screen white?-->
    beq L81DB                       ;If not, branch.
    jsr UpdateCrossExplode          ;($8976)Draw cross sprites in middle of the screen.
    jmp FlashIntroScreen            ;($8AA7)Flash screen white.
L81DB:
    inc TitleRoutine                ;ChangeIntroNameTable is next routine to run.
    lda #$60                        ;
    sta ObjY                        ;
    lda #$7C                        ;These values are written into memory, but they are-->
    sta ObjX                        ;not used later in the title routine.  This is the-->
    lda ObjAnimResetIndex           ;remnants of some abandoned code.
    sta ObjAnimIndex                ;
    rts

;Unused intro routine.
UnusedIntroRoutine1:
    lda #$01
    sta SpareMemBB
    lda #$04
    sta SpritePagePos
    sta Joy1Change
    sta Joy1Status
    sta Joy1Retrig
    lda #$03
    sta ObjAction
    sta ScrollDir
    inc TitleRoutine
    rts

;Unused intro routine. It looks like this routine-->
;was going to be used to manipulate sprite objects.
UnusedIntroRoutine2:
    lda ObjAction
    cmp #$04
    bne RTS_822D
    lda #$00
    sta ObjAction
    lda #$0B
    sta ObjAnimResetIndex
    lda #$0C
    sta ObjAnimIndex
    lda #$07
    sta ObjAnimFrame
    lda #$08
    sta Timer3
    lda #$00
    sta SpareMemC9 ;Not accessed by game.
    sta SpareMemCB ;Not accessed by game.
    inc TitleRoutine
RTS_822D:
    rts

ChangeIntroNameTable:
    ;Change to name table 1.
    lda PPUCTRL_ZP
    ora #$01
    sta PPUCTRL_ZP
    ;Next routine to run is MessageFadeIn.
    inc TitleRoutine
    ;Set Timer3 for 80 frames(1.33 seconds).
    lda #$08
    sta Timer3
    ;Index to FadeInPalData.
    lda #$06
    sta FadeDataIndex
    lda #$00
    sta SpareMemC9 ;Not accessed by game.
    rts

MessageFadeIn:
    lda Timer3                      ;Check if delay timer has expired.  If not, branch-->
    bne RTS_8262                    ;to exit, else run this rouine.
    lda FrameCount                  ;
    and #$07                        ;Perform next step of fade every 8th frame.
    bne RTS_8262                    ;
    lda FadeDataIndex               ;
    cmp #$0B                        ;Has end of fade in palette data been reached?-->
    bne L825F                       ;If not, branch.
    lda #$00                        ;
    sta FadeDataIndex               ;Clear FadeDataIndex.
    lda #$30                        ;
    sta Timer3                      ;Set Timer3 to 480 frames(8 seconds).
    inc TitleRoutine                ;Next routine is MessageFadeOut.
    bne RTS_8262                    ;Branch always.
L825F:
    jsr DoFadeOut                   ;($8B5F)Fade message onto screen.
RTS_8262:
    rts

MessageFadeOut:
    lda Timer3                      ;Check if delay timer has expired.  If not, branch-->
    bne RTS_8282                    ;to exit, else run this rouine.
    lda FrameCount                  ;
    and #$07                        ;Perform next step of fade every 8th frame.
    bne RTS_8282                    ;
    lda FadeDataIndex               ;
    cmp #$05                        ;Has end of fade out palette data been reached?-->
    bne L827F                       ;If not, branch.
    lda #$06                        ;
    sta FadeDataIndex               ;Set index to start of fade in data.
    lda #$00                        ;
    sta SpareMemCB                  ;Not accessed by game.
    inc TitleRoutine                ;Next routine is DelayIntroReplay.
    bne RTS_8282                    ;Branch always.
L827F:
    jsr DoFadeOut                   ;($8B5F)Fade message off of screen.
RTS_8282:
    rts

DelayIntroReplay:
    ;Increment to next routine.
    inc TitleRoutine
    ;Set Timer3 for a delay of 160 frames(2.6 seconds).
    lda #$10
    sta Timer3
    rts

;Unused intro routine.
UnusedIntroRoutine3:
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

PrepIntroRestart:
    lda Timer3                      ;Check if delay timer has expired.  If not, branch-->
    bne RTS_82E9                    ;to exit, else run this rouine.
    sta SpareMemD2                  ;Not accessed by game.
    sta SpareMemBB                  ;Not accessed by game.
    sta IsSamus                     ;Clear IsSamus memory address.
    ldy #$1F                        ;
L82AF:
    sta ObjAction,y                 ;
    dey                             ;Clear RAM $0300 thru $031F.
    bpl L82AF                       ;
    lda PPUCTRL_ZP                  ;Change to name table 0.
    and #$FC                        ;
    sta PPUCTRL_ZP                  ;
    iny                             ;Y=0.
    sty SpareMemB7                  ;Accessed by unused routine.
    sty SpareMemB8                  ;Accessed by unused routine.
    sty PalDataIndex                ;
    sty ScreenFlashPalIndex         ;Clear all index values from these addresses.
    sty IntroStarOffset             ;
    sty FadeDataIndex               ;
    sty SpareMemCD                  ;Not accessed by game.
    sty Joy1Change                  ;
    sty Joy1Status                  ;Clear addresses that were going to be written to by an-->
    sty Joy1Retrig                  ;unused intro routine.
    sty SpareMemD7                  ;Not accessed by game.
    iny                             ;Y=1.
    sty SpareMemCE                  ;Not accessed by game.
    iny                             ;Y=2.
    sty SpareMemCC                  ;Not accessed by game.
    sty SpareMemCF                  ;Not accessed by game.
    sty TitleRoutine                ;Next routine sets up METROID fade in delay.
    lda IntroMusicRestart           ;Check to see if intro music needs to be restarted.-->
    bne L82EA                       ;Branch if not.
    lda #sfxMulti_IntroMusic        ;
    sta MultiSFXFlag                ;Restart intro music.
    lda #$02                        ;Set restart of intro music after another two cycles-->
    sta IntroMusicRestart           ;of the title routines.
RTS_82E9:
    rts

L82EA:
    dec IntroMusicRestart           ;One title routine cycle complete. Decrement intro-->
    rts                             ;music restart counter.

TitleScreenOff:
    jsr ScreenOff                   ;($C439)Turn screen off.
    inc TitleRoutine                ;Next routine is TitleRoutineReturn.
    rts                             ;This routine should not be reached.

TitleRoutineReturn:
    rts                             ;Last title routine function. Should not be reached.

;The following data fills name table 0 with the intro screen background graphics.
L82F4:
    ;Information to be stored in attribute table 0.
    PPUString $23C0, {$00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF}

    PPUString $23E0, {$FF, $FF, $BF, $AF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00}

    ;Writes row $22E0 (24th row from top).
    PPUString $22E0, {$FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF}

    ;Writes row $2300 (25th row from top).
    PPUString $2300, {$80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81}

    ;Writes row $2320 (26th row from top).
    PPUString $2320, {$82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83}

    ;Writes row $2340 (27th row from top).
    PPUString $2340, {$84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85}

    ;Writes row $2360 (28th row from top).
    PPUString $2360, {$86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87}

    ;Writes row $2380 (29th row from top).
    PPUString $2380, {$88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89}

    ;Writes row $23A0 (Bottom row).
    PPUString $23A0, {$8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B}

    ;Writes some blank spaces in row $20A0 (6th row from top).
    PPUStringRepeat $20A8, ' ', $0F

    ;Writes METROID graphics in row $2100 (9th row from top).
    PPUString $2103, {$40, $5D, $56, $5D, $43, $40, $5D, $43, $40, $5D, $5D, $43, $40, $5D, $5D, $63, $62, $5D, $5D, $63, $40, $43, $40, $5D, $5D, $63, $1D, $16}

    ;Writes METROID graphics in row $2120 (10th row from top).
    PPUString $2123, {$44, $50, $50, $50, $47, $44, $57, $58, $74, $75, $76, $77, $44, $57, $69, $47, $44, $57, $69, $47, $44, $47, $44, $68, $69, $47}

    ;Writes METROID graphics in row $2140 (11th row from top).
    PPUString $2143, {$44, $41, $7E, $49, $47, $44, $59, $5A, $78, $79, $7A, $7B, $44, $59, $6D, $70, $44, $73, $72, $47, $44, $47, $44, $73, $72, $47}

    ;Writes METROID graphics in row $2160 (12th row from top).
    PPUString $2163, {$44, $42, $7F, $4A, $47, $44, $5B, $5C, $FF, $44, $47, $FF, $44, $5B, $6F, $71, $44, $45, $46, $47, $44, $47, $44, $45, $46, $47}

    ;Writes METROID graphics in row $2180 (13th row from top).
    PPUString $2183, {$44, $47, $FF, $44, $47, $44, $5F, $60, $FF, $44, $47, $FF, $44, $7D, $7C, $47, $44, $6A, $6B, $47, $44, $47, $44, $6A, $6B, $47}

    ;Writes METROID graphics in row $21A0 (14th row from top).
    PPUString $21A3, {$4C, $4F, $FF, $4C, $4F, $4C, $5E, $4F, $FF, $4C, $4F, $FF, $4C, $4D, $4E, $4F, $66, $5E, $5E, $64, $4C, $4F, $4C, $5E, $5E, $64}

    ;Writes METROID graphics in row $21C0 (15th row from top).
    PPUString $21C3, {$51, $52, $FF, $51, $52, $51, $61, $52, $FF, $51, $52, $FF, $51, $53, $54, $52, $67, $61, $61, $65, $51, $52, $51, $61, $61, $65}

    ;Writes PUSH START BUTTON in row $2220 (18th row from top).
    PPUString $2227, " PUSH START BUTTON   "

    ;Writes C 1986 NINTENDO in row $2260 (20th row from top).
    PPUString $2269, "< 1986 NINTENDO   "

;The following data fills name table 1 with the intro screen background graphics.

    ;Information to be stored in attribute table 1.
    PPUString $27C0, {$00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF}

    ;Writes row $27E0 (24th row from top).
    PPUString $27E0, {$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00}

    ;Writes row $26E0 (24th row from top).
    PPUString $26E0, {$FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF, $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF}

    ;Writes row $2700 (25th row from top).
    PPUString $2700, {$80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81}

    ;Writes row $2720 (26th row from top).
    PPUString $2720, {$82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83}

    ;Writes row $2740 (27th row from top).
    PPUString $2740, {$84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85}

    ;Writes row $2760 (28th row from top).
    PPUString $2760, {$86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87}

    ;Writes row $2780 (29th row from top).
    PPUString $2780, {$88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89}

    ;Writes row $27A0 (bottom row).
    PPUString $27A0, {$8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B}

    ;Writes row $2480 (5th row from top).
    PPUString $2488, "EMERGENCY ORDER"

    ;Writes row $2500 (9th row from top).
    PPUString $2504, "DEFEAT THE METROID OF       "

    ;Writes row $2540 (11th row from top).
    PPUString $2544, "THE PLANET ZEBETH AND     "

    ;Writes row $2580 (13th row from top).
    PPUString $2584, "DESTROY THE MOTHER BRAIN  "

    ;Writes row $25C0 (15th row from top).
    PPUString $25C4, "THE MECHANICAL LIFE VEIN  "

    ;Writes row $2620 (18th row from top).
    PPUString $2627, "GALAXY FEDERAL POLICE"

    ;Writes row $2660 (20th row from top).
    PPUString $2669, "              M510"

    .byte $00                       ;End PPU string write.

;The following data does not appear to be used.
    .byte $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $20, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;The following error message is diplayed if the player enters an incorrect password.
L8759:
    .byte "ERROR TRY AGAIN"

;If the error message above is not being displayed on the password
;screen, the following fifteen blanks spaces are used to cover it up.
L8768:
    .byte "               "

;Not used.
    .byte $79, $87, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $A1, $87, $A2, $87, $A5, $87, $A8, $87, $00, $18, $CC, $00, $18, $CD
    .byte $00, $18, $CE, $00

LoadSparkleData:
    ldx #$0A
    L87AD:
        lda InitSparkleDataTbl,x
        sta IntroSprYCoord,x           ;Loads $6EA0 thru $6EAA with the table below.
        sta IntroSprYCoord+$10,x       ;Loads $6EB0 thru $6EBA with the table below.
        dex
        ;Loop until all values from table below are loaded.
        bpl L87AD
    ;$6EA0 thru $6EAA = #$3C, #$C6, #$01, #$18, #$00, #$00, #$00, #$00, #$20, #$00, #$00, initial.
    ;$6EB0 thru $6EBA = #$6B, #$C6, #$01, #$DC, #$00, #$00, #$00, #$00, #$20, #$00, #$00, initial.
    lda #$6B
    sta IntroSprYCoord+$10
    lda #$DC
    sta IntroSprXCoord+$10
    rts

;Used by above routine to load Metroid initial sparkle data into $6EA0
;thru $6EAA and $6EB0 thru $6EBA.

InitSparkleDataTbl:
    .byte $3C, $C6, $01, $18, $00, $00, $00, $00, $20, $00, $00

UpdateSparkleSprites:
    ;Performs calculations on top sparkle sprite.
    ldx #$00
    jsr DoTwoSparkleUpdates
    ;Performs calculations on bottom sparkle sprite.
    ldx #$10
    ; fallthrough
DoTwoSparkleUpdates:
    jsr SparkleUpdate               ;($87D9)Update sparkle sprite data.
    ; fallthrough
SparkleUpdate:
    ;If $6EA5 has not reached #$00, skip next routine.
    lda IntroSprNextDelay,x
    bne L87E1
        ;($881A)Update sparkle sprite screen position.
        jsr DoSparkleSpriteCoord
    L87E1:
    
    ;If sprite is already done, skip routine.
    lda IntroSprComplete,x
    bne RTS_8819
    
    dec IntroSprNextDelay,x

    ;Updates sparkle sprite Y coord.
    lda SparkleSprYChange,x
    clc
    adc IntroSprYCoord,x
    sta IntroSprYCoord,x

    ;Updates sparkle sprite X coord.
    lda SparkleSprXChange,x
    clc
    adc IntroSprXCoord,x
    sta IntroSprXCoord,x

    ;Decrement IntroSprChangeDelay.
    dec IntroSprChangeDelay,x
    ;If 0, time to change sprite graphic.
    bne L8816
        ;The sparkle sprite graphic is-->
        ;changed back and forth between pattern table-->
        ;graphic $C6 and $C5. (BUG! Should be $C6 and $C7)
        lda IntroSprPattTbl,x
        eor #($C6^$C5)
        sta IntroSprPattTbl,x
        ;IntroSprChangeDelay is reset to #$20.
        lda #$20
        sta IntroSprChangeDelay,x
        ;Flips pattern at $C5 in pattern table-->
        ;horizontally when displayed.
        asl ; a = #OAMDATA_HFLIP
        eor IntroSprCntrl,x
        sta IntroSprCntrl,x
    L8816:
    jmp WriteIntroSprite ;($887B)Transfer sprite info into sprite RAM.
RTS_8819:
    rts

DoSparkleSpriteCoord:
    txa                             ;
    jsr Adiv8                       ;($C2C0)Y=0 when working with top sparkle sprite-->
    tay                             ;and y=2 when working with bottom sparkle sprite.
    lda SparkleAddressTbl,y         ;Base is $89AF.
    sta $00                         ;When working with top sparkle sprite, E1,E0=$89B3-->
    lda SparkleAddressTbl+1,y       ;and when botton sparkle sprite, E1,E0=$89E9.
    sta $01                         ;
    ldy IntroSprIndex,x             ;Loads index for finding sparkle data (x=$00 or $10).
    lda ($00),y                     ;
    bpl L8835                       ;If data byte MSB is set, set $6EA9 to #$01 and move to-->
        lda #$01                        ;next index for sparkle sprite data.
        sta IntroSprByteType,x          ;
    L8835:
    bne L883C                       ;
        lda #$01                        ;If value is equal to zero, sparkle sprite-->
        sta IntroSprComplete,x          ;processing is complete.
    L883C:
    sta IntroSprNextDelay,x         ;
    iny                             ;
    lda ($00),y                     ;Get x/y position byte.
    dec IntroSprByteType,x          ;If MSB of second byte is set, branch.
    bmi L8850                       ;
        lda #$00                        ;This code is run when the MSB of the first byte-->
        sta SparkleSprYChange,x        ;is set.  This allows the sprite to change X coord-->
        lda ($00),y                     ;by more than 7.  Ensures Y coord does not change.
        bmi L8867                       ;
    L8850:
        pha                             ;Store value twice so X and Y-->
        pha                             ;coordinates can be extracted.
        lda #$00                        ;
        sta IntroSprByteType,x          ;Set IntroSpr0ByteType to #$00 after processing.
        pla                             ;
        jsr Adiv16                      ;($C2BF)Move upper 4 bits to lower 4 bits.
        jsr NibbleSubtract              ;($8871)Check if nibble to be converted to twos complement.
        sta SparkleSprYChange,x         ;Twos complement stored if Y coord decreasing.
        pla                             ;
        and #$0F                        ;Discard upper 4 bits.
        jsr NibbleSubtract              ;($8871)Check if nibble to be converted to twos complement.
    L8867:
    sta SparkleSprXChange,x         ;Store amount to move spite in x direction.
    inc IntroSprIndex,x             ;
    inc IntroSprIndex,x             ;Add two to find index for next data byte.
    rts                             ;

NibbleSubtract:
    cmp #$08                        ;If bit 3 is set, nibble is a negative number-->
    bcc RTS_887A                    ;and lower three bits are converted to twos-->
    and #$07                        ;complement for subtraction, else exit.
    jsr TwosComplement              ;($C3D4)Prepare for subtraction with twos complement.
RTS_887A:
    rts

;Load the four bytes for the intro sprites into sprite RAM.
WriteIntroSprite:
    lda IntroSprYCoord,x
    sec ;Subtract #$01 from first byte to get proper y coordinate.
    sbc #$01
    sta SpriteRAM+$04<<2,x
    
    lda IntroSprPattTbl,x
    sta SpriteRAM+$04<<2+1,x
    
    lda IntroSprCntrl,x
    sta SpriteRAM+$04<<2+2,x
    
    lda IntroSprXCoord,x
    sta SpriteRAM+$04<<2+3,x
    
    rts

InitCrossMissiles:
    lda #$20                        ;
    sta CrossMsl4to7SpawnDelay      ;Set delay for second 4 sprites to 32 frames.
    ldx #$3F                        ;Prepare to loop 64 times.

    L889D:
        lda InitCrossMissile0and4Tbl,x        ;Load data from tables below.
        cmp $FF                         ;If #$FF, skip loading that byte and move to next item.
        beq L88AA                       ;
            sta IntroSprYCoord,x            ;Store initial values for sprites 0 thru 3.
            sta IntroSprYCoord+$40,x        ;Store initial values for sprites 4 thru 7.
        L88AA:
        dex                             ;
        bpl L889D                       ;Loop until all data is loaded.

    lda #$B8                        ;Special case for sprite 6 and 7.
    sta IntroSprYCoord+$60          ;
    sta IntroSprYCoord+$70          ;Change sprite 6 and 7 initial y position.
    lda #$16                        ;
    sta IntroSprYRise+$60           ;Change sprite 6 and 7 y displacement. The combination-->
    sta IntroSprYRise+$70           ;of these two changes the slope of the sprite movement.
    rts

;The following tables are loaded into RAM as initial sprite control values for the crosshair sprites.

InitCrossMissile0and4Tbl:
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

InitCrossMissile1and5Tbl:
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

InitCrossMissile2and6Tbl:
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

InitCrossMissile3and7Tbl:
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
UpdateCrossMissiles:
    ;Has CrossMsl0to3SlowDelay already hit 0? If so, branch.
    lda CrossMsl0to3SlowDelay
    beq L8936
    
    dec CrossMsl0to3SlowDelay
    ;Is CrossMsl0to3SlowDelay now equal to 0? if not, branch.
    bne L8936
    
    ;Multiply the rise and run of the 8 sprites by 2.-->
    ;This doubles their speed.
    asl IntroSprXRun
    asl IntroSprYRise
    asl IntroSprXRun+$10
    asl IntroSprYRise+$10
    asl IntroSprXRun+$20
    asl IntroSprYRise+$20
    asl IntroSprXRun+$30
    asl IntroSprYRise+$30
    asl IntroSprXRun+$40
    asl IntroSprYRise+$40
    asl IntroSprXRun+$50
    asl IntroSprYRise+$50
    asl IntroSprXRun+$60
    asl IntroSprYRise+$60
    asl IntroSprXRun+$70
    asl IntroSprYRise+$70
    
L8936:
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
UpdateCrossMissile: ;($8963)
    ;If the current sprite has finished its movements, exit this routine.
    lda IntroSprComplete,x
    bne RTS_8975
    
    ;Calculate new sprite position.
    jsr UpdateCrossMissileCoords
    ;If sprite not at final position, branch to move next frame.
    bcs L8972
        ;Sprite movement complete.
        lda #$01
        sta IntroSprComplete,x
    L8972:
    ;($887B)Write sprite data to sprite RAM.
    jmp WriteIntroSprite

RTS_8975:
    rts

UpdateCrossExplode:
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

    ;Increment index into CrossExplodeLengthTbl every-->
    ;other frame.  This updates the cross sprites-->
    ;every two frames.
    lda FrameCount
    lsr
    bcc RTS_89A9
    inc CrossExplodeLengthIndex
RTS_89A9:
    rts

;The following table tells the routine above how many data bytes to load from CrossExplodeDataTbl.
;The more data that is loaded, the bigger the cross that is drawn on the screen.  The table below
;starts the cross out small, it then grows bigger and gets small again.

CrossExplodeLengthTbl:
    .byte CrossExplodeLength0
    .byte CrossExplodeLength1
    .byte CrossExplodeLength2
    .byte CrossExplodeLength1
    .byte CrossExplodeLength0

;The following table is used to find the data for the sparkle routine in the table below:

SparkleAddressTbl:
    .word TopSparkleDataTbl         ;($89B3)Table for top sparkle data.
    .word BottomSparkleDataTbl      ;($89E9)Table for bottom sparkle data.

;The following two tables are the data tables for controlling the movement of the sparkle sprites
;in the title routine.  Here's how thw data in the tables work: The first byte is a counter byte.
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

TopSparkleDataTbl:
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

BottomSparkleDataTbl:
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

CrossExplodeDataTbl:
    .byte $10                       ;Load following sprite data into Sprite04RAM.
    .byte $5A, $C0, $00, $79        ;Sprite data.
    CrossExplodeLength0 = * - CrossExplodeDataTbl
    .byte $14                       ;Load following sprite data into Sprite05RAM.
    .byte $52, $C8, $00, $79        ;Sprite data.
    .byte $18                       ;Load following sprite data into Sprite06RAM.
    .byte $5A, $C2, $40, $71        ;Sprite data.
    .byte $1C                       ;Load following sprite data into Sprite07RAM.
    .byte $5A, $C2, $00, $81        ;Sprite data.
    .byte $20                       ;Load following sprite data into Sprite08RAM.
    .byte $62, $C8, $80, $79        ;Sprite data.
    CrossExplodeLength1 = * - CrossExplodeDataTbl
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
    CrossExplodeLength2 = * - CrossExplodeDataTbl

LoadPalData:
    ;Chooses which set of palette data to load from the table below.
    ldy PalDataIndex
    lda PalSelectTbl,y
    cmp #$FF
    beq RTS_8A99
    ;Prepare to write palette data.
    sta PalDataPending
    inc PalDataIndex
RTS_8A99:
    rts

;The table below is used by above routine to pick the proper palette.

PalSelectTbl:
    .byte $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0C, $FF

FlashIntroScreen:
    ldy ScreenFlashPalIndex         ;Load index into table below.
    lda ScreenFlashPalTbl,y         ;Load palette data byte.
    cmp #$FF                        ;Has the end of the table been reached?-->
    bne L8AB8                       ;If not, branch.
    lda #$00                        ;
    sta ScreenFlashPalIndex         ;Clear screen flash palette index and reset-->
    sta FlashScreen                 ;screen flash control address.
    beq RTS_8ABC                    ;Branch always.
L8AB8:
    sta PalDataPending              ;Store palette change data.
    inc ScreenFlashPalIndex         ;Increment index into table below.
RTS_8ABC:
    rts

ScreenFlashPalTbl:
    .byte $11, $01, $11, $01, $11, $11, $01, $11, $01, $FF

;----------------------------------[ Intro star palette routines ]-----------------------------------

StarPalSwitch:
    ;Change star palette every 16th frame.
    lda FrameCount
    and #$0F
    bne RTS_8AD2
    ;Is any other PPU data waiting? If so, exit.
    lda PPUStrIndex
    beq L8AD3
RTS_8AD2:
    rts

L8AD3:
    lda #$19                        ;
    sta $00                         ;Prepare to write to the sprite palette-->
    lda #$3F                        ;starting at address $3F19.
    sta $01                         ;
    lda IntroStarOffset             ;Use only first 3 bits of byte since the pointer-->
    and #$07                        ;table only has 8 entries.
    asl                             ;*2 to find entry in IntroStarPntr table.
    tay                             ;
    lda IntroStarPntr,y             ;Stores starting address of palette data to write-->
    sta $02                         ;into $02 and $03 from IntroStarPntr table.
    lda IntroStarPntr+1,y           ;
    sta $03                         ;
    inc IntroStarOffset             ;Increment index for next palette change.
    jsr PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.
    lda #$1D                        ;
    sta $00                         ;
    lda #$3F                        ;Prepare another write to the sprite palette.-->
    sta $01                         ;This tie starting at address $3F1D.
    iny                             ;
    jsr AddYToPtr02                 ;($C2B3)Find new data base of palette data.
    jmp PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.

;The following table is a list of pointers into the table below. It contains
;the palette data for the twinkling stars in the intro scene.  The palette data
;is changed every 16 frames by the above routine.

IntroStarPntr:
    .word IntroStarPal0, IntroStarPal1, IntroStarPal2, IntroStarPal3
    .word IntroStarPal4, IntroStarPal5, IntroStarPal6, IntroStarPal7

;The following table contains the platette data that is changed in the intro
;scene to give the stars a twinkling effect. All entries in the table are
;non-repeating.

IntroStarPal0:  .byte $03, $0F, $02, $13, $00, $03, $00, $34, $0F, $00
IntroStarPal1:  .byte $03, $06, $01, $23, $00, $03, $0F, $34, $09, $00
IntroStarPal2:  .byte $03, $16, $0F, $23, $00, $03, $0F, $24, $1A, $00
IntroStarPal3:  .byte $03, $17, $0F, $13, $00, $03, $00, $04, $28, $00
IntroStarPal4:  .byte $03, $17, $01, $14, $00, $03, $10, $0F, $28, $00
IntroStarPal5:  .byte $03, $16, $02, $0F, $00, $03, $30, $0F, $1A, $00
IntroStarPal6:  .byte $03, $06, $12, $0F, $00, $03, $30, $04, $09, $00
IntroStarPal7:  .byte $03, $0F, $12, $14, $00, $03, $10, $24, $0F, $00

;----------------------------------------------------------------------------------------------------

DoFadeOut:
    ;Load palette data from table below.
    ldy FadeDataIndex
    lda FadeOutPalData,y
    ;If palette data = #$FF, exit.
    cmp #$FF
    beq RTS_8B6C
    ;Store new palette data.
    sta PalDataPending
    inc FadeDataIndex
RTS_8B6C:
    rts

FadeOutPalData:
    .byte $0D, $0E, $0F, $10, $01, $FF

FadeInPalData:
    .byte $01, $10, $0F, $0E, $0D, $FF

;----------------------------------------[ Password routines ]---------------------------------------

ProcessUniqueItems:
    ;Store NumberOfUniqueItems at $03.
    lda NumberOfUniqueItems
    sta $03
    ;Set $04 to #$00.
    ldy #$00
    sty $04
    L8B82:
        ;Use $04 at index into unique item list.
        ldy $04
        ;Load the two bytes representing the aquired Unique item and store them in $00 and $01.
        iny
        lda UniqueItemHistory-1,y
        sta $00
        iny
        lda UniqueItemHistory-1,y
        sta $01
        ;Increment $04 by two (load unique item complete).
        sty $04
        ;Find unique item.
        jsr UniqueItemSearch
        ;If all unique items processed, return, else branch to process next unique item.
        ldy $04
        cpy $03
        bcc L8B82
    rts

UniqueItemSearch: ;($8B9C)
    ldx #$00
    L8B9E:
        ; y = x*2
        txa
        asl
        tay
        ;Load unique item reference starting at $9029(2 bytes).
        lda ItemData,y
        cmp $00
        bne L8BAF
            ;Get next byte of unique item.
            lda ItemData+1,y
            cmp $01
            ;If unique item found, branch to UniqueItemFound.
            beq UniqueItemFound
        L8BAF:
        ;If the unique item is a Zebetite, return, else branch to find next unique item.
        inx
        cpx #>ui_ZEBETITE1
        bcc L8B9E
    rts

;The following routine sets the item bits for aquired items in addresses $6988 thru $698E.-->
;Items 1 thru 7 masked in $6988, 8 thru 15 in $6989, etc.

UniqueItemFound:
    txa                             ;
    jsr Adiv8                       ;($C2C0)Divide by 8.
    sta $05                         ;Shifts 5 MSBs to LSBs of item # and saves results in $05.
    jsr Amul8                       ;($C2C6)Multiply by 8.
    sta $02                         ;Restores 5 MSBs of item # and drops 3 LSBs; saves in $02.
    txa                             ;
    sec                             ;
    sbc $02                         ;
    sta $06                         ;Remove 5 MSBs and stores 3 LSBs in $06.
    ldx $05                         ;
    lda PasswordByte,x              ;
    ldy $06                         ;
    ora PasswordBitmaskTbl,y        ;
    sta PasswordByte,x              ;Masks each unique item in the proper item address-->
    rts                             ;(addresses $6988 thru $698E).

LoadUniqueItems:
    lda #$00                        ;
    sta NumberOfUniqueItems         ;
    sta $05                         ;$05 offset of password byte currently processing(0 thru 7).
    sta $06                         ;$06 bit of password byte currently processing(0 thru 7).
    lda #$3B                        ;
    sta $07                         ;Maximum number of unique items(59 or #$3B).
    ldy $05                         ;
    lda PasswordByte,y              ;
    sta $08                         ;$08 stores contents of password byte currently processing.
    ldx #$00                        ;
    stx $09                         ;Stores number of unique items processed(#$0 thru #$3B).
    ldx $06                         ;
    beq ProcessNewItemByte          ;If start of new byte, branch.

    ldx #$01                        ;
    stx $02                         ;
    clc                             ;
    L8BF5:
        ror                             ;
        sta $08                         ;This code does not appear to ever be executed.
        ldx $02                         ;
        cpx $06                         ;
        beq ProcessNewItemByte          ;
        inc $02                         ;
        jmp L8BF5                       ;

ProcessNextItem:
    ldy $05                         ;Locates next password byte to process-->
    lda PasswordByte,y              ;and loads it into $08.
    sta $08                         ;

ProcessNewItemByte:
    lda $08                         ;
    ror                             ;Rotates next bit to be processed to the carry flag.
    sta $08                         ;
    bcc L8C14                       ;
        jsr SamusHasItem            ;($8C39)Store item in unique item history.
    L8C14:
    ldy $06                         ;If last bit of item byte has been-->
    cpy #$07                        ;checked, move to next byte.
    bcs L8C27                       ;
    inc $06                         ;
    inc $09                         ;
    ldx $09                         ;If all 59 unique items have been-->
    cpx $07                         ;searched through, exit.
    bcs RTS_8C38                    ;
    jmp ProcessNewItemByte          ;($8C0A)Repeat routine for next item byte.

L8C27:
    ldy #$00                        ;
    sty $06                         ;
    inc $05                         ;
    inc $09                         ;
    ldx $09                         ;If all 59 unique items have been-->
    cpx $07                         ;searched through, exit.
    bcs RTS_8C38                       ;
    jmp ProcessNextItem             ;($8C03)Process next item.

RTS_8C38:
    rts

SamusHasItem:
    lda $05                         ;$05 becomes the upper part of the item offset-->
    jsr Amul8                       ;while $06 becomes the lower part of the item offset.
    clc                             ;
    adc $06                         ;
    asl                             ;* 2. Each item is two bytes in length.
    tay                             ;
    lda ItemData+1,y                ;
    sta $01                         ;$00 and $01 store the two bytes of-->
    lda ItemData,y                  ;the unique item to process.
    sta $00                         ;
    ldy NumberOfUniqueItems         ;
    sta UniqueItemHistory,y         ;Store the two bytes of the unique item-->
    lda $01                         ;in RAM in the unique item history.
    iny                             ;
    sta UniqueItemHistory,y         ;
    iny                             ;
    sty NumberOfUniqueItems         ;Keeps a running total of unique items.
    rts

CheckPassword:
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
    lda #$18
    sta TitleRoutine
    rts

CalculatePassword:
    lda #$00                        ;
    ldy #$0F                        ;Clears values at addresses -->
    L8C7E:
        sta PasswordByte,y              ;$6988 thru $6997 and -->
        sta PasswordChar,y              ;$699A thru $69A9.
        dey                             ;
        bpl L8C7E                       ;
    jsr ProcessUniqueItems          ;($8B79)Determine what items Samus has collected.
    lda PasswordByte+$07            ;
    and #$04                        ;Check to see if mother brain has been defeated,-->
    beq L8C9E                       ;If so, restore mother brain, zeebetites and-->
        lda #$00                        ;all missile doors in Tourian as punishment for-->
        sta PasswordByte+$07            ;dying after mother brain defeated. Only reset in the-->
        lda PasswordByte+$06            ;password.  Continuing without resetting will not-->
        and #$03                        ;restore those items.
        sta PasswordByte+$06              ;
    L8C9E:
    lda InArea                      ;Store InArea in bits 0 thru 5 in-->
    and #$3F                        ;address $6990.
    ldy JustInBailey                ;
    beq L8CA9                       ;
        ora #$80                        ;Sets MSB of $6990 is Samus is suitless.
    L8CA9:
    sta PasswordByte+$08              ;
    lda SamusGear                   ;
    sta PasswordByte+$09              ;SamusGear stored in $6991.
    lda MissileCount                ;
    sta PasswordByte+$0A              ;MissileCount stored in $6992.
    lda #$00                        ;
    sta $00                         ;
    lda KraidStatueStatus           ;
    and #$80                        ;
    beq L8CC9                       ;If statue not up, branch.
        lda $00                         ;
        ora #$80                        ;Set bit 7 of $00-->
        sta $00                         ;if Kraid statue up.
    L8CC9:
    lda KraidStatueStatus           ;
    and #$01                        ;
    beq L8CD6                       ;Branch if Kraid not yet defeated.
        lda $00                         ;
        ora #$40                        ;Set bit 6 of $00-->
        sta $00                         ;If Kraid defeated.
    L8CD6:
    lda RidleyStatueStatus          ;
    and #$80                        ;
    beq L8CE3                       ;Branch if Ridley statue not up.
        lda $00                         ;
        ora #$20                        ;Set bit 5 of $00-->
        sta $00                         ;if Ridley statue up.
    L8CE3:
    lda RidleyStatueStatus          ;
    and #$02                        ;
    beq L8CF0                       ;Branch if Ridley not yet defeated.
        lda $00                         ;
        ora #$10                        ;Set bit 4 of $00-->
        sta $00                         ;if Ridley defeated.
    L8CF0:
    lda $00                         ;
    sta PasswordByte+$0F              ;Stores statue statuses in 4 MSB at $6997.
    ldy #$03                        ;
    L8CF7:
        lda SamusAge,y                  ;Store SamusAge in $6993,-->
        sta PasswordByte+$0B,y            ;SamusAge+1 in $6994 and-->
        dey                             ;SamusAe+2 in $6995.
        bpl L8CF7                       ;
    L8D00:
        jsr $C000                       ;
        lda RandomNumber1               ;
        and #$0F                        ;Store the value of $2E at $6998-->
        beq L8D00                       ;When any of the 4 LSB are set. (Does not-->
    sta PasswordByte+$10              ;allow RandomNumber1 to be a multiple of 16).
    jsr PasswordChecksumAndScramble ;($8E17)Calculate checksum and scramble password.
    jmp LoadPasswordChar            ;($8E6C)Calculate password characters.

LoadPasswordData:
    lda NARPASSWORD                 ;If invincible Samus active, skip-->
    bne RTS_8D3C                    ;further password processing.
    jsr LoadUniqueItems             ;($8BD4)Load unique items from password.
    jsr LoadTanksAndMissiles        ;($8D3D)Calculate number of missiles from password.
    ldy #$00                        ;
    lda PasswordByte+$08            ;If MSB in PasswordByte08 is set,-->
    and #$80                        ;Samus is not wearing her suit.
    beq L8D27                       ;
        iny                             ;
    L8D27:
    sty JustInBailey                ;
    lda PasswordByte+$08            ;Extract first 5 bits from PasswordByte08-->
    and #$3F                        ;and use it to determine starting area.
    sta InArea                      ;
    ldy #$03                        ;
    L8D33:
        lda PasswordByte+$0B,y          ;Load Samus' age.
        sta SamusAge,y                  ;
        dey                             ;
        bpl L8D33                       ;Loop to load all 3 age bytes.
RTS_8D3C:
    rts

LoadTanksAndMissiles:
    lda PasswordByte+$09            ;Loads Samus gear.
    sta SamusGear                   ;Save Samus gear.
    lda PasswordByte+$0A            ;Loads current number of missiles.
    sta MissileCount                ;Save missile count.
    lda #$00                        ;
    sta $00                         ;
    sta $02                         ;
    lda PasswordByte+$0F            ;
    and #$80                        ;If MSB is set, Kraid statue is up.
    beq L8D5C                       ;
        lda $00                         ;
        ora #$80                        ;If Kraid statue is up, set MSB in $00.
        sta $00                         ;
    L8D5C:
    lda PasswordByte+$0F            ;
    and #$40                        ;If bit 6 is set, Kraid is defeated.
    beq L8D69                       ;
        lda $00                         ;
        ora #$01                        ;If Kraid is defeated, set LSB in $00.
        sta $00                         ;
    L8D69:
    lda $00                         ;
    sta KraidStatueStatus           ;Store Kraid status.
    lda PasswordByte+$0F            ;
    and #$20                        ;If bit 5 is set, Ridley statue is up.
    beq L8D7B                       ;
        lda $02                         ;
        ora #$80                        ;If Ridley statue is up, set MSB in $02.
        sta $02                         ;
    L8D7B:
    lda PasswordByte+$0F            ;
    and #$10                        ;If bit 4 is set, Ridley is defeated.
    beq L8D88                       ;
        lda $02                         ;
        ora #$02                        ;If Ridley is defeated, set bit 1 of $02.
        sta $02                         ;
    L8D88:
    lda $02                         ;
    sta RidleyStatueStatus          ;Store Ridley status.
    lda #$00                        ;
    sta $00                         ;
    sta $02                         ;
    ldy #$00                        ;
L8D95:
    lda UniqueItemHistory+1,y       ;Load second byte of item and compare-->
    and #$FC                        ;the 6 MSBs to #$20. If it matches,-->
    cmp #$20                        ;an energy tank has been found.
    bne L8DA3                       ;
        inc $00                         ;Increment number of energy tanks found.
        jmp IncrementToNextItem         ;
    L8DA3:
    cmp #$24                        ;Load second byte of item and compare the 6 MSBs to-->
    bne IncrementToNextItem         ;#$24. If it matches, missiles have been found.
    inc $02                         ;Increment number of missiles found.

IncrementToNextItem:
    iny                             ;
    iny                             ;Increment twice. Each item is 2 bytes.
    cpy #$84                        ;7 extra item slots in unique item history.
    bcc L8D95                       ;Loop until all unique item history checked.
    lda $00                         ;
    cmp #$06                        ;Ensure the Tank Count does not exceed 6-->
    bcc L8DB7                       ;tanks. Then stores the number of-->
        lda #$06                        ;energy tanks found in TankCount.
    L8DB7:
    sta TankCount                   ;
    lda #$00                        ;
    ldy $02                         ;
    beq L8DC6                       ;Branch if no missiles found.
        clc                             ;
        L8DC1:
            adc #$05                        ;
            dey                             ;For every missile item found, this-->
            bne L8DC1                       ;loop adds 5 missiles to MaxMissiles.
    L8DC6:
    ldy KraidStatueStatus           ;
    beq L8DCF                       ;
        adc #$4B                        ;75 missiles are added to MaxMissiles-->
        bcs L8DD8                       ;if Kraid has been defeated and another-->
L8DCF:
    ldy RidleyStatueStatus          ;75 missiles are added if the ridley-->
    beq L8DDA                       ;has been defeated.
        adc #$4B                        ;
        bcc L8DDA                       ;
    L8DD8:
        lda #$FF                        ;If number of missiles exceeds 255, it stays at 255.
L8DDA:
    sta MaxMissiles
    rts

ValidatePassword:
    ;If invincible Samus already active, branch.
    lda NARPASSWORD
    bne L8DF7
    
    ;Check if NARPASSWORD was entered at the password screen
    ldy #$0F
    L8DE5:
        lda PasswordChar,y
        cmp NARPASSWORDTbl,y
        bne L8DF7
        dey
        bpl L8DE5
    
    ;NARPASSWORD was entered, activate invincible Samus
    lda #$01
    sta NARPASSWORD
    bne L8E05
    
L8DF7:
    ;NARPASSWORD was not entered, continue to process password
    jsr UnscramblePassword          ;($8E4E)Unscramble password.
    jsr PasswordChecksum            ;($8E21)Calculate password checksum.
    cmp PasswordByte+$11            ;Verify proper checksum.
    beq L8E05                       ;
    sec                             ;If password is invalid, sets carry flag.
    bcs RTS_8E06                    ;
L8E05:
    clc                             ;If password is valid, clears carry flag.
RTS_8E06:
    rts

;The table below is used by the code above. It checks to see if NARPASSWORD has been entered.
;NOTE: any characters after the 16th character will be ignored if the first 16 characters
;match the values below.

NARPASSWORDTbl:
    .byte "NARPASSWORD00000"

PasswordChecksumAndScramble:
    jsr PasswordChecksum            ;($8E21)Store the combined added value of-->
    sta PasswordByte+$11            ;addresses $6988 thu $6998 in $6999.
    jsr PasswordScramble            ;($8E2D)Scramble password.
    rts

;Add the values at addresses $6988 thru $6998 together.
PasswordChecksum:
    ldy #$10
    lda #$00
    L8E25:
        clc
        adc PasswordByte,y
        dey
        bpl L8E25
    rts

PasswordScramble:
    lda PasswordByte+$10
    sta $02
    L8E32:
        lda PasswordByte                ;Store contents of $6988 in $00 for-->
        sta $00                         ;further processing after rotation.
        ldx #$00                        ;
        ldy #$0F                        ;
        L8E3B:
            ror PasswordByte,x              ;Rotate right, including carry, all values in-->
            inx                             ;addresses $6988 thru $6997.
            dey                             ;
            bpl L8E3B                       ;
        ror $00                         ;Rotate right $6988 to ensure the LSB-->
        lda $00                         ;from address $6997 is rotated to the-->
        sta PasswordByte                ;MSB of $6988.
        dec $02                         ;
        bne L8E32                       ;Continue rotating until $02 = 0.
    rts

UnscramblePassword:
    lda PasswordByte+$10            ;Stores random number used to scramble the password.
    sta $02                         ;
    L8E53:
        lda PasswordByte+$0F            ;Preserve MSB that may have been rolled from $6988.
        sta $00                         ;
        ldx #$0F                        ;
        L8E5A:
            rol PasswordByte,x              ;The following loop rolls left the first 16 bytes-->
            dex                             ;of the password one time.
            bpl L8E5A                       ;
        rol $00                         ;Rolls byte in $6997 to ensure MSB from $6988 is not lost.
        lda $00                         ;
        sta PasswordByte+$0F            ;
        dec $02                         ;
        bne L8E53                       ;Loop repeats the number of times decided by the random-->
    rts                             ;number in $6998 to properly unscramble the password.

;The following code takes the 18 password bytes and converts them into 24 characters
;to be displayed to the player as the password.  NOTE: the two MSBs will always be 0.

LoadPasswordChar:
    .repeat 6, I
        ;%XXXXXX-- %-------- %--------
        ldy #(I*3+0)
        jsr SixUpperBits
        sta PasswordChar+I*4+0
        ;%------XX %XXXX---- %--------
        ldy #(I*3+0)
        jsr TwoLowerAndFourUpper
        sta PasswordChar+I*4+1
        ;%-------- %----XXXX %XX------
        ldy #(I*3+1)
        jsr FourLowerAndTwoUpper
        sta PasswordChar+I*4+2
        ;%-------- %-------- %--XXXXXX
        ldy #(I*3+2)
        jsr SixLowerBits
        sta PasswordChar+I*4+3
    .endrep
    rts

SixUpperBits: ;($8F2D)
    lda PasswordByte,y              ;Uses six upper bits to create a new byte.-->
    lsr                             ;Bits are right shifted twice and two lower-->
    lsr                             ;bits are discarded.
    rts

TwoLowerAndFourUpper: ;($8F33)
    lda PasswordByte,y              ;
    and #$03                        ;Saves two lower bits and stores them-->
    jsr Amul16                      ;($C2C5)in bits 4 and 5.
    sta $00                         ;
    lda PasswordByte+1,y            ;Saves upper 4 bits and stores them-->
    jsr Adiv16                      ;($C2BF)bits 0, 1, 2 and 3.
    ora $00                         ;Add two sets of bits together to make a byte-->
    rts                             ;where bits 6 and 7 = 0.

FourLowerAndTwoUpper: ;($8F46)
    lda PasswordByte,y              ;
    and #$0F                        ;Keep lower 4 bits.
    asl                             ;Move lower 4 bits to bits 5, 4, 3 and 2.
    asl                             ;
    sta $00                         ;
    lda PasswordByte+1,y            ;Move upper two bits-->
    rol                             ;to bits 1 and 0.
    rol                             ;
    rol                             ;
    and #$03                        ;Add two sets of bits together to make a byte-->
    ora $00                         ;where bits 6 and 7 = 0.
    rts

SixLowerBits: ;($8F5A)
    ;Discard bits 6 and 7.
    lda PasswordByte,y
    and #$3F
    rts

;The following routine converts the 24 user entered password characters into the 18 password
;bytes used by the program to store Samus' stats and unique item history.

ConsolidatePassword:
    .repeat 6, I
        ;%00XXXXXX %00XX---- %00------ %00------
        ldy #(I*4+0)
        jsr SixLowerAndTwoUpper
        sta PasswordByte+I*3+0
        ;%00------ %00--XXXX %00XXXX-- %00------
        ldy #(I*4+1)
        jsr FourLowerAndFiveThruTwo
        sta PasswordByte+I*3+1
        ;%00------ %00------ %00----XX %00XXXXXX
        ldy #(I*4+2)
        jsr TwoLowerAndSixLower
        sta PasswordByte+I*3+2
    .endrep
    rts

SixLowerAndTwoUpper:
    lda PasswordChar,y              ;Remove upper two bits and transfer-->
    asl                             ;lower six bits to upper six bits.
    asl                             ;
    sta $00                         ;
    lda PasswordChar+1,y            ;Move bits 4and 5 to lower two-->
    jsr Adiv16                      ;($C2BF)bits and discard the rest.
    ora $00                         ;Combine the two bytes together.
    rts

FourLowerAndFiveThruTwo:
    lda PasswordChar,y              ;Take four lower bits and transfer-->
    jsr Amul16                      ;($C2C5)them to upper four bits. Discard the rest.
    sta $00                         ;
    lda PasswordChar+1,y            ;Remove two lower bits and transfer-->
    lsr                             ;bits 5 thru 2 to lower four bits.
    lsr                             ;
    ora $00                         ;Combine the two bytes together.
    rts                             ;

TwoLowerAndSixLower:
    lda PasswordChar,y              ;Shifts two lower bits to two higest bits-->
    ror                             ;and discards the rest
    ror                             ;
    ror                             ;
    and #$C0                        ;
    sta $00                         ;
    lda PasswordChar+1,y            ;Add six lower bits to previous results.
    ora $00                         ;
    rts

PasswordBitmaskTbl:
    .byte $01, $02, $04, $08, $10, $20, $40, $80

;The following table contains the unique items in the game.  The two bytes can be deciphered
;as follows:IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
;on world map. See constants.asm for values of IIIIII.

ItemData: ; $9029
    .word ui_MARUMARI    + ($02 << 5) + $0E  ;Maru Mari at coord 02,0E                    (Item 0)
    .word ui_MISSILES    + ($12 << 5) + $0B  ;Missiles at coord 12,0B                     (Item 1)
    .word ui_MISSILEDOOR + ($07 << 5) + $05  ;Red door to long beam at coord 07,05        (Item 2)
    .word ui_MISSILEDOOR + ($04 << 5) + $02  ;Red door to Tourian elevator at coord 05,02 (Item 3)
    .word ui_ENERGYTANK  + ($19 << 5) + $07  ;Energy tank at coord 19,07                  (Item 4)
    .word ui_MISSILEDOOR + ($19 << 5) + $05  ;Red door to bombs at coord 1A,05            (Item 5)
    .word ui_BOMBS       + ($19 << 5) + $05  ;Bombs at coord 19,05                        (Item 6)
    .word ui_MISSILEDOOR + ($13 << 5) + $09  ;Red door to ice beam at coord 13,09         (Item 7)
    .word ui_MISSILES    + ($18 << 5) + $03  ;Missiles at coord 18,03                     (Item 8)
    .word ui_ENERGYTANK  + ($1B << 5) + $03  ;Energy tank at coord 1B,03                  (Item 9)
    .word ui_MISSILEDOOR + ($0F << 5) + $02  ;Red door to varia suit at coord 0F,02       (Item 10)
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
    .word ui_HIGHJUMP    + ($1B << 5) + $11  ;High jump at coord 1B,11                    (Item 24)
    .word ui_MISSILEDOOR + ($0F << 5) + $10  ;Red door to screw attack at coord 0E,10     (Item 25)
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
    .word ui_MISSILEDOOR + ($10 << 5) + $1D  ;purple door at coord 10,1D(Ridley's room)   (Item 47)
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
    .word ui_MOTHERBRAIN                     ;Mother brain                                (Item 58)

ClearAll:
    jsr ScreenOff                   ;($C439)Turn screen off.
    jsr ClearNameTables             ;Turn off screen, clear sprites and name tables.
    jsr EraseAllSprites             ;
    lda PPUCTRL_ZP                  ;Set Name table address to $2000.
    and #$FC                        ;
    sta PPUCTRL_ZP                  ;
    lda #$00                        ;
    sta ScrollY                     ;Reset scroll offsets.
    sta ScrollX                     ;
    jsr WaitNMIPass                 ;($C42C)Wait for NMI to end.
    jmp VBOffAndHorzWrite           ;($C47D)Set PPU for horizontal write and turn off VBlank.

StartContinueScreen:
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #.lobyte(L9984)                        ;Low address for PPU write.
    ldy #.hibyte(L9984)                        ;High address for PPU write.
    jsr PreparePPUProcess           ;($9449)Clears screen and writes "START CONTINUE".
    ldy #$00                        ;
    sty StartContinue               ;Set selection sprite at START.
    lda #$0D                        ;
    sta PalDataPending              ;Change palette and title routine.
    lda #$16                        ;Next routine is ChooseStartContinue.
    sta TitleRoutine                ;

TurnOnDisplay:
    jsr NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    jmp ScreenOn                    ;($C447)Turn screen on.

ChooseStartContinue:
    lda Joy1Change                  ;
    and #$30                        ;Checks both select and start buttons.
    cmp #$10                        ;Check if START has been pressed.
    bne L90EB                       ;Branch if START not pressed.
    ldy StartContinue               ;
    bne L90E7                       ;if CONTINUE selected, branch.
    jmp InitializeStats             ;($932B)Zero out all stats.
L90E7:
    ldy #$17                        ;Next routine is LoadPasswordScreen.
    sty TitleRoutine                ;
L90EB:
    cmp #$20                        ;check if SELECT has been pressed.
    bne L90FF                       ;Branch if SELECT not pressed.
    lda StartContinue               ;
    eor #$01                        ;Chooses between START and CONTINUE-->
    sta StartContinue               ;on game select screen.
    lda TriSFXFlag                  ;
    ora #sfxTri_Beep                ;Set SFX flag for select being pressed.-->
    sta TriSFXFlag                  ;Uses triangle channel.
L90FF:
    ldy StartContinue               ;
    lda StartContTbl,y              ;Get y pos of selection sprite.
    sta SpriteRAM                   ;
    lda #$6E                        ;Load sprite info for square selection sprite.
    sta SpriteRAM+1                 ;
    lda #$03                        ;
    sta SpriteRAM+2                 ;
    lda #$50                        ;Set data for selection sprite.
    sta SpriteRAM+3                 ;
    rts

StartContTbl:
    .byte $60                       ;Y sprite position for START.
    .byte $78                       ;Y sprite position for CONTINUE.

LoadPasswordScreen:
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #.lobyte(L99E3)             ;Loads PPU with info to display-->
    ldy #.hibyte(L99E3)             ;PASS WORD PLEASE.
    jsr PreparePPUProcess           ;($9449)Load "PASSWORD PLEASE" on screen.
    jsr InitGFX7                    ;($C6D6)Loads the font for the password.
    jsr DisplayInputCharacters      ;($940B)Write password character to screen.
    lda #$13                        ;
    sta PalDataPending              ;Change palette.
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

EnterPassword:
    ;($C1A3)Remove sprites from screen.
    jsr EraseAllSprites
    
    ;Check to see if START has been pressed.
    lda Joy1Change
    and #$10
    ;If not, branch.
    beq L9153
        ;($8C5E)Check if password is correct.
        jmp CheckPassword
    L9153:
    
    ;Prepare to write the password screen data to PPU.
    ldx #$01
    stx PPUDataPending
    ldx PPUStrIndex
    
    ;Upper byte of PPU string.
    lda #$21
    jsr WritePPUByte
    ;Lower byte of PPU string.
    lda #$A8
    jsr WritePPUByte
    ;PPU string length.
    lda #$0F
    jsr WritePPUByte
    
    lda Timer3
    beq L9178
        ;Writes 'ERROR TRY AGAIN' on the screen if Timer3 is anything but #$00.
        lda #.lobyte(L8759)
        sta $02
        lda #.hibyte(L8759)
        sta $03
        jmp L9180
    L9178:
        ;Writes the blank lines that cover the message 'ERROR TRY AGAIN'.
        lda #.lobyte(L8768)
        sta $02
        lda #.hibyte(L8768)
        sta $03
    L9180:
    ; loop to write all the bytes from those strings to ppu string buffer
    ldy #$00
    L9182:
        lda ($02),y
        jsr WritePPUByte
        iny
        cpy #$0F
        bne L9182
    
    ;If button A pressed, branch.
    lda Joy1Change
    bmi L9193
        ;($91FB)Check if backspace pressed.
        jmp CheckBackspace
    L9193:
    
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

LoadRowAndColumn: ;($91BF)
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

CheckBackspace:
    lda Joy1Change                  ;
    and #$40                        ;If button B (backspace) has not-->
    beq L920E                       ;been pressed, branch.
        lda PasswordCursor              ;
        sec                             ;Subtract 1 from PasswordCursor.  If-->
        sbc #$01                        ;PasswordCursor is negative, load-->
        bcs L920B                       ;PasswordCursor with #$17 (last character).
            lda #$17                        ;
        L920B:
        sta PasswordCursor              ;
    L920E:
    ldy PasswordStat00              ;Appears to have no function.
    lda FrameCount                  ;
    and #$08                        ;If FrameCount bit 3 not set, branch.
    beq L923F                       ;
        lda #$3F                        ;
        ldx PasswordCursor              ;Load A with #$3F if PasswordCursor is on-->
        cpx #$0C                        ;character 0 thru 11, else load it with #$4F.
        bcc L9222                       ;
            lda #$4F                        ;
        L9222:
        sta SpriteRAM+$01<<2            ;Set Y-coord of password cursor sprite.
        lda #$6E                        ;
        sta SpriteRAM+$01<<2+1          ;Set pattern for password cursor sprite.
        lda #$20                        ;
        sta SpriteRAM+$01<<2+2          ;Set attributes for password cursor sprite.
        lda PasswordCursor              ;If the password cursor is at the 12th-->
        cmp #$0C                        ;character or less, branch.
        bcc L9238                       ;
            sbc #$0C                        ;Calculate how many characters the password cursor-->
        L9238:
        tax                             ;is from the left if on the second row of password.
        lda CursorPosTbl,x              ;Load X position of PasswordCursor.
        sta SpriteRAM+$01<<2+3          ;
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
    lda FrameCount                  ;
    and #$08                        ;If FrameCount bit 3 not set, branch.
    beq RTS_92B3                    ;
        lda CharSelectYTbl,x            ;Set Y-coord of character selection sprite.
        sta SpriteRAM+$02<<2            ;
        lda #$6E                        ;Set pattern for character selection sprite.
        sta SpriteRAM+$02<<2+1          ;
        lda #$20                        ;Set attributes for character selection sprite.
        sta SpriteRAM+$02<<2+2          ;
        lda CharSelectXTbl,y            ;Set x-Coord of character selection sprite.
        sta SpriteRAM+$02<<2+3          ;
    RTS_92B3:
    rts                             ;

;The following data does not appear to be used in the program.
    .byte $21, $20

;The following table is used to determine the proper Y position of the character
;selection sprite on password entry screen.

CharSelectYTbl:
    .byte $77, $87, $97, $A7, $B7

;The following table is used to determine the proper X position of the character
;selection sprite on password entry screen.

CharSelectXTbl:
    .byte $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0

;When the PasswordCursor is on the second row of the password, the following table is used
;to determine the proper x position of the password cursor sprite(password characters 12-23).

CursorPosTbl:
    .byte $48, $50, $58, $60, $68, $70, $80, $88, $90, $98, $A0, $A8

InitializeGame:
    jsr ClearRAM_33_DF              ;($C1D4)Clear RAM.
    jsr ClearSamusStats             ;($C578)Reset Samus stats for a new game.
    jsr LoadPasswordData            ;($8D12)Load data from password.
    ldy #$00                        ;
    sty SpritePagePos               ;
    sty PageIndex                   ;Clear object data.
    sty ObjectCntrl                 ;
    sty ObjHi                       ;
    jsr SilenceMusic                ;($CB8E)Turn off music.
    lda #$5A                        ;
    sta ObjAnimFrame                ;Set animframe index. changed by initializing routines.
    ldx #$01                        ;x is the index into the position tables below.
    lda InArea                      ;Load starting area.
    and #$0F                        ;
    bne L92F9                       ;If in area other than Brinstar, get second item in tables.
        dex                             ;Starting in Brinstar. Get first item in each table.
    L92F9:
    
    ;Set Samus restart position on screen.
    lda RestartYPosTbl,x
    sta ObjY
    lda RestartXPosTbl,x
    sta ObjX
    
    ;SamusStat0B's low and high bytes keep track of how many times Samus has-->
    ;died or beaten the game as they are incremented every time this routine-->
    ;is run, but they are not accessed anywhere else.
    inc SamusStat0B
    bne L930D
        inc SamusStat0B+1
    L930D:
    
    lda #$01                        ;
    sta MainRoutine                 ;Initialize starting area.
    jsr ScreenNmiOff                ;($C45D)Turn off screen.
    jsr LoadSamusGFX                ;($C5DC)Load Samus GFX into pattern table.
    jsr NMIOn                       ;($C487)Turn on the non-maskable interrupt.
    lda InArea                      ;Load area Samus is to start in.
    and #$0F                        ;
    tay                             ;
    lda BankTable,y                 ;Change to proper memory page.
    sta SwitchPending               ;
RTS_9324:
    rts

;The following two tables are used to find Samus y and x positions on the screen after the game
;restarts.  The third entry in each table are not used.

RestartYPosTbl:
    .byte $64                       ;Brinstar
    .byte $8C                       ;All other areas.
    .byte $5C                       ;Not used.

RestartXPosTbl:
    .byte $78                       ;Brinstar
    .byte $78                       ;All other areas.
    .byte $5C                       ;Not used.

InitializeStats:
    ;Set all of Samus' stats to 0 when starting new game.
    lda #$00
    sta SamusStat00
    sta TankCount
    sta SamusGear
    sta MissileCount
    sta MaxMissiles
    sta KraidStatueStatus
    sta RidleyStatueStatus
    sta SamusAge
    sta SamusAge+1
    sta SamusAge+2
    sta SamusStat0A
    sta AtEnding
    sta JustInBailey
    ;Prepare to switch to Brinstar memory page.
    lda #$02
    sta SwitchPending
    rts

DisplayPassword:
    lda Timer3                      ;Wait for "GAME OVER" to be displayed-->
    bne RTS_9324                    ;for 160 frames (2.6 seconds).
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #.lobyte(L937F)             ;Low byte of start of PPU data.
    ldy #.hibyte(L937F)             ;High byte of start of PPU data.
    jsr PreparePPUProcess           ;($9449)Clears screen and writes "PASS WORD".
    jsr InitGFX7                    ;($C6D6)Loads the font for the password.
    jsr CalculatePassword           ;($8C7A)Calculates the password.
    jsr NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    jsr PasswordToScreen            ;($93C6)Displays password on screen.
    jsr WaitNMIPass                 ;($C42C)Wait for NMI to end.
    lda #$13                        ;
    sta PalDataPending              ;Change palette.
    inc TitleRoutine                ;
    jmp ScreenOn                    ;($C447)Turn screen on.

L937F:
    ;Information below is for above routine to display "PASS WORD" on the screen.
    PPUString $214B, "PASS WORD"

    ;Information to be stored in attribute table 0.
    PPUStringRepeat $23D0, $00, $08

    ;Turn color on to display password characters.
    PPUStringRepeat $23D8, $55, $20

    .byte $00                       ;End PPU string write.

WaitForSTART:
    lda Joy1Change                  ;Waits for START to be ressed proceed-->
    and #$10                        ;past the GAME OVER screen.
    beq RTS_939D                       ;If start not pressed, branch.
        jmp CheckPassword               ;($8C5E)Check if password is correct.

    RTS_939D:
    rts

GameOver:
    jsr ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    ldx #.lobyte(L93B9)             ;Low byte of start of PPU data.
    ldy #.hibyte(L93B9)             ;High byte of start of PPU data.
    jsr PreparePPUProcess           ;($9449)Clears screen and writes "GAME OVER".
    jsr InitGFX7                    ;($C6D6)Loads the font for the password.
    jsr NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    lda #$10                        ;Load Timer3 with a delay of 160 frames-->
    sta Timer3                      ;(2.6 seconds) for displaying "GAME OVER".
    lda #$19                        ;Loads TitleRoutine with -->
    sta TitleRoutine                ;DisplayPassword.
    jmp ScreenOn                    ;($C447)Turn screen on.

L93B9:
    ;Information below is for above routine to display "GAME OVER" on the screen.
    PPUString $218C, "GAME OVER"

    .byte $00                       ;End PPU string write.


PasswordToScreen:
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


LoadPasswordTiles:
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

DisplayInputCharacters:
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
PasswordRowsTbl:
    .byte $21, $E4                  ;
    .byte $22, $24                  ;The two entries in each row are the upper and lower address-->
    .byte $22, $64                  ;bytes to start writing to the name table, respectively.
    .byte $22, $A4                  ;
    .byte $22, $E4                  ;


PreparePPUProcess:
    stx $00                         ;Lower byte of pointer to PPU string
    sty $01                         ;Upper byte of pointer to PPU string
    jmp ProcessPPUString            ;($C30C)

PrepareEraseTiles:
    stx $00                         ;PPU low address byte
    sty $01                         ;PPU high address byte
    
    ;Address of byte where tile size of tile to be erased is stored.
    ldx #<TileSize
    ldy #>TileSize
    stx $02
    sty $03
    jmp EraseTile                   ;($C328)Erase the selected tiles.

;---------------------------------------[ Unused intro routines ]------------------------------------

;The following routines are intro routines that are not used in this version of the game.  It
;appears that the intro routine was originally going to be more complex with a more advanced
;sprite control mechanism and name table writing routines. The intro routines are a mess! In
;addition to unused routines, there are several unused memory addresses that are written to but
;never read.

UnusedIntroRoutine4:
    stx PPUStrIndex                 ;
    lda #$00                        ;
    sta PPUDataString,x             ;The following unused routine writes something to the-->
    lda #$01                        ;PPU string and prepares for a PPU write.
    sta PPUDataPending              ;
    rts                             ;


;Unused intro routine. It looks like originally the-->
;title routines were going to write data to the name-->
;tables in the middle of the title sequences.
UnusedIntroRoutine5:
    sta $05
    and #$F0
    lsr
    lsr
    lsr
    lsr
    jsr L947B
        lda $05
        and #$0F
    L947B:
    sta PPUDataString,x
    inx
    txa
    cmp #$55
    bcc RTS_948E
    ldx PPUStrIndex
    L9487:
        lda #$00 
        sta PPUDataString,x
        beq L9487
RTS_948E:
    rts

;Another unused intro routine.
UnusedIntroRoutine6:
    tya
    pha
    jsr Amul16 ;($C2C5)Multiply by 16.
    tay
    lda $684B,y
    sta $0B
    lda $684A,y
    sta $0A
    jsr UnusedIntroRoutine8 ;($94DA)
    lda $06
    sta $683D,x
    lda $07
    sta $683C,x
    pla
    tay
    rts

;Another unused intro routine.
UnusedIntroRoutine7:
    tya
    pha
    jsr Amul16 ;($C2C5)Multiply by 16.
    tay
    lda $684D,y
    sta $0B
    lda $684C,y
    sta $0A
    jsr UnusedIntroRoutine8 ;($94DA)
    lda $06
    sta $6834,x
    lda $07
    sta $6833,x
    lda $6842,y
    pha
    txa
    lsr
    tay
    pla
    sta $6839,y
    pla
    tay
    rts

;Unused intro routine. Looks like the intro routines may-->
;have had more complicated sprite control routines-->
;than it does now.
UnusedIntroRoutine8:
    lda #$FF                        ;
    sta $01                         ;
    sta $02                         ;
    sta $03                         ;
    sec                             ;
    L94E3:
        lda $0A                         ;
        sbc #$E8                        ;
        sta $0A                         ;
        lda $0B                         ;
        sbc #$03                        ;
        sta $0B                         ;
        inc $03                         ;
        bcs L94E3                       ;
    lda $0A                         ;
    adc #$E8                        ;
    sta $0A                         ;
    lda $0B                         ;
    adc #$03                        ;
    sta $0B                         ;
    lda $0A                         ;
    L9501:
        sec
        L9502:
            sbc #$64                        
            inc $02                         
            bcs L9502                       ;
        dec $0B                         ;
        bpl L9501                       ;
    adc #$64                        ;
    sec                             ;
    L950F:
        sbc #$0A                        ;
        inc $01                         ;
        bcs L950F                       ;
    adc #$0A                        ;
    sta $06                         ;
    lda $01                         ;
    jsr Amul16 ;($C2C5)Multiply by 16.
    ora $06                         ;
    sta $06                         ;
    lda $03                         ;
    jsr Amul16 ;($C2C5)Multiply by 16.
    ora $02                         ;
    sta $07                         ;
    rts                             ;

;Not used.
    .byte $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00

;--------------------------------------[ Palette data ]---------------------------------------------

;The following table points to the palette data
;used in the intro and ending portions of the game.

PalPntrTbl:
    .word Palette00                 ;($9586)
    .word Palette01                 ;($95AA)
    .word Palette02                 ;($95CE)
    .word Palette03                 ;($95F2)
    .word Palette04                 ;($9616)
    .word Palette05                 ;($963A)
    .word Palette06                 ;($965E)
    .word Palette07                 ;($9682)
    .word Palette08                 ;($96A6)
    .word Palette09                 ;($96CA)
    .word Palette0A                 ;($96EE)
    .word Palette0B                 ;($9712)
    .word Palette0C                 ;($9736)
    .word Palette0D                 ;($975A)
    .word Palette0E                 ;($977E)
    .word Palette0F                 ;($97A2)
    .word Palette10                 ;($97C6)
    .word Palette11                 ;($97EA)
    .word Palette12                 ;($97F2)

Palette00:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette01 info.

Palette01:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $35, $35, $04, $0F, $35, $14, $04, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette02 info.

Palette02:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $39, $39, $09, $0F, $39, $29, $09, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette03 info.

Palette03:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $36, $36, $06, $0F, $36, $15, $06, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette04 info.

Palette04:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $27, $27, $12, $0F, $27, $21, $12, $0F, $16, $1A, $27, $0F, $31, $20, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette05 info.

Palette05:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette06 info.

Palette06:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $01, $0F, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette07 info.

Palette07:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $02, $01, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette08 info.

Palette08:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $01, $01, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette09 info.

Palette09:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $02, $0F, $12, $12, $02, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette0A info.

Palette0A:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $11, $11, $02, $0F, $11, $02, $02, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette0B info.

Palette0B:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $31, $31, $01, $0F, $31, $11, $01, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette0C info.

Palette0C:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $12, $30, $21, $0F, $27, $28, $29, $0F, $31, $31, $01, $0F, $16, $2A, $27, $0F, $12, $30, $21, $0F, $27, $24, $2C, $0F, $15, $21, $38}

    .byte $00                       ;End Palette0D info.

Palette0D:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $01, $0F, $12, $02, $01, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette0E info.

Palette0E:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $0F, $0F, $02, $01, $0F, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette0F info.

Palette0F:
    PPUString $3F00, {$0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F, $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12}

    .byte $00                       ;End Palette10 info.

Palette10:
    PPUString $3F00, {$30, $28, $18, $08, $30, $29, $1B, $1A, $30, $30, $30, $30, $30, $30, $30, $30, $30, $16, $1A, $27, $30, $37, $3A, $1B, $30, $17, $31, $37, $30, $32, $22, $12}

    .byte $00                       ;End Palette11 info.

Palette11:
    PPUString $3F00, {$0F, $30, $30, $21}

    .byte $00                       ;End Palette12 info.

Palette12:
    PPUString $3F00, {$0F, $30, $30, $0F, $0F, $2A, $2A, $21, $0F, $31, $31, $0F, $0F, $2A, $2A, $21}

    .byte $00                       ;End Palette13 data.

EndGamePal0B:
    PPUString $3F00, {$0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C}

EndGamePal0C:
    PPUStringRepeat $3F10, $0F, $10

    .byte $00                       ;End EndGamePal0C data.

UpdateCrossMissileCoords: ;($981E)
    lda IntroSprXRun,x             ;Load sprite run(sprite x component).
    jsr CalcDisplacement            ;($9871)Calculate sprite displacement in x direction.
    ldy IntroSprXDir,x             ;Get byte describing if sprite increasing or decreasing pos.
    bpl L982E                       ;
        eor #$FF                        ;If MSB is set, sprite is decreasing position. convert-->
        clc                             ;value in A (result from CalcDisplacement) to twos complement.
        adc #$01                        ;
    L982E:
    clc                             ;
    adc IntroSprXCoord,x           ;Add change to sprite x coord.
    sta IntroSprXCoord,x           ;
    sec                             ;
    sbc IntroSprXChange,x          ;Subtract total sprite movemnt value from current sprite x pos.
    php                             ;Transfer processor status to A.
    pla                             ;
    eor IntroSprXDir,x             ;Eor carry bit with direction byte to see if sprite has-->
    lsr                             ;reached its end point.
    bcc L9864                       ;Branch if sprite has reached the end of x movement.
        lda IntroSprYRise,x            ;Load sprite rise(sprite y component).
        jsr CalcDisplacement            ;($9871)Calculate sprite displacement in y direction.
        ldy IntroSprYDir,x             ;Get byte describing if sprite increasing or decreasing pos.
        bpl L9851                       ;
            eor #$FF                        ;If MSB is set, sprite is decreasing position. convert-->
            clc                             ;value in A (result from CalcDisplacement) to twos complement.
            adc #$01                        ;
        L9851:
        clc                             ;
        adc IntroSprYCoord,x           ;Add change to sprite y coord.
        sta IntroSprYCoord,x           ;
        sec                             ;
        sbc IntroSprYChange,x          ;Subtract total sprite movemnt value from current sprite y pos.
        php                             ;Transfer processor status to A.
        pla                             ;
        eor IntroSprYDir,x             ;Eor carry bit with direction byte to see if sprite has-->
        lsr                             ;reached its end point.
        bcs RTS_9870                       ;Branch if sprite has not reached the end of y movement.
    L9864:
        lda IntroSprYChange,x          ;After sprite has reached its final position, this code-->
        sta IntroSprYCoord,x           ;explicitly writes final the x and y coords to to sprite-->
        lda IntroSprXChange,x          ;position addresses to make sure the sprites don't-->
        sta IntroSprXCoord,x           ;overshoot their mark.
    RTS_9870:
    rts                             ;

CalcDisplacement:
    sta $04                         ;
    lda #$08                        ;Time division. The higher the number, the slower the sprite.
    sta $00                         ;
    L9877:
        lsr $04                         ;
        bcc L9883                       ;
        lda FrameCount                  ;
        and $00                         ;Calculate the change in the sprite position by taking the-->
        bne L9883                       ;value in a and dividing it by the time division. The time-->
        inc $04                         ;time division in this case is #$08.
    L9883:
        lsr $00                         ;
        bne L9877                       ;
    lda $04                         ;
    rts                             ;Return A/time.

;This function decrements the y coordinate of the 40 intro star sprites.

DecSpriteYCoord:
    lda TitleRoutine                ;
    cmp #$1D                        ;
    bcs RTS_98AD                       ;If the end game is playing, branch to exit.
    lda SpriteLoadPending           ;
    beq RTS_98AD                       ;If no sprite load is pending, branch to exit.
    lda FrameCount                  ;
    lsr                             ;
    bcs RTS_98AD                       ;If not on an odd numbered frame, branch to exit.
    ldx #$9F                        ;
    L989B:
        dec IntroStarSprite,x         ;Decrement y coord of the intro star sprites.
        dec SpriteRAM+$18<<2,x               ;Decrement y coord of 40 sprites.
        dex                             ;
        dex                             ;
        dex                             ;Move to next sprite.
        dex                             ;
        cpx #$FF                        ;
        bne L989B                       ;Loop 40 times.
    lda #$00                        ;
    sta SpriteLoadPending           ;Sprite RAM load complete.
RTS_98AD:
    rts                             ;

LoadStarSprites:
    ldy #$9F                        ;
L98B0:
    lda IntroStarSprite,y         ;
    sta SpriteRAM+$18<<2,y               ;Store RAM contents of $6E00 thru $6E9F -->
    dey                             ;in sprite RAM at locations $0260 thru $02FF.
    cpy #$FF                        ;
    bne L98B0                       ;
    lda #$00                        ;
    sta SpriteLoadPending           ;Set $C8 to #$00.
    rts                             ;

;The following values are loaded into RAM $6E00 thru $6E9F in InitBank0
;routine.  These values are then loaded into sprite RAM at $0260 thru $02FF
;in above routine.  They are the stars in the title screen.

IntroStarsData:
    .byte $73, $CC, $22, $F2, $48, $CD, $63, $EE, $2A, $CE, $A2, $DC, $36, $CF, $E2, $C6
    .byte $11, $CC, $23, $B7, $53, $CD, $63, $A0, $BB, $CE, $A2, $9A, $0F, $CF, $E2, $8B
    .byte $85, $CC, $E2, $70, $9D, $CD, $A3, $6B, $A0, $CE, $63, $58, $63, $CF, $23, $4F
    .byte $0A, $CC, $22, $39, $1F, $CD, $23, $2A, $7F, $CE, $A3, $1F, $56, $CF, $A2, $03
    .byte $4D, $CC, $E3, $AF, $3E, $CD, $63, $2B, $61, $CE, $E2, $4F, $29, $CF, $62, $6F
    .byte $8A, $CC, $23, $82, $98, $CD, $A3, $07, $AE, $CE, $E2, $CA, $B6, $CF, $63, $E3
    .byte $0F, $CC, $62, $18, $1F, $CD, $22, $38, $22, $CE, $A3, $5F, $53, $CF, $E2, $78
    .byte $48, $CC, $E3, $94, $37, $CD, $A3, $B3, $6F, $CE, $A3, $DC, $78, $CF, $22, $FE
    .byte $83, $CC, $62, $0B, $9F, $CD, $23, $26, $A0, $CE, $62, $39, $BD, $CF, $A2, $1C
    .byte $07, $CC, $E3, $A4, $87, $CD, $63, $5D, $5A, $CE, $62, $4F, $38, $CF, $23, $85

;Not used.
    .byte $3F, $00, $20, $02, $20, $1B, $3A, $02, $20, $21, $01, $02, $2C, $30, $27, $02
    .byte $26, $31, $17, $02, $16, $19, $27, $02, $16, $20, $27, $02, $16, $20, $11, $02
    .byte $01, $20, $21, $00

L9984:
    PPUString $218C, "START"

    PPUString $21EC, "CONTINUE"

    .byte $00               ;End PPU string write

;The following pointer table is used to find the start
;of each row on the password screen in the data below.

PasswordRowTbl:
    .word PasswordRow0              ;($99A2)
    .word PasswordRow1              ;($99AF)
    .word PasswordRow2              ;($99BC)
    .word PasswordRow3              ;($99C9)
    .word PasswordRow4              ;($99D6)

;The following data is used to load the name table With the password characters:
PasswordRow0: .byte "0123456789ABC"
PasswordRow1: .byte "DEFGHIJKLMNOP"
PasswordRow2: .byte "QRSTUVWXYZabc"
PasswordRow3: .byte "defghijklmnop"
PasswordRow4: .byte "qrstuvwxyz?- "

;Writes 'PASSWORD PLEASE' on name table 0 in row $2080 (5th row from top).
L99E3:
    PPUString $2088, "PASS WORD PLEASE"

    ;Clears attribute table 0 starting at address $23C0.
    PPUStringRepeat $23C0, $00, $10

    ;Writes to attribute table 0 starting at address $23D0.
    PPUStringRepeat $23D0, $55, $08

    ;Writes to attribute table 0 starting at address $23D8.
    PPUStringRepeat $23D8, $FF, $20

    ;Writes to attribute table 0 starting at address $23DA.
    PPUStringRepeat $23DA, $F0, $04

    .byte $00                       ;End PPU string write.

;----------------------------------------[ Ending routines ]-----------------------------------------

;The following routine is accessed via the NMI routine every frame.
NMIScreenWrite:
    lda TitleRoutine                ;
    cmp #$1D                        ;If titleRoutine not at end game, exit.
    bcc Exit100                     ;
    jsr LoadCredits                 ;($9C45)Display end credits on screen.
    lda EndMsgWrite                 ;
    beq L9A24                       ;If not time to write end message, branch
    cmp #$05                        ;
    bcs L9A24                       ;If end message is finished being written, branch
    asl                             ;
    tay                             ;
    ldx EndMessageStringTbl0-2,y    ;Writes the end message on name table 0
    lda EndMessageStringTbl0-1,y    ;
    tay                             ;
    jsr PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
L9A24:
    lda HideShowEndMsg              ;
    beq Exit100                     ;If not time to erase end message, branch
    cmp #$05                        ;
    bcs Exit100                     ;If end message is finished being erased, branch
    asl                             ;
    tay                             ;
    ldx EndMessageStringTbl1-2,y    ;Erases the end message on name table 0
    lda EndMessageStringTbl1-1,y    ;
    tay                             ;
    jmp PreparePPUProcess_          ;($C20E)Prepare to write to PPU.

Exit100:
    rts                             ;Exit from above and below routines.

Restart:
    lda Joy1Status                  ;
    and #$10                        ;If start has not been pressed, branch to exit.
    beq Exit100                     ;
    ldy #$11                        ;
    lda #$00                        ;
    L9A43:
        sta PasswordByte,y            ;Erase PasswordByte00 thru PasswordByte11.
        dey                             ;
        bpl L9A43                       ;
    iny                             ;Y = #$00.
    L9A4A:
        sta UniqueItemHistory,y         ;
        iny                             ;Erase Unique item history.
        bne L9A4A                       ;
    
    lda SamusGear
    and #gr_MARUMARI
    beq L9A5C                       ;If Samus does not have Maru Mari, branch.-->
        lda #$01                        ;Else load Maru Mari data into PasswordByte00.
        sta PasswordByte              ;
    L9A5C:
    
    lda SamusGear
    and #gr_BOMBS
    beq L9A6B                       ;If Samus does not have bombs, branch.-->
        lda PasswordByte              ;Else load bomb data into PasswordByte00.
        ora #$40                        ;
        sta PasswordByte              ;
    L9A6B:
    
    lda SamusGear
    and #gr_VARIA
    beq L9A77                       ;If Samus does not have varia suit, branch.-->
        lda #$08                        ;Else load varia suit data into PasswordByte01.
        sta PasswordByte+$01              ;
    L9A77:
    
    lda SamusGear
    and #gr_HIGHJUMP
    beq L9A83                       ;If Samus does not have high jump, branch.-->
        lda #$01                        ;Else load high jump data into PasswordByte03.
        sta PasswordByte+$03              ;
    L9A83:
    
    lda SamusGear                   ;
    and #gr_MARUMARI                        ;If Samus does not have Maru Mari, branch.-->
    beq L9A92                       ;Else load screw attack data into PasswordByte03.-->
        lda PasswordByte+$03              ;A programmer error?  Should check for screw-->
        ora #$04                        ;attack data.
        sta PasswordByte+$03              ;
    L9A92:
    
    lda SamusGear                   ;
    sta PasswordByte+$09              ;Store Samus gear data in PasswordByte09.
    lda #$00                        ;
    ldy JustInBailey                ;
    beq L9AA1                       ;If Samus is wearing suit, branch.  Else-->
        lda #$80                        ;load suitless Samus data into PasswordByte08.
    L9AA1:
    sta PasswordByte+$08              ;
    
    jmp InitializeGame              ;($92D4)Clear RAM to restart game at beginning.

EndGame:
    jsr LoadEndStarSprites          ;($9EAA)Load stars in end scene onto screen.
    lda IsCredits                   ;Skips palette change when rolling credits.
    bne L9AC0                       ;
    lda FrameCount                  ;
    and #$0F                        ;Changes star palettes every 16th frame.
    bne L9AC0                       ;
    inc PalDataPending              ;
    lda PalDataPending              ;Reset palette data to #$01 after it-->
    cmp #$09                        ;reaches #$09.
    bne L9AC0                       ;
    lda #$01                        ;
    sta PalDataPending              ;
L9AC0:
    lda RoomPtr                     ;RoomPtr used in end of game to determine-->
    jsr ChooseRoutine               ;($C27C)which subroutine to run below.
        .word LoadEndGFX                ;($9AD5)Load end GFX to pattern tables.
        .word ShowEndSamus              ;($9B1C)Show Samus and end message.
        .word EndSamusFlash             ;($9B34)Samus flashes and changes.
        .word SamusWave                 ;($9B93)Samus waving in ending if suitless.
        .word EndFadeOut                ;($9BCD)Fade out Samus in ending.
        .word RollCredits               ;($9BFC)Rolls ending credits.
        .word Restart                   ;($9A39)Starts at beginning after game completed.
        .word ExitSub                   ;($C45C)Rts.

LoadEndGFX:
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
    ldx #.lobyte(LA052)                        ;Loads the screen where Samus stands on-->
    ldy #.hibyte(LA052)                        ;the surface of the planet in end of game.
    jsr PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
    jsr NMIOn                       ;($C487)Turn on non-maskable interrupt.
    lda #sfxMulti_EndMusic          ;Initiate end game music.
    sta MultiSFXFlag                ;
    lda #$60                        ;Loads Timer3 with a delay of 960 frames-->
    sta Timer3                      ;(16 seconds).
    lda #$36                        ;#$36/#$03 = #$12.  Number of sprites-->
    sta SpriteByteCounter           ;used to draw end graphic of Samus.
    lda #$00                        ;
    sta SpriteAttribByte            ;
    sta ColorCntIndex               ;
    sta IsCredits                   ;The following values are-->
    sta EndMsgWrite                 ;initialized to #$00.
    sta HideShowEndMsg              ;
    sta CreditPageNumber            ;
    lda #$01                        ;
    sta PalDataPending              ;Change palette.
    lda #$08                        ;
    sta ClrChangeCounter            ;Initialize ClrChangeCounter with #$08.
    inc RoomPtr                     ;
    jmp ScreenOn                    ;($C447)Turn screen on.

ShowEndSamus:
    jsr LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    lda Timer3                      ;Once 960 frames (16 seconds) have expired,-->
    bne L9B26                       ;Move to EndSamusFlash routine.
        inc RoomPtr                     ;
        rts                             ;

    L9B26:
    cmp #$50                        ;After 160 frames have past-->
    bne L9B2D                       ;(2.6 seconds), write end message.
        inc EndMsgWrite                 ;
        rts                             ;

    L9B2D:
    cmp #$01                        ;After 950 frames have past-->
    bne L9B33                       ;(15.8 seconds), erase end message.
        inc HideShowEndMsg              ;
    L9B33:
    rts                             ;

EndSamusFlash:
    lda FrameCount                  ;If FrameCount not divisible by 32, branch.
    and #$1F                        ;
    bne L9B69                       ;
        inc ColorCntIndex               ;Every 32 frame, increment the ColorCntInex-->
        lda ColorCntIndex               ;value.  Flashing Samus lasts for 512-->
        cmp #$08                        ;frames (8.5 seconds).
        bne L9B52                       ;
            jsr ChooseEnding                ;($CAF5)Choose which Samus ending to show.
            jsr CalculatePassword           ;($8C7A)Calculate game password.
            lda EndingType                  ;
            asl                             ;When EndSamusFlash routine is half way-->
            sta SpritePointerIndex          ;done, this code will calculate the-->
            lda #$36                        ;password and choose the proper ending.
            sta SpriteByteCounter           ;
        L9B52:
        cmp #$10                        ;
        bne L9B69                       ;Once flashing Samus is compete, set Timer3-->
        sta Timer3                      ;for a 160 frame(2.6 seconds) delay.
        ldy #$00                        ;
        lda EndingType                  ;
        cmp #$04                        ;If one of the suitless Samus endings,-->
        bcc L9B62                       ;increment sprite color for proper-->
            iny                             ;color to be displayed and increment-->
        L9B62:
        sty SpriteAttribByte            ;RoomPtr and erase the sprites.
        inc RoomPtr                     ;
        jmp EraseAllSprites             ;($C1A3)Clear all sprites off the screen.
    L9B69:
    dec ClrChangeCounter            ;Decrement ClrChangeCounter.
    bne L9B80                       ;
    ldy ColorCntIndex               ;
    lda PalChangeTable,y            ;When ClrChangeCounter=#$00, fetch new-->
    sta ClrChangeCounter            ;ClrChangeCounter value. and increment-->
    inc SpriteAttribByte            ;sprite color.
    lda SpriteAttribByte            ;
    cmp #$03                        ;
    bne L9B80                       ;
    lda #$00                        ;If sprite color=#$03, set sprite-->
    sta SpriteAttribByte            ;color to #$00.
L9B80:
    jmp LoadEndSamusSprites         ;($9C9A)Load end image of Samus.

;The following table is used by the above routine to load ClrChangeCounter.  ClrChangeCounter
;decrements every frame, When ClrChangeCounter reaches zero, the sprite colors for Samus
;changes.  This has the effect of making Samus flash.  The flashing starts slow, speeds up,
;then slows down again.
PalChangeTable:
    .byte $08, $07, $06, $05, $04, $03, $02, $01, $01, $02, $03, $04, $05, $06, $07, $08

SamusWave:
    lda Timer3                      ;If 160 frame timer from previous routine-->
    bne L9BA2                       ;has not expired, branch(waves for 2.6 seconds).
    lda #$10                        ;
    sta Timer3                      ;Load Timer3 with 160 frame delay-->
    lda #$08                        ;(2.6 seconds).
    sta PalDataPending              ;Change palette
    inc RoomPtr                     ;Increment RoomPtr
    rts                             ;

L9BA2:
    lda EndingType                  ;If suitless Samus-->
    cmp #$04                        ;ending, branch.
    bcs L9BAC                       ;
    jmp LoadEndSamusSprites         ;($9C9A)
L9BAC:
    sbc #$04                        ;If jumpsuit Samus ending,-->
    asl                             ;WaveSpritePointer=#$00, if bikini-->
    asl                             ;Samus ending, WaveSpritePointer=#$04.
    sta WaveSpritePointer           ;
    lda FrameCount                  ;
    and #$08                        ;Every eigth frame count, change wave sprite data.
    bne L9BBE                       ;
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

EndFadeOut:
    lda Timer3                      ;If 160 frame delay from last routine has not-->
    bne L9BEF                       ;yet expired, branch.
    lda IsCredits                   ;
    bne L9BDB                       ;Branch always.

        lda #$08                        ;*This code does not appear to be used.
        sta PalDataPending              ;*Change palette.
        inc IsCredits                   ;*Increment IsCredits.

    L9BDB:
    lda FrameCount                  ;
    and #$07                        ;Every seventh frame, increment the palette info-->
    bne L9BEF                       ;If PalDataPending is not equal to #$0C, keep-->
    inc PalDataPending              ;incrementing every seventh frame until it does.-->
    lda PalDataPending              ;This creates the fade out effect.
    cmp #$0C                        ;
    bne L9BEF                       ;
        lda #$10                        ;After fadeout complete, load Timer3 with 160 frame-->
        sta Timer3                      ;delay(2.6 seconds) and increment RoomPtr.
        inc RoomPtr                     ;
    L9BEF:
    lda EndingType                  ;
    cmp #$04                        ;If suitless Samus ending, load hand wave sprites,-->
    bcs L9BF9                       ;else just load regular Samus sprites
        jmp LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    L9BF9:
        jmp LoadWaveSprites             ;($9C7F)Load sprites for waving Samus.

RollCredits:
    lda Timer3                      ;If 160 frame timer delay from previous-->
    beq L9C17                       ;routine has expired, branch.
    cmp #$02                        ;If not 20 frames left in Timer3, branch to exit.
    bne RTS_9C44                       ;
    jsr ScreenOff                   ;($C439)When 20 frames left in Timer3,-->
    jsr ClearNameTable0             ;($C16D)clear name table 0 and sprites.-->
    jsr EraseAllSprites             ;($C1A3)prepares screen for credits.
    lda #$0D                        ;
    sta PalDataPending              ;Change to proper palette for credits.
    jsr ScreenOn                    ;($C447)Turn screen on.
    jmp WaitNMIPass_                ;($C43F)Wait for NMI to end.
L9C17:
    lda CreditPageNumber            ;If first page of credits has not started to-->
    bne L9C1D                       ;roll, start it now, else branch.
    inc CreditPageNumber            ;
L9C1D:
    cmp #$06                        ;If not at last page of credits, branch.
    bne L9C2A                       ;
    lda ScrollY                     ;
    cmp #$88                        ;If last page of credits is not finished-->
    bcc L9C2A                       ;scrolling, branch.  Else increment to next-->
    inc RoomPtr                     ;routine.
    rts                             ;

L9C2A:
    lda FrameCount                  ;credits scroll up one position every 3 frames.
    and #$03                        ;
    bne RTS_9C44                       ;Ready to scroll? If not, branch.
    inc ScrollY                     ;
    lda ScrollY                     ;Load ScrollY and check it to see if its-->
    cmp #$F0                        ;position is at the very bottom on name table.-->
    bne RTS_9C44                       ;if not, branch.
    inc CreditPageNumber            ;
    lda #$00                        ;
    sta ScrollY                     ;When Scrolly is at bottom of the name table,-->
    lda PPUCTRL_ZP                   ;Swap to next name table(0 or 2) and increment-->
    eor #$02                        ;CreditPageNumber.
    sta PPUCTRL_ZP                   ;
RTS_9C44:
    rts

;The following routine is checked every frame and is accessed via the NMIScreenWrite routine.
;The LoadCredits routine works like this: The Y scroll position is checked every frame.  When
;it is in the first four positions of the current name table (0, 1, 2 or 3), or the four
;positions right after 127 (128, 129, 130 and 131), the routine will then load the ending
;credits into the positions on the name table that were just scrolled over.  For example, If
;the scroll window is currently half way down name table 0, the LoadCredits routine will load
;the contents of the upper half of name table 0.  Also, name table 0 contains odd numbered
;pages and name table 2 contains even numbered pages.

LoadCredits:
    ldy CreditPageNumber            ;
    beq RTS_9C7E                       ;If credits are not being displayed, exit.
    cpy #$07                        ;
    bcs RTS_9C7E                       ;If CreditPageNumber is higher than #$06, exit.
    ldx #$00                        ;
    lda ScrollY                     ;If ScrollY is less than #$80 (128), branch.
    bpl L9C57                       ;
    inx                             ;Load X with sign bit (#$01) and remove-->
    sec                             ;sign bit from A.
    sbc #$80                        ;
L9C57:
    cmp #$04                        ;
    bcs RTS_9C7E                       ;If ScrollY is not #$04, branch to exit.
    sta $01                         ;Store #$00, #$01, #$02 or #$03 in address $01.
    dey                             ;Y now contains CreditPageNumber - 1.
    txa                             ;
    bne L9C6C                       ;If ScrollY is #$80 (128) or greater, branch.
    dey                             ;Y now contains CreditPageNumber - 2.
    bmi RTS_9C7E                       ;If on Credit page less than two , branch to exit.
    tya                             ;
    asl                             ;Start with CreditPageNumber - 2-->
    asl                             ;* 8 + 4 + $01 * 2.
    asl                             ;This formula is used when ScrollY = 0, 1, 2 and 3.
    adc #$04                        ;Result is index to find proper credits to load.
    bne L9C70                       ;Branch always.
L9C6C:
    tya                             ;
    asl                             ;Start with CreditPageNumber - 1-->
    asl                             ;* 8 + $01 * 2.
    asl                             ;This formula is used when ScrollY = 128,-->
L9C70:
    adc $01                         ;129, 130 and 131.
    asl                             ;Result is index to find proper credits to load.
    tay                             ;
    ldx CreditsPointerTbl,y         ;Base is $A291. Lower byte of pointer to PPU string.
    lda CreditsPointerTbl+1,y       ;Upper byte of pointer to PPU string.
    tay                             ;
    jmp PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
RTS_9C7E:
    rts                             ;

LoadWaveSprites:
    ldx WaveSpritePointer           ;
    lda WavePointerTable,x          ;
    sta $00                         ;Load pointer to wave sprite data-->
    lda WavePointerTable+1,x        ;into addresses $00 and $01.
    sta $01                         ;
    ldx #$20                        ;Offset for sprite RAM load.
    ldy #$00                        ;
    L9C8F:
        lda ($00),y                     ;
        sta SpriteRAM,x               ;Load wave sprites into sprite RAM starting at-->
        inx                             ;location $220 (Sprite08RAM).
        iny                             ;
        cpy WaveSpriteCounter           ;Check to see if sprite RAM load complete.-->
        bne L9C8F                       ;If not, branch and load another byte.

LoadEndSamusSprites:
    ldx #$30                        ;Index for loading Samus sprite data into sprite RAM.
    ldy SpritePointerIndex          ;
    lda EndSamusAddrTbl,y           ;Base is $9D5A.
    sta $00                         ;Load $00 and $01 with pointer to the sprite-->
    lda EndSamusAddrTbl+1,y         ;data that shows Samus at the end of the game.
    sta $01                         ;
    ldy #$00                        ;
    L9CAA:
        lda ($00),y                     ;Load sprite data starting at Sprite0CRAM.
        sta SpriteRAM,x               ;Load sprite Y-coord.
        inx                             ;
        iny                             ;Increment X and Y.
        lda ($00),y                     ;
        bpl L9CC0                       ;If sprite pattern byte MSB cleared, branch.
            and #$7F                        ;
            sta SpriteRAM,x               ;Remove MSB and write sprite pattern data-->
            lda SpriteAttribByte            ;to sprite RAM.
            eor #$40                        ;
            bne L9CC5                       ;
        L9CC0:
            sta SpriteRAM,x               ;Writes sprite pattern byte to-->
            lda SpriteAttribByte            ;sprite RAM if its MSB is not set.
        L9CC5:
        inx                             ;
        sta SpriteRAM,x               ;Writes sprite attribute byte to sprite RAM.
        iny                             ;
        inx                             ;Increment X and Y.
        lda ($00),y                     ;
        sta SpriteRAM,x               ;Load sprite X-coord.
        iny                             ;
        inx                             ;Increment X and Y.
        cpy SpriteByteCounter           ;
        bne L9CAA                       ;Repeat until sprite load is complete.
    lda RoomPtr                     ;
    cmp #$02                        ;If not running the EndSamusFlash routine, branch.
    bcc RTS_9CF9                       ;
    lda ColorCntIndex               ;
    cmp #$08                        ;If EndSamusFlash routine is more than half-->
    bcc RTS_9CF9                       ;way done, Check ending type for the Samus helmet-->
    lda EndingType                  ;off ending.  If not helmet off ending, branch.
    cmp #$03                        ;
    bne RTS_9CF9                       ;
    ldy #$00                        ;
    ldx #$00                        ;
    L9CED:
        lda SamusHeadSpriteTble,y       ;The following code loads the sprite graphics-->
        sta SpriteRAM,x               ;when the helmet off ending is playing.  The-->
        iny                             ;sprites below keep Samus head from flashing-->
        inx                             ;while the rest of her body does.
        cpy #$18                        ;
        bne L9CED                       ;
RTS_9CF9:
    rts                             ;

;The following table is used by the routine above to keep Samus'
;head from flashing during the helmet off ending.

SamusHeadSpriteTble:
    .byte $93, $36, $01, $70        ;Sprite00RAM
    .byte $93, $37, $01, $78        ;Sprite01RAM
    .byte $93, $38, $01, $80        ;Sprite02RAM
    .byte $9B, $46, $01, $70        ;Sprite03RAM
    .byte $9B, $47, $01, $78        ;Sprite04RAM
    .byte $9B, $48, $01, $80        ;Sprite05RAM

;The following table is a pointer table to the sprites that makes Samus wave in the end
;of the game when she is suitless.  The top two pointers are for when she is in the jumpsuit
;and the bottom two pointers are for when she is in the bikini.

WavePointerTable:
    .word JsHandUpTable                     ;Jumpsuit Samus hand up.
    .word JsHandDownTable                     ;Jumpsuit Samus hand down.
    .word BkHandUpTable                     ;Bikini Samus hand up.
    .word BkHandDownTable                     ;Bikini Samus hand down.

;Sprite data table used when Samus is in jumpsuit and her waving hand is up.
JsHandUpTable:
    .byte $9B, $1F, $01, $80
    .byte $A3, $2F, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80

;Sprite data table used when Samus is in jumpsuit and her waving hand is down.
JsHandDownTable:
    .byte $9B, $2A, $01, $80
    .byte $9B, $2B, $01, $88
    .byte $A3, $3A, $01, $80
    .byte $AB, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is up.
BkHandUpTable:
    .byte $9B, $0C, $01, $80
    .byte $A3, $1C, $01, $80
    .byte $AB, $3F, $01, $80
    .byte $F4, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is down.
BkHandDownTable:
    .byte $9B, $4A, $01, $80
    .byte $9B, $4B, $01, $88
    .byte $A3, $4D, $01, $80
    .byte $AB, $3F, $01, $80

EndSamusAddrTbl:
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

NormalSamus:
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

BackTurnedSamus:
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

FistRaisedSamus:
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

HelmetOffSamus:
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

JumpsuitSamus:
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

BikiniSamus:
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

LoadEndStarSprites:
    ldy #$00
    L9EAC:
        lda EndStarDataTable,y
        sta SpriteRAM+$1C<<2,y               ;Load the table below into sprite RAM-->
        iny                             ;starting at address $0270.
        cpy #$9C
        bne L9EAC
    rts

;Loaded into sprite RAM by routine above. Displays stars at the end of the game.

EndStarDataTable:
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

EndGamePalWrite:
    lda PalDataPending              ;If no palette data pending, branch to exit.
    beq RTS_9F80                       ;
    cmp #$0C                        ;If PalDataPending has loaded last palette,-->
    beq RTS_9F80                       ;branch to exit.
    cmp #$0D                        ;Once end palettes have been cycled through,-->
    bne L9F64                       ;start over.
        ldy #$00                        ;
        sty PalDataPending              ;
    L9F64:
    asl                             ;* 2, pointer is two bytes.
    tay                             ;
    lda EndGamePalPntrTbl-1,y       ;High byte of PPU data pointer.
    ldx EndGamePalPntrTbl-2,y       ;Low byte of PPU data pointer.
    tay                             ;
    jsr PreparePPUProcess_          ;($C20E)Prepare to write data string to PPU.
    lda #$3F                        ;
    sta PPUADDR                  ;
    lda #$00                        ;
    sta PPUADDR                  ;Set PPU address to $3F00.
    sta PPUADDR                  ;
    sta PPUADDR                  ;Set PPU address to $0000.
RTS_9F80:
    rts                             ;

;The following pointer table is used by the routine above to
;find the proper palette data during the EndGame routine.

EndGamePalPntrTbl:
    .word EndGamePal00              ;($9F9B)
    .word EndGamePal01              ;($9FBF)
    .word EndGamePal02              ;($9FCB)
    .word EndGamePal03              ;($9FD7)
    .word EndGamePal04              ;($9FE3)
    .word EndGamePal05              ;($9FEF)
    .word EndGamePal06              ;($9FFB)
    .word EndGamePal07              ;($A007)
    .word EndGamePal08              ;($A013)
    .word EndGamePal09              ;($A02E)
    .word EndGamePal0A              ;($A049)
    .word EndGamePal0A              ;($A049)
    .word EndGamePal0B              ;($9806)

EndGamePal00:
    PPUString $3F00, {$0F, $21, $11, $02, $0F, $29, $1B, $1A, $0F, $27, $28, $29, $0F, $28, $18, $08, $0F, $16, $19, $27, $0F, $36, $15, $17, $0F, $12, $21, $20, $0F, $35, $12, $16}

    .byte $00                       ;End EndGamePal00 data.

EndGamePal01:
    PPUString $3F18, {$0F, $10, $20, $30, $0F, $0F, $0F, $0F}

    .byte $00                       ;End EndGamePal01 data.

EndGamePal02:
    PPUString $3F18, {$0F, $12, $22, $32, $0F, $0B, $1B, $2B}

    .byte $00                       ;End EndGamePal02 data.

EndGamePal03:
    PPUString $3F18, {$0F, $14, $24, $34, $0F, $09, $19, $29}

    .byte $00                       ;End EndGamePal03 data.

EndGamePal04:
    PPUString $3F18, {$0F, $16, $26, $36, $0F, $07, $17, $27}

    .byte $00                       ;End EndGamePal04 data.

EndGamePal05:
    PPUString $3F18, {$0F, $18, $28, $38, $0F, $05, $15, $25}

    .byte $00                       ;End EndGamePal05 data.

EndGamePal06:
    PPUString $3F18, {$0F, $1A, $2A, $3A, $0F, $03, $13, $13}

    .byte $00                       ;End EndGamePal06 data.

EndGamePal07:
    PPUString $3F18, {$0F, $1C, $2C, $3C, $0F, $01, $11, $21}

    .byte $00                       ;End EndGamePal07 data.

EndGamePal08:
    PPUString $3F0C, {$0F, $18, $08, $07}
    PPUString $3F10, {$0F, $26, $05, $07, $0F, $26, $05, $07, $0F, $01, $01, $05, $0F, $13, $1C, $0C}

    .byte $00                       ;End EndGamePal08 data.

EndGamePal09:
    PPUString $3F0C, {$0F, $08, $07, $0F}
    PPUString $3F10, {$0F, $06, $08, $0F, $0F, $06, $08, $0F, $0F, $00, $10, $0F, $0F, $01, $0C, $0F}

    .byte $00                       ;End EndGamePal09 data.

EndGamePal0A:
    PPUStringRepeat $3F0C, $0F, $04
    PPUStringRepeat $3F10, $0F, $10

    .byte $00                       ;End EndGamePal0A data.

;The following data writes the end game background graphics.

;Writes ground graphics on name table 0 in row $2300 (25th row from top).
LA052:
    PPUString $2300, {$30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31}

    ;Writes ground graphics on name table 0 in row $2320 (26th row from top).
    PPUString $2320, {$32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33}

    ;Writes ground graphics on name table 0 in row $2340 (27th row from top).
    PPUString $2340, {$34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35}

    ;Writes ground graphics on name table 0 in row $2360 (28th row from top).
    PPUString $2360, {$36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37}

    ;Writes ground graphics on name table 0 in row $2380 (29th row from top).
    PPUString $2380, {$38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39}

    ;Writes ground graphics on name table 0 in row $23A0 (bottom row).
    PPUString $23A0, {$3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B}

    ;Sets all color bits in attribute table 0 starting at $23F0.
    PPUStringRepeat $23F0, $FF, $10

    ;Writes credits on name table 2 in row $2820 (2nd row from top).
    PPUString $282E, "STAFF"

    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    PPUString $28A8, "SCENARIO WRITTEN BY"

    ;Writes credits on name table 2 in row $28E0 (8th row from top).
    PPUString $28EE, "KANOH"

    ;Writes credits on name table 2 in row $2960 (12th row from top).
    PPUString $2966, "CHARACTER DESIGNED BY"

    ;Writes credits on name table 2 in row $29A0 (14th row from top).
    PPUString $29AC, "KIYOTAKE"

    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    PPUString $2A2B, "NEW MATSUOKA"

    ;Writes credits on name table 2 in row $2A60 (20th row from top).
    PPUString $2A6C, "SHIKAMOTO"

    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    PPUString $2AEC, "MUSIC BY"

    ;Writes credits on name table 2 in row $2B20 (26th row from top)
    PPUString $2B2B, "HIP TANAKA"

    ;Writes credits on name table 2 in row $2BA0 (bottom row).
    PPUString $2BA7, " MAIN PROGRAMMERS "

    .byte $00                       ;End PPU string write.

;The following pointer table is accessed by the NMIScreenWrite routine.
;It is used to locate the start of the PPU strings below.

EndMessageStringTbl0:
    .word LA1C2, LA1EB, LA20F, LA240

LA1C2:
    ;Writes end message on name table 0 in row $2060 (4th row from top).
    PPUString $206D, "GREAT !!"

    ;Writes end message on name table 0 in row $20C0 (7th row from top).
    PPUString $20C3, "YOU FULFILED YOUR MISSION."

    .byte $00                       ;End PPU string write.

LA1EB:
    ;Writes end message on name table 0 in row $2100 (9th row from top).
    PPUString $2103, "IT WILL REVIVE PEACE IN"

    ;Writes end message on name table 0 in row $2140 (11th row from top).
    PPUString $2142, "SPACE."

    .byte $00                       ;End PPU string write.

LA20F:
    ;Writes end message on name table 0 in row $2180 (13th row from top).
    PPUString $2183, "BUT,IT MAY BE INVADED BY"

    ;Writes end message on name table 0 in row $21C0 (15th row from top).
    PPUString $21C2, "THE OTHER METROID."

    .byte $00                       ;End PPU string write.

LA240:
    ;Writes end message on name table 0 in row $2200 (18th row from top).
    PPUString $2203, "PRAY FOR A TRUE PEACE IN"

    ;Writes end message on name table 0 in row $2240 (19th row from top).
    PPUString $2242, "SPACE!"

    .byte $00                       ;End PPU string write.

;The following pointer table is accessed by the NMIScreenWrite routine.
;It is used to locate the start of the PPU strings below.

EndMessageStringTbl1:
    .word LA26D, LA276, LA27F, LA288

LA26D:
    ;Erases end message on name table 0 in row $2060 (4th row from top).
    PPUStringRepeat $206D, ' ', $08

    ;Erases end message on name table 0 in row $20C0 (7th row from top).
    PPUStringRepeat $20C3, ' ', $1A

    .byte $00                       ;End PPU string write.

LA276:
    ;Erases end message on name table 0 in row $2100 (9th row from top).
    PPUStringRepeat $2103, ' ', $17

    ;Erases end message on name table 0 in row $2140 (11th row from top).
    PPUStringRepeat $2142, ' ', $0A

    .byte $00                       ;End PPU string write.

LA27F:
    ;Erases end message on name table 0 in row $2180 (13th row from top).
    PPUStringRepeat $2183, ' ', $18

    ;Erases end message on name table 0 in row $21C0 (15th row from top).
    PPUStringRepeat $21C2, ' ', $12

    .byte $00                       ;End PPU string write.

LA288:
    ;Erases end message on name table 0 in row $2200 (18th row from top).
    PPUStringRepeat $2203, ' ', $18

    ;Erases end message on name table 0 in row $2240 (19th row from top).
    PPUStringRepeat $2242, ' ', $0A

    .byte $00                       ;End PPU string write

;The following table is used by the LoadCredits routine to load the end credits on the screen.

CreditsPointerTbl:
    .word LA2E9, LA2FB, LA31A, LA31B, LA32D, LA339, LA34F, LA362, LA375, LA384, LA39F, LA3AA
    .word LA3C8, LA3D8, LA3F1, LA412, LA417, LA426, LA442, LA46B, LA470, LA493, LA49C, LA4AD
    .word LA4BD, LA4CD, LA4D2, LA4D7, LA4DC, LA4E1, LA4E6, LA4EB, LA4EF, LA4F0, LA508, LA51A
    .word LA51F, LA524, LA51F, LA524, LA538, LA53D, LA538, LA53D

LA2E9:
    ;Writes credits on name table 0 in row $2020 (2nd row from top).
    PPUString $202C, "HAI YUKAMI"

    ;Clears attribute table 0 starting at $23C0.
    PPUStringRepeat $23C0, $00, $20

    .byte $00                       ;End PPU string write.

LA2FB:
    ;Writes credits on name table 0 in row $2060 (4th row from top)
    PPUString $206A, "ZARU SOBAJIMA"

    ;Writes credits on name table 0 in row $20A0 (6th row from top).
    PPUString $20AB, "GPZ SENGOKU"

    .byte $00                       ;End PPU string write.

LA31A:
    .byte $00                       ;End PPU string write.

LA31B:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    PPUString $216A, "N.SHIOTANI"

    ;Clears attribute table 0 starting at $23E0
    PPUStringRepeat $23E0, $00, $20

    .byte $00                       ;End PPU string write.

;Writes credits on name table 0 in row $21E0 (16th row from top).
LA32D:
    PPUString $21EB, "M.HOUDAI"

    .byte $00                       ;End PPU string write.

LA339:
    ;Writes credits on name table 0 in row $22A0 (22nd row from top).
    PPUString $22A7, "SPECIAL THANKS  TO"

    .byte $00                       ;End PPU string write.

LA34F:
    ;Writes credits on name table 0 in row $22E0 (24nd row from top).
    PPUString $22EC, "KEN ZURI"

    ;Writes credits on name table 0 in row $2320 (26nd row from top).
    PPUString $232E, "SUMI"

    .byte $00                       ;End PPU string write.

LA362:
    ;Writes credits on name table 0 in row $2360 (28nd row from top).
    PPUString $236C, "INUSAWA"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    PPUString $23AD, "KACHO"

    .byte $00                       ;End PPU string write.

LA375:
    ;Writes credits on name table 2 in row $2820 (2nd row from top).
    PPUStringRepeat $2828, ' ', $0E

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    PPUString $286C, "HYAKKAN"

    .byte $00                       ;End PPU string write.

LA384:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    PPUString $28A8, "     GOYAKE        "

    ;Writes credits on name table 2 in row $28E0 (8th row from top).
    PPUStringRepeat $28E8, ' ', $0F

    .byte $00                       ;End PPU string write.

LA39F:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    PPUString $292C, "HARADA "

    .byte $00                       ;End PPU string write.

LA3AA:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    PPUString $2966, "       PENPEN         "

    ;Writes credits on name table 2 in row $29A0 (14th row from top).
    PPUStringRepeat $29A8, ' ', $0F

    .byte $00                       ;End PPU string write.

LA3C8:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    PPUString $29EA, "CONVERTED BY"

    .byte $00                       ;End PPU string write.

LA3D8:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    PPUString $2A26, "     T.NARIHIRO  "

    ;Writes credits on name table 2 in row $2A60 (20th row from top).
    PPUStringRepeat $2A67, ' ', $11

    .byte $00                       ;End PPU string write.

LA3F1:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    PPUString $2AEB, "ASSISTED BY"

    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    PPUString $2B28, "   MAKOTO KANOH"

    .byte $00                       ;End PPU string write.

LA412:
    ;Writes credits on name table 2 in row $2BA0 (bottom row).
    PPUStringRepeat $2BA6, ' ', $13

    .byte $00                       ;End PPU string write.

LA417:
    ;Writes credits on name table 0 in row $2020 (2nd row from the top).
    PPUString $202B, "DIRECTED BY"

    .byte $00                       ;End PPU string write.

LA426:
    ;Writes credits on name table 0 in row $2060 (4th row from the top).
    PPUString $2067, "     YAMAMOTO       "

    ;Writes credits on name table 0 in row $20A0 (6th row from the top).
    PPUStringRepeat $20AA, ' ', $0E

    .byte $00                       ;End PPU string write.

LA442:
    ;Writes credits on name table 0 in row $2120 (10th row from the top).
    PPUString $2127, "  CHIEF DIRECTOR "

    ;Writes credits on name table 0 in row $2160 (12th row from the top).
    PPUString $2168, "  SATORU OKADA   "

    .byte $00                       ;End PPU string write.

LA46B:
    ;Writes credits on name table 0 in row $21E0 (16th row from the top).
    PPUStringRepeat $21E6, ' ', $18

    .byte $00                       ;End PPU string write.

LA470:
    ;Writes credits on name table 0 in row $2220 (18th row from the top).
    PPUString $222B, "PRODUCED BY     "

    ;Writes credits on name table 0 in row $2260 (20th row from the top).
    PPUString $226A, "GUNPEI YOKOI"

    .byte $00                       ;End PPU string write.

LA493:
    ;Writes credits on name table 0 in row $22A0 (22nd row from the top).
    PPUStringRepeat $22A6, ' ', $13

    ;Writes credits on name table 0 in row $22E0 (24th row from the top).
    PPUStringRepeat $22E8, ' ', $0F

    .byte $00                       ;End PPU string write.

LA49C:
    ;Writes credits on name table 0 in row $2320 (26th row from the top).
    PPUStringRepeat $2329, ' ', $0D

    ;Writes credits on name table 0 in row $2340 (27th row from the top).
    PPUString $234B, "COPYRIGHT"

    .byte $00                       ;End PPU string write.

LA4AD:
    ;Writes credits on name table 0 in row $2360 (28th row from the top).
    PPUStringRepeat $236B, ' ', $0A

    ;Writes credits on name table 0 in row $2380 (29th row from the top).
    PPUString $238E, "1986"

    ;Writes credits on name table 0 in row $23A0 (bottom row).
    PPUStringRepeat $23A8, ' ', $0F

    .byte $00                       ;End PPU string write.

LA4BD:
    ;Writes credits on name table 2 in row $2800 (top row)
    PPUString $280C, "NINTENDO"

    ;Writes credits on name table 2 in row $2860 (4th row from top).
    PPUStringRepeat $2866, ' ', $11

    .byte $00                       ;End PPU string write.

LA4CD:
    ;Writes credits on name table 2 in row $28A0 (6th row from top).
    PPUStringRepeat $28AA, ' ', $0C

    .byte $00                       ;End PPU string write.

LA4D2:
    ;Writes credits on name table 2 in row $2920 (10th row from top).
    PPUStringRepeat $2926, ' ', $1B

    .byte $00                       ;End PPU string write.

LA4D7:
    ;Writes credits on name table 2 in row $2960 (12th row from top).
    PPUStringRepeat $2967, ' ', $12

    .byte $00                       ;End PPU string write.

LA4DC:
    ;Writes credits on name table 2 in row $29E0 (16th row from top).
    PPUStringRepeat $29E6, ' ', $14

    .byte $00                       ;End PPU string write.

LA4E1:
    ;Writes credits on name table 2 in row $2A20 (18th row from top).
    PPUStringRepeat $2A28, ' ', $15

    .byte $00                       ;End PPU string write.

LA4E6:
    ;Writes credits on name table 2 in row $2AE0 (24th row from top).
    PPUStringRepeat $2AE6, ' ', $10

    .byte $00                       ;End PPU string write.

LA4EB:
    ;Writes credits on name table 2 in row $2B20 (26th row from top).
    PPUStringRepeat $2B29, ' ', $0E

LA4EF:
    .byte $00                       ;End PPU string write.

;Writes the top half of 'The End' on name table 0 in row $2020 (2nd row from top).
LA4F0:
    PPUString $2026, {"     ", $24, $25, $26, $27, "  ", $2C, $2D, $2E, $2F, "     "}

    .byte $00                       ;End PPU string write.

;Writes the bottom half of 'The End' on name table 0 in row $2040 (3rd row from top).
LA508:
    PPUString $204B, {$28, $29, $2A, $2B, "  ", $02, $03, $04, $05}

LA515:
    ;Writes credits on name table 0 in row $2060 (4th row from top).
    PPUStringRepeat $206A, ' ', $0C

    .byte $00                       ;End PPU string write.

LA51A:
    ;Writes credits on name table 0 in row $2120 (10th row from top).
    PPUStringRepeat $2126, ' ', $13

    .byte $00                       ;End PPU string write.

LA51F:
    ;Writes credits on name table 0 in row $2160 (12th row from top).
    PPUStringRepeat $216A, ' ', $0C

    .byte $00                       ;End PPU string write.

LA524:
    ;Writes credits on name table 0 in row $2180 (13th row from top).
    PPUString $2188, "                 "

LA538:
    ;Writes credits on name table 0 in row $2220 (18th row from top).
    PPUStringRepeat $2226, ' ', $0B

    .byte $00                       ;End PPU string write.

LA53D:
    .byte $00                       ;End PPU block write.

;-------------------------------------------[ World map ]--------------------------------------------

WorldMap:
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

;Loads contents of world map into -->
;RAM at addresses $7000 thru $73FF.
CopyMap:
    lda #<WorldMap
    sta $00
    lda #>WorldMap
    sta $01
    lda #<WorldMapRAM
    sta $02
    lda #>WorldMapRAM
    sta $03
    ldx #$04
    LA950:
        ldy #$00
        LA952:
            lda ($00),y
            sta ($02),y
            iny
            bne LA952
        inc $01
        inc $03
        dex
        bne LA950
    rts

;Unused tile patterns.
    .byte $00, $40, $90, $D0, $08, $5C, $0C, $00, $00, $C0, $70, $F8, $FC, $F4, $FC, $10
    .byte $22, $56, $03, $2B, $74, $37, $0D, $3F, $5F, $7D, $7F, $7F, $5F, $3F, $0F, $68
    .byte $F6, $BC, $5E, $3C, $DE, $7C, $F0, $FC, $DE, $FE, $FE, $FE, $FE, $FC, $F0, $00
    .byte $00, $7F, $80, $80, $FF, $7F, $00, $00, $7F, $80, $7F, $FF, $FF, $7F, $00, $00
    .byte $00, $FC, $01, $03, $FF, $FE, $00, $00, $FE, $03, $FF, $FF, $FF, $FE, $00, $00
    .byte $10, $20, $20, $00, $20, $00, $00, $3C, $42, $81, $81, $81, $81, $42, $3C, $7F
    .byte $7F, $3F, $1F, $80, $0F, $08, $88, $12, $80, $C0, $E0, $E0, $EF, $E8, $E8, $FC
    .byte $FC, $FC, $F8, $1C, $DC, $58, $5C, $48, $04, $0C, $18, $1C, $DC, $18, $1C, $0F
    .byte $00, $9F, $3F, $7F, $DB, $00, $00, $E0, $E0, $FF, $FF, $FF, $DB, $00, $00, $DC
    .byte $18, $EC, $F4, $F8, $6C, $00, $00, $1C, $18, $FC, $FC, $FC, $6C, $00, $00, $FF
    .byte $FF, $C0, $C0, $CF, $CB, $CC, $CC, $00, $00, $1F, $3F, $3F, $38, $3B, $3B, $FC
    .byte $FC, $0C, $0C, $CC, $4C, $CC, $CC, $00, $04, $EC, $FC, $FC, $3C, $BC, $BC, $CB
    .byte $CF, $C0, $C0, $FF, $FF, $00, $00, $3B, $30, $3F, $1F, $7F, $FF, $00, $00, $4C
    .byte $CC, $0C, $0C, $FC, $FC, $00, $00, $3C, $3C, $FC, $EC, $FC, $FC, $00, $00, $FE
    .byte $82, $82, $82, $82, $FE, $00, $00, $00, $7E, $56, $56, $7E, $FE, $00, $00, $20
    .byte $00, $00, $18, $20, $00, $00, $18, $1C, $F7, $3C, $18, $1C, $F7, $3C, $18, $E2
    .byte $80, $10, $20, $00, $00, $80, $00, $E2, $98, $2C, $5E, $7E, $3C, $98, $00, $7E
    .byte $00, $7E, $00, $7E, $00, $7E, $00, $6E, $00, $6E, $00, $6E, $00, $6E, $00, $10
    .byte $F4, $08, $04, $C5, $24, $23, $05, $E8, $F8, $0E, $E6, $F7, $37, $2E, $FD, $00
    .byte $5F, $20, $48, $D7, $88, $18, $80, $3F, $3F, $E0, $C7, $CF, $B8, $98, $7F, $F8
    .byte $10, $10, $10, $D7, $08, $00, $EF, $F8, $10, $30, $B7, $F7, $30, $DF, $EF, $FF
    .byte $00, $08, $08, $EF, $08, $10, $EF, $FF, $00, $18, $DB, $FF, $38, $F7, $EF, $FF
    .byte $7F, $3F, $5F, $4F, $07, $03, $01, $00, $B0, $C0, $E0, $F0, $F8, $FC, $FE, $FE
    .byte $FE, $FE, $FA, $FA, $FE, $FE, $FE, $00, $1A, $06, $0A, $1A, $3E, $7E, $FE, $01
    .byte $03, $07, $4F, $5F, $27, $7F, $00, $FF, $FF, $FF, $FF, $FF, $E7, $FF, $00, $7E
    .byte $BE, $DA, $EA, $F6, $CA, $FC, $00, $FE, $FE, $FA, $FA, $FE, $CE, $FE, $00, $CF
    .byte $BF, $70, $60, $C4, $C8, $C0, $C0, $47, $BF, $70, $27, $4B, $57, $5F, $DF, $CC
    .byte $F4, $38, $18, $0C, $0C, $0C, $0C, $CC, $F4, $38, $98, $CC, $EC, $EC, $EC, $C0
    .byte $C0, $60, $70, $BF, $CF, $00, $00, $DF, $CF, $67, $70, $BF, $4F, $00, $00, $0C
    .byte $0C, $18, $38, $F4, $CC, $00, $00, $EC, $CC, $98, $38, $F4, $CC, $00, $00, $FF
    .byte $FF, $C0, $DF, $D0, $D0, $DF, $C0, $00, $00, $3F, $3F, $35, $35, $20, $3F, $FC
    .byte $FC, $0C, $EC, $2C, $2C, $EC, $0C, $00, $04, $FC, $FC, $5C, $5C, $1C, $FC, $FF
    .byte $00, $00, $E4, $00, $CF, $00, $00, $7F, $00, $00, $E3, $00, $BF, $00, $00, $FC
    .byte $00, $00, $F9, $00, $87, $00, $00, $FC, $00, $00, $F7, $00, $67, $00, $00, $FE
    .byte $02, $02, $02, $FE, $00, $00, $7F, $00, $FE, $0E, $FE, $FE, $00, $00, $00, $7F
    .byte $40, $40, $40, $7F, $00, $00, $FE, $00, $3F, $30, $3F, $7F, $00, $00, $00, $40
    .byte $40, $40, $7F, $00, $00, $00, $FF, $3F, $30, $3F, $7F, $00, $00, $FF, $FF, $02
    .byte $02, $02, $FE, $00, $00, $00, $FF, $FE, $0E, $FE, $FE, $00, $00, $FF, $FF, $FF
    .byte $FF, $C0, $D0, $C0, $C0, $C0, $C0, $00, $00, $3F, $27, $3F, $3F, $3F, $3F, $FC
    .byte $FC, $0C, $4C, $0C, $0C, $0C, $0C, $00, $04, $FC, $9C, $FC, $FC, $FC, $FC, $C0
    .byte $C0, $D0, $C0, $FF, $FF, $00, $00, $3F, $3F, $27, $3F, $3F, $7F, $00, $00, $0C
    .byte $0C, $4C, $0C, $FC, $FC, $00, $00, $FC, $FC, $9C, $FC, $FC, $FC, $00, $00

;------------------------------------------[ Area music data ]---------------------------------------

.include "songs/end.asm"

;Unused tile patterns.
    .byte $80, $40, $20, $10, $88, $00, $00, $00, $00, $00, $00, $00, $80, $04, $00, $02
    .byte $02, $00, $00, $00, $00, $07, $03, $03, $03, $01, $00, $00, $00, $84, $C4, $42
    .byte $62, $21, $31, $11, $11, $80, $C0, $C0, $E0, $E0, $F0, $F0, $F0, $00, $00, $00
    .byte $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $03, $03, $11, $11, $31
    .byte $21, $63, $62, $C4, $84, $F0, $F0, $F0, $E0, $E0, $E0, $C0, $80, $01, $13, $16
    .byte $2C, $78, $B3, $EC, $F0, $07, $1F, $1E, $3C, $78, $F0, $E0, $00, $08, $10, $20
    .byte $40, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $82, $CC, $4E
    .byte $4C, $40, $4C, $4C, $4C, $82, $CC, $CE, $CC, $C0, $CC, $CC, $CC, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $01, $03, $06, $0C, $18, $00, $00, $00, $00, $00, $01, $03, $07, $0F, $3C, $E0
    .byte $84, $08, $30, $60, $E0, $00, $02, $1F, $7A, $F4, $C8, $98, $10, $19, $31, $33
    .byte $63, $63, $67, $E7, $E7, $06, $0E, $0C, $1C, $1C, $18, $18, $18, $C0, $C0, $80
    .byte $80, $80, $00, $00, $00, $30, $30, $60, $60, $60, $E0, $E0, $E0, $C7, $C7, $C7
    .byte $C7, $C7, $C7, $C7, $C7, $38, $38, $38, $38, $38, $38, $38, $38, $20, $20, $20
    .byte $20, $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

.include "songs/intro.asm"

;Unused tile patterns.
    .byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
    .byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
    .byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
    .byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
    .byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
    .byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
    .byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
    .byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
    .byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
    .byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
    .byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
    .byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
    .byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_00_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
