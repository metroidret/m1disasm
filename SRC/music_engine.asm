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
SamusHitSQ1SQ2SFXData:
    .byte $C1, $89, $02, $0F
BossHitSQ2SFXData:
    .byte $34, $BA, $E0, $05
BossHitSQ1SFXData:
    .byte $34, $BB, $CE, $05
IncorrectPasswordSQ1SFXData:
    .byte $B6, $7F, $00, $C2
IncorrectPasswordSQ2SFXData:
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

NoiseSFXInitPointers:
    .word NoiseSFXInitRoutineTbl, LoadNoiseSFXContFlags              ;Noise init SFX         (1st).
    .byte $00

NoiseSFXContPointers:
    .word NoiseSFXContRoutineTbl, RTS_B4EE              ;Noise continue SFX     (2nd).
    .byte $00

SQ1SFXInitPointers:
    .word SQ1SFXInitRoutineTbl, LoadSQ1SFXContFlags              ;SQ1 init SFX           (5th).
    .byte $01

SQ1SFXContPointers:
    .word SQ1SFXContRoutineTbl, RTS_B4EE              ;SQ2 continue SFX       (6th).
    .byte $01

TriSFXInitPointers:
    .word TriSFXInitRoutineTbl, LoadTriSFXContFlags              ;Triangle init SFX      (7th).
    .byte $03

TriSFXContPointers:
    .word TriSFXContRoutineTbl, RTS_B4EE              ;Triangle continue SFX  (8th).
    .byte $03

MultiSFXInitPointers:
    .word MultiSFXInitRoutineTbl, LoadMultiSFXContFlags              ;Multi init SFX         (3rd).
    .byte $04

MultiSFXContPointers:
    .word MultiSFXContRoutineTbl, GotoLoadSQ1SFXInitFlags              ;Multi continue SFX     (4th).
    .byte $04

MusicContPointers:
    .word MusicRoutineTbl, ContinueMusic              ;temp flag Music        (10th).
    .byte $00

MusicInitPointers:
    .word MusicRoutineTbl, LoadMusicInitFlags              ;Music                  (9th).
    .byte $00

;The tables below contain addresses for SFX handling routines.

;Noise Init SFX handling routine addresses:
NoiseSFXInitRoutineTbl:
    .word RTS_B4EE                     ;No sound.
    .word ScrewAttackSFXStart                     ;Screw attack init SFX.
    .word MissileLaunchSFXStart                     ;Missile launch init SFX.
    .word BombExplodeSFXStart                     ;Bomb explode init SFX.
    .word SamusWalkSFXStart                     ;Samus walk init SFX.
    .word SpitFlameSFXStart                     ;Spit flame init SFX.
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.

;Noise Continue SFX handling routine addresses:
NoiseSFXContRoutineTbl:
    .word RTS_B4EE                     ;No sound.
    .word ScrewAttackSFXContinue                     ;Screw attack continue SFX.
    .word MissileLaunchSFXContinue                     ;Missile launch continue SFX.
    .word NoiseSFXContinue                     ;Bomb explode continue SFX.
    .word NoiseSFXContinue                     ;Samus walk continue SFX.
    .word SpitFlameSFXContinue                     ;Spit flame continue SFX.
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.

;SQ1 Init SFX handling routine addresses:
SQ1SFXInitRoutineTbl:
    .word MissilePickupSFXStart                     ;Missile pickup init SFX.
    .word EnergyPickupSFXStart                     ;Energy pickup init SFX.
    .word MetalSFXStart                     ;Metal init SFX.
    .word BulletFireSFXStart                     ;Bullet fire init SFX.
    .word BirdOutOfHoleSFXStart                     ;Bird out of hole init SFX.
    .word EnemyHitSFXStart                     ;Enemy hit init SFX.
    .word SamusJumpSFXStart                     ;Samus jump init SFX.
    .word WaveBeamSFXStart                     ;Wave beam init SFX.

;SQ1 Continue SFX handling routine addresses:
SQ1SFXContRoutineTbl:
    .word MissilePickupSFXContinue                     ;Missile pickup continue SFX.
    .word EnergyPickupSFXContinue                     ;Energy pickup continue SFX.
    .word SQ1SFXContinue                     ;Metal continue SFX.
    .word BulletFireSFXContinue                     ;Bullet fire continue SFX.
    .word SQ1SFXContinue                     ;Bird out of hole continue SFX.
    .word SQ1SFXContinue                     ;Enemy hit continue SFX.
    .word SQ1SFXContinue                     ;Samus jump continue SFX.
    .word WaveBeamSFXContinue                     ;Wave beam continue SFX.

;Triangle init handling routine addresses:
TriSFXInitRoutineTbl:
    .word SamusDieSFXStart                     ;Samus die init SFX.
    .word DoorOpenCloseSFXStart                     ;Door open close init SFX.
    .word MetroidHitSFXStart                     ;Metroid hit init SFX.
    .word StatueRaiseSFXStart                     ;Statue raise init SFX.
    .word BeepSFXStart                     ;Beep init SFX.
    .word BigEnemyHitSFXStart                     ;Big enemy hit init SFX.
    .word SamusToBallSFXStart                     ;Samus to ball init SFX.
    .word BombLaunchSFXStart                     ;Bomb launch init SFX.

;Triangle continue handling routine addresses:
TriSFXContRoutineTbl:
    .word SamusDieSFXContinue                     ;Samus die continue SFX.
    .word DoorOpenCloseSFXContinue                     ;Door open close continue SFX.
    .word MetroidHitSFXContinue                     ;Metroid hit continue SFX.
    .word StatueRaiseSFXContinue                     ;Statue raise continue SFX.
    .word BeepSFXContinue                     ;Beep continue SFX.
    .word BigEnemyHitSFXContinue                     ;Big enemy hit continue SFX.
    .word SamusToBallSFXContinue                     ;Samus to ball continue SFX.
    .word BombLaunchSFXContinue                     ;Bomb launch continue SFX.

LoadNoiseSFXInitFlags:
    lda NoiseSFXFlag                ;Load A with Noise init SFX flags, (1st SFX cycle).
    ldx #<NoiseSFXInitPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadNoiseSFXContFlags:
    lda NoiseContSFX                ;Load A with Noise continue flags, (2nd SFX cycle).
    ldx #<NoiseSFXContPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXInitFlags:
    lda SQ1SFXFlag                  ;Load A with SQ1 init flags, (5th SFX cycle).
    ldx #<SQ1SFXInitPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXContFlags:
    lda SQ1ContSFX                  ;Load A with SQ1 continue flags, (6th SFX cycle).
    ldx #<SQ1SFXContPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

GotoSFXCheckFlags:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX flags set.
    jmp (SoundE2)                     ;if no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling routine.

LoadTriSFXInitFlags:
    lda TriSFXFlag                  ;Load A with Triangle init flags, (7th SFX cycle).
    ldx #<TriSFXInitPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadTriSFXContFlags:
    lda TriContSFX                  ;Load A with Triangle continue flags, (8th SFX cycle).
    ldx #<TriSFXContPointers.b        ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadMultiSFXInitFlags:
    lda MultiSFXFlag                ;Load A with Multi init flags, (3rd SFX cycle).
    ldx #<MultiSFXInitPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jsr Add8                        ;($BC64)Add 8 to MusicInitIndex.
    jmp (SoundE2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.
LoadMultiSFXContFlags:
    lda MultiContSFX                ;Load A with $68C flags (4th SFX cycle).
    ldx #<MultiSFXContPointers.b      ;Lower address byte in ChooseNextSFXRoutineTbl.
    jmp GotoSFXCheckFlags           ;($B337)Checks to see if SFX or music flags set.

GotoLoadSQ1SFXInitFlags:
    jsr LoadSQ1SFXInitFlags         ;($B329)Check for SQ1 init flags.
    rts

LoadSQ1ChannelSFX:                      ;Used to determine which sound registers to change-->
    lda #$00                        ;($4000 - $4003) - SQ1.
    beq LoadSFXData                       ;Branch always.

LoadTriChannelSFX:                 ;Used to determine which sound registers to change-->
    lda #$08                        ;($4008 - $400B) - Triangle.
    bne LoadSFXData                       ;Branch always.

LoadNoiseChannelSFX:                    ;Used to determine which sound registers to change-->
    lda #$0C                        ;($400C - $400F) - Noise.
    bne LoadSFXData                       ;Branch always.

LoadSQ2ChannelSFX:                      ;Used to determine which sound registers to change-->
    lda #$04                        ;($4004 - $4007) - SQ2.
    ; fallthrough

LoadSFXData:
    sta SoundE0                     ;Lower address byte of desired APU control register.
    lda #$40                        ;
    sta SoundE0+1.b                   ;Upper address byte of desired APU control register.
    sty SoundE2                     ;Lower address byte of data to load into sound channel.
    lda #>SFXData.b                   ;
    sta SoundE2+1.b                   ;Upper address byte of data to load into sound channel.
    ldy #$00                        ;Starting index for loading four byte sound data.

LoadSFXRegisters:
    lda (SoundE2),y                 ;Load A with SFX data byte.
    sta (SoundE0),y                 ;Store A in SFX register.
    iny                             ;
    tya                             ;The four registers associated with each sound-->
    cmp #$04                        ;channel are loaded one after the other (the loop-->
    bne LoadSFXRegisters            ;repeats four times).
    rts

PauseSFX:
    inc SFXPaused                   ;SFXPaused=#$01
    jsr ClearSounds                 ;($B43E)Clear sound registers of data.
    sta PauseSFXStatus              ;PauseSFXStatus=#$00
    rts

LB399:
    lda SFXPaused                   ;Has SFXPaused been set? if not, branch
    beq PauseSFX                    ;
    lda PauseSFXStatus              ;For the first #$12 frames after the game has been-->
    cmp #$12                        ;paused, play GamePaused SFX.  If paused for #$12-->
    beq RTS_B3B3                       ;frames or more, branch to exit.
    and #$03                        ;
    cmp #$03                        ;Every fourth frame, repeat GamePaused SFX
    bne LB3B0                       ;
        ldy #<GamePausedSFXData.b         ;Lower address byte of GamePaused SFX data(Base=$B200)
        jsr LoadSQ1ChannelSFX           ;($B368) Load GamePaused SFX data.
    LB3B0:
    inc PauseSFXStatus
RTS_B3B3:
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
    lda #APU_5STEP | APU_IRQDISABLE.b
    sta JOY2
    ;is bit zero is set in NoiseSFXFlag(Silence music)?  If yes, branch.
    lda NoiseSFXFlag
    lsr
    bcs LB3EB
    ;Is game paused?  If yes, branch.
    lda MainRoutine
    cmp #$05
    beq LB399
    ;Clear SFXPaused when game is running.
    lda #$00
    sta SFXPaused
    jsr LoadNoiseSFXInitFlags       ;($B31B)Check noise SFX flags.
    jsr LoadMultiSFXInitFlags       ;($B34B)Check multichannel SFX flags.
    jsr LoadTriSFXInitFlags         ;($B33D)Check triangle SFX flags.
    jsr LoadMusicTempFlags          ;($BC36)Check music flags.
    ; fallthrough

;Clear all SFX flags.
ClearSFXFlags:
    lda #$00
    sta NoiseSFXFlag
    sta SQ1SFXFlag
    sta SQ2SFXFlag
    sta TriSFXFlag
    sta MultiSFXFlag
    sta MusicInitFlag
    rts

LB3EB:
    jsr InitializeSoundAddresses    ;($B404)Prepare to start playing music.
    beq ClearSFXFlags               ;Branch always.

CheckRepeatMusic:
    ;If music is supposed to repeat, reset music flags else branch to exit.
    lda MusicRepeat
    beq InitializeSoundAddresses
    lda CurrentMusic
    sta CurrentMusicRepeat
    rts

CheckMusicFlags: ;($B3FC)
    lda CurrentMusic                ;Loads A with current music flags and compares it-->
    cmp CurrentSFXFlags             ;with current SFX flags.  If both are equal,-->
    beq GotoClearSpecialAddresses   ;just clear music counters, else clear everything.

InitializeSoundAddresses:
    ;Jumps to all subroutines needed to reset all sound addresses in order to start playing music.
    jsr ClearMusicAndSFXAddresses
    jsr ClearSounds
GotoClearSpecialAddresses:
    jsr ClearSpecialAddresses
    rts

;Clears addresses used for repeating music, pausing music and controlling triangle length.
ClearSpecialAddresses: ;($B40E)
    lda #$00
    sta TriCounterCntrl
    sta SFXPaused
    sta CurrentMusicRepeat
    sta MusicRepeat
    rts

;Clears any SFX or music currently being played.
ClearMusicAndSFXAddresses: ;($B41D)
    lda #$00
    sta SQ1InUse
    sta SQ2InUse
    sta TriInUse
    sta WriteMultiChannelData
    sta NoiseContSFX
    sta SQ1ContSFX
    sta SQ2ContSFX
    sta TriContSFX
    sta MultiContSFX
    sta CurrentMusic
    rts

;Clears all sounds that might be in the sound channel registers.
ClearSounds: ;($B43E)
    lda #$10
    sta SQ1_VOL
    sta SQ2_VOL
    sta NOISE_VOL
    lda #$00
    sta TRI_LINEAR
    sta DMC_RAW
    rts

SelectSFXRoutine:
    ldx ChannelType                 ;
    sta NoiseSFXLength,x            ;Stores frame length of SFX in corresponding address.
    txa                             ;
    beq SelectSFXRoutine_Noise      ;Branch if SFX uses noise channel.
    cmp #$01                        ;
    beq SelectSFXRoutine_SQ1        ;Branch if SFX uses SQ1 channel.
    cmp #$02                        ;
    beq SelectSFXRoutine_SQ2        ;Branch if SFX uses SQ2 channel.
    cmp #$03                        ;
    beq SelectSFXRoutine_Tri        ;Branch if SFX uses triangle wave.
    rts                             ;Exit if SFX routine uses no channels.

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
    sta NoiseInUse,x
    ;Clears all the following addresses before going to the proper SFX handling routine.
    lda #$00
    sta ThisNoiseFrame,x
    sta NoiseSFXData,x
    sta MultiSFXData,x
    sta ScrewAttackSFXData,x
    sta WriteMultiChannelData
    rts

UpdateContFlags: ;($B493)
    ;Loads X register with sound channel just changed.
    ldx ChannelType
    ;Clear existing continuation SFX flags for that channel.
    lda NoiseContSFX,x
    and #$00 ; was this value non-zero at some point in development?
    ;Load new continuation flags.
    ora CurrentSFXFlags
    ;Save results.
    sta NoiseContSFX,x
    rts

ClearCurrentSFXFlags:
    ;Once SFX has completed, this block clears the SFX flag from the current flag register.
    lda #$00
    sta CurrentSFXFlags
    beq UpdateContFlags

IncrementSFXFrame:
    ;Load SFX channel number.
    ldx ChannelType
    ;Increment and load current frame to play on given channel.
    inc ThisNoiseFrame,x
    lda ThisNoiseFrame,x
    ;Check to see if current frame is last frame to play.
    cmp NoiseSFXLength,x
    bne RTS_B4BC
        ;If current frame is last frame, reset current frame to 0.
        lda #$00
        sta ThisNoiseFrame,x
    RTS_B4BC:
    rts


CheckSFXFlag:
    ;Store any set flags in $064D.
    sta CurrentSFXFlags
    ;Prepare pointer to SFX data
    stx SoundE4
    ldy #>NoiseSFXInitPointers.b
    sty SoundE4+1.b
    ;Y=0 for counting loop ahead.
    ldy #$00
    LB4C8:
        ;Loads either SFXInitPointers or SFXContPointers into $E0-$E3
        lda (SoundE4),y
        sta SoundE0,y
        iny
        tya
        ;Loop repeats four times to load the values.
        cmp #$04
        bne LB4C8
    lda (SoundE4),y
    sta ChannelType                 ;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
    ;Set y to 0 for counting loop ahead.
    ldy #$00
    ;Push current SFX flags on stack.
    lda CurrentSFXFlags
    pha
    LB4DE:
        ;This portion of the routine loops a maximum of eight times looking for
        ;any SFX flags that have been set in the current SFX cycle.
        asl CurrentSFXFlags
        ;If a flag is found, Branch to SFXFlagFound for further processing
        bcs SFXFlagFound
        ;no flags are set, continue to next SFX cycle.
        iny
        iny
        tya
        cmp #$10
        bne LB4DE

;Restore original data in CurrentSFXFlags.
RestoreSFXFlags:
    pla
    sta CurrentSFXFlags
RTS_B4EE:
    rts

SFXFlagFound:
    lda (SoundE0),y                 ;This routine stores the starting address of the-->
    sta SoundE2                     ;specific SFX handling routine for the SFX flag-->
    iny                             ;found.  The address is stored in registers-->
    lda (SoundE0),y                 ;$E2 and $E3.
    sta SoundE2+1.b                   ;
    jmp RestoreSFXFlags             ;($B4EA)Restore original data in CurrentSFXFlags.

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
    bne LB51E                       ;If more frames to process, branch.
        jmp EndNoiseSFX                 ;($B58F)End SFX.
    LB51E:
    ldy NoiseSFXData                ;
    lda SpitFlamesTbl,y             ;Load data from table above and store in NOISE_VOL.
    sta NOISE_VOL                   ;
    inc NoiseSFXData                ;Increment to next entry in data table.
    rts

ScrewAttackSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #<ScrewAttSFXData.b           ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda ScrewAttSFXData+2                       ;#$00.
    sta NoiseSFXData                ;Clear NoiseSFXData.
RTS_B538:
    rts

ScrewAttackSFXContinue:
    lda ScrewAttackSFXData          ;Prevents period index from being incremented until-->
    cmp #$02                        ;after the tenth frame of the SFX.
    beq LB549                       ;Branch if not ready to increment.
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_B538                    ;
    inc ScrewAttackSFXData          ;Increment every fifth frame.
    rts

LB549:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne IncrementPeriodIndex        ;Start increasing period index after first ten frames.
    dec NoiseSFXData                ;
    dec NoiseSFXData                ;Decrement NoiseSFXData by three every fifth frame.
    dec NoiseSFXData                ;
    inc MultiSFXData                ;Increment MultiSFXData.  When it is equal to #$0F-->
    lda MultiSFXData                ;end screw attack SFX.  MultiSFXData does not-->
    cmp #$0F                        ;appear to be linked to multi SFX channels in-->
    bne RTS_B538                    ;this routine.
    jmp EndNoiseSFX                 ;($B58F)End SFX.

IncrementPeriodIndex:
    ;Incrementing the period index has the effect of lowering the frequency of the noise SFX.
    inc NoiseSFXData
    lda NoiseSFXData
    sta NOISE_LO
    rts

MissileLaunchSFXStart:
    lda #$18                        ;Number of frames to play sound before a change.
    ldy #<MissileLaunchSFXData.b      ;Lower byte of sound data start address(base=$B200).
    jsr GotoSelectSFXRoutine        ;($B587)Prepare to setup registers for SFX.
    lda #$0A                        ;
    sta NoiseSFXData                ;Start increment index for noise channel at #$0A.
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
    bne RTS_MusicBranch02           ;If more frames to process, branch to exit.

EndNoiseSFX:
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    lda #$10                        ;
    sta NOISE_VOL                   ;disable envelope generator(sound off).

RTS_MusicBranch02:
    rts                             ;Exit for multiple routines.

SamusWalkSFXStart:
    lda NoiseContSFX                ;If MissileLaunch, BombExplode or SpitFire SFX are-->
                                    ;already being played, branch to exit.s
    and #sfxNoise_MissileLaunch | sfxNoise_BombExplode | sfxNoise_SpitFlame.b
    bne RTS_MusicBranch02           ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<SamusWalkSFXData.b          ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine        ;Branch always.

MultiSFXInit:
    sta MultiSFXLength
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    jsr UpdateContFlags             ;($B493)Set continue SFX flag.
    ;Disable music from using SQ1 and SQ2 while SFX are playing.
    lda #$01
    sta SQ1InUse
    lda #$02
    sta SQ2InUse
    ;Clear all listed memory addresses.
    lda #$00
    sta SQ1ContSFX
    sta SQ1SFXData
    sta SQ1SQ2SFXData
    sta SQ1SFXPeriodLow
    sta ThisMultiFrame
    sta WriteMultiChannelData
    rts

EndMultiSFX:
    lda #$10                        ;
    sta SQ1_VOL                     ;Disable SQ1 envelope generator(sound off).
    sta SQ2_VOL                     ;Disable SQ2 envelope generator(sound off).
    lda #$7F                        ;
    sta SQ1_SWEEP                   ;Disable SQ1 sweep.
    sta SQ2_SWEEP                   ;Disable SQ2 sweep.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    lda #$00                        ;
    sta SQ1InUse                    ;
    sta SQ2InUse                    ;Allows music player to use SQ1 and SQ2 channels.
    inc WriteMultiChannelData       ;
    rts

BossHitSFXStart:
    ldy #<BossHitSQ1SFXData.b         ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    ldy #<BossHitSQ2SFXData.b         ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
    inc SQ1SFXData                  ;Increment index to data in table below.
    ldy SQ1SFXData                  ;
    lda BossHitSFXDataTbl,y         ;
    sta SQ1_VOL                     ;Load SQ1_VOL and SQ2_VOL from table below.
    sta SQ2_VOL                     ;
    lda SQ1SFXData                  ;
    cmp #$14                        ;After #$14 frames, end SFX.
    beq GotoEndMultiSFX             ;
    cmp #$06                        ;After six or more frames of SFX, branch.
    bcc LB620                       ;
    lda RandomNumber1               ;
    ora #$10                        ;Set bit 5.
    and #$7F                        ;Randomly set bits 7, 3, 2, 1 and 0.
    sta SQ1SFXPeriodLow             ;Store in SQ1 period low.
    rol                             ;
    sta SQ1SQ2SFXData               ;
    jmp WriteSQ1SQ2PeriodLow        ;($B62C)Write period low data to SQ1 and SQ2.
LB620:
    inc SQ1SQ2SFXData               ;
    inc SQ1SQ2SFXData               ;Increment SQ1 and SQ2 period low by two.
    inc SQ1SFXPeriodLow             ;
    inc SQ1SFXPeriodLow             ;

WriteSQ1SQ2PeriodLow:
    lda SQ1SQ2SFXData               ;
    sta SQ2_LO                      ;Write new SQ1 and SQ2 period lows to SQ1 and SQ2-->
    lda SQ1SFXPeriodLow             ;channels.
    sta SQ1_LO                      ;
    rts

GotoEndMultiSFX:
    jmp EndMultiSFX                 ;($B5CD)End SFX.

BossHitSFXDataTbl:
    .byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
    .byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB658                       ;If more SFX frames to process, branch.
    jmp EndMultiSFX                 ;($B5CD)End SFX.
LB658:
    ldy #<SamusHitSQ1SQ2SFXData.b     ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                      ;
    ldy #<SamusHitSQ1SQ2SFXData.b     ;Low byte of SQ2 sound data start address(base=$B200).
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                      ;Randomly set bits 2 and 3 of SQ2 period low.
    rts

SamusHitSFXStart:
    ldy #<SamusHitSQ1SQ2SFXData.b     ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                      ;
    clc                             ;
    lda RandomNumber1               ;Randomly set last three bits of SQ2 period low+1.
    and #$03                        ;
    adc #$01                        ;Number of frames to play sound before a change.
    ldy #<SamusHitSQ1SQ2SFXData.b     ;Low byte of SQ2 sound data start address(base=$B200).
    jsr MultiSFXInit                ;($B5A5)Initiate multi channel SFX.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                   ;Randomly set bits 2 and 3 of SQ2 period low.
RTS_B694:
    rts

IncorrectPasswordSFXStart:
    ldy #<IncorrectPasswordSQ1SFXData.b ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda #$20                        ;Number of frames to play sound before a change.
    ldy #<IncorrectPasswordSQ2SFXData.b ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_B694                       ;If more frames to process, branch to exit.
    jmp EndMultiSFX                 ;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1_LO data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
    .byte $BD, $8D, $7E, $5E, $46, $3E, $00

MissilePickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_MusicBranch03               ;If more frames to process, branch to exit.
    ldy SQ1SFXData                  ;
    lda MissilePickupSFXTbl,y       ;Load SFX data from table above.
    bne LB6C0                       ;
        jmp EndSQ1SFX                   ;($B6F2)SFX completed.
    LB6C0:
    sta SQ1_LO                   ;
    lda MissilePickupSFXData+3      ;#$28.
    sta SQ1_HI                   ;load SQ1_HI with #$28.
    inc SQ1SFXData                  ;Increment index to data table above every 5 frames.

RTS_MusicBranch03:
    rts                             ;Exit from multiple routines.

MissilePickupSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #<MissilePickupSFXData.b      ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

EnergyPickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_MusicBranch03               ;If more frames to process, branch to exit.
    inc SQ1SFXData                  ;
    lda SQ1SFXData                  ;Every six frames, reload SFX info.  Does it-->
    cmp #$03                        ;three times for a total of 18 frames.
    beq EndSQ1SFX                   ;
    ldy #<EnergyPickupSFXData.b       ;
    jmp LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #<EnergyPickupSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_MusicBranch03

EndSQ1SFX:
    lda #$10                        ;
    sta SQ1_VOL                     ;Disable envelope generator(sound off).
    lda #$00                        ;
    sta SQ1InUse                    ;Allows music to use SQ1 channel.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    inc WriteMultiChannelData       ;Allows music routines to load SQ1 and SQ2 music.
    rts

SamusJumpSFXStart:
    lda CurrentMusic                ;If escape music is playing, exit without playing-->
    cmp #music_Escape               ;Samus jump SFX.
    beq RTS_MusicBranch03               ;
    lda #$0C                        ;Number of frames to play sound before a change.
    ldy #<JumpSFXData.b        ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

EnemyHitSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #<EnemyHitSFXData.b    ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

BulletFireSFXStart:
    lda HasBeamSFX                  ;
    lsr                             ;If Samus has ice beam, branch.
    bcs HasIceBeamSFXStart          ;
    lda SQ1ContSFX                  ;If MissilePickup, EnergyPickup, BirdOutOfHole-->
                                    ;or EnemyHit SFX already playing, branch to exit.
    and #sfxSQ1_MissilePickup | sfxSQ1_EnergyPickup | sfxSQ1_OutOfHole | sfxSQ1_EnemyHit.b
    bne RTS_MusicBranch03           ;
    lda HasBeamSFX                  ;
    asl                             ;If Samus has long beam, branch.
    bcs HasLongBeamSFXStart         ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<ShortRangeShotSFXData.b     ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #<LongRangeShotSFXData.b      ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

MetalSFXStart:
    lda #$0B                        ;Number of frames to play sound before a change.
    ldy #<MetalSFXData.b              ;Lower byte of sound data start address(base=$B200).

SelectSFX1:
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
    lda CurrentMusic                ;If escape music is playing, use this SFX to make-->
    cmp #music_Escape               ;the bomb ticking sound, else play regular SFX.
    beq LB749                       ;
    lda #$16                        ;Number of frames to play sound before a change.
    ldy #<BugOutOFHoleSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.
LB749:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #<TimeBombTickSFXData.b       ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

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
    lda SQ1SFXData                  ;
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
        ldy SQ1SQ2SFXData               ;
        inc SQ1SQ2SFXData               ;Load wave beam SFXDisable/enable envelope length-->
        lda WaveBeamSFXDisLngthTbl,y    ;data from WaveBeamSFXDisableLengthTbl.
        sta SQ1_VOL                     ;
        bne RTS_MusicBranch10               ;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
        jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
    LB797:
    lda SQ1SFXData
    and #$01                        ;
    tay                             ;Load wave beam SFX period low data from-->
    lda WaveBeamSFXPeriodLowTbl,y   ;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
    sta SQ1_LO                   ;Change the period low data for SQ1 channel.
    inc SQ1SFXData

RTS_MusicBranch10:
    rts                             ;Exit for multiple routines.

WaveBeamSFXPeriodLowTbl:
    .byte $58                       ;Wave beam SFX period low data.
    .byte $6F                       ;

WaveBeamSFXDisLngthTbl:
    .byte $93                       ;
    .byte $91                       ;Wave beam SFX Disable/enable envelope length data.
    .byte $00                       ;

DoorOpenCloseSFXStart:
    lda DoorSFXData+2               ;#$30.
    sta TriPeriodLow                ;Set triangle period low data byte.
    lda DoorSFXData+3               ;#$B2.
    and #$07                        ;Set triangle period high data byte.
    sta TriPeriodHigh               ;#$B7.
    lda #$0F                        ;
    sta TriChangeLow                ;Change triangle channel period low every frame by #$0F.
    lda #$00                        ;
    sta TriChangeHigh               ;No change in triangle channel period high.
    lda #$1F                        ;Number of frames to play sound before a change.
    ldy #<DoorSFXData.b               ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB7D3                       ;
        jmp EndTriSFX               ;($B896)End SFX.
    LB7D3:
    jsr DecreaseTriPeriods     ;($B98C)Decrease periods.
    jmp WriteTriPeriods        ;($B869)Save new periods.

BeepSFXStart:
    lda TriContSFX                  ;If SamusDieSFX is already playing, branch-->
    and #sfxTri_SamusDie            ;without playing BeepSFX.
    bne RTS_MusicBranch10           ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<SamusBeepSFXData.b          ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BeepSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_MusicBranch10               ;If more frames to process, branch to exit.
    jmp EndTriSFX              ;($B896)End SFX.

BigEnemyHitSFXStart:
    lda #$12                        ;Increase triangle low period by #$12 every frame.
    sta TriChangeLow                ;
    lda #$00                        ;
    sta TriChangeHigh               ;Does not change triangle period high.
    lda BigEnemyHitSFXData+2        ;#$42.
    sta TriPeriodLow                ;Save new triangle period low data.
    lda BigEnemyHitSFXData+3        ;#$18.
    and #$07                        ;#$1F.
    sta TriPeriodHigh               ;Save new triangle period high data.
    lda #$0A                        ;Number of frames to play sound before a change.
    ldy #<BigEnemyHitSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @dontEnd                          ;If more frames to process, branch
        jmp EndTriSFX              ;($B896)End SFX
    @dontEnd:
    jsr IncreaseTriPeriods          ;($B978)Increase periods.
    lda RandomNumber1               ;
    and #$3C                        ;
    sta TriSFXData                  ;
    lda TriPeriodLow                ;Randomly set or clear bits 2, 3, 4 and 5 in-->
    and #$C3                        ;triangle channel period low.
    ora TriSFXData                  ;
    sta TRI_LO                      ;
    lda TriPeriodHigh               ;
    ora #$40                        ;Set 4th bit in triangle channel period high.
    sta TRI_HI                      ;
    rts

SamusToBallSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #<SamusToBallSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda #$05                        ;
    sta PercentDifference           ;Stores percent difference. In this case 5 = 1/5 = 20%.
    lda SamusToBallSFXData+2        ;#$DD.
    sta TriPeriodLow                ;Save new triangle period low data.
    lda SamusToBallSFXData+3        ;#$3B.
    and #$07                        ;#$02.
    sta TriPeriodHigh               ;Save new triangle period high data.
    rts

SamusToBallSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB857                       ;If more frames to process, branch.
    jmp EndTriSFX                  ;($B896)End SFX.
LB857:
    jsr DivideTriPeriods            ;($B9A0)reduces triangle period low by 20% each frame.
    lda TriLowPercentage            ;
    sta TriChangeLow                ;Store new values to change triangle periods.
    lda TriHighPercentage           ;
    sta TriChangeHigh               ;
    jsr DecreaseTriPeriods          ;($B98C)Decrease periods.

WriteTriPeriods:
    ;Write TriPeriodLow to triangle channel.
    lda TriPeriodLow
    sta TRI_LO
    ;Write TriPeriodHigh to triangle channel.
    lda TriPeriodHigh
    ora #$08
    sta TRI_HI
    rts

BombLaunchSFXStart:
    lda #$04                        ;Number of frames to play sound before a change.
    ldy #<BombLaunch1SFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne RTS_MusicBranch04           ;If more frames to process, branch to exit.
    inc TriSFXData                  ;
    lda TriSFXData                  ;After four frames, load second part of SFX.
    cmp #$02                        ;
    bne LB891                       ;
    jmp EndTriSFX                   ;($B896)End SFX.
LB891:
    ldy #<BombLaunch2SFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp LoadTriChannelSFX           ;($B36C)Prepare to load triangle channel with data.

EndTriSFX:
    lda #$00                        ;
    sta TRI_LINEAR                  ;clear TriCntr0(sound off).
    sta TriInUse                    ;Allows music to use triangle channel.
    lda #$18                        ;
    sta TRI_HI                      ;Set length index to #$03.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.

RTS_MusicBranch04:
    rts                             ;Exit from for multiple routines.

MetroidHitSFXStart:
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #<MetroidHitSFXData.b         ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    jmp RndTriPeriods               ;($B8C3)MetroidHit SFX has several different sounds.

MetroidHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    beq RndTriPeriods               ;
    inc TriSFXData                  ;
    lda TriSFXData                  ;Randomize triangle periods nine times throughout-->
    cmp #$09                        ;the course of the SFX.
    bne RTS_MusicBranch04           ;If SFX not done, branch.
    jmp EndTriSFX                   ;($B896)End SFX.

RndTriPeriods:
    lda RandomNumber1               ;Randomly set or reset bits 7, 4, 2 and 1 of-->
    ora #$6C                        ;triangle channel period low.
    sta TRI_LO                      ;
    and #$01                        ;
    ora #$F8                        ;Randomly set or reset last bit of triangle-->
    sta TRI_HI                      ;channel period high.
    rts

SamusDieSFXStart:
    jsr InitializeSoundAddresses    ;($B404)Clear all sound addresses.
    lda #$0E                        ;Number of frames to play sound before a change.
    ldy #<SamusDieSFXData.b           ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda #$15                        ;Decrease triangle SFX periods by 4.8% every frame.
    sta PercentDifference           ;
    lda SamusDieSFXData+2           ;#$40.
    sta TriPeriodLow                ;
    lda #$00                        ;Initial values of triangle periods.
    sta TriPeriodHigh               ;
RTS_B8EC:
    rts

SamusDieSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB90C                       ;
        lda #$20                        ;Store change in triangle period low.
        sta TriChangeLow                ;
        lda #$00                        ;
        sta TriChangeHigh               ;No change in triangle period high.
        jsr DecreaseTriPeriods          ;($B98C)Decrease periods.
        inc TriSFXData                  ;
        lda TriSFXData                  ;
        cmp #$06                        ;
        bne RTS_B8EC                    ;If more frames to process, branch to exit.
        jmp EndTriSFX                   ;($B896)End SFX.
    LB90C:
    jsr DivideTriPeriods            ;($B9A0)reduces triangle period low.
    lda TriLowPercentage            ;
    sta TriChangeLow                ;Update triangle periods.
    lda TriHighPercentage           ;
    sta TriChangeHigh               ;
    jsr IncreaseTriPeriods          ;($B978)Increase periods.
    jmp WriteTriPeriods             ;($B869)Save new periods.

StatueRaiseSFXStart:
    lda StatueRaiseSFXData+2        ;#$11.
    sta TriPeriodLow           ;Save period low data.
    lda StatueRaiseSFXData+3        ;#$09.
    and #$07                        ;
    sta TriPeriodHigh          ;Store last three bits in $B284.
    lda #$00                        ;
    sta TriChangeHigh          ;No change in Triangle period high.
    lda #$0B                        ;
    sta TriChangeLow           ;
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #<StatueRaiseSFXData.b        ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB972                       ;
        inc TriSFXData             ;Increment TriSFXData every 6 frames.
        lda TriSFXData             ;
        cmp #$09                        ;When TriSFXData = #$09, end SFX.
        bne LB952                       ;
            jmp EndTriSFX              ;($B896)End SFX.
        LB952:
        lda TriChangeLow           ;
        pha                             ;Save triangle periods.
        lda TriChangeHigh          ;
        pha                             ;
        lda #$25                        ;
        sta TriChangeLow           ;
        lda #$00                        ;No change in triangle period high.
        sta TriChangeHigh          ;
        jsr IncreaseTriPeriods     ;($B978)Increase periods.
        pla                             ;
        sta TriChangeHigh          ;Restore triangle periods.
        pla                             ;
        sta TriChangeLow           ;
        jmp WriteTriPeriods        ;($B869)Save new periods.
    LB972:
    jsr DecreaseTriPeriods     ;($B98C)Decrease periods.
    jmp WriteTriPeriods        ;($B869)Save new periods.

IncreaseTriPeriods:
    clc
    lda TriPeriodLow           ;
    adc TriChangeLow           ;Calculate new TriPeriodLow.
    sta TriPeriodLow           ;
    lda TriPeriodHigh          ;
    adc TriChangeHigh          ;Calculate new TriPeriodHigh.
    sta TriPeriodHigh          ;
    rts

DecreaseTriPeriods:
    sec
    lda TriPeriodLow           ;
    sbc TriChangeLow           ;Calculate new TriPeriodLow.
    sta TriPeriodLow           ;
    lda TriPeriodHigh          ;
    sbc TriChangeHigh          ;Calculate new TriPeriodHigh.
    sta TriPeriodHigh          ;
    rts

DivideTriPeriods:
    lda TriPeriodLow           ;
    pha                             ;Store TriPeriodLow and TriPeriodHigh.
    lda TriPeriodHigh          ;
    pha                             ;
    lda #$00                        ;
    sta DivideData                  ;
    ldx #$10                        ;
    rol TriPeriodLow           ;
    rol TriPeriodHigh          ;
    LB9B5:
        rol DivideData                  ;The following routine takes the triangle period-->
        lda DivideData                  ;high and triangle period low values and reduces-->
        cmp PercentDifference           ;them by a certain percent.  The percent is-->
        bcc LB9C6                       ;determined by the value stored in-->
            sbc PercentDifference           ;PercentDifference.  If PercentDifference=#$05,-->
            sta DivideData                  ;then the values will be reduced by 20%(1/5).-->
        LB9C6:
        rol TriPeriodLow           ;If PercentDifference=#$0A,Then the value will-->
        rol TriPeriodHigh          ;be reduced by 10%(1/10), etc. This function is-->
        dex                             ;basically a software emulation of a sweep function.
        bne LB9B5                       ;
    lda TriPeriodLow           ;
    sta TriLowPercentage       ;
    lda TriPeriodHigh          ;
    sta TriHighPercentage      ;
    pla                             ;
    sta TriPeriodHigh          ;Restore TriPerodLow and TriPeriodHigh.
    pla                             ;
    sta TriPeriodLow           ;
    rts

;--------------------------------------[ End SFX routines ]-------------------------------------

SetVolumeAndDisableSweep:
    ;Disable sweep generator on SQ1 and SQ2.
    lda #$7F
    sta MusicSQ1Sweep
    sta MusicSQ2Sweep
    ;Store duty cycle and volume data for SQ1 and SQ2.
    stx SQ1DutyEnvelope
    sty SQ2DutyEnvelope
    rts

ResetVolumeIndex:
    lda SQ1MusicFrameCount          ;If at the beginning of a new SQ1 note, set-->
    cmp #$01                        ;SQ1VolumeIndex = #$01.
    bne LB9FD                       ;
        sta SQ1VolumeIndex              ;
    LB9FD:
    lda SQ2MusicFrameCount          ;
    cmp #$01                        ;If at the beginning of a new SQ2 note, set-->
    bne RTS_BA07                       ;SQ2VolumeIndex = #$01.
        sta SQ2VolumeIndex              ;
    RTS_BA07:
    rts

LoadSQ1SQ2Periods:
    lda WriteMultiChannelData       ;If a Multi channel data does not need to be-->
    beq RTS_BA36                       ;loaded, branch to exit.
    lda #$00                        ;
    sta WriteMultiChannelData       ;Clear multi channel data write flag.
    lda MusicSQ1Sweep               ;
    sta SQ1_SWEEP                   ;
    lda MusicSQ1PeriodLow           ;
    sta SQ1_LO                      ;Loads SQ1 channel addresses $4001, $4002, $4003.
    lda MusicSQ1PeriodHigh          ;
    sta SQ1_HI                      ;
    lda MusicSQ2Sweep               ;
    sta SQ2_SWEEP                   ;
    lda MusicSQ2PeriodLow           ;
    sta SQ2_LO                      ;Loads SQ2 channel addresses $4005, $4006, $4007.
    lda MusicSQ2PeriodHigh          ;
    sta SQ2_HI                      ;
RTS_BA36:
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
    beq RTS_BA8B
    
    sta VolumeEnvelopeIndex
    jsr LoadSQ1SQ2Periods           ;($BA08)Load SQ1 and SQ2 control information.
    ;If sound channel is not currently playing sound, branch.
    lda SQ1VolumeData,x
    cmp #$10
    beq LBA99
    
    ; Store (VolumeEnvelopeIndex-1)*2 into y
    ldy #$00
    LBA54:
        ;Desired entry in VolumeEnvelopePtrTable.
        dec VolumeEnvelopeIndex
        beq LBA5C
        ;*2(2 byte address to find volume control data).
        iny
        iny
        ;Keep decrementing until desired address is found.
        bne LBA54
LBA5C:
    ;Load volume data address into VolumeEnvelopePtr
    lda VolumeEnvelopePtrTable,y
    sta VolumeEnvelopePtr
    lda VolumeEnvelopePtrTable+1,y
    sta VolumeEnvelopePtr+1.b
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
    lda SQ1DutyEnvelope,x
    and #$F0
    ora Cntrl0Data
    tay
LBA7D:
    ;Increment Index to volume data.
    inc SQ1VolumeIndex,x
LBA80:
    ;If SQ1 or SQ2(depends on loop iteration) in use, branch to exit
    lda SQ1InUse,x
    bne RTS_BA8B
    ;else write SQ(1 or 2)Cntrl0.
    txa
    ;If currently on SQ1, branch to write SQ1 data.
    beq WriteSQ1_VOL

;Write SQ2_VOL data.
WriteSQ2_VOL:
    sty SQ2_VOL
RTS_BA8B:
    rts

;Write SQ1_VOL data.
WriteSQ1_VOL:
    sty SQ1_VOL
    rts

MusicBranch05:
    ldy SQ1DutyEnvelope,x           ;Restore original volume of sound channel.
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

LoadCurrentMusicFrameData:
    jsr ResetVolumeIndex            ;($B9F3)Reset index if at the beginning of a new note.
    lda #$00                        ;
    tax                             ;X = #$00.
    sta ThisSoundChannel            ;(#$00, #$04, #$08 or #$0C).
    beq LBAC2                       ;
LBAB0:
    txa                             ;
    lsr                             ;
    tax                             ;Increment to next sound channel(1,2 or 3).

IncrementToNextChannel:
    inx                             ;
    txa                             ;
    cmp #$04                        ;If done with four sound channels, branch to load-->
    beq GotoLoadSQ1SQ2Channels      ;sound channel SQ1 SQ2 data.
    lda ThisSoundChannel            ;Add 4 to the least significant byte of the current-->
    clc                             ;sound channel start address.  This moves to next-->
    adc #$04                        ;sound channel address ranges to process.
    sta ThisSoundChannel            ;
LBAC2:
    txa                             ;
    asl                             ;*2(two bytes for sound channel info base address).
    tax                             ;
    lda SQ1Base,x                 ;
    sta SoundChannelBase                         ;Load sound channel info base address into $E6-->
    lda SQ1Base+1,x                 ;and $E7. ($E6=low byte, $E7=high byte).
    sta SoundChannelBase+1.b                         ;
    lda SQ1Base+1,x                 ;If no data for this sound channel, branch-->
    beq LBAB0                       ;to find data for next sound channel.
    txa                             ;
    lsr                             ;/2. Determine current sound channel (0,1,2 or3).
    tax                             ;
    dec SQ1MusicFrameCount,x        ;Decrement the current sound channel frame count-->
    bne IncrementToNextChannel      ;If not zero, branch to check next channel, else-->
                                        ;load the next set of sound channel data.
LoadNextChannelIndexData:
    ldy SQ1MusicIndexIndex,x        ;Load current channel index to music data index.
    inc SQ1MusicIndexIndex,x        ;Increment current channel index to music data index.
    lda (SoundChannelBase),y                     ;
    beq GotoCheckRepeatMusic        ;Branch if music has reached the end.
    tay                             ;Transfer music data index to Y (base=$BE77) .
    cmp #$FF                        ;
    beq RepeatMusicLoop             ;At end of loop? If yes, branch.
    and #$C0                        ;
    cmp #$C0                        ;At beginnig of new loop? if yes, branch.
    beq StartNewMusicLoop           ;
    jmp LoadMusicChannel            ;($BB1C)Load music data into channel.

RepeatMusicLoop:
    lda SQ1RepeatCounter,x          ;If loop counter has reached zero, branch to exit.
    beq GotoLoadNextChannelIndexData                       ;
    dec SQ1RepeatCounter,x          ;Decrement loop counter.
    lda SQ1LoopIndex,x              ;Load loop index for proper channel and store it in-->
    sta SQ1MusicIndexIndex,x        ;music index index address.
    bne GotoLoadNextChannelIndexData                       ;Branch unless music has reached the end.

StartNewMusicLoop:
    tya                             ;
    and #$3F                        ;Remove last six bits of loop controller and save-->
    sta SQ1RepeatCounter,x          ;in repeat counter addresses.  # of times to loop.
    dec SQ1RepeatCounter,x          ;Decrement loop counter.
    lda SQ1MusicIndexIndex,x        ;Store location of loop start in loop index address.
    sta SQ1LoopIndex,x              ;
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
    sta SQ1FrameCountInit,x         ;frame count init address.
    tay                             ;Y now contains note length.
    txa                             ;
    cmp #$02                        ;If loading Triangle channel data, branch.
    beq GotoLoadTRI_LINEAR

LoadSoundDataIndexIndex:
    ldy SQ1MusicIndexIndex,x        ;Load current index to sound data index.
    inc SQ1MusicIndexIndex,x        ;Increment music index index address.
    lda (SoundChannelBase),y        ;Load index to sound channel music data.
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
        bne LBB73                       ;Branch always.
    PeriodInformationFound:
        lda SQ1DutyEnvelope,x           ;Store channel duty cycle and volume info in $EA.
        sta Cntrl0Data                  ;
    LBB73:
    txa                             ;
    dec SQ1InUse,x                  ;
    cmp SQ1InUse,x                  ;If SQ1 or SQ2 are being used by SFX routines, branch.
    beq SQ1SQ2InUse                 ;
    inc SQ1InUse,x                  ;Restore not in use status of SQ1 or SQ2.
    ldy ThisSoundChannel            ;
    txa                             ;
    cmp #$02                        ;If loading triangle channel data, branch.
    beq LBB8C                       ;
    lda SQ1VolumeEnvelopeIndex,x            ;If $062E or $062F has volume data, skip writing-->
    bne LBB91                       ;Cntrl0Data to SQ1 or SQ2.
LBB8C:
    lda Cntrl0Data                  ;
    sta SQ1_VOL,y                 ;Write Cntrl0Data.
LBB91:
    lda Cntrl0Data                  ;
    sta SQ1VolumeData,x             ;Store volume data index to volume data.
    lda MusicSQ1PeriodLow,y         ;
    sta SQ1_LO,y                 ;
    lda MusicSQ1PeriodHigh,y        ;Write data to three sound channel addresses.
    sta SQ1_HI,y                 ;
    lda MusicSQ1Sweep,x             ;
    sta SQ1_SWEEP,y                 ;

LoadNewMusicFrameCount:
    lda SQ1FrameCountInit,x         ;Load new music frame count and store it in music-->
    sta SQ1MusicFrameCount,x        ;frame count address.
    jmp IncrementToNextChannel      ;($BAB3)Move to next sound channel.

SQ1SQ2InUse:
    inc SQ1InUse,x                  ;Restore in use status of SQ1 or SQ1.
    jmp LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

LoadTRI_LINEAR:
    lda TriCounterCntrl             ;
    and #$0F                        ;If lower bits set, branch to play shorter note.
    bne LBBD8                       ;
    lda TriCounterCntrl             ;
    and #$F0                        ;If upper bits are set, branch to play longer note.
    bne LBBC9                       ;
        tya                             ;
        jmp AddTriLength                ;($BBCD)Calculate length to play note.
    LBBC9:
    lda #$FF                        ;Disable length cntr(play until triangle data changes).
    bne LBBD8                       ;Branch always.

AddTriLength:
    clc                             ;
    adc #$FF                        ;Add #$FF(Effectively subtracts 1 from A).
    asl                             ;*2.
    asl                             ;*2.
    cmp #$3C                        ;
    bcc LBBD8                       ;If result is greater than #$3C, store #$3C(highest-->
    lda #$3C                        ;triangle linear count allowed).
LBBD8:
    sta TriLinearCount              ;
    jmp LoadSoundDataIndexIndex     ;($BB37)Load index to sound data index.

LoadNoiseChannelMusic:
    lda NoiseContSFX                ;If playing any Noise SFX, branch to exit.
    and #$FF~(sfxNoise_PauseMusic | sfxNoise_SilenceMusic).b
    bne LBBF7                       ;
        lda SFXData,y                     ;
        sta NOISE_VOL                 ;Load noise channel with drum beat SFX starting-->
        lda SFXData+1,y                   ;at address B201.  The possible values of Y are-->
        sta NOISE_LO                 ;#$01, #$04, #$07 or #$0A.
        lda SFXData+2,y                   ;
        sta NOISE_HI                 ;
    LBBF7:
    jmp LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

;The following table is used by the InitializeMusic routine to find the index for loading
;addresses $062B thru $0637.  Base is $BD31.

InitMusicIndexTbl:
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

MultiSFXInitRoutineTbl:
    .word GotoMusic03Init                     ;Fade in music.
    .word GotoMusic01Init                     ;Power up music.
    .word GotoMusic05Init                     ;End game music.
    .word GotoMusic01Init                     ;Intro music.
    .word RTS_B4EE                     ;No sound.
    .word SamusHitSFXStart                     ;Samus hit init SFX.
    .word BossHitSFXStart                     ;Boss hit init SFX.
    .word IncorrectPasswordSFXStart                     ;Incorrect password init SFX.

;Multi channel continue SFX handling routine addresses:

MultiSFXContRoutineTbl:
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.
    .word RTS_B4EE                     ;No sound.
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

LoadMusicTempFlags:
    lda CurrentMusicRepeat          ;Load A with temp music flags, (9th SFX cycle).
    ldx #<MusicInitPointers.b         ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne LBC42                       ;Branch always.

LoadMusicInitFlags:
    lda MusicInitFlag               ;Load A with Music flags, (10th SFX cycle).
    ldx #<MusicContPointers.b         ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jmp (SoundE2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.

ContinueMusic:                          ;11th and last SFX cycle.
    lda CurrentMusic                ;
    beq RTS_BC76                       ;Branch to exit of no music playing.
    jmp LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

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
    beq RTS_BC63
    @loop:
        ;Shift left until bit flag is in carry bit.
        ;Loop until SFX flag found.  Store bit-->
        ;number of music in MusicInitIndex.
        inc MusicInitIndex
        asl
        bcc @loop
RTS_BC63:
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
    lda CurrentMusic
    ora #$F0
    sta CurrentMusic
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
    jmp LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

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
.if BUILDTARGET == "NES_NTSC"
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
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $F5, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F5, $00, $00
    .endif
    
    .if BANK == 3
        .word SongMthrBrnRoomSQ1, SongMthrBrnRoomSQ2, SongMthrBrnRoomTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongEscapeHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $00, $02, $02
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $00, $02, $02
    .endif
    
    .if BANK == 3
        .word SongEscapeSQ1, SongEscapeSQ2, SongEscapeTri, SongEscapeNoise
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongNorfairHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $F0, $04, $04
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F0, $04, $04
    .endif
    
    .if BANK == 2
        .word SongNorfairSQ1, SongNorfairSQ2, SongNorfairTri, SongNorfairNoise
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongKraidHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@4, $FF, $F0, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@4, $FF, $F0, $00, $00
    .endif
    
    .if (BANK == 4) || (BANK == 5)
        .word SongKraidSQ1, SongKraidSQ2, SongKraidTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongItemRoomHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $03, $00, $00
    .endif
    
    .if BANK <= 5
        .word SongItemRoomSQ1, SongItemRoomSQ2, SongItemRoomTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongRidleyHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $F0, $01, $01
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $F0, $01, $01
    .endif
    
    .if (BANK == 4) || (BANK == 5)
        .word SongRidleySQ1, SongRidleySQ2, SongRidleyTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0000
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongEndHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@7, $00, $00, $02, $01
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@6, $00, $00, $02, $01
    .endif
    
    .if BANK == 0
        .word SongEndSQ1, SongEndSQ2, SongEndTri, SongEndNoise
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongIntroHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@7, $00, $F0, $02, $05
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@6, $00, $F0, $02, $05
    .endif
    
    .if BANK == 0
        .word SongIntroSQ1, SongIntroSQ2, SongIntroTri, SongIntroNoise
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif

SongFadeInHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $00, $F0, $02, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $00, $F0, $02, $00
    .endif
    
    .if BANK <= 5
        .word SongFadeInSQ1, SongFadeInSQ2, SongFadeInTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongPowerUpHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@4, $00, $F0, $01, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@3, $00, $F0, $01, $00
    .endif
    
    .if BANK <= 5
        .word SongPowerUpSQ1, SongPowerUpSQ2, SongPowerUpTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif

SongBrinstarHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $00, $02, $03
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $00, $02, $03
    .endif
    
    .if BANK == 1
        .word SongBrinstarSQ1, SongBrinstarSQ2, SongBrinstarTri, SongBrinstarNoise
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


SongTourianHeader:
    .if BUILDTARGET == "NES_NTSC"
        SongHeader NoteLengthsTbl@6, $FF, $03, $00, $00
    .elif BUILDTARGET == "NES_PAL"
        SongHeader NoteLengthsTbl@5, $FF, $03, $00, $00
    .endif
    
    .if BANK <= 5
        .word SongTourianSQ1, SongTourianSQ2, SongTourianTri, $0000
    .elif BUILDTARGET == "NES_NTSC"
        .word $0100, $0300, $0500, $0700
    .elif BUILDTARGET == "NES_PAL"
        .word $0000, $0000, $0000, $0000
    .endif


.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/item_room.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/item_room.asm"
.endif

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/power_up.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/power_up.asm"
.endif

.if BUILDTARGET == "NES_NTSC"
    .include "songs/ntsc/fade_in.asm"
.elif BUILDTARGET == "NES_PAL"
    .include "songs/pal/fade_in.asm"
.endif

.if BUILDTARGET == "NES_NTSC"
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
.if BUILDTARGET == "NES_NTSC"
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
    
    ;Load current SFX flags and store CurrentMusic address.
    lda CurrentSFXFlags
    sta CurrentMusic
    
    ;Find index for music in InitMusicInitIndexTbl.
    lda MusicInitIndex
    tay
    lda InitMusicIndexTbl,y
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
    sta SQ1MusicFrameCount
    sta SQ2MusicFrameCount
    sta TriMusicFrameCount
    sta NoiseMusicFrameCount
    
    ;Resets addresses $0638 thru $063B to #$00.-->
    ;These are the index to find sound channel data index.
    lda #$00
    sta SQ1MusicIndexIndex
    sta SQ2MusicIndexIndex
    sta TriMusicIndexIndex
    sta NoiseMusicIndexIndex
    rts

;Not used.
.if BUILDTARGET == "NES_NTSC"
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

