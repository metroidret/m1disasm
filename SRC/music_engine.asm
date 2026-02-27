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
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Music Engine (part 1)

; The reason the music engine is split into two parts is because the song init
; table differs between banks. Songs that are not included in the bank point to
; the middle of RAM instead.

SFXData: ;The top four entries are used by the noise music player for drum beats.
    .byte $00                       ;Base for drum beat music data.

DrumBeat00SFXData:
    .byte $10, $01, $18             ;Noise channel music data #$01.
DrumBeat01SFXData:
    .byte $00, $01, $38             ;Noise channel music data #$04.
DrumBeat02SFXData:
    .byte $01, $02, $40             ;Noise channel music data #$07.
DrumBeat03SFXData:
    .byte $00, $09, $58             ;Noise channel music data #$0A.
GamePausedSFXData:
    .byte $80, $7F, $80, $48
ScrewAttSFXData:
    .byte $35, $7F, $00, $B0
MissileLaunchSFXData:
    .byte $19, $7F, $0E, $A0
BombExplodeSFXData:
    .byte $0D, $7F, $0F, $08
SamusWalkSFXData:
    .byte $16, $7F, $0B, $18
SpitFlameSFXData:
    .byte $13, $7F, $0E, $F8
SamusHitSFXSQ1SQ2Data:
    .byte $C1, $89, $02, $0F
BossHitSFXSQ2Data:
    .byte $34, $BA, $E0, $05
BossHitSFXSQ1Data:
    .byte $34, $BB, $CE, $05
IncorrectPasswordSFXSQ1Data:
    .byte $B6, $7F, $00, $C2
IncorrectPasswordSFXSQ2Data:
    .byte $B6, $7F, $04, $C2
TimeBombTickSFXData:
    .byte $17, $7F, $66, $89
EnergyPickupSFXData:
    .byte $89, $7F, $67, $18
MissilePickupSFXData:
    .byte $8B, $7F, $FD, $28
MetalSFXData:
    .byte $02, $7F, $A8, $F8
LongRangeShotSFXData:
    .byte $D7, $83, $58, $F8
ShortRangeShotSFXData:
    .byte $D6, $82, $58, $F8
JumpSFXData:
    .byte $95, $8C, $40, $B9
EnemyHitSFXData:
    .byte $1D, $9A, $20, $8F
BugOutOFHoleSFXData:
    .byte $16, $8D, $E0, $42
WaveBeamSFXData:
    .byte $19, $7F, $6F, $40
IceBeamSFXData:
    .byte $18, $7F, $80, $40
BombLaunch1SFXData:
    .byte $07, $7F, $40, $28
BombLaunch2SFXData:
    .byte $07, $7F, $45, $28
SamusToBallSFXData:
    .byte $7F, $7F, $DD, $3B
MetroidHitSFXData:
    .byte $7F, $7F, $FF, $98
SamusDieSFXData:
    .byte $7F, $7F, $40, $08
SamusBeepSFXData:
    .byte $09, $7F, $30, $48
BigEnemyHitSFXData:
    .byte $03, $7F, $42, $18
StatueRaiseSFXData:
    .byte $03, $7F, $11, $09
DoorSFXData:
    .byte $7F, $7F, $30, $B2

;The following table is used by the CheckSFXFlag routine.  The first two bytes of each row
;are the address of the pointer table used for handling SFX and music  routines for set flags.
;The second pair of bytes is the address of the routine to next jump to if no SFX or music
;flags were found.  The final byte represents what type of channel is currently being
;processed: 0=Noise, 1=SQ1, 3=Tri, 4=Multiple channels.

SFXNoiseInitPointers:
    ;Noise init SFX         (1st).
    .word SFXNoiseInitRoutineTbl, LoadSFXNoiseContFlags
    .byte $00

SFXNoiseContPointers:
    ;Noise continue SFX     (2nd).
    .word SFXNoiseContRoutineTbl, CheckSFXFlag@RTS
    .byte $00

SFXSQ1InitPointers:
    ;SQ1 init SFX           (5th).
    .word SFXSQ1InitRoutineTbl, LoadSFXSQ1ContFlags
    .byte $01

SFXSQ1ContPointers:
    ;SQ2 continue SFX       (6th).
    .word SFXSQ1ContRoutineTbl, CheckSFXFlag@RTS
    .byte $01

SFXTriInitPointers:
    ;Triangle init SFX      (7th).
    .word SFXTriInitRoutineTbl, LoadSFXTriContFlags
    .byte $03

SFXTriContPointers:
    ;Triangle continue SFX  (8th).
    .word SFXTriContRoutineTbl, CheckSFXFlag@RTS
    .byte $03

SFXMultiInitPointers:
    ;Multi init SFX         (3rd).
    .word SFXMultiInitRoutineTbl, LoadSFXMultiContFlags
    .byte $04

SFXMultiContPointers:
    ;Multi continue SFX     (4th).
    .word SFXMultiContRoutineTbl, GotoLoadSFXSQ1InitFlags
    .byte $04

MusicContPointers:
    ;temp flag Music        (10th).
    .word MusicRoutineTbl, ContinueMusic
    .byte $00

MusicInitPointers:
    ;Music                  (9th).
    .word MusicRoutineTbl, LoadMusicInitFlags
    .byte $00

;The tables below contain addresses for SFX handling routines.

;Noise Init SFX handling routine addresses:
SFXNoiseInitRoutineTbl:
    .word CheckSFXFlag@RTS                     ;No sound.
    .word ScrewAttackSFXStart                     ;Screw attack init SFX.
    .word MissileLaunchSFXStart                     ;Missile launch init SFX.
    .word BombExplodeSFXStart                     ;Bomb explode init SFX.
    .word SamusWalkSFXStart                     ;Samus walk init SFX.
    .word SpitFlameSFXStart                     ;Spit flame init SFX.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.

;Noise Continue SFX handling routine addresses:
SFXNoiseContRoutineTbl:
    .word CheckSFXFlag@RTS                     ;No sound.
    .word ScrewAttackSFXContinue                     ;Screw attack continue SFX.
    .word MissileLaunchSFXContinue                     ;Missile launch continue SFX.
    .word NoiseSFXContinue                     ;Bomb explode continue SFX.
    .word NoiseSFXContinue                     ;Samus walk continue SFX.
    .word SpitFlameSFXContinue                     ;Spit flame continue SFX.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.

;SQ1 Init SFX handling routine addresses:
SFXSQ1InitRoutineTbl:
    .word MissilePickupSFXStart                     ;Missile pickup init SFX.
    .word EnergyPickupSFXStart                     ;Energy pickup init SFX.
    .word MetalSFXStart                     ;Metal init SFX.
    .word BulletFireSFXStart                     ;Bullet fire init SFX.
    .word BirdOutOfHoleSFXStart                     ;Bird out of hole init SFX.
    .word EnemyHitSFXStart                     ;Enemy hit init SFX.
    .word SamusJumpSFXStart                     ;Samus jump init SFX.
    .word WaveBeamSFXStart                     ;Wave beam init SFX.

;SQ1 Continue SFX handling routine addresses:
SFXSQ1ContRoutineTbl:
    .word MissilePickupSFXContinue                     ;Missile pickup continue SFX.
    .word EnergyPickupSFXContinue                     ;Energy pickup continue SFX.
    .word SQ1SFXContinue                     ;Metal continue SFX.
    .word BulletFireSFXContinue                     ;Bullet fire continue SFX.
    .word SQ1SFXContinue                     ;Bird out of hole continue SFX.
    .word SQ1SFXContinue                     ;Enemy hit continue SFX.
    .word SQ1SFXContinue                     ;Samus jump continue SFX.
    .word WaveBeamSFXContinue                     ;Wave beam continue SFX.

;Triangle init handling routine addresses:
SFXTriInitRoutineTbl:
    .word SamusDieSFXStart                     ;Samus die init SFX.
    .word DoorOpenCloseSFXStart                     ;Door open close init SFX.
    .word MetroidHitSFXStart                     ;Metroid hit init SFX.
    .word StatueRaiseSFXStart                     ;Statue raise init SFX.
    .word BeepSFXStart                     ;Beep init SFX.
    .word BigEnemyHitSFXStart                     ;Big enemy hit init SFX.
    .word SamusToBallSFXStart                     ;Samus to ball init SFX.
    .word BombLaunchSFXStart                     ;Bomb launch init SFX.

;Triangle continue handling routine addresses:
SFXTriContRoutineTbl:
    .word SamusDieSFXContinue                     ;Samus die continue SFX.
    .word DoorOpenCloseSFXContinue                     ;Door open close continue SFX.
    .word MetroidHitSFXContinue                     ;Metroid hit continue SFX.
    .word StatueRaiseSFXContinue                     ;Statue raise continue SFX.
    .word BeepSFXContinue                     ;Beep continue SFX.
    .word BigEnemyHitSFXContinue                     ;Big enemy hit continue SFX.
    .word SamusToBallSFXContinue                     ;Samus to ball continue SFX.
    .word BombLaunchSFXContinue                     ;Bomb launch continue SFX.

LoadSFXNoiseInitFlags:
    lda SFXNoiseInitFlags                ;Load A with Noise init SFX flags, (1st SFX cycle).
    ldx #<SFXNoiseInitPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags ;Branch always.

LoadSFXNoiseContFlags:
    lda SFXNoiseContFlags                ;Load A with Noise continue flags, (2nd SFX cycle).
    ldx #<SFXNoiseContPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadSFXSQ1InitFlags:
    lda SFXSQ1InitFlags                  ;Load A with SQ1 init flags, (5th SFX cycle).
    ldx #<SFXSQ1InitPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags ;Branch always.

LoadSFXSQ1ContFlags:
    lda SFXSQ1ContFlags                  ;Load A with SQ1 continue flags, (6th SFX cycle).
    ldx #<SFXSQ1ContPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags ;Branch always. useless instruction

GotoSFXCheckFlags:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX flags set.
    jmp (SoundE2)                     ;if no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling routine.

LoadSFXTriInitFlags:
    lda SFXTriInitFlags                  ;Load A with Triangle init flags, (7th SFX cycle).
    ldx #<SFXTriInitPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags ;Branch always.

LoadSFXTriContFlags:
    lda SFXTriContFlags                  ;Load A with Triangle continue flags, (8th SFX cycle).
    ldx #<SFXTriContPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags ;Branch always.

LoadSFXMultiInitFlags:
    lda SFXMultiInitFlags                ;Load A with Multi init flags, (3rd SFX cycle).
    ldx #<SFXMultiInitPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jsr Add8                        ;($BC64)Add 8 to MusicInitIndex.
    jmp (SoundE2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.
LoadSFXMultiContFlags:
    lda SFXMultiContFlags                ;Load A with $68C flags (4th SFX cycle).
    ldx #<SFXMultiContPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    jmp GotoSFXCheckFlags           ;($B337)Checks to see if SFX or music flags set.

GotoLoadSFXSQ1InitFlags:
    jsr LoadSFXSQ1InitFlags         ;($B329)Check for SQ1 init flags.
    rts

LoadSQ1ChannelSFX: ; $B368
    ;Used to determine which sound registers to change ($4000 - $4003) - SQ1.
    lda #<SQ1_VOL
    beq LoadSFXData ;Branch always.

LoadTriChannelSFX:
    ;Used to determine which sound registers to change ($4008 - $400B) - Triangle.
    lda #<TRI_LINEAR
    bne LoadSFXData ;Branch always.

LoadNoiseChannelSFX:
    ;Used to determine which sound registers to change ($400C - $400F) - Noise.
    lda #<NOISE_VOL
    bne LoadSFXData ;Branch always.

LoadSQ2ChannelSFX:
    ;Used to determine which sound registers to change ($4004 - $4007) - SQ2.
    lda #<SQ2_VOL
    ; fallthrough

LoadSFXData:
    ;Lower address byte of desired APU control register.
    sta SoundE0
    ;Upper address byte of desired APU control register.
    lda #$40
    sta SoundE0+1
    
    ;Lower address byte of data to load into sound channel.
    sty SoundE2
    ;Upper address byte of data to load into sound channel.
    lda #>SFXData.b
    sta SoundE2+1
    
    ;Starting index for loading four byte sound data.
    ldy #$00
    @loop_LoadSFXRegisters:
        ;Load A with SFX data byte. Store A in SFX register.
        lda (SoundE2),y
        sta (SoundE0),y
        iny
        tya
        ;The four registers associated with each sound channel are loaded one after the other.
        ; (the loop repeats four times)
        cmp #$04
        bne @loop_LoadSFXRegisters
    rts

PauseSFX:
    ;SFXPaused=#$01
    inc SFXPaused
    ;Clear sound registers of data.
    jsr ClearSounds
    ;PauseSFXStatus=#$00
    sta PauseSFXStatus
    rts

SoundEngine_GameIsPaused:
    ;Has SFXPaused been set? if not, branch
    lda SFXPaused
    beq PauseSFX
    ;For the first #$12 frames after the game has been paused, play GamePaused SFX.
    ;If paused for #$12 frames or more, branch to exit.
    lda PauseSFXStatus
    cmp #$12
    beq @RTS
    ;Every fourth frame, repeat GamePaused SFX
    and #$03
    cmp #$03
    bne @endIf_A
        ;Lower address byte of GamePaused SFX data(Base=$B200)
        ldy #<GamePausedSFXData.b
        ;Load GamePaused SFX data.
        jsr LoadSQ1ChannelSFX
    @endIf_A:
    inc PauseSFXStatus
@RTS:
    rts

;------------------------------------[ Sound Engine Entry Point ]------------------------------------
;NOTES:
;SFX take priority over music.
;
;There are 10 SFX cycles run every time the sound engine subroutine is called.  The cycles
;search for set sound flags in the following registers in order:
;$680, $688, $684, $68C, $681, $689, $683, $68B, $65D, $685
;
;The sound channels are assigned SFX numbers.  Those SFX numbers are:
;Noise=0, sq1=1, sq2=2, triangle=3, Multi=4
;The sound channels are assigned music numbers.  Those music numbers are:
;SQ1=0, SQ2=1, Tri=2, Noise=3

SoundEngine:
    ;Set APU to 5 frame cycle, disable frame interrupt.
    ;This syncs the APU's frame counter with the PPU.
    lda #APU_5STEP | APU_IRQDISABLE
    sta JOY2
    ;is bit zero is set in SFXNoiseInitFlag(Silence music)?  If yes, branch.
    lda SFXNoiseInitFlags
    lsr
    bcs SoundEngine_SilenceMusic
    ;Is game paused?  If yes, branch.
    lda MainRoutine
    cmp #_id_PauseMode.b
    beq SoundEngine_GameIsPaused
    ;Clear SFXPaused when game is running.
    lda #$00
    sta SFXPaused
    jsr LoadSFXNoiseInitFlags       ;($B31B)Check noise SFX flags.
    jsr LoadSFXMultiInitFlags       ;($B34B)Check multichannel SFX flags.
    jsr LoadSFXTriInitFlags         ;($B33D)Check triangle SFX flags.
    jsr LoadMusicRepeatFlags          ;($BC36)Check music flags.
    ; fallthrough

;Clear all SFX flags.
ClearSFXFlags:
    lda #$00
    sta SFXNoiseInitFlags
    sta SFXSQ1InitFlags
    sta SFXSQ2InitFlags
    sta SFXTriInitFlags
    sta SFXMultiInitFlags
    sta MusicInitFlags
    rts

SoundEngine_SilenceMusic:
    jsr InitializeSoundAddresses    ;($B404)Prepare to start playing music.
    beq ClearSFXFlags ;Branch always.

CheckRepeatMusic:
    ;If music is supposed to repeat, reset music flags else branch to exit.
    lda MusicRepeatsOnEnd
    beq InitializeSoundAddresses
    lda MusicContFlags
    sta MusicRepeatFlags
    rts

CheckMusicFlags: ; $B3FC
    lda MusicContFlags                ;Loads A with current music flags and compares it-->
    cmp CurrentSFXFlags             ;with current SFX flags.  If both are equal,-->
    beq GotoClearSpecialAddresses   ;just clear music counters, else clear everything.

InitializeSoundAddresses: ; $B404
    ;Jumps to all subroutines needed to reset all sound addresses in order to start playing music.
    jsr ClearMusicAndSFXAddresses
    jsr ClearSounds
GotoClearSpecialAddresses:
    ; the function is right below lmao
    jsr ClearSpecialAddresses
    rts

;Clears addresses used for repeating music, pausing music and controlling triangle length.
ClearSpecialAddresses: ; $B40E
    lda #$00
    sta TriCounterCntrl
    sta SFXPaused
    sta MusicRepeatFlags
    sta MusicRepeatsOnEnd
    rts

;Clears any SFX or music currently being played.
ClearMusicAndSFXAddresses: ; $B41D
    lda #$00
    sta SQ1UsedBySFX
    sta SQ2UsedBySFX
    sta TriUsedBySFX
    sta LoadMusicSQ1SQ2PeriodsFlag
    sta SFXNoiseContFlags
    sta SFXSQ1ContFlags
    sta SFXSQ2ContFlags
    sta SFXTriContFlags
    sta SFXMultiContFlags
    sta MusicContFlags
    rts

;Clears all sounds that might be in the sound channel registers.
ClearSounds: ; $B43E
    lda #$10
    sta SQ1_VOL
    sta SQ2_VOL
    sta NOISE_VOL
    lda #$00
    sta TRI_LINEAR
    sta DMC_RAW
    rts

SelectSFXRoutine:
    ;Stores frame length of SFX in corresponding address.
    ldx ChannelType
    sta SFXNoiseLength,x
    txa
    ;Branch if SFX uses noise channel.
    beq SelectSFXRoutine_Noise
    ;Branch if SFX uses SQ1 channel.
    cmp #$01
    beq SelectSFXRoutine_SQ1
    ;Branch if SFX uses SQ2 channel.
    cmp #$02
    beq SelectSFXRoutine_SQ2
    ;Branch if SFX uses triangle wave.
    cmp #$03
    beq SelectSFXRoutine_Tri
    ;Exit if SFX routine uses no channels.
    rts

SelectSFXRoutine_SQ1:
    jsr LoadSQ1ChannelSFX           ;($B368)Prepare to load SQ1 channel with data.
    beq SelectSFXRoutine_Common     ;Branch always.
SelectSFXRoutine_SQ2:
    jsr LoadSQ2ChannelSFX           ;($B374)Prepare to load SQ2 channel with data.
    beq SelectSFXRoutine_Common     ;Branch always.
SelectSFXRoutine_Tri:
    jsr LoadTriChannelSFX      ;($B36C)Prepare to load triangle channel with data.
    beq SelectSFXRoutine_Common     ;Branch always.
SelectSFXRoutine_Noise:
    jsr LoadNoiseChannelSFX         ;($B370)Prepare to load noise channel with data.
SelectSFXRoutine_Common:
    ;Set continuation flags for this SFX.
    jsr UpdateContFlags
    ;Indicate sound channel is in use.
    txa
    sta NoiseUsedBySFX,x
    ;Clears all the following addresses before going to the proper SFX handling routine.
    lda #$00
    sta SFXNoiseFrame,x
    sta SFXNoiseData0,x
    sta SFXNoiseData1,x
    sta SFXNoiseData2,x
    sta LoadMusicSQ1SQ2PeriodsFlag
    rts

UpdateContFlags: ; $B493
    ;Loads X register with sound channel just changed.
    ldx ChannelType
    ;Clear existing continuation SFX flags for that channel.
    lda SFXNoiseContFlags,x
    and #$00 ; was this value non-zero at some point in development?
    ;Load new continuation flags.
    ora CurrentSFXFlags
    ;Save results.
    sta SFXNoiseContFlags,x
    rts

ClearCurrentSFXFlags:
    ;Once SFX has completed, this block clears the SFX flag from the current flag register.
    lda #$00
    sta CurrentSFXFlags
    beq UpdateContFlags ; branch always

IncrementSFXFrame:
    ;Load SFX channel number.
    ldx ChannelType
    ;Increment and load current frame to play on given channel.
    inc SFXNoiseFrame,x
    lda SFXNoiseFrame,x
    ;Check to see if current frame is last frame to play.
    cmp SFXNoiseLength,x
    bne @RTS
        ;If current frame is last frame, reset current frame to 0.
        lda #$00
        sta SFXNoiseFrame,x
    @RTS:
    rts


CheckSFXFlag:
    ;Store any set flags in $064D.
    sta CurrentSFXFlags
    ;Prepare pointer to SFX data
    stx SoundE4
    ldy #>SFXNoiseInitPointers.b
    sty SoundE4+1
    ;Y=0 for counting loop ahead.
    ldy #$00
    @loop_A:
        ;Loads either SFXInitPointers or SFXContPointers into $E0-$E3
        lda (SoundE4),y
        sta SoundE0,y
        iny
        tya
        ;Loop repeats four times to load the values.
        cmp #$04
        bne @loop_A
    lda (SoundE4),y
    sta ChannelType                 ;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
    ;Set y to 0 for counting loop ahead.
    ldy #$00
    ;Push current SFX flags on stack.
    lda CurrentSFXFlags
    pha
    @loop_B:
        ;This portion of the routine loops a maximum of eight times looking for
        ;any SFX flags that have been set in the current SFX cycle.
        asl CurrentSFXFlags
        ;If a flag is found, Branch to @SFXFlagFound for further processing
        bcs @SFXFlagFound
        ;no flags are set, continue to next SFX cycle.
        iny
        iny
        tya
        cmp #$10
        bne @loop_B

;Restore original data in CurrentSFXFlags.
@RestoreSFXFlags:
    pla
    sta CurrentSFXFlags
@RTS:
    rts

@SFXFlagFound:
    lda (SoundE0),y                 ;This routine stores the starting address of the-->
    sta SoundE2                     ;specific SFX handling routine for the SFX flag-->
    iny                             ;found.  The address is stored in registers-->
    lda (SoundE0),y                 ;$E2 and $E3.
    sta SoundE2+1                   ;
    jmp @RestoreSFXFlags             ;($B4EA)Restore original data in CurrentSFXFlags.

;-----------------------------------[ SFX Handling Routines ]---------------------------------------

;The following table is used by the SpitFlamesSFXContinue routine to change the volume-->
;on the SFX.  It starts out quiet, then becomes louder then goes quiet again.
SpitFlamesTbl:
    .byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1B, $1A, $19, $17
    .byte $16, $15, $14, $12

SpitFlameSFXStart:
    lda #$14                        ;Number of frames to play sound before a change.
    ldy #<SpitFlameSFXData.b          ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

SpitFlameSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @endIf_A                       ;If more frames to process, branch.
        jmp EndNoiseSFX                 ;($B58F)End SFX.
    @endIf_A:
    ldy SFXNoiseData0                ;
    lda SpitFlamesTbl,y             ;Load data from table above and store in NOISE_VOL.
    sta NOISE_VOL                   ;
    inc SFXNoiseData0                ;Increment to next entry in data table.
    rts

ScrewAttackSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #<ScrewAttSFXData.b           ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda ScrewAttSFXData+2                       ;#$00.
    sta SFXNoiseData0                ;Clear SFXNoiseData0.
@RTS:
    rts

ScrewAttackSFXContinue:
    ;Prevents period index from being incremented until after the tenth frame of the SFX.
    ;Branch if not ready to increment.
    lda SFXNoiseData2
    cmp #$02
    beq @increasePeriod
    
    jsr IncrementSFXFrame
    bne ScrewAttackSFXStart@RTS
    ;Increment every fifth frame.
    inc SFXNoiseData2
    rts

@increasePeriod:
    ;Start increasing period index after first ten frames.
    jsr IncrementSFXFrame
    bne IncrementPeriodIndex
    ;Decrement SFXNoiseData0 by three every fifth frame.
    dec SFXNoiseData0
    dec SFXNoiseData0
    dec SFXNoiseData0
    ; Increment SFXNoiseData1.  When it is equal to #$0F, end screw attack SFX.
    ; SFXNoiseData1 does not appear to be linked to multi SFX channels in this routine.
    inc SFXNoiseData1
    lda SFXNoiseData1
    cmp #$0F
    bne ScrewAttackSFXStart@RTS
    jmp EndNoiseSFX

IncrementPeriodIndex:
    ;Incrementing the period index has the effect of lowering the frequency of the noise SFX.
    inc SFXNoiseData0
    lda SFXNoiseData0
    sta NOISE_LO
    rts

MissileLaunchSFXStart:
    lda #$18                        ;Number of frames to play sound before a change.
    ldy #<MissileLaunchSFXData.b      ;Lower byte of sound data start address(base=$B200).
    jsr GotoSelectSFXRoutine        ;($B587)Prepare to setup registers for SFX.
    lda #$0A                        ;
    sta SFXNoiseData0                ;Start increment index for noise channel at #$0A.
    rts

MissileLaunchSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne IncrementPeriodIndex        ;
    jmp EndNoiseSFX                 ;($B58F)End SFX.

BombExplodeSFXStart:
    lda #$30                        ;Number of frames to play sound before a change.
    ldy #<BombExplodeSFXData.b        ;Lower byte of sound data start address(base=$B200).
GotoSelectSFXRoutine:
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

;The following routine is used to continue BombExplode and SamusWalk SFX.

NoiseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne EndNoiseSFX@RTS           ;If more frames to process, branch to exit.

EndNoiseSFX:
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    lda #$10                        ;
    sta NOISE_VOL                   ;disable envelope generator(sound off).
@RTS:
    rts

SamusWalkSFXStart:
    lda SFXNoiseContFlags                ;If MissileLaunch, BombExplode or SpitFire SFX are-->
                                    ;already being played, branch to exit.s
    and #sfxNoise_MissileLaunch | sfxNoise_BombExplode | sfxNoise_SpitFlame
    bne EndNoiseSFX@RTS
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<SamusWalkSFXData.b          ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine        ;Branch always.

MultiSFXInit:
    sta SFXMultiLength
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    jsr UpdateContFlags             ;($B493)Set continue SFX flag.
    ;Disable music from using SQ1 and SQ2 while SFX are playing.
    lda #$01
    sta SQ1UsedBySFX
    lda #$02
    sta SQ2UsedBySFX
    ;Clear all listed memory addresses.
    lda #$00
    sta SFXSQ1ContFlags
    sta SFXSQ1Data0
    sta SFXSQ2PeriodLow
    sta SFXSQ1PeriodLow
    sta SFXMultiFrame
    sta LoadMusicSQ1SQ2PeriodsFlag
    rts

EndMultiSFX:
    ;Disable SQ1 & SQ2 envelope generators(sound off).
    lda #$10
    sta SQ1_VOL
    sta SQ2_VOL
    ;Disable SQ1 & SQ2 sweeps.
    lda #$7F
    sta SQ1_SWEEP
    sta SQ2_SWEEP
    ;($B4A2)Clear all SFX flags.
    jsr ClearCurrentSFXFlags
    ;Allows music player to use SQ1 and SQ2 channels.
    lda #$00
    sta SQ1UsedBySFX
    sta SQ2UsedBySFX
    inc LoadMusicSQ1SQ2PeriodsFlag
    rts

BossHitSFXStart:
    ldy #<BossHitSFXSQ1Data.b         ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    ldy #<BossHitSFXSQ2Data.b         ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
    inc SFXSQ1Data0                  ;Increment index to data in table below.
    ldy SFXSQ1Data0                  ;
    lda BossHitSFXDataTbl,y         ;
    sta SQ1_VOL                     ;Load SQ1_VOL and SQ2_VOL from table below.
    sta SQ2_VOL                     ;
    lda SFXSQ1Data0                  ;
    cmp #$14                        ;After #$14 frames, end SFX.
    beq GotoEndMultiSFX             ;
    cmp #$06                        ;After six or more frames of SFX, branch.
    bcc LB620                       ;
    lda RandomNumber1               ;
    ora #$10                        ;Set bit 5.
    and #$7F                        ;Randomly set bits 7, 3, 2, 1 and 0.
    sta SFXSQ1PeriodLow             ;Store in SQ1 period low.
    rol                             ;
    sta SFXSQ2PeriodLow               ;
    jmp WriteSQ1SQ2PeriodLow        ;($B62C)Write period low data to SQ1 and SQ2.
LB620:
    ;Increment SQ1 and SQ2 period low by two.
    inc SFXSQ2PeriodLow
    inc SFXSQ2PeriodLow
    inc SFXSQ1PeriodLow
    inc SFXSQ1PeriodLow

WriteSQ1SQ2PeriodLow:
    ;Write new SQ1 and SQ2 period lows to SQ1 and SQ2 channels.
    lda SFXSQ2PeriodLow
    sta SQ2_LO
    lda SFXSQ1PeriodLow
    sta SQ1_LO
    rts

GotoEndMultiSFX:
    jmp EndMultiSFX                 ;($B5CD)End SFX.

BossHitSFXDataTbl:
    .byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
    .byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @endIf_A                       ;If more SFX frames to process, branch.
        jmp EndMultiSFX                 ;($B5CD)End SFX.
    @endIf_A:
    ldy #<SamusHitSFXSQ1SQ2Data.b     ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                      ;
    ldy #<SamusHitSFXSQ1SQ2Data.b     ;Low byte of SQ2 sound data start address(base=$B200).
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                      ;Randomly set bits 2 and 3 of SQ2 period low.
    rts

SamusHitSFXStart:
    ldy #<SamusHitSFXSQ1SQ2Data.b     ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                      ;
    clc                             ;
    lda RandomNumber1               ;Randomly set last three bits of SQ2 period low+1.
    and #$03                        ;
    adc #$01                        ;Number of frames to play sound before a change.
    ldy #<SamusHitSFXSQ1SQ2Data.b     ;Low byte of SQ2 sound data start address(base=$B200).
    jsr MultiSFXInit                ;($B5A5)Initiate multi channel SFX.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                   ;Randomly set bits 2 and 3 of SQ2 period low.
@RTS:
    rts

IncorrectPasswordSFXStart:
    ldy #<IncorrectPasswordSFXSQ1Data.b ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda #$20                        ;Number of frames to play sound before a change.
    ldy #<IncorrectPasswordSFXSQ2Data.b ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne SamusHitSFXStart@RTS                       ;If more frames to process, branch to exit.
    jmp EndMultiSFX                 ;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1_LO data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
    .byte $BD, $8D, $7E, $5E, $46, $3E, $00

MissilePickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @RTS               ;If more frames to process, branch to exit.
    ldy SFXSQ1Data0                  ;
    lda MissilePickupSFXTbl,y       ;Load SFX data from table above.
    bne @endIf_A
        jmp EndSQ1SFX                   ;($B6F2)SFX completed.
    @endIf_A:
    sta SQ1_LO
    lda MissilePickupSFXData+3      ;#$28.
    sta SQ1_HI                   ;load SQ1_HI with #$28.
    inc SFXSQ1Data0                  ;Increment index to data table above every 5 frames.
@RTS:
    rts

MissilePickupSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #<MissilePickupSFXData.b      ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2                  ;Branch always.

EnergyPickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MissilePickupSFXContinue@RTS               ;If more frames to process, branch to exit.
    inc SFXSQ1Data0                  ;
    lda SFXSQ1Data0                  ;Every six frames, reload SFX info.  Does it-->
    cmp #$03                        ;three times for a total of 18 frames.
    beq EndSQ1SFX                   ;
    ldy #<EnergyPickupSFXData.b       ;
    jmp LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #<EnergyPickupSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MissilePickupSFXContinue@RTS

EndSQ1SFX:
    lda #$10                        ;
    sta SQ1_VOL                     ;Disable envelope generator(sound off).
    lda #$00                        ;
    sta SQ1UsedBySFX                    ;Allows music to use SQ1 channel.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    inc LoadMusicSQ1SQ2PeriodsFlag       ;Allows music routines to load SQ1 and SQ2 music.
    rts

SamusJumpSFXStart:
    lda MusicContFlags                ;If escape music is playing, exit without playing-->
    cmp #music_Escape               ;Samus jump SFX.
    beq MissilePickupSFXContinue@RTS               ;
    lda #$0C                        ;Number of frames to play sound before a change.
    ldy #<JumpSFXData.b        ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.

EnemyHitSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #<EnemyHitSFXData.b    ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.

BulletFireSFXStart:
    lda HasBeamSFX                  ;
    lsr                             ;If Samus has ice beam, branch.
    bcs HasIceBeamSFXStart          ;
    lda SFXSQ1ContFlags                  ;If MissilePickup, EnergyPickup, BirdOutOfHole-->
                                    ;or EnemyHit SFX already playing, branch to exit.
    and #sfxSQ1_MissilePickup | sfxSQ1_EnergyPickup | sfxSQ1_OutOfHole | sfxSQ1_EnemyHit
    bne MissilePickupSFXContinue@RTS           ;
    lda HasBeamSFX                  ;
    asl                             ;If Samus has long beam, branch.
    bcs HasLongBeamSFXStart         ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<ShortRangeShotSFXData.b     ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #<LongRangeShotSFXData.b      ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.

MetalSFXStart:
    lda #$0B                        ;Number of frames to play sound before a change.
    ldy #<MetalSFXData.b              ;Lower byte of sound data start address(base=$B200).

GotoSelectSFXRoutine2:
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
    lda MusicContFlags                ;If escape music is playing, use this SFX to make-->
    cmp #music_Escape               ;the bomb ticking sound, else play regular SFX.
    beq LB749                       ;
    lda #$16                        ;Number of frames to play sound before a change.
    ldy #<BugOutOFHoleSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.
LB749:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #<TimeBombTickSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine2 ;Branch always.

BulletFireSFXContinue:
    lda HasBeamSFX                  ;
    lsr                             ;If Samus has ice beam, branch.
    bcs HasIceBeamSFXContinue       ;
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_B75D                       ;If more frames to process, branch to exit.
        jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
    RTS_B75D:
    rts

HasIceBeamSFXStart:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #<IceBeamSFXData.b            ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

HasIceBeamSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB76D                       ;If more frames to process, branch.
        jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
    LB76D:
    lda SFXSQ1Data0                  ;
    and #$01                        ;Determine index for IceBeamSFXDataTbl below.
    tay                             ;
    lda IceBeamSFXDataTbl,y         ;Loads A with value from IceBeamSFXDataTbl below.
    bne LoadSQ1PeriodLow            ;

IceBeamSFXDataTbl:
    .byte $93                       ;Ice beam SFX period low data.
    .byte $81                       ;

WaveBeamSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #<WaveBeamSFXData.b           ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

WaveBeamSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB797                       ;If more frames to process, branch.
        ldy SFXSQ1Data1                 ;
        inc SFXSQ1Data1                 ;Load wave beam SFXDisable/enable envelope length-->
        lda WaveBeamSFXDisLngthTbl,y    ;data from WaveBeamSFXDisableLengthTbl.
        sta SQ1_VOL                     ;
        bne LoadSQ1PeriodLow@RTS               ;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
        jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
    LB797:
    lda SFXSQ1Data0
    and #$01                        ;
    tay                             ;Load wave beam SFX period low data from-->
    lda WaveBeamSFXPeriodLowTbl,y   ;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
    ;Change the period low data for SQ1 channel.
    sta SQ1_LO
    inc SFXSQ1Data0
@RTS:
    rts

WaveBeamSFXPeriodLowTbl:
    .byte $58                       ;Wave beam SFX period low data.
    .byte $6F                       ;

WaveBeamSFXDisLngthTbl:
    .byte $93                       ;
    .byte $91                       ;Wave beam SFX Disable/enable envelope length data.
    .byte $00                       ;

DoorOpenCloseSFXStart:
    lda DoorSFXData+2               ;#$30.
    sta SFXTriPeriodLow                ;Set triangle period low data byte.
    lda DoorSFXData+3               ;#$B2.
    and #$07                        ;Set triangle period high data byte.
    sta SFXTriPeriodHigh               ;#$B7.
    ;Change triangle channel period low every frame by #$000F.
    lda #$0F
    sta SFXTriChangeLow
    lda #$00
    sta SFXTriChangeHigh
    ;Number of frames to play sound before a change.
    lda #$1F
    ;Lower byte of sound data start address(base=$B200).
    ldy #<DoorSFXData.b
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @endIf_A
        jmp EndTriSFX
    @endIf_A:
    jsr DecreaseSFXTriPeriod     ;($B98C)Decrease periods.
    jmp WriteSFXTriPeriod        ;($B869)Save new periods.

BeepSFXStart:
    lda SFXTriContFlags                  ;If SamusDieSFX is already playing, branch-->
    and #sfxTri_SamusDie            ;without playing BeepSFX.
    bne LoadSQ1PeriodLow@RTS           ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<SamusBeepSFXData.b          ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BeepSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LoadSQ1PeriodLow@RTS               ;If more frames to process, branch to exit.
    jmp EndTriSFX              ;($B896)End SFX.

BigEnemyHitSFXStart:
    ;Increase triangle low period by #$0012 every frame.
    lda #$12
    sta SFXTriChangeLow
    lda #$00
    sta SFXTriChangeHigh
    lda BigEnemyHitSFXData+2        ;#$42.
    sta SFXTriPeriodLow                ;Save new triangle period low data.
    lda BigEnemyHitSFXData+3        ;#$18.
    and #$07                        ;#$1F.
    sta SFXTriPeriodHigh               ;Save new triangle period high data.
    lda #$0A                        ;Number of frames to play sound before a change.
    ldy #<BigEnemyHitSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @dontEnd                          ;If more frames to process, branch
        jmp EndTriSFX              ;($B896)End SFX
    @dontEnd:
    jsr IncreaseSFXTriPeriod          ;($B978)Increase periods.
    lda RandomNumber1               ;
    and #$3C                        ;
    sta SFXTriData0                  ;
    lda SFXTriPeriodLow                ;Randomly set or clear bits 2, 3, 4 and 5 in-->
    and #$C3                        ;triangle channel period low.
    ora SFXTriData0                  ;
    sta TRI_LO                      ;
    lda SFXTriPeriodHigh               ;
    ora #$40                        ;Set 4th bit in triangle channel period high.
    sta TRI_HI                      ;
    rts

SamusToBallSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #<SamusToBallSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda #$05                        ;
    sta SFXTriPeriodDivisor           ;Stores fraction difference. In this case 5 = 1/5 = 20%.
    lda SamusToBallSFXData+2        ;#$DD.
    sta SFXTriPeriodLow                ;Save new triangle period low data.
    lda SamusToBallSFXData+3        ;#$3B.
    and #$07                        ;#$02.
    sta SFXTriPeriodHigh               ;Save new triangle period high data.
    rts

SamusToBallSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    ;If more frames to process, branch.
    bne LB857
        jmp EndTriSFX
    LB857:
    ;($B9A0)reduces triangle period low by 20% each frame.
    jsr DivideSFXTriPeriod
    ;Store new values to change triangle periods.
    lda SFXTriPeriodDividedLow
    sta SFXTriChangeLow
    lda SFXTriPeriodDividedHigh
    sta SFXTriChangeHigh
    ;($B98C)Decrease periods.
    jsr DecreaseSFXTriPeriod

WriteSFXTriPeriod:
    ;Write SFXTriPeriodLow to triangle channel.
    lda SFXTriPeriodLow
    sta TRI_LO
    ;Write SFXTriPeriodHigh to triangle channel.
    lda SFXTriPeriodHigh
    ora #$08
    sta TRI_HI
    rts

BombLaunchSFXStart:
    lda #$04                        ;Number of frames to play sound before a change.
    ldy #<BombLaunch1SFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne EndTriSFX@RTS           ;If more frames to process, branch to exit.
    inc SFXTriData0                  ;
    lda SFXTriData0                  ;After four frames, load second part of SFX.
    cmp #$02                        ;
    bne LB891                       ;
    jmp EndTriSFX                   ;($B896)End SFX.
LB891:
    ldy #<BombLaunch2SFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp LoadTriChannelSFX           ;($B36C)Prepare to load triangle channel with data.

EndTriSFX:
    lda #$00                        ;
    sta TRI_LINEAR                  ;clear TriCntr0(sound off).
    sta TriUsedBySFX                    ;Allows music to use triangle channel.
    lda #$18                        ;
    sta TRI_HI                      ;Set length index to #$03.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
@RTS:
    rts                             ;Exit from for multiple routines.

MetroidHitSFXStart:
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<MetroidHitSFXData.b         ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    jmp RndTriPeriods               ;($B8C3)MetroidHit SFX has several different sounds.

MetroidHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    beq RndTriPeriods               ;
    inc SFXTriData0                  ;
    lda SFXTriData0                  ;Randomize triangle periods nine times throughout-->
    cmp #$09                        ;the course of the SFX.
    bne EndTriSFX@RTS           ;If SFX not done, branch.
    jmp EndTriSFX                   ;($B896)End SFX.

RndTriPeriods:
    ;Randomly set or reset bits 7, 4, 2 and 1 of triangle channel period low.
    lda RandomNumber1
    ora #$6C
    sta TRI_LO
    ;Randomly set or reset last bit of triangle channel period high.
    and #$01
    ora #$F8
    sta TRI_HI
    rts

SamusDieSFXStart:
    jsr InitializeSoundAddresses    ;($B404)Clear all sound addresses.
    lda #$0E                        ;Number of frames to play sound before a change.
    ldy #<SamusDieSFXData.b           ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    ;init divisor to divide by 21: multiply by 4.8%.
    lda #$15
    sta SFXTriPeriodDivisor
    ;Initial values of triangle periods.
    lda SamusDieSFXData+2
    sta SFXTriPeriodLow
    lda #$00
    sta SFXTriPeriodHigh
@RTS:
    rts

SamusDieSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB90C
        ;Decrease period by #$0020.
        lda #$20
        sta SFXTriChangeLow
        lda #$00
        sta SFXTriChangeHigh
        jsr DecreaseSFXTriPeriod
        
        inc SFXTriData0
        ;If more frames to process, branch to exit.
        lda SFXTriData0
        cmp #$06
        bne SamusDieSFXStart@RTS
        jmp EndTriSFX
    LB90C:
    ;Increase triangle SFX periods by 4.8% every frame.
    jsr DivideSFXTriPeriod
    lda SFXTriPeriodDividedLow
    sta SFXTriChangeLow
    lda SFXTriPeriodDividedHigh
    sta SFXTriChangeHigh
    jsr IncreaseSFXTriPeriod
    ;($B869)Save new periods.
    jmp WriteSFXTriPeriod

StatueRaiseSFXStart:
    lda StatueRaiseSFXData+2        ;#$11.
    sta SFXTriPeriodLow           ;Save period low data.
    lda StatueRaiseSFXData+3        ;#$09.
    and #$07
    sta SFXTriPeriodHigh          ;Store last three bits in $B284.
    ; set tri change to #$000B
    lda #$00
    sta SFXTriChangeHigh
    lda #$0B
    sta SFXTriChangeLow
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #<StatueRaiseSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
    jsr IncrementSFXFrame
    bne @endIf_A
        ;Increment SFXTriData0 every 6 frames.
        inc SFXTriData0
        ;When SFXTriData0 = #$09, end SFX.
        lda SFXTriData0
        cmp #$09
        bne @endIf_B
            jmp EndTriSFX
        @endIf_B:
        ;Save triangle change.
        lda SFXTriChangeLow
        pha
        lda SFXTriChangeHigh
        pha
        ;Increase period by #$0025.
        lda #$25
        sta SFXTriChangeLow
        lda #$00
        sta SFXTriChangeHigh
        jsr IncreaseSFXTriPeriod
        ;Restore triangle change.
        pla
        sta SFXTriChangeHigh
        pla
        sta SFXTriChangeLow
        ;($B869)Save new periods.
        jmp WriteSFXTriPeriod
    @endIf_A:
    ;Decrease period by #$000B, as initialized in StatueRaiseSFXStart
    jsr DecreaseSFXTriPeriod
    ;($B869)Save new periods.
    jmp WriteSFXTriPeriod

; decreases pitch of triangle
IncreaseSFXTriPeriod:
    clc
    ;Calculate new SFXTriPeriodLow.
    lda SFXTriPeriodLow
    adc SFXTriChangeLow
    sta SFXTriPeriodLow
    ;Calculate new SFXTriPeriodHigh.
    lda SFXTriPeriodHigh
    adc SFXTriChangeHigh
    sta SFXTriPeriodHigh
    rts

; increases pitch of triangle
DecreaseSFXTriPeriod:
    sec
    ;Calculate new SFXTriPeriodLow.
    lda SFXTriPeriodLow
    sbc SFXTriChangeLow
    sta SFXTriPeriodLow
    ;Calculate new SFXTriPeriodHigh.
    lda SFXTriPeriodHigh
    sbc SFXTriChangeHigh
    sta SFXTriPeriodHigh
    rts

;The following routine takes the triangle period values (SFXTriPeriodLow, SFXTriPeriodHigh) -->
;and divides them by SFXTriPeriodDivisor.
;The routine then stores the result in SFXTriPeriodDividedLow and SFXTriPeriodDividedHigh.
;This function is basically a software emulation of a sweep function.
DivideSFXTriPeriod:
    ;Store SFXTriPeriodLow and SFXTriPeriodHigh.
    lda SFXTriPeriodLow
    pha
    lda SFXTriPeriodHigh
    pha
    
    ;Perform division. This is similar to division on paper, but in binary.
    lda #$00
    sta SFXTriPeriodRemainder
    ; for all 16 bits in tri period
    ldx #$10
    rol SFXTriPeriodLow
    rol SFXTriPeriodHigh
    @loop:
        ; rotate highest bit of tri period into remainder lowest bit
        rol SFXTriPeriodRemainder
        ; branch if remainder is smaller than divisor
        lda SFXTriPeriodRemainder
        cmp SFXTriPeriodDivisor
        bcc @endIf_A
            ; remainder is greater or equal to divisor
            ; subtract divisor from remainder, such that it becomes smaller than divisor
            sbc SFXTriPeriodDivisor
            sta SFXTriPeriodRemainder
            ; we subtracted 1*divisor, so carry is 1
        @endIf_A:
        ; rotate carry (bit of result) into lowest bit of tri period
        rol SFXTriPeriodLow
        rol SFXTriPeriodHigh
        dex
        bne @loop
    ; save result to result variables
    lda SFXTriPeriodLow
    sta SFXTriPeriodDividedLow
    lda SFXTriPeriodHigh
    sta SFXTriPeriodDividedHigh
    
    ;Restore SFXTriPeriodLow and SFXTriPeriodHigh.
    pla
    sta SFXTriPeriodHigh
    pla
    sta SFXTriPeriodLow
    rts

;--------------------------------------[ End SFX routines ]-------------------------------------

SetVolumeAndDisableSweep:
    ;Disable sweep generator on SQ1 and SQ2.
    lda #$7F
    sta MusicSQ1Sweep
    sta MusicSQ2Sweep
    ;Store duty cycle and volume data for SQ1 and SQ2.
    stx MusicSQ1DutyEnvelope
    sty MusicSQ2DutyEnvelope
    rts

ResetVolumeIndex:
    ;If at the beginning of a new SQ1 note, set SQ1VolumeIndex = #$01.
    lda MusicSQ1FrameCount
    cmp #$01
    bne @endIf_A
        sta SQ1VolumeIndex
    @endIf_A:
    ;If at the beginning of a new SQ2 note, set SQ2VolumeIndex = #$01.
    lda MusicSQ2FrameCount
    cmp #$01
    bne @endIf_B
        sta SQ2VolumeIndex
    @endIf_B:
    rts

LoadMusicSQ1SQ2Periods:
    ;If a Multi channel data does not need to be loaded, branch to exit.
    lda LoadMusicSQ1SQ2PeriodsFlag
    beq @RTS
    ;Clear multi channel data write flag.
    lda #$00
    sta LoadMusicSQ1SQ2PeriodsFlag
    ;Loads SQ1 channel addresses $4001, $4002, $4003.
    lda MusicSQ1Sweep
    sta SQ1_SWEEP
    lda MusicSQ1PeriodLow
    sta SQ1_LO
    lda MusicSQ1PeriodHigh
    sta SQ1_HI
    ;Loads SQ2 channel addresses $4005, $4006, $4007.
    lda MusicSQ2Sweep
    sta SQ2_SWEEP
    lda MusicSQ2PeriodLow
    sta SQ2_LO
    lda MusicSQ2PeriodHigh
    sta SQ2_HI
@RTS:
    rts

LoadSQ1SQ2Channels:
    ldx #$00                        ;Load SQ1 channel data.
    jsr WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    inx                             ;Load SQ2 channel data.
    jsr WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    rts

WriteSQCntrl0:
    ;Load SQ channel volume data. If zero, branch to exit.
    lda SQ1VolumeEnvelopeIndex,x
    beq WriteSQ2_VOL@RTS
    
    sta VolumeEnvelopeIndex
    jsr LoadMusicSQ1SQ2Periods           ;($BA08)Load SQ1 and SQ2 control information.
    ;If sound channel is not currently playing sound, branch.
    lda SQ1VolumeData,x
    cmp #$10
    beq LBA99
    
    ; Store (VolumeEnvelopeIndex-1)*2 into y
    ldy #$00
    @loop:
        ;Desired entry in VolumeEnvelopePtrTable.
        dec VolumeEnvelopeIndex
        beq @exitLoop
        ;*2(2 byte address to find volume control data).
        iny
        iny
        ;Keep decrementing until desired address is found.
        bne @loop
@exitLoop:
    ;Load volume data address into VolumeEnvelopePtr
    lda VolumeEnvelopePtrTable,y
    sta VolumeEnvelopePtr
    lda VolumeEnvelopePtrTable+1,y
    sta VolumeEnvelopePtr+1
    ;Index to desired volume data.
    ldy SQ1VolumeIndex,x
    ;Load desired volume for current channel into Cntrl0Data.
    lda (VolumeEnvelopePtr),y
    sta Cntrl0Data
    
    ;If last entry in volume table is #$FF, restore-->
    ;volume to its original level after done reading Volume data.
    cmp #$FF
    beq MusicBranch05
    ;If #$F0 is last entry, turn sound off on current channel until next note.
    cmp #$F0
    beq MusicBranch06
    
    ;Remove duty cycle data For current channel and-->
    ;add this frame of volume data and store results in Cntrl0Data.
    lda MusicSQ1DutyEnvelope,x
    and #$F0
    ora Cntrl0Data
    tay
LBA7D:
    ;Increment Index to volume data.
    inc SQ1VolumeIndex,x
LBA80:
    ;If SQ1 or SQ2(depends on loop iteration) in use, branch to exit
    lda SQ1UsedBySFX,x
    bne WriteSQ2_VOL@RTS
    ;else write SQ(1 or 2)Cntrl0.
    txa
    ;If currently on SQ1, branch to write SQ1 data.
    beq WriteSQ1_VOL

;Write SQ2_VOL data.
WriteSQ2_VOL:
    sty SQ2_VOL
@RTS:
    rts

;Write SQ1_VOL data.
WriteSQ1_VOL:
    sty SQ1_VOL
    rts

MusicBranch05:
    ldy MusicSQ1DutyEnvelope,x           ;Restore original volume of sound channel.
    bne LBA80                       ;Branch always.

MusicBranch06:
    ldy #$10                        ;Disable envelope generator and set volume to 0.
    bne LBA80                       ;Branch always.

LBA99:
    ldy #$10                        ;Disable envelope generator and set volume to 0.
    bne LBA7D                       ;Branch always.

GotoCheckRepeatMusic:
    jsr CheckRepeatMusic            ;($B3F0)Resets music flags if music repeats.
    rts

GotoLoadSQ1SQ2Channels:
    jsr LoadSQ1SQ2Channels          ;($BA37)Load SQ1 and SQ2 channel data.
    rts


LoadMusicContFlagsFrameData:
    ;Reset index if at the beginning of a new note.
    jsr ResetVolumeIndex
    ;X = #$00.
    lda #$00
    tax
    ; set sound channel to first channel SQ1 (#$00, #$04, #$08 or #$0C).
    sta ThisSoundChannel
    beq LBAC2 ; branch always


LBAB0:
    ;Increment to next sound channel(1,2 or 3).
    txa
    lsr
    tax

IncrementToNextChannel:
    inx
    txa
    ;If done with four sound channels, branch to load sound channel SQ1 SQ2 data.
    cmp #$04
    beq GotoLoadSQ1SQ2Channels
    ;Add 4 to the least significant byte of the current sound channel start address.
    ;This moves to next sound channel address ranges to process.
    lda ThisSoundChannel
    clc
    adc #$04
    sta ThisSoundChannel
LBAC2:
    ;*2(two bytes for sound channel info base address).
    txa
    asl
    tax
    ;Load sound channel info base address into $E6 and $E7. ($E6=low byte, $E7=high byte).
    lda MusicSQ1Base,x
    sta MusicChannelBase
    lda MusicSQ1Base+1,x
    sta MusicChannelBase+1
    ;If no data for this sound channel, branch to find data for next sound channel.
    lda MusicSQ1Base+1,x
    beq LBAB0
    ;/2. Determine current sound channel (0,1,2 or3).
    txa
    lsr
    tax
    ;Decrement the current sound channel frame count
    dec MusicSQ1FrameCount,x
    ;If not zero, branch to check next channel, else load the next set of sound channel data.
    bne IncrementToNextChannel

LoadNextChannelIndexData:
    ldy MusicSQ1IndexIndex,x        ;Load current channel index to music data index.
    inc MusicSQ1IndexIndex,x        ;Increment current channel index to music data index.
    lda (MusicChannelBase),y
    beq GotoCheckRepeatMusic        ;Branch if music has reached the end.
    tay                             ;Transfer music data index to Y (base=$BE77) .
    cmp #$FF                        ;
    beq RepeatMusicLoop             ;At end of loop? If yes, branch.
    and #$C0                        ;
    cmp #$C0                        ;At beginning of new loop? if yes, branch.
    beq StartNewMusicLoop           ;
    jmp LoadMusicChannel            ;($BB1C)Load music data into channel.

RepeatMusicLoop:
    lda MusicSQ1RepeatCounter,x          ;If loop counter has reached zero, branch to exit.
    beq GotoLoadNextChannelIndexData                       ;
    dec MusicSQ1RepeatCounter,x          ;Decrement loop counter.
    lda MusicSQ1LoopIndex,x              ;Load loop index for proper channel and store it in-->
    sta MusicSQ1IndexIndex,x        ;music index index address.
    bne GotoLoadNextChannelIndexData                       ;Branch unless music has reached the end.

StartNewMusicLoop:
    tya                             ;
    and #$3F                        ;Remove last six bits of loop controller and save-->
    sta MusicSQ1RepeatCounter,x          ;in repeat counter addresses.  # of times to loop.
    dec MusicSQ1RepeatCounter,x          ;Decrement loop counter.
    lda MusicSQ1IndexIndex,x        ;Store location of loop start in loop index address.
    sta MusicSQ1LoopIndex,x              ;
GotoLoadNextChannelIndexData:
    jmp LoadNextChannelIndexData    ;($BADC)Load next channel index data.

GotoLoadNoiseChannelMusic:
    jmp LoadNoiseChannelMusic       ;($BBDE)Load data for noise channel music.

GotoLoadTRI_LINEAR:
    jmp LoadTRI_LINEAR          ;($BBB7)Load Cntrl0 byte of triangle channel.

LoadMusicChannel:
    tya                             ;
    and #$B0                        ;
    cmp #$B0                        ;Is data byte music note length data?  If not, branch.
    bne LBB40                       ;
    tya                             ;
    and #$0F                        ;Separate note length data.
    clc                             ;
    adc NoteLengthTblOffset         ;Find proper note lengths table for current music.
    tay                             ;
    lda NoteLengthsTbl,y           ;(Base is $BEF7)Load note length and store in-->
    sta MusicSQ1FrameCountInit,x         ;frame count init address.
    tay                             ;Y now contains note length.
    txa                             ;
    cmp #$02                        ;If loading Triangle channel data, branch.
    beq GotoLoadTRI_LINEAR

LoadSoundDataIndexIndex:
    ldy MusicSQ1IndexIndex,x        ;Load current index to sound data index.
    inc MusicSQ1IndexIndex,x        ;Increment music index index address.
    lda (MusicChannelBase),y        ;Load index to sound channel music data.
    tay 
LBB40:
    txa                             ;
    cmp #$03                        ;If loading Noise channel data, branch.
    beq GotoLoadNoiseChannelMusic
    pha                             ;Push music channel number on stack(0, 1 or 2).
    ldx ThisSoundChannel            ;
    lda MusicNotesTbl+1,y           ;(Base=$BE78)Load A with music channel period low data.
    beq LBB59                       ;If data is #$00, skip period high and low loading.
        sta MusicSQ1PeriodLow,x         ;Store period low data in proper period low address.
        lda MusicNotesTbl,y             ;(Base=$BE77)Load A with music channel period high data.
        ora #$08                        ;Ensure minimum index length of 1.
        sta MusicSQ1PeriodHigh,x        ;Store period high data in proper period high address.
    LBB59:
    tay                             ;
    pla                             ;Pull stack and restore channel number to X.
    tax                             ;
    tya                             ;
    bne PeriodInformationFound      ;If period information was present, branch.
    NoPeriodInformation:
        lda #$00                        ;Turn off channel volume since no period data present.
        sta Cntrl0Data                  ;
        txa                             ;
        cmp #$02                        ;If loading triangle channel data, branch.
        beq LBB73                       ;
        lda #$10                        ;Turn off volume and disable env. generator(SQ1,SQ2).
        sta Cntrl0Data                  ;
        bne LBB73 ;Branch always.
    PeriodInformationFound:
        lda MusicSQ1DutyEnvelope,x           ;Store channel duty cycle and volume info in $EA.
        sta Cntrl0Data                  ;
    LBB73:
    txa
    dec SQ1UsedBySFX,x                  ;
    cmp SQ1UsedBySFX,x                  ;If SQ1 or SQ2 are being used by SFX routines, branch.
    beq SQ1SQ2UsedBySFX                 ;
    inc SQ1UsedBySFX,x                  ;Restore not in use status of SQ1 or SQ2.
    ldy ThisSoundChannel            ;
    txa                             ;
    cmp #$02                        ;If loading triangle channel data, branch.
    beq LBB8C                       ;
    lda SQ1VolumeEnvelopeIndex,x            ;If $062E or $062F has volume data, skip writing-->
    bne LBB91                       ;Cntrl0Data to SQ1 or SQ2.
LBB8C:
    ;Write Cntrl0Data.
    lda Cntrl0Data
    sta SQ1_VOL,y
LBB91:
    ;Store volume data index to volume data.
    lda Cntrl0Data
    sta SQ1VolumeData,x
    ;Write data to three sound channel addresses.
    lda MusicSQ1PeriodLow,y
    sta SQ1_LO,y
    lda MusicSQ1PeriodHigh,y
    sta SQ1_HI,y
    lda MusicSQ1Sweep,x
    sta SQ1_SWEEP,y

LoadNewMusicFrameCount:
    ;Load new music frame count and store it in music frame count address.
    lda MusicSQ1FrameCountInit,x
    sta MusicSQ1FrameCount,x
    ;($BAB3)Move to next sound channel.
    jmp IncrementToNextChannel

SQ1SQ2UsedBySFX:
    inc SQ1UsedBySFX,x                  ;Restore in use status of SQ1 or SQ1.
    jmp LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

LoadTRI_LINEAR:
    lda TriCounterCntrl             ;
    and #$0F                        ;If lower bits set, branch to play shorter note.
    bne LBBD8                       ;
    lda TriCounterCntrl             ;
    and #$F0                        ;If upper bits are set, branch to play longer note.
    bne @endIf_A                       ;
        tya                             ;
        jmp AddTriLength                ;($BBCD)Calculate length to play note.
    @endIf_A:
    lda #$FF                        ;Disable length cntr(play until triangle data changes).
    bne LBBD8                       ;Branch always.

AddTriLength:
    ;Add #$FF(Effectively subtracts 1 from A).
    clc
    adc #$FF
    ;*4
    asl
    asl
    ;If result is greater than #$3C, store #$3C(highest triangle linear count allowed).
    cmp #$3C
    bcc @endIf_A
        lda #$3C
    @endIf_A:
LBBD8:
    sta MusicTriLinearCount
    jmp LoadSoundDataIndexIndex     ;($BB37)Load index to sound data index.

LoadNoiseChannelMusic:
    ;If playing any Noise SFX, branch to exit.
    lda SFXNoiseContFlags
    and #~(sfxNoise_PauseMusic | sfxNoise_SilenceMusic)
    bne @endIf_A
        ;Load noise channel with drum beat SFX starting at address B201.
        ;The possible values of Y are #$01, #$04, #$07 or #$0A.
        lda SFXData,y
        sta NOISE_VOL
        lda SFXData+1,y
        sta NOISE_LO
        lda SFXData+2,y
        sta NOISE_HI
    @endIf_A:
    jmp LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

;The following table is used by the InitializeMusic routine to find the index for loading
;addresses $062B thru $0637.  Base is $BD31.

SongHeaderOffsetTable:
    .byte SongRidleyHeader      - SongHeaders                       ;Ridley area music.
    .byte SongTourianHeader     - SongHeaders                       ;Tourian music.
    .byte SongItemRoomHeader    - SongHeaders                       ;Item room music.
    .byte SongKraidHeader       - SongHeaders                       ;Kraid area music.
    .byte SongNorfairHeader     - SongHeaders                       ;Norfair music.
    .byte SongEscapeHeader      - SongHeaders                       ;Escape music.
    .byte SongMthrBrnRoomHeader - SongHeaders                       ;Mother brain music.
    .byte SongBrinstarHeader    - SongHeaders                       ;Brinstar music.
    .byte SongFadeInHeader      - SongHeaders                       ;Fade in music.
    .byte SongPowerUpHeader     - SongHeaders                       ;Power up music.
    .byte SongEndHeader         - SongHeaders                       ;End music.
    .byte SongIntroHeader       - SongHeaders                       ;Intro music.

;The tables below contain addresses for SFX and music handling routines.
;Multi channel Init SFX and music handling routine addresses:

SFXMultiInitRoutineTbl:
    .word GotoMusic03Init                     ;Fade in music.
    .word GotoMusic01Init                     ;Power up music.
    .word GotoMusic05Init                     ;End game music.
    .word GotoMusic01Init                     ;Intro music.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word SamusHitSFXStart                     ;Samus hit init SFX.
    .word BossHitSFXStart                     ;Boss hit init SFX.
    .word IncorrectPasswordSFXStart                     ;Incorrect password init SFX.

;Multi channel continue SFX handling routine addresses:

SFXMultiContRoutineTbl:
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word CheckSFXFlag@RTS                     ;No sound.
    .word SamusHitSFXContinue                     ;Samus hit continue SFX.
    .word BossHitSFXContinue                     ;Boss hit continue SFX.
    .word IncorrectPasswordSFXContinue                     ;Incorrect password continue SFX.

;Music handling routine addresses:

MusicRoutineTbl:
    .word GotoMusic04Init                     ;Ridley area music.
    .word GotoMusic00Init                     ;Tourian music.
    .word GotoMusic00Init                     ;Item room music.
    .word GotoMusic00Init                     ;Kraid area music.
    .word GotoMusic03Init                     ;Norfair music.
    .word GotoMusic02Init                     ;Escape music.
    .word GotoMusic00Init                     ;Mother brain music.
    .word GotoMusic03Init                     ;Brinstar music.

;-----------------------------------[ Entry point for music routines ]--------------------------------

LoadMusicRepeatFlags:
    lda MusicRepeatFlags          ;Load A with temp music flags, (9th SFX cycle).
    ldx #<MusicInitPointers.b         ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne LBC42                       ;Branch always.

LoadMusicInitFlags:
    lda MusicInitFlags               ;Load A with Music flags, (10th SFX cycle).
    ldx #<MusicContPointers.b         ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jmp (SoundE2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.

ContinueMusic:                          ;11th and last SFX cycle.
    lda MusicContFlags
    beq RTS_BC76                       ;Branch to exit of no music playing.
    jmp LoadMusicContFlagsFrameData   ;($BAA5)Load info for current frame of music data.

;MusicInitIndex values correspond to the following music:
;#$00=Ridley area music, #$01=Tourian music, #$02=Item room music, #$03=Kraid area music,
;#$04=Norfair music, #$05=Escape music, #$06=Mother brain music, #$07=Brinstar music,
;#$08=Fade in music, #$09=Power up music, #$0A=End game music, #$0B=Intro music.

FindMusicInitIndex:
    ;Load MusicInitIndex with #$FF.
    lda #$FF
    sta MusicInitIndex
    ;Branch to exit if no SFX flags set for Multi SFX.
    lda CurrentSFXFlags
    beq @RTS
    @loop:
        ;Shift left until bit flag is in carry bit.
        ;Loop until SFX flag found.  Store bit-->
        ;number of music in MusicInitIndex.
        inc MusicInitIndex
        asl
        bcc @loop
@RTS:
    rts

;The following routine is used to add eight to the music index when looking for music flags
;in the MultiSFX address.
Add8:
    ;Add #$08 to MusicInitIndex.
    lda MusicInitIndex
    clc
    adc #$08
    sta MusicInitIndex
    rts

;This code does not appear to be used in this page.
    lda MusicContFlags
    ora #$F0
    sta MusicContFlags
RTS_BC76:
    rts

GotoMusic00Init:
    jmp Music00Init                 ;($BCAA)Initialize music 00.

GotoMusic01Init:
    jmp Music01Init                 ;($BCA4)Initialize music 01.

GotoMusic02Init:
    jmp Music02Init                 ;($BC9A)Initialize music 02.

GotoMusic03Init:
    jmp Music03Init                 ;($BC96)Initialize music 03.

GotoMusic04Init:
    jmp Music04Init                 ;($BC89)Initialize music 04.

GotoMusic05Init:
    jmp Music05Init                 ;($BC9E)Initialize music 05.

Music04Init:
    lda #$B3                        ;Duty cycle and volume data for SQ1 and SQ2.

XYMusicInit:
    tax                             ;Duty cycle and volume data for SQ1.
    tay                             ;Duty cycle and volume data for SQ2.

LBC8D:
    jsr SetVolumeAndDisableSweep    ;($B9E4)Set duty cycle and volume data for SQ1 and SQ2.
    jsr InitializeMusic             ;($BF19)Setup music registers.
    jmp LoadMusicContFlagsFrameData   ;($BAA5)Load info for current frame of music data.

Music03Init:
    lda #$34                        ;Duty cycle and volume data for SQ1 and SQ2.
    bne XYMusicInit                 ;Branch always

Music02Init:
    lda #$F4                        ;Duty cycle and volume data for SQ1 and SQ2.
    bne XYMusicInit                 ;Branch always

Music05Init:
    ldx #$F5                        ;Duty cycle and volume data for SQ1.
    ldy #$F6                        ;Duty cycle and volume data for SQ2.
    bne LBC8D                       ;Branch always

Music01Init:
    ldx #$B6                        ;Duty cycle and volume data for SQ1.
    ldy #$F6                        ;Duty cycle and volume data for SQ2.
    bne LBC8D                       ;Branch always

Music00Init:
    ldx #$92                        ;Duty cycle and volume data for SQ1.
    ldy #$96                        ;Duty cycle and volume data for SQ2.
    bne LBC8D                       ;Branch always

;The following address table provides starting addresses of the volume data tables below:
VolumeEnvelopePtrTable:
    .word VolumeEnvelope1, VolumeEnvelope2, VolumeEnvelope3, VolumeEnvelope4, VolumeEnvelope5

VolumeEnvelope1:
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $01, $02, $02, $03, $03, $04, $05, $06, $07, $08, $FF
.elif BUILDTARGET == "NES_PAL"
    .byte $01, $02, $03, $04, $04, $05, $06, $06, $07, $08, $FF
.endif

VolumeEnvelope2:
    .byte $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF

VolumeEnvelope3:
    .byte $00, $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF

VolumeEnvelope4:
    .byte $02, $06, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $04, $04, $04, $03
    .byte $03, $03, $03, $02, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02
    .byte $02, $02, $02, $01, $01, $01, $01, $01, $F0

VolumeEnvelope5:
    .byte $0A, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $07, $07, $06, $05, $04, $04
    .byte $03, $02, $02, $02, $05, $05, $05, $04, $03, $02, $02, $02, $01, $01, $04, $04
    .byte $03, $02, $01, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $F0

;The init music table loads addresses $062B thru $0637 with the initial data needed to play the
;selected music.  The data for each entry in the table have the following format:
;.byte $xx, $xx, $xx, $xx, $xx : .word $xxxx, $xxxx, $xxxx, $xxxx.
;The first five bytes have the following functions:
;Byte 0=index to proper note length table.  Will be either #$00, #$0B or #$17.
;Byte 1=Repeat music byte. #$00=no repeat, any other value and the music repeats.
;Byte 2=Controls length counter for triangle channel.
;Byte 3=Volume control byte for SQ1.
;Byte 4=Volume control byte for SQ2.
;Address 0=Base address of SQ1 music data.
;Address 1=Base address of SQ2 music data.
;Address 2=Base address of triangle music data.
;Address 3=Base address of noise music data.

SongHeaders:

SongMthrBrnRoomHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $F5, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F5, $00, $00
    .endif
    
    .if BANK == 3
        .word SongMthrBrnRoomSQ1, SongMthrBrnRoomSQ2, SongMthrBrnRoomTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongEscapeHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $00, $02, $02
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $00, $02, $02
    .endif
    
    .if BANK == 3
        .word SongEscapeSQ1, SongEscapeSQ2, SongEscapeTri, SongEscapeNoise
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongNorfairHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $F0, $04, $04
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F0, $04, $04
    .endif
    
    .if BANK == 2
        .word SongNorfairSQ1, SongNorfairSQ2, SongNorfairTri, SongNorfairNoise
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongKraidHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@4, $FF, $F0, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@4, $FF, $F0, $00, $00
    .endif
    
    .if BANK == 4 || BANK == 5
        .word SongKraidSQ1, SongKraidSQ2, SongKraidTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongItemRoomHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $03, $00, $00
    .endif
    
    .if BANK <= 5
        .word SongItemRoomSQ1, SongItemRoomSQ2, SongItemRoomTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongRidleyHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $F0, $01, $01
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F0, $01, $01
    .endif
    
    .if BANK == 4 || BANK == 5
        .word SongRidleySQ1, SongRidleySQ2, SongRidleyTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongEndHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@7, $00, $00, $02, $01
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@6, $00, $00, $02, $01
    .endif
    
    .if BANK == 0
        .word SongEndSQ1, SongEndSQ2, SongEndTri, SongEndNoise
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongIntroHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@7, $00, $F0, $02, $05
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@6, $00, $F0, $02, $05
    .endif
    
    .if BANK == 0
        .word SongIntroSQ1, SongIntroSQ2, SongIntroTri, SongIntroNoise
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif

SongFadeInHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $00, $F0, $02, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $00, $F0, $02, $00
    .endif
    
    .if BANK <= 5
        .word SongFadeInSQ1, SongFadeInSQ2, SongFadeInTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongPowerUpHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@4, $00, $F0, $01, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@3, $00, $F0, $01, $00
    .endif
    
    .if BANK <= 5
        .word SongPowerUpSQ1, SongPowerUpSQ2, SongPowerUpTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif

SongBrinstarHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $00, $02, $03
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $00, $02, $03
    .endif
    
    .if BANK == 1
        .word SongBrinstarSQ1, SongBrinstarSQ2, SongBrinstarTri, SongBrinstarNoise
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongTourianHeader:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $03, $00, $00
    .endif
    
    .if BANK <= 5
        .word SongTourianSQ1, SongTourianSQ2, SongTourianTri, $0000
    .elif BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/item_room.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/item_room.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/power_up.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/power_up.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/fade_in.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/fade_in.asm"
.endif

.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .include "songs/ntsc/tourian.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/tourian.asm"
.endif

;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)
;Note that on PAL consoles, the CPU clock speed is a bit slower, which affects the pitch.
;The formula for PAL is 1663000/16/(hhhllllllll + 1), so all notes play roughly a semitone flat (-128 cents).
MusicNotesTbl:
    .byte $07,$F0                       ;55.0Hz (A1)    Index #$00 (Not used)
    .byte $00,$00                       ;No sound       Index #$02
    .byte $06,$4E                       ;69.3Hz (C#2)   Index #$04
    .byte $05,$F3                       ;73.4Hz (D2)    Index #$06
    .byte $05,$4D                       ;82.4Hz (E2)    Index #$08
    .byte $05,$01                       ;87.3Hz (F2)    Index #$0A
    .byte $04,$B9                       ;92.5Hz (F#2)   Index #$0C
    .byte $04,$75                       ;98.0Hz (G2)    Index #$0E
    .byte $04,$35                       ;103.8Hz (Ab2)  Index #$10
    .byte $03,$F8                       ;110.0Hz (A2)   Index #$12
    .byte $03,$BF                       ;116.5Hz (A#2)  Index #$14
    .byte $03,$89                       ;123.5Hz (B2)   Index #$16
    .byte $03,$57                       ;130.7Hz (C3)   Index #$18
    .byte $03,$27                       ;138.5Hz (C#3)  Index #$1A
    .byte $02,$F9                       ;146.8Hz (D3)   Index #$1C
    .byte $02,$CF                       ;155.4Hz (D#3)  Index #$1E
    .byte $02,$A6                       ;164.8Hz (E3)   Index #$20
    .byte $02,$80                       ;174.5Hz (F3)   Index #$22
    .byte $02,$5C                       ;184.9Hz (F#3)  Index #$24
    .byte $02,$3A                       ;196.0Hz (G3)   Index #$26
    .byte $02,$1A                       ;207.6Hz (Ab3)  Index #$28
    .byte $01,$FC                       ;219.8Hz (A3)   Index #$2A
    .byte $01,$DF                       ;233.1Hz (A#3)  Index #$2C
    .byte $01,$C4                       ;247.0Hz (B3)   Index #$2E
    .byte $01,$AB                       ;261.4Hz (C4)   Index #$30
    .byte $01,$93                       ;276.9Hz (C#4)  Index #$32
    .byte $01,$7C                       ;293.6Hz (D4)   Index #$34
    .byte $01,$67                       ;310.8Hz (D#4)  Index #$36
    .byte $01,$52                       ;330.0Hz (E4)   Index #$38
    .byte $01,$3F                       ;349.6Hz (F4)   Index #$3A
    .byte $01,$2D                       ;370.4Hz (F#4)  Index #$3C
    .byte $01,$1C                       ;392.5Hz (G4)   Index #$3E
    .byte $01,$0C                       ;415.9Hz (Ab4)  Index #$40
    .byte $00,$FD                       ;440.4Hz (A4)   Index #$42
    .byte $00,$EE                       ;468.1Hz (A#4)  Index #$44
    .byte $00,$E1                       ;495.0Hz (B4)   Index #$46
    .byte $00,$D4                       ;525.2Hz (C5)   Index #$48
    .byte $00,$C8                       ;556.6Hz (C#5)  Index #$4A
    .byte $00,$BD                       ;588.8Hz (D5)   Index #$4C
    .byte $00,$B2                       ;625.0Hz (D#5)  Index #$4E
    .byte $00,$A8                       ;662.0Hz (E5)   Index #$50
    .byte $00,$9F                       ;699.2Hz (F5)   Index #$52
    .byte $00,$96                       ;740.9Hz (F#5)  Index #$54
    .byte $00,$8D                       ;787.9Hz (G5)   Index #$56
    .byte $00,$85                       ;834.9Hz (Ab5)  Index #$58
    .byte $00,$7E                       ;880.9HZ (A5)   Index #$5A
    .byte $00,$76                       ;940.1Hz (A#5)  Index #$5C
    .byte $00,$70                       ;990.0Hz (B5)   Index #$5E
    .byte $00,$69                       ;1055Hz (C6)    Index #$60
    .byte $00,$63                       ;1118Hz (C#6)   Index #$62
    .byte $00,$5E                       ;1178Hz (D6)    Index #$64
    .byte $00,$58                       ;1257Hz (D#6)   Index #$66
    .byte $00,$53                       ;1332Hz (E6)    Index #$68
    .byte $00,$4F                       ;1398Hz (F6)    Index #$6A
    .byte $00,$4A                       ;1492Hz (F#6)   Index #$6C
    .byte $00,$46                       ;1576Hz (G6)    Index #$6E
    .byte $00,$42                       ;1670Hz (Ab6)   Index #$70
    .byte $00,$3E                       ;1776Hz (A6)    Index #$72
    .byte $00,$3A                       ;1896Hz (A#6)   Index #$74
    .byte $00,$37                       ;1998Hz (B6)    Index #$76
    .byte $00,$34                       ;2111Hz (C7)    Index #$78
    .byte $00,$31                       ;2238Hz (C#7)   Index #$7A
    .byte $00,$2E                       ;2380Hz (D7)    Index #$7C
    .byte $00,$27                       ;2796Hz (F7)    Index #$7E

;The following tables are used to load the music frame count addresses ($0640 thru $0643). The
;larger the number, the longer the music will play a solid note.  The number represents how
;many frames the note will play.  There is a small discrepancy in time length because the
;Nintendo runs at 60 frames pers second and I am using 64 frames per second to make the
;numbers below divide more evenly.

NoteLengthsTbl:
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    ;Used by power up music and Kraid area music.
    @4:
        .byte $04                       ;About    1/16 seconds ($B0)
        .byte $08                       ;About    1/8  seconds ($B1)
        .byte $10                       ;About    1/4  seconds ($B2)
        .byte $20                       ;About    1/2  seconds ($B3)
        .byte $40                       ;About 1       seconds ($B4)
        .byte $18                       ;About    3/8  seconds ($B5)
        .byte $30                       ;About    3/4  seconds ($B6)
        .byte $0C                       ;About    3/16 seconds ($B7)
        .byte $0B                       ;About   11/64 seconds ($B8)
        .byte $05                       ;About    5/64 seconds ($B9)
        .byte $02                       ;About    1/32 seconds ($BA)

    ;Used by item room, fade in, Brinstar music, Ridley area music, Mother brain music,
    ;escape music, Norfair music and Tourian music.
    @6:
        .byte $06                       ;About    3/32 seconds ($B0)
        .byte $0C                       ;About    3/16 seconds ($B1)
        .byte $18                       ;About    3/8  seconds ($B2)
        .byte $30                       ;About    3/4  seconds ($B3)
        .byte $60                       ;About 1  1/2  seconds ($B4)
        .byte $24                       ;About    9/16 seconds ($B5)
        .byte $48                       ;About 1  3/16 seconds ($B6)
        .byte $12                       ;About    9/32 seconds ($B7)
        .byte $10                       ;About    1/4  seconds ($B8)
        .byte $08                       ;About    1/8  seconds ($B9)
        .byte $03                       ;About    3/64 seconds ($BA)
        .byte $10                       ;About    1/4  seconds ($BB)

    ;Used by intro and end game music.
    @7:
        .byte $07                       ;About    7/64 seconds ($B0)
        .byte $0E                       ;About    7/32 seconds ($B1)
        .byte $1C                       ;About    7/16 seconds ($B2)
        .byte $38                       ;About    7/8  seconds ($B3)
        .byte $70                       ;About 1 13/16 seconds ($B4)
        .byte $2A                       ;About   21/32 seconds ($B5)
        .byte $54                       ;About 1  5/16 seconds ($B6)
        .byte $15                       ;About   21/64 seconds ($B7)
        .byte $12                       ;About    9/32 seconds ($B8)
        .byte $02                       ;About    1/32 seconds ($B9)
        .byte $03                       ;About    3/64 seconds ($BA)
.elif BUILDTARGET == "NES_PAL"
    @3:
        .byte $03
        .byte $06
        .byte $0C
        .byte $18
        .byte $30
        .byte $12
        .byte $24
        .byte $09
        .byte $08
        .byte $04
        .byte $02
        .byte $01
    
    @4:
        .byte $04
        .byte $08
        .byte $10
        .byte $20
        .byte $40
        .byte $18
        .byte $30
        .byte $0C
        .byte $0B
        .byte $05
        .byte $02
        .byte $01
    
    @5:
        .byte $05
        .byte $0A
        .byte $14
        .byte $28
        .byte $50
        .byte $1E
        .byte $3C
        .byte $0F
        .byte $0C
        .byte $06
        .byte $03
        .byte $02
    
    @6:
        .byte $06
        .byte $0C
        .byte $18
        .byte $30
        .byte $60
        .byte $24
        .byte $48
        .byte $12
        .byte $10
        .byte $08
        .byte $03
        .byte $10
    
    @7:
        .byte $07
        .byte $0E
        .byte $1C
        .byte $38
        .byte $70
        .byte $2A
        .byte $54
        .byte $15
        .byte $12
        .byte $02
        .byte $03
.endif


InitializeMusic:
    ;Check to see if restarting current music.
    jsr CheckMusicFlags
    
    ;Load current SFX flags and store MusicContFlags address.
    lda CurrentSFXFlags
    sta MusicContFlags
    
    ;Find index for music in SongHeaderOffsetTable.
    lda MusicInitIndex
    tay
    lda SongHeaderOffsetTable,y
    tay
    ldx #$00
    
    ;The following loop repeats 13 times to load the initial music addresses -->
    ;(registers $062B thru $0637).
    @loop:
        lda SongHeaders,y
        sta NoteLengthTblOffset,x
        iny
        inx
        txa
        cmp #$0D
        bne @loop
    
    ;Resets addresses $0640 thru $0643 to #$01.-->
    ;These addresses are used for counting the number of frames music channels have been playing.
    lda #$01
    sta MusicSQ1FrameCount
    sta MusicSQ2FrameCount
    sta MusicTriFrameCount
    sta MusicNoiseFrameCount
    
    ;Resets addresses $0638 thru $063B to #$00.-->
    ;These are the index to find sound channel data index.
    lda #$00
    sta MusicSQ1IndexIndex
    sta MusicSQ2IndexIndex
    sta MusicTriIndexIndex
    sta MusicNoiseIndexIndex
    rts

;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP" || BUILDTARGET == "NES_CNSUS"
    .byte $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $2C, $B4, $AD
    .byte $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9, $2A, $BC, $A8, $A2, $00, $B9
    .byte $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40
    .byte $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D
    .byte $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $99, $90, $04, $E5, $99, $85, $9A, $26, $97, $26, $98, $CA, $D0, $ED, $60, $01
    .byte $02
.endif

