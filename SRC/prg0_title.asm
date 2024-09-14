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
.segment "BANK_00_00"

;--------------------------------------------[ Export ]---------------------------------------------

.export MainTitleRoutine
.export StarPalSwitch
.export DecSpriteYCoord
.export NMIScreenWrite
.export EndGamePalWrite
.export CopyMap

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
.import TwosCompliment
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
        lda PPUCTRL_ZP                   ;       
        and #$FC                        ;Set name table to name table 0.
        sta PPUCTRL_ZP                   ;
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
    LDA #$10                        ;Intro music flag.
    STA ABStatus                    ;Never accessed by game.
    STA MultiSFXFlag                ;Initiates intro music.
    JSR ScreenOff                   ;($C439)Turn screen off.
    JSR ClearNameTables             ;($C158)Erase name table data.
    LDX #.lobyte(L82F4)                        ;Lower address of PPU information.
    LDY #.hibyte(L82F4)                        ;Upper address of PPU information.
    JSR PreparePPUProcess_          ;($C20E) Writes background of intro screen to name tables.
    LDA #$01                        ;
    STA PalDataPending              ;Prepare to load palette data.
    STA SpareMemC5                  ;Not accessed by game.
    LDA PPUCTRL_ZP                   ;
    AND #$FC                        ;Switch to name table 0
    STA PPUCTRL_ZP                   ;
    INC TitleRoutine                ;Next routine sets up METROID fade in delay.
    LDA #$00                        ;
    STA SpareMemD7                  ;Not accessed by game.
    JMP ScreenOn                    ;($C447)Turn screen on.

FadeInDelay:
    LDA PPUCTRL_ZP                   ;
    AND #$FE                        ;Switch to name table 0 or 2.
    STA PPUCTRL_ZP                   ;
    LDA #$08                        ;Loads Timer3 with #$08. Delays Fade in routine.-->
    STA Timer3                      ;Delays fade in by 80 frames (1.3 seconds).
    LSR                             ;
    STA PalDataIndex                ;Loads PalDataIndex with #$04
    INC TitleRoutine                ;Increment to next routine.
    RTS                             ;
 
FlashEffect:
    LDA FrameCount                  ;Every third frame, run change palette-->
    AND #$03                        ;Creates METROID flash effect.
    BNE L812B                       ;
    LDA PalDataIndex                ;Uses only the first three palette-->
    AND #$03                        ;data sets in the flash routine.
    STA PalDataIndex                ;
    JSR LoadPalData                 ;
    LDA Timer3                      ;If Timer 3 has not expired, branch-->
    BNE L812B                       ;so routine will keep running.
    LDA PalDataIndex                ;
    CMP #$04                        ;Ensures the palette index is back at 0.
    BNE L812B                       ;
    INC TitleRoutine                ;Increment to next routine.
    JSR LoadSparkleData             ;($87AB) Loads data for next routine.
    LDA #$18                        ;Sets Timer 3 for a delay of 240 frames-->
    STA Timer3                      ;(4 seconds).
L812B:
    RTS                             ;

METROIDFadeIn:
    LDA Timer3                      ;
    BNE L8141                       ;
    LDA FrameCount                  ;Every 16th FrameCount, Change palette.-->
    AND #$0F                        ;Causes the fade in effect.
    BNE L8141                       ;
    JSR LoadPalData                 ;($8A8C)Load data into Palettes.
    BNE L8141                       ;
    LDA #$20                        ;Set timer delay for METROID flash effect.-->
    STA Timer3                      ;Delays flash by 320 frames (5.3 seconds).
    INC TitleRoutine                ;
L8141:
    RTS                             ;

LoadFlashTimer:
    LDA Timer3                      ;If 320 frames have not passed, exit
    BNE L8141                       ;
    LDA #$08                        ;
    STA Timer3                      ;Stores a value of 80 frames in Timer3-->
    INC TitleRoutine                ;(1.3 seconds).
    RTS                             ;

METROIDSparkle:
    LDA Timer3                      ;Wait until 3 seconds have passed since-->
    BNE L8162                       ;last routine before continuing.
    LDA IntroSpr0Complete           ;Check if sparkle sprites are done moving.
    AND IntroSpr1Complete           ;
    CMP #$01                        ;Is sparkle routine finished? If so,-->
    BNE L815F                       ;go to next title routine, else continue-->
    INC TitleRoutine                ;with sparkle routine.
    BNE L8162                       ;
L815F:
    JSR UpdateSparkleSprites        ;($87CF)Update sparkle sprites on the screen.
L8162:
    RTS                             ;

METROIDFadeOut:
    LDA FrameCount                  ;Wait until the frame count is a multiple-->
    AND #$07                        ;of eight before proceeding.  
    BNE L8181                       ;
    LDA FadeDataIndex               ;If FadeDataIndex is less than #$04, keep-->
    CMP #$04                        ;doing the palette changing routine.
    BNE L817E                       ;
    JSR LoadInitialSpriteData       ;($8897)Load initial sprite values for crosshair routine.
    LDA #$08                        ;
    STA Timer3                      ;Load Timer3 with a delay of 80 frames(1.3 seconds).
    STA First4SlowCntr              ;Set counter for slow sprite movement for 8 frames,
    LDA #$00                        ;
    STA SecondCrosshairSprites      ;Set SecondCrosshairSprites = #$00
    INC TitleRoutine                ;Move to next routine
L817E:
    JSR DoFadeOut                   ;($8B5F)Fades METROID off the screen.
L8181:
    RTS                             ;

Crosshairs:
    LDA FlashScreen                 ;Is it time to flash the screen white?-->
    BEQ L8189                       ;If not, branch.
    JSR FlashIntroScreen            ;($8AA7)Flash screen white.
L8189:
    LDA Timer3                      ;Wait 80 frames from last routine-->
    BNE L81D0                       ;before running this one.
    LDA IntroSpr0Complete           ;
    AND IntroSpr1Complete           ;Check if first 4 sprites have completed-->
    AND IntroSpr2Complete           ;their movements.  If not, branch.
    AND IntroSpr3Complete           ;
    BEQ L81CA                       ;
    LDA #$01                        ;Prepare to flash screen and draw cross.
    CMP SecondCrosshairSprites      ;Branch if second crosshair sprites are already--> 
    BEQ L81AB                       ;active.
    INC SecondCrosshairSprites      ;Indicates second crosshair sprites are active.
    STA DrawCross                   ;Draw cross animation on screen.
    STA FlashScreen                 ;Flash screen white.
    LDA #$00                        ;
    STA CrossDataIndex              ;Reset index to cross sprite data.
L81AB:
    AND IntroSpr4Complete           ;
    AND IntroSpr5Complete           ;Check if second 4 sprites have completed--> 
    AND IntroSpr6Complete           ;their movements.  If not, branch.
    AND IntroSpr7Complete           ;
    BEQ L81CA                       ;
    LDA #$01                        ;Prepare to flash screen and draw cross.
    STA DrawCross                   ;Draw cross animation on screen.
    STA FlashScreen                 ;Flash screen white.
    JSR LoadStarSprites             ;($98AE)Loads stars on intro screen.
    LDA #$00                        ;
    STA CrossDataIndex              ;Reset index to cross sprite data.
    INC TitleRoutine                ;Do MoreCrosshairs next frame.
    BNE L81CD                       ;Branch always.
L81CA:
    JSR DrawCrosshairsSprites       ;($88FE)Draw sprites that converge in center of screen.
L81CD:
    JSR DrawCrossSprites            ;($8976)Draw cross sprites in middle of the screen.
L81D0:
    RTS                             ;

MoreCrosshairs:
    LDA FlashScreen                 ;Is it time to flash the screen white?-->
    BEQ L81DB                       ;If not, branch.
    JSR DrawCrossSprites            ;($8976)Draw cross sprites in middle of the screen.
    JMP FlashIntroScreen            ;($8AA7)Flash screen white.
L81DB:
    INC TitleRoutine                ;ChangeIntroNameTable is next routine to run.
    LDA #$60                        ;
    STA ObjectY                     ;
    LDA #$7C                        ;These values are written into memory, but they are-->
    STA ObjectX                     ;not used later in the title routine.  This is the-->
    LDA AnimResetIndex              ;remnants of some abandoned code.
    STA AnimIndex                   ;
    RTS                             ;

UnusedIntroRoutine1:
    LDA #$01                        ;
    STA SpareMemBB                  ;
    LDA #$04                        ;
    STA SpritePagePos               ;
    STA Joy1Change                  ;
    STA Joy1Status                  ;Unused intro routine.
    STA Joy1Retrig                  ;
    LDA #$03                        ;
    STA ObjAction                   ;
    STA ScrollDir                   ;
    INC TitleRoutine                ;
    RTS                             ;

UnusedIntroRoutine2:
    LDA ObjAction                   ;
    CMP #$04                        ;
    BNE L822D                       ;
    LDA #$00                        ;
    STA ObjAction                   ;
    LDA #$0B                        ;Unused intro routine. It looks like this routine-->
    STA AnimResetIndex              ;was going to be used to manipulate sprite objects.
    LDA #$0C                        ;
    STA AnimIndex                   ;
    LDA #$07                        ;
    STA AnimFrame                   ;
    LDA #$08                        ;
    STA Timer3                      ;
    LDA #$00                        ;
    STA SpareMemC9                  ;Not accessed by game.
    STA SpareMemCB                  ;Not accessed by game.
    INC TitleRoutine                ;
L822D:
    RTS                             ;

ChangeIntroNameTable:
    LDA PPUCTRL_ZP                   ;
    ORA #$01                        ;Change to name table 1.
    STA PPUCTRL_ZP                   ;
    INC TitleRoutine                ;Next routine to run is MessageFadeIn.
    LDA #$08                        ;
    STA Timer3                      ;Set Timer3 for 80 frames(1.33 seconds).
    LDA #$06                        ;Index to FadeInPalData.
    STA FadeDataIndex               ;
    LDA #$00                        ;
    STA SpareMemC9                  ;Not accessed by game.
    RTS                             ;

MessageFadeIn:
    LDA Timer3                      ;Check if delay timer has expired.  If not, branch-->
    BNE L8262                       ;to exit, else run this rouine.
    LDA FrameCount                  ;
    AND #$07                        ;Perform next step of fade every 8th frame.
    BNE L8262                       ;
    LDA FadeDataIndex               ;
    CMP #$0B                        ;Has end of fade in palette data been reached?-->
    BNE L825F                       ;If not, branch.
    LDA #$00                        ;
    STA FadeDataIndex               ;Clear FadeDataIndex.
    LDA #$30                        ;
    STA Timer3                      ;Set Timer3 to 480 frames(8 seconds).
    INC TitleRoutine                ;Next routine is MessageFadeOut.
    BNE L8262                       ;Branch always.
L825F:
    JSR DoFadeOut                   ;($8B5F)Fade message onto screen.
L8262:
    RTS                             ;

MessageFadeOut:
    LDA Timer3                      ;Check if delay timer has expired.  If not, branch-->
    BNE L8282                       ;to exit, else run this rouine.
    LDA FrameCount                  ;
    AND #$07                        ;Perform next step of fade every 8th frame.
    BNE L8282                       ;
    LDA FadeDataIndex               ;
    CMP #$05                        ;Has end of fade out palette data been reached?-->
    BNE L827F                       ;If not, branch.
    LDA #$06                        ;
    STA FadeDataIndex               ;Set index to start of fade in data.
    LDA #$00                        ;
    STA SpareMemCB                  ;Not accessed by game.
    INC TitleRoutine                ;Next routine is DelayIntroReplay.
    BNE L8282                       ;Branch always.
L827F:
    JSR DoFadeOut                   ;($8B5F)Fade message off of screen.
L8282:
    RTS                             ;

DelayIntroReplay:
    INC TitleRoutine                ;Increment to next routine.
    LDA #$10                        ;
    STA Timer3                      ;Set Timer3 for a delay of 160 frames(2.6 seconds).
    RTS                             ;

UnusedIntroRoutine3:
    LDA Timer3                      ;
    BNE L82A2                       ;
    LDA SpareMemB7                  ;
    BNE L82A2                       ;
    LDA SpareMemB8                  ;
    AND #$0F                        ;Unused intro routine.
    BNE L82A2                       ;
    LDA #$01                        ;
    STA SpareMemD2                  ;
    LDA #$10                        ;
    STA Timer3                      ;
    INC TitleRoutine                ;
L82A2:
    RTS                             ;

PrepIntroRestart:
    LDA Timer3                      ;Check if delay timer has expired.  If not, branch-->
    BNE L82E9                       ;to exit, else run this rouine.
    STA SpareMemD2                  ;Not accessed by game.
    STA SpareMemBB                  ;Not accessed by game.
    STA IsSamus                     ;Clear IsSamus memory address.
    LDY #$1F                        ;
L82AF:
    STA ObjAction,Y                 ;
    DEY                             ;Clear RAM $0300 thru $031F.
    BPL L82AF                       ;
    LDA PPUCTRL_ZP                   ;Change to name table 0.
    AND #$FC                        ;
    STA PPUCTRL_ZP                   ;
    INY                             ;Y=0.
    STY SpareMemB7                  ;Accessed by unused routine.
    STY SpareMemB8                  ;Accessed by unused routine.
    STY PalDataIndex                ;
    STY ScreenFlashPalIndex         ;Clear all index values from these addresses.
    STY IntroStarOffset             ;
    STY FadeDataIndex               ;
    STY SpareMemCD                  ;Not accessed by game.
    STY Joy1Change                  ;
    STY Joy1Status                  ;Clear addresses that were going to be written to by an-->
    STY Joy1Retrig                  ;unused intro routine.
    STY SpareMemD7                  ;Not accessed by game.
    INY                             ;Y=1.
    STY SpareMemCE                  ;Not accessed by game.
    INY                             ;Y=2.
    STY SpareMemCC                  ;Not accessed by game.
    STY SpareMemCF                  ;Not accessed by game.
    STY TitleRoutine                ;Next routine sets up METROID fade in delay.
    LDA IntroMusicRestart           ;Check to see if intro music needs to be restarted.-->
    BNE L82EA                       ;Branch if not.
    LDA #$10                        ;
    STA MultiSFXFlag                ;Restart intro music.
    LDA #$02                        ;Set restart of intro music after another two cycles-->
    STA IntroMusicRestart           ;of the title routines.
L82E9:
    RTS                             ;
 
L82EA:
    DEC IntroMusicRestart           ;One title routine cycle complete. Decrement intro-->
    RTS                             ;music restart counter.

TitleScreenOff:
    JSR ScreenOff                   ;($C439)Turn screen off.
    INC TitleRoutine                ;Next routine is TitleRoutineReturn.
    RTS                             ;This routine should not be reached.

TitleRoutineReturn:
    RTS                             ;Last title routine function. Should not be reached.

;The following data fills name table 0 with the intro screen background graphics.
L82F4:
    ;Information to be stored in attribute table 0.
    .byte $23                       ;PPU address high byte.
    .byte $C0                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF 
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

    .byte $23                       ;PPU address high byte.
    .byte $E0                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $FF, $FF, $BF, $AF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    ;Writes row $22E0 (24th row from top).
    .byte $22                       ;PPU address high byte.
    .byte $E0                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

    ;Writes row $2300 (25th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $00                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81
    .byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

    ;Writes row $2320 (26th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $20                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83
    .byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

    ;Writes row $2340 (27th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $40                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85
    .byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

    ;Writes row $2360 (28th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $60                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87
    .byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

    ;Writes row $2380 (29th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $80                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89
    .byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

    ;Writes row $23A0 (Bottom row).
    .byte $23                       ;PPU address high byte.
    .byte $A0                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B
    .byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

    ;Writes some blank spaces in row $20A0 (6th row from top).
    PPUStringRepeat $20A8, ' ', $0F

    ;Writes METROID graphics in row $2100 (9th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $03                       ;PPU address low byte.
    .byte $1C                       ;PPU string length.
    .byte $40, $5D, $56, $5D, $43, $40, $5D, $43, $40, $5D, $5D, $43, $40, $5D, $5D, $63
    .byte $62, $5D, $5D, $63, $40, $43, $40, $5D, $5D, $63, $1D, $16

    ;Writes METROID graphics in row $2120 (10th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $23                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $44, $50, $50, $50, $47, $44, $57, $58, $74, $75, $76, $77, $44, $57, $69, $47
    .byte $44, $57, $69, $47, $44, $47, $44, $68, $69, $47

    ;Writes METROID graphics in row $2140 (11th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $43                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $44, $41, $7E, $49, $47, $44, $59, $5A, $78, $79, $7A, $7B, $44, $59, $6D, $70
    .byte $44, $73, $72, $47, $44, $47, $44, $73, $72, $47

    ;Writes METROID graphics in row $2160 (12th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $63                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $44, $42, $7F, $4A, $47, $44, $5B, $5C, $FF, $44, $47, $FF, $44, $5B, $6F, $71
    .byte $44, $45, $46, $47, $44, $47, $44, $45, $46, $47

    ;Writes METROID graphics in row $2180 (13th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $83                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $44, $47, $FF, $44, $47, $44, $5F, $60, $FF, $44, $47, $FF, $44, $7D, $7C, $47
    .byte $44, $6A, $6B, $47, $44, $47, $44, $6A, $6B, $47

    ;Writes METROID graphics in row $21A0 (14th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $A3                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $4C, $4F, $FF, $4C, $4F, $4C, $5E, $4F, $FF, $4C, $4F, $FF, $4C, $4D, $4E, $4F
    .byte $66, $5E, $5E, $64, $4C, $4F, $4C, $5E, $5E, $64

    ;Writes METROID graphics in row $21C0 (15th row from top).
    .byte $21                       ;PPU address high byte.
    .byte $C3                       ;PPU address low byte.
    .byte $1A                       ;PPU string length.
    .byte $51, $52, $FF, $51, $52, $51, $61, $52, $FF, $51, $52, $FF, $51, $53, $54, $52
    .byte $67, $61, $61, $65, $51, $52, $51, $61, $61, $65

    ;Writes PUSH START BUTTON in row $2220 (18th row from top).
    PPUString $2227, " PUSH START BUTTON   "

    ;Writes C 1986 NINTENDO in row $2260 (20th row from top).
    PPUString $2269, "< 1986 NINTENDO   "

;The following data fills name table 1 with the intro screen background graphics.

    ;Information to be stored in attribute table 1.
    .byte $27                       ;PPU memory high byte.
    .byte $C0                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

    ;Writes row $27E0 (24th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $E0                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    ;Writes row $26E0 (24th row from top).
    .byte $26                       ;PPU memory high byte.
    .byte $E0                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

    ;Writes row $2700 (25th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $00                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81
    .byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

    ;Writes row $2720 (26th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $20                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83
    .byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

    ;Writes row $2740 (27th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $40                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85
    .byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

    ;Writes row $2760 (28th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $60                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87
    .byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

    ;Writes row $2780 (29th row from top).
    .byte $27                       ;PPU memory high byte.
    .byte $80                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89
    .byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

    ;Writes row $27A0 (bottom row).
    .byte $27                       ;PPU memory high byte.
    .byte $A0                       ;PPU memory low byte.
    .byte $20                       ;PPU string length.
    .byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B
    .byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

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
L8759:  .byte "ERROR TRY AGAIN"

;If the error message above is not being displayed on the password 
;screen, the following fifteen blanks spaces are used to cover it up.
L8768:  .byte "               "

;Not used.
    .byte $79, $87, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
    .byte $00, $03, $A1, $87, $A2, $87, $A5, $87, $A8, $87, $00, $18, $CC, $00, $18, $CD
    .byte $00, $18, $CE, $00 

LoadSparkleData:
    LDX #$0A                        ;
    L87AD:
        LDA InitSparkleDataTbl,X        ;
        STA IntroSpr0YCoord,X           ;Loads $6EA0 thru $6EAA with the table below.
        STA IntroSpr1YCoord,X           ;Loads $6EB0 thru $6EBA with the table below.
        DEX                             ;
        BPL L87AD                       ;Loop until all values from table below are loaded.
    LDA #$6B                        ;
    STA IntroSpr1YCoord             ;$6EA0 thru $6EAA = #$3C, #$C6, #$01, #$18, #$00,-->
    LDA #$DC                        ;#$00, #$00, #$00, #$20, #$00, #$00, initial.
    STA IntroSpr1XCoord             ;$6EB0 thru $6EBA = #$6B, #$C6, #$01, #$DC, #$00,-->
    RTS                             ;#$00, #$00, #$00, #$20, #$00, #$00, initial.

;Used by above routine to load Metroid initial sparkle data into $6EA0
;thru $6EAA and $6EB0 thru $6EBA.

InitSparkleDataTbl:
L87C4:  .byte $3C, $C6, $01, $18, $00, $00, $00, $00, $20, $00, $00

UpdateSparkleSprites:
    LDX #$00                        ;
    JSR DoOneSparkleUpdate          ;($87D6)Performs calculations on top sparkle sprite.
    LDX #$10                        ;Performs calculations on bottom sparkle sprite.

DoOneSparkleUpdate:
    JSR SparkleUpdate               ;($87D9)Update sparkle sprite data.

SparkleUpdate:
    LDA IntroSpr0NextCntr,X         ;If $6EA5 has not reached #$00, skip next routine.
    BNE L87E1                       ;
        JSR DoSparkleSpriteCoord        ;($881A)Update sparkle sprite screen position.
    L87E1:
    LDA IntroSpr0Complete,X         ;
    BNE L8819                       ;If sprite is already done, skip routine.
    DEC IntroSpr0NextCntr,X         ;

    LDA SparkleSpr0YChange,X        ;
    CLC                             ;
    ADC IntroSpr0YCoord,X           ;Updates sparkle sprite Y coord.
    STA IntroSpr0YCoord,X           ;

    LDA SparkleSpr0XChange,X        ;                       
    CLC                             ;
    ADC IntroSpr0XCoord,X           ;Updates sparkle sprite X coord.
    STA IntroSpr0XCoord,X           ;

    DEC IntroSpr0ChngCntr,X         ;Decrement IntroSpr0ChngCntr. If 0, time to change-->
    BNE L8816                       ;sprite graphic.
        LDA IntroSpr0PattTbl,X          ;
        EOR #$03                        ;If IntroSpr0ChngCntr=$00, the sparkle sprite graphic is-->
        STA IntroSpr0PattTbl,X          ;changed back and forth between pattern table-->
        LDA #$20                        ;graphic $C6 and $C7.  IntroSpr0ChngCntr is reset to #$20.
        STA IntroSpr0ChngCntr,X         ;
        ASL                             ;
        EOR IntroSpr0Cntrl,X            ;Flips pattern at $C5 in pattern table--> 
        STA IntroSpr0Cntrl,X            ;horizontally when displayed.
    L8816:
    JMP WriteIntroSprite            ;($887B)Transfer sprite info into sprite RAM.
L8819:
    RTS                             ;

DoSparkleSpriteCoord:
    TXA                             ;
    JSR Adiv8                       ;($C2C0)Y=0 when working with top sparkle sprite-->
    TAY                             ;and y=2 when working with bottom sparkle sprite.
    LDA SparkleAddressTbl,Y         ;Base is $89AF.
    STA $00                         ;When working with top sparkle sprite, E1,E0=$89B3-->
    LDA SparkleAddressTbl+1,Y       ;and when botton sparkle sprite, E1,E0=$89E9.
    STA $01                         ;
    LDY IntroSpr0Index,X            ;Loads index for finding sparkle data (x=$00 or $10).
    LDA ($00),Y                     ;
    BPL L8835                       ;If data byte MSB is set, set $6EA9 to #$01 and move to-->
        LDA #$01                        ;next index for sparkle sprite data.
        STA IntroSpr0ByteType,X         ;
    L8835:
    BNE L883C                       ;
        LDA #$01                        ;If value is equal to zero, sparkle sprite-->
        STA IntroSpr0Complete,X         ;processing is complete.
    L883C:
    STA IntroSpr0NextCntr,X         ;
    INY                             ;
    LDA ($00),y                     ;Get x/y position byte.
    DEC IntroSpr0ByteType,X         ;If MSB of second byte is set, branch.
    BMI L8850                       ;
        LDA #$00                        ;This code is run when the MSB of the first byte-->
        STA SparkleSpr0YChange,X        ;is set.  This allows the sprite to change X coord-->
        LDA ($00),Y                     ;by more than 7.  Ensures Y coord does not change.
        BMI L8867                       ;
    L8850:
        PHA                             ;Store value twice so X and Y-->
        PHA                             ;coordinates can be extracted.
        LDA #$00                        ;
        STA IntroSpr0ByteType,X         ;Set IntroSpr0ByteType to #$00 after processing.
        PLA                             ;
        JSR Adiv16                      ;($C2BF)Move upper 4 bits to lower 4 bits.
        JSR NibbleSubtract              ;($8871)Check if nibble to be converted to twos compliment.
        STA SparkleSpr0YChange,X        ;Twos compliment stored if Y coord decreasing.
        PLA                             ;
        AND #$0F                        ;Discard upper 4 bits.
        JSR NibbleSubtract              ;($8871)Check if nibble to be converted to twos compliment.
    L8867:
    STA SparkleSpr0XChange,X        ;Store amount to move spite in x direction.
    INC IntroSpr0Index,X            ;
    INC IntroSpr0Index,X            ;Add two to find index for next data byte.
    RTS                             ;

NibbleSubtract:
    CMP #$08                        ;If bit 3 is set, nibble is a negative number-->
    BCC L887A                       ;and lower three bits are converted to twos-->
    AND #$07                        ;compliment for subtraction, else exit.
    JSR TwosCompliment              ;($C3D4)Prepare for subtraction with twos compliment.
L887A:
    RTS                             ;

WriteIntroSprite:
    LDA IntroSpr0YCoord,X           ;
    SEC                             ;Subtract #$01 from first byte to get proper y coordinate.
    SBC #$01                        ;
    STA Sprite04RAM,X               ;
    LDA IntroSpr0PattTbl,X          ;
    STA Sprite04RAM+1,X             ;Load the four bytes for the-->
    LDA IntroSpr0Cntrl,X            ;intro sprites into sprite RAM.
    STA Sprite04RAM+2,X             ;
    LDA IntroSpr0XCoord,X           ;
    STA Sprite04RAM+3,X             ;
    RTS                             ;
 
LoadInitialSpriteData:
    LDA #$20                        ;
    STA Second4Delay                ;Set delay for second 4 sprites to 32 frames.
    LDX #$3F                        ;Prepare to loop 64 times.

    L889D:
        LDA Sprite0and4InitTbl,X        ;Load data from tables below.
        CMP $FF                         ;If #$FF, skip loading that byte and move to next item.
        BEQ L88AA                       ;
            STA IntroSpr0YCoord,X           ;Store initial values for sprites 0 thru 3.
            STA IntroSpr4YCoord,X           ;Store initial values for sprites 4 thru 7.
        L88AA:
        DEX                             ;
        BPL L889D                       ;Loop until all data is loaded.

    LDA #$B8                        ;Special case for sprite 6 and 7.
    STA IntroSpr6YCoord             ;
    STA IntroSpr7YCoord             ;Change sprite 6 and 7 initial y position.
    LDA #$16                        ;
    STA IntroSpr6YRise              ;Change sprite 6 and 7 y displacement. The combination-->
    STA IntroSpr7YRise              ;of these two changes the slope of the sprite movement.
    RTS                             ;
 
;The following tables are loaded into RAM as initial sprite control values for the crosshair sprites.

Sprite0and4InitTbl:
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

Sprite1and5InitTbl:
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

Sprite2and6InitTbl:
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

Sprite3and7InitTbl:
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

DrawCrosshairsSprites:
    LDA First4SlowCntr              ;
    BEQ L8936                       ;Has First4SlowCntr already hit 0? If so, branch.
    DEC First4SlowCntr              ;
    BNE L8936                       ;Is First4SlowCntr now equal to 0? if not, branch.
    ASL IntroSpr0XRun               ;
    ASL IntroSpr0YRise              ;
    ASL IntroSpr1XRun               ;
    ASL IntroSpr1YRise              ;
    ASL IntroSpr2XRun               ;
    ASL IntroSpr2YRise              ;
    ASL IntroSpr3XRun               ;Multiply the rise and run of the 8 sprites by 2.-->
    ASL IntroSpr3YRise              ;This doubles their speed.
    ASL IntroSpr4XRun               ;
    ASL IntroSpr4YRise              ;
    ASL IntroSpr5XRun               ;
    ASL IntroSpr5YRise              ;
    ASL IntroSpr6XRun               ;
    ASL IntroSpr6YRise              ;
    ASL IntroSpr7XRun               ;
    ASL IntroSpr7YRise              ;
L8936:
    LDX #$00                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 0.
    LDX #$10                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 1.
    LDX #$20                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 2.
    LDX #$30                        ;
    LDA Second4Delay                ;Check to see if the delay to start movement of the second-->
    BEQ L894F                       ;4 sprites has ended.  If so, start drawing those sprites.
    DEC Second4Delay                ;
    BNE DoSpriteMovement            ;
L894F:
    JSR DoSpriteMovement            ;($8963)Move sprite 3.
    LDX #$40                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 4.
    LDX #$50                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 5.
    LDX #$60                        ;
    JSR DoSpriteMovement            ;($8963)Move sprite 6.
    LDX #$70                        ;($8963)Move sprite 7.

DoSpriteMovement:
    LDA IntroSpr0Complete,X         ;If the current sprite has finished-->
    BNE L8975                       ;its movements, exit this routine.
    JSR UpdateSpriteCoords          ;($981E)Calculate new sprite position.
    BCS L8972                       ;If sprite not at final position, branch to move next frame.
    LDA #$01                        ;Sprite movement complete.
    STA IntroSpr0Complete,X         ;
L8972:
    JMP WriteIntroSprite            ;($887B)Write sprite data to sprite RAM.
L8975:
    RTS                             ;

DrawCrossSprites:
    LDA DrawCross                   ;If not ready to draw crosshairs,-->
    BEQ L89A9                       ;branch to exit.
    LDY CrossDataIndex              ;
    CPY #$04                        ;Check to see if at last index in table.  If so, branch-->
    BCC L8986                       ;to draw cross sprites.
    BNE L89A9                       ;If beyond last index, branch to exit.
    LDA #$00                        ;
    STA DrawCross                   ;If at last index, clear indicaor to draw cross sprites.
L8986:
    LDA CrossSpriteIndexTbl,Y       ;
    STA $00                         ;
    LDY #$00                        ;Reset index into CrossSpriteDataTbl

L898D:
    LDX CrossSpriteDataTbl,Y        ;Get offet into sprite RAM to load sprite.
    INY                             ;
L8991:
    LDA CrossSpriteDataTbl,Y        ;Get sprite data byte.
    STA Sprite00RAM,X               ;Store byte in sprite RAM.
    INX                             ;Move to next sprite RAM address.
    INY                             ;Move to next data byte in table.
    TXA                             ;
    AND #$03                        ;Is new sprite position reached?-->
    BNE L8991                       ;if not, branch to load next sprite data byte.
    CPY $00                         ;Has all the sprites been loaded for cross graphic?-->
    BNE L898D                       ;If not, branch to load next set of sprite data.

    LDA FrameCount                  ;
    LSR                             ;Increment index into CrossSpriteIndexTbl every-->
    BCC L89A9                       ;other frame.  This updates the cross sprites-->
    INC CrossDataIndex              ;every two frames.
L89A9:
    RTS                             ;

;The following table tells the routine above how many data bytes to load from CrossSpriteDataTbl.
;The more data that is loaded, the bigger the cross that is drawn on the screen.  The table below
;starts the cross out small, it then grows bigger and gets small again.

CrossSpriteIndexTbl:
L89AA: .byte $05, $19, $41, $19, $05 

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

;The following table is used by the DrawCrossSprites routine to draw the sprites on the screen that
;make up the cross that appears during the Crosshairs routine.  The single byte is the index into
;the sprite RAM where the sprite data is to be written.  The 4 bytes that follow it are the actual
;sprite data bytes.

CrossSpriteDataTbl:
L8A4B:  .byte $10                       ;Load following sprite data into Sprite04RAM.
L8A4C:  .byte $5A, $C0, $00, $79        ;Sprite data.
L8A50:  .byte $14                       ;Load following sprite data into Sprite05RAM.
L8A51:  .byte $52, $C8, $00, $79        ;Sprite data.
L8A55:  .byte $18                       ;Load following sprite data into Sprite06RAM.
L8A56:  .byte $5A, $C2, $40, $71        ;Sprite data.
L8A5A:  .byte $1C                       ;Load following sprite data into Sprite07RAM.
L8A5B:  .byte $5A, $C2, $00, $81        ;Sprite data.
L8A5F:  .byte $20                       ;Load following sprite data into Sprite08RAM.
L8A60:  .byte $62, $C8, $80, $79        ;Sprite data.
L8A64:  .byte $14                       ;Load following sprite data into Sprite05RAM.
L8A65:  .byte $52, $C9, $00, $79        ;Sprite data.
L8A69:  .byte $18                       ;Load following sprite data into Sprite06RAM.
L8A6A:  .byte $5A, $C1, $00, $71        ;Sprite data.
L8A6E:  .byte $1C                       ;Load following sprite data into Sprite07RAM.
L8A6F:  .byte $5A, $C1, $00, $81        ;Sprite data.
L8A73:  .byte $20                       ;Load following sprite data into Sprite08RAM.
L8A74:  .byte $62, $C9, $00, $79        ;Sprite data.
L8A78:  .byte $24                       ;Load following sprite data into Sprite09RAM.
L8A79:  .byte $4A, $C8, $00, $79        ;Sprite data.
L8A7D:  .byte $28                       ;Load following sprite data into Sprite0ARAM.
L8A7E:  .byte $5A, $C2, $40, $69        ;Sprite data.
L8A82:  .byte $2C                       ;Load following sprite data into Sprite0BRAM.
L8A83:  .byte $5A, $C2, $00, $89        ;Sprite data.
L8A87:  .byte $30                       ;Load following sprite data into Sprite0CRAM.
L8A88:  .byte $6A, $C8, $80, $79        ;Sprite data.

LoadPalData:
    lDY PalDataIndex                ;
    LDA PalSelectTbl,Y              ;Chooses which set of palette data-->
    CMP #$FF                        ;to load from the table below.
    BEQ L8A99                       ;
    STA PalDataPending              ;Prepare to write palette data.
    INC PalDataIndex                ;
L8A99:
    RTS                             ;

;The table below is used by above routine to pick the proper palette.

PalSelectTbl:
    .byte $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0C, $FF

FlashIntroScreen:
    LDY ScreenFlashPalIndex         ;Load index into table below.
    LDA ScreenFlashPalTbl,Y         ;Load palette data byte.
    CMP #$FF                        ;Has the end of the table been reached?-->
    BNE L8AB8                       ;If not, branch.
    LDA #$00                        ;
    STA ScreenFlashPalIndex         ;Clear screen flash palette index and reset-->
    STA FlashScreen                 ;screen flash control address.
    BEQ L8ABC                       ;Branch always.
L8AB8:
    STA PalDataPending              ;Store palette change data.
    INC ScreenFlashPalIndex         ;Increment index into table below.
L8ABC:
    RTS                             ;

ScreenFlashPalTbl:
    .byte $11, $01, $11, $01, $11, $11, $01, $11, $01, $FF

;----------------------------------[ Intro star palette routines ]-----------------------------------

StarPalSwitch:
    LDA FrameCount                  ;
    AND #$0F                        ;Change star palette every 16th frame.
    BNE L8AD2                       ;
    LDA PPUStrIndex                 ;
    BEQ L8AD3                       ;Is any other PPU data waiting? If so, exit.
L8AD2:
    RTS                             ;

L8AD3:
    LDA #$19                        ;
    STA $00                         ;Prepare to write to the sprite palette-->
    LDA #$3F                        ;starting at address $3F19.
    STA $01                         ;
    LDA IntroStarOffset             ;Use only first 3 bits of byte since the pointer-->
    AND #$07                        ;table only has 8 entries.
    ASL                             ;*2 to find entry in IntroStarPntr table.
    TAY                             ; 
    LDA IntroStarPntr,Y             ;Stores starting address of palette data to write-->
    STA $02                         ;into $02 and $03 from IntroStarPntr table.
    LDA IntroStarPntr+1,Y           ;
    STA $03                         ;
    INC IntroStarOffset             ;Increment index for next palette change.
    JSR PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.
    LDA #$1D                        ;
    STA $00                         ;
    LDA #$3F                        ;Prepare another write to the sprite palette.-->
    STA $01                         ;This tie starting at address $3F1D.
    INY                             ;
    JSR AddYToPtr02                 ;($C2B3)Find new data base of palette data.
    JMP PrepPPUPaletteString        ;($C37E)Prepare and write new palette data.

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
    LDY FadeDataIndex               ;Load palette data from table below.
    LDA FadeOutPalData,Y            ;
    CMP #$FF                        ;If palette data = #$FF, exit.
    BEQ L8B6C                       ;
    STA PalDataPending              ;Store new palette data.
    INC FadeDataIndex               ;
L8B6C:
    RTS                             ;

FadeOutPalData:
    .byte $0D, $0E, $0F, $10, $01, $FF

FadeInPalData:
    .byte $01, $10, $0F, $0E, $0D, $FF

;----------------------------------------[ Password routines ]---------------------------------------

ProcessUniqueItems:
    LDA NumberOfUniqueItems         ;
    STA $03                         ;Store NumberOfUniqueItems at $03.
    LDY #$00                        ;
    STY $04                         ;Set $04 to #$00.
L8B82:
    LDY $04                         ;Use $04 at index into unique itme list.                        
    INY                             ;
    LDA UniqueItemHistory-1,Y       ;
    STA $00                         ;Load the two bytes representing the aquired-->
    INY                             ;Unique item and store them in $00 and $01.
    LDA UniqueItemHistory-1,Y       ;
    STA $01                         ;
    STY $04                         ;Increment $04 by two (load unique item complete).
    JSR UniqueItemSearch            ;($8B9C)Find unique item.
    LDY $04                         ;
    CPY $03                         ;If all unique items processed, return, else-->
    BCC L8B82                       ;branch to process next unique item.
    RTS                             ;

UniqueItemSearch:
    LDX #$00                        ;
L8B9E:
    TXA                             ;Transfer X to A(Item number).
    ASL                             ;Multiply by 2.
    TAY                             ;Store multiplied value in y.
    LDA ItemData,Y                  ;Load unique item reference starting at $9029(2 bytes).
    CMP $00                         ;
    BNE L8BAF                       ;
    LDA ItemData+1,Y                ;Get next byte of unique item.
    CMP $01                         ;
    BEQ UniqueItemFound             ;If unique item found, branch to UniqueItemFound.
L8BAF:
    INX                             ;
    CPX #$3C                        ;If the unque item is a Zeebetite, return-->
    BCC L8B9E                       ;else branch to find next unique item.
    RTS                             ;

;The following routine sets the item bits for aquired items in addresses $6988 thru $698E.-->
;Items 1 thru 7 masked in $6988, 8 thru 15 in $6989, etc.

UniqueItemFound:
    TXA                             ;
    JSR Adiv8                       ;($C2C0)Divide by 8.
    STA $05                         ;Shifts 5 MSBs to LSBs of item # and saves results in $05.
    JSR Amul8                       ;($C2C6)Multiply by 8.
    STA $02                         ;Restores 5 MSBs of item # and drops 3 LSBs; saves in $02.
    TXA                             ;
    SEC                             ;
    SBC $02                         ;
    STA $06                         ;Remove 5 MSBs and stores 3 LSBs in $06.
    LDX $05                         ;
    LDA PasswordByte00,X            ;
    LDY $06                         ;
    ORA PasswordBitmaskTbl,Y        ;
    STA PasswordByte00,X            ;Masks each unique item in the proper item address-->
    RTS                             ;(addresses $6988 thru $698E).

LoadUniqueItems:
    LDA #$00                        ;
    STA NumberOfUniqueItems         ;
    STA $05                         ;$05 offset of password byte currently processing(0 thru 7).
    STA $06                         ;$06 bit of password byte currently processing(0 thru 7).
    LDA #$3B                        ;
    STA $07                         ;Maximum number of unique items(59 or #$3B).
    LDY $05                         ;
    LDA PasswordByte00,Y            ;
    STA $08                         ;$08 stores contents of password byte currently processing.
    LDX #$00                        ;
    STX $09                         ;Stores number of unique items processed(#$0 thru #$3B).
    LDX $06                         ;
    BEQ ProcessNewItemByte          ;If start of new byte, branch.

    LDX #$01                        ;
    STX $02                         ;
    CLC                             ;
    L8BF5:
        ROR                             ;
        STA $08                         ;This code does not appear to ever be executed.
        LDX $02                         ;
        CPX $06                         ;
        BEQ ProcessNewItemByte          ;
        INC $02                         ;
        JMP L8BF5                       ;

ProcessNextItem:
    LDY $05                         ;Locates next password byte to process-->
    LDA PasswordByte00,Y            ;and loads it into $08.
    STA $08                         ;

ProcessNewItemByte:
    LDA $08                         ;
    ROR                             ;Rotates next bit to be processed to the carry flag.
    STA $08                         ;
    BCC L8C14                       ;
        JSR SamusHasItem                ;($8C39)Store item in unique item history.
    L8C14:
    LDY $06                         ;If last bit of item byte has been--> 
    CPY #$07                        ;checked, move to next byte.
    BCS L8C27                       ;
    INC $06                         ;
    INC $09                         ;
    LDX $09                         ;If all 59 unique items have been--> 
    CPX $07                         ;searched through, exit.
    BCS L8C38                       ;
    JMP ProcessNewItemByte          ;($8C0A)Repeat routine for next item byte.

L8C27:
    LDY #$00                        ;
    STY $06                         ;
    INC $05                         ;
    INC $09                         ;
    LDX $09                         ;If all 59 unique items have been--> 
    CPX $07                         ;searched through, exit.
    BCS L8C38                       ;
    JMP ProcessNextItem             ;($8C03)Process next item.

L8C38:
    RTS                             ;
 
SamusHasItem:
    LDA $05                         ;$05 becomes the upper part of the item offset-->
    JSR Amul8                       ;while $06 becomes the lower part of the item offset.
    CLC                             ;
    ADC $06                         ;
    ASL                             ;* 2. Each item is two bytes in length.
    TAY                             ;
    LDA ItemData+1,Y                ;
    STA $01                         ;$00 and $01 store the two bytes of--> 
    LDA ItemData,Y                  ;the unique item to process.
    STA $00                         ;
    LDY NumberOfUniqueItems         ;
    STA UniqueItemHistory,Y         ;Store the two bytes of the unique item-->
    LDA $01                         ;in RAM in the unique item history.
    INY                             ; 
    STA UniqueItemHistory,Y         ;
    INY                             ;
    STY NumberOfUniqueItems         ;Keeps a running total of unique items.
    RTS                             ;

CheckPassword:
    JSR ConsolidatePassword         ;($8F60)Convert password characters to password bytes.
    JSR ValidatePassword            ;($8DDE)Verify password is correct.
    BCS L8C69                       ;Branch if incorrect password.
        JMP InitializeGame              ;($92D4)Preliminary housekeeping before game starts.
    L8C69:
    LDA MultiSFXFlag                ;
    ORA #$01                        ;Set IncorrectPassword SFX flag.
    STA MultiSFXFlag                ;
    LDA #$0C                        ;
    STA Timer3                      ;Set Timer3 time for 120 frames (2 seconds).
    LDA #$18                        ;
    STA TitleRoutine                ;Run EnterPassword routine.
    RTS                             ;

CalculatePassword:
    LDA #$00                        ;
    LDY #$0F                        ;Clears values at addresses -->
    L8C7E:
        STA PasswordByte00,Y            ;$6988 thru $6997 and -->
        STA PasswordChar00,Y            ;$699A thru $69A9.
        DEY                             ;
        BPL L8C7E                       ;
    JSR ProcessUniqueItems          ;($8B79)Determine what items Samus has collected.
    LDA PasswordByte07              ;
    AND #$04                        ;Check to see if mother brain has been defeated,-->
    BEQ L8C9E                       ;If so, restore mother brain, zeebetites and-->
        LDA #$00                        ;all missile doors in Tourian as punishment for-->
        STA PasswordByte07              ;dying after mother brain defeated. Only reset in the-->
        LDA PasswordByte06              ;password.  Continuing without resetting will not-->
        AND #$03                        ;restore those items.
        STA PasswordByte06              ;
    L8C9E:
    LDA InArea                      ;Store InArea in bits 0 thru 5 in-->
    AND #$3F                        ;address $6990.
    LDY JustInBailey                ;
    BEQ L8CA9                       ;
        ORA #$80                        ;Sets MSB of $6990 is Samus is suitless.
    L8CA9:
    STA PasswordByte08              ;
    LDA SamusGear                   ;
    STA PasswordByte09              ;SamusGear stored in $6991.
    LDA MissileCount                ;
    STA PasswordByte0A              ;MissileCount stored in $6992.
    LDA #$00                        ;
    STA $00                         ;
    LDA KraidStatueStatus           ;
    AND #$80                        ;
    BEQ L8CC9                       ;If statue not up, branch.
        LDA $00                         ;
        ORA #$80                        ;Set bit 7 of $00--> 
        STA $00                         ;if Kraid statue up.
    L8CC9:
    LDA KraidStatueStatus           ;
    AND #$01                        ;
    BEQ L8CD6                       ;Branch if Kraid not yet defeated.
        LDA $00                         ;
        ORA #$40                        ;Set bit 6 of $00-->
        STA $00                         ;If Kraid defeated.
    L8CD6:
    LDA RidleyStatueStatus          ;
    AND #$80                        ;
    BEQ L8CE3                       ;Branch if Ridley statue not up.
        LDA $00                         ;
        ORA #$20                        ;Set bit 5 of $00-->
        STA $00                         ;if Ridley statue up.
    L8CE3:
    LDA RidleyStatueStatus          ;
    AND #$02                        ;
    BEQ L8CF0                       ;Branch if Ridley not yet defeated.
        LDA $00                         ;
        ORA #$10                        ;Set bit 4 of $00-->
        STA $00                         ;if Ridley defeated.
    L8CF0:
    LDA $00                         ;
    STA PasswordByte0F              ;Stores statue statuses in 4 MSB at $6997.
    LDY #$03                        ;
    L8CF7:
        LDA SamusAge,Y                  ;Store SamusAge in $6993,-->
        STA PasswordByte0B,Y            ;SamusAge+1 in $6994 and-->
        DEY                             ;SamusAe+2 in $6995.
        BPL L8CF7                       ;
    L8D00:
        JSR $C000                       ;
        LDA RandomNumber1               ;
        AND #$0F                        ;Store the value of $2E at $6998-->
        BEQ L8D00                       ;When any of the 4 LSB are set. (Does not-->
    STA PasswordByte10              ;allow RandomNumber1 to be a multiple of 16).
    JSR PasswordChecksumAndScramble ;($8E17)Calculate checksum and scramble password.
    JMP LoadPasswordChar            ;($8E6C)Calculate password characters.

LoadPasswordData:
    LDA NARPASSWORD                 ;If invincible Samus active, skip-->
    BNE L8D3C                       ;further password processing.
    JSR LoadUniqueItems             ;($8BD4)Load unique items from password.
    JSR LoadTanksAndMissiles        ;($8D3D)Calculate number of missiles from password.
    LDY #$00                        ;
    LDA PasswordByte08              ;If MSB in PasswordByte08 is set,-->
    AND #$80                        ;Samus is not wearing her suit.
    BEQ L8D27                       ;                       
        INY                             ;
    L8D27:
    STY JustInBailey                ;
    LDA PasswordByte08              ;Extract first 5 bits from PasswordByte08-->
    AND #$3F                        ;and use it to determine starting area.
    STA InArea                      ;
    LDY #$03                        ;
    L8D33:
        LDA PasswordByte0B,Y            ;Load Samus' age.
        STA SamusAge,Y                  ;
        DEY                             ;
        BPL L8D33                       ;Loop to load all 3 age bytes.
L8D3C:
    RTS                             ;
 
LoadTanksAndMissiles:
    LDA PasswordByte09              ;Loads Samus gear.
    STA SamusGear                   ;Save Samus gear.
    LDA PasswordByte0A              ;Loads current number of missiles.
    STA MissileCount                ;Save missile count.
    LDA #$00                        ;
    STA $00                         ;
    STA $02                         ;
    LDA PasswordByte0F              ;
    AND #$80                        ;If MSB is set, Kraid statue is up.
    BEQ L8D5C                       ;
        LDA $00                         ;
        ORA #$80                        ;If Kraid statue is up, set MSB in $00.
        STA $00                         ;
    L8D5C:
    LDA PasswordByte0F              ;
    AND #$40                        ;If bit 6 is set, Kraid is defeated.
    BEQ L8D69                       ;
        LDA $00                         ;
        ORA #$01                        ;If Kraid is defeated, set LSB in $00.
        STA $00                         ;
    L8D69:
    LDA $00                         ;
    STA KraidStatueStatus           ;Store Kraid status.
    LDA PasswordByte0F              ;
    AND #$20                        ;If bit 5 is set, Ridley statue is up.
    BEQ L8D7B                       ;
        LDA $02                         ;
        ORA #$80                        ;If Ridley statue is up, set MSB in $02.
        STA $02                         ;
    L8D7B:
    LDA PasswordByte0F              ;
    AND #$10                        ;If bit 4 is set, Ridley is defeated.
    BEQ L8D88                       ;
        LDA $02                         ;
        ORA #$02                        ;If Ridley is defeated, set bit 1 of $02.
        STA $02                         ;
    L8D88:
    LDA $02                         ;
    STA RidleyStatueStatus          ;Store Ridley status.
    LDA #$00                        ;
    STA $00                         ;
    STA $02                         ;
    LDY #$00                        ;
L8D95:
    LDA UniqueItemHistory+1,Y       ;Load second byte of item and compare-->
    AND #$FC                        ;the 6 MSBs to #$20. If it matches,-->  
    CMP #$20                        ;an energy tank has been found.
    BNE L8DA3                       ;
    INC $00                         ;Increment number of energy tanks found.
    JMP IncrementToNextItem         ;
L8DA3:
    CMP #$24                        ;Load second byte of item and compare the 6 MSBs to-->
    BNE IncrementToNextItem         ;#$24. If it matches, missiles have been found.
    INC $02                         ;Increment number of missiles found.

IncrementToNextItem:
    INY                             ;
    INY                             ;Increment twice. Each item is 2 bytes.
    CPY #$84                        ;7 extra item slots in unique item history.
    BCC L8D95                       ;Loop until all unique item history checked.
    LDA $00                         ;
    CMP #$06                        ;Ensure the Tank Count does not exceed 6-->
    BCC L8DB7                       ;tanks. Then stores the number of-->
    LDA #$06                        ;energy tanks found in TankCount.
L8DB7:
    STA TankCount                   ;
    LDA #$00                        ;
    LDY $02                         ;
    BEQ L8DC6                       ;Branch if no missiles found.
    CLC                             ;
L8DC1:
    ADC #$05                        ;
    DEY                             ;For every missile item found, this-->
    BNE L8DC1                       ;loop adds 5 missiles to MaxMissiles.
L8DC6:
    LDY KraidStatueStatus           ;
    BEQ L8DCF                       ;
    ADC #$4B                        ;75 missiles are added to MaxMissiles-->
    BCS L8DD8                       ;if Kraid has been defeated and another-->
L8DCF:
    LDY RidleyStatueStatus          ;75 missiles are added if the ridley--> 
    BEQ L8DDA                       ;has been defeated.
    ADC #$4B                        ;
    BCC L8DDA                       ;
L8DD8:
    LDA #$FF                        ;If number of missiles exceeds 255, it stays at 255.
L8DDA:
    STA MaxMissiles                 ;
    RTS                             ;

ValidatePassword:
    LDA NARPASSWORD                 ;
    BNE L8DF7                       ;If invincible Samus already active, branch.
    LDY #$0F                        ;
L8DE5:
    LDA PasswordChar00,Y            ;
    CMP NARPASSWORDTbl,Y            ;If NARPASSWORD was entered at the-->
    BNE L8DF7                       ;password screen, activate invincible-->
    DEY                             ;Samus, else continue to process password.
    BPL L8DE5                       ;
    LDA #$01                        ;
    STA NARPASSWORD                 ;
    BNE L8E05                       ;
L8DF7:
    JSR UnscramblePassword          ;($8E4E)Unscramble password.
    JSR PasswordChecksum            ;($8E21)Calculate password checksum.
    CMP PasswordByte11              ;Verify proper checksum.
    BEQ L8E05                       ;
    SEC                             ;If password is invalid, sets carry flag.
    BCS L8E06                       ;
L8E05:
    CLC                             ;If password is valid, clears carry flag.
L8E06:
    RTS                             ;

;The table below is used by the code above. It checks to see if NARPASSWORD has been entered.
;NOTE: any characters after the 16th character will be ignored if the first 16 characters
;match the values below.

NARPASSWORDTbl:
    .byte "NARPASSWORD00000"

PasswordChecksumAndScramble:
    JSR PasswordChecksum            ;($8E21)Store the combined added value of-->
    STA PasswordByte11              ;addresses $6988 thu $6998 in $6999.
    JSR PasswordScramble            ;($8E2D)Scramble password.
    RTS                             ;
 
PasswordChecksum:
    LDY #$10                        ;
    LDA #$00                        ;
    L8E25:
        CLC                             ;Add the values at addresses-->
        ADC PasswordByte00,Y            ;$6988 thru $6998 together.
        DEY                             ;
        BPL L8E25                       ;
    RTS                             ;
 
PasswordScramble:
    LDA PasswordByte10              ;
    STA $02                         ;
L8E32:
    LDA PasswordByte00              ;Store contents of $6988 in $00 for-->
    STA $00                         ;further processing after rotation.
    LDX #$00                        ;
    LDY #$0F                        ;
L8E3B:
    ROR PasswordByte00,X            ;Rotate right, including carry, all values in-->
    INX                             ;addresses $6988 thru $6997.
    DEY                             ;
    BPL L8E3B                       ;
    ROR $00                         ;Rotate right $6988 to ensure the LSB-->
    LDA $00                         ;from address $6997 is rotated to the-->
    STA PasswordByte00              ;MSB of $6988.
    DEC $02                         ;
    BNE L8E32                       ;Continue rotating until $02 = 0.
    RTS                             ;

UnscramblePassword:
    LDA PasswordByte10              ;Stores random number used to scramble the password.
    STA $02                         ;
L8E53:
    LDA PasswordByte0F              ;Preserve MSB that may have been rolled from $6988.
    STA $00                         ;
    LDX #$0F                        ;
L8E5A:
    ROL PasswordByte00,X            ;The following loop rolls left the first 16 bytes-->
    DEX                             ;of the password one time.
    BPL L8E5A                       ;
    ROL $00                         ;Rolls byte in $6997 to ensure MSB from $6988 is not lost.
    LDA $00                         ;
    STA PasswordByte0F              ;
    DEC $02                         ;
    BNE L8E53                       ;Loop repeats the number of times decided by the random-->
    RTS                             ;number in $6998 to properly unscramble the password.

;The following code takes the 18 password bytes and converts them into 24 characters
;to be displayed to the player as the password.  NOTE: the two MSBs will always be 0.

LoadPasswordChar:
    .repeat 6, I
        LDY #(I*3+0)                        ;Password byte #$00.
        JSR SixUpperBits                ;($8F2D)
        STA PasswordChars+I*4+0              ;Store results.
        LDY #(I*3+0)                        ;Password bytes #$00 and #$01.
        JSR TwoLowerAndFourUpper        ;($8F33)
        STA PasswordChars+I*4+1              ;Store results.
        LDY #(I*3+1)                        ;Password bytes #$01 and #$02.
        JSR FourLowerAndTwoUpper        ;($8F46)
        STA PasswordChars+I*4+2              ;Store results.
        LDY #(I*3+2)                        ;Password byte #$02.
        JSR SixLowerBits                ;($8F5A)
        STA PasswordChars+I*4+3              ;Store results.
    .endrep
    RTS                             ;

SixUpperBits:
    LDA PasswordByte00,Y            ;Uses six upper bits to create a new byte.-->
    LSR                             ;Bits are right shifted twice and two lower-->
    LSR                             ;bits are discarded.
    RTS                             ;
 
TwoLowerAndFourUpper:
    LDA PasswordByte00,Y            ;
    AND #$03                        ;Saves two lower bits and stores them-->
    JSR Amul16                      ;($C2C5)in bits 4 and 5.
    STA $00                         ;
    LDA PasswordByte01,Y            ;Saves upper 4 bits and stores them-->
    JSR Adiv16                      ;($C2BF)bits 0, 1, 2 and 3.
    ORA $00                         ;Add two sets of bits together to make a byte-->
    RTS                             ;where bits 6 and 7 = 0.
 
FourLowerAndTwoUpper:
    LDA PasswordByte00,Y            ;
    AND #$0F                        ;Keep lower 4 bits.
    ASL                             ;Move lower 4 bits to bits 5, 4, 3 and 2.
    ASL                             ;
    STA $00                         ;
    LDA PasswordByte01,Y            ;Move upper two bits-->
    ROL                             ;to bits 1 and 0.
    ROL                             ;
    ROL                             ;
    AND #$03                        ;Add two sets of bits together to make a byte-->        
    ORA $00                         ;where bits 6 and 7 = 0.
    RTS                             ;

SixLowerBits:
    LDA PasswordByte00,Y            ;Discard bits 6 and 7.
    AND #$3F                        ;
    RTS 

;The following routine converts the 24 user entered password characters into the 18 password
;bytes used by the program to store Samus' stats and unique item history.

ConsolidatePassword:
    .repeat 6, I
        LDY #(I*4+0)                        ;Password characters #$00 and #$01.
        JSR SixLowerAndTwoUpper         ;($8FF1)
        STA PasswordBytes+I*3+0              ;Store results.
        LDY #(I*4+1)                        ;Password characters #$01 and #$02.
        JSR FourLowerAndFiveThruTwo     ;($9001)
        STA PasswordBytes+I*3+1              ;Store results.
        LDY #(I*4+2)                        ;Password characters #$02 and #$03.
        JSR TwoLowerAndSixLower         ;($9011)
        STA PasswordBytes+I*3+2              ;Store results.
    .endrep
    RTS

SixLowerAndTwoUpper:
    LDA PasswordChar00,Y            ;Remove upper two bits and transfer-->
    ASL                             ;lower six bits to upper six bits.
    ASL                             ;
    STA $00                         ;
    LDA PasswordChar01,Y            ;Move bits 4and 5 to lower two-->
    JSR Adiv16                      ;($C2BF)bits and discard the rest.
    ORA $00                         ;Combine the two bytes together.
    RTS                             ;

FourLowerAndFiveThruTwo:
    LDA PasswordChar00,Y            ;Take four lower bits and transfer-->
    JSR Amul16                      ;($C2C5)them to upper four bits. Discard the rest.
    STA $00                         ;
    LDA PasswordChar01,Y            ;Remove two lower bits and transfer-->
    LSR                             ;bits 5 thru 2 to lower four bits. 
    LSR                             ;
    ORA $00                         ;Combine the two bytes together.
    RTS                             ;
 
TwoLowerAndSixLower:
    LDA PasswordChar00,Y            ;Shifts two lower bits to two higest bits-->
    ROR                             ;and discards the rest
    ROR                             ;
    ROR                             ;
    AND #$C0                        ;
    STA $00                         ;
    LDA PasswordChar01,Y            ;Add six lower bits to previous results.
    ORA $00                         ;
    RTS                             ;

PasswordBitmaskTbl:
L9021:  .byte $01, $02, $04, $08, $10, $20, $40, $80

;The following table contains the unique items in the game.  The two bytes can be deciphered
;as follows:IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
;on world map.  The items have the following values of IIIIII:
;High jump     = 000001
;Long beam     = 000010 (Not considered a unique item).
;Screw attack  = 000011
;Maru Mari     = 000100
;Varia suit    = 000101
;Wave beam     = 000110 (Not considered a unique item).
;Ice beam      = 000111 (Not considered a unique item).
;Energy tank   = 001000
;Missiles      = 001001
;Missile door  = 001010
;Bombs         = 001100
;Mother brain  = 001110
;1st Zeebetite = 001111
;2nd Zeebetite = 010000
;3rd Zeebetite = 010001
;4th Zeebetite = 010010
;5th Zeebetite = 010011

ItemData: ; $9029
    .word $104E                     ;Maru Mari at coord 02,0E                    (Item 0)
    .word $264B                     ;Missiles at coord 12,0B                     (Item 1)
    .word $28E5                     ;Red door to long beam at coord 07,05        (Item 2)
    .word $2882                     ;Red door to Tourian elevator at coord 05,02 (Item 3)
    .word $2327                     ;Energy tank at coord 19,07                  (Item 4)
    .word $2B25                     ;Red door to bombs at coord 1A,05            (Item 5)
    .word $0325                     ;Bombs at coord 19,05                        (Item 6)
    .word $2A69                     ;Red door to ice beam at coord 13,09         (Item 7)
    .word $2703                     ;Missiles at coord 18,03                     (Item 8)
    .word $2363                     ;Energy tank at coord 1B,03                  (Item 9)
    .word $29E2                     ;Red door to varia suit at coord 0F,02       (Item 10)
    .word $15E2                     ;Varia suit at coord 0F,02                   (Item 11)
    .word $212E                     ;Energy tank at coord 09,0E                  (Item 12)
    .word $264E                     ;Missiles at coord 12,0E                     (Item 13)
    .word $262F                     ;Missiles at coord 11,0F                     (Item 14)
    .word $2B4C                     ;Red door to ice beam at coord 1B,0C         (Item 15)
    .word $276A                     ;Missiles at coord 1B,0A                     (Item 16)
    .word $278A                     ;Missiles at coord 1C,0A                     (Item 17)
    .word $278B                     ;Missiles at coord 1C,0B                     (Item 18)
    .word $276B                     ;Missiles at coord 1B,0B                     (Item 19)
    .word $274B                     ;Missiles at coord 1A,0B                     (Item 20)
    .word $268F                     ;Missiles at coord 14,0F                     (Item 21)
    .word $266F                     ;Missiles at coord 13,0F                     (Item 22)
    .word $2B71                     ;Red door to high jump at coord 1C,11        (Item 23)
    .word $0771                     ;High jump at coord 1B,11                    (Item 24)
    .word $29F0                     ;Red door to screw attack at coord 0E,10     (Item 25)
    .word $0DF0                     ;Screw attack at coord 0D,1D                 (Item 26)
    .word $2676                     ;Missiles at coord 13,16                     (Item 27)
    .word $2696                     ;Misslies at coord 14,16                     (Item 28)
    .word $2A55                     ;Red door to wave beam at coord 1C,15        (Item 29)
    .word $2353                     ;Energy tank at coord 1A,13                  (Item 30)
    .word $2794                     ;Missiles at coord 1C,14                     (Item 31)
    .word $28F5                     ;Red door at coord 07,15                     (Item 32)
    .word $2535                     ;Missiles at coord 09,15                     (Item 33)
    .word $2495                     ;Missiles at coord 04,15                     (Item 34)
    .word $28F6                     ;Red door at coord 07,16                     (Item 35)
    .word $2156                     ;Energy tank at coord 0A,16                  (Item 36)
    .word $28F8                     ;Red door at coord 07,18                     (Item 37)
    .word $287B                     ;Red door at coord 03,1B                     (Item 38)
    .word $24BB                     ;Missiles at coord 05,1B                     (Item 39)
    .word $2559                     ;Missiles at coord 0A,19                     (Item 40)
    .word $291D                     ;Red door to Kraid at coord 08,1D            (Item 41)
    .word $211D                     ;Energy tank at coord 08,1D(Kraid's room)    (Item 42)
    .word $2658                     ;Missiles at coord 12,18                     (Item 43)
    .word $2A39                     ;Red door at coord 11,19                     (Item 44)
    .word $2239                     ;Energy tank at coord 11,19                  (Item 45)
    .word $269E                     ;Missiles at coord 14,1E                     (Item 46)
    .word $2A1D                     ;purple door at coord 10,1D(Ridley's room)   (Item 47)
    .word $21FD                     ;Energy tank at coord 0F,1D                  (Item 48)
    .word $271B                     ;Missile at coord 18,1B                      (Item 49)
    .word $2867                     ;Orange door at coord 03,07                  (Item 50)
    .word $2927                     ;Red door at coord 09,07                     (Item 51)
    .word $292B                     ;Red door at coord 0A,0B                     (Item 52)
    .word $3C00                     ;1st Zeebetite in mother brain room          (Item 53)
    .word $4000                     ;2nd Zeebetite in mother brain room          (Item 54)
    .word $4400                     ;3rd Zeebetite in mother brain room          (Item 55)
    .word $4800                     ;4th Zeebetite in mother brain room          (Item 56)
    .word $4C00                     ;5th Zeebetite in mother brain room          (Item 57)
    .word $3800                     ;Mother brain                                (Item 58)

ClearAll:
    jsr ScreenOff                   ;($C439)Turn screen off.
    jsr ClearNameTables             ;Turn off screen, clear sprites and name tables.
    jsr EraseAllSprites             ;
    lda PPUCTRL_ZP                   ;Set Name table address to $2000.
    and #$FC                        ;
    sta PPUCTRL_ZP                   ;
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
    LDY #$00                        ;
    STY StartContinue               ;Set selection sprite at START.
    LDA #$0D                        ;
    STA PalDataPending              ;Change palette and title routine.
    LDA #$16                        ;Next routine is ChooseStartContinue.
    STA TitleRoutine                ;

TurnOnDisplay:
    JSR NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    JMP ScreenOn                    ;($C447)Turn screen on.

ChooseStartContinue:
    LDA Joy1Change                  ;
    AND #$30                        ;Checks both select and start buttons.
    CMP #$10                        ;Check if START has been pressed.
    BNE L90EB                       ;Branch if START not pressed.
    LDY StartContinue               ;
    BNE L90E7                       ;if CONTINUE selected, branch.
    JMP InitializeStats             ;($932B)Zero out all stats.
L90E7:
    LDY #$17                        ;Next routine is LoadPasswordScreen.
    STY TitleRoutine                ;
L90EB:
    CMP #$20                        ;check if SELECT has been pressed.
    BNE L90FF                       ;Branch if SELECT not pressed.
    LDA StartContinue               ;
    EOR #$01                        ;Chooses between START and CONTINUE-->
    STA StartContinue               ;on game select screen.
    LDA TriangleSFXFlag             ;
    ORA #$08                        ;Set SFX flag for select being pressed.-->
    STA TriangleSFXFlag             ;Uses triangle channel.
L90FF:
    LDY StartContinue               ;
    LDA StartContTbl,Y              ;Get y pos of selection sprite.
    STA Sprite00RAM                 ;
    LDA #$6E                        ;Load sprite info for square selection sprite.
    STA Sprite00RAM+1               ;
    LDA #$03                        ;
    STA Sprite00RAM+2               ;
    LDA #$50                        ;Set data for selection sprite.
    STA Sprite00RAM+3               ;
    RTS                             ;

StartContTbl:
    .byte $60                       ;Y sprite position for START.
    .byte $78                       ;Y sprite position for CONTINUE.

LoadPasswordScreen:
    JSR ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    LDX #.lobyte(L99E3)                        ;Loads PPU with info to display-->
    LDY #.hibyte(L99E3)                        ;PASS WORD PLEASE.
    JSR PreparePPUProcess           ;($9449)Load "PASSWORD PLEASE" on screen.
    JSR InitGFX7                    ;($C6D6)Loads the font for the password.
    JSR DisplayInputCharacters      ;($940B)Write password character to screen.
    LDA #$13                        ;
    STA PalDataPending              ;Change palette.
    LDA #$00                        ;
    STA InputRow                    ;Sets character select cursor to-->
    STA InputColumn                 ;upper left character (0).
    STA Timer3                      ;
    LDA #$00                        ;
    STA PasswordCursor              ;Sets password cursor to password character 0.
    LDY #$00                        ;
    STY PasswordStat00              ;Appears to have no function.
    INC TitleRoutine                ;
    JMP TurnOnDisplay               ;($90D1)Turn on screen and NMI.

EnterPassword:
    JSR EraseAllSprites             ;($C1A3)Remove sprites from screen.
    LDA Joy1Change                  ;
    AND #$10                        ;Check to see if START has been pressed.
    BEQ L9153                       ;If not, branch.
        JMP CheckPassword               ;($8C5E)Check if password is correct.
        
    L9153:
    LDX #$01                        ;
    STX PPUDataPending              ;Prepare to write the password screen data to PPU.
    LDX PPUStrIndex                 ;
    LDA #$21                        ;Upper byte of PPU string.
    JSR WritePPUByte                ;($C36B)Write byte to PPU.
    LDA #$A8                        ;Lower byte of PPU string.
    JSR WritePPUByte                ;($C36B)Write byte to PPU.
    LDA #$0F                        ;PPU string length.
    JSR WritePPUByte                ;($C36B)Write byte to PPU.
    LDA Timer3                      ;
    BEQ L9178                       ;
        LDA #.lobyte(L8759)                        ;
        STA $02                         ;Writes 'ERROR TRY AGAIN' on the screen-->
        LDA #.hibyte(L8759)                        ;if Timer3 is anything but #$00.
        STA $03                         ;
        JMP L9180                       ;
    L9178:
        LDA #.lobyte(L8768)                        ;
        STA $02                         ;
        LDA #.hibyte(L8768)                        ;
        STA $03                         ;Writes the blank lines that cover-->
    L9180:
    LDY #$00                        ;the message 'ERROR TRY AGAIN'.
    L9182:
        LDA ($02),Y                     ;
        JSR WritePPUByte                ;
        INY                             ;
        CPY #$0F                        ;
        BNE L9182                       ;
    LDA Joy1Change                  ;If button A pressed, branch.
    BMI L9193                       ;
    JMP CheckBackspace              ;($91FB)Check if backspace pressed.

L9193:
    LDA TriangleSFXFlag             ;Initiate BombLaunch SFX if a character-->
    ORA #$01                        ;has been written to the screen.
    STA TriangleSFXFlag             ;
    LDA PasswordCursor              ;
    CMP #$12                        ;Check to see if password cursor is on-->
    BCC L91A8                       ;character 19 thru 24.  If not, branch.
    CLC                             ;
    ADC #$3E                        ;Will equal #$50 thru #$55.
    JMP LoadRowAndColumn            ;($91BF)

L91A8:
    CMP #$0C                        ;Check to see if password cursor is on-->
    BCC L91B2                       ;character 13 thru 18.  If not, branch.
    CLC                             ;
    ADC #$3D                        ;Will equal #$49 thru #$4E.
    JMP LoadRowAndColumn            ;($91BF)

L91B2:
    CMP #$06                        ;Check to see if password cursor is on-->
    BCC L91BC                       ;character 7 thru 12.  If not, branch.
    CLC                             ;
    ADC #$0A                        ;Will equal #$10 thru #$15.
    JMP LoadRowAndColumn            ;($91BF)

L91BC:
    CLC                             ;
    ADC #$09                        ;Will equal #$09 thru #$0E.

LoadRowAndColumn:
    STA $06                         ;
    LDA InputRow                    ;
    ASL                             ;*2. address pointer is two bytes.
    TAY                             ;
    LDA PasswordRowTbl,Y            ;Store lower byte of row pointer.
    STA $00                         ;
    LDA PasswordRowTbl+1,Y          ;Store upper byte of row pointer.
    STA $01                         ;
    LDY InputColumn                 ;Uses InputColumn value to find proper index-->         
    LDA ($00),Y                     ;of current character selected.
    PHA                             ;Temp storage of A.
    STA TileInfo0                   ;Store value of current character slected.
    LDA #$11                        ;
    STA TileSize                    ;
    LDX $06                         ;Replace password character tile with-->
    LDY #$21                        ;the one selected by the player.
    JSR PrepareEraseTiles           ;($9450)
    LDX PasswordCursor              ;
    PLA                             ;Store the currently selected password character-->
    STA PasswordChar00,X            ;in the proper PasswordChar RAM location.
    LDA PasswordCursor              ;
    CLC                             ;
    ADC #$01                        ;
    CMP #$18                        ;
    BCC L91F8                       ;Increment PasswordCursor.  If at last character,-->
    LDA #$00                        ;loop back to the first character.
L91F8:
    STA PasswordCursor              ;

CheckBackspace:
    LDA Joy1Change                  ;
    AND #$40                        ;If button B (backspace) has not-->
    BEQ L920E                       ;been pressed, branch.
        LDA PasswordCursor              ;
        SEC                             ;Subtract 1 from PasswordCursor.  If-->
        SBC #$01                        ;PasswordCursor is negative, load-->
        BCS L920B                       ;PasswordCursor with #$17 (last character).
            LDA #$17                        ;
        L920B:
        STA PasswordCursor              ;
    L920E:
    LDY PasswordStat00              ;Appears to have no function.
    LDA FrameCount                  ;
    AND #$08                        ;If FrameCount bit 3 not set, branch.
    BEQ L923F                       ;
        LDA #$3F                        ;
        LDX PasswordCursor              ;Load A with #$3F if PasswordCursor is on-->
        CPX #$0C                        ;character 0 thru 11, else load it with #$4F.
        BCC L9222                       ;
            LDA #$4F                        ;
        L9222:
        STA Sprite01RAM                 ;Set Y-coord of password cursor sprite.
        LDA #$6E                        ;
        STA Sprite01RAM+1               ;Set pattern for password cursor sprite.
        LDA #$20                        ;
        STA Sprite01RAM+2               ;Set attributes for password cursor sprite.
        LDA PasswordCursor              ;If the password cursor is at the 12th-->
        CMP #$0C                        ;character or less, branch.
        BCC L9238                       ;
            SBC #$0C                        ;Calculate how many characters the password cursor-->
        L9238:
        TAX                             ;is from the left if on the second row of password.
        LDA CursorPosTbl,X              ;Load X position of PasswordCursor.
        STA Sprite01RAM+3               ;
    L923F:
    LDX InputRow                    ;Load X and Y with row and column-->
    LDY InputColumn                 ;of current character selected.
    LDA Joy1Retrig                  ;
    AND #$0F                        ;If no directional buttons are in-->
    BEQ L9297                       ;retrigger mode, branch.
    PHA                             ;Temp storage of A.
    LDA TriangleSFXFlag             ;Initiate BeepSFX when the player pushes-->
    ORA #$08                        ;a button on the directional pad.
    STA TriangleSFXFlag             ;
    PLA                             ;Restore A.
    LSR                             ;Put status of right directional button in carry bit.
    BCC L926C                       ;Branch if right button has not been pressed.
        INY                             ;
        CPY #$0D                        ;Increment Y(column).  If Y is greater than #$0C,-->
        BNE L9269                       ;increment X(Row).  If X is greater than #$04,-->
            INX                             ;set X to #$00(start back at top row) and store-->
            CPX #$05                        ;new row in InputRow.
            BNE L9264                       ;
                LDX #$00                        ;
            L9264:
            STX InputRow                    ;
            LDY #$00                        ;Store new column in InputColumn.
        L9269:
        STY InputColumn                 ;
    L926C:
    LSR                             ;Put status of left directional button in carry bit.
    BCC L927F                       ;Branch if left button has not been pressed.
        DEY                             ;
        BPL L927C                       ;Decrement Y(column).  If Y is less than #$00,-->
            DEX                             ;Decrement X(row).  If X is less than #$00,-->
            BPL L9277                       ;set X to #$04(last row) and store new row-->
                LDX #$04                        ;in InputRow.
            L9277:
            STX InputRow                    ;
            LDY #$0C                        ;Store new column in InputColumn.
        L927C:
        STY InputColumn                 ;
    L927F:
    LSR                             ;Put status of down directional button in carry bit.
    BCC L928C                       ;Branch if down button has not been pressed.
        INX                             ;
        CPX #$05                        ;Increment X(row).  if X is greater than #$04,-->
        BNE L9289                       ;set X to #$00(first row) and store new-->
            LDX #$00                        ;row in InputRow.
        L9289:
        STX InputRow                    ;
    L928C:
    LSR                             ;Put status of up directional button in carry bit.
    BCC L9297                       ;Branch if up button has not been pressed.
        DEX                             ;
        BPL L9294                       ;Decrement X(row).  if X is less than #$00,-->
            LDX #$04                        ;set X to #$04(last row) and store new-->
        L9294:
        STX InputRow                    ;row in InputRow.
    L9297:
    LDA FrameCount                  ;
    AND #$08                        ;If FrameCount bit 3 not set, branch.
    BEQ L92B3                       ;
        LDA CharSelectYTbl,X            ;Set Y-coord of character selection sprite.
        STA Sprite02RAM                 ;
        LDA #$6E                        ;Set pattern for character selection sprite.
        STA Sprite02RAM+1               ;
        LDA #$20                        ;Set attributes for character selection sprite.
        STA Sprite02RAM+2               ;
        LDA CharSelectXTbl,Y            ;Set x-Coord of character selection sprite.
        STA Sprite02RAM+3               ;
    L92B3:
    RTS                             ;

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
    JSR ClearRAM_33_DF              ;($C1D4)Clear RAM.
    JSR ClearSamusStats             ;($C578)Reset Samus stats for a new game.
    JSR LoadPasswordData            ;($8D12)Load data from password.
    LDY #$00                        ;
    STY SpritePagePos               ;
    STY PageIndex                   ;Clear object data.
    STY ObjectCntrl                 ;
    STY ObjectHi                    ;
    JSR SilenceMusic                ;($CB8E)Turn off music.
    LDA #$5A                        ;
    STA AnimFrame                   ;Set animframe index. changed by initializing routines. 
    LDX #$01                        ;x is the index into the position tables below.
    LDA InArea                      ;Load starting area.
    AND #$0F                        ;
    BNE L92F9                       ;If in area other than Brinstar, get second item in tables.
        DEX                             ;Starting in Brinstar. Get forst item in each table.
    L92F9:
    LDA RestartYPosTbl,X            ;
    STA ObjectY                     ;Set Samus restart y position on screen.
    LDA RestartXPosTbl,X            ;
    STA ObjectX                     ;Set Samus restart x position on screen.
    INC SamusStat02                 ;The combination of SamusStat02 and 03 keep track of how-->
    BNE L930D                       ;many times Samus has died and beaten the game as they are-->
        INC SamusStat03                 ;incremented every time this routine is run, but they are-->
    L930D:
    LDA #$01                        ;not accessed anywhere else.
    STA MainRoutine                 ;Initialize starting area.
    JSR ScreenNmiOff                ;($C45D)Turn off screen.
    JSR LoadSamusGFX                ;($C5DC)Load Samus GFX into pattern table.
    JSR NMIOn                       ;($C487)Turn on the non-maskable interrupt.
    LDA InArea                      ;Load area Samus is to start in.
    AND #$0F                        ;
    TAY                             ;
    LDA BankTable,Y                 ;Change to proper memory page.
    STA SwitchPending               ;
L9324:
    RTS 

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
    LDA #$00                        ;
    STA SamusStat00                 ;
    STA TankCount                   ;
    STA SamusGear                   ;
    STA MissileCount                ;
    STA MaxMissiles                 ;
    STA KraidStatueStatus           ;Set all of Samus' stats to 0 when starting new game.
    STA RidleyStatueStatus          ;
    STA SamusAge                    ;
    STA SamusAge+1                  ;
    STA SamusAge+2                  ;
    STA SamusStat01                 ;
    STA AtEnding                    ;
    STA JustInBailey                ;
    LDA #$02                        ;
    STA SwitchPending               ;Prepare to switch to Brinstar memory page.
    RTS                             ;

DisplayPassword:
    LDA Timer3                      ;Wait for "GAME OVER" to be displayed-->
    BNE L9324                       ;for 160 frames (2.6 seconds).
    JSR ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    LDX #.lobyte(L937F)                        ;Low byte of start of PPU data.
    LDY #.hibyte(L937F)                        ;High byte of start of PPU data.
    JSR PreparePPUProcess           ;($9449)Clears screen and writes "PASS WORD".
    JSR InitGFX7                    ;($C6D6)Loads the font for the password.
    JSR CalculatePassword           ;($8C7A)Calculates the password.
    JSR NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    JSR PasswordToScreen            ;($93C6)Displays password on screen.
    JSR WaitNMIPass                 ;($C42C)Wait for NMI to end.
    LDA #$13                        ;
    STA PalDataPending              ;Change palette.
    INC TitleRoutine                ;
    JMP ScreenOn                    ;($C447)Turn screen on.

L937F:
    ;Information below is for above routine to display "PASS WORD" on the screen.
    PPUString $214B, "PASS WORD"

    ;Information to be stored in attribute table 0.
    PPUStringRepeat $23D0, $00, $08

    ;Turn color on to display password characters.  
    PPUStringRepeat $23D8, $55, $20

    .byte $00                       ;End PPU string write.

WaitForSTART:
    LDA Joy1Change                  ;Waits for START to be ressed proceed-->
    AND #$10                        ;past the GAME OVER screen.
    BEQ L939D                       ;If start not pressed, branch.
        JMP CheckPassword               ;($8C5E)Check if password is correct.

    L939D:
    RTS                             ;

GameOver:
    JSR ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    LDX #.lobyte(L93B9)                        ;Low byte of start of PPU data.
    LDY #.hibyte(L93B9)                        ;High byte of start of PPU data.
    JSR PreparePPUProcess           ;($9449)Clears screen and writes "GAME OVER".
    JSR InitGFX7                    ;($C6D6)Loads the font for the password.
    JSR NMIOn                       ;($C487)Turn on the nonmaskable interrupt.
    LDA #$10                        ;Load Timer3 with a delay of 160 frames-->
    STA Timer3                      ;(2.6 seconds) for displaying "GAME OVER".
    LDA #$19                        ;Loads TitleRoutine with -->
    STA TitleRoutine                ;DisplayPassword.
    JMP ScreenOn                    ;($C447)Turn screen on.

L93B9:
    ;Information below is for above routine to display "GAME OVER" on the screen.
    PPUString $218C,  "GAME OVER"

    .byte $00                       ;End PPU string write.

PasswordToScreen:
    JSR WaitNMIPass                 ;($C42C)Wait for NMI to end.
    LDY #$05                        ;Index to find password characters(base=$699A).
    JSR LoadPasswordTiles           ;($93F9)Load tiles on screen.
    LDX #$A9                        ;PPU low address byte.
    LDY #$21                        ;PPU high address byte.
    JSR PrepareEraseTiles           ;($9450)Erase tiles on screen.
    LDY #$0B                        ;Index to find password characters(base=$699A).
    JSR LoadPasswordTiles           ;($93F9)Load tiles on screen.
    LDX #$B0                        ;PPU low address byte.
    LDY #$21                        ;PPU high address byte.
    JSR PrepareEraseTiles           ;($9450)Erase tiles on screen.
    LDY #$11                        ;Index to find password characters(base=$699A).
    JSR LoadPasswordTiles           ;($93F9)Load tiles on screen.
    LDX #$E9                        ;PPU low address byte.
    LDY #$21                        ;PPU high address byte.
    JSR PrepareEraseTiles           ;($9450)Erase tiles on screen.
    LDY #$17                        ;Index to find password characters(base=$699A).
    JSR LoadPasswordTiles           ;($93F9)Load tiles on screen.
    LDX #$F0                        ;PPU low address byte.
    LDY #$21                        ;PPU high address byte.
    JMP PrepareEraseTiles           ;($9450)Erase tiles on screen.

LoadPasswordTiles:
    LDA #$16                        ;Tiles to replace are one block-->
    STA TileSize                    ;high and 6 blocks long.
    LDX #$05                        ;
    L9400:
        LDA PasswordChar00,Y            ;
        STA TileInfo0,X                 ;
        DEY                             ;Transfer password characters to-->
        DEX                             ;TileInfo addresses.
        BPL L9400                       ;
    RTS                             ;

DisplayInputCharacters:
    LDA PPUSTATUS                   ;Clear address latches.
    LDY #$00                        ;
    TYA                             ;Initially sets $00 an $01.
    STA $00                         ;to #$00.
    STA $01                         ;Also, initially sets x and y to #$00.
    L9415:
        ASL                             ;
        TAX                             ;
        LDA PasswordRowsTbl,X           ;
        STA PPUADDR                  ;
        LDA PasswordRowsTbl+1,X         ;Displays the list of characters -->
        STA PPUADDR                  ;to choose from on the password--> 
        LDX #$00                        ;entry screen.
        L9425:
            LDA PasswordRow0,Y              ;Base is $99A2.
            STA PPUDATA                    ;
            LDA #$FF                        ;Blank tile.
            STA PPUDATA                    ;
            INY                             ;
            INX                             ;
            CPX #$0D                        ;13 characters in current row?
            BNE L9425                       ;if not, add another character.
        INC $01                         ;
        LDA $01                         ;
        CMP #$05                        ;5 rows?
        BNE L9415                       ;If not, go to next row.
    RTS                             ;

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
    STX $00                         ;PPU low address byte
    STY $01                         ;PPU high address byte
    LDX #$80                        ;
    LDY #$07                        ;
    STX $02                         ;Address of byte where tile size-->  
    STY $03                         ;of tile to be erased is stored.
    JMP EraseTile                   ;($C328)Erase the selected tiles.

;---------------------------------------[ Unused intro routines ]------------------------------------

;The following routines are intro routines that are not used in this version of the game.  It
;appears that the intro routine was originally going to be more complex with a more advanced
;sprite control mechanism and name table writing routines. The intro routines are a mess! In
;addition to unused routines, there are several unused memory addresses that are written to but
;never read.

UnusedIntroRoutine4:
    STX PPUStrIndex                 ;
    LDA #$00                        ;
    STA PPUDataString,X             ;The following unused routine writes something to the-->
    LDA #$01                        ;PPU string and prepares for a PPU write.
    STA PPUDataPending              ;
    RTS                             ;

UnusedIntroRoutine5:
    STA $05                         ;
    AND #$F0                        ;
    LSR                             ;
    LSR                             ;
    LSR                             ;
    LSR                             ;
    JSR L947B                       ;
        LDA $05                         ;Unused intro routine. It looks like originally the-->
        AND #$0F                        ;title routines were going to write data to the name-->
    L947B:
    STA PPUDataString,X             ;tables in the middle of the title sequences.
    INX                             ;
    TXA                             ;
    CMP #$55                        ;
    BCC L948E                       ;
    LDX PPUStrIndex                 ;
    L9487:
        LDA #$00                        ;
        STA PPUDataString,X             ;
        BEQ L9487                       ;
L948E:
    RTS                             ;

UnusedIntroRoutine6:
    TYA                             ;
    PHA                             ;
    JSR Amul16                      ;($C2C5)Multiply by 16.
    TAY                             ;
    LDA $684B,Y                     ;
    STA $0B                         ;
    LDA $684A,Y                     ;
    STA $0A                         ;
    JSR UnusedIntroRoutine8         ;($94DA)
    LDA $06                         ;
    STA $683D,X                     ;Another unused intro routine.
    LDA $07                         ;
    STA $683C,X                     ;
    PLA                             ;
    TAY                             ;
    RTS                             ;

UnusedIntroRoutine7:
    TYA                             ;
    PHA                             ;
    JSR Amul16                      ;($C2C5)Multiply by 16.
    TAY                             ;
    LDA $684D,Y                     ;
    STA $0B                         ;
    LDA $684C,Y                     ;
    STA $0A                         ;
    JSR UnusedIntroRoutine8         ;($94DA)
    LDA $06                         ;
    STA $6834,X                     ;
    LDA $07                         ;
    STA $6833,X                     ;
    LDA $6842,Y                     ;Another unused intro routine.
    PHA                             ;
    TXA                             ;
    LSR                             ;
    TAY                             ;
    PLA                             ;
    STA $6839,Y                     ;
    PLA                             ;
    TAY                             ;
    RTS                             ;

UnusedIntroRoutine8:
    LDA #$FF                        ;
    STA $01                         ;
    STA $02                         ;
    STA $03                         ;
    SEC                             ;
    L94E3:
        LDA $0A                         ;
        SBC #$E8                        ;
        STA $0A                         ;
        LDA $0B                         ;
        SBC #$03                        ;
        STA $0B                         ;
        INC $03                         ;
        BCS L94E3                       ;
    LDA $0A                         ;
    ADC #$E8                        ;
    STA $0A                         ;
    LDA $0B                         ;
    ADC #$03                        ;
    STA $0B                         ;
    LDA $0A                         ;
    L9501:
        SEC                             ;Unused intro routine. Looks like the intro routines may-->
        L9502:
            SBC #$64                        ;have had more complicated sprite control routines-->
            INC $02                         ;that it does now.
            BCS L9502                       ;
        DEC $0B                         ;
        BPL L9501                       ;
    ADC #$64                        ;
    SEC                             ;
    L950F:
        SBC #$0A                        ;
        INC $01                         ;
        BCS L950F                       ;
    ADC #$0A                        ;
    STA $06                         ;
    LDA $01                         ;
    JSR Amul16                      ;($C2C5)Multiply by 16.
    ORA $06                         ;
    STA $06                         ;
    LDA $03                         ;
    JSR Amul16                      ;($C2C5)Multiply by 16.
    ORA $02                         ;
    STA $07                         ;
    RTS                             ;

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
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette01 info.

Palette01:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $35, $35, $04, $0F, $35, $14, $04
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette02 info.

Palette02:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $39, $39, $09, $0F, $39, $29, $09
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette03 info.

Palette03:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $36, $36, $06, $0F, $36, $15, $06
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette04 info.

Palette04:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $27, $27, $12, $0F, $27, $21, $12
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $31, $20, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette05 info.

Palette05:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette06 info.

Palette06:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $01, $0F
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette07 info.

Palette07:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $02, $01
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette08 info.

Palette08:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $01, $01
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette09 info.

Palette09:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $02, $0F, $12, $12, $02
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette0A info.

Palette0A:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $11, $11, $02, $0F, $11, $02, $02
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette0B info.

Palette0B:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $31, $31, $01, $0F, $31, $11, $01
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette0C info.

Palette0C:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $12, $30, $21, $0F, $27, $28, $29, $0F, $31, $31, $01
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $2A, $27, $0F, $12, $30, $21, $0F, $27, $24, $2C, $0F, $15, $21, $38

    .byte $00                       ;End Palette0D info.

Palette0D:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $01, $0F, $12, $02, $01
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette0E info.

Palette0E:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $0F, $0F, $02, $01, $0F
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette0F info.

Palette0F:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F
    ;The following values are written to the sprite palette:
    .byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

    .byte $00                       ;End Palette10 info.

Palette10:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $20                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $30, $28, $18, $08, $30, $29, $1B, $1A, $30, $30, $30, $30, $30, $30, $30, $30
    ;The following values are written to the sprite palette:
    .byte $30, $16, $1A, $27, $30, $37, $3A, $1B, $30, $17, $31, $37, $30, $32, $22, $12

    .byte $00                       ;End Palette11 info.

Palette11:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $04                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $30, $30, $21

    .byte $00                       ;End Palette12 info.

Palette12:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $10                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $30, $30, $0F, $0F, $2A, $2A, $21, $0F, $31, $31, $0F, $0F, $2A, $2A, $21

    .byte $00                       ;End Palette13 data.

EndGamePal0B:
    .byte $3F                       ;Upper byte of PPU palette adress.
    .byte $00                       ;Lower byte of PPU palette adress.
    .byte $10                       ;Palette data length.
    ;The following values are written to the background palette:
    .byte $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C

EndGamePal0C:
    PPUStringRepeat $3F10, $0F, $10

    .byte $00                       ;End EndGamePal0C data.

UpdateSpriteCoords:
    LDA IntroSpr0XRun,X             ;Load sprite run(sprite x component).
    JSR CalcDisplacement            ;($9871)Calculate sprite displacement in x direction.
    LDY IntroSpr0XDir,X             ;Get byte describing if sprite increasing or decreasing pos.
    BPL L982E                       ;
        EOR #$FF                        ;If MSB is set, sprite is decreasing position. convert-->
        CLC                             ;value in A (result from CalcDisplacement) to twos compliment.
        ADC #$01                        ;
    L982E:
    CLC                             ;
    ADC IntroSpr0XCoord,X           ;Add change to sprite x coord. 
    STA IntroSpr0XCoord,X           ;
    SEC                             ;
    SBC IntroSpr0XChange,X          ;Subtract total sprite movemnt value from current sprite x pos.
    PHP                             ;Transfer processor status to A.
    PLA                             ;
    EOR IntroSpr0XDir,X             ;Eor carry bit with direction byte to see if sprite has-->       
    LSR                             ;reached its end point.
    BCC L9864                       ;Branch if sprite has reached the end of x movement.
        LDA IntroSpr0YRise,X            ;Load sprite rise(sprite y component).
        JSR CalcDisplacement            ;($9871)Calculate sprite displacement in y direction.
        LDY IntroSpr0YDir,X             ;Get byte describing if sprite increasing or decreasing pos.
        BPL L9851                       ;
            EOR #$FF                        ;If MSB is set, sprite is decreasing position. convert-->
            CLC                             ;value in A (result from CalcDisplacement) to twos compliment.
            ADC #$01                        ;
        L9851:
        CLC                             ;
        ADC IntroSpr0YCoord,X           ;Add change to sprite y coord. 
        STA IntroSpr0YCoord,X           ;
        SEC                             ;
        SBC IntroSpr0YChange,X          ;Subtract total sprite movemnt value from current sprite y pos.
        PHP                             ;Transfer processor status to A.
        PLA                             ;
        EOR IntroSpr0YDir,X             ;Eor carry bit with direction byte to see if sprite has-->
        LSR                             ;reached its end point.
        BCS L9870                       ;Branch if sprite has not reached the end of y movement.
    L9864:
        LDA IntroSpr0YChange,X          ;After sprite has reached its final position, this code-->
        STA IntroSpr0YCoord,X           ;explicitly writes final the x and y coords to to sprite-->
        LDA IntroSpr0XChange,X          ;position addresses to make sure the sprites don't-->
        STA IntroSpr0XCoord,X           ;overshoot their mark.
    L9870:
    RTS                             ;

CalcDisplacement:
    STA $04                         ;
    LDA #$08                        ;Time division. The higher the number, the slower the sprite.
    STA $00                         ;
    L9877:
        LSR $04                         ;
        BCC L9883                       ;
        LDA FrameCount                  ;
        AND $00                         ;Calculate the change in the sprite position by taking the-->
        BNE L9883                       ;value in a and dividing it by the time division. The time-->
        INC $04                         ;time division in this case is #$08.
    L9883:
        LSR $00                         ;
        BNE L9877                       ;
    LDA $04                         ;
    RTS                             ;Return A/time.

;This function decrements the y coordinate of the 40 intro star sprites.

DecSpriteYCoord:
    LDA TitleRoutine                ;
    CMP #$1D                        ;
    BCS L98AD                       ;If the end game is playing, branch to exit.
    LDA SpriteLoadPending           ;               
    BEQ L98AD                       ;If no sprite load is pending, branch to exit.
    LDA FrameCount                  ;
    LSR                             ;
    BCS L98AD                       ;If not on an odd numbered frame, branch to exit.
    LDX #$9F                        ;
    L989B:
        DEC IntroStarSprite00,X         ;Decrement y coord of the intro star sprites.
        DEC Sprite18RAM,X               ;Decrement y coord of 40 sprites.
        DEX                             ;
        DEX                             ;
        DEX                             ;Move to next sprite.
        DEX                             ;
        CPX #$FF                        ;
        BNE L989B                       ;Loop 40 times.
    LDA #$00                        ;
    STA SpriteLoadPending           ;Sprite RAM load complete.
L98AD:
    RTS                             ;

LoadStarSprites:
    LDY #$9F                        ;
L98B0:
    LDA IntroStarSprite00,Y         ;
    STA Sprite18RAM,Y               ;Store RAM contents of $6E00 thru $6E9F -->
    DEY                             ;in sprite RAM at locations $0260 thru $02FF. 
    CPY #$FF                        ;
    BNE L98B0                       ;
    LDA #$00                        ;                               
    STA SpriteLoadPending           ;Set $C8 to #$00.
    RTS                             ;

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
    LDA TitleRoutine                ;
    CMP #$1D                        ;If titleRoutine not at end game, exit.
    BCC Exit100                     ;
    JSR LoadCredits                 ;($9C45)Display end credits on screen.
    LDA EndMsgWrite                 ;
    BEQ L9A24                       ;If not time to write end message, branch
    CMP #$05                        ;
    BCS L9A24                       ;If end message is finished being written, branch
    ASL                             ;
    TAY                             ;
    LDX EndMessageStringTbl0-2,Y    ;Writes the end message on name table 0
    LDA EndMessageStringTbl0-1,Y    ;
    TAY                             ;
    JSR PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
L9A24:
    LDA HideShowEndMsg              ;
    BEQ Exit100                     ;If not time to erase end message, branch
    CMP #$05                        ;
    BCS Exit100                     ;If end message is finished being erased, branch
    ASL                             ;
    TAY                             ;
    LDX EndMessageStringTbl1-2,Y    ;Erases the end message on name table 0
    LDA EndMessageStringTbl1-1,Y    ;
    TAY                             ;
    JMP PreparePPUProcess_          ;($C20E)Prepare to write to PPU.

Exit100:
    RTS                             ;Exit from above and below routines.
 
Restart:
    LDA Joy1Status                  ;
    AND #$10                        ;If start has not been pressed, branch to exit.
    BEQ Exit100                     ;
    LDY #$11                        ;
    LDA #$00                        ;
L9A43:
    STA PasswordByte00,Y            ;Erase PasswordByte00 thru PasswordByte11.
    DEY                             ;
    BPL L9A43                       ;
    INY                             ;Y = #$00.
L9A4A:
    STA UniqueItemHistory,Y         ;
    INY                             ;Erase Unique item history.
    BNE L9A4A                       ;
    LDA SamusGear                   ;
    AND #$10                        ;
    BEQ L9A5C                       ;If Samus does not have Maru Mari, branch.-->
    LDA #$01                        ;Else load Maru Mari data into PasswordByte00.
    STA PasswordByte00              ;
L9A5C:
    LDA SamusGear                   ;
    AND #$01                        ;
    BEQ L9A6B                       ;If Samus does not have bombs, branch.-->
    LDA PasswordByte00              ;Else load bomb data into PasswordByte00.
    ORA #$40                        ;
    STA PasswordByte00              ;
L9A6B:
    LDA SamusGear                   ;
    AND #$20                        ;
    BEQ L9A77                       ;If Samus does not have varia suit, branch.-->
    LDA #$08                        ;Else load varia suit data into PasswordByte01.
    STA PasswordByte01              ;
L9A77:
    LDA SamusGear                   ;
    AND #$02                        ;
    BEQ L9A83                       ;If Samus does not have high jump, branch.-->
    LDA #$01                        ;Else load high jump data into PasswordByte03.
    STA PasswordByte03              ;
L9A83:
    LDA SamusGear                   ;
    AND #$10                        ;If Samus does not have Maru Mari, branch.-->
    BEQ L9A92                       ;Else load screw attack data into PasswordByte03.-->
    LDA PasswordByte03              ;A programmer error?  Should check for screw-->
    ORA #$04                        ;attack data.
    STA PasswordByte03              ;
L9A92:
    LDA SamusGear                   ;
    STA PasswordByte09              ;Store Samus gear data in PasswordByte09.
    LDA #$00                        ;
    LDY JustInBailey                ;
    BEQ L9AA1                       ;If Samus is wearing suit, branch.  Else-->
    LDA #$80                        ;load suitless Samus data into PasswordByte08.
L9AA1:
    STA PasswordByte08              ;
    JMP InitializeGame              ;($92D4)Clear RAM to restart game at beginning.

EndGame:
    JSR LoadEndStarSprites          ;($9EAA)Load stars in end scene onto screen.
    LDA IsCredits                   ;Skips palette change when rolling credits.
    BNE L9AC0                       ;
    LDA FrameCount                  ;
    AND #$0F                        ;Changes star palettes every 16th frame.
    BNE L9AC0                       ;
    INC PalDataPending              ;
    LDA PalDataPending              ;Reset palette data to #$01 after it-->
    CMP #$09                        ;reaches #$09.
    BNE L9AC0                       ;
    LDA #$01                        ;
    STA PalDataPending              ;
L9AC0:
    LDA RoomPtr                     ;RoomPtr used in end of game to determine-->
    JSR ChooseRoutine               ;($C27C)which subroutine to run below.
        .word LoadEndGFX                ;($9AD5)Load end GFX to pattern tables.
        .word ShowEndSamus              ;($9B1C)Show Samus and end message.
        .word EndSamusFlash             ;($9B34)Samus flashes and changes.
        .word SamusWave                 ;($9B93)Samus waving in ending if suitless.
        .word EndFadeOut                ;($9BCD)Fade out Samus in ending.
        .word RollCredits               ;($9BFC)Rolls ending credits.
        .word Restart                   ;($9A39)Starts at beginning after game completed.
        .word ExitSub                   ;($C45C)Rts.

LoadEndGFX:
    JSR ClearAll                    ;($909F)Turn off screen, erase sprites and nametables.
    JSR InitEndGFX                  ;($C5D0)Prepare to load end GFX.
    LDA #$04                        ;
    LDY JustInBailey                ;Checks if game was played as suitless-->
    BNE L9AE4                       ;Samus.  If so, branch.
    LDA #$00                        ;Loads SpritePointerIndex with #$00(suit on).
L9AE4:
    STA EndingType                  ;
    ASL                             ;Loads SpritePointerIndex with #$08(suitless).
    STA SpritePointerIndex          ;
    LDX #.lobyte(LA052)                        ;Loads the screen where Samus stands on-->
    LDY #.hibyte(LA052)                        ;the surface of the planet in end of game.
    JSR PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
    JSR NMIOn                       ;($C487)Turn on non-maskable interrupt.
    LDA #$20                        ;Initiate end game music.
    STA MultiSFXFlag                ;
    LDA #$60                        ;Loads Timer3 with a delay of 960 frames-->
    STA Timer3                      ;(16 seconds).
    LDA #$36                        ;#$36/#$03 = #$12.  Number of sprites-->
    STA SpriteByteCounter           ;used to draw end graphic of Samus.
    LDA #$00                        ;
    STA SpriteAttribByte            ;
    STA ColorCntIndex               ;
    STA IsCredits                   ;The following values are-->
    STA EndMsgWrite                 ;initialized to #$00.
    STA HideShowEndMsg              ;
    STA CreditPageNumber            ;
    LDA #$01                        ;
    STA PalDataPending              ;Change palette.
    LDA #$08                        ;
    STA ClrChangeCounter            ;Initialize ClrChangeCounter with #$08.
    INC RoomPtr                     ;
    JMP ScreenOn                    ;($C447)Turn screen on.

ShowEndSamus:
    JSR LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    LDA Timer3                      ;Once 960 frames (16 seconds) have expired,-->
    BNE L9B26                       ;Move to EndSamusFlash routine.
        INC RoomPtr                     ;
        RTS                             ;

    L9B26:
    CMP #$50                        ;After 160 frames have past-->
    BNE L9B2D                       ;(2.6 seconds), write end message.
        INC EndMsgWrite                 ;
        RTS                             ;

    L9B2D:
    CMP #$01                        ;After 950 frames have past-->
    BNE L9B33                       ;(15.8 seconds), erase end message.
        INC HideShowEndMsg              ;
    L9B33:
    RTS                             ;

EndSamusFlash:
    LDA FrameCount                  ;If FrameCount not divisible by 32, branch.
    AND #$1F                        ;
    BNE L9B69                       ;
        INC ColorCntIndex               ;Every 32 frame, increment the ColorCntInex-->
        LDA ColorCntIndex               ;value.  Flashing Samus lasts for 512-->
        CMP #$08                        ;frames (8.5 seconds).
        BNE L9B52                       ;
            JSR ChooseEnding                ;($CAF5)Choose which Samus ending to show.
            JSR CalculatePassword           ;($8C7A)Calculate game password.
            LDA EndingType                  ;
            ASL                             ;When EndSamusFlash routine is half way-->
            STA SpritePointerIndex          ;done, this code will calculate the-->
            LDA #$36                        ;password and choose the proper ending.
            STA SpriteByteCounter           ;
        L9B52:
        CMP #$10                        ;
        BNE L9B69                       ;Once flashing Samus is compete, set Timer3-->
        STA Timer3                      ;for a 160 frame(2.6 seconds) delay.
        LDY #$00                        ;
        LDA EndingType                  ;
        CMP #$04                        ;If one of the suitless Samus endings,-->
        BCC L9B62                       ;increment sprite color for proper-->
            INY                             ;color to be displayed and increment-->
        L9B62:
        STY SpriteAttribByte            ;RoomPtr and erase the sprites.
        INC RoomPtr                     ;
        JMP EraseAllSprites             ;($C1A3)Clear all sprites off the screen.
    L9B69:
    DEC ClrChangeCounter            ;Decrement ClrChangeCounter.
    BNE L9B80                       ;
    LDY ColorCntIndex               ;
    LDA PalChangeTable,Y            ;When ClrChangeCounter=#$00, fetch new-->
    STA ClrChangeCounter            ;ClrChangeCounter value. and increment-->
    INC SpriteAttribByte            ;sprite color.  
    LDA SpriteAttribByte            ;
    CMP #$03                        ;
    BNE L9B80                       ;       
    LDA #$00                        ;If sprite color=#$03, set sprite-->
    STA SpriteAttribByte            ;color to #$00.
L9B80:
    JMP LoadEndSamusSprites         ;($9C9A)Load end image of Samus.

;The following table is used by the above routine to load ClrChangeCounter.  ClrChangeCounter
;decrements every frame, When ClrChangeCounter reaches zero, the sprite colors for Samus
;changes.  This has the effect of making Samus flash.  The flashing starts slow, speeds up,
;then slows down again.
PalChangeTable:
    .byte $08, $07, $06, $05, $04, $03, $02, $01, $01, $02, $03, $04, $05, $06, $07, $08
 
SamusWave:
    LDA Timer3                      ;If 160 frame timer from previous routine-->
    BNE L9BA2                       ;has not expired, branch(waves for 2.6 seconds).
    LDA #$10                        ;
    STA Timer3                      ;Load Timer3 with 160 frame delay-->
    LDA #$08                        ;(2.6 seconds).
    STA PalDataPending              ;Change palette
    INC RoomPtr                     ;Increment RoomPtr
    RTS                             ;

L9BA2:
    LDA EndingType                  ;If suitless Samus-->
    CMP #$04                        ;ending, branch.
    BCS L9BAC                       ;
    JMP LoadEndSamusSprites         ;($9C9A)
L9BAC:
    SBC #$04                        ;If jumpsuit Samus ending,-->
    ASL                             ;WaveSpritePointer=#$00, if bikini-->
    ASL                             ;Samus ending, WaveSpritePointer=#$04.
    STA WaveSpritePointer           ;
    LDA FrameCount                  ;
    AND #$08                        ;Every eigth frame count, change wave sprite data.
    BNE L9BBE                       ;
        LDY #$10                        ;Load WaveSpriteCounter with #$10(16 bytes of-->
        STY WaveSpriteCounter           ;sprite data to be loaded).
        BNE L9BC6                       ;Branch always.
    L9BBE:
        INC WaveSpritePointer           ;
        INC WaveSpritePointer           ;When bit 3 of FrameCount is not set,-->
        LDY #$10                        ;Samus' waving hand is down.
        STY WaveSpriteCounter           ;
    L9BC6:
    LDA #$2D                        ;Load SpriteByteCounter in preparation for-->
    STA SpriteByteCounter           ;refreshing Samus sprite bytes.
    JMP LoadWaveSprites             ;($9C7F)Load sprites for waving Samus.

EndFadeOut:
    LDA Timer3                      ;If 160 frame delay from last routine has not-->
    BNE L9BEF                       ;yet expired, branch.
    LDA IsCredits                   ;
    BNE L9BDB                       ;Branch always.

        LDA #$08                        ;*This code does not appear to be used.
        STA PalDataPending              ;*Change palette.
        INC IsCredits                   ;*Increment IsCredits.

    L9BDB:
    LDA FrameCount                  ;
    AND #$07                        ;Every seventh frame, increment the palette info-->
    BNE L9BEF                       ;If PalDataPending is not equal to #$0C, keep--> 
    INC PalDataPending              ;incrementing every seventh frame until it does.-->
    LDA PalDataPending              ;This creates the fade out effect.
    CMP #$0C                        ;
    BNE L9BEF                       ;
        LDA #$10                        ;After fadeout complete, load Timer3 with 160 frame-->
        STA Timer3                      ;delay(2.6 seconds) and increment RoomPtr.
        INC RoomPtr                     ;
    L9BEF:
    LDA EndingType                  ;
    CMP #$04                        ;If suitless Samus ending, load hand wave sprites,-->
    BCS L9BF9                       ;else just load regular Samus sprites
        JMP LoadEndSamusSprites         ;($9C9A)Load end image of Samus.
    L9BF9:
        JMP LoadWaveSprites             ;($9C7F)Load sprites for waving Samus.

RollCredits:
    LDA Timer3                      ;If 160 frame timer delay from previous-->
    BEQ L9C17                       ;routine has expired, branch.
    CMP #$02                        ;If not 20 frames left in Timer3, branch to exit.
    BNE L9C44                       ;
    JSR ScreenOff                   ;($C439)When 20 frames left in Timer3,-->
    JSR ClearNameTable0             ;($C16D)clear name table 0 and sprites.-->
    JSR EraseAllSprites             ;($C1A3)prepares screen for credits.
    LDA #$0D                        ;
    STA PalDataPending              ;Change to proper palette for credits.
    JSR ScreenOn                    ;($C447)Turn screen on.
    JMP WaitNMIPass_                ;($C43F)Wait for NMI to end.
L9C17:
    LDA CreditPageNumber            ;If first page of credits has not started to-->
    BNE L9C1D                       ;roll, start it now, else branch.
    INC CreditPageNumber            ;
L9C1D:
    CMP #$06                        ;If not at last page of credits, branch.
    BNE L9C2A                       ;
    LDA ScrollY                     ;
    CMP #$88                        ;If last page of credits is not finished-->
    BCC L9C2A                       ;scrolling, branch.  Else increment to next-->
    INC RoomPtr                     ;routine.
    RTS                             ;

L9C2A:
    LDA FrameCount                  ;credits scroll up one position every 3 frames.
    AND #$03                        ;
    BNE L9C44                       ;Ready to scroll? If not, branch.
    INC ScrollY                     ;
    LDA ScrollY                     ;Load ScrollY and check it to see if its-->
    CMP #$F0                        ;position is at the very bottom on name table.-->
    BNE L9C44                       ;if not, branch.
    INC CreditPageNumber            ;
    LDA #$00                        ;
    STA ScrollY                     ;When Scrolly is at bottom of the name table,-->
    LDA PPUCTRL_ZP                   ;Swap to next name table(0 or 2) and increment-->
    EOR #$02                        ;CreditPageNumber.
    STA PPUCTRL_ZP                   ;
L9C44:
    RTS

;The following routine is checked every frame and is accessed via the NMIScreenWrite routine.
;The LoadCredits routine works like this: The Y scroll position is checked every frame.  When
;it is in the first four positions of the current name table (0, 1, 2 or 3), or the four
;positions right after 127 (128, 129, 130 and 131), the routine will then load the ending
;credits into the positions on the name table that were just scrolled over.  For example, If
;the scroll window is currently half way down name table 0, the LoadCredits routine will load
;the contents of the upper half of name table 0.  Also, name table 0 contains odd numbered
;pages and name table 2 contains even numbered pages.

LoadCredits:
    LDY CreditPageNumber            ;
    BEQ L9C7E                       ;If credits are not being displayed, exit.
    CPY #$07                        ;
    BCS L9C7E                       ;If CreditPageNumber is higher than #$06, exit.
    LDX #$00                        ;
    LDA ScrollY                     ;If ScrollY is less than #$80 (128), branch.
    BPL L9C57                       ;
    INX                             ;Load X with sign bit (#$01) and remove-->
    SEC                             ;sign bit from A.
    SBC #$80                        ;
L9C57:
    CMP #$04                        ;
    BCS L9C7E                       ;If ScrollY is not #$04, branch to exit.
    STA $01                         ;Store #$00, #$01, #$02 or #$03 in address $01.
    DEY                             ;Y now contains CreditPageNumber - 1.
    TXA                             ;
    BNE L9C6C                       ;If ScrollY is #$80 (128) or greater, branch.
    DEY                             ;Y now contains CreditPageNumber - 2.
    BMI L9C7E                       ;If on Credit page less than two , branch to exit.
    TYA                             ;
    ASL                             ;Start with CreditPageNumber - 2-->
    ASL                             ;* 8 + 4 + $01 * 2.
    ASL                             ;This formula is used when ScrollY = 0, 1, 2 and 3.
    ADC #$04                        ;Result is index to find proper credits to load.
    BNE L9C70                       ;Branch always.
L9C6C:
    TYA                             ;
    ASL                             ;Start with CreditPageNumber - 1-->
    ASL                             ;* 8 + $01 * 2.
    ASL                             ;This formula is used when ScrollY = 128,-->
L9C70:
    ADC $01                         ;129, 130 and 131.
    ASL                             ;Result is index to find proper credits to load.
    TAY                             ;
    LDX CreditsPointerTbl,Y         ;Base is $A291. Lower byte of pointer to PPU string.
    LDA CreditsPointerTbl+1,Y       ;Upper byte of pointer to PPU string.
    TAY                             ;
    JMP PreparePPUProcess_          ;($C20E)Prepare to write to PPU.
L9C7E:
    RTS                             ;
 
LoadWaveSprites:
    LDX WaveSpritePointer           ;
    LDA WavePointerTable,X          ;
    STA $00                         ;Load pointer to wave sprite data-->
    LDA WavePointerTable+1,X        ;into addresses $00 and $01.
    STA $01                         ;
    LDX #$20                        ;Offset for sprite RAM load.
    LDY #$00                        ;
    L9C8F:
        LDA ($00),Y                     ;
        STA Sprite00RAM,X               ;Load wave sprites into sprite RAM starting at-->
        INX                             ;location $220 (Sprite08RAM).
        INY                             ;
        CPY WaveSpriteCounter           ;Check to see if sprite RAM load complete.-->
        BNE L9C8F                       ;If not, branch and load another byte.

LoadEndSamusSprites:
    LDX #$30                        ;Index for loading Samus sprite data into sprite RAM.
    LDY SpritePointerIndex          ;
    LDA EndSamusAddrTbl,Y           ;Base is $9D5A.
    STA $00                         ;Load $00 and $01 with pointer to the sprite-->
    LDA EndSamusAddrTbl+1,Y         ;data that shows Samus at the end of the game.
    STA $01                         ;
    LDY #$00                        ;
    L9CAA:
        LDA ($00),Y                     ;Load sprite data starting at Sprite0CRAM.
        STA Sprite00RAM,X               ;Load sprite Y-coord.
        INX                             ;
        INY                             ;Increment X and Y.
        LDA ($00),Y                     ;
        BPL L9CC0                       ;If sprite pattern byte MSB cleared, branch.
            AND #$7F                        ;
            STA Sprite00RAM,X               ;Remove MSB and write sprite pattern data-->
            LDA SpriteAttribByte            ;to sprite RAM.
            EOR #$40                        ;
            BNE L9CC5                       ;
        L9CC0:
            STA Sprite00RAM,X               ;Writes sprite pattern byte to--> 
            LDA SpriteAttribByte            ;sprite RAM if its MSB is not set.
        L9CC5:
        INX                             ;
        STA Sprite00RAM,X               ;Writes sprite attribute byte to sprite RAM.
        INY                             ;
        INX                             ;Increment X and Y.
        LDA ($00),Y                     ;
        STA Sprite00RAM,X               ;Load sprite X-coord.
        INY                             ;
        INX                             ;Increment X and Y.
        CPY SpriteByteCounter           ;
        BNE L9CAA                       ;Repeat until sprite load is complete.
    LDA RoomPtr                     ;
    CMP #$02                        ;If not running the EndSamusFlash routine, branch.
    BCC L9CF9                       ;
    LDA ColorCntIndex               ;
    CMP #$08                        ;If EndSamusFlash routine is more than half-->
    BCC L9CF9                       ;way done, Check ending type for the Samus helmet-->
    LDA EndingType                  ;off ending.  If not helmet off ending, branch.
    CMP #$03                        ;
    BNE L9CF9                       ;
    LDY #$00                        ;
    LDX #$00                        ;
    L9CED:
        LDA SamusHeadSpriteTble,Y       ;The following code loads the sprite graphics-->
        STA Sprite00RAM,X               ;when the helmet off ending is playing.  The-->
        INY                             ;sprites below keep Samus head from flashing-->
        INX                             ;while the rest of her body does.
        CPY #$18                        ;
        BNE L9CED                       ;
L9CF9:
    RTS                             ;
 
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
    .byte $9B, $1F, $01, $80, $A3, $2F, $01, $80, $AB, $3F, $01, $80, $F4, $3F, $01, $80

;Sprite data table used when Samus is in jumpsuit and her waving hand is down.
JsHandDownTable:
    .byte $9B, $2A, $01, $80, $9B, $2B, $01, $88, $A3, $3A, $01, $80, $AB, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is up.
BkHandUpTable:
    .byte $9B, $0C, $01, $80, $A3, $1C, $01, $80, $AB, $3F, $01, $80, $F4, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is down.
BkHandDownTable:
    .byte $9B, $4A, $01, $80, $9B, $4B, $01, $88, $A3, $4D, $01, $80, $AB, $3F, $01, $80

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
    LDY #$00
    L9EAC:
        LDA EndStarDataTable,Y
        STA Sprite1CRAM,Y               ;Load the table below into sprite RAM-->
        INY                             ;starting at address $0270.
        CPY #$9C
        BNE L9EAC
    RTS 

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
    LDA PalDataPending              ;If no palette data pending, branch to exit.
    BEQ L9F80                       ;
    CMP #$0C                        ;If PalDataPending has loaded last palette,-->
    BEQ L9F80                       ;branch to exit.
    CMP #$0D                        ;Once end palettes have been cycled through,-->
    BNE L9F64                       ;start over.
        LDY #$00                        ;
        STY PalDataPending              ;
    L9F64:
    ASL                             ;* 2, pointer is two bytes.
    TAY                             ;
    LDA EndGamePalPntrTbl-1,Y       ;High byte of PPU data pointer.
    LDX EndGamePalPntrTbl-2,Y       ;Low byte of PPU data pointer.
    TAY                             ;
    JSR PreparePPUProcess_          ;($C20E)Prepare to write data string to PPU.
    LDA #$3F                        ;
    STA PPUADDR                  ;
    LDA #$00                        ;
    STA PPUADDR                  ;Set PPU address to $3F00.
    STA PPUADDR                  ;
    STA PPUADDR                  ;Set PPU address to $0000.
L9F80:
    RTS                             ;

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
    .byte $3F                       ;PPU address high byte.
    .byte $00                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
;The following values are written to the background palette:
    .byte $0F, $21, $11, $02, $0F, $29, $1B, $1A, $0F, $27, $28, $29, $0F, $28, $18, $08
;The following values are written to the sprite palette:
    .byte $0F, $16, $19, $27, $0F, $36, $15, $17, $0F, $12, $21, $20, $0F, $35, $12, $16 

    .byte $00                       ;End EndGamePal00 data.

EndGamePal01:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $10, $20, $30, $0F, $0F, $0F, $0F

    .byte $00                       ;End EndGamePal01 data.

EndGamePal02:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $12, $22, $32, $0F, $0B, $1B, $2B

    .byte $00                       ;End EndGamePal02 data.

EndGamePal03:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $14, $24, $34, $0F, $09, $19, $29 

    .byte $00                       ;End EndGamePal03 data.

EndGamePal04:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $16, $26, $36, $0F, $07, $17, $27

    .byte $00                       ;End EndGamePal04 data.

EndGamePal05:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $18, $28, $38, $0F, $05, $15, $25 

    .byte $00                       ;End EndGamePal05 data.

EndGamePal06:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $1A, $2A, $3A, $0F, $03, $13, $13

    .byte $00                       ;End EndGamePal06 data.

EndGamePal07:
    .byte $3F                       ;PPU address high byte.
    .byte $18                       ;PPU address low byte.
    .byte $08                       ;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
    .byte $0F, $1C, $2C, $3C, $0F, $01, $11, $21 

    .byte $00                       ;End EndGamePal07 data.

EndGamePal08:
    .byte $3F                       ;PPU address high byte.
    .byte $0C                       ;PPU address low byte.
    .byte $04                       ;PPU string length.
;The following values are written to the background palette starting at $3F0C:
    .byte $0F, $18, $08, $07

    .byte $3F                       ;PPU address high byte.
    .byte $10                       ;PPU address low byte.
    .byte $10                       ;PPU string length.
;The following values are written to the sprite palette:
    .byte $0F, $26, $05, $07, $0F, $26, $05, $07, $0F, $01, $01, $05, $0F, $13, $1C, $0C

    .byte $00                       ;End EndGamePal08 data.

EndGamePal09:
    .byte $3F                       ;PPU address high byte.
    .byte $0C                       ;PPU address low byte.
    .byte $04                       ;PPU string length.
;The following values are written to the background palette starting at $3F0C:
    .byte $0F, $08, $07, $0F

    .byte $3F                       ;PPU address high byte.
    .byte $10                       ;PPU address low byte.
    .byte $10                       ;PPU string length.
;The following values are written to the sprite palette:
    .byte $0F, $06, $08, $0F, $0F, $06, $08, $0F, $0F, $00, $10, $0F, $0F, $01, $0C, $0F

    .byte $00                       ;End EndGamePal09 data.

EndGamePal0A:
PPUStringRepeat $3F0C, $0F, $04
PPUStringRepeat $3F10, $0F, $10

    .byte $00                       ;End EndGamePal0A data.

;The following data writes the end game backgroud graphics.

;Writes ground graphics on name table 0 in row $2300 (25th row from top).
LA052:
    .byte $23                       ;PPU address high byte.
    .byte $00                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31
    .byte $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31

;Writes ground graphics on name table 0 in row $2320 (26th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $20                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33
    .byte $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33

    ;Writes ground graphics on name table 0 in row $2340 (27th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $40                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35
    .byte $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35

    ;Writes ground graphics on name table 0 in row $2360 (28th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $60                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37
    .byte $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37

    ;Writes ground graphics on name table 0 in row $2380 (29th row from top).
    .byte $23                       ;PPU address high byte.
    .byte $80                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39
    .byte $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39

    ;Writes ground graphics on name table 0 in row $23A0 (bottom row).
    .byte $23                       ;PPU address high byte.
    .byte $A0                       ;PPU address low byte.
    .byte $20                       ;PPU string length.
    .byte $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B
    .byte $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B

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
LA1BA:  .word LA1C2, LA1EB, LA20F, LA240

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
LA265:  .word LA26D, LA276, LA27F, LA288

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
    .byte $20                       ;PPU address high byte.
    .byte $26                       ;PPU address low byte.
    .byte $14                       ;PPU string length.
    .byte $FF, $FF, $FF, $FF, $FF, $24, $25, $26, $27, $FF, $FF, $2C, $2D, $2E, $2F, $FF
    .byte $FF, $FF, $FF, $FF

    .byte $00                       ;End PPU string write.

;Writes the bottom half of 'The End' on name table 0 in row $2040 (3rd row from top).
LA508:
    .byte $20                       ;PPU address high byte.
    .byte $4B                       ;PPU address low byte.
    .byte $0A                       ;PPU string length.
    .byte $28, $29, $2A, $2B, $FF, $FF, $02, $03, $04, $05

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
    LDA #.lobyte(WorldMap)
    STA $00
    LDA #.hibyte(WorldMap)
    STA $01
    LDA #$00
    STA $02
    LDA #$70
    STA $03
    LDX #$04
    LA950:
        LDY #$00
        LA952:
            LDA ($00),Y
            STA ($02),Y
            INY
            BNE LA952
        INC $01
        INC $03
        DEX
        BNE LA950
    RTS
 
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
