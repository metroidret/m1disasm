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

.redef BANK = 7
.section "ROM Bank $007" bank 7 slot "ROMFixedSlot" orga $C000 force

;------------------------------------------[ Start of code ]-----------------------------------------

;This routine generates pseudo random numbers and updates those numbers
;every frame. The random numbers are used for several purposes including
;password scrambling and determinig what items, if any, an enemy leaves
;behind after it is killed.

RandomNumbers: ;$C000
    ;RandomNumber1 is increased by #$19 every frame
    ;RandomNumber2 is increased by #$5F every frame.
    txa
    pha
    ldx #$05
    @loop:
        lda RandomNumber1
        clc
        adc #$05
        sta RandomNumber1

        lda RandomNumber2
        clc
        adc #$13
        sta RandomNumber2

        dex
        bne @loop
    pla
    tax
    lda RandomNumber1
    rts

;------------------------------------------[ Startup ]----------------------------------------------

Startup:
    lda #$00
    sta MMC1CHR0                    ;Clear bit 0. MMC1 is serial controlled
    sta MMC1CHR0                    ;Clear bit 1
    sta MMC1CHR0                    ;Clear bit 2
    sta MMC1CHR0                    ;Clear bit 3
    sta MMC1CHR0                    ;Clear bit 4
    sta MMC1CHR1                    ;Clear bit 0
    sta MMC1CHR1                    ;Clear bit 1
    sta MMC1CHR1                    ;Clear bit 2
    sta MMC1CHR1                    ;Clear bit 3
    sta MMC1CHR1                    ;Clear bit 4
    jsr MMCWritePrgBank             ;($C4FA)Swap to PRG bank #0 at $8000
    dex                             ;X = $FF
    txs                             ;S points to end of stack page

;Clear RAM at $0000-$07FF.
    ;$0000 = #$0700
    ;High byte of start address.
    ldy #$07
    sty $01
    ;Low byte of start address.
    ldy #$00
    sty $00
    tya ;A = 0
    @loop_A:
        @loop_B:
            ;clear address
            sta ($00),y
            ;Repeat for entire page.
            iny
            bne @loop_B
        ;Decrement high byte of address.
        dec $01
        ;If $01 < 0, all pages are cleared.
        bmi @exitLoop_A
        ;Keep looping until ram is cleared.
        ldx $01
        cpx #$01
        bne @loop_A
    @exitLoop_A:

    ;Clear cartridge RAM at $6000-$7FFF.
    ;$0000 points to $7F00
    ;High byte of start address.
    ldy #$7F
    sty $01
    ;Low byte of start address.
    ldy #$00
    sty $00
    tya ;A = 0
    @loop_C:
        @loop_D:
            ;Clears 256 bytes of memory before decrementing to next 256 bytes.
            sta ($00),y
            iny
            bne @loop_D
        dec $01
        ldx $01
        ;Is address < $6000? If not, do another page.
        cpx #$60
        bcs @loop_C


    ;Vertical mirroring.
    ;H/V mirroring (As opposed to one-screen mirroring).
    ;Switch low PRGROM area during a page switch.
    ;16KB PRGROM switching enabled.
    ;8KB CHRROM switching enabled.
    lda #MMC1CTRL_MIRROR_VERTI | MMC1CTRL_PRGFIXED_C000 | MMC1CTRL_PRGBANK_16K | MMC1CTRL_CHRBANK_8K.b
    sta MMC1CTRL_ZP

    ;Clear bits 3 and 4 of MMC1 register 3.
    lda #$00
    sta SwitchUpperBits

    ; clear scroll and hardware scroll
    ldy #$00
    sty ScrollX
    sty ScrollY
    sty PPUSCROLL ;Clear hardware scroll x
    sty PPUSCROLL ;Clear hardware scroll y

    ;Title screen mode
    iny ;Y = #$01
    sty GameMode

    jsr ClearNameTables
    jsr EraseAllSprites

    ;NMI = enabled
    ;Sprite size = 8x8
    ;BG pattern table address = $1000
    ;SPR pattern table address = $0000
    ;PPU address increment = 1
    ;Name table address = $2000
    lda #PPUCTRL_VBLKNMI_ON | PPUCTRL_OBJH_8 | PPUCTRL_BG_1000 | PPUCTRL_OBJ_0000 | PPUCTRL_INCR_FWD | PPUCTRL_NMTBL_2000.b
    sta PPUCTRL
    sta PPUCTRL_ZP

    ;Sprites visible = no
    ;Background visible = no
    ;Sprite clipping = yes
    ;Background clipping = no
    ;Display type = color
    lda #PPUMASK_OBJ_OFF | PPUMASK_BG_OFF | PPUMASK_HIDE8OBJ | PPUMASK_SHOW8BG | PPUMASK_COLOR.b
    sta PPUMASK_ZP

    ;Prepare to set PPU to vertical mirroring.
    lda #$47
    sta MirrorCntrl
    jsr PrepVertMirror

    ;PCM volume = 0 - disables DMC channel
    lda #$00
    sta DMC_RAW
    ;Enable sound channel 0,1,2,3
    lda #SND_CHN_SQ1 | SND_CHN_SQ2 | SND_CHN_TRI | SND_CHN_NOISE.b
    sta SND_CHN

    ;Set title routine and and main routine function pointers equal to 0.
    ldy #$00
    sty TitleRoutine
    sty MainRoutine
    ;Initialize RandomNumber1 to #$11
    lda #$11
    sta RandomNumber1
    ;Initialize RandomNumber2 to #$FF
    lda #$FF
    sta RandomNumber2

    iny ;Y = 1
    sty SwitchPending               ;Prepare to switch page 0 into lower PRGROM.
    jsr CheckSwitch                 ;($C4DE)
    bne WaitNMIEnd                  ;Branch always

;-----------------------------------------[ Main loop ]----------------------------------------------

;The main loop runs all the routines that take place outside of the NMI.

MainLoop:
    ;($C4DE)Check to see if memory page needs to be switched.
    jsr CheckSwitch
    ;($C266)Update Timers 1, 2 and 3.
    jsr UpdateTimer
    ;($C114)Go to main routine for updating game.
    jsr GoMainRoutine
    ;Increment frame counter.
    inc FrameCount

    ;Wait for next NMI to end.
    lda #$00
    sta NMIStatus
WaitNMIEnd:
        ;If nonzero, NMI has ended. Else keep waiting.
        tay
        lda NMIStatus
        bne LC0D3
        jmp WaitNMIEnd

LC0D3:
    ;($C000)Update pseudo random numbers.
    jsr RandomNumbers
    ;($C0BC)Jump to top of subroutine.
    jmp MainLoop

;-------------------------------------[ Non-Maskable Interrupt ]-------------------------------------

;The NMI is called 60 times a second by the VBlank signal from the PPU. When the
;NMI routine is called, the game should already be waiting for it in the main
;loop routine in the WaitNMIEnd loop.  It is possible that the main loop routine
;will not be waiting as it is bogged down with excess calculations. This causes
;the game to slow down.

NMI:
    ;Save processor status flags.
    php
    ;Save A.
    pha
    ;Save X.
    txa
    pha
    ;Save Y.
    tya
    pha
    ;Sprite RAM address = 0.
    lda #$00
    sta OAMADDR
    ;Transfer page 2 ($200-$2FF) to Sprite RAM.
    lda #>SpriteRAM.b
    sta OAMDMA
    ;Skip if the frame couldn't finish in time.
    lda NMIStatus
    bne LC103
        ;Branch if mode=Play.
        lda GameMode
        beq LC0F4
            ;($9A07)Write end message on screen(If appropriate).
            jsr NMIScreenWrite
        LC0F4:
        ;($C1E0)Check if palette data pending.
        jsr CheckPalWrite
        ;($C2CA)check if data needs to be written to PPU.
        jsr CheckPPUWrite
        ;($C44D)Update $2000 & $2001.
        jsr WritePPUCtrl
        ;($C29A)Update h/v scroll reg.
        jsr WriteScroll
        ;($C215)Read both joypads.
        jsr ReadJoyPads
    LC103:
    ;($B3B4)Update music and SFX.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        jsr SoundEngine
    .elif BUILDTARGET == "NES_PAL"
        jsr GotoSoundEngine
    .endif
    ;($C97E)Update Samus' age.
    jsr UpdateAge
    ; NMI = finished.
    ldy #$01
    sty NMIStatus
    ;Restore Y.
    pla
    tay
    ;Restore X.
    pla
    tax
    ;Restore A.
    pla
    ;Restore processor status flags.
    plp
    ;Return from NMI.
    rti

;----------------------------------------[ GoMainRoutine ]-------------------------------------------

;This is where the real code of each frame is executed.
;MainRoutine or TitleRoutine (Depending on the value of GameMode)
;is used as an index into a code pointer table, and this routine
;is executed.

GoMainRoutine:
    ;0 if game is running, 1 if at intro screen.
    ;Branch if mode=Play.
    lda GameMode
    beq @endIf_A
        ;Jump to $8000, where a routine similar to the one below is executed,-->
        ;only using TitleRoutine instead of MainRoutine as index into a jump table.
        jmp MainTitleRoutine
    @endIf_A:

    ;Has START been pressed? If not, execute current routine as normal.
    lda Joy1Change
    and #BUTTON_START
    beq @endIf_B

    ;START was pressed
    ;Is game engine running?-->
    lda MainRoutine
    cmp #_id_GameEngine.b
    beq @else_C
        ;Game engine is not running
        ;Is game paused? If it isn't, don't care about START being pressed.
        cmp #_id_PauseMode.b
        bne @endIf_B
        ;Game is paused
        ;Switch to Game engine.
        lda #_id_GameEngine.b
        bne @endIf_C ;Branch always.
    @else_C:
        ;Game engine is running
        ;Switch to pause routine.
        lda #_id_PauseMode.b
    @endIf_C:
    ;(MainRoutine = 5 if game paused, 3 if game engine running).
    sta MainRoutine
    ;Toggle game paused.
    lda GamePaused
    eor #$01
    sta GamePaused
    ;($CB92)Silences music while game paused.
    jsr PauseMusic

@endIf_B:
    ;Use MainRoutine as index into routine table below.
    lda MainRoutine
    jsr ChooseRoutine
    MainRoutinePtrTable:
        PtrTableEntry MainRoutinePtrTable, AreaInit                  ;($C801)Area init.
        PtrTableEntry MainRoutinePtrTable, MoreInit                  ;($C81D)More area init.
        PtrTableEntry MainRoutinePtrTable, SamusInit                 ;($C8D1)Samus init.
        PtrTableEntry MainRoutinePtrTable, GameEngine                ;($C92B)Game engine.
        PtrTableEntry MainRoutinePtrTable, PrepareGameOver           ;($C9A6)Display GAME OVER.
        PtrTableEntry MainRoutinePtrTable, PauseMode                 ;($C9B1)Pause game.
        PtrTableEntry MainRoutinePtrTable, GoPassword                ;($C9C4)Display password.
        PtrTableEntry MainRoutinePtrTable, IncrementRoutine          ;($C155)Just advances to next routine in table.
        PtrTableEntry MainRoutinePtrTable, SamusIntro                ;($C9D7)Intro.
        PtrTableEntry MainRoutinePtrTable, WaitTimer                 ;($C494)Delay.

IncrementRoutine:
    ;Increment to next routine in above table.
    inc MainRoutine
    rts

;-------------------------------------[ Clear name tables ]------------------------------------------

ClearNameTables: ;($C158)
    ;Always clear name table 0 first.
    jsr @nameTable0
    ;Branch if mode = Play.
    lda GameMode
    beq @nameTable1
    ;If running the end game routine, clear name table 2, else clear name table 1.
    lda TitleRoutine
    cmp #_id_EndGame.b
    beq @nameTable2

@nameTable1:
    ;Name table to clear + 1 (name table 1).
    lda #$01+1
    bne @nameTableCommon ;Branch always.

@nameTable2:
    ;Name table to clear + 1 (name table 2).
    lda #$02+1
    bne @nameTableCommon ;Branch always.

@nameTable0:
    ;Name table to clear + 1 (name table 0).
    lda #$00+1
@nameTableCommon:
    ;Stores name table to clear.
    sta Temp01_NameTablePlus1
    ;Value to fill with.
    lda #$FF
    sta Temp00_FillValue
    ; fallthrough

ClearNameTable:
    ;Reset PPU address latch.
    ldx PPUSTATUS
    ;PPU increment = 1.
    lda PPUCTRL_ZP
    and #~PPUCTRL_INCR_DOWN.b
    sta PPUCTRL_ZP
    ;Store control bits in PPU.
    sta PPUCTRL
    ;Name table = X - 1.
    ldx Temp01_NameTablePlus1
    dex
    ;get high PPU address.  pointer table at $C19F.
    lda HiPPUTable,x
    ;Set PPU start address (High byte first).
    sta PPUADDR
    lda #$00
    sta PPUADDR
    ;Prepare to loop 4 times.
    ldx #$04
    ;Inner loop value.
    ldy #$00
    ;Fill-value.
    lda Temp00_FillValue
    @loop_outer:
        @loop_inner:
            ;Loops until the desired name table is cleared.
            ;It also clears the associated attribute table.
            sta PPUDATA
            dey
            bne @loop_inner
        dex
        bne @loop_outer
    rts

;The following table is used by the above routine for finding
;the high byte of the proper name table to clear.
HiPPUTable:
    .byte >$2000                       ;Name table 0.
    .byte >$2400                       ;Name table 1.
    .byte >$2800                       ;Name table 2.
    .byte >$2C00                       ;Name table 3.

;-------------------------------------[ Erase all sprites ]------------------------------------------

EraseAllSprites: ;($C1A3)
    ; load SpriteRAM address into $00-01
    ldy #>SpriteRAM.b
    sty $01
    ldy #<SpriteRAM.b
    sty $00
    ;Stores #$F0 in memory addresses $0200 thru $02FF.
    ldy #$00
    lda #$F0
    @loop:
        sta ($00),y
        iny
        ;Loop while more sprite RAM to clear.
        bne @loop
    ;Exit subroutine if GameMode=Play(#$00)
    lda GameMode
    beq Exit101
        jmp DecSpriteYCoord             ;($988A)Find proper y coord of sprites.
Exit101:
    rts                             ;Return used by subroutines above and below.

;---------------------------------------[ Remove intro sprites ]-------------------------------------

;The following routine is used in the Intro to remove the sparkle sprites and the crosshairs
;sprites every frame.  It does this by loading the sprite values with #$F4 which moves the
;sprite to the bottom right of the screen and uses a blank graphic for the sprite.

RemoveIntroSprites:
    ;Start at address $200. ($00) = $0200 (sprite page)
    ldy #>SpriteRAM.b
    sty $01
    ldy #<SpriteRAM.b
    sty $00
    ;Prepare to clear RAM $0200-$025F
    ldy #$5F
    lda #$F4
    @loop:
        sta ($00),y
        dey
        ;Loop unitl $200 thru $25F is filled with #$F4.
        bpl @loop
    ; branch if mode = Play.
    lda GameMode
    beq Exit101
        jmp DecSpriteYCoord             ;($988A)Find proper y coord of sprites.

;-------------------------------------[Clear RAM $33 thru $DF]---------------------------------------

;The routine below clears RAM associated with rooms and enemies.

ClearRAM_33_DF:
    ldx #RoomPtr.b
    lda #$00
    @loop:
        ;Clear RAM addresses $33 through $DF.
        sta $00,x
        inx
        ;Loop until all desired addresses are cleared.
        cpx #SoundE0.b
        bcc @loop
    rts

;--------------------------------[ Check and prepare palette write ]---------------------------------

CheckPalWrite:
    lda GameMode                    ;
    beq LC1ED                       ;Is game being played? If so, branch to exit.
    lda TitleRoutine                ;
    cmp #_id_EndGame.b                        ;Is Game at ending sequence? If not, branch
    bcc LC1ED                       ;
    jmp EndGamePalWrite             ;($9F54)Write palette data for ending.
LC1ED:
    ldy PalDataPending              ;
    bne LC1FF                       ;Is palette data pending? If so, branch.
        lda GameMode                    ;
        beq RTS_C1FE                       ;Is game being played? If so, branch to exit.
        lda TitleRoutine                ;
        cmp #_id_StartContinueScreen15.b                        ;Is intro playing? If not, branch.
        bcs RTS_C1FE                       ;
        jmp StarPalSwitch               ;($8AC7)Cycles palettes for intro stars twinkle.
        RTS_C1FE:
        rts                             ;Exit when no palette data pending.

;Prepare to write palette data to PPU.

LC1FF:
    dey                             ;Palette # = PalDataPending - 1.
    tya                             ;
    asl                             ;* 2, each pal data ptr is 2 bytes (16-bit).
    tay                             ;
    ldx PalPntrTbl,y                ;X = low byte of PPU data pointer.
    lda PalPntrTbl+1,y              ;
    tay                             ;Y = high byte of PPU data pointer.
    lda #$00                        ;Clear A.
    sta PalDataPending              ;Reset palette data pending byte.

PreparePPUProcess:
    stx $00                         ;Lower byte of pointer to PPU string.
    sty $01                         ;Upper byte of pointer to PPU string.
    jmp ProcessPPUString            ;($C30C)Write data string to PPU.

;----------------------------------------[Read joy pad status ]--------------------------------------

;The following routine reads the status of both joypads

ReadJoyPads:
    ;Load x with #$00. Used to read status of joypad 1.
    ldx #$00
    stx $01
    jsr ReadOnePad
    ;Load x with #$01. Used to read status of joypad 2.
    inx
    inc $01
    ; fallthrough

ReadOnePad:
    ;These lines strobe the joystick to enable the program to read the buttons pressed.
    ldy #$01
    sty JOY1
    dey
    sty JOY1
    ;Do 8 buttons.
    ldy #$08
    @loop:
        ;Store A.
        pha
        ;Read button status. Joypad 1 or 2.
        lda JOY1,x
        ;Store button press at location $00.
        sta $00
        ;Also accept button press from joypad that is plugged into the console's expansion port
        lsr
        ora $00
        ;Move button press to carry bit.
        lsr
        ;Restore A.
        pla
        ;Add button press status to A.
        rol
        ;Loop 8 times to get status of all 8 buttons.
        dey
        bne @loop
    ; a now contains the new joypad status

    ;Get joypad status of previous refresh.
    ldx $01 ;Joypad #(0 or 1).
    ldy Joy1Status,x
    ;Store at $00.
    sty $00

    ;Store current joypad status.
    sta Joy1Status,x

    ;Branch if no buttons changed.
    eor $00
    beq @endIf_A
        ;Remove the previous status of the B button.
        lda $00
        and #~BUTTON_B.b
        sta $00
        eor Joy1Status,x
    @endIf_A:
    ;Save any button changes from the current frame and the last frame to the joy change addresses.
    and Joy1Status,x
    sta Joy1Change,x
    ;Store any changed buttons in JoyRetrig address.
    sta Joy1Retrig,x

    ldy #$20
    ;Checks to see if same buttons are being pressed this frame as last frame.
    lda Joy1Status,x
    cmp $00
    ;If none, branch.
    bne @endIf_B
        ;Decrement RetrigDelay if same buttons pressed.
        dec RetrigDelay1,x
        bne RTS_C265
        ;Once RetrigDelay=#$00, store buttons to retrigger.
        sta Joy1Retrig,x
        ldy #$08
    @endIf_B:
    ;Reset retrigger delay to #$20(32 frames) or #$08(8 frames) if already retriggering.
    sty RetrigDelay1.b,x
RTS_C265:
    rts

;-------------------------------------------[ Update timer ]-----------------------------------------

;This routine is used for timing - or for waiting around, rather.
;TimerDelay is decremented every frame. When it hits zero, $2A, $2B and $2C are
;decremented if they aren't already zero. The program can then check
;these variables (it usually just checks $2C) to determine when it's time
;to "move on". This is used for the various sequences of the intro screen,
;when the game is started, when Samus takes a special item, and when GAME
;OVER is displayed, to mention a few examples.

UpdateTimer:
    ; Default to only decrementing Timer2 and Timer1.
    ldx #$01
    ; branch if timer delay is not zero
    dec TimerDelay
    bpl @endIf_A
        ;TimerDelay hits #$00 every 10th frame.
        ;Reset TimerDelay after it hits #$00.
        lda #$09
        sta TimerDelay
        ;Decrement Timer3 every 10 frames.
        ldx #$02
    @endIf_A:

    ; decrement the chosen timers
    @loop_decTimer:
        ;Don't decrease if timer is already zero.
        lda Timer1,x
        beq @endIf_B
            dec Timer1,x
        @endIf_B:
        dex
        bpl @loop_decTimer
    rts

;-----------------------------------------[ Choose routine ]-----------------------------------------

;This is an indirect jump routine. A is used as an index into a code
;pointer table, and the routine at that position is executed. The programmers
;always put the pointer table itself directly after the JSR to ChooseRoutine,
;meaning that its address can be popped from the stack.

ChooseRoutine:
    ;* 2, each ptr is 2 bytes (16-bit).
    asl
    ;Temp storage. (not pushed to stack, because stack needs to be accessed)
    sty TempY
    stx TempX
    ; y = a+1
    tay
    iny
    ;load ptr table address from stack
    pla
    sta CodePtr
    pla
    sta CodePtr+1.b
    ;Low byte of routine ptr
    lda (CodePtr),y
    tax
    ;High byte of routine ptr.
    iny
    lda (CodePtr),y
    ; save routine ptr to CodePtr
    sta CodePtr+1.b
    stx CodePtr
    ;Restore X and Y.
    ldx TempX
    ldy TempY
    jmp (CodePtr)

;--------------------------------------[ Write to scroll registers ]---------------------------------

WriteScroll:
    ;Reset scroll register flip/flop
    lda PPUSTATUS
    ;X and Y scroll offsets are loaded serially.
    lda ScrollX
    sta PPUSCROLL
    lda ScrollY
    sta PPUSCROLL
    rts

;----------------------------------[ Add y index to stored addresses ]-------------------------------

;Add Y to pointer at $0000.
AddYToPtr00: ; 07:C2A8
    ;Add value stored in Y to lower address byte stored in $00.
    tya
    clc
    adc $00
    sta $00
    ;Increment $01(upper address byte) if carry has occurred.
    bcc @RTS
        inc $01
    @RTS:
    rts

;Add Y to pointer at $0002
AddYToPtr02:
    ;Add value stored in Y to lower address byte stored in $02.
    tya
    clc
    adc $02
    sta $02
    ;Increment $03(upper address byte) if carry has occurred.
    bcc @RTS
        inc $03
    @RTS:
    rts

;--------------------------------[ Simple divide and multiply routines ]-----------------------------

Adiv32:
    lsr                             ;Divide by 32.
Adiv16:
    lsr                             ;Divide by 16.
Adiv8:
    lsr                             ;Divide by 8.
    lsr                             ;
    lsr                             ;Divide by shifting A right.
    rts

Amul32:
    asl                             ;Multiply by 32.
Amul16:
    asl                             ;Multiply by 16.
Amul8:
    asl                             ;Multiply by 8.
    asl                             ;
    asl                             ;Multiply by shifting A left.
    rts

;-------------------------------------[ PPU writing routines ]---------------------------------------

;Checks if any data is waiting to be written to the PPU.
;RLE data is one tile that repeats several times in a row.  RLE-Repeat Last Entry

CheckPPUWrite:
    ;If zero no PPU data to write, branch to exit.
    lda PPUDataPending
    beq RTS_C2E3
    ;Sets up PPU writer to start at address $07A1.
    ;$0000 = ptr to PPU data string ($07A1).
    lda #<PPUDataString.b
    sta $00
    lda #>PPUDataString.b
    sta $01
    ;($C30C)write it to PPU.
    jsr ProcessPPUString
    ;PPU data string has been written so the data stored for the write is now erased.
    lda #$00
    sta PPUStrIndex
    sta PPUDataString
    sta PPUDataPending
RTS_C2E3:
    rts

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

;Write blasted tile to nametable.  Each screen is 16 tiles across and 15 tiles down.
WriteTileBlast:
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

NextPPUByte: ;($C36E)
    inx                             ;PPUDataString has increased in size by 1 byte.
    cpx #$4F                        ;PPU byte writer can only write a maximum of #$4F bytes
    bcc RTS_C37D                           ;If PPU string not full, branch to get more data.
    ldx PPUStrIndex                 ;

EndPPUString:
    lda #$00                        ;If PPU string is already full, or all PPU bytes loaded,-->
    sta PPUDataString,x             ;add #$00 as last byte to the PPU byte string.
    pla                             ;
    pla                             ;Remove last return address from stack and jump out of-->
RTS_C37D:
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
    bpl LC3AF                           ;have been used for a software control vertical mirror, but-->
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
    ;Store current byte
    sta Temp04_ControlBits
    ;Remove RLE bit and save control bit in PPUDataString.
    and #$BF
    sta PPUDataString,x
    ;Extract counter bits and save them for use above.
    and #$3F
    sta Temp05_BytesCounter
    jmp NextPPUByte

;----------------------------------------[ Math routines ]-------------------------------------------

TwosComplement:
    eor #$FF                        ;
    clc                             ;Generate twos complement of value stored in A.
    adc #$01                        ;
    rts

;The following two routines add a Binary coded decimal (BCD) number to another BCD number.
;A base number is stored in $03 and the number in A is added/subtracted from $03.  $01 and $02
;contain the lower and upper digits of the value in A respectively.  If an overflow happens after
;the addition/subtraction, the carry bit is set before the routine returns.

Base10Add:
    jsr ExtractNibbles              ;($C41D)Separate upper 4 bits and lower 4 bits.
    adc $01                         ;Add lower nibble to number.
    cmp #$0A                        ;
    bcc LC3E5                           ;If result is greater than 9, add 6 (5+carry) to create-->
        adc #$05                        ;valid result(skip #$0A thru #$0F).
    LC3E5:
    clc                             ;
    adc $02                         ;Add upper nibble to number.
    sta $02                         ;
    lda $03                         ;
    and #$F0                        ;Keep upper 4 bits of Health/Health+1 in A.
    adc $02                         ;
    bcc LC3F6                       ;
LC3F2:
    adc #$5F                        ;If upper result caused a carry, add #$60 (#$5f+carry) to create-->
    sec                             ;valid result. Set carry indicating carry to next digit.
    rts
LC3F6:
    cmp #$A0                        ;If result of upper nibble add is greater than #$90,-->
    bcs LC3F2                       ;Branch to add #$60 to create valid result.
    rts

Base10Subtract: ;($C3FB)
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
    lda $03                         ;Keep upper 4 bits of Health/Health+1 in A.
    and #$F0                        ;
    sec                             ;
    sbc $02                         ;If result is greater than zero, branch to finish.
    bcs LC41A                           ;
        adc #$A0                        ;Add 10 to create valid result.
        clc                             ;
    LC41A:
    ora $01                         ;Combine A and $01 to create final value.
    rts

ExtractNibbles:
    pha                             ;
    and #$0F                        ;Lower 4 bits of value to change Health/Health+1 by.
    sta $01                         ;
    pla                             ;
    and #$F0                        ;Upper 4 bits of value to change Health/Health+1 by.
    sta $02                         ;
    lda $03                         ;
    and #$0F                        ;Keep lower 4 bits of Health/Health+1 in A.
    rts

;---------------------------[ NMI and PPU control routines ]--------------------------------

; Wait for the NMI to end.
WaitNMIPass:
    ;Indicate currently in NMI.
    jsr ClearNMIStat
    @loop:
        ;Wait for NMI to end before continuing.
        lda NMIStatus
        beq @loop
    rts

ClearNMIStat: ;($C434)
    ;Clear NMI byte to indicate the game is currently running NMI routines.
    lda #$00
    sta NMIStatus
    rts

ScreenOff:
    ; BG & SPR visibility = off
    lda PPUMASK_ZP
    and #~(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b
    ; fallthrough

WriteAndWait: ;($C43D)
    ;Update value to be loaded into PPU control register.
    sta PPUMASK_ZP

WaitNMIPass_:
    ;Indicate currently in NMI.
    jsr ClearNMIStat
    @loop:
        ;Wait for NMI to end before continuing.
        lda NMIStatus
        beq @loop
    rts

ScreenOn:
    ;BG & SPR visibility = on
    lda PPUMASK_ZP
    ora #(PPUMASK_SHOW8BG | PPUMASK_SHOW8OBJ | PPUMASK_BG_ON | PPUMASK_OBJ_ON).b
    bne WriteAndWait ;Branch always

;Update the actual PPU control registers.

WritePPUCtrl:
    ;Update PPU control registers.
    lda PPUCTRL_ZP
    sta PPUCTRL
    lda PPUMASK_ZP
    sta PPUMASK
    lda MirrorCntrl
    ;($C4D9)Setup vertical or horizontal mirroring.
    jsr PrepPPUMirror

ExitSub:
    rts                             ;Exit subroutines.

;Turn off both screen and NMI.

ScreenNmiOff:
    ;BG & SPR visibility = off
    lda PPUMASK_ZP
    and #~(PPUMASK_BG_ON | PPUMASK_OBJ_ON).b
    jsr WriteAndWait                ;($C43D)Wait for end of NMI.

    ;Prepare to turn off NMI in PPU.
    lda PPUCTRL_ZP
    and #~PPUCTRL_VBLKNMI_ON.b
    sta PPUCTRL_ZP
    ;Actually load PPU register with NMI off value.
    sta PPUCTRL
    rts

;The following routine does not appear to be used.

    ;Enable VBlank.
    lda PPUCTRL_ZP
    ora #PPUCTRL_VBLKNMI_ON
    ;Write PPU control register 0 and PPU status byte.
    sta PPUCTRL_ZP
    sta PPUCTRL
    ;Turn sprites and screen on.
    lda PPUMASK_ZP
    ora #PPUMASK_OBJ_ON | PPUMASK_BG_ON | PPUMASK_SHOW8OBJ | PPUMASK_SHOW8BG.b
    bne WriteAndWait ;Branch always.

VBOffAndHorzWrite:
    lda PPUCTRL_ZP
    and #~(PPUCTRL_INCR_DOWN | PPUCTRL_VBLKNMI_ON).b
    ;Horizontal write, disable VBlank.
LC481:
    ;Save new values in the PPU control register and PPU status byte.
    sta PPUCTRL
    sta PPUCTRL_ZP
    rts

NMIOn:
    @loop:
        ;Wait for end of VBlank.
        lda PPUSTATUS
        and #PPUSTATUS_VBLK
        bne @loop
    ;Enable VBlank interrupts.
    lda PPUCTRL_ZP
    ora #PPUCTRL_VBLKNMI_ON
    bne LC481 ;Branch always.

;--------------------------------------[ Timer routines ]--------------------------------------------

;The following routines set the timer and decrement it. The timer is set after Samus dies and
;before the GAME OVER message is dispayed.  The timer is also set while the item pickup music
;is playing.

WaitTimer:
    ;Exit if timer hasn't hit zero yet
    lda Timer3
    bne RTS_C4A9

    lda NextRoutine
    ;Set GameOver as next routine.
    cmp #_id_PrepareGameOver
    beq SetMainRoutine
    ;Set GoPassword as main routine.
    cmp #_id_GoPassword
    beq SetMainRoutine
    ;($D92C)Assume power up was picked up and GameEngine is next routine. Start area music before exiting.
    jsr StartMusic
    lda NextRoutine

SetMainRoutine:
    ;Set next routine to run.
    sta MainRoutine
RTS_C4A9:
    rts

SetTimer:
    ;Set Timer3. Frames to wait is value stored in A*10.
    sta Timer3
    ;Save routine to jump to after Timer3 expires.
    stx NextRoutine
    ;Next routine to run is WaitTimer.
    lda #_id_WaitTimer.b
    bne SetMainRoutine ;Branch always.

;-----------------------------------[ PPU mirroring routines ]---------------------------------------

PrepVertMirror: ;($C4B2)
    ;Prepare to set PPU for vertical mirroring (again).
    nop
    nop
    lda #$47

SetPPUMirror:
    ;Move bit 3 to bit 0 position.
    lsr
    lsr
    lsr
    ;Remove all other bits. Store at address $00.
    and #$01
    sta $00
    ;Load MMC1CTRL_ZP and remove bit 0.
    lda MMC1CTRL_ZP
    and #$FE
    ;Replace bit 0 with stored bit at $00.
    ora $00
    sta MMC1CTRL_ZP
    ;Load new configuration data serially into MMC1CTRL.
    sta MMC1CTRL
    lsr
    sta MMC1CTRL
    lsr
    sta MMC1CTRL
    lsr
    sta MMC1CTRL
    lsr
    sta MMC1CTRL
    rts

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
    ;Exit if zero(no bank switch issued). else Y contains bank#+1.
    ldy SwitchPending
    beq RTS_C50F
    ;($C4E8)Perform bank switch.
    jsr SwitchOK
    ;($C510)Initialize bank switch data.
    jmp GoBankInit

SwitchOK:
    ; clear SwitchPending (so that the bank switch won't be performed every succeeding frame too).
    lda #$00
    sta SwitchPending
    ;Y now contains the bank to switch to.
    dey
    sty CurrentBank

ROMSwitch:
    ;Bank to switch to is stored at location $00.
    tya
    sta $00
    ;Load upper two bits for Reg 3 (they should always be 0).
    lda SwitchUpperBits
    ;Extract bits 3 and 4 and add them to the current bank to switch to.
    and #$18
    ora $00
    ;Store any new bits set in 3 or 4(there should be none).
    sta SwitchUpperBits

;Loads the lower memory page with the bank specified in A.

MMCWritePrgBank:
    ;Write bit 0 of ROM bank #.
    sta MMC1PRG
    ;Write bit 1 of ROM bank #.
    lsr
    sta MMC1PRG
    ;Write bit 2 of ROM bank #.
    lsr
    sta MMC1PRG
    ;Write bit 3 of ROM bank #.
    lsr
    sta MMC1PRG
    ;Write bit 4 of ROM bank #.
    lsr
    sta MMC1PRG
    ;Restore A with current bank number before exiting.
    lda $00
RTS_C50F:
    rts

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

    ;Loads sprite info for stars into RAM $6E00 thru 6E9F.
    ldy #$A0
    LC543:
        lda IntroStarsData-1,y
        sta IntroStarSprite-1,y
        dey
        bne LC543

    jsr InitTitleGFX                ;($C5D7)Load title GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Brinstar memory page.
InitBank1:
    ;GameMode = play.
    lda #$00
    sta GameMode
    ;($C45D)Disable screen and Vblank.
    jsr ScreenNmiOff
    ;Is game engine running? if so, branch.-->
    lda MainRoutine
    cmp #_id_GameEngine
    beq LC56D
        ;Else do some housekeeping first.
        lda #$00 ;_id_AreaInit
        ;Run InitArea routine next.
        sta MainRoutine
        ;Start in Brinstar.
        sta InArea
        ;Make sure game is not paused.
        sta GamePaused
        ;($C1D4)Clear game engine memory addresses.
        jsr ClearRAM_33_DF
        ;($C578)Clear Samus' stats memory addresses.
        jsr ClearSamusStats
    LC56D:
    ;($C4EF)Load Brinstar memory page into lower 16Kb memory.
    ldy #$00
    jsr ROMSwitch
    ;($C604)Load Brinstar GFX.
    jsr InitBrinstarGFX
    ;($C487)Turn on VBlank interrupts.
    jmp NMIOn

ClearSamusStats:
    ;Clears Samus stats(Health, full tanks, game timer, etc.).
    ldy #$0F
    lda #$00
    @loop:
        ;Load $100 thru $10F with #$00.
        sta $0100,y
        dey
        ;Loop 16 times.
        bpl @loop
    rts

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
        sta MetroidRepelSpeed,y                     ;$77F0 thru $77FD.
        dey                             ;
        bpl LC599                       ;
    jsr InitTourianGFX              ;($C645)Load Tourian GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

;Table used by above subroutine and loads the initial data used to describe
;metroid's behavior in the Tourian section of the game.
;Only MetroidLatch0400-0450 are meaningfully written outside of this routine.
MetroidData:
    .byte $F8, $08 ; MetroidRepelSpeed
    .byte $30, $D0, $60, $A0 ; MetroidAccel
    .byte $02, $04 ; MetroidMaxSpeed
    .byte $00, $00, $00, $00, $00, $00 ; MetroidLatch0400-0450

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
    jsr InitRidleyGFX               ;($C69F)Load Ridley GFX.
    jmp NMIOn                       ;($C487)Turn on VBlank interrupts.

InitEndGFX:
    lda #$01                        ;
    sta GameMode                    ;Game is at title/end game.
    jmp InitGFX6                    ;($C6C2)Load end game GFX.

InitTitleGFX:
    ldy #_id_GFX_Title.b
    jsr LoadGFX

LoadSamusGFX:
    ldy #_id_GFX_Samus.b
    jsr LoadGFX

    ;Branch if wearing suit
    lda JustInBailey
    beq @endIf_A
        ;Switch to girl gfx
        ldy #_id_GFX_SamusSuitless.b
        jsr LoadGFX
    @endIf_A:

    ldy #_id_GFX_IntroSprites.b
    jsr LoadGFX

    ldy #_id_GFX_Font_Complete.b
    jsr LoadGFX

    ldy #_id_GFX_Font_Hud.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitBrinstarGFX:
    ldy #_id_GFX_BrinBG1.b
    jsr LoadGFX

    ldy #_id_GFX_CREBG1.b
    jsr LoadGFX

    ldy #_id_GFX_CREBG2.b
    jsr LoadGFX

    ldy #_id_GFX_BrinstarSprites.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitNorfairGFX:
    ldy #_id_GFX_CREBG1.b
    jsr LoadGFX

    ldy #_id_GFX_CREBG2.b
    jsr LoadGFX

    ldy #_id_GFX_NorfBG1.b
    jsr LoadGFX

    ldy #_id_GFX_NorfBG2.b
    jsr LoadGFX

    ldy #_id_GFX_NorfairSprites.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitTourianGFX:
    ldy #_id_GFX_CREBG2.b
    jsr LoadGFX

    ldy #_id_GFX_BossBG.b
    jsr LoadGFX

    ldy #_id_GFX_TourBG.b
    jsr LoadGFX

    ldy #_id_GFX_Zebetite.b
    jsr LoadGFX

    ldy #_id_GFX_TourianFont.b
    jsr LoadGFX

    ldy #_id_GFX_TourianSprites.b
    jsr LoadGFX

    ldy #_id_GFX_Font_Tourian.b
    jsr LoadGFX

    ldy #_id_GFX_ExclamationPoint.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitKraidGFX:
    ldy #_id_GFX_CREBG1.b
    jsr LoadGFX

    ldy #_id_GFX_CREBG2.b
    jsr LoadGFX

    ldy #_id_GFX_BossBG.b
    jsr LoadGFX

    ldy #_id_GFX_KraiBG2.b
    jsr LoadGFX

    ldy #_id_GFX_KraiBG3.b
    jsr LoadGFX

    ldy #_id_GFX_KraidSprites.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitRidleyGFX:
    ldy #_id_GFX_CREBG1.b
    jsr LoadGFX

    ldy #_id_GFX_CREBG2.b
    jsr LoadGFX

    ldy #_id_GFX_BossBG.b
    jsr LoadGFX

    ldy #_id_GFX_RidlBG.b
    jsr LoadGFX

    ldy #_id_GFX_RidleySprites.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitGFX6:
    ldy #_id_GFX_EndingSprites.b
    jsr LoadGFX

    ldy #_id_GFX_TheEndFont.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_0FC0.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

InitPasswordFontGFX:
    ldy #_id_GFX_Font_Complete.b
    jsr LoadGFX

    ldy #_id_GFX_Solid_1FC0.b
    jmp LoadGFX

;The table below contains info for each tile data block in the ROM.
;Each entry is 7 bytes long. The format is as follows:
;byte 0: ROM bank where GFX data is located.
;byte 1-2: 16-bit ROM start address (src).
;byte 3-4: 16-bit PPU start address (dest).
;byte 5-6: data length (16-bit).

GFXInfo:
    ;[SPR]Samus, items.             Entry 0.
    GFXInfoEntry GFX_Samus, $0000
    ;[SPR]Samus in ending.          Entry 1.
    GFXInfoEntry GFX_EndingSprites, $0000
    ;[BGR]Partial font, "The End".  Entry 2.
    GFXInfoEntry GFX_TheEndFont, $1000
    ;[BGR]Brinstar rooms.           Entry 3.
    GFXInfoEntry GFX_BrinBG1, $1000
    ;[BGR]Common Room Elements      Entry 4.
    GFXInfoEntry GFX_CREBG1, $1200
    ;[BGR]More CRE                  Entry 5.
    GFXInfoEntry GFX_CREBG2, $1800
    ;[SPR]Brinstar enemies.         Entry 6.
    GFXInfoEntry GFX_BrinstarSprites, $0C00
    ;[BGR]Norfair rooms.            Entry 7.
    GFXInfoEntry GFX_NorfBG1, $1000
    ;[BGR]More Norfair rooms.       Entry 8.
    GFXInfoEntry GFX_NorfBG2, $1700
    ;[SPR]Norfair enemies.          Entry 9.
    GFXInfoEntry GFX_NorfairSprites, $0C00
    ;[BGR]Boss areas (Kr, Rd, Tr)   Entry 10. (0A)
    GFXInfoEntry GFX_BossBG, $1000
    ;[BGR]Tourian rooms.            Entry 11. (0B)
    GFXInfoEntry GFX_TourBG, $1200
    ;[BGR]Mother Brain room.        Entry 12. (0C)
    GFXInfoEntry GFX_Zebetite, $1900
    ;[BGR]Misc. object.             Entry 13. (0D)
    GFXInfoEntry GFX_TourianFont, $1D00
    ;[SPR]Tourian enemies.          Entry 14. (0E)
    GFXInfoEntry GFX_TourianSprites, $0C00
    ;[BGR]More Kraid Rooms          Entry 15. (0F)
    GFXInfoEntry GFX_KraiBG2, $1700
    ;[BGR]More Kraid Rooms          Entry 16. (10)
    GFXInfoEntry GFX_KraiBG3, $1E00
    ;[SPR]Miniboss I enemies.       Entry 17. (11)
    GFXInfoEntry GFX_KraidSprites, $0C00
    ;[BGR]More Ridley Rooms         Entry 18. (12)
    GFXInfoEntry GFX_RidlBG, $1700
    ;[SPR]Miniboss II enemies.      Entry 19. (13)
    GFXInfoEntry GFX_RidleySprites, $0C00
    ;[SPR]Intro/End sprites.        Entry 20. (14)
    GFXInfoEntry GFX_IntroSprites, $0C00
    ;[BGR]Title.                    Entry 21. (15)
    GFXInfoEntry GFX_Title, $1400
    ;[BGR]Solid tiles.              Entry 22. (16)
    .redef _entryNumber_GFXInfo = _entryNumber_GFXInfo + 1
    .def _id_GFX_Solid_1FC0 = _entryNumber_GFXInfo export
    .byte bank(GFX_Solid)
    .word GFX_Solid, $1FC0, _sizeof_GFX_Solid
    ;[BGR]Complete font.            Entry 23. (17)
    .redef _entryNumber_GFXInfo = _entryNumber_GFXInfo + 1
    .def _id_GFX_Font_Complete = _entryNumber_GFXInfo export
    .byte bank(GFX_Font)
    .word GFX_Font, $1000, $0400
    ;[BGR]Ingame HUD font.          Entry 24. (18)
    .redef _entryNumber_GFXInfo = _entryNumber_GFXInfo + 1
    .def _id_GFX_Font_Hud = _entryNumber_GFXInfo export
    .byte bank(GFX_Font)
    .word GFX_Font, $0A00, $00A0
    ;[SPR]Solid tiles.              Entry 25. (19)
    .redef _entryNumber_GFXInfo = _entryNumber_GFXInfo + 1
    .def _id_GFX_Solid_0FC0 = _entryNumber_GFXInfo export
    .byte bank(GFX_Solid)
    .word GFX_Solid, $0FC0, _sizeof_GFX_Solid
    ;[BGR]Tourian font.             Entry 26. (1A)
    .redef _entryNumber_GFXInfo = _entryNumber_GFXInfo + 1
    .def _id_GFX_Font_Tourian = _entryNumber_GFXInfo export
    .byte bank(GFX_Font)
    .word GFX_Font, $1D00, $02A0
    ;[SPR]Suitless Samus.           Entry 27. (1B)
    GFXInfoEntry GFX_SamusSuitless, $0000
    ;[BGR]Exclaimation point.       Entry 28. (1C)
    GFXInfoEntry GFX_ExclamationPoint, $1F40

;--------------------------------[ Pattern table loading routines ]---------------------------------

;Y contains the GFX header to fetch from the table above, GFXInfo.

LoadGFX:
    ; Set a to (7 * y + 6), offset pointing to the last byte of the GFXInfo entry.
    lda #$FF
    LC7AD:
        clc
        adc #$07
        dey
        bpl LC7AD
    ;Transfer offset into table to Y.
    tay

    ;Copy entries from GFXInfo to $00-$06.
    ldx #$06
    LC7B6:
        lda GFXInfo,y
        sta $00,x
        dey
        dex
        bpl LC7B6

    ;Switch to ROM bank containing the GFX data.
    ldy $00
    jsr ROMSwitch

    ;Set the PPU to increment by 1.
    lda PPUCTRL_ZP
    and #~PPUCTRL_INCR_DOWN.b
    sta PPUCTRL_ZP
    sta PPUCTRL

    jsr CopyGFXBlock                ;($C7D5)Copy graphics into pattern tables.

    ;Switch back to the previous bank.
    ldy CurrentBank
    jmp ROMSwitch


;Writes tile data from ROM to VRAM, according to the gfx header data contained in $00-$06.
CopyGFXBlock:
    ;If data length low byte is #$00, decrement data length high byte before beginning.
    lda $05
    bne @loop
    dec $06
@loop:
    ;Set PPU to destination address for GFX block write.
    lda $04
    sta PPUADDR
    lda $03
    sta PPUADDR
    ;Set offset for GFX data to 0.
    ldy #$00
    @lowLoop:
        ;Copy GFX data byte from ROM to Pattern table.
        lda ($01),y
        sta PPUDATA
        ;Decrement low byte of data length.
        dec $05
        ;Branch if high byte does not need decrementing.
        bne @endIf
            ;Low byte has reached 0. High byte needs decrementing.
            lda $06
            ;If copying complete, branch to exit.
            beq RTS_C800
            ;Decrement high byte
            dec $06
        @endIf:
        ;Increment to next byte to copy.
        iny
        bne @lowLoop
    ;After 256 bytes loaded, increment upper bits of source and destination addresses.
    inc $02
    inc $04
    jmp @loop
RTS_C800:
    rts

;-------------------------------------------[ AreaInit ]---------------------------------------------

AreaInit:
    lda #$00                        ;
    sta ScrollX                     ;Clear ScrollX.
    sta ScrollY                     ;Clear ScrollY.
    lda PPUCTRL_ZP                  ;
    and #$FC                        ;Sets nametable address = $2000.
    sta PPUCTRL_ZP                  ;
    inc MainRoutine                 ;Increment MainRoutine to MoreInit.
    lda Joy1Status                  ;
    and #BUTTON_A | BUTTON_B.b        ;Stores status of both the A and B buttons.
    sta ABStatus                    ;Appears to never be accessed.
    jsr EraseAllSprites             ;($C1A3)Clear all sprite info.
    lda #$10                        ;Prepare to load Brinstar memory page.
    jsr IsEngineRunning             ;($CA18)Check to see if ok to switch lower memory page.

;------------------------------------------[ MoreInit ]---------------------------------------------

MoreInit:
    ldy #_id_Palette00+1.b          ;
    sty PalDataPending              ;Palette data pending = yes.
    ldx #$FF                        ;
    stx SpareMem75                  ;$75 Not referenced ever again in the game.
    inx                             ;X=0.
    stx AtEnding                    ;Not playing ending scenes.
    stx DoorEntryStatus                  ;Samus not in door.
    stx SamusDoorData               ;Samus is not inside a door.
    stx UpdatingProjectile          ;No projectiles need to be updated.
    txa                             ;A=0.

    LC830:
        cpx #(SoundE0-1)-SpareMem7A.b   ;Check to see if more RAM to clear in $7A thru $DE. (should clear $DF, off-by-one bug?)
        bcs LC836                           ;
            sta SpareMem7A.b,x              ;Clear RAM $7A thru $DE.
        LC836:
        cpx #$FF                        ;Check to see if more RAM to clear in $300 thru $3FE. (off-by-one bug)
        bcs LC83D                           ;
            sta ObjAction,x                 ;Clear RAM $300 thru $3FE.
        LC83D:
        inx                             ;
        bne LC830                       ;Loop until all required RAM is cleared.

    jsr ScreenOff                   ;($C439)Turn off Background and visibility.
    jsr ClearNameTables             ;($C158)Clear screen data.
    jsr EraseAllSprites             ;($C1A3)Erase all sprites from sprite RAM.
    jsr DestroyEnemies

    stx ScrollBlockOnNameTable3     ;Clear data about doors on the name tables.
    stx ScrollBlockOnNameTable0     ;
    inx                             ;X=1.
    stx SpareMem30                  ;Not accessed by game.
    inx                             ;X=2.
    stx ScrollDir                   ;Set initial scroll direction as left.
    lda AreaMapPosX            ;Get Samus start x pos on map.
    sta MapPosX                ;
    lda AreaMapPosY            ;Get Samus start y pos on map.
    sta MapPosY                ;

    lda AreaPalToggle               ; Get ??? Something to do with palette switch
    sta PalToggle
    lda #$FF
    sta RoomNumber                  ;Room number = $FF(undefined room).
    jsr CopyAreaPointers    ; copy pointers from ROM to RAM
    jsr GetRoomNum                  ;($E720)Put room number at current map pos in $5A.
    LC86F:
        jsr SetupRoom                   ;($EA2B)
        ldy RoomNumber  ; load room number
        iny
        bne LC86F

    ldy RoomRAMPtr+1.b
    sty $01
    ldy RoomRAMPtr
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

    stx DoorPalChangeDir
    inx          ; X = 1
    stx PalDataPending
    stx SpareMem30                  ;Not accessed by game.
    inc MainRoutine                 ;SamusInit is next routine to run.
    jmp ScreenOn

; CopyAreaPointers
; ========
; Copy 7 16-bit pointers from $959A thru $95A7 to $3B thru $48.

CopyAreaPointers:
    ldx #$0D
    @loop:
        lda AreaPointers+2,x
        sta RoomPtrTable,x
        dex
        bpl @loop
    rts

; DestroyEnemies
; ==============

DestroyEnemies: ;($C8BB)
    lda #$00
    tax
    @loop:
        cpx #(SoundE0-1)-CannonIndex.b
        bcs @endIf_A
            ; clear $97-$DE (should clear $DF, off-by-one bug?)
            sta CannonIndex,x
        @endIf_A:
        ; clear extra enemy RAM, including status
        sta EnsExtra.0.status,x
        pha
        pla
        inx
        bne @loop
    ;Force Samus to have no Metroid stuck to her.
    stx MetroidOnSamus
    jmp GotoClearAllMetroidLatches

; SamusInit
; =========
; Code that sets up Samus, when the game is first started.

SamusInit:
    ;SamusIntro will be executed next frame.
    lda #_id_SamusIntro.b
    sta MainRoutine
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        ;440 frames to fade in Samus(7.3 seconds).
        lda #$2C
    .elif BUILDTARGET == "NES_PAL"
        lda #$26
    .endif
    sta Timer3
    jsr IntroMusic                  ;($CBFD)Start the intro music.
    ldy #_id_Palette13+1.b          ;
    sty ObjAction                   ;Set Samus status as fading onto screen.
    ldx #$00
    stx SamusInvincibleDelay
    dex                             ;X = $FF
    stx PipeBugHoles.0.status
    stx PipeBugHoles.1.status
    stx PipeBugHoles.1.y ; (BUG! those last two should be PipeBugHoles.2.status and PipeBugHoles.3.status)
    stx PipeBugHoles.2.status
    stx EndTimer                    ;Set end timer bytes to #$FF as-->
    stx EndTimer+1                  ;escape timer not currently active.
    stx RinkaSpawners.0.status
    stx RinkaSpawners.1.status
    ldy #$27
    lda InArea
    and #$0F
    beq Lx002                       ;Branch if Samus starting in Brinstar.
        lsr ScrollDir                   ;If not in Brinstar, change scroll direction from left-->
        ldy #$2F                        ;to down. and set PPU for horizontal mirroring.
    Lx002:
    sty MirrorCntrl
    sty MissilePickupQtyMax
    sty EnergyPickupQtyMax
    ;Samus' initial vertical position
    lda AreaSamusY
    sta ObjY
    ;Samus' initial horizontal position
    lda #$80
    sta ObjX
    ;Set Samus' name table position to current name table active in PPU.
    lda PPUCTRL_ZP
    and #$01
    sta ObjHi
    ;Starting health is set to 30 units.
    lda #$00
    sta Health
    lda #$03
    sta Health+1
RTS_C92A:
    rts

;------------------------------------[ Main game engine ]--------------------------------------------

GameEngine:
    jsr ScrollDoor                  ;($E1F1)Scroll doors, if needed. 2 routine calls scrolls-->
    jsr ScrollDoor                  ;($E1F1)twice as fast as 1 routine call.

    lda NARPASSWORD                 ;
    beq LC945                           ;
        lda #$03                        ;The following code is only accessed if -->
        sta Health+1                    ;NARPASSWORD has been entered at the -->
        lda #$FF                        ;password screen. Gives you new health,-->
        sta SamusGear                   ;missiles and every power-up every frame.
        lda #$05                        ;
        sta MissileCount                ;
    LC945:
    jsr UpdateWorld                 ;($CB29)Update Samus, enemies and room tiles.
    lda MiniBossKillDelayFlag       ;
    ora PowerUpDelayFlag            ;Check if mini boss was just killed or powerup aquired.-->
    beq LC95F                           ;If not, branch.
        lda #$00                        ;
        sta MiniBossKillDelayFlag       ;Reset delay indicators.
        sta PowerUpDelayFlag            ;
        .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
            ;Set timer for 240 frames(4 seconds).
            lda #$18
        .elif BUILDTARGET == "NES_PAL"
            lda #$15
        .endif
        ldx #$03                        ;GameEngine routine to run after delay expires
        jsr SetTimer                    ;($C4AA)Set delay timer and game engine routine.
    LC95F:
    lda ObjAction                   ;Check is Samus is dead.
    cmp #sa_Dead2                   ;Is Samus dead?-->
    bne RTS_C92A                    ;exit if not.
    lda ObjAnimDelay                ;Is Samus still exploding?-->
    bne RTS_C92A                    ;Exit if still exploding.
    jsr SilenceMusic                ;Turn off music.
    lda MotherBrainStatus           ;
    cmp #$0A                        ;Is mother brain already dead? If so, branch.
    beq LC97B                           ;
        lda #$04                        ;Set timer for 40 frames (.667 seconds).
        ldx #$04                        ;GameOver routine to run after delay expires.
        jmp SetTimer                    ;($C4AA)Set delay timer and run game over routine.
    LC97B:
    inc MainRoutine                 ;Next routine to run is GameOver.
    rts

;----------------------------------------[ Update age ]----------------------------------------------

;This is the routine which keeps track of Samus' age. It is called in the
;NMI. Basically, this routine just increments a 24-bit variable every
;256th frame. (Except it's not really 24-bit, because the lowest age byte
;overflows at $D0.)

UpdateAge:
    ;Exit if at title/password screen.
    lda GameMode
    bne @RTS

    ;Exit if game engine is notrunning.
    lda MainRoutine
    cmp #_id_GameEngine.b
    bne @RTS

    ;Only update age when FrameCount is zero-->
    ;(which is approx. every 4.266666666667 seconds).
    ldx FrameCount
    bne @RTS

    ;Minor Age = Minor Age + 1.
    inc SamusAge,x
    ;Has Minor Age reached $D0?-->
    lda SamusAge
    cmp #$D0
    ;If not, we're done.-->
    bcc @RTS
    ;Else reset minor age.
    lda #$00
    sta SamusAge
    ;Loop to update the higher bytes of age.
    @loop:
        cpx #$03
        bcs @RTS
        inx
        inc SamusAge,x
        ;Branch if carry to next byte. Else exit.
        beq @loop
@RTS:
    rts

;-------------------------------------------[ Game over ]--------------------------------------------

PrepareGameOver:
    ;GameOver is the next routine to run.
    lda #_id_GameOver.b
    sta TitleRoutine
    ;Prepare to switch to title memory page.
    lda #$00+1
    sta SwitchPending
    ;($C439)Turn screen off.
    jmp ScreenOff

;------------------------------------------[ Pause mode ]--------------------------------------------

PauseMode:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
        ;Load buttons currently being pressed on joypad 2.
        lda Joy2Status
        ; Exit if not both A & UP pressed.
        and #BUTTON_A | BUTTON_UP.b
        eor #BUTTON_A | BUTTON_UP.b
    .elif BUILDTARGET == "NES_CNSUS"
        ;Load buttons currently being pressed on joypad 1.
        lda Joy1Status
        ; Exit if not pressing only SELECT & UP.
        sec
        sbc #BUTTON_SELECT | BUTTON_UP.b
        nop
    .endif
    bne Exit14

    ;Is escape timer active?
    ;Sorry, can't quit if this is during escape scence.
    ldy EndTimer+1
    iny
    bne Exit14

    ;Clear pause game indicator.
    sta GamePaused
    ;Display password is the next routine to run.
    inc MainRoutine

Exit14:
    rts                             ;Exit for routines above and below.

;------------------------------------------[ GoPassword ]--------------------------------------------

GoPassword:
    lda #_id_DisplayPassword.b                        ;DisplayPassword is next routine to run.
    sta TitleRoutine                ;
    lda #$00+1                        ;
    sta SwitchPending               ;Prepare to switch to intro memory page.
    lda NoiseSFXFlag                ;
    ora #sfxNoise_SilenceMusic      ;Silence music.
    sta NoiseSFXFlag                ;
    jmp ScreenOff                   ;($C439)Turn off screen.

;-----------------------------------------[ Samus intro ]--------------------------------------------

SamusIntro:
    ;($C1A3)Clear all sprites off screen.
    jsr EraseAllSprites
    ;Load Samus' fade in status.
    ldy ObjAction
    ;Branch if Intro still playing.
    lda Timer3
    bne LC9F2
        ;Fade in complete.
        ;Make sure item room music is not playing.
        sta ItemRoomMusicStatus
        ;Samus facing forward and can't be hurt.
        lda #sa_Begin
        sta ObjAction
        ;($D92C)Start main music.
        jsr StartMusic
        ;($CB73)Select proper Samus palette.
        jsr SelectSamusPal
        ;Game engine will be called next frame.
        lda #_id_GameEngine.b
        sta MainRoutine
    ;Still fading in.
    LC9F2:
    ;When 310 frames left of intro, display Samus.
    ;Branch if not time to start drawing Samus.
    cmp #$1F
    bcs Exit14
    ;_id_Palette13+1 is beginning of table.
    cmp SamusFadeInTimeTbl-(_id_Palette13+1),y
    ;Every time Timer3 equals one of the entries in the table-->
    bne LCA00
        ;below, change the palette used to color Samus.
        inc ObjAction
        sty PalDataPending
    LCA00:
    ;Is game currently on an odd frame?-->
    ;If not, branch to exit.
    ;Only display Samus on odd frames [the blink effect].
    lda FrameCount
    lsr
    bcc Exit14
    ;Samus front animation is animation to display.-->
    lda #ObjAnim_SamusFront - ObjectAnimIndexTbl.b
    ;($CF6B)while fading in.
    jsr SetSamusAnim
    ;Samus sprites start at Sprite00RAM.
    lda #$00
    sta SpritePagePos
    ;Samus RAM is first set of RAM.
    sta PageIndex
    ;($DE47)Draw Samus on screen.
    jmp AnimDrawObject

;The following table marks the time remaining in Timer3 when a palette change should occur during
;the Samus fade-in sequence. This creates the fade-in effect.

SamusFadeInTimeTbl:
    .byte $1E,$14,$0B,$04,$FF

;---------------------------------[ Check if game engine running ]-----------------------------------

IsEngineRunning:
    ;If Samus is fading in or the wait timer is active, return from routine.
    ldy MainRoutine
    cpy #_id_IncrementRoutine.b
    beq RTS_CA22
    ;Is game engine running? If yes, branch to SwitchBank.
    cpy #_id_GameEngine.b
    beq SwitchBank
RTS_CA22:
    ;Exit if can't switch bank.
    rts

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
    .byte $01+1                       ;Brinstar.
    .byte $02+1                       ;Norfair.
    .byte $04+1                       ;Kraid hideout.
    .byte $03+1                       ;Tourian.
    .byte $05+1                       ;Ridley hideout.

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
        sta SamusData02,y                     ;Saved game 0=$780C, saved game 1=$781C, saved game 2=$782C.
    LCA4C:
    ;If initializing the area at the start of the game, branch to load Samus' saved game info.
    lda MainRoutine
    cmp #_id_MoreInit.b
    beq LoadGameData

SaveGameData:
    ;Save game based on current area Samus is in. Don't know why.
    lda InArea
    jsr SavedDataBaseAddr           ;($CAC6)Find index to unique item history for this saved game.
    ;Prepare to save unique item history which is 64 bytes in length.
    ldy #$3F
    LCA59:
        ;Save unique item history in appropriate saved game slot.
        lda NumberOfUniqueItems,y
        sta ($00),y
        dey
        ;Loop until unique item history transfer complete.
        bpl LCA59
    ;Prepare to save Samus' data.
    ldy SamusDataIndex
    ldx #$00
    LCA66:
        ;Save Samus' data in appropriate saved game slot.
        lda SamusStat00,x
        sta SamusData00,y
        iny
        inx
        cpx #$10
        ;Loop until Samus' data transfer complete.
        bne LCA66
    ;fallthrough

LoadGameData:
    ;Restore A to find appropriate saved game to load.
    pla
    jsr SavedDataBaseAddr           ;($CAC6)Find index to unique item history for this saved game.
    ;Prepare to load unique item history which is 64 bytes in length.
    ldy #$3F
    LCA78:
        ;Loop until unique item history is loaded.
        lda ($00),y
        sta NumberOfUniqueItems,y
        dey
        bpl LCA78
    ;Branch always.
    bmi LCA83
        pha ; unused instruction
    LCA83:
    ;Prepare to load Samus' data.
    ldy SamusDataIndex
    ldx #$00
    LCA88:
        ;Load Samus' data from appropriate saved game slot.
        lda SamusData00,y
        sta SamusStat00,x
        iny
        inx
        cpx #$10
        ;Loop until Samus' data transfer complete.
        bne LCA88
    pla
    rts

GetGameDataIndex:
    ;A contains the save game slot to work on (0, 1 or 2).-->
    ;This number is transferred to the upper four bits to-->
    ;find the offset for Samus' data for this particular-->
    ;saved game (#$00, #$10 or #$20).
    lda DataSlot
    asl
    asl
    asl
    asl
    sta SamusDataIndex
    rts

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
        sta SamusData00,y               ;Erase Samus' data.
        iny                             ;
        inx                             ;
        cpx #$0C                        ;
        bne LCABC                       ;Loop until all data is erased.
    rts

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
    beq RTS_CAEE                       ;Exit if at saved game 0.  No further calculations required.
    LCAE0:
        lda $00                         ;
        clc                             ;
        adc #$40                        ;
        sta $00                         ;Loop to add #$40 to base address of $69B4 in order to find-->
        bcc LCAEB                           ;the proper base address for this saved game data. (save-->
            inc $01                         ;slot 0 = $69B4, save slot 1 = $69F4, save slot 2 = $6A34).
        LCAEB:
        dex
        bne LCAE0
RTS_CAEE:
    rts

;Table used by above subroutine to find base address to load saved game data from. The slot 0
;starts at $69B4, slot 1 starts at $69F4 and slot 2 starts at $6A34.

SavedDataTable:
    .word ItemHistory               ;($69B4)Base for save game slot 0.
    .word ItemHistory               ;($69B4)Base for save game slot 1.
    .word ItemHistory               ;($69B4)Base for save game slot 2.

;----------------------------------------[ Choose ending ]-------------------------------------------

;Determine what type of ending is to be shown, based on Samus' age.
ChooseEnding:
    ldy #$01
    @loop:
        ;If SamusAge+2 anything but #$00, load worst ending(more than 37 hours of gameplay).
        ;(BUG! Should be checking SamusAge+3 here too)
        lda SamusAge+2
        bne @endingFound
        ;If SamusAge+1 is slower or equal to the threshold in AgeTable, confirm ending
        lda SamusAge+1
        cmp AgeTable-1,y
        bcs @endingFound
        ;SamusAge+1 is faster than that threshold
        iny
        ;loop if there exists a better ending to check
        cpy #$05
        bne @loop
        ;this is the best ending, dont loop anymore
@endingFound:
    ;Store the ending number (1..5), 5=best ending
    sty EndingType

    ;Was the best or 2nd best ending achieved? Branch if not (suit stays on)
    lda #$00
    cpy #$04
    bcc @endIf_A
        ;Suit OFF, baby!
        lda #$01
    @endIf_A:
    sta JustInBailey                
    rts

;Table used by above subroutine to determine ending type.
AgeTable:
    .byte $7A                       ;Max. 37 hours
    .byte $16                       ;Max. 6.7 hours
    .byte $0A                       ;Max. 3.0 hours
    .byte $04                       ;Best ending. Max. 1.2 hours

;--------------------------------[ Clear screen data (not used) ]------------------------------------

ClearScreenData:
    ;Turn off screen.
    jsr ScreenOff
    ;Prepare to fill nametable with #$FF.
    lda #$FF
    sta Temp00_FillValue
    ;Clear selected nametable.
    jsr ClearNameTable
    ;Clear sprite data.
    jmp EraseAllSprites

;----------------------------------------------------------------------------------------------------

; ===== THE REAL GUTS OF THE GAME ENGINE! =====

UpdateWorld:
    ;Set start of sprite RAM to $0200.
    ldx #$00
    stx SpritePagePos

    jsr UpdateAllEnemies            ;($F345)Display of enemies.
    jsr UpdateProjectiles           ;($D4BF)Display of bullets/missiles/bombs.
    jsr UpdateSamus                 ;($CC0D)Display/movement of Samus.
    jsr AreaRoutine                 ;($95C3)Area specific routine.
    jsr UpdateElevator              ;($D7B3)Display of elevators.
    jsr UpdateAllStatues            ;($D9D4)Display of Ridley & Kraid statues.
    jsr UpdateAllEnemyExplosions    ; destruction of enemies
    jsr UpdateAllMellows            ; update of Mellow/Memu enemies
    jsr UpdateAllEnProjectiles
    jsr UpdateAllSkreeProjectiles   ; destruction of green spinners
    jsr SamusEnterDoor              ;($8B13)Check if Samus entered a door.
    jsr UpdateAllDoors              ; display of doors
    jsr UpdateAllTileBlasts         ; tile de/regeneration
    jsr CollisionDetection          ; collision detection between entities.
    jsr DisplayBar                  ;($E0C1)Display of status bar.
    jsr UpdateAllPipeBugHoles
    jsr CheckMissileToggle
    jsr UpdateAllPowerUps           ;($DB37)Display of power-up items.
    jsr UpdateTourianItems          ;($FDE3)

;Clear remaining sprite RAM
    ldx SpritePagePos
    lda #$F4
    @loop:
        sta SpriteRAM.0.y,x
        jsr Xplus4       ; X = X + 4
        bne @loop
    rts

;------------------------------------[ Select Samus palette ]----------------------------------------

; Select the proper palette for Samus based on:
; - Is Samus wearing Varia (protective suit)?
; - Is Samus firing missiles or regular bullets?
; - Is Samus with or without suit?

SelectSamusPal: ;$CB73
    ;Temp storage of Y on the stack.
    tya
    pha

    ;CF contains Varia status (1 = Samus has it)
    lda SamusGear
    asl
    asl
    asl
    ;A = 1 if Samus is firing missiles, else 0
    lda MissileToggle
    rol
    ; now a is #$000000mv, where m is missile toggle and v is whether she has varia
    ; offset by first samus palette id (carry is clear)
    adc #_id_Palette01+1.b
    ;In suit? If so, Branch.
    ldy JustInBailey
    beq @endIf
        ;Add #$17 to the palette number to reach "no suit" palettes.
        clc
        adc #_id_Palette18-_id_Palette01.b
    @endIf:
    ;Palette will be written next NMI.
    sta PalDataPending

    ;Restore the contents of y.
    pla
    tay
    rts

;----------------------------------[ Initiate SFX and music routines ]-------------------------------

;Initiate sound effects.

SilenceMusic:
    lda #sfxNoise_SilenceMusic
    bne SFX_SetNoiseSFXFlag

PauseMusic:
    lda #sfxNoise_PauseMusic
    bne SFX_SetNoiseSFXFlag

SFX_SamusWalk:
    lda #sfxNoise_SamusWalk
    bne SFX_SetNoiseSFXFlag

SFX_BombExplode:
    lda #sfxNoise_BombExplode
    bne SFX_SetNoiseSFXFlag

SFX_MissileLaunch:
    lda #sfxNoise_MissileLaunch

SFX_SetNoiseSFXFlag:
    ldx #NoiseSFXFlag - NoiseSFXFlag.b
    beq SFX_SetSoundFlag

SFX_OutOfHole:
    lda #sfxSQ1_OutOfHole
    bne SFX_SetSQ1SFXFlag

SFX_BombLaunch:
    lda #sfxTri_BombLaunch
    bne SFX_SetTriSFXFlag

SFX_SamusJump:
    lda #sfxSQ1_SamusJump
    bne SFX_SetSQ1SFXFlag

SFX_EnemyHit:
    lda #sfxSQ1_EnemyHit
    bne SFX_SetSQ1SFXFlag

SFX_BulletFire:
    lda #sfxSQ1_BulletFire
    bne SFX_SetSQ1SFXFlag

SFX_Metal:
    lda #sfxSQ1_Metal
    bne SFX_SetSQ1SFXFlag

SFX_EnergyPickup:
    lda #sfxSQ1_EnergyPickup
    bne SFX_SetSQ1SFXFlag

SFX_MissilePickup:
    lda #sfxSQ1_MissilePickup

SFX_SetSQ1SFXFlag:
    ldx #SQ1SFXFlag - NoiseSFXFlag.b
    bne SFX_SetSoundFlag

SFX_WaveFire:
    lda #sfxSQ1_WaveFire
    bne SFX_SetSQ1SFXFlag

SFX_ScrewAttack:
    lda #sfxNoise_ScrewAttack
    bne SFX_SetNoiseSFXFlag

SFX_BigEnemyHit:
    lda #sfxTri_BigEnemyHit
    bne SFX_SetTriSFXFlag

SFX_MetroidHit:
    lda #sfxTri_MetroidHit
    bne SFX_SetTriSFXFlag

SFX_BossHit:
    lda #sfxMulti_BossHit
    bne SFX_SetMultiSFXFlag

SFX_Door:
    lda #sfxTri_Door
    bne SFX_SetTriSFXFlag

SFX_SamusHit:
    lda #sfxMulti_SamusHit
    bne SFX_SetMultiSFXFlag

SFX_SamusDie:
    lda #sfxTri_SamusDie
    bne SFX_SetTriSFXFlag

SFX_SetSQ2SFXFlag:
    ldx #SQ2SFXFlag - NoiseSFXFlag.b

SFX_SetSoundFlag:
    ora NoiseSFXFlag,x
    sta NoiseSFXFlag,x
    rts

SFX_SamusBall:
    lda #sfxTri_SamusBall
    bne SFX_SetTriSFXFlag

SFX_Beep:
    lda #sfxTri_Beep

SFX_SetTriSFXFlag:
    ldx #TriSFXFlag - NoiseSFXFlag.b
    bne SFX_SetSoundFlag

;Initiate music

PowerUpMusic:
    lda #sfxMulti_PowerUp
    bne SFX_SetMultiSFXFlag

IntroMusic:
    lda #sfxMulti_Intro

SFX_SetMultiSFXFlag:
    ldx #MultiSFXFlag - NoiseSFXFlag.b
    bne SFX_SetSoundFlag

MotherBrainMusic:
    lda #music_MotherBrain
    bne SFX_SetMusicInitFlag

TourianMusic:
    lda #music_Tourian

SFX_SetMusicInitFlag:
    ldx #MusicInitFlag - NoiseSFXFlag.b
    bne SFX_SetSoundFlag

;--------------------------------------[ Update Samus ]----------------------------------------------

UpdateSamus:
    ;Samus data is located at index #$00.
    ldx #$00
    stx PageIndex
    ;Indicate Samus is the object being updated.
    inx ;x=1.
    stx IsSamus
    jsr GoSamusHandler
    ;Update of Samus complete.
    dec IsSamus
    rts

;Find proper Samus handler routine.
GoSamusHandler: ;($CC1A)
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
    ;Status of joypad 1.
    lda Joy1Status
    ;Remove SELECT & START status bits.
    and #~(BUTTON_SELECT | BUTTON_START).b
    ;Branch if no buttons pressed.
    beq LCC41
        ;($CF5D)Set no horiontal movement and single frame animation.
        ;BUG: fire animation only plays for a single frame.
        ;To fix, use StopHorzMovement instead.
        jsr SetSamusStand_NoFootstep
        lda Joy1Status
    LCC41:
    ;Keep status of DOWN/LEFT/RIGHT.
    and #BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT.b
    ;Branch if any are pressed.
    bne LCC4B
        ;Check if UP was pressed last frame. If not, branch.
        lda Joy1Change
        and #BUTTON_UP
        beq LCC5B
    LCC4B:
    ;($E1E1)Find which directional button is pressed.
    jsr BitScan
    ;Is down pressed? If so, branch.
    cmp #BUTTONBIT_DOWN
    bcs LCC54
        ;1=left, 0=right.
        sta SamusDir
    LCC54:
    ;Load proper Samus status from table below.
    tax
    lda ActionTable,x
    ;Save Samus status.
    sta ObjAction
LCC5B:
    ;Check if fire was just pressed or needs to retrigger.
    ;Branch if FIRE not pressed.
    lda Joy1Change
    ora Joy1Retrig
    asl
    bpl LCC65
        ;($D1EE)Shoot left/right.
        jsr FireWeapon
    LCC65:
    ;Branch if JUMP not pressed.
    bit Joy1Change
    bpl LCC6E
        ;Set Samus status as jumping.
        lda #sa_Jump
        sta ObjAction
    LCC6E:
    ;Prepare to set animation delay to 4 frames.
    lda #$04
    ;($CD6D)Set Samus control data and animation.
    jsr SetSamusData
    ;Is Samus action not in this table? If so, branch to exit.
    lda ObjAction
    cmp #sa_Door
    bcs RTS_CC9X
    ;Select routine below.
    jsr ChooseRoutine
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

SetSamusExplode: ;($CC8B)
    ; this write doesn't serve any purpose
    lda #$50
    sta SamusJumpDsplcmnt
    ; set samus animation to explode
    lda #ObjAnim_SamusExplode - ObjectAnimIndexTbl.b
    jsr SetSamusAnim
    ; a is #$00 here
    sta ObjectCounter
RTS_CC9X:
    rts

SetSamusRun:
    lda #$09
    sta WalkSoundDelay
    ldx #$00
    lda ObjAnimResetIndex
    cmp #ObjAnim_SamusStand - ObjectAnimIndexTbl.b
    beq LCCBX
    inx
    cmp #ObjAnim_SamusPntUp - ObjectAnimIndexTbl.b
    beq LCCBX
        ; Samus is previously in a run animation
        ; turnaround animation
        lda #ObjAnim_SamusFront - ObjectAnimIndexTbl.b
        jsr SetSamusNextAnim
    LCCBX:
    lda RunAnimationTbl,x
    sta ObjAnimResetIndex
    ldx SamusDir
SetSamusRunAccel:
    lda RunAccelerationTbl,x
    sta SamusAccelX
    rts

RunAnimationTbl:
    .byte ObjAnim_SamusRun - ObjectAnimIndexTbl
    .byte ObjAnim_SamusRunPntUp - ObjectAnimIndexTbl

RunAccelerationTbl:
    .byte $30                       ;Accelerate right.
    .byte $D0                       ;Accelerate left.

; SamusRun
; ========

SamusRun:
    ldx SamusDir
    lda SamusAccelY
    beq samL07
        ldy SamusJumpDsplcmnt
        bit ObjSpeedY
        bmi samL01
            ; falling
            ; unspin if SamusJumpDsplcmnt < 24 pixels
            cpy #$18
            bcs samL04
            lda #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
            sta ObjAnimResetIndex
            bcc samL04          ; branch always
        samL01:
        ; jumping
        ; spin if SamusJumpDsplcmnt >= 24 pixels and isn't jump fire (and not aiming up) animation
        cpy #$18
        bcc samL04
        lda ObjAnimResetIndex
        cmp #ObjAnim_SamusJumpFire - ObjectAnimIndexTbl.b
        beq samL02
            lda #ObjAnim_SamusSalto - ObjectAnimIndexTbl.b
            sta ObjAnimResetIndex
        samL02:
        cpy #$20
        bcc samL04
        ; SamusJumpDsplcmnt >= 32 pixels
        ; aim up if up pressed
        lda Joy1Status
        and #BUTTON_UP
        beq samL03
            lda #ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl.b
            sta ObjAnimResetIndex
        samL03:
        ; stop rising if jump not pressed
        bit Joy1Status
        bmi samL04
        jsr StopVertMovement
    samL04:
        ; if running and not aiming, set jump anim
        lda #ObjAnim_SamusRun - ObjectAnimIndexTbl.b
        cmp ObjAnimResetIndex
        bne samL05
            lda #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
            sta ObjAnimResetIndex
        samL05:
        lda SamusInLava
        beq samL06
            ; allows Samus to jump in lava
            lda Joy1Change
            bmi LCD40       ; branch if JUMP pressed
        samL06:
        jsr SamusRun_CheckHorzMovementMidair
        jsr SamusJump_CheckFire
        jsr LCF2E
        ; animate every 2 frames
        lda #$02
        bne SetSamusData       ; branch always
    samL07:
    ; on ground
    lda SamusOnElevator
    bne samL08
        jsr SetSamusRunAccel
    samL08:
    jsr SamusRun_SetAnim
    ; time to play walk sound? branch if not
    dec WalkSoundDelay
    bne samL09
        ; # of frames till next walk sound trigger
        lda #$09
        sta WalkSoundDelay
        jsr SFX_SamusWalk
    samL09:
    jsr LCF2E
     ; branch if JUMP not pressed
    lda Joy1Change
    bpl samL10
    LCD40:
        jsr SetSamusJump
        lda #$12
        sta SamusHorzSpeedMax
        jmp SetSamusData_3FrameAnimDelay

    samL10:
        ; branch if FIRE not pressed
        ora Joy1Retrig
        asl
        bpl samL11
            jsr SamusRun_Fire
        samL11:
        lda Joy1Status
        and #BUTTON_RIGHT | BUTTON_LEFT.b
        bne samL12
            ; stop running
            jsr SetSamusStand
            jmp SetSamusData_3FrameAnimDelay
        samL12:
        jsr BitScan                     ;($E1E1)
        cmp SamusDir
        beq SetSamusData_3FrameAnimDelay
        ; turn around
        sta SamusDir
        jsr SetSamusRun
    SetSamusData_3FrameAnimDelay:
    ; animate every 3 frames
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
        ora #$80 | OAMDATA_PRIORITY.b   ;Attack is active.
        sta ObjectCntrl                 ;
    LCD7E:
    jsr CheckHealthStatus           ;($CDFA)Check if Samus hit, blinking or Health low.
    jsr LavaAndMoveCheck            ;($E269)Check if Samus is in lava or moving.
    lda MetroidOnSamus              ;Is a Metroid stuck to Samus?-->
    beq LCD8C                           ;If not, branch.
        lda #$81 | OAMDATA_PRIORITY.b   ;Metroid on Samus. Turn Samus blue.
        sta ObjectCntrl                 ;
    LCD8C:
    jsr SetMirrorCntrlBit           ;($CD92)Mirror Samus, if necessary.
    jmp ObjDrawFrame                   ;($DE4A)Display Samus.

;---------------------------------[ Set mirror control bit ]-----------------------------------------

SetMirrorCntrlBit:
    ;Facing left=#$01, facing right=#$00.
    lda SamusDir
    ;Move bit 0 to bit 4 position.
    jsr Amul16
    ;Use SamusDir bit to set mirror bit.
    ora ObjectCntrl
    sta ObjectCntrl
    rts

;------------------------------[ Check if screw attack is active ]-----------------------------------

; return carry clear if screw attack is active
; return carry set if no screw attack
IsScrewAttackActive:
    ; default to screw attack inactive (carry flag set).
    sec
    ; return inactive if Samus is not running (spinjumping is a form of running)
    ldy ObjAction
    dey
    bne RTS_CDBE
    ; return inactive if Samus doesn't have the screw attack upgrade
    lda SamusGear
    and #gr_SCREWATTACK
    beq RTS_CDBE
    ; return active if Samus is in the somersaulting animation
    lda ObjAnimResetIndex
    cmp #ObjAnim_SamusSalto - ObjectAnimIndexTbl.b
    beq LCDBB
        ; return inactive if Samus is not in the neutral jump animation
        cmp #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
        sec
        bne RTS_CDBE
        ; samus is in the neutral jump animation
        ; screw attack is active if Samus is moving upwards
        bit ObjSpeedY
        bpl RTS_CDBE
    LCDBB:
    cmp ObjAnimIndex
RTS_CDBE:
    rts

;----------------------------------------------------------------------------------------------------

SamusRun_SetAnim:
    ; X = 1 if up pressed, else 0
    lda Joy1Status
    and #BUTTON_UP
    lsr
    lsr
    lsr
    tax

    lda RunAnimationTbl,x
    cmp ObjAnimResetIndex
    beq RTS_CDBE
    ; aim changed
    jsr SetSamusAnim
    pla
    pla
    jmp SetSamusData_3FrameAnimDelay

SamusRun_Fire:
    ;($D1EE)Shoot left/right.
    jsr FireWeapon
    lda Joy1Status
    and #BUTTON_UP
    bne @aimingUp
        lda #ObjAnim_SamusRunFire - ObjectAnimIndexTbl.b
        sta ObjAnimIndex
        rts

    @aimingUp:
    ; Animation looks weird
    lda ObjAnimIndex
    sec
    sbc ObjAnimResetIndex
    and #$03
    tax
    lda @table,x
    jmp SetSamusNextAnim

; Table used by above subroutine
@table:
    .byte ObjAnim_SamusRunPntUpFire3 - ObjectAnimIndexTbl.b
    .byte ObjAnim_SamusRunPntUpFire1 - ObjectAnimIndexTbl.b
    .byte ObjAnim_SamusRunPntUpFire2 - ObjectAnimIndexTbl.b
    .byte ObjAnim_SamusRunPntUpFire3 - ObjectAnimIndexTbl.b

CheckHealthStatus: ;($CDFA)
    ;Has Samus been hit?
    lda SamusIsHit
    and #$20
    ;If not, branch to check if still blinking from recent hit.
    beq Lx006
        ;Samus has been hit. Set blink for 50 frames.
        lda #$32
        sta SamusInvincibleDelay
        ; default to no knockback
        lda #$FF
        sta SamusKnockbackDir
        lda SamusKnockbackIsBomb
        sta SamusKnockbackIsBomb77
        beq Lx005
            ; play hurt sfx if samus was hurt
            bpl Lx004
                jsr SFX_SamusHit
            Lx004:
            ; write bit 3 of SamusIsHit (direction samus got hit) in SamusKnockbackDir
            lda SamusIsHit
            and #$08
            lsr
            lsr
            lsr
            sta SamusKnockbackDir
        Lx005:
        ; set samus hit y speed
        lda #$FD
        sta ObjSpeedY
        ; set Samus hit gravity.
        lda #$38
        sta SamusAccelY
        ; branch if samus is not dead
        jsr IsSamusDead
        bne Lx006
            ; samus is dead, exit
            jmp CheckHealthBeep
    Lx006:
    ; exit if samus has no i-frames
    lda SamusInvincibleDelay
    beq CheckHealthBeep
    ; samus has i-frames, decrement them
    dec SamusInvincibleDelay
    ; branch if direction is nothing
    ldx SamusKnockbackDir
    inx
    beq Lx009
    ; x is #$01=left or #$02=right
    ; X speed = floor(i-frames / 16) pixels
    jsr Adiv16       ; / 16
    ; check if X speed >= 3, branch if so
    cmp #$03
    bcs Lx007
        ; X speed < 3
        ; reset X subspeed if no X accel
        ldy SamusAccelX
        bne Lx009
        jsr LCF4E
    Lx007:
    ; if left, negate X speed
    dex
    bne Lx008
        jsr TwosComplement              ;($C3D4)
    Lx008:
    ; X speed = A
    sta ObjSpeedX
Lx009:
    ; check if samus should become invisible for her i-frames blinking
    ; exit if samus was hit by a bomb
    lda SamusKnockbackIsBomb77
    bpl CheckHealthBeep
    ; exit on odd frames
    lda FrameCount
    and #$01
    bne CheckHealthBeep

    ; make samus invisible
    tay
    sty ObjAnimDelay
    ldy #$F7
    sty ObjAnimFrame

CheckHealthBeep:
    ; beep if health < 17
    ldy Health+1
    dey
    bmi Lx010
    bne Lx011
    lda Health
    cmp #$70
    bcs Lx011
Lx010:
    ;Only beep every 16th frame.
    lda FrameCount
    and #$0F
    bne Lx011
        jsr SFX_Beep
    Lx011:
    ; clear SamusIsHit
    lda #$00
    sta SamusIsHit
RTS_CE83:
    rts

;----------------------------------------[ Is Samus dead ]-------------------------------------------

IsSamusDead:
    ;Samus is dead. Zero flag is set.
    lda ObjAction
    cmp #sa_Dead
    beq Exit3
    cmp #sa_Dead2
    beq Exit3
    ;Samus not dead. Clear zero flag.
    cmp #sa_Begin
Exit3:
    rts                             ;Exit for routines above and below.

;----------------------------------------[ Subtract health ]-----------------------------------------

SubtractHealth: ; 07:CE92
    ;Check to see if health needs to be changed. If not, branch to exit.
    lda HealthChange
    ora HealthChange+1.b
    beq Exit3
    ;Samus cannot be hurt while she is dead
    jsr IsSamusDead
    beq GotoClearHealthChange
    ;If end escape timer is running, Samus cannot be hurt.
    ldy EndTimer+1
    iny
    beq LCEA6 ;Branch if end escape timer not active.
    GotoClearHealthChange:
        jmp ClearHealthChange           ;($F323)Clear health change values.
    LCEA6:
    ;If mother brain is in the process of dying, receive no damage.
    lda MotherBrainStatus
    cmp #$03
    bcs GotoClearHealthChange

    ;Branch if Samus doesn't have Varia.
    lda SamusGear
    and #gr_VARIA
    beq LCEBF
    ;Samus has Varia, divide damage by 2.
    lsr HealthChange
    lsr HealthChange+1.b
    ;If Health+1 moved a bit into the carry flag while-->
    ;dividing, add #$4F to Health for proper division results.
    bcc LCEBF
    lda #$4F
    adc HealthChange
    sta HealthChange

LCEBF:
    ;Prepare to subtract from Health.
    lda Health
    sta $03
    ;Amount to subtract from Health.
    lda HealthChange
    sec
    ;Perform base 10 subtraction.
    jsr Base10Subtract
    ;Save results.
    sta Health

    ;Prepare to subtract from Health+1.
    lda Health+1
    sta $03
    ;Amount to subtract from Health+1.
    lda HealthChange+1.b
    ;Perform base 10 subtraction.
    jsr Base10Subtract
    ;Save Results.
    sta Health+1

    ;Is Samus health at 0?  If so, branch to begin death routine.
    lda Health
    and #$F0
    ora Health+1
    beq LCEE6
        ;Samus not dead. Branch to exit.
        bcs GotoClearHealthChange_
    LCEE6:
    ;Samus is dead.
    ;Set health to #$00.
    lda #$00
    sta Health
    sta Health+1
    ;Death handler.
    lda #sa_Dead
    sta ObjAction
    ;($CBE2)Start Samus die SFX.
    jsr SFX_SamusDie
    ;($CC8B)Set Samus exlpode routine.
    jmp SetSamusExplode

;----------------------------------------[ Add health ]----------------------------------------------

AddHealth: ; 07:CEF9
    ;Prepare to add to Health.
    lda Health
    sta $03
    ;Amount to add to Health.
    lda HealthChange
    clc
    ;Perform base 10 addition.
    jsr Base10Add
    ;Save results.
    sta Health

    ;Prepare to add to Health+1.
    lda Health+1
    sta $03
    ;Amount to add to Health+1.
    lda HealthChange+1.b
    ;Perform base 10 addition.
    jsr Base10Add
    ;Save results.
    sta Health+1

    ;Move tank count to upper 4 bits.
    lda EnergyTankCount
    jsr Amul16
    ;Set lower 4 bits.
    ora #$0F
    cmp Health+1
    ;Is life less than max? if so, branch.
    bcs @endIf_A
        ;Life is more than max amount.
        ;Set life to max amount.
        and #$F9
        sta Health+1
        lda #$99
        sta Health
    @endIf_A:
GotoClearHealthChange_:
    jmp ClearHealthChange           ;($F323)

;----------------------------------------------------------------------------------------------------

LCF2E:
    ; exit if samus is not touching a solid entity
    lda SamusIsHit
    lsr
    and #$02
    beq RTS_X014
    ; branch if bit 0 of SamusIsHit is set (touch solid entity from the right)
    bcs @else_A
        ; touch from the left
        ; exit if samus accelerates left
        lda SamusAccelX
        bmi RTS_X014
        bpl @endIf_A
    @else_A:
        ; touch from the right
        ; exit if samus accelerates right
        lda SamusAccelX
        bmi @endIf_A
        bne RTS_X014
    @endIf_A:
    ; samus is accelerating towards the solid entity
    ; flip acceleration so that she accelerates away from it
    jsr TwosComplement              ;($C3D4)
    sta SamusAccelX

ClearHorzMvmntData:
    ;Set Samus Horizontal speed to #$00.
    ldy #$00
LCF4E:
    sty ObjSpeedX
    sty SamusSpeedSubPixelX
RTS_X014:
    rts

SetSamusStand:
    lda SamusAccelX              ;Is Samus moving horizontally?-->
    bne SetSamusStand_NoFootstep    ;If so, branch to stop movement.
    jsr SFX_SamusWalk               ;($CB96)Play walk SFX.

SetSamusStand_NoFootstep:
    jsr NoHorzMoveNoDelay           ;($CF81)Clear horizontal movement and animation delay data.
    sty ObjAction                   ;Samus is standing.
    lda Joy1Status                  ;
    and #BUTTON_UP                  ;Is The up button being pressed?-->
    bne SetSamusPntUp               ;If so, branch.
    lda #ObjAnim_SamusStand - ObjectAnimIndexTbl.b            ;Set Samus animation for standing.

SetSamusAnim:
    sta ObjAnimResetIndex           ;Set new animation reset index.

SetSamusNextAnim:
    sta ObjAnimIndex                ;Set new animation data index.
    lda #$00                        ;
    sta ObjAnimDelay                ;New animation to take effect immediately.
    rts

SetSamusPntUp:
    lda #sa_PntUp                   ;
    sta ObjAction                   ;Samus is pointing up.
    lda #ObjAnim_SamusPntUp - ObjectAnimIndexTbl.b            ;
    jsr SetSamusAnim                ;($CF6B)Set new animation values.

NoHorzMoveNoDelay:
    jsr StopHorzMovement               ;($CFB7)Clear all horizontal movement data.
    sty ObjAnimDelay                ;Clear animation delay data.
    rts

SamusRun_CheckHorzMovementMidair:
    lda Joy1Status
    and #BUTTON_RIGHT | BUTTON_LEFT.b
    beq Lx015
        ; pressing right or left
        ; set X accel
        jsr BitScan                     ;($E1E1)
        tax
        jsr SetSamusRunAccel
        ; return if going up
        lda SamusAccelY
        bmi StopHorzMovement@RTS
        ; return if somersaulting
        lda ObjAnimResetIndex
        cmp #ObjAnim_SamusSalto - ObjectAnimIndexTbl.b
        beq StopHorzMovement@RTS
        ; turn around
        stx SamusDir
        lda Table06+1,x
        jmp SetSamusAnim

    Lx015:
    ; not pressing right nor left
    ; return if going up
    lda SamusAccelY
    bmi StopHorzMovement@RTS
    ; return if on ground
    beq StopHorzMovement@RTS
    ; return if not neutral jump
    lda ObjAnimResetIndex
    cmp #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
    bne StopHorzMovement@RTS
    ; fallthrough

StopHorzMovement:
    jsr ClearHorzMvmntData          ;($CF4C)Clear horizontal speed and linear counter.
    sty SamusAccelX              ;Clear horizontal acceleration data.
@RTS:
    rts

SetSamusJumpPntUp:
    ldy #ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl.b
    jmp LCFC5
    SetSamusJump:
        ldy #ObjAnim_SamusJump - ObjectAnimIndexTbl.b
    LCFC5:
    sty ObjAnimResetIndex
    ; - 1 to get ObjAnim_SamusJumpTransition and ObjAnim_SamusJumpPntUpFire respectively
    dey
    sty ObjAnimIndex
    lda #$04
    sta ObjAnimDelay
    lda #$00
    sta SamusJumpDsplcmnt
    lda #$FC
    sta ObjSpeedY
    ldx ObjAction
    dex
    bne Lx017      ; branch if Samus is standing still
    lda SamusGear
    and #gr_SCREWATTACK
    beq Lx017      ; branch if Samus doesn't have Screw Attack
    lda #$00
    sta ScrewAttack0686
    jsr SFX_ScrewAttack
Lx017:
    jsr SFX_SamusJump
    ldy #$18        ; gravity (high value -> low jump)
    lda SamusGear
    and #gr_HIGHJUMP
    beq Lx018      ; branch if Samus doesn't have High Jump
        ldy #$12        ; lower gravity value -> high jump!
    Lx018:
    sty SamusAccelY
    rts

SamusJump:
    lda SamusJumpDsplcmnt
    ; branch if falling down
    bit ObjSpeedY
    bpl Lx019
    ; branch if jumped less than 32 pixels upwards
    cmp #$20
    bcc Lx019
    ; branch if JUMP button still pressed
    bit Joy1Status
    bmi Lx019
    ;($D147)Stop jump (start falling).
    jsr StopVertMovement
Lx019:
    jsr SamusJump_CheckHorzMovement
    jsr LCF2E
    lda Joy1Status
    and #BUTTON_UP     ; UP pressed?
    beq Lx020      ; branch if not
        lda #ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl.b
        sta ObjAnimResetIndex
        lda #sa_PntJump.b      ; "jumping & pointing up" handler
        sta ObjAction
    Lx020:
    jsr SamusJump_CheckFire
    lda SamusInLava
    beq Lx021
    lda Joy1Change
    bpl Lx021      ; branch if JUMP not pressed
    ; jump in lava
    jsr SetSamusJump
    jmp SetSamusData_3FrameAnimDelay

Lx021:
    ; check if touched ground
    lda SamusAccelY
    bne Lx023
    ; touched ground, set stand
    lda ObjAction
    cmp #sa_PntJump
    bne Lx022
        jsr SetSamusPntUp
        bne Lx023
    Lx022:
    jsr SetSamusStand
Lx023:
    lda #$03
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

SamusJump_CheckHorzMovement:
    ; X = 1
    ldx #$01
    ; Y = 0
    ldy #$00
    lda Joy1Status
    lsr
    bcs Lx024      ; branch if RIGHT pressed
    ; X = 0
    dex
    lsr
    bcc Lx027       ; branch if LEFT not pressed
    ; X = -1
    dex
    ; Y = 1
    iny
Lx024:
    ; branch if not turning around
    cpy SamusDir
    beq Lx027
    ; turning around
    lda ObjAction
    cmp #sa_PntJump
    bne Lx025
        ; aiming up
        lda ObjAnimResetIndex
        cmp Table04,y
        bne Lx026
        lda Table04+1,y
        jmp Lx026

    Lx025:
    lda ObjAnimResetIndex
    cmp Table06,y
    bne Lx026
    lda Table06+1,y
Lx026:
    jsr SetSamusAnim
    lda #$08
    sta ObjAnimDelay
    ; SamusDir = Y
    sty SamusDir
Lx027:
    ; ObjSpeedX = X
    stx ObjSpeedX
RTS_X028:
    rts

; Table used by above subroutine

Table06:
    .byte ObjAnim_SamusJump - ObjectAnimIndexTbl
    .byte ObjAnim_SamusJump - ObjectAnimIndexTbl
    .byte ObjAnim_SamusJump - ObjectAnimIndexTbl
Table04:
    .byte ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl
    .byte ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl
    .byte ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl

SamusJump_CheckFire:
    lda Joy1Change
    ora Joy1Retrig
    asl
    bpl RTS_X028      ; exit if FIRE not pressed
    lda ObjAnimResetIndex
    cmp #ObjAnim_SamusJumpPntUp - ObjectAnimIndexTbl.b
    bne @notAimingUp
    jmp FireWeaponUpwards

@notAimingUp:
    jsr FireWeaponForwards
    lda #ObjAnim_SamusJumpFire - ObjectAnimIndexTbl.b
    jmp SetSamusAnim

SetSamusRoll:
    lda SamusGear
    and #gr_MARUMARI
    beq Lx030      ; branch if Samus doesn't have Maru Mari
    lda SamusAccelY
    bne Lx030

;Turn Samus into ball
    ldx SamusDir
    lda #ObjAnim_SamusRoll - ObjectAnimIndexTbl.b
    sta ObjAnimResetIndex
    lda #ObjAnim_SamusRunJump - ObjectAnimIndexTbl.b
    sta ObjAnimIndex
    lda RunAccelerationTbl,x
    sta SamusAccelX
    lda #$01
    sta ScrewAttack0686
    jmp SFX_SamusBall

Lx030:
    lda #sa_Stand
    sta ObjAction
    rts

; SamusRoll
; =========

SamusRoll:
    lda Joy1Change
    and #BUTTON_UP     ; UP pressed?
    bne Lx031      ; branch if yes
        bit Joy1Change  ; JUMP pressed?
        bpl Lx032    ; branch if no
    Lx031:
    lda Joy1Status
    and #BUTTON_DOWN     ; DOWN pressed?
    bne Lx032     ; branch if yes
        ;break out of "ball mode"
        lda ObjRadY
        clc
        adc #$08
        sta ObjRadY
        jsr ObjectCheckMoveUp
        bcc Lx032     ; branch if not possible to stand up
        ; move Samus 11 pixels up
        ldx #$00
        jsr StoreObjectPositionToTemp
        stx Temp05_SpeedX
        lda #-$0B
        sta Temp04_SpeedY
        jsr ApplySpeedToPosition
        jsr LoadObjectPositionFromTemp
        jsr SetSamusStand
        ; set unroll anim (BUG: this is only true if up not pressed)
        dec ObjAnimIndex
        jsr StopVertMovement
        ; unroll anim for 4 frames
        lda #$04
        jmp LD144
    Lx032:
        lda Joy1Change
        jsr BitScan                     ;($E1E1)
        cmp #BUTTONBIT_DOWN
        bcs Lx033
            ; newly pressed right or left, turn around
            sta SamusDir
            lda #ObjAnim_SamusRoll - ObjectAnimIndexTbl.b
            jsr SetSamusAnim
        Lx033:
        ldx SamusDir
        jsr SetSamusRunAccel
        jsr LCF2E
        jsr CheckBombLaunch
        lda Joy1Status
        and #BUTTON_RIGHT | BUTTON_LEFT.b
        bne Lx034
            ; not pressing right or left, stop
            jsr StopHorzMovement
        Lx034:
        ; animate every 2 frames
        lda #$02
    LD144:
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

StopVertMovement: ;($D147)
    ldy #$00
    sty ObjSpeedY
    sty SamusSpeedSubPixelY
    rts

; CheckBombLaunch
; ===============
; This routine is called only when Samus is rolled into a ball.

CheckBombLaunch:
    ; exit if Samus doesn't have Bombs
    lda SamusGear
    lsr
    bcc @RTS
    ; move status of FIRE button to bit 7
    lda Joy1Change
    ora Joy1Retrig
    asl
    ; exit if FIRE not pressed
    bpl @RTS
    ; exit if samus's y speed is < 0.0px/frame or >= 1.0px/frame
    ; exit if samus is on an elevator
    lda ObjSpeedY
    ora SamusOnElevator
    bne @RTS

    ; try object slot D
    ldx #$D0
    lda ObjAction,x
    ; launch bomb if slot available
    beq @bombSlotFound
    ; slot D is occupied, try object slot E
    ldx #$E0
    lda ObjAction,x
    ; launch bomb if slot available
    beq @bombSlotFound
    ; slot E is occupied, try object slot F
    ldx #$F0
    lda ObjAction,x
    ; if slot F is occupied, no bomb slots available, exit
    bne @RTS
    ; slot F is available
@bombSlotFound:
    ; launch bomb... give it same coords as Samus
    lda ObjHi
    sta ObjHi,x
    lda ObjX
    sta ObjX,x
    ; 4 pixels further down than Samus' center
    lda ObjY
    clc
    adc #$04
    sta ObjY,x
    lda #wa_LayBomb
    sta ObjAction,x
    jsr SFX_BombLaunch
@RTS:
    rts

SamusPntUp:
    lda Joy1Status
    and #BUTTON_UP     ; UP still pressed?
    bne Lx037      ; branch if yes
        lda #sa_Stand   ; stand handler
        sta ObjAction
    Lx037:
    lda Joy1Status
    and #BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT.b        ; DOWN, LEFT, RIGHT pressed?
    beq Lx039    ; branch if no
        jsr BitScan                     ;($E1E1)
        cmp #BUTTONBIT_DOWN
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
        .word SetSamusStand
        .word SetSamusRun
        .word ExitSub       ;($C45C)rts
        .word SetSamusRoll
        .word ExitSub       ;($C45C)rts
        .word ExitSub       ;($C45C)rts
        .word SetSamusJumpPntUp
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
    and #BUTTON_UP
    beq FireWeaponForwards
    jmp FireWeaponUpwards


; search for open samus projectile slot
; returns zero flag set if slot was found
; returns slot low byte in y
SearchOpenProjectileSlot:
    ; loop through all samus projectile slots
    ldy #$D0
    @loop:
        lda ProjectileStatus,y
        beq @slotFound
        jsr Yplus16
        bne @loop
    ; all samus projectile slots are occupied
    ; return clear zero flag
    iny
    rts

@slotFound:
    ; found open samus projectile slot
    ; clear ProjectileIsHit
    sta ProjectileIsHit,y
    ; return set zero flag if Samus is not shooting a missile
    lda MissileToggle
    beq @endIf_A
        ; Samus is shooting a missile
        ; return set zero flag if the slot found is $03D0 (missiles can only be in that slot)
        cpy #$D0
    @endIf_A:
    rts


FireWeaponForwards:
    ; exit if there is a metroid on samus
    lda MetroidOnSamus
    bne @exit

    ; search for open samus projectile slot
    jsr SearchOpenProjectileSlot
    ; exit if no slots are available
    bne @exit


    jsr InitBullet
    jsr CheckHorizontalWaveBulletFire
    jsr CheckIceBulletFire
    lda #$0C
    sta ProjectileDieDelay,y
    ldx SamusDir
    lda BulletSpeedXTable,x   ; get bullet speed
    sta ObjSpeedX,y     ; -4 or 4, depending on Samus' direction
    lda #$00
    sta ObjSpeedY,y
    lda #$01
    sta ObjOnScreen,y
    jsr CheckHorizontalMissileLaunch
    ; place bullet at arm cannon
    lda ObjAction,y
    asl
    ora SamusDir
    and #$03
    tax
    lda BulletForwardsOffsetXTable,x
    sta Temp05_SpeedX
    lda #-$06
    sta Temp04_SpeedY
    jsr PlaceBulletAtArmCannon
    ; set bit 7 of HasBeamSFX if Samus has long beam
    lda SamusGear
    and #gr_LONGBEAM
    lsr
    lsr
    lsr
    ror
    ora HasBeamSFX
    sta HasBeamSFX
    ; branch if not regular beam (sound played at CheckHorizontalWaveBulletFire or CheckIceBulletFire)
    ldx ObjAction,y
    dex
    bne @exit
    jsr SFX_BulletFire
@exit:
    ldy #ObjAnim_SamusStandFire - ObjectAnimIndexTbl.b
LD26B:
    tya
    jmp SetSamusNextAnim

BulletForwardsOffsetXTable:
    .byte  $0C, -$0C ;weapon action id is even (wave beam)
    .byte  $08, -$08 ;weapon action id is odd (power beam, ice beam, missiles)
BulletSpeedXTable:
    .byte  $04, -$04

FireWeaponUpwards:
    ; exit if there is a metroid on samus
    lda MetroidOnSamus
    bne @exit

    ; search for open samus projectile slot
    jsr SearchOpenProjectileSlot
    ; exit if no slots are available
    bne @exit

    jsr InitBullet
    jsr CheckVerticalWaveBulletFire
    jsr CheckIceBulletFire
    lda #$0C
    sta ProjectileDieDelay,y
    lda #$FC
    sta ObjSpeedY,y
    lda #$00
    sta ObjSpeedX,y
    lda #$01
    sta ObjOnScreen,y
    jsr CheckVerticalMissileLaunch
    ; place bullet at arm cannon
    ldx SamusDir
    lda BulletUpwardsOffsetXTable,x
    sta Temp05_SpeedX
    lda ObjAction,y
    and #$01
    tax
    lda BulletUpwardsOffsetYTable,x
    sta Temp04_SpeedY
    jsr PlaceBulletAtArmCannon
    ; set bit 7 of HasBeamSFX if Samus has long beam
    lda SamusGear
    and #gr_LONGBEAM
    lsr
    lsr
    lsr
    ror
    ora HasBeamSFX
    sta HasBeamSFX
    ; branch if not regular beam (sound played at CheckVerticalWaveBulletFire or CheckIceBulletFire)
    lda ObjAction,y
    cmp #$01
    bne @exit
    jsr SFX_BulletFire
@exit:
    ldx SamusDir
    ldy StandAimUpFireAnimTbl,x
    lda SamusAccelY
    beq Lx045
        ldy AimUpFireMidairAnimTbl,x
    Lx045:
    lda ObjAction
    cmp #$01
    beq RTS_X046
    jmp LD26B

; Table used by above subroutine

StandAimUpFireAnimTbl:
    .byte ObjAnim_SamusPntUpFire - ObjectAnimIndexTbl, ObjAnim_SamusPntUpFire - ObjectAnimIndexTbl
AimUpFireMidairAnimTbl:
    .byte ObjAnim_SamusJumpPntUpFire - ObjectAnimIndexTbl, ObjAnim_SamusJumpPntUpFire - ObjectAnimIndexTbl

BulletUpwardsOffsetXTable:
    .byte  $01, -$01
BulletUpwardsOffsetYTable:
    .byte -$14, -$10

InitBullet:
    tya
    tax
    inc ProjectileStatus,x
    lda #$02
    sta ProjectileRadY,y
    sta ProjectileRadX,y
    lda #ObjAnim_RegularBullet - ObjectAnimIndexTbl.b

InitObjAnimIndex:
    sta ObjAnimResetIndex,x
SetObjAnimIndex:
    sta ObjAnimIndex,x
    lda #$00
    sta ObjAnimDelay,x
RTS_X046:
    rts

PlaceBulletAtArmCannon:
    ldx #$00
    jsr StoreObjectPositionToTemp
    tya
    tax
    jsr ApplySpeedToPosition
    txa
    tay
    jmp LoadObjectPositionFromTemp

CheckHorizontalMissileLaunch:
    lda MissileToggle
    beq Exit4       ; exit if Samus not in "missile fire" mode
    cpy #$D0
    bne Exit4
    ldx SamusDir
    lda HorizontalMissileAnims,x
Lx047:
    jsr SetBulletAnim
    jsr SFX_MissileLaunch
    lda #wa_Missile ; missile handler
    sta ObjAction,y
    lda #$FF
    sta ProjectileDieDelay,y     ; # of frames projectile should last
    dec MissileCount
    bne Exit4       ; exit if not the last missile
; Samus has no more missiles left
    dec MissileToggle       ; put Samus in "regular fire" mode
    jmp SelectSamusPal      ; update Samus' palette to reflect this

HorizontalMissileAnims:
    .byte ObjAnim_MissileRight - ObjectAnimIndexTbl
    .byte ObjAnim_MissileLeft - ObjectAnimIndexTbl

CheckVerticalMissileLaunch:
    lda MissileToggle
    beq Exit4
    cpy #$D0
    bne Exit4
    lda #ObjAnim_MissileUp - ObjectAnimIndexTbl.b
    bne Lx047 ; branch always

SetBulletAnim:
    sta ObjAnimIndex,y
    sta ObjAnimResetIndex,y
    lda #$00
    sta ObjAnimDelay,y
Exit4:
    rts

CheckHorizontalWaveBulletFire:
    lda SamusDir
LD35B:
    sta ProjectileWaveDir,y
    bit SamusGear
    bvc Exit4       ; branch if Samus doesn't have Wave Beam
    lda MissileToggle
    bne Exit4
    lda #$00
    sta ProjectileWaveInstrTimer,y
    sta ProjectileAnimDelay,y
    tya
    jsr Adiv32      ; / 32
    lda #$00
    bcs Lx048
    lda #$0C
Lx048:
    sta ProjectileWaveInstrID,y
    lda #wa_WaveBeam
    sta ObjAction,y
    lda #ObjAnim_WaveBeam - ObjectAnimIndexTbl.b
    jsr SetBulletAnim
    jmp SFX_WaveFire

CheckVerticalWaveBulletFire:
    lda #$02
    bne LD35B ; branch always

CheckIceBulletFire:
    lda MissileToggle
    bne Exit4
    lda SamusGear
    bpl Exit4       ; branch if Samus doesn't have Ice Beam
    lda #wa_IceBeam
    sta ObjAction,y
    lda HasBeamSFX
    ora #$01
    sta HasBeamSFX
    jmp SFX_BulletFire

; SamusDoor
; =========

SamusDoor:
    lda DoorEntryStatus
    cmp #$05
    bcc Lx055
; move Samus out of door, how far depends on initial value of DoorDelay
    dec DoorDelay
    bne MoveOutDoor
; done moving
    asl
    bcc Lx049
        lsr
        sta DoorEntryStatus
        bne Lx055
    Lx049:
    ; Why not use DeleteOffscreenRoomSprites?
    jsr Door_DeleteOffscreenEnemies
    jsr Doors_RemoveIfOffScreen
    jsr GotoClearAllMetroidLatches ; if it is defined in the current bank
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
    sta DoorEntryStatus
    jsr StopVertMovement

MoveOutDoor:
    lda SamusDoorDir
    beq Lx054    ; branch if door leads to the right
    ldy ObjX
    bne Lx053
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
    Lx053:
    dec ObjX
    jmp Lx055

Lx054:
    inc ObjX
    bne Lx055
    jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
Lx055:
    jsr CheckHealthStatus           ;($CDFA)Check if Samus hit, blinking or Health low.
    jsr SetMirrorCntrlBit
    jmp ObjDrawFrame       ; display Samus

SamusDead:
    lda #$01
    jmp SetSamusData                ;($CD6D)Set Samus control data and animation.

SamusDead2:
    dec ObjAnimDelay
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
    lda ElevatorType
    bmi Lx059
        lda ObjY
        sec
        sbc ScrollY     ; A = Samus' Y position on the visual screen
        cmp #$84
        bcc Lx057      ; if ScreenY < $84, don't scroll
            jsr ScrollDown  ; otherwise, attempt to scroll
        Lx057:
        ldy ObjY
        cpy #SCRN_VY-1.b        ; wrap-around required?
        bne Lx058
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
            ldy #$FF        ; ObjY will now be 0
        Lx058:
        iny
        sty ObjY
        jmp LD47E
    Lx059:
        lda ObjY
        sec
        sbc ScrollY     ; A = Samus' Y position on the visual screen
        cmp #$64
        bcs Lx060      ; if ScreenY >= $64, don't scroll
            jsr ScrollUp    ; otherwise, attempt to scroll
        Lx060:
        ldy ObjY
        bne Lx061      ; wraparound required? (branch if not)
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
            ldy #SCRN_VY        ; ObjY will now be 239
        Lx061:
        dey
        sty ObjY
        jmp LD47E

Lx062:
    ldy #$00
    sty ObjSpeedY
    cmp #$05
    beq Lx063
    cmp #$07
    beq Lx063
LD47E:
    lda FrameCount
    lsr
    bcc RTS_X064
Lx063:
    jsr SetMirrorCntrlBit           ;($CD92)Mirror Samus, if necessary.
    lda #$01
    jmp AnimDrawObject
RTS_X064:
    rts

Door_DeleteOffscreenEnemies:
    ldx #$60 ; BUG: should be #$50
    sec
    @loop_enemies:
        jsr @deleteEnemy
        txa
        sbc #$20 ; BUG: should be #$10
        tax
        bpl @loop_enemies
    jsr GetNameTableAtScrollDir
    tay
    ldx #_sizeof_PipeBugHoles - _sizeof_PipeBugHoles.0.b
    @loop_pipeBugHoles:
        jsr @deletePipeBugHole
        txa
        sec
        sbc #_sizeof_PipeBugHoles.0
        tax
        bne @loop_pipeBugHoles
@deletePipeBugHole:
    ; delete if offscreen
    tya
    cmp PipeBugHoles.0.hi,x
    bne @@RTS
        lda #$FF
        sta PipeBugHoles.0.status,x
    @@RTS:
    rts

@deleteEnemy:
    ; delete if offscreen
    lda EnData05,x
    and #$02
    bne @@RTS
        sta EnsExtra.0.status,x
    @@RTS:
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
        .word UpdateBullet          ; regular beam
        .word UpdateWaveBullet      ; wave beam
        .word UpdateIceBullet       ; ice beam
        .word UpdateBulletExplode   ; bullet/missile explode
        .word BombInit              ; lay bomb
        .word BombCountdown         ; lay bomb
        .word BombExplode           ; lay bomb
        .word BombInit              ; lay bomb
        .word BombCountdown         ; bomb countdown
        .word BombExplode           ; bomb explode
        .word UpdateBullet          ; missile

UpdateBullet:
    lda #$01
    sta UpdatingProjectile
    jsr UpdateBullet_DeleteIfOffScreen
    jsr UpdateBullet_ExplodeIfHitSprite
    jsr UpdateBullet_CollisionWithBG
CheckBulletStat:
    ldx PageIndex
    bcc @collided
        lda SamusGear
        and #gr_LONGBEAM
        bne DrawBullet  ; branch if Samus has Long Beam
        dec ProjectileDieDelay,x     ; decrement bullet timer
        bne DrawBullet
        lda #$00        ; timer hit 0, kill bullet
        sta ProjectileStatus,x
        beq DrawBullet  ; branch always
    @collided:
    lda ProjectileStatus,x
    beq Lx069
        jsr BulletExplode
DrawBullet:
        lda #$01
        jsr AnimDrawObject
    Lx069:
    dec UpdatingProjectile
    rts

MoveToNextProjectileWaveInstr:
    inc ProjectileWaveInstrID,x
LD522:
    inc ProjectileWaveInstrID,x
    lda #$00
    sta ProjectileWaveInstrTimer,x
    beq Lx071      ; branch always

UpdateWaveBullet:
    lda #$01
    sta UpdatingProjectile
    jsr UpdateBullet_DeleteIfOffScreen
    jsr UpdateBullet_ExplodeIfHitSprite
    ; get movement string depending on wave bullet direction
    lda ProjectileWaveDir,x
    and #$FE
    tay
    lda WaveBulletTrajectoryPointers,y
    sta $0A
    lda WaveBulletTrajectoryPointers+1,y
    sta $0B
Lx071:
    ; get byte from movement string
    ldy ProjectileWaveInstrID,x
    lda ($0A),y
    ; branch if we are not at the end of the movement string
    cmp #$FF
    bne Lx072
        ; we are at the end of the movement string
        ; go back to the beginning and get byte again
        sta ProjectileWaveInstrID,x
        jmp LD522
    Lx072:
    ; a contains the current instruction's duration (always #$01)
    ; move to next instruction if timer == duration
    cmp ProjectileWaveInstrTimer,x
    beq MoveToNextProjectileWaveInstr

    ; timer is not yet == duration
    ; increment timer
    inc ProjectileWaveInstrTimer,x
    ; move to speed byte of instruction
    iny

    ; get y speed from instruction
    lda ($0A),y
    jsr EnemyGetDeltaY_8296
    ; set y speed
    ldx PageIndex
    sta ObjSpeedY,x
    ; get x speed from instruction
    lda ($0A),y
    jsr EnemyGetDeltaX_832F
    ; set x speed
    ldx PageIndex
    sta ObjSpeedX,x

    ; y = x speed
    tay
    ; flip x speed if wave bullet is facing left
    lda ProjectileWaveDir,x
    lsr
    bcc Lx073
        tya
        jsr TwosComplement              ;($C3D4)
        sta ObjSpeedX,x
    Lx073:

    jsr UpdateBullet_CollisionWithBG
    bcs Lx074
        ; move bullet even if collided
        jsr UpdateBullet_Move
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

; UpdateBulletExplode
; =============
; bullet/missile explode

UpdateBulletExplode:
    lda #$01
    sta UpdatingProjectile
    lda ObjAnimFrame,x
    sec
    sbc #$F7
    bne Lx075
    sta ObjAction,x  ; kill bullet
Lx075:
    jmp DrawBullet

UpdateBullet_ExplodeIfHitSprite:
    ; exit if projectile didn't hit anything
    lda ProjectileIsHit,x
    beq Exit5
    ; clear projectile is hit flag
    lda #$00
    sta ProjectileIsHit,x
BulletExplode:
    ; explode the projectile
    lda #ObjAnim_BulletHit - ObjectAnimIndexTbl.b
    ldy ObjAction,x
    cpy #wa_BulletExplode
    beq Exit5
    cpy #wa_Missile
    bne Lx076
    lda #ObjAnim_MissileExplode - ObjectAnimIndexTbl.b
Lx076:
    jsr InitObjAnimIndex
    lda #wa_BulletExplode
Lx077:
    sta ObjAction,x
Exit5:
    rts

UpdateBullet_DeleteIfOffScreen:
    lda ObjOnScreen,x
    lsr
    bcs Exit5
Lx078:
    lda #$00
    beq Lx077   ; branch always

GotoProjectileHitDoorOrStatue:
    jmp ProjectileHitDoorOrStatue

; bullet <--> background crash detection
; return carry clear if collided, set otherwise
UpdateBullet_CollisionWithBG:
    jsr GetObjRoomRAMPtr
    ; get tile id that bullet touches
    ldy #$00
    lda (Temp04_RoomRAMPtr),y
    ; branch if tile id >= #$A0 (air tiles)
    cmp #$A0
    bcs UpdateBullet_Move
    ; tile is solid
    jsr GotoUpdateBullet_CollisionWithMotherBrain
    ; branch if bullet hit solid blank tile
    cmp #$4E
    beq GotoProjectileHitDoorOrStatue
    jsr CheckBlastTile
    bcc RTS_X081
    clc
    jmp IsBlastTile

UpdateBullet_Move:
    ldx PageIndex
    lda ObjSpeedX,x
    sta Temp05_SpeedX
    lda ObjSpeedY,x
    sta Temp04_SpeedY
    jsr StoreObjectPositionToTemp
    jsr ApplySpeedToPosition
    ; delete bullet if out of bounds
    bcc Lx078
LoadObjectPositionFromTemp:
    lda Temp08_PositionY
    sta ObjY,x
    lda Temp09_PositionX
    sta ObjX,x
    lda Temp0B_PositionHi
    and #$01
    bpl Lx080 ; branch always
ToggleObjHi:
        lda ObjHi,x
        eor #$01
    Lx080:
    sta ObjHi,x
RTS_X081:
    rts

; Blast tile ids are #$80-$9F in Brinstar and #$70-$9F in other areas
CheckBlastTile:
    ldy InArea
    cpy #$10
    beq @Brinstar
        cmp #$70
        bcs @RTS
    @Brinstar:
    cmp #$80
@RTS:
    rts

BombInit:
    lda #ObjAnim_BombTick - ObjectAnimIndexTbl.b
    jsr InitObjAnimIndex
    lda #$18        ; fuse length :-)
    sta ProjectileDieDelay,x
    inc ObjAction,x       ; bomb update handler
    DrawBomb:
    lda #$03 ; move to next bomb animation frame every 3 frames
    jmp AnimDrawObject

BombCountdown:
    lda FrameCount
    lsr
    bcc Lx085    ; only update counter on odd frames
    dec ProjectileDieDelay,x
    bne Lx085
    ; countdown is over, time to explode
    lda #ObjAnim_SamusRunPntUp - ObjectAnimIndexTbl.b ; ?
    ldy ObjAction,x
    cpy #wa_BombCount
    bne Lx084
        lda #ObjAnim_BombExplode - ObjectAnimIndexTbl.b
    Lx084:
    jsr InitObjAnimIndex
    inc ObjAction,x
    jsr SFX_BombExplode
Lx085:
    jmp DrawBomb

BombExplode:
    inc ProjectileDieDelay,x
    jsr BombExplosion_CollisionWithBG
    ldx PageIndex
    lda ObjAnimFrame,x
    sec
    sbc #$F7
    bne Lx086
    sta ObjAction,x     ; kill bomb
Lx086:
    jmp DrawBomb

BombExplosion_CollisionWithBG:
    jsr GetObjRoomRAMPtr
    ; store bomb's cart ram pointer at $0B.$0A
    lda Temp04_RoomRAMPtr
    sta $0A
    lda Temp04_RoomRAMPtr+1.b
    sta $0B
    ; bomb center if ProjectileDieDelay == 1
    ldx PageIndex
    ldy ProjectileDieDelay,x
    dey
    beq Lx088
    dey
    bne Lx089
        ; ProjectileDieDelay == 2, bomb 2 tiles up
        lda #$40
        jsr LD78B
        ; branch always
        txa
        bne Lx087
            lda Temp04_RoomRAMPtr
            and #$20
            beq Exit6
        Lx087:
        ; check if underflowed to attributes
        lda Temp04_RoomRAMPtr+1.b
        and #$03
        cmp #$03
        bne Lx088
        lda Temp04_RoomRAMPtr
        cmp #$C0
        bcc Lx088
            ; underflowed to attributes
            ; exit if in horizontal room
            lda ScrollDir
            and #$02
            bne Exit6
            ; skip attributes and check opposite nametable
            lda #$40+$40
            jsr LD78B
    Lx088:
    jsr BombCurrentTile
Exit6:
    rts

Lx089:
    dey
    bne Lx092
        ; ProjectileDieDelay == 3, bomb 2 tiles down
        lda #$40
        jsr LD77F
        ; branch always
        txa
        bne Lx090
            lda Temp04_RoomRAMPtr
            and #$20
            bne Exit6
        Lx090:
        ; check if overflowed to attributes
        lda Temp04_RoomRAMPtr+1.b
        and #$03
        cmp #$03
        bne Lx091
        lda Temp04_RoomRAMPtr
        cmp #$C0
        bcc Lx091
            ; overflowed to attributes
            ; exit if in horizontal room
            lda ScrollDir
            and #$02
            bne Exit6
            ; skip attributes and check opposite nametable
            lda #$40+$40
            jsr LD77F
        Lx091:
        jmp BombCurrentTile
    Lx092:
    dey
    bne Lx095
        ; ProjectileDieDelay == 4, bomb 2 tiles left
        lda #$02
        jsr LD78B
        ; branch always
        txa
        bne Lx093
            lda Temp04_RoomRAMPtr
            lsr
            bcc Exit7
        Lx093:
        lda Temp04_RoomRAMPtr
        and #$1F
        cmp #$1E
        bcc Lx094
            ; underflowed left
            ; exit if in vertical room
            lda ScrollDir
            and #$02
            beq Exit7
            ; check opposite nametable
            lda #$20-$02
            jsr LD77F
            lda Temp04_RoomRAMPtr+1.b
            eor #$04
            sta Temp04_RoomRAMPtr+1.b
        Lx094:
        jmp BombCurrentTile
    Lx095:
    dey
    bne Exit7
        ; ProjectileDieDelay == 5, bomb 2 tiles right
        lda #$02
        jsr LD77F
        ; branch always
        txa
        bne Lx096
            lda Temp04_RoomRAMPtr
            lsr
            bcs Exit7
        Lx096:
        lda Temp04_RoomRAMPtr
        and #$1F
        cmp #$02
        bcs BombCurrentTile
            ; overflowed right
            ; exit if in vertical room
            lda ScrollDir
            and #$02
            beq Exit7
            ; check opposite nametable
            lda #$20-$02
            jsr LD78B
            lda Temp04_RoomRAMPtr+1.b
            eor #$04
            sta Temp04_RoomRAMPtr+1.b
    BombCurrentTile:
    txa
    pha
    ldy #$00
    lda (Temp04_RoomRAMPtr),y
    jsr CheckBlastTile
    bcc Lx097
        cmp #$A0
        bcs Lx097
        jsr IsBlastTile_SkipCheckUpdatingProjectile
    Lx097:
    pla
    tax
Exit7:
    rts

LD77F:
    clc
    adc $0A
    sta Temp04_RoomRAMPtr
    lda $0B
    adc #$00
    jmp LD798

LD78B:
    sta $00
    lda $0A
    sec
    sbc $00
    sta Temp04_RoomRAMPtr
    lda $0B
    sbc #$00
LD798:
    and #$07
    ora #>RoomRAMA.b
    sta Temp04_RoomRAMPtr+1.b
RTS_X098:
    rts

;-------------------------------------[ Get object coordinates ]------------------------------------

GetObjRoomRAMPtr:
    ;Load index into object RAM to find proper object.
    ldx PageIndex
    ;Load and save temp copy of object y coord.
    lda ObjY,x
    sta Temp02_PositionY
    ;Load and save temp copy of object x coord.
    lda ObjX,x
    sta Temp03_PositionX
    ;Load and save temp copy of object nametable.
    lda ObjHi,x
    sta Temp0B_PositionHi
    ;($E96A)Find object position in room RAM.
    jmp MakeRoomRAMPtr

;---------------------------------------------------------------------------------------------------

UpdateElevator:
    ldx #$20
    stx PageIndex
    lda ElevatorStatus-$20,x
    jsr ChooseRoutine ; Pointer table to elevator handlers
        .word ExitSub       ;($C45C) rts
        .word ElevatorIdle
        .word ElevatorScrollXToCenter
        .word ElevatorMove
        .word ElevatorScrollY
        .word ElevatorFade ; fade out samus (vestigial)
        .word ElevatorD8BF
        .word ElevatorFade ; fade in samus (vestigial)
        .word ElevatorMove
        .word ElevatorStop

ElevatorIdle:
    lda SamusOnElevator
    beq DrawElevator
    lda #BUTTON_DOWN
    bit ElevatorType       ; elevator direction in bit 7 (1 = up)
    bpl Lx099
        asl             ; BUTTON_UP
    Lx099:
    and Joy1Status
    beq DrawElevator

    ; start elevator!
    ; clear samus variables
    jsr StopVertMovement
    ; y is #$00 here
    sty ObjAnimDelay
    sty SamusAccelY
    ; clear elevator unused variable
    tya ; a = #$00
    sta ElevatorUnused0328-$20,x
    ; increment elevator routine to ElevatorScrollXToCenter
    inc ElevatorStatus-$20,x
    ; set samus animation
    lda #sa_Elevator
    sta ObjAction
    lda #ObjAnim_SamusFront - ObjectAnimIndexTbl.b
    jsr SetSamusAnim
    ; set samus position to the center of the screen, on top of the elevator
    lda #(SCRN_VX/2).b
    sta ObjX
    lda #(SCRN_VY/2 - 8).b
    sta ObjY
DrawElevator:
    ; only display elevator at odd frames
    lda FrameCount
    lsr
    bcc RTS_X098
    ; display elevator
    jmp ObjDrawFrame

ElevatorScrollXToCenter:
    lda ScrollX
    bne @notCentered
    ; we are centered horizontally
    ; set mirroring to horizontal, to place the nametables in a vertical configuration
    lda MirrorCntrl
    ora #$08
    sta MirrorCntrl
    ; set scrolling to vertical
    lda ScrollDir
    and #$01
    sta ScrollDir
    ; increment elevator routine to ElevatorMove
    inc ElevatorStatus-$20,x
    jmp DrawElevator

@notCentered:
    lda #$80
    sta ObjX
    lda ObjX,x
    sec
    sbc ScrollX
    bmi @scrollRight
        jsr ScrollLeft
        jmp DrawElevator
    @scrollRight:
        jsr ScrollRight
        jmp DrawElevator

ElevatorMove:
    ; branch if elevator going down
    lda ElevatorType-$20,x
    bpl @else_A
        ; move elevator up one pixel
        ; if current pos is 0, set to 240 and toggle hi byte
        ldy ObjY,x
        bne @endIf_B
            jsr ToggleObjHi
            ldy #SCRN_VY
        @endIf_B:
        ; decrement and save
        dey
        tya
        sta ObjY,x
        jmp @endIf_A
    @else_A:
        ; move elevator down one pixel
        ; increment
        inc ObjY,x
        ; if new pos is 240, save as 0 and toggle hi byte
        lda ObjY,x
        cmp #SCRN_VY
        bne @endIf_C
            jsr ToggleObjHi
            lda #$00
            sta ObjY,x
        @endIf_C:
    @endIf_A:
    cmp #$83
    ; move until Y coord = $83
    bne @endIf_D
        ; increment elevator routine to ElevatorScrollY
        inc ObjAction,x
    @endIf_D:
    jmp DrawElevator

ElevatorScrollY:
    ; scroll until ScrollY = 0
    lda ScrollY
    bne ElevScrollRoom
    ; scroll y is 0
    ; set samus animation to fade out
    lda #ObjAnim_SamusFadeOutArea_Reset - ObjectAnimIndexTbl.b
    sta ObjAnimResetIndex
    lda #ObjAnim_SamusFadeOutArea - ObjectAnimIndexTbl.b
    sta ObjAnimIndex
    ; set elevator animation to fade out
    lda #ObjAnim_ElevatorFadeOutArea_Reset - ObjectAnimIndexTbl.b
    sta ElevatorAnimResetIndex-$20,x
    lda #ObjAnim_ElevatorFadeOutArea - ObjectAnimIndexTbl.b
    sta ElevatorAnimIndex-$20,x
    ; increment elevator routine to ElevatorFade
    inc ObjAction,x
    ; set timer for 64 frames (useless)
    ; the timer may have once been checked in ElevatorFade to handle the fade out / fade in, -->
    ; but right now, ElevatorFade runs for a single frame instead of 64 frames. -->
    ; the fade out / fade in plays fully in the FDS version, so it's probably a remnant from that
    lda #$40
    sta Timer1
    jmp DrawElevator

ElevScrollRoom:
    ; branch if elevator going down
    lda ElevatorType-$20,x
    bpl @scrollDown
        jsr ScrollUp
        jmp DrawElevator
    @scrollDown:
        jsr ScrollDown
        jmp DrawElevator

ElevatorFade:
    ; increment elevator routine
    inc ObjAction,x
    ; branch if new elevator routine is not ElevatorMove
    lda ObjAction,x
    cmp #$08
    bne @endIf_A
        lda #_id_ObjFrame_Elevator.b
        sta ElevatorAnimFrame-$20,x
        lda #ObjAnim_SamusFront - ObjectAnimIndexTbl.b
        jsr SetSamusAnim
        jmp DrawElevator
    @endIf_A:
        ; draw elevator by animating it every frame
        lda #$01
        jmp AnimDrawObject

ElevatorD8BF:
    lda ElevatorType-$20,x
    tay
    ; Leads-To-Ending elevator?
    cmp #$8F
    bne @endIf_A
        ; Samus made it! YAY!
        lda #_id_IncrementRoutine.b
        sta MainRoutine
        inc AtEnding
        ldy #$00
        sty RoomPtr
        ; switch to bank 0
        iny
        sty SwitchPending
        ; ending
        lda #_id_EndGame.b
        sta TitleRoutine
        rts
    @endIf_A:

    ; determine destination area
    ; branch if elevator is going down
    tya
    bpl @endIf_B
        ; elevator is going up
        ; default destination is brinstar
        ldy #$00
        ; if the elevator is Norfair/Ridley, destination is norfair
        cmp #$84
        bne @endIf_C
            iny
        @endIf_C:
        tya
    @endIf_B:
    ; destination area is now in the low nybble of y
    ; load destination area bank
    ora #$10
    jsr IsEngineRunning
    ; toggle palette
    lda PalToggle
    eor #(_id_Palette00+1)~(_id_Palette05+1).b
    sta PalToggle
    ; if in tourian, load palette 0, else load palette PalToggle
    ldy InArea
    cpy #$12
    bcc @endIf_D
        lda #_id_Palette00+1.b
    @endIf_D:
    sta PalDataPending
    jsr WaitNMIPass_
    ; update samus palette
    jsr SelectSamusPal
    ;($D92C)Start music.
    jsr StartMusic
    ; turn the screen on (when had it turned off?)
    jsr ScreenOn
    ; copy area pointers
    jsr CopyAreaPointers
    ; clear all enemy slots
    jsr DestroyEnemies
    ; load elevator slot into PageIndex
    ldx #$20
    stx PageIndex
    ; set samus animation to fade in
    lda #ObjAnim_SamusFadeInArea_Reset - ObjectAnimIndexTbl.b
    sta ObjAnimResetIndex
    lda #ObjAnim_SamusFadeInArea - ObjectAnimIndexTbl.b
    sta ObjAnimIndex
    ; set elevator animation to fade in
    lda #ObjAnim_ElevatorFadeInArea_Reset - ObjectAnimIndexTbl.b
    sta ObjAnimResetIndex,x
    lda #ObjAnim_ElevatorFadeInArea - ObjectAnimIndexTbl.b
    sta ObjAnimIndex,x
    ; increment elevator routine to ElevatorFade
    inc ObjAction,x
    ; set timer for 64 frames (useless)
    lda #$40
    sta Timer1
    rts

StartMusic:
    ; branch if we are not in an elevator transition
    lda ElevatorStatus
    cmp #$06
    bne Lx112
        ; we are in an elevator transition
        ; branch if elevator is going up
        lda ElevatorType
        bmi Lx113
    Lx112:
        ; we are not in an elevator transition, or elevator is going down
        ;Load proper bit flag for area music.
        lda AreaMusicFlag
        ldy ItemRoomMusicStatus
        bmi Lx114
        beq Lx114
    Lx113:
        ; elevator is going up, or item room music flag is set
        ;Set flag to play item room music.
        lda #$81
        sta ItemRoomMusicStatus
        lda #music_ItemRoom
    Lx114:
    ;Store music flag info.
    ora MusicInitFlag
    sta MusicInitFlag
    rts

ElevatorStop:
    ; scroll until ScrollY = 0
    lda ScrollY
    bne Lx116
    ; we are at the right height to stop moving
    ; set samus to stand
    lda #sa_Stand
    sta ObjAction
    ; clear samus horizontal movement
    jsr SetSamusStand
    ; set elevator routine to ElevatorIdle
    ldx PageIndex
    lda #$01
    sta ObjAction,x
    ; switch elevator direction
    lda ElevatorType-$20,x
    eor #$80
    sta ElevatorType-$20,x
    ; branch if elevator is now on the lower floor
    bmi Lx115
        ; elevator is now on the upper floor
        ; toggle scrolling to horizontal
        jsr ToggleScroll
        sta MirrorCntrl
    Lx115:
    jmp DrawElevator
Lx116:
    jmp ElevScrollRoom

SamusCollisionWithSolidEntities: ;($D976)
    ;Default to Samus not being on an elevator or on a frozen enemy.
    lda #$00
    sta SamusOnElevator
    sta OnFrozenEnemy

    ; set y to #$00, object slot of samus
    tay
    ldx #$50 ; prepare x for the loop
    ; get samus position
    jsr GetObjectYSlotPosition
    @loop:
        ; branch if enemy is not frozen
        lda EnsExtra.0.status,x
        cmp #enemyStatus_Frozen
        bne @notOnEnemy
        ; branch if samus is not touching enemy
        jsr GetEnemyXSlotPosition
        jsr GetRadiusSumsOfEnXSlotAndObjYSlot
        jsr CheckCollisionOfXSlotAndYSlot
        bcs @notOnEnemy
        ; branch if samus is not on top of enemy
        jsr @isSamusOnTop
        bne @notOnEnemy
            ;Samus is standing on a frozen enemy.
            inc OnFrozenEnemy
            bne @loopExit ; branch always
        @notOnEnemy:
            ; samus is not standing on that enemy
            jsr Xminus16
            bpl @loop
    @loopExit:

    ; exit if there is no elevator
    lda ElevatorStatus
    beq @RTS
    ; exit if samus is not touching the elevator
    ldy #$00
    ldx #$20
    jsr LDC82
    bcs @RTS
    ; exit if samus is not on top of the elevator
    jsr @isSamusOnTop
    bne @RTS
    ;Samus is standing on elevator.
    inc SamusOnElevator
@RTS:
    rts

@isSamusOnTop:
    ; branch if samus is below the enemy
    lda Temp10_DistHi
    and #$02
    bne @isSamusOnTop_no
        ; exit if they overlap by one pixel on the y axis
        ldy Temp11_DistY
        iny
        cpy Temp04_YSlotRadY
        beq Exit8
        ; they overlap by more than a pixel on the y axis
        ; therefore, samus must be touching the sides of the enemy
    @isSamusOnTop_no:
    ; samus is not on top of enemy
    ; update SamusIsHit to reflect collision with frozen enemy
    lda SamusIsHit
    and #$38
    ora Temp10_DistHi
    ora #$40
    sta SamusIsHit
Exit8:
    rts

; UpdateAllStatues
; =============

UpdateAllStatues:
    ; set page index to statues object slot
    lda #$60
    sta PageIndex
    ; exit if no statue present
    ldy StatueStatus
    beq Exit8

    ; branch if statue status is not #$01
    dey
    bne @endIf_A
        ; statue status is #$01
        ; put bg tiles for lowered statues
        ; kraid statue
        ; y is #$00 here
        jsr UpdateStatueBGTiles

        ; ridley statue
        ldy #$01
        jsr UpdateStatueBGTiles

        ; branch if bg tile update has failed
        bcs @endIf_B
            ; bg tile update was successful
            ; increase statue status to #$02
            inc StatueStatus
        @endIf_B:
    @endIf_A:

    ; branch if statue status is not #$02
    ldy StatueStatus
    cpy #$02
    bne @endIf_C
        ; statue status is #$02
        ; branch if kraid statue is not raised
        lda KraidStatueStatus
        bpl @endIf_D
            ; put bg tiles for kraid raised statue
            ldy #$02
            jsr UpdateStatueBGTiles
        @endIf_D:

        ; branch if ridley statue is not raised
        lda RidleyStatueStatus
        bpl @endIf_E
            ; put bg tiles for ridley raised statue
            ldy #$03
            jsr UpdateStatueBGTiles
        @endIf_E:

        ; branch if bg tile update has failed (or if no tile update occurred)
        bcs @endIf_F
            ; bg tile update was successful
            ; increase statue status to #$03
            inc StatueStatus
        @endIf_F:
    @endIf_C:

    ; update kraid statue
    ldx #(KraidStatueStatus-(KraidStatueStatus-$60)).b
    jsr UpdateStatue
    ; update ridley statue
    ldx #(RidleyStatueStatus-(KraidStatueStatus-$60)).b
    jsr UpdateStatue
    ; update bridge to tourian
    jmp UpdateAllStatues_Bridge

UpdateStatue:
    jsr UpdateStatue_Raise
    jsr UpdateStatue_StartRaising
    ; set statue anim frame depending on which statue it is
    txa
    and #$01
    tay
    lda StatueAnimFrameTable,y
    sta StatueAnimFrame
    ; always display statue if statue status is up or not blinking
    lda KraidStatueStatus-$60,x
    beq Lx126
    bmi Lx126
    ; statue is blinking
    ; only display statue at odd frames
    lda FrameCount
    lsr
    bcc RTS_X127
Lx126:
    ; display statue
    jmp ObjDrawFrame

StatueXTable:
    .byte $88 ; Kraid's X position
    .byte $68 ; Ridley's X position
StatueAnimFrameTable:
    .byte _id_ObjFrame_KraidStatue ; Kraid anim frame
    .byte _id_ObjFrame_RidleyStatue ; Ridley anim frame

UpdateStatue_Raise:
    ; exit if statue is raised
    lda KraidStatueRaiseState-$60,x
    bmi RTS_X127

    ; set raise state to not raised
    lda #$01
    sta KraidStatueRaiseState-$60,x
    ; exit if statue isn't moving
    lda KraidStatueY-$60,x
    and #$0F
    beq RTS_X127

    ; set raise state to raising
    inc KraidStatueRaiseState-$60,x
    ; move statue upwards by one pixel
    dec KraidStatueY-$60,x
    ; exit if statue isn't done moving
    lda KraidStatueY-$60,x
    and #$0F
    bne RTS_X127

    ; statue is done moving
    ; set raise state to raised
    lda KraidStatueRaiseState-$60,x
    ora #$80
    sta KraidStatueRaiseState-$60,x
    ; set status to statue up
    sta KraidStatueStatus-$60,x
    ; set raise state to raised (useless)
    inc KraidStatueRaiseState-$60,x
    ; push object slot to stack
    txa
    pha
    ; push #$00 for kraid, #$01 for ridley to stack
    and #$01
    pha
    ; put bg tiles for lowered statue (useless)
    tay
    jsr UpdateStatueBGTiles
    ; put bg tiles for raised statue
    pla
    tay
    iny
    iny
    jsr UpdateStatueBGTiles
    ; restore object slot to x
    pla
    tax
RTS_X127:
    rts

UpdateStatue_StartRaising:
    ; set position of statue object to current statue's position
    lda KraidStatueY-$60,x
    sta StatueY
    txa
    and #$01
    tay
    lda StatueXTable,y
    sta StatueX
    ; branch if statue status is up or not blinking
    lda KraidStatueStatus-$60,x
    beq @exit
    bmi @exit

    ; statue is blinking
    ; branch if statue is raising or raised
    lda KraidStatueRaiseState-$60,x
    cmp #$01
    bne @exit

    ; statue is not raised
    ; branch if statue is not hit
    lda KraidStatueIsHit-$60,x
    beq @exit
        ; statue is hit by samus's weapons
        ; move statue up by one pixel for the first time
        ; thanks to this, UpdateStatue_Raise will know that the statue is moving and will take over for the next 15 pixels
        dec KraidStatueY-$60,x
        ; play raise sfx
        lda TriSFXFlag
        ora #sfxTri_StatueRaise
        sta TriSFXFlag
    @exit:
    ; clear statue is hit flag
    lda #$00
    sta KraidStatueIsHit-$60,x
    rts

; return carry clear if updated successfully
; return carry set on failure
UpdateStatueBGTiles:
    ; set destination pointer low byte
    lda StatueTileBlastRoomRAMPtrLoTable,y
    sta TileBlasts.12.roomRAMPtr
    ; set destination pointer high byte
    lda StatueHi
    asl
    asl
    ora StatueTileBlastRoomRAMPtrHiTable,y
    sta TileBlasts.12.roomRAMPtr+1
    ; set 2x3 tile region of solid blank tiles
    lda #$09
    sta TileBlasts.12.animFrame
    ; set tile blast index to #$C0
    lda #_sizeof_TileBlasts.0*$C.b
    sta PageIndex
    ; update bg tiles
    jsr DrawTileBlast
    ; restore page index to statues object slot
    lda #$60
    sta PageIndex
    rts

; Table used by above subroutine
StatueTileBlastRoomRAMPtrLoTable:
    .byte <$6130 ; non-raised kraid top left corner
    .byte <$60AC ; non-raised ridley top left corner
    .byte <$60F0 ; raised kraid top left corner
    .byte <$606C ; raised ridley top left corner
StatueTileBlastRoomRAMPtrHiTable:
    .byte >$6130
    .byte >$60AC
    .byte >$60F0
    .byte >$606C

UpdateAllStatues_Bridge:
    ; exit if the bridge is already spawned
    lda StatuesBridgeIsSpawned
    bmi Exit0

    ; exit if samus is in a door
    lda DoorEntryStatus
    bne Exit0

    ; exit if either statue is not raised
    lda KraidStatueStatus
    and RidleyStatueStatus
    bpl Exit0

    ; set StatuesBridgeIsSpawned flag to not spawn the bridge again
    sta StatuesBridgeIsSpawned

    ; loop through all 8 blasts to create for the bridge
    ldx #(8-1)*_sizeof_TileBlasts.0.b
    ldy #$08
    @loop:
        ; set tile blast routine to await respawning
        lda #$03
        sta TileBlasts.0.routine,x
        ; set respawn delay to y*2
        tya
        asl
        sta TileBlasts.0.delay,x
        ; set tile blast animation to generic shot block
        lda #$04
        sta TileBlasts.0.type,x
        ; set tile blast nametable pointer
        lda StatueHi
        asl
        asl
        ora #$62
        sta TileBlasts.0.roomRAMPtr+1,x
        tya
        asl
        adc #$08
        sta TileBlasts.0.roomRAMPtr,x
        ; continue looping if there are still more tile blasts to make
        jsr Xminus16
        dey
        bne @loop
Exit0:
    rts

;-------------------------------------------------------------------------------
; CheckMissileToggle
; ==================
; Toggles between bullets/missiles (if Samus has any missiles).

CheckMissileToggle:
    ; exit if Samus has no missiles
    lda MissileCount
    beq Exit0

    ; exit if SELECT was not just pressed and was not auto-fired
    lda Joy1Change
    ora Joy1Retrig
    and #BUTTON_SELECT
    beq Exit0

    ; toggle missiles on/off
    lda MissileToggle
    eor #$01
    sta MissileToggle
    ; update samus's palette
    jmp SelectSamusPal

;-------------------------------------------------------------------------------
; MakeBitMask
; ===========
;In: Y = bit index. Out: A = bit Y set, other 7 bits zero.

MakeBitMask:
    sec
    lda #$00
    @loop:
        rol
        dey
        bpl @loop
RTS_DB36:
    rts

;------------------------------------------[ Update items ]-----------------------------------------

UpdateAllPowerUps:
    ;PowerUp drawing RAM starts at $0340.
    lda #$40
    sta PageIndex
    ;Check first item slot.
    ldx #$00
    jsr UpdateOnePowerUp
    ;Check second item slot.
    ldx #_sizeof_PowerUps.0
    ; fallthrough
UpdateOnePowerUp: ; 07:DB42
    ;First or second item slot index(#$00 or #$08).
    stx ItemIndex
    ;Exit if no item present in item slot(#$FF)
    ldy PowerUps.0.type,x
    iny
    beq RTS_DB36

    ;Store y, x and name table coordinates of power up item.
    lda PowerUps.0.y,x
    sta PowerUpDrawY
    lda PowerUps.0.x,x
    sta PowerUpDrawX
    lda PowerUps.0.hi,x
    sta PowerUpDrawHi
    ;Find object position in room RAM.
    jsr GetObjRoomRAMPtr
    ;Index to proper power up item.
    ldx ItemIndex
    ;Load pointer into room RAM.
    ldy #$00
    lda (Temp04_RoomRAMPtr),y
    ;Exit if power-up is buried inside a solid tile
    cmp #$A0
    bcc RTS_DB36

    ;Load power up type byte and keep only bits 0 thru 3.
    lda PowerUps.0.type,x
    and #$0F
    ;Set bits 4 and 6.
    ora #_id_ObjFrame_BombItem.b
    ;Save index to find object animation.
    sta PowerUpDrawAnimFrame
    ;Change color of item every other frame.
    ;FrameCount/2
    lda FrameCount
    lsr
    ;the 2 LSBs of object control byte change palette of object.
    and #$03
    ;Indicate ObjectCntrl contains valid data by setting MSB.
    ora #$80
    sta ObjectCntrl
    ;Load current index into sprite RAM.
    lda SpritePagePos
    ;Temp save sprite RAM position.
    pha
    lda PowerUps.0.data07,x ;this read is useless
    ;Display power-up
    jsr ObjDrawFrame
    ;Restore sprite page position byte.
    pla
    ;Was power up item successfully drawn? If not, branch to exit.
    cmp SpritePagePos
    beq Exit9
    ;Store sprite page position in x.
    tax
    ;Load index to proper power up data slot.
    ldy ItemIndex
    ;Reload power up type data.
    lda PowerUps.0.type,y
    ;Set power up color for ice beam orb.
    ldy #$01
    ;Is power up item the ice beam? If so, branch.
    cmp #pu_ICEBEAM
    beq LDB9F
    ;Set power up color for long/wave beam orb.
    dey
    ;Is power up item the wave beam? If so, branch.
    cmp #pu_WAVEBEAM
    beq LDB9F
    ;Is power up item the long beam? If not, branch.
    cmp #pu_LONGBEAM
    bne LDBA5
    LDB9F:
        ;Store power up color for beam weapon.
        tya
        sta SpriteRAM.1.attrib,x
        ;Indicate power up obtained is a beam weapon.
        lda #$FF

    LDBA5:
    ;Temporarily store power up type.
    pha
    ;Index to object 0(Samus).
    ldx #$00
    ;Index to object 1(power up).
    ldy #$40
    ;Determine if Samus is touching power up.
    jsr AreObjectsTouching
    ;Carry clear=Samus touching power up. Carry set=not touching.
    ;Restore power up type byte.
    pla
    ; exit if samus is not touching the power-up
    bcs Exit9

    ; samus is touching the power-up
    ;Store power-up type byte in Y.
    tay
    ;($CBF9)Power up obtained! Play power up music.
    jsr PowerUpMusic
    ;X=index to power up item slot.
    ldx ItemIndex
    ;Is item obtained a beam weapon? If so, branch.
    iny
    beq LDBC6
        ;Temp storage of nametable and power-up type in $08 and $09 respectively.
        lda PowerUps.0.hi,x
        sta Temp08_ItemHi
        lda PowerUps.0.type,x
        sta Temp09_ItemType
        ;($DC1C)Get proper X and Y coords of item, save in history.
        jsr GetItemXYPos
    LDBC6:
    ;Get power-up type byte again.
    lda PowerUps.0.type,x
    tay
    ;Is power-up item a missile or energy tank? If so, branch.
    cpy #pu_ENERGYTANK
    bcs MissileEnergyTank
    ;Is item the wave beam or ice beam? If not, branch.
    cpy #pu_WAVEBEAM
    bcc LDBDA
        ;Remove beam weapon data from Samus gear byte.
        ;Since the current item is a beam, it will replace the beam Samus previously had.
        lda SamusGear
        and #~(gr_WAVEBEAM | gr_ICEBEAM).b
        sta SamusGear
    LDBDA:
    ;Create a bit mask for power-up just obtained.
    jsr MakeBitMask
    ;Update Samus gear with new power-up.
    ora SamusGear
    sta SamusGear
LDBE3:
    ;Initiate delay while power up music plays.
    lda #$FF
    sta PowerUpDelayFlag
    ;Clear out item data from RAM.
    sta PowerUps.0.type,x
    ;Is Samus not in an item room? If not, branch.
    ldy ItemRoomMusicStatus
    beq LDBF1
        ;Restart item room music after special item music is done.
        ldy #$01
    LDBF1:
    sty ItemRoomMusicStatus
    ;Set Samus new palette.
    jmp SelectSamusPal

Exit9:
    ;Exit for multiple routines above.
    rts

MissileEnergyTank:
    ;Branch if item is an energy tank.
    beq LDC00
        ;Increase missile capacity by 5.
        lda #$05
        jsr AddToMaxMissiles
        bne LDBE3 ;Branch always.

    LDC00:
    ;Has Samus got 6 energy tanks? If so, she can't have any more.
    lda EnergyTankCount
    cmp #$06
    beq LDC0A
        ;Otherwise give her a new tank.
        inc EnergyTankCount
    LDC0A:
    ;Get tank count and shift into upper nibble.
    lda EnergyTankCount
    jsr Amul16
    ;Set new tank count. Upper health digit set to 9.
    ora #$09
    sta Health+1
    ;Max out low health digit.
    lda #$99
    sta Health
    ;Health is now FULL!
    bne LDBE3 ;Branch always.

;It is possible for the current nametable in the PPU to not be the actual nametable the special item
;is on so this function checks for the proper location of the special item so the item ID can be
;properly calculated.

GetItemXYPos:
    lda MapPosX
MapScrollRoutine:
    ;Temp storage of Samus map position x and y in $07 and $06 respectively.
    ; note that MapPosX and MapPosY are the map position of the edge of the screen ->
    ; that samus is scrolling the screen towards.
    sta Temp07_ItemX
    lda MapPosY
    sta Temp06_ItemY

    ;Load scroll direction and shift LSB into carry bit.
    lda ScrollDir
    lsr
    ;Temp storage of zero flag (scroll vertically or horizontally)
    php
    ;Branch if scrolling up/down.
    beq @else_A
        ; scrolling horizontally
        ;Branch if scrolling left.
        bcc @endIf_A
            ;Scrolling right.
            ;Unless the scroll x offset is 0, the actual room x pos -->
            ;needs to be decremented in order to be correct.
            lda ScrollX
            beq @endIf_A
                dec Temp07_ItemX
                bcs @endIf_A ;Branch always.
    @else_A:
        ; scrolling vertically
        ; branch if scrolling up
        bcc @endIf_A
            ;Scrolling down.
            ;Unless the scroll y offset is 0, the actual room y pos -->
            ;needs to be decremented in order to be correct.
            lda ScrollY
            beq @endIf_A
                dec Temp06_ItemY
    @endIf_A:

    ;now Temp07_ItemX and Temp06_ItemY contain the map position of the top-left corner of the camera

    ;If item is on the same nametable as the camera,-->
    ;then no further adjustment to item x and y position needed.
    lda PPUCTRL_ZP
    eor Temp08_ItemHi
    and #$01
    ;Restore the zero flag and clear the carry bit.
    plp
    clc
    ;If Scrolling up/down, branch to adjust item y position.
    beq @else_B
        ;Scrolling left/right. Make any necessary adjustments to-->
        ;item x position before writing to unique item history.
        adc Temp07_ItemX
        sta Temp07_ItemX
        jmp @endIf_B
    @else_B:
        ;Scrolling up/down. Make any necessary adjustments to-->
        ;item y position before writing to unique item history.
        adc Temp06_ItemY
        sta Temp06_ItemY
    @endIf_B:

    ;($DC67)Create an item ID to put into unique item history.
    jsr CreateItemID
AddItemToHistory:
    ;Store number of unique items in Y.
    ldy NumberOfUniqueItems
    ;Store item ID in unique item history.
    lda Temp06_ItemID
    sta UniqueItemHistory,y
    lda Temp06_ItemID+1.b
    sta UniqueItemHistory+1,y
    ;Add 2 to Y. 2 bytes per unique item.
    iny
    iny
    ;Store new number of unique items.
    sty NumberOfUniqueItems
    rts

;------------------------------------------[ Create item ID ]-----------------------------------------

;The following routine creates a unique two byte item ID number for that item.  The description
;of the format of the item ID number is as follows:
;
;IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
;on world map. See constants.asm for values of IIIIII.
;
;The results are stored in $06(lower byte) and $07(upper byte).

CreateItemID:
    ;Load x map position of item.
    lda Temp07_ItemX
    ;Move lower 3 bytes to upper 3 bytes.
    jsr Amul32
    ;combine Y coordinates into data byte.
    ora Temp06_ItemY
    ;Lower data byte complete. Save in $06.
    sta Temp06_ItemID

    ;Move upper two bits of X coordinate to LSBs.
    lsr Temp07_ItemX
    lsr Temp07_ItemX
    lsr Temp07_ItemX
    ;Load item type bits.
    lda Temp09_ItemType
    ;Move the 6 bits of item type to upper 6 bits of byte.
    asl
    asl
    ;Add upper two bits of X coordinate to byte.
    ora Temp07_ItemX
    ;Upper data byte complete. Save in $07.
    sta Temp06_ItemID+1.b
    rts

;-----------------------------------------------------------------------------------------------------

; carry set = not touching
; carry clear = touching
AreObjectsTouching:
    jsr GetObjectYSlotPosition
LDC82:
    jsr GetObjectXSlotPosition
    jsr GetRadiusSumsOfObjXSlotAndObjYSlot
    jmp CheckCollisionOfXSlotAndYSlot

;The following table is used to rotate the sprites of both Samus and enemies when they explode.

ExplodeRotationTbl:
    .byte $00                            ;No sprite flipping.
    .byte OAMDATA_VFLIP                  ;Flip sprite vertically.
    .byte OAMDATA_VFLIP | OAMDATA_HFLIP  ;Flip sprite vertically and horizontally.
    .byte OAMDATA_HFLIP                  ;Flip sprite horizontally.

; UpdateObjAnim
; =============
; Advance to object's next frame of animation

UpdateObjAnim:
    ldx PageIndex
    ldy ObjAnimDelay,x
    beq Lx130      ; is it time to advance to the next anim frame?
        dec ObjAnimDelay,x     ; nope
        bne RTS_X132   ; exit if still not zero (don't update animation)
    Lx130:
    sta ObjAnimDelay,x     ; set initial anim countdown value
    ldy ObjAnimIndex,x
Lx131:
    lda ObjectAnimIndexTbl,y                ;($8572)Load frame number.
    cmp #$FF        ; has end of anim been reached?
    beq Lx133
    sta ObjAnimFrame,x     ; store frame number
    iny          ; inc anim index
    tya
    sta ObjAnimIndex,x     ; store anim index
RTS_X132:
    rts

Lx133:
    ldy ObjAnimResetIndex,x     ; reset anim frame index
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
;Where AA are the two bits used to control the horizontal and vertical mirroring of the
;sprite and BB are the two bits used control the sprite colors. XXXX is the entry number
;in the PlacePtrTbl used to place the sprite on the screen.

GetSpriteCntrlData:
    ;Clear index into placement data.
    ldy #$00
    sty Temp0F_PlaceIndex

    ;Load control byte from frame pointer data.
    lda (Temp00_FramePtr),y
    sta Temp04_MetaspriteFlipFlags ;Store value in $04 for processing below.
    tax ;Keep a copy of the value in x as well.

    ;Transfer bits 4 and 5 of the control byte into $05 bits 0 and 1(sprite color bits).
    jsr Adiv16                      ;($C2BF)Move upper 4 bits to lower 4 bits.
    and #$03
    sta Temp05_Cntrl
    ;Bits 6 and 7 are transferred into $05 bits 6 and 7(sprite flip bits).
    ;bit 5 is then set(sprite always drawn behind background).
    txa
    and #OAMDATA_HFLIP | OAMDATA_VFLIP.b
    ora #OAMDATA_PRIORITY
    ora Temp05_Cntrl
    sta Temp05_Cntrl

    ;Extract bit from control byte that controls the object mirroring.
    lda ObjectCntrl
    and #OAMDATA_HFLIP>>2.b
    ;Move it to the bit 6 position and use it to flip the horizontal mirroring of the sprite if set.
    asl
    asl
    eor Temp04_MetaspriteFlipFlags
    sta Temp04_MetaspriteFlipFlags
    ;If MSB is set in ObjectCntrl, use its attributes.
    lda ObjectCntrl
    bpl LDCEF
        asl ObjectCntrl
        jsr SpriteAttrsOverride     ;($E038)Use object attributes as priority over sprite attributes.
    LDCEF:
    ;Discard upper nibble so only entry number into PlacePtrTbl remains.
    txa
    and #$0F
    asl ;*2. pointers in PlacePntrTbl are 2 bytes in size.
    ;Transfer to X to use as an index to find proper placement data segment.
    tax
    rts

;-----------------------------------------------------------------------------------------------------

; Post-explosion enemy death handler
LDCF5:
    jsr ClearObjectCntrl            ;($DF2D)Clear object control byte.
    pla
    pla
    ldx PageIndex
LDCFC:
    ; Branch ahead if not in Tourian
    lda InArea
    cmp #$13
    bne Lx135
        ; we are in tourian
        ; never turn into a drop if enemy is a ??? or a rinka
        lda EnsExtra.0.type,x
        cmp #$04
        beq Lx139
        cmp #$02
        beq Lx139
    Lx135:
    ; Branch if boss just killed
    lda EnPrevStatus,x
    asl
    bmi LDD75

    jsr ReadTableAt968B
    sta $00
    jsr LoadTableAt977B ; TableAtL977B[EnemyType[x]]*2
    and #$20
    sta EnsExtra.0.type,x

    ; enemy becomes a pickup
    lda #enemyStatus_Pickup
    sta EnsExtra.0.status,x

    lda #$60
    sta EnData0D,x
    lda RandomNumber1
    cmp #$10
    bcc LDD5B
LDD30:
    and #$07
    tay
    lda ItemDropTbl,y
    sta EnsExtra.0.animFrame,x
    cmp #_id_EnFrame_MissilePickup.b
    bne Lx138
        ; check if spawning a missile pickup is allowed
        ; fail if the quantity of missile pickups spawned in this room has reached the max
        ldy MissilePickupQtyMax
        cpy MissilePickupQtyCur
        beq LDD5B
        ; fail if Samus's missile capacity is 0
        lda MaxMissiles
        beq LDD5B
        ; allow spawning the missile pickup
        inc MissilePickupQtyCur
    RTS_X137:
        rts
    Lx138:
        ; drop type is energy pickup or no pickup
        ; check if spawning an energy pickup is allowed
        ; fail if the quantity of energy pickups spawned in this room has reached the max
        ldy EnergyPickupQtyMax
        cpy EnergyPickupQtyCur
        beq LDD5B

        inc EnergyPickupQtyCur
        ; exit if it is not big energy (small energy pickup)
        cmp #_id_EnFrame_BigEnergyPickup.b
        bne RTS_X137

        ; fail if enemy can't drop big energy
        lsr $00
        bcs RTS_X137

LDD5B:
    ; pickup failed to spawn
    ; if not in tourian, remove enemy
    ldx PageIndex
    lda InArea
    cmp #$13
    beq Lx140
    Lx139:
        jmp RemoveEnemy                  ;($FA18)Free enemy data slot.
    Lx140:
    ; we are in tourian
    ; the pickup must have failed to spawn because the max quantity was hit
    ; (BUG! this assumption is false when skipping the minibosses in NARPASSWORD)
    ; therefore, to force the pickup to spawn anyway, reset the quantities
    lda RandomNumber1
    ; set current quantities to 0
    ldy #$00
    sty EnergyPickupQtyCur
    sty MissilePickupQtyCur
    ; set max quantities to 1
    iny
    sty MissilePickupQtyMax
    sty EnergyPickupQtyMax
    ; try to spawn the pickup again
    bne LDD30

LDD75:
    ; miniboss was just killed
    ; play item get music
    jsr PowerUpMusic
    ; trigger kill delay
    lda InArea
    and #$0F
    sta MiniBossKillDelayFlag
    ; make corresponding miniboss statue blink
    lsr
    tay
    sta KraidStatueStatus-1,y
    ; Samus's missile capacity increases by 75 missiles
    lda #75
    jsr AddToMaxMissiles
    bne LDD5B

DrawEnemy:
    ; branch if enemy frame is not blank
    ldx PageIndex
    lda EnsExtra.0.animFrame,x
    cmp #$F7
    bne DrawEnemy_NotBlank
    ; enemy frame is blank
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.

; AddToMaxMissiles
; ================
; Adds A to both MissileCount & MaxMissiles, storing the new count
; (255 if it overflows)

AddToMaxMissiles:
    ;Temp storage of quantity of missiles to add.
    pha
    ; add to current missile count
    clc
    adc MissileCount
    bcc @endIf_A
        ; cap at 255
        lda #$FF
    @endIf_A:
    sta MissileCount
    pla
    ; add to max missile count
    clc
    adc MaxMissiles
    bcc @endIf_B
        ; cap at 255
        lda #$FF
    @endIf_B:
    sta MaxMissiles
    rts

DrawEnemy_NotBlank:
    ; Y coord
    lda EnY,x
    sta Temp0A_PositionY
    ; X coord
    lda EnX,x
    sta Temp0B_PositionX
    ; hi coord
    lda EnsExtra.0.hi,x
    sta Temp06_PositionHi

    ; load pointer to enemy frame data into $00-$01
    lda EnsExtra.0.animFrame,x
    asl
    tay
    lda (EnmyFrameTbl1Ptr),y
    bcc Lx144
        lda (EnmyFrameTbl2Ptr),y
    Lx144:
    sta Temp00_FramePtr
    iny
    lda (EnmyFrameTbl1Ptr),y
    bcc Lx145
        lda (EnmyFrameTbl2Ptr),y
    Lx145:
    sta Temp00_FramePtr+1.b

    jsr GetSpriteCntrlData          ;($DCC3)Get place pointer index and sprite control data.
    ; load pointer to enemy place data into $02-$03
    tay
    lda (EnmyPlaceTblPtr),y
    sta Temp02_PlacePtr
    iny
    lda (EnmyPlaceTblPtr),y
    sta Temp02_PlacePtr+1.b
    ; branch if place is not EnPlace1
    ldy #$00
    cpx #_id_EnPlace1*2.b
    bne Lx146
        ; place is EnPlace1
        ; therefore, this enemy is exploding

        ; increment explosion timer
        ldx PageIndex
        inc EnSpeedSubPixelY,x
        lda EnSpeedSubPixelY,x
        pha
        ; update h-flip and v-flip of the blown up chunks of the enemy
        and #$03
        tax
        lda Temp05_Cntrl
        and #~(OAMDATA_VFLIP | OAMDATA_HFLIP).b
        ora ExplodeRotationTbl,x
        sta Temp05_Cntrl
        pla
        ; if explosion timer reaches #$19, the enemy has finished exploding
        cmp #$19
        bne Lx146
            ; complete enemy's death
            jmp LDCF5
    Lx146:

    ldx PageIndex
    ; write y radius to EnsExtra.0.radY
    iny ; y = #$01
    lda (Temp00_FramePtr),y
    sta EnsExtra.0.radY,x
    ; write y radius - #$10 to temp $08
    jsr ReduceYRadius
    ; write x radius
    iny
    lda (Temp00_FramePtr),y
    sta EnsExtra.0.radX,x
    ; write x radius to temp $09
    sta Temp09_RadiusX

    ; save y to $11
    iny
    sty Temp11_FrameIndex
    ;Determine if object is within screen boundaries.
    ;x=1 object on screen, x=0 object not on screen
    jsr IsObjectVisible
    ; write this flag in bit 1 of EnData05
    txa
    asl
    sta Temp08_RadiusY
    ldx PageIndex
    lda EnData05,x
    and #$FD
    ora Temp08_RadiusY
    sta EnData05,x
    ; draw enemy if it is on screen
    lda Temp08_RadiusY
    beq GotoClearObjectCntrl
    jmp LDEDE

;----------------------------------------[ Item drop table ]-----------------------------------------

;The following table determines what, if any, items an enemy will drop when it is killed.
;This is the EnFrame of the drop.

ItemDropTbl:
    .byte _id_EnFrame_MissilePickup                       ;Missile.
    .byte _id_EnFrame_SmallEnergyPickup                       ;Energy.
    .byte _id_EnFrame_BigEnergyPickup                       ;No item / big energy.
    .byte _id_EnFrame_MissilePickup                       ;Missile.
    .byte _id_EnFrame_SmallEnergyPickup                       ;Energy.
    .byte _id_EnFrame_BigEnergyPickup                       ;No item / big energy.
    .byte _id_EnFrame_SmallEnergyPickup                       ;Energy.
    .byte _id_EnFrame_BigEnergyPickup                       ;No item / big energy.

;------------------------------------[ Object drawing routines ]-------------------------------------

;The following function effectively sets an object's temporary y radius to #$00 if the object
;is 4 tiles tall or less.  If it is taller, #$10 is subtracted from the temporary y radius.

ReduceYRadius:
    ;Subtract #$10 from object y radius.
    sec
    sbc #$10
     ;If number is still a positive number, branch to store value.
    bcs LDE44
        ;Number is negative.  Set Y radius to #$00.
        lda #$00
    LDE44:
    ;Store result and return.
    sta Temp08_RadiusY
    rts

AnimDrawObject:
    jsr UpdateObjAnim               ;($DC8F)Update animation if needed.

ObjDrawFrame:
    ldx PageIndex                   ;Get index to proper object to work with.
    lda ObjAnimFrame,x              ;
    cmp #$F7                        ;Is the frame valid?-->
    bne LDE56                          ;Branch if yes.
    GotoClearObjectCntrl:
        jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.
    LDE56:
        cmp #_id_ObjFrame_SamusFront.b           ;Is the animation of Samus facing forward?-->
    bne LDE60                           ;If not, branch.

    lda ObjectCntrl                 ;Ensure object mirroring bit is clear so Samus'-->
    and #~(OAMDATA_HFLIP>>2).b      ;sprite appears properly when going up and down-->
    sta ObjectCntrl                 ;elevators.

LDE60:
    lda ObjY,x                      ;
    sta Temp0A_PositionY            ;
    lda ObjX,x                      ;Copy object y and x room position and name table-->
    sta Temp0B_PositionX            ;data into $0A, $0B and $06 respectively.
    lda ObjHi,x                     ;
    sta Temp06_PositionHi           ;
    lda ObjAnimFrame,x              ;Load A with index into ObjFramePtrTable.
    asl                             ;*2. Frame pointers are two bytes.
    tax                             ;X is now the index into the ObjFramePtrTable.
    lda ObjFramePtrTable,x             ;
    sta Temp00_FramePtr             ;
    lda ObjFramePtrTable+1,x           ;Entry from ObjFramePtrTable is stored in $0000.
    sta Temp00_FramePtr+1.b         ;
    jsr GetSpriteCntrlData          ;($DCC3)Get place pointer index and sprite control data.
    lda ObjPlacePtrTable,x             ;
    sta Temp02_PlacePtr             ;
    lda ObjPlacePtrTable+1,x           ;Store pointer from PlacePtrTbl in $0002.
    sta Temp02_PlacePtr+1.b         ;
    lda IsSamus                     ;Is Samus the object being drawn?-->
    beq LDEBC                           ;If not, branch.

;Special case for Samus exploding.
    cpx #_id_ObjPlace7*2.b          ;Is Samus exploding?-->
    bne LDEBC                           ;If not, branch to skip this section of code.
    ldx PageIndex                   ;X=0.
    inc ObjectCounter               ;Incremented every frame during explode sequence.-->
    lda ObjectCounter               ;Bottom two bits used for index into ExplodeRotationTbl.
    pha                             ;Save value of A.
    and #$03                        ;Use 2 LSBs for index into ExplodeRotationTbl.
    tax                             ;
    lda Temp05_Cntrl                ;Drop mirror control bits from sprite control byte.
    and #$3F                        ;
    ora ExplodeRotationTbl,x        ;Use mirror control bytes from table(Base is $DC8B).
    sta Temp05_Cntrl                ;Save modified sprite control byte.
    pla                             ;Restore A
    cmp #$19                        ;After 25 frames, Move on to second part of death-->
    bne LDEBC                           ;handler, else branch to skip the rest of this code.
    ldx PageIndex                   ;X=0.
    lda #sa_Dead2                   ;
    sta ObjAction,x                 ;Move to next part of the death handler.
    lda #$28                        ;
    sta ObjAnimDelay,x                 ;Set animation delay for 40 frames(.667 seconds).
    pla                             ;Pull last return address off of the stack.
    pla                             ;
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte.

LDEBC:
    ldx PageIndex                   ;
    iny                             ;Increment to second frame data byte.
    lda (Temp00_FramePtr),y         ;
    sta ObjRadY,x                   ;Get vertical radius in pixels of object.
    jsr ReduceYRadius               ;($DE3D)Reduce temp y radius by #$10.
    iny                             ;Increment to third frame data byte.
    lda (Temp00_FramePtr),y         ;Get horizontal radius in pixels of object.
    sta ObjRadX,x                   ;
    sta Temp09_RadiusX              ;Temp storage for object x radius.
    iny                             ;Set index to 4th byte of frame data.
    sty Temp11_FrameIndex           ;Store current index into frame data.
    jsr IsObjectVisible             ;($DFDF)Determine if object is within the screen boundaries.
    txa                             ;
    ldx PageIndex                   ;Get index to object.
    sta ObjOnScreen,x               ;Store visibility status of object.
    tax                             ;
    beq LDEE3                           ;Branch if object is not within the screen boundaries.
LDEDE:
    ldx SpritePagePos               ;Load index into next unused sprite RAM segment.
    jmp DrawSpriteObject            ;($DF19)Start drawing object.
LDEE3:
    jmp ClearObjectCntrl            ;($DF2D)Clear object control byte then exit.

WriteSpriteRAM: ;($DEE6)
    ldy Temp0F_PlaceIndex           ;Load index for placement data.
    jsr YDisplacement               ;($DF6B)Get displacement for y direction.
    adc Temp10_ScreenY              ;Add initial Y position.
    sta SpriteRAM.0.y,x               ;Store sprite Y coord.
    dec SpriteRAM.0.y,x               ;Because PPU uses Y + 1 as real Y coord.
    inc Temp0F_PlaceIndex           ;Increment index to next byte of placement data.
    ldy Temp11_FrameIndex           ;Get index to frame data.
    lda (Temp00_FramePtr),y         ;Tile value.
    sta SpriteRAM.0.tileID,x             ;Store tile value in sprite RAM.
    lda ObjectCntrl                 ;
    asl                             ;Move horizontal mirror control byte to bit 6 and-->
    asl                             ;discard all other bits.
    and #OAMDATA_HFLIP                        ;
    eor Temp05_Cntrl              ;Use it to override sprite horz mirror bit.
    sta SpriteRAM.0.attrib,x             ;Store sprite control byte in sprite RAM.
    inc Temp11_FrameIndex           ;Increment to next byte of frame data.
    ldy Temp0F_PlaceIndex           ;Load index for placement data.
    jsr XDisplacement               ;($DFA3)Get displacement for x direction.
    adc Temp0E_ScreenX              ;Add initial X pos
    sta SpriteRAM.0.x,x             ;Store sprite X coord
    inc Temp0F_PlaceIndex           ;Increment to next placement data byte.
    inx                             ;
    inx                             ;
    inx                             ;Advance to next sprite.
    inx                             ;

DrawSpriteObject:
    ldy Temp11_FrameIndex           ;Get index into frame data.

GetNextFrameByte:
    lda (Temp00_FramePtr),y         ;Get next frame data byte.
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

SkipPlacementData: ;($DF32)
    inc Temp0F_PlaceIndex           ;Skip next y and x placement data bytes.
    inc Temp0F_PlaceIndex           ;
    inc Temp11_FrameIndex           ;Increment to next data item in frame data.
    jmp DrawSpriteObject            ;($DF19)Draw next sprite.

GetNewControlByte: ;($DF3B)
    iny                             ;Increment index to next byte of frame data.
    asl ObjectCntrl                 ;If MSB of ObjectCntrl is not set, no overriding of-->
    bcc LDF45                           ;attributes needs to be performed.
        jsr SpriteAttrsOverride         ;($E038)Use object attributes as priority over sprite attributes.
        bne LDF4B                          ;Branch always.
    LDF45:
        lsr ObjectCntrl                 ;Restore MSB of ObjectCntrl.
        lda (Temp00_FramePtr),y         ;
        sta Temp05_Cntrl              ;Save new sprite control byte.
    LDF4B:
    iny                             ;Increment past sprite control byte.
    sty Temp11_FrameIndex           ;Save index of frame data.
    jmp GetNextFrameByte            ;($DF1B)Load next frame data byte.

OffsetObjectPosition:
    iny                             ;Increment index to next byte of frame data.
    lda (Temp00_FramePtr),y         ;This data byte is used to offset the object from-->
    clc                             ;its current y positon.
    adc Temp10_ScreenY              ;
    sta Temp10_ScreenY              ;Add offset amount to object y screen position.
    inc Temp11_FrameIndex           ;
    inc Temp11_FrameIndex           ;Increment past control byte and y offset byte.
    ldy Temp11_FrameIndex           ;
    lda (Temp00_FramePtr),y         ;Load x offset data byte.
    clc                             ;
    adc Temp0E_ScreenX              ;Add offset amount to object x screen position.
    sta Temp0E_ScreenX              ;
    inc Temp11_FrameIndex           ;Increment past x offset byte.
    jmp DrawSpriteObject            ;($DF19)Draw next sprite.

;----------------------------------[ Sprite placement routines ]-------------------------------------

YDisplacement:
    lda (Temp02_PlacePtr),y         ;Load placement data byte.
    tay                             ;
    and #$F0                        ;Check to see if this is placement data for the object-->
    cmp #$80                        ;exploding.  If so, branch.
    beq ExplodeYDisplace                          ;
    tya                             ;Restore placement data byte to A.
LDF75:
    bit Temp04_MetaspriteFlipFlags  ;
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
        adc EnSpeedSubPixelY,y                 ;Increment every frame enemy is exploding. Initial=#$01.
        jmp LDF91                          ;Jump to load explode placement data.


    ;Special case for Samus exploding.
    LDF8F:
        adc ObjectCounter               ;Increments every frame Samus is exploding. Initial=#$01.
    LDF91:
    tay                             ;
    lda ExplodePlacementTbl-1,y     ;Get data from ExplodePlacementTbl.
    pha                             ;Save data on stack.
    lda Temp0F_PlaceIndex           ;Load placement data index.
    clc                             ;
    adc #$0C                        ;Move index forward by 12 bytes. to find y-->
    tay                             ;placement data.
    pla                             ;Restore A with ExplodePlacementTbl data.
    clc                             ;
    adc (Temp02_PlacePtr),y         ;Add table displacements with sprite placement data.
    jmp LDF75                       ;Branch to add y placement values to sprite coords.

XDisplacement:
    lda (Temp02_PlacePtr),y         ;Load placement data byte.
    tay                             ;
    and #$F0                        ;Check to see if this is placement data for the object-->
    cmp #$80                        ;exploding.  If so, branch.
    beq ExplodeXDisplace            ;
    tya                             ;Restore placement data byte to A.
LDFAD:
    bit Temp04_MetaspriteFlipFlags  ;
    bvc LDFB6                           ;Branch if bit 6 cleared, else data is negative displacement.

NegativeDisplacement:
    eor #$FF                        ;
    sec                             ;NOTE:Setting carry makes solution 1 higher than expected.
    adc #$F8                        ;If flip bit is set in $04, this function flips the-->
LDFB6:
    clc                             ;object by using two complement minus 8(Each sprite is-->
    rts                             ;8x8 pixels).

ExplodeXDisplace:
    ldy PageIndex                   ;Load index to proper enemy slot.
    lda EnSpeedSubPixelY,y                 ;Load counter value.
    ldy IsSamus                     ;Is Samus the one exploding?-->
    beq LDFC3                       ;If not, branch.
        lda ObjectCounter               ;Load object counter if it is Samus who is exploding.
    LDFC3:
    asl                             ;*2. Move sprite in x direction 2 pixels every frame.
    pha                             ;Store value on stack.
    ldy Temp0F_PlaceIndex           ;
    lda (Temp02_PlacePtr),y         ;Load placement data byte.
    lsr                             ;
    bcs LDFD2                       ;Check if LSB is set. If not, the byte stored on stack-->
        pla                             ;Will be twos complemented and used to move sprite in-->
        eor #$FF                        ;the negative x direction.
        adc #$01                        ;
        pha                             ;
    LDFD2:
    lda Temp0F_PlaceIndex           ;Load placement data index.
    clc                             ;
    adc #$0C                        ;Move index forward by 12 bytes. to find x-->
    tay                             ;placement data.
    pla                             ;Restore A with x displacement data.
    clc                             ;
    adc (Temp02_PlacePtr),y         ;Add x displacement with sprite placement data.
    jmp LDFAD                       ;Branch to add x placement values to sprite coords.

;---------------------------------[ Check if object is on screen ]----------------------------------

;The following set of functions determine if an object is visible on the screen.  If the object
;is visible, X=1 when the function returns, X=0 if the object is not within the boundaries of the
;current screen.  The function needs to know what nametable is currently in the PPU, what nametable
;the object is on and what the scroll offsets are.

;why is $09 (radius x) used, but not $08 (radius y)?
IsObjectVisible: ;($DFDF)
    ldx #$01                        ;Assume object is visible on screen.
    lda Temp0A_PositionY            ;Object Y position in room.
    tay                             ;
    sec                             ;Subtract y scroll to find sprite's y position on screen.
    sbc ScrollY                     ;
    sta Temp10_ScreenY              ;Store result in $10.
    lda Temp0B_PositionX            ;Object X position in room.
    sec                             ;
    sbc ScrollX                     ;Subtract x scroll to find sprite's x position on screen.
    sta Temp0E_ScreenX              ;Store result in $0E.
    lda ScrollDir                   ;
    and #$02                        ;Is Samus scrolling left or right?-->
    bne HorzScrollCheck             ;($E01C)If so, branch.

VertScrollCheck:
    cpy ScrollY                     ;If object room pos is >= scrollY, set carry.
    lda Temp06_PositionHi           ;Check if object is on different name table as current-->
    eor PPUCTRL_ZP                  ;name table active in PPU.-->
    and #$01                        ;If not, branch.
    beq LE012                       ;
    bcs LE01A                       ;If carry is still set, sprite is not in screen boundaries.
    lda Temp10_ScreenY              ;
    sbc #$0F                        ;Move sprite y position up 15 pixels.
    sta Temp10_ScreenY              ;
    lda Temp09_RadiusX              ;
    clc                             ;If a portion of the object is outside the sceen-->
    adc Temp10_ScreenY              ;boundaries, treat object as if the whole thing is-->
    cmp #$F0                        ;not visible.
    bcc RTS_E01B                    ;
    clc                             ;Causes next statement to branch always.
LE012:
    bcc LE01A                       ;
    lda Temp09_RadiusX              ;If object is on same name table as the current one in-->
    cmp Temp10_ScreenY              ;the PPU, check if part of object is out of screen-->
    bcc RTS_E01B                    ;boundaries.  If so, branch.
LE01A:
    dex                             ;Sprite is not within screen boundaries. Decrement X.
RTS_E01B:
    rts

HorzScrollCheck:
    lda Temp06_PositionHi           ;
    eor PPUCTRL_ZP                  ;Check if object is on different name table as current-->
    and #$01                        ;name table active in PPU.-->
    beq LE02E                       ;If not, branch.
        bcs LE036                   ;If carry is still set, sprite is not in screen boundaries.
        lda Temp09_RadiusX          ;
        clc                         ;If a portion of the object is outside the sceen-->
        adc Temp0E_ScreenX          ;boundaries, treat object as if the whole thing is-->
        bcc RTS_E037                ;not visible.
        clc                         ;Causes next statement to branch always.
    LE02E:
    bcc LE036                       ;
    lda Temp09_RadiusX              ;If object is on same name table as the current one in-->
    cmp Temp0E_ScreenX              ;the PPU, check if part of object is out of screen-->
    bcc RTS_E037                    ;boundaries.  If so, branch.
LE036:
    dex                             ;Sprite is not within screen boundaries. Decrement X.
RTS_E037:
    rts

;------------------------[ Override sprite flip bits with object flip bits ]-------------------------

;If the MSB is set in ObjectCntrl, its attributes take priority over the sprite control bits.
;This function modifies the sprite control byte with any attributes found in ObjectCntrl.

SpriteAttrsOverride: ;($E038)
    ;Restore MSB.
    lsr ObjectCntrl
    ;Reload frame data control byte into A.
    lda (Temp00_FramePtr),y
    ;Extract the two sprite flip bytes from the original control byte and set any additional bits from ObjectCntrl.
    and #OAMDATA_HFLIP | OAMDATA_VFLIP.b
    ora ObjectCntrl
    ;Store modified byte to load in sprite control byte later.
    sta Temp05_Cntrl
    ;Ensure MSB of object control byte remains set.
    lda ObjectCntrl
    ora #$80
    sta ObjectCntrl
    rts

;--------------------------------[ Explosion placement data ]---------------------------------------

;The following table has the index values into the table after it for finding the placement data
;for an exploding object.

ExplodeIndexTbl:
    .byte ExplodePlacementTopTbl-ExplodePlacementTbl
    .byte ExplodePlacementMiddleTbl-ExplodePlacementTbl
    .byte ExplodePlacementBottomTbl-ExplodePlacementTbl

;The following table is used to produce the arcing motion of exploding objects.  It is displacement
;data for the y directions only.  The x displacement is constant.

ExplodePlacementTbl:

;Top sprites.
ExplodePlacementTopTbl:
    .byte $FC, $F8, $F4, $F0, $EE, $EC, $EA, $E8, $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
    .byte $E5, $E7, $E9, $EB, $EF, $F3, $F7, $FB

;Middle sprites.
ExplodePlacementMiddleTbl:
    .byte $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $ED, $EB, $EA, $E9, $E8, $E7, $E6
    .byte $E6, $E6, $E6, $E6, $E8, $EA, $EC, $EE

;Bottom sprites.
ExplodePlacementBottomTbl:
    .byte $FE, $FC, $FA, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F1, $F0, $F0, $EF, $EF
    .byte $EF, $EF, $EF, $EF, $F0, $F0, $F1, $F2

;--------------------------------------[ Update enemy animation ]-----------------------------------

;Advance to next frame of enemy's animation. Basically the same as UpdateObjAnim, only for enemies.

UpdateEnemyAnim:
    ldx PageIndex                   ;Load index to desired enemy.
    ldy EnsExtra.0.status,x                  ;
    cpy #enemyStatus_Pickup                        ;Is enemy in the process of dying?-->
    beq RTS_E0BB                         ;If so, branch to exit.
    ldy EnsExtra.0.animDelay,x               ;
    beq LE0A7                           ;Check if current anumation frame is ready to be updated.
        dec EnsExtra.0.animDelay,x               ;Not ready to update. decrement delay timer and-->
        bne RTS_E0BB                         ;branch to exit.
    LE0A7:
    sta EnsExtra.0.animDelay,x               ;Save new animation delay value.
    ldy EnsExtra.0.animIndex,x               ;Load enemy animation index.
LE0AD:
    lda (EnemyAnimPtr),y            ;Get animation data.
    cmp #$FF                        ;End of animation?
    beq LE0BC                          ;If so, branch to reset animation.
    sta EnsExtra.0.animFrame,x               ;Store current animation frame data.
    iny                             ;Increment to next animation data index.
    tya                             ;
    sta EnsExtra.0.animIndex,x               ;Save new animation index.
RTS_E0BB:
    rts

LE0BC:
    ldy EnsExtra.0.resetAnimIndex,x          ;reset animation index.
    bcs LE0AD                         ;Branch always.

;---------------------------------------[ Display status bar ]---------------------------------------

;Displays Samus' status bar components.

DisplayBar:
    ldy #$00                        ;Reset data index.
    lda SpritePagePos               ;Load current sprite index.
    pha                             ;save sprite page pos.
    tax
    @loop:
        ;Store contents of DataDisplayTbl in sprite RAM.
        lda DataDisplayTbl,y
        sta SpriteRAM,x
        inx
        iny
        ;At end of DataDisplayTbl? If not, loop to load next byte from table.
        cpy #10*4.b
        bne @loop

;Display 2-digit health count.
    stx SpritePagePos               ;Save new location in sprite RAM.
    pla                             ;Restore initial sprite page pos.
    tax                             ;
    lda Health+1                    ;
    and #$0F                        ;Extract upper health digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda Health                    ;
    jsr Adiv16                      ;($C2BF)Move lower health digit to 4 LSBs.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    ldy EndTimer+1                  ;
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
    sta SpriteRAM.3.tileID,x             ;Erase left half of missile.
    cpx #$F0                        ;If at last 4 sprites, branch to skip.
    bcs LE14A                          ;
    sta SpriteRAM.4.tileID,x             ;Erase right half of missile.
    bne LE14A                          ;Branch always.

;Display 3-digit end sequence timer.
LE11C:
    lda EndTimer+1                  ;
    jsr Adiv16                      ;($C2BF)Upper timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda EndTimer+1                  ;
    and #$0F                        ;Middle timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda EndTimer                  ;
    jsr Adiv16                      ;($C2BF)Lower timer digit.
    jsr SPRWriteDigit               ;($E173)Display digit on screen.
    lda #$58                        ;"TI" sprite(left half of "TIME").
    sta SpriteRAM.0.tileID,x             ;
    inc SpriteRAM.0.attrib,x             ;Change color of sprite.
    cpx #$FC                        ;If at last sprite, branch to skip.
    bcs LE14A                           ;
    lda #$59                        ;"ME" sprite(right half of "TIME").
    sta SpriteRAM.1.tileID,x             ;
    inc SpriteRAM.1.attrib,x             ;Change color of sprite.

LE14A:
    ldx SpritePagePos               ;Restore initial sprite page pos.
    lda EnergyTankCount                   ;
    beq RTS_E172                          ;Branch to exit if Samus has no energy tanks.

;Display full/empty energy tanks.
    sta $03                         ;Temp store tank count.
    lda #$40                        ;X coord of right-most energy tank.
    sta $00                         ;Energy tanks are drawn from right to left.
    ldy #$6F                        ;"Full energy tank" tile.
    lda Health+1                    ;
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
RTS_E172:
    rts

;----------------------------------------[Sprite write digit ]---------------------------------------

;A=value in range 0..9. #$A0 is added to A(the number sprites begin at $A0), and the result is stored
;as the tile # for the sprite indexed by X.

SPRWriteDigit:
    ora #$A0                        ;#$A0 is index into pattern table for numbers.
    sta SpriteRAM.0.tileID,x             ;Store proper nametable pattern in sprite RAM.
    jmp Xplus4                      ;Find next sprite pattern table byte.

;----------------------------------[ Add energy tank to display ]------------------------------------

;Add energy tank to Samus' data display.

AddOneTank:
    ;Y coord-1.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        lda #$17
    .elif BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        lda #$15
    .endif
    sta SpriteRAM.0.y,x
    ;Tile value.
    tya
    sta SpriteRAM.0.tileID,x
    ;Palette #.
    lda #$01
    sta SpriteRAM.0.attrib,x
    ;X coord.
    lda $00
    sta SpriteRAM.0.x,x
    ;Find x coord of next energy tank.
    sec
    sbc #$0A
    sta $00
    ; fallthrough

;-----------------------------------------[ Add 4 to x ]---------------------------------------------

Xplus4:
    ;Add 4 to value stored in X.
    inx
    inx
    inx
    inx
    rts

;------------------------------------[ Convert hex to decimal ]--------------------------------------

;Convert 8-bit value in A to 3 decimal digits.
;Upper digit put in $02, middle in $01 and lower in $00.
HexToDec:
    ldy #100                        ;Find upper digit.
    sty $0A                         ;
    jsr DivideByRepeatedSubtraction ;Extract hundreds digit.
    sty $02                         ;Store upper digit in $02.

    ldy #10                         ;Find middle digit.
    sty $0A                         ;
    jsr DivideByRepeatedSubtraction ;Extract tens digit.
    sty $01                         ;Store middle digit in $01.

    sta $00                         ;Store lower digit in $00
    rts

; A is the dividend
; $0A is the divisor
; returns quotient in Y and remainder in A
DivideByRepeatedSubtraction: ;($E1AD)
    ldy #$00
    sec
    ;Loop and subtract value in $0A from A until carry flag is not set.
    @loop:
        iny
        sbc $0A
        bcs @loop
    ;the last subtraction made A negative
    ;undo last subtraction
    dey
    adc $0A
    rts

;-------------------------------------[ Status bar sprite data ]-------------------------------------

;Sprite data for Samus' data display

DataDisplayTbl:
    .byte $21,$A0,$01,$30           ;Upper health digit.
    .byte $21,$A0,$01,$38           ;Lower health digit.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .byte $2B,$FF,$01,$28           ;Upper missile digit.
        .byte $2B,$FF,$01,$30           ;Middle missile digit.
        .byte $2B,$FF,$01,$38           ;Lower missile digit.
        .byte $2B,$5E,$00,$18           ;Left half of missile.
        .byte $2B,$5F,$00,$20           ;Right half of missile.
    .elif BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .byte $2D,$FF,$01,$28           ;Upper missile digit.
        .byte $2D,$FF,$01,$30           ;Middle missile digit.
        .byte $2D,$FF,$01,$38           ;Lower missile digit.
        .byte $2D,$5E,$00,$18           ;Left half of missile.
        .byte $2D,$5F,$00,$20           ;Right half of missile.
    .endif
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
    @loop:
        lsr                             ;Transfer bit to carry flag.
        bcs @exitLoop                   ;If the shifted bit was 1, Branch out of loop.
        inx                             ;Increment X to keep of # of bits checked.
        cpx #$08                        ;Have all 8 bit been tested?-->
        bne @loop                       ;If not, branch to check the next bit.
    @exitLoop:
    txa                             ;Return which bit number was set.
    ldx $0E                         ;Restore X.
RTS_E1F0:
    rts

;------------------------------------------[ Scroll door ]-------------------------------------------

;Scrolls the screen if Samus is inside a door.

ScrollDoor:
    ldx DoorEntryStatus                  ;
    beq RTS_E1F0                    ;Exit if Samus isn't in a door.
    dex                             ;
    bne LE1FE                           ;Not in right door. branch to check left door.
        jsr ScrollRight                 ;($E6D2)DoorEntryStatus=1, scroll 1 pixel right.
        jmp LE204                       ;Jump to check if door scroll is finished.

    LE1FE:
        dex                             ;Check if in left door.
        bne LE20C                       ;
        jsr ScrollLeft                  ;($E6A7)DoorEntryStatus=2, scroll 1 pixel left.
    LE204:
    ldx ScrollX                     ;Has x scroll offset reached 0?-->
    bne Exit15                      ;If not, branch to exit.

;Scrolled one full screen, time to exit door.
    ldx #$05                        ;Samus is exiting the door.
    bne DoOneDoorScroll             ;Branch always.

LE20C:
    dex                             ;
    bne LE215                           ;Check if need to scroll down to center door.
        jsr ScrollDown                  ;($E519)DoorEntryStatus=3, scroll 1 pixel down.
        jmp VerticalRoomCentered        ;Jump to check y scrolling value.
    LE215:
    dex                             ;
    bne Exit15                      ;Check if need to scroll up to center door.
    jsr ScrollUp                    ;($E4F1)DoorEntryStatus=4, scroll 1 pixel up.

VerticalRoomCentered: ; ($E21B)
    ldx ScrollY                     ;Has room been centered on screen?-->
    bne Exit15                      ;If not, branch to exit.
    stx ScrollBlockOnNameTable3     ;
    stx ScrollBlockOnNameTable0     ;Erase door nametable data.
    inx                             ;X=1.
    lda ObjX                        ;Did Samus enter in the right hand door?-->
    bmi LE241                       ;If so, branch.
    inx                             ;X=2. Samus is in left door.
    bne LE241                       ;Branch always.

;This function is called once after door scrolling is complete.

DoOneDoorScroll:
    lda #$20                        ;Set DoorDelay to 32 frames(comming out of door).
    sta DoorDelay                   ;
    lda SamusDoorData               ;Check if scrolling should be toggled.
    jsr Amul8                       ;($C2C6)*8. Is door not to toggle scrolling(item room,-->
    bcs LE23D                           ;bridge room, etc.)? If so, branch to NOT toggle scrolling.
        ldy DoorScrollStatus            ;If coming from vertical shaft, skip ToggleScroll because-->
        cpy #$03                        ;the scroll was already toggled after room was centered-->
        bcc LE241                       ;by the routine just above.
    LE23D:
    lda #$47                        ;Set mirroring for vertical mirroring(horz scrolling).
    bne LE244                       ;Branch always.

    LE241:
        jsr ToggleScroll                ;($E252)Toggle scrolling and mirroring.
    LE244:
    sta MirrorCntrl                 ;Store new mirror control data.
    stx DoorEntryStatus                  ;DoorEntryStatus=5. Done with door scrolling.

Exit15:
    rts                             ;Exit for several routines above.

;------------------------------------[ Toggle Samus nametable ]--------------------------------------

;Change Samus' current nametable from one to the other.
ToggleSamusHi:
    lda ObjHi
    eor #$01
    sta ObjHi
    rts

;-------------------------------------------[ Toggle scroll ]----------------------------------------

;Toggles both mirroring and scroll direction when Samus has moved from
;a horizontal shaft to a vertical shaft or vice versa.

ToggleScroll:
    ;Toggle scroll direction.
    lda ScrollDir
    eor #$03
    sta ScrollDir
    ;Toggle mirroring.
    lda MirrorCntrl
    eor #$08
    rts

;----------------------------------------[ Is Samus in lava ]----------------------------------------

;The following function checks to see if Samus is in lava.  If she is, the carry bit is cleared,
;if she is not, the carry bit is set. Samus can only be in lava if in a horizontally scrolling
;room. If Samus is 24 pixels or less away from the bottom of the screen, she is considered to be
;in lava whether its actually there or not.

IsSamusInLava:
    ;Set carry bit(and exit) if scrolling up or down.
    lda #$01
    cmp ScrollDir
    bcs RTS_E268
    ;If Samus is Scrolling left or right and within 24 pixels-->
    ;of the bottom of the screen, she is in lava. Clear carry bit.
    lda #$D8
    cmp ObjY
RTS_E268:
    rts

;----------------------------------[ Check lava and movement routines ]------------------------------

LavaAndMoveCheck:
    ; don't exit if samus is on elevator
    lda ObjAction
    cmp #sa_Elevator
    beq @endIf_A
        ; exit if samus is dead (sa_Dead or sa_Dead2)
        cmp #sa_Dead
        bcs RTS_E268
    @endIf_A:

    ;($E25D)Clear carry flag if Samus is in lava.
    jsr IsSamusInLava
    ;branch if Samus not in lava.
    ldy #$FF
    bcs @noLava

    ;Samus is in lava.
    ;Don't push Samus from lava damage.
    sty SamusKnockbackDir
    ;($F323)Clear any pending health changes to Samus.
    jsr ClearHealthChange
    ;Make Samus blink.
    lda #$32
    sta SamusInvincibleDelay
    ;Start the jump SFX every 4th frame while in lava.
    lda FrameCount
    and #$03
    bne @endIf_B
        ;($CBAC)Initiate jump SFX.
        jsr SFX_SamusJump
    @endIf_B:
    ;This portion of the code causes Samus to be damaged by-->
    ;lava twice every 8 frames if she does not have the varia-->
    ;but only once every 8 frames if she does.
    lda FrameCount
    lsr
    and #$03
    bne @endIf_C
    ;branch if Samus doesn't have the Varia
    lda SamusGear
    and #gr_VARIA
    beq @endIf_D
        ;Samus has varia. Carry set every other frame. Half damage.
        bcc @endIf_C
    @endIf_D:
    ;Samus takes lava damage.
    lda #$07
    sta HealthChange
    jsr SubtractHealth
@endIf_C:
    ;Prepare to indicate Samus is in lava.
    ldy #$00
@noLava:
    ;Set Samus lava status.
    iny
    sty SamusInLava

SamusMoveVertically: ; unreferenced label
    ;($E37A)Calculate vertical acceleration.
    jsr VertAccelerate
    ;Calculate Samus' screen y position.
    lda ObjY
    sec
    sbc ScrollY
    sta SamusScrY
    ;Load temp copy of delta y. branch if Samus is moving downwards
    lda $00
    bpl @downwards

    ;Samus is moving upwards.
    ;($C3D4)Get twos complement of delta y.
    jsr TwosComplement
    ;branch if Samus isn't in lava
    ldy SamusInLava
    beq @endIf_A
        ; samus is in lava, cut delta y in half
        lsr
        ; branch if delta y became zero
        beq SamusMoveHorizontally
    @endIf_A:
    ;Store number of pixels to move Samus this frame.
    sta ObjectCounter
    @loop_up:
        ;($E457)Attempt to move Samus up 1 pixel.
        jsr MoveSamusUp
        ;Branch if Samus successfully moved up 1 pixel.
        bcs @endIf_B
            ;Samus blocked upwards. Divide her speed by 2 and set the MSB to reverse her direction of travel.
            sec
            ror ObjSpeedY
            ror SamusSpeedSubPixelY
            ;($E31A)Attempt to move Samus left/right.
            jmp SamusMoveHorizontally
        @endIf_B:
        ;1 pixel movement is complete.
        dec ObjectCounter
        ;Branch if Samus needs to be moved another pixel.
        bne @loop_up
        ; fallthrough to SamusMoveHorizontally

@downwards:
    ;Samus is moving downwards.
    ; branch if delta y is zero
    beq SamusMoveHorizontally
    ;branch if Samus isn't in lava
    ldy SamusInLava
    beq @endIf_C
        ;samus is in lava, reduce Samus delta y by 75%(divide by 4).
        lsr
        lsr
        ; branch if delta y became zero
        beq SamusMoveHorizontally
    @endIf_C:
    ;Store number of pixels to move Samus this frame.
    sta ObjectCounter
    @loop_down:
        ;($E4A3)Attempt to move Samus 1 pixel down.
        jsr MoveSamusDown
        ;Branch if Samus successfully moved down 1 pixel.
        bcs @endIf_D
            ;Samus bounce after hitting the ground in ball form.
            ;branch if Samus isn't rolled into a ball
            lda ObjAction
            cmp #sa_Roll
            bne @landingNoBall
            ;Divide vertical speed by 2.
            lsr ObjSpeedY
            ;branch if Speed is not falling fast enough to bounce (speed < 2px/frame)
            beq @landingNoBounce
            ; continue division of vertical speed by 2
            ror SamusSpeedSubPixelY
            ; negate vertical speed
            lda #$00
            sec
            sbc SamusSpeedSubPixelY
            sta SamusSpeedSubPixelY
            lda #$00
            sbc ObjSpeedY
            sta ObjSpeedY
            ;($E31A)Attempt to move Samus left/right.
            jmp SamusMoveHorizontally

        ;Samus has hit the ground after moving downwards.
        @landingNoBall:
            ;($CB96)Play walk SFX.
            jsr SFX_SamusWalk
        @landingNoBounce:
            ;($D147)Clear vertical movement data.
            jsr StopVertMovement
            ;Clear Samus gravity value.
            sty SamusAccelY
            ;($E31A)Attempt to move Samus left/right.
            beq SamusMoveHorizontally
        @endIf_D:
        ;1 pixel movement is complete.
        dec ObjectCounter
         ;Branch if Samus needs to be moved another pixel.
        bne @loop_down

SamusMoveHorizontally:
    ;($E3E5)Horizontally accelerate Samus.
    jsr HorzAccelerate
    ;Calculate Samus' x position on screen.
    lda ObjX
    sec
    sbc ScrollX
    sta SamusScrX
    ;Load Samus' current delta x.
    lda $00
    ;Branch if moving right.
    bpl LE347

;Samus is moving left.
    ;($C3D4)Get twos complement of delta x.
    jsr TwosComplement
    ; branch if samus is not in lava
    ldy SamusInLava
    beq LE333
        ;samus is in lava, cut delta x in half.
        lsr
        ;Branch to exit if Samus not going to move this frame.
        beq Exit10
    LE333:
    ;Store number of pixels to move Samus this frame.
    sta ObjectCounter
    LE335:
        ;($E626)Attempt to move Samus 1 pixel to the left.
        jsr MoveSamusLeft
        ;($E365)Check if horizontal movement needs to be stopped.
        jsr CheckStopHorzMvmt
        ;1 pixel movement is complete.
        dec ObjectCounter
        ;Branch if Samus needs to be moved another pixel.
        bne LE335
    ; exit if samus hasn't entered a door
    lda SamusDoorData
    beq Exit10
    ; samus has entered a door, Door leads to the left.
    lda #$01
    bne LE362 ;Branch always.

;Samus is moving right.
LE347:
    ;Branch to exit if Samus not moving horizontally.
    beq Exit10
    ; branch if samus is not in lava
    ldy SamusInLava
    beq LE350
        ;samus is in lava, cut horizontal speed in half.
        lsr
        ;Branch to exit if Samus not going to move this frame.
        beq Exit10
    LE350:
    ;Store number of pixels to move Samus this frame.
    sta ObjectCounter
    LE352:
        ;($E668)Attempt to move Samus 1 pixel to the right.
        jsr MoveSamusRight
        ;($E365)Check if horizontal movement needs to be stopped.
        jsr CheckStopHorzMvmt
        ;1 pixel movement is complete.
        dec ObjectCounter
        ;Branch if Samus needs to be moved another pixel.
        bne LE352
    ; exit if samus hasn't entered a door
    lda SamusDoorData
    beq Exit10
    ; samus has entered a door, Door leads to the right.
    lda #$00
LE362:
    sta SamusDoorDir
Exit10:
    rts                             ;Exit for routines above and below.

CheckStopHorzMvmt:
    ;Samus moved successfully. Branch to exit.
    bcs Exit10
    ; break loop of caller routine
    lda #$01
    sta ObjectCounter
    ; exit if samus is in the air
    lda SamusAccelY
    bne Exit10
    ; exit if samus is a ball
    lda ObjAction
    cmp #sa_Roll
    beq Exit10
    ;($CF55)Stop horizontal movement or play walk SFX if stopped.
    jmp SetSamusStand

;-------------------------------------[ Samus vertical acceleration ]--------------------------------

;The following code accelerates/decelerates Samus vertically.  There are 4 possible values for
;gravity used in the acceleration calculation. The higher the number, the more intense the gravity.
;The possible values for gravity are as follows:
;#$38-When Samus has been hit by an enemy.
;#$1A-When Samus is falling.
;#$18-Jump without high jump boots.
;#$12-Jump with high jump boots.

VertAccelerate:
    ;Branch if Samus is in the air
    lda SamusAccelY
    bne @dontStartFalling

    ;Set Samus maximum running speed. (1.5 px)
    lda #$18
    sta SamusHorzSpeedMax
    ;Check if Samus is obstructed downwards on y room positions divisible by 8(every 8th pixel).
    lda ObjY
    clc
    adc ObjRadY
    and #$07
    bne @endIf_A
        ;Branch if Samus is obstructed downwards
        jsr ObjectCheckMoveDown
        bcc @dontStartFalling
    @endIf_A:
    jsr SamusCollisionWithSolidEntities
    ;branch if Samus is standing on a solid entity
    lda SamusOnElevator
    bne @dontStartFalling
    lda OnFrozenEnemy
    bne @dontStartFalling

    ;Samus is falling. Store falling gravity value.
    lda #$1A
    sta SamusAccelY

@dontStartFalling:
    ;Load X with maximum downward speed.
    ldx #$05
    ; apply gravity to y speed
    lda SamusSpeedSubPixelY
    clc
    adc SamusAccelY
    sta SamusSpeedSubPixelY
    lda ObjSpeedY
    adc #$00
    sta ObjSpeedY
    ;Branch if Samus is moving downwards.
    bpl @else_B
        ;Check if maximum upward speed has been exceeded. If so, prepare to set maximum speed.
        ;Sets carry bit.
        lda #$00
        cmp SamusSpeedSubPixelY
        ;Subtract ObjSpeedY to see if maximum speed has been exceeded.
        sbc ObjSpeedY
        cmp #$06
        ;Load X with maximum upward speed.
        ldx #$FA
        bne @endIf_B ;Branch always.
    @else_B:
        ;Check if maximum downward speed has been reached. If so, prepare to set maximum speed.
        cmp #$05                        ;Has maximum downward speed been reached?-->
    @endIf_B:
    bcc @endIf_C                           ;If not, branch.
        ;Max vertical speed reached or exceeded. Adjust Samus vertical speed to max.
        jsr StopVertMovement            ;($D147)Clear vertical movement data.
        stx ObjSpeedY                ;Set Samus vertical speed to max.
    @endIf_C:

    ; apply sub-pixel speed to sub-pixel position
    lda SamusSubPixelY
    clc
    adc SamusSpeedSubPixelY
    sta SamusSubPixelY
    ;$00 stores temp copy of current delta y.
    lda #$00
    adc ObjSpeedY
    sta $00
    rts

;----------------------------------------------------------------------------------------------------

HorzAccelerate: ;($E3E5)
    ; store max speed sub-pixels to temp
    lda SamusHorzSpeedMax
    jsr Amul16       ; * 16
    sta $00
    sta $02
    ; store max speed pixels to temp
    lda SamusHorzSpeedMax
    jsr Adiv16       ; / 16
    sta $01
    sta $03

    ; apply x acceleration to x speed
    ; and save x speed in x and y
    lda SamusSpeedSubPixelX
    clc
    adc SamusAccelX
    sta SamusSpeedSubPixelX
    tax
    lda #$00
    bit SamusAccelX
    bpl Lx147 ;Branch if Samus accelerating to the right.
        lda #$FF
    Lx147:
    adc ObjSpeedX
    sta ObjSpeedX
    tay
    ;Branch if Samus is moving to the right.
    bpl Lx148
        ; samus is moving left
        ; store negative x speed in x and y
        lda #$00
        sec
        sbc SamusSpeedSubPixelX
        tax
        lda #$00
        sbc ObjSpeedX
        tay
        ; negate max speed in temp $00-$01
        jsr NegateTemp00Temp01
    Lx148:
    ;x and y now contain absolute x speed
    ;temp $00-$01 now contain signed max x speed
    ;temp $02-$03 now contain absolute max x speed

    ; branch if absolute x speed is less than than absolute max x speed
    cpx $02
    tya
    sbc $03
    bcc Lx149
        ; absolute x speed is greater than than absolute max x speed
        ; cap signed x speed to signed max x speed
        lda $00
        sta SamusSpeedSubPixelX
        lda $01
        sta ObjSpeedX
    Lx149:

    ; apply sub-pixel speed to sub-pixel position
    lda SamusSubPixelX
    clc
    adc SamusSpeedSubPixelX
    sta SamusSubPixelX
    ;$00 stores temp copy of current delta x.
    lda #$00
    adc ObjSpeedX
    sta $00
    rts

NegateTemp00Temp01:
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
    lda ObjY                        ;Get Samus' y position in room.
    sec                             ;
    sbc ObjRadY                     ;Subtract Samus' vertical radius.
    and #$07                        ;Check if result is a multiple of 8. If so, branch to-->
    bne Lx150                       ;Only call crash detection every 8th pixel.
        jsr ObjectCheckMoveUp                 ;($E7A2)Check if Samus obstructed UPWARDS.-->
        bcc RTS_X156                     ;If so, branch to exit(can't move any further).
    Lx150:
    ; branch if Samus is riding elevator
    lda ObjAction
    cmp #sa_Elevator
    beq Lx151
        jsr SamusCollisionWithSolidEntities
        ; exit if samus is under a solid entity
        lda SamusIsHit
        and #$42
        cmp #$42
        clc
        beq RTS_X156
    Lx151:
    ; reached up scroll limit? branch if not
    lda SamusScrY
    cmp #$66
    bcs Lx152
        jsr ScrollUp
        bcc Lx153
    Lx152:
        dec SamusScrY
    Lx153:
    lda ObjY
    bne Lx155
        lda ScrollDir
        and #$02
        bne Lx154
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        Lx154:
        lda #SCRN_VY
        sta ObjY
    Lx155:
    dec ObjY
    inc SamusJumpDsplcmnt
    sec
RTS_X156:
    rts

; attempt to move Samus one pixel down

MoveSamusDown:
    lda ObjY
    clc
    adc ObjRadY
    and #$07
    bne Lx157              ; only call crash detection every 8th pixel
        jsr ObjectCheckMoveDown       ; check if Samus obstructed DOWNWARDS
        bcc RTS_X163      ; exit if yes
    Lx157:
    ; branch if Samus is riding elevator
    lda ObjAction
    cmp #sa_Elevator
    beq Lx158
        jsr SamusCollisionWithSolidEntities
        ; exit if samus is standing on a solid entity
        lda SamusOnElevator
        clc
        bne RTS_X163
        lda OnFrozenEnemy
        bne RTS_X163
    Lx158:
    ; reached down scroll limit? branch if not
    lda SamusScrY
    cmp #$84
    bcc Lx159
        jsr ScrollDown
        bcc Lx160
    Lx159:
        inc SamusScrY
    Lx160:
    lda ObjY
    cmp #SCRN_VY-1.b
    bne Lx162
        lda ScrollDir
        and #$02
        bne Lx161
            jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
        Lx161:
        lda #$FF
        sta ObjY
    Lx162:
    inc ObjY
    dec SamusJumpDsplcmnt
    sec
RTS_X163:
    rts

; Attempt to scroll UP, return carry clear if success, carry set if failure
ScrollUp:
    lda ScrollDir
    beq @currentlyScrollingUp
        ; can't scroll vertically while scrolling horizontally
        cmp #$01
        bne @cantScroll
        ; currently scrolling down
        dec ScrollDir       ; ScrollDir = up
        lda ScrollY
        beq @currentlyScrollingUp
        dec MapPosY
    @currentlyScrollingUp:
    ldx ScrollY
    bne @noNewRoom
        ; new room is above
        dec MapPosY    ; decrement MapY
        jsr GetRoomNum      ; put room # at current map pos in $5A
        bcs @atTopBound     ; if function returns CF = 1, moving up is not possible
        jsr ToggleNameTable ; switch to the opposite Name Table
        ldx #SCRN_VY        ; new Y coord
    @noNewRoom:
    dex
    jmp ScrollVertically_Merge
@atTopBound:
    inc MapPosY
@cantScroll:
    sec
    rts

; Attempt to scroll DOWN
ScrollDown:
    ldx ScrollDir
    dex
    beq @currentlyScrollingDown
        ; can't scroll vertically while scrolling horizontally
        bpl ScrollDown_cantScroll
        ; currently scrolling up
        inc ScrollDir       ; ScrollDir = down
        lda ScrollY
        beq @currentlyScrollingDown
        inc MapPosY
    @currentlyScrollingDown:
    lda ScrollY
    bne @noNewRoom
        inc MapPosY                ; increment MapY
        jsr GetRoomNum                  ; put room # at current map pos in $5A
        bcs ScrollDown_atBottomBound    ; if function returns CF = 1, moving down is not possible
    @noNewRoom:
    ; ScrollY = (ScrollY + 1) % 0xF0
    ldx ScrollY
    cpx #SCRN_VY-1.b
    bne @noNameTableSwitch
        jsr ToggleNameTable ; switch to the opposite Name Table
        ldx #$FF
    @noNameTableSwitch:
    inx
ScrollVertically_Merge:
    stx ScrollY
    jsr CheckUpdateNameTable    ; check if it's time to update Name Table
    clc
    rts
ScrollDown_atBottomBound:
    dec MapPosY
ScrollDown_cantScroll:
    sec
RTS_X173:
    rts

CheckUpdateNameTable:
    jsr SetupRoom
    ; return if new room loaded
    ldx RoomNumber
    inx
    bne RTS_X173

    lda ScrollDir
    and #$02
    bne @horizontal
        jmp CheckUpdateNameTableVertical
    @horizontal:
    jmp CheckUpdateNameTableHorizontal

CheckUpdateNameTableVertical_ScrollYThresholds:
    .byte $07
    .byte $00

;---------------------------------[ Get PPU and RoomRAM addresses ]----------------------------------

PPUAddrs:
    .byte $20                       ;High byte of nametable #0(PPU).
    .byte $2C                       ;High byte of nametable #3(PPU)

RoomRAMAddrs:
    .byte >RoomRAMA         ;High byte of RoomRAMA(cart RAM).
    .byte >RoomRAMB         ;High byte of RoomRAMB(cart RAM).

GetNameAddrs:
    ;Get current name table number.
    jsr GetNameTableAtScrollDir
    and #$01 ;useless instruction
    tay
    ;Get high PPU addr of nametable(dest).
    lda PPUAddrs,y
    ;Get high cart RAM addr of nametable(src).
    ldx RoomRAMAddrs,y
    rts

;----------------------------------------------------------------------------------------------------

; check if it's time to update nametable (when scrolling is VERTICAL)

CheckUpdateNameTableVertical:
    ldx ScrollDir
    lda ScrollY
    and #$07        ; compare value = 0 if ScrollDir = down, else 7
    cmp CheckUpdateNameTableVertical_ScrollYThresholds,x
    bne RTS_X173     ; exit if not equal (no nametable update)

EndOfRoomVertical:
    ; Avoid redundant name table updates by checking if ScrollDir = TempScrollDir.
    ldx ScrollDir
    cpx TempScrollDir
    bne RTS_X173
    ; $01.00 = (ScrollY & 0xF8) << 2 = tile index
    lda ScrollY
    and #$F8        ; keep upper 5 bits
    sta Temp00_RoomRAMPtr
    lda #$00
    asl Temp00_RoomRAMPtr
    rol
    asl Temp00_RoomRAMPtr
    rol

UpdateNameTable: ; 07:E590
    sta Temp00_RoomRAMPtr+1.b
    ; $03.02 = $01.00 + PPU nametable addr = pointer to PPU nametable tile
    jsr GetNameAddrs
    ora Temp00_RoomRAMPtr+1.b
    sta Temp02_PPURAMPtr+1.b
    ; $01.00 += cart RAM nametable addr = pointer to cart RAM nametable tile
    txa
    ora Temp00_RoomRAMPtr+1.b
    sta Temp00_RoomRAMPtr+1.b
    lda Temp00_RoomRAMPtr
    sta Temp02_PPURAMPtr
    lda ScrollDir
    lsr             ; A = 0 if vertical scrolling, 1 if horizontal
    tax
    lda @controlBitsTable,x
    sta Temp04_ControlBits
    ldy #$01
    sty PPUDataPending      ; data pending = YES
    dey
    ldx PPUStrIndex
    ; PPU starting address = $03.02
    lda Temp02_PPURAMPtr+1.b
    jsr WritePPUByte                ;($C36B)Put data byte into PPUDataString.
    lda Temp02_PPURAMPtr
    jsr WritePPUByte
    ; Control byte = $04
    lda Temp04_ControlBits
    jsr SeparateControlBits         ;($C3C6)
    @loop_data:
        ; y is #$00 here
        lda (Temp00_RoomRAMPtr),y
        jsr WritePPUByte
        ; backup Y to $06
        sty Temp06_Zero
        ; if bit 7 (PPU inc) of $04 clear, WRAM pointer increment = 1
        ; else ptr inc = 32
        ldy #$01
        bit Temp04_ControlBits
        bpl @inc1
            ldy #$20
        @inc1:
        jsr AddYToPtr00                 ;($C2A8)
        ; restore Y from $06
        ldy Temp06_Zero
        ; decrement number of bytes of data remaining if branch if there's any left
        dec Temp05_BytesCounter
        bne @loop_data
    ; End PPU string.
    stx PPUStrIndex
    jsr EndPPUString

@controlBitsTable:
    .byte $20                       ;Horizontal write. PPU inc = 1, length = 32 tiles.
    .byte $1E | $80                 ;Vertical write... PPU inc = 32, length = 30 tiles.

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

MoveSamusLeft: ;($E626)
    lda ObjX
    sec
    sbc ObjRadX
    and #$07
    bne Lx177              ; only call crash detection every 8th pixel
        jsr ObjectCheckMoveLeft       ; check if player is obstructed to the LEFT
        bcc Lx181        ; branch if yes! (CF = 0)
    Lx177:
    jsr SamusCollisionWithSolidEntities
    ; exit if samus is touching the right side of a solid entity
    lda SamusIsHit
    and #$41
    cmp #$41
    clc
    beq Lx181
    ; reached left scroll limit? branch if not
    lda SamusScrX
    cmp #$71
    bcs Lx178
        jsr ScrollLeft
        bcc Lx179
    Lx178:
        dec SamusScrX
    Lx179:
    lda ObjX
    bne Lx180
        lda ScrollDir
        and #$02
        beq Lx180
        jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
    Lx180:
    dec ObjX
    sec
    rts

; crash with object on the left
Lx181:
    lda #$00
    sta SamusDoorData
    rts

; attempt to move Samus one pixel right

MoveSamusRight:
    lda ObjX
    clc
    adc ObjRadX
    and #$07
    bne Lx182              ; only call crash detection every 8th pixel
        jsr ObjectCheckMoveRight      ; check if Samus is obstructed to the RIGHT
        bcc Lx186       ; branch if yes! (CF = 0)
    Lx182:
    jsr SamusCollisionWithSolidEntities
    ; exit if samus is touching the left side of a solid entity
    lda SamusIsHit
    and #$41
    cmp #$40
    clc
    beq Lx186
    ; reached right scroll limit? branch if not
    lda SamusScrX
    cmp #$8F
    bcc Lx183
        jsr ScrollRight
        bcc Lx184
    Lx183:
        inc SamusScrX
    Lx184:
    inc ObjX      ; go right, Samus!
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
    beq @currentlyScrollingLeft
        ; can't scroll horizontally while scrolling vertically
        cmp #$03
        bne @cantScroll
        ; currently scrolling right
        dec ScrollDir       ; ScrollDir = left
        lda ScrollX
        beq @currentlyScrollingLeft
        dec MapPosX
    @currentlyScrollingLeft:
    lda ScrollX
    bne @noNewRoom
        dec MapPosX    ; decrement MapX
        jsr GetRoomNum      ; put room # at current map pos in $5A
        bcs @atLeftBound    ; if function returns CF=1, scrolling left is not possible
        jsr ToggleNameTable ; switch to the opposite Name Table
    @noNewRoom:
    dec ScrollX
    jsr CheckUpdateNameTable    ; check if it's time to update Name Table
    clc
    rts
@atLeftBound:
    inc MapPosX
@cantScroll:
    sec
    rts

; Attempt to scroll RIGHT

ScrollRight:
    lda ScrollDir
    cmp #$03
    beq @currentlyScrollingRight
        ; can't scroll horizontally while scrolling vertically
        cmp #$02
        bne @cantScroll
        inc ScrollDir
        lda ScrollX
        beq @currentlyScrollingRight
        inc MapPosX
    @currentlyScrollingRight:
    lda ScrollX
    bne @noNewRoom
        inc MapPosX
        jsr GetRoomNum      ; put room # at current map pos in $5A
        bcs @atRightBound   ; if function returns CF=1, scrolling right is not possible
    @noNewRoom:
    inc ScrollX
    bne @noNameTableSwitch
        jsr ToggleNameTable ; switch to the opposite Name Table
    @noNameTableSwitch:
    jsr CheckUpdateNameTable    ; check if it's time to update Name Table
    clc
    rts
@atRightBound:
    dec MapPosX
@cantScroll:
    sec
RTS_X196:
    rts

CheckUpdateNameTableHorizontal_ScrollXThresholds:
    .byte $07
    .byte $00

; check if it's time to update nametable (when scrolling is HORIZONTAL)

CheckUpdateNameTableHorizontal:
    ldx ScrollDir
    lda ScrollX
    and #$07        ; keep lower 3 bits
    cmp CheckUpdateNameTableHorizontal_ScrollXThresholds-2,x ; compare value = 0 if ScrollDir = right, else 7
    bne RTS_X196      ; exit if not equal (no nametable update)

EndOfRoomHorizontal:
    ; Avoid redundant name table updates by checking if ScrollDir = TempScrollDir.
    ldx ScrollDir
    cpx TempScrollDir
    bne RTS_X196
    ; $01.00 = (ScrollX & 0xF8) / 8 = tile index
    lda ScrollX
    and #$F8        ; keep upper five bits (redundant)
    jsr Adiv8       ; / 8 (make 'em lower five)
    sta Temp00_RoomRAMPtr
    lda #$00
    jmp UpdateNameTable

;---------------------------------------[ Get room number ]-------------------------------------------

;Gets room number at current map position. Sets carry flag if room # at map position is FF.
;If valid room number, the room number is stored in $5A.

GetRoomNum:
    lda ScrollDir                   ;
    lsr                             ;Branch if scrolling vertical.
    beq LE733                       ;

    rol                             ;Restore value of a
    adc #$FF                        ;A=#$01 if scrolling left, A=#$02 if scrolling right.
    pha                             ;Save A.
    jsr OnNameTable0                ;($EC93)Y=1 if name table=0, Y=0 if name table=3.
    pla                             ;Restore A.
    and ScrollBlockOnNameTable3,y   ;
    sec                             ;
    bne RTS_E76F                    ;Can't load room, a door is in the way. This has the-->
                                    ;effect of stopping the scrolling until Samus walks-->
                                    ;through the door(horizontal scrolling only).

LE733:
    lda MapPosY                ;Map pos y.
    jsr Amul16                      ;($C2C5)Multiply by 16.
    sta $00                         ;Store multiplied value in $00.
    lda #$00                        ;
    rol                             ;Save carry, if any.
    rol $00                         ;Multiply value in $00 by 2.
    rol                             ;Save carry, if any.
    sta $01                         ;
    lda $00                         ;
    adc MapPosX                ;Add map pos X to A.
    sta $00                         ;Store result.
    lda $01                         ;
    adc #>WorldMapRAM.b             ;Add #$7000 to result.
    sta $01                         ;$0000 = (MapY*32)+MapX+#$7000.
    ldy #$00                        ;
    lda ($00),y                     ;Load room number.
    cmp #$FF                        ;Is it unused?-->
    beq RTS_E76F                    ;If so, branch to exit with carry flag set.

    sta RoomNumber                  ;Store room number.

    LE758:
        cmp AreaItemRoomNumbers,y       ;Is it a special room?-->
        beq LE76A                       ;If so, branch to set flag to play item room music.
        iny                             ;
        cpy #$07                        ;
        bne LE758                       ;Loop until all special room numbers are checked.

    lda ItemRoomMusicStatus         ;Load item room music status.
    beq LE76C                       ;Branch if not in special room.
    lda #$80                        ;Stop playing item room music after next music start.
    bne LE76C                       ;Branch always.

LE76A:
    lda #$01                        ;Start item room music on next music start.
LE76C:
    sta ItemRoomMusicStatus         ;
    clc                             ;Clear carry flag. was able to get room number.
RTS_E76F:
    rts

;-----------------------------------------------------------------------------------------------------

EnemyCheckMoveUp:
    ldx PageIndex
    ; Y radius + 8 to check block directly above
    lda EnsExtra.0.radY,x
    clc
    adc #$08
    jmp LE783

EnemyCheckMoveDown:
    ldx PageIndex
    ; check block directly below
    lda #$00
    sec
    sbc EnsExtra.0.radY,x
    ; fallthrough

LE783:
    sta Temp02_DistToCenterY
    ; redundant
    lda #$08
    sta Temp04_NumBlocksToCheck

    jsr StoreEnemyPositionToTemp
    lda EnsExtra.0.radX,x
    jmp CheckMoveVertical

StoreEnemyPositionToTemp:
    lda EnX,x
    sta Temp09_PositionX     ; X coord
    lda EnY,x
    sta Temp08_PositionY     ; Y coord
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi     ; hi coord
    rts

ObjectCheckMoveUp:; For Samus, et al
    ldx PageIndex
    ; Y radius + 8 to check block directly above
    lda ObjRadY,x
    clc
    adc #$08
    jmp Lx197

ObjectCheckMoveDown: ; For Samus
    ldx PageIndex
    ; check block directly below
    lda #$00
    sec
    sbc ObjRadY,x
Lx197:
    sta Temp02_DistToCenterY
    jsr StoreObjectPositionToTemp
    lda ObjRadX,x

CheckMoveVertical:
    bne Lx198
        ; Skip collision if X radius = 0
        sec
        rts
    Lx198:
    sta Temp03_DistToCenterX
    tay
    ldx #$00
    ; A = left boundary
    lda Temp09_PositionX
    sec
    sbc Temp03_DistToCenterX
    ; check for left remainder
    and #$07
    beq Lx199
        ; there's a left remainder
        inx
    Lx199:
    jsr GetNumBlocksToCheck
    sta Temp04_NumBlocksToCheck
    jsr CalculateFirstBGCollisionPoint
    ldx #$00 ; Temp06_NextPointYOffset = 0
    ldy #$08 ; Temp07_NextPointXOffset = 8
    lda Temp00_CollisionPointYMod8
LE7DE:
    ; skip collision if object boundary is not at block boundary
    bne Lx202
    stx Temp06_NextPointYOffset
    sty Temp07_NextPointXOffset
    ldx Temp04_NumBlocksToCheck

; object<-->background crash detection

LE7E6:
    jsr MakeRoomRAMPtr              ;($E96A)Find object position in room RAM.
    ldy #$00
    lda (Temp04_RoomRAMPtr),y     ; get tile value
    ; branch if bullet hit solid blank tile
    cmp #$4E
    beq ProjectileHitDoorOrStatue
    jsr GotoUpdateBullet_CollisionWithMotherBrain
    jsr CheckBlastTile
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
    jsr CalculateNextBGCollisionPoint
    jmp LE7E6
Lx202:
    sec          ; no crash
Exit16:
    rts

; bullet/missile hits a door

ProjectileHitDoorOrStatue:
    ; exit if we aren't updating a samus projectile
    ldx UpdatingProjectile
    beq ClcExit
    ldx #$06
    ; go through all doors
    @loop:
        ; check if projectile tile column is the same as door tile column otherwise check next door
        lda Temp04_RoomRAMPtr+1.b
        eor DoorRoomRAMPtr+1.b,x
        and #$04
        bne @next
        lda Temp04_RoomRAMPtr
        eor DoorRoomRAMPtr,x
        and #$1F
        bne @next
        ; get obj slot
        txa
        jsr Amul8       ; * 8
        ora #$80
        tay
        ; check next door if it doesn't exist
        lda DoorStatus,y
        beq @next
        lda DoorType,y
        lsr
        bcs @blueDoor
            ; missile door
            ldx PageIndex
            ; check if projectile is a missile or missile explosion
            lda ObjAction,x
            eor #wa_Missile         ; eor to preserve carry clear?
            beq @hitByMissile
                lda ObjAction,x
                eor #wa_BulletExplode
                bne GotoSFX_Metal
                lda ObjAnimResetIndex,x
                eor #ObjAnim_MissileExplode - ObjectAnimIndexTbl.b
                bne GotoSFX_Metal
            @hitByMissile:
            lda TriSFXFlag
            ora #sfxTri_SamusBall
            sta TriSFXFlag
        @blueDoor:
        ; set door is hit
        lda #$04
        sta DoorIsHit,y
        bne ClcExit
    @next:
        dex
        dex
    bpl @loop

    ; if it wasn't a door, it was a statue
    ; lowest nybble of pointer to kraid statue is #$0 or #$1
    ; lowest nybble of pointer to ridley statue is #$C or #$D
    ; therefore, by using bit 3 of the pointer, we can distinguish between the statues
    lda Temp04_RoomRAMPtr
    jsr Adiv8       ; / 8
    and #$01
    ; set statue is hit flag for appropriate statue
    tax
    inc KraidStatueIsHit,x

ClcExit:
    clc
    rts

GotoSFX_Metal:
    jmp SFX_Metal

ObjectCheckMoveLeft:
    ldx PageIndex
    ; X radius + 8 to check block directly to the left
    lda ObjRadX,x
    clc
    adc #$08
    jmp ObjectCheckMoveHorizontalBranch

ObjectCheckMoveRight:
    ldx PageIndex
    ; check block directly to the right
    lda #$00
    sec
    sbc ObjRadX,x
    ; fallthrough

ObjectCheckMoveHorizontalBranch:
    sta Temp03_DistToCenterX
    jsr StoreObjectPositionToTemp
    ldy ObjRadY,x

CheckMoveHorizontal:
    bne Lx208
        ; Skip collision if Y radius = 0
        sec
        rts
    Lx208:
    sty Temp02_DistToCenterY
    ldx #$00
    ; A = top boundary
    lda Temp08_PositionY
    sec
    sbc Temp02_DistToCenterY
     ; check for top remainder
    and #$07
    beq Lx209
        ; there's a top remainder
        inx
    Lx209:
    jsr GetNumBlocksToCheck
    sta Temp04_NumBlocksToCheck
    jsr CalculateFirstBGCollisionPoint
    ldx #$08 ; Temp06_NextPointYOffset = 8
    ldy #$00 ; Temp07_NextPointXOffset = 0
    lda Temp01_CollisionPointXMod8
    jmp LE7DE

StoreObjectPositionToTemp:
    lda ObjHi,x
    sta Temp0B_PositionHi
    lda ObjY,x
    sta Temp08_PositionY
    lda ObjX,x
    sta Temp09_PositionX
    rts

;--------------------------------------------------------
; Visualizations: (| is block boundary, l is left remainder, c is center, r is right remainder)
; |  ll|cccc|cccc|rr  | object spans 4 blocks and there are left and right remainders
; |cccc| object spans 1 block and there's no left nor right remainders
; |  ll|rr  | object spans 2 blocks and there are left and right remainders
; |  ll| object spans 1 block and right/bottom is at a block boundary
; |rr  | object spans 1 block and left/top is at a block boundary
GetNumBlocksToCheck:
    ; $04 = left remainder size
    eor #$FF
    clc
    adc #$01
    and #$07
    sta Temp04_NumBlocksToCheck
    ; center
    ; diameter without left remainder
    tya
    asl
    sec
    sbc Temp04_NumBlocksToCheck
    bcs Lx210
        ; | cc | Special case: object spans 1 block and doesn't touch any block boundary
        adc #$08
    Lx210:
    tay
    lsr
    lsr
    lsr
    sta Temp04_NumBlocksToCheck
    ; check for right remainder
    tya
    and #$07
    beq Lx211
        ; there's a right remainder
        inx
    Lx211:
    txa
    clc
    adc Temp04_NumBlocksToCheck
    rts
;-----------------------------------------------------------

EnemyCheckMoveLeft:
    ldx PageIndex
    ; X radius + 8 to check block directly to the left
    lda EnsExtra.0.radX,x
    clc
    adc #$08
    jmp EnemyCheckMoveHorizontalBranch

EnemyCheckMoveRight:
    ldx PageIndex
    ; check block directly to the right
    lda #$00
    sec
    sbc EnsExtra.0.radX,x

EnemyCheckMoveHorizontalBranch:
    sta Temp03_DistToCenterX
    jsr StoreEnemyPositionToTemp
    ldy EnsExtra.0.radY,x
    jmp CheckMoveHorizontal

;----------------------------------------------
; Like ApplySpeedToPosition but no bounds checking (wraps around)
CalculateFirstBGCollisionPoint:
    ; Y
    lda Temp02_DistToCenterY
    bpl Lx213
        ; check bottom boundary
        jsr LE95F
        bcs Lx212
        cpx #$F0
        bcc Lx214
    Lx212:
        ; bottom boundary >= 240, adjust
        txa
        adc #$0F
        jmp LE934
    Lx213:
    ; check top boundary
    jsr LE95F
    lda Temp08_PositionY
    sec
    sbc Temp02_DistToCenterY
    tax
    and #$07
    sta Temp00_CollisionPointYMod8
    bcs Lx214
        ; bottom boundary < 0, adjust
        txa
        sbc #$0F
    LE934:
        tax
        ; branch if scrolling horizontally (allows Samus to wrap around)
        lda ScrollDir
        and #$02
        bne Lx214
        ; move to next nametable
        inc Temp0B_PositionHi
    Lx214:
    ; store Y position of collision point
    stx Temp02_PositionY
    ; X
    ; messy code to check for X wraparound, involving carry
    ldx #$00
    lda Temp03_DistToCenterX
    bmi Lx215
        ; checking left boundary
        dex
    Lx215:
    ; calculate X position of collision point
    lda Temp09_PositionX
    sec
    sbc Temp03_DistToCenterX
    sta Temp03_PositionX
    and #$07
    sta Temp01_CollisionPointXMod8
    txa
    adc #$00
    beq RTS_X216
    ; X wrapped around, adjust
    ; return if scrolling vertically (allows Samus to wrap around)
    lda ScrollDir
    and #$02
    beq RTS_X216
    ; move to next nametable
    inc Temp0B_PositionHi
RTS_X216:
    rts

;---------------------------------------------
LE95F:
    ; X = bottom boundary
    ; A = $00 = bottom boundary % 8
    lda Temp08_PositionY
    sec
    sbc Temp02_DistToCenterY
    tax
    and #$07
    sta Temp00_CollisionPointYMod8
    rts

;------------------------------------[ Object pointer into cart RAM ]-------------------------------

;Find object's equivalent position in room RAM based on object's coordinates.
;In: $02 = ObjY, $03 = ObjX, $0B = ObjHi. Out: $04 = cart RAM pointer.

MakeRoomRAMPtr:
    ;Set pointer to $6xxx(cart RAM).
    lda #RoomRAMA >> 10.b
    sta Temp04_RoomRAMPtr+1.b
    ;Object Y room position.
    lda Temp02_PositionY
    ;Drop 3 LSBs. Only use multiples of 8.
    and #$F8
    ;Move upper 2 bits to lower 2 bits of $05
    asl
    rol Temp04_RoomRAMPtr+1.b
    asl
    rol Temp04_RoomRAMPtr+1.b
    ;move bits 3, 4, 5 to upper 3 bits of $04.
    sta Temp04_RoomRAMPtr
    ;Object X room position.
    lda Temp03_PositionX
    ;A=ObjX/8.
    lsr
    lsr
    lsr
    ;Put bits 0 thru 4 into $04.
    ora Temp04_RoomRAMPtr
    sta Temp04_RoomRAMPtr
    ;Object nametable.
    lda Temp0B_PositionHi
    ; A=ObjHi*4.
    asl
    asl
    ;Set bit 2 if object is on nametable 3.
    and #$04
    ;Include nametable bit in $05.
    ora Temp04_RoomRAMPtr+1.b
    sta Temp04_RoomRAMPtr+1.b
    ;Return pointer in $04 = 01100HYY YYYXXXXX.
    rts

;---------------------------------------------------------------------------------------------------

CalculateNextBGCollisionPoint:
    ; point Y += next point Y offset
    lda Temp02_PositionY
    clc
    adc Temp06_NextPointYOffset
    sta Temp02_PositionY
    cmp #$F0
    bcc Lx217
    ; point Y >= 240, adjust
    adc #$0F
    sta Temp02_PositionY
    ; branch if scrolling horizontally (allows Samus to wrap around)
    lda ScrollDir
    and #$02
    bne Lx217
    ; move to next nametable
    inc Temp0B_PositionHi
Lx217:
    ; point X += next point X offset
    lda Temp03_PositionX
    clc
    adc Temp07_NextPointXOffset
    sta Temp03_PositionX
    bcc RTS_X218
    ; point X >= 256, adjust
    ; return if scrolling vertically (allows Samus to wrap around)
    lda ScrollDir
    and #$02
    beq RTS_X218
    ; move to next nametable
    inc Temp0B_PositionHi
RTS_X218:
    rts

ToggleNameTable:
    lda PPUCTRL_ZP
    eor #$03
    sta PPUCTRL_ZP
    rts

IsBlastTile:
    ldy UpdatingProjectile
    beq Exit18
IsBlastTile_SkipCheckUpdatingProjectile:
    tay
    jsr GotoUpdateBullet_CollisionWithZebetiteAndMotherBrainGlass
    cpy #$98
    bcs Lx223
; attempt to find a vacant tile slot
    ldx #_sizeof_TileBlasts - _sizeof_TileBlasts.0.b
    Lx219:
        lda TileBlasts.0.routine,x
        beq Lx220                           ; 0 = free slot
        jsr Xminus16
        bne Lx219
    lda TileBlasts.0.routine,x
    bne Lx223                        ; no more slots, can't blast tile
Lx220:
    inc TileBlasts.0.routine,x
    lda $04
    and #$DE
    sta TileBlasts.0.roomRAMPtr,x
    lda $05
    sta TileBlasts.0.roomRAMPtr+1,x
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
    sta TileBlasts.0.type,x
Lx223:
    clc
Exit18:
    rts

;------------------------------------------[ Select room RAM ]---------------------------------------

SelectRoomRAM:
    ;Find name table to draw room on.
    jsr GetNameTableAtScrollDir
    ;A=#$64 for name table 3, A=#$60 for name table 0.
    asl
    asl
    ora #>RoomRAMA.b
    ;Save two byte pointer to start of proper room RAM.
    sta RoomRAMPtr+1.b
    lda #$00
    sta RoomRAMPtr
    rts

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
RTS_EA2A:
    rts

;------------------------------------------[ Setup room ]--------------------------------------------

SetupRoom:
    lda RoomNumber                  ;Room number.
    cmp #$FF                        ;
    beq RTS_EA2A                           ;Branch to exit if room is undefined.
    cmp #$FE                        ;
    beq LEA5D                           ;Branch if empty place holder byte found in room data.
    cmp #$F0                        ;
    bcs AttribTableWrite                          ;Branch if time to write PPU attribute table data.
    jsr DeleteOffscreenRoomSprites  ;($EC9B)Delete offscreen room sprites.

    jsr ScanForItems                ;($ED98)Set up any special items.
    lda RoomNumber                  ;Room number to load.
    asl                             ;*2(for loading address of room pointer).
    tay                             ;
    lda (RoomPtrTable),y            ;Low byte of 16-bit room pointer.-->
    sta RoomPtr                     ;Base copied from $959A to $3B.
    iny                             ;
    lda (RoomPtrTable),y            ;High byte of 16-bit room pointer.-->
    sta RoomPtr+1.b                   ;Base copied from $959B to $3C.
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
    lda RoomRAMPtr                  ;
    sta RoomRAMWorkPtr              ;Set the working pointer equal to the room pointer-->
    lda RoomRAMPtr+1.b                ;(start at beginning of the room).
    sta RoomRAMWorkPtr+1.b            ;
    lda $0E                         ;Reload object position byte.
    jsr Adiv16                      ;($C2BF)/16. Lower nibble contains object y position.-->
    tax                             ;Transfer it to X, prepare for loop.
    beq LEA80                         ;Skip y position calculation loop as y position=0 and-->
                                        ;does not need to be calculated.
    LEA72:
        lda RoomRAMWorkPtr              ;Low byte of pointer working in room RAM.
        clc                             ;
        adc #$40                        ;Advance two rows in room RAM(one y unit).
        sta RoomRAMWorkPtr              ;
        bcc LEA7D                           ;If carry occurred, increment high byte of pointer-->
            inc RoomRAMWorkPtr+1.b            ;in room RAM.
        LEA7D:
        dex                             ;
        bne LEA72                          ;Repeat until at desired y position(X=0).

LEA80:
    lda $0E                         ;Reload object position byte.
    and #$0F                        ;Remove y position upper nibble.
    asl                             ;Each x unit is 2 tiles.
    adc RoomRAMWorkPtr              ;
    sta RoomRAMWorkPtr              ;Add x position to room RAM work pointer.
    bcc LEA8D                           ;If carry occurred, increment high byte of room RAM work-->
    inc RoomRAMWorkPtr+1.b            ;pointer, else branch to draw object.

;RoomRAMWorkPtr now points to the object's starting location (upper left corner)
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
    sta StructPtr+1.b                 ;
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
    ;add index in A to low byte of room pointer.
    clc
    adc RoomPtr
    sta RoomPtr
    ;Did carry occur? If not branch to exit.
    bcc RTS_EAC9
        ;Increment high byte of room pointer if carry occured.
        inc RoomPtr+1.b
    RTS_EAC9:
    rts

;----------------------------------------------------------------------------------------------------

EndOfObjs:
    ;Store room pointer in $0000.
    lda RoomPtr
    sta $00
    lda RoomPtr+1.b
    sta $01
    ;Prepare to increment to enemy/door data.
    lda #$01

EnemyLoop:
    ;Add A to pointer at $0000.
    jsr AddToPtr00
    ;Get first byte of enemy/door data.
    ldy #$00
    lda ($00),y
    ;End of enemy/door data? If so, branch to finish room setup.
    cmp #$FF
    beq EndOfRoom

    ;Discard upper four bits of data.
    and #$0F
    jsr ChooseRoutine               ;Jump to proper enemy/door handling routine.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadEnemy                 ;($EB06)Room enemies.
        .word LoadDoor                  ;($EB8C)Room doors.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadElevator              ;($EC04)Elevator.
        .word ExitSub                   ;($C45C)Rts.
        .word LoadStatues               ;($EC2F)Kraid & Ridley statues.
        .word LoadPipeBugHole           ;($EC57)Regenerating enemies(such as Zeb).

EndOfRoom:
    ;Prepare for PPU attribute table write.
    ldx #$F0
    stx RoomNumber
    ;Make temp copy of ScrollDir.
    lda ScrollDir
    sta TempScrollDir
    ;Check if scrolling left or right.
    and #$02
    bne Lx224
        jmp EndOfRoomVertical
    Lx224:
        jmp EndOfRoomHorizontal

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
    ;Number of bytes to add to ptr to find next room item.
    lda #$03
    rts

GetEnemyType: ; ($EB28)
    pha                             ;Store enemy type.
    and #$C0                        ;If MSB is set, the "tough" version of the enemy
    sta EnSpecialAttribs,x          ;is to be loaded(double health, except rippers).
    asl                             ;
    bpl Lx228                          ;If bit 6 is set, the enemy is either Kraid or Ridley.
        lda InArea                      ;Load current area Samus is in(to check if Kraid or-->
        and #$06                        ;Ridley is alive or dead).
        lsr                             ;Use InArea to find status of Kraid/Ridley statue.
        tay                             ;
        lda KraidStatueStatus-1,y       ;Load status of Kraid/Ridley statue.
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
    sta EnsExtra.0.type,x               ;Store index byte.
    rts

LEB4D:
    tay                             ;Save enemy position data in Y.
    and #$F0                        ;Extract Enemy y position.
    ora #$08                        ;Add 8 pixels to y position so enemy is always on screen.
    sta EnY,x                ;Store enemy y position.
    tya                             ;Restore enemy position data.
    jsr Amul16                      ;*16 to extract enemy x position.
    ora #$0C                        ;Add 12 pixels to x position so enemy is always on screen.
    sta EnX,x                ;Store enemy x position.
    lda #enemyStatus_Resting        ;
    sta EnsExtra.0.status,x                  ;Indicate object slot is taken.
    lda #$00
    sta EnIsHit,x
    jsr GetNameTableAtScrollDir       ;Get name table to place enemy on.
    sta EnsExtra.0.hi,x               ;Store name table.
LEB6E:
    ldy EnsExtra.0.type,x               ;Load A with index to enemy data.
    asl EnData05,x                     ;*2
    jsr LFB7B
    jmp InitEnemyForceSpeedTowardsSamusDelayAndHealth

IsSlotTaken:
    lda EnsExtra.0.status,x
    beq @RTS
        lda EnData05,x
        and #$02
    @RTS:
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
;The same diagonal traversal of the name tables illustrated above applies to vertical traversal as
;well. Since Samus can only travel between 2 name tables and not 4, the name table placement for
;objects is simplified.  The following code determines which name table to use next:

GetNameTableAtScrollDir: ; 07:EB85
    ;Store #$01 if object should be loaded onto name table 3.
    ;Store #$00 if it should be loaded onto name table 0.
    lda PPUCTRL_ZP
    eor ScrollDir
    and #$01
    rts

;----------------------------------------------------------------------------------------------------

; LoadDoor
; ========

LoadDoor:
    jsr SpawnDoorRoutine
Lx230:
    jmp EnemyLoop    ; do next room object

SpawnDoorRoutine:
    iny
    lda ($00),y     ; door info byte
    pha
    jsr Amul16      ; CF = door side (0=right, 1=left)
    php
    ; get color on checkerboard (white square = MapPosX + MapPosY even, black square = vice versa)
    lda MapPosX
    clc
    adc MapPosY
    plp
    rol
    and #$03
    tay
    ldx DoorSlots,y
    pla          ; retrieve door info
    and #$03
    sta DoorType,x     ; door type
    tya
    pha
    lda DoorType,x
    cmp #$01
    beq @if_B
    cmp #$03
    beq @if_B
    ; missile door, check item ID
    lda #$0A
    sta $09
    ldy MapPosX
    txa
    jsr Amul16       ; * 16
    bcc @endif_A
        ; left door, Y = MapPosX - 1 so adjacent doors stay open
        dey
    @endif_A:
    tya
    jsr LEE41
    jsr CheckForItem
    ; branch if door opened
    bcs @endIf_B
    @if_B:
        ; blue door or unopened missile door, set door action to init
        lda #$01
        sta ObjAction,x
    @endIf_B:
    pla
    and #$01        ; A = door side (0=right, 1=left)
    tay
    jsr GetNameTableAtScrollDir
    sta ObjHi,x
    lda DoorXs,y    ; get door's X coordinate
    sta ObjX,x
    lda #$68        ; door Y coord is always #$68
    sta ObjY,x
    ; block scroll at nametable the door is in
    lda DoorScrollBlocks,y
    tay
    jsr GetNameTableAtScrollDir
    eor #$01
    tax
    tya
    ora ScrollBlockOnNameTable3,x
    sta ScrollBlockOnNameTable3,x

    lda #$02
    rts

DoorXs:
    .byte $F0        ; X coord of RIGHT door
    .byte $10        ; X coord of LEFT door
DoorScrollBlocks:
    .byte $02        ; right
    .byte $01        ; left
DoorSlots:
    .byte $80        ; right on white square
    .byte $B0        ; left on white square
    .byte $A0        ; right on black square
    .byte $90        ; left on black square

; LoadElevator
; ============

LoadElevator:
    jsr SpawnElevatorRoutine
    bne Lx230           ; branch always

SpawnElevatorRoutine:
    lda ElevatorStatus
    bne @exit      ; exit if elevator already present
    iny
    lda ($00),y
    sta ElevatorType
    ldy #$83
    sty ObjY+$20       ; elevator Y coord
    lda #$80
    sta ObjX+$20       ; elevator X coord
    jsr GetNameTableAtScrollDir
    sta ObjHi+$20       ; high Y coord
    lda #_id_ObjFrame_Elevator.b
    sta ObjAnimFrame+$20       ; elevator frame
    inc ElevatorStatus              ;1
@exit:
    lda #$02
    rts

; LoadStatues
; ===========

LoadStatues:
    ; set statues object hi position
    jsr GetNameTableAtScrollDir
    sta StatueHi

    ; set kraid statue y position
    lda #$40
    ldx RidleyStatueStatus
    bpl @elseIf_A      ; branch if Ridley statue not hit
        lda #$30
    @elseIf_A:
    sta RidleyStatueY

    ; set ridley statue y position
    lda #$60
    ldx KraidStatueStatus
    bpl @elseIf_B      ; branch if Kraid statue not hit
        lda #$50
    @elseIf_B:
    sta KraidStatueY

    ; clear StatuesBridgeIsSpawned
    ; y is #$00 here
    sty StatuesBridgeIsSpawned
    ; set status to #$01 (first bg tile update batch)
    lda #$01
    sta StatueStatus
Lx237:
    jmp EnemyLoop   ; do next room object


LoadPipeBugHole:
    ; find first open pipe bug hole slot
    ldx #_sizeof_PipeBugHoles
    @loop:
        txa
        sec
        sbc #_sizeof_PipeBugHoles.0
        ; exit if no slots are open
        bmi @exit
        tax
        ; slot is occupied if status is not #$FF
        ldy PipeBugHoles.0.status,x
        iny
        bne @loop
    ; slot found, spawn pipe bug hole
    ; set enemy slot
    ldy #$00
    lda ($00),y
    and #$F0
    sta PipeBugHoles.0.enemySlot,x
    ; set status (enemy type to be spawned)
    iny
    lda ($00),y
    sta PipeBugHoles.0.status,x
    ; set position
    iny
    lda ($00),y
    tay
    and #$F0
    ora #$08
    sta PipeBugHoles.0.y,x
    tya
    jsr Amul16       ; * 16
    ora #$00
    sta PipeBugHoles.0.x,x
    jsr GetNameTableAtScrollDir
    sta PipeBugHoles.0.hi,x
@exit:
    lda #$03
    bne Lx237

OnNameTable0:
    ;If currently on name table 0, return #$01. Else return #$00.
    lda PPUCTRL_ZP
    eor #$01
    and #$01
    tay
    rts

; Despawn offscreen room sprites to make room for new room sprites.
DeleteOffscreenRoomSprites:
    ; This seems useless because it's already cleared when starting door transition
    ; X = 0 if ScrollDir = down, 1 if left, 2 if right, 3 if up
    ldx ScrollDir
    dex
    ldy #$00
    jsr UpdateDoorData              ;($ED51)Update name table 0 door data.
    iny
    jsr UpdateDoorData              ;($ED51)Update name table 3 door data.

    ; If the enemy is in the opposite nametable and is offscreen, delete it.
    ldx #$50
    jsr GetNameTableAtScrollDir
    tay
    @loop_enemies:
        tya
        eor EnsExtra.0.hi,x
        lsr
        bcs @dontDeleteEnemy
        lda EnData05,x
        and #$02
        bne @dontDeleteEnemy
            sta EnsExtra.0.status,x
        @dontDeleteEnemy:
        jsr Xminus16
        bpl @loop_enemies
    ; same thing with mellows
    ldx #_sizeof_Mellows - _sizeof_Mellows.0.b
    @loop_mellows:
        tya
        eor Mellows.0.hi,x
        lsr
        bcs @dontDeleteMellow
            lda #$00
            sta Mellows.0.status,x
        @dontDeleteMellow:
        txa
        sec
        sbc #_sizeof_Mellows.0
        tax
        bpl @loop_mellows
    ; doors
    jsr Doors_RemoveIfOffScreen
    jsr EraseScrollBlockOnNameTableAtScrollDir
    jsr GetNameTableAtScrollDir
    asl
    asl
    tay
    ; tile blasts
    ldx #_sizeof_TileBlasts - _sizeof_TileBlasts.0.b
    @loop_tileBlasts:
        tya
        eor TileBlasts.0.roomRAMPtr+1,x
        and #$04
        bne @dontDeleteTileBlast
            sta TileBlasts.0.routine,x
        @dontDeleteTileBlast:
        jsr Xminus16
        cmp #-_sizeof_TileBlasts.0.b
        bne @loop_tileBlasts
    tya
    lsr
    lsr
    tay
    ; non-beam projectiles
    ldx #$D0
    jsr Projectile_RemoveIfOffScreen
    ldx #$E0
    jsr Projectile_RemoveIfOffScreen
    ldx #$F0
    jsr Projectile_RemoveIfOffScreen
    tya
    ; elevator
    sec
    sbc ObjHi+$20
    bne Lx246
        sta ElevatorStatus
    Lx246:
    ; unused RAM $0700-$0723
    ldx #_sizeof_Mem0700 - _sizeof_Mem0700.0.b
    Lx247:
        lda Mem0700.0.data04,x
        bne Lx248
            lda #$FF
            sta Mem0700.0.data00,x
        Lx248:
        txa
        sec
        sbc #_sizeof_Mem0700.0
        tax
        bpl Lx247
    ; statues
    cpy StatueHi
    bne Lx249
        lda #$00
        sta StatueStatus
    Lx249:
    ; pipe bug holes
    ldx #_sizeof_PipeBugHoles - _sizeof_PipeBugHoles.0.b
    Lx250:
        tya
        cmp PipeBugHoles.0.hi,x
        bne Lx251
            lda #$FF
            sta PipeBugHoles.0.status,x
        Lx251:
        txa
        sec
        sbc #_sizeof_PipeBugHoles.0
        tax
        bpl Lx250
    ; power-ups
    ldx #$00
    jsr PowerUp_RemoveIfOffScreen
    ldx #_sizeof_PowerUps.0
    jsr PowerUp_RemoveIfOffScreen
    ; tourian stuff
    jmp GotoDeleteOffscreenRoomSprites_Tourian

UpdateDoorData:
    ; 3 if ScrollDir = down, 2 if left, 1 if right, 0 if up
    txa                             ;
    eor #$03                        ;
    and ScrollBlockOnNameTable3,y   ;Moves door info from one name table to the next-->
LED57:
    sta ScrollBlockOnNameTable3,y   ;when the room is transferred across name tables.
    rts

EraseScrollBlockOnNameTableAtScrollDir:
    jsr GetNameTableAtScrollDir
    eor #$01
    tay
    lda #$00
    beq LED57 ; branch always

Doors_RemoveIfOffScreen:
    ; loop through all doors
    ldx #$B0
    @loop:
        ; branch if door doesn't exist
        lda DoorStatus,x
        beq @endIf_A
        ; branch if door is on screen
        lda DoorOnScreen,x
        bne @endIf_A
            ; door exists but is not on screen
            ; remove door
            sta DoorStatus,x
        @endIf_A:
        ; check next door
        jsr Xminus16
        bmi @loop
    rts

; y = current nametable
Projectile_RemoveIfOffScreen:
    ; exit if projectile doesn't exist or is a beam
    lda ProjectileStatus,x
    cmp #wa_BulletExplode+1.b
    bcc @RTS

    ; exit if projectile is in current nametable
    tya
    eor ProjectileHi,x
    ; shift bit 0 into carry
    lsr
    bcs @RTS

    ; projectile exists but is not on screen
    ; remove projectile
    sta ProjectileStatus,x
@RTS:
    rts

; y = current nametable
PowerUp_RemoveIfOffScreen:
    ; exit if power-up is in the current nametable
    tya
    cmp PowerUps.0.hi,x
    bne Exit11

    ; remove power-up
    lda #$FF
    sta PowerUps.0.type,x
Exit11:
    rts

;---------------------------------------[ Setup special items ]--------------------------------------

;The following routines look for special items on the game map and jump to
;the appropriate routine to load those items.

ScanForItems:
    lda AreaPointers               ;Low byte of ptr to 1st item data.
    sta $00                         ;
    lda AreaPointers+1             ;High byte of ptr to 1st item data.

ScanOneItem:
    sta $01                         ;
    ldy #$00                        ;Index starts at #$00.
    lda ($00),y                     ;Load map Ypos of item.-->
    cmp MapPosY                ;Does it equal Samus' Ypos on map?-->
    beq LEDBE                       ;If yes, check Xpos too.

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
    cmp MapPosX                ;Does it equal Samus' Xpos on map?-->
    beq LEDD4                       ;If so, then load object.
    bcs Exit11                      ;Exit if item pos X > Samus Pos X.

    iny
    ;Check for another item on same Y pos.
    ;This will double return if there are no more items (from AnotherItem routine and from this routine)
    jsr AnotherItem
    ;Try next X coord.
    jmp ScanItemX

LEDD4:
    lda #$02                        ;Move ahead two bytes to find item data.

ChooseSpawningRoutine:
    jsr AddToPtr00                  ;($EF09)Add A to pointer at $0000.
    ldy #$00                        ;
    lda ($00),y                     ;Object type
    and #$0F                        ;Object handling routine index stored in 4 LSBs.
    jsr ChooseRoutine               ;($C27C)Load proper handling routine from table below.
        .word ExitSub               ;($C45C)rts.
        .word SpawnMapEnemy         ;($EDF8)Enemies, used by some squeepts.
        .word SpawnPowerUp          ;($EDFE)Power-ups.
        .word SpawnMellows          ;($EE63)Mellows, Mellas and Memus.
        .word SpawnElevator         ;($EEA1)Elevators.
        .word SpawnCannon           ;($EEA6)Mother brain room cannons.
        .word SpawnMotherBrain      ;($EEAE)Mother brain.
        .word SpawnZebetite         ;($EECA)Zebetites.
        .word SpawnRinkaSpawner     ;($EEEE)Rinkas.
        .word SpawnDoor             ;($EEF4)Some doors.
        .word SpawnPalette          ;($EEFA)Background palette change.

;---------------------------------------[ Squeept handler ]------------------------------------------

SpawnMapEnemy:
    jsr GetEnemyData                ;($EB0C)Load Squeept data.
@exit:
    jmp ChooseSpawningRoutine        ;($EDD6)Exit handler routines.

;--------------------------------------[ Power-up Handler ]------------------------------------------

SpawnPowerUp:
    ; set y to 1, to prepare to load power-up item type
    iny
    ; find power up slot
    ;Is first power-up item slot available? if yes, use the slot to load item.
    ldx #$00
    lda #$FF
    cmp PowerUps.0.type
    beq @endIf_A
        ;Prepare to check second power-up item slot.
        ;Is second power-up item slot available? If not, the power-up fails to spawn, branch to exit.
        ldx #_sizeof_PowerUps.0
        cmp PowerUps.1.type
        bne @exit
        ; second slot is available. use the slot to load item.
    @endIf_A:

    ;load power-up item type.
    lda ($00),y
    ;($EE3D)Get unique item ID.
    jsr PrepareItemID
    ; exit if Samus already has item.
    jsr CheckForItem
    bcs @exit

    ; set y to 2, to prepare to load x and y screen position of item.
    ldy #$02
    ;Store power-up type in available item slot.
    lda Temp09_ItemType
    sta PowerUps.0.type,x
    ; load x and y screen position of item.
    lda ($00),y
    ;Save position data for later processing.
    tay
    ;Extract Y coordinate. + 8 to find Y coordinate center.
    and #$F0
    ora #$08
    ;Store center Y coord
    sta PowerUps.0.y,x
    ;Reload position data.
    tya
    ;Move lower 4 bits to upper 4 bits. + 8 to find X coordinate center.
    jsr Amul16
    ora #$08
    ;Store center X coord
    sta PowerUps.0.x,x
    ;Get name table to place item on.
    jsr GetNameTableAtScrollDir
    ;Store name table Item is located on.
    sta PowerUps.0.hi,x
@exit:
    ;Get next data byte(Always #$00).
    lda #$03
    bne SpawnMapEnemy@exit ;Branch always to exit handler routines.

PrepareItemID:
    ;Store item type.
    sta Temp09_ItemType

    lda MapPosX
LEE41:
    ;Store item X coordinate.
    sta Temp07_ItemX

    lda MapPosY
    ;Store item Y coordinate.
    sta Temp06_ItemY

    ;($DC67)Get unique item ID.
    jmp CreateItemID


; return carry clear if samus doesnt have the item
; return carry set if samus has the item
CheckForItem:
    ; if Samus has no unique items, Load item and exit.
    ldy NumberOfUniqueItems
    beq @samusDoesNotHaveThisItem
    @loop:
        ;Look for upper byte of unique item. branch if it doesn't match
        lda Temp06_ItemID+1.b
        cmp UniqueItemHistory-1,y
        bne @noMatch
        ; upper byte matches
        ;Look for lower byte of unique item.
        lda Temp06_ItemID
        cmp UniqueItemHistory-2,y
        ;If lower byte matches, Samus already has item. Return carry set
        beq @samusHasThisItem
    @noMatch:
        ; this item doesn't match
        ;Loop until all Samus' unique items are checked.
        dey
        dey
        bne @loop
@samusDoesNotHaveThisItem:
    ;Samus does not have the item. Return carry clear. It will be placed on screen.
    clc
@samusHasThisItem:
    rts

;-----------------------------------------------------------------------------------------------------

SpawnMellows:
    ; try to spawn a mellow in all available mellow slots
    ldx #_sizeof_Mellows - _sizeof_Mellows.0.b
    ; store random number in MellowRandomNumber
    lda RandomNumber1
    adc FrameCount
    sta MellowRandomNumber
    @loop:
        ; spawn a mellow in that slot if possible
        jsr SpawnMellow
        ; move to next slot
        txa
        sec
        sbc #_sizeof_Mellows.0
        tax
        bpl @loop
    ;
    lda AreaMellowAnimIndex
    sta EnsExtra.15.resetAnimIndex
    sta EnsExtra.15.animIndex
    lda #$01
    sta EnsExtra.15.status
SpawnMellows_exit:
    jmp ChooseSpawningRoutine        ;($EDD6)Exit handler routines.

SpawnMellow:
    ; exit if slot is occupied
    lda Mellows.0.status,x
    bne @RTS

    ; slot is available, spawn mellow
    ; set y pos to random number
    txa
    adc MellowRandomNumber
    and #$7F
    sta Mellows.0.y,x
    ; set x pos to random number
    adc RandomNumber2
    sta Mellows.0.x,x
    ; set nametable
    jsr GetNameTableAtScrollDir
    sta Mellows.0.hi,x
    ; set status to resting
    lda #$01
    sta Mellows.0.status,x
    ; rotate random number
    rol MellowRandomNumber
@RTS:
    rts

SpawnElevator:
    jsr SpawnElevatorRoutine
    bne SpawnMellows_exit                          ;Branch always.

SpawnCannon:
    jsr GotoSpawnCannonRoutine
    lda #$02
SpawnCannon_exit:
    jmp ChooseSpawningRoutine        ;($EDD6)Exit handler routines.

SpawnMotherBrain:
    jsr GotoSpawnMotherBrainRoutine
    ; branch if mother brain is not dead
    lda #>ui_MOTHERBRAIN.b
    sta Temp06_ItemID+1.b
    lda #<ui_MOTHERBRAIN.b
    sta Temp06_ItemID
    jsr CheckForItem
    bcc SpawnMotherBrain_exit
        ; mother brain is dead
        ; set status to redraw time bomb message that had been scrolled offscreen
        lda #$08
        sta MotherBrainStatus
        ; set time bomb message counter to first part of the message
        lda #$00
        sta MotherBrainTimeBombCounter
    SpawnMotherBrain_exit:
    lda #$01
    bne SpawnCannon_exit ; branch always

SpawnZebetite:
    jsr GotoSpawnZebetiteRoutine
    txa
    lsr
    adc #>ui_ZEBETITE1.b
    sta Temp06_ItemID+1.b
    lda #<ui_ZEBETITE1.b
    sta Temp06_ItemID
    jsr CheckForItem
    bcc @endIf_A
        ; Kill Zebetite
        lda #$81
        sta Zebetites.0.status,x
        lda #$01
        sta Zebetites.0.isHit,x
        lda #$07
        sta Zebetites.0.qtyHits,x
    @endIf_A:
    jmp SpawnMotherBrain_exit

SpawnRinkaSpawner:
    jsr GotoSpawnRinkaSpawnerRoutine
    jmp SpawnMotherBrain_exit

SpawnDoor:
    jsr SpawnDoorRoutine
    jmp ChooseSpawningRoutine        ;($EDD6)Exit handler routines.

SpawnPalette:
    lda ScrollDir
    sta DoorPalChangeDir
    bne SpawnMotherBrain_exit

AnotherItem: ;($EF00)
    ;Is there another item with same Y pos? If so, A is amount to add to ptr. to find X pos.
    lda ($00),y
    cmp #$FF
    bne AddToPtr00
    ;No more items to check. Pull last subroutine off stack and exit.
    pla
    pla
    rts

AddToPtr00: ;($EF09)
    ;A is added to the 16 bit address stored in $0000.
    clc
    adc $00
    sta $00
    bcc @RTS
        inc $01
    @RTS:
    rts

;----------------------------------[ Draw structure routines ]----------------------------------------

;Draws one row of the structure.
;A = number of 2x2 tile metatiles to draw horizontally.

DrawStructRow:
    ;Row length(in metatiles). Range #$00 thru #$0F.
    and #$0F
    bne LEF19
        ;#$00 in row length=16.
        lda #$10
    LEF19:
    ;Store horizontal metatile count.
    sta Temp0E_MetatileCounter
    ;Get length byte again. Upper nibble contains x coord offset(if any).
    lda (StructPtr),y
    jsr Adiv16
    ;*2, because a metatile is 2 tiles wide.
    asl
    ;Add x coord offset to RoomRAMWorkPtr and save in $00.
    adc RoomRAMWorkPtr
    sta Temp00_RoomRAMPtr
    ;Save high byte of work pointer in $01.
    lda #$00
    adc RoomRAMWorkPtr+1.b
    sta Temp00_RoomRAMPtr+1.b
    ;$0000 = work pointer.

DrawMetatile:
    ;High byte of current location in room RAM.
    lda Temp00_RoomRAMPtr+1.b
    ;Check high byte of room RAM address for both room RAMs to see if the attribute table data-->
    ;for the room RAM has been reached.
    ;If so, branch to check lower byte as well.
    ;If not at end of room RAM, branch to draw metatile.
    cmp #$63
    beq @checkLowByte
    cmp #$67
    bcc @checkSuccess
    beq @checkLowByte
    ;Return if have gone past room RAM(should never happen).
    rts

@checkLowByte:
    ;Low byte of current nametable address.
    lda Temp00_RoomRAMPtr
    ;Reached attrib table? If not, branch to draw the metatile.
    cmp #$A0
    bcc @checkSuccess
    ;Can't draw any more of the structure, exit.
    rts

@checkSuccess:
    ;Increase struct data index.
    inc Temp10_StructIndex
    ;Load struct data index into Y.
    ldy Temp10_StructIndex
    ;Get metatile number. A=metatile number * 4. Each metatile is 4 bytes long.
    lda (StructPtr),y
    asl
    asl
    ;Store metatile index.
    sta Temp11_MetatileIndex
    ;Prepare to copy four tile numbers.
    ldx #$03
    @loop:
        ;Metatile index loaded into Y.
        ldy Temp11_MetatileIndex
        ;Get tile number.
        lda (MetatilePtr),y
        inc Temp11_MetatileIndex
        ;Write tile number to room RAM.
        ldy TilePosTable,x
        sta (Temp00_RoomRAMPtr),y
        ;Done four tiles yet? If not, loop to do another.
        dex
        bpl @loop
    ;Update attribute table if necessary
    jsr UpdateAttrib
    ;Add metatile width(in tiles) to pointer to move to next metatile.
    ldy #$02
    jsr AddYToPtr00
    ;Low byte of current room RAM work pointer.
    lda Temp00_RoomRAMPtr
    ;Still room left in current row? If yes, branch to do another metatile.
    and #$1F
    bne LEF72

;End structure row early to prevent it from wrapping on to the next row..
    ;Struct index.
    lda Temp10_StructIndex
    ;Add number of metatiles remaining in current row.
    clc
    adc Temp0E_MetatileCounter
    ;-1 from metatiles remaining in current row.
    sec
    sbc #$01
    ;($EF78)Move to next row of structure.
    jmp AdvanceRow

LEF72:
    ;Have all metatiles been drawn on this row? If not, branch to draw another metatile.
    dec Temp0E_MetatileCounter
    bne DrawMetatile
    ;Load struct index.
    lda Temp10_StructIndex

AdvanceRow:
    ;Since carry bit is set, addition will be one more than expected.
    ;Update the struct pointer.
    sec
    adc StructPtr
    sta StructPtr
    ;Update high byte of struct pointer if carry occured.
    bcc @endIf_A
        inc StructPtr+1.b
    @endIf_A:
    ;Advance to next metatile row in room RAM(two tile rows).
    lda #$40
    clc
    adc RoomRAMWorkPtr
    sta RoomRAMWorkPtr
    ;Increment high byte of pointer if necessary.
    bcc @endIf_B
        inc RoomRAMWorkPtr+1.b
    @endIf_B:
    ;Begin drawing next structure row.

DrawStruct:
    ;Reset struct index.
    ldy #$00
    sty Temp10_StructIndex
    ;Load data byte.
    lda (StructPtr),y
    ;End-of-struct? If so, branch to exit.
    cmp #$FF
    beq @RTS
    ;($EF13)Draw a row of metatiles.
    jmp DrawStructRow
@RTS:
    rts

;The following table is used to draw metatiles in room RAM. Each metatile is 2 x 2 tiles.
;The following table contains the offsets required to place the tiles in each metatile.

TilePosTable:
    .byte $21                       ;Lower right tile.
    .byte $20                       ;Lower left tile.
    .byte $01                       ;Upper right tile.
    .byte $00                       ;Upper left tile.

;---------------------------------[ Update attribute table bits ]------------------------------------

;The following routine updates attribute bits for one 2x2 tile section on the screen.

UpdateAttrib: ; 07:EF9E
    ;Load attribute data of structure.
    lda ObjectPal
    ;Is it the same as the room's default attribute data?-->
    ;If so, no need to modify the attribute table, exit.
    cmp RoomPal
    beq @RTS

;Figure out cart RAM address of the byte containing the relevant bits.

    ;The following section of code calculates the proper attribute byte that-->
    ;corresponds to the metatile that has just been placed in the room RAM.
    lda Temp00_RoomRAMPtr
    sta Temp02_AttribPtr
    lda Temp00_RoomRAMPtr+1.b
    lsr
    ror Temp02_AttribPtr
    lsr
    ror Temp02_AttribPtr
    lda Temp02_AttribPtr
    and #$07
    sta Temp02_AttribPtr+1.b
    lda Temp02_AttribPtr
    lsr
    lsr
    and #$38
    ora Temp02_AttribPtr+1.b
    ora #$C0
    sta Temp02_AttribPtr
    lda #$63
    sta Temp02_AttribPtr+1.b
    ;$0002 contains pointer to attribute byte.

    ;The following section of code figures out which pair of bits to modify in-->
    ;the attribute table byte for the metatile that has just been placed in the room RAM.
    ldx #$00
    bit Temp00_RoomRAMPtr
    bvc @endIf_A
        ldx #$02
    @endIf_A:
    lda Temp00_RoomRAMPtr
    and #$02
    beq @endIf_B
        inx
    @endIf_B:

;X now contains which metatile attribute table bits to modify:
;+---+---+
;| 0 | 1 |
;+---+---+
;| 2 | 3 |
;+---+---+
;Where each box represents a metatile(2x2 tiles).

;The following code clears the old attribute table bits and sets the new ones.
    ;Load high byte of work pointer in room RAM.
    lda Temp00_RoomRAMPtr+1.b
    and #$04
    ;Choose proper attribute table associated with the current room RAM.
    ora Temp02_AttribPtr+1.b
    sta Temp02_AttribPtr+1.b
    ;Choose appropriate attribute table bit mask from table below.
    lda AttribMaskTable,x
    ;clear the old attribute table bits.
    ldy #$00
    and (Temp02_AttribPtr),y
    sta (Temp02_AttribPtr),y
    ;Load new attribute table data(#$00 thru #$03).
    lda ObjectPal
    @loop:
        dex
        bmi @exitLoop
        ;Attribute table bits shifted one step left
        asl
        asl
        ;Loop until attribute table bits are in the proper location.
        bcc @loop
    @exitLoop:
    ;Set attribute table bits.
    ora (Temp02_AttribPtr),y
    sta (Temp02_AttribPtr),y
@RTS:
    rts

AttribMaskTable:
    .byte %11111100                 ;Upper left metatile.
    .byte %11110011                 ;Upper right metatile.
    .byte %11001111                 ;Lower left metatile.
    .byte %00111111                 ;Lower right metatile.

;------------------------[ Initialize room RAM and associated attribute table ]-----------------------

InitTables:
    lda RoomRAMPtr+1.b                ;#$60 or #$64.
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
    @loop:
        sta ($00),y                     ;Fill attribute table.
        iny                             ;
        bne @loop                       ;Loop until entire attribute table is filled.
    rts

;Data to fill attribute tables with.
ATDataTable:
    .byte %00000000
    .byte %01010101
    .byte %10101010
    .byte %11111111

FillRoomRAM:
    ;Temporarily store A.
    pha
    ;Calculate value to store in X to use as upper byte counter for initilaizing room RAM.
    ;(X = RoomRAMPtrHi+3 - RoomRAMPtrHi - clc = #$FC)
    ;Since carry bit is cleared, result is one less than expected.
    txa
    sty $01
    clc
    sbc $01
    tax
    ;Restore value to fill room RAM with(#$FF).
    pla
    ;Lower address byte to start at.
    ldy #$00
    sty $00
    ;Loop until all the room RAM is filled with #$FF(black).
    @loop_outer:
        @loop_inner:
            sta ($00),y
            dey
            bne @loop_inner
        dec $01
        inx
        bne @loop_outer
    rts

;----------------------------------------------------------------------------------------------------

; Crash detection
; ===============

CollisionDetection:
    lda #$FF
    sta SamusKnockbackIsBomb
    sta SamusHurt010F

; mellow <--> bullet/missile/bomb detection
    ldx #_sizeof_Mellows - _sizeof_Mellows.0.b
    Lx261:
        ; branch if no Mellow in slot
        lda Mellows.0.status,x
        beq Lx266
        cmp #$03
        beq Lx266
        jsr GetMellowXSlotPosition
        jsr IsSamusDead
        beq Lx262
        lda SamusInvincibleDelay
        bne Lx262
        ldy #$00
        jsr CollisionDetectionMellow_CheckWithObjectYSlot
        jsr CollisionDetectionMellow_ReactToCollisionWithSamus
    ; check for crash with samus's projectiles
    Lx262:
        ldy #$D0
        Lx263:
            ; try next projectile if this one is not active
            lda ObjAction,y
            beq Lx265
            ; try next projectile if it is not a bullet, unknown7, bomb or missile
            cmp #wa_BulletExplode
            bcc Lx264
            cmp #wa_Unknown7
            beq Lx264
            cmp #wa_BombExplode
            beq Lx264
            cmp #wa_Missile
            bne Lx265
            Lx264:
                ; projectile is of the right type
                ; hit mellow if they collided
                jsr CollisionDetectionMellow_CheckWithObjectYSlot
                jsr CollisionDetectionMellow_ReactToCollisionWithProjectile
            Lx265:
            jsr Yplus16
            bne Lx263
    Lx266:
        ; each Mellow occupies 8 bytes
        txa
        sec
        sbc #_sizeof_Mellows.0
        tax
        bpl Lx261

; doors <--> samus detection
    ldx #$B0
    Lx267:
        ; check next door if this door is not closed
        lda ObjAction,x
        cmp #$02
        bne Lx268
        ; dont check doors if samus is dead
        ldy #$00
        jsr IsSamusDead
        beq Lx269

        jsr AreObjectsTouching          ;($DC7F)
        jsr CollisionDetectionDoor_F277
    Lx268:
        jsr Xminus16
        bmi Lx267

; enemy <--> bullet/missile/bomb detection and enemy <--> samus detection
Lx269:
    ; start with enemy slot #5
    ldx #$50
    LF09F:
        ; check next enemy if enemy slot is empty
        lda EnsExtra.0.status,x
        beq Lx270
            ; check next enemy if enemy is currently exploding
            cmp #enemyStatus_Explode
        Lx270:
        beq NextEnemy      ; next slot

        ; skip projectile collision if enemy is a pickup
        jsr GetEnemyXSlotPosition
        lda EnsExtra.0.status,x
        cmp #enemyStatus_Pickup
        beq Lx274

        ; first projectile slot
        ldy #$D0
        Lx271:
            lda ObjAction,y  ; is it active?
            beq Lx273            ; branch if not
            cmp #wa_BulletExplode
            bcc Lx272
            cmp #wa_Unknown7
            beq Lx272
            cmp #wa_BombExplode
            beq Lx272
            cmp #wa_Missile
            bne Lx273
            ; check if enemy is actually hit
            Lx272:
                jsr CollisionDetectionEnemy_CheckWithObjectYSlot
                jsr CollisionDetectionEnemy_ReactToCollisionWithProjectile
            Lx273:
            jsr Yplus16          ; next projectile slot
            bne Lx271
    Lx274:
        ; check next enemy if samus has i-frames
        ldy #$00
        lda SamusInvincibleDelay
        bne NextEnemy
        ; check next enemy if samus is dead
        jsr IsSamusDead
        beq NextEnemy
        ; enemy collide with samus
        jsr CollisionDetectionEnemy_CheckWithObjectYSlot
        jsr CollisionDetectionEnemy_ReactToCollisionWithSamus
        NextEnemy:
        jsr Xminus16
        bmi Lx275
            jmp LF09F

; enemy projectile <--> samus detection
Lx275:
    ; get samus coord data
    ldx #$00
    jsr GetObjectXSlotPosition
    ldy #$60
    Lx276:
        lda EnsExtra.0.status,y
        beq Lx277
        cmp #$05
        beq Lx277
        ; check next projectile if samus has i-frames
        lda SamusInvincibleDelay
        bne Lx277
        ; check next projectile if samus is dead
        jsr IsSamusDead
        beq Lx277

        jsr GetRadiusSumsOfObjXSlotAndEnYSlot
        jsr GetEnemyYSlotPosition
        jsr CheckCollisionOfXSlotAndYSlot
        jsr CollisionDetectionEnProjectile_ReactToCollisionWithSamus
    Lx277:
        jsr Yplus16
        cmp #$C0
        bne Lx276

; bomb <--> samus detection
    ; skip this if samus is dead
    ldy #$00
    jsr IsSamusDead
    beq GotoSubtractHealth
    jsr GetObjectYSlotPosition
    ldx #$F0
    Lx278:
        lda ObjAction,x
        cmp #wa_Unknown7
        beq Lx279
        cmp #wa_BombExplode
        bne Lx280
    Lx279:
        jsr LDC82
        jsr SamusHurt_F311
    Lx280:
        jsr Xminus16
        cmp #$C0
        bne Lx278

GotoSubtractHealth:
    jmp SubtractHealth


CollisionDetectionEnemy_CheckWithObjectYSlot:
    jsr GetRadiusSumsOfEnXSlotAndObjYSlot
    jsr GetObjectYSlotPosition
    jmp CheckCollisionOfXSlotAndYSlot

CollisionDetectionMellow_CheckWithObjectYSlot:
    jsr GetObjectYSlotPosition
    jsr AddObjectYSlotRadiusYOf4AndRadiusXOf8
    jmp CheckCollisionOfXSlotAndYSlot

GetEnemyXSlotPosition:
    lda EnY,x
    sta Temp07_XSlotPositionY  ; Y coord
    lda EnX,x
    sta Temp09_XSlotPositionX  ; X coord
    lda EnsExtra.0.hi,x     ; hi coord
    jmp GetXSlotPosition_Common

GetEnemyYSlotPosition:
    lda EnY,y     ; Y coord
    sta Temp06_YSlotPositionY
    lda EnX,y     ; X coord
    sta Temp08_YSlotPositionX
    lda EnsExtra.0.hi,y     ; hi coord
    jmp GetYSlotPosition_Common

GetObjectXSlotPosition:
    lda ObjY,x
    sta Temp07_XSlotPositionY
    lda ObjX,x
    sta Temp09_XSlotPositionX
    lda ObjHi,x
GetXSlotPosition_Common:
    eor PPUCTRL_ZP
    and #$01
    sta Temp0B_XSlotPositionHi
    rts

GetObjectYSlotPosition:
    lda ObjY,y
    sta Temp06_YSlotPositionY
    lda ObjX,y
    sta Temp08_YSlotPositionX
    lda ObjHi,y
GetYSlotPosition_Common:
    eor PPUCTRL_ZP
    and #$01
    sta Temp0A_YSlotPositionHi
    rts

GetMellowXSlotPosition:
    lda Mellows.0.y,x
    sta Temp07_XSlotPositionY
    lda Mellows.0.x,x
    sta Temp09_XSlotPositionX
    lda Mellows.0.hi,x
    jmp GetXSlotPosition_Common

GetRadiusSumsOfObjXSlotAndObjYSlot:
    lda ObjRadY,x
    jsr AddObjectYSlotRadiusY
    lda ObjRadX,x
    jmp AddObjectYSlotRadiusX

GetRadiusSumsOfObjXSlotAndEnYSlot:
    lda ObjRadY,x
    jsr AddEnemyYSlotRadiusY
    lda ObjRadX,x
    jmp AddEnemyYSlotRadiusX

GetRadiusSumsOfEnXSlotAndObjYSlot:
    lda EnsExtra.0.radY,x
    jsr AddObjectYSlotRadiusY
    lda EnsExtra.0.radX,x
    jmp AddObjectYSlotRadiusX

AddEnemyYSlotRadiusX:
    clc
    adc EnsExtra.0.radX,y
    sta Temp05_YSlotRadX
    rts

AddObjectYSlotRadiusYOf4AndRadiusXOf8:
    lda #$04
    jsr AddObjectYSlotRadiusY
    lda #$08

AddObjectYSlotRadiusX:
    clc
    adc ObjRadX,y
    sta Temp05_YSlotRadX
    rts

AddObjectYSlotRadiusY:
    clc
    adc ObjRadY,y
    sta Temp04_YSlotRadY
    rts

AddEnemyYSlotRadiusY:
    clc
    adc EnsExtra.0.radY,y
    sta Temp04_YSlotRadY
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

; return carry set if both things dont overlap
; return carry clear if they do overlap
CheckCollisionOfXSlotAndYSlot:
    ; difference high byte in $10
    ; this is to set bit 2 in SamusIsHit for enemy frozen collision (why?)
    lda #$02
    sta Temp10_DistHi
    ; put horizontal/vertical room flag in $03
    and ScrollDir
    sta Temp03_ScrollDir

    ;subtract y slot entity's y position from x slot entity's y position
    lda Temp07_XSlotPositionY
    sec
    sbc Temp06_YSlotPositionY
    ;Store difference in $00.
    sta Temp00_Diff

    ; branch if room is horizontal
    lda Temp03_ScrollDir
    bne @else_sameHiY
    ; room is vertical
    ; branch if high bytes of y pos are equal
    lda Temp0B_XSlotPositionHi
    eor Temp0A_YSlotPositionHi
    beq @else_sameHiY
        ; high bytes are not equal
        ; this must be reflected in the difference
        jsr @positionHi_notEqual
        ; compensate for the screen height being 240 instead of 256
        lda Temp00_Diff
        sec
        sbc #$100-SCRN_VY.b
        sta Temp00_Diff
        bcs @endIf_A
            dec Temp01_DiffHi
        @endIf_A:
        jmp @endIf_sameHiY
    @else_sameHiY:
        ; high bytes are equal
        lda #$00
        sbc #$00
        jsr @positionHi_equal
    @endIf_sameHiY:
    ; return carry set if y distance is greater or equal to $100
    sec
    lda Temp01_DiffHi
    bne @RTS

    lda Temp00_Diff
    sta Temp11_DistY
    ; return carry set if y distance is greater than both y radius combined
    cmp Temp04_YSlotRadY
    bcs @RTS

    ; both things are overlapping on the y axis
    ; do the x axis

    ; multiply by 2.
    ;  now bit7-3 is clear, bit 2 is set, bit 1 is dist hi y
    ;  bit 0 will be dist hi x
    asl Temp10_DistHi

    ;subtract y slot entity's x position from x slot entity's x position
    lda Temp09_XSlotPositionX
    sec
    sbc Temp08_YSlotPositionX
    ;Store difference in $00.
    sta Temp00_Diff

    ; branch if room is vertical
    lda Temp03_ScrollDir
    beq @else_sameHiX
    ; room is horizontal
    ; branch if high bytes of x pos are equal
    lda Temp0B_XSlotPositionHi
    eor Temp0A_YSlotPositionHi
    beq @else_sameHiX
        ; high bytes are not equal
        ; this must be reflected in the difference
        jsr @positionHi_notEqual
        jmp @endIf_sameHiX
    @else_sameHiX:
        ; high bytes are equal
        sbc #$00
        jsr @positionHi_equal
    @endIf_sameHiX:
    ; return set carry if x distance is greater or equal to $100
    sec
    lda Temp01_DiffHi
    bne @RTS

    lda Temp00_Diff
    sta Temp0F_DistX
    ; return carry set if y distance is greater than both y radius combined
    ; if not, return carry clear: both entities are overlapping
    cmp Temp05_YSlotRadX
@RTS:
    rts

@positionHi_notEqual:
    ; subtract y slot entity's hi position from x slot entity's hi position
    lda Temp0B_XSlotPositionHi
    sbc Temp0A_YSlotPositionHi
@positionHi_equal:
    sta Temp01_DiffHi
    ; return if difference is not negative
    bpl RTS_X286
    ; difference is negative
    ; negate it to get the absolute distance
    jsr NegateTemp00Temp01
    ; set dist hi bit
    inc Temp10_DistHi
RTS_X286:
    rts

LF270:
    ora SamusIsHit,x
    sta SamusIsHit,x
    rts

CollisionDetectionDoor_F277:
    ; exit if collision didn't happen
    bcs Exit17

SetProjectileIsHit:
    lda Temp10_DistHi
SetSamusIsHitFlags:
    ora SamusIsHit,y
    sta SamusIsHit,y
Exit17:
    rts

CollisionDetectionEnemy_ReactToCollisionWithSamus:
    ; exit if collision didn't happen
    bcs Exit17

    jsr SetEnemyTouchingSamusFlags
    ;branch if screw attack is active.
    jsr IsScrewAttackActive
    ldy #$00
    bcc Lx289

    ; screw attack is not active
    ; exit if enemy is frozen, pickup or hurt
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Frozen
    bcs Exit17

    ; enemy is not frozen
    ; set SamusHurt010F to enemy type
    lda EnsExtra.0.type,x
Lx287:
    sta SamusHurt010F

    ; branch if enemy type bit 7 is set (when does this happen?)
    tay
    bmi Lx288
        ; enemy type bit 7 is not set
        ; exit if bit 4 of L968B is set
        lda L968B,y
        and #$10
        bne Exit17
    Lx288:

    ldy #$00
    jsr SetSamusIsHitByEnemy
    jmp LF306
Lx289:
    lda #wa_ScrewAttack
    sta EnWeaponAction,x
    bne Lx291 ; branch always

CollisionDetectionMellow_ReactToCollisionWithSamus:
    ; exit if collision didn't happen
    bcs RTS_X290
    ; branch if screw attack is not active (samus got hit)
    jsr IsScrewAttackActive
    ldy #$00
    lda #$C0
    bcs Lx287
    ; screw attack was active
CollisionDetectionMellow_Hit:
    ; set mellow is hit flag
    lda Mellows.0.isHit,x
    and #$F8
    ora Temp10_DistHi
    eor #$03
    sta Mellows.0.isHit,x
RTS_X290:
    rts

CollisionDetectionEnemy_ReactToCollisionWithProjectile:
    ; exit if collision didn't happen
    bcs Lx293

    ; save weapon action to enemy
    lda ObjAction,y
    sta EnWeaponAction,x
    ; set projectile is hit flag
    jsr SetProjectileIsHit
Lx291:
    ; set enemy is hit flag
    jsr GetEnemyIsHitFlags
Lx292:
    ora EnIsHit,x
    sta EnIsHit,x
Lx293:
    rts

CollisionDetectionEnProjectile_ReactToCollisionWithSamus_F2DF:
    lda Temp10_DistHi
    ora EnIsHit,y
    sta EnIsHit,y
    rts

SetEnemyTouchingSamusFlags:
    jsr LF340
    bne Lx292 ; branch always
CollisionDetectionEnProjectile_ReactToCollisionWithSamus:
    ; exit if collision didn't happen
    bcs RTS_X294

    jsr CollisionDetectionEnProjectile_ReactToCollisionWithSamus_F2DF
    tya
    pha
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    pla
    tay
    bcc RTS_X294
    lda #$80
    sta SamusHurt010F
    jsr GetEnemyIsHitFlags
    jsr LF270
LF306:
    ; apply enemy base damage
    lda AreaEnemyDamage
    sta HealthChange
    lda AreaEnemyDamage+1
    sta HealthChange+1.b
RTS_X294:
    rts

SamusHurt_F311:
    ; exit if collision didn't happen
    bcs Exit22
    ; set SamusHurt010F to #$E0
    lda #$E0
    sta SamusHurt010F
    ; set SamusIsHit depending on the direction samus was hit
    jsr SetSamusIsHitByEnemy
    ; set SamusKnockbackIsBomb to #$01 (vertical knockback) if samus and what hit her have the same x position
    ; else, set SamusKnockbackIsBomb to #$00 (diagonal knockback)
    lda Temp0F_DistX
    beq Lx295
        lda #$01
    Lx295:
    sta SamusKnockbackIsBomb
    ; fallthrough

ClearHealthChange:
    lda #$00
    sta HealthChange
    sta HealthChange+1.b

Exit22:
    rts                             ;Return for routine above and below.

CollisionDetectionMellow_ReactToCollisionWithProjectile:
    bcs Exit22
    jsr SetProjectileIsHit
    jmp CollisionDetectionMellow_Hit

GetEnemyIsHitFlags:
    jsr LF340
    jmp Amul8       ; * 8

SetSamusIsHitByEnemy:
    lda Temp10_DistHi
    asl
    asl
    asl
    jmp SetSamusIsHitFlags

LF340:
    lda Temp10_DistHi
    eor #$03
    rts

;-------------------------------------------------------------------------------
UpdateAllEnemies: ; LF345
    ldx #$50                ;Load x with #$50
    @loop:
        jsr UpdateEnemy                  ;($F351)
        ldx PageIndex
        jsr Xminus16
        bne @loop
    ; After loop, UpdateEnemy for the case X=$00

;-------------------------------------------------------------------------------
UpdateEnemy: ;LF351
    stx PageIndex                   ;PageIndex starts at $50 and is subtracted by #$0F each-->
                                    ;iteration. There is a max of 6 enemies at a time.
    ldy EnsExtra.0.status,x
    beq @endIf
        cpy #enemyStatus_Active+1.b
        bcs @endIf
            ; enemy status is enemyStatus_Resting or enemyStatus_Active here
            jsr UpdateEnemy_CheckIfVisible
    @endIf:
    jsr UpdateEnemy_UpdateEnData05Bit6
    lda EnsExtra.0.status,x
    sta EnemyStatusPreAI
    cmp #enemyStatus_Hurt+1.b
    bcs @invalidStatus
    jsr ChooseRoutine
        .word ExitSub ; 00 ($C45C) rts
        .word UpdateEnemy_Resting ; 01 Resting (Offscreen or Inactive)
        .word UpdateEnemy_Active ; 02 Active
        .word UpdateEnemy_Explode ; 03 Exploding ?
        .word UpdateEnemy_Frozen ; 04 Frozen
        .word UpdateEnemy_Pickup ; 05 Pickup
        .word UpdateEnemy_Hurt ; 06 Hurt

@invalidStatus:
    jmp RemoveEnemy                  ;($FA18)Free enemy data slot.

;-------------------------------------------------------------------------------
UpdateEnemy_CheckIfVisible:
    lda EnData05,x
    and #$02
    bne @exit
        ; Store Enemy Position/Hitbox to Temp
        lda EnY,x     ; Y coord
        sta Temp0A_PositionY
        lda EnX,x     ; X coord
        sta Temp0B_PositionX
        lda EnsExtra.0.hi,x     ; hi coord
        sta Temp06_PositionHi
        lda EnsExtra.0.radY,x
        sta Temp08_RadiusY
        lda EnsExtra.0.radX,x
        sta Temp09_RadiusX
        ;Determine if object is within the screen boundaries.
        jsr IsObjectVisible
        txa
        bne @exit
            ; enemy is not visible
            ; double return, returns from UpdateEnemy entirely
            pla
            pla
    @exit:
    ldx PageIndex
    rts

; toggle bit 6 of EnData05
UpdateEnemy_UpdateEnData05Bit6:
    ; shift bit 6 of EnData05 into carry
    lda EnData05,x ;76543210
    asl ;6543210-
    rol ;543210-7
    tay
    ; put (slot id xor FrameCount)'s bit 0 into carry
    txa
    jsr Adiv16                      ;($C2BF)/16.
    eor FrameCount
    lsr
    ; shift carry into bit 6 of EnData05
    tya ;543210-7
    ror ;X543210-
    ror ;7X543210
    sta EnData05,x
    rts

;---------------------------------------------
UpdateEnemy_Resting: ;($F3BE)
    ; Branch if bit 6 is set (30FPS)
    lda EnData05,x
    asl
    bmi Lx299
        lda #$00
        sta EnsExtra.0.jumpDsplcmnt,x
        sta EnMovementInstrIndex,x
        sta EnData0A,x
        jsr UpdateEnemy_ForceSpeedTowardsSamus
        jsr UpdateEnemy_EnData05DistanceToSamusThreshold
        jsr InitEnRestingAnimIndex
        jsr UpdateEnemy_Resting_UpdateEnData1F

        ; branch if delay is zero
        lda EnDelay,x
        beq Lx299
            jsr UpdateEnemy_Resting_TryBecomingActive
    Lx299:
    jmp UpdateEnemy_Active_BranchB
;------------------------------------------
UpdateEnemy_Active: ; LF3E6
    ; Branch if bit 6 is set (30FPS)
    lda EnData05,x
    asl
    bmi UpdateEnemy_Active_BranchB

    ; Branch if bit 5 is clear
    lda EnData05,x
    and #$20
    beq UpdateEnemy_Active_BranchA

    ; Set enemy delay
    ldy EnsExtra.0.type,x
    lda EnemyInitDelayTbl,y ;($96BB)
    sta EnDelay,x
    ; Decrement status from active to resting
    dec EnsExtra.0.status,x
    bne UpdateEnemy_Active_BranchB ; Branch always

UpdateEnemy_Active_BranchA: ; LF401
    jsr UpdateEnemy_ForceSpeedTowardsSamus
    jsr UpdateEnemy_EnData05DistanceToSamusThreshold
    jsr RemoveEnemyIfItIsInLava
UpdateEnemy_Active_BranchB: ; LF40A
    jsr EnemyReactToSamusWeapon
UpdateEnemy_Explode:
    jmp ChooseEnemyAIRoutine
;-------------------------------------------
; This procedure is called by a lot of enemy AI routines, with three different
;  entry points
; Entry Point 1 ; CommonJump_00
LF410:
    jsr UpdateEnemyAnim
    jsr CommonEnemyAI
; Entry Point 2 ; CommonJump_02
LF416:
    ; check if enemy is tough
    ldx PageIndex
    lda EnSpecialAttribs,x
    bpl Lx301

    lda ObjectCntrl
    bmi Lx301
    lda #$83 | OAMDATA_PRIORITY.b
LF423:
    sta ObjectCntrl
Lx301:
    lda EnsExtra.0.status,x
    beq LF42D
        jsr DrawEnemy
    LF42D:
    ldx PageIndex
    lda #$00
    sta EnIsHit,x
    sta EnWeaponAction,x
    rts

; Entry Point 3 ; CommonJump_01
LF438:
    jsr UpdateEnemyAnim
    jmp LF416
;-------------------------------------------
UpdateEnemy_Frozen: ; ($F43E)
    jsr EnemyReactToSamusWeapon
    lda EnsExtra.0.status,x
    cmp #$03
    beq LF410
    bit ObjectCntrl
    bmi Lx302
        lda #$81 | OAMDATA_PRIORITY.b
        sta ObjectCntrl
    Lx302:
    lda FrameCount
    and #$07
    bne Lx303
        dec EnData0D,x
        bne Lx303
            lda EnsExtra.0.status,x
            cmp #enemyStatus_Explode
            beq Lx303
                lda EnPrevStatus,x
                sta EnsExtra.0.status,x
                ldy EnsExtra.0.type,x
                lda EnemyForceSpeedTowardsSamusDelayTbl,y
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
UpdateEnemy_Pickup: ;($F483)
    ; branch if samus is not touching the pickup
    lda EnIsHit,x
    and #$24
    beq @pickupWasNotTouched

    ; delete pickup
    jsr RemoveEnemy                  ;($FA18)Free enemy data slot.

    ; if anim frame is #$80, it is a missile pickup
    ldy EnsExtra.0.animFrame,x
    cpy #_id_EnFrame_MissilePickup.b
    beq @pickupMissile

    ; health pickup
    tya
    pha
    lda EnsExtra.0.type,x
    pha
    ;Increase Health by 30.
    ldy #$00
    ldx #$03
    pla
    ; branch if EnsExtra.0.type is non-zero (health pickup from a metroid)
    bne @endIf_A
        ; default to big health pickup
        ;Increase Health by 20.
        dex
        pla
        ; branch if not small health pickup
        cmp #_id_EnFrame_SmallEnergyPickup.b
        bne @endIf_B
            ; small health pickup
            ;Increase Health by 5.
            ldx #$00
            ldy #$50
        @endIf_B:
        pha
    @endIf_A:
    pla
    sty HealthChange
    stx HealthChange+1.b
    jsr AddHealth                   ;($CEF9)Add health to Samus.
    jmp SFX_EnergyPickup

@pickupMissile:
    ; add 2 missiles
    lda #$02
    ; branch if EnsExtra.0.type is zero (regular missile pickup)
    ldy EnsExtra.0.type,x
    beq @endIf_C
        ; missile pickup from a metroid
        ; add 30 missiles
        lda #$1E
    @endIf_C:
    clc
    adc MissileCount
    bcs @capMissiles              ; can't have more than 255 missiles
    cmp MaxMissiles  ; can Samus hold this many missiles?
    bcc @dontCapMissiles            ; branch if yes
@capMissiles:
    lda MaxMissiles  ; set to max. # of missiles allowed
@dontCapMissiles:
    sta MissileCount
    jmp SFX_MissilePickup

@pickupWasNotTouched:
    ; decrement pickup die delay every 4 frames
    lda FrameCount
    and #$03
    bne @endIf_D
        dec EnData0D,x
        ; if die delay is 0, remove pickup
        bne @endIf_D
            jsr RemoveEnemy                  ;($FA18)Free enemy data slot.
    @endIf_D:
    ; flicker the color of the pickup
    lda FrameCount
    and #$02
    lsr
    ora #$80 | OAMDATA_PRIORITY.b
    sta ObjectCntrl
    jmp LF416
;--------------------------------------------
UpdateEnemy_Hurt:
    dec EnSpecialAttribs,x
    bne Lx313
    ; Preserve upper two bits of EnSpecialAttribs
    lda EnPrevStatus,x
    tay
    and #$C0
    sta EnSpecialAttribs,x
    tya

    and #$3F
    sta EnsExtra.0.status,x
    pha
    jsr LoadTableAt977B
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
    sta EnPrevStatus,x
LF518:
    lda #enemyStatus_Frozen
    sta EnsExtra.0.status,x
    rts

;-------------------------------------------------------------------------------
RemoveEnemyIfItIsInLava:
    ; exit if room scrolls vertically
    lda ScrollDir
    ldx PageIndex
    cmp #$02
    bcc RTS_X315
    ; room scrolls horizontally
    ; exit if enemy is above lava
    lda EnY,x     ; Y coord
    cmp #$EC
    bcc RTS_X315
    ; enemy is in lava
    jmp RemoveEnemy                  ;($FA18)Free enemy data slot.

;-------------------------------------------------------------------------------
Lx314:
    ; Samus attacked a non-frozen metroid with something else than the ice beam
    ; just play a sfx and ignore the attack
    jsr SFX_MetroidHit
    jmp GetPageIndex

; handles enemy getting attacked by Samus
EnemyReactToSamusWeapon:
    lda EnSpecialAttribs,x
    sta $0A
    ; exit if enemy was not attacked?
    lda EnIsHit,x
    and #$20
    beq RTS_X315

    ; branch if enemy was not attacked by ice beam
    lda EnWeaponAction,x
    cmp #wa_IceBeam
    bne Lx317
    ; branch if enemy is a miniboss (miniboss cannot be frozen)
    bit $0A
    bvs Lx317
    ; branch if enemy is already in the frozen state
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Frozen
    beq Lx317

    ; freeze enemy
    ; set state to frozen
    jsr LF515
    ; set freeze timer to 512 frames
    lda #$40
    sta EnData0D,x
    ; exit if enemy is not a metroid
    jsr LoadTableAt977B
    and #$20
    beq RTS_X315
    ; set hp to 5, and clear metroid latch
    lda #$05
    sta EnHealth,x
    jmp GotoClearCurrentMetroidLatchAndMetroidOnSamus
RTS_X315:
    rts

Lx316:
    ; Samus's attack was ineffective against the enemy
    ; branch if enemy is a metroid
    jsr LoadTableAt977B
    and #$20
    bne Lx314
    ; play sfx and clear variables defining Samus's attack on this enemy
    jsr SFX_Metal
    jmp LF42D
Lx317:
    ; branch if enemy is completely invulnerable to Samus's attacks
    lda EnHealth,x
    cmp #$FF
    beq Lx316

    ; play enemy hurt sound effect
    ; check if enemy is a miniboss
    bit $0A
    bvc Lx318
        ; enemy is a miniboss, so play miniboss hurt sound effect
        jsr SFX_BossHit
        bne Lx319 ; branch always
    Lx318:
    ; play different enemy hurt sound effects depending on which enemy it is
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
    ; fallthrough

Lx319:
    ; check if enemy is a metroid
    ldx PageIndex
    jsr LoadTableAt977B
    and #$20
    beq Lx320
        ; enemy is a metroid
        ; since it is not completely invulnerable to Samus's attacks, we assume that the metroid is currently frozen
        ; ignore all of Samus's attacks except for missiles
        lda EnWeaponAction,x
        cmp #wa_Missile
        bne Lx316
    Lx320:

    ; update EnPrevStatus
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Frozen
    bne Lx321
        lda EnPrevStatus,x
    Lx321:
    ora $0A
    sta EnPrevStatus,x

    ; branch if enemy is a miniboss
    asl
    bmi Lx322
    ; branch if enemy is a metroid
    jsr LoadTableAt977B
    and #$20
    bne Lx322
        ; enemy is not a miniboss and is not a metroid
        ; check attack type
        ldy EnWeaponAction,x
        ; instantly kill enemy if it was attacked by Samus's missile
        cpy #wa_Missile
        beq ExplodeEnemy
        ; instantly kill enemy if it was attacked by Samus's screw attack
        cpy #wa_ScrewAttack
        beq ExplodeEnemy
    Lx322:

    ; set enemy state to hurt
    lda #enemyStatus_Hurt
    sta EnsExtra.0.status,x

    ; set EnSpecialAttribs to
    ; #$0A if enemy is not a miniboss
    ; #$03 if enemy is a miniboss
    lda #$0A
    bit $0A
    bvc Lx323
        lda #$03
    Lx323:
    sta EnSpecialAttribs,x

    ; check attack type
    ; if enemy is attacked by wave beam, decrement health by 2
    cpy #wa_WaveBeam
    beq Lx324
        ; if enemy is not a miniboss, decrement health by 1
        bit $0A
        bvc Lx325
        ; enemy is a miniboss
        ; if miniboss was not attacked by a missile, decrement health by 1
        ldy EnWeaponAction,x
        cpy #wa_Missile
        bne Lx325
        ; miniboss was attacked by a missile, decrement health by 4
        dec EnHealth,x
        beq ExplodeEnemy
        dec EnHealth,x
        beq ExplodeEnemy
    Lx324:
    dec EnHealth,x
    beq ExplodeEnemy
Lx325:
    dec EnHealth,x
    bne GetPageIndex
ExplodeEnemy:
    ; the enemy has been killed by Samus's attacks
    ; set status to explode
    lda #enemyStatus_Explode
    sta EnsExtra.0.status,x

    ; branch if enemy is a miniboss
    bit $0A
    bvs Lx327
    ; branch if enemy was not hit by the regular beam
    lda EnWeaponAction,x
    cmp #wa_RegularBeam+1.b
    bcs Lx327
    ; call LDCFC routine
    lda #$00 ; useless instruction
    jsr LDCFC
    ldx PageIndex
Lx327:
    jsr GetEnemyTypeTimes2PlusFacingDirection
    lda EnemyDeathAnimIndex,y
    jsr InitEnAnimIndex
    sta EnSpeedSubPixelY,x
    ; find first open enemy explosion slot
    ldx #$C0
    Lx328:
        lda EnsExtra.0.status,x
        beq Lx329
        txa
        clc
        adc #$08
        tax
        cmp #$E0
        bne Lx328
    ; could not spawn enemy explosion, because all enemy explosion slots are occupied
    beq GetPageIndex
Lx329:
    ; open enemy explosion slot found
    ; initialize explosion based on current enemy's coordinates
    lda AreaExplosionAnimIndex
    jsr InitEnAnimIndex
    lda #$0A
    sta EnExplosionAnimDelay,x
    inc EnsExtra.0.status,x
    lda #$00
    bit $0A
    bvc Lx330
        lda #$03
    Lx330:
    sta EnExplosionAnimFrame,x
    ldy PageIndex
    lda EnY,y
    sta EnExplosionY,x
    lda EnX,y
    sta EnExplosionX,x
    lda EnsExtra.0.hi,y
    sta EnsExtra.0.hi,x
GetPageIndex:
    ldx PageIndex
    rts

UpdateEnemy_Resting_UpdateEnData1F:
    ; load L977B entry * 2
    jsr LoadTableAt977B
    ; move bits 2-3 of L977B entry to bits 6-7
    asl
    asl
    asl
    ; isolate them and save to EnData1F
    and #$C0
    sta EnsExtra.0.data1F,x
    rts

InitEnRestingAnimIndex:
    jsr GetEnemyTypeTimes2PlusFacingDirection
    lda EnemyRestingAnimIndex,y
    cmp EnsExtra.0.resetAnimIndex,x
    beq RTS_X331
InitEnAnimIndex:
    sta EnsExtra.0.resetAnimIndex,x
SetEnAnimIndex:
    sta EnsExtra.0.animIndex,x
ClearEnAnimDelay:
    lda #$00
    sta EnsExtra.0.animDelay,x
RTS_X331:
    rts

InitEnActiveAnimIndex:
    ; exit if enemy anim is already the same as from EnemyActiveAnimIndex
    jsr GetEnemyTypeTimes2PlusFacingDirection
    lda EnemyActiveAnimIndex,y
    cmp EnsExtra.0.resetAnimIndex,x
    beq Exit12
    ; set anim to the one from the table
    jsr InitEnAnimIndex
    ; exit if L967B entry and #$7F is zero
    ldy EnsExtra.0.type,x
    lda L967B,y
    and #$7F
    beq Exit12
    ; decrease EnsExtra.0.animIndex by that non-zero amount
    tay
    Lx332:
        dec EnsExtra.0.animIndex,x
        dey
        bne Lx332
Exit12:
    rts

;-------------------------------------------------------------------------------
UpdateEnemy_ForceSpeedTowardsSamus:
    ; clear $82
    lda #$00
    sta Enemy82

    jsr ReadTableAt968B
    tay

    ; branch if enemy is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne Lx333
        ; enemy is active
        ; if bit 1 of L968B[EnsExtra.0.type] is not set, exit
        tya
        and #$02
        beq Exit12
    Lx333:
    ; enemy is not active or bit 1 of L968B[EnsExtra.0.type] is set
    tya
    dec EnData0D,x
    bne Exit12

    ; write EnData0D from table
    pha
    ldy EnsExtra.0.type,x
    lda EnemyForceSpeedTowardsSamusDelayTbl,y
    sta EnData0D,x
    pla
    ; branch if bit 7 of L968B[EnsExtra.0.type] is not set
    bpl Lx337

    ; x axis

    ; clear bit 0 of EnData05 (x axis flip)
    lda #~$01
    jsr AndEnData05

    ; branch if room is vertical
    lda ScrollDir
    cmp #$02
    bcc Lx334

    ; room is horizontal
    ; branch if samus is in the same nametable as the enemy
    jsr LoadEnHiToYAndLoadEorHiToCarry
    bcc Lx334

    ; samus is in the other nametable
    ; load (EnsExtra.0.hi != PPUCTRL_ZP) into a
    tya
    eor PPUCTRL_ZP
    bcs Lx336 ; branch always

    Lx334:
        ; samus is in the same nametable as the enemy on the x axis
        ; compare enemy pos to samus pos
        lda EnX,x
        cmp ObjX
        bne Lx335
            ; samus x position is the same as enemy x position
            ; set bit 0 of Enemy82
            inc Enemy82
        Lx335:
        ; carry contains whether or not the enemy is to the right of samus
        ; rotate carry into bit 0
        rol
    Lx336:
    ; set bit 0 as bit 0 of EnData05
    and #$01
    jsr OrEnData05
    ; move bit 0 to bit 7
    lsr
    ror
    ; branch if it matches sign bit of x speed (enemy moves towards samus)
    eor EnSpeedX,x
    bpl Lx337
    ; it doesnt match
    ; force x speed to point the right direction
    jsr L81DA
Lx337:

    ; y axis

    ; clear bit 2 of EnData05 (y axis flip)
    lda #~$04
    jsr AndEnData05

    ; branch if room is horizontal
    lda ScrollDir
    cmp #$02
    bcs Lx338

    ; room is vertical
    ; branch if samus is in the same nametable as the enemy
    jsr LoadEnHiToYAndLoadEorHiToCarry
    bcc Lx338

    ; samus is in the other nametable
    ; load (EnsExtra.0.hi != PPUCTRL_ZP) into a
    tya
    eor PPUCTRL_ZP
    bcs Lx340 ; branch always

    Lx338:
        ; samus is in the same nametable as the enemy on the y axis
        ; compare enemy pos to samus pos
        lda EnY,x
        cmp ObjY
        bne Lx339
            ; samus y position is the same as enemy y position
            ; set bit 1 of Enemy82
            inc Enemy82
            inc Enemy82
        Lx339:
        ; carry contains whether or not the enemy is under samus
        ; rotate carry into bit 0
        rol
    Lx340:
    ; set bit 0 as bit 2 of EnData05
    and #$01
    asl
    asl
    jsr OrEnData05
    ; move bit 2 to bit 7
    lsr
    lsr
    lsr
    ror
    ; branch if it matches sign bit of y speed (enemy moves towards samus)
    eor EnSpeedY,x
    bpl RTS_X341
    ; force y speed to point the right direction
    jmp L820F

;-------------------------------------------------------------------------------
OrEnData05:
    ora EnData05,x
    sta EnData05,x
RTS_X341:
    rts

;-------------------------------------------------------------------------------
ReadTableAt968B: ; LF74B
    ldy EnsExtra.0.type,x
    lda L968B,y
    rts

;-------------------------------------------------------------------------------

LoadEnHiToYAndLoadEorHiToCarry:
    lda EnsExtra.0.hi,x
    tay
    eor ObjHi
    lsr
    rts

;-------------------------------------------------------------------------------
UpdateEnemy_EnData05DistanceToSamusThreshold:
    ; default to masking out bit 4 and bit 3 of EnData05
    lda #~$18
    sta $06
    ; set bit 4 and bit 3 of EnData05
    lda #$18
    jsr OrEnData05
    ; exit if EnemyDistanceToSamusThreshold is zero
    ldy EnsExtra.0.type,x
    lda EnemyDistanceToSamusThreshold,y
    beq RTS_X346

    ; push to y
    tay
    ; unset bit 4 and bit 3 of EnData05 and exit if enemy is invisible
    lda EnData05,x
    and #$02
    beq Lx345

    ; pop from y
    tya
    ; mask out bit 3 from EnData05
    ldy #~$08
    ; branch if bit 7 of EnemyDistanceToSamusThreshold is set
    asl
    bcs Lx342
        ; bit 7 of EnemyDistanceToSamusThreshold is not set
        ; mask out bit 4 from EnData05
        ldy #~$10
    Lx342:
    ; save EnemyDistanceToSamusThreshold & #$7F to $02
    lsr
    sta $02
    ; save mask to $06
    sty $06

    ; check y axis
    lda ObjY
    sta $00
    ldy EnY,x
    ; branch if bit 7 of EnData05 is set
    lda EnData05,x
    bmi Lx343
        ; bit 7 of EnData05 is not set
        ; check x axis
        ldy ObjX
        sty $00
        ldy EnX,x
    Lx343:

    ; rotate samus hi bit into bit 7 of her position
    lda ObjHi
    lsr
    ror $00
    ; rotate enemy hi bit into bit 7 of its position
    lda EnsExtra.0.hi,x
    lsr
    tya
    ror
    ; get enemy pos relative to samus pos
    sec
    sbc $00
    ; branch if enemy is to the right of samus
    bpl Lx344
        ; enemy is to the left of samus
        ; negate pos
        jsr TwosComplement              ;($C3D4)
    Lx344:
    ; now a contains absolute distance between enemy and samus on a specific axis, divided by 2

    ; divide further by 8
    lsr
    lsr
    lsr
    ; now it's divided by 16
    ; compare with EnemyDistanceToSamusThreshold & #$7F
    cmp $02
    ; exit if the distance is smaller than the threshold
    bcc RTS_X346
    ; the distance is greater than the threshold
    ; we must unset the proper bit of EnData05
Lx345:
    ; apply mask to EnData05
    lda $06
AndEnData05:
    and EnData05,x
    sta EnData05,x
RTS_X346:
    rts

UpdateEnemy_Resting_TryBecomingActive:
    ; decrement delay until next action
    dec EnDelay,x
    ; exit if delay is not zero
    bne @RTS
    ; delay is zero
    ; branch if bit 3 of EnData05 is set
    lda EnData05,x
    and #$08
    bne @becomeActive
    ; bit 3 of EnData05 is not set
    ; undo decrement delay and exit
    inc EnDelay,x
@RTS:
    rts
@becomeActive:
    ; bit 3 of EnData05 is set
    ; branch if enemy is not a pipe bug
    lda EnsExtra.0.type,x
    cmp #$07
    bne Lx349
        ; enemy is a pipe bug, play pipe bug sfx
        jsr SFX_OutOfHole
        ldx PageIndex
    Lx349:
    ; increment enemy status to active
    inc EnsExtra.0.status,x
    ; initialize animation for active enemy
    jsr InitEnActiveAnimIndex
    ; load enemy's EnemyMovementChoices offset
    ldy EnsExtra.0.type,x
    lda EnemyMovementChoiceOffset,y
    ; make pointer to enemy's EnemyMovementChoice in $00-$01
    clc
    adc #<EnemyMovementChoices.b
    sta $00
    lda #$00
    adc #>EnemyMovementChoices.b
    sta $01
    ; create randomly generated offset
    lda FrameCount
    eor RandomNumber1
    ; and this with enemy's EnemyMovementChoice possibility bitflag
    ; for example, if there are 4 possible EnemyMovement indexes in the -->
    ; EnemyMovementChoice, the bitflag will be #$03, because 2 bits is 4 possibilities.
    ldy #$00
    and ($00),y
    ; add one to point to the first EnemyMovement index and save in y
    tay
    iny
    ; get movement index at that randomly generated offset
    lda ($00),y
    ; save movement index
    sta EnMovementIndex,x

    ; branch if the enemy doesn't use acceleration and speed and subpixels
    jsr LoadTableAt977B
    bpl Lx351
        ; the enemy uses acceleration and speed and subpixels
        ; initialize those to what they should be
        lda #$00
        sta EnSpeedSubPixelY,x
        sta EnSpeedSubPixelX,x
        ldy EnMovementIndex,x

        lda EnAccelYTable,y
        sta EnsExtra.0.accelY,x
        lda EnAccelXTable,y
        sta EnsExtra.0.accelX,x

        lda EnSpeedYTable,y
        sta EnSpeedY,x
        lda EnSpeedXTable,y
        sta EnSpeedX,x

        lda EnData05,x
        bmi Lx350
            ; bit 7 of EnData05 is not set
            ; use bit 0 of EnData05 as facing direction
            lsr
            ; branch if facing right
            bcc Lx351
            ; enemy is facing left, call L81D1
            jsr L81D1
            jmp Lx351
        Lx350:
            ; bit 7 of EnData05 is set
            ; use bit 2 of EnData05 as facing direction instead of bit 0
            and #$04
            ; branch if facing up
            beq Lx351
            ; enemy is facing down, call L8206
            jsr L8206
    Lx351:
    ; clear bit 5 of EnData05
    lda #~$20
    jmp AndEnData05

GetEnemyTypeTimes2PlusFacingDirectionBit0:
    lda EnData05,x
    jmp Lx352

GetEnemyTypeTimes2PlusFacingDirection:
    lda EnData05,x
    bpl Lx352
        lsr
        lsr
Lx352:
    lsr
    lda EnsExtra.0.type,x
    rol
    tay
    rts

CrawlerAIRoutine_ShouldCrawlerMove:
    ; load enemy slot into a
    txa
    ; divide by 8
    lsr
    lsr
    lsr
    ; add frame count
    adc FrameCount
    ; divide by two
    lsr
    ; this returns
    ; enemy slot  %----7654
    ; frame count %07654321
    ; whenever this is called, only the bits 0-1 are used
    ; if bits 0-1 are zero, the crawler does not move
    rts

InitEnemyForceSpeedTowardsSamusDelayAndHealth:
    ldy EnsExtra.0.type,x

    ; initialoze EnData0D
    lda EnemyForceSpeedTowardsSamusDelayTbl,y
    sta EnData0D,x

    ; initialize enemy's health
    lda EnemyHealthTbl,y          ;($962B)
    ldy EnSpecialAttribs,x
    ; Check MSB of enemyAttr, double health if set
    ; (this is the reason powerful variants of rippers have 254 health,
    ;  instead of being invincible (255 health) like their weaker variant)
    bpl Lx353
        asl
    Lx353:
    sta EnHealth,x
RTS_X354:
    rts


SpawnEnProjectile:
    ; exit if bit 4 of EnData05 is set (what does this bit represent?)
    lda EnData05,x
    and #$10
    beq RTS_X354
    ; exit if status doesn't match expected status (never exit)
    ; (draygon sets this to #$02 and polyp sets this to #$02|$01)
    lda SpawnEnProjectile_ExpectedStatus
    and EnsExtra.0.status,x
    beq RTS_X354

    ; branch if bit 7 of SpawnEnProjectile_ExpectedStatus is unset (always)
    lda SpawnEnProjectile_ExpectedStatus
    bpl Lx355
        ; exit if EnsExtra.0.jumpDsplcmnt is zero
        ldy EnsExtra.0.jumpDsplcmnt,x
        bne RTS_X354
    Lx355:

    ; attempt to find open enemy projectile slot
    jsr SpawnEnProjectile_FindSlot
    ; exit if all slots are occupied
    bcs RTS_SpawnEnProjectile_FindSlot

    ; a is #$00 here
    sta EnIsHit,y
    jsr SpawnEnProjectile_F92C
    ; rotate horizontal facing dir flag into carry
    lda EnData05,x
    lsr
    ; push SpawnEnProjectile_AnimTableIndex to stack for later
    lda SpawnEnProjectile_AnimTableIndex
    pha
    ; SpawnEnProjectile_AnimTableIndex*2 + horizontal facing dir
    rol
    ; get anim index from table
    tax
    lda EnProjectileRisingAnimIndexTable,x
    pha
    ; init anim index for projectile
    tya
    tax
    pla
    jsr InitEnAnimIndex

    ; set projectile status to resting
    ldx PageIndex
    lda #enemyStatus_Resting ;#$01
    sta EnsExtra.0.status,y
    ; use horizontal facing dir flag to set projectile x speed
    and EnData05,x
    tax
    lda EnSpeedX_Table15,x
    sta EnSpeedX,y
    ; y speed
    lda #$00
    sta EnSpeedY,y

    ldx PageIndex
    jsr SpawnEnProjectile_F8F8

    ; get and apply x and y offsets to enemy position to make projectile position
    ; put horizontal facing dir flag into carry
    lda EnData05,x
    lsr
    pla ; SpawnEnProjectile_AnimTableIndex
    tax
    lda EnProjectilePosOffsetY,x
    sta $04
    txa
    rol
    tax
    lda EnProjectilePosOffsetX,x
    sta $05
    jsr SpawnEnProjectile_SetEnProjectilePosition

    ; exit if bit 6 of SpawnEnProjectile_ExpectedStatus is unset (always)
    ldx PageIndex
    bit SpawnEnProjectile_ExpectedStatus
    bvc RTS_SpawnEnProjectile_FindSlot
    ; set animation for enemy that shot the projectile depending on the direction its facing
    lda EnData05,x
    and #$01
    tay
    lda SpawnEnProjectile_AnimIndex,y
    jmp SetEnAnimIndex

SpawnEnProjectile_FindSlot:
    ldy #$60
    clc
    @loop:
        lda EnsExtra.0.status,y
        beq RTS_SpawnEnProjectile_FindSlot
        jsr Yplus16
        cmp #$C0
        bne @loop
RTS_SpawnEnProjectile_FindSlot:
    rts

SpawnEnProjectile_F8F8:
    ; exit if anim table index is 0 or 1 (does this ever happen?)
    lda SpawnEnProjectile_AnimTableIndex
    cmp #$02
    bcc @RTS
    ; shift horizontal facing dir flag into carry
    ldx PageIndex ; redundant instruction
    lda EnData05,x
    lsr
    ; SpawnEnProjectile_EnData0A*2 + horizontal facing dir
    lda SpawnEnProjectile_EnData0A
    rol
    and #$07
    sta EnData0A,y
    ; set projectile status to active
    lda #enemyStatus_Active
    sta EnsExtra.0.status,y
    ; clear projectile anim delay and movement
    lda #$00
    sta EnDelay,y
    sta EnsExtra.0.animDelay,y
    sta EnMovementIndex,y
@RTS:
    rts

SpawnEnProjectile_SetEnProjectilePosition:
    ldx PageIndex
    ; loads position of enemy that shot the projectile into temp
    jsr StoreEnemyPositionToTemp
    tya
    tax
    ; apply offsets to that position
    jsr ApplySpeedToPosition
    ; save as position of projectile
    jmp LoadEnemyPositionFromTemp

; Table used by above subroutine
EnSpeedX_Table15:
    .byte $02
    .byte $FE

SpawnEnProjectile_F92C:
    lda #$02
    sta EnsExtra.0.radY,y
    sta EnsExtra.0.radX,y
    ora EnData05,y
    sta EnData05,y
    rts


UpdateAllEnProjectiles:
    ldx #$B0
    Lx359:
        jsr UpdateEnProjectile
        ldx PageIndex
        jsr Xminus16
        cmp #$60
        bne Lx359
        ; fallthrough
UpdateEnProjectile:
    stx PageIndex
    lda EnData05,x
    and #$02
    bne Lx360
        jsr RemoveEnemy                  ;($FA18)Free enemy data slot.
    Lx360:
    lda EnsExtra.0.status,x
    beq Exit19
    jsr ChooseRoutine
        .word ExitSub     ;($C45C) rts
        .word UpdateEnProjectile_Resting
        .word UpdateEnProjectile_Active       ; spit dragon's projectile
        .word ExitSub     ;($C45C) rts
        .word UpdateEnProjectile_Frozen
        .word UpdateEnProjectile_Pickup

Exit19:
    rts

UpdateEnProjectile_Resting:
    jsr EnemyBecomePickupIfHit
    jsr EnemyBGCollideOrApplySpeed
    ldx PageIndex
    bcs LF97C
    lda EnsExtra.0.status,x
    beq Exit19
    jsr EnemyBecomePickup
LF97C:
    lda #$01
AnimDrawEnemy:
    jsr UpdateEnemyAnim
    jmp DrawEnemy
Lx361:
    inc EnMovementIndex,x
LF987:
    inc EnMovementIndex,x
    lda #$00
    sta EnDelay,x
    beq Lx362

UpdateEnProjectile_Active:
    jsr EnemyBecomePickupIfHit
    lda EnData0A,x
    and #$FE
    tay
    lda EnProjectileMovementPtrTable,y
    sta $0A
    lda EnProjectileMovementPtrTable+1,y
    sta $0B
Lx362:
    ldy EnMovementIndex,x
    lda ($0A),y
    ; If #$FF, restart movement string
    cmp #$FF
    bne Lx363
        sta EnMovementIndex,x
        jmp LF987
    Lx363:
    cmp EnDelay,x ; Move onto the next instruction if EnDelay == array value
    beq Lx361

    inc EnDelay,x
    iny

    lda ($0A),y
    jsr EnemyGetDeltaY_8296 ; Get the y velocity from this byte
    ldx PageIndex
    sta EnSpeedY,x

    lda ($0A),y
    jsr EnemyGetDeltaX_832F ; Get the x velocity from this byte
    ldx PageIndex
    sta EnSpeedX,x

    ; if bit 0 of EnData0A is set, invert x speed
    tay
    lda EnData0A,x
    lsr
    php
    bcc Lx364
        tya
        jsr TwosComplement              ;($C3D4)
        sta EnSpeedX,x
    Lx364:

    ; branch if this is not the first movement instruction
    plp
    bne Lx365
    ; branch if y speed is not strictly positive
    lda EnSpeedY,x
    beq Lx365
    bmi Lx365

    ldy EnData0A,x
    lda AreaEnProjectileFallingAnimIndex,y
    sta EnsExtra.0.resetAnimIndex,x
Lx365:
    jsr EnemyBGCollideOrApplySpeed
    ldx PageIndex
    bcs Lx367
    lda EnsExtra.0.status,x
    beq Exit20
    ldy #$00
    lda EnData0A,x
    lsr
    beq Lx366
        iny
    Lx366:
    lda AreaEnProjectileSplatterAnimIndex,y
    jsr InitEnAnimIndex
    jsr LF518
    lda #$0A
    sta EnDelay,x
Lx367:
    jmp LF97C

RemoveEnemy:
    ;Store #$00 as enemy status(enemy slot is open).
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    rts

; enemy<-->background crash detection
; return carry clear if enemy collided or was removed
;        carry set if apply speed
EnemyBGCollideOrApplySpeed:
    ; branch if not in norfair
    lda InArea
    cmp #$11
    bne Lx368
        ; we are in norfair
        ; branch if enemy is active, frozen or hurt
        lda EnsExtra.0.status,x
        lsr
        bcc Lx369
    Lx368:
        ; get tile id at enemy's position
        jsr GetEnemyRoomRAMPtr
        ldy #$00
        lda (Temp04_RoomRAMPtr),y
        ; return carry clear if tile is solid
        cmp #$A0
        bcc RTS_X370
        ldx PageIndex
    Lx369:
    ; apply enemy speed
    lda EnSpeedX,x
    sta Temp05_SpeedX
    lda EnSpeedY,x
    sta Temp04_SpeedY
LFA41:
    jsr StoreEnemyPositionToTemp
    jsr ApplySpeedToPosition
    ; remove enemy if enemy left room's bounds
    bcc RemoveEnemy
    ; fallthrough

LoadEnemyPositionFromTemp:
    lda Temp08_PositionY
    sta EnY,x
    lda Temp09_PositionX
    sta EnX,x
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x
RTS_X370:
    rts

EnemyBecomePickupIfHit:
    ; exit if not hit
    lda EnIsHit,x
    beq Exit20
EnemyBecomePickup:
    lda #$00
    sta EnIsHit,x
    lda #enemyStatus_Pickup
    sta EnsExtra.0.status,x
Exit20:
    rts

UpdateEnProjectile_Frozen:
    lda EnsExtra.0.animFrame,x
    cmp #$F7
    beq Lx371
        dec EnDelay,x
        bne Lx372
    Lx371:
        jsr RemoveEnemy                  ;($FA18)Free enemy data slot.
    Lx372:
    jmp LF97C

GetEnemyRoomRAMPtr:
    ldx PageIndex
    lda EnY,x
    sta Temp02_PositionY
    lda EnX,x
    sta Temp03_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    jmp MakeRoomRAMPtr              ;($E96A)Find enemy position in room RAM.

UpdateEnProjectile_Pickup:
    jsr RemoveEnemy                  ;($FA18)Free enemy data slot.
    lda AreaEnProjectileKilledAnimIndex
    jsr InitEnAnimIndex
    jmp LF97C

;-------------------------------------------------------------------------------
UpdateAllEnemyExplosions:
    ldx #$C0
    @loop:
        stx PageIndex
        lda EnsExtra.0.status,x
        beq @endIf
            jsr UpdateEnemyExplosion
        @endIf:
        ; move on to next explosion
        lda PageIndex
        clc
        adc #$08
        tax
        cmp #$E0
        bne @loop
RTS_X375:
    rts

UpdateEnemyExplosion:
    ; decrement frame delay
    dec EnExplosionAnimDelay,x
    bne Lx377
    ; if frame delay is zero, move to next frame
    lda #$0C
    sta EnExplosionAnimDelay,x
    dec EnExplosionAnimFrame,x
    ; if frame number <= 0, remove explosion
    bmi Lx376
    bne Lx377
Lx376:
    jsr RemoveEnemy                  ;($FA18)Free enemy data slot.

Lx377:

    lda EnExplosionAnimDelay,x
    cmp #$09
    bne Lx378
        lda EnExplosionAnimFrame,x
        asl
        tay
        lda Table16,y
        sta Temp04_SpeedY
        lda Table16+1,y
        sta Temp05_SpeedX
        jsr LFA41
    Lx378:
    lda #$80
    sta ObjectCntrl
    lda #$03
    jmp AnimDrawEnemy

; Table used by above subroutine
Table16:
    .byte $00, $00
    .byte $0C, $1C
    .byte $10, $F0
    .byte $F0, $08

;-------------------------------------------------------------------------------
UpdateAllPipeBugHoles:
    ldy #_sizeof_PipeBugHoles - _sizeof_PipeBugHoles.0.b
    @loop:
        jsr UpdatePipeBugHole
        lda PageIndex
        sec
        sbc #_sizeof_PipeBugHoles.0
        tay
        bne @loop

UpdatePipeBugHole:
    sty PageIndex
    ; exit if hole doesn't exist
    ldx PipeBugHoles.0.status,y
    inx
    beq RTS_X375
    ; exit if enemy slot is occupied by a visible enemy
    ldx PipeBugHoles.0.enemySlot,y
    lda EnsExtra.0.status,x
    beq @endIf_A
        lda EnData05,x
        and #$02
        bne Exit13
    @endIf_A:
    ; enemy slot is available, spawn pipe bug
    ; a is #$00 here
    sta EnIsHit,x
    ; check if the slot status needs to be cleared first
    ; (why must clearing be done on a different frame than spawning the pipe bug?)
    lda #$FF
    cmp EnsExtra.0.type,x
    bne @clearEnemySlot
    ; exit if delay is not zero
    dec EnDelay,x
    bne Exit13
    ; set pipe bug type
    lda PipeBugHoles.0.status,y
    jsr GetEnemyType
    ; set pipe bug position
    ldy PageIndex
    lda PipeBugHoles.0.y,y
    sta EnY,x
    lda PipeBugHoles.0.x,y
    sta EnX,x
    lda PipeBugHoles.0.hi,y
    sta EnsExtra.0.hi,x
    ; set pipe bug radius
    lda #$18
    sta EnsExtra.0.radX,x
    lda #$0C
    sta EnsExtra.0.radY,x
    ; abort spawning pipe bug if samus is too close
    ldy #$00
    jsr GetObjectYSlotPosition
    jsr GetEnemyXSlotPosition
    jsr GetRadiusSumsOfEnXSlotAndObjYSlot
    jsr CheckCollisionOfXSlotAndYSlot
    bcc Exit13
    ; set status to resting
    lda #enemyStatus_Resting ; #$01
    sta EnDelay,x
    sta EnsExtra.0.status,x
    ; set enemy facing direction depending on scroll direction
    and ScrollDir
    asl ; to compensate for the ror instruction in LFB7B
    sta EnData05,x
    ; set enemy delay
    ldy EnsExtra.0.type,x
    jsr LFB7B
    ; init health and stuff
    jmp InitEnemyForceSpeedTowardsSamusDelayAndHealth

@clearEnemySlot:
    sta EnsExtra.0.type,x
    lda #$01
    sta EnDelay,x
    jmp RemoveEnemy                  ;($FA18)Free enemy data slot.

LFB7B:
    ; rotate bit 7 of L977B into bit 7 of EnData05
    jsr LoadTableAt977B
    ror EnData05,x
    ; load initial delay for enemy movement.
    lda EnemyInitDelayTbl,y
    sta EnDelay,x

Exit13:
    rts                             ;Exit from multiple routines.

;-------------------------------------------------------------------------------
; Sidehopper AI ?
; Wavers, too?
EnemyFlipAfterDisplacement:
    ; load (enemy type * 2 + horizontal facing direction) into y
    ldx PageIndex
    jsr GetEnemyTypeTimes2PlusFacingDirection

    lda EnsExtra.0.jumpDsplcmnt,x
    ; branch if EnData1F is not zero
    inc EnsExtra.0.data1F,x
    dec EnsExtra.0.data1F,x
    bne Lx382
        ; EnData1F is zero
        ; set negative flag for EnJumpDsplcmnt
        pha
        pla
    Lx382:
    ; branch if EnData1F is zero and if EnJumpDsplcmnt is positive,
    ; or if EnData1F == #$40
    bpl Lx383
        ; EnData1F is zero and EnJumpDsplcmnt is negative
        ; or EnData1F == #$80 or #$C0
        ; negate EnJumpDsplcmnt to get the absolute distance
        jsr TwosComplement              ;($C3D4)
    Lx383:
    ; branch if displacement is less than 8 pixels
    cmp #$08
    bcc Lx384
        ; exit if displacement is greater or equal to 16 pixels
        cmp #$10
        bcs Exit13
        ; displacement is between 8 and 15 pixels inclusive
        ; set y to horizontal facing direction
        tya
        and #$01
        tay
        ; exit if current enemy animation is the same as the new animation
        lda EnemyFlipAfterDisplacementAnimIndex,y
        cmp EnsExtra.0.resetAnimIndex,x
        beq Exit13
        ; current enemy anim is different, init anim index
        sta EnsExtra.0.animIndex,x
        dec EnsExtra.0.animIndex,x
InitEnResetAnimIndex: ; referenced in areas_common.asm
        sta EnsExtra.0.resetAnimIndex,x
        jmp ClearEnAnimDelay
    Lx384:
        ; displacement is less than 8 pixels
        ; exit if enemy is doing its resting animation
        lda EnemyRestingAnimIndex,y
        cmp EnsExtra.0.resetAnimIndex,x
        beq Exit13
        ; set enemy animation to resting animation
        jmp InitEnAnimIndex
;-------------------------------------------------------------------------------

LFBCA:
    ldx PageIndex
    jsr GetEnemyTypeTimes2PlusFacingDirection
    lda EnemyActiveAnimIndex,y
    cmp EnsExtra.0.resetAnimIndex,x
    beq Exit13
    sta EnsExtra.0.resetAnimIndex,x
    jmp SetEnAnimIndex

UpdateAllSkreeProjectiles:
    lda #$40
    sta PageIndex
    ldx #_sizeof_SkreeProjectiles - _sizeof_SkreeProjectiles.0.b
    @loop:
        jsr UpdateSkreeProjectile
        dex
        dex
        dex
        dex
        bne @loop
        ; fallthrough
UpdateSkreeProjectile:
    lda SkreeProjectiles.0.dieDelay,x
    beq @RTS
    dec SkreeProjectiles.0.dieDelay,x

    ; y = x/2
    txa
    lsr
    tay

    ; prepare parameters to ApplySpeedToPosition
    ; y speed
    lda SkreeProjectileSpeedTable,y
    sta Temp04_SpeedY
    ; x speed
    lda SkreeProjectileSpeedTable+1,y
    sta Temp05_SpeedX
    ; y pos
    lda SkreeProjectiles.0.y,x
    sta Temp08_PositionY
    ; x pos
    lda SkreeProjectiles.0.x,x
    sta Temp09_PositionX
    ; nametable
    lda SkreeProjectiles.0.hi,x
    sta Temp0B_PositionHi

    ; apply speed to position in parameters
    jsr ApplySpeedToPosition
    ; kill projectile if the projectile moved outside the bounds of the room
    bcc KillSkreeProjectile

    ; save the new position from parameters to skree projectile variables
    ; y pos
    lda Temp08_PositionY
    sta SkreeProjectiles.0.y,x
    sta PowerUpDrawY
    ; x pos
    lda Temp09_PositionX
    sta SkreeProjectiles.0.x,x
    sta PowerUpDrawX
    ; nametable
    lda Temp0B_PositionHi
    and #$01
    sta SkreeProjectiles.0.hi,x
    sta PowerUpDrawHi
    ; oops this write is redundant
    lda SkreeProjectiles.0.hi,x
    sta PowerUpDrawHi

    ;Save index to find object animation.
    lda #_id_ObjFrame_SkreeProjectile.b
    sta PowerUpDrawAnimFrame
    txa
    pha
    jsr ObjDrawFrame

    ; exit if samus is in i-frames
    lda SamusInvincibleDelay
    bne @endIf_A
    ; exit if samus is not touching the skree projectile
    ldy #$00
    ldx #$40
    jsr AreObjectsTouching          ;($DC7F)
    bcs @endIf_A
    ; exit if samus is doing the screw attack
    jsr IsScrewAttackActive         ;($CD9C)Check if screw attack active.
    ldy #$00
    bcc @endIf_A
        ; samus is being hit by the projectile
        clc
        jsr SamusHurt_F311
        ; deal 5 damage to Samus
        lda #$50
        sta HealthChange
        jsr SubtractHealth
    @endIf_A:
    pla
    tax
@RTS:
    rts

KillSkreeProjectile:
    lda #$00
    sta SkreeProjectiles.0.dieDelay,x
    rts

; Table used by above subroutine
SkreeProjectileSpeedTable:
    ;      Y    X
    .byte $00, $FB
    .byte $FB, $FE
    .byte $FB, $02
    .byte $00, $05

UpdateAllMellows:
    ; exit if mellow handler enemy isn't there
    lda EnsExtra.15.status
    beq @RTS

    ldx #$F0
    stx PageIndex
    ; delete mellow handler enemy if ???
    lda EnsExtra.15.resetAnimIndex
    cmp AreaMellowAnimIndex
    bne RemoveMellowHandlerEnemy

    lda #$03
    jsr UpdateEnemyAnim
    lda RandomNumber1
    sta MellowRandomNumber
    lda #_sizeof_Mellows - _sizeof_Mellows.0.b
    @loop:
        pha
        tax
        jsr UpdateMellow
        pla
        tax
        lda Mellows.0.isHit,x
        and #$F8
        sta Mellows.0.isHit,x
        txa
        sec
        sbc #_sizeof_Mellows.0
        bpl @loop
@RTS:
    rts

RemoveMellowHandlerEnemy:
    jmp RemoveEnemy                   ;($FA18)Free enemy data slot.

UpdateMellow:
    lda Mellows.0.status,x
    jsr ChooseRoutine
        .word ExitSub       ;($C45C) rts
        .word UpdateMellow_Resting
        .word UpdateMellow_Active
        .word UpdateMellow_Explode

UpdateMellow_Resting:
    jsr UpdateMellow_FD84
    jsr UpdateMellow_FD08
    jsr UpdateMellow_FD25
    jmp DrawEnemy

UpdateMellow_Active:
    jsr UpdateMellow_FD84
    jsr UpdateMellow_RunAI
    jmp DrawEnemy

UpdateMellow_Explode:
    lda #$00
    sta Mellows.0.status,x
    jmp SFX_EnemyHit

UpdateMellow_RunAI:
    jsr UpdateMellow_StorePositionToTemp
    lda Mellows.0.attackState,x
    cmp #$02
    bcs Lx392
    ldy Temp08_PositionY
    cpy ObjY
    bcc Lx392
    ora #$02
    sta Mellows.0.attackState,x
Lx392:
    ldy #$01
    lda Mellows.0.attackState,x
    lsr
    bcc Lx393
        ldy #$FF
    Lx393:
    sty Temp05_SpeedX
    ldy #$04
    lsr
    lda Mellows.0.attackTimer,x
    bcc Lx394
        ldy #$FD
    Lx394:
    sty Temp04_SpeedY
    inc Mellows.0.attackTimer,x
    jsr ApplySpeedToPosition
    bcs Lx395
        lda Mellows.0.attackState,x
        ora #$02
        sta Mellows.0.attackState,x
    Lx395:
    bcc Lx396
        jsr UpdateMellow_LoadPositionFromTemp
    Lx396:
    lda Mellows.0.attackTimer,x
    cmp #$50
    bcc RTS_X397
    lda #$01
    sta Mellows.0.status,x
RTS_X397:
    rts

UpdateMellow_FD08:
    lda #$00
    sta Mellows.0.attackTimer,x
    tay
    lda ObjX
    sec
    sbc Mellows.0.x,x
    bpl Lx398
        iny
        jsr TwosComplement              ;($C3D4)
    Lx398:
    cmp #$10
    bcs RTS_X399
    tya
    sta Mellows.0.attackState,x
    lda #$02
    sta Mellows.0.status,x
RTS_X399:
    rts

UpdateMellow_FD25:
    txa
    lsr
    lsr
    lsr
    adc MellowRandomNumber
    sta MellowRandomNumber
    lsr MellowRandomNumber
    and #$03
    tay
    lda MellowSpeedTable,y
    sta Temp04_SpeedY
    lda MellowSpeedTable+1,y
    sta Temp05_SpeedX
    jsr UpdateMellow_StorePositionToTemp
    lda Temp08_PositionY
    sec
    sbc ScrollY
    tay
    lda #$02
    cpy #$20
    bcc Lx400
    jsr TwosComplement              ;($C3D4)
    cpy #$80
    bcc Lx401
Lx400:
    sta Temp04_SpeedY
Lx401:
    jsr ApplySpeedToPosition
    jmp UpdateMellow_LoadPositionFromTemp

; Table used by above subroutine
MellowSpeedTable:
    .byte  $02
    .byte -$02
    .byte  $01
    .byte -$01
    .byte  $02

UpdateMellow_StorePositionToTemp:
    lda Mellows.0.hi,x
    sta Temp0B_PositionHi
    lda Mellows.0.y,x
    sta Temp08_PositionY
    lda Mellows.0.x,x
    sta Temp09_PositionX
    rts

UpdateMellow_LoadPositionFromTemp:
    lda Temp08_PositionY
    sta Mellows.0.y,x
    sta EnY+$F0
    lda Temp09_PositionX
    sta Mellows.0.x,x
    sta EnX+$F0
    lda Temp0B_PositionHi
    and #$01
    sta Mellows.0.hi,x
    sta EnsExtra.15.hi
    rts

UpdateMellow_FD84:
    lda Mellows.0.isHit,x
    and #$04
    beq @RTS
        lda #$03
        sta Mellows.0.status,x
    @RTS:
    rts

;-------------------------------------------------------------------------------
; $02 is tempScrollDir
; $04 is tempYvel?
; $05 is tempXvel?
; $08 is tempY
; $09 is tempX
; $0B is tempNametable

; params are $04, $05, $08, $09, $0B
; returns are $02, $08, $09, $0B, carry
; return carry set if movement was successful, and carry unset if movement failed
ApplySpeedToPosition:
    ; save vertical or horizontal scroll flag to $02
    lda ScrollDir
    and #$02
    sta Temp02_ScrollDir

    ; apply y speed to y position
    lda Temp04_SpeedY
    clc
    bmi @else_A
        ; dont apply y speed if it is zero
        beq @endIf_A
        ; positive y speed
        adc Temp08_PositionY
        bcs @then_B
            cmp #$F0
            bcc @endIf_B
        @then_B:
            ; position is greater or equal to 240px, we must wrap around
            adc #$0F ; carry is set, so this adds #$10
            ; if screen scrolls horizontally, this movement has failed bc it would go out of bounds
            ldy Temp02_ScrollDir
            bne @exit_failure
            ; screen scrolls vertically, update high byte
            inc Temp0B_PositionHi
        @endIf_B:
        ; save new y position
        sta Temp08_PositionY
        jmp @endIf_A
    @else_A:
        ; negative y speed
        adc Temp08_PositionY
        bcs @endIf_C
            ; position is lesser than 0px, we must wrap around
            sbc #$0F ; carry is set, so this subtracts #$10
            ; if screen scrolls horizontally, this movement has failed bc it would go out of bounds
            ldy Temp02_ScrollDir
            bne @exit_failure
            ; screen scrolls vertically, update high byte
            inc Temp0B_PositionHi
        @endIf_C:
        ; save new y position
        sta Temp08_PositionY
    @endIf_A:

    ; apply x speed to x position
    lda Temp05_SpeedX
    clc
    bmi @else_D
        ; dont apply x speed if it is zero
        beq @exit_success
        ; positive x speed
        adc Temp09_PositionX
        bcc @endIf_E
            ; position is greater or equal to 256px, we must wrap around
            ; if screen scrolls vertically, this movement has failed bc it would go out of bounds
            ldy Temp02_ScrollDir
            beq @exit_failure
            ; screen scrolls horizontally, update high byte
            inc Temp0B_PositionHi
        @endIf_E:
        ; save new x position
        jmp @endIf_F
    @else_D:
        adc Temp09_PositionX
        bcs @endIf_F
            ; position is lesser than 0px, we must wrap around
            ; if screen scrolls vertically, this movement has failed bc it would go out of bounds
            ldy Temp02_ScrollDir
            beq @exit_failure
            ; screen scrolls horizontally, update high byte
            inc Temp0B_PositionHi
        @endIf_F:
        ; save new x position
        sta Temp09_PositionX

@exit_success:
    ; movement was successful, set carry
    sec
    rts

@exit_failure:
    ; movement has failed, clear carry
    clc
RTS_X410:
    rts

;-------------------------------------------------------------------------------
; Adds mother brain and zebetite
UpdateTourianItems: ; $FDE3
    ; Determine if this is the first frame the end timer is running
    ; (it will have a value of 99.99 the first frame)
    lda EndTimer+1
    cmp #$99
    bne @endIf_A
    clc
    sbc EndTimer
    bne @endIf_A                   ; On the first frame of the end timer:
        ; Add [mother brain defeated] to item history
        ; a is #$00, low byte of ui_MOTHERBRAIN
        sta Temp06_ItemID
        lda #>ui_MOTHERBRAIN.b
        sta Temp06_ItemID+1.b
        jsr AddItemToHistory
    @endIf_A:

    ; Loop through zebetites (@ x = #$20, #$18, #$10, #$08, #$00)
    ldx #_sizeof_Zebetites - _sizeof_Zebetites.0.b
    @loop:
        ; ($FE05) Update one zebetite
        jsr CheckZebetite
        ; Subtract 8 from x
        txa
        sec
        sbc #_sizeof_Zebetites.0
        tax
        bne @loop

CheckZebetite: ; $FE05
    ; Exit if zebetite state != 2
    lda Zebetites.0.status,x
    sec
    sbc #$02
    bne RTS_X410

    ; a is #$00, low byte of ui_ZEBETITE1
    sta Temp06_ItemID
    ; Set zebetite state to 3
    inc Zebetites.0.status,x
    txa
    lsr                     ; A =  zebetite index * 4 (10, C, 8, 4, or 0)
    adc #>ui_ZEBETITE1.b      ;      + $3C
    sta Temp06_ItemID+1.b
    jmp AddItemToHistory               ; Add zebetite to item history

;-------------------------------------------------------------------------------
; Tile degenerate/regenerate
UpdateAllTileBlasts:
    ldx #_sizeof_TileBlasts - _sizeof_TileBlasts.0.b
    @loop:
        jsr UpdateTileBlast
        ldx PageIndex
        jsr Xminus16
        bne @loop
UpdateTileBlast:
    stx PageIndex
    lda TileBlasts.0.routine,x
    beq SetTileAnim@RTS          ; exit if tile not active
    jsr ChooseRoutine
        .word ExitSub       ;($C45C) rts
        .word UpdateTileBlast_Init
        .word UpdateTileBlast_Animating ; spawning
        .word UpdateTileBlast_WaitToRespawn
        .word UpdateTileBlast_Animating ; respawning
        .word UpdateTileBlast_Respawned

UpdateTileBlast_Init:
    inc TileBlasts.0.routine,x
    ; set anim to blasting
    lda #TileBlastAnim0 - TileBlastAnim.b
    jsr SetTileAnim
    ; tile respawns after 320 frames
    lda #$50
    sta TileBlasts.0.delay,x
    lda TileBlasts.0.roomRAMPtr,x     ; low WRAM addr of blasted tile
    sta $00
    lda TileBlasts.0.roomRAMPtr+1,x     ; high WRAM addr
    sta $01

UpdateTileBlast_Animating:
    ; anim every 2 frames
    lda #$02
    jmp UpdateTileBlastAnim

UpdateTileBlast_WaitToRespawn:
    ; only update tile timer every 4th frame
    lda FrameCount
    and #$03
    bne SetTileAnim@RTS

    ; exit if timer not reached zero
    dec TileBlasts.0.delay,x
    bne SetTileAnim@RTS

    inc TileBlasts.0.routine,x
    ldy TileBlasts.0.type,x
    lda TileBlastRespawnAnimIndexTable,y

SetTileAnim:
    sta TileBlasts.0.animIndex,x
    sta TileBlasts.0.spare05,x
    lda #$00
    sta TileBlasts.0.animDelay,x
@RTS:
    rts

; Table used for indexing the respawining animations in TileBlastAnim (see below)
; Why aren't these in area banks?
TileBlastRespawnAnimIndexTable:
    .byte TileBlastAnim6 - TileBlastAnim ; tile #$70
    .byte TileBlastAnim7 - TileBlastAnim ; tile #$74
    .byte TileBlastAnim8 - TileBlastAnim ; tile #$78 (also tile #$76 in Norfair)
    .byte TileBlastAnim0 - TileBlastAnim ; tile #$7C
    .byte TileBlastAnim1 - TileBlastAnim ; tile #$80
    .byte TileBlastAnim2 - TileBlastAnim ; tile #$84
    .byte TileBlastAnim3 - TileBlastAnim ; tile #$88
    .byte TileBlastAnim4 - TileBlastAnim ; tile #$8C
    .byte TileBlastAnim9 - TileBlastAnim ; tile #$90
    .byte TileBlastAnim5 - TileBlastAnim ; tile #$94

UpdateTileBlast_Respawned:
    ; delete tile blast
    lda #$00
    sta TileBlasts.0.routine,x
    ; ($03, $02) = position of center of tile
    lda TileBlasts.0.roomRAMPtr,x
    clc
    adc #$21
    sta $00
    lda TileBlasts.0.roomRAMPtr+1,x
    sta $01
    jsr GetPosAtNameTableAddr
    ; check if colliding with Samus
    lda $02
    sta Temp07_XSlotPositionY
    lda $03
    sta Temp09_XSlotPositionX
    lda $01
    lsr
    lsr
    and #$01
    sta Temp0B_XSlotPositionHi
    ; get Samus's position
    ldy #$00
    jsr GetObjectYSlotPosition
    ; 8x8 hitbox
    lda #$04
    clc
    adc ObjRadY
    sta Temp04_YSlotRadY
    lda #$04
    clc
    adc ObjRadX
    sta Temp05_YSlotRadX
    jsr CheckCollisionOfXSlotAndYSlot
    bcs GetTileBlastFramePtr@RTS

    ; tile hit Samus
    jsr SamusHurt_F311
    ; deal 5 damage to samus
    lda #$50
    sta HealthChange
    jmp SubtractHealth

GetTileBlastFramePtr:
    lda TileBlasts.0.animFrame,x
    asl
    tay
    lda TileBlastFramePtrTable,y
    sta $02
    lda TileBlastFramePtrTable+1,y
    sta $03
@RTS:
    rts

; return carry clear if successfully drawn
; return carry set if there is not enough space in the ppu string buffer
DrawTileBlast: ;($FEDC)
    lda PPUStrIndex
    cmp #$1F
    bcs GetTileBlastFramePtr@RTS
    ldx PageIndex
    ; $01.$00 = TileBlastRoomRAMPtr
    lda TileBlasts.0.roomRAMPtr,x
    sta $00
    lda TileBlasts.0.roomRAMPtr+1,x
    sta $01
    jsr GetTileBlastFramePtr
    ; $11 = room RAM index = 0
    ldy #$00
    sty $11
    ; header: hhhhwwww
    lda ($02),y
    tax
    ; $04 = height (high nybble)
    jsr Adiv16       ; / 16
    sta $04
    txa
    ; $05 = width (low nybble)
    and #$0F
    sta $05
    ; $10 = frame index = 1
    iny
    sty $10
    @loop_rows:
        ldx $05
        @loop_columns:
            ; write tile
            ; read src and increment frame index
            ldy $10
            lda ($02),y
            inc $10
            ; write to room RAM and increment room RAM index
            ldy $11
            sta ($00),y
            inc $11
            ; loop if there are columns remaining
            dex
            bne @loop_columns
        ; next row
        lda $11
        clc
        adc #$20
        ; to compenate for incrementing room RAM index by writing the previous row
        sec
        sbc $05
        sta $11
        ; loop if there are rows remaining
        dec $04
        bne @loop_rows
    ; $01.$00 = PPU address to write tile blast
    ; branch if in RoomRAMA
    lda $01
    and #$04
    beq @inNameTable0
        ; write to nametable 3
        lda $01
        ora #$0C
        sta $01
    @inNameTable0:
    lda $01
    and #$2F
    sta $01
    jsr WriteTileBlast
    clc
    rts

GetPosAtNameTableAddr:
    ; $01.$00 = ------yy yyyxxxxx (nametable address)
    ; $02 = yyyyy000 (Y position)
    ; $03 = xxxxx000 (X position)
    lda $00
    tay
    and #%11100000
    sta $02
    lda $01
    lsr
    ror $02
    lsr
    ror $02
    tya
    and #%00011111
    jsr Amul8       ; * 8
    sta $03
    rts

UpdateTileBlastAnim:
    ldx PageIndex
    ldy TileBlasts.0.animDelay,x
    beq @update
        dec TileBlasts.0.animDelay,x
        bne @RTS
    @update:
    ; TileBlastAnimDelay = A
    sta TileBlasts.0.animDelay,x
    ; get frame index
    ldy TileBlasts.0.animIndex,x
    lda TileBlastAnim,y
    cmp #$FE            ; end of "tile-blast" animation?
    beq @end
    ; set frame
    sta TileBlasts.0.animFrame,x
    ; inc anim index
    iny
    tya
    sta TileBlasts.0.animIndex,x
    ; try to draw it
    jsr DrawTileBlast
    bcc @RTS
    ; Failed to draw, retry drawing it next frame.
    ; BUG: TileBlastAnimDelay should be set to 0 or 1 here.
    ldx PageIndex
    dec TileBlasts.0.animIndex,x
@RTS:
    rts
@end:
    ; TileBlastRoutine = wait to respawn
    inc TileBlasts.0.routine,x
    ; Quit updating remaining tile blasts and return (bug)
    pla
    pla
    rts

; Frame data for tile blasts (why aren't these in area banks?)

TileBlastAnim:
TileBlastAnim0:  .byte $06,$07,$00,$FE ; blasting tile or respawning tile #$7C
TileBlastAnim1:  .byte $07,$06,$01,$FE ; respawning tile #$80
TileBlastAnim2:  .byte $07,$06,$02,$FE ; respawning tile #$84
TileBlastAnim3:  .byte $07,$06,$03,$FE ; respawning tile #$88
TileBlastAnim4:  .byte $07,$06,$04,$FE ; respawning tile #$8C
TileBlastAnim5:  .byte $07,$06,$05,$FE ; respawning tile #$94
TileBlastAnim6:  .byte $07,$06,$09,$FE ; respawning tile #$70
TileBlastAnim7:  .byte $07,$06,$0A,$FE ; respawning tile #$74
TileBlastAnim8:  .byte $07,$06,$0B,$FE ; respawning tile #$78
TileBlastAnim9:  .byte $07,$06,$08,$FE ; respawning tile #$90

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $01, $02
.endif

;-----------------------------------------------[ RESET ]--------------------------------------------

ROMFIXED_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $007 - Vectors" bank 7 slot "ROMFixedSlot" orga $FFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_CNSUS"
        .word ROMFIXED_RESET            ;($FFB0)Reset vector.
        .word ROMFIXED_RESET            ;($FFB0)IRQ vector.
    .elif BUILDTARGET == "NES_MZMJP"
        .word $FFFF
        .word $FFFF
    .endif
.ends

