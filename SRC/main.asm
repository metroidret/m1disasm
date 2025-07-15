.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"


.def FDSFile_Side = 0
.def FDSFile_Number = 0
.def FDSFile_Bank = 0



; disk info block
.section "Side{FDSFile_Side}-DiskInfo" bank FDSFile_Bank slot "DummySlot"
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $00, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $0F
.ends
.redef FDSFile_Bank = FDSFile_Bank + 1



; file $00 - kyodaku-
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



; file $01 - demo.chr
FDSFileMacroPart1 $00
    .ascstr "DEMO.CHR"
FDSFileMacroPart2 $0000, $01
    .incbin "fdspacker_output/side_1/demo.chr.chr"
FDSFileMacroPart3



; file $02 - met.hex
FDSFileMacroPart1 $00
    .ascstr "MET.HEX", $00
FDSFileMacroPart2 $D000, $00
    .incbin "fdspacker_output/side_1/met.hex.prg"
FDSFileMacroPart3



; file $03 - demo.pgm
FDSFileMacroPart1 $00
    .ascstr "DEMO.PGM"
FDSFileMacroPart2 $6800, $00
    .include "fdspacker_output/side_1/demo.pgm.asm"
FDSFileMacroPart3



; file $04 - demo.pg2
FDSFileMacroPart1 $00
    .ascstr "DEMO.PG2"
FDSFileMacroPart2 $C5A0, $00
    .incbin "fdspacker_output/side_1/demo.pg2.prg"
FDSFileMacroPart3



; file $05 - demo.vec
FDSFileMacroPart1 $00
    .ascstr "DEMO.VEC"
FDSFileMacroPart2 $DFFA, $00
    .word $68BD
    .word $6821
    .word $6821
FDSFileMacroPart3



; file $06 - bmenst
FDSFileMacroPart1 $20
    .ascstr "BMENST", $00, $00
FDSFileMacroPart2 $C000, $00
    .include "fdspacker_output/side_1/bmenst.asm"
FDSFileMacroPart3



; file $07 - main.vec
FDSFileMacroPart1 $20
    .ascstr "MAIN.VEC"
FDSFileMacroPart2 $DFFA, $00
    .word $9396
    .word $C000
    .word $C000
FDSFileMacroPart3



; file $08 - main.pgm
FDSFileMacroPart1 $20
    .ascstr "MAIN.PGM"
FDSFileMacroPart2 $6800, $00
    .incbin "fdspacker_output/side_1/main.pgm.prg"
FDSFileMacroPart3



; file $09 - endobj
FDSFileMacroPart1 $EE
    .ascstr "ENDOBJ", $00, $00
FDSFileMacroPart2 $0000, $01
    .incbin "fdspacker_output/side_1/endobj.chr"
FDSFileMacroPart3



; file $0A - endbg
FDSFileMacroPart1 $EE
    .ascstr "ENDBG", $00, $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "fdspacker_output/side_1/endbg.chr"
FDSFileMacroPart3



; file $0B - mmeee
FDSFileMacroPart1 $EE
    .ascstr "MMEEE", $00, $00, $00
FDSFileMacroPart2 $CC00, $00
    .incbin "fdspacker_output/side_1/mmeee.prg"
FDSFileMacroPart3



; file $0C - endpgm
FDSFileMacroPart1 $EE
    .ascstr "ENDPGM", $00, $00
FDSFileMacroPart2 $6000, $00
    .incbin "fdspacker_output/side_1/endpgm.prg"
FDSFileMacroPart3



; file $0D - endvec
FDSFileMacroPart1 $EE
    .ascstr "ENDVEC", $00, $00
FDSFileMacroPart2 $DFFA, $00
    .word $60D9
    .word $6000
    .word $6143
FDSFileMacroPart3



; file $0E - \u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001
FDSFileMacroPart1 $0E
    .ascstr $01, $01, $01, $01, $01, $01, $01, $01
FDSFileMacroPart2 $C5A0, $00
    .incbin "fdspacker_output/side_1/u0001.prg"
FDSFileMacroPart3


; switch to side b of the disk
.redef FDSFile_Side = FDSFile_Side + 1
.redef FDSFile_Number = 0


; disk info block
.section "Side{FDSFile_Side}-DiskInfo" bank FDSFile_Bank
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $01, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $68, $43, $4F, $4E, $20, $62, $79, $20, $68, $61, $6C, $39, $39, $39, $39, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $1C
.ends
.redef FDSFile_Bank = FDSFile_Bank + 1


; file $00 - hmbg1a
FDSFileMacroPart1 $81
    .ascstr "HMBG1A", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "fdspacker_output/side_2/hmbg1a.chr"
FDSFileMacroPart3



; file $01 - hmbg1b
FDSFileMacroPart1 $90
    .ascstr "HMBG1B", $00, $00
FDSFileMacroPart2 $1200, $01
    .incbin "fdspacker_output/side_2/hmbg1b.chr"
FDSFileMacroPart3



; file $02 - hmbg1c
FDSFileMacroPart1 $91
    .ascstr "HMBG1C", $00, $00
FDSFileMacroPart2 $1800, $01
    .incbin "fdspacker_output/side_2/hmbg1c.chr"
FDSFileMacroPart3



; file $03 - hmob1b
FDSFileMacroPart1 $81
    .ascstr "HMOB1B", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "fdspacker_output/side_2/hmob1b.chr"
FDSFileMacroPart3



; file $04 - hmbg4a
FDSFileMacroPart1 $84
    .ascstr "HMBG4A", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "fdspacker_output/side_2/hmbg4a.chr"
FDSFileMacroPart3



; file $05 - hmbg4b
FDSFileMacroPart1 $84
    .ascstr "HMBG4B", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "fdspacker_output/side_2/hmbg4b.chr"
FDSFileMacroPart3



; file $06 - hmob4a
FDSFileMacroPart1 $84
    .ascstr "HMOB4A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "fdspacker_output/side_2/hmob4a.chr"
FDSFileMacroPart3



; file $07 - hmbg6c
FDSFileMacroPart1 $92
    .ascstr "HMBG6C", $00, $00
FDSFileMacroPart2 $1000, $01
    .incbin "fdspacker_output/side_2/hmbg6c.chr"
FDSFileMacroPart3



; file $08 - hmbg5b
FDSFileMacroPart1 $85
    .ascstr "HMBG5B", $00, $00
FDSFileMacroPart2 $1200, $01
    .incbin "fdspacker_output/side_2/hmbg5b.chr"
FDSFileMacroPart3



; file $09 - hmbg5c
FDSFileMacroPart1 $85
    .ascstr "HMBG5C", $00, $00
FDSFileMacroPart2 $1900, $01
    .incbin "fdspacker_output/side_2/hmbg5c.chr"
FDSFileMacroPart3



; file $0A - hmbg5d
FDSFileMacroPart1 $85
    .ascstr "HMBG5D", $00, $00
FDSFileMacroPart2 $1D00, $01
    .incbin "fdspacker_output/side_2/hmbg5d.chr"
FDSFileMacroPart3



; file $0B - hmob5a
FDSFileMacroPart1 $85
    .ascstr "HMOB5A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "fdspacker_output/side_2/hmob5a.chr"
FDSFileMacroPart3



; file $0C - hmbg6a
FDSFileMacroPart1 $86
    .ascstr "HMBG6A", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "fdspacker_output/side_2/hmbg6a.chr"
FDSFileMacroPart3



; file $0D - hmbg6b
FDSFileMacroPart1 $86
    .ascstr "HMBG6B", $00, $00
FDSFileMacroPart2 $1E00, $01
    .incbin "fdspacker_output/side_2/hmbg6b.chr"
FDSFileMacroPart3



; file $0E - hmob6a
FDSFileMacroPart1 $86
    .ascstr "HMOB6A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "fdspacker_output/side_2/hmob6a.chr"
FDSFileMacroPart3



; file $0F - hmbg7a
FDSFileMacroPart1 $87
    .ascstr "HMBG7A", $00, $00
FDSFileMacroPart2 $1700, $01
    .incbin "fdspacker_output/side_2/hmbg7a.chr"
FDSFileMacroPart3



; file $10 - hmob7a
FDSFileMacroPart1 $87
    .ascstr "HMOB7A", $00, $00
FDSFileMacroPart2 $0C00, $01
    .incbin "fdspacker_output/side_2/hmob7a.chr"
FDSFileMacroPart3



; file $11 - mmrock
FDSFileMacroPart1 $10
    .ascstr "MMROCK", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .incbin "fdspacker_output/side_2/mmrock.prg"
FDSFileMacroPart3



; file $12 - mmfire
FDSFileMacroPart1 $11
    .ascstr "MMFIRE", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .incbin "fdspacker_output/side_2/mmfire.prg"
FDSFileMacroPart3



; file $13 - mmkiti
FDSFileMacroPart1 $13
    .ascstr "MMKITI", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .incbin "fdspacker_output/side_2/mmkiti.prg"
FDSFileMacroPart3



; file $14 - mmkbos
FDSFileMacroPart1 $1F
    .ascstr "MMKBOS", $00, $00
FDSFileMacroPart2 $DEA0, $00
    .incbin "fdspacker_output/side_2/mmkbos.prg"
FDSFileMacroPart3



; file $15 - stg1pgm
FDSFileMacroPart1 $10
    .ascstr "STG1PGM", $00
FDSFileMacroPart2 $B560, $00
    .incbin "fdspacker_output/side_2/stg1pgm.prg"
FDSFileMacroPart3



; file $16 - stg4pgm
FDSFileMacroPart1 $11
    .ascstr "STG4PGM", $00
FDSFileMacroPart2 $B560, $00
    .incbin "fdspacker_output/side_2/stg4pgm.prg"
FDSFileMacroPart3



; file $17 - stg5pgm
FDSFileMacroPart1 $13
    .ascstr "STG5PGM", $00
FDSFileMacroPart2 $B560, $00
    .incbin "fdspacker_output/side_2/stg5pgm.prg"
FDSFileMacroPart3



; file $18 - stg6pgm
FDSFileMacroPart1 $12
    .ascstr "STG6PGM", $00
FDSFileMacroPart2 $B560, $00
    .incbin "fdspacker_output/side_2/stg6pgm.prg"
FDSFileMacroPart3



; file $19 - stg7pgm
FDSFileMacroPart1 $14
    .ascstr "STG7PGM", $00
FDSFileMacroPart2 $B560, $00
    .incbin "fdspacker_output/side_2/stg7pgm.prg"
FDSFileMacroPart3



; file $1A - mensave2
FDSFileMacroPart1 $EF
    .ascstr "MENSAVE2"
FDSFileMacroPart2 $C3F0, $00
    .incbin "fdspacker_output/side_2/mensave2.prg"
FDSFileMacroPart3



; file $1B - \u0002\u0002\u0002\u0002\u0002\u0002\u0002\u0002
FDSFileMacroPart1 $EF
    .ascstr $02, $02, $02, $02, $02, $02, $02, $02
FDSFileMacroPart2 $C000, $00
    .incbin "fdspacker_output/side_2/u0002.prg"
FDSFileMacroPart3





