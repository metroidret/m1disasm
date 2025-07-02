
.MEMORYMAP
    DEFAULTSLOT 0
    SLOT 0 $0000 $FFDC "DummySlot"
    SLOT 1 $0000 $0800 "RAMConsoleSlot"
    SLOT 2 $6000 $8000 "RAMDiskSysSlot"
    SLOT 3 $E000 $2000 "ROMFDSBIOSSlot"
.ENDME

.ROMBANKMAP
    BANKSTOTAL $2
    BANKSIZE $FFDC
    BANKS $2
.ENDRO


.ASCIITABLE
.ENDA

.SECTION "Side B - Dummy" BANK 1 SLOT "DummySlot" ORGA $0000 FORCE

; disk info block
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $01, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $68, $43, $4F, $4E, $20, $62, $79, $20, $68, $61, $6C, $39, $39, $39, $39, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $1C



; file $00 - hmbg1a
    .byte $03, $00, $81
    .ascstr "HMBG1A", $00, $00
    .word $1000, SideBFile00_End - SideBFile00_Start
    .byte $01, $04
SideBFile00_Start:
    .incbin "fdspacker_output/side_2/hmbg1a.chr"
SideBFile00_End:



; file $01 - hmbg1b
    .byte $03, $01, $90
    .ascstr "HMBG1B", $00, $00
    .word $1200, SideBFile01_End - SideBFile01_Start
    .byte $01, $04
SideBFile01_Start:
    .incbin "fdspacker_output/side_2/hmbg1b.chr"
SideBFile01_End:



; file $02 - hmbg1c
    .byte $03, $02, $91
    .ascstr "HMBG1C", $00, $00
    .word $1800, SideBFile02_End - SideBFile02_Start
    .byte $01, $04
SideBFile02_Start:
    .incbin "fdspacker_output/side_2/hmbg1c.chr"
SideBFile02_End:



; file $03 - hmob1b
    .byte $03, $03, $81
    .ascstr "HMOB1B", $00, $00
    .word $0C00, SideBFile03_End - SideBFile03_Start
    .byte $01, $04
SideBFile03_Start:
    .incbin "fdspacker_output/side_2/hmob1b.chr"
SideBFile03_End:



; file $04 - hmbg4a
    .byte $03, $04, $84
    .ascstr "HMBG4A", $00, $00
    .word $1000, SideBFile04_End - SideBFile04_Start
    .byte $01, $04
SideBFile04_Start:
    .incbin "fdspacker_output/side_2/hmbg4a.chr"
SideBFile04_End:



; file $05 - hmbg4b
    .byte $03, $05, $84
    .ascstr "HMBG4B", $00, $00
    .word $1700, SideBFile05_End - SideBFile05_Start
    .byte $01, $04
SideBFile05_Start:
    .incbin "fdspacker_output/side_2/hmbg4b.chr"
SideBFile05_End:



; file $06 - hmob4a
    .byte $03, $06, $84
    .ascstr "HMOB4A", $00, $00
    .word $0C00, SideBFile06_End - SideBFile06_Start
    .byte $01, $04
SideBFile06_Start:
    .incbin "fdspacker_output/side_2/hmob4a.chr"
SideBFile06_End:



; file $07 - hmbg6c
    .byte $03, $07, $92
    .ascstr "HMBG6C", $00, $00
    .word $1000, SideBFile07_End - SideBFile07_Start
    .byte $01, $04
SideBFile07_Start:
    .incbin "fdspacker_output/side_2/hmbg6c.chr"
SideBFile07_End:



; file $08 - hmbg5b
    .byte $03, $08, $85
    .ascstr "HMBG5B", $00, $00
    .word $1200, SideBFile08_End - SideBFile08_Start
    .byte $01, $04
SideBFile08_Start:
    .incbin "fdspacker_output/side_2/hmbg5b.chr"
SideBFile08_End:



; file $09 - hmbg5c
    .byte $03, $09, $85
    .ascstr "HMBG5C", $00, $00
    .word $1900, SideBFile09_End - SideBFile09_Start
    .byte $01, $04
SideBFile09_Start:
    .incbin "fdspacker_output/side_2/hmbg5c.chr"
SideBFile09_End:



; file $0A - hmbg5d
    .byte $03, $0A, $85
    .ascstr "HMBG5D", $00, $00
    .word $1D00, SideBFile0A_End - SideBFile0A_Start
    .byte $01, $04
SideBFile0A_Start:
    .incbin "fdspacker_output/side_2/hmbg5d.chr"
SideBFile0A_End:



; file $0B - hmob5a
    .byte $03, $0B, $85
    .ascstr "HMOB5A", $00, $00
    .word $0C00, SideBFile0B_End - SideBFile0B_Start
    .byte $01, $04
SideBFile0B_Start:
    .incbin "fdspacker_output/side_2/hmob5a.chr"
SideBFile0B_End:



; file $0C - hmbg6a
    .byte $03, $0C, $86
    .ascstr "HMBG6A", $00, $00
    .word $1700, SideBFile0C_End - SideBFile0C_Start
    .byte $01, $04
SideBFile0C_Start:
    .incbin "fdspacker_output/side_2/hmbg6a.chr"
SideBFile0C_End:



; file $0D - hmbg6b
    .byte $03, $0D, $86
    .ascstr "HMBG6B", $00, $00
    .word $1E00, SideBFile0D_End - SideBFile0D_Start
    .byte $01, $04
SideBFile0D_Start:
    .incbin "fdspacker_output/side_2/hmbg6b.chr"
SideBFile0D_End:



; file $0E - hmob6a
    .byte $03, $0E, $86
    .ascstr "HMOB6A", $00, $00
    .word $0C00, SideBFile0E_End - SideBFile0E_Start
    .byte $01, $04
SideBFile0E_Start:
    .incbin "fdspacker_output/side_2/hmob6a.chr"
SideBFile0E_End:



; file $0F - hmbg7a
    .byte $03, $0F, $87
    .ascstr "HMBG7A", $00, $00
    .word $1700, SideBFile0F_End - SideBFile0F_Start
    .byte $01, $04
SideBFile0F_Start:
    .incbin "fdspacker_output/side_2/hmbg7a.chr"
SideBFile0F_End:



; file $10 - hmob7a
    .byte $03, $10, $87
    .ascstr "HMOB7A", $00, $00
    .word $0C00, SideBFile10_End - SideBFile10_Start
    .byte $01, $04
SideBFile10_Start:
    .incbin "fdspacker_output/side_2/hmob7a.chr"
SideBFile10_End:



; file $11 - mmrock
    .byte $03, $11, $10
    .ascstr "MMROCK", $00, $00
    .word $DEA0, SideBFile11_End - SideBFile11_Start
    .byte $00, $04
SideBFile11_Start:
    .incbin "fdspacker_output/side_2/mmrock.prg"
SideBFile11_End:



; file $12 - mmfire
    .byte $03, $12, $11
    .ascstr "MMFIRE", $00, $00
    .word $DEA0, SideBFile12_End - SideBFile12_Start
    .byte $00, $04
SideBFile12_Start:
    .incbin "fdspacker_output/side_2/mmfire.prg"
SideBFile12_End:



; file $13 - mmkiti
    .byte $03, $13, $13
    .ascstr "MMKITI", $00, $00
    .word $DEA0, SideBFile13_End - SideBFile13_Start
    .byte $00, $04
SideBFile13_Start:
    .incbin "fdspacker_output/side_2/mmkiti.prg"
SideBFile13_End:



; file $14 - mmkbos
    .byte $03, $14, $1F
    .ascstr "MMKBOS", $00, $00
    .word $DEA0, SideBFile14_End - SideBFile14_Start
    .byte $00, $04
SideBFile14_Start:
    .incbin "fdspacker_output/side_2/mmkbos.prg"
SideBFile14_End:



; file $15 - stg1pgm
    .byte $03, $15, $10
    .ascstr "STG1PGM", $00
    .word $B560, SideBFile15_End - SideBFile15_Start
    .byte $00, $04
SideBFile15_Start:
    .incbin "fdspacker_output/side_2/stg1pgm.prg"
SideBFile15_End:



; file $16 - stg4pgm
    .byte $03, $16, $11
    .ascstr "STG4PGM", $00
    .word $B560, SideBFile16_End - SideBFile16_Start
    .byte $00, $04
SideBFile16_Start:
    .incbin "fdspacker_output/side_2/stg4pgm.prg"
SideBFile16_End:



; file $17 - stg5pgm
    .byte $03, $17, $13
    .ascstr "STG5PGM", $00
    .word $B560, SideBFile17_End - SideBFile17_Start
    .byte $00, $04
SideBFile17_Start:
    .incbin "fdspacker_output/side_2/stg5pgm.prg"
SideBFile17_End:



; file $18 - stg6pgm
    .byte $03, $18, $12
    .ascstr "STG6PGM", $00
    .word $B560, SideBFile18_End - SideBFile18_Start
    .byte $00, $04
SideBFile18_Start:
    .incbin "fdspacker_output/side_2/stg6pgm.prg"
SideBFile18_End:



; file $19 - stg7pgm
    .byte $03, $19, $14
    .ascstr "STG7PGM", $00
    .word $B560, SideBFile19_End - SideBFile19_Start
    .byte $00, $04
SideBFile19_Start:
    .incbin "fdspacker_output/side_2/stg7pgm.prg"
SideBFile19_End:



; file $1A - mensave2
    .byte $03, $1A, $EF
    .ascstr "MENSAVE2"
    .word $C3F0, SideBFile1A_End - SideBFile1A_Start
    .byte $00, $04
SideBFile1A_Start:
    .incbin "fdspacker_output/side_2/mensave2.prg"
SideBFile1A_End:



; file $1B - \u0002\u0002\u0002\u0002\u0002\u0002\u0002\u0002
    .byte $03, $1B, $EF
    .ascstr $02, $02, $02, $02, $02, $02, $02, $02
    .word $C000, SideBFile1B_End - SideBFile1B_Start
    .byte $00, $04
SideBFile1B_Start:
    .incbin "fdspacker_output/side_2/u0002.prg"
SideBFile1B_End:



; pad the rest with zero ($4166 bytes)
    .ds $4166, $00

.ENDS

