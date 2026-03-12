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
;Disassembled, reconstructed and commented
;by SnowBro [Kent Hansen] <kentmhan@online.no>
;Continued by Dirty McDingus (nmikstas@yahoo.com)
;A work in progress.

;Metroid defines.


.include "memory_layout.asm"


.stringmaptable charmap "charmap.tbl"


;------------------------------------------[ Misc. defines ]-----------------------------------------

;Special item types.
.enumid 1 export
.enumid it_Squeept             ;$1
.enumid it_PowerUp             ;$2
.enumid it_Mellow              ;$3
.enumid it_Elevator            ;$4
.enumid it_Cannon              ;$5   ;High nibble is Cannons.0.instrListID
.enumid it_MotherBrain         ;$6
.enumid it_Zebetite            ;$7   ;High nibble is Zebetite slot ID
.enumid it_RinkaSpawner        ;$8
.enumid it_Door                ;$9
.enumid it_PaletteChange       ;$A

;Power up id for items
.enumid 0 export
.enumid pu_BOMBS               ;$00
.enumid pu_HIGHJUMP            ;$01
.enumid pu_LONGBEAM            ;$02
.enumid pu_SCREWATTACK         ;$03
.enumid pu_MARUMARI            ;$04
.enumid pu_VARIA               ;$05
.enumid pu_WAVEBEAM            ;$06
.enumid pu_ICEBEAM             ;$07
.enumid pu_ENERGYTANK          ;$08
.enumid pu_MISSILES            ;$09

;Bitmask defs used for SamusGear.
gr_BOMBS               = %00000001 export
gr_HIGHJUMP            = %00000010 export
gr_LONGBEAM            = %00000100 export
gr_SCREWATTACK         = %00001000 export
gr_MARUMARI            = %00010000 export
gr_VARIA               = %00100000 export
gr_WAVEBEAM            = %01000000 export
gr_ICEBEAM             = %10000000 export


;unique items IIIIII
.enumid 0 step 1<<10 export
.enumid ui_BOMBS               ;%000000 << 10
.enumid ui_HIGHJUMP            ;%000001 << 10
.enumid ui_LONGBEAM            ;%000010 << 10 ;(Not considered a unique item).
.enumid ui_SCREWATTACK         ;%000011 << 10
.enumid ui_MARUMARI            ;%000100 << 10
.enumid ui_VARIA               ;%000101 << 10
.enumid ui_WAVEBEAM            ;%000110 << 10 ;(Not considered a unique item).
.enumid ui_ICEBEAM             ;%000111 << 10 ;(Not considered a unique item).
.enumid ui_ENERGYTANK          ;%001000 << 10
.enumid ui_MISSILES            ;%001001 << 10
.enumid ui_MISSILEDOOR         ;%001010 << 10
.enumid 14<<10 step 1<<10 export
.enumid ui_MOTHERBRAIN         ;%001110 << 10
.enumid ui_ZEBETITE1           ;%001111 << 10
.enumid ui_ZEBETITE2           ;%010000 << 10
.enumid ui_ZEBETITE3           ;%010001 << 10
.enumid ui_ZEBETITE4           ;%010010 << 10
.enumid ui_ZEBETITE5           ;%010011 << 10

;Samus action handlers.
.enumid 0 export
.enumid sa_Stand               ;0
.enumid sa_Run                 ;1       ;Also run and jump.
.enumid sa_Jump                ;2
.enumid sa_Roll                ;3
.enumid sa_PntUp               ;4
.enumid sa_Door                ;5
.enumid sa_PntJump             ;6
.enumid sa_Dead                ;7
.enumid sa_Dead2               ;8       ;Also after time bomb exploded.
.enumid sa_Elevator            ;9
sa_Begin               = 255 export

;Weapon action handlers.
.enumid 1 export
.enumid wa_RegularBeam         ;$01
.enumid wa_WaveBeam            ;$02
.enumid wa_IceBeam             ;$03
.enumid wa_BulletExplode       ;$04
.enumid 7 export
.enumid wa_Unknown7            ;$07
.enumid wa_LayBomb             ;$08
.enumid wa_BombCount           ;$09
.enumid wa_BombExplode         ;$0A
.enumid wa_Missile             ;$0B
wa_ScrewAttack         = $81 export

;Enemy Status
.enumid 0 export
.enumid enemyStatus_NoEnemy    ;0
.enumid enemyStatus_Resting    ;1
.enumid enemyStatus_Active     ;2
.enumid enemyStatus_Explode    ;3
.enumid enemyStatus_Frozen     ;4
.enumid enemyStatus_Pickup     ;5
.enumid enemyStatus_Hurt       ;6
; greater than 6 is the same as no enemy

;Sound flags
;sfxNoise_80            = %10000000
sfxNoise_ScrewAttack   = %01000000 export
sfxNoise_MissileLaunch = %00100000 export
sfxNoise_BombExplode   = %00010000 export
sfxNoise_SamusWalk     = %00001000 export
sfxNoise_SpitFlame     = %00000100 export
sfxNoise_PauseMusic    = %00000010 export
sfxNoise_SilenceMusic  = %00000001 export

sfxSQ1_MissilePickup   = %10000000 export
sfxSQ1_EnergyPickup    = %01000000 export
sfxSQ1_Metal           = %00100000 export
sfxSQ1_BulletFire      = %00010000 export
sfxSQ1_OutOfPipe       = %00001000 export
sfxSQ1_EnemyHit        = %00000100 export
sfxSQ1_SamusJump       = %00000010 export
sfxSQ1_WaveFire        = %00000001 export

sfxTri_SamusDie        = %10000000 export
sfxTri_Door            = %01000000 export
sfxTri_MetroidHit      = %00100000 export
sfxTri_StatueRaise     = %00010000 export
sfxTri_Beep            = %00001000 export
sfxTri_BigEnemyHit     = %00000100 export
sfxTri_SamusBall       = %00000010 export
sfxTri_BombLaunch      = %00000001 export

sfxMulti_Intro         = %10000000 export
sfxMulti_PowerUp       = %01000000 export
sfxMulti_EndMusic      = %00100000 export
sfxMulti_IntroMusic    = %00010000 export
;sfxMulti_08            = %00001000
sfxMulti_SamusHit      = %00000100 export
sfxMulti_BossHit       = %00000010 export
sfxMulti_IncorrectPassword = %00000001 export

music_RidleyArea       = %10000000 export
music_Tourian          = %01000000 export
music_ItemRoom         = %00100000 export
music_KraidArea        = %00010000 export
music_Norfair          = %00001000 export
music_Escape           = %00000100 export
music_MotherBrain      = %00000010 export
music_Brinstar         = %00000001 export



.include "constants_ram.asm"


