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
; Disassembled, reconstructed and commented
; by SnowBro [Kent Hansen] <kentmhan@online.no>
; Continued by Dirty McDingus (nmikstas@yahoo.com)
; A work in progress.

;Game engine (memory page 7)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

BANK .set 7
.segment "BANK_07_MAIN"

;-------------------------------------[ Forward declarations ]--------------------------------------

ObjectAnimIndexTbl     = $8572
FramePtrTable          = $860B
PlacePtrTable          = $86DF

SamusEnterDoor         = $8B13
PalPntrTbl             = $9560
AreaPointers           = $9598
AreaRoutine            = $95C3
ChooseEnemyRoutine     = $95E5
EnemyHitPointTbl       = $962B
EnemyInitDelayTbl      = $96BB
L97AF                  = $97AF

SpecItmsTable          = $9598
SoundEngine            = $B3B4

;--------------------------------------------[ Export ]---------------------------------------------

.export Startup
.export NMI
.export ClearNameTables
.export ClearNameTable0
.export EraseAllSprites
.export RemoveIntroSprites
.export ClearRAM_33_DF
.export PreparePPUProcess_
.export ChooseRoutine
.export AddYToPtr02
.export Adiv32
.export Adiv16
.export Adiv8
.export Amul16
.export Amul8
.export ProcessPPUString
.export EraseTile
.export WritePPUByte
.export PrepPPUPaletteString
.export TwosCompliment
.export Base10Subtract
.export SubtractHealth
.export SetProjectileAnim
.export SetProjectileAnim2
.export UpdateEnemyAnim
.export VerticalRoomCentered
.export EnemyCheckMoveUp
.export EnemyCheckMoveDown
.export EnemyCheckMoveLeft
.export EnemyCheckMoveRight
.export WaitNMIPass
.export ScreenOff
.export WaitNMIPass_
.export ScreenOn
.export ExitSub
.export ScreenNmiOff
.export VBOffAndHorzWrite
.export NMIOn
.export SetTimer
.export ClearSamusStats
.export InitEndGFX
.export LoadSamusGFX
.export InitGFX7
.export BankTable
.export ChooseEnding
.export SilenceMusic
.export AnimDrawObject
.export SFX_Door
.export OrEnData05
.export ReadTableAt968B
.export MapScrollRoutine
.export MotherBrainMusic
.export TourianMusic
.export SelectSamusPal
.export MakeCartRAMPtr
.export LDD8B
.export LE449
.export LEB6E
.export LF410
.export LF416
.export LF438
.export LF68D
.export LF83E
.export LF852
.export LF85A
.export LF870
.export LFA1E
.export LFB70
.export LFB88
.export LFBB9
.export LFBCA
.export LFD8F
.export LFEDC


;---------------------------------------------[ Import ]---------------------------------------------

.import MainTitleRoutine
.import StarPalSwitch
.import DecSpriteYCoord
.import NMIScreenWrite
.import EndGamePalWrite
.import CopyMap

.import GotoLA320
.import GotoMetroid_LA315
.import GotoL9C6F
.import GotoCannonRoutine
.import GotoMotherBrainRoutine
.import GotoZebetiteRoutine
.import GotoRinkaSpawnerRoutine
.import GotoLA0C6
.import GotoLA142

.import GFX_Samus
.import GFX_IntroSprites
.import GFX_Title
.import GFX_SamusSuitless
.import GFX_ExclamationPoint
.import GFX_Solid
.import GFX_BrinBG1
.import GFX_CREBG2
.import GFX_NorfBG1
.import GFX_NorfBG2
.import GFX_BossBG
.import GFX_TourBG
.import GFX_Zebetite
.import GFX_KraiBG2
.import GFX_RidlBG
.import GFX_Font

;------------------------------------------[ Start of code ]-----------------------------------------

;This routine generates pseudo random numbers and updates those numbers
;every frame. The random numbers are used for several purposes including
;password scrambling and determinig what items, if any, an enemy leaves
;behind after it is killed.

RandomNumbers: ;$C000
    txa
    pha
    ldx #$05
    @:
        lda RandomNumber1
        clc
        adc #$05
        sta RandomNumber1               ;2E is increased by #$19 every frame and-->
        lda RandomNumber2               ;2F is increased by #$5F every frame.
        clc
        adc #$13
        sta RandomNumber2
        dex
        bne @-
    pla
    tax
    lda RandomNumber1
    rts

;------------------------------------------[ Startup ]----------------------------------------------

Startup:
    lda #$00
    sta MMC1Reg1                    ;Clear bit 0. MMC1 is serial controlled
    sta MMC1Reg1                    ;Clear bit 1
    sta MMC1Reg1                    ;Clear bit 2
    sta MMC1Reg1                    ;Clear bit 3
    sta MMC1Reg1                    ;Clear bit 4
    sta MMC1Reg2                    ;Clear bit 0
    sta MMC1Reg2                    ;Clear bit 1
    sta MMC1Reg2                    ;Clear bit 2
    sta MMC1Reg2                    ;Clear bit 3
    sta MMC1Reg2                    ;Clear bit 4
    jsr MMCWriteReg3                ;($C4FA)Swap to PRG bank #0 at $8000
    dex                             ;X = $FF
    txs                             ;S points to end of stack page

;Clear RAM at $000-$7FF.
    ldy #$07                        ;High byte of start address.
    sty $01                         ;
    ldy #$00                        ;Low byte of start address.
    sty $00                         ;$0000 = #$0700
    tya                             ;A = 0
    LC048:
        sta ($00),y                     ;clear address
        iny                             ;
        bne LC048                       ;Repeat for entire page.
        dec $01                         ;Decrement high byte of address.
        bmi LC057                       ;If $01 < 0, all pages are cleared.
        ldx $01                         ;
        cpx #$01                        ;Keep looping until ram is cleared.
        bne LC048                       ;

;Clear cartridge RAM at $6000-$7FFF.
LC057:
    ldy #$7F                        ;High byte of start address.
    sty $01                         ;
    ldy #$00                        ;Low byte of start address.
    sty $00                         ;$0000 points to $7F00
    tya                             ;A = 0
    LC060:
        sta ($00),y                     ;
        iny                             ;Clears 256 bytes of memory before decrementing to next-->
        bne LC060                       ;256 bytes.
        dec $01                         ;
        ldx $01                         ;Is address < $6000?-->
        cpx #$60                        ;If not, do another page.
        bcs LC060                       ;


    ;Vertical mirroring.
    ;H/V mirroring (As opposed to one-screen mirroring).
    ;Switch low PRGROM area during a page switch.
    ;16KB PRGROM switching enabled.
    ;8KB CHRROM switching enabled.
    lda #MMC1_0_MIRROR_VERTI | MMC1_0_PRGFIXED_C000 | MMC1_0_PRGBANK_16K | MMC1_0_CHRBANK_8K
    sta MMCReg0Cntrl

    lda #$00                        ;Clear bits 3 and 4 of MMC1 register 3.
    sta SwitchUpperBits             ;

    ldy #$00                        ;
    sty ScrollX                     ;ScrollX = 0
    sty ScrollY                     ;ScrollY = 0
    sty PPUSCROLL                   ;Clear hardware scroll x
    sty PPUSCROLL                   ;Clear hardware scroll y
    iny                             ;Y = #$01
    sty GameMode                    ;Title screen mode
    jsr ClearNameTables             ;($C158)
    jsr EraseAllSprites             ;($C1A3)

    ;NMI = enabled
    ;Sprite size = 8x8
    ;BG pattern table address = $1000
    ;SPR pattern table address = $0000
    ;PPU address increment = 1
    ;Name table address = $2000
    lda #PPUCTRL_VBLKNMI_ON | PPUCTRL_OBJH_8 | PPUCTRL_BG_1000 | PPUCTRL_OBJ_0000 | PPUCTRL_INCR_FWD | PPUCTRL_NMTBL_2000
    sta PPUCTRL
    sta PPUCTRL_ZP

    ;Sprites visible = no
    ;Background visible = no
    ;Sprite clipping = yes
    ;Background clipping = no
    ;Display type = color
    lda #PPUMASK_OBJ_OFF | PPUMASK_BG_OFF | PPUMASK_HIDE8OBJ | PPUMASK_SHOW8BG | PPUMASK_COLOR
    sta PPUMASK_ZP

    lda #$47                        ;
    sta MirrorCntrl                 ;Prepare to set PPU to vertical mirroring.
    jsr PrepVertMirror              ;($C4B2)

    lda #$00                        ;
    sta DMCCntrl1                   ;PCM volume = 0 - disables DMC channel
    lda #$0F                        ;
    sta APUCommonCntrl0             ;Enable sound channel 0,1,2,3

    ldy #$00                        ;
    sty TitleRoutine                ;Set title routine and and main routine function-->
    sty MainRoutine                 ;pointers equal to 0.
    lda #$11                        ;
    sta RandomNumber1               ;Initialize RandomNumber1 to #$11
    lda #$FF                        ;
    sta RandomNumber2               ;Initialize RandomNumber2 to #$FF

    iny                             ;Y = 1
    sty SwitchPending               ;Prepare to switch page 0 into lower PRGROM.
    jsr CheckSwitch                 ;($C4DE)
    bne WaitNMIEnd                  ;Branch always

;-----------------------------------------[ Main loop ]----------------------------------------------

;The main loop runs all the routines that take place outside of the NMI.

MainLoop:
    jsr CheckSwitch                 ;($C4DE)Check to see if memory page needs to be switched.
    jsr UpdateTimer                 ;($C266)Update Timers 1, 2 and 3.
    jsr GoMainRoutine               ;($C114)Go to main routine for updating game.
    inc FrameCount                  ;Increment frame counter.
    lda #$00                        ;
    sta NMIStatus                   ;Wait for next NMI to end.

WaitNMIEnd:
    tay                             ;
    lda NMIStatus                   ;
    bne LC0D3                       ;If nonzero, NMI has ended. Else keep waiting.
    jmp WaitNMIEnd                  ;

LC0D3:
    jsr RandomNumbers               ;($C000)Update pseudo random numbers.
    jmp MainLoop                    ;($C0BC)Jump to top of subroutine.

;-------------------------------------[ Non-Maskable Interrupt ]-------------------------------------

;The NMI is called 60 times a second by the VBlank signal from the PPU. When the
;NMI routine is called, the game should already be waiting for it in the main
;loop routine in the WaitNMIEnd loop.  It is possible that the main loop routine
;will not be waiting as it is bogged down with excess calculations. This causes
;the game to slow down.

NMI:
    php                             ;Save processor status, A, X and Y on stack.
    pha                             ;Save A.
    txa                             ;
    pha                             ;Save X.
    tya                             ;
    pha                             ;Save Y.
    lda #$00                        ;
    sta OAMADDR                  ;Sprite RAM address = 0.
    lda #$02                        ;
    sta OAMDMA                   ;Transfer page 2 ($200-$2FF) to Sprite RAM.
    lda NMIStatus                   ;
    bne LC103                       ;Skip if the frame couldn't finish in time.
        lda GameMode                    ;
        beq LC0F4                       ;Branch if mode=Play.
            jsr NMIScreenWrite              ;($9A07)Write end message on screen(If appropriate).
        LC0F4:
        jsr CheckPalWrite               ;($C1E0)Check if palette data pending.
        jsr CheckPPUWrite               ;($C2CA)check if data needs to be written to PPU.
        jsr WritePPUCtrl                ;($C44D)Update $2000 & $2001.
        jsr WriteScroll                 ;($C29A)Update h/v scroll reg.
        jsr ReadJoyPads                 ;($C215)Read both joypads.
    LC103:
    jsr SoundEngine                 ;($B3B4)Update music and SFX.
    jsr UpdateAge                   ;($C97E)Update Samus' age.
    ldy #$01                        ; NMI = finished.
    sty NMIStatus                   ;
    pla                             ;Restore Y.
    tay                             ;
    pla                             ;Restore X.
    tax                             ;
    pla                             ;restore A.
    plp                             ;Restore processor status flags.
    rti                             ;Return from NMI.

;----------------------------------------[ GoMainRoutine ]-------------------------------------------

;This is where the real code of each frame is executed.
;MainRoutine or TitleRoutine (Depending on the value of GameMode)
;is used as an index into a code pointer table, and this routine
;is executed.

GoMainRoutine:
    lda GameMode                    ;0 if game is running, 1 if at intro screen.
    beq LC11B                       ;Branch if mode=Play.
        jmp MainTitleRoutine            ;Jump to $8000, where a routine similar to the one-->
                                        ;below is executed, only using TitleRoutine instead
                                        ;of MainRoutine as index into a jump table.
    LC11B:
    lda Joy1Change                  ;
    and #$10                        ;Has START been pressed?-->
    beq LC13C                       ;if not, execute current routine as normal.

    lda MainRoutine                 ;
    cmp #$03                        ;Is game engine running?-->
    beq LC12F                       ;If yes, check for routine #5 (pause game).
        cmp #$05                        ;Is game paused?-->
        bne LC13C                       ;If not routine #5 either, don't care about START being pressed.
        lda #$03                        ;Otherwise, switch to routine #3 (game engine).
        bne LC131                       ;Branch always.
    LC12F:
           lda #$05                        ;Switch to pause routine.
    LC131:
    sta MainRoutine                 ;(MainRoutine = 5 if game paused, 3 if game engine running).
    lda GamePaused                  ;
    eor #$01                        ;Toggle game paused.
    sta GamePaused                  ;
    jsr PauseMusic                  ;($CB92)Silences music while game paused.

LC13C:
    lda MainRoutine                 ;
    jsr ChooseRoutine               ;($C27C)Use MainRoutine as index into routine table below.
        .word AreaInit                  ;($C801)Area init.
        .word MoreInit                  ;($C81D)More area init.
        .word SamusInit                 ;($C8D1)Samus init.
        .word GameEngine                ;($C92B)Game engine.
        .word PrepareGameOver           ;($C9A6)Display GAME OVER.
        .word PauseMode                 ;($C9B1)Pause game.
        .word GoPassword                ;($C9C4)Display password.
        .word IncrementRoutine          ;($C155)Just advances to next routine in table.
        .word SamusIntro                ;($C9D7)Intro.
        .word WaitTimer                 ;($C494)Delay.

IncrementRoutine:
    inc MainRoutine                 ;Increment to next routine in above table.
    rts                             ;

;-------------------------------------[ Clear name tables ]------------------------------------------

ClearNameTables:
    jsr ClearNameTable0             ;($C16D)Always clear name table 0 first.
    lda GameMode                    ;
    beq LC165                       ;Branch if mode = Play.
    lda TitleRoutine                ;
    cmp #$1D                        ;If running the end game routine, clear-->
    beq LC169                       ;name table 2, else clear name table 1.
LC165:
    lda #$02                        ;Name table to clear + 1 (name table 1).
    bne LC16F                       ;Branch always.
LC169:
    lda #$03                        ;Name table to clear + 1 (name table 2).
    bne LC16F                       ;Branch always.

ClearNameTable0:
    lda #$01                        ;Name table to clear + 1 (name table 0).
LC16F:
    sta $01                         ;Stores name table to clear.
    lda #$FF                        ;
    sta $00                         ;Value to fill with.

ClearNameTable:
    ldx PPUSTATUS                   ;Reset PPU address latch.
    lda PPUCTRL_ZP                  ;
    and #$FB                        ;PPU increment = 1.
    sta PPUCTRL_ZP                  ;
    sta PPUCTRL                     ;Store control bits in PPU.
    ldx $01                         ;
    dex                             ;Name table = X - 1.
    lda HiPPUTable,x                ;get high PPU address.  pointer table at $C19F.
    sta PPUADDR                     ;
    lda #$00                        ;Set PPU start address (High byte first).
    sta PPUADDR                     ;
    ldx #$04                        ;Prepare to loop 4 times.
    ldy #$00                        ;Inner loop value.
    lda $00                         ;Fill-value.
    LC195:
        sta PPUDATA                     ;
        dey                             ;
        bne LC195                       ;Loops until the desired name table is cleared.-->
        dex                             ;It also clears the associated attribute table.
        bne LC195                       ;
    rts                             ;

;The following table is used by the above routine for finding
;the high byte of the proper name table to clear.

HiPPUTable:
    .byte $20                       ;Name table 0.
    .byte $24                       ;Name table 1.
    .byte $28                       ;Name table 2.
    .byte $2C                       ;Name table 3.

;-------------------------------------[ Erase all sprites ]------------------------------------------

EraseAllSprites:
    ldy #$02                        ;
    sty $01                         ;Loads locations $00 and $01 with -->
    ldy #$00                        ;#$00 and #$02 respectively
    sty $00                         ;
    ldy #$00                        ;
    lda #$F0                        ;
    LC1AF:
        sta ($00),y                     ;Stores #$F0 in memory addresses $0200 thru $02FF.
        iny                             ;
        bne LC1AF                       ;Loop while more sprite RAM to clear.
    lda GameMode                    ;
    beq Exit101                     ;Exit subroutine if GameMode=Play(#$00)
        jmp DecSpriteYCoord             ;($988A)Find proper y coord of sprites.
    Exit101:
    rts                             ;Return used by subroutines above and below.

;---------------------------------------[ Remove intro sprites ]-------------------------------------

;The following routine is used in the Intro to remove the sparkle sprites and the crosshairs
;sprites every frame.  It does this by loading the sprite values with #$F4 which moves the
;sprite to the bottom right of the screen and uses a blank graphic for the sprite.

RemoveIntroSprites:
    ldy #$02                        ;Start at address $200.
    sty $01                         ;
    ldy #$00                        ;
    sty $00                         ;($00) = $0200 (sprite page)
    ldy #$5F                        ;Prepare to clear RAM $0200-$025F
    lda #$F4                        ;
    LC1C8:
        sta ($00),y                     ;
        dey                             ;Loop unitl $200 thru $25F is filled with #$F4.
        bpl LC1C8                       ;
    lda GameMode                    ;
    beq Exit101                     ; branch if mode = Play.
        jmp DecSpriteYCoord             ;($988A)Find proper y coord of sprites.

;-------------------------------------[Clear RAM $33 thru $DF]---------------------------------------

;The routine below clears RAM associated with rooms and enemies.

ClearRAM_33_DF:
    ldx #$33                        ;
    lda #$00                        ;
    LC1D8:
        sta $00,x                       ;Clear RAM addresses $33 through $DF.
        inx                             ;
        cpx #$E0                        ;
        bcc LC1D8                       ;Loop until all desired addresses are cleared.
    rts                             ;

;--------------------------------[ Check and prepare palette write ]---------------------------------

CheckPalWrite:
    lda GameMode                    ;
    beq LC1ED                       ;Is game being played? If so, branch to exit.
    lda TitleRoutine                ;
    cmp #$1D                        ;Is Game at ending sequence? If not, branch
    bcc LC1ED                       ;
    jmp EndGamePalWrite             ;($9F54)Write palette data for ending.
LC1ED:
    ldy PalDataPending              ;
    bne LC1FF                       ;Is palette data pending? If so, branch.
        lda GameMode                    ;
        beq LC1FE                       ;Is game being played? If so, branch to exit.
        lda TitleRoutine                ;
        cmp #$15                        ;Is intro playing? If not, branch.
        bcs LC1FE                       ;
        jmp StarPalSwitch               ;($8AC7)Cycles palettes for intro stars twinkle.
        LC1FE:
        rts                             ;Exit when no palette data pending.

;Prepare to write palette data to PPU.

LC1FF:
    dey                             ;Palette # = PalDataPending - 1.
    tya                             ;
    asl                             ;* 2, each pal data ptr is 2 bytes (16-bit).
    tay                             ;
    ldx PalPntrTbl,y                     ;X = low byte of PPU data pointer.
    lda PalPntrTbl+1,y                     ;
    tay                             ;Y = high byte of PPU data pointer.
    lda #$00                        ;Clear A.
    sta PalDataPending              ;Reset palette data pending byte.

PreparePPUProcess_:
    stx $00                         ;Lower byte of pointer to PPU string.
    sty $01                         ;Upper byte of pointer to PPU string.
    jmp ProcessPPUString            ;($C30C)Write data string to PPU.

;----------------------------------------[Read joy pad status ]--------------------------------------

;The following routine reads the status of both joypads

ReadJoyPads:
    ldx #$00                        ;Load x with #$00. Used to read status of joypad 1.
    stx $01                         ;
    jsr ReadOnePad                  ;
    inx                             ;Load x with #$01. Used to read status of joypad 2.
    inc $01                         ;

ReadOnePad:
    ldy #$01                        ;These lines strobe the -->
    sty CPUJoyPad1                  ;joystick to enable the -->
    dey                             ;program to read the -->
    sty CPUJoyPad1                  ;buttons pressed.

    ldy #$08                        ;Do 8 buttons.
    LC22A:
        pha                             ;Store A.
        lda CPUJoyPad1,x                ;Read button status. Joypad 1 or 2.
        sta $00                         ;Store button press at location $00.
        lsr                             ;Move button push to carry bit.
        ora $00                         ;If joystick not connected, -->
        lsr                             ;fills Joy1Status with all 1s.
        pla                             ;Restore A.
        rol                             ;Add button press status to A.
        dey                             ;Loop 8 times to get -->
        bne LC22A                       ;status of all 8 buttons.

    ldx $01                         ;Joypad #(0 or 1).
    ldy Joy1Status,x                ;Get joypad status of previous refresh.
    sty $00                         ;Store at $00.
    sta Joy1Status,x                ;Store current joypad status.
    eor $00                         ;
    beq LC24D                       ;Branch if no buttons changed.
        lda $00                         ;
        and #$BF                        ;Remove the previous status of the B button.
        sta $00                         ;
        eor Joy1Status,x                ;
    LC24D:
    and Joy1Status,x                ;Save any button changes from the current frame-->
    sta Joy1Change,x                ;and the last frame to the joy change addresses.
    sta Joy1Retrig,x                ;Store any changed buttons in JoyRetrig address.
    ldy #$20                        ;
    lda Joy1Status,x                ;Checks to see if same buttons are being-->
    cmp $00                         ;pressed this frame as last frame.-->
    bne LC263                       ;If none, branch.
    dec RetrigDelay1,x              ;Decrement RetrigDelay if same buttons pressed.
    bne LC265                       ;
    sta Joy1Retrig,x                ;Once RetrigDelay=#$00, store buttons to retrigger.
    ldy #$08                        ;
LC263:
    sty RetrigDelay1,x              ;Reset retrigger delay to #$20(32 frames)-->
LC265:
    rts                             ;or #$08(8 frames) if already retriggering.

;-------------------------------------------[ Update timer ]-----------------------------------------

;This routine is used for timing - or for waiting around, rather.
;TimerDelay is decremented every frame. When it hits zero, $2A, $2B and $2C are
;decremented if they aren't already zero. The program can then check
;these variables (it usually just checks $2C) to determine when it's time
;to "move on". This is used for the various sequences of the intro screen,
;when the game is started, when Samus takes a special item, and when GAME
;OVER is displayed, to mention a few examples.

UpdateTimer:
    ldx #$01                        ;First timer to decrement is Timer2.
    dec TimerDelay                  ;
    bpl DecTimer                    ;
        lda #$09                        ;TimerDelay hits #$00 every 10th frame.
        sta TimerDelay                  ;Reset TimerDelay after it hits #$00.
        ldx #$02                        ;Decrement Timer3 every 10 frames.

    DecTimer:
        lda Timer1,x                    ;
        beq LC278                       ;Don't decrease if timer is already zero.
            dec Timer1,x                    ;
        LC278:
        dex                             ;Timer1 and Timer2 decremented every frame.
        bpl DecTimer                    ;
    rts                             ;

;-----------------------------------------[ Choose routine ]-----------------------------------------

;This is an indirect jump routine. A is used as an index into a code
;pointer table, and the routine at that position is executed. The programmers
;always put the pointer table itself directly after the JSR to ChooseRoutine,
;meaning that its address can be popped from the stack.

ChooseRoutine:
    asl                             ;* 2, each ptr is 2 bytes (16-bit).
    sty TempY                       ;Temp storage.
    stx TempX                       ;Temp storage.
    tay                             ;
    iny                             ;
    pla                             ;Low byte of ptr table address.
    sta CodePtr                     ;
    pla                             ;High byte of ptr table address.
    sta CodePtr+1                   ;
    lda (CodePtr),y                 ;Low byte of code ptr.
    tax                             ;
    iny                             ;
    lda (CodePtr),y                 ;High byte of code ptr.
    sta CodePtr+1                   ;
    stx CodePtr                     ;
    ldx TempX                       ;Restore X.
    ldy TempY                       ;Restore Y.
    jmp (CodePtr)                   ;

;--------------------------------------[ Write to scroll registers ]---------------------------------

WriteScroll:
    lda PPUSTATUS                   ;Reset scroll register flip/flop
    lda ScrollX                     ;
    sta PPUSCROLL                   ;
    lda ScrollY                     ;X and Y scroll offsets are loaded serially.
    sta PPUSCROLL                   ;
    rts                             ;

;----------------------------------[ Add y index to stored addresses ]-------------------------------

;Add Y to pointer at $0000.

AddYToPtr00:
    tya                             ;
    clc                             ;Add value stored in Y to lower address-->
    adc $00                         ;byte stored in $00.
    sta $00                         ;
    bcc LC2B2                       ;Increment $01(upper address byte) if carry-->
        inc $01                     ;has occurred.
    LC2B2:
    rts                             ;

;Add Y to pointer at $0002

AddYToPtr02:
    tya                             ;
    clc                             ;Add value stored in Y to lower address-->
    adc $02                         ;byte stored in $02.
    sta $02                         ;
    bcc LC2BD                       ;Increment $01(upper address byte) if carry-->
        inc $03                     ;has occurred.
    LC2BD:
    rts                             ;

;--------------------------------[ Simple divide and multiply routines ]-----------------------------

Adiv32:
    lsr                             ;Divide by 32.

Adiv16:
    lsr                             ;Divide by 16.

Adiv8:
    lsr                             ;Divide by 8.
    lsr                             ;
    lsr                             ;Divide by shifting A right.
    rts                             ;

Amul32:
    asl                             ;Multiply by 32.

Amul16:
    asl                             ;Multiply by 16.

Amul8:
    asl                             ;Multiply by 8.
    asl                             ;
    asl                             ;Multiply by shifting A left.
    rts                             ;

;-------------------------------------[ PPU writing routines ]---------------------------------------

;Checks if any data is waiting to be written to the PPU.
;RLE data is one tile that repeats several times in a row.  RLE-Repeat Last Entry

CheckPPUWrite:
    lda PPUDataPending              ;
    beq LC2E3                       ;If zero no PPU data to write, branch to exit.
    lda #$A1                        ;
    sta $00                         ;Sets up PPU writer to start at address $07A1.
    lda #$07                        ;
    sta $01                         ;$0000 = ptr to PPU data string ($07A1).
    jsr ProcessPPUString            ;($C30C)write it to PPU.
    lda #$00                        ;
    sta PPUStrIndex                 ;PPU data string has been written so the data-->
    sta PPUDataString               ;stored for the write is now erased.
    sta PPUDataPending              ;
LC2E3:
       rts                             ;

PPUWrite:
    sta PPUADDR                     ;Set high PPU address.
    iny                             ;
    lda ($00),y                     ;
    sta PPUADDR                     ;Set low PPU address.
    iny                             ;
    lda ($00),y                     ;Get data byte containing rep length & RLE status.
    asl                             ;Carry Flag = PPU address increment (0 = 1, 1 = 32).
    jsr SetPPUInc                   ;($C318)Update PPUCtrl0 according to Carry Flag.
    asl                             ;Carry Flag = bit 6 of byte at ($00),y (1 = RLE).
    lda ($00),y                     ;Get data byte again.
    and #$3F                        ;Keep lower 6 bits as loop counter.
    tax                             ;
    bcc PPUWriteLoop                ;If Carry Flag not set, the data is not RLE.
    iny                             ;Data is RLE, advance to data byte.

PPUWriteLoop:
    bcs LC300                           ;
        iny                             ;Only inc Y if data is not RLE.
    LC300:
    lda ($00),y                     ;Get data byte.
    sta PPUDATA                     ;Write to PPU.
    dex                             ;Decrease loop counter.
    bne PPUWriteLoop                ;Keep going until X=0.
    iny                             ;
    jsr AddYToPtr00                 ;($C2A8)Point to next data chunk.

;Write data string at ($00) to PPU.

ProcessPPUString:
    ldx PPUSTATUS                   ;Reset PPU address flip/flop.
    ldy #$00                        ;
    lda ($00),y                     ;
    bne PPUWrite                    ;If A is non-zero, PPU data string follows,-->
    jmp WriteScroll                 ;($C29A)Otherwise we're done.

;In: CF = desired PPU address increment (0 = 1, 1 = 32).
;Out: PPU control #0 ($2000) updated accordingly.

SetPPUInc:
    pha                             ;Preserve A.
    lda PPUCTRL_ZP                  ;
    ora #$04                        ;
    bcs LC321                           ;PPU increment = 32 only if Carry Flag set,-->
        and #$FB                        ;else PPU increment = 1.
    LC321:
    sta PPUCTRL                     ;
    sta PPUCTRL_ZP                  ;
    pla                             ;Restore A.
    rts                             ;

;Erase blasted tile on nametable.  Each screen is 16 tiles across and 15 tiles down.
EraseTile:
    ldy #$01                        ;
    sty PPUDataPending              ;data pending = YES.
    dey                             ;
    lda ($02),y                     ;
    and #$0F                        ;
    sta $05                         ;# of tiles horizontally.
    lda ($02),y                     ;
    jsr Adiv16                      ;($C2BF)/ 16.
    sta $04                         ;# of tiles vertically.
    ldx PPUStrIndex                 ;
    LC33D:
        lda $01                         ;
        jsr WritePPUByte                ;($C36B)write PPU high address to $07A1,PPUStrIndex.
        lda $00                         ;
        jsr WritePPUByte                ;($C36B)write PPU low address to $07A1,PPUStrIndex.
        lda $05                         ;data length.
        sta $06                         ;
        jsr WritePPUByte                ;($C36B)write PPU string length to $07A1,PPUStrIndex.
        LC34E:
            iny                             ;
            lda ($02),y                     ;Get new tile to replace old tile.
            jsr WritePPUByte                ;($C36B)Write it to $07A1,PPUStrIndex, inc x.
            dec $06                         ;
            bne LC34E                       ;Branch if more horizontal tiles to replace.
        stx PPUStrIndex                 ;
        sty $06                         ;
        ldy #$20                        ;
        jsr AddYToPtr00                 ;($C2A8)Move to next name table line.
        ldy $06                         ;Store index to find next tile info.
        dec $04                         ;
        bne LC33D                       ;Branch if more lines need to be changed on name table.
    jsr EndPPUString                ;($c376)Finish writing PPU string and exit.

WritePPUByte:
    sta PPUDataString,x             ;Store data byte at end of PPUDataString.

NextPPUByte:
    inx                             ;PPUDataString has increased in size by 1 byte.
    cpx #$4F                        ;PPU byte writer can only write a maximum of #$4F bytes
    bcc LC37D                           ;If PPU string not full, branch to get more data.
    ldx PPUStrIndex                 ;

EndPPUString:
    lda #$00                        ;If PPU string is already full, or all PPU bytes loaded,-->
    sta PPUDataString,x             ;add #$00 as last byte to the PPU byte string.
    pla                             ;
    pla                             ;Remove last return address from stack and jump out of-->
LC37D:
    rts                             ;PPU writing routines.

;The following routine is only used by the intro routine to load the sprite
;palette data for the twinkling stars. The following memory addresses are used:
;$00-$01 Destination address for PPU write, $02-$03 Source address for PPU data,
;$04 Temp storage for PPU data byte, $05 PPU data string counter byte,
;$06 Temp storage for index byte.

PrepPPUPaletteString:
    ldy #$01                        ;
    sty PPUDataPending              ;Indicate data waiting to be written to PPU.
    dey                             ;
    beq LC3BC                       ;Branch always

LC385:
    sta $04                         ;$04 now contains next data byte to be put into the PPU string.
    lda $01                         ;High byte of staring address to write PPU data
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda $00                         ;Low byte of starting address to write PPU data.
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda $04                         ;A now contains next data byte to be put into the PPU string.
    jsr SeparateControlBits         ;($C3C6)Break control byte into two bytes.

    bit $04                         ;Check to see if RLE bit is set in control byte.-->
    bvc WritePaletteStringByte      ;If not set, branch to load byte. Else increment index-->
    iny                             ;to find repeating data byte.

WritePaletteStringByte:
    bit $04                         ;Check if RLE bit is set (again). if set, load same-->
    bvs LC3A0                           ;byte over and over again until counter = #$00.
        iny                             ;Non-repeating data byte. Increment for next byte.
    LC3A0:
    lda ($02),y                     ;
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    sty $06                         ;Temporarily store data index.
    ldy #$01                        ;PPU address increment = 1.
    bit $04                         ;If MSB set in control bit, it looks like this routine might-->
    bpl LC3AF                           ;have been used for a software control verticle mirror, but-->
                                        ;the starting address has already been written to the PPU-->
                                        ;string so this section has no effect whether the MSB is set-->
                                        ;or not. The PPU is always incremented by 1.
        ldy #$20                        ;PPU address increment = 32.
    LC3AF:
    jsr AddYToPtr00                 ;($C2A8)Set next PPU write address.(Does nothing, already set).
    ldy $06                         ;Restore data index to Y.
    dec $05                         ;Decrement counter byte.
    bne WritePaletteStringByte      ;If more bytes to write, branch to write another byte.
    stx PPUStrIndex                 ;Store total length, in bytes, of PPUDataString.
    iny                             ;Move to next data byte(should be #$00).

LC3BC:
    ldx PPUStrIndex                 ;X now contains current length of PPU data string.
    lda ($02),y                     ;
    bne LC385                       ;Is PPU string done loading (#$00)? If so exit,-->
    jsr EndPPUString                ;($C376)else branch to process PPU byte.

SeparateControlBits:
    sta $04                         ;Store current byte
    and #$BF                        ;
    sta PPUDataString,x             ;Remove RLE bit and save control bit in PPUDataString.
    and #$3F                        ;
    sta $05                         ;Extract counter bits and save them for use above.
    jmp NextPPUByte                 ;($C36E)

;----------------------------------------[ Math routines ]-------------------------------------------

TwosCompliment:
    eor #$FF                        ;
    clc                             ;Generate twos compliment of value stored in A.
    adc #$01                        ;
    rts                             ;

;The following two routines add a Binary coded decimal (BCD) number to another BCD number.
;A base number is stored in $03 and the number in A is added/subtracted from $03.  $01 and $02
;contain the lower and upper digits of the value in A respectively.  If an overflow happens after
;the addition/subtraction, the carry bit is set before the routine returns.

Base10Add:
    jsr ExtractNibbles              ;($C41D)Separate upper 4 bits and lower 4 bits.
    adc $01                         ;Add lower nibble to number.
    cmp #$0A                        ;
    bcc LC3E5                           ;If result is greater than 9, add 5 to create-->
        adc #$05                        ;valid result(skip #$0A thru #$0F).
    LC3E5:
    clc                             ;
    adc $02                         ;Add upper nibble to number.
    sta $02                         ;
    lda $03                         ;
    and #$F0                        ;Keep upper 4 bits of HealthLo/HealthHi in A.
    adc $02                         ;
    bcc LC3F6                       ;
LC3F2:
    adc #$5F                        ;If upper result caused a carry, add #$5F to create-->
    sec                             ;valid result. Set carry indicating carry to next digit.
    rts                             ;
LC3F6:
    cmp #$A0                        ;If result of upper nibble add is greater than #$90,-->
    bcs LC3F2                       ;Branch to add #$5F to create valid result.
    rts                             ;

Base10Subtract:
    jsr ExtractNibbles              ;($C41D)Separate upper 4 bits and lower 4 bits.
    sbc $01                         ;Subtract lower nibble from number.
    sta $01                         ;
    bcs LC40E                           ;If result is less than zero, add 10 to create-->
        adc #$0A                        ;valid result.
        sta $01                         ;
        lda $02                         ;
        adc #$0F                        ;Adjust $02 to account for borrowing.
        sta $02                         ;
    LC40E:
    lda $03                         ;Keep upper 4 bits of HealthLo/HealthHi in A.
    and #$F0                        ;
    sec                             ;
    sbc $02                         ;If result is greater than zero, branch to finish.
    bcs LC41A                           ;
        adc #$A0                        ;Add 10 to create valid result.
        clc                             ;
    LC41A:
    ora $01                         ;Combine A and $01 to create final value.
    rts                             ;

ExtractNibbles:
    pha                             ;
    and #$0F                        ;Lower 4 bits of value to change HealthLo/HealthHi by.
    sta $01                         ;
    pla                             ;
    and #$F0                        ;Upper 4 bits of value to change HealthLo/HealthHi by.
    sta $02                         ;
    lda $03                         ;
    and #$0F                        ;Keep lower 4 bits of HealthLo/HealthHi in A.
    rts                             ;

;---------------------------[ NMI and PPU control routines ]--------------------------------

; Wait for the NMI to end.

WaitNMIPass:
    jsr ClearNMIStat                ;($C434)Indicate currently in NMI.
    LC42F:
        lda NMIStatus                   ;
        beq LC42F                       ;Wait for NMI to end.
    rts                             ;

ClearNMIStat:
    lda #$00                        ;Clear NMI byte to indicate the game is-->
    sta NMIStatus                   ;currently running NMI routines.
    rts                             ;

ScreenOff:
    lda PPUMASK_ZP                   ;
    and #$E7                        ; BG & SPR visibility = off

WriteAndWait:
LC43D:
    sta PPUMASK_ZP                   ;Update value to be loaded into PPU control register.

WaitNMIPass_:
    jsr ClearNMIStat                ;($C434)Indicate currently in NMI.
    LC442:
        lda NMIStatus                   ;
        beq LC442                       ;Wait for NMI to end before continuing.
    rts                             ;

ScreenOn:
    lda PPUMASK_ZP                   ;
    ora #$1E                        ;BG & SPR visibility = on
    bne WriteAndWait                ;Branch always

;Update the actual PPU control registers.

WritePPUCtrl:
    lda PPUCTRL_ZP                   ;
    sta PPUCTRL                 ;
    lda PPUMASK_ZP                   ;Update PPU control registers.
    sta PPUMASK                 ;
    lda MirrorCntrl                 ;
    jsr PrepPPUMirror               ;($C4D9)Setup vertical or horizontal mirroring.

ExitSub:
    rts                             ;Exit subroutines.

;Turn off both screen and NMI.

ScreenNmiOff:
    lda PPUMASK_ZP                   ;
    and #$E7                        ;BG & SPR visibility = off
    jsr WriteAndWait                ;($C43D)Wait for end of NMI.
    lda PPUCTRL_ZP                   ;Prepare to turn off NMI in PPU.
    and #$7F                        ;NMI = off
    sta PPUCTRL_ZP                   ;
    sta PPUCTRL                 ;Actually load PPU register with NMI off value.
    rts                             ;

;The following routine does not appear to be used.

    lda PPUCTRL_ZP                   ;Enable VBlank.
    ora #$80                        ;
    sta PPUCTRL_ZP                   ;Write PPU control register 0 and PPU status byte.
    sta PPUCTRL                 ;
    lda PPUMASK_ZP                   ;Turn sprites and screen on.
    ora #$1E                        ;
    bne WriteAndWait                ;Branch always.

VBOffAndHorzWrite:
    lda PPUCTRL_ZP                   ;
    and #$7B                        ;Horizontal write, disable VBlank.
LC481:
    sta PPUCTRL                 ;Save new values in the PPU control register-->
    sta PPUCTRL_ZP                   ;and PPU status byte.
    rts                             ;

NMIOn:
        lda PPUSTATUS                   ;
        and #$80                        ;Wait for end of VBlank.
        bne NMIOn                       ;
    lda PPUCTRL_ZP                   ;
    ora #$80                        ;Enable VBlank interrupts.
    bne LC481                       ;Branch always.

;--------------------------------------[ Timer routines ]--------------------------------------------

;The following routines set the timer and decrement it. The timer is set after Samus dies and
;before the GAME OVER message is dispayed.  The timer is also set while the item pickup music
;is playing.

WaitTimer:
    lda Timer3                      ;Exit if timer hasn't hit zero yet
    bne LC4A9                           ;
    lda NextRoutine                 ;Set GameOver as next routine.
    cmp #$04                        ;
    beq SetMainRoutine              ;Set GoPassword as main routine.
    cmp #$06                        ;
    beq SetMainRoutine              ;
    jsr StartMusic                  ;($D92C)Assume power up was picked up and GameEngine-->
    lda NextRoutine                 ;is next routine. Start area music before exiting.

SetMainRoutine:
    sta MainRoutine                 ;Set next routine to run.
LC4A9:
    rts                             ;

SetTimer:
    sta Timer3                      ;Set Timer3. Frames to wait is value stored in A*10.
    stx NextRoutine                 ;Save routine to jump to after Timer3 expires.
    lda #$09                        ;Next routine to run is WaitTimer.
    bne SetMainRoutine              ;Branch always.

;-----------------------------------[ PPU mirroring routines ]---------------------------------------

PrepVertMirror:
    nop                             ;
    nop                             ;Prepare to set PPU for vertical mirroring (again).
    lda #$47                        ;

SetPPUMirror:
    lsr                             ;
    lsr                             ;Move bit 3 to bit 0 position.
    lsr                             ;
    and #$01                        ;Remove all other bits.
    sta $00                         ;Store at address $00.
    lda MMCReg0Cntrl                ;
    and #$FE                        ;Load MMCReg0Cntrl and remove bit 0.
    ora $00                         ;Replace bit 0 with stored bit at $00.
    sta MMCReg0Cntrl                ;
    sta MMC1Reg0                    ;
    lsr                             ;
    sta MMC1Reg0                    ;
    lsr                             ;
    sta MMC1Reg0                    ;
    lsr                             ;Load new configuration data serially-->
    sta MMC1Reg0                    ;into MMC1Reg0.
    lsr                             ;
    sta MMC1Reg0                    ;
    rts                             ;

PrepPPUMirror:
    lda MirrorCntrl                 ;Load MirrorCntrl into A.
    jmp SetPPUMirror                ;($C4B6)Set mirroring through MMC1 chip.

;-----------------------------[ Switch bank and init bank routines ]---------------------------------

;This is how the bank switching works... Every frame, the routine below
;is executed. First, it checks the value of SwitchPending. If it is zero,
;the routine will simply exit. If it is non-zero, it means that a bank
;switch has been issued, and must be performed. SwitchPending then contains
;the bank to switch to, plus one.

CheckSwitch:
    ldy SwitchPending               ;
    beq LC50F                           ;Exit if zero(no bank switch issued). else Y contains bank#+1.
    jsr SwitchOK                    ;($C4E8)Perform bank switch.
    jmp GoBankInit                  ;($C510)Initialize bank switch data.

SwitchOK:
    lda #$00                        ;Reset(so that the bank switch won't be performed-->
    sta SwitchPending               ;every succeeding frame too).
    dey                             ;Y now contains the bank to switch to.
    sty CurrentBank                 ;

ROMSwitch:
    tya                             ;
    sta $00                         ;Bank to switch to is stored at location $00.
    lda SwitchUpperBits             ;Load upper two bits for Reg 3 (they should always be 0).
    and #$18                        ;Extract bits 3 and 4 and add them to the current-->
    ora $00                         ;bank to switch to.
    sta SwitchUpperBits             ;Store any new bits set in 3 or 4(there should be none).

;Loads the lower memory page with the bank specified in A.

MMCWriteReg3:
    sta MMC1Reg3                    ;Write bit 0 of ROM bank #.
    lsr                             ;
    sta MMC1Reg3                    ;Write bit 1 of ROM bank #.
    lsr                             ;
    sta MMC1Reg3                    ;Write bit 2 of ROM bank #.
    lsr                             ;
    sta MMC1Reg3                    ;Write bit 3 of ROM bank #.
    lsr                             ;
    sta MMC1Reg3                    ;Write bit 4 of ROM bank #.
    lda $00                         ;Restore A with current bank number before exiting.
LC50F:
    rts                             ;

;Calls the proper routine according to the bank number in A.

GoBankInit:
    asl                             ;*2 For proper table offset below.
    tay                             ;
    lda BankInitTable,y             ;
    sta $0A                         ;Load appropriate subroutine address into $0A and $0B.
    lda BankInitTable+1,y           ;
    sta $0B                         ;
    jmp ($000A)                     ;Jump to appropriate initialization routine.

    BankInitTable:
        .word InitBank0                 ;($C531)Initialize bank 0.
        .word InitBank1                 ;($C552)Initialize bank 1.
        .word InitBank2                 ;($C583)Initialize bank 2.
        .word InitBank3                 ;($C590)Initialize bank 3.
        .word InitBank4                 ;($C5B6)Initialize bank 4.
        .word InitBank5                 ;($C5C3)Initialize bank 5.
        .word ExitSub                   ;($C45C)Rts
        .word ExitSub                   ;($C45C)Rts
        .word ExitSub                   ;($C45C)Rts

;Title screen memory page.

InitBank0:
    ldy #$00                        ;
    sty GamePaused                  ;Ensure game is not paused.
    iny                             ;Y=1.
    sty GameMode                    ;Game is at title routines.
    jsr ScreenNmiOff                ;($C45D)Waits for NMI to end then turns it off.
    jsr CopyMap                     ;($A93E)Copy game map from ROM to cartridge RAM $7000-$73FF
    jsr ClearNameTables             ;($C158)Erase name table data.

    ldy #$A0                        ;
    LC543:
        lda $98BF,y                     ;
        sta $6DFF,y                     ;Loads sprite info for stars into RAM $6E00 thru 6E9F.
        dey                             ;
        bne LC543                       ;

    jsr InitTitleGFX                ;($C5D7)Load title GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Brinstar memory page.

InitBank1:
    lda #$00                        ;
    sta GameMode                    ;GameMode = play.
    jsr ScreenNmiOff                ;($C45D)Disable screen and Vblank.
    lda MainRoutine                 ;
    cmp #$03                        ;Is game engine running? if so, branch.-->
    beq LC56D                           ;Else do some housekeeping first.
        lda #$00                        ;
        sta MainRoutine                 ;Run InitArea routine next.
        sta InArea                      ;Start in Brinstar.
        sta GamePaused                  ;Make sure game is not paused.
        jsr ClearRAM_33_DF              ;($C1D4)Clear game engine memory addresses.
        jsr ClearSamusStats             ;($C578)Clear Samus' stats memory addresses.
    LC56D:
    ldy #$00                        ;
    jsr ROMSwitch                   ;($C4EF)Load Brinstar memory page into lower 16Kb memory.
    jsr InitBrinstarGFX             ;($C604)Load Brinstar GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

ClearSamusStats:
    ldy #$0F                        ;
    lda #$00                        ;Clears Samus stats(Health, full tanks, game timer, etc.).
    LC57C:
        sta $0100,y                     ;Load $100 thru $10F with #$00.
        dey                             ;
        bpl LC57C                       ;Loop 16 times.
    rts                             ;

;Norfair memory page.

InitBank2:
    lda #$00                        ;GameMode = play.
    sta GameMode                    ;
    jsr ScreenNmiOff                ;($C45D)Disable screen and Vblank.
    jsr InitNorfairGFX              ;($C622)Load Norfair GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Tourian memory page.

InitBank3:
    lda #$00                        ;GameMode = play.
    sta GameMode                    ;
    jsr ScreenNmiOff                ;($C45D)Disable screen and Vblank.
    ldy #$0D                        ;
    LC599:
        lda MetroidData,y               ;Load info from table below into-->
        sta $77F0,y                     ;$77F0 thru $77FD.
        dey                             ;
        bpl LC599                       ;
    jsr InitTourianGFX              ;($C645)Load Tourian GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Table used by above subroutine and loads the initial data used to describe
;metroid's behavior in the Tourian section of the game.

MetroidData:
    .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00

;Kraid memory page.

InitBank4:
    lda #$00                        ;GameMode = play.
    sta GameMode                    ;
    jsr ScreenNmiOff                ;($C45D)Disable screen and Vblank.
    jsr InitKraidGFX                ;($C677)Load Kraid GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Ridley memory page.

InitBank5:
    lda #$00                        ;GameMode = play.
    sta GameMode                    ;
    jsr ScreenNmiOff                ;($C45D)Disable screen and Vblank.
    jsr InitRidleyGFX               ;($C69F)Loag Ridley GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

InitEndGFX:
    lda #$01                        ;
    sta GameMode                    ;Game is at title/end game.
    jmp InitGFX6                    ;($C6C2)Load end game GFX.

InitTitleGFX:
    ldy #$15                        ;Entry 21 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.

LoadSamusGFX:
    ldy #$00                        ;Entry 0 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    lda JustInBailey                ;
    beq LC5EB                           ;Branch if wearing suit
        ldy #$1B                        ;Entry 27 in GFXInfo table.
        jsr LoadGFX                     ;($C7AB)Switch to girl gfx
    LC5EB:
    ldy #$14                        ;Entry 20 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$17                        ;Entry 23 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$18                        ;Entry 24 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitBrinstarGFX:
    ldy #$03                        ;Entry 3 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$04                        ;Entry 4 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$05                        ;Entry 5 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$06                        ;Entry 6 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitNorfairGFX:
    ldy #$04                        ;Entry 4 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$05                        ;Entry 5 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$07                        ;Entry 7 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$08                        ;Entry 8 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$09                        ;Entry 9 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitTourianGFX:
    ldy #$05                        ;Entry 5 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0A                        ;Entry 10 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0B                        ;Entry 11 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0C                        ;Entry 12 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0D                        ;Entry 13 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0E                        ;Entry 14 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$1A                        ;Entry 26 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$1C                        ;Entry 28 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitKraidGFX:
    ldy #$04                        ;Entry 4 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$05                        ;Entry 5 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0A                        ;Entry 10 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0F                        ;Entry 15 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$10                        ;Entry 16 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$11                        ;Entry 17 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitRidleyGFX:
    ldy #$04                        ;Entry 4 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$05                        ;Entry 5 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$0A                        ;Entry 10 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$12                        ;Entry 18 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$13                        ;Entry 19 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitGFX6:
    ldy #$01                        ;Entry 1 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$02                        ;Entry 2 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$19                        ;Entry 25 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

InitGFX7: ; Load Password Font
    ldy #$17                        ;Entry 23 in GFXInfo table.
    jsr LoadGFX                     ;($C7AB)Load pattern table GFX.
    ldy #$16                        ;Entry 22 in GFXInfo table.
    jmp LoadGFX                     ;($C7AB)Load pattern table GFX.

;The table below contains info for each tile data block in the ROM.
;Each entry is 7 bytes long. The format is as follows:
;byte 0: ROM bank where GFX data is located.
;byte 1-2: 16-bit ROM start address (src).
;byte 3-4: 16-bit PPU start address (dest).
;byte 5-6: data length (16-bit).

GFXInfo:
    .byte .bank(GFX_Samus)          ;[SPR]Samus, items.             Entry 0.
        .word GFX_Samus, $0000, $09A0
    .byte $04                       ;[SPR]Samus in ending.          Entry 1.
        .word $8D60, $0000, $0520
    .byte $01                       ;[BGR]Partial font, "The End".  Entry 2.
        .word $8D60, $1000, $0400
    .byte .bank(GFX_BrinBG1)        ;[BGR]Brinstar rooms.           Entry 3.
        .word GFX_BrinBG1, $1000, $0150
    .byte $05                       ;[BGR]Common Room Elements      Entry 4.
        .word $8D60, $1200, $0450
    .byte .bank(GFX_CREBG2)         ;[BGR]More CRE                  Entry 5.
        .word GFX_CREBG2, $1800, $0800
    .byte $01                       ;[SPR]Brinstar enemies.         Entry 6.
        .word $9160, $0C00, $0400
    .byte .bank(GFX_NorfBG1)        ;[BGR]Norfair rooms.            Entry 7.
        .word GFX_NorfBG1, $1000, $0260
    .byte .bank(GFX_NorfBG2)        ;[BGR]More Norfair rooms.       Entry 8.
        .word GFX_NorfBG2, $1700, $0070
    .byte $02                       ;[SPR]Norfair enemies.          Entry 9.
        .word $8D60, $0C00, $0400
    .byte .bank(GFX_BossBG)         ;[BGR]Boss areas (Kr, Rd, Tr)   Entry 10. (0A)
        .word GFX_BossBG, $1000, $02E0
    .byte .bank(GFX_TourBG)         ;[BGR]Tourian rooms.            Entry 11. (0B)
        .word GFX_TourBG, $1200, $0600
    .byte .bank(GFX_Zebetite)       ;[BGR]Mother Brain room.        Entry 12. (0C)
        .word GFX_Zebetite, $1900, $0090
    .byte $05                       ;[BGR]Misc. object.             Entry 13. (0D)
        .word $91B0, $1D00, $0300
    .byte $02                       ;[SPR]Tourian enemies.          Entry 14. (0E)
        .word $9160, $0C00, $0400
    .byte .bank(GFX_KraiBG2)        ;[BGR]More Kraid Rooms          Entry 15. (0F)
        .word GFX_KraiBG2, $1700, $00C0
    .byte $04                       ;[BGR]More Kraid Rooms          Entry 16. (10)
        .word $9360, $1E00, $0200
    .byte $03                       ;[SPR]Miniboss I enemies.       Entry 17. (11)
        .word $8D60, $0C00, $0400
    .byte .bank(GFX_RidlBG)         ;[BGR]More Ridley Rooms         Entry 18. (12)
        .word GFX_RidlBG, $1700, $00C0
    .byte $03                       ;[SPR]Miniboss II enemies.      Entry 19. (13)
        .word $9160, $0C00, $0400
    .byte .bank(GFX_IntroSprites)   ;[SPR]Intro/End sprites.        Entry 20. (14)
        .word GFX_IntroSprites, $0C00, $0100
    .byte .bank(GFX_Title)          ;[BGR]Title.                    Entry 21. (15)
        .word GFX_Title, $1400, $0500
    .byte .bank(GFX_Solid)          ;[BGR]Solid tiles.              Entry 22. (16)
        .word GFX_Solid, $1FC0, $0040
    .byte .bank(GFX_Font)           ;[BGR]Complete font.            Entry 23. (17)
        .word GFX_Font, $1000, $0400
    .byte .bank(GFX_Font)           ;[BGR]Ingame HUD font.          Entry 24. (18)
        .word GFX_Font, $0A00, $00A0
    .byte .bank(GFX_Solid)          ;[BGR]Solid tiles.              Entry 25. (19)
        .word GFX_Solid, $0FC0, $0040
    .byte .bank(GFX_Font)           ;[BGR]Tourian font.             Entry 26. (1A)
        .word GFX_Font, $1D00, $02A0
    .byte .bank(GFX_SamusSuitless)  ;[SPR]Suitless Samus.           Entry 27. (1B)
        .word GFX_SamusSuitless, $0000, $07B0
    .byte .bank(GFX_ExclamationPoint)  ;[BGR]Exclaimation point.       Entry 28. (1C)
        .word GFX_ExclamationPoint, $1F40, $0010

;--------------------------------[ Pattern table loading routines ]---------------------------------

;Y contains the GFX header to fetch from the table above, GFXInfo.

LoadGFX:
    lda #$FF                        ;
    LC7AD:
        clc                             ;Every time y decrements, the entry into the table-->
        adc #$07                        ;is increased by 7.  When y is less than 0, A points-->
        dey                             ;to the last byte of the entry in the table.
        bpl LC7AD                       ;
    tay                             ;Transfer offset into table to Y.

    ldx #$06                        ;
    LC7B6:
        lda GFXInfo,y                   ;
        sta $00,x                       ;Copy entries from GFXInfo to $00-$06.
        dey                             ;
        dex                             ;
        bpl LC7B6                       ;

    ldy $00                         ;ROM bank containing the GFX data.
    jsr ROMSwitch                   ;($C4EF)Switch to that bank.
    lda PPUCTRL_ZP                   ;
    and #$FB                        ;
    sta PPUCTRL_ZP                   ;Set the PPU to increment by 1.
    sta PPUCTRL                 ;
    jsr CopyGFXBlock                ;($C7D5)Copy graphics into pattern tables.
    ldy CurrentBank                 ;
    jmp ROMSwitch                   ;($C4FE)Switch back to the "old" bank.

;Writes tile data from ROM to VRAM, according to the gfx header data
;contained in $00-$06.

CopyGFXBlock:
    lda $05                         ;
    bne GFXCopyLoop                 ;If $05 is #$00, decrement $06 before beginning.
    dec $06                         ;

GFXCopyLoop:
    lda $04                         ;
    sta PPUADDR                  ;Set PPU to proper address for GFX block write.
    lda $03                         ;
    sta PPUADDR                  ;
    ldy #$00                        ;Set offset for GFX data to 0.
    LC7E7:
        lda ($01),y                     ;
        sta PPUDATA                    ;Copy GFX data byte from ROM to Pattern table.
        dec $05                         ;Decrement low byte of data length.
        bne LC7F6                           ;Branch if high byte does not need decrementing.
            lda $06                         ;
            beq LC800                       ;If copying complete, branch to exit.
            dec $06                         ;Decrement when low byte has reached 0.
        LC7F6:
        iny                             ;Increment to next byte to copy.
        bne LC7E7                       ;
    inc $02                         ;After 256 bytes loaded, increment upper bits of-->
    inc $04                         ;Source and destination addresses.
    jmp GFXCopyLoop                 ;(&C7DB)Repeat copy routine.
LC800:
    rts

;-------------------------------------------[ AreaInit ]---------------------------------------------

AreaInit:
    lda #$00                        ;
    sta ScrollX                     ;Clear ScrollX.
    sta ScrollY                     ;Clear ScrollY.
    lda PPUCTRL_ZP                   ;
    and #$FC                        ;Sets nametable address = $2000.
    sta PPUCTRL_ZP                   ;
    inc MainRoutine                 ;Increment MainRoutine to MoreInit.
    lda Joy1Status                  ;
    and #$C0                        ;Stores status of both the A and B buttons.
    sta ABStatus                    ;Appears to never be accessed.
    jsr EraseAllSprites             ;($C1A3)Clear all sprite info.
    lda #$10                        ;Prepare to load Brinstar memory page.
    jsr IsEngineRunning             ;($CA18)Check to see if ok to switch lower memory page.

;------------------------------------------[ MoreInit ]---------------------------------------------

MoreInit:
    ldy #$01                        ;
    sty PalDataPending              ;Palette data pending = yes.
    ldx #$FF                        ;
    stx SpareMem75                  ;$75 Not referenced ever again in the game.
    inx                             ;X=0.
    stx AtEnding                    ;Not playing ending scenes.
    stx DoorStatus                  ;Samus not in door.
    stx SamusDoorData               ;Samus is not inside a door.
    stx UpdatingProjectile          ;No projectiles need to be updated.
    txa                             ;A=0.

    LC830:
        cpx #$65                        ;Check to see if more RAM to clear in $7A thru $DE.
        bcs LC836                           ;
            sta $7A,x                       ;Clear RAM $7A thru $DE.
        LC836:
        cpx #$FF                        ;Check to see if more RAM to clear in $300 thru $3FE.
        bcs LC83D                           ;
            sta ObjAction,x                 ;Clear RAM $300 thru $3FE.
        LC83D:
        inx                             ;
        bne LC830                       ;Loop until all required RAM is cleared.

    jsr ScreenOff                   ;($C439)Turn off Background and visibility.
    jsr ClearNameTables             ;($C158)Clear screen data.
    jsr EraseAllSprites             ;($C1A3)Erase all sprites from sprite RAM.
    jsr DestroyEnemies              ;($C8BB)

    stx DoorOnNameTable3            ;Clear data about doors on the name tables.
    stx DoorOnNameTable0            ;
    inx                             ;X=1.
    stx SpareMem30                  ;Not accessed by game.
    inx                             ;X=2.
    stx ScrollDir                   ;Set initial scroll direction as left.
    lda $95D7                       ;Get Samus start x pos on map.
    sta MapPosX                     ;
    lda $95D8                       ;Get Samus start y pos on map.
    sta MapPosY                     ;

    lda $95DA       ; Get ??? Something to do with palette switch
    sta PalToggle
    lda #$FF
    sta RoomNumber                  ;Room number = $FF(undefined room).
    jsr CopyPtrs    ; copy pointers from ROM to RAM
    jsr GetRoomNum                  ;($E720)Put room number at current map pos in $5A.
    LC86F:
        jsr SetupRoom                   ;($EA2B)
        ldy RoomNumber  ; load room number
        iny
        bne LC86F

    ldy CartRAMPtr+1
    sty $01
    ldy CartRAMPtr
    sty $00
    lda PPUCTRL_ZP
    and #$FB        ; PPU increment = 1
    sta PPUCTRL_ZP
    sta PPUCTRL
    ldy PPUSTATUS   ; reset PPU addr flip/flop

; Copy room RAM #0 ($6000) to PPU Name Table #0 ($2000)

    ldy #$20
    sty PPUADDR
    ldy #$00
    sty PPUADDR
    ldx #$04        ; prepare to write 4 pages
    Lx001:
        lda ($00),y
        sta PPUDATA
        iny
        bne Lx001
        inc $01
        dex
        bne Lx001

    stx $91
    inx          ; X = 1
    stx PalDataPending
    stx SpareMem30                  ;Not accessed by game.
    inc MainRoutine                 ;SamusInit is next routine to run.
    jmp ScreenOn

; CopyPtrs
; ========
; Copy 7 16-bit pointers from $959A thru $95A7 to $3B thru $48.

CopyPtrs:
    ldx #$0D
    LCopyPtrs:
        lda AreaPointers+2,x
        sta RoomPtrTable,x
        dex
        bpl LCopyPtrs
    rts

; DestroyEnemies
; ==============

DestroyEnemies:
LC8BB:
    lda #$00
    tax
    LC8BF:
        cpx #$48
        bcs LC89X
            sta $97,x
        LC89X:
        sta EnStatus,x
        pha
        pla
        inx
        bne LC8BF
    stx MetroidOnSamus              ;Samus had no Metroid stuck to her.
    jmp GotoMetroid_LA315

; SamusInit
; =========
; Code that sets up Samus, when the game is first started.

SamusInit:
    lda #$08                        ;
    sta MainRoutine                 ;SamusIntro will be executed next frame.
    lda #$2C                        ;440 frames to fade in Samus(7.3 seconds).
    sta Timer3                      ;
    jsr IntroMusic                  ;($CBFD)Start the intro music.
    ldy #sa_FadeIn0                 ;
    sty ObjAction                   ;Set Samus status as fading onto screen.
    ldx #$00
    stx SamusBlink
    dex                             ;X = $FF
    stx $0728
    stx $0730
    stx $0732
    stx $0738
    stx EndTimerLo                  ;Set end timer bytes to #$FF as-->
    stx EndTimerHi                  ;escape timer not currently active.
    stx $8B
    stx $8E
    ldy #$27
    lda InArea
    and #$0F
    beq Lx002                       ;Branch if Samus starting in Brinstar.
        lsr ScrollDir                   ;If not in Brinstar, change scroll direction from left-->
        ldy #$2F                        ;to down. and set PPU for horizontal mirroring.
    Lx002:
    sty MirrorCntrl                 ;
    sty MaxMissilePickup
    sty MaxEnergyPickup
    lda $95D9                       ;Samus' initial vertical position
    sta ObjectY                     ;
    lda #$80                        ;Samus' initial horizontal position
    sta ObjectX                     ;
    lda PPUCTRL_ZP                   ;
    and #$01                        ;Set Samus' name table position to current name table-->
    sta ObjectHi                    ;active in PPU.
    lda #$00                        ;
    sta HealthLo                    ;Starting health is-->
    lda #$03                        ;set to 30 units.
    sta HealthHi                    ;
LC92A:
    rts                             ;

;------------------------------------[ Main game engine ]--------------------------------------------

GameEngine:
    jsr ScrollDoor                  ;($E1F1)Scroll doors, if needed. 2 routine calls scrolls-->
    jsr ScrollDoor                  ;($E1F1)twice as fast as 1 routine call.

    lda NARPASSWORD                 ;
    beq LC945                           ;
        lda #$03                        ;The following code is only accessed if -->
        sta HealthHi                    ;NARPASSWORD has been entered at the -->
        lda #$FF                        ;password screen. Gives you new health,-->
        sta SamusGear                   ;missiles and every power-up every frame.
        lda #$05                        ;
        sta MissileCount                ;
    LC945:
    jsr UpdateWorld                 ;($CB29)Update Samus, enemies and room tiles.
    lda MiniBossKillDelay           ;
    ora PowerUpDelay                ;Check if mini boss was just killed or powerup aquired.-->
    beq LC95F                           ;If not, branch.
        lda #$00                        ;
        sta MiniBossKillDelay           ;Reset delay indicators.
        sta PowerUpDelay                ;
        lda #$18                        ;Set timer for 240 frames(4 seconds).
        ldx #$03                        ;GameEngine routine to run after delay expires
        jsr SetTimer                    ;($C4AA)Set delay timer and game engine routine.
    LC95F:
    lda ObjAction                   ;Check is Samus is dead.
    cmp #sa_Dead2                   ;Is Samus dead?-->
    bne LC92A                       ;exit if not.
    lda AnimDelay                   ;Is Samus still exploding?-->
    bne LC92A                       ;Exit if still exploding.
    jsr SilenceMusic                ;Turn off music.
    lda MotherBrainStatus           ;
    cmp #$0A                        ;Is mother brain already dead? If so, branch.
    beq LC97B                           ;
        lda #$04                        ;Set timer for 40 frames (.667 seconds).
        ldx #$04                        ;GameOver routine to run after delay expires.
        jmp SetTimer                    ;($C4AA)Set delay timer and run game over routine.
    LC97B:
    inc MainRoutine                 ;Next routine to run is GameOver.
    rts                             ;

;----------------------------------------[ Update age ]----------------------------------------------

;This is the routine which keeps track of Samus' age. It is called in the
;NMI. Basically, this routine just increments a 24-bit variable every
;256th frame. (Except it's not really 24-bit, because the lowest age byte
;overflows at $D0.)

UpdateAge:
    lda GameMode                    ;
    bne LC9A5                       ;Exit if at title/password screen.
    lda MainRoutine                 ;
    cmp #$03                        ;Is game engine running?
    bne LC9A5                       ;If not, don't update age.
    ldx FrameCount                  ;Only update age when FrameCount is zero-->
    bne LC9A5                       ;(which is approx. every 4.266666666667 seconds).
    inc SamusAge,x                  ;Minor Age = Minor Age + 1.
    lda SamusAge                    ;
    cmp #$D0                        ;Has Minor Age reached $D0?-->
    bcc LC9A5                       ;If not, we're done.-->
    lda #$00                        ;Else reset minor age.
    sta SamusAge                    ;
    LC99B:
        cpx #$03                        ;
        bcs LC9A5                           ;Loop to update middle age and possibly major age.
        inx                             ;
        inc SamusAge,x                  ;
        beq LC99B                       ;Branch if middle age overflowed, need to increment-->
LC9A5:
    rts                             ;major age too. Else exit.

;-------------------------------------------[ Game over ]--------------------------------------------

PrepareGameOver:
    lda #$1C                        ;GameOver is the next routine to run.
    sta TitleRoutine                ;
    lda #$01                        ;
    sta SwitchPending               ;Prepare to switch to title memory page.
    jmp ScreenOff                   ;($C439)Turn screen off.

;------------------------------------------[ Pause mode ]--------------------------------------------

PauseMode:
    lda Joy2Status                  ;Load buttons currently being pressed on joypad 2.
    and #$88                        ;
    eor #$88                        ;both A & UP pressed?-->
    bne Exit14                      ;Exit if not.
    ldy EndTimerHi                  ;
    iny                             ;Is escape timer active?-->
    bne Exit14                      ;Sorry, can't quit if this is during escape scence.
    sta GamePaused                  ;Clear pause game indicator.
    inc MainRoutine                 ;Display password is the next routine to run.

Exit14:
    rts                             ;Exit for routines above and below.

;------------------------------------------[ GoPassword ]--------------------------------------------

GoPassword:
    lda #$19                        ;DisplayPassword is next routine to run.
    sta TitleRoutine                ;
    lda #$01                        ;
    sta SwitchPending               ;Prepare to switch to intro memory page.
    lda NoiseSFXFlag                ;
    ora #$01                        ;Silence music.
    sta NoiseSFXFlag                ;
    jmp ScreenOff                   ;($C439)Turn off screen.

;-----------------------------------------[ Samus intro ]--------------------------------------------

SamusIntro:
    jsr EraseAllSprites             ;($C1A3)Clear all sprites off screen.
    ldy ObjAction                   ;Load Samus' fade in status.
    lda Timer3                      ;
    bne LC9F2                           ;Branch if Intro still playing.
        ;Fade in complete.
        sta ItemRoomMusicStatus         ;Make sure item room music is not playing.
        lda #sa_Begin                   ;Samus facing forward and can't be hurt.
        sta ObjAction                   ;
        jsr StartMusic                  ;($D92C)Start main music.
        jsr SelectSamusPal              ;($CB73)Select proper Samus palette.
        lda #$03                        ;
        sta MainRoutine                 ;Game engine will be called next frame.
    ;Still fading in.
    LC9F2:
    cmp #$1F                        ;When 310 frames left of intro, display Samus.
    bcs Exit14                      ;Branch if not time to start drawing Samus.
    cmp SamusFadeInTimeTbl-20,y     ;sa_FadeIn0 is beginning of table.
    bne LCA00                           ;Every time Timer3 equals one of the entries in the table-->
        inc ObjAction                   ;below, change the palette used to color Samus.
        sty PalDataPending              ;
    LCA00:
    lda FrameCount                  ;Is game currently on an odd frame?-->
    lsr                             ;If not, branch to exit.
    bcc Exit14                      ;Only display Samus on odd frames [the blink effect].
    lda #an_SamusFront              ;Samus front animation is animation to display.-->
    jsr SetSamusAnim                ;($CF6B)while fading in.
    lda #$00                        ;
    sta SpritePagePos               ;Samus sprites start at Sprite00RAM.
    sta PageIndex                   ;Samus RAM is first set of RAM.
    jmp AnimDrawObject              ;($DE47)Draw Samus on screen.

;The following table marks the time remaining in Timer3 when a palette change should occur during
;the Samus fade-in sequence. This creates the fade-in effect.

SamusFadeInTimeTbl:
    .byte $1E,$14,$0B,$04,$FF

;---------------------------------[ Check if game engine running ]-----------------------------------

IsEngineRunning:
    ldy MainRoutine                 ;If Samus is fading in or the wait timer is-->
    cpy #$07                        ;active, return from routine.
    beq LCA22                           ;
    cpy #$03                        ;Is game engine running?
    beq SwitchBank                  ;If yes, branch to SwitchBank.
LCA22:
    rts                             ;Exit if can't switch bank.

;-----------------------------------------[ Switch bank ]--------------------------------------------

;Switch to appropriate area bank

SwitchBank:
    sta InArea                      ;Save current area Samus is in.
    and #$0F                        ;
    tay                             ;Use 4 LSB to load switch pending offset from BankTable table.
    lda BankTable,y                 ;Base is $CA30.
    sta SwitchPending               ;Store switch data.
    jmp CheckSwitch                 ;($C4DE)Switch lower 16KB to appropriate memory page.

;Table used by above subroutine.
;Each value is the area bank number plus one.

BankTable:
    .byte $02                       ;Brinstar.
    .byte $03                       ;Norfair.
    .byte $05                       ;Kraid hideout.
    .byte $04                       ;Tourian.
    .byte $06                       ;Ridley hideout.

;----------------------------------[ Saved game routines (not used) ]--------------------------------

AccessSavedGame:
    pha                             ;Save two copies of A. Why? Who knows. This code is-->
    pha                             ;Never implemented. A contains data slot to work on.
    jsr GetGameDataIndex            ;($CA96)Get index to this save game Samus data info.
    lda EraseGame                   ;
    bpl LCA4C                           ;Is MSB set? If so, erase saved game data. Else branch.
        and #$01                        ;
        sta EraseGame                   ;Clear MSB so saved game data is not erased again.
        jsr EraseAllGameData            ;($CAA1)Erase selected saved game data.
        lda #$01                        ;Indicate this saved game has been erased.-->
        sta $7800,y                     ;Saved game 0=$780C, saved game 1=$781C, saved game 2=$782C.
    LCA4C:
    lda MainRoutine                 ;
    cmp #$01                        ;If initializing the area at the start of the game, branch-->
    beq LoadGameData                ;to load Samus' saved game info.

SaveGameData:
    lda InArea                      ;Save game based on current area Samus is in. Don't know why.
    jsr SavedDataBaseAddr           ;($CAC6)Find index to unique item history for this saved game.
    ldy #$3F                        ;Prepare to save unique item history which is 64 bytes-->
    LCA59:
        lda NumberOfUniqueItems,y       ;in length.
        sta ($00),y                     ;Save unique item history in appropriate saved game slot.
        dey                             ;
        bpl LCA59                       ;Loop until unique item history transfer complete.
    ldy SamusDataIndex              ;Prepare to save Samus' data.
    ldx #$00                        ;
    LCA66:
        lda SamusStat00,x               ;
        sta SamusData,y                 ;Save Samus' data in appropriate saved game slot.
        iny                             ;
        inx                             ;
        cpx #$10                        ;
        bne LCA66                       ;Loop until Samus' data transfer complete.

LoadGameData:
    pla                             ;Restore A to find appropriate saved game to load.
    jsr SavedDataBaseAddr           ;($CAC6)Find index to unique item history for this saved game.
    ldy #$3F                        ;Prepare to load unique item history which is 64 bytes-->
    LCA78:
        lda ($00),y                     ;in length.
        sta NumberOfUniqueItems,y       ;Loop until unique item history is loaded.
        dey                             ;
        bpl LCA78                       ;
    bmi LCA83                           ;Branch always.
        pha                             ;
    LCA83:
    ldy SamusDataIndex              ;Prepare to load Samus' data.
    ldx #$00                        ;
    LCA88:
        lda SamusData,y                 ;
        sta SamusStat00,x               ;Load Samus' data from appropriate saved game slot.
        iny                             ;
        inx                             ;
        cpx #$10                        ;
        bne LCA88                       ;Loop until Samus' data transfer complete.
    pla                             ;
    rts                             ;

GetGameDataIndex:
    lda DataSlot                    ;
    asl                             ;A contains the save game slot to work on (0 1 or 2).-->
    asl                             ;This number is transferred to the upper four bits to-->
    asl                             ;find the offset for Samus' data for this particular-->
    asl                             ;saved game (#$00, #$10 or #$20).
    sta SamusDataIndex              ;
    rts                             ;

EraseAllGameData:
    lda #$00                        ;Always start at saved game 0. Erase all 3 saved games.
    jsr SavedDataBaseAddr           ;($CAC6)Find index to unique item history for this saved game.
    inc $03                         ;Prepare to erase saved game info at $6A00 and above.
    ldy #$00                        ;Fill saved game data with #$00.
    tya                             ;
    LCAAB:
        sta ($00),y                     ;Erase unique item histories from $69B4 to $69FF.
        cpy #$40                        ;
        bcs LCAB3                           ;IF 64 bytes alrady erased, no need to erase any more-->
            sta ($02),y                     ;in the $6A00 and above range.
        LCAB3:
        iny                             ;
        bne LCAAB                       ;Loop until all saved game data is erased.
    ldy SamusDataIndex              ;Load proper index to desired Samus data to erase.
    ldx #$00                        ;
    txa                             ;
    LCABC:
        sta SamusData,y                 ;Erase Samus' data.
        iny                             ;
        inx                             ;
        cpx #$0C                        ;
        bne LCABC                       ;Loop until all data is erased.
    rts                             ;

;This routine finds the base address of the unique item history for the desired saved game (0, 1 or 2).
;The memory set aside for each unique item history is 64 bytes and occupies memory addresses $69B4 thru
;$6A73.

SavedDataBaseAddr:
    pha                             ;Save contents of A.
    lda DataSlot                    ;Load saved game data slot to load.
    asl                             ;*2. Table values below are two bytes.
    tax                             ;
    lda SavedDataTable,x            ;
    sta $00                         ;Load $0000 and $0002 with base addresses from-->
    sta $02                         ;table below($69B4).
    lda SavedDataTable+1,x          ;
    sta $01                         ;
    sta $03                         ;
    pla                             ;Restore A.
    and #$0F                        ;Discard upper four bits in A.
    tax                             ;X used for counting loop.
    beq LCAEE                       ;Exit if at saved game 0.  No further calculations required.
    LCAE0:
        lda $00                         ;
        clc                             ;
        adc #$40                        ;
        sta $00                         ;Loop to add #$40 to base address of $69B4 in order to find-->
        bcc LCAEB                           ;the proper base address for this saved game data. (save-->
            inc $01                         ;slot 0 = $69B4, save slot 1 = $69F4, save slot 2 = $6A34).
        LCAEB:
        dex                             ;
        bne LCAE0                       ;
LCAEE:
    rts                             ;

;Table used by above subroutine to find base address to load saved game data from. The slot 0
;starts at $69B4, slot 1 starts at $69F4 and slot 2 starts at $6A34.

SavedDataTable:
    .word ItemHistory               ;($69B4)Base for save game slot 0.
    .word ItemHistory               ;($69B4)Base for save game slot 1.
    .word ItemHistory               ;($69B4)Base for save game slot 2.

;----------------------------------------[ Choose ending ]-------------------------------------------

;Determine what type of ending is to be shown, based on Samus' age.
ChooseEnding:
    ldy #$01                        ;
LCAF7:
    lda SamusAge+2                  ;If SamusAge+2 anything but #$00, load worst-->
    bne LCB09                           ;ending(more than 37 hours of gameplay).
    lda SamusAge+1                  ;
    cmp AgeTable-1,y                ;Loop four times to determine-->
    bcs LCB09                           ;ending type from table below.
    iny                             ;
    cpy #$05                        ;
    bne LCAF7                       ;
LCB09:
    sty EndingType                  ;Store the ending # (1..5), 5=best ending
    lda #$00                        ;
    cpy #$04                        ;Was the best or 2nd best ending achieved?
    bcc LCB14                           ;Branch if not (suit stays on)
        lda #$01                        ;
    LCB14:
    sta JustInBailey                ;Suit OFF, baby!
    rts                             ;

;Table used by above subroutine to determine ending type.
AgeTable:
.byte $7A                       ;Max. 37 hours
.byte $16                       ;Max. 6.7 hours
.byte $0A                       ;Max. 3.0 hours
.byte $04                       ;Best ending. Max. 1.2 hours

;--------------------------------[ Clear screen data (not used) ]------------------------------------

ClearScreenData:
    jsr ScreenOff                   ;($C439)Turn off screen.
    lda #$FF                        ;
    sta $00                         ;Prepare to fill nametable with #$FF.
    jsr ClearNameTable              ;($C175)Clear selected nametable.
    jmp EraseAllSprites             ;($C1A3)Clear sprite data.

;----------------------------------------------------------------------------------------------------

; ===== THE REAL GUTS OF THE GAME ENGINE! =====

UpdateWorld:
    ldx #$00                        ;Set start of sprite RAM to $0200.
    stx SpritePagePos               ;

    jsr UpdateEnemies               ;($F345)Display of enemies.
    jsr UpdateProjectiles           ;($D4BF)Display of bullets/missiles/bombs.
    jsr UpdateSamus                 ;($CC0D)Display/movement of Samus.
    jsr AreaRoutine                 ;($95C3)Area specific routine.
    jsr UpdateElevator              ;($D7B3)Display of elevators.
    jsr UpdateStatues               ;($D9D4)Display of Ridley & Kraid statues.
    jsr LFA9D       ; destruction of enemies
    jsr LFC65       ; update of Mellow/Memu enemies
    jsr LF93B
    jsr LFBDD       ; destruction of green spinners
    jsr SamusEnterDoor              ;($8B13)Check if Samus entered a door.
    jsr $8B79       ; display of doors
    jsr UpdateTiles ; tile de/regeneration
    jsr LF034       ; Samus <--> enemies crash detection
    jsr DisplayBar                  ;($E0C1)Display of status bar.
    jsr LFAF2
    jsr CheckMissileToggle
    jsr UpdateItems                 ;($DB37)Display of power-up items.
    jsr UpdateTourianItems          ;($FDE3)

;Clear remaining sprite RAM
    ldx SpritePagePos
    lda #$F4
    Lx003:
        sta Sprite00RAM,x
        jsr Xplus4       ; X = X + 4
        bne Lx003
    rts

;------------------------------------[ Select Samus palette ]----------------------------------------

; Select the proper palette for Samus based on:
; - Is Samus wearing Varia (protective suit)?
; - Is Samus firing missiles or regular bullets?
; - Is Samus with or without suit?

SelectSamusPal: ;$CB73
    tya                             ;
    pha                             ;Temp storage of Y on the stack.
    lda SamusGear
    asl
    asl
    asl                             ;CF contains Varia status (1 = Samus has it)
    lda MissileToggle               ;A = 1 if Samus is firing missiles, else 0
    rol                             ;Bit 0 of A = 1 if Samus is wearing Varia
    adc #$02
    ldy JustInBailey                ;In suit?-->
    beq LCB8X                           ;If so, Branch.
        clc
        adc #$17                        ;Add #$17 to the pal # to reach "no suit"-palettes.
    LCB8X:
    sta PalDataPending              ;Palette will be written next NMI.
    pla                             ;
    tay                             ;Restore the contents of y.
    rts                             ;

;----------------------------------[ Initiate SFX and music routines ]-------------------------------

;Initiate sound effects.

SilenceMusic:                           ;The sound flags are stored in memory-->
    lda #$01                        ;starting at $0680. The following is a-->
    bne SFX_SetX0                   ;list of sound effects played when the-->
                                        ;flags are set:
PauseMusic:                             ;
    lda #$02                        ;$0680: These SFX use noise channel.
    bne SFX_SetX0                   ;Bit 7 - No sound.
                                        ;Bit 6 - ScrewAttack.
SFX_SamusWalk:                          ;Bit 5 - MissileLaunch.
    lda #$08                        ;Bit 4 - BombExplode.
    bne SFX_SetX0                   ;Bit 3 - SamusWalk.
                                        ;Bit 2 - SpitFlame.
SFX_BombExplode:                        ;Bit 1 - No sound.
    lda #$10                        ;Bit 0 - No sound.
    bne SFX_SetX0                   ;
                                        ;$0681: These SFX use sq1 channel.
SFX_MissileLaunch:                      ;Bit 7 - MissilePickup.
    lda #$20                        ;Bit 6 - EnergyPickup.
                                        ;Bit 5 - Metal.
SFX_SetX0:                              ;Bit 4 - BulletFire.
    ldx #$00                        ;Bit 3 - OutOfHole.
    beq SFX_SetSoundFlag            ;Bit 2 - EnemyHit.
                                        ;Bit 1 - SamusJump.
SFX_OutOfHole:                          ;Bit 0 - WaveFire.
    lda #$08                        ;
    bne SFX_SetX1                   ;$0682: Not used.
                                        ;
SFX_BombLaunch:                         ;$0683: These SFX use tri channel.
    lda #$01                        ;Bit 7 - SamusDie.
    bne SFX_SetX3                   ;Bit 6 - DoorOpenClose.
                                        ;Bit 5 - MetroidHit.
SFX_SamusJump:                          ;Bit 4 - StatueRaise.
    lda #$02                        ;Bit 3 - Beep.
    bne SFX_SetX1                   ;Bit 2 - BigEnemyHit.
                                        ;Bit 1 - SamusBall.
SFX_EnemyHit:                           ;Bit 0 - BombLaunch.
    lda #$04                        ;
    bne SFX_SetX1                   ;$0684: These SFX use multi channels.
                                        ;Bit 7 - FadeInMusic            (music).
SFX_BulletFire:                         ;Bit 6 - PowerUpMusic           (music).
    lda #$10                        ;Bit 5 - EndMusic  (Page 0 only)(music).
    bne SFX_SetX1                   ;Bit 4 - IntroMusic(Page 0 only)(music).
                                        ;Bit 3 - not used               (SFX).
SFX_Metal:                              ;Bit 2 - SamusHit               (SFX).
    lda #$20                        ;Bit 1 - BossHit                (SFX).
    bne SFX_SetX1                   ;Bit 0 - IncorrectPassword      (SFX).
                                        ;
SFX_EnergyPickup:                       ;$0685: Music flags. The music flags start different-->
    lda #$40                        ;music depending on what memory page is loaded. The-->
    bne SFX_SetX1                   ;following lists what bits start what music for each-->
                                        ;memory page.
SFX_MissilePickup:                      ;
    lda #$80                        ;Page 0: Intro/ending.
                                        ;Bit 7 - Not used.
SFX_SetX1:                              ;Bit 6 - TourianMusic.
    ldx #$01                        ;Bit 5 - ItemRoomMusic.
    bne SFX_SetSoundFlag            ;Bit 4 - Not used.
                                        ;Bit 3 - Not used.
SFX_WaveFire:                           ;Bit 2 - Not used.
    lda #$01                        ;Bit 1 - Not used.
    bne SFX_SetX1                   ;Bit 0 - Not used.
                                        ;
SFX_ScrewAttack:                        ;Page 1: Brinstar.
    lda #$40                        ;Bit 7 - Not used.
    bne SFX_SetX0                   ;Bit 6 - TourianMusic.
                                        ;Bit 5 - ItemRoomMusic.
SFX_BigEnemyHit:                        ;Bit 4 - Not used.
    lda #$04                        ;Bit 3 - Not used.
    bne SFX_SetX3                   ;Bit 2 - Not used.
                                        ;Bit 1 - Not used.
SFX_MetroidHit:                         ;Bit 0 - BrinstarMusic.
    lda #$20                        ;
    bne SFX_SetX3                   ;Page 2: Norfair.
                                        ;Bit 7 - Not used.
SFX_BossHit:                            ;Bit 6 - TourianMusic.
    lda #$02                        ;Bit 5 - ItemRoomMusic.
    bne SFX_SetX4                   ;Bit 4 - Not used.
                                        ;Bit 3 - NorfairMusic.
SFX_Door:                               ;Bit 2 - Not used.
    lda #$40                        ;Bit 1 - Not used.
    bne SFX_SetX3                   ;Bit 0 - Not used.
                                        ;
SFX_SamusHit:                           ;Page 3: Tourian.
    lda #$04                        ;Bit 7 - Not used.
    bne SFX_SetX4                   ;Bit 6 - TourianMusic
                                        ;Bit 5 - ItemRoomMusic.
SFX_SamusDie:                           ;Bit 4 - Not used.
    lda #$80                        ;Bit 3 - Not used.
    bne SFX_SetX3                   ;Bit 2 - EscapeMusic.
                                        ;Bit 1 - MotherBrainMusic
SFX_SetX2:                              ;Bit 0 - Not used.
    ldx #$02                        ;
                                        ;Page 4: Kraid.
SFX_SetSoundFlag:                       ;Bit 7 - RidleyAreaMusic.
    ora $0680,x                     ;Bit 6 - TourianMusic.
    sta $0680,x                     ;Bit 5 - ItemRoomMusic.
    rts                             ;Bit 4 - KraidAreaMusic.
                                        ;Bit 3 - Not used.
SFX_SamusBall:                          ;Bit 2 - Not used.
    lda #$02                        ;Bit 1 - Not used.
    bne SFX_SetX3                   ;Bit 0 - Not used.
                                        ;
SFX_Beep:                               ;Page 5: Ridley.
    lda #$08                        ;Bit 7 - RidleyAreaMusic.
                                        ;Bit 6 - TourianMusic.
SFX_SetX3:                              ;Bit 5 - ItemRoomMusic.
    ldx #$03                        ;Bit 4 - KraidAreaMusic.
    bne SFX_SetSoundFlag            ;Bit 3 - Not used.
                                        ;Bit 2 - Not used.
;Initiate music                         ;Bit 1 - Not used.
                                        ;Bit 0 - Not used.
PowerUpMusic:                           ;
    lda #$40                        ;
    bne SFX_SetX4                   ;
                                        ;
IntroMusic:                             ;
    lda #$80                        ;
                                        ;
SFX_SetX4:                              ;
    ldx #$04                        ;
    bne SFX_SetSoundFlag            ;
                                        ;
MotherBrainMusic:                       ;
    lda #$02                        ;
    bne SFX_SetX5                   ;
                                        ;
TourianMusic:                           ;
    lda #$40                        ;
                                        ;
SFX_SetX5:                              ;
    ldx #$05                        ;
    bne SFX_SetSoundFlag            ;

;--------------------------------------[ Update Samus ]----------------------------------------------

UpdateSamus:
    ldx #$00                        ;Samus data is located at index #$00.
    stx PageIndex                   ;
    inx                             ;x=1.
    stx IsSamus                     ;Indicate Samus is the object being updated.
    jsr GoSamusHandler              ;($CC1A)Find proper Samus handler routine.
    dec IsSamus                     ;Update of Samus complete.
    rts                             ;

GoSamusHandler:
    lda ObjAction                   ;
    bmi SamusStand                  ;Branch if Samus is standing.
    jsr ChooseRoutine               ;($C27C)Goto proper Samus handler routine.
        .word SamusStand                ;($CC36)Standing.
        .word SamusRun                  ;($CCC2)Running.
        .word SamusJump                 ;($D002)Jumping.
        .word SamusRoll                 ;($D0E1)Rolling.
        .word SamusPntUp                ;($D198)Pointing up.
        .word SamusDoor                 ;($D3A8)Inside door while screen scrolling.
        .word SamusJump                 ;($D002)Jumping while pointing up.
        .word SamusDead                 ;($D41A)Dead.
        .word SamusDead2                ;($D41F)More dead.
        .word SamusElevator             ;($D423)Samus on elevator.

;---------------------------------------[ Samus standing ]-------------------------------------------

SamusStand:
    lda Joy1Status                  ;Status of joypad 1.
    and #$CF                        ;Remove SELECT & START status bits.
    beq LCC41                           ;Branch if no buttons pressed.
        jsr ClearHorzMvmtAnimData       ;($CF5D)Set no horiontal movement and single frame animation.
        lda Joy1Status                  ;
    LCC41:
    and #$07                        ;Keep status of DOWN/LEFT/RIGHT.
    bne LCC4B                           ;Branch if any are pressed.
        lda Joy1Change                  ;
        and #$08                        ;Check if UP was pressed last frame.-->
        beq LCC5B                       ;If not, branch.
    LCC4B:
    jsr BitScan                     ;($E1E1)Find which directional button is pressed.
    cmp #$02                        ;Is down pressed?-->
    bcs LCC54                           ;If so, branch.
        sta SamusDir                    ;1=left, 0=right.
    LCC54:
    tax                             ;
    lda ActionTable,x               ;Load proper Samus status from table below.
    sta ObjAction                   ;Save Samus status.
LCC5B:
    lda Joy1Change                  ;
    ora Joy1Retrig                  ;Check if fire was just pressed or needs to retrigger.
    asl                             ;
    bpl LCC65                           ;Branch if FIRE not pressed.
        jsr FireWeapon                  ;($D1EE)Shoot left/right.
    LCC65:
    bit Joy1Change                  ;Check if jump was just pressed.
    bpl LCC6E                           ;Branch if JUMP not pressed.
        lda #sa_Jump                    ;
        sta ObjAction                   ;Set Samus status as jumping.
    LCC6E:
    lda #$04                        ;Prepare to set animation delay to 4 frames.
    jsr SetSamusData                ;($CD6D)Set Samus control data and animation.
    lda ObjAction                   ;
    cmp #sa_Door                    ;Is Samus inside a door, dead or pointing up and jumping?-->
    bcs LCC9X                           ;If so, branch to exit.
    jsr ChooseRoutine               ;Select routine below.
        .word ExitSub                   ;($C45C)Rts.
        .word SetSamusRun               ;($CC98)Samus is running.
        .word SetSamusJump              ;($CFC3)Samus is jumping.
        .word SetSamusRoll              ;($D0B5)Samus is in a ball.
        .word SetSamusPntUp             ;($CF77)Samus is pointing up.

;Table used by above subroutine.
ActionTable:
    .byte sa_Run                    ;Run right.
    .byte sa_Run                    ;Run left.
    .byte sa_Roll
    .byte sa_PntUp

;----------------------------------------------------------------------------------------------------

SetSamusExplode:
    lda #$50
    sta SamusJumpDsplcmnt
    lda #an_Explode
    jsr SetSamusAnim
    sta ObjectCounter
LCC9X:
    rts

SetSamusRun:
    lda #$09
    sta WalkSoundDelay
    ldx #$00
    lda AnimResetIndex
    cmp #an_SamusStand
    beq LCCBX
    inx
    cmp #$27
    beq LCCBX
        lda #$04
        jsr SetSamusNextAnim
    LCCBX:
    lda RunAnimationTbl,x
    sta AnimResetIndex
    ldx SamusDir
LCCB7:
    lda RunAccelerationTbl,x
    sta SamusHorzAccel
    rts

RunAnimationTbl:
LCCBE:  .byte an_SamusRun
        .byte an_SamusRunPntUp

RunAccelerationTbl:
LCCC0:  .byte $30                       ;Accelerate right.
        .byte $D0                       ;Accelerate left.

; SamusRun
; ========

SamusRun:
LCCC2:
    ldx SamusDir
    lda SamusGravity
    beq samL07
        ldy SamusJumpDsplcmnt
        bit ObjVertSpeed
        bmi samL01
            cpy #$18
            bcs samL04
            lda #an_SamusJump
            sta AnimResetIndex
            bcc samL04          ; branch always
        samL01:
        cpy #$18
        bcc samL04
        lda AnimResetIndex
        cmp #an_SamusFireJump
        beq samL02
            lda #an_SamusSalto
            sta AnimResetIndex
        samL02:
        cpy #$20
        bcc samL04
        lda Joy1Status
        and #$08
        beq samL03
            lda #an_SamusJumpPntUp
            sta AnimResetIndex
        samL03:
        bit Joy1Status
        bmi samL04
        jsr StopVertMovement            ;($D147)
    samL04:
        lda #an_SamusRun
        cmp AnimResetIndex
        bne samL05
            lda #an_SamusJump
            sta AnimResetIndex
        samL05:
        lda SamusInLava
        beq samL06
            lda Joy1Change
            bmi LCD40       ; branch if JUMP pressed
        samL06:
        jsr LCF88
        jsr LD09C
        jsr LCF2E
        lda #$02
        bne SetSamusData       ; branch always
    samL07:
    lda SamusOnElevator
    bne samL08
        jsr LCCB7
    samL08:
    jsr LCDBF
    dec WalkSoundDelay  ; time to play walk sound?
    bne samL09          ; branch if not
        lda #$09
        sta WalkSoundDelay  ; # of frames till next walk sound trigger
        jsr SFX_SamusWalk
    samL09:
    jsr LCF2E
    lda Joy1Change
    bpl samL10      ; branch if JUMP not pressed
    LCD40:
        jsr SetSamusJump
        lda #$12
        sta SamusHorzSpeedMax
        jmp LCD6B

    samL10:
        ora Joy1Retrig
        asl
        bpl samL11      ; branch if FIRE not pressed
            jsr LCDD7
        samL11:
        lda Joy1Status
        and #$03
        bne samL12
            jsr StopHorzMovement
            jmp LCD6B
        samL12:
        jsr BitScan                     ;($E1E1)
        cmp SamusDir
        beq LCD6B
        sta SamusDir
        jsr SetSamusRun
    LCD6B:
    lda #$03
    ; fallthrough

;---------------------------------------[ Set Samus data ]-------------------------------------------

;The following function sets various animation and control data bytes for Samus.

SetSamusData:
    jsr UpdateObjAnim               ;($DC8F)Update animation if needed.
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active to change palette.
    bcs LCD7E                           ;If screw attack not active, branch to skip palette change.
        lda FrameCount                  ;
        lsr                             ;
        and #$03                        ;Every other frame, change Samus palette while screw-->
        ora #$A0                        ;Attack is active.
        sta ObjectCntrl                 ;
    LCD7E:
    jsr CheckHealthStatus           ;($CDFA)Check if Samus hit, blinking or Health low.
    jsr LavaAndMoveCheck            ;($E269)Check if Samus is in lava or moving.
    lda MetroidOnSamus              ;Is a Metroid stuck to Samus?-->
    beq LCD8C                           ;If not, branch.
        lda #$A1                        ;Metroid on Samus. Turn Samus blue.
        sta ObjectCntrl                 ;
    LCD8C:
    jsr SetMirrorCntrlBit           ;($CD92)Mirror Samus, if necessary.
    jmp DrawFrame                   ;($DE4A)Display Samus.

;---------------------------------[ Set mirror control bit ]-----------------------------------------

SetMirrorCntrlBit:
    lda SamusDir                    ;Facing left=#$01, facing right=#$00.
    jsr Amul16                      ;($C2C5)*16. Move bit 0 to bit 4 position.
    ora ObjectCntrl                 ;
    sta ObjectCntrl                 ;Use SamusDir bit to set mirror bit.
    rts                             ;

;------------------------------[ Check if screw attack is active ]-----------------------------------

IsScrewAttackActive:
    sec                             ;Assume screw attack is not active.
    ldy ObjAction                   ;
    dey                             ;Is Samus running?-->
    bne LCDBE                       ;If not, branch to exit.
    lda SamusGear                   ;
    and #gr_SCREWATTACK             ;Does Samus have screw attack?-->
    beq LCDBE                       ;If not, branch to exit.
    lda AnimResetIndex              ;
    cmp #an_SamusSalto              ;Is Samus somersaulting?-->
    beq LCDBB                           ;If so, branch to clear carry(screw attack active).
        cmp #an_SamusJump               ;
        sec                             ;Is Samus jumping?-->
        bne LCDBE                       ;If not, branch to exit.
        bit ObjVertSpeed                ;If Samus is jumping and still moving upwards, screw-->
        bpl LCDBE                       ;attack is active.
    LCDBB:
    cmp AnimIndex                   ;Screw attack will still be active if not spinning, but-->
LCDBE:
    rts                             ;jumping while running and still moving upwards.

;----------------------------------------------------------------------------------------------------

LCDBF:
    lda Joy1Status
    and #$08
    lsr
    lsr
    lsr
    tax
    lda LCCBE,x
    cmp AnimResetIndex
    beq LCDBE
    jsr SetSamusAnim
    pla
    pla
    jmp LCD6B

LCDD7:
    jsr FireWeapon                  ;($D1EE)Shoot left/right.
    lda Joy1Status
    and #$08
    bne LCDEX
        lda #an_SamusFireRun
        sta AnimIndex
        rts

    LCDEX:
    lda AnimIndex
    sec
    sbc AnimResetIndex
    and #$03
    tax
    lda Table05,x
    jmp SetSamusNextAnim

; Table used by above subroutine

Table05:
    .byte $3F
    .byte $3B
    .byte $3D
    .byte $3F

CheckHealthStatus:
LCDFA:
    lda SamusHit                    ;
    and #$20                        ;Has Samus been hit?-->
    beq Lx006                       ;If not, branch to check if still blinking from recent hit.
        lda #$32                        ;
        sta SamusBlink                  ;Samus has been hit. Set blink for 32 frames.
        lda #$FF
        sta DamagePushDirection
        lda $73
        sta $77
        beq Lx005
            bpl Lx004
                jsr SFX_SamusHit
            Lx004:
            lda SamusHit
            and #$08
            lsr
            lsr
            lsr
            sta DamagePushDirection
        Lx005:
        lda #$FD
        sta ObjVertSpeed
        lda #$38                        ;Samus is hit. Store Samus hit gravity.
        sta SamusGravity                ;
        jsr IsSamusDead
        bne Lx006
        jmp CheckHealthBeep

    Lx006:
    lda SamusBlink
    beq CheckHealthBeep
    dec SamusBlink
    ldx DamagePushDirection
    inx
    beq Lx009
    jsr Adiv16       ; / 16
    cmp #$03
    bcs Lx007
        ldy SamusHorzAccel
        bne Lx009
        jsr LCF4E
    Lx007:
    dex
    bne Lx008
        jsr TwosCompliment              ;($C3D4)
    Lx008:
    sta ObjHorzSpeed
Lx009:
    lda $77
    bpl CheckHealthBeep
    lda FrameCount
    and #$01
    bne CheckHealthBeep
    tay
    sty AnimDelay
    ldy #$F7
    sty AnimFrame

CheckHealthBeep:
    ldy HealthHi
    dey
    bmi Lx010
    bne Lx011
    lda HealthLo
    cmp #$70
    bcs Lx011
; health < 17
Lx010:
    lda FrameCount
    and #$0F
    bne Lx011                           ;Only beep every 16th frame.
    jsr SFX_Beep
Lx011:
    lda #$00
    sta SamusHit
LCE83:
    rts

;----------------------------------------[ Is Samus dead ]-------------------------------------------

IsSamusDead:
    lda ObjAction                   ;
    cmp #sa_Dead                    ;
    beq Exit3                       ;Samus is dead. Zero flag is set.
    cmp #sa_Dead2                   ;
    beq Exit3                       ;
    cmp #$FF                        ;Samus not dead. Clear zero flag.

Exit3:
    rts                             ;Exit for routines above and below.

;----------------------------------------[ Subtract health ]-----------------------------------------

SubtractHealth:
    lda HealthLoChange              ;Check to see if health needs to be changed.-->
    ora HealthHiChange              ;If not, branch to exit.
    beq Exit3                       ;
    jsr IsSamusDead                 ;($CE84)Check if Samus is already dead.
    beq ClearDamage                 ;Samus is dead. Branch to clear damage values.
    ldy EndTimerHi                  ;If end escape timer is running, Samus cannot be hurt.
    iny                             ;
    beq LCEA6                           ;Branch if end escape timer not active.
    ClearDamage:
        jmp ClearHealthChange           ;($F323)Clear health change values.
    LCEA6:
    lda MotherBrainStatus           ;If mother brain is in the process of dying, receive-->
    cmp #$03                        ;no damage.
    bcs ClearDamage                 ;

    lda SamusGear                   ;
    and #gr_VARIA                   ;Check is Samus has Varia.
    beq LCEBF                           ;
    lsr HealthLoChange              ;If Samus has Varia, divide damage by 2.
    lsr HealthHiChange              ;
    bcc LCEBF                           ;If HealthHi moved a bit into the carry flag while-->
    lda #$4F                        ;dividing, add #$4F to HealthLo for proper-->
    adc HealthLoChange              ;division results.
    sta HealthLoChange              ;

LCEBF:
    lda HealthLo                    ;Prepare to subtract from HealthLo.
    sta $03                         ;
    lda HealthLoChange              ;Amount to subtract from HealthLo.
    sec                             ;
    jsr Base10Subtract              ;($C3FB)Perform base 10 subtraction.
    sta HealthLo                    ;Save results.

    lda HealthHi                   ;Prepare to subtract from HealthHi.
    sta $03                         ;
    lda HealthHiChange              ;Amount to subtract from HealthHi.
    jsr Base10Subtract              ;($C3FB)Perform base 10 subtraction.
    sta HealthHi                    ;Save Results.

    lda HealthLo                    ;
    and #$F0                        ;Is Samus health at 0?  If so, branch to-->
    ora HealthHi                    ;begin death routine.
    beq LCEE6                           ;
        bcs LCF2B                       ;Samus not dead. Branch to exit.
    LCEE6:
    lda #$00                        ;Samus is dead.
    sta HealthLo                    ;
    sta HealthHi                    ;Set health to #$00.
    lda #sa_Dead                    ;
    sta ObjAction                   ;Death handler.
    jsr SFX_SamusDie                ;($CBE2)Start Samus die SFX.
    jmp SetSamusExplode             ;($CC8B)Set Samus exlpode routine.

;----------------------------------------[ Add health ]----------------------------------------------

AddHealth:
    lda HealthLo                    ;Prepare to add to HealthLo.
    sta $03                         ;
    lda HealthLoChange              ;Amount to add to HealthLo.
    clc                             ;
    jsr Base10Add                   ;($C3DA)Perform base 10 addition.
    sta HealthLo                    ;Save results.

    lda HealthHi                    ;Prepare to add to HealthHi.
    sta $03                         ;
    lda HealthHiChange              ;Amount to add to HealthHi.
    jsr Base10Add                   ;($C3DA)Perform base 10 addition.
    sta HealthHi                    ;Save results.

    lda TankCount                   ;
    jsr Amul16                      ;($C2C5)*16. Move tank count to upper 4 bits.
    ora #$0F                        ;Set lower 4 bits.
    cmp HealthHi                    ;
    bcs LCF2B                           ;Is life less than max? if so, branch.
    and #$F9                        ;Life is more than max amount.
    sta HealthHi                    ;
    lda #$99                        ;Set life to max amount.
    sta HealthLo                    ;
LCF2B:
    jmp ClearHealthChange           ;($F323)

;----------------------------------------------------------------------------------------------------

LCF2E:  lda SamusHit
    lsr
    and #$02
    beq Lx014
    bcs Lx012
        lda SamusHorzAccel
        bmi Lx014
        bpl Lx013
    Lx012:
    lda SamusHorzAccel
    bmi Lx013
    bne Lx014
Lx013:
    jsr TwosCompliment              ;($C3D4)
    sta SamusHorzAccel

ClearHorzMvmntData:
    ldy #$00                        ;
LCF4E:
    sty ObjHorzSpeed                ;Set Samus Horizontal speed and horizontal-->
    sty HorzCntrLinear              ;linear counter to #$00.
Lx014:
    rts                             ;

StopHorzMovement:
    lda SamusHorzAccel              ;Is Samus moving horizontally?-->
    bne ClearHorzMvmtAnimData       ;If so, branch to stop movement.
    jsr SFX_SamusWalk               ;($CB96)Play walk SFX.

ClearHorzMvmtAnimData:
    jsr NoHorzMoveNoDelay           ;($CF81)Clear horizontal movement and animation delay data.
    sty ObjAction                   ;Samus is standing.
    lda Joy1Status                  ;
    and #$08                        ;Is The up button being pressed?-->
    bne SetSamusPntUp               ;If so, branch.
    lda #an_SamusStand              ;Set Samus animation for standing.

SetSamusAnim:
    sta AnimResetIndex              ;Set new animation reset index.

SetSamusNextAnim:
    sta AnimIndex                   ;Set new animation data index.
    lda #$00                        ;
    sta AnimDelay                   ;New animation to take effect immediately.
    rts                             ;

SetSamusPntUp:
    lda #sa_PntUp                   ;
    sta ObjAction                   ;Samus is pointing up.
    lda #an_SamusPntUp              ;
    jsr SetSamusAnim                ;($CF6B)Set new animation values.

NoHorzMoveNoDelay:
    jsr ClearHorzData               ;($CFB7)Clear all horizontal movement data.
    sty AnimDelay                   ;Clear animation delay data.
    rts                             ;

LCF88:
    lda Joy1Status
    and #$03
    beq Lx015
        jsr BitScan                     ;($E1E1)
        tax
        jsr LCCB7
        lda SamusGravity
        bmi Lx016
        lda AnimResetIndex
        cmp #an_SamusSalto
        beq Lx016
        stx SamusDir
        lda Table06+1,x
        jmp SetSamusAnim

    Lx015:
    lda SamusGravity
    bmi Lx016
    beq Lx016
    lda AnimResetIndex
    cmp #an_SamusJump
    bne Lx016

ClearHorzData:
    jsr ClearHorzMvmntData          ;($CF4C)Clear horizontal speed and linear counter.
    sty SamusHorzAccel              ;Clear horizontal acceleration data.
Lx016:
    rts                             ;

LCFBE:
    ldy #an_SamusJumpPntUp
    jmp LCFC5
    SetSamusJump:
        ldy #an_SamusJump
    LCFC5:
    sty AnimResetIndex
    dey
    sty AnimIndex
    lda #$04
    sta AnimDelay
    lda #$00
    sta SamusJumpDsplcmnt
    lda #$FC
    sta ObjVertSpeed
    ldx ObjAction
    dex
    bne Lx017      ; branch if Samus is standing still
    lda SamusGear
    and #gr_SCREWATTACK
    beq Lx017      ; branch if Samus doesn't have Screw Attack
    lda #$00
    sta $0686
    jsr SFX_ScrewAttack
Lx017:
    jsr SFX_SamusJump
    ldy #$18        ; gravity (high value -> low jump)
    lda SamusGear
    and #gr_HIGHJUMP
    beq Lx018      ; branch if Samus doesn't have High Jump
        ldy #$12        ; lower gravity value -> high jump!
    Lx018:
    sty SamusGravity
    rts

SamusJump:
    lda SamusJumpDsplcmnt
    bit ObjVertSpeed
    bpl Lx019      ; branch if falling down
    cmp #$20
    bcc Lx019      ; branch if jumped less than 32 pixels upwards
    bit Joy1Status
    bmi Lx019      ; branch if JUMP button still pressed
    jsr StopVertMovement            ;($D147)Stop jump (start falling).
Lx019:
    jsr LD055
    jsr LCF2E
    lda Joy1Status
    and #$08     ; UP pressed?
    beq Lx020      ; branch if not
        lda #an_SamusJumpPntUp
        sta AnimResetIndex
        lda #sa_PntJump      ; "jumping & pointing up" handler
        sta ObjAction
    Lx020:
    jsr LD09C
    lda SamusInLava
    beq Lx021
    lda Joy1Change
    bpl Lx021      ; branch if JUMP not pressed
    jsr SetSamusJump
    jmp LCD6B

Lx021:
    lda SamusGravity
    bne Lx023
    lda ObjAction
    cmp #sa_PntJump
    bne Lx022
        jsr SetSamusPntUp
        bne Lx023
    Lx022:
    jsr StopHorzMovement
Lx023:
    lda #$03
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

LD055:
    ldx #$01
    ldy #$00
    lda Joy1Status
    lsr
    bcs Lx024      ; branch if RIGHT pressed
    dex
    lsr
    bcc Lx027       ; branch if LEFT not pressed
    dex
    iny
Lx024:
    cpy SamusDir
    beq Lx027
    lda ObjAction
    cmp #sa_PntJump
    bne Lx025
        lda AnimResetIndex
        cmp Table04,y
        bne Lx026
        lda Table04+1,y
        jmp Lx026

    Lx025:
    lda AnimResetIndex
    cmp Table06,y
    bne Lx026
    lda Table06+1,y
Lx026:
    jsr SetSamusAnim
    lda #$08
    sta AnimDelay
    sty SamusDir
Lx027:
    stx ObjHorzSpeed
Lx028:
    rts

; Table used by above subroutine

Table06:
    .byte $0C
    .byte $0C
    .byte $0C
Table04:
    .byte $35
    .byte $35
    .byte $35

LD09C:
    lda Joy1Change
    ora Joy1Retrig
    asl
    bpl Lx028      ; exit if FIRE not pressed
    lda AnimResetIndex
    cmp #an_SamusJumpPntUp
    bne Lx029
    jmp LD275

Lx029:
    jsr LD210
    lda #an_SamusFireJump
    jmp SetSamusAnim

SetSamusRoll:
    lda SamusGear
    and #gr_MARUMARI
    beq Lx030      ; branch if Samus doesn't have Maru Mari
    lda SamusGravity
    bne Lx030

;Turn Samus into ball
    ldx SamusDir
    lda #an_SamusRoll
    sta AnimResetIndex
    lda #an_SamusRunJump
    sta AnimIndex
    lda LCCC0,x
    sta SamusHorzAccel
    lda #$01
    sta $0686
    jmp SFX_SamusBall

Lx030:
    lda #sa_Stand
    sta ObjAction
    rts

; SamusRoll
; =========

SamusRoll:
    lda Joy1Change
    and #$08     ; UP pressed?
    bne Lx031      ; branch if yes
        bit Joy1Change  ; JUMP pressed?
        bpl Lx032    ; branch if no
    Lx031:
    lda Joy1Status
    and #$04           ; DOWN pressed?
    bne Lx032     ; branch if yes
    ;break out of "ball mode"
        lda ObjRadY
        clc
        adc #$08
        sta ObjRadY
        jsr CheckMoveUp
        bcc Lx032     ; branch if not possible to stand up
        ldx #$00
        jsr LE8BE
        stx $05
        lda #$F5
        sta $04
        jsr LFD8F
        jsr LD638
        jsr StopHorzMovement
        dec AnimIndex
        jsr StopVertMovement            ;($D147)
        lda #$04
        jmp LD144
    Lx032:
        lda Joy1Change
        jsr BitScan                     ;($E1E1)
        cmp #$02
        bcs Lx033
            sta SamusDir
            lda #an_SamusRoll
            jsr SetSamusAnim
        Lx033:
        ldx SamusDir
        jsr LCCB7
        jsr LCF2E
        jsr CheckBombLaunch
        lda Joy1Status
        and #$03
        bne Lx034
            jsr ClearHorzData
        Lx034:
        lda #$02
    LD144:
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

StopVertMovement:
LD147:
    ldy #$00
    sty ObjVertSpeed
    sty VertCntrLinear
    rts

; CheckBombLaunch
; ===============
; This routine is called only when Samus is rolled into a ball.
; It does the following:
; - Checks if Samus has bombs
; - If so, checks if the FIRE button has been pressed
; - If so, checks if there are any object "slots" available
;   (only 3 bullets/bombs can be active at the same time)
; - If so, a bomb is launched.

CheckBombLaunch:
    lda SamusGear
    lsr
    bcc Lx036    ; exit if Samus doesn't have Bombs
    lda Joy1Change
    ora Joy1Retrig
    asl             ; bit 7 = status of FIRE button
    bpl Lx036    ; exit if FIRE not pressed
    lda ObjVertSpeed
    ora SamusOnElevator
    bne Lx036
    ldx #$D0        ; try object slot D
    lda ObjAction,x
    beq Lx035      ; launch bomb if slot available
    ldx #$E0        ; try object slot E
    lda ObjAction,x
    beq Lx035      ; launch bomb if slot available
    ldx #$F0        ; try object slot F
    lda ObjAction,x
    bne Lx036    ; no bomb slots available, exit
; launch bomb... give it same coords as Samus
Lx035:
    lda ObjectHi
    sta ObjectHi,x
    lda ObjectX
    sta ObjectX,x
    lda ObjectY
    clc
    adc #$04        ; 4 pixels further down than Samus' center
    sta ObjectY,x
    lda #wa_LayBomb
    sta ObjAction,x
    jsr SFX_BombLaunch
Lx036:
    rts

SamusPntUp:
    lda Joy1Status
    and #$08     ; UP still pressed?
    bne Lx037      ; branch if yes
        lda #sa_Stand   ; stand handler
        sta ObjAction
    Lx037:
    lda Joy1Status
    and #$07        ; DOWN, LEFT, RIGHT pressed?
    beq Lx039    ; branch if no
        jsr BitScan                     ;($E1E1)
        cmp #$02
        bcs Lx038
            sta SamusDir
        Lx038:
        tax
        lda Table07,x
        sta ObjAction
    Lx039:
    lda Joy1Change
    ora Joy1Retrig
    asl
    bpl Lx040      ; branch if FIRE not pressed
        jsr FireWeapon                  ;($D1EE)Shoot up.
    Lx040:
    bit Joy1Change
    bpl Lx041      ; branch if JUMP not pressed
        lda #sa_PntJump
        sta ObjAction
    Lx041:
    lda #$04
    jsr SetSamusData                ;($CD6D)Set Samus control data and animation.
    lda ObjAction
    jsr ChooseRoutine
        .word StopHorzMovement
        .word SetSamusRun
        .word ExitSub       ;($C45C)rts
        .word SetSamusRoll
        .word ExitSub       ;($C45C)rts
        .word ExitSub       ;($C45C)rts
        .word LCFBE
        .word ExitSub       ;($C45C)rts
        .word ExitSub       ;($C45C)rts
        .word ExitSub       ;($C45C)rts

; Table used by above subroutine

Table07:
    .byte sa_Run
    .byte sa_Run
    .byte sa_Roll

FireWeapon:
    lda Joy1Status
    and #$08
    beq LD210
    jmp LD275
LD1F7:
    ldy #$D0
    LD1F9:
        lda ObjAction,y
        beq Lx042
        jsr Yplus16
        bne LD1F9
    iny
    rts
Lx042:
    sta SamusHit,y
    lda MissileToggle
    beq Lx043
        cpy #$D0
    Lx043:
    rts

LD210:
    lda MetroidOnSamus
    bne LD269
    jsr LD1F7
    bne LD269
    jsr LD2EB
    jsr LD359
    jsr LD38E
    lda #$0C
    sta $030F,y
    ldx SamusDir
    lda Table99,x   ; get bullet speed
    sta ObjHorzSpeed,y     ; -4 or 4, depending on Samus' direction
    lda #$00
    sta ObjVertSpeed,y
    lda #$01
    sta ObjectOnScreen,y
    jsr CheckMissileLaunch
    lda ObjAction,y
    asl
    ora SamusDir
    and #$03
    tax
    lda Table08,x
    sta $05
    lda #$FA
    sta $04
    jsr LD306
    lda SamusGear
    and #gr_LONGBEAM
    lsr
    lsr
    lsr
    ror
    ora $061F
    sta $061F
    ldx ObjAction,y
    dex
    bne LD269
    jsr SFX_BulletFire
LD269:
    ldy #$09
LD26B:
    tya
    jmp SetSamusNextAnim

Table08:
    .byte  $0C
    .byte -$0C
    .byte  $08
    .byte -$08
Table99:
    .byte  $04
    .byte -$04

LD275:
    lda MetroidOnSamus
    bne Lx044
    jsr LD1F7
    bne Lx044
    jsr LD2EB
    jsr LD38A
    jsr LD38E
    lda #$0C
    sta $030F,y
    lda #$FC
    sta ObjVertSpeed,y
    lda #$00
    sta ObjHorzSpeed,y
    lda #$01
    sta ObjectOnScreen,y
    jsr LD340
    ldx SamusDir
    lda Table09+4,x
    sta $05
    lda ObjAction,y
    and #$01
    tax
    lda Table09+6,x
    sta $04
    jsr LD306
    lda SamusGear
    and #gr_LONGBEAM
    lsr
    lsr
    lsr
    ror
    ora $061F
    sta $061F
    lda ObjAction,y
    cmp #$01
    bne Lx044
    jsr SFX_BulletFire
Lx044:
    ldx SamusDir
    ldy Table09,x
    lda SamusGravity
    beq Lx045
        ldy Table09+2,x
    Lx045:
    lda ObjAction
    cmp #$01
    beq Lx046
    jmp LD26B

; Table used by above subroutine

Table09:
    .byte $26
    .byte $26
    .byte $34
    .byte $34
    .byte $01
    .byte $FF
    .byte $EC
    .byte $F0

LD2EB:
    tya
    tax
    inc ObjAction,x
    lda #$02
    sta ObjRadY,y
    sta ObjRadX,y
    lda #an_Bullet

SetProjectileAnim:
    sta AnimResetIndex,x
SetProjectileAnim2:
    sta AnimIndex,x
    lda #$00
    sta AnimDelay,x
Lx046:
    rts

LD306:
    ldx #$00
    jsr LE8BE
    tya
    tax
    jsr LFD8F
    txa
    tay
    jmp LD638

CheckMissileLaunch:
    lda MissileToggle
    beq Exit4       ; exit if Samus not in "missile fire" mode
    cpy #$D0
    bne Exit4
    ldx SamusDir
    lda MissileAnims,x
Lx047:
    jsr SetBulletAnim
    jsr SFX_MissileLaunch
    lda #wa_Missile ; missile handler
    sta ObjAction,y
    lda #$FF
    sta $030F,y     ; # of frames projectile should last
    dec MissileCount
    bne Exit4       ; exit if not the last missile
; Samus has no more missiles left
    dec MissileToggle       ; put Samus in "regular fire" mode
    jmp SelectSamusPal      ; update Samus' palette to reflect this

MissileAnims:
    .byte an_MissileRight
    .byte an_MissileLeft

LD340:
    lda MissileToggle
    beq Exit4
    cpy #$D0
    bne Exit4
    lda #$8F
    bne Lx047

SetBulletAnim:
    sta AnimIndex,y
    sta AnimResetIndex,y
    lda #$00
    sta AnimDelay,y
Exit4:
    rts

LD359:
    lda SamusDir
LD35B:
    sta $0502,y
    bit SamusGear
    bvc Exit4       ; branch if Samus doesn't have Wave Beam
    lda MissileToggle
    bne Exit4
    lda #$00
    sta $0501,y
    sta $0304,y
    tya
    jsr Adiv32      ; / 32
    lda #$00
    bcs Lx048
    lda #$0C
Lx048:
    sta $0500,y
    lda #wa_WaveBeam
    sta ObjAction,y
    lda #an_WaveBeam
    jsr SetBulletAnim
    jmp SFX_WaveFire

LD38A:
    lda #$02
    bne LD35B
LD38E:
    lda MissileToggle
    bne Exit4
    lda SamusGear
    bpl Exit4       ; branch if Samus doesn't have Ice Beam
    lda #wa_IceBeam
    sta ObjAction,y
    lda $061F
    ora #$01
    sta $061F
    jmp SFX_BulletFire

; SamusDoor
; =========

SamusDoor:
    lda DoorStatus
    cmp #$05
    bcc Lx055
; move Samus out of door, how far depends on initial value of DoorDelay
    dec DoorDelay
    bne MoveOutDoor
; done moving
    asl
    bcc Lx049
        lsr
        sta DoorStatus
        bne Lx055
    Lx049:
    jsr LD48C
    jsr LED65
    jsr GotoMetroid_LA315 ; if it is defined in the current bank
    lda ItemRoomMusicStatus
    beq Lx051
    pha
    jsr StartMusic       ; start music
    pla
    bpl Lx051
    lda #$00
    sta ItemRoomMusicStatus
    beq Lx051
    Lx050:
        lda #$80
        sta ItemRoomMusicStatus
    Lx051:
        lda KraidRidleyPresent
        beq Lx052
        jsr TourianMusic
        lda #$00
        sta KraidRidleyPresent
        beq Lx050     ; branch always
Lx052:
    lda SamusDoorData
    and #$0F
    sta ObjAction
    lda #$00
    sta SamusDoorData
    sta DoorStatus
    jsr StopVertMovement            ;($D147)

MoveOutDoor:
    lda SamusDoorDir
    beq Lx054    ; branch if door leads to the right
    ldy ObjectX
    bne Lx053
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
    Lx053:
    dec ObjectX
    jmp Lx055

Lx054:  inc ObjectX
    bne Lx055
    jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
Lx055:
    jsr CheckHealthStatus           ;($CDFA)Check if Samus hit, blinking or Health low.
    jsr SetMirrorCntrlBit
    jmp DrawFrame       ; display Samus

SamusDead:
    lda #$01
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

SamusDead2:
    dec AnimDelay
    rts

; SamusElevator
; =============

SamusElevator:
    lda ElevatorStatus
    cmp #$03
    beq Lx056
        cmp #$08
        bne Lx062
    Lx056:
    lda $032F
    bmi Lx059
        lda ObjectY
        sec
        sbc ScrollY     ; A = Samus' Y position on the visual screen
        cmp #$84
        bcc Lx057      ; if ScreenY < $84, don't scroll
            jsr ScrollDown  ; otherwise, attempt to scroll
        Lx057:  ldy ObjectY
        cpy #239        ; wrap-around required?
        bne Lx058
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
            ldy #$FF        ; ObjectY will now be 0
        Lx058:
        iny
        sty ObjectY
        jmp LD47E
    Lx059:
    lda ObjectY
    sec
    sbc ScrollY     ; A = Samus' Y position on the visual screen
    cmp #$64
    bcs Lx060      ; if ScreenY >= $64, don't scroll
        jsr ScrollUp    ; otherwise, attempt to scroll
    Lx060:
    ldy ObjectY
    bne Lx061      ; wraparound required? (branch if not)
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        ldy #240        ; ObjectY will now be 239
    Lx061:
    dey
    sty ObjectY
    jmp LD47E
Lx062:
    ldy #$00
    sty ObjVertSpeed
    cmp #$05
    beq Lx063
    cmp #$07
    beq Lx063
LD47E:
    lda FrameCount
    lsr
    bcc Lx064
Lx063:
    jsr SetMirrorCntrlBit           ;($CD92)Mirror Samus, if necessary.
    lda #$01
    jmp AnimDrawObject
Lx064:
    rts

LD48C:
    ldx #$60
    sec
    Lx065:
        jsr LD4B4
        txa
        sbc #$20
        tax
        bpl Lx065
    jsr GetNameTable                ;($EB85)
    tay
    ldx #$18
    Lx066:
        jsr LD4A8
        txa
        sec
        sbc #$08
        tax
        bne Lx066
LD4A8:
    tya
    cmp $072C,x
    bne Lx067
        lda #$FF
        sta $0728,x
    Lx067:
    rts

LD4B4:
    lda EnData05,x
    and #$02
    bne LD4BE
        sta EnStatus,x
    LD4BE:
    rts

; UpdateProjectiles
; =================

UpdateProjectiles:
    ldx #$D0
    jsr DoOneProjectile
    ldx #$E0
    jsr DoOneProjectile
    ldx #$F0
    ; fallthrough

DoOneProjectile:
    stx PageIndex
    lda ObjAction,x
    jsr ChooseRoutine
        .word ExitSub     ;($C45C) rts
        .word UpdateBullet ; regular beam
        .word UpdateWaveBullet      ; wave beam
        .word UpdateIceBullet       ; ice beam
        .word BulletExplode    ; bullet/missile explode
        .word $D65E       ; lay bomb
        .word $D670       ; lay bomb
        .word $D691       ; lay bomb
        .word $D65E       ; lay bomb
        .word $D670       ; bomb countdown
        .word $D691       ; bomb explode
        .word UpdateBullet  ; missile

UpdateBullet:
    lda #$01
    sta UpdatingProjectile
    jsr LD5FC
    jsr LD5DA
    jsr LD609
CheckBulletStat:
    ldx PageIndex
    bcc Lx068
        lda SamusGear
        and #gr_LONGBEAM
        bne DrawBullet  ; branch if Samus has Long Beam
        dec $030F,x     ; decrement bullet timer
        bne DrawBullet
        lda #$00        ; timer hit 0, kill bullet
        sta ObjAction,x
        beq DrawBullet  ; branch always
    Lx068:
    lda ObjAction,x
    beq Lx069
    jsr LD5E4
DrawBullet:
    lda #$01
    jsr AnimDrawObject
Lx069:
    dec UpdatingProjectile
    rts

Lx070:
    inc $0500,x
LD522:
    inc $0500,x
    lda #$00
    sta $0501,x
    beq Lx071      ; branch always

UpdateWaveBullet:
    lda #$01
    sta UpdatingProjectile
    jsr LD5FC
    jsr LD5DA
    lda $0502,x
    and #$FE
    tay
    lda WaveBulletTrajectoryPointers,y
    sta $0A
    lda WaveBulletTrajectoryPointers+1,y
    sta $0B
Lx071:
    ldy $0500,x
    lda ($0A),y
    cmp #$FF
    bne Lx072
        sta $0500,x
        jmp LD522
    Lx072:
    cmp $0501,x
    beq Lx070
    inc $0501,x
    iny
    lda ($0A),y
    jsr $8296
    ldx PageIndex
    sta ObjVertSpeed,x
    lda ($0A),y
    jsr $832F
    ldx PageIndex
    sta ObjHorzSpeed,x
    tay
    lda $0502,x
    lsr
    bcc Lx073
        tya
        jsr TwosCompliment              ;($C3D4)
        sta ObjHorzSpeed,x
    Lx073:
    jsr LD609
    bcs Lx074
        jsr LD624
    Lx074:
    jmp CheckBulletStat

WaveBulletTrajectoryPointers:
    .word WaveBulletTrajectoryHorizontal ; Used when Samus shoots left or right
    .word WaveBulletTrajectoryVertical   ; Used when Samus shoots up

; Wave Beam Trajectory Tables
; First byte is whether the table ends or not
; Second byte has Speed Y in high nibble and Speed X in low nibble, as sign-magnitude numbers
; This repeats until table ends

WaveBulletTrajectoryHorizontal:
    SignMagSpeed $01,  3, -7
    SignMagSpeed $01,  3, -5
    SignMagSpeed $01,  3, -1
    SignMagSpeed $01,  3,  1
    SignMagSpeed $01,  3,  5
    SignMagSpeed $01,  3,  7
    SignMagSpeed $01,  3,  7
    SignMagSpeed $01,  3,  5
    SignMagSpeed $01,  3,  1
    SignMagSpeed $01,  3, -1
    SignMagSpeed $01,  3, -5
    SignMagSpeed $01,  3, -7
    .byte $FF

WaveBulletTrajectoryVertical:
    SignMagSpeed $01,  7, -3
    SignMagSpeed $01,  5, -3
    SignMagSpeed $01,  1, -3
    SignMagSpeed $01, -1, -3
    SignMagSpeed $01, -5, -3
    SignMagSpeed $01, -7, -3
    SignMagSpeed $01, -7, -3
    SignMagSpeed $01, -5, -3
    SignMagSpeed $01, -1, -3
    SignMagSpeed $01,  1, -3
    SignMagSpeed $01,  5, -3
    SignMagSpeed $01,  7, -3
    .byte $FF

; UpdateIceBullet
; ===============

UpdateIceBullet:
    lda #$81
    sta ObjectCntrl
    jmp UpdateBullet

; BulletExplode
; =============
; bullet/missile explode

BulletExplode:
    lda #$01
    sta UpdatingProjectile
    lda $0303,x
    sec
    sbc #$F7
    bne Lx075
    sta ObjAction,x  ; kill bullet
Lx075:
    jmp DrawBullet

LD5DA:
    lda SamusHit,x
    beq Exit5
    lda #$00
    sta SamusHit,x
LD5E4:
    lda #$1D
    ldy ObjAction,x
    cpy #wa_BulletExplode
    beq Exit5
    cpy #wa_Missile
    bne Lx076
    lda #an_MissileExplode
Lx076:
    jsr SetProjectileAnim
    lda #wa_BulletExplode
Lx077:
    sta ObjAction,x
Exit5:
    rts

LD5FC:
    lda ObjectOnScreen,x
    lsr
    bcs Exit5
Lx078:
    lda #$00
    beq Lx077   ; branch always
Lx079:
    jmp LE81E

; bullet <--> background crash detection

LD609:
    jsr GetObjCoords
    ldy #$00
    lda ($04),y     ; get tile # that bullet touches
    cmp #$A0
    bcs LD624
    jsr GotoLA142
    cmp #$4E
    beq Lx079
    jsr LD651
    bcc Lx081
    clc
    jmp IsBlastTile

LD624:
    ldx PageIndex
    lda ObjHorzSpeed,x
    sta $05
    lda ObjVertSpeed,x
    sta $04
    jsr LE8BE
    jsr LFD8F
    bcc Lx078
LD638:
    lda $08
    sta ObjectY,x
    lda $09
    sta ObjectX,x
    lda $0B
    and #$01
    bpl Lx080      ; branch always
        ToggleObjectHi:
        lda ObjectHi,x
        eor #$01
    Lx080:
    sta ObjectHi,x
Lx081:
    rts

LD651:
    ldy InArea
    cpy #$10
    beq Lx082
        cmp #$70
        bcs Lx083
    Lx082:
    cmp #$80
Lx083:
    rts

LD65E:
    lda #an_BombTick
    jsr SetProjectileAnim
    lda #$18        ; fuse length :-)
    sta $030F,x
    inc ObjAction,x       ; bomb update handler
    DrawBomb:
    lda #$03
    jmp AnimDrawObject

LD670:
    lda FrameCount
    lsr
    bcc Lx085    ; only update counter on odd frames
    dec $030F,x
    bne Lx085
    lda #$37
    ldy ObjAction,x
    cpy #$09
    bne Lx084
        lda #an_BombExplode
    Lx084:
    jsr SetProjectileAnim
    inc ObjAction,x
    jsr SFX_BombExplode
Lx085:
    jmp DrawBomb

LD691:
    inc $030F,x
    jsr LD6A7
    ldx PageIndex
    lda $0303,x
    sec
    sbc #$F7
    bne Lx086
    sta ObjAction,x     ; kill bomb
Lx086:
    jmp DrawBomb

LD6A7:
    jsr GetObjCoords
    lda $04
    sta $0A
    lda $05
    sta $0B
    ldx PageIndex
    ldy $030F,x
    dey
    beq Lx088
    dey
    bne Lx089
    lda #$40
    jsr LD78B
    txa
    bne Lx087
    lda $04
    and #$20
    beq Exit6
Lx087:
    lda $05
    and #$03
    cmp #$03
    bne Lx088
    lda $04
    cmp #$C0
    bcc Lx088
    lda ScrollDir
    and #$02
    bne Exit6
    lda #$80
    jsr LD78B
Lx088:
    jsr LD76A
Exit6:
    rts

Lx089:
    dey
    bne Lx092
    lda #$40
    jsr LD77F
    txa
    bne Lx090
        lda $04
        and #$20
        bne Exit6
    Lx090:
    lda $05
    and #$03
    cmp #$03
    bne Lx091
        lda $04
        cmp #$C0
        bcc Lx091
        lda ScrollDir
        and #$02
        bne Exit6
        lda #$80
        jsr LD77F
    Lx091:
    jmp LD76A
Lx092:
    dey
    bne Lx095
        lda #$02
        jsr LD78B
        txa
        bne Lx093
            lda $04
            lsr
            bcc Exit7
        Lx093:
        lda $04
        and #$1F
        cmp #$1E
        bcc Lx094
            lda ScrollDir
            and #$02
            beq Exit7
            lda #$1E
            jsr LD77F
            lda $05
            eor #$04
            sta $05
        Lx094:
        jmp LD76A
    Lx095:
    dey
    bne Exit7
    lda #$02
    jsr LD77F
    txa
    bne Lx096
        lda $04
        lsr
        bcs Exit7
    Lx096:
    lda $04
    and #$1F
    cmp #$02
    bcs LD76A
    lda ScrollDir
    and #$02
    beq Exit7
    lda #$1E
    jsr LD78B
    lda $05
    eor #$04
    sta $05
LD76A:
    txa
    pha
    ldy #$00
    lda ($04),y
    jsr LD651
    bcc Lx097
        cmp #$A0
        bcs Lx097
        jsr LE9C2
    Lx097:
    pla
    tax
Exit7:
    rts

LD77F:
    clc
    adc $0A
    sta $04
    lda $0B
    adc #$00
    jmp LD798

LD78B:
    sta $00
    lda $0A
    sec
    sbc $00
    sta $04
    lda $0B
    sbc #$00
LD798:
    and #$07
    ora #$60
    sta $05
Lx098:
    rts

;-------------------------------------[ Get object coordinates ]------------------------------------

GetObjCoords:
    ldx PageIndex                   ;Load index into object RAM to find proper object.
    lda ObjectY,x                   ;
    sta $02                         ;Load and save temp copy of object y coord.
    lda ObjectX,x                   ;
    sta $03                         ;Load and save temp copy of object x coord.
    lda ObjectHi,x                  ;
    sta $0B                         ;Load and save temp copy of object nametable.
    jmp MakeCartRAMPtr              ;($E96A)Find object position in room RAM.

;---------------------------------------------------------------------------------------------------

UpdateElevator:
    ldx #$20
    stx PageIndex
    lda ObjAction,x
    jsr ChooseRoutine ; Pointer table to elevator handlers
        .word ExitSub       ;($C45C) rts
        .word ElevatorIdle
        .word LD80E
        .word ElevatorMove
        .word ElevatorScroll
        .word LD8A3
        .word LD8BF
        .word LD8A3
        .word ElevatorMove
        .word ElevatorStop

ElevatorIdle:
    lda SamusOnElevator
    beq ShowElevator
    lda #$04
    bit $032F       ; elevator direction in bit 7 (1 = up)
    bpl Lx099
        asl             ; btn_UP
    Lx099:
    and Joy1Status
    beq ShowElevator
; start elevator!
    jsr StopVertMovement            ;($D147)
    sty AnimDelay
    sty SamusGravity
    tya
    sta ObjVertSpeed,x
    inc ObjAction,x
    lda #sa_Elevator
    sta ObjAction
    lda #an_SamusFront
    jsr SetSamusAnim
    lda #128
    sta ObjectX     ; center
    lda #112
    sta ObjectY     ; center
    ShowElevator:
    lda FrameCount
    lsr
    bcc Lx098    ; only display elevator at odd frames
    jmp DrawFrame       ; display elevator

LD80E:
    lda ScrollX
    bne Lx100
    lda MirrorCntrl
    ora #$08
    sta MirrorCntrl
    lda ScrollDir
    and #$01
    sta ScrollDir
    inc ObjAction,x
    jmp ShowElevator

Lx100:
    lda #$80
    sta ObjectX
    lda ObjectX,x
    sec
    sbc ScrollX
    bmi Lx101
    jsr ScrollLeft
    jmp ShowElevator

Lx101:
    jsr ScrollRight
    jmp ShowElevator

ElevatorMove:
    lda $030F,x
    bpl Lx103    ; branch if elevator going down
    ; move elevator up one pixel
    ldy ObjectY,x
    bne Lx102
        jsr ToggleObjectHi
        ldy #240
    Lx102:
    dey
    tya
    sta ObjectY,x
    jmp Lx104

    ; move elevator down one pixel
Lx103:
    inc ObjectY,x
    lda ObjectY,x
    cmp #240
    bne Lx104
    jsr ToggleObjectHi
    lda #$00
    sta ObjectY,x
Lx104:
    cmp #$83
    bne Lx105      ; move until Y coord = $83
        inc ObjAction,x
    Lx105:
    jmp ShowElevator

ElevatorScroll:
    lda ScrollY
    bne ElevScrollRoom  ; scroll until ScrollY = 0
    lda #$4E
    sta AnimResetIndex
    lda #$41
    sta AnimIndex
    lda #$5D
    sta AnimResetIndex,x
    lda #$50
    sta AnimIndex,x
    inc ObjAction,x
    lda #$40
    sta Timer1
    jmp ShowElevator

ElevScrollRoom:
    lda $030F,x
    bpl Lx106      ; branch if elevator going down
    jsr ScrollUp
    jmp ShowElevator

Lx106:
    jsr ScrollDown
    jmp ShowElevator

LD8A3:
    inc ObjAction,x
    lda ObjAction,x
    cmp #$08        ; ElevatorMove
    bne Lx107
    lda #$23
    sta $0303,x
    lda #an_SamusFront
    jsr SetSamusAnim
    jmp ShowElevator
Lx107:
    lda #$01
    jmp AnimDrawObject

LD8BF:
    lda $030F,x
    tay
    cmp #$8F        ; Leads-To-Ending elevator?
    bne Lx108
; Samus made it! YAY!
    lda #$07
    sta MainRoutine
    inc AtEnding
    ldy #$00
    sty $33
    iny
    sty SwitchPending   ; switch to bank 0
    lda #$1D        ; ending
    sta TitleRoutine
    rts

Lx108:
    tya
    bpl Lx110
    ldy #$00
    cmp #$84
    bne Lx109
        iny
    Lx109:
    tya
Lx110:
    ora #$10
    jsr IsEngineRunning
    lda PalToggle
    eor #$07
    sta PalToggle
    ldy InArea
    cpy #$12
    bcc Lx111
        lda #$01
    Lx111:
    sta PalDataPending
    jsr WaitNMIPass_
    jsr SelectSamusPal
    jsr StartMusic                  ;($D92C)Start music.
    jsr ScreenOn
    jsr CopyPtrs
    jsr DestroyEnemies
    ldx #$20
    stx PageIndex
    lda #$6B
    sta AnimResetIndex
    lda #$5F
    sta AnimIndex
    lda #$7A
    sta AnimResetIndex,x
    lda #$6E
    sta AnimIndex,x
    inc ObjAction,x
    lda #$40
    sta Timer1
    rts

StartMusic:
    lda ElevatorStatus
    cmp #$06
    bne Lx112
        lda $032F
        bmi Lx113
    Lx112:
        lda $95CD                       ;Load proper bit flag for area music.
        ldy ItemRoomMusicStatus
        bmi Lx114
        beq Lx114
    Lx113:
    lda #$81
    sta ItemRoomMusicStatus
    lda #$20                        ;Set flag to play item room music.
Lx114:
    ora MusicInitFlag               ;
    sta MusicInitFlag               ;Store music flag info.
    rts                             ;

ElevatorStop:
    lda ScrollY
    bne Lx116    ; scroll until ScrollY = 0
    lda #sa_Stand
    sta ObjAction
    jsr StopHorzMovement
    ldx PageIndex   ; #$20
    lda #$01        ; ElevatorIdle
    sta ObjAction,x
    lda $030F,x
    eor #$80        ; switch elevator direction
    sta $030F,x
    bmi Lx115
        jsr ToggleScroll
        sta MirrorCntrl
    Lx115:
    jmp ShowElevator
Lx116:
    jmp ElevScrollRoom

SamusOnElevatorOrEnemy:
    lda #$00                        ;
    sta SamusOnElevator             ;Assume Samus is not on an elevator or on a frozen enemy.
    sta OnFrozenEnemy               ;
    tay
    ldx #$50
    jsr GetObject1CoordData
Lx117:
    lda EnStatus,x
    cmp #$04
    bne Lx118
    jsr LF152
    jsr DistFromEn0ToObj1
    jsr LF1FA
    bcs Lx118
    jsr LD9BA
    bne Lx118
        inc OnFrozenEnemy               ;Samus is standing on a frozen enemy.
        bne Lx119
    Lx118:
        jsr Xminus16
        bpl Lx117
    Lx119:
    lda ElevatorStatus
    beq Lx120
    ldy #$00
    ldx #$20
    jsr LDC82
    bcs Lx120
    jsr LD9BA
    bne Lx120
    inc SamusOnElevator             ;Samus is standing on elevator.
Lx120:
    rts

LD9BA:
    lda $10
    and #$02
    bne Lx121
        ldy $11
        iny
        cpy $04
        beq Exit8
    Lx121:
    lda SamusHit
    and #$38
    ora $10
    ora #$40
    sta SamusHit
Exit8:
    rts

; UpdateStatues
; =============

UpdateStatues:
    lda #$60
    sta PageIndex
    ldy $0360
    beq Exit8          ; exit if no statue present
    dey
    bne Lx122
    jsr LDAB0
    ldy #$01
    jsr LDAB0
    bcs Lx122
    inc $0360
Lx122:
    ldy $0360
    cpy #$02
    bne Lx125
    lda KraidStatueStatus
    bpl Lx123
        ldy #$02
        jsr LDAB0
    Lx123:
    lda $687C
    bpl Lx124
        ldy #$03
        jsr LDAB0
    Lx124:
    bcs Lx125
    inc $0360
Lx125:
    ldx #$60
    jsr LDA1A
    ldx #$61
    jsr LDA1A
    jmp LDADA

LDA1A:
    jsr LDA3D
    jsr LDA7C
    txa
    and #$01
    tay
    lda LDA3B,y
    sta $0363
    lda $681B,x
    beq Lx126
    bmi Lx126
    lda FrameCount
    lsr
    bcc Lx127    ; only display statue at odd frames
Lx126:
    jmp DrawFrame       ; display statue

LDA39:
    .byte $88
    .byte $68
LDA3B:
    .byte $65
    .byte $66

LDA3D:
    lda $0304,x
    bmi Lx127
    lda #$01
    sta $0304,x
    lda $030F,x
    and #$0F
    beq Lx127
    inc $0304,x
    dec $030F,x
    lda $030F,x
    and #$0F
    bne Lx127
    lda $0304,x
    ora #$80
    sta $0304,x
    sta $681B,x
    inc $0304,x
    txa
    pha
    and #$01
    pha
    tay
    jsr LDAB0
    pla
    tay
    iny
    iny
    jsr LDAB0
    pla
    tax
Lx127:
    rts

LDA7C:
    lda $030F,x
    sta $036D
    txa
    and #$01
    tay
    lda LDA39,y
    sta $036E
    lda $681B,x
    beq Lx128
    bmi Lx128
    lda $0304,x
    cmp #$01
    bne Lx128
    lda $0306,x
    beq Lx128
    dec $030F,x
    lda $0683
    ora #$10
    sta $0683
Lx128:
    lda #$00
    sta $0306,x
    rts

LDAB0:
    lda Table0E,y
    sta $05C8
    lda $036C
    asl
    asl
    ora Table1B,y
    sta $05C9
    lda #$09
    sta $05C3
    lda #$C0
    sta PageIndex
    jsr DrawTileBlast
    lda #$60
    sta PageIndex
    rts

; Table used by above subroutine

Table0E:
    .byte $30
    .byte $AC
    .byte $F0
    .byte $6C
Table1B:
    .byte $61
    .byte $60
    .byte $60
    .byte $60

LDADA:
    lda $54
    bmi Exit0
    lda DoorStatus
    bne Exit0
    lda KraidStatueStatus
    and $687C
    bpl Exit0
    sta $54
    ldx #$70
    ldy #$08
Lx129:
    lda #$03
    sta $0500,x
    tya
    asl
    sta $0507,x
    lda #$04
    sta TileType,x
    lda $036C
    asl
    asl
    ora #$62
    sta TileWRAMHi,x
    tya
    asl
    adc #$08
    sta TileWRAMLo,x
    jsr Xminus16
    dey
    bne Lx129
Exit0:
    rts

;-------------------------------------------------------------------------------
; CheckMissileToggle
; ==================
; Toggles between bullets/missiles (if Samus has any missiles).

CheckMissileToggle:
    lda MissileCount
    beq Exit0       ; exit if Samus has no missiles
    lda Joy1Change
    ora Joy1Retrig
    and #$20
    beq Exit0       ; exit if SELECT not pressed
    lda MissileToggle
    eor #$01        ; 0 = fire bullets, 1 = fire missiles
    sta MissileToggle
    jmp SelectSamusPal

;-------------------------------------------------------------------------------
; MakeBitMask
; ===========
;In: Y = bit index. Out: A = bit Y set, other 7 bits zero.

MakeBitMask:
    sec
    lda #$00
    LDB32:
        rol
        dey
        bpl LDB32
LDB36:
    rts

;------------------------------------------[ Update items ]-----------------------------------------

UpdateItems:
    lda #$40                        ;PowerUp RAM starts at $0340.
    sta PageIndex                   ;
    ldx #$00                        ;Check first item slot.
    jsr CheckOneItem                ;($DB42)Check current item slot.
    ldx #$08                        ;Check second item slot.

CheckOneItem:
    stx ItemIndex                   ;First or second item slot index(#$00 or #$08).
    ldy PowerUpType,x               ;
    iny                             ;Is no item present in item slot(#$FF)?-->
    beq LDB36                           ;If so, branch to exit.

    lda PowerUpYCoord,x             ;
    sta PowerUpY                    ;
    lda PowerUpXCoord,x             ;Store y, x and name table coordinates of power up item.
    sta PowerUpX                    ;
    lda PowerUpNameTable,x          ;
    sta PowerUpHi                   ;
    jsr GetObjCoords                ;($D79F)Find object position in room RAM.
    ldx ItemIndex                   ;Index to proper power up item.
    ldy #$00                        ;Reset index.
    lda ($04),y                     ;Load pointer into room RAM.
    cmp #$A0                        ;Is object being placed on top of a solid tile?-->
    bcc LDB36                       ;If so, branch to exit.
    lda PowerUpType,x               ;
    and #$0F                        ;Load power up type byte and keep only bits 0 thru 3.
    ora #$50                        ;Set bits 4 and 6.
    sta PowerUpAnimFrame            ;Save index to find object animation.
    lda FrameCount                  ;
    lsr                             ;Color affected every other frame.
    and #$03                        ;the 2 LSBs of object control byte change palette of object.
    ora #$80                        ;Indicate ObjectCntrl contains valid data by setting MSB.
    sta ObjectCntrl                 ;Change color of item every other frame.
    lda SpritePagePos               ;Load current index into sprite RAM.
    pha                             ;Temp save sprite RAM position.
    lda PowerUpAnimIndex,x          ;Load entry into FramePtrTable for item animation.
    jsr DrawFrame                   ;($DE4A)Display special item.

    pla                             ;Restore sprite page position byte.
    cmp SpritePagePos               ;Was power up item successfully drawn?-->
    beq Exit9                       ;If not, branch to exit.
    tax                             ;Store sprite page position in x.
    ldy ItemIndex                   ;Load index to proper power up data slot.
    lda PowerUpType,y               ;Reload power up type data.
    ldy #$01                        ;Set power up color for ice beam orb.
    cmp #$07                        ;Is power up item the ice beam?-->
    beq LDB9F                       ;If so, branch.

        dey                             ;Set power up color for long/wave beam orb.
        cmp #$06                        ;Is power up item the wave beam?-->
        beq LDB9F                       ;If so, branch.
        cmp #$02                        ;Is power up item the long beam?-->
        bne LDBA5                       ;If not, branch.
    LDB9F:
        tya                             ;Transfer color data to A.
        sta Sprite01RAM+2,x             ;Store power up color for beam weapon.
        lda #$FF                        ;Indicate power up obtained is a beam weapon.

    LDBA5:
    pha                             ;Temporarily store power up type.
    ldx #$00                        ;Index to object 0(Samus).
    ldy #$40                        ;Index to object 1(power up).
    jsr AreObjectsTouching          ;($DC7F)Determine if Samus is touching power up.
    pla                             ;Restore power up type byte.
    bcs Exit9                       ;Carry clear=Samus touching power up. Carry set=not touching.

    tay                             ;Store power-up type byte in Y.
    jsr PowerUpMusic                ;($CBF9)Power up obtained! Play power up music.
    ldx ItemIndex                   ;X=index to power up item slot.
    iny                             ;Is item obtained a beam weapon?-->
    beq LDBC6                       ;If so, branch.
        lda PowerUpNameTable,x          ;
        sta $08                         ;Temp storage of nametable and power-up type in $08-->
        lda PowerUpType,x               ;and $09 respectively.
        sta $09                         ;
        jsr GetItemXYPos                ;($DC1C)Get proper X and Y coords of item, save in history.
    LDBC6:
    lda PowerUpType,x               ;Get power-up type byte again.
    tay                             ;
    cpy #$08                        ;Is power-up item a missile or energy tank?-->
    bcs MissileEnergyPickup                       ;If so, branch.
    cpy #$06                        ;Is item the wave beam or ice beam?-->
    bcc LDBDA                       ;If not, branch.
        lda SamusGear                   ;Clear status of wave beam and ice beam power ups.
        and #$3F                        ;
        sta SamusGear                   ;Remove beam weapon data from Samus gear byte.
    LDBDA:
    jsr MakeBitMask                 ;($DB2F)Create a bit mask for beam weapon just obtained.
    ora SamusGear                   ;
    sta SamusGear                   ;Update Samus gear with new beam weapon.
LDBE3:
    lda #$FF                        ;
    sta PowerUpDelay                ;Initiate delay while power up music plays.
    sta PowerUpType,x               ;Clear out item data from RAM.
    ldy ItemRoomMusicStatus         ;Is Samus not in an item room?-->
    beq LDBF1                       ;If not, branch.
        ldy #$01                        ;Restart item room music after special item music is done.
    LDBF1:
    sty ItemRoomMusicStatus         ;
    jmp SelectSamusPal              ;($CB73)Set Samus new palette.

Exit9:
    rts                             ;Exit for multiple routines above.

MissileEnergyPickup:
    beq LDC00                       ;Branch if item is an energy tank.
        lda #$05                        ;
        jsr AddToMaxMissiles            ;($DD97)Increase missile capacity by 5.
        bne LDBE3                       ;Branch always.

    LDC00:
    lda TankCount                   ;
    cmp #$06                        ;Has Samus got 6 energy tanks?-->
    beq LDC0A                       ;If so, she can't have any more.-->
        inc TankCount                   ;Otherwise give her a new tank.
    LDC0A:
    lda TankCount                   ;
    jsr Amul16                      ;Get tank count and shift into upper nibble.
    ora #$09                        ;
    sta HealthHi                    ;Set new tank count. Upper health digit set to 9.
    lda #$99                        ;Max out low health digit.
    sta HealthLo                    ;Health is now FULL!
    bne LDBE3                       ;Branch always.

;It is possible for the current nametable in the PPU to not be the actual nametable the special item
;is on so this function checks for the proper location of the special item so the item ID can be
;properly calculated.

GetItemXYPos:
    lda MapPosX                     ;
MapScrollRoutine:
    sta $07                         ;Temp storage of Samus map position x and y in $07-->
    lda MapPosY                     ;and $06 respectively.
    sta $06                         ;
    lda ScrollDir                   ;Load scroll direction and shift LSB into carry bit.
    lsr                             ;
    php                             ;Temp storage of processor status.
    beq LDC34                       ;Branch if scrolling up/down.
    bcc LDC3C                       ;Branch if scrolling right.

    ;Scrolling left.
        lda ScrollX                     ;Unless the scroll x offset is 0, the actual room x pos-->
        beq LDC3C                       ;needs to be decremented in order to be correct.
        dec $07                         ;
        bcs LDC3C                       ;Branch always.

    LDC34:
        bcc LDC3C                       ;Branch if scrolling up.

    ;Scrolling down.
        lda ScrollY                     ;Unless the scroll y offset is 0, the actual room y pos-->
        beq LDC3C                           ;needs to be decremented in order to be correct.
        dec $06                         ;

    LDC3C:
    lda PPUCTRL_ZP                   ;If item is on the same nametable as current nametable,-->
    eor $08                         ;then no further adjustment to item x and y position needed.
    and #$01                        ;
    plp                             ;Restore the processor status and clear the carry bit.
    clc                             ;
    beq LDC4D                       ;If Scrolling up/down, branch to adjust item y position.

        adc $07                         ;Scrolling left/right. Make any necessary adjustments to-->
        sta $07                         ;item x position before writing to unique item history.

        jmp AddItemToHistory            ;($DC51)Add unique item to unique item history.

    LDC4D:
    adc $06                         ;Scrolling up/down. Make any necessary adjustments to-->
    sta $06                         ;item y position before writing to unique item history.

AddItemToHistory:
    jsr CreateItemID                ;($DC67)Create an item ID to put into unique item history.
LDC54:
    ldy NumberOfUniqueItems         ;Store number of uniqie items in Y.
    lda $06                         ;
    sta UniqueItemHistory,y         ;Store item ID in inuque item history.
    lda $07                         ;
    sta UniqueItemHistory+1,y       ;
    iny                             ;Add 2 to Y. 2 bytes ber unique item.
    iny                             ;
    sty NumberOfUniqueItems         ;Store new number of unique items.
    rts                             ;

;------------------------------------------[ Create item ID ]-----------------------------------------

;The following routine creates a unique two byte item ID number for that item.  The description
;of the format of the item ID number is as follows:
;
;IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
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
;
;The results are stored in $06(upper byte) and $07(lower byte).

CreateItemID:
    lda $07                         ;Load x map position of item.
    jsr Amul32                      ;($C2C$)*32. Move lower 3 bytes to upper 3 bytes.
    ora $06                         ;combine Y coordinates into data byte.
    sta $06                         ;Lower data byte complete. Save in $06.
    lsr $07                         ;
    lsr $07                         ;Move upper two bits of X coordinate to LSBs.
    lsr $07                         ;
    lda $09                         ;Load item type bits.
    asl                             ;Move the 6 bits of item type to upper 6 bits of byte.
    asl                             ;
    ora $07                         ;Add upper two bits of X coordinate to byte.
    sta $07                         ;Upper data byte complete. Save in #$06.
    rts                             ;

;-----------------------------------------------------------------------------------------------------

AreObjectsTouching:
    jsr GetObject1CoordData
LDC82:
    jsr GetObject0CoordData
    jsr DistFromObj0ToObj1
    jmp LF1FA

;The following table is used to rotate the sprites of both Samus and enemies when they explode.

ExplodeRotationTbl:
    .byte $00                       ;No sprite flipping.
    .byte $80                       ;Flip sprite vertically.
    .byte $C0                       ;Flip sprite vertically and horizontally.
    .byte $40                       ;Flip sprite horizontally.

; UpdateObjAnim
; =============
; Advance to object's next frame of animation

UpdateObjAnim:
LDC8F:
    ldx PageIndex
    ldy AnimDelay,x
    beq Lx130      ; is it time to advance to the next anim frame?
        dec AnimDelay,x     ; nope
        bne Lx132   ; exit if still not zero (don't update animation)
    Lx130:
    sta AnimDelay,x     ; set initial anim countdown value
    ldy AnimIndex,x
Lx131:
    lda ObjectAnimIndexTbl,y                ;($8572)Load frame number.
    cmp #$FF        ; has end of anim been reached?
    beq Lx133
    sta AnimFrame,x     ; store frame number
    iny          ; inc anim index
    tya
    sta AnimIndex,x     ; store anim index
Lx132:
    rts

Lx133:
    ldy AnimResetIndex,x     ; reset anim frame index
    jmp Lx131    ; do first frame of animation

;is this unused?
    pha
    lda #$00
    sta $06
    pla
    bpl Lx134
        dec $06
    Lx134:
    clc
    rts

;--------------------------------[ Get sprite control byte ]-----------------------------------------

;The sprite control byte extracted from the frame data has the following format: AABBXXXX.
;Where AA are the two bits used to control the horizontal and verticle mirroring of the
;sprite and BB are the two bits used control the sprite colors. XXXX is the entry number
;in the PlacePtrTbl used to place the sprite on the screen.

GetSpriteCntrlData:
    ldy #$00                        ;
    sty $0F                         ;Clear index into placement data.
    lda ($00),y                     ;Load control byte from frame pointer data.
    sta $04                         ;Store value in $04 for processing below.
    tax                             ;Keep a copy of the value in x as well.
    jsr Adiv16                      ;($C2BF)Move upper 4 bits to lower 4 bits.
    and #$03                        ;
    sta $05                         ;The following lines take the upper 4 bits in the-->
    txa                             ;control byte and transfer bits 4 and 5 into $05 bits 0-->
    and #$C0                        ;and 1(sprite color bits).  Bits 6 and 7 are-->
    ora #$20                        ;transferred into $05 bits 6 and 7(sprite flip bits).-->
    ora $05                         ;bit 5 is then set(sprite always drawn behind background).
    sta $05                         ;
    lda ObjectCntrl                 ;Extract bit from control byte that controls the
    and #$10                        ;object mirroring.
    asl                             ;
    asl                             ;
    eor $04                         ;Move it to the bit 6 position and use it to flip the-->
    sta $04                         ;horizontal mirroring of the sprite if set.
    lda ObjectCntrl                 ;
    bpl LDCEF                       ;If MSB is set in ObjectCntrl, use its flip bits(6 and 7).
        asl ObjectCntrl                 ;
        jsr SpriteFlipBitsOveride       ;($E038)Use object flip bits as priority over sprite flip bits.
    LDCEF:
    txa                             ;Discard upper nibble so only entry number into-->
    and #$0F                        ;PlacePtrTbl remains.
    asl                             ;*2. pointers in PlacePntrTbl are 2 bytes in size.
    tax                             ;Transfer to X to use as an index to find proper-->
    rts                             ;placement data segment.

;-----------------------------------------------------------------------------------------------------

; Post-explosion enemy death handler
LDCF5:
    jsr ClearObjectCntrl            ;($DF2D)Clear object control byte.
    pla
    pla
    ldx PageIndex
LDCFC:
    lda InArea ; Branch ahead if not in Tourian
    cmp #$13
    bne Lx135

        lda EnDataIndex,x
        cmp #$04
        beq Lx139
        cmp #$02
        beq Lx139
    Lx135:
    ; Branch if boss just killed
    lda EnData0C,x
    asl
    bmi LDD75

    jsr ReadTableAt968B
    sta $00
    jsr $80B0 ; TableAtL977B[EnemyType[x]]*2
    and #$20
    sta EnDataIndex,x
    lda #$05
    sta EnStatus,x
    lda #$60
    sta EnData0D,x
    lda RandomNumber1
    cmp #$10
    bcc LDD5B
Lx136:
    and #$07
    tay
    lda ItemDropTbl,y
    sta EnAnimFrame,x
    cmp #$80
    bne Lx138
        ldy MaxMissilePickup
        cpy CurrentMissilePickups
        beq LDD5B
        lda MaxMissiles
        beq LDD5B
        inc CurrentMissilePickups
    Lx137:
        rts
    Lx138:
        ldy MaxEnergyPickup
        cpy CurrentEnergyPickups
        beq LDD5B
        inc CurrentEnergyPickups
        cmp #$89
        bne Lx137
        lsr $00
        bcs Lx137

LDD5B:
    ldx PageIndex
    lda InArea
    cmp #$13
    beq Lx140
    Lx139:
        jmp KillObject                  ;($FA18)Free enemy data slot.
    Lx140:
    lda RandomNumber1
    ldy #$00
    sty CurrentEnergyPickups
    sty CurrentMissilePickups
    iny
    sty MaxMissilePickup
    sty MaxEnergyPickup
    bne Lx136

LDD75:
    jsr PowerUpMusic
    lda InArea
    and #$0F
    sta MiniBossKillDelay
    lsr
    tay
    sta MaxMissiles,y
    lda #75
    jsr AddToMaxMissiles
    bne LDD5B

LDD8B:
    ldx PageIndex
    lda EnAnimFrame,x
    cmp #$F7
    bne Lx143
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.

; AddToMaxMissiles
; ================
; Adds A to both MissileCount & MaxMissiles, storing the new count
; (255 if it overflows)

AddToMaxMissiles:
    pha                             ;Temp storage of # of missiles to add.
    clc
    adc MissileCount
    bcc Lx141
        lda #$FF
    Lx141:
    sta MissileCount
    pla
    clc
    adc MaxMissiles
    bcc Lx142
        lda #$FF
    Lx142:  sta MaxMissiles
    rts

Lx143:
    lda EnYRoomPos,x
    sta $0A  ; Y coord
    lda EnXRoomPos,x
    sta $0B  ; X coord
    lda EnNameTable,x
    sta $06  ; hi coord
    lda EnAnimFrame,x
    asl
    tay
    lda ($41),y
    bcc Lx144
        lda ($43),y
    Lx144:
    sta $00
    iny
    lda ($41),y
    bcc Lx145
        lda ($43),y
    Lx145:
    sta $01
    jsr GetSpriteCntrlData          ;($DCC3)Get place pointer index and sprite control data.
    tay
    lda ($45),y
    sta $02
    iny
    lda ($45),y
    sta $03
    ldy #$00
    cpx #$02
    bne Lx146
    ldx PageIndex
    inc EnCounter,x
    lda EnCounter,x
    pha
    and #$03
    tax
    lda $05
    and #$3F
    ora ExplodeRotationTbl,x
    sta $05
    pla
    cmp #$19
    bne Lx146
    jmp LDCF5
Lx146:
    ldx PageIndex
    iny
    lda ($00),y
    sta EnRadY,x
    jsr ReduceYRadius               ;($DE3D)Reduce temp y radius by #$10.
    iny
    lda ($00),y
    sta EnRadX,x
    sta $09
    iny
    sty $11
    jsr IsObjectVisible             ;($DFDF)Determine if object is within screen boundaries.
    txa
    asl
    sta $08
    ldx PageIndex
    lda EnData05,x
    and #$FD
    ora $08
    sta EnData05,x
    lda $08
    beq LDE53
    jmp LDEDE

;----------------------------------------[ Item drop table ]-----------------------------------------

;The following table determines what, if any, items an enemy will drop when it is killed.

ItemDropTbl:
    .byte $80                       ;Missile.
    .byte $81                       ;Energy.
    .byte $89                       ;No item.
    .byte $80                       ;Missile.
    .byte $81                       ;Energy.
    .byte $89                       ;No item.
    .byte $81                       ;Energy.
    .byte $89                       ;No item.

;------------------------------------[ Object drawing routines ]-------------------------------------

;The following function effectively sets an object's temporary y radius to #$00 if the object
;is 4 tiles tall or less.  If it is taller, #$10 is subtracted from the temporary y radius.

ReduceYRadius:
    sec                             ;
    sbc #$10                        ;Subtract #$10 from object y radius.
    bcs LDE44                       ;If number is still a positive number, branch to store value.
        lda #$00                        ;Number is negative.  Set Y radius to #$00.
    LDE44:
    sta $08                         ;Store result and return.
    rts                             ;

AnimDrawObject:
    jsr UpdateObjAnim               ;($DC8F)Update animation if needed.

DrawFrame:
    ldx PageIndex                   ;Get index to proper object to work with.
    lda AnimFrame,x                 ;
    cmp #$F7                        ;Is the frame valid?-->
    bne LDE56                          ;Branch if yes.
    LDE53:
        jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.
    LDE56:
        cmp #$07                        ;Is the animation of Samus facing forward?-->
    bne LDE60                           ;If not, branch.

    lda ObjectCntrl                 ;Ensure object mirroring bit is clear so Samus'-->
    and #$EF                        ;sprite appears properly when going up and down-->
    sta ObjectCntrl                 ;elevators.

LDE60:
    lda ObjectY,x                   ;
    sta $0A                         ;
    lda ObjectX,x                   ;Copy object y and x room position and name table-->
    sta $0B                         ;data into $0A, $0B and $06 respectively.
    lda ObjectHi,x                  ;
    sta $06                         ;
    lda AnimFrame,x                 ;Load A with index into FramePtrTable.
    asl                             ;*2. Frame pointers are two bytes.
    tax                             ;X is now the index into the FramePtrTable.
    lda FramePtrTable,x             ;
    sta $00                         ;
    lda FramePtrTable+1,x           ;Entry from FramePtrTable is stored in $0000.
    sta $01                         ;
    jsr GetSpriteCntrlData          ;($DCC3)Get place pointer index and sprite control data.
    lda PlacePtrTable,x             ;
    sta $02                         ;
    lda PlacePtrTable+1,x           ;Store pointer from PlacePtrTbl in $0002.
    sta $03                         ;
    lda IsSamus                     ;Is Samus the object being drawn?-->
    beq LDEBC                           ;If not, branch.

;Special case for Samus exploding.
    cpx #$0E                        ;Is Samus exploding?-->
    bne LDEBC                           ;If not, branch to skip this section of code.
    ldx PageIndex                   ;X=0.
    inc ObjectCounter               ;Incremented every frame during explode sequence.-->
    lda ObjectCounter               ;Bottom two bits used for index into ExplodeRotationTbl.
    pha                             ;Save value of A.
    and #$03                        ;Use 2 LSBs for index into ExplodeRotationTbl.
    tax                             ;
    lda $05                         ;Drop mirror control bits from sprite control byte.
    and #$3F                        ;
    ora ExplodeRotationTbl,x        ;Use mirror control bytes from table(Base is $DC8B).
    sta $05                         ;Save modified sprite control byte.
    pla                             ;Restore A
    cmp #$19                        ;After 25 frames, Move on to second part of death-->
    bne LDEBC                           ;handler, else branch to skip the rest of this code.
    ldx PageIndex                   ;X=0.
    lda #sa_Dead2                   ;
    sta ObjAction,x                 ;Move to next part of the death handler.
    lda #$28                        ;
    sta AnimDelay,x                 ;Set animation delay for 40 frames(.667 seconds).
    pla                             ;Pull last return address off of the stack.
    pla                             ;
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.

LDEBC:
    ldx PageIndex                   ;
    iny                             ;Increment to second frame data byte.
    lda ($00),y                     ;
    sta ObjRadY,x                   ;Get verticle radius in pixles of object.
    jsr ReduceYRadius               ;($DE3D)Reduce temp y radius by #$10.
    iny                             ;Increment to third frame data byte.
    lda ($00),y                     ;Get horizontal radius in pixels of object.
    sta ObjRadX,x                   ;
    sta $09                         ;Temp storage for object x radius.
    iny                             ;Set index to 4th byte of frame data.
    sty $11                         ;Store current index into frame data.
    jsr IsObjectVisible             ;($DFDF)Determine if object is within the screen boundaries.
    txa                             ;
    ldx PageIndex                   ;Get index to object.
    sta ObjectOnScreen,x            ;Store visibility status of object.
    tax                             ;
    beq LDEE3                           ;Branch if object is not within the screen boundaries.
LDEDE:
    ldx SpritePagePos               ;Load index into next unused sprite RAM segment.
    jmp DrawSpriteObject            ;($DF19)Start drawing object.

LDEE3:
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte then exit.

WriteSpriteRAM:
LDEE6:
    ldy $0F                         ;Load index for placement data.
    jsr YDisplacement               ;($DF6B)Get displacement for y direction.
    adc $10                         ;Add initial Y position.
    sta Sprite00RAM,x               ;Store sprite Y coord.
    dec Sprite00RAM,x               ;Because PPU uses Y + 1 as real Y coord.
    inc $0F                         ;Increment index to next byte of placement data.
    ldy $11                         ;Get index to frame data.
    lda ($00),y                     ;Tile value.
    sta Sprite00RAM+1,x             ;Store tile value in sprite RAM.
    lda ObjectCntrl                 ;
    asl                             ;Move horizontal mirror control byte to bit 6 and-->
    asl                             ;discard all other bits.
    and #$40                        ;
    eor $05                         ;Use it to override sprite horz mirror bit.
    sta Sprite00RAM+2,x             ;Store sprite control byte in sprite RAM.
    inc $11                         ;Increment to next byte of frame data.
    ldy $0F                         ;Load index for placement data.
    jsr XDisplacement               ;($DFA3)Get displacement for x direction.
    adc $0E                         ;Add initial X pos
    sta Sprite00RAM+3,x             ;Store sprite X coord
    inc $0F                         ;Increment to next placement data byte.
    inx                             ;
    inx                             ;
    inx                             ;Advance to next sprite.
    inx                             ;

DrawSpriteObject:
    ldy $11                         ;Get index into frame data.

GetNextFrameByte:
    lda ($00),y                     ;Get next frame data byte.
    cmp #$FC                        ;If byte < #$FC, byte is tile data. If >= #$FC, byte is-->
    bcc WriteSpriteRAM              ;frame data control info. Branch to draw sprite.
    beq OffsetObjectPosition        ;#$FC changes object's x and y position.
    cmp #$FD                        ;
    beq GetNewControlByte           ;#$FD sets new control byte information for the next sprites.
    cmp #$FE                        ;#$FE skips next sprite placement x and y bytes.
    beq SkipPlacementData           ;
    stx SpritePagePos               ;Keep track of current position in sprite RAM.

ClearObjectCntrl:
    lda #$00                        ;
    sta ObjectCntrl                 ;Clear object control byte.
    rts                             ;

SkipPlacementData:
LDF32:
    inc $0F                         ;Skip next y and x placement data bytes.
    inc $0F                         ;
    inc $11                         ;Increment to next data item in frame data.
    jmp DrawSpriteObject            ;($DF19)Draw next sprite.

GetNewControlByte:
LDF3B:
    iny                             ;Increment index to next byte of frame data.
    asl ObjectCntrl                 ;If MSB of ObjectCntrl is not set, no overriding of-->
    bcc LDF45                           ;flip bits needs to be performed.
        jsr SpriteFlipBitsOveride       ;($E038)Use object flip bits as priority over sprite flip bits.
        bne LDF4B                          ;Branch always.
    LDF45:
        lsr ObjectCntrl                 ;Restore MSB of ObjectCntrl.
        lda ($00),y                     ;
        sta $05                         ;Save new sprite control byte.
    LDF4B:
    iny                             ;Increment past sprite control byte.
    sty $11                         ;Save index of frame data.
    jmp GetNextFrameByte            ;($DF1B)Load next frame data byte.

OffsetObjectPosition:
    iny                             ;Increment index to next byte of frame data.
    lda ($00),y                     ;This data byte is used to offset the object from-->
    clc                             ;its current y positon.
    adc $10                         ;
    sta $10                         ;Add offset amount to object y screen position.
    inc $11                         ;
    inc $11                         ;Increment past control byte and y offset byte.
    ldy $11                         ;
    lda ($00),y                     ;Load x offset data byte.
    clc                             ;
    adc $0E                         ;Add offset amount to object x screen position.
    sta $0E                         ;
    inc $11                         ;Increment past x offset byte.
    jmp DrawSpriteObject            ;($DF19)Draw next sprite.

;----------------------------------[ Sprite placement routines ]-------------------------------------

YDisplacement:
    lda ($02),y                     ;Load placement data byte.
    tay                             ;
    and #$F0                        ;Check to see if this is placement data for the object-->
    cmp #$80                        ;exploding.  If so, branch.
    beq ExplodeYDisplace                          ;
    tya                             ;Restore placement data byte to A.
LDF75:
    bit $04                         ;
    bmi NegativeDisplacement        ;Branch if MSB in $04 is set(Flips object).
    clc                             ;Clear carry before returning.
    rts                             ;

ExplodeYDisplace:
    tya                             ;Transfer placement byte back into A.
    and #$0E                        ;Discard bits 7,6,5,4 and 0.
    lsr                             ;/2.
    tay                             ;
    lda ExplodeIndexTbl,y           ;Index into ExplodePlacementTbl.
    ldy IsSamus                     ;
    bne LDF8F            ;Is Samus the object exploding? if so, branch.
        ldy PageIndex                   ;Load index to proper enemy data.
        adc EnCounter,y                 ;Increment every frame enemy is exploding. Initial=#$01.
        jmp LDF91                          ;Jump to load explode placement data.


    ;Special case for Samus exploding.
    LDF8F:
           adc ObjectCounter               ;Increments every frame Samus is exploding. Initial=#$01.
    LDF91:
    tay                             ;
    lda ExplodeIndexTbl+2,y         ;Get data from ExplodePlacementTbl.
    pha                             ;Save data on stack.
    lda $0F                         ;Load placement data index.
    clc                             ;
    adc #$0C                        ;Move index forward by 12 bytes. to find y-->
    tay                             ;placement data.
    pla                             ;Restore A with ExplodePlacementTbl data.
    clc                             ;
    adc ($02),y                     ;Add table displacements with sprite placement data.
    jmp LDF75                       ;Branch to add y placement values to sprite coords.

XDisplacement:
    lda ($02),y                     ;Load placement data byte.
    tay                             ;
    and #$F0                        ;Check to see if this is placement data for the object-->
    cmp #$80                        ;exploding.  If so, branch.
    beq ExplodeXDisplace            ;
    tya                             ;Restore placement data byte to A.
LDFAD:
    bit $04                         ;
    bvc LDFB6                           ;Branch if bit 6 cleared, else data is negative displacement.

NegativeDisplacement:
    eor #$FF                        ;
    sec                             ;NOTE:Setting carry makes solution 1 higher than expected.
    adc #$F8                        ;If flip bit is set in $04, this function flips the-->
LDFB6:
    clc                             ;object by using two compliment minus 8(Each sprite is-->
    rts                             ;8x8 pixels).

ExplodeXDisplace:
    ldy PageIndex                   ;Load index to proper enemy slot.
    lda EnCounter,y                 ;Load counter value.
    ldy IsSamus                     ;Is Samus the one exploding?-->
    beq LDFC3                       ;If not, branch.
        lda ObjectCounter               ;Load object counter if it is Samus who is exploding.
    LDFC3:
    asl                             ;*2. Move sprite in x direction 2 pixels every frame.
    pha                             ;Store value on stack.
    ldy $0F                         ;
    lda ($02),y                     ;Load placement data byte.
    lsr                             ;
    bcs LDFD2                       ;Check if LSB is set. If not, the byte stored on stack-->
        pla                             ;Will be twos complimented and used to move sprite in-->
        eor #$FF                        ;the negative x direction.
        adc #$01                        ;
        pha                             ;
    LDFD2:
    lda $0F                         ;Load placement data index.
    clc                             ;
    adc #$0C                        ;Move index forward by 12 bytes. to find x-->
    tay                             ;placement data.
    pla                             ;Restore A with x displacement data.
    clc                             ;
    adc ($02),y                     ;Add x displacement with sprite placement data.
    jmp LDFAD                       ;Branch to add x placement values to sprite coords.

;---------------------------------[ Check if object is on screen ]----------------------------------

;The following set of functions determine if an object is visible on the screen.  If the object
;is visible, X-1 when the function returns, X=0 if the object is not within the boundaries of the
;current screen.  The function needs to know what nametable is currently in the PPU, what nametable
;the object is on and what the scroll offsets are.

IsObjectVisible:
    ldx #$01                        ;Assume object is visible on screen.
    lda $0A                         ;Object Y position in room.
    tay                             ;
    sec                             ;Subtract y scroll to find sprite's y position on screen.
    sbc ScrollY                     ;
    sta $10                         ;Store result in $10.
    lda $0B                         ;Object X position in room.
    sec                             ;
    sbc ScrollX                     ;Subtract x scroll to find sprite's x position on screen.
    sta $0E                         ;Store result in $0E.
    lda ScrollDir                   ;
    and #$02                        ;Is Samus scrolling left or right?-->
    bne HorzScrollCheck             ;($E01C)If so, branch.

VertScrollCheck:
    cpy ScrollY                     ;If object room pos is >= scrollY, set carry.
    lda $06                         ;Check if object is on different name table as current-->
    eor PPUCTRL_ZP                   ;name table active in PPU.-->
    and #$01                        ;If not, branch.
    beq LE012                           ;
    bcs LE01A                          ;If carry is still set, sprite is not in screen boundaries.
    lda $10                         ;
    sbc #$0F                        ;Move sprite y position up 15 pixles.
    sta $10                         ;
    lda $09                         ;
    clc                             ;If a portion of the object is outside the sceen-->
    adc $10                         ;boundaries, treat object as if the whole thing is-->
    cmp #$F0                        ;not visible.
    bcc LE01B                         ;
    clc                             ;Causes next statement to branch always.
LE012:
    bcc LE01A                           ;
    lda $09                         ;If object is on same name table as the current one in-->
    cmp $10                         ;the PPU, check if part of object is out of screen-->
    bcc LE01B                          ;boundaries.  If so, branch.
LE01A:
    dex                             ;Sprite is not within screen boundaries. Decrement X.
LE01B:
    rts                             ;

HorzScrollCheck:
    lda $06                         ;
    eor PPUCTRL_ZP                   ;Check if object is on different name table as current-->
    and #$01                        ;name table active in PPU.-->
    beq LE02E                           ;If not, branch.
        bcs LE036                          ;If carry is still set, sprite is not in screen boundaries.
        lda $09                         ;
        clc                             ;If a portion of the object is outside the sceen-->
        adc $0E                         ;boundaries, treat object as if the whole thing is-->
        bcc LE037                         ;not visible.
        clc                             ;Causes next statement to branch always.
    LE02E:
    bcc LE036                           ;
    lda $09                         ;If object is on same name table as the current one in-->
    cmp $0E                         ;the PPU, check if part of object is out of screen-->
    bcc LE037                          ;boundaries.  If so, branch.
LE036:
       dex                             ;Sprite is not within screen boundaries. Decrement X.
LE037:
       rts                             ;

;------------------------[ Override sprite flip bits with object flip bits ]-------------------------

;If the MSB is set in ObjectCntrl, its two upper bits that control sprite flipping take priority
;over the sprite control bits.  This function modifies the sprite control byte with any flipping
;bits found in ObjectCntrl.

SpriteFlipBitsOveride:
    lsr ObjectCntrl                 ;Restore MSB.
    lda ($00),y                     ;Reload frame data control byte into A.
    and #$C0                        ;Extract the two sprite flip bytes from theoriginal-->
    ora ObjectCntrl                 ;control byte and set any additional bits from ObjectCntrl.
    sta $05                         ;Store modified byte to load in sprite control byte later.
    lda ObjectCntrl                 ;
    ora #$80                        ;
    sta ObjectCntrl                 ;Ensure MSB of object control byte remains set.
    rts                             ;

;--------------------------------[ Explosion placement data ]---------------------------------------

;The following table has the index values into the table after it for finding the placement data
;for an exploding object.

ExplodeIndexTbl:
    .byte $00, $18, $30

;The following table is used to produce the arcing motion of exploding objects.  It is displacement
;data for the y directions only.  The x displacement is constant.

ExplodePlacementTbl:

;Bottom sprites.
    .byte $FC, $F8, $F4, $F0, $EE, $EC, $EA, $E8, $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
    .byte $E5, $E7, $E9, $EB, $EF, $F3, $F7, $FB

;Middle sprites.
    .byte $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $ED, $EB, $EA, $E9, $E8, $E7, $E6
    .byte $E6, $E6, $E6, $E6, $E8, $EA, $EC, $EE

;Top sprites.
    .byte $FE, $FC, $FA, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F1, $F0, $F0, $EF, $EF
    .byte $EF, $EF, $EF, $EF, $F0, $F0, $F1, $F2

;--------------------------------------[ Update enemy animation ]-----------------------------------

;Advance to next frame of enemy's animation. Basically the same as UpdateObjAnim, only for enemies.

UpdateEnemyAnim:
    ldx PageIndex                   ;Load index to desired enemy.
    ldy EnStatus,x                  ;
    cpy #$05                        ;Is enemy in the process of dying?-->
    beq LE0BB                         ;If so, branch to exit.
    ldy EnAnimDelay,x               ;
    beq LE0A7                           ;Check if current anumation frame is ready to be updated.
        dec EnAnimDelay,x               ;Not ready to update. decrement delay timer and-->
        bne LE0BB                         ;branch to exit.
    LE0A7:
    sta EnAnimDelay,x               ;Save new animation delay value.
    ldy EnAnimIndex,x               ;Load enemy animation index.
LE0AD:
    lda (EnemyAnimPtr),y            ;Get animation data.
    cmp #$FF                        ;End of animation?
    beq LE0BC                          ;If so, branch to reset animation.
    sta EnAnimFrame,x               ;Store current animation frame data.
    iny                             ;Increment to next animation data index.
    tya                             ;
    sta EnAnimIndex,x               ;Save new animation index.
LE0BB:
    rts                             ;

LE0BC:
    ldy EnResetAnimIndex,x          ;reset animation index.
    bcs LE0AD                         ;Branch always.

;---------------------------------------[ Display status bar ]---------------------------------------

;Displays Samus' status bar components.

DisplayBar:
    ldy #$00                        ;Reset data index.
    lda SpritePagePos               ;Load current sprite index.
    pha                             ;save sprite page pos.
    tax                             ;
    LE0C7:
        lda DataDisplayTbl,y            ;
        sta Sprite00RAM,x               ;Stor contents of DataDisplayTbl in sprite RAM.
        inx                             ;
        iny                             ;
        cpy #$28                        ;10*4. At end of DataDisplayTbl? If not, loop to-->
        bne LE0C7                           ;load next byte from table.

;Display 2-digit health count.
    stx SpritePagePos               ;Save new location in sprite RAM.
    pla                             ;Restore initial sprite page pos.
    tax                             ;
    lda HealthHi                    ;
    and #$0F                        ;Extract upper health digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda HealthLo                    ;
    jsr Adiv16                      ;($C2BF)Move lower health digit to 4 LSBs.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    ldy EndTimerHi                  ;
    iny                             ;Is Samus in escape sequence?-->
    bne LE11C                          ;If so, branch.
    ldy MaxMissiles                 ;
    beq LE10A                           ;Don't show missile count if Samus has no missile containers.

;Display 3-digit missile count.
    lda MissileCount                ;
    jsr HexToDec                    ;($E198)Convert missile hex count to decimal cout.
    lda $02                         ;Upper digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda $01                         ;Middle digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda $00                         ;Lower digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    bne LE14A                         ;Branch always.

;Samus has no missiles, erase missile sprite.
LE10A:
    lda #$FF                        ;"Blank" tile.
    cpx #$F4                        ;If at last 3 sprites, branch to skip.
    bcs LE14A                          ;
    sta Sprite03RAM+1,x             ;Erase left half of missile.
    cpx #$F0                        ;If at last 4 sprites, branch to skip.
    bcs LE14A                          ;
    sta Sprite04RAM+1,x             ;Erase right half of missile.
    bne LE14A                          ;Branch always.

;Display 3-digit end sequence timer.
LE11C:
    lda EndTimerHi                  ;
    jsr Adiv16                      ;($C2BF)Upper timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda EndTimerHi                  ;
    and #$0F                        ;Middle timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda EndTimerLo                  ;
    jsr Adiv16                      ;($C2BF)Lower timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda #$58                        ;"TI" sprite(left half of "TIME").
    sta Sprite00RAM+1,x             ;
    inc Sprite00RAM+2,x             ;Change color of sprite.
    cpx #$FC                        ;If at last sprite, branch to skip.
    bcs LE14A                           ;
    lda #$59                        ;"ME" sprite(right half of "TIME").
    sta Sprite01RAM+1,x             ;
    inc Sprite01RAM+2,x             ;Change color of sprite.

LE14A:
    ldx SpritePagePos               ;Restore initial sprite page pos.
    lda TankCount                   ;
    beq LE172                          ;Branch to exit if Samus has no energy tanks.

;Display full/empty energy tanks.
    sta $03                         ;Temp store tank count.
    lda #$40                        ;X coord of right-most energy tank.
    sta $00                         ;Energy tanks are drawn from right to left.
    ldy #$6F                        ;"Full energy tank" tile.
    lda HealthHi                    ;
    jsr Adiv16                      ;($C2BF)/16. A contains # of full energy tanks.
    sta $01                         ;Storage of full tanks.
    bne AddTanks                    ;Branch if at least 1 tank is full.
    dey                             ;Else switch to "empty energy tank" tile.

AddTanks:
    jsr AddOneTank                  ;($E17B)Add energy tank to display.
    dec $01                         ;Any more full energy tanks left?-->
    bne LE16C                           ;If so, then branch.-->
        dey                             ;Otherwise, switch to "empty energy tank" tile.
    LE16C:
    dec $03                         ;done all tanks?-->
    bne AddTanks                    ;if not, loop to do another.

    stx SpritePagePos               ;Store new sprite page position.
LE172:
    rts                             ;

;----------------------------------------[Sprite write digit ]---------------------------------------

;A=value in range 0..9. #$A0 is added to A(the number sprites begin at $A0), and the result is stored
;as the tile # for the sprite indexed by X.

SPRWriteDigit:
    ora #$A0                        ;#$A0 is index into pattern table for numbers.
    sta Sprite00RAM+1,x             ;Store proper nametable pattern in sprite RAM.
    jmp Xplus4                      ;Find next sprite pattern table byte.

;----------------------------------[ Add energy tank to display ]------------------------------------

;Add energy tank to Samus' data display.

AddOneTank:
    lda #$17                        ;Y coord-1.
    sta Sprite00RAM,x               ;
    tya                             ;Tile value.
    sta Sprite00RAM+1,x             ;
    lda #$01                        ;Palette #.
    sta Sprite00RAM+2,x             ;
    lda $00                         ;X coord.
    sta Sprite00RAM+3,x             ;
    sec                             ;
    sbc #$0A                        ;Find x coord of next energy tank.
    sta $00                         ;

;-----------------------------------------[ Add 4 to x ]---------------------------------------------

Xplus4:
    inx                             ;
    inx                             ;
    inx                             ;Add 4 to value stored in X.
    inx                             ;
    rts                             ;

;------------------------------------[ Convert hex to decimal ]--------------------------------------

;Convert 8-bit value in A to 3 decimal digits. Upper digit put in $02, middle in $01 and lower in $00.

HexToDec:
    ldy #100                        ;Find upper digit.
    sty $0A                         ;
    jsr GetDigit                    ;($E1AD)Extract hundreds digit.
    sty $02                         ;Store upper digit in $02.
    ldy #10                         ;Find middle digit.
    sty $0A                         ;
    jsr GetDigit                    ;($E1AD)Extract tens digit.
    sty $01                         ;Store middle digit in $01.
    sta $00                         ;Store lower digit in $00
    rts                             ;

GetDigit:
    ldy #$00                        ;
    sec                             ;
    LE1B0:
        iny                             ;
        sbc $0A                         ;Loop and subtract value in $0A from A until carry flag-->
        bcs LE1B0                           ;is not set.  The resulting number of loops is the decimal-->
    dey                             ;number extracted and A is the remainder.
    adc $0A                         ;
    rts                             ;

;-------------------------------------[ Status bar sprite data ]-------------------------------------

;Sprite data for Samus' data display

DataDisplayTbl:
    .byte $21,$A0,$01,$30           ;Upper health digit.
    .byte $21,$A0,$01,$38           ;Lower health digit.
    .byte $2B,$FF,$01,$28           ;Upper missile digit.
    .byte $2B,$FF,$01,$30           ;Middle missile digit.
    .byte $2B,$FF,$01,$38           ;Lower missile digit.
    .byte $2B,$5E,$00,$18           ;Left half of missile.
    .byte $2B,$5F,$00,$20           ;Right half of missile.
    .byte $21,$76,$01,$18           ;E
    .byte $21,$7F,$01,$20           ;N
    .byte $21,$3A,$00,$28           ;..

;-------------------------------------------[ Bit scan ]---------------------------------------------

;This function takes the value stored in A and right shifts it until a set bit is encountered.
;Once a set bit is encountered, the function exits and returns the bit number of the set bit.
;The returned value is stored in A.

BitScan:
    stx $0E                         ;Save X.
    ldx #$00                        ;First bit is bit 0.
LE1E5:
    lsr                             ;Transfer bit to carry flag.
    bcs LE1ED                           ;If the shifted bit was 1, Branch out of loop.
    inx                             ;Increment X to keep of # of bits checked.
    cpx #$08                        ;Have all 8 bit been tested?-->
    bne LE1E5                           ;If not, branch to check the next bit.
LE1ED:
    txa                             ;Return which bit number was set.
    ldx $0E                         ;Restore X.
LE1F0:
    rts                             ;

;------------------------------------------[ Scroll door ]-------------------------------------------

;Scrolls the screen if Samus is inside a door.

ScrollDoor:
    ldx DoorStatus                  ;
    beq LE1F0                           ;Exit if Samus isn't in a door.
    dex                             ;
    bne LE1FE                           ;Not in right door. branch to check left door.
        jsr ScrollRight                 ;($E6D2)DoorStatus=1, scroll 1 pixel right.
        jmp LE204                          ;Jump to check if door scroll is finished.

    LE1FE:
        dex                             ;Check if in left door.
        bne LE20C                          ;
        jsr ScrollLeft                  ;($E6A7)DoorStatus=2, scroll 1 pixel left.
    LE204:
    ldx ScrollX                     ;Has x scroll offset reached 0?-->
    bne Exit15                      ;If not, branch to exit.

;Scrolled one full screen, time to exit door.
    ldx #$05                        ;Samus is exiting the door.
    bne DoOneDoorScroll             ;Branch always.

LE20C:
    dex                             ;
    bne LE215                           ;Check if need to scroll down to center door.
        jsr ScrollDown                  ;($E519)DoorStatus=3, scroll 1 pixel down.
        jmp VerticalRoomCentered                          ;Jump to check y scrolling value.
    LE215:
    dex                             ;
    bne Exit15                      ;Check if need to scroll up to center door.
    jsr ScrollUp                    ;($E4F1)DoorStatus=4, scroll 1 pixel up.

VerticalRoomCentered:
LE21B:
    ldx ScrollY                     ;Has room been centered on screen?-->
    bne Exit15                      ;If not, branch to exit.
    stx DoorOnNameTable3            ;
    stx DoorOnNameTable0            ;Erase door nametable data.
    inx                             ;X=1.
    lda ObjectX                     ;Did Samus enter in the right hand door?-->
    bmi LE241                          ;If so, branch.
    inx                             ;X=2. Samus is in left door.
    bne LE241                          ;Branch always.

;This function is called once after door scrolling is complete.

DoOneDoorScroll:
    lda #$20                        ;Set DoorDelay to 32 frames(comming out of door).
    sta DoorDelay                   ;
    lda SamusDoorData               ;Check if scrolling should be toggled.
    jsr Amul8                       ;($C2C6)*8. Is door not to toggle scrolling(item room,-->
    bcs LE23D                           ;bridge room, etc.)? If so, branch to NOT toggle scrolling.
        ldy DoorScrollStatus            ;If comming from vertical shaft, skip ToggleScroll because-->
        cpy #$03                        ;the scroll was already toggled after room was centered-->
        bcc LE241                          ;by the routine just above.
    LE23D:
    lda #$47                        ;Set mirroring for vertical mirroring(horz scrolling).
    bne LE244                          ;Branch always.

    LE241:
        jsr ToggleScroll                ;($E252)Toggle scrolling and mirroring.
    LE244:
    sta MirrorCntrl                 ;Store new mirror control data.
    stx DoorStatus                  ;DoorStatus=5. Done with door scrolling.

Exit15:
    rts                             ;Exit for several routines above.

;------------------------------------[ Toggle Samus nametable ]--------------------------------------

ToggleSamusHi:
    lda ObjectHi                    ;
    eor #$01                        ;Change Samus' current nametable from one to the other.
    sta ObjectHi                    ;
    rts                             ;

;-------------------------------------------[ Toggle scroll ]----------------------------------------

;Toggles both mirroring and scroll direction when Samus has moved from
;a horizontal shaft to a vertical shaft or vice versa.

ToggleScroll:
    lda ScrollDir                   ;
    eor #$03                        ;Toggle scroll direction.
    sta ScrollDir                   ;
    lda MirrorCntrl                 ;Toggle mirroring.
    eor #$08                        ;
    rts                             ;

;----------------------------------------[ Is Samus in lava ]----------------------------------------

;The following function checks to see if Samus is in lava.  If she is, the carry bit is cleared,
;if she is not, the carry bit is set. Samus can only be in lava if in a horizontally scrolling
;room. If Samus is 24 pixels or less away from the bottom of the screen, she is considered to be
;in lava whether its actually there or not.

IsSamusInLava:
    lda #$01                        ;
    cmp ScrollDir                   ;Set carry bit(and exit) if scrolling up or down.
    bcs LE268                           ;
    lda #$D8                        ;If Samus is Scrolling left or right and within 24 pixels-->
    cmp ObjectY                     ;of the bottom of the screen, she is in lava. Clear carry bit.
LE268:
    rts                             ;

;----------------------------------[ Check lava and movement routines ]------------------------------

LavaAndMoveCheck:
    lda ObjAction                   ;
    cmp #sa_Elevator                ;Is Samus on elevator?-->
    beq LE274                           ;If so, branch.
        cmp #sa_Dead                    ;Is Samus Dead-->
        bcs LE268                           ;If so, branch to exit.
    LE274:
    jsr IsSamusInLava               ;($E25D)Clear carry flag if Samus is in lava.
    ldy #$FF                        ;Assume Samus not in lava.
    bcs LE2A6                        ;Samus not in lava so branch.

;Samus is in lava.
    sty DamagePushDirection         ;Don't push Samus from lava damage.
    jsr ClearHealthChange           ;($F323)Clear any pending health changes to Samus.
    lda #$32                        ;
    sta SamusBlink                  ;Make Samus blink.
    lda FrameCount                  ;
    and #$03                        ;Start the jump SFX every 4th frame while in lava.
    bne LE28D                           ;
        jsr SFX_SamusJump               ;($CBAC)Initiate jump SFX.
    LE28D:
    lda FrameCount                  ;
    lsr                             ;This portion of the code causes Samus to be damaged by-->
    and #$03                        ;lava twice every 8 frames if she does not have the varia-->
    bne LE2A4                          ;but only once every 8 frames if she does.
    lda SamusGear                   ;
    and #gr_VARIA                   ;Does Samus have the Varia?-->
    beq LE29D                           ;If not, branch.
        bcc LE2A4                          ;Samus has varia. Carry set every other frame. Half damage.
    LE29D:
    lda #$07                        ;
    sta HealthLoChange              ;Samus takes lava damage.
    jsr SubtractHealth              ;($CE92)
LE2A4:
    ldy #$00                        ;Prepare to indicate Samus is in lava.
LE2A6:
    iny                             ;Set Samus lava status.
LE2A7:
    sty SamusInLava                 ;

SamusMoveVertically:
    jsr VertAccelerate              ;($E37A)Calculate vertical acceleration.
    lda ObjectY                     ;
    sec                             ;
    sbc ScrollY                     ;Calculate Samus' screen y position.
    sta SamusScrY                   ;
    lda $00                         ;Load temp copy of vertical speed.
    bpl LE2D7                        ;If Samus is moving downwards, branch.

    jsr TwosCompliment              ;($C3D4)Get twos compliment of vertical speed.
    ldy SamusInLava                 ;Is Samus in lava?
    beq LE2C2                           ;If not, branch,-->
    lsr                             ;else cut vertical speed in half.
    beq SamusMoveHorizontally       ;($E31A)Branch if no vertical mvmnt to Check left/right mvmnt.

;Samus is moving upwards.
LE2C2:
    sta ObjectCounter               ;Store number of pixels to move Samus this frame.
LE2C4:
    jsr MoveSamusUp                 ;($E457)Attempt to move Samus up 1 pixel.
    bcs LE2D3                           ;Branch if Samus successfully moved up 1 pixel.

    sec                             ;Samus blocked upwards. Divide her speed by 2 and set the
    ror ObjVertSpeed                ;MSB to reverse her direction of travel.
    ror VertCntrLinear              ;
    jmp SamusMoveHorizontally       ;($E31A)Attempt to move Samus left/right.

LE2D3:
    dec ObjectCounter               ;1 pixel movement is complete.
    bne LE2C4                          ;Branch if Samus needs to be moved another pixel.

;Samus is moving downwards.
LE2D7:
    beq SamusMoveHorizontally       ;($E31A)Branch if no vertical mvmnt to Check left/right mvmnt.
    ldy SamusInLava                 ;Is Samus in lava?
    beq LE2E1                           ;If not, branch,-->
    lsr                             ;Else reduce Samus speed by 75%(divide by 4).
    lsr                             ;
    beq SamusMoveHorizontally       ;($E31A)Attempt to move Samus left/right.

LE2E1:
    sta ObjectCounter               ;Store number of pixels to move Samus this frame.
LE2E3:
    jsr MoveSamusDown               ;($E4A3)Attempt to move Samus 1 pixel down.
    bcs LE316                         ;Branch if Samus successfully moved down 1 pixel.

;Samus bounce after hitting the ground in ball form.
    lda ObjAction                   ;
    cmp #sa_Roll                    ;Is Samus rolled into a ball?-->
    bne LE30B                           ;If not, branch.
    lsr ObjVertSpeed                ;Divide verticle speed by 2.
    beq LE30E                          ;Speed not fast enough to bounce. branch to skip.
    ror VertCntrLinear              ;Move carry bit into MSB to reverse Linear counter.
    lda #$00                        ;
    sec                             ;
    sbc VertCntrLinear              ;Subtract linear counter from 0 and save the results.-->
    sta VertCntrLinear              ;Carry will be cleared.
    lda #$00                        ;
    sbc ObjVertSpeed                ;Subtract vertical speed from 0. this will reverse the-->
    sta ObjVertSpeed                ;vertical direction of travel(bounce up).
    jmp SamusMoveHorizontally       ;($E31A)Attempt to move Samus left/right.

;Samus has hit the ground after moving downwards.
LE30B:
    jsr SFX_SamusWalk               ;($CB96)Play walk SFX.
LE30E:
    jsr StopVertMovement            ;($D147)Clear vertical movement data.
    sty SamusGravity                ;Clear Samus gravity value.
    beq SamusMoveHorizontally       ;($E31A)Attempt to move Samus left/right.

LE316:
    dec ObjectCounter               ;1 pixel movement is complete.
    bne LE2E3                        ;Branch if Samus needs to be moved another pixel.

SamusMoveHorizontally:
    jsr HorzAccelerate              ;($E3E5)Horizontally accelerate Samus.
    lda ObjectX                     ;
    sec                             ;Calculate Samus' x position on screen.
    sbc ScrollX                     ;
    sta SamusScrX                   ;Save Samus' x position.
    lda $00                         ;Load Samus' current horizontal speed.
    bpl LE347                         ;Branch if moving right.

;Samus is moving left.
    jsr TwosCompliment              ;($C3D4)Get twos compliment of horizontal speed.
    ldy SamusInLava                 ;Is Samus in lava?-->
    beq LE333                           ;If not, branch,-->
        lsr                             ;else cut horizontal speed in half.
        beq Exit10                      ;Branch to exit if Samus not going to move this frame.

    LE333:
    sta ObjectCounter               ;Store number of pixels to move Samus this frame.
    LE335:
        jsr MoveSamusLeft               ;($E626)Attempt to move Samus 1 pixel to the left.
        jsr CheckStopHorzMvmt           ;($E365)Check if horizontal movement needs to be stopped.
        dec ObjectCounter               ;1 pixel movement is complete.
        bne LE335                           ;Branch if Samus needs to be moved another pixel.

    lda SamusDoorData               ;Has Samus entered a door?-->
    beq Exit10                      ;If not, branch to exit.
    lda #$01                        ;Door leads to the left.
    bne LE362                        ;Branch always.

;Samus is moving right.
LE347:
    beq Exit10                      ;Branch to exit if Samus not moving horizontally.
    ldy SamusInLava                 ;Is Samus in lava?-->
    beq LE350                           ;If not, branch,-->
    lsr                             ;else cut horizontal speed in half.
    beq Exit10                      ;Branch to exit if Samus not going to move this frame.

LE350:
    sta ObjectCounter               ;Store number of pixels to move Samus this frame.
    LE352:
        jsr MoveSamusRight              ;($E668)Attempt to move Samus 1 pixel to the right.
        jsr CheckStopHorzMvmt           ;($E365)Check if horizontal movement needs to be stopped.
        dec ObjectCounter               ;1 pixel movement is complete.
        bne LE352                           ;Branch if Samus needs to be moved another pixel.

    lda SamusDoorData               ;Has Samus entered a door?-->
    beq Exit10                      ;If not, branch to exit.
    lda #$00                        ;
LE362:
    sta SamusDoorDir                ;Door leads to the right.

Exit10:
    rts                             ;Exit for routines above and below.

CheckStopHorzMvmt:
    bcs Exit10                      ;Samus moved successfully. Branch to exit.
    lda #$01                        ;Load counter with #$01 so this function will not be-->
    sta ObjectCounter               ;called again.
    lda SamusGravity                ;Is Samus on the ground?-->
    bne Exit10                      ;If not, branch to exit.
    lda ObjAction                   ;
    cmp #sa_Roll                    ;Is Samus rolled into a ball?-->
    beq Exit10                      ;If so, branch to exit.
    jmp StopHorzMovement            ;($CF55)Stop horizontal movement or play walk SFX if stopped.

;-------------------------------------[ Samus vertical acceleration ]--------------------------------

;The following code accelerates/decelerates Samus vertically.  There are 4 possible values for
;gravity used in the acceleration calculation. The higher the number, the more intense the gravity.
;The possible values for gravity are as follows:
;#$38-When Samus has been hit by an enemy.
;#$1A-When Samus is falling.
;#$18-Jump without high jump boots.
;#$12-Jump with high jump boots.

VertAccelerate:
    lda SamusGravity                ;Is Samus rising or falling?-->
    bne LE3A5                          ;Branch if yes.
    lda #$18                        ;
    sta SamusHorzSpeedMax           ;Set Samus maximum running speed.
    lda ObjectY                     ;
    clc                             ;
    adc ObjRadY                     ;Check is Samus is obstructed downwards on y room-->
    and #$07                        ;positions divisible by 8(every 8th pixel).
    bne LE394                           ;
    jsr CheckMoveDown               ;($E7AD)Is Samus obstructed downwards?-->
    bcc LE3A5                          ;Branch if yes.
LE394:
    jsr SamusOnElevatorOrEnemy      ;($D976)Calculate if Samus standing on elevator or enemy.
    lda SamusOnElevator             ;Is Samus on an elevator?-->
    bne LE3A5                           ;Branch if yes.
    lda OnFrozenEnemy               ;Is Samus standing on a frozen enemy?-->
    bne LE3A5                           ;Branch if yes.
    lda #$1A                        ;Samus is falling. Store falling gravity value.
    sta SamusGravity                ;

LE3A5:
    ldx #$05                        ;Load X with maximum downward speed.
    lda VertCntrLinear              ;
    clc                             ;The higher the gravity, the faster this addition overflows-->
    adc SamusGravity                ;and the faster ObjVertSpeed is incremented.
    sta VertCntrLinear              ;
    lda ObjVertSpeed                ;Every time above addition sets carry bit, ObjVertSpeed is-->
    adc #$00                        ;incremented. This has the effect of speeding up a fall-->
    sta ObjVertSpeed                ;and slowing down a jump.
    bpl LE3C9                           ;Branch if Samus is moving downwards.

;Check if maximum upward speed has been exceeded. If so, prepare to set maximum speed.
    lda #$00                        ;
    cmp VertCntrLinear              ;Sets carry bit.
    sbc ObjVertSpeed                ;Subtract ObjVertSpeed to see if maximum speed has-->
    cmp #$06                        ;been exceeded.
    ldx #$FA                        ;Load X with maximum upward speed.
    bne LE3CB                          ;Branch always.

;Check if maximum downward speed has been reached. If so, prepare to set maximum speed.
LE3C9:
    cmp #$05                        ;Has maximum downward speed been reached?-->
LE3CB:
    bcc LE3D3                           ;If not, branch.

;Max verticle speed reached or exceeded. Adjust Samus verticle speed to max.
    jsr StopVertMovement            ;($D147)Clear verticle movement data.
    stx ObjVertSpeed                ;Set Samus vertical speed to max.

;This portion of the function creates an exponential increase/decrease in verticle speed. This is the
;part of the function that does all the work to make Samus' jump seem natural.
LE3D3:
    lda VertCntrNonLinear           ;
    clc                             ;This function adds itself plus the linear verticle counter-->
    adc VertCntrLinear              ;onto itself every frame.  This causes the non-linear-->
    sta VertCntrNonLinear           ;counter to increase exponentially.  This function will-->
    lda #$00                        ;cause Samus to reach maximum speed first in most-->
    adc ObjVertSpeed                ;situations before the linear counter.
    sta $00                         ;$00 stores temp copy of current verticle speed.
    rts                             ;

;----------------------------------------------------------------------------------------------------

HorzAccelerate:
LE3E5:
    lda SamusHorzSpeedMax
    jsr Amul16       ; * 16
    sta $00
    sta $02
    lda SamusHorzSpeedMax
    jsr Adiv16       ; / 16
    sta $01
    sta $03

    lda HorzCntrLinear
    clc
    adc SamusHorzAccel
    sta HorzCntrLinear
    tax
    lda #$00
    bit SamusHorzAccel
    bpl Lx147                           ;Branch if Samus accelerating to the right.

        lda #$FF
    Lx147:
    adc ObjHorzSpeed
    sta ObjHorzSpeed
    tay
    bpl Lx148                           ;Branch if Samus accelerating to the right.

        lda #$00
        sec
        sbc HorzCntrLinear
        tax
        lda #$00
        sbc ObjHorzSpeed
        tay
        jsr LE449
    Lx148:
    cpx $02
    tya
    sbc $03
    bcc Lx149
        lda $00
        sta HorzCntrLinear
        lda $01
        sta ObjHorzSpeed
    Lx149:
    lda HorzCntrNonLinear
    clc
    adc HorzCntrLinear
    sta HorzCntrNonLinear
    lda #$00
    adc ObjHorzSpeed
    sta $00                         ;$00 stores temp copy of current horizontal speed.
    rts                             ;

LE449:
    lda #$00
    sec
    sbc $00
    sta $00
    lda #$00
    sbc $01
    sta $01
    rts

;----------------------------------------------------------------------------------------------------

;Attempt to move Samus one pixel up.

MoveSamusUp:
    lda ObjectY                     ;Get Samus' y position in room.
    sec                             ;
    sbc ObjRadY                     ;Subtract Samus' vertical radius.
    and #$07                        ;Check if result is a multiple of 8. If so, branch to-->
    bne Lx150                       ;Only call crash detection every 8th pixel.
        jsr CheckMoveUp                 ;($E7A2)Check if Samus obstructed UPWARDS.-->
        bcc Lx156                     ;If so, branch to exit(can't move any further).
    Lx150:
    lda ObjAction                   ;
    cmp #sa_Elevator                ;Is Samus riding elevator?-->
    beq Lx151                           ;If so, branch.
        jsr SamusOnElevatorOrEnemy      ;($D976)Calculate if Samus standing on elevator or enemy.
        lda SamusHit
        and #$42
        cmp #$42
        clc
        beq Lx156
    Lx151:
    lda SamusScrY
    cmp #$66        ; reached up scroll limit?
    bcs Lx152      ; branch if not
        jsr ScrollUp
        bcc Lx153
    Lx152:
        dec SamusScrY
    Lx153:
    lda ObjectY
    bne Lx155
        lda ScrollDir
        and #$02
        bne Lx154
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        Lx154:
        lda #240
        sta ObjectY
    Lx155:
    dec ObjectY
    inc SamusJumpDsplcmnt
    sec
Lx156:
    rts

; attempt to move Samus one pixel down

MoveSamusDown:
    lda ObjectY
    clc
    adc ObjRadY
    and #$07
    bne Lx157              ; only call crash detection every 8th pixel
        jsr CheckMoveDown       ; check if Samus obstructed DOWNWARDS
        bcc Lx163      ; exit if yes
    Lx157:
    lda ObjAction
    cmp #sa_Elevator        ; is Samus in elevator?
    beq Lx158
        jsr SamusOnElevatorOrEnemy
        lda SamusOnElevator
        clc
        bne Lx163
        lda OnFrozenEnemy
        bne Lx163
    Lx158:
    lda SamusScrY
    cmp #$84        ; reached down scroll limit?
    bcc Lx159      ; branch if not
        jsr ScrollDown
        bcc Lx160
    Lx159:
        inc SamusScrY
    Lx160:
    lda ObjectY
    cmp #239
    bne Lx162
        lda ScrollDir
        and #$02
        bne Lx161
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        Lx161:
        lda #$FF
        sta ObjectY
    Lx162:
    inc ObjectY
    dec SamusJumpDsplcmnt
    sec
Lx163:
    rts

; Attempt to scroll UP

ScrollUp:
    lda ScrollDir
    beq Lx164
        cmp #$01
        bne Lx167
        dec ScrollDir
        lda ScrollY
        beq Lx164
        dec MapPosY
    Lx164:
    ldx ScrollY
    bne Lx165
        dec MapPosY     ; decrement MapY
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs Lx166   ; if function returns CF = 1, moving up is not possible
        jsr LE9B7       ; switch to the opposite Name Table
        ldx #240        ; new Y coord
    Lx165:
    dex
    jmp LE53F
Lx166:
    inc MapPosY
Lx167:
    sec
    rts

; Attempt to scroll DOWN

ScrollDown:
    ldx ScrollDir
    dex
    beq Lx168
        bpl Lx172
        inc ScrollDir
        lda ScrollY
        beq Lx168
        inc MapPosY
    Lx168:
    lda ScrollY
    bne Lx169
        inc MapPosY     ; increment MapY
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs Lx171   ; if function returns CF = 1, moving down is not possible
    Lx169:
    ldx ScrollY
    cpx #239
    bne Lx170
        jsr LE9B7       ; switch to the opposite Name Table
        ldx #$FF
    Lx170:
    inx
LE53F:
    stx ScrollY
    jsr LE54A       ; check if it's time to update Name Table
    clc
    rts
Lx171:
    dec MapPosY
Lx172:
    sec
Lx173:
    rts

LE54A:
    jsr SetupRoom
    ldx RoomNumber
    inx
    bne Lx173
    lda ScrollDir
    and #$02
    bne Lx174
        jmp LE571
    Lx174:
    jmp LE701

Table11:
    .byte $07
    .byte $00

;---------------------------------[ Get PPU and RoomRAM addresses ]----------------------------------

PPUAddrs:
LE560:  .byte $20                       ;High byte of nametable #0(PPU).
LE561:  .byte $2C                       ;High byte of nametable #3(PPU)

WRAMAddrs:
LE562:  .byte $60                       ;High byte of RoomRAMA(cart RAM).
LE563:  .byte $64                       ;High byte of RoomRAMB(cart RAM).

GetNameAddrs:
LE564:  jsr GetNameTable                ;($EB85)Get current name table number.
LE567:  and #$01                        ;Update name table 0 or 3.
LE569:  tay                             ;
LE56A:  lda PPUAddrs,y                  ;Get high PPU addr of nametable(dest).
LE56D:  ldx WRAMAddrs,y                 ;Get high cart RAM addr of nametable(src).
LE570:  rts                             ;

;----------------------------------------------------------------------------------------------------

; check if it's time to update nametable (when scrolling is VERTICAL)

LE571:
    ldx ScrollDir
    lda ScrollY
    and #$07        ; compare value = 0 if ScrollDir = down, else 7
    cmp Table11,x
    bne Lx173     ; exit if not equal (no nametable update)

LE57C:
    ldx ScrollDir                   ;
    cpx TempScrollDir               ;Still scrolling same direction when room was loaded?-->
    bne Lx173                          ;If not, branch to exit.
    lda ScrollY
    and #$F8        ; keep upper 5 bits
    sta $00
    lda #$00
    asl $00
    rol
    asl $00
    rol

LE590:
    sta $01  ; $0001 = (ScrollY & 0xF8) << 2 = row offset
    jsr GetNameAddrs
    ora $01
    sta $03
    txa
    ora $01
    sta $01
    lda $00
    sta $02
    lda ScrollDir
    lsr             ; A = 0 if vertical scrolling, 1 if horizontal
    tax
    lda Table01,x
    sta $04
    ldy #$01
    sty PPUDataPending      ; data pending = YES
    dey
    ldx PPUStrIndex
    lda $03
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda $02
    jsr WritePPUByte
    lda $04
    jsr SeparateControlBits         ;($C3C6)
    Lx175:
        lda ($00),y
        jsr WritePPUByte
        sty $06
        ldy #$01        ; WRAM pointer increment = 1...
        bit $04  ; ... if bit 7 (PPU inc) of $04 clear
        bpl Lx176
            ldy #$20        ; else ptr inc = 32
        Lx176:
        jsr AddYToPtr00                 ;($C2A8)
        ldy $06
        dec $05
    bne Lx175
    stx PPUStrIndex
    jsr EndPPUString

Table01:
    .byte $20                       ;Horizontal write. PPU inc = 1, length = 32 tiles.
    .byte $9E                       ;Vertical write... PPU inc = 32, length = 30 tiles.

;---------------------------------[Write PPU attribute table data ]----------------------------------

WritePPUAttribTbl:
    ldx #$C0                        ;Low byte of First row of attribute table.
    lda RoomNumber                  ;
    cmp #$F2                        ;Is this the second pass through the routine?-->
    beq LE5EC                       ;If so, branch.
        ldx #$E0                        ;Low byte of second row of attribute table.
    LE5EC:
    stx $00                         ;$0000=RoomRAM atrrib table starting address.
    stx $02                         ;$0002=PPU attrib table starting address.
    jsr GetNameAddrs                ;($E564)Get name table addr and corresponding RoomRAM addr.
    ora #$03                        ;#$23 for attrib table 0, #$2F for attrib table 3.
    sta $03                         ;Store results.
    txa                             ;move high byte of RoomRAM to A.
    ora #$03                        ;#$63 for RoomRAMA, #$67 for RoomRAMB(Attrib tables).
    sta $01                         ;Store results.
    lda #$01                        ;
    sta PPUDataPending              ;Data pending = YES.
    ldx PPUStrIndex                 ;Load current index into PPU strng to append data.
    lda $03                         ;Store high byte of starting address(attrib table).
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda $02                         ;Store low byte of starting address(attrib table).
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda #$20                        ;Length of data to write(1 row of attrib data).
    sta $04                         ;
    jsr WritePPUByte                ;($C36B)Write control byte. Horizontal write.
    ldy #$00                        ;Reset index into data string.
    LE616:
        lda ($00),y                     ;Get data byte.
        jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
        iny                             ;Increment to next attrib data byte.
        dec $04                         ;
        bne LE616                           ;Loop until all attrib data loaded into PPU.
    stx PPUStrIndex                 ;Store updated PPU string index.
    jsr EndPPUString                ;($C376)Append end marker(#$00) and exit writing routines.

;----------------------------------------------------------------------------------------------------

; attempt to move Samus one pixel left

MoveSamusLeft:
LE626:
    lda ObjectX
    sec
    sbc ObjRadX
    and #$07
    bne Lx177              ; only call crash detection every 8th pixel
        jsr CheckMoveLeft       ; check if player is obstructed to the LEFT
        bcc Lx181        ; branch if yes! (CF = 0)
    Lx177:
    jsr SamusOnElevatorOrEnemy
    lda SamusHit
    and #$41
    cmp #$41
    clc
    beq Lx181
    lda SamusScrX
    cmp #$71        ; reached left scroll limit?
    bcs Lx178      ; branch if not
        jsr ScrollLeft
        bcc Lx179
    Lx178:
        dec SamusScrX
    Lx179:
    lda ObjectX
    bne Lx180
        lda ScrollDir
        and #$02
        beq Lx180
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
    Lx180:
    dec ObjectX
    sec
    rts

; crash with object on the left
Lx181:
    lda #$00
    sta SamusDoorData
    rts

; attempt to move Samus one pixel right

MoveSamusRight:
    lda ObjectX
    clc
    adc ObjRadX
    and #$07
    bne Lx182              ; only call crash detection every 8th pixel
        jsr CheckMoveRight      ; check if Samus is obstructed to the RIGHT
        bcc Lx186       ; branch if yes! (CF = 0)
    Lx182:
    jsr SamusOnElevatorOrEnemy
    lda SamusHit
    and #$41
    cmp #$40
    clc
    beq Lx186
    lda SamusScrX
    cmp #$8F        ; reached right scroll limit?
    bcc Lx183      ; branch if not
        jsr ScrollRight
        bcc Lx184
    Lx183:
        inc SamusScrX
    Lx184:
    inc ObjectX      ; go right, Samus!
    bne Lx185
        lda ScrollDir
        and #$02
        beq Lx185
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
    Lx185:
    sec
    rts

; crash with object on the right
Lx186:
    lda #$00
    sta SamusDoorData
    rts

; Attempt to scroll LEFT

ScrollLeft:
    lda ScrollDir
    cmp #$02
    beq Lx187
        cmp #$03
        bne Lx190
        dec ScrollDir
        lda ScrollX
        beq Lx187
        dec MapPosX
    Lx187:
    lda ScrollX
    bne Lx188
        dec MapPosX     ; decrement MapX
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs Lx189  ; if function returns CF=1, scrolling left is not possible
        jsr LE9B7       ; switch to the opposite Name Table
    Lx188:
    dec ScrollX
    jsr LE54A       ; check if it's time to update Name Table
    clc
    rts
Lx189:
    inc MapPosX
Lx190:
    sec
    rts

; Attempt to scroll RIGHT

ScrollRight:
    lda ScrollDir
    cmp #$03
    beq Lx191
        cmp #$02
        bne Lx195
        inc ScrollDir
        lda ScrollX
        beq Lx191
        inc MapPosX
    Lx191:
    lda ScrollX
    bne Lx192
        inc MapPosX
        jsr GetRoomNum  ; put room # at current map pos in $5A
        bcs Lx194   ; if function returns CF=1, scrolling right is not possible
    Lx192:
    inc ScrollX
    bne Lx193
        jsr LE9B7       ; switch to the opposite Name Table
    Lx193:
    jsr LE54A       ; check if it's time to update Name Table
    clc
    rts
Lx194:
    dec MapPosX
Lx195:
    sec
Lx196:
    rts

Table02:
        .byte $07,$00

; check if it's time to update nametable (when scrolling is HORIZONTAL)

LE701:
    ldx ScrollDir
    lda ScrollX
    and #$07        ; keep lower 3 bits
    cmp Table02-2,x ; compare value = 0 if ScrollDir = right, else 7
    bne Lx196      ; exit if not equal (no nametable update)

LE70C:
    ldx ScrollDir
    cpx TempScrollDir
    bne Lx196
    lda ScrollX
    and #$F8        ; keep upper five bits
    jsr Adiv8       ; / 8 (make 'em lower five)
    sta $00
    lda #$00
    jmp LE590

;---------------------------------------[ Get room number ]-------------------------------------------

;Gets room number at current map position. Sets carry flag if room # at map position is FF.
;If valid room number, the room number is stored in $5A.

GetRoomNum:
    lda ScrollDir                   ;
    lsr                             ;Branch if scrolling vertical.
    beq LE733                           ;

    rol                             ;Restore value of a
    adc #$FF                        ;A=#$01 if scrolling left, A=#$02 if scrolling right.
    pha                             ;Save A.
    jsr OnNameTable0                ;($EC93)Y=1 if name table=0, Y=0 if name table=3.
    pla                             ;Restore A.
    and $006C,y                     ;
    sec                             ;
    bne LE76F                       ;Can't load room, a door is in the way. This has the-->
                                        ;effect of stopping the scrolling until Samus walks-->
                                        ;through the door(horizontal scrolling only).

LE733:
    lda MapPosY                     ;Map pos y.
    jsr Amul16                      ;($C2C5)Multiply by 16.
    sta $00                         ;Store multiplied value in $00.
    lda #$00                        ;
    rol                             ;Save carry, if any.
    rol $00                         ;Multiply value in $00 by 2.
    rol                             ;Save carry, if any.
    sta $01                         ;
    lda $00                         ;
    adc MapPosX                     ;Add map pos X to A.
    sta $00                         ;Store result.
    lda $01                         ;
    adc #$70                        ;Add #$7000 to result.
    sta $01                         ;$0000 = (MapY*32)+MapX+#$7000.
    ldy #$00                        ;
    lda ($00),y                     ;Load room number.
    cmp #$FF                        ;Is it unused?-->
    beq LE76F                        ;If so, branch to exit with carry flag set.

    sta RoomNumber                  ;Store room number.

    LE758:
        cmp $95D0,y                     ;Is it a special room?-->
        beq LE76A                           ;If so, branch to set flag to play item room music.
        iny                             ;
        cpy #$07                        ;
        bne LE758                           ;Loop until all special room numbers are checked.

    lda ItemRoomMusicStatus         ;Load item room music status.
    beq LE76C                          ;Branch if not in special room.
    lda #$80                        ;Ptop playing item room music after next music start.
    bne LE76C                          ;Branch always.

LE76A:
    lda #$01                        ;Start item room music on next music start.
LE76C:
    sta ItemRoomMusicStatus         ;
    clc                             ;Clear carry flag. was able to get room number.
LE76F:
    rts                             ;

;-----------------------------------------------------------------------------------------------------

EnemyCheckMoveUp:
    ldx PageIndex
    lda EnRadY,x
    clc
    adc #$08
    jmp LE783

EnemyCheckMoveDown:
    ldx PageIndex
    lda #$00
    sec
    sbc EnRadY,x
    ; fallthrough

LE783:
    sta $02
    lda #$08
    sta $04
    jsr StoreEnemyPositionToTemp
    lda EnRadX,x
    jmp LE7BD

StoreEnemyPositionToTemp:
    lda EnXRoomPos,x
    sta $09     ; X coord
    lda EnYRoomPos,x
    sta $08     ; Y coord
    lda EnNameTable,x
    sta $0B     ; hi coord
    rts

CheckMoveUp:; For Samus, et al
    ldx PageIndex
    lda ObjRadY,x
    clc
    adc #$08
    jmp Lx197

CheckMoveDown: ; For Samus
    ldx PageIndex
    lda #$00
    sec
    sbc ObjRadY,x
Lx197:
    sta $02
    jsr LE8BE
    lda ObjRadX,x

LE7BD:
    bne Lx198
        sec
        rts
    Lx198:
    sta $03
    tay
    ldx #$00
    lda $09
    sec
    sbc $03
    and #$07
    beq Lx199
        inx
    Lx199:
    jsr LE8CE
    sta $04
    jsr LE90F
    ldx #$00
    ldy #$08
    lda $00
LE7DE:
    bne Lx202
    stx $06
    sty $07
    ldx $04

; object<-->background crash detection

LE7E6:
    jsr MakeCartRAMPtr              ;($E96A)Find object position in room RAM.
    ldy #$00
    lda ($04),y     ; get tile value
    cmp #$4E
    beq LE81E
    jsr GotoLA142
    jsr LD651
    bcc Exit16      ; CF = 0 if tile # < $80 (solid tile)... CRASH!!!
    cmp #$A0        ; is tile >= A0h? (walkable tile)
    bcs IsWalkableTile
    jmp IsBlastTile  ; tile is $80-$9F (blastable tiles)

IsWalkableTile:
    ldy IsSamus
    beq Lx201
; special case for Samus
    dey          ; = 0
    sty SamusDoorData
    cmp #$A0        ; crash with tile #$A0? (scroll toggling door)
    beq Lx200
    cmp #$A1        ; crash with tile #$A1? (horizontal scrolling door)
    bne Lx201
    inc SamusDoorData
Lx200:
    inc SamusDoorData
Lx201:
    dex
    beq Lx202
    jsr LE98E
    jmp LE7E6
Lx202:
    sec          ; no crash
Exit16:
    rts

LE81E:
    ldx UpdatingProjectile
    beq ClcExit
    ldx #$06
    Lx203:
        lda $05
        eor $5D,x
        and #$04
        bne Lx206
        lda $04
        eor $5C,x
        and #$1F
        bne Lx206
        txa
        jsr Amul8       ; * 8
        ora #$80
        tay
        lda ObjAction,y
        beq Lx206
        lda $0307,y
        lsr
        bcs Lx205
            ldx PageIndex
            lda ObjAction,x
            eor #$0B
            beq Lx204
                lda ObjAction,x
                eor #$04
                bne PlaySnd4
                lda AnimResetIndex,x
                eor #$91
                bne PlaySnd4
            Lx204:
            lda $0683
            ora #$02
            sta $0683
        Lx205:
        lda #$04
        sta SamusHit,y
        bne ClcExit
    Lx206:
        dex
        dex
    bpl Lx203
    lda $04
    jsr Adiv8       ; / 8
    and #$01
    tax
    inc $0366,x

ClcExit:
    clc
    rts

PlaySnd4:
    jmp SFX_Metal

CheckMoveLeft:
    ldx PageIndex
    lda ObjRadX,x
    clc
    adc #$08
    jmp Lx207

CheckMoveRight:
    ldx PageIndex
    lda #$00
    sec
    sbc ObjRadX,x
    ; fallthrough

Lx207:
    sta $03
    jsr LE8BE
    ldy ObjRadY,x

LE89B:
    bne Lx208
        sec
        rts
    Lx208:
    sty $02
    ldx #$00
    lda $08
    sec
    sbc $02
    and #$07
    beq Lx209
        inx
    Lx209:
    jsr LE8CE
    sta $04
    jsr LE90F
    ldx #$08
    ldy #$00
    lda $01
    jmp LE7DE

LE8BE:
    lda ObjectHi,x
    sta $0B
    lda ObjectY,x
    sta $08
    lda ObjectX,x
    sta $09
    rts

;--------------------------------------------------------
LE8CE:
    eor #$FF
    clc
    adc #$01
    and #$07
    sta $04
    tya
    asl
    sec
    sbc $04
    bcs Lx210
        adc #$08
    Lx210:
    tay
    lsr
    lsr
    lsr
    sta $04
    tya
    and #$07
    beq Lx211
        inx
    Lx211:
    txa
    clc
    adc $04
    rts
;-----------------------------------------------------------

EnemyCheckMoveLeft:
    ldx PageIndex
    lda EnRadX,x
    clc
    adc #$08
    jmp LE904

EnemyCheckMoveRight:
    ldx PageIndex
    lda #$00
    sec
    sbc EnRadX,x

LE904:
    sta $03
    jsr StoreEnemyPositionToTemp
    ldy EnRadY,x
    jmp LE89B

;----------------------------------------------
; $02 stores some sort of adjusted temp hitbox radius ?
LE90F:
    lda $02
    bpl Lx213
        jsr LE95F
        bcs Lx212
        cpx #$F0
        bcc Lx214
    Lx212:
        txa
        adc #$0F
        jmp LE934
    Lx213:
    jsr LE95F
    lda $08
    sec
    sbc $02
    tax
    and #$07
    sta $00
    bcs Lx214
        txa
        sbc #$0F
    LE934:
        tax
        lda ScrollDir
        and #$02
        bne Lx214
        inc $0B
    Lx214:
    stx $02
    ldx #$00
    lda $03
    bmi Lx215
        dex
    Lx215:
    lda $09
    sec
    sbc $03
    sta $03
    and #$07
    sta $01
    txa
    adc #$00
    beq Lx216
    lda ScrollDir
    and #$02
    beq Lx216
    inc $0B
Lx216:
    rts

;---------------------------------------------
LE95F:
    lda $08
    sec
    sbc $02
    tax
    and #$07
    sta $00
    rts

;------------------------------------[ Object pointer into cart RAM ]-------------------------------

;Find object's equivalent position in room RAM based on object's coordinates.
;In: $02 = ObjectY, $03 = ObjectX, $0B = ObjectHi. Out: $04 = cart RAM pointer.

MakeCartRAMPtr:
    lda #$18                        ;Set pointer to $6xxx(cart RAM).
    sta $05                         ;
    lda $02                         ;Object Y room position.
    and #$F8                        ;Drop 3 LSBs. Only use multiples of 8.
    asl                             ;
    rol $05                         ;
    asl                             ;Move upper 2 bits to lower 2 bits of $05 and move y bits-->
    rol $05                         ;3, 4, 5 to upper 3 bits of $04.
    sta $04                         ;
    lda $03                         ;Object X room position.
    lsr                             ;
    lsr                             ;
    lsr                             ;A=ObjectX/8.
    ora $04                         ;
    sta $04                         ;Put bits 0 thru 4 into $04.
    lda $0B                         ;Object nametable.
    asl                             ;
    asl                             ; A=ObjectHi*4.
    and #$04                        ;Set bit 2 if object is on nametable 3.
    ora $05                         ;
    sta $05                         ;Include nametable bit in $05.
    rts                             ;Return pointer in $04 = 01100HYY YYYXXXXX.

;---------------------------------------------------------------------------------------------------

LE98E:
    lda $02
    clc
    adc $06
    sta $02
    cmp #$F0
    bcc Lx217
    adc #$0F
    sta $02
    lda ScrollDir
    and #$02
    bne Lx217
    inc $0B
Lx217:
    lda $03
    clc
    adc $07
    sta $03
    bcc Lx218
    lda ScrollDir
    and #$02
    beq Lx218
    inc $0B
Lx218:
    rts

LE9B7:
    lda PPUCTRL_ZP
    eor #$03
    sta PPUCTRL_ZP
    rts

IsBlastTile:
    ldy UpdatingProjectile
    beq Exit18
LE9C2:
    tay
    jsr GotoLA0C6
    cpy #$98
    bcs Lx223
; attempt to find a vacant tile slot
    ldx #$C0
    Lx219:
        lda TileRoutine,x
        beq Lx220                           ; 0 = free slot
        jsr Xminus16
        bne Lx219
    lda TileRoutine,x
    bne Lx223                        ; no more slots, can't blast tile
Lx220:
    inc TileRoutine,x
    lda $04
    and #$DE
    sta TileWRAMLo,x
    lda $05
    sta TileWRAMHi,x
    lda InArea
    cmp #$11                        ; In Norfair?
    bne Lx221
    cpy #$76                        ; Special case for the four-small-bubbles breakable block
    bne Lx221
    lda #$04
    bne Lx222
Lx221:
    tya                             ; Destroyed block ID
    clc
    adc #$10
    and #$3C
    lsr
Lx222:
    lsr
    sta TileType,x
Lx223:
    clc
Exit18:
    rts

;------------------------------------------[ Select room RAM ]---------------------------------------

SelectRoomRAM:
    jsr GetNameTable                ;($EB85)Find name table to draw room on.
    asl                             ;
    asl                             ;
    ora #$60                        ;A=#$64 for name table 3, A=#$60 for name table 0.
    sta CartRAMPtr+1                ;
    lda #$00                        ;
    sta CartRAMPtr                  ;Save two byte pointer to start of proper room RAM.
    rts                             ;

;------------------------------------[ write attribute table data ]----------------------------------

AttribTableWrite:
    lda RoomNumber                  ;
    and #$0F                        ;Determine what row of PPU attribute table data, if any,-->
    inc RoomNumber                  ;to load from RoomRAM into PPU.
    jsr ChooseRoutine               ;Determine when to write to the PPU attribute table.
        .word ExitSub                   ;($C45C)Rts.
        .word WritePPUAttribTbl         ;($E5E2)Write first row of PPU attrib data.
        .word ExitSub                   ;($C45C)Rts.
        .word WritePPUAttribTbl         ;($E5E2)Write second row of PPU attrib data.
        .word RoomFinished              ;($EA26)Finished writing attribute table data.

;-----------------------------------[ Finished writing room data ]-----------------------------------

RoomFinished:
    lda #$FF                        ;No more tasks to perform on current room.-->
    sta RoomNumber                  ;Set RoomNumber to #$FF.
LEA2A:
    rts

;------------------------------------------[ Setup room ]--------------------------------------------

SetupRoom:
    lda RoomNumber                  ;Room number.
    cmp #$FF                        ;
    beq LEA2A                           ;Branch to exit if room is undefined.
    cmp #$FE                        ;
    beq LEA5D                           ;Branch if empty place holder byte found in room data.
    cmp #$F0                        ;
    bcs AttribTableWrite                          ;Branch if time to write PPU attribute table data.
    jsr UpdateRoomSpriteInfo        ;($EC9B)Update which sprite belongs on which name table.

    jsr ScanForItems                ;($ED98)Set up any special items.
    lda RoomNumber                  ;Room number to load.
    asl                             ;*2(for loading address of room pointer).
    tay                             ;
    lda (RoomPtrTable),y            ;Low byte of 16-bit room pointer.-->
    sta RoomPtr                     ;Base copied from $959A to $3B.
    iny                             ;
    lda (RoomPtrTable),y            ;High byte of 16-bit room pointer.-->
    sta RoomPtr+1                   ;Base copied from $959B to $3C.
    ldy #$00                        ;
    lda (RoomPtr),y                 ;First byte of room data.
    sta RoomPal                     ;store initial palette # to fill attrib table with.
    lda #$01                        ;
    jsr AddToRoomPtr                ;($EAC0)Increment room data pointer.
    jsr SelectRoomRAM               ;($EA05)Determine where to draw room in RAM, $6000 or $6400.
    jsr InitTables                  ;($EFF8)clear Name Table & do initial Attrib table setup.
LEA5D:
    jmp DrawRoom                    ;($EAAA)Load room contents into room RAM.

;---------------------------------------[ Draw room object ]-----------------------------------------

DrawObject:
    sta $0E                         ;Store object position byte(%yyyyxxxx).
    lda CartRAMPtr                  ;
    sta CartRAMWorkPtr              ;Set the working pointer equal to the room pointer-->
    lda CartRAMPtr+1                ;(start at beginning of the room).
    sta CartRAMWorkPtr+1            ;
    lda $0E                         ;Reload object position byte.
    jsr Adiv16                      ;($C2BF)/16. Lower nibble contains object y position.-->
    tax                             ;Transfer it to X, prepare for loop.
    beq LEA80                         ;Skip y position calculation loop as y position=0 and-->
                                        ;does not need to be calculated.
    LEA72:
        lda CartRAMWorkPtr              ;LoW byte of pointer working in room RAM.
        clc                             ;
        adc #$40                        ;Advance two rows in room RAM(one y unit).
        sta CartRAMWorkPtr              ;
        bcc LEA7D                           ;If carry occurred, increment high byte of pointer-->
            inc CartRAMWorkPtr+1            ;in room RAM.
        LEA7D:
        dex                             ;
        bne LEA72                          ;Repeat until at desired y position(X=0).

LEA80:
    lda $0E                         ;Reload object position byte.
    and #$0F                        ;Remove y position upper nibble.
    asl                             ;Each x unit is 2 tiles.
    adc CartRAMWorkPtr              ;
    sta CartRAMWorkPtr              ;Add x position to room RAM work pointer.
    bcc LEA8D                           ;If carry occurred, increment high byte of room RAM work-->
    inc CartRAMWorkPtr+1            ;pointer, else branch to draw object.

;CartRAMWorkPtr now points to the object's starting location (upper left corner)
;on the room RAM which will eventually be loaded into a name table.

LEA8D:
    iny                             ;Move to the next byte of room data which is-->
    lda (RoomPtr),y                 ;the index into the structure pointer table.
    tax                             ;Transfer structure pointer index into X.
    iny                             ;Move to the next byte of room data which is-->
    lda (RoomPtr),y                 ;the attrib table info for the structure.
    sta ObjectPal                   ;Save attribute table info.
    txa                             ;Restore structure pointer to A.
    asl                             ;*2. Structure pointers are two bytes in size.
    tay                             ;
    lda (StructPtrTable),y          ;Low byte of 16-bit structure ptr.
    sta StructPtr                   ;
    iny                             ;
    lda (StructPtrTable),y          ;High byte of 16-bit structure ptr.
    sta StructPtr+1                 ;
    jsr DrawStruct                  ;($EF8C)Draw one structure.
    lda #$03                        ;Move to next set of structure data.
    jsr AddToRoomPtr                ;($EAC0)Add A to room data pointer.

;-------------------------------------------[ Draw room ]--------------------------------------------

;The following function draws a room in the room RAM which is eventually loaded into a name table.

DrawRoom:
    ldy #$00                        ;Zero index.
    lda (RoomPtr),y                 ;Load byte of room data.-->
    cmp #$FF                        ;Is it #$FF(end-of-room)?-->
    beq EndOfRoom                   ;If so, branch to exit.
    cmp #$FE                        ;Place holder for empty room objects(not used).
    beq LEABC                           ;
        cmp #$FD                        ;is A=#$FD(end-of-objects)?-->
        bne DrawObject                  ;If not, branch to draw room object.-->
        beq EndOfObjs                   ;Else branch to set up enemies/doors.
    LEABC:
    sta RoomNumber                  ;Store #$FE if room object is empty.
    lda #$01                        ;Prepare to increment RoomPtr.

;-------------------------------------[ Add A to room pointer ]--------------------------------------

AddToRoomPtr:
    clc                             ;Prepare to add index in A to room pointer.
    adc RoomPtr                     ;
    sta RoomPtr                     ;
    bcc LEAC9                           ;Did carry occur? If not branch to exit.
        inc RoomPtr+1                   ;Increment high byte of room pointer if carry occured.
    LEAC9:
    rts                             ;

;----------------------------------------------------------------------------------------------------

EndOfObjs:
    lda RoomPtr                     ;
    sta $00                         ;Store room pointer in $0000.
    lda RoomPtr+1                   ;
    sta $01                         ;
    lda #$01                        ;Prepare to increment to enemy/door data.

EnemyLoop:
    jsr AddToPtr00                  ;($EF09)Add A to pointer at $0000.
    ldy #$00                        ;
    lda ($00),y                     ;Get first byte of enemy/door data.
    cmp #$FF                        ;End of enemy/door data?-->
    beq EndOfRoom                   ;If so, branch to finish room setup.
    and #$0F                        ;Discard upper four bits of data.
    jsr ChooseRoutine               ;Jump to proper enemy/door handling routine.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadEnemy                 ;($EB06)Room enemies.
        .word LoadDoor                  ;($EB8C)Room doors.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadElevator              ;($EC04)Elevator.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadStatues               ;($EC2F)Kraid & Ridley statues.
        .word ZebHole                   ;($EC57)Regenerating enemies(such as Zeb).

EndOfRoom:
    ldx #$F0                        ;Prepare for PPU attribute table write.
    stx RoomNumber                  ;
    lda ScrollDir                   ;
    sta TempScrollDir               ;Make temp copy of ScrollDir.
    and #$02                        ;Check if scrolling left or right.
    bne Lx224                           ;
        jmp LE57C
    Lx224:
    jmp LE70C

LoadEnemy:
    jsr GetEnemyData                ;($EB0C)Get enemy data from room data.
    jmp EnemyLoop                   ;($EAD4)Do next room object.

GetEnemyData:
    lda ($00),y                     ;Get 1st byte again.
    and #$F0                        ;Get object slot that enemy will occupy.
    tax                             ;
    jsr IsSlotTaken                 ;($EB7A)Check if object slot is already in use.
    bne Lx226                          ;Exit if object slot taken.
        iny                             ;
        lda ($00),y                     ;Get enemy type.
        jsr GetEnemyType                ;($EB28)Load data about enemy.
        ldy #$02                        ;
        lda ($00),y                     ;Get enemy initial position(%yyyyxxxx).
        jsr LEB4D
        pha
    Lx225:
        pla
Lx226:
    lda #$03                        ;Number of bytes to add to ptr to find next room item.
    rts                             ;

GetEnemyType:
LEB28:
    pha                             ;Store enemy type.
    and #$C0                        ;If MSB is set, the "tough" version of the enemy
    sta EnSpecialAttribs,x          ;is to be loaded(more hit points, except rippers).
    asl                             ;
    bpl Lx228                          ;If bit 6 is set, the enemy is either Kraid or Ridley.
        lda InArea                      ;Load current area Samus is in(to check if Kraid or-->
        and #$06                        ;Ridley is alive or dead).
        lsr                             ;Use InArea to find status of Kraid/Ridley statue.
        tay                             ;
        lda MaxMissiles,y               ;Load status of Kraid/Ridley statue.
        beq Lx227                           ;Branch if Kraid or Ridley needs to be loaded.
            pla                             ;
            pla                             ;Mini boss is dead so pull enemy info and last address off-->
            jmp Lx225                          ;stack so next enemy/door item can be loaded.
        Lx227:
        lda #$01                        ;Samus is in Kraid or Ridley's room and the-->
        sta KraidRidleyPresent          ;mini boss is alive and needs to be loaded.
    Lx228:
    pla                             ;Restore enemy type data.
    and #$3F                        ;Keep 6 lower bits to use as index for enemy data tables.
    sta EnDataIndex,x               ;Store index byte.
    rts                             ;

LEB4D:
    tay                             ;Save enemy position data in Y.
    and #$F0                        ;Extract Enemy y position.
    ora #$08                        ;Add 8 pixels to y position so enemy is always on screen.
    sta EnYRoomPos,x                ;Store enemy y position.
    tya                             ;Restore enemy position data.
    jsr Amul16                      ;*16 to extract enemy x position.
    ora #$0C                        ;Add 12 pixels to x position so enemy is always on screen.
    sta EnXRoomPos,x                ;Store enemy x position.
    lda #$01                        ;
    sta EnStatus,x                  ;Indicate object slot is taken.
    lda #$00
    sta EnData04,x
    jsr GetNameTable                ;($EB85)Get name table to place enemy on.
    sta EnNameTable,x               ;Store name table.
LEB6E:
    ldy EnDataIndex,x               ;Load A with index to enemy data.
    asl EnData05,x                     ;*2
    jsr LFB7B
    jmp LF85A

IsSlotTaken:
    lda EnStatus,x
    beq Lx229
        lda EnData05,x
        and #$02
    Lx229:
    rts

;------------------------------------------[ Get name table ]----------------------------------------

;The following routine is small but is called by several other routines so it is important and
;requires some explaining to understand its function.  First of all, as Samus moves from one room
;to the next, she is also moving from one name table to the next.  Samus does not move from one
;name table to the next as one might think. Samus moves diagonally through the name tables. To
;understand this concept, one must first know how the name tables are arranged.  They are arranged
;like so:
;
; +-----+-----+                                                  +-----+-----+
; |     |     | The following is an incorrect example of how     |     |     |
; |  2  |  3  | Samus goes from one name table to the next-----> |  2  |  3  |
; |     |     |                                                  |     |     |
; +-----+-----+                                                  +-----+-----+
; |     |     |                                                  |     |     |
; |  0  |  1  |                               INCORRECT!------>  |  0<-|->1  |
; |     |     |                                                  |     |     |
; +-----+-----+                                                  +-----+-----+
;
;The following are examples of how the name tables are properly traversed while walking through rooms:
;
;          +-----+-----+                                     +-----+-----+
;          |     |     |                                     |     |     |
;          |  2  | ->3 |                                     |  2  |  3<-|-+
;          |     |/    |                                     |     |     | |
;          +-----+-----+     <--------CORRECT!-------->      +-----+-----+ |
;          |    /|     |                                     |     |     | |
;          | 0<- |  1  |                                   +-|->0  |  1  | |
;          |     |     |                                   | |     |     | |
;          +-----+-----+                                   | +-----+-----+ |
;                                                          +---------------+
;
;The same diagonal traversal of the name tables illustrated above applies to vetricle traversal as
;well. Since Samus can only travel between 2 name tables and not 4, the name table placement for
;objects is simplified.  The following code determines which name table to use next:

GetNameTable:
    lda PPUCTRL_ZP                   ;
    eor ScrollDir                   ;Store #$01 if object should be loaded onto name table 3-->
    and #$01                        ;store #$00 if it should be loaded onto name table 0.
    rts                             ;

;----------------------------------------------------------------------------------------------------

; LoadDoor
; ========

LoadDoor:
    jsr LEB92
Lx230:
    jmp EnemyLoop    ; do next room object

LEB92:
    iny
    lda ($00),y     ; door info byte
    pha
    jsr Amul16      ; CF = door side (0=right, 1=left)
    php
    lda MapPosX
    clc
    adc MapPosY
    plp
    rol
    and #$03
    tay
    ldx $EC00,y
    pla          ; retrieve door info
    and #$03
    sta $0307,x     ; door palette
    tya
    pha
    lda $0307,x
    cmp #$01
    beq Lx232
    cmp #$03
    beq Lx232
    lda #$0A
    sta $09
    ldy MapPosX
    txa
    jsr Amul16       ; * 16
    bcc Lx231
        dey
    Lx231:
    tya
    jsr LEE41
    jsr CheckForItem
    bcs Lx233
    Lx232:
        lda #$01
        sta ObjAction,x
    Lx233:
    pla
    and #$01        ; A = door side (0=right, 1=left)
    tay
    jsr GetNameTable                ;($EB85)
    sta ObjectHi,x
    lda DoorXs,y    ; get door's X coordinate
    sta ObjectX,x
    lda #$68        ; door Y coord is always #$68
    sta ObjectY,x
    lda LEBFE,y
    tay
    jsr GetNameTable                ;($EB85)
    eor #$01
    tax
    tya
    ora DoorOnNameTable3,x
    sta DoorOnNameTable3,x
    lda #$02
    rts

DoorXs:
    .byte $F0        ; X coord of RIGHT door
    .byte $10        ; X coord of LEFT door
LEBFE:
    .byte $02
    .byte $01
LEC00:
    .byte $80
    .byte $B0
    .byte $A0
    .byte $90

; LoadElevator
; ============

LoadElevator:
    jsr LEC09
    bne Lx230           ; branch always

LEC09:
    lda ElevatorStatus
    bne Lx234      ; exit if elevator already present
    iny
    lda ($00),y
    sta $032F
    ldy #$83
    sty $032D       ; elevator Y coord
    lda #$80
    sta $032E       ; elevator X coord
    jsr GetNameTable                ;($EB85)
    sta $032C       ; high Y coord
    lda #$23
    sta $0323       ; elevator frame
    inc ElevatorStatus              ;1
Lx234:
    lda #$02
    rts

; LoadStatues
; ===========

LoadStatues:
    jsr GetNameTable                ;($EB85)
    sta $036C
    lda #$40
    ldx RidleyStatueStatus
    bpl Lx235      ; branch if Ridley statue not hit
        lda #$30
    Lx235:
    sta $0370
    lda #$60
    ldx KraidStatueStatus
    bpl Lx236      ; branch if Kraid statue not hit
        lda #$50
    Lx236:
    sta $036F
    sty $54
    lda #$01
    sta $0360
Lx237:
    jmp EnemyLoop   ; do next room object

ZebHole:
LEC57:
    ldx #$20
    Lx238:
        txa
        sec
        sbc #$08
        bmi Lx239
        tax
        ldy $0728,x
        iny
        bne Lx238
    ldy #$00
    lda ($00),y
    and #$F0
    sta $0729,x
    iny
    lda ($00),y
    sta $0728,x
    iny
    lda ($00),y
    tay
    and #$F0
    ora #$08
    sta $072A,x
    tya
    jsr Amul16       ; * 16
    ora #$00
    sta $072B,x
    jsr GetNameTable                ;($EB85)
    sta $072C,x
Lx239:
    lda #$03
    bne Lx237

OnNameTable0:
LEC93:
    lda PPUCTRL_ZP                   ;
    eor #$01                        ;If currently on name table 0,-->
    and #$01                        ;return #$01. Else return #$00.
    tay                             ;
    rts                             ;

UpdateRoomSpriteInfo:
LEC9B:
    ldx ScrollDir
    dex
    ldy #$00
    jsr UpdateDoorData              ;($ED51)Update name table 0 door data.
    iny
    jsr UpdateDoorData              ;($ED51)Update name table 3 door data.
    ldx #$50
    jsr GetNameTable                ;($EB85)
    tay
    Lx240:
        tya
        eor EnNameTable,x
        lsr
        bcs Lx241
        lda EnData05,x
        and #$02
        bne Lx241
        sta EnStatus,x
    Lx241:
        jsr Xminus16
        bpl Lx240
    ldx #$18
    Lx242:
        tya
        eor $B3,x
        lsr
        bcs Lx243
            lda #$00
            sta $B0,x
        Lx243:
        txa
        sec
        sbc #$08
        tax
        bpl Lx242
    jsr LED65
    jsr LED5B
    jsr GetNameTable                ;(EB85)
    asl
    asl
    tay
    ldx #$C0
    Lx244:
        tya
        eor TileWRAMHi,x
        and #$04
        bne Lx245
            sta $0500,x
        Lx245:
        jsr Xminus16
        cmp #$F0
        bne Lx244
    tya
    lsr
    lsr
    tay
    ldx #$D0
    jsr LED7A
    ldx #$E0
    jsr LED7A
    ldx #$F0
    jsr LED7A
    tya
    sec
    sbc $032C
    bne Lx246
        sta ElevatorStatus
    Lx246:
    ldx #$1E
    Lx247:
        lda $0704,x
        bne Lx248
            lda #$FF
            sta $0700,x
        Lx248:
        txa
        sec
        sbc #$06
        tax
        bpl Lx247
    cpy $036C
    bne Lx249
        lda #$00
        sta $0360
    Lx249:
    ldx #$18
    Lx250:
        tya
        cmp $072C,x
        bne Lx251
            lda #$FF
            sta $0728,x
        Lx251:
        txa
        sec
        sbc #$08
        tax
        bpl Lx250
    ldx #$00
    jsr LED8C
    ldx #$08
    jsr LED8C
    jmp GotoL9C6F

UpdateDoorData:
    txa                             ;
    eor #$03                        ;
    and $006C,y                     ;Moves door info from one name table to the next-->
LED57:
    sta $006C,y                     ;when the room is transferred across name tables.
    rts                             ;

LED5B:
    jsr GetNameTable                ;($EB85)
    eor #$01
    tay
    lda #$00
    beq LED57
LED65:
    ldx #$B0
    Lx252:
        lda ObjAction,x
        beq Lx253
        lda ObjectOnScreen,x
        bne Lx253
        sta ObjAction,x
    Lx253:
        jsr Xminus16
        bmi Lx252
    rts

LED7A:
    lda ObjAction,x
    cmp #$05
    bcc Lx254
    tya
    eor ObjectHi,x
    lsr
    bcs Lx254
    sta ObjAction,x
Lx254:
    rts

LED8C:
    tya
    cmp PowerUpNameTable,x
    bne Exit11
    lda #$FF
    sta PowerUpType,x
Exit11:
    rts

;---------------------------------------[ Setup special items ]--------------------------------------

;The following routines look for special items on the game map and jump to
;the appropriate routine to handle those items.

ScanForItems:
    lda SpecItmsTable               ;Low byte of ptr to 1st item data.
    sta $00                         ;
    lda SpecItmsTable+1             ;High byte of ptr to 1st item data.

ScanOneItem:
    sta $01                         ;
    ldy #$00                        ;Index starts at #$00.
    lda ($00),y                     ;Load map Ypos of item.-->
    cmp MapPosY                     ;Does it equal Samus' Ypos on map?-->
    beq LEDBE                           ;If yes, check Xpos too.

    bcs Exit11                      ;Exit if item Y pos >  Samus Y Pos.
    iny                             ;
    lda ($00),y                     ;Low byte of ptr to next item data.
    tax                             ;
    iny                             ;
    and ($00),y                     ;AND with hi byte of item ptr.
    cmp #$FF                        ;if result is FFh, then this was the last item-->
    beq Exit11                      ;(item ptr = FFFF). Branch to exit.

    lda ($00),y                     ;High byte of ptr to next item data.
    stx $00                         ;Write low byte for next item.
    jmp ScanOneItem                 ;Process next item.

LEDBE:
    lda #$03                        ;Get ready to look at byte containing X pos.
    jsr AddToPtr00                  ;($EF09)Add 3 to pointer at $0000.

ScanItemX:
    ldy #$00                        ;
    lda ($00),y                     ;Load map Xpos of object.-->
    cmp MapPosX                     ;Does it equal Samus' Xpos on map?-->
    beq LEDD4                           ;If so, then load object.
    bcs Exit11                      ;Exit if item pos X > Samus Pos X.

    iny                             ;
    jsr AnotherItem                 ;($EF00)Check for another item on same Y pos.
    jmp ScanItemX                   ;Try next X coord.

LEDD4:
    lda #$02                        ;Move ahead two bytes to find item data.

ChooseHandlerRoutine:
    jsr AddToPtr00                  ;($EF09)Add A to pointer at $0000.
    ldy #$00                        ;
    lda ($00),y                     ;Object type
    and #$0F                        ;Object handling routine index stored in 4 LSBs.
    jsr ChooseRoutine               ;($C27C)Load proper handling routine from table below.
        .word ExitSub                   ;($C45C)rts.
        .word SqueeptHandler            ;($EDF8)Some squeepts.
        .word PowerUpHandler            ;($EDFE)power-ups.
        .word SpecEnemyHandler          ;($EE63)Special enemies(Mellows, Melias and Memus).
        .word ElevatorHandler           ;($EEA1)Elevators.
        .word CannonHandler             ;($EEA6)Mother brain room cannons.
        .word MotherBrainHandler        ;($EEAE)Mother brain.
        .word ZeebetiteHandler          ;($EECA)Zeebetites.
        .word RinkaSpawnerHandler       ;($EEEE)Rinkas.
        .word DoorHandler               ;($EEF4)Some doors.
        .word PaletteHandler            ;($EEFA)Background palette change.

;---------------------------------------[ Squeept handler ]------------------------------------------

SqueeptHandler:
    jsr GetEnemyData                ;($EB0C)Load Squeept data.
LEDFB:
    jmp ChooseHandlerRoutine        ;($EDD6)Exit handler routines.

;--------------------------------------[ Power-up Handler ]------------------------------------------

PowerUpHandler:
    iny                             ;Prepare to store item type.
    ldx #$00                        ;
    lda #$FF                        ;
    cmp PowerUpType                 ;Is first power-up item slot available?-->
    beq LEE0F                           ;if yes, branch to load item.
        ldx #$08                        ;Prepare to check second power-up item slot.
        cmp PowerUpBType                ;Is second power-up item slot available?-->
        bne LEE39                          ;If not, branch to exit.
    LEE0F:
    lda ($00),y                     ;Power-up item type.
    jsr PrepareItemID               ;($EE3D)Get unique item ID.
    jsr CheckForItem                ;($EE4A)Check if Samus already has item.
    bcs LEE39                           ;Samus already has item. do not load it.

    ldy #$02                        ;Prepare to load item coordinates.
    lda $09                         ;
    sta PowerUpType,x               ;Store power-up type in available item slot.
    lda ($00),y                     ;Load x and y screen positions of item.
    tay                             ;Save position data for later processing.
    and #$F0                        ;Extract Y coordinate.
    ora #$08                        ;+ 8 to find  Y coordinate center.
    sta PowerUpYCoord,x             ;Store center Y coord
    tya                             ;Reload position data.
    jsr Amul16                      ;($C2C5)*16. Move lower 4 bits to upper 4 bits.
    ora #$08                        ;+ 8 to find X coordinate center.
    sta PowerUpXCoord,x             ;Store center X coord
    jsr GetNameTable                ;($EB85)Get name table to place item on.
    sta PowerUpNameTable,x          ;Store name table Item is located on.

LEE39:
    lda #$03                        ;Get next data byte(Always #$00).
    bne LEDFB                         ;Branch always to exit handler routines.

PrepareItemID:
    sta $09                         ;Store item type.
    lda MapPosX                     ;

LEE41:
    sta $07                         ;Store item X coordinate.
    lda MapPosY                     ;
    sta $06                         ;Store item Y coordinate.
    jmp CreateItemID                ;($DC67)Get unique item ID.

CheckForItem:
    ldy NumberOfUniqueItems         ;
    beq LEE61                         ;Samus has no unique items. Load item and exit.
    LEE4F:
        lda $07                         ;
        cmp NumberOfUniqueItems,y       ;Look for lower byte of unique item.
        bne LEE5D                           ;
        lda $06                         ;Look for upper byte of unique item.
        cmp DataSlot,y                  ;
        beq LEE62                         ;Samus already has item. Branch to exit.
    LEE5D:
        dey                             ;
        dey                             ;
        bne LEE4F                          ;Loop until all Samus' unique items are checked.
LEE61:
    clc                             ;Samus does not have the item. It will be placed on screen.
LEE62:
    rts                             ;

;-----------------------------------------------------------------------------------------------------

SpecEnemyHandler:
    ldx #$18
    lda RandomNumber1
    adc FrameCount
    sta $8A
    Lx255:
        jsr LEE86
        txa
        sec
        sbc #$08
        tax
        bpl Lx255
    lda $95E4
    sta $6BE9
    sta $6BEA
    lda #$01
    sta $6BE4
Lx256:
    jmp ChooseHandlerRoutine        ;($EDD6)Exit handler routines.

LEE86:
    lda $B0,x
    bne Lx257
    txa
    adc $8A
    and #$7F
    sta $B1,x
    adc RandomNumber2
    sta $B2,x
    jsr GetNameTable                ;($EB85)
    sta $B3,x
    lda #$01
    sta $B0,x
    rol $8A
Lx257:
    rts

ElevatorHandler:
    jsr LEC09
    bne Lx256                          ;Branch always.

CannonHandler:
    jsr GotoCannonRoutine
    lda #$02
Lx258:  jmp ChooseHandlerRoutine        ;($EDD6)Exit handler routines.

MotherBrainHandler:
    jsr GotoMotherBrainRoutine
    lda #$38
    sta $07
    lda #$00
    sta $06
    jsr CheckForItem
    bcc LEEC6
        lda #$08
        sta MotherBrainStatus
        lda #$00
        sta MotherBrainHits
    LEEC6:
    lda #$01
    bne Lx258

ZeebetiteHandler:
    jsr GotoZebetiteRoutine
    txa
    lsr
    adc #$3C
    sta $07
    lda #$00
    sta $06
    jsr CheckForItem
    bcc Lx259
    lda #$81
    sta $0758,x
    lda #$01
    sta $075D,x
    lda #$07
    sta $075B,x
Lx259:
    jmp LEEC6

RinkaSpawnerHandler:
    jsr GotoRinkaSpawnerRoutine
    jmp LEEC6

DoorHandler:
    jsr LEB92
    jmp ChooseHandlerRoutine        ;($EDD6)Exit handler routines.

PaletteHandler:
    lda ScrollDir
    sta $91
    bne LEEC6

AnotherItem:
    lda ($00),y                     ;Is there another item with same Y pos?-->
    cmp #$FF                        ;If so, A is amount to add to ptr. to find X pos.
    bne AddToPtr00                  ;($EF09)
    pla                             ;
    pla                             ;No more items to check. Pull last subroutine-->
    rts                             ;off stack and exit.

AddToPtr00:
    clc                             ;
    adc $00                         ;
    sta $00                         ;A is added to the 16 bit address stored in $0000.
    bcc Lx260                           ;
        inc $01                         ;
    Lx260:
    rts                             ;

;----------------------------------[ Draw structure routines ]----------------------------------------

;Draws one row of the structure.
;A = number of 2x2 tile macros to draw horizontally.

DrawStructRow:
    and #$0F                        ;Row length(in macros). Range #$00 thru #$0F.
    bne LEF19                           ;
    lda #$10                        ;#$00 in row length=16.
LEF19:
    sta $0E                         ;Store horizontal macro count.
    lda (StructPtr),y               ;Get length byte again.
    jsr Adiv16                      ;($C2BF)/16. Upper nibble contains x coord offset(if any).
    asl                             ;*2, because a macro is 2 tiles wide.
    adc CartRAMWorkPtr              ;Add x coord offset to CartRAMWorkPtr and save in $00.
    sta $00                         ;
    lda #$00                        ;
    adc CartRAMWorkPtr+1            ;Save high byte of work pointer in $01.
    sta $01                         ;$0000 = work pointer.

DrawMacro:
    lda $01                         ;High byte of current location in room RAM.
    cmp #$63                        ;Check high byte of room RAM address for both room RAMs-->
    beq LEF38                           ;to see if the attribute table data for the room RAM has-->
    cmp #$67                        ;been reached.  If so, branch to check lower byte as well.
    bcc LEF3F                          ;If not at end of room RAM, branch to draw macro.
    beq LEF38                           ;
    rts                             ;Return if have gone past room RAM(should never happen).

LEF38:
    lda $00                         ;Low byte of current nametable address.
    cmp #$A0                        ;Reached attrib table?-->
    bcc LEF3F                           ;If not, branch to draw the macro.
    rts                             ;Can't draw any more of the structure, exit.

LEF3F:
    inc $10                         ;Increase struct data index.
    ldy $10                         ;Load struct data index into Y.
    lda (StructPtr),y               ;Get macro number.
    asl                             ;
    asl                             ;A=macro number * 4. Each macro is 4 bytes long.
    sta $11                         ;Store macro index.
    ldx #$03                        ;Prepare to copy four tile numbers.
LEF4B:
    ldy $11                         ;Macro index loaded into Y.
    lda (MacroPtr),y                ;Get tile number.
    inc $11                         ;Increase macro index
    ldy TilePosTable,x              ;get tile position in macro.
    sta ($00),y                     ;Write tile number to room RAM.
    dex                             ;Done four tiles yet?-->
    bpl LEF4B                           ;If not, loop to do another.
    jsr UpdateAttrib                ;($EF9E)Update attribute table if necessary
    ldy #$02                        ;Macro width(in tiles).
    jsr AddYToPtr00                 ;($C2A8)Add 2 to pointer to move to next macro.
    lda $00                         ;Low byte of current room RAM work pointer.
    and #$1F                        ;Still room left in current row?-->
    bne LEF72                           ;If yes, branch to do another macro.

;End structure row early to prevent it from wrapping on to the next row..
    lda $10                         ;Struct index.
    clc                             ;
    adc $0E                         ;Add number of macros remaining in current row.
    sec                             ;
    sbc #$01                        ;-1 from macros remaining in current row.
    jmp AdvanceRow                  ;($EF78)Move to next row of structure.

LEF72:
    dec $0E                         ;Have all macros been drawn on this row?-->
    bne DrawMacro                   ;If not, branch to draw another macro.
    lda $10                         ;Load struct index.

AdvanceRow:
    sec                             ;Since carry bit is set,-->
    adc StructPtr                   ;addition will be one more than expected.
    sta StructPtr                   ;Update the struct pointer.
    bcc LEF81                           ;
        inc StructPtr+1                 ;Update high byte of struct pointer if carry occured.
    LEF81:
    lda #$40                        ;
    clc                             ;
    adc CartRAMWorkPtr              ;Advance to next macro row in room RAM(two tile rows).
    sta CartRAMWorkPtr              ;
    bcc DrawStruct                  ;Begin drawing next structure row.
    inc CartRAMWorkPtr+1            ;Increment high byte of pointer if necessary.

DrawStruct:
    ldy #$00                        ;Reset struct index.
    sty $10                         ;
    lda (StructPtr),y               ;Load data byte.
    cmp #$FF                        ;End-of-struct?-->
    beq LEF99                           ;If so, branch to exit.
    jmp DrawStructRow               ;($EF13)Draw a row of macros.
LEF99:
    rts                             ;

;The following table is used to draw macros in room RAM. Each macro is 2 x 2 tiles.
;The following table contains the offsets required to place the tiles in each macro.

TilePosTable:
    .byte $21                       ;Lower right tile.
    .byte $20                       ;Lower left tile.
    .byte $01                       ;Upper right tile.
    .byte $00                       ;Upper left tile.

;---------------------------------[ Update attribute table bits ]------------------------------------

;The following routine updates attribute bits for one 2x2 tile section on the screen.

UpdateAttrib:
    lda ObjectPal                   ;Load attribute data of structure.
    cmp RoomPal                     ;Is it the same as the room's default attribute data?-->
    beq LEFF3                       ;If so, no need to modify the attribute table, exit.

;Figure out cart RAM address of the byte containing the relevant bits.

    lda $00                         ;
    sta $02                         ;
    lda $01                         ;
    lsr                             ;
    ror $02                         ;
    lsr                             ;
    ror $02                         ;
    lda $02                         ;The following section of code calculates the-->
    and #$07                        ;proper attribute byte that corresponds to the-->
    sta $03                         ;macro that has just been placed in the room RAM.
    lda $02                         ;
    lsr                             ;
    lsr                             ;
    and #$38                        ;
    ora $03                         ;
    ora #$C0                        ;
    sta $02                         ;
    lda #$63                        ;
    sta $03                         ;$0002 contains pointer to attribute byte.

    ldx #$00                        ;
    bit $00                         ;
    bvc LEFCE                           ;
        ldx #$02                        ;The following section of code figures out which-->
    LEFCE:
    lda $00                         ;pair of bits to modify in the attribute table byte-->
    and #$02                        ;for the macro that has just been placed in the-->
    beq LEFD5                           ;room RAM.
        inx                             ;

;X now contains which macro attribute table bits to modify:
;+---+---+
;| 0 | 1 |
;+---+---+
;| 2 | 3 |
;+---+---+
;Where each box represents a macro(2x2 tiles).

;The following code clears the old attribute table bits and sets the new ones.
LEFD5:
    lda $01                         ;Load high byte of work pointer in room RAM.
    and #$04                        ;
    ora $03                         ;Choose proper attribute table associated with the-->
    sta $03                         ;current room RAM.
    lda AttribMaskTable,x           ;Choose appropriate attribute table bit mask from table below.
    ldy #$00                        ;
    and ($02),y                     ;clear the old attribute table bits.
    sta ($02),y                     ;
    lda ObjectPal                   ;Load new attribute table data(#$00 thru #$03).
    LEFE8:
        dex                             ;
        bmi LEFEF                           ;
        asl                             ;
        asl                             ;Attribute table bits shifted one step left
        bcc LEFE8                           ;Loop until attribute table bits are in the proper location.
LEFEF:
    ora ($02),y                     ;
    sta ($02),y                     ;Set attribute table bits.
LEFF3:
    rts                             ;

AttribMaskTable:
    .byte %11111100                 ;Upper left macro.
    .byte %11110011                 ;Upper right macro.
    .byte %11001111                 ;Lower left macro.
    .byte %00111111                 ;Lower right macro.

;------------------------[ Initialize room RAM and associated attribute table ]-----------------------

InitTables:
    lda CartRAMPtr+1                ;#$60 or #$64.
    tay                             ;
    tax                             ;Save value to create counter later.
    iny                             ;
    iny                             ;High byte of address to fill to ($63 or $67).
    iny                             ;
    lda #$FF                        ;Value to fill room RAM with.
    jsr FillRoomRAM                 ;($F01C)Fill entire RAM for designated room with #$FF.

    ldx $01                         ;#$5F or #$63 depening on which room RAM was initialized.
    jsr Xplus4                      ;($E193)X = X + 4.
    stx $01                         ;Set high byte for attribute table write(#$63 or #$67).
    ldx RoomPal                     ;Index into table below (Lowest 2 bits).
    lda ATDataTable,x               ;Load attribute table data from table below.
    ldy #$C0                        ;Low byte of start of all attribute tables.
    LF012:
        sta ($00),y                     ;Fill attribute table.
        iny                             ;
        bne LF012                           ;Loop until entire attribute table is filled.
    rts                             ;

ATDataTable:
    .byte %00000000                 ;
    .byte %01010101                 ;Data to fill attribute tables with.
    .byte %10101010                 ;
    .byte %11111111                 ;

FillRoomRAM:
    pha                             ;Temporarily store A.
    txa                             ;
    sty $01                         ;Calculate value to store in X to use as upper byte-->
    clc                             ;counter for initilaizing room RAM(X=#$FC).-->
    sbc $01                         ;Since carry bit is cleared, result is one less than expected.
    tax                             ;
    pla                             ;Restore value to fill room RAM with(#$FF).
    ldy #$00                        ;Lower address byte to start at.
    sty $00                         ;
    LF029:
        sta ($00),y                     ;
        dey                             ;
        bne LF029                           ;
        dec $01                         ;Loop until all the room RAM is filled with #$FF(black).
        inx                             ;
        bne LF029                           ;
    rts                             ;

;----------------------------------------------------------------------------------------------------

; Crash detection
; ===============

LF034:
    lda #$FF
    sta $73
    sta $010F
; check for crash with Memus
    ldx #$18
Lx261:
    lda $B0,x
    beq Lx266           ; branch if no Memu in slot
    cmp #$03
    beq Lx266
    jsr LF19A
    jsr IsSamusDead
    beq Lx262
    lda SamusBlink
    bne Lx262
    ldy #$00
    jsr LF149
    jsr LF2B4
; check for crash with bullets
Lx262:
    ldy #$D0
Lx263:
    lda ObjAction,y       ; projectile active?
    beq Lx265            ; try next one if not
    cmp #wa_BulletExplode
    bcc Lx264
    cmp #$07
    beq Lx264
    cmp #wa_BombExplode
    beq Lx264
    cmp #wa_Missile
    bne Lx265
Lx264:
    jsr LF149
    jsr LF32A
Lx265:
    jsr Yplus16
    bne Lx263
Lx266:
    txa
    sec
    sbc #$08                ; each Memu occupies 8 bytes
    tax
    bpl Lx261

    ldx #$B0
Lx267:
    lda ObjAction,x
    cmp #$02
    bne Lx268
    ldy #$00
    jsr IsSamusDead
    beq Lx269
    jsr AreObjectsTouching          ;($DC7F)
    jsr LF277
Lx268:
    jsr Xminus16
    bmi Lx267

; enemy <--> bullet/missile/bomb detection
Lx269:
    ldx #$50                ; start with enemy slot #5
LF09F:
    lda EnStatus,x       ; slot active?
    beq Lx270              ; branch if not
    cmp #$03
Lx270:
    beq NextEnemy      ; next slot
    jsr LF152
    lda EnStatus,x
    cmp #$05
    beq Lx274
    ldy #$D0                ; first projectile slot
Lx271:
    lda ObjAction,y  ; is it active?
    beq Lx273            ; branch if not
    cmp #wa_BulletExplode
    bcc Lx272
    cmp #$07
    beq Lx272
    cmp #wa_BombExplode
    beq Lx272
    cmp #wa_Missile
    bne Lx273
; check if enemy is actually hit
Lx272:
    jsr LF140
    jsr LF2CA
Lx273:
    jsr Yplus16          ; next projectile slot
    bne Lx271
Lx274:
    ldy #$00
    lda SamusBlink
    bne NextEnemy
    jsr IsSamusDead
    beq NextEnemy
    jsr LF140
    jsr LF282
    NextEnemy:
    jsr Xminus16
    bmi Lx275
    jmp LF09F
Lx275:
    ldx #$00
    jsr GetObject0CoordData
    ldy #$60
Lx276:
    lda EnStatus,y
    beq Lx277
    cmp #$05
    beq Lx277
    lda SamusBlink
    bne Lx277
    jsr IsSamusDead
    beq Lx277
    jsr DistFromObj0ToEn1
    jsr LF162
    jsr LF1FA
    jsr LF2ED
Lx277:
    jsr Yplus16
    cmp #$C0
    bne Lx276
    ldy #$00
    jsr IsSamusDead
    beq Lx281
    jsr GetObject1CoordData
    ldx #$F0
Lx278:
    lda ObjAction,x
    cmp #$07
    beq Lx279
    cmp #$0A
    bne Lx280
Lx279:
    jsr LDC82
    jsr LF311
Lx280:
    jsr Xminus16
    cmp #$C0
    bne Lx278
Lx281:
    jmp SubtractHealth              ;($CE92)

LF140:
    jsr DistFromEn0ToObj1
    jsr GetObject1CoordData
    jmp LF1FA

LF149:
    jsr GetObject1CoordData
    jsr LF1D2
    jmp LF1FA

LF152:
    lda EnYRoomPos,x
    sta $07  ; Y coord
    lda EnXRoomPos,x
    sta $09  ; X coord
    lda EnNameTable,x     ; hi coord
    jmp LF17F

LF162:
    lda EnYRoomPos,y     ; Y coord
    sta $06
    lda EnXRoomPos,y     ; X coord
    sta $08
    lda EnNameTable,y     ; hi coord
    jmp LF193

GetObject0CoordData:
    lda ObjectY,x
    sta $07
    lda ObjectX,x
    sta $09
    lda ObjectHi,x

LF17F:
    eor PPUCTRL_ZP
    and #$01
    sta $0B
    rts

GetObject1CoordData:
    lda ObjectY,y
    sta $06
    lda ObjectX,y
    sta $08
    lda ObjectHi,y

LF193:
    eor PPUCTRL_ZP
    and #$01
    sta $0A
    rts

LF19A:
    lda $B1,x
    sta $07
    lda $B2,x
    sta $09
    lda $B3,x
    jmp LF17F

DistFromObj0ToObj1:
    lda ObjRadY,x
    jsr AddObject1YRadius
    lda ObjRadX,x
    jmp AddObject1XRadius

DistFromObj0ToEn1:
    lda ObjRadY,x
    jsr LF1E7
    lda ObjRadX,x
    jmp AddEnemy1XRadius

DistFromEn0ToObj1:
    lda EnRadY,x
    jsr AddObject1YRadius
    lda EnRadX,x
    jmp AddObject1XRadius

AddEnemy1XRadius:
    clc
    adc EnRadX,y
    sta $05
    rts

LF1D2:
    lda #$04
    jsr AddObject1YRadius
    lda #$08

AddObject1XRadius:
    clc
    adc ObjRadX,y
    sta $05
    rts

AddObject1YRadius:
    clc
    adc ObjRadY,y
    sta $04
    rts

LF1E7:
    clc
    adc EnRadY,y
    sta $04
    rts

; Y = Y + 16

Yplus16:
    tya
    clc
    adc #$10
    tay
    rts

; X = X - 16

Xminus16:
    txa
    sec
    sbc #$10
    tax
    rts

LF1FA:
    lda #$02
    sta $10
    and ScrollDir
    sta $03
    lda $07                         ;Load object 0 y coord.
    sec                             ;
    sbc $06                         ;Subtract object 1 y coord.
    sta $00                         ;Store difference in $00.
    lda $03
    bne Lx283
    lda $0B
    eor $0A
    beq Lx283
    jsr LF262
    lda $00
    sec
    sbc #$10
    sta $00
    bcs Lx282
        dec $01
    Lx282:
    jmp LF22B
Lx283:
    lda #$00
    sbc #$00
    jsr LF266

LF22B:
    sec
    lda $01
    bne Lx285
    lda $00
    sta $11
    cmp $04
    bcs Lx285
    asl $10
    lda $09
    sec
    sbc $08
    sta $00
    lda $03
    beq Lx284
    lda $0B
    eor $0A
    beq Lx284
    jsr LF262
    jmp LF256
Lx284:
    sbc #$00
    jsr LF266
LF256:
    sec
    lda $01
    bne Lx285
    lda $00
    sta $0F
    cmp $05
Lx285:
    rts

LF262:
    lda $0B
    sbc $0A

LF266:
    sta $01
    bpl Lx286
    jsr LE449
    inc $10
Lx286:
    rts

LF270:
    ora SamusHit,x
    sta SamusHit,x
    rts

LF277:
    bcs Exit17
LF279:
    lda $10
LF27B:
    ora SamusHit,y
    sta SamusHit,y
    Exit17:
    rts

LF282:
    bcs Exit17
    jsr LF2E8
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    ldy #$00
    bcc Lx289
    lda EnStatus,x
    cmp #$04
    bcs Exit17
    lda EnDataIndex,x
Lx287:
    sta $010F
    tay
    bmi Lx288
        lda $968B,y
        and #$10
        bne Exit17
    Lx288:
    ldy #$00
    jsr LF338
    jmp LF306
Lx289:
    lda #$81
    sta EnData0E,x
    bne Lx291
LF2B4:
    bcs Lx290
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    ldy #$00
    lda #$C0
    bcs Lx287
LF2BF:
    lda $B6,x
    and #$F8
    ora $10
    eor #$03
    sta $B6,x
Lx290:
    rts

LF2CA:
    bcs Lx293
    lda ObjAction,y
    sta EnData0E,x
    jsr LF279
Lx291:
    jsr LF332
Lx292:
    ora EnData04,x
    sta EnData04,x
Lx293:
    rts

LF2DF:
    lda $10
    ora EnData04,y
    sta EnData04,y
    rts

LF2E8:
    jsr LF340
    bne Lx292
LF2ED:
    bcs Lx294
    jsr LF2DF
    tya
    pha
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    pla
    tay
    bcc Lx294
    lda #$80
    sta $010F
    jsr LF332
    jsr LF270
LF306:
    lda $95CE
    sta HealthLoChange
    lda $95CF
    sta HealthHiChange
Lx294:
    rts

LF311:
    bcs Exit22
    lda #$E0
    sta $010F
    jsr LF338
    lda $0F
    beq Lx295
    lda #$01
Lx295:
    sta $73

ClearHealthChange:
    lda #$00
    sta HealthLoChange
    sta HealthHiChange

Exit22:
    rts                             ;Return for routine above and below.

LF32A:  bcs Exit22
        jsr LF279
        jmp LF2BF

LF332:  jsr LF340
        jmp Amul8       ; * 8

LF338:  lda $10
        asl
        asl
        asl
        jmp LF27B

LF340:  lda $10
        eor #$03
        rts

;-------------------------------------------------------------------------------
UpdateEnemies: ; LF345
    ldx #$50                ;Load x with #$50
    @loop:
        jsr DoOneEnemy                  ;($F351)
        ldx PageIndex
        jsr Xminus16
        bne @loop
    ; After loop, DoOneEnemy for the case X=$00

;-------------------------------------------------------------------------------
DoOneEnemy: ;LF351
    stx PageIndex                   ;PageIndex starts at $50 and is subtracted by #$0F each-->
                                    ;iteration. There is a max of 6 enemies at a time.
    ldy EnStatus,x
    beq @label
    cpy #$03
    bcs @label
    jsr LF37F
@label:
    jsr LF3AA
    lda EnStatus,x
    sta $81
    cmp #$07
    bcs @kill
    jsr ChooseRoutine
        .word ExitSub ; 00 ($C45C) rts
        .word DoRestingEnemy ; 01 Resting (Offscreen or Inactive)
        .word DoActiveEnemy ; 02 Active
        .word LF40D ; 03 Exploding ?
        .word DoFrozenEnemy ; 04 Frozen
        .word DoEnemyPickup ; 05 Pickup
        .word DoHurtEnemy ; 06 Hurt

@kill:
    jmp KillObject                  ;($FA18)Free enemy data slot.

;-------------------------------------------------------------------------------
LF37F:
    lda EnData05,x
    and #$02
    bne Lx298
    ; Store Enemy Position/Hitbox to Temp
    lda EnYRoomPos,x     ; Y coord
    sta $0A
    lda EnXRoomPos,x     ; X coord
    sta $0B
    lda EnNameTable,x     ; hi coord
    sta $06
    lda EnRadY,x
    sta $08
    lda EnRadX,x
    sta $09
    jsr IsObjectVisible             ;($DFDF)Determine if object is within the screen boundaries.
    txa
    bne Lx298
    pla
    pla
Lx298:
    ldx PageIndex
    rts

LF3AA:
    lda EnData05,x
    asl
    rol
    tay
    txa
    jsr Adiv16                      ;($C2BF)/16.
    eor FrameCount
    lsr
    tya
    ror
    ror
    sta EnData05,x
    rts
;---------------------------------------------
DoRestingEnemy:
LF3BE:
    lda EnData05,x
    asl
    bmi Lx299
    lda #$00
    sta EnData1D,x
    sta EnCounter,x
    sta EnData0A,x
    jsr LF6B9
    jsr LF75B
    jsr LF682
    jsr LF676
    lda EnDelay,x
    beq Lx299
    jsr LF7BA
Lx299:
    jmp DoActiveEnemy_BranchB
;------------------------------------------
DoActiveEnemy: ; LF3E6
    ; Branch if bit 6 is set
    lda EnData05,x
    asl
    bmi DoActiveEnemy_BranchB

    ; Branch if bit 5 is set
    lda EnData05,x
    and #$20
    beq DoActiveEnemy_BranchA

    ; Set enemy delay
    ldy EnDataIndex,x
    lda EnemyInitDelayTbl,y ;($96BB)
    sta EnDelay,x
    ; Decrement status from active to resting
    dec EnStatus,x
    bne DoActiveEnemy_BranchB ; Branch always

DoActiveEnemy_BranchA: ; LF401
    jsr LF6B9
    jsr LF75B
    jsr LF51E
DoActiveEnemy_BranchB: ; LF40A
    jsr LF536
LF40D:
    jmp ChooseEnemyRoutine
;-------------------------------------------
; This procedure is called by a lot of enemy AI routines, with three different
;  entry points
; Entry Point 1 ; CommonJump_00
LF410:
    jsr UpdateEnemyAnim
    jsr $8058
; Entry Point 2 ; CommonJump_02
LF416:
    ldx PageIndex
    lda EnSpecialAttribs,x
    bpl Lx301
    lda ObjectCntrl
    bmi Lx301
    lda #$A3
LF423:
    sta ObjectCntrl
Lx301:
    lda EnStatus,x
    beq LF42D
        jsr LDD8B
    LF42D:
    ldx PageIndex
    lda #$00
    sta EnData04,x
    sta EnData0E,x
    rts

; Entry Point 3 ; CommonJump_01
LF438:
    jsr UpdateEnemyAnim
    jmp LF416
;-------------------------------------------
DoFrozenEnemy:
LF43E:
    jsr LF536
    lda EnStatus,x
    cmp #$03
    beq LF410
    bit ObjectCntrl
    bmi Lx302
        lda #$A1
        sta ObjectCntrl
    Lx302:
    lda FrameCount
    and #$07
    bne Lx303
    dec EnData0D,x
    bne Lx303
    lda EnStatus,x
    cmp #$03
    beq Lx303
    lda EnData0C,x
    sta EnStatus,x
    ldy EnDataIndex,x
    lda $969B,y
    sta EnData0D,x
Lx303:
    lda EnData0D,x
    cmp #$0B
    bcs Lx304
    lda FrameCount
    and #$02
    beq Lx304
    asl ObjectCntrl
Lx304:
    jmp LF416
;--------------------------------------
DoEnemyPickup:
LF483:
    lda EnData04,x
    and #$24
    beq Lx310
    jsr KillObject                  ;($FA18)Free enemy data slot.
    ldy EnAnimFrame,x
    cpy #$80
    beq PickupMissile
    tya
    pha
    lda EnDataIndex,x
    pha
    ldy #$00
    ldx #$03
    pla
    bne Lx306
    dex
    pla
    cmp #$81
    bne Lx305
    ldx #$00                        ;Increase HealthHi by 0.
    ldy #$50                        ;Increase HealthLo by 5.
Lx305:
    pha
Lx306:
    pla
    sty HealthLoChange
    stx HealthHiChange
    jsr AddHealth                   ;($CEF9)Add health to Samus.
    jmp SFX_EnergyPickup

PickupMissile:
    lda #$02
    ldy EnDataIndex,x
    beq Lx307
    lda #$1E
Lx307:
    clc
    adc MissileCount
    bcs Lx308              ; can't have more than 255 missiles
    cmp MaxMissiles  ; can Samus hold this many missiles?
    bcc Lx309            ; branch if yes
Lx308:
    lda MaxMissiles  ; set to max. # of missiles allowed
Lx309:
    sta MissileCount
    jmp SFX_MissilePickup
Lx310:
    lda FrameCount
    and #$03
    bne Lx311
    dec EnData0D,x
    bne Lx311
    jsr KillObject                  ;($FA18)Free enemy data slot.
Lx311:
    lda FrameCount
    and #$02
    lsr
    ora #$A0
    sta ObjectCntrl
    jmp LF416
;--------------------------------------------
DoHurtEnemy:
    dec EnSpecialAttribs,x
    bne Lx313
    ; Preserve upper two bits of EnSpecialAttribs
    lda EnData0C,x
    tay
    and #$C0
    sta EnSpecialAttribs,x
    tya

    and #$3F
    sta EnStatus,x
    pha
    jsr $80B0
    and #$20
    beq Lx312
        pla
        jsr LF515
        pha
    Lx312:
    pla
Lx313:
    lda #$A0
    jmp LF423

LF515:
    sta EnData0C,x
LF518:
    lda #$04
    sta EnStatus,x
    rts

;-------------------------------------------------------------------------------
LF51E:
    lda ScrollDir
    ldx PageIndex
    cmp #$02
    bcc Lx315
    lda EnYRoomPos,x     ; Y coord
    cmp #$EC
    bcc Lx315
    jmp KillObject                  ;($FA18)Free enemy data slot.

Lx314:
    jsr SFX_MetroidHit
    jmp GetPageIndex

;-------------------------------------------------------------------------------
LF536:
    lda EnSpecialAttribs,x
    sta $0A
    lda EnData04,x
    and #$20
    beq Lx315
    lda EnData0E,x
    cmp #$03
    bne Lx317
    bit $0A
    bvs Lx317
    lda EnStatus,x
    cmp #$04
    beq Lx317
    jsr LF515
    lda #$40
    sta EnData0D,x
    jsr $80B0
    and #$20
    beq Lx315
    lda #$05
    sta EnHitPoints,x
    jmp GotoLA320
Lx315:
    rts

Lx316:
    jsr $80B0
    and #$20
    bne Lx314
    jsr SFX_Metal
    jmp LF42D
Lx317:
    lda EnHitPoints,x
    cmp #$FF
    beq Lx316
    bit $0A
    bvc Lx318
        jsr SFX_BossHit
        bne Lx319
    Lx318:
    jsr ReadTableAt968B
    and #$0C
    beq PlaySnd1
    cmp #$04
    beq PlaySnd2
    cmp #$08
    beq PlaySnd3
    jsr SFX_MetroidHit
    bne Lx319       ; branch always
PlaySnd1:
    jsr SFX_EnemyHit
    bne Lx319       ; branch always
PlaySnd2:
    jsr SFX_EnemyHit
    bne Lx319       ; branch always
PlaySnd3:
    jsr SFX_BigEnemyHit             ;($CBCE)
Lx319:
    ldx PageIndex
    jsr $80B0
    and #$20
    beq Lx320
        lda EnData0E,x
        cmp #$0B
        bne Lx316
    Lx320:
    lda EnStatus,x
    cmp #$04
    bne Lx321
        lda EnData0C,x
    Lx321:
    ora $0A
    sta EnData0C,x
    asl
    bmi Lx322
    jsr $80B0
    and #$20
    bne Lx322
    ldy EnData0E,x
    cpy #$0B
    beq Lx326
    cpy #$81
    beq Lx326
Lx322:
    lda #$06
    sta EnStatus,x
    lda #$0A
    bit $0A
    bvc Lx323
        lda #$03
    Lx323:
    sta EnSpecialAttribs,x
    cpy #$02
    beq Lx324
        bit $0A
        bvc Lx325
        ldy EnData0E,x
        cpy #$0B
        bne Lx325
        dec EnHitPoints,x
        beq Lx326
        dec EnHitPoints,x
        beq Lx326
    Lx324:
    dec EnHitPoints,x
    beq Lx326
Lx325:
    dec EnHitPoints,x
    bne GetPageIndex
Lx326:
    lda #$03
    sta EnStatus,x
    bit $0A
    bvs Lx327
    lda EnData0E,x
    cmp #$02
    bcs Lx327
    lda #$00
    jsr LDCFC
    ldx PageIndex
Lx327:
    jsr LF844
    lda $960B,y
    jsr LF68D
    sta EnCounter,x
    ldx #$C0
    Lx328:
        lda EnStatus,x
        beq Lx329
        txa
        clc
        adc #$08
        tax
        cmp #$E0
        bne Lx328
    beq GetPageIndex
Lx329:
    lda $95DD
    jsr LF68D
    lda #$0A
    sta EnCounter,x
    inc EnStatus,x
    lda #$00
    bit $0A
    bvc Lx330
        lda #$03
    Lx330:
    sta $0407,x
    ldy PageIndex
    lda EnYRoomPos,y
    sta EnYRoomPos,x
    lda EnXRoomPos,y
    sta EnXRoomPos,x
    lda EnNameTable,y
    sta EnNameTable,x
    GetPageIndex:
    ldx PageIndex
    rts

LF676:
    jsr $80B0
    asl
    asl
    asl
    and #$C0
    sta EnData1F,x
    rts

LF682:
    jsr LF844
    lda $963B,y
    cmp EnResetAnimIndex,x
    beq Lx331
LF68D:
    sta EnResetAnimIndex,x
LF690:
    sta EnAnimIndex,x
LF693:
    lda #$00
    sta EnAnimDelay,x
Lx331:
    rts

LF699:
    jsr LF844
    lda $965B,y
    cmp EnResetAnimIndex,x
    beq Exit12
    jsr LF68D
    ldy EnDataIndex,x
    lda $967B,y
    and #$7F
    beq Exit12
    tay
    Lx332:
        dec EnAnimIndex,x
        dey
        bne Lx332
Exit12:
    rts

;-------------------------------------------------------------------------------
LF6B9:
    ; clear $82
    lda #$00
    sta $82
    jsr ReadTableAt968B
    tay

    ; branch if enemy is not active
    lda EnStatus,x
    cmp #$02
    bne Lx333

        ; if bit 1 of $968B[EnDataIndex] is not set, exit
        tya
        and #$02
        beq Exit12

    ; If enemy is not active or if bit 1 of $968B[EnDataIndex] is set
    Lx333:
    tya
    dec EnData0D,x
    bne Exit12

    pha
    ldy EnDataIndex,x
    lda $969B,y
    sta EnData0D,x
    pla
    bpl Lx337

    lda #$FE
    jsr LF7B3
    lda ScrollDir
    cmp #$02
    bcc Lx334

    jsr LF752
    bcc Lx334
    tya
    eor PPUCTRL_ZP
    bcs Lx336
Lx334:
    lda EnXRoomPos,x
    cmp ObjectX
    bne Lx335
        inc $82
    Lx335:
    rol
Lx336:
    and #$01
    jsr OrEnData05
    lsr
    ror
    eor EnData03,x
    bpl Lx337
    jsr $81DA
Lx337:
    lda #$FB
    jsr LF7B3
    lda ScrollDir
    cmp #$02
    bcs Lx338
    jsr LF752
    bcc Lx338
    tya
    eor PPUCTRL_ZP
    bcs Lx340
    Lx338:
        lda EnYRoomPos,x
        cmp ObjectY
        bne Lx339
            inc $82
            inc $82
        Lx339:
        rol
    Lx340:
    and #$01
    asl
    asl
    jsr OrEnData05
    lsr
    lsr
    lsr
    ror
    eor EnData02,x
    bpl Lx341
    jmp $820F

;-------------------------------------------------------------------------------
OrEnData05:
    ora EnData05,x
    sta EnData05,x
Lx341:
    rts

;-------------------------------------------------------------------------------
ReadTableAt968B: ; LF74B
    ldy EnDataIndex,x
    lda $968B,y
    rts

;-------------------------------------------------------------------------------

LF752:
    lda EnNameTable,x
    tay
    eor ObjectHi
    lsr
    rts

;-------------------------------------------------------------------------------
LF75B:
    lda #$E7
    sta $06
    lda #$18
    jsr OrEnData05
    ldy EnDataIndex,x
    lda $96AB,y
    beq Lx346
    tay
    lda EnData05,x
    and #$02
    beq Lx345
    tya
    ldy #$F7
    asl
    bcs Lx342
        ldy #$EF
    Lx342:
    lsr
    sta $02
    sty $06
    lda ObjectY
    sta $00
    ldy EnYRoomPos,x
    lda EnData05,x
    bmi Lx343
        ldy ObjectX
        sty $00
        ldy EnXRoomPos,x
    Lx343:
    lda ObjectHi
    lsr
    ror $00
    lda EnNameTable,x
    lsr
    tya
    ror
    sec
    sbc $00
    bpl Lx344
        jsr TwosCompliment              ;($C3D4)
    Lx344:
    lsr
    lsr
    lsr
    cmp $02
    bcc Lx346
Lx345:
    lda $06
LF7B3:
    and EnData05,x
    sta EnData05,x
Lx346:
    rts

LF7BA:
    dec EnDelay,x
    bne Lx347
    lda EnData05,x
    and #$08
    bne Lx348
    inc EnDelay,x
Lx347:
    rts
Lx348:
    lda EnDataIndex,x
    cmp #$07
    bne Lx349
        jsr SFX_OutOfHole
        ldx PageIndex
    Lx349:
    inc EnStatus,x
    jsr LF699
    ldy EnDataIndex,x
    lda $96CB,y
    clc
    adc #$D1
    sta $00
    lda #$00
    adc #$97
    sta $01
    lda FrameCount
    eor RandomNumber1
    ldy #$00
    and ($00),y
    tay
    iny
    lda ($00),y
    sta EnData08,x
    jsr $80B0
    bpl Lx351
    lda #$00
    sta EnCounter,x
    sta EnData07,x
    ldy EnData08,x

    lda $972B,y
    sta EnData1A,x

    lda $973F,y
    sta EnData1B,x

    lda $9753,y
    sta EnData02,x

    lda $9767,y
    sta EnData03,x
    lda EnData05,x
    bmi Lx350
        lsr
        bcc Lx351
        jsr $81D1
        jmp Lx351
    Lx350:
    and #$04
    beq Lx351
    jsr $8206
Lx351:
    lda #$DF
    jmp LF7B3

LF83E:
    lda EnData05,x
    jmp Lx352

LF844:
    lda EnData05,x
    bpl Lx352
    lsr
    lsr
Lx352:
    lsr
    lda EnDataIndex,x
    rol
    tay
    rts

LF852: ; accessed from CommonJump_03
    txa
    lsr
    lsr
    lsr
    adc FrameCount
    lsr
    rts

LF85A:
    ldy EnDataIndex,x
    lda $969B,y
    sta EnData0D,x
    lda EnemyHitPointTbl,y          ;($962B)
    ldy EnSpecialAttribs,x
    bpl Lx353 ; Check MSB of enemyAttr, double health if set
        asl
    Lx353:
    sta EnHitPoints,x
Lx354:
    rts

LF870:
    lda EnData05,x
    and #$10
    beq Lx354
    lda $87
    and EnStatus,x
    beq Lx354
    lda $87
    bpl Lx355
        ldy EnData1D,x
        bne Lx354
    Lx355:
    jsr LF8E8
    bcs Lx357
    sta EnData04,y
    jsr LF92C
    lda EnData05,x
    lsr
    lda $85
    pha
    rol
    tax
    lda $978B,x
    pha
    tya
    tax
    pla
    jsr LF68D
    ldx PageIndex
    lda #$01
    sta EnStatus,y
    and EnData05,x
    tax
    lda Table15,x
    sta EnData03,y
    lda #$00
    sta EnData02,y
    ldx PageIndex
    jsr LF8F8
    lda EnData05,x
    lsr
    pla
    tax
    lda $97A3,x
    sta $04
    txa
    rol
    tax
    lda $979B,x
    sta $05
    jsr LF91D
    ldx PageIndex
    bit $87
    bvc Lx357
    lda EnData05,x
    and #$01
    tay
    lda $0083,y
    jmp LF690

LF8E8:
    ldy #$60
    clc
Lx356:
    lda EnStatus,y
    beq Lx357
    jsr Yplus16
    cmp #$C0
    bne Lx356
Lx357:
    rts

LF8F8:
    lda $85
    cmp #$02
    bcc Lx358
    ldx PageIndex
    lda EnData05,x
    lsr
    lda $88
    rol
    and #$07
    sta EnData0A,y
    lda #$02
    sta EnStatus,y
    lda #$00
    sta EnDelay,y
    sta EnAnimDelay,y
    sta EnData08,y
Lx358:
    rts

LF91D:
    ldx PageIndex
    jsr StoreEnemyPositionToTemp
    tya
    tax
    jsr LFD8F
    jmp LoadEnemyPositionFromTemp

; Table used by above subroutine

Table15:
    .byte $02
    .byte $FE

LF92C:
    lda #$02
    sta EnRadY,y
    sta EnRadX,y
    ora EnData05,y
    sta EnData05,y
    rts

LF93B:
    ldx #$B0
    Lx359:
        jsr LF949
        ldx PageIndex
        jsr Xminus16
        cmp #$60
        bne Lx359
LF949:
    stx PageIndex
    lda EnData05,x
    and #$02
    bne Lx360
        jsr KillObject                  ;($FA18)Free enemy data slot.
    Lx360:
    lda EnStatus,x
    beq Exit19
    jsr ChooseRoutine
        .word ExitSub     ;($C45C) rts
        .word LF96A
        .word LF991       ; spit dragon's fireball
        .word ExitSub     ;($C45C) rts
        .word LFA6B
        .word LFA91

Exit19:
    rts

LF96A:
    jsr LFA5B
    jsr LFA1E
    ldx PageIndex
    bcs LF97C
    lda EnStatus,x
    beq Exit19
    jsr LFA60
LF97C:
    lda #$01
LF97E:
    jsr UpdateEnemyAnim
    jmp LDD8B
Lx361:
    inc EnData08,x
LF987:
    inc EnData08,x
    lda #$00
    sta EnDelay,x
    beq Lx362

LF991:
    jsr LFA5B
    lda EnData0A,x
    and #$FE
    tay
    lda $97A7,y
    sta $0A
    lda $97A8,y
    sta $0B
Lx362:
    ldy EnData08,x
    lda ($0A),y
    cmp #$FF ; If FF, restart string
    bne Lx363
    sta EnData08,x
    jmp LF987

Lx363:
    cmp EnDelay,x ; Move onto the next instruction if EnDelay == array value
    beq Lx361

    inc EnDelay,x
    iny
    lda ($0A),y
    jsr $8296 ; Get the y velocity from this byte
    ldx PageIndex
    sta EnData02,x

    lda ($0A),y
    jsr $832F ; Get the x velocity from this byte
    ldx PageIndex
    sta EnData03,x

    tay
    lda EnData0A,x
    lsr
    php
    bcc Lx364
    tya
    jsr TwosCompliment              ;($C3D4)
    sta EnData03,x
Lx364:
    plp
    bne Lx365
    lda EnData02,x
    beq Lx365
    bmi Lx365
    ldy EnData0A,x
    lda $95E0,y
    sta EnResetAnimIndex,x
Lx365:
    jsr LFA1E
    ldx PageIndex
    bcs Lx367
    lda EnStatus,x
    beq Exit20
    ldy #$00
    lda EnData0A,x
    lsr
    beq Lx366
        iny
    Lx366:
    lda $95E2,y
    jsr LF68D
    jsr LF518
    lda #$0A
    sta EnDelay,x
Lx367:
    jmp LF97C

KillObject:
    lda #$00                        ;
    sta EnStatus,x                  ;Store #$00 as enemy status(enemy slot is open).
    rts                             ;

; enemy<-->background crash detection

LFA1E:
    lda InArea
    cmp #$11
    bne Lx368
        lda EnStatus,x
        lsr
        bcc Lx369
    Lx368:
        jsr LFA7D
        ldy #$00
        lda ($04),y
        cmp #$A0
        bcc Lx370
        ldx PageIndex
    Lx369:
    lda EnData03,x
    sta $05
    lda EnData02,x
    sta $04
LFA41:
    jsr StoreEnemyPositionToTemp
    jsr LFD8F
    bcc KillObject                  ;($FA18)Free enemy data slot.

LoadEnemyPositionFromTemp:
    lda $08
    sta EnYRoomPos,x
    lda $09
    sta EnXRoomPos,x
    lda $0B
    and #$01
    sta EnNameTable,x
Lx370:
    rts

LFA5B:
    lda EnData04,x
    beq Exit20
LFA60:
    lda #$00
    sta EnData04,x
    lda #$05
    sta EnStatus,x
Exit20:
    rts

LFA6B:
    lda EnAnimFrame,x
    cmp #$F7
    beq Lx371
        dec EnDelay,x
        bne Lx372
    Lx371:
        jsr KillObject                  ;($FA18)Free enemy data slot.
    Lx372:
    jmp LF97C

LFA7D:
    ldx PageIndex
    lda EnYRoomPos,x
    sta $02
    lda EnXRoomPos,x
    sta $03
    lda EnNameTable,x
    sta $0B
    jmp MakeCartRAMPtr              ;($E96A)Find enemy position in room RAM.

LFA91:
    jsr KillObject                  ;($FA18)Free enemy data slot.
    lda $95DC
    jsr LF68D
    jmp LF97C

;-------------------------------------------------------------------------------
LFA9D:
    ldx #$C0
Lx373:
    stx PageIndex
    lda EnStatus,x
    beq Lx374
        jsr LFAB4
    Lx374:
    lda PageIndex
    clc
    adc #$08
    tax
    cmp #$E0
    bne Lx373
Lx375:
    rts

LFAB4:
    dec EnCounter,x
    bne Lx377
    lda #$0C
    sta EnCounter,x
    dec $0407,x
    bmi Lx376
    bne Lx377
Lx376:
    jsr KillObject                  ;($FA18)Free enemy data slot.
Lx377:
    lda EnCounter,x
    cmp #$09
    bne Lx378
    lda $0407,x
    asl
    tay
    lda Table16,y
    sta $04
    lda Table16+1,y
    sta $05
    jsr LFA41
Lx378:
    lda #$80
    sta ObjectCntrl
    lda #$03
    jmp LF97E

; Table used by above subroutine

Table16:
    .byte $00
    .byte $00
    .byte $0C
    .byte $1C
    .byte $10
    .byte $F0
    .byte $F0
    .byte $08

;-------------------------------------------------------------------------------
LFAF2:
    ldy #$18
Lx379:
    jsr LFAFF
    lda PageIndex
    sec
    sbc #$08
    tay
    bne Lx379

LFAFF:
    sty PageIndex
    ldx $0728,y
    inx
    beq Lx375
    ldx $0729,y
    lda EnStatus,x
    beq Lx380
    lda EnData05,x
    and #$02
    bne Exit13
Lx380:
    sta EnData04,x
    lda #$FF
    cmp EnDataIndex,x
    bne Lx381
    dec EnDelay,x
    bne Exit13
    lda $0728,y
    jsr LEB28
    ldy PageIndex
    lda $072A,y
    sta EnYRoomPos,x
    lda $072B,y
    sta EnXRoomPos,x
    lda $072C,y
    sta EnNameTable,x
    lda #$18
    sta EnRadX,x
    lda #$0C
    sta EnRadY,x
    ldy #$00
    jsr GetObject1CoordData
    jsr LF152
    jsr DistFromEn0ToObj1
    jsr LF1FA
    bcc Exit13
    lda #$01
    sta EnDelay,x
    sta EnStatus,x
    and ScrollDir
    asl
    sta EnData05,x
    ldy EnDataIndex,x
    jsr LFB7B
LFB70:
    jmp LF85A
Lx381:
    sta EnDataIndex,x
    lda #$01
    sta EnDelay,x
    jmp KillObject                  ;($FA18)Free enemy data slot.

LFB7B:
    jsr $80B0
    ror EnData05,x
    lda EnemyInitDelayTbl,y         ;($96BB)Load initial delay for enemy movement.
    sta EnDelay,x           ;

Exit13:
    rts                             ;Exit from multiple routines.

;-------------------------------------------------------------------------------
; Sidehopper AI ?
; Wavers, too?
LFB88:
    ldx PageIndex
    jsr LF844
    lda EnData1D,x
    inc EnData1F,x
    dec EnData1F,x
    bne Lx382
        pha
        pla
    Lx382:
    bpl Lx383
        jsr TwosCompliment              ;($C3D4)
    Lx383:
    cmp #$08
    bcc Lx384
        cmp #$10
        bcs Exit13
        tya
        and #$01
        tay
        lda $0085,y
        cmp EnResetAnimIndex,x
        beq Exit13
        sta EnAnimIndex,x
        dec EnAnimIndex,x
    LFBB9:
        sta EnResetAnimIndex,x
        jmp LF693
    Lx384:
    lda $963B,y
    cmp EnResetAnimIndex,x
    beq Exit13
    jmp LF68D
;-------------------------------------------------------------------------------

LFBCA:
    ldx PageIndex
    jsr LF844
    lda $965B,y
    cmp EnResetAnimIndex,x
    beq Exit13
    sta EnResetAnimIndex,x
    jmp LF690

LFBDD:
    lda #$40
    sta PageIndex
    ldx #$0C
    Lx385:
        jsr LFBEC
        dex
        dex
        dex
        dex
        bne Lx385
LFBEC:
    lda $A0,x
    beq Lx387
    dec $A0,x
    txa
    lsr
    tay
    lda Table17,y
    sta $04
    lda Table17+1,y
    sta $05
    lda $A1,x
    sta $08
    lda $A2,x
    sta $09
    lda $A3,x
    sta $0B
    jsr LFD8F
    bcc Lx388
    lda $08
    sta $A1,x
    sta $034D
    lda $09
    sta $A2,x
    sta $034E
    lda $0B
    and #$01
    sta $A3,x
    sta $034C
    lda $A3,x
    sta $034C
    lda #$5A
    sta PowerUpAnimFrame            ;Save index to find object animation.
    txa
    pha
    jsr DrawFrame
    lda SamusBlink
    bne Lx386
    ldy #$00
    ldx #$40
    jsr AreObjectsTouching          ;($DC7F)
    bcs Lx386
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    ldy #$00
    bcc Lx386
    clc
    jsr LF311
    lda #$50
    sta HealthLoChange
    jsr SubtractHealth              ;($CE92)
Lx386:
    pla
    tax
Lx387:
    rts

Lx388:
    lda #$00
    sta $A0,x
    rts

; Table used by above subroutine

Table17:
    .byte $00
    .byte $FB
    .byte $FB
    .byte $FE
    .byte $FB
    .byte $02
    .byte $00
    .byte $05

LFC65:
    lda $6BE4
    beq Lx390
    ldx #$F0
    stx PageIndex
    lda $6BE9
    cmp $95E4
    bne Lx391
    lda #$03
    jsr UpdateEnemyAnim
    lda RandomNumber1
    sta $8A
    lda #$18
Lx389:
    pha
    tax
    jsr LFC98
    pla
    tax
    lda $B6,x
    and #$F8
    sta $B6,x
    txa
    sec
    sbc #$08
    bpl Lx389
Lx390:
    rts
Lx391:
    jmp KillObject                   ;($FA18)Free enemy data slot.

LFC98:
    lda $B0,x
    jsr ChooseRoutine

; Pointer table to code

    .word ExitSub       ;($C45C) rts
    .word $FCA5
    .word $FCB1
    .word $FCBA

LFCA5:
    jsr LFD84
    jsr LFD08
    jsr LFD25
    jmp LDD8B

LFCB1:
    jsr LFD84
    jsr LFCC1
    jmp LDD8B

LFCBA:
    lda #$00
    sta $B0,x
    jmp SFX_EnemyHit

LFCC1:
    jsr LFD5F
    lda $B4,x
    cmp #$02
    bcs Lx392
    ldy $08
    cpy ObjectY
    bcc Lx392
    ora #$02
    sta $B4,x
Lx392:
    ldy #$01
    lda $B4,x
    lsr
    bcc Lx393
        ldy #$FF
    Lx393:
    sty $05
    ldy #$04
    lsr
    lda $B5,x
    bcc Lx394
        ldy #$FD
    Lx394:
    sty $04
    inc $B5,x
    jsr LFD8F
    bcs Lx395
        lda $B4,x
        ora #$02
        sta $B4,x
    Lx395:
    bcc Lx396
        jsr LFD6C
    Lx396:
    lda $B5,x
    cmp #$50
    bcc Lx397
    lda #$01
    sta $B0,x
Lx397:
    rts

LFD08:
    lda #$00
    sta $B5,x
    tay
    lda ObjectX
    sec
    sbc $B2,x
    bpl Lx398
        iny
        jsr TwosCompliment              ;($C3D4)
    Lx398:
    cmp #$10
    bcs Lx399
    tya
    sta $B4,x
    lda #$02
    sta $B0,x
Lx399:
    rts

LFD25:
    txa
    lsr
    lsr
    lsr
    adc $8A
    sta $8A
    lsr $8A
    and #$03
    tay
    lda Table18,y
    sta $04
    lda Table18+1,y
    sta $05
    jsr LFD5F
    lda $08
    sec
    sbc ScrollY
    tay
    lda #$02
    cpy #$20
    bcc Lx400
    jsr TwosCompliment              ;($C3D4)
    cpy #$80
    bcc Lx401
Lx400:
    sta $04
Lx401:
    jsr LFD8F
    jmp LFD6C

; Table used by above subroutine

Table18:
    .byte $02
    .byte $FE
    .byte $01
    .byte $FF
    .byte $02

LFD5F:
    lda $B3,x
    sta $0B
    lda $B1,x
    sta $08
    lda $B2,x
    sta $09
    rts

LFD6C:
    lda $08
    sta $B1,x
    sta $04F0
    lda $09
    sta $B2,x
    sta $04F1
    lda $0B
    and #$01
    sta $B3,x
    sta $6BEB
    rts

LFD84:
    lda $B6,x
    and #$04
    beq Lx402
    lda #$03
    sta $B0,x
Lx402:
    rts

;-------------------------------------------------------------------------------
; $02 is tempScrollDir
; $04 is tempYvel?
; $05 is tempXvel?

; $08 is tempY
; $09 is tempX
; $0B is tempNametable
LFD8F:
    lda ScrollDir
    and #$02
    sta $02
    lda $04
    clc
    bmi Lx405
        beq LFDBF
        adc $08
        bcs Lx403
            cmp #$F0
            bcc Lx404
        Lx403:
            adc #$0F
            ldy $02
            bne ClcExit2
            inc $0B
        Lx404:
        sta $08
        jmp LFDBF
    Lx405:
    adc $08
    bcs Lx406
        sbc #$0F
        ldy $02
        bne ClcExit2
        inc $0B
    Lx406:
    sta $08
LFDBF:
    lda $05
    clc
    bmi Lx408
        beq SecExit
        adc $09
        bcc Lx407
            ldy $02
            beq ClcExit2
            inc $0B
        Lx407:
        jmp Lx409
    Lx408:
    adc $09
    bcs Lx409
    ldy $02
    beq ClcExit2
    inc $0B
Lx409:
    sta $09

SecExit:
    sec
    rts
ClcExit2:
    clc
Lx410:
    rts

;-------------------------------------------------------------------------------
UpdateTourianItems:
; Adds mother brain and zebetite
LFDE3:
    lda EndTimerHi          ; Determine if this is the first frame the end timer is running
    cmp #$99                ; (it will have a value of 99.99 the first frame)
    bne Lx411
    clc
    sbc EndTimerLo
    bne Lx411                   ; On the first frame of the end timer:

    sta $06	                ;
    lda #$38                ;
    sta $07                 ;    Add [mother brain defeated] to item history
    jsr LDC54               ;
Lx411:
    ldx #$20                ; Loop through zebetites (@ x = 20, 18, 10, 8, 0)
    Lx412:
        jsr CheckZebetite       ;     ($FE05) Update one zebetite
        txa                     ;     (Subtract 8 from x)
        sec
        sbc #$08
        tax
        bne Lx412

CheckZebetite:
LFE05:
    lda $0758,x             ;
    sec
    sbc #$02                ;
    bne Lx410                 ; Exit if zebetite state != 2
    sta $06                 ; Store 0 to $06
    inc $0758,x             ; Set zebetite state to 3
    txa
    lsr                     ; A =  zebetite index * 4 (10, C, 8, 4, or 0)
    adc #$3C                ;      + $3C
    sta $07
    jmp LDC54               ; Add zebetite to item history

;-------------------------------------------------------------------------------
; Tile degenerate/regenerate
UpdateTiles:
    ldx #$C0
    Lx413:
        jsr DoOneTile
        ldx PageIndex
        jsr Xminus16
        bne Lx413
DoOneTile:
    stx PageIndex
    lda TileRoutine,x
    beq Lx414          ; exit if tile not active
    jsr ChooseRoutine
        .word ExitSub       ;($C45C) rts
        .word LFE3D
        .word LFE54
        .word LFE59
        .word LFE54
        .word LFE83

LFE3D:
    inc TileRoutine,x
    lda #$00
    jsr SetTileAnim
    lda #$50
    sta TileDelay,x
    lda TileWRAMLo,x     ; low WRAM addr of blasted tile
    sta $00
    lda TileWRAMHi,x     ; high WRAM addr
    sta $01

LFE54:
    lda #$02
    jmp UpdateTileAnim

LFE59:
    lda FrameCount
    and #$03
    bne Lx414       ; only update tile timer every 4th frame
    dec TileDelay,x
    bne Lx414       ; exit if timer not reached zero
    inc TileRoutine,x
    ldy TileType,x
    lda Table19,y
    SetTileAnim:
    sta TileAnimIndex,x
    sta $0505,x
    lda #$00
    sta TileAnimDelay,x
Lx414:
    rts

; Table used for indexing the animations in TileBlastAnim (see below)

Table19:
    .byte $18,$1C,$20,$00,$04,$08,$0C,$10,$24,$14

LFE83:
    lda #$00
    sta TileRoutine,x       ; tile = respawned
    lda TileWRAMLo,x
    clc
    adc #$21
    sta $00
    lda TileWRAMHi,x
    sta $01
    jsr LFF3C
    lda $02
    sta $07
    lda $03
    sta $09
    lda $01
    lsr
    lsr
    and #$01
    sta $0B
    ldy #$00
    jsr GetObject1CoordData
    lda #$04
    clc
    adc ObjRadY
    sta $04
    lda #$04
    clc
    adc ObjRadX
    sta $05
    jsr LF1FA
    bcs Exit23
    jsr LF311
    lda #$50
    sta HealthLoChange
    jmp SubtractHealth              ;($CE92)

    GetTileFramePtr:
    lda TileAnimFrame,x
    asl
    tay
    lda L97AF,y
    sta $02
    lda L97AF+1,y
    sta $03
Exit23:
    rts

LFEDC:
DrawTileBlast:
    lda PPUStrIndex
    cmp #$1F
    bcs Exit23
    ldx PageIndex
    lda TileWRAMLo,x
    sta $00
    lda TileWRAMHi,x
    sta $01
    jsr GetTileFramePtr
    ldy #$00
    sty $11
    lda ($02),y
    tax
    jsr Adiv16       ; / 16
    sta $04
    txa
    and #$0F
    sta $05
    iny
    sty $10
    Lx415:
        ldx $05
        Lx416:
            ldy $10
            lda ($02),y
            inc $10
            ldy $11
            sta ($00),y
            inc $11
            dex
            bne Lx416
        lda $11
        clc
        adc #$20
        sec
        sbc $05
        sta $11
        dec $04
        bne Lx415
    lda $01
    and #$04
    beq Lx417
        lda $01
        ora #$0C
        sta $01
    Lx417:
    lda $01
    and #$2F
    sta $01
    jsr EraseTile
    clc
    rts

LFF3C:
    lda $00
    tay
    and #$E0
    sta $02
    lda $01
    lsr
    ror $02
    lsr
    ror $02
    tya
    and #$1F
    jsr Amul8       ; * 8
    sta $03
    rts

UpdateTileAnim:
    ldx PageIndex
    ldy TileAnimDelay,x
    beq Lx418
        dec TileAnimDelay,x
        bne Lx419
    Lx418:
    sta TileAnimDelay,x
    ldy TileAnimIndex,x
    lda TileBlastAnim,y
    cmp #$FE            ; end of "tile-blast" animation?
    beq Lx420
    sta TileAnimFrame,x
    iny
    tya
    sta TileAnimIndex,x
    jsr DrawTileBlast
    bcc Lx419
    ldx PageIndex
    dec TileAnimIndex,x
Lx419:
    rts
Lx420:
    inc TileRoutine,x
    pla
    pla
    rts

; Frame data for tile blasts

TileBlastAnim:
    .byte $06,$07,$00,$FE
    .byte $07,$06,$01,$FE
    .byte $07,$06,$02,$FE
    .byte $07,$06,$03,$FE
    .byte $07,$06,$04,$FE
    .byte $07,$06,$05,$FE
    .byte $07,$06,$09,$FE
    .byte $07,$06,$0A,$FE
    .byte $07,$06,$0B,$FE
    .byte $07,$06,$08,$FE

    .byte $00
    .byte $00

;-----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;-----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_07_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
