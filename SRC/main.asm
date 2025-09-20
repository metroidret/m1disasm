.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"



.def FDSFile_Bank = 0


; --------------------------- Disk Side A ---------------------------
.def FDSFile_Side = 0
.def FDSFile_Number = 0


; disk info block
.section "Side{FDSFile_Side}-DiskInfo" bank FDSFile_Bank slot "DummySlot"
    .byte $01
    .ascstr "*NINTENDO-HVC*"
    .byte $01
    .ascstr "MET"
    .ascstr " "
    .byte $02
    .byte FDSFile_Side
    .byte $00
    .byte $00
    .byte $00
    .byte $0F
    .byte $FF, $FF, $FF, $FF, $FF
    .byte $61, $09, $09
    .byte $49
    .byte $61
    .byte $00
    .byte $00, $02
    .byte $00, $1A, $00, $10, $00
    .byte $61, $09, $09
    .byte $FF
    .byte $FF
    .byte $FF, $FF
    .byte $FF
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    
    .byte $02
    .byte $0F
.ends
.redef FDSFile_Bank = FDSFile_Bank + 1



; file $00 - kyodaku- ($2800-$28DF)
; Copyright screen necessary for any FDS game to boot properly
FDSFileMacroPart1 $00
    .ascstr "KYODAKU-"
FDSFileMacroPart2 $2800, $02
    .stringmap charmap_kyodaku, "           NINTENDO r           "
    .stringmap charmap_kyodaku, "       FAMILY COMPUTER TM       "
    .stringmap charmap_kyodaku, "                                "
    .stringmap charmap_kyodaku, "  THIS PRODUCT IS MANUFACTURED  "
    .stringmap charmap_kyodaku, "  AND SOLD BY NINTENDO CO;LTD.  "
    .stringmap charmap_kyodaku, "  OR BY OTHER COMPANY UNDER     "
    .stringmap charmap_kyodaku, "  LICENSE OF NINTENDO CO;LTD..  "
FDSFileMacroPart3



; file $01 - demo.chr ($0000-$1D9F)
; Tile data for title screen
FDSFileMacroPart1 $00
    .ascstr "DEMO.CHR"
FDSFileMacroPart2 $0000, $01
    .incbin "sideA/demo.chr.chr"
FDSFileMacroPart3



; file $02 - met.hex ($D000-$DFF5)
; Music engine
FDSFileMacroPart1 $00
    .ascstr "MET.HEX", $00
FDSFileMacroPart2 $D000, $00
    .include "sideA/met.hex.asm"
FDSFileMacroPart3



; file $03 - demo.pgm ($6800-$90FF)
; Title screen code - part 1
FDSFileMacroPart1 $00
    .ascstr "DEMO.PGM"
FDSFileMacroPart2 $6800, $00
    .include "sideA/demo.pgm.asm"
FDSFileMacroPart3



; file $04 - demo.pg2 ($C5A0-$CF5F)
; Title screen code - part 2
FDSFileMacroPart1 $00
    .ascstr "DEMO.PG2"
FDSFileMacroPart2 $C5A0, $00
    .include "sideA/demo.pg2.asm"
FDSFileMacroPart3



; file $05 - demo.vec ($DFFA-$DFFF)
FDSFileMacroPart1 $00
    .ascstr "DEMO.VEC"
FDSFileMacroPart2 $DFFA, $00
    .word DEMO_NMI
    .word DEMO_RESET
    .word DEMO_RESET
FDSFileMacroPart3



; file $06 - bmenst ($C000-$C0BF)
; Switching to disk side B
FDSFileMacroPart1 $20
    .ascstr "BMENST", $00, $00
FDSFileMacroPart2 $C000, $00
    .include "sideA/bmenst.asm"
FDSFileMacroPart3



; file $07 - main.vec ($DFFA-$DFFF)
FDSFileMacroPart1 $20
    .ascstr "MAIN.VEC"
FDSFileMacroPart2 $DFFA, $00
    .word MAIN_NMI
    .word BMENST_RESET
    .word BMENST_RESET
FDSFileMacroPart3



; file $08 - main.pgm ($6800-$B40F)
FDSFileMacroPart1 $20
    .ascstr "MAIN.PGM"
FDSFileMacroPart2 $6800, $00
    .include "sideA/main.pgm.asm"
FDSFileMacroPart3



; file $09 - endobj ($0000-$05FF)
FDSFileMacroPart1 $EE
    .ascstr "ENDOBJ", $00, $00
FDSFileMacroPart2 $0000, $01
    .incbin "sideA/endobj.chr"
FDSFileMacroPart3



; file $0A - endbg ($1000-$13FF)
FDSFileMacroPart1 $EE
    .ascstr "ENDBG", $00, $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "sideA/endbg.chr"
FDSFileMacroPart3



; file $0B - mmeee ($CC00-$CFCF)
; Ending Song
FDSFileMacroPart1 $EE
    .ascstr "MMEEE", $00, $00, $00
FDSFileMacroPart2 $CC00, $00
    .include "sideA/mmeee.asm"
FDSFileMacroPart3



; file $0C - endpgm ($6000-$6D7F)
FDSFileMacroPart1 $EE
    .ascstr "ENDPGM", $00, $00
FDSFileMacroPart2 $6000, $00
    .include "sideA/endpgm.asm"
FDSFileMacroPart3



; file $0D - endvec ($DFFA-$DFFF)
FDSFileMacroPart1 $EE
    .ascstr "ENDVEC", $00, $00
FDSFileMacroPart2 $DFFA, $00
    .word ENDPGM_NMI
    .word ENDPGM_RESET
    .word ENDPGM_IRQ
FDSFileMacroPart3



; file $0E - savedata ($C5A0-$C614)
FDSFileMacroPart1 $0F
    .ascstr "SAVEDATA"
FDSFileMacroPart2 $C5A0, $00
    .include "sideA/savedata.asm"
FDSFileMacroPart3


; --------------------------- Disk Side B ---------------------------
.redef FDSFile_Side = FDSFile_Side + 1
.redef FDSFile_Number = 0


; disk info block
.section "Side{FDSFile_Side}-DiskInfo" bank FDSFile_Bank
    .byte $01
    .ascstr "*NINTENDO-HVC*"
    .byte $01
    .ascstr "MET"
    .ascstr " "
    .byte $02
    .byte FDSFile_Side
    .byte $00
    .byte $00
    .byte $00
    .byte $0F
    .byte $FF, $FF, $FF, $FF, $FF
    .byte $61, $09, $10
    .byte $49
    .byte $61
    .byte $00
    .byte $00, $02
    .byte $00, $59, $02, $12, $00
    .byte $61, $09, $10
    .byte $FF
    .byte $FF
    .byte $FF, $FF
    .byte $FF
    .byte $00
    .byte $01
    .byte $00
    .byte $00
    
    .byte $02
    .byte $1C
.ends
.redef FDSFile_Bank = FDSFile_Bank + 1


; file $00 - hmbg1a ($1000-$114F)
FDSFileMacroPart1 $81
    .ascstr "HMBG1A", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "sideB/brinstar/hmbg1a.chr"
FDSFileMacroPart3



; file $01 - hmbg1b ($1200-$164F)
FDSFileMacroPart1 $90
    .ascstr "HMBG1B", $00, $00
FDSFileMacroPart2 $1200, $01
    .incbin "sideB/brinstar/hmbg1b.chr"
FDSFileMacroPart3



; file $02 - hmbg1c ($1800-$1FFF)
FDSFileMacroPart1 $91
    .ascstr "HMBG1C", $00, $00
FDSFileMacroPart2 $1800, $01
    .incbin "sideB/brinstar/hmbg1c.chr"
FDSFileMacroPart3



; file $03 - hmob1b ($0C00-$0FFF)
FDSFileMacroPart1 $81
    .ascstr "HMOB1B", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "sideB/brinstar/hmob1b.chr"
FDSFileMacroPart3



; file $04 - hmbg4a ($1000-$125F)
FDSFileMacroPart1 $84
    .ascstr "HMBG4A", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "sideB/norfair/hmbg4a.chr"
FDSFileMacroPart3



; file $05 - hmbg4b ($1700-$176F)
FDSFileMacroPart1 $84
    .ascstr "HMBG4B", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "sideB/norfair/hmbg4b.chr"
FDSFileMacroPart3



; file $06 - hmob4a ($0C00-$0FFF)
FDSFileMacroPart1 $84
    .ascstr "HMOB4A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "sideB/norfair/hmob4a.chr"
FDSFileMacroPart3



; file $07 - hmbg6c ($1000-$12DF)
FDSFileMacroPart1 $92
    .ascstr "HMBG6C", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "sideB/kraid/hmbg6c.chr"
FDSFileMacroPart3



; file $08 - hmbg5b ($1200-$17FF)
FDSFileMacroPart1 $85
    .ascstr "HMBG5B", $00, $00
FDSFileMacroPart2 $1200, $01
    .incbin "sideB/tourian/hmbg5b.chr"
FDSFileMacroPart3



; file $09 - hmbg5c ($1900-$198F)
FDSFileMacroPart1 $85
    .ascstr "HMBG5C", $00, $00
FDSFileMacroPart2 $1900, $01
    .incbin "sideB/tourian/hmbg5c.chr"
FDSFileMacroPart3



; file $0A - hmbg5d ($1D00-$1FFF)
FDSFileMacroPart1 $85
    .ascstr "HMBG5D", $00, $00
FDSFileMacroPart2 $1D00, $01
    .incbin "sideB/tourian/hmbg5d.chr"
FDSFileMacroPart3



; file $0B - hmob5a ($0C00-$0FFF)
FDSFileMacroPart1 $85
    .ascstr "HMOB5A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "sideB/tourian/hmob5a.chr"
FDSFileMacroPart3



; file $0C - hmbg6a ($1700-$17BF)
FDSFileMacroPart1 $86
    .ascstr "HMBG6A", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "sideB/kraid/hmbg6a.chr"
FDSFileMacroPart3



; file $0D - hmbg6b ($1E00-$1FFF)
FDSFileMacroPart1 $86
    .ascstr "HMBG6B", $00, $00
FDSFileMacroPart2 $1E00, $01
    .incbin "sideB/kraid/hmbg6b.chr"
FDSFileMacroPart3



; file $0E - hmob6a ($0C00-$0FFF)
FDSFileMacroPart1 $86
    .ascstr "HMOB6A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "sideB/kraid/hmob6a.chr"
FDSFileMacroPart3



; file $0F - hmbg7a ($1700-$17BF)
FDSFileMacroPart1 $87
    .ascstr "HMBG7A", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "sideB/ridley/hmbg7a.chr"
FDSFileMacroPart3



; file $10 - hmob7a ($0C00-$0FFF)
FDSFileMacroPart1 $87
    .ascstr "HMOB7A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "sideB/ridley/hmob7a.chr"
FDSFileMacroPart3



; file $11 - mmrock ($DEA0-$DFEF)
; Brinstar Song
FDSFileMacroPart1 $10
    .ascstr "MMROCK", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .include "sideB/mmrock.asm"
FDSFileMacroPart3



; file $12 - mmfire ($DEA0-$DFEF)
; Norfair Song
FDSFileMacroPart1 $11
    .ascstr "MMFIRE", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .include "sideB/mmfire.asm"
FDSFileMacroPart3



; file $13 - mmkiti ($DEA0-$DFEF)
; Escape and Mother Brain Song
FDSFileMacroPart1 $13
    .ascstr "MMKITI", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .include "sideB/mmkiti.asm"
FDSFileMacroPart3



; file $14 - mmkbos ($DEA0-$DFEF)
; Kraid and Ridley Songs
FDSFileMacroPart1 $1F
    .ascstr "MMKBOS", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .include "sideB/mmkbos.asm"
FDSFileMacroPart3



; file $15 - stg1pgm ($B560-$CFDF)
; Brinstar Area Data
FDSFileMacroPart1 $10
    .ascstr "STG1PGM", $00
FDSFileMacroPart2 $B560, $00
    .include "sideB/stg1pgm.asm"
FDSFileMacroPart3



; file $16 - stg4pgm ($B560-$CFDF)
; Norfair Area Data
FDSFileMacroPart1 $11
    .ascstr "STG4PGM", $00
FDSFileMacroPart2 $B560, $00
    .include "sideB/stg4pgm.asm"
FDSFileMacroPart3



; file $17 - stg5pgm ($B560-$CF7F)
; Tourian Area Data
FDSFileMacroPart1 $13
    .ascstr "STG5PGM", $00
FDSFileMacroPart2 $B560, $00
    .include "sideB/stg5pgm.asm"
FDSFileMacroPart3



; file $18 - stg6pgm ($B560-$CCDF)
; Kraid Area Data
FDSFileMacroPart1 $12
    .ascstr "STG6PGM", $00
FDSFileMacroPart2 $B560, $00
    .include "sideB/stg6pgm.asm"
FDSFileMacroPart3



; file $19 - stg7pgm ($B560-$CBDF)
; Ridley Area Data
FDSFileMacroPart1 $14
    .ascstr "STG7PGM", $00
FDSFileMacroPart2 $B560, $00
    .include "sideB/stg7pgm.asm"
FDSFileMacroPart3



; file $1A - mensave2 ($C3F0-$C59F)
FDSFileMacroPart1 $EF
    .ascstr "MENSAVE2"
FDSFileMacroPart2 $C3F0, $00
    .include "sideB/mensave2.asm"
FDSFileMacroPart3



; file $1B - mensave ($C000-$C3EF)
FDSFileMacroPart1 $EF
    .ascstr "MENSAVE", $00
FDSFileMacroPart2 $C000, $00
    .include "sideB/mensave.asm"
FDSFileMacroPart3




