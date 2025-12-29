.include "memory_layout.asm"


.asciitable
.enda

.stringmaptable charmap_kyodaku "kyodaku.tbl"
.stringmaptable charmap_title "title.tbl"
.stringmaptable charmap_savemenu "savemenu.tbl"
.stringmaptable charmap_gameover "gameover.tbl"
.stringmaptable charmap_ending "ending.tbl"


.include "constants_ram.asm"


;------------------------------------------[ Misc. defines ]-----------------------------------------

;FDS disk side File ID
FDSFileID_Side00_00    = $00   ; title screen
FDSFileID_Side00_0E    = $0E   ; savedata
FDSFileID_Side00_0F    = $0F   ; savedata (never written)
FDSFileID_Side00_Boot  = $0F   ; all files on side A whose id is less or equal to this are loaded on boot
FDSFileID_Side00_20    = $20   ; gameplay code
FDSFileID_Side00_EE    = $EE   ; ending
FDSFileID_Side01_10    = $10   ; STG1PGM + Brinstar Song
FDSFileID_Side01_11    = $11   ; STG4PGM + Norfair Song
FDSFileID_Side01_12    = $12   ; STG6PGM
FDSFileID_Side01_13    = $13   ; STG5PGM + Escape and Mother Brain Song
FDSFileID_Side01_14    = $14   ; STG7PGM
FDSFileID_Side01_1F    = $1F   ; Kraid and Ridley Songs
FDSFileID_Side01_81    = $81   ; HMBG1A + HMOB1B
FDSFileID_Side01_84    = $84   ; HMBG4A + HMBG4B + HMOB4A
FDSFileID_Side01_85    = $85   ; HMBG5B + HMBG5C + HMBG5D + HMOB5A
FDSFileID_Side01_86    = $86   ; HMBG6A + HMBG6B + HMOB6A
FDSFileID_Side01_87    = $87   ; HMBG7A + HMOB7A
FDSFileID_Side01_90    = $90   ; HMBG1B
FDSFileID_Side01_91    = $91   ; HMBG1C
FDSFileID_Side01_92    = $92   ; HMBG6C
FDSFileID_Side01_EF    = $EF   ; save menu


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

