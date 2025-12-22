.include "memory_layout.asm"


.asciitable
.enda

.stringmaptable charmap_kyodaku "SRC/kyodaku.tbl"
.stringmaptable charmap_title "SRC/title.tbl"
.stringmaptable charmap_savemenu "SRC/savemenu.tbl"
.stringmaptable charmap_gameover "SRC/gameover.tbl"
.stringmaptable charmap_ending "SRC/ending.tbl"


.include "constants_ram.asm"


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

;Enemy Status
enemyStatus_NoEnemy    = 0
enemyStatus_Resting    = 1
enemyStatus_Active     = 2
enemyStatus_Explode    = 3
enemyStatus_Frozen     = 4
enemyStatus_Pickup     = 5
enemyStatus_Hurt       = 6
; greater than 6 is the same as no enemy

