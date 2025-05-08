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
;processed: 0=Noise, 1=SQ1, 3=Triangle, 4=Multiple channels.

NoiseSFXInitPointers:
    .word NoiseSFXInitRoutineTbl, LoadNoiseSFXContFlags              ;Noise init SFX         (1st).
    .byte $00

NoiseSFXContPointers:
    .word NoiseSFXContRoutineTbl, LB4EE              ;Noise continue SFX     (2nd).
    .byte $00

SQ1SFXInitPointers:
    .word SQ1SFXInitRoutineTbl, LoadSQ1SFXContFlags              ;SQ1 init SFX           (5th).
    .byte $01

SQ1SFXContPointers:
    .word SQ1SFXContRoutineTbl, LB4EE              ;SQ2 continue SFX       (6th).
    .byte $01

TriangleSFXInitPointers:
    .word TriangleSFXInitRoutineTbl, LoadTriangleSFXContFlags              ;Triangle init SFX      (7th).
    .byte $03

TriangleSFXContPointers:
    .word TriangleSFXContRoutineTbl, LB4EE              ;Triangle continue SFX  (8th).
    .byte $03

MultiSFXInitPointers:
    .word MultiSFXInitRoutineTbl, LoadMultiSFXContFlags              ;Multi init SFX         (3rd).
    .byte $04

MultiSFXContPointers:
    .word MultiSFXContRoutineTbl, LoadSQ1Flags              ;Multi continue SFX     (4th).
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
    .word LB4EE                     ;No sound.
    .word ScrewAttackSFXStart                     ;Screw attack init SFX.
    .word MissileLaunchSFXStart                     ;Missile launch init SFX.
    .word BombExplodeSFXStart                     ;Bomb explode init SFX.
    .word SamusWalkSFXStart                     ;Samus walk init SFX.
    .word SpitFlameSFXStart                     ;Spit flame init SFX.
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.

;Noise Continue SFX handling routine addresses:
NoiseSFXContRoutineTbl:
    .word LB4EE                     ;No sound.
    .word ScrewAttackSFXContinue                     ;Screw attack continue SFX.
    .word MissileLaunchSFXContinue                     ;Missile launch continue SFX.
    .word NoiseSFXContinue                     ;Bomb explode continue SFX.
    .word NoiseSFXContinue                     ;Samus walk continue SFX.
    .word SpitFlameSFXContinue                     ;Spit flame continue SFX.
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.

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
TriangleSFXInitRoutineTbl:
    .word SamusDieSFXStart                     ;Samus die init SFX.
    .word DoorOpenCloseSFXStart                     ;Door open close init SFX.
    .word MetroidHitSFXStart                     ;Metroid hit init SFX.
    .word StatueRaiseSFXStart                     ;Statue raise init SFX.
    .word BeepSFXStart                     ;Beep init SFX.
    .word BigEnemyHitSFXStart                     ;Big enemy hit init SFX.
    .word SamusToBallSFXStart                     ;Samus to ball init SFX.
    .word BombLaunchSFXStart                     ;Bomb launch init SFX.

;Triangle continue handling routine addresses:
TriangleSFXContRoutineTbl:
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
    ldx #.lobyte(NoiseSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadNoiseSFXContFlags:
    lda NoiseContSFX                ;Load A with Noise continue flags, (2nd SFX cycle).
    ldx #.lobyte(NoiseSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXInitFlags:
    lda SQ1SFXFlag                  ;Load A with SQ1 init flags, (5th SFX cycle).
    ldx #.lobyte(SQ1SFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXContFlags:
    lda SQ1ContSFX                  ;Load A with SQ1 continue flags, (6th SFX cycle).
    ldx #.lobyte(SQ1SFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

GotoSFXCheckFlags:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX flags set.
    jmp ($00E2)                     ;if no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling routine.
LoadSTriangleSFXInitFlags:
    lda TriangleSFXFlag             ;Load A with Triangle init flags, (7th SFX cycle).
    ldx #.lobyte(TriangleSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadTriangleSFXContFlags:
    lda TriangleContSFX             ;Load A with Triangle continue flags, (8th SFX cycle).
    ldx #.lobyte(TriangleSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne GotoSFXCheckFlags           ;Branch always.

LoadMultiSFXInitFlags:
    lda MultiSFXFlag                ;Load A with Multi init flags, (3rd SFX cycle).
    ldx #.lobyte(MultiSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jsr Add8                        ;($BC64)Add 8 to MusicInitIndex.
    jmp ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.
LoadMultiSFXContFlags:
    lda MultiContSFX                ;Load A with $68C flags (4th SFX cycle).
    ldx #.lobyte(MultiSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    jmp GotoSFXCheckFlags           ;($B337)Checks to see if SFX or music flags set.

LoadSQ1Flags:
    jsr LoadSQ1SFXInitFlags         ;($B329)Check for SQ1 init flags.
    rts                             ;

LoadSQ1ChannelSFX:                      ;Used to determine which sound registers to change-->
    lda #$00                        ;($4000 - $4003) - SQ1.
    beq LoadSFXData                       ;Branch always.

LoadTriangleChannelSFX:                 ;Used to determine which sound registers to change-->
    lda #$08                        ;($4008 - $400B) - Triangle.
    bne LoadSFXData                       ;Branch always.

LoadNoiseChannelSFX:                    ;Used to determine which sound registers to change-->
    lda #$0C                        ;($400C - $400F) - Noise.
    bne LoadSFXData                       ;Branch always.

LoadSQ2ChannelSFX:                      ;Used to determine which sound registers to change-->
    lda #$04                        ;($4004 - $4007) - SQ2.
    ; fallthrough

LoadSFXData:
    sta $E0                         ;Lower address byte of desired APU control register.
    lda #$40                        ;
    sta $E0+1                       ;Upper address byte of desired APU control register.
    sty $E2                         ;Lower address byte of data to load into sound channel.
    lda #.hibyte(SFXData)           ;
    sta $E2+1                       ;Upper address byte of data to load into sound channel.
    ldy #$00                        ;Starting index for loading four byte sound data.

LoadSFXRegisters:
    lda ($E2),y                     ;Load A with SFX data byte.
    sta ($E0),y                     ;Store A in SFX register.
    iny                             ;
    tya                             ;The four registers associated with each sound-->
    cmp #$04                        ;channel are loaded one after the other (the loop-->
    bne LoadSFXRegisters                       ;repeats four times).
    rts                             ;

PauseSFX:
    inc SFXPaused                   ;SFXPaused=#$01
    jsr ClearSounds                 ;($B43E)Clear sound registers of data.
    sta PauseSFXStatus              ;PauseSFXStatus=#$00
    rts                             ;

LB399:
    lda SFXPaused                   ;Has SFXPaused been set? if not, branch
    beq PauseSFX                    ;
    lda PauseSFXStatus              ;For the first #$12 frames after the game has been-->
    cmp #$12                        ;paused, play GamePaused SFX.  If paused for #$12-->
    beq LB3B3                       ;frames or more, branch to exit.
    and #$03                        ;
    cmp #$03                        ;Every fourth frame, repeat GamePaused SFX
    bne LB3B0                       ;
        ldy #.lobyte(GamePausedSFXData) ;Lower address byte of GamePaused SFX data(Base=$B200)
        jsr LoadSQ1ChannelSFX           ;($B368) Load GamePaused SFX data.
    LB3B0:
    inc PauseSFXStatus
LB3B3:
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
;SQ1=0, SQ2=1, Triangle=2, Noise=3

SoundEngine:
    lda #$C0                        ;Set APU to 5 frame cycle, disable frame interrupt.
    sta JOY2             ;
    lda NoiseSFXFlag                ;is bit zero is set in NoiseSFXFlag(Silence-->
    lsr                             ;music)?  If yes, branch.
    bcs LB3EB                       ;
    lda MainRoutine                 ;
    cmp #$05                        ;Is game paused?  If yes, branch.
    beq LB399                       ;
    lda #$00                        ;Clear SFXPaused when game is running.
    sta SFXPaused                   ;
    jsr LoadNoiseSFXInitFlags       ;($B31B)Check noise SFX flags.
    jsr LoadMultiSFXInitFlags       ;($B34B)Check multichannel SFX flags.
    jsr LoadSTriangleSFXInitFlags   ;($B33D)Check triangle SFX flags.
    jsr LoadMusicTempFlags          ;($BC36)Check music flags.

ClearSFXFlags:
    lda #$00                        ;
    sta NoiseSFXFlag                ;
    sta SQ1SFXFlag                  ;
    sta SQ2SFXFlag                  ;Clear all SFX flags.
    sta TriangleSFXFlag             ;
    sta MultiSFXFlag                ;
    sta MusicInitFlag               ;
    rts                             ;

LB3EB:
    jsr InitializeSoundAddresses    ;($B404)Prepare to start playing music.
    beq ClearSFXFlags               ;Branch always.

CheckRepeatMusic:
    lda MusicRepeat                 ;
    beq InitializeSoundAddresses    ;If music is supposed to repeat, reset music,-->
    lda CurrentMusic                ;flags else branch to exit.
    sta CurrentMusicRepeat          ;
    rts                             ;

CheckMusicFlags:
    lda CurrentMusic                ;Loads A with current music flags and compares it-->
    cmp CurrentSFXFlags             ;with current SFX flags.  If both are equal,-->
    beq LB40A                       ;just clear music counters, else clear everything.

InitializeSoundAddresses:               ;
    jsr ClearMusicAndSFXAddresses   ;($B41D)Jumps to all subroutines needed to reset-->
    jsr ClearSounds                 ;($B43E)all sound addresses in order to start-->
LB40A:
    jsr ClearSpecialAddresses       ;($B40E)playing music.
    rts                             ;

ClearSpecialAddresses:
    lda #$00                        ;
    sta TriangleCounterCntrl        ;Clears addresses used for repeating music,-->
    sta SFXPaused                   ;pausing music and controlling triangle length.
    sta CurrentMusicRepeat          ;
    sta MusicRepeat                 ;
    rts                             ;

ClearMusicAndSFXAddresses:
    lda #$00                        ;
    sta SQ1InUse                    ;
    sta SQ2InUse                    ;
    sta TriangleInUse               ;
    sta WriteMultiChannelData       ;
    sta NoiseContSFX                ;Clears any SFX or music-->
    sta SQ1ContSFX                  ;currently being played.
    sta SQ2ContSFX                  ;
    sta TriangleContSFX             ;
    sta MultiContSFX                ;
    sta CurrentMusic                ;
    rts                             ;

ClearSounds:
    lda #$10                        ;
    sta SQ1_VOL                   ;
    sta SQ2_VOL                   ;
    sta NOISE_VOL                 ;Clears all sounds that might be in-->
    lda #$00                        ;The sound channel registers.
    sta TRI_LINEAR              ;
    sta DMC_RAW                   ;
    rts                             ;

SelectSFXRoutine:
    ldx ChannelType                 ;
    sta NoiseSFXLength,x            ;Stores frame length of SFX in corresponding address.
    txa                             ;
    beq LB477                       ;Branch if SFX uses noise channel.
    cmp #$01                        ;
    beq LB468                       ;Branch if SFX uses SQ1 channel.
    cmp #$02                        ;
    beq MusicBranch00               ;Branch if SFX uses SQ2 channel.
    cmp #$03                        ;
    beq MusicBranch01               ;Branch if SFX uses triangle wave.
    rts                             ;Exit if SFX routine uses no channels.

LB468:
    jsr LoadSQ1ChannelSFX           ;($B368)Prepare to load SQ1 channel with data.
    beq LB47A                       ;Branch always.
MusicBranch00:                          ;
    jsr LoadSQ2ChannelSFX           ;($B374)Prepare to load SQ2 channel with data.
    beq LB47A                       ;Branch always.
MusicBranch01:                          ;
    jsr LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.
    beq LB47A                       ;Branch always.
LB477:
    jsr LoadNoiseChannelSFX         ;($B370)Prepare to load noise channel with data.
LB47A:
    jsr UpdateContFlags             ;($B493)Set continuation flags for this SFX.
    txa                             ;
    sta NoiseInUse,x                ;Indicate sound channel is in use.
    lda #$00                        ;
    sta ThisNoiseFrame,x            ;
    sta NoiseSFXData,x              ;Clears all the following addresses before going-->
    sta MultiSFXData,x              ;to the proper SFX handling routine.
    sta ScrewAttackSFXData,x        ;
    sta WriteMultiChannelData       ;
    rts                             ;

UpdateContFlags:
    ldx ChannelType                 ;Loads X register with sound channel just changed.
    lda NoiseContSFX,x              ;Clear existing continuation SFX-->
    and #$00                        ;flags for that channel.
    ora CurrentSFXFlags             ;Load new continuation flags.
    sta NoiseContSFX,x              ;Save results.
    rts                             ;

ClearCurrentSFXFlags:
    lda #$00                        ;Once SFX has completed, this block clears the-->
    sta CurrentSFXFlags             ;SFX flag from the current flag register.
    beq UpdateContFlags             ;

IncrementSFXFrame:
    ldx ChannelType                 ;Load SFX channel number.
    inc ThisNoiseFrame,x            ;increment current frame to play on given channel.
    lda ThisNoiseFrame,x            ;Load current frame to play on given channel.
    cmp NoiseSFXLength,x            ;Check to see if current frame is last frame to play.
    bne LB4BC                       ;
    lda #$00                        ;If current frame is last frame,-->
    sta ThisNoiseFrame,x            ;reset current frame to 0.
LB4BC:
    rts                             ;

;The CheckSFXFlag routine loads E0 thru E3 with the below values:
;1st  SFX cycle $E0=#$BB, $E1=#$B2, $E2=#$22, $E3=#$B3.  Base address=$B289
;2nd  SFX cycle $E0=#$CB, $E1=#$B2, $E2=#$EE, $E3=#$B4.  Base address=$B28E
;3rd  SFX cycle $E0=#$06, $E1=#$BC, $E2=#$5C, $E3=#$B3.  Base address=$B2A7
;4th  SFX cycle $E0=#$16, $E1=#$BC, $E2=#$64, $E3=#$B3.  Base address=$B2AC
;5th  SFX cycle $E0=#$DB, $E1=#$B2, $E2=#$30, $E3=#$B3.  Base address=$B293
;6th  SFX cycle $E0=#$EB, $E1=#$B2, $E2=#$EE, $E3=#$B4.  Base address=$B298
;7th  SFX cycle $E0=#$FB, $E1=#$B2, $E2=#$44, $E3=#$B3.  Base address=$B29D
;8th  SFX cycle $E0=#$0B, $E1=#$B3, $E2=#$EE, $E3=#$B4.  Base address=$B2A2
;9th  SFX cycle $E0=#$26, $E1=#$BC, $E2=#$3D, $E3=#$BC.  Base address=$B2B6
;10th SFX cycle $E0=#$26, $E1=#$BC, $E2=#$4B, $E3=#$BC.  Base address=$B2B1

CheckSFXFlag:
    sta CurrentSFXFlags             ;Store any set flags in $064D.
    stx $E4                         ;
    ldy #.hibyte(SFXData)           ;
    sty $E4+1                       ;
    ldy #$00                        ;Y=0 for counting loop ahead.
    LB4C8:
        lda ($E4),y                     ;
        sta $00E0,y                     ;See table above for values loaded into $E0-->
        iny                             ;thru $E3 during this loop.
        tya                             ;
        cmp #$04                        ;Loop repeats four times to load the values.
        bne LB4C8                       ;
    lda ($E4),y                     ;
    sta ChannelType                 ;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
    ldy #$00                        ;Set y to 0 for counting loop ahead.
    lda CurrentSFXFlags             ;
    pha                             ;Push current SFX flags on stack.
    LB4DE:
        asl CurrentSFXFlags             ;
        bcs SFXFlagFound                       ;This portion of the routine loops a maximum of-->
        iny                             ;eight times looking for any SFX flags that have-->
        iny                             ;been set in the current SFX cycle.  If a flag-->
        tya                             ;is found, Branch to SFXFlagFound for further-->
        cmp #$10                        ;processing, if no flags are set, continue to-->
        bne LB4DE                       ;next SFX cycle.

RestoreSFXFlags:
    pla                             ;
    sta CurrentSFXFlags             ;Restore original data in CurrentSFXFlags.
LB4EE:
    rts                             ;

SFXFlagFound:                           ;
    lda ($E0),y                     ;This routine stores the starting address of the-->
    sta $E2                         ;specific SFX handling routine for the SFX flag-->
    iny                             ;found.  The address is stored in registers-->
    lda ($E0),y                     ;$E2 and $E3.
    sta $E2+1                       ;
    jmp RestoreSFXFlags             ;($B4EA)Restore original data in CurrentSFXFlags.

;-----------------------------------[ SFX Handling Routines ]---------------------------------------

;The following table is used by the SpitFlamesSFXContinue routine to change the volume-->
;on the SFX.  It starts out quiet, then becomes louder then goes quiet again.
SpitFlamesTbl:
    .byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1B, $1A, $19, $17
    .byte $16, $15, $14, $12

SpitFlameSFXStart:
    lda #$14                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SpitFlameSFXData)  ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

SpitFlameSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB51E                       ;If more frames to process, branch.
        jmp EndNoiseSFX                 ;($B58F)End SFX.
    LB51E:
    ldy NoiseSFXData                ;
    lda $B4FB,y                     ;Load data from table above and store in NOISE_VOL.
    sta NOISE_VOL                 ;
    inc NoiseSFXData                ;Increment to next entry in data table.
    rts

ScrewAttackSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #.lobyte(ScrewAttSFXData)   ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda ScrewAttSFXData+2                       ;#$00.
    sta NoiseSFXData                ;Clear NoiseSFXData.
LB538:
    rts                             ;

ScrewAttackSFXContinue:
    lda ScrewAttackSFXData          ;Prevents period index from being incremented until-->
    cmp #$02                        ;after the tenth frame of the SFX.
    beq LB549                       ;Branch if not ready to increment.
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB538                       ;
    inc ScrewAttackSFXData          ;Increment every fifth frame.
    rts                             ;

LB549:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne IncrementPeriodIndex        ;Start increasing period index after first ten frames.
    dec NoiseSFXData                ;
    dec NoiseSFXData                ;Decrement NoiseSFXData by three every fifth frame.
    dec NoiseSFXData                ;
    inc MultiSFXData                ;Increment MultiSFXData.  When it is equal to #$0F-->
    lda MultiSFXData                ;end screw attack SFX.  MultiSFXData does not-->
    cmp #$0F                        ;appear to be linked to multi SFX channels in-->
    bne LB538                       ;this routine.
    jmp EndNoiseSFX                 ;($B58F)End SFX.

IncrementPeriodIndex:
    inc NoiseSFXData                ;Incrementing the period index has the effect of-->
    lda NoiseSFXData                ;lowering the frequency of the noise SFX.
    sta NOISE_LO                 ;
    rts                             ;

MissileLaunchSFXStart:
    lda #$18                        ;Number of frames to play sound before a change.
    ldy #.lobyte(MissileLaunchSFXData) ;Lower byte of sound data start address(base=$B200).
    jsr GotoSelectSFXRoutine        ;($B587)Prepare to setup registers for SFX.
    lda #$0A                        ;
    sta NoiseSFXData                ;Start increment index for noise channel at #$0A.
    rts                             ;

MissileLaunchSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne IncrementPeriodIndex        ;
    jmp EndNoiseSFX                 ;($B58F)End SFX.

BombExplodeSFXStart:
    lda #$30                        ;Number of frames to play sound before a change.
    ldy #.lobyte(BombExplodeSFXData) ;Lower byte of sound data start address(base=$B200).

GotoSelectSFXRoutine:
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

;The following routine is used to continue BombExplode and SamusWalk SFX.

NoiseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch02               ;If more frames to process, branch to exit.

EndNoiseSFX:
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    lda #$10                        ;
    sta NOISE_VOL                 ;disable envelope generator(sound off).

MusicBranch02:
    rts                             ;Exit for multiple routines.

SamusWalkSFXStart:
    lda NoiseContSFX                ;If MissileLaunch, SamusWalk or SpitFire SFX are-->
    and #$34                        ;already being played, branch to exit.
    bne MusicBranch02               ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SamusWalkSFXData)  ;Lower byte of sound data start address(base=$B200).
    bne GotoSelectSFXRoutine                       ;Branch always.

MultiSFXInit:
    sta MultiSFXLength              ;
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    jsr UpdateContFlags             ;($B493)Set continue SFX flag.
    lda #$01                        ;
    sta SQ1InUse                    ;Disable music from using SQ1 and SQ2 while-->
    lda #$02                        ;SFX are playing.
    sta SQ2InUse                    ;
    lda #$00                        ;
    sta SQ1ContSFX                  ;
    sta SQ1SFXData                  ;
    sta SQ1SQ2SFXData               ;Clear all listed memory addresses.
    sta SQ1SFXPeriodLow             ;
    sta ThisMultiFrame              ;
    sta WriteMultiChannelData       ;
    rts                             ;

EndMultiSFX:
    lda #$10                        ;
    sta SQ1_VOL                   ;Disable SQ1 envelope generator(sound off).
    sta SQ2_VOL                   ;Disable SQ2 envelope generator(sound off).
    lda #$7F                        ;
    sta SQ1_SWEEP                   ;Disable SQ1 sweep.
    sta SQ2_SWEEP                   ;Disable SQ2 sweep.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    lda #$00                        ;
    sta SQ1InUse                    ;
    sta SQ2InUse                    ;Allows music player to use SQ1 and SQ2 channels.
    inc WriteMultiChannelData       ;
    rts                             ;

BossHitSFXStart:
    ldy #.lobyte(BossHitSQ1SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    ldy #.lobyte(BossHitSQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
    inc SQ1SFXData                  ;Increment index to data in table below.
    ldy SQ1SFXData                  ;
    lda LB63C,y                     ;
    sta SQ1_VOL                   ;Load SQ1_VOL and SQ2_VOL from table below.
    sta SQ2_VOL                   ;
    lda SQ1SFXData                  ;
    cmp #$14                        ;After #$14 frames, end SFX.
    beq LB639                       ;
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
    sta SQ2_LO                   ;Write new SQ1 and SQ2 period lows to SQ1 and SQ2-->
    lda SQ1SFXPeriodLow             ;channels.
    sta SQ1_LO                   ;
    rts                             ;

LB639:
    jmp EndMultiSFX                 ;($B5CD)End SFX.

BossHitSFXDataTbl:
LB63C:  .byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
LB64C:  .byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB658                       ;If more SFX frames to process, branch.
    jmp EndMultiSFX                 ;($B5CD)End SFX.
LB658:
    ldy #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                   ;
    ldy #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    jsr LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                   ;Randomly set bits 2 and 3 of SQ2 period low.
    rts                             ;

SamusHitSFXStart:
    ldy #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly set last four bits of SQ1 period low.
    sta SQ1_LO                   ;
    clc                             ;
    lda RandomNumber1               ;Randomly set last three bits of SQ2 period low+1.
    and #$03                        ;
    adc #$01                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    jsr MultiSFXInit                ;($B5A5)Initiate multi channel SFX.
    lda RandomNumber1               ;
    lsr                             ;Multiply random number by 4.
    lsr                             ;
    and #$0F                        ;
    sta SQ2_LO                   ;Randomly set bits 2 and 3 of SQ2 period low.
LB694:
    rts                             ;

IncorrectPasswordSFXStart:
    ldy #.lobyte(IncorrectPasswordSQ1SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    jsr LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    lda #$20                        ;Number of frames to play sound before a change.
    ldy #.lobyte(IncorrectPasswordSQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    jmp MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB694                       ;If more frames to process, branch to exit.
    jmp EndMultiSFX                 ;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1_LO data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
    .byte $BD, $8D, $7E, $5E, $46, $3E, $00

MissilePickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch03               ;If more frames to process, branch to exit.
    ldy SQ1SFXData                  ;
    lda MissilePickupSFXTbl,y       ;Load SFX data from table above.
    bne LB6C0                       ;
    jmp EndSQ1SFX                   ;($B6F2)SFX completed.
LB6C0:
    sta SQ1_LO                   ;
    lda MissilePickupSFXData+3      ;#$28.
    sta SQ1_HI                   ;load SQ1_HI with #$28.
    inc SQ1SFXData                  ;Increment index to data table above every 5 frames.

MusicBranch03:
    rts                             ;Exit from multiple routines.

MissilePickupSFXStart:
    lda #$05                        ;Number of frames to play sound before a change.
    ldy #.lobyte(MissilePickupSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                       ;Branch always.

EnergyPickupSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch03               ;If more frames to process, branch to exit.
    inc SQ1SFXData                  ;
    lda SQ1SFXData                  ;Every six frames, reload SFX info.  Does it-->
    cmp #$03                        ;three times for a total of 18 frames.
    beq EndSQ1SFX                       ;
    ldy #.lobyte(EnergyPickupSFXData) ;
    jmp LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #.lobyte(EnergyPickupSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                       ;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch03               ;

EndSQ1SFX:
    lda #$10                        ;
    sta SQ1_VOL                     ;Disable envelope generator(sound off).
    lda #$00                        ;
    sta SQ1InUse                    ;Allows music to use SQ1 channel.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    inc WriteMultiChannelData       ;Allows music routines to load SQ1 and SQ2 music.
    rts                             ;

SamusJumpSFXStart:
    lda CurrentMusic                ;If escape music is playing, exit without playing-->
    cmp #$04                        ;Samus jump SFX.
    beq MusicBranch03               ;
    lda #$0C                        ;Number of frames to play sound before a change.
    ldy #.lobyte(JumpSFXData)       ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

EnemyHitSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #.lobyte(EnemyHitSFXData)   ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

BulletFireSFXStart:
    lda HasBeamSFX                  ;
    lsr                             ;If Samus has ice beam, branch.
    bcs HasIceBeamSFXStart          ;
    lda SQ1ContSFX                  ;If MissilePickup, EnergyPickup, BirdOutOfHole-->
    and #$CC                        ;or EnemyHit SFX already playing, branch to exit.
    bne MusicBranch03               ;
    lda HasBeamSFX                  ;
    asl                             ;If Samus has long beam, branch.
    bcs HasLongBeamSFXStart         ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #.lobyte(ShortRangeShotSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #.lobyte(LongRangeShotSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

MetalSFXStart:
    lda #$0B                        ;Number of frames to play sound before a change.
    ldy #.lobyte(MetalSFXData)      ;Lower byte of sound data start address(base=$B200).

SelectSFX1:
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
    lda CurrentMusic                ;If escape music is playing, use this SFX to make-->
    cmp #$04                        ;the bomb ticking sound, else play regular SFX.
    beq LB749                       ;
    lda #$16                        ;Number of frames to play sound before a change.
    ldy #.lobyte(BugOutOFHoleSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.
LB749:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #.lobyte(TimeBombTickSFXData) ;Lower byte of sound data start address(base=$B200).
    bne SelectSFX1                  ;Branch always.

BulletFireSFXContinue:
    lda HasBeamSFX                  ;
    lsr                             ;If Samus has ice beam, branch.
    bcs HasIceBeamSFXContinue       ;
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB75D                       ;If more frames to process, branch to exit.
    jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB75D:
    rts                             ;

HasIceBeamSFXStart:
    lda #$07                        ;Number of frames to play sound before a change.
    ldy #.lobyte(IceBeamSFXData)    ;Lower byte of sound data start address(base=$B200).
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
    ldy #.lobyte(WaveBeamSFXData)   ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

WaveBeamSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB797                       ;If more frames to process, branch.
    ldy SQ1SQ2SFXData               ;
    inc SQ1SQ2SFXData               ;Load wave beam SFXDisable/enable envelope length-->
    lda WaveBeamSFXDisLngthTbl,y    ;data from WaveBeamSFXDisableLengthTbl.
    sta SQ1_VOL                     ;
    bne MusicBranch10               ;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
    jmp EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB797:
    lda SQ1SFXData
    and #$01                        ;
    tay                             ;Load wave beam SFX period low data from-->
    lda WaveBeamSFXPeriodLowTbl,y   ;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
    sta SQ1_LO                   ;Change the period low data for SQ1 channel.
    inc SQ1SFXData                  ;

MusicBranch10:
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
    sta TrianglePeriodLow           ;Set triangle period low data byte.
    lda DoorSFXData+3               ;#$B2.
    and #$07                        ;Set triangle period high data byte.
    sta TrianglePeriodHigh          ;#$B7.
    lda #$0F                        ;
    sta TriangleChangeLow           ;Change triangle channel period low every frame by #$0F.
    lda #$00                        ;
    sta TriangleChangeHigh          ;No change in triangle channel period high.
    lda #$1F                        ;Number of frames to play sound before a change.
    ldy #.lobyte(DoorSFXData)       ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB7D3                       ;
        jmp EndTriangleSFX              ;($B896)End SFX.
    LB7D3:
    jsr DecreaseTrianglePeriods     ;($B98C)Decrease periods.
    jmp WriteTrianglePeriods        ;($B869)Save new periods.

BeepSFXStart:
    lda TriangleContSFX             ;If BombLaunchSFX is already playing, branch-->
    and #$80                        ;without playing BeepSFX.
    bne MusicBranch10               ;
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SamusBeepSFXData)  ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BeepSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch10               ;If more frames to process, branch to exit.
    jmp EndTriangleSFX              ;($B896)End SFX.

BigEnemyHitSFXStart:
    lda #$12                        ;Increase triangle low period by #$12 every frame.
    sta TriangleChangeLow           ;
    lda #$00                        ;
    sta TriangleChangeHigh          ;Does not change triangle period high.
    lda BigEnemyHitSFXData+2        ;#$42.
    sta TrianglePeriodLow           ;Save new triangle period low data.
    lda BigEnemyHitSFXData+3        ;#$18.
    and #$07                        ;#$1F.
    sta TrianglePeriodHigh          ;Save new triangle period high data.
    lda #$0A                        ;Number of frames to play sound before a change.
    ldy #.lobyte(BigEnemyHitSFXData) ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne @+                          ;If more frames to process, branch
        jmp EndTriangleSFX              ;($B896)End SFX
@:
    jsr IncreaseTrianglePeriods     ;($B978)Increase periods.
    lda RandomNumber1               ;
    and #$3C                        ;
    sta TriangleSFXData             ;
    lda TrianglePeriodLow           ;Randomly set or clear bits 2, 3, 4 and 5 in-->
    and #$C3                        ;triangle channel period low.
    ora TriangleSFXData             ;
    sta TRI_LO              ;
    lda TrianglePeriodHigh          ;
    ora #$40                        ;Set 4th bit in triangle channel period high.
    sta TRI_HI              ;
    rts                             ;

SamusToBallSFXStart:
    lda #$08                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SamusToBallSFXData) ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda #$05                        ;
    sta PercentDifference           ;Stores percent difference. In this case 5 = 1/5 = 20%.
    lda SamusToBallSFXData+2        ;#$DD.
    sta TrianglePeriodLow           ;Save new triangle period low data.
    lda SamusToBallSFXData+3        ;#$3B.
    and #$07                        ;#$02.
    sta TrianglePeriodHigh          ;Save new triangle period high data.
    rts                             ;

SamusToBallSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB857                       ;If more frames to process, branch.
    jmp EndTriangleSFX              ;($B896)End SFX.
LB857:
    jsr DivideTrianglePeriods       ;($B9A0)reduces triangle period low by 20% each frame.
    lda TriangleLowPercentage       ;
    sta TriangleChangeLow           ;Store new values to change triangle periods.
    lda TriangleHighPercentage      ;
    sta TriangleChangeHigh          ;
    jsr DecreaseTrianglePeriods     ;($B98C)Decrease periods.

WriteTrianglePeriods:
    lda TrianglePeriodLow           ;Write TrianglePeriodLow to triangle channel.
    sta TRI_LO              ;
    lda TrianglePeriodHigh          ;
    ora #$08                        ;Write TrianglePeriodHigh to triangle channel.
    sta TRI_HI              ;
    rts                             ;

BombLaunchSFXStart:
    lda #$04                        ;Number of frames to play sound before a change.
    ldy #.lobyte(BombLaunch1SFXData) ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne MusicBranch04               ;If more frames to process, branch to exit.
    inc TriangleSFXData             ;
    lda TriangleSFXData             ;After four frames, load second part of SFX.
    cmp #$02                        ;
    bne LB891                       ;
    jmp EndTriangleSFX              ;($B896)End SFX.
LB891:
    ldy #.lobyte(BombLaunch2SFXData) ;Lower byte of sound data start address(base=$B200).
    jmp LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.

EndTriangleSFX:
    lda #$00                        ;
    sta TRI_LINEAR              ;clear TriangleCntr0(sound off).
    sta TriangleInUse               ;Allows music to use triangle channel.
    lda #$18                        ;
    sta TRI_HI              ;Set length index to #$03.
    jsr ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.

MusicBranch04:
    rts                             ;Exit from for multiple routines.

MetroidHitSFXStart:
    lda #$03                        ;Number of frames to play sound before a change.
    ldy #.lobyte(MetroidHitSFXData) ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    jmp RndTrianglePeriods          ;($B8C3)MetroidHit SFX has several different sounds.

MetroidHitSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    beq RndTrianglePeriods          ;
    inc TriangleSFXData             ;
    lda TriangleSFXData             ;Randomize triangle periods nine times throughout-->
    cmp #$09                        ;the course of the SFX.
    bne MusicBranch04               ;If SFX not done, branch.
    jmp EndTriangleSFX              ;($B896)End SFX.

RndTrianglePeriods:
    lda RandomNumber1               ;Randomly set or reset bits 7, 4, 2 and 1 of-->
    ora #$6C                        ;triangle channel period low.
    sta TRI_LO              ;
    and #$01                        ;
    ora #$F8                        ;Randomly set or reset last bit of triangle-->
    sta TRI_HI              ;channel period high.
    rts                             ;

SamusDieSFXStart:
    jsr InitializeSoundAddresses    ;($B404)Clear all sound addresses.
    lda #$0E                        ;Number of frames to play sound before a change.
    ldy #.lobyte(SamusDieSFXData)   ;Lower byte of sound data start address(base=$B200).
    jsr SelectSFXRoutine            ;($B452)Setup registers for SFX.
    lda #$15                        ;Decrease triangle SFX periods by 4.8% every frame.
    sta PercentDifference           ;
    lda SamusDieSFXData+2           ;#$40.
    sta TrianglePeriodLow           ;
    lda #$00                        ;Initial values of triangle periods.
    sta TrianglePeriodHigh          ;
LB8EC:
    rts                             ;

SamusDieSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB90C                       ;
        lda #$20                        ;Store change in triangle period low.
        sta TriangleChangeLow           ;
        lda #$00                        ;
        sta TriangleChangeHigh          ;No change in triangle period high.
        jsr DecreaseTrianglePeriods     ;($B98C)Decrease periods.
        inc TriangleSFXData             ;
        lda TriangleSFXData             ;
        cmp #$06                        ;
        bne LB8EC                       ;If more frames to process, branch to exit.
        jmp EndTriangleSFX              ;($B896)End SFX.
    LB90C:
    jsr DivideTrianglePeriods       ;($B9A0)reduces triangle period low.
    lda TriangleLowPercentage       ;
    sta TriangleChangeLow           ;Update triangle periods.
    lda TriangleHighPercentage      ;
    sta TriangleChangeHigh          ;
    jsr IncreaseTrianglePeriods     ;($B978)Increase periods.
    jmp WriteTrianglePeriods        ;($B869)Save new periods.

StatueRaiseSFXStart:
    lda StatueRaiseSFXData+2        ;#$11.
    sta TrianglePeriodLow           ;Save period low data.
    lda StatueRaiseSFXData+3        ;#$09.
    and #$07                        ;
    sta TrianglePeriodHigh          ;Store last three bits in $B284.
    lda #$00                        ;
    sta TriangleChangeHigh          ;No change in Triangle period high.
    lda #$0B                        ;
    sta TriangleChangeLow           ;
    lda #$06                        ;Number of frames to play sound before a change.
    ldy #.lobyte(StatueRaiseSFXData) ;Lower byte of sound data start address(base=$B200).
    jmp SelectSFXRoutine            ;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
    jsr IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    bne LB972                       ;
        inc TriangleSFXData             ;Increment TriangleSFXData every 6 frames.
        lda TriangleSFXData             ;
        cmp #$09                        ;When TriangleSFXData = #$09, end SFX.
        bne LB952                       ;
            jmp EndTriangleSFX              ;($B896)End SFX.
        LB952:
        lda TriangleChangeLow           ;
        pha                             ;Save triangle periods.
        lda TriangleChangeHigh          ;
        pha                             ;
        lda #$25                        ;
        sta TriangleChangeLow           ;
        lda #$00                        ;No change in triangle period high.
        sta TriangleChangeHigh          ;
        jsr IncreaseTrianglePeriods     ;($B978)Increase periods.
        pla                             ;
        sta TriangleChangeHigh          ;Restore triangle periods.
        pla                             ;
        sta TriangleChangeLow           ;
        jmp WriteTrianglePeriods        ;($B869)Save new periods.
    LB972:
    jsr DecreaseTrianglePeriods     ;($B98C)Decrease periods.
    jmp WriteTrianglePeriods        ;($B869)Save new periods.

IncreaseTrianglePeriods:
    clc
    lda TrianglePeriodLow           ;
    adc TriangleChangeLow           ;Calculate new TrianglePeriodLow.
    sta TrianglePeriodLow           ;
    lda TrianglePeriodHigh          ;
    adc TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
    sta TrianglePeriodHigh          ;
    rts                             ;

DecreaseTrianglePeriods:
    sec
    lda TrianglePeriodLow           ;
    sbc TriangleChangeLow           ;Calculate new TrianglePeriodLow.
    sta TrianglePeriodLow           ;
    lda TrianglePeriodHigh          ;
    sbc TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
    sta TrianglePeriodHigh          ;
    rts                             ;

DivideTrianglePeriods:
    lda TrianglePeriodLow           ;
    pha                             ;Store TrianglePeriodLow and TrianglePeriodHigh.
    lda TrianglePeriodHigh          ;
    pha                             ;
    lda #$00                        ;
    sta DivideData                  ;
    ldx #$10                        ;
    rol TrianglePeriodLow           ;
    rol TrianglePeriodHigh          ;
    LB9B5:
        rol DivideData                  ;The following routine takes the triangle period-->
        lda DivideData                  ;high and triangle period low values and reduces-->
        cmp PercentDifference           ;them by a certain percent.  The percent is-->
        bcc LB9C6                       ;determined by the value stored in-->
            sbc PercentDifference           ;PercentDifference.  If PercentDifference=#$05,-->
            sta DivideData                  ;then the values will be reduced by 20%(1/5).-->
        LB9C6:
        rol TrianglePeriodLow           ;If PercentDifference=#$0A,Then the value will-->
        rol TrianglePeriodHigh          ;be reduced by 10%(1/10), etc. This function is-->
        dex                             ;basically a software emulation of a sweep function.
        bne LB9B5                       ;
    lda TrianglePeriodLow           ;
    sta TriangleLowPercentage       ;
    lda TrianglePeriodHigh          ;
    sta TriangleHighPercentage      ;
    pla                             ;
    sta TrianglePeriodHigh          ;Restore TrianglePerodLow and TrianglePeriodHigh.
    pla                             ;
    sta TrianglePeriodLow           ;
    rts                             ;

;--------------------------------------[ End SFX routines ]-------------------------------------

SetVolumeAndDisableSweep:
    lda #$7F                        ;
    sta MusicSQ1Sweep               ;Disable sweep generator on SQ1 and SQ2.
    sta MusicSQ2Sweep               ;
    stx SQ1DutyEnvelope             ;Store duty cycle and volume data for SQ1 and SQ2.
    sty SQ2DutyEnvelope             ;
    rts                             ;

ResetVolumeIndex:
    lda SQ1MusicFrameCount          ;If at the beginning of a new SQ1 note, set-->
    cmp #$01                        ;SQ1VolumeIndex = #$01.
    bne LB9FD                       ;
        sta SQ1VolumeIndex              ;
    LB9FD:
    lda SQ2MusicFrameCount          ;
    cmp #$01                        ;If at the beginning of a new SQ2 note, set-->
    bne LBA07                       ;SQ2VolumeIndex = #$01.
        sta SQ2VolumeIndex              ;
    LBA07:
    rts                             ;

LoadSQ1SQ2Periods:
    lda WriteMultiChannelData       ;If a Multi channel data does not need to be-->
    beq LBA36                       ;loaded, branch to exit.
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
LBA36:
    rts                             ;

LoadSQ1SQ2Channels:
    ldx #$00                        ;Load SQ1 channel data.
    jsr WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    inx                             ;Load SQ2 channel data.
    jsr WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    rts                             ;

WriteSQCntrl0:
    lda SQ1VolumeCntrl,x            ;Load SQ channel volume data. If zero, branch to exit.
    beq LBA8B                       ;
    sta VolumeCntrlAddress          ;
    jsr LoadSQ1SQ2Periods           ;($BA08)Load SQ1 and SQ2 control information.
    lda SQ1VolumeData,x             ;
    cmp #$10                        ;If sound channel is not currently-->
    beq LBA99                       ;playing sound, branch.
    ldy #$00                        ;
    LBA54:
        dec VolumeCntrlAddress          ;Desired entry in VolumeCntrlAdressTbl.
        beq LBA5C                       ;
        iny                             ;*2(2 byte address to find voulume control data).
        iny                             ;
        bne LBA54                       ;Keep decrementing until desired address is found.
LBA5C:
    lda VolumeCntrlAddressTbl,y     ;Base is $BCB0.
    sta $EC                         ;Volume data address low byte.
    lda VolumeCntrlAddressTbl+1,y   ;Base is $BCB1.
    sta $ED                         ;Volume data address high byte.
    ldy SQ1VolumeIndex,x            ;Index to desired volume data.
    lda ($EC),y                     ;Load desired volume for current channel into-->
    sta Cntrl0Data                  ;Cntrl0Data.
    cmp #$FF                        ;If last entry in volume table is #$FF, restore-->
    beq MusicBranch05               ;volume to its original level after done reading-->
    cmp #$F0                        ;Volume data.  If #$F0 is last entry, turn sound-->
    beq MusicBranch06               ;off on current channel until next note.
    lda SQ1DutyEnvelope,x           ;Remove duty cycle data For current channel and-->
    and #$F0                        ;add this frame of volume data and store results-->
    ora Cntrl0Data                  ;in Cntrl0Data.
    tay                             ;
LBA7D:
    inc SQ1VolumeIndex,x            ;Increment Index to volume data.
LBA80:
    lda SQ1InUse,x                  ;If SQ1 or SQ2(depends on loop iteration) in use,-->
    bne LBA8B                       ;branch to exit, else write SQ(1 or 2)Cntrl0.
    txa                             ;
    beq WriteSQ1_VOL              ;If currently on SQ1, branch to write SQ1 data.

WriteSQ2_VOL:                         ;
    sty SQ2_VOL                   ;Write SQ2_VOL data.
LBA8B:
    rts                             ;

WriteSQ1_VOL:                         ;
    sty SQ1_VOL                   ;Write SQ1_VOL data.
    rts                             ;

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
    rts                             ;

GotoLoadSQ1SQ2Channels:
    jsr LoadSQ1SQ2Channels          ;($BA37)Load SQ1 and SQ2 channel data.
    rts                             ;

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

IncrementToNextChannel:                 ;
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
    lda SQ1BaseLo,x                 ;
    sta $E6                         ;Load sound channel info base address into $E6-->
    lda SQ1BaseHi,x                 ;and $E7. ($E6=low byte, $E7=high byte).
    sta $E7                         ;
    lda SQ1BaseHi,x                 ;If no data for this sound channel, branch-->
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
    lda ($E6),y                     ;
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
    beq LBB13                       ;
    dec SQ1RepeatCounter,x          ;Decrement loop counter.
    lda SQ1LoopIndex,x              ;Load loop index for proper channel and store it in-->
    sta SQ1MusicIndexIndex,x        ;music index index address.
    bne LBB13                       ;Branch unless music has reached the end.

StartNewMusicLoop:
    tya                             ;
    and #$3F                        ;Remove last six bits of loop controller and save-->
    sta SQ1RepeatCounter,x          ;in repeat counter addresses.  # of times to loop.
    dec SQ1RepeatCounter,x          ;Decrement loop counter.
    lda SQ1MusicIndexIndex,x        ;Store location of loop start in loop index address.
    sta SQ1LoopIndex,x              ;
LBB13:
    jmp LoadNextChannelIndexData    ;($BADC)Load next channel index data.

LBB16:
    jmp LoadNoiseChannelMusic       ;($BBDE)Load data for noise channel music.

LBB19:
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
    lda NoteLengths0Tbl,y           ;(Base is $BEF7)Load note length and store in-->
    sta SQ1FrameCountInit,x         ;frame count init address.
    tay                             ;Y now contains note length.
    txa                             ;
    cmp #$02                        ;If loading Triangle channel data, branch.
    beq LBB19                       ;

LoadSoundDataIndexIndex:
    ldy SQ1MusicIndexIndex,x        ;Load current index to sound data index.
    inc SQ1MusicIndexIndex,x        ;Increment music index index address.
    lda ($E6),y                     ;Load index to sound channel music data.
    tay                             ;
LBB40:
    txa                             ;
    cmp #$03                        ;If loading Noise channel data, branch.
    beq LBB16                       ;
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
    lda SQ1VolumeCntrl,x            ;If $062E or $062F has volume data, skip writing-->
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
    lda TriangleCounterCntrl        ;
    and #$0F                        ;If lower bits set, branch to play shorter note.
    bne LBBD8                       ;
    lda TriangleCounterCntrl        ;
    and #$F0                        ;If upper bits are set, branch to play longer note.
    bne LBBC9                       ;
    tya                             ;
    jmp AddTriangleLength           ;($BBCD)Calculate length to play note.
LBBC9:
    lda #$FF                        ;Disable length cntr(play until triangle data changes).
    bne LBBD8                       ;Branch always.

AddTriangleLength:
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
    lda NoiseContSFX                ;
    and #$FC                        ;If playing any Noise SFX, branch to exit.
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
    .word Music03Start                     ;Fade in music.
    .word Music01Start                     ;Power up music.
    .word Music05Start                     ;End game music.
    .word Music01Start                     ;Intro music.
    .word LB4EE                     ;No sound.
    .word SamusHitSFXStart                     ;Samus hit init SFX.
    .word BossHitSFXStart                     ;Boss hit init SFX.
    .word IncorrectPasswordSFXStart                     ;Incorrect password init SFX.

;Multi channel continue SFX handling routine addresses:

MultiSFXContRoutineTbl:
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.
    .word LB4EE                     ;No sound.
    .word SamusHitSFXContinue                     ;Samus hit continue SFX.
    .word BossHitSFXContinue                     ;Boss hit continue SFX.
    .word IncorrectPasswordSFXContinue                     ;Incorrect password continue SFX.

;Music handling routine addresses:

MusicRoutineTbl:
    .word Music04Start                     ;Ridley area music.
    .word Music00Start                     ;Tourian music.
    .word Music00Start                     ;Item room music.
    .word Music00Start                     ;Kraid area music.
    .word Music03Start                     ;Norfair music.
    .word Music02Start                     ;Escape music.
    .word Music00Start                     ;Mother brain music.
    .word Music03Start                     ;Brinstar music.

;-----------------------------------[ Entry point for music routines ]--------------------------------

LoadMusicTempFlags:
    lda CurrentMusicRepeat          ;Load A with temp music flags, (9th SFX cycle).
    ldx #.lobyte(MusicInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    bne LBC42                       ;Branch always.

LoadMusicInitFlags:
    lda MusicInitFlag               ;Load A with Music flags, (10th SFX cycle).
    ldx #.lobyte(MusicContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:
    jsr CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    jsr FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    jmp ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.

ContinueMusic:                          ;11th and last SFX cycle.
    lda CurrentMusic                ;
    beq LBC76                       ;Branch to exit of no music playing.
    jmp LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

;MusicInitIndex values correspond to the following music:
;#$00=Ridley area music, #$01=Tourian music, #$02=Item room music, #$03=Kraid area music,
;#$04=Norfair music, #$05=Escape music, #$06=Mother brain music, #$07=Brinstar music,
;#$08=Fade in music, #$09=Power up music, #$0A=End game music, #$0B=Intro music.

FindMusicInitIndex:
    lda #$FF                        ;Load MusicInitIndex with #$FF.
    sta MusicInitIndex              ;
    lda CurrentSFXFlags             ;
    beq LBC63                       ;Branch to exit if no SFX flags set for Multi SFX.
    LBC5D:
        inc MusicInitIndex              ;
        asl                             ;Shift left until bit flag is in carry bit.
        bcc LBC5D                       ;Loop until SFX flag found.  Store bit-->
LBC63:
    rts                             ;number of music in MusicInitIndex.

;The following routine is used to add eight to the music index when looking for music flags
;in the MultiSFX address.
Add8:
    lda MusicInitIndex              ;
    clc                             ;
    adc #$08                        ;Add #$08 to MusicInitIndex.
    sta MusicInitIndex              ;
    rts                             ;

    lda CurrentMusic                ;
    ora #$F0                        ;This code does not appear to be used in this page.
    sta CurrentMusic                ;
LBC76:
    rts                             ;

Music00Start:
    jmp Music00Init                 ;($BCAA)Initialize music 00.

Music01Start:
    jmp Music01Init                 ;($BCA4)Initialize music 01.

Music02Start:
    jmp Music02Init                 ;($BC9A)Initialize music 02.

Music03Start:
    jmp Music03Init                 ;($BC96)Initialize music 03.

Music04Start:
    jmp Music04Init                 ;($BC89)Initialize music 04.

Music05Start:
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
VolumeCntrlAddressTbl:
    .word VolumeDataTbl1, VolumeDataTbl2, VolumeDataTbl3, VolumeDataTbl4, VolumeDataTbl5

VolumeDataTbl1:
    .byte $01, $02, $02, $03, $03, $04, $05, $06, $07, $08, $FF

VolumeDataTbl2:
    .byte $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF

VolumeDataTbl3:
    .byte $00, $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF

VolumeDataTbl4:
    .byte $02, $06, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $04, $04, $04, $03
    .byte $03, $03, $03, $02, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02
    .byte $02, $02, $02, $01, $01, $01, $01, $01, $F0

VolumeDataTbl5:
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
    SongHeader NoteLengths1Tbl, $FF, $F5, $00, $00
    .if BANK = 3
        .word SongMthrBrnRoomSQ1, SongMthrBrnRoomSQ2, SongMthrBrnRoomTri, $0000
    .else
        .word $0100, $0300, $0500, $0000
    .endif

SongEscapeHeader:
    SongHeader NoteLengths1Tbl, $FF, $00, $02, $02
    .if BANK = 3
        .word SongEscapeSQ1, SongEscapeSQ2, SongEscapeTri, SongEscapeNoise
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongNorfairHeader:
    SongHeader NoteLengths1Tbl, $FF, $F0, $04, $04
    .if BANK = 2
        .word SongNorfairSQ1, SongNorfairSQ2, SongNorfairTri, SongNorfairNoise
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongKraidHeader:
    SongHeader NoteLengths0Tbl, $FF, $F0, $00, $00
    .if (BANK = 4) || (BANK = 5)
        .word SongKraidSQ1, SongKraidSQ2, SongKraidTri, $0000
    .else
        .word $0100, $0300, $0500, $0000
    .endif

SongItemRoomHeader:
    SongHeader NoteLengths1Tbl, $FF, $03, $00, $00
    .if BANK <= 5
        .word SongItemRoomSQ1, SongItemRoomSQ2, SongItemRoomTri, $0000
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongRidleyHeader:
    SongHeader NoteLengths1Tbl, $FF, $F0, $01, $01
    .if (BANK = 4) || (BANK = 5)
        .word SongRidleySQ1, SongRidleySQ2, SongRidleyTri, $0000
    .else
        .word $0100, $0300, $0500, $0000
    .endif

SongEndHeader:
    SongHeader NoteLengths2Tbl, $00, $00, $02, $01
    .if BANK = 0
        .word SongEndSQ1, SongEndSQ2, SongEndTri, SongEndNoise
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongIntroHeader:
    SongHeader NoteLengths2Tbl, $00, $F0, $02, $05
    .if BANK = 0
        .word SongIntroSQ1, SongIntroSQ2, SongIntroTri, SongIntroNoise
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongFadeInHeader:
    SongHeader NoteLengths1Tbl, $00, $F0, $02, $00
    .if BANK <= 5
        .word SongFadeInSQ1, SongFadeInSQ2, SongFadeInTri, $0000
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongPowerUpHeader:
    SongHeader NoteLengths0Tbl, $00, $F0, $01, $00
    .if BANK <= 5
        .word SongPowerUpSQ1, SongPowerUpSQ2, SongPowerUpTri, $0000
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongBrinstarHeader:
    SongHeader NoteLengths1Tbl, $FF, $00, $02, $03
    .if BANK = 1
        .word SongBrinstarSQ1, SongBrinstarSQ2, SongBrinstarTri, SongBrinstarNoise
    .else
        .word $0100, $0300, $0500, $0700
    .endif

SongTourianHeader:
    SongHeader NoteLengths1Tbl, $FF, $03, $00, $00
    .if BANK <= 5
        .word SongTourianSQ1, SongTourianSQ2, SongTourianTri, $0000
    .else
        .word $0100, $0300, $0500, $0700
    .endif

.include "songs/item_room.asm"

.include "songs/power_up.asm"

.include "songs/fade_in.asm"

.include "songs/tourian.asm"

;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)

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

;Used by power up music and Kraid area music.

NoteLengths0Tbl:
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

NoteLengths1Tbl:
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

NoteLengths2Tbl:
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

InitializeMusic:
    jsr CheckMusicFlags             ;($B3FC)Check to see if restarting current music.
    lda CurrentSFXFlags             ;Load current SFX flags and store CurrentMusic address.
    sta CurrentMusic                ;
    lda MusicInitIndex              ;
    tay                             ;
    lda InitMusicIndexTbl,y         ;($BBFA)Find index for music in InitMusicInitIndexTbl.
    tay                             ;
    ldx #$00                        ;
    LBF2C:
        lda SongHeaders,y              ;Base is $BD31.
        sta NoteLengthTblOffset,x       ;
        iny                             ;The following loop repeats 13 times to-->
        inx                             ;load the initial music addresses -->
        txa                             ;(registers $062B thru $0637).
        cmp #$0D                        ;
        bne LBF2C                       ;
    lda #$01                        ;Resets addresses $0640 thru $0643 to #$01.-->
    sta SQ1MusicFrameCount          ;These addresses are used for counting the-->
    sta SQ2MusicFrameCount          ;number of frames music channels have been playing.
    sta TriangleMusicFrameCount     ;
    sta NoiseMusicFrameCount        ;
    lda #$00                        ;
    sta SQ1MusicIndexIndex          ;
    sta SQ2MusicIndexIndex          ;Resets addresses $0638 thru $063B to #$00.-->
    sta TriangleMusicIndexIndex     ;These are the index to find sound channel data index.
    sta NoiseMusicIndexIndex        ;
    rts                             ;

;Not used.
    .byte $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $2C, $B4, $AD
    .byte $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9, $2A, $BC, $A8, $A2, $00, $B9
    .byte $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40
    .byte $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D
    .byte $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
