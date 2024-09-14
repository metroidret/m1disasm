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
    LDA NoiseSFXFlag                ;Load A with Noise init SFX flags, (1st SFX cycle).
    LDX #.lobyte(NoiseSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Branch always.

LoadNoiseSFXContFlags:
    LDA NoiseContSFX                ;Load A with Noise continue flags, (2nd SFX cycle).
    LDX #.lobyte(NoiseSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXInitFlags:
    LDA SQ1SFXFlag                  ;Load A with SQ1 init flags, (5th SFX cycle).
    LDX #.lobyte(SQ1SFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXContFlags:
    LDA SQ1ContSFX                  ;Load A with SQ1 continue flags, (6th SFX cycle).
    LDX #.lobyte(SQ1SFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Branch always.

GotoSFXCheckFlags:
    JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX flags set.         
    JMP ($00E2)                     ;if no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling routine.
LoadSTriangleSFXInitFlags:
    LDA TriangleSFXFlag             ;Load A with Triangle init flags, (7th SFX cycle).
    LDX #.lobyte(TriangleSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Brach always.

LoadTriangleSFXContFlags:
    LDA TriangleContSFX             ;Load A with Triangle continue flags, (8th SFX cycle).
    LDX #.lobyte(TriangleSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE GotoSFXCheckFlags           ;Branch always.

LoadMultiSFXInitFlags:
    LDA MultiSFXFlag                ;Load A with Multi init flags, (3rd SFX cycle).
    LDX #.lobyte(MultiSFXInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    JSR FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    JSR Add8                        ;($BC64)Add 8 to MusicInitIndex.
    JMP ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.
LoadMultiSFXContFlags:
    LDA MultiContSFX                ;Load A with $68C flags (4th SFX cycle).
    LDX #.lobyte(MultiSFXContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    JMP GotoSFXCheckFlags           ;($B337)Checks to see if SFX or music flags set.

LoadSQ1Flags:
    JSR LoadSQ1SFXInitFlags         ;($B329)Check for SQ1 init flags.
    RTS                             ;

LoadSQ1ChannelSFX:                      ;Used to determine which sound registers to change-->
    LDA #$00                        ;($4000 - $4003) - SQ1.
    BEQ LoadSFXData                       ;Branch always.

LoadTriangleChannelSFX:                 ;Used to determine which sound registers to change-->
    LDA #$08                        ;($4008 - $400B) - Triangle.
    BNE LoadSFXData                       ;Branch always.

LoadNoiseChannelSFX:                    ;Used to determine which sound registers to change-->
    LDA #$0C                        ;($400C - $400F) - Noise.
    BNE LoadSFXData                       ;Branch always.

LoadSQ2ChannelSFX:                      ;Used to determine which sound registers to change-->
    LDA #$04                        ;($4004 - $4007) - SQ2.
    ; fallthrough

LoadSFXData:
    STA $E0                         ;Lower address byte of desired APU control register.
    LDA #$40                        ;
    STA $E0+1                       ;Upper address byte of desired APU control register.
    STY $E2                         ;Lower address byte of data to load into sound channel.
    LDA #.hibyte(SFXData)           ;
    STA $E2+1                       ;Upper address byte of data to load into sound channel.
    LDY #$00                        ;Starting index for loading four byte sound data.

LoadSFXRegisters:
    LDA ($E2),Y                     ;Load A with SFX data byte.
    STA ($E0),Y                     ;Store A in SFX register.
    INY                             ;
    TYA                             ;The four registers associated with each sound-->
    CMP #$04                        ;channel are loaded one after the other (the loop-->
    BNE LoadSFXRegisters                       ;repeats four times).
    RTS                             ;

PauseSFX:
    INC SFXPaused                   ;SFXPaused=#$01
    JSR ClearSounds                 ;($B43E)Clear sound registers of data.          
    STA PauseSFXStatus              ;PauseSFXStatus=#$00
    RTS                             ;

LB399:
    LDA SFXPaused                   ;Has SFXPaused been set? if not, branch
    BEQ PauseSFX                    ;
    LDA PauseSFXStatus              ;For the first #$12 frames after the game has been-->
    CMP #$12                        ;paused, play GamePaused SFX.  If paused for #$12-->
    BEQ LB3B3                       ;frames or more, branch to exit.
    AND #$03                        ;
    CMP #$03                        ;Every fourth frame, repeat GamePaused SFX
    BNE LB3B0                       ;
        LDY #.lobyte(GamePausedSFXData) ;Lower address byte of GamePaused SFX data(Base=$B200)
        JSR LoadSQ1ChannelSFX           ;($B368) Load GamePaused SFX data.
    LB3B0:
    INC PauseSFXStatus
LB3B3:
    RTS

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
    LDA #$C0                        ;Set APU to 5 frame cycle, disable frame interrupt.
    STA APUCommonCntrl1             ;
    LDA NoiseSFXFlag                ;is bit zero is set in NoiseSFXFlag(Silence-->
    LSR                             ;music)?  If yes, branch.
    BCS LB3EB                       ;
    LDA MainRoutine                 ;
    CMP #$05                        ;Is game paused?  If yes, branch.
    BEQ LB399                       ;
    LDA #$00                        ;Clear SFXPaused when game is running.
    STA SFXPaused                   ;
    JSR LoadNoiseSFXInitFlags       ;($B31B)Check noise SFX flags.
    JSR LoadMultiSFXInitFlags       ;($B34B)Check multichannel SFX flags.
    JSR LoadSTriangleSFXInitFlags   ;($B33D)Check triangle SFX flags.
    JSR LoadMusicTempFlags          ;($BC36)Check music flags.

ClearSFXFlags:
    LDA #$00                        ;
    STA NoiseSFXFlag                ;
    STA SQ1SFXFlag                  ;
    STA SQ2SFXFlag                  ;Clear all SFX flags.
    STA TriangleSFXFlag             ;
    STA MultiSFXFlag                ;
    STA MusicInitFlag               ;
    RTS                             ;

LB3EB:
    JSR InitializeSoundAddresses    ;($B404)Prepare to start playing music.         
    BEQ ClearSFXFlags               ;Branch always.

CheckRepeatMusic:
    LDA MusicRepeat                 ;
    BEQ InitializeSoundAddresses    ;If music is supposed to repeat, reset music,-->
    LDA CurrentMusic                ;flags else branch to exit.
    STA CurrentMusicRepeat          ;
    RTS                             ;

CheckMusicFlags:
    LDA CurrentMusic                ;Loads A with current music flags and compares it-->
    CMP CurrentSFXFlags             ;with current SFX flags.  If both are equal,-->
    BEQ LB40A                       ;just clear music counters, else clear everything.

InitializeSoundAddresses:               ;
    JSR ClearMusicAndSFXAddresses   ;($B41D)Jumps to all subroutines needed to reset-->
    JSR ClearSounds                 ;($B43E)all sound addresses in order to start-->
LB40A:
    JSR ClearSpecialAddresses       ;($B40E)playing music.
    RTS                             ;

ClearSpecialAddresses:
    LDA #$00                        ;       
    STA TriangleCounterCntrl        ;Clears addresses used for repeating music,-->
    STA SFXPaused                   ;pausing music and controlling triangle length.
    STA CurrentMusicRepeat          ;
    STA MusicRepeat                 ;
    RTS                             ;

ClearMusicAndSFXAddresses:              ;
    LDA #$00                        ;
    STA SQ1InUse                    ;
    STA SQ2InUse                    ;
    STA TriangleInUse               ;
    STA WriteMultiChannelData       ;
    STA NoiseContSFX                ;Clears any SFX or music--> 
    STA SQ1ContSFX                  ;currently being played.
    STA SQ2ContSFX                  ;
    STA TriangleContSFX             ;
    STA MultiContSFX                ;
    STA CurrentMusic                ;
    RTS                             ;

ClearSounds:                            ;
    LDA #$10                        ;
    STA SQ1Cntrl0                   ;
    STA SQ2Cntrl0                   ;
    STA NoiseCntrl0                 ;Clears all sounds that might be in-->
    LDA #$00                        ;The sound channel registers.
    STA TriangleCntrl0              ;
    STA DMCCntrl1                   ;
    RTS                             ;

SelectSFXRoutine:
    LDX ChannelType                 ;
    STA NoiseSFXLength,X            ;Stores frame length of SFX in corresponding address.
    TXA                             ;
    BEQ LB477                       ;Branch if SFX uses noise channel.
    CMP #$01                        ;
    BEQ LB468                       ;Branch if SFX uses SQ1 channel.
    CMP #$02                        ;
    BEQ MusicBranch00               ;Branch if SFX uses SQ2 channel.
    CMP #$03                        ;
    BEQ MusicBranch01               ;Branch if SFX uses triangle wave.
    RTS                             ;Exit if SFX routine uses no channels.

LB468:
    JSR LoadSQ1ChannelSFX           ;($B368)Prepare to load SQ1 channel with data.
    BEQ LB47A                       ;Branch always.
MusicBranch00:                          ;
    JSR LoadSQ2ChannelSFX           ;($B374)Prepare to load SQ2 channel with data.
    BEQ LB47A                       ;Branch always.
MusicBranch01:                          ;
    JSR LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.
    BEQ LB47A                       ;Branch always.
LB477:
    JSR LoadNoiseChannelSFX         ;($B370)Prepare to load noise channel with data.
LB47A:
    JSR UpdateContFlags             ;($B493)Set continuation flags for this SFX.
    TXA                             ;
    STA NoiseInUse,X                ;Indicate sound channel is in use.
    LDA #$00                        ;
    STA ThisNoiseFrame,X            ;
    STA NoiseSFXData,X              ;Clears all the following addresses before going-->
    STA MultiSFXData,X              ;to the proper SFX handling routine.
    STA ScrewAttackSFXData,X        ;
    STA WriteMultiChannelData       ;
    RTS                             ;

UpdateContFlags:
    LDX ChannelType                 ;Loads X register with sound channel just changed.
    LDA NoiseContSFX,X              ;Clear existing continuation SFX-->
    AND #$00                        ;flags for that channel.
    ORA CurrentSFXFlags             ;Load new continuation flags.
    STA NoiseContSFX,X              ;Save results.
    RTS                             ;

ClearCurrentSFXFlags:
    LDA #$00                        ;Once SFX has completed, this block clears the-->
    STA CurrentSFXFlags             ;SFX flag from the current flag register.
    BEQ UpdateContFlags             ;

IncrementSFXFrame:
    LDX ChannelType                 ;Load SFX channel number.
    INC ThisNoiseFrame,X            ;increment current frame to play on given channel.
    LDA ThisNoiseFrame,X            ;Load current frame to play on given channel.
    CMP NoiseSFXLength,X            ;Check to see if current frame is last frame to play.
    BNE LB4BC                       ;
    LDA #$00                        ;If current frame is last frame,-->
    STA ThisNoiseFrame,X            ;reset current frame to 0.
LB4BC:
    RTS                             ;

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
    STA CurrentSFXFlags             ;Store any set flags in $064D.
    STX $E4                         ;
    LDY #.hibyte(SFXData)           ;
    STY $E4+1                       ;
    LDY #$00                        ;Y=0 for counting loop ahead.
    LB4C8:
        LDA ($E4),Y                     ;
        STA $00E0,Y                     ;See table above for values loaded into $E0-->
        INY                             ;thru $E3 during this loop.
        TYA                             ;
        CMP #$04                        ;Loop repeats four times to load the values.
        BNE LB4C8                       ;
    LDA ($E4),Y                     ;
    STA ChannelType                 ;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
    LDY #$00                        ;Set y to 0 for counting loop ahead.
    LDA CurrentSFXFlags             ;
    PHA                             ;Push current SFX flags on stack.
    LB4DE:
        ASL CurrentSFXFlags             ;
        BCS SFXFlagFound                       ;This portion of the routine loops a maximum of-->
        INY                             ;eight times looking for any SFX flags that have-->
        INY                             ;been set in the current SFX cycle.  If a flag-->
        TYA                             ;is found, Branch to SFXFlagFound for further-->
        CMP #$10                        ;processing, if no flags are set, continue to-->
        BNE LB4DE                       ;next SFX cycle.

RestoreSFXFlags:
    PLA                             ;
    STA CurrentSFXFlags             ;Restore original data in CurrentSFXFlags.
LB4EE:
    RTS                             ;

SFXFlagFound:                           ;
    LDA ($E0),Y                     ;This routine stores the starting address of the-->
    STA $E2                         ;specific SFX handling routine for the SFX flag--> 
    INY                             ;found.  The address is stored in registers-->
    LDA ($E0),Y                     ;$E2 and $E3.
    STA $E2+1                       ;
    JMP RestoreSFXFlags             ;($B4EA)Restore original data in CurrentSFXFlags.

;-----------------------------------[ SFX Handling Routines ]---------------------------------------

;The following table is used by the SpitFlamesSFXContinue routine to change the volume-->
;on the SFX.  It starts out quiet, then becomes louder then goes quiet again.
SpitFlamesTbl:
    .byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1B, $1A, $19, $17
    .byte $16, $15, $14, $12

SpitFlameSFXStart:
    LDA #$14                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SpitFlameSFXData)  ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

SpitFlameSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB51E                       ;If more frames to process, branch.
        JMP EndNoiseSFX                 ;($B58F)End SFX.
    LB51E:
    LDY NoiseSFXData                ;
    LDA $B4FB,Y                     ;Load data from table above and store in NoiseCntrl0.
    STA NoiseCntrl0                 ;
    INC NoiseSFXData                ;Increment to next entry in data table.
    RTS 

ScrewAttackSFXStart:
    LDA #$05                        ;Number of frames to play sound before a change.
    LDY #.lobyte(ScrewAttSFXData)   ;Lower byte of sound data start address(base=$B200).
    JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
    LDA ScrewAttSFXData+2                       ;#$00.
    STA NoiseSFXData                ;Clear NoiseSFXData.
LB538:
    RTS                             ;

ScrewAttackSFXContinue:
    LDA ScrewAttackSFXData          ;Prevents period index from being incremented until-->
    CMP #$02                        ;after the tenth frame of the SFX.
    BEQ LB549                       ;Branch if not ready to increment.
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB538                       ;
    INC ScrewAttackSFXData          ;Increment every fifth frame.
    RTS                             ;

LB549:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE IncrementPeriodIndex        ;Start increasing period index after first ten frames.
    DEC NoiseSFXData                ;
    DEC NoiseSFXData                ;Decrement NoiseSFXData by three every fifth frame.
    DEC NoiseSFXData                ;
    INC MultiSFXData                ;Increment MultiSFXData.  When it is equal to #$0F-->
    LDA MultiSFXData                ;end screw attack SFX.  MultiSFXData does not-->
    CMP #$0F                        ;appear to be linked to multi SFX channels in-->
    BNE LB538                       ;this routine.
    JMP EndNoiseSFX                 ;($B58F)End SFX.

IncrementPeriodIndex:
    INC NoiseSFXData                ;Incrementing the period index has the effect of-->
    LDA NoiseSFXData                ;lowering the frequency of the noise SFX.
    STA NoiseCntrl2                 ;
    RTS                             ;

MissileLaunchSFXStart:
    LDA #$18                        ;Number of frames to play sound before a change.
    LDY #.lobyte(MissileLaunchSFXData) ;Lower byte of sound data start address(base=$B200).
    JSR GotoSelectSFXRoutine        ;($B587)Prepare to setup registers for SFX.
    LDA #$0A                        ;
    STA NoiseSFXData                ;Start increment index for noise channel at #$0A.
    RTS                             ;

MissileLaunchSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE IncrementPeriodIndex        ;
    JMP EndNoiseSFX                 ;($B58F)End SFX.

BombExplodeSFXStart:
    LDA #$30                        ;Number of frames to play sound before a change.
    LDY #.lobyte(BombExplodeSFXData) ;Lower byte of sound data start address(base=$B200).

GotoSelectSFXRoutine:
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

;The following routine is used to continue BombExplode and SamusWalk SFX.

NoiseSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch02               ;If more frames to process, branch to exit. 

EndNoiseSFX:
    JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    LDA #$10                        ;
    STA NoiseCntrl0                 ;disable envelope generator(sound off).

MusicBranch02:
    RTS                             ;Exit for multiple routines.
 
SamusWalkSFXStart:
    LDA NoiseContSFX                ;If MissileLaunch, SamusWalk or SpitFire SFX are-->
    AND #$34                        ;already being played, branch to exit.
    BNE MusicBranch02               ;
    LDA #$03                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SamusWalkSFXData)  ;Lower byte of sound data start address(base=$B200).
    BNE GotoSelectSFXRoutine                       ;Branch always.

MultiSFXInit:
    STA MultiSFXLength              ;
    JSR LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    JSR UpdateContFlags             ;($B493)Set continue SFX flag.
    LDA #$01                        ;
    STA SQ1InUse                    ;Disable music from using SQ1 and SQ2 while-->
    LDA #$02                        ;SFX are playing.
    STA SQ2InUse                    ;
    LDA #$00                        ;
    STA SQ1ContSFX                  ;
    STA SQ1SFXData                  ;
    STA SQ1SQ2SFXData               ;Clear all listed memory addresses.
    STA SQ1SFXPeriodLow             ;
    STA ThisMultiFrame              ;
    STA WriteMultiChannelData       ;
    RTS                             ;

EndMultiSFX:
    LDA #$10                        ;
    STA SQ1Cntrl0                   ;Disable SQ1 envelope generator(sound off).
    STA SQ2Cntrl0                   ;Disable SQ2 envelope generator(sound off).
    LDA #$7F                        ;
    STA SQ1Cntrl1                   ;Disable SQ1 sweep.
    STA SQ2Cntrl1                   ;Disable SQ2 sweep.
    JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    LDA #$00                        ;
    STA SQ1InUse                    ;
    STA SQ2InUse                    ;Allows music player to use SQ1 and SQ2 channels.
    INC WriteMultiChannelData       ;
    RTS                             ;

BossHitSFXStart:
    LDY #.lobyte(BossHitSQ1SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    LDY #.lobyte(BossHitSQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    JMP MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
    INC SQ1SFXData                  ;Increment index to data in table below.
    LDY SQ1SFXData                  ;
    LDA LB63C,Y                     ;
    STA SQ1Cntrl0                   ;Load SQ1Cntrl0 and SQ2Cntrl0 from table below.
    STA SQ2Cntrl0                   ;
    LDA SQ1SFXData                  ;
    CMP #$14                        ;After #$14 frames, end SFX.
    BEQ LB639                       ;
    CMP #$06                        ;After six or more frames of SFX, branch.
    BCC LB620                       ;
    LDA RandomNumber1               ;
    ORA #$10                        ;Set bit 5.
    AND #$7F                        ;Randomly set bits 7, 3, 2, 1 and 0.
    STA SQ1SFXPeriodLow             ;Store in SQ1 period low.
    ROL                             ;
    STA SQ1SQ2SFXData               ;
    JMP WriteSQ1SQ2PeriodLow        ;($B62C)Write period low data to SQ1 and SQ2.
LB620:
    INC SQ1SQ2SFXData               ;
    INC SQ1SQ2SFXData               ;Increment SQ1 and SQ2 period low by two.
    INC SQ1SFXPeriodLow             ;
    INC SQ1SFXPeriodLow             ;

WriteSQ1SQ2PeriodLow:
    LDA SQ1SQ2SFXData               ;
    STA SQ2Cntrl2                   ;Write new SQ1 and SQ2 period lows to SQ1 and SQ2-->
    LDA SQ1SFXPeriodLow             ;channels.
    STA SQ1Cntrl2                   ;
    RTS                             ;

LB639:
    JMP EndMultiSFX                 ;($B5CD)End SFX.

BossHitSFXDataTbl:
LB63C:  .byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
LB64C:  .byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB658                       ;If more SFX frames to process, branch.
    JMP EndMultiSFX                 ;($B5CD)End SFX.
LB658:
    LDY #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    LDA RandomNumber1               ;
    AND #$0F                        ;Randomly set last four bits of SQ1 period low.
    STA SQ1Cntrl2                   ;
    LDY #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    JSR LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
    LDA RandomNumber1               ;
    LSR                             ;Multiply random number by 4.
    LSR                             ;
    AND #$0F                        ;
    STA SQ2Cntrl2                   ;Randomly set bits 2 and 3 of SQ2 period low.
    RTS                             ;

SamusHitSFXStart:
    LDY #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    LDA RandomNumber1               ;
    AND #$0F                        ;Randomly set last four bits of SQ1 period low.
    STA SQ1Cntrl2                   ;
    CLC                             ;
    LDA RandomNumber1               ;Randomly set last three bits of SQ2 period low+1.
    AND #$03                        ;
    ADC #$01                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SamusHitSQ1SQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    JSR MultiSFXInit                ;($B5A5)Initiate multi channel SFX.
    LDA RandomNumber1               ;
    LSR                             ;Multiply random number by 4.
    LSR                             ;
    AND #$0F                        ;
    STA SQ2Cntrl2                   ;Randomly set bits 2 and 3 of SQ2 period low.
LB694:
    RTS                             ;

IncorrectPasswordSFXStart:
    LDY #.lobyte(IncorrectPasswordSQ1SFXData) ;Low byte of SQ1 sound data start address(base=$B200).
    JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
    LDA #$20                        ;Number of frames to play sound before a change.
    LDY #.lobyte(IncorrectPasswordSQ2SFXData) ;Low byte of SQ2 sound data start address(base=$B200).
    JMP MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB694                       ;If more frames to process, branch to exit.
    JMP EndMultiSFX                 ;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1Cntrl2 data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
    .byte $BD, $8D, $7E, $5E, $46, $3E, $00 

MissilePickupSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch03               ;If more frames to process, branch to exit.
    LDY SQ1SFXData                  ;
    LDA MissilePickupSFXTbl,Y       ;Load SFX data from table above.
    BNE LB6C0                       ;
    JMP EndSQ1SFX                   ;($B6F2)SFX completed.
LB6C0:
    STA SQ1Cntrl2                   ;
    LDA MissilePickupSFXData+3      ;#$28.
    STA SQ1Cntrl3                   ;load SQ1Cntrl3 with #$28.
    INC SQ1SFXData                  ;Increment index to data table above every 5 frames.

MusicBranch03:
    RTS                             ;Exit from multiple routines.

MissilePickupSFXStart:
    LDA #$05                        ;Number of frames to play sound before a change.
    LDY #.lobyte(MissilePickupSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                       ;Branch always.

EnergyPickupSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch03               ;If more frames to process, branch to exit.
    INC SQ1SFXData                  ;
    LDA SQ1SFXData                  ;Every six frames, reload SFX info.  Does it-->
    CMP #$03                        ;three times for a total of 18 frames.
    BEQ EndSQ1SFX                       ;
    LDY #.lobyte(EnergyPickupSFXData) ;
    JMP LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
    LDA #$06                        ;Number of frames to play sound before a change.
    LDY #.lobyte(EnergyPickupSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                       ;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch03               ;

EndSQ1SFX:
    LDA #$10                        ;
    STA SQ1Cntrl0                   ;Disable envelope generator(sound off).
    LDA #$00                        ;
    STA SQ1InUse                    ;Allows music to use SQ1 channel.
    JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
    INC WriteMultiChannelData       ;Allows music routines to load SQ1 and SQ2 music.
    RTS                             ;

SamusJumpSFXStart:
    LDA CurrentMusic                ;If escape music is playing, exit without playing-->
    CMP #$04                        ;Samus jump SFX.
    BEQ MusicBranch03               ;
    LDA #$0C                        ;Number of frames to play sound before a change.
    LDY #.lobyte(JumpSFXData)       ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always.

EnemyHitSFXStart:
    LDA #$08                        ;Number of frames to play sound before a change.
    LDY #.lobyte(EnemyHitSFXData)   ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always.

BulletFireSFXStart:
    LDA HasBeamSFX                  ;
    LSR                             ;If Samus has ice beam, branch.
    BCS HasIceBeamSFXStart          ;
    LDA SQ1ContSFX                  ;If MissilePickup, EnergyPickup, BirdOutOfHole-->
    AND #$CC                        ;or EnemyHit SFX already playing, branch to exit.
    BNE MusicBranch03               ;
    LDA HasBeamSFX                  ;
    ASL                             ;If Samus has long beam, branch.
    BCS HasLongBeamSFXStart         ;
    LDA #$03                        ;Number of frames to play sound before a change.
    LDY #.lobyte(ShortRangeShotSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
    LDA #$07                        ;Number of frames to play sound before a change.
    LDY #.lobyte(LongRangeShotSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always.

MetalSFXStart:
    LDA #$0B                        ;Number of frames to play sound before a change.
    LDY #.lobyte(MetalSFXData)      ;Lower byte of sound data start address(base=$B200).

SelectSFX1:
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
    LDA CurrentMusic                ;If escape music is playing, use this SFX to make-->
    CMP #$04                        ;the bomb ticking sound, else play regular SFX.
    BEQ LB749                       ;
    LDA #$16                        ;Number of frames to play sound before a change.
    LDY #.lobyte(BugOutOFHoleSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always.
LB749:
    LDA #$07                        ;Number of frames to play sound before a change.
    LDY #.lobyte(TimeBombTickSFXData) ;Lower byte of sound data start address(base=$B200).
    BNE SelectSFX1                  ;Branch always.

BulletFireSFXContinue:
    LDA HasBeamSFX                  ;
    LSR                             ;If Samus has ice beam, branch.
    BCS HasIceBeamSFXContinue       ;
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB75D                       ;If more frames to process, branch to exit.
    JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB75D:
    RTS                             ;

HasIceBeamSFXStart:
    LDA #$07                        ;Number of frames to play sound before a change.
    LDY #.lobyte(IceBeamSFXData)    ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

HasIceBeamSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB76D                       ;If more frames to process, branch.
    JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB76D:
    LDA SQ1SFXData                  ;
    AND #$01                        ;Determine index for IceBeamSFXDataTbl below.
    TAY                             ;
    LDA IceBeamSFXDataTbl,Y         ;Loads A with value from IceBeamSFXDataTbl below.
    BNE LoadSQ1PeriodLow            ;

IceBeamSFXDataTbl:
    .byte $93                       ;Ice beam SFX period low data.
    .byte $81                       ;

WaveBeamSFXStart:
    LDA #$08                        ;Number of frames to play sound before a change.
    LDY #.lobyte(WaveBeamSFXData)   ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

WaveBeamSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB797                       ;If more frames to process, branch.
    LDY SQ1SQ2SFXData               ;
    INC SQ1SQ2SFXData               ;Load wave beam SFXDisable/enable envelope length-->
    LDA WaveBeamSFXDisLngthTbl,Y    ;data from WaveBeamSFXDisableLengthTbl.
    STA SQ1Cntrl0                   ;
    BNE MusicBranch10               ;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
    JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB797:
    LDA SQ1SFXData
    AND #$01                        ;
    TAY                             ;Load wave beam SFX period low data from-->
    LDA WaveBeamSFXPeriodLowTbl,Y   ;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
    STA SQ1Cntrl2                   ;Change the period low data for SQ1 channel.
    INC SQ1SFXData                  ;

MusicBranch10:
    RTS                             ;Exit for multiple routines.
 
WaveBeamSFXPeriodLowTbl:
    .byte $58                       ;Wave beam SFX period low data.
    .byte $6F                       ;

WaveBeamSFXDisLngthTbl:
    .byte $93                       ;
    .byte $91                       ;Wave beam SFX Disable/enable envelope length data.
    .byte $00                       ;

DoorOpenCloseSFXStart:
    LDA DoorSFXData+2               ;#$30.
    STA TrianglePeriodLow           ;Set triangle period low data byte.
    LDA DoorSFXData+3               ;#$B2.
    AND #$07                        ;Set triangle period high data byte.
    STA TrianglePeriodHigh          ;#$B7.
    LDA #$0F                        ;
    STA TriangleChangeLow           ;Change triangle channel period low every frame by #$0F.
    LDA #$00                        ;
    STA TriangleChangeHigh          ;No change in triangle channel period high.
    LDA #$1F                        ;Number of frames to play sound before a change.
    LDY #.lobyte(DoorSFXData)       ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB7D3                       ;
        JMP EndTriangleSFX              ;($B896)End SFX.
    LB7D3:
    JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
    JMP WriteTrianglePeriods        ;($B869)Save new periods.

BeepSFXStart:
    LDA TriangleContSFX             ;If BombLaunchSFX is already playing, branch-->
    AND #$80                        ;without playing BeepSFX.
    BNE MusicBranch10               ;
    LDA #$03                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SamusBeepSFXData)  ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BeepSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch10               ;If more frames to process, branch to exit.
    JMP EndTriangleSFX              ;($B896)End SFX.

BigEnemyHitSFXStart:
    LDA #$12                        ;Increase triangle low period by #$12 every frame.
    STA TriangleChangeLow           ;
    LDA #$00                        ;
    STA TriangleChangeHigh          ;Does not change triangle period high.
    LDA BigEnemyHitSFXData+2        ;#$42.
    STA TrianglePeriodLow           ;Save new triangle period low data.
    LDA BigEnemyHitSFXData+3        ;#$18.
    AND #$07                        ;#$1F.
    STA TrianglePeriodHigh          ;Save new triangle period high data.
    LDA #$0A                        ;Number of frames to play sound before a change.
    LDY #.lobyte(BigEnemyHitSFXData) ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE @+                          ;If more frames to process, branch
        JMP EndTriangleSFX              ;($B896)End SFX
@:  JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
    LDA RandomNumber1               ;
    AND #$3C                        ;
    STA TriangleSFXData             ;
    LDA TrianglePeriodLow           ;Randomly set or clear bits 2, 3, 4 and 5 in-->
    AND #$C3                        ;triangle channel period low.
    ORA TriangleSFXData             ;
    STA TriangleCntrl2              ;
    LDA TrianglePeriodHigh          ;
    ORA #$40                        ;Set 4th bit in triangle channel period high.
    STA TriangleCntrl3              ;
    RTS                             ;

SamusToBallSFXStart:
    LDA #$08                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SamusToBallSFXData) ;Lower byte of sound data start address(base=$B200).
    JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
    LDA #$05                        ;
    STA PercentDifference           ;Stores percent difference. In this case 5 = 1/5 = 20%.
    LDA SamusToBallSFXData+2        ;#$DD.
    STA TrianglePeriodLow           ;Save new triangle period low data.
    LDA SamusToBallSFXData+3        ;#$3B.
    AND #$07                        ;#$02.
    STA TrianglePeriodHigh          ;Save new triangle period high data.
    RTS                             ;

SamusToBallSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB857                       ;If more frames to process, branch.
    JMP EndTriangleSFX              ;($B896)End SFX.
LB857:
    JSR DivideTrianglePeriods       ;($B9A0)reduces triangle period low by 20% each frame.
    LDA TriangleLowPercentage       ;
    STA TriangleChangeLow           ;Store new values to change triangle periods.
    LDA TriangleHighPercentage      ;
    STA TriangleChangeHigh          ;
    JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.

WriteTrianglePeriods:
    LDA TrianglePeriodLow           ;Write TrianglePeriodLow to triangle channel.
    STA TriangleCntrl2              ;
    LDA TrianglePeriodHigh          ;
    ORA #$08                        ;Write TrianglePeriodHigh to triangle channel.
    STA TriangleCntrl3              ;
    RTS                             ;

BombLaunchSFXStart:
    LDA #$04                        ;Number of frames to play sound before a change.
    LDY #.lobyte(BombLaunch1SFXData) ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE MusicBranch04               ;If more frames to process, branch to exit.
    INC TriangleSFXData             ;
    LDA TriangleSFXData             ;After four frames, load second part of SFX.
    CMP #$02                        ;
    BNE LB891                       ;
    JMP EndTriangleSFX              ;($B896)End SFX.
LB891:
    LDY #.lobyte(BombLaunch2SFXData) ;Lower byte of sound data start address(base=$B200).
    JMP LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.

EndTriangleSFX:
    LDA #$00                        ;
    STA TriangleCntrl0              ;clear TriangleCntr0(sound off).
    STA TriangleInUse               ;Allows music to use triangle channel.
    LDA #$18                        ;
    STA TriangleCntrl3              ;Set length index to #$03.
    JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.

MusicBranch04:
    RTS                             ;Exit from for multiple routines.

MetroidHitSFXStart:
    LDA #$03                        ;Number of frames to play sound before a change.
    LDY #.lobyte(MetroidHitSFXData) ;Lower byte of sound data start address(base=$B200).
    JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
    JMP RndTrianglePeriods          ;($B8C3)MetroidHit SFX has several different sounds.

MetroidHitSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BEQ RndTrianglePeriods          ;
    INC TriangleSFXData             ;
    LDA TriangleSFXData             ;Randomize triangle periods nine times throughout-->
    CMP #$09                        ;the course of the SFX.
    BNE MusicBranch04               ;If SFX not done, branch.
    JMP EndTriangleSFX              ;($B896)End SFX.

RndTrianglePeriods:
    LDA RandomNumber1               ;Randomly set or reset bits 7, 4, 2 and 1 of-->
    ORA #$6C                        ;triangle channel period low.
    STA TriangleCntrl2              ;
    AND #$01                        ;
    ORA #$F8                        ;Randomly set or reset last bit of triangle-->
    STA TriangleCntrl3              ;channel period high.
    RTS                             ;

SamusDieSFXStart:
    JSR InitializeSoundAddresses    ;($B404)Clear all sound addresses.
    LDA #$0E                        ;Number of frames to play sound before a change.
    LDY #.lobyte(SamusDieSFXData)   ;Lower byte of sound data start address(base=$B200).
    JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
    LDA #$15                        ;Decrease triangle SFX periods by 4.8% every frame.
    STA PercentDifference           ;
    LDA SamusDieSFXData+2           ;#$40.
    STA TrianglePeriodLow           ;
    LDA #$00                        ;Initial values of triangle periods.
    STA TrianglePeriodHigh          ;
LB8EC:
    RTS                             ;

SamusDieSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB90C                       ;
        LDA #$20                        ;Store change in triangle period low.
        STA TriangleChangeLow           ;
        LDA #$00                        ;
        STA TriangleChangeHigh          ;No change in triangle period high.
        JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
        INC TriangleSFXData             ;
        LDA TriangleSFXData             ;
        CMP #$06                        ;
        BNE LB8EC                       ;If more frames to process, branch to exit.
        JMP EndTriangleSFX              ;($B896)End SFX.
    LB90C:
    JSR DivideTrianglePeriods       ;($B9A0)reduces triangle period low.
    LDA TriangleLowPercentage       ;
    STA TriangleChangeLow           ;Update triangle periods.
    LDA TriangleHighPercentage      ;
    STA TriangleChangeHigh          ;
    JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
    JMP WriteTrianglePeriods        ;($B869)Save new periods.

StatueRaiseSFXStart:
    LDA StatueRaiseSFXData+2        ;#$11.
    STA TrianglePeriodLow           ;Save period low data.
    LDA StatueRaiseSFXData+3        ;#$09.
    AND #$07                        ;
    STA TrianglePeriodHigh          ;Store last three bits in $B284.
    LDA #$00                        ;
    STA TriangleChangeHigh          ;No change in Triangle period high.
    LDA #$0B                        ;
    STA TriangleChangeLow           ;
    LDA #$06                        ;Number of frames to play sound before a change.
    LDY #.lobyte(StatueRaiseSFXData) ;Lower byte of sound data start address(base=$B200).
    JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
    JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
    BNE LB972                       ;
        INC TriangleSFXData             ;Increment TriangleSFXData every 6 frames.
        LDA TriangleSFXData             ;
        CMP #$09                        ;When TriangleSFXData = #$09, end SFX.
        BNE LB952                       ;
            JMP EndTriangleSFX              ;($B896)End SFX.
        LB952:
        LDA TriangleChangeLow           ;
        PHA                             ;Save triangle periods.
        LDA TriangleChangeHigh          ;
        PHA                             ;
        LDA #$25                        ;
        STA TriangleChangeLow           ;
        LDA #$00                        ;No change in triangle period high.
        STA TriangleChangeHigh          ;
        JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
        PLA                             ;
        STA TriangleChangeHigh          ;Restore triangle periods.
        PLA                             ;
        STA TriangleChangeLow           ;
        JMP WriteTrianglePeriods        ;($B869)Save new periods.
    LB972:
    JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
    JMP WriteTrianglePeriods        ;($B869)Save new periods.

IncreaseTrianglePeriods:
    CLC 
    LDA TrianglePeriodLow           ;
    ADC TriangleChangeLow           ;Calculate new TrianglePeriodLow.
    STA TrianglePeriodLow           ;
    LDA TrianglePeriodHigh          ;
    ADC TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
    STA TrianglePeriodHigh          ;
    RTS                             ;

DecreaseTrianglePeriods:
    SEC 
    LDA TrianglePeriodLow           ;
    SBC TriangleChangeLow           ;Calculate new TrianglePeriodLow.
    STA TrianglePeriodLow           ;
    LDA TrianglePeriodHigh          ;
    SBC TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
    STA TrianglePeriodHigh          ;
    RTS                             ;

DivideTrianglePeriods:
    LDA TrianglePeriodLow           ;
    PHA                             ;Store TrianglePeriodLow and TrianglePeriodHigh.
    LDA TrianglePeriodHigh          ;
    PHA                             ;
    LDA #$00                        ;
    STA DivideData                  ;
    LDX #$10                        ;
    ROL TrianglePeriodLow           ;
    ROL TrianglePeriodHigh          ;
    LB9B5:
        ROL DivideData                  ;The following routine takes the triangle period-->
        LDA DivideData                  ;high and triangle period low values and reduces-->
        CMP PercentDifference           ;them by a certain percent.  The percent is-->
        BCC LB9C6                       ;determined by the value stored in-->
            SBC PercentDifference           ;PercentDifference.  If PercentDifference=#$05,-->
            STA DivideData                  ;then the values will be reduced by 20%(1/5).-->
        LB9C6:
        ROL TrianglePeriodLow           ;If PercentDifference=#$0A,Then the value will-->
        ROL TrianglePeriodHigh          ;be reduced by 10%(1/10), etc. This function is-->
        DEX                             ;basically a software emulation of a sweep function.
        BNE LB9B5                       ;
    LDA TrianglePeriodLow           ;
    STA TriangleLowPercentage       ;
    LDA TrianglePeriodHigh          ;
    STA TriangleHighPercentage      ;
    PLA                             ;
    STA TrianglePeriodHigh          ;Restore TrianglePerodLow and TrianglePeriodHigh.
    PLA                             ;
    STA TrianglePeriodLow           ;
    RTS                             ;

;--------------------------------------[ End SFX routines ]-------------------------------------
 
SetVolumeAndDisableSweep:
    LDA #$7F                        ;
    STA MusicSQ1Sweep               ;Disable sweep generator on SQ1 and SQ2.
    STA MusicSQ2Sweep               ;
    STX SQ1DutyEnvelope             ;Store duty cycle and volume data for SQ1 and SQ2.
    STY SQ2DutyEnvelope             ;
    RTS                             ;

ResetVolumeIndex:
    LDA SQ1MusicFrameCount          ;If at the beginning of a new SQ1 note, set-->
    CMP #$01                        ;SQ1VolumeIndex = #$01.
    BNE LB9FD                       ;
        STA SQ1VolumeIndex              ;
    LB9FD:
    LDA SQ2MusicFrameCount          ;
    CMP #$01                        ;If at the beginning of a new SQ2 note, set-->
    BNE LBA07                       ;SQ2VolumeIndex = #$01.
        STA SQ2VolumeIndex              ;
    LBA07:
    RTS                             ;

LoadSQ1SQ2Periods:
    LDA WriteMultiChannelData       ;If a Multi channel data does not need to be-->
    BEQ LBA36                       ;loaded, branch to exit.
    LDA #$00                        ;
    STA WriteMultiChannelData       ;Clear multi channel data write flag.
    LDA MusicSQ1Sweep               ;
    STA SQ1Cntrl1                   ;
    LDA MusicSQ1PeriodLow           ;
    STA SQ1Cntrl2                   ;Loads SQ1 channel addresses $4001, $4002, $4003.
    LDA MusicSQ1PeriodHigh          ;
    STA SQ1Cntrl3                   ;
    LDA MusicSQ2Sweep               ;
    STA SQ2Cntrl1                   ;
    LDA MusicSQ2PeriodLow           ;
    STA SQ2Cntrl2                   ;Loads SQ2 channel addresses $4005, $4006, $4007.
    LDA MusicSQ2PeriodHigh          ;
    STA SQ2Cntrl3                   ;
LBA36:
    RTS                             ;

LoadSQ1SQ2Channels:
    LDX #$00                        ;Load SQ1 channel data.
    JSR WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    INX                             ;Load SQ2 channel data.
    JSR WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
    RTS                             ;

WriteSQCntrl0:
    LDA SQ1VolumeCntrl,X            ;Load SQ channel volume data. If zero, branch to exit.
    BEQ LBA8B                       ;
    STA VolumeCntrlAddress          ;
    JSR LoadSQ1SQ2Periods           ;($BA08)Load SQ1 and SQ2 control information.
    LDA SQ1VolumeData,X             ;
    CMP #$10                        ;If sound channel is not currently-->
    BEQ LBA99                       ;playing sound, branch.
    LDY #$00                        ;
    LBA54:
        DEC VolumeCntrlAddress          ;Desired entry in VolumeCntrlAdressTbl.
        BEQ LBA5C                       ;
        INY                             ;*2(2 byte address to find voulume control data).
        INY                             ;
        BNE LBA54                       ;Keep decrementing until desired address is found.
LBA5C:
    LDA VolumeCntrlAddressTbl,Y     ;Base is $BCB0.
    STA $EC                         ;Volume data address low byte.
    LDA VolumeCntrlAddressTbl+1,Y   ;Base is $BCB1.
    STA $ED                         ;Volume data address high byte.
    LDY SQ1VolumeIndex,X            ;Index to desired volume data.
    LDA ($EC),Y                     ;Load desired volume for current channel into-->
    STA Cntrl0Data                  ;Cntrl0Data.
    CMP #$FF                        ;If last entry in volume table is #$FF, restore-->
    BEQ MusicBranch05               ;volume to its original level after done reading-->
    CMP #$F0                        ;Volume data.  If #$F0 is last entry, turn sound-->
    BEQ MusicBranch06               ;off on current channel until next note.
    LDA SQ1DutyEnvelope,X           ;Remove duty cycle data For current channel and-->
    AND #$F0                        ;add this frame of volume data and store results--> 
    ORA Cntrl0Data                  ;in Cntrl0Data.
    TAY                             ;
LBA7D:
    INC SQ1VolumeIndex,X            ;Increment Index to volume data.
LBA80:
    LDA SQ1InUse,X                  ;If SQ1 or SQ2(depends on loop iteration) in use,-->
    BNE LBA8B                       ;branch to exit, else write SQ(1 or 2)Cntrl0.
    TXA                             ;
    BEQ WriteSQ1Cntrl0              ;If currently on SQ1, branch to write SQ1 data.

WriteSQ2Cntrl0:                         ;
    STY SQ2Cntrl0                   ;Write SQ2Cntrl0 data.
LBA8B:
    RTS                             ;

WriteSQ1Cntrl0:                         ;
    STY SQ1Cntrl0                   ;Write SQ1Cntrl0 data.
    RTS                             ;

MusicBranch05:
    LDY SQ1DutyEnvelope,X           ;Restore original volume of sound channel.
    BNE LBA80                       ;Branch always.

MusicBranch06:
    LDY #$10                        ;Disable envelope generator and set volume to 0.
    BNE LBA80                       ;Branch always.
LBA99:
    LDY #$10                        ;Disable envelope generator and set volume to 0.
    BNE LBA7D                       ;Branch always.

GotoCheckRepeatMusic:
    JSR CheckRepeatMusic            ;($B3F0)Resets music flags if music repeats.
    RTS                             ;

GotoLoadSQ1SQ2Channels:
    JSR LoadSQ1SQ2Channels          ;($BA37)Load SQ1 and SQ2 channel data.
    RTS                             ;

LoadCurrentMusicFrameData:
    JSR ResetVolumeIndex            ;($B9F3)Reset index if at the beginning of a new note.
    LDA #$00                        ;
    TAX                             ;X = #$00.
    STA ThisSoundChannel            ;(#$00, #$04, #$08 or #$0C).
    BEQ LBAC2                       ;
LBAB0:
    TXA                             ;
    LSR                             ;
    TAX                             ;Increment to next sound channel(1,2 or 3).

IncrementToNextChannel:                 ;
    INX                             ;
    TXA                             ;
    CMP #$04                        ;If done with four sound channels, branch to load-->
    BEQ GotoLoadSQ1SQ2Channels      ;sound channel SQ1 SQ2 data.
    LDA ThisSoundChannel            ;Add 4 to the least significant byte of the current-->
    CLC                             ;sound channel start address.  This moves to next-->
    ADC #$04                        ;sound channel address ranges to process.
    STA ThisSoundChannel            ;
LBAC2:
    TXA                             ;
    ASL                             ;*2(two bytes for sound channel info base address).
    TAX                             ;
    LDA SQ1LowBaseByte,X            ;
    STA $E6                         ;Load sound channel info base address into $E6-->
    LDA SQ1HighBaseByte,X           ;and $E7. ($E6=low byte, $E7=high byte).
    STA $E7                         ;
    LDA SQ1HighBaseByte,X           ;If no data for this sound channel, branch-->
    BEQ LBAB0                       ;to find data for next sound channel.
    TXA                             ;
    LSR                             ;/2. Determine current sound channel (0,1,2 or3).
    TAX                             ;
    DEC SQ1MusicFrameCount,X        ;Decrement the current sound channel frame count-->
    BNE IncrementToNextChannel      ;If not zero, branch to check next channel, else-->
                                        ;load the next set of sound channel data.
LoadNextChannelIndexData:
    LDY SQ1MusicIndexIndex,X        ;Load current channel index to music data index.
    INC SQ1MusicIndexIndex,X        ;Increment current channel index to music data index.
    LDA ($E6),Y                     ;
    BEQ GotoCheckRepeatMusic        ;Branch if music has reached the end.
    TAY                             ;Transfer music data index to Y (base=$BE77) .
    CMP #$FF                        ;
    BEQ RepeatMusicLoop             ;At end of loop? If yes, branch.
    AND #$C0                        ;
    CMP #$C0                        ;At beginnig of new loop? if yes, branch.
    BEQ StartNewMusicLoop           ;
    JMP LoadMusicChannel            ;($BB1C)Load music data into channel.

RepeatMusicLoop:
    LDA SQ1RepeatCounter,X          ;If loop counter has reached zero, branch to exit.
    BEQ LBB13                       ;
    DEC SQ1RepeatCounter,X          ;Decrement loop counter.
    LDA SQ1LoopIndex,X              ;Load loop index for proper channel and store it in-->
    STA SQ1MusicIndexIndex,X        ;music index index address.
    BNE LBB13                       ;Branch unless music has reached the end.

StartNewMusicLoop:
    TYA                             ;
    AND #$3F                        ;Remove last six bits of loop controller and save-->
    STA SQ1RepeatCounter,X          ;in repeat counter addresses.  # of times to loop.
    DEC SQ1RepeatCounter,X          ;Decrement loop counter.
    LDA SQ1MusicIndexIndex,X        ;Store location of loop start in loop index address.
    STA SQ1LoopIndex,X              ;
LBB13:
    JMP LoadNextChannelIndexData    ;($BADC)Load next channel index data.

LBB16:
    JMP LoadNoiseChannelMusic       ;($BBDE)Load data for noise channel music.

LBB19:
    JMP LoadTriangleCntrl0          ;($BBB7)Load Cntrl0 byte of triangle channel.

LoadMusicChannel:
    TYA                             ;
    AND #$B0                        ;
    CMP #$B0                        ;Is data byte music note length data?  If not, branch.
    BNE LBB40                       ;
    TYA                             ;
    AND #$0F                        ;Separate note length data.
    CLC                             ;
    ADC NoteLengthTblOffset         ;Find proper note lengths table for current music.
    TAY                             ;
    LDA NoteLengths0Tbl,Y           ;(Base is $BEF7)Load note length and store in--> 
    STA SQ1FrameCountInit,X         ;frame count init address.
    TAY                             ;Y now contains note length.
    TXA                             ;
    CMP #$02                        ;If loading Triangle channel data, branch.
    BEQ LBB19                       ;

LoadSoundDataIndexIndex:
    LDY SQ1MusicIndexIndex,X        ;Load current index to sound data index.
    INC SQ1MusicIndexIndex,X        ;Increment music index index address.
    LDA ($E6),Y                     ;Load index to sound channel music data.
    TAY                             ;
LBB40:
    TXA                             ;
    CMP #$03                        ;If loading Noise channel data, branch.
    BEQ LBB16                       ;
    PHA                             ;Push music channel number on stack(0, 1 or 2).
    LDX ThisSoundChannel            ;
    LDA MusicNotesTbl+1,Y           ;(Base=$BE78)Load A with music channel period low data.
    BEQ LBB59                       ;If data is #$00, skip period high and low loading.
    STA MusicSQ1PeriodLow,X         ;Store period low data in proper period low address.
    LDA MusicNotesTbl,Y             ;(Base=$BE77)Load A with music channel period high data.
    ORA #$08                        ;Ensure minimum index length of 1.
    STA MusicSQ1PeriodHigh,X        ;Store period high data in proper period high address.
LBB59:
    TAY                             ;
    PLA                             ;Pull stack and restore channel number to X.
    TAX                             ;
    TYA                             ;
    BNE PeriodInformationFound      ;If period information was present, branch.
    NoPeriodInformation:
        LDA #$00                        ;Turn off channel volume since no period data present.
        STA Cntrl0Data                  ;
        TXA                             ;
        CMP #$02                        ;If loading triangle channel data, branch.
        BEQ LBB73                       ;
        LDA #$10                        ;Turn off volume and disable env. generator(SQ1,SQ2).
        STA Cntrl0Data                  ;
        BNE LBB73                       ;Branch always.
    PeriodInformationFound:
        LDA SQ1DutyEnvelope,X           ;Store channel duty cycle and volume info in $EA.
        STA Cntrl0Data                  ;
    LBB73:
    TXA                             ;
    DEC SQ1InUse,X                  ;
    CMP SQ1InUse,X                  ;If SQ1 or SQ2 are being used by SFX routines, branch.
    BEQ SQ1SQ2InUse                 ;
    INC SQ1InUse,X                  ;Restore not in use status of SQ1 or SQ2.
    LDY ThisSoundChannel            ;
    TXA                             ;
    CMP #$02                        ;If loading triangle channel data, branch.
    BEQ LBB8C                       ;
    LDA SQ1VolumeCntrl,X            ;If $062E or $062F has volume data, skip writing-->
    BNE LBB91                       ;Cntrl0Data to SQ1 or SQ2.
LBB8C:
    LDA Cntrl0Data                  ;
    STA SQ1Cntrl0,Y                 ;Write Cntrl0Data.
LBB91:
    LDA Cntrl0Data                  ;
    STA SQ1VolumeData,X             ;Store volume data index to volume data.
    LDA MusicSQ1PeriodLow,Y         ;
    STA SQ1Cntrl2,Y                 ;
    LDA MusicSQ1PeriodHigh,Y        ;Write data to three sound channel addresses.
    STA SQ1Cntrl3,Y                 ;
    LDA MusicSQ1Sweep,X             ;
    STA SQ1Cntrl1,Y                 ;

LoadNewMusicFrameCount:
    LDA SQ1FrameCountInit,X         ;Load new music frame count and store it in music-->
    STA SQ1MusicFrameCount,X        ;frame count address.
    JMP IncrementToNextChannel      ;($BAB3)Move to next sound channel.

SQ1SQ2InUse:
    INC SQ1InUse,X                  ;Restore in use status of SQ1 or SQ1.
    JMP LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

LoadTriangleCntrl0:
    LDA TriangleCounterCntrl        ;
    AND #$0F                        ;If lower bits set, branch to play shorter note. 
    BNE LBBD8                       ;
    LDA TriangleCounterCntrl        ;
    AND #$F0                        ;If upper bits are set, branch to play longer note.
    BNE LBBC9                       ;
    TYA                             ;
    JMP AddTriangleLength           ;($BBCD)Calculate length to play note.
LBBC9:
    LDA #$FF                        ;Disable length cntr(play until triangle data changes).
    BNE LBBD8                       ;Branch always.

AddTriangleLength:
    CLC                             ;
    ADC #$FF                        ;Add #$FF(Effectively subtracts 1 from A).
    ASL                             ;*2.
    ASL                             ;*2.
    CMP #$3C                        ;
    BCC LBBD8                       ;If result is greater than #$3C, store #$3C(highest-->
    LDA #$3C                        ;triangle linear count allowed).
LBBD8:
    STA TriLinearCount              ;
    JMP LoadSoundDataIndexIndex     ;($BB37)Load index to sound data index.

LoadNoiseChannelMusic:
    LDA NoiseContSFX                ;
    AND #$FC                        ;If playing any Noise SFX, branch to exit.
    BNE LBBF7                       ;
        LDA SFXData,Y                     ;
        STA NoiseCntrl0                 ;Load noise channel with drum beat SFX starting-->
        LDA SFXData+1,Y                   ;at address B201.  The possible values of Y are-->
        STA NoiseCntrl2                 ;#$01, #$04, #$07 or #$0A.
        LDA SFXData+2,Y                   ;
        STA NoiseCntrl3                 ;
    LBBF7:
    JMP LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

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
    LDA CurrentMusicRepeat          ;Load A with temp music flags, (9th SFX cycle).
    LDX #.lobyte(MusicInitPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
    BNE LBC42                       ;Branch always.

LoadMusicInitFlags:
    LDA MusicInitFlag               ;Load A with Music flags, (10th SFX cycle).
    LDX #.lobyte(MusicContPointers) ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:
    JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
    JSR FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
    JMP ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.

ContinueMusic:                          ;11th and last SFX cycle.
    LDA CurrentMusic                ;
    BEQ LBC76                       ;Branch to exit of no music playing.
    JMP LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

;MusicInitIndex values correspond to the following music:
;#$00=Ridley area music, #$01=Tourian music, #$02=Item room music, #$03=Kraid area music,
;#$04=Norfair music, #$05=Escape music, #$06=Mother brain music, #$07=Brinstar music,
;#$08=Fade in music, #$09=Power up music, #$0A=End game music, #$0B=Intro music.

FindMusicInitIndex:
    LDA #$FF                        ;Load MusicInitIndex with #$FF.
    STA MusicInitIndex              ;
    LDA CurrentSFXFlags             ;
    BEQ LBC63                       ;Branch to exit if no SFX flags set for Multi SFX.
    LBC5D:
        INC MusicInitIndex              ;
        ASL                             ;Shift left until bit flag is in carry bit.
        BCC LBC5D                       ;Loop until SFX flag found.  Store bit-->
LBC63:
    RTS                             ;number of music in MusicInitIndex.

;The following routine is used to add eight to the music index when looking for music flags
;in the MultiSFX address.  
Add8:
    LDA MusicInitIndex              ;
    CLC                             ;
    ADC #$08                        ;Add #$08 to MusicInitIndex.
    STA MusicInitIndex              ;
    RTS                             ;

    LDA CurrentMusic                ;
    ORA #$F0                        ;This code does not appear to be used in this page.
    STA CurrentMusic                ;
LBC76:
    RTS                             ;

Music00Start:
    JMP Music00Init                 ;($BCAA)Initialize music 00.

Music01Start:
    JMP Music01Init                 ;($BCA4)Initialize music 01.

Music02Start:
    JMP Music02Init                 ;($BC9A)Initialize music 02.

Music03Start:
    JMP Music03Init                 ;($BC96)Initialize music 03.

Music04Start:
    JMP Music04Init                 ;($BC89)Initialize music 04.

Music05Start:
    JMP Music05Init                 ;($BC9E)Initialize music 05.

Music04Init:
    LDA #$B3                        ;Duty cycle and volume data for SQ1 and SQ2.

XYMusicInit:
    TAX                             ;Duty cycle and volume data for SQ1.
    TAY                             ;Duty cycle and volume data for SQ2.

LBC8D:
    JSR SetVolumeAndDisableSweep    ;($B9E4)Set duty cycle and volume data for SQ1 and SQ2.
    JSR InitializeMusic             ;($BF19)Setup music registers.
    JMP LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

Music03Init:
    LDA #$34                        ;Duty cycle and volume data for SQ1 and SQ2.
    BNE XYMusicInit                 ;Branch always

Music02Init:
    LDA #$F4                        ;Duty cycle and volume data for SQ1 and SQ2.
    BNE XYMusicInit                 ;Branch always

Music05Init:
    LDX #$F5                        ;Duty cycle and volume data for SQ1.
    LDY #$F6                        ;Duty cycle and volume data for SQ2.
    BNE LBC8D                       ;Branch always

Music01Init:
    LDX #$B6                        ;Duty cycle and volume data for SQ1.
    LDY #$F6                        ;Duty cycle and volume data for SQ2.
    BNE LBC8D                       ;Branch always

Music00Init:
    LDX #$92                        ;Duty cycle and volume data for SQ1.
    LDY #$96                        ;Duty cycle and volume data for SQ2.
    BNE LBC8D                       ;Branch always

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
    JSR CheckMusicFlags             ;($B3FC)Check to see if restarting current music.
    LDA CurrentSFXFlags             ;Load current SFX flags and store CurrentMusic address.
    STA CurrentMusic                ;
    LDA MusicInitIndex              ;
    TAY                             ;
    LDA InitMusicIndexTbl,Y         ;($BBFA)Find index for music in InitMusicInitIndexTbl.
    TAY                             ;
    LDX #$00                        ;
    LBF2C:
        LDA SongHeaders,Y              ;Base is $BD31.
        STA NoteLengthTblOffset,X       ;
        INY                             ;The following loop repeats 13 times to-->
        INX                             ;load the initial music addresses -->
        TXA                             ;(registers $062B thru $0637).
        CMP #$0D                        ;
        BNE LBF2C                       ;
    LDA #$01                        ;Resets addresses $0640 thru $0643 to #$01.-->
    STA SQ1MusicFrameCount          ;These addresses are used for counting the-->
    STA SQ2MusicFrameCount          ;number of frames music channels have been playing.
    STA TriangleMusicFrameCount     ;
    STA NoiseMusicFrameCount        ;
    LDA #$00                        ;
    STA SQ1MusicIndexIndex          ;
    STA SQ2MusicIndexIndex          ;Resets addresses $0638 thru $063B to #$00.-->
    STA TriangleMusicIndexIndex     ;These are the index to find sound channel data index.
    STA NoiseMusicIndexIndex        ;
    RTS                             ;

;Not used.
    .byte $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $2C, $B4, $AD
    .byte $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9, $2A, $BC, $A8, $A2, $00, $B9
    .byte $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40
    .byte $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D
    .byte $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
