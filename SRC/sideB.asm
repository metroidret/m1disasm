
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


.SECTION "Side B - Dummy" BANK 1 SLOT "DummySlot" ORGA $0000 FORCE

; disk info block
    .byte $01, $2A, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $2D, $48, $56, $43, $2A, $01, $4D, $45, $54, $20, $02, $01, $00, $00, $00, $0F, $FF, $FF, $FF, $FF, $FF, $00, $68, $43, $4F, $4E, $20, $62, $79, $20, $68, $61, $6C, $39, $39, $39, $39, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $1C


; file $00 - hmbg1a
    .byte $03, $00, $81, $48, $4D, $42, $47, $31, $41, $00, $00, $00, $10, $50, $01, $01, $04
    .incbin "fdspacker_output/side_2/hmbg1a.chr"

; file $01 - hmbg1b
    .byte $03, $01, $90, $48, $4D, $42, $47, $31, $42, $00, $00, $00, $12, $50, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmbg1b.chr"

; file $02 - hmbg1c
    .byte $03, $02, $91, $48, $4D, $42, $47, $31, $43, $00, $00, $00, $18, $00, $08, $01, $04
    .incbin "fdspacker_output/side_2/hmbg1c.chr"

; file $03 - hmob1b
    .byte $03, $03, $81, $48, $4D, $4F, $42, $31, $42, $00, $00, $00, $0C, $00, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmob1b.chr"

; file $04 - hmbg4a
    .byte $03, $04, $84, $48, $4D, $42, $47, $34, $41, $00, $00, $00, $10, $60, $02, $01, $04
    .incbin "fdspacker_output/side_2/hmbg4a.chr"

; file $05 - hmbg4b
    .byte $03, $05, $84, $48, $4D, $42, $47, $34, $42, $00, $00, $00, $17, $70, $00, $01, $04
    .incbin "fdspacker_output/side_2/hmbg4b.chr"

; file $06 - hmob4a
    .byte $03, $06, $84, $48, $4D, $4F, $42, $34, $41, $00, $00, $00, $0C, $00, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmob4a.chr"

; file $07 - hmbg6c
    .byte $03, $07, $92, $48, $4D, $42, $47, $36, $43, $00, $00, $00, $10, $E0, $02, $01, $04
    .incbin "fdspacker_output/side_2/hmbg6c.chr"

; file $08 - hmbg5b
    .byte $03, $08, $85, $48, $4D, $42, $47, $35, $42, $00, $00, $00, $12, $00, $06, $01, $04
    .incbin "fdspacker_output/side_2/hmbg5b.chr"

; file $09 - hmbg5c
    .byte $03, $09, $85, $48, $4D, $42, $47, $35, $43, $00, $00, $00, $19, $90, $00, $01, $04
    .incbin "fdspacker_output/side_2/hmbg5c.chr"

; file $0A - hmbg5d
    .byte $03, $0A, $85, $48, $4D, $42, $47, $35, $44, $00, $00, $00, $1D, $00, $03, $01, $04
    .incbin "fdspacker_output/side_2/hmbg5d.chr"

; file $0B - hmob5a
    .byte $03, $0B, $85, $48, $4D, $4F, $42, $35, $41, $00, $00, $00, $0C, $00, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmob5a.chr"

; file $0C - hmbg6a
    .byte $03, $0C, $86, $48, $4D, $42, $47, $36, $41, $00, $00, $00, $17, $C0, $00, $01, $04
    .incbin "fdspacker_output/side_2/hmbg6a.chr"

; file $0D - hmbg6b
    .byte $03, $0D, $86, $48, $4D, $42, $47, $36, $42, $00, $00, $00, $1E, $00, $02, $01, $04
    .incbin "fdspacker_output/side_2/hmbg6b.chr"

; file $0E - hmob6a
    .byte $03, $0E, $86, $48, $4D, $4F, $42, $36, $41, $00, $00, $00, $0C, $00, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmob6a.chr"

; file $0F - hmbg7a
    .byte $03, $0F, $87, $48, $4D, $42, $47, $37, $41, $00, $00, $00, $17, $C0, $00, $01, $04
    .incbin "fdspacker_output/side_2/hmbg7a.chr"

; file $10 - hmob7a
    .byte $03, $10, $87, $48, $4D, $4F, $42, $37, $41, $00, $00, $00, $0C, $00, $04, $01, $04
    .incbin "fdspacker_output/side_2/hmob7a.chr"

; file $11 - mmrock
    .byte $03, $11, $10, $4D, $4D, $52, $4F, $43, $4B, $00, $00, $A0, $DE, $50, $01, $00, $04
    .incbin "fdspacker_output/side_2/mmrock.prg"

; file $12 - mmfire
    .byte $03, $12, $11, $4D, $4D, $46, $49, $52, $45, $00, $00, $A0, $DE, $50, $01, $00, $04
    .incbin "fdspacker_output/side_2/mmfire.prg"

; file $13 - mmkiti
    .byte $03, $13, $13, $4D, $4D, $4B, $49, $54, $49, $00, $00, $A0, $DE, $50, $01, $00, $04
    .incbin "fdspacker_output/side_2/mmkiti.prg"

; file $14 - mmkbos
    .byte $03, $14, $1F, $4D, $4D, $4B, $42, $4F, $53, $00, $00, $A0, $DE, $50, $01, $00, $04
    .incbin "fdspacker_output/side_2/mmkbos.prg"

; file $15 - stg1pgm
    .byte $03, $15, $10, $53, $54, $47, $31, $50, $47, $4D, $00, $60, $B5, $80, $1A, $00, $04
    .incbin "fdspacker_output/side_2/stg1pgm.prg"

; file $16 - stg4pgm
    .byte $03, $16, $11, $53, $54, $47, $34, $50, $47, $4D, $00, $60, $B5, $80, $1A, $00, $04
    .incbin "fdspacker_output/side_2/stg4pgm.prg"

; file $17 - stg5pgm
    .byte $03, $17, $13, $53, $54, $47, $35, $50, $47, $4D, $00, $60, $B5, $20, $1A, $00, $04
    .incbin "fdspacker_output/side_2/stg5pgm.prg"

; file $18 - stg6pgm
    .byte $03, $18, $12, $53, $54, $47, $36, $50, $47, $4D, $00, $60, $B5, $80, $17, $00, $04
    .incbin "fdspacker_output/side_2/stg6pgm.prg"

; file $19 - stg7pgm
    .byte $03, $19, $14, $53, $54, $47, $37, $50, $47, $4D, $00, $60, $B5, $80, $16, $00, $04
    .incbin "fdspacker_output/side_2/stg7pgm.prg"

; file $1A - mensave2
    .byte $03, $1A, $EF, $4D, $45, $4E, $53, $41, $56, $45, $32, $F0, $C3, $B0, $01, $00, $04
    .incbin "fdspacker_output/side_2/mensave2.prg"

; file $1B - \u0002\u0002\u0002\u0002\u0002\u0002\u0002\u0002
    .byte $03, $1B, $EF, $02, $02, $02, $02, $02, $02, $02, $02, $00, $C0, $F0, $03, $00, $04
    .incbin "fdspacker_output/side_2/u0002.prg"

; pad the rest with zero ($4166 bytes)
    .ds $4166, $00

.ENDS

