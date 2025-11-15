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


.ifndef BUILDTARGET
    .fail "no build target specified"
.endif


.memorymap
    defaultslot 0
    slot 0 $0000 $0010 "HeaderSlot"
    slot 1 $0000 $0800 "RAMConsoleSlot"
    slot 2 $6000 $2000 "RAMCartSlot"
    slot 3 $8000 $4000 "ROMSwitchSlot"
    slot 4 $C000 $4000 "ROMFixedSlot"
.endme

.rombankmap
    bankstotal $8
    banksize $4000
    banks $8
.endro


.stringmaptable charmap "SRC/charmap.tbl"


.include "SRC/constants_ram.asm"


;------------------------------------------[ Misc. defines ]-----------------------------------------

;Special item types.
it_Squeept             = $1
it_PowerUp             = $2
it_Mellow              = $3
it_Elevator            = $4
it_Cannon              = $5   ;High nibble is Cannons.0.instrListID
it_MotherBrain         = $6
it_Zebetite            = $7   ;High nibble is Zebetite slot ID
it_RinkaSpawner        = $8
it_Door                = $9
it_PaletteChange       = $A

;Power up id for items
pu_BOMBS               = $00
pu_HIGHJUMP            = $01
pu_LONGBEAM            = $02
pu_SCREWATTACK         = $03
pu_MARUMARI            = $04
pu_VARIA               = $05
pu_WAVEBEAM            = $06
pu_ICEBEAM             = $07
pu_ENERGYTANK          = $08
pu_MISSILES            = $09

;Bitmask defs used for SamusGear.
gr_BOMBS               = %00000001
gr_HIGHJUMP            = %00000010
gr_LONGBEAM            = %00000100
gr_SCREWATTACK         = %00001000
gr_MARUMARI            = %00010000
gr_VARIA               = %00100000
gr_WAVEBEAM            = %01000000
gr_ICEBEAM             = %10000000

;unique items IIIIII
ui_BOMBS               = %000000 << 10
ui_HIGHJUMP            = %000001 << 10
ui_LONGBEAM            = %000010 << 10 ;(Not considered a unique item).
ui_SCREWATTACK         = %000011 << 10
ui_MARUMARI            = %000100 << 10
ui_VARIA               = %000101 << 10
ui_WAVEBEAM            = %000110 << 10 ;(Not considered a unique item).
ui_ICEBEAM             = %000111 << 10 ;(Not considered a unique item).
ui_ENERGYTANK          = %001000 << 10
ui_MISSILES            = %001001 << 10
ui_MISSILEDOOR         = %001010 << 10
ui_MOTHERBRAIN         = %001110 << 10
ui_ZEBETITE1           = %001111 << 10
ui_ZEBETITE2           = %010000 << 10
ui_ZEBETITE3           = %010001 << 10
ui_ZEBETITE4           = %010010 << 10
ui_ZEBETITE5           = %010011 << 10

;Samus action handlers.
sa_Stand               = 0
sa_Run                 = 1       ;Also run and jump.
sa_Jump                = 2
sa_Roll                = 3
sa_PntUp               = 4
sa_Door                = 5
sa_PntJump             = 6
sa_Dead                = 7
sa_Dead2               = 8       ;Also after time bomb exploded.
sa_Elevator            = 9
sa_Begin               = 255

;Weapon action handlers.
wa_RegularBeam         = $01
wa_WaveBeam            = $02
wa_IceBeam             = $03
wa_BulletExplode       = $04
wa_Unknown7            = $07
wa_LayBomb             = $08
wa_BombCount           = $09
wa_BombExplode         = $0A
wa_Missile             = $0B
wa_ScrewAttack         = $81

;Enemy Status
enemyStatus_NoEnemy    = 0
enemyStatus_Resting    = 1
enemyStatus_Active     = 2
enemyStatus_Explode    = 3
enemyStatus_Frozen     = 4
enemyStatus_Pickup     = 5
enemyStatus_Hurt       = 6
; greater than 6 is the same as no enemy

;Sound flags
;sfxNoise_80            = %10000000
sfxNoise_ScrewAttack   = %01000000
sfxNoise_MissileLaunch = %00100000
sfxNoise_BombExplode   = %00010000
sfxNoise_SamusWalk     = %00001000
sfxNoise_SpitFlame     = %00000100
sfxNoise_PauseMusic    = %00000010
sfxNoise_SilenceMusic  = %00000001

sfxSQ1_MissilePickup   = %10000000
sfxSQ1_EnergyPickup    = %01000000
sfxSQ1_Metal           = %00100000
sfxSQ1_BulletFire      = %00010000
sfxSQ1_OutOfHole       = %00001000
sfxSQ1_EnemyHit        = %00000100
sfxSQ1_SamusJump       = %00000010
sfxSQ1_WaveFire        = %00000001

sfxTri_SamusDie        = %10000000
sfxTri_Door            = %01000000
sfxTri_MetroidHit      = %00100000
sfxTri_StatueRaise     = %00010000
sfxTri_Beep            = %00001000
sfxTri_BigEnemyHit     = %00000100
sfxTri_SamusBall       = %00000010
sfxTri_BombLaunch      = %00000001

sfxMulti_Intro         = %10000000
sfxMulti_PowerUp       = %01000000
sfxMulti_EndMusic      = %00100000
sfxMulti_IntroMusic    = %00010000
;sfxMulti_08            = %00001000
sfxMulti_SamusHit      = %00000100
sfxMulti_BossHit       = %00000010
sfxMulti_IncorrectPassword = %00000001

music_RidleyArea       = %10000000
music_Tourian          = %01000000
music_ItemRoom         = %00100000
music_KraidArea        = %00010000
music_Norfair          = %00001000
music_Escape           = %00000100
music_MotherBrain      = %00000010
music_Brinstar         = %00000001

