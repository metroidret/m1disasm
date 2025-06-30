
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

.STRINGMAPTABLE charmap_kyodaku "SRC/kyodaku.tbl"

.SECTION "Side A - Dummy" BANK 0 SLOT "DummySlot" ORGA $0000 FORCE

; disk info block
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $00, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $0F


; file $00 - kyodaku-
    .byte $03, $00, $00
    .ascstr "KYODAKU-"
    .word $2800, SideAFile00_End - SideAFile00_Start
    .byte $02, $04
SideAFile00_Start:
    .stringmap charmap_kyodaku, "           NINTENDO r           "
    .stringmap charmap_kyodaku, "       FAMILY COMPUTER TM       "
    .stringmap charmap_kyodaku, "                                "
    .stringmap charmap_kyodaku, "  THIS PRODUCT IS MANUFACTURED  "
    .stringmap charmap_kyodaku, "  AND SOLD BY NINTENDO CO;LTD.  "
    .stringmap charmap_kyodaku, "  OR BY OTHER COMPANY UNDER     "
    .stringmap charmap_kyodaku, "  LICENSE OF NINTENDO CO;LTD..  "
SideAFile00_End:

; file $01 - demo.chr
    .byte $03, $01, $00
    .ascstr "DEMO.CHR"
    .word $0000, SideAFile01_End - SideAFile01_Start
    .byte $01, $04
SideAFile01_Start:
    .incbin "fdspacker_output/side_1/demo.chr.chr"
SideAFile01_End:

; file $02 - met.hex
    .byte $03, $02, $00
    .ascstr "MET.HEX", $00
    .word $D000, SideAFile02_End - SideAFile02_Start
    .byte $00, $04
SideAFile02_Start:
    .incbin "fdspacker_output/side_1/met.hex.prg"
SideAFile02_End:

; file $03 - demo.pgm
    .byte $03, $03, $00
    .ascstr "DEMO.PGM"
    .word $6800, SideAFile03_End - SideAFile03_Start
    .byte $00, $04
SideAFile03_Start:
    .incbin "fdspacker_output/side_1/demo.pgm.prg"
SideAFile03_End:

; file $04 - demo.pg2
    .byte $03, $04, $00
    .ascstr "DEMO.PG2"
    .word $C5A0, SideAFile04_End - SideAFile04_Start
    .byte $00, $04
SideAFile04_Start:
    .incbin "fdspacker_output/side_1/demo.pg2.prg"
SideAFile04_End:

; file $05 - demo.vec
    .byte $03, $05, $00
    .ascstr "DEMO.VEC"
    .word $DFFA, SideAFile05_End - SideAFile05_Start
    .byte $00, $04
SideAFile05_Start:
    .word $68BD
    .word $6821
    .word $6821
SideAFile05_End:

; file $06 - bmenst
    .byte $03, $06, $20
    .ascstr "BMENST", $00, $00
    .word $C000, SideAFile06_End - SideAFile06_Start
    .byte $00, $04
SideAFile06_Start:
    .incbin "fdspacker_output/side_1/bmenst.prg"
SideAFile06_End:

; file $07 - main.vec
    .byte $03, $07, $20
    .ascstr "MAIN.VEC"
    .word $DFFA, SideAFile07_End - SideAFile07_Start
    .byte $00, $04
SideAFile07_Start:
    .word $9396
    .word $C000
    .word $C000
SideAFile07_End:

; file $08 - main.pgm
    .byte $03, $08, $20
    .ascstr "MAIN.PGM"
    .word $6800, SideAFile08_End - SideAFile08_Start
    .byte $00, $04
SideAFile08_Start:
    .incbin "fdspacker_output/side_1/main.pgm.prg"
SideAFile08_End:

; file $09 - endobj
    .byte $03, $09, $EE
    .ascstr "ENDOBJ", $00, $00
    .word $0000, SideAFile09_End - SideAFile09_Start
    .byte $01, $04
SideAFile09_Start:
    .incbin "fdspacker_output/side_1/endobj.chr"
SideAFile09_End:

; file $0A - endbg
    .byte $03, $0A, $EE
    .ascstr "ENDBG", $00, $00, $00
    .word $1000, SideAFile0A_End - SideAFile0A_Start
    .byte $01, $04
SideAFile0A_Start:
    .incbin "fdspacker_output/side_1/endbg.chr"
SideAFile0A_End:

; file $0B - mmeee
    .byte $03, $0B, $EE
    .ascstr "MMEEE", $00, $00, $00
    .word $CC00, SideAFile0B_End - SideAFile0B_Start
    .byte $00, $04
SideAFile0B_Start:
    .incbin "fdspacker_output/side_1/mmeee.prg"
SideAFile0B_End:

; file $0C - endpgm
    .byte $03, $0C, $EE
    .ascstr "ENDPGM", $00, $00
    .word $6000, SideAFile0C_End - SideAFile0C_Start
    .byte $00, $04
SideAFile0C_Start:
    .incbin "fdspacker_output/side_1/endpgm.prg"
SideAFile0C_End:

; file $0D - endvec
    .byte $03, $0D, $EE
    .ascstr "ENDVEC", $00, $00
    .word $DFFA, SideAFile0D_End - SideAFile0D_Start
    .byte $00, $04
SideAFile0D_Start:
    .word $60D9
    .word $6000
    .word $6143
SideAFile0D_End:

; file $0E - \u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001
    .byte $03, $0E, $0E
    .ascstr $01, $01, $01, $01, $01, $01, $01, $01
    .word $C5A0, SideAFile0E_End - SideAFile0E_Start
    .byte $00, $04
SideAFile0E_Start:
    .incbin "fdspacker_output/side_1/u0001.prg"
SideAFile0E_End:

; pad the rest with zero ($34C6 bytes)
    .ds $34C6, $00

.ENDS

