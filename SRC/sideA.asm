
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


.STRINGMAPTABLE charmap_kyodaku "SRC/kyodaku.tbl"

.SECTION "Side A - Dummy" BANK 0 SLOT "DummySlot" ORGA $0000 FORCE

; disk info block
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $00, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $0F


; file $00 - kyodaku-
    .byte $03, $00, $00, $4B, $59, $4F, $44, $41, $4B, $55, $2D, $00, $28, $E0, $00, $02, $04
    .stringmap charmap_kyodaku, "           NINTENDO r           "
    .stringmap charmap_kyodaku, "       FAMILY COMPUTER TM       "
    .stringmap charmap_kyodaku, "                                "
    .stringmap charmap_kyodaku, "  THIS PRODUCT IS MANUFACTURED  "
    .stringmap charmap_kyodaku, "  AND SOLD BY NINTENDO CO;LTD.  "
    .stringmap charmap_kyodaku, "  OR BY OTHER COMPANY UNDER     "
    .stringmap charmap_kyodaku, "  LICENSE OF NINTENDO CO;LTD..  "

; file $01 - demo.chr
    .byte $03, $01, $00, $44, $45, $4D, $4F, $2E, $43, $48, $52, $00, $00, $A0, $1D, $01, $04
    .incbin "fdspacker_output/side_1/demo.chr.chr"

; file $02 - met.hex
    .byte $03, $02, $00, $4D, $45, $54, $2E, $48, $45, $58, $00, $00, $D0, $F6, $0F, $00, $04
    .incbin "fdspacker_output/side_1/met.hex.prg"

; file $03 - demo.pgm
    .byte $03, $03, $00, $44, $45, $4D, $4F, $2E, $50, $47, $4D, $00, $68, $00, $29, $00, $04
    .incbin "fdspacker_output/side_1/demo.pgm.prg"

; file $04 - demo.pg2
    .byte $03, $04, $00, $44, $45, $4D, $4F, $2E, $50, $47, $32, $A0, $C5, $C0, $09, $00, $04
    .incbin "fdspacker_output/side_1/demo.pg2.prg"

; file $05 - demo.vec
    .byte $03, $05, $00, $44, $45, $4D, $4F, $2E, $56, $45, $43, $FA, $DF, $06, $00, $00, $04
    .incbin "fdspacker_output/side_1/demo.vec.prg"

; file $06 - bmenst
    .byte $03, $06, $20, $42, $4D, $45, $4E, $53, $54, $00, $00, $00, $C0, $C0, $00, $00, $04
    .incbin "fdspacker_output/side_1/bmenst.prg"

; file $07 - main.vec
    .byte $03, $07, $20, $4D, $41, $49, $4E, $2E, $56, $45, $43, $FA, $DF, $06, $00, $00, $04
    .incbin "fdspacker_output/side_1/main.vec.prg"

; file $08 - main.pgm
    .byte $03, $08, $20, $4D, $41, $49, $4E, $2E, $50, $47, $4D, $00, $68, $10, $4C, $00, $04
    .incbin "fdspacker_output/side_1/main.pgm.prg"

; file $09 - endobj
    .byte $03, $09, $EE, $45, $4E, $44, $4F, $42, $4A, $00, $00, $00, $00, $00, $06, $01, $04
    .incbin "fdspacker_output/side_1/endobj.chr"

; file $0A - endbg
    .byte $03, $0A, $EE, $45, $4E, $44, $42, $47, $00, $00, $00, $00, $10, $00, $04, $01, $04
    .incbin "fdspacker_output/side_1/endbg.chr"

; file $0B - mmeee
    .byte $03, $0B, $EE, $4D, $4D, $45, $45, $45, $00, $00, $00, $00, $CC, $D0, $03, $00, $04
    .incbin "fdspacker_output/side_1/mmeee.prg"

; file $0C - endpgm
    .byte $03, $0C, $EE, $45, $4E, $44, $50, $47, $4D, $00, $00, $00, $60, $80, $0D, $00, $04
    .incbin "fdspacker_output/side_1/endpgm.prg"

; file $0D - endvec
    .byte $03, $0D, $EE, $45, $4E, $44, $56, $45, $43, $00, $00, $FA, $DF, $06, $00, $00, $04
    .incbin "fdspacker_output/side_1/endvec.prg"

; file $0E - \u0001\u0001\u0001\u0001\u0001\u0001\u0001\u0001
    .byte $03, $0E, $0E, $01, $01, $01, $01, $01, $01, $01, $01, $A0, $C5, $75, $00, $00, $04
    .incbin "fdspacker_output/side_1/u0001.prg"

; pad the rest with zero ($34C6 bytes)
    .ds $34C6, $00

.ENDS

