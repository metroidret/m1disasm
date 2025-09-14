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
;Can be assembled using Ophis.
;Last updated: 2/21/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Graphics data (memory page 6)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.redef BANK = 6
.section "ROM Bank $006" bank 6 slot "ROMSwitchSlot" orga $8000 force

;------------------------------------------[ Start of code ]-----------------------------------------

; These are loaded together.
GFX_Samus:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/samus.chr" ; 8000 - Samus and gear tile patterns.
        .incbin "common_chr/items.chr" ; Item Graphics (plus bomb, the N in "EN", and another dot thingy)
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $9A0, $00
    .endif

GFX_IntroSprites:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/intro_sprites.chr" ; 89A0 - Intro and end tile patterns.
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $100, $00
    .endif

; Garbage data
; (part of areas_common.asm from L6_8AA0 to L6_8BDF (sprite data, Samus door routines))
GFX_Garbage8AA0:
    .byte $FF, $04, $00, $00, $5A, $FF, $13, $00, $00, $B0, $B1, $B2, $B3, $FF, $13, $00
    .byte $00, $B4, $B5, $B6, $B7, $B8, $B6, $B9, $B3, $FF, $13, $00, $00, $B3, $BA, $BA
    .byte $FE, $80, $80, $FF, $1E, $00, $08, $FA, $FB, $FA, $FB, $FC, $00, $04, $C5, $C6
    .byte $C7, $D5, $D6, $D7, $E5, $E6, $E7, $FF, $1E, $00, $08, $FA, $FB, $FA, $FB, $FE
    .byte $C8, $C9, $EB, $D8, $D9, $EA, $E8, $E9, $FF, $0A, $04, $08, $FD, $00, $57, $FD
    .byte $40, $57, $FF, $0B, $04, $0C, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0
    .byte $18, $18, $FF, $0C, $04, $10, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0
    .byte $18, $18, $FF, $A5, $56, $D0, $55, $A4, $58, $F0, $51, $85, $95, $85, $96, $A5
    .byte $2E, $29, $0F, $85, $93, $0A, $09, $40, $85, $94, $A5, $FF, $49, $01, $29, $01
    .byte $A8, $4A, $99, $6C, $00, $A5, $49, $29, $02, $D0, $10, $A2, $04, $A5, $FC, $F0
    .byte $2C, $A5, $FF, $4D, $0C, $03, $4A, $90, $0A, $B0, $07, $A2, $02, $AD, $0E, $03
    .byte $10, $01, $CA, $8A, $85, $57, $20, $74, $8B, $A9, $12, $85, $59, $A5, $58, $20
    .byte $C5, $C2, $0D, $00, $03, $85, $58, $A9, $05, $8D, $00, $03, $60, $20, $53, $8B
    .byte $20, $1B, $E2, $8A, $09, $80, $85, $56, $60, $A2, $B0, $20, $87, $8B, $A5, $4B
    .byte $38, $E9, $10, $AA, $30, $F5, $60, $86, $4B, $BD, $00, $03, $20, $7C, $C2, $5C
    .byte $C4, $9D, $8B, $D5, $8B, $01, $8C, $84, $8C, $C6, $8C, $F0, $8C, $FE, $00, $03
    .byte $A9, $30, $20, $FA, $D2, $20, $FB, $8C, $BC, $07, $03, $B9, $D1, $8B, $9D, $0F
    .byte $03, $BD, $07, $03, $C9, $03, $D0, $02, $A9, $01, $09, $A0, $85, $6B, $A9, $00
    .byte $9D, $0A, $03, $8A, $29, $10, $49, $10, $05, $6B, $85, $6B, $A9, $06, $4C, $47
    .byte $DE, $05, $01, $0A, $01, $BD, $0A, $03, $29, $04, $F0, $D5, $DE, $0F, $03, $D0

; 8BE0 - METROID title screen CHR
GFX_Title:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/title.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/title_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $500, $00
    .endif

; 90E0 - Suitless Samus (in-game)
GFX_SamusSuitless:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/samus_suitless.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $7B0, $00
    .endif

; 9890 - Exclamation point
GFX_ExclamationPoint:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/exclamation_point.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/exclamation_point_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $10, $00
    .endif

; Garbage data (leftovers from Ridley's bank)
GFX_Garbage98A0:
    .byte $B9, $D5, $98, $9D, $03, $04, $BD, $05, $04, $0A, $30, $1E, $BD, $F4, $6A, $C9
    .byte $02, $D0, $17, $20, $36, $80, $48, $20, $39, $80, $85, $05, $68, $85, $04, $20
    .byte $E1, $9A, $20, $27, $80, $90, $08, $20, $F1, $9A, $A9, $03, $4C, $03, $80, $A9
    .byte $00, $9D, $F4, $6A, $60, $08, $F8, $A9, $03, $85, $00, $A9, $08, $85, $01, $BD
    .byte $F4, $6A, $C9, $01, $D0, $0C, $BD, $05, $04, $29, $10, $F0, $05, $A9, $01, $20
    .byte $58, $99, $20, $F8, $98, $4C, $30, $98, $BD, $F4, $6A, $C9, $02, $D0, $0C, $A9
    .byte $20, $BC, $02, $04, $10, $02, $A9, $1D, $9D, $F9, $6A, $60, $A5, $81, $C9, $01
    .byte $F0, $10, $C9, $03, $F0, $3F, $BD, $F4, $6A, $C9, $01, $D0, $0A, $A9, $00, $20
    .byte $58, $99, $A9, $08, $4C, $03, $80, $A9, $80, $9D, $FE, $6A, $BD, $02, $04, $30
    .byte $1C, $BD, $05, $04, $29, $10, $F0, $15, $BD, $00, $04, $38, $ED, $0D, $03, $10
    .byte $03, $20, $C6, $95, $C9, $10, $B0, $05, $A9, $00, $9D, $FE, $6A, $20, $F8, $98
    .byte $A9, $03, $4C, $00, $80, $4C, $06, $80, $9D, $02, $6B, $BD, $0B, $04, $48, $20
    .byte $2A, $80, $68, $9D, $0B, $04, $60, $20, $09, $80, $29, $03, $F0, $34, $A5, $81
    .byte $C9, $01, $F0, $36, $C9, $03, $F0, $2F, $BD, $F4, $6A, $C9, $03, $F0, $23, $BD

;Blank tile patterns.
GFX_Solid:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/solid.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $40, $00
    .endif

; Garbage data (leftovers from Ridley's bank)
GFX_Garbage99C0:
    .byte $53, $4D, $50, $50, $4D, $53, $A6, $4B, $B0, $19, $A5, $00, $D0, $0D, $BC, $0A
    .byte $04, $88, $98, $29, $03, $9D, $0A, $04, $4C, $AD, $99, $BD, $05, $04, $49, $01
    .byte $9D, $05, $04, $60, $20, $F8, $99, $20, $00, $9A, $A6, $4B, $90, $09, $20, $F8
    .byte $99, $9D, $0A, $04, $20, $AD, $99, $60, $BC, $0A, $04, $C8, $98, $29, $03, $60
    .byte $BC, $05, $04, $84, $00, $46, $00, $2A, $0A, $A8, $B9, $49, $80, $48, $B9, $48
    .byte $80, $48, $60, $BD, $F4, $6A, $C9, $03, $90, $19, $F0, $04, $C9, $05, $D0, $21
    .byte $A9, $00, $8D, $04, $6B, $8D, $14, $6B, $8D, $24, $6B, $8D, $34, $6B, $8D, $44
    .byte $6B, $F0, $0E, $A9, $0B, $85, $85, $A9, $0E, $85, $86, $20, $1B, $80, $20, $79
    .byte $9A, $A9, $03, $85, $00, $85, $01, $4C, $30, $98, $BD, $05, $04, $48, $A9, $02
    .byte $85, $00, $85, $01, $20, $30, $98, $68, $A6, $4B, $5D, $05, $04, $4A, $B0, $13
    .byte $BD, $05, $04, $4A, $B0, $12, $BD, $01, $04, $38, $ED, $0E, $03, $90, $09, $C9
    .byte $20, $90, $05, $A9, $00, $9D, $F4, $6A, $60, $A4, $80, $D0, $02, $A0, $60, $A5
    .byte $2D, $29, $02, $D0, $24, $88, $84, $80, $98, $0A, $30, $1D, $29, $0F, $C9, $0A
    .byte $D0, $17, $A2, $50, $BD, $F4, $6A, $F0, $11, $BD, $05, $04, $29, $02, $F0, $0A
    .byte $8A, $38, $E9, $10, $AA, $D0, $ED, $E6, $7E, $60, $8A, $A8, $A2, $00, $20, $E1
    .byte $9A, $98, $AA, $AD, $05, $04, $9D, $05, $04, $29, $01, $A8, $B9, $DF, $9A, $85
    .byte $05, $A9, $F8, $85, $04, $20, $27, $80, $90, $DF, $A9, $00, $9D, $0F, $04, $A9
    .byte $0A, $9D, $02, $6B, $A9, $01, $9D, $F4, $6A, $20, $F1, $9A, $4C, $2A, $80, $08
    .byte $F8, $BD, $00, $04, $85, $08, $BD, $01, $04, $85, $09, $BD, $FB, $6A, $85, $0B
    .byte $60, $A5, $0B, $29, $01, $9D, $FB, $6A, $A5, $08, $9D, $00, $04, $A5, $09, $9D
    .byte $01, $04, $60, $BD, $F4, $6A, $C9, $02, $D0, $03, $20, $1E, $80, $A9, $02, $85
    .byte $00, $85, $01, $4C, $30, $98, $A9, $00, $9D, $F5, $6A, $9D, $F6, $6A, $A9, $10
    .byte $9D, $05, $04, $8A, $4A, $4A, $4A, $4A, $65, $2D, $29, $07, $D0, $1A, $5E, $05
    .byte $04, $A9, $03, $85, $87, $A5, $2E, $4A, $3E, $05, $04, $29, $03, $F0, $09, $85
    .byte $88, $A9, $02, $85, $85, $4C, $21, $80, $60, $22, $FF, $FF, $FF, $FF, $22, $80
    .byte $81, $82, $83, $22, $84, $85, $86, $87, $22, $88, $89, $8A, $8B, $22, $8C, $8D
    .byte $8E, $8F, $22, $94, $95, $96, $97, $22, $9C, $9D, $9D, $9C, $22, $9E, $9F, $9F
    .byte $9E, $22, $90, $91, $92, $93, $22, $70, $71, $72, $73, $22, $74, $75, $76, $77
    .byte $22, $78, $79, $7A, $7B, $00, $01, $FF, $02, $FF, $03, $04, $FF, $07, $08, $FF
    .byte $05, $06, $FF, $09, $0A, $FF, $0B, $FF, $0C, $0D, $0E, $0F, $FF, $10, $11, $12
    .byte $13, $FF, $17, $18, $FF, $19, $1A, $FF, $1B, $FF, $21, $22, $FF, $27, $28, $29
    .byte $2A, $FF, $2B, $2C, $2D, $2E, $FF, $2F, $FF, $42, $FF, $43, $44, $F7, $FF, $37
    .byte $FF, $38, $FF, $30, $31, $FF, $31, $32, $FF, $33, $34, $FF, $34, $35, $FF, $58
    .byte $59, $FF, $5A, $5B, $FF, $5C, $5D, $FF, $5E, $5F, $FF, $60, $FF, $61, $F7, $62
    .byte $F7, $FF, $66, $67, $FF, $69, $6A, $FF, $68, $FF, $6B, $FF, $66, $FF, $69, $FF
    .byte $D8, $9D, $DD, $9D, $E2, $9D, $E7, $9D, $FA, $9D, $0E, $9E, $24, $9E, $3A, $9E
    .byte $4D, $9E, $61, $9E, $77, $9E, $8D, $9E, $97, $9E, $9C, $9E, $A1, $9E, $A6, $9E
    .byte $AB, $9E, $B0, $9E, $B5, $9E, $BA, $9E, $BF, $9E, $BF, $9E, $BF, $9E, $BF, $9E
    .byte $CE, $9E, $DD, $9E, $EE, $9E, $FF, $9E, $07, $9F, $07, $9F, $07, $9F, $07, $9F
    .byte $07, $9F, $07, $9F, $0F, $9F, $17, $9F, $17, $9F, $17, $9F, $17, $9F, $17, $9F
    .byte $23, $9F, $31, $9F, $3F, $9F, $4D, $9F, $59, $9F, $67, $9F, $75, $9F, $83, $9F
    .byte $8E, $9F, $9C, $9F, $AA, $9F, $B6, $9F, $C4, $9F, $D2, $9F, $DE, $9F, $DE, $9F
    .byte $F2, $9F, $06, $A0, $06, $A0, $06, $A0, $06, $A0, $06, $A0, $06, $A0, $06, $A0
    .byte $06, $A0, $06, $A0, $06, $A0, $0B, $A0, $13, $A0, $1B, $A0, $1B, $A0, $1B, $A0
    .byte $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0
    .byte $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0, $1B, $A0
    .byte $1B, $A0, $27, $A0, $33, $A0, $3F, $A0, $4B, $A0, $57, $A0, $63, $A0, $6F, $A0
    .byte $7B, $A0, $83, $A0, $91, $A0, $AB, $A0, $AB, $A0, $AB, $A0, $AB, $A0, $B3, $A0
    .byte $BB, $A0, $C3, $A0, $CB, $A0, $D3, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0
    .byte $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0
    .byte $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0, $DB, $A0
    .byte $DB, $A0, $E1, $A0, $E6, $A0, $E6, $A0, $E6, $A0, $E6, $A0, $E6, $A0, $E6, $A0
    .byte $E6, $A0, $E6, $A0, $22, $9D, $24, $9D, $3C, $9D, $60, $9D, $72, $9D, $64, $9D
    .byte $6E, $9D, $76, $9D, $82, $9D, $8A, $9D, $8A, $9D, $AA, $9D, $B8, $9D, $BC, $9D
    .byte $CC, $9D, $FC, $FC, $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00, $EC, $F8, $EC, $00
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0, $04, $F8, $04, $00
    .byte $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4, $12, $E8, $14, $F8
    .byte $F4, $F4, $F4, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00, $FC, $F8
    .byte $FC, $00, $F0, $F8, $F0, $00, $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8
    .byte $08, $00, $F8, $E8, $F8, $10, $F8, $F0, $F8, $08, $F8, $F8, $F8, $00, $00, $F8
    .byte $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0, $F0, $F8, $F8, $F0, $00, $F0

; 9DA0 - Brinstar BG CHR data
GFX_BrinBG1:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "brinstar/bg_chr_1.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "brinstar/bg_chr_1_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $150, $00
    .endif

; 9EF0 - Common Room Elements (loaded in all areas)
GFX_CREBG2:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_CRE_2.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/bg_CRE_2_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $800, $00
    .endif

; A6F0 - Norfair BG CHR data
GFX_NorfBG1:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "norfair/bg_chr_1.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "norfair/bg_chr_1_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $260, $00
    .endif

; A950 - Norfair BG CHR data
GFX_NorfBG2:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "norfair/bg_chr_2.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "norfair/bg_chr_2_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $70, $00
    .endif

; A9C0 - Kraid, Ridley, Tourian BG CHR
GFX_BossBG:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_boss_areas.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/bg_boss_areas_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $2E0, $00
    .endif

; ACA0 - Tourian BG CHR
GFX_TourBG:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "tourian/bg_chr.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "tourian/bg_chr_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $600, $00
    .endif

; B2A0 - Zebetite BG CHR
GFX_Zebetite:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZMUS"
        .incbin "tourian/zebetite_chr.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $90, $00
    .endif

; B330 - More Kraid BG CHR
GFX_KraiBG2:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "kraid/bg_chr_2.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "kraid/bg_chr_2_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $C0, $00
    .endif

; B3F0 - More Ridley BG CHR
GFX_RidlBG:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "ridley/bg_chr.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "ridley/bg_chr_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $C0, $00
    .endif

;Not used.
GFX_GarbageB4B0:
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .byte $65, $06, $DD, $60, $06, $D0, $05, $A9, $00, $9D, $65, $06, $60, $8D, $4D, $06
.elif BUILDTARGET == "NES_PAL"
    .byte $06, $A9, $00, $9D, $65, $06, $9D, $70, $06, $9D, $74, $06, $9D, $78, $06, $8D
.endif

; B4C0 - Font (upper and lowercase)
GFX_Font:
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/font.chr"
    .elif BUILDTARGET == "NES_MZMUS"
        .incbin "common_chr/font_mzmus.chr"
    .elif BUILDTARGET == "NES_MZMJP"
        .ds $400, $00
    .endif

GFX_GarbageB8C0:
    .incbin "common_chr/exclamation_point.chr" ; B8C0 - Exclamation point (unused)

; Garbage data (Half of the music engine)
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZMUS" || BUILDTARGET == "NES_MZMJP"
    .byte $40, $60, $20, $04, $B4, $A9, $0E, $A0, $75, $20, $52, $B4, $A9, $15, $8D, $16
    .byte $06, $AD, $77, $B2, $8D, $10, $06, $A9, $00, $8D, $11, $06, $60, $20, $A9, $B4
    .byte $D0, $1A, $A9, $20, $8D, $12, $06, $A9, $00, $8D, $13, $06, $20, $8C, $B9, $EE
    .byte $73, $06, $AD, $73, $06, $C9, $06, $D0, $E3, $4C, $96, $B8, $20, $A0, $B9, $AD
    .byte $14, $06, $8D, $12, $06, $AD, $15, $06, $8D, $13, $06, $20, $78, $B9, $4C, $69
    .byte $B8, $AD, $83, $B2, $8D, $10, $06, $AD, $84, $B2, $29, $07, $8D, $11, $06, $A9
    .byte $00, $8D, $13, $06, $A9, $0B, $8D, $12, $06, $A9, $06, $A0, $81, $4C, $52, $B4
    .byte $20, $A9, $B4, $D0, $2D, $EE, $73, $06, $AD, $73, $06, $C9, $09, $D0, $03, $4C
    .byte $96, $B8, $AD, $12, $06, $48, $AD, $13, $06, $48, $A9, $25, $8D, $12, $06, $A9
    .byte $00, $8D, $13, $06, $20, $78, $B9, $68, $8D, $13, $06, $68, $8D, $12, $06, $4C
    .byte $69, $B8, $20, $8C, $B9, $4C, $69, $B8, $18, $AD, $10, $06, $6D, $12, $06, $8D
    .byte $10, $06, $AD, $11, $06, $6D, $13, $06, $8D, $11, $06, $60, $38, $AD, $10, $06
    .byte $ED, $12, $06, $8D, $10, $06, $AD, $11, $06, $ED, $13, $06, $8D, $11, $06, $60
    .byte $AD, $10, $06, $48, $AD, $11, $06, $48, $A9, $00, $8D, $17, $06, $A2, $10, $2E
    .byte $10, $06, $2E, $11, $06, $2E, $17, $06, $AD, $17, $06, $CD, $16, $06, $90, $06
    .byte $ED, $16, $06, $8D, $17, $06, $2E, $10, $06, $2E, $11, $06, $CA, $D0, $E6, $AD
    .byte $10, $06, $8D, $14, $06, $AD, $11, $06, $8D, $15, $06, $68, $8D, $11, $06, $68
    .byte $8D, $10, $06, $60, $A9, $7F, $8D, $48, $06, $8D, $49, $06, $8E, $28, $06, $8C
    .byte $29, $06, $60, $AD, $40, $06, $C9, $01, $D0, $03, $8D, $6A, $06, $AD, $41, $06
    .byte $C9, $01, $D0, $03, $8D, $6B, $06, $60, $AD, $07, $06, $F0, $29, $A9, $00, $8D
    .byte $07, $06, $AD, $48, $06, $8D, $01, $40, $AD, $00, $06, $8D, $02, $40, $AD, $01
    .byte $06, $8D, $03, $40, $AD, $49, $06, $8D, $05, $40, $AD, $04, $06, $8D, $06, $40
    .byte $AD, $05, $06, $8D, $07, $40, $60, $A2, $00, $20, $41, $BA, $E8, $20, $41, $BA
    .byte $60, $BD, $2E, $06, $F0, $45, $85, $EB, $20, $08, $BA, $BD, $6C, $06, $C9, $10
    .byte $F0, $47, $A0, $00, $C6, $EB, $F0, $04, $C8, $C8, $D0, $F8, $B9, $B0, $BC, $85
    .byte $EC, $B9, $B1, $BC, $85, $ED, $BC, $6A, $06, $B1, $EC, $85, $EA, $C9, $FF, $F0
    .byte $1F, $C9, $F0, $F0, $20, $BD, $28, $06, $29, $F0, $05, $EA, $A8, $FE, $6A, $06
    .byte $BD, $53, $06, $D0, $06, $8A, $F0, $04, $8C, $04, $40, $60, $8C, $00, $40, $60
    .byte $BC, $28, $06, $D0, $EB, $A0, $10, $D0, $E7, $A0, $10, $D0, $E0, $20, $F0, $B3
    .byte $60, $20, $37, $BA, $60, $20, $F3, $B9, $A9, $00, $AA, $8D, $4B, $06, $F0, $12
    .byte $8A, $4A, $AA, $E8, $8A, $C9, $04, $F0, $E8, $AD, $4B, $06, $18, $69, $04, $8D
    .byte $4B, $06, $8A, $0A, $AA, $BD, $30, $06, $85, $E6, $BD, $31, $06, $85, $E7, $BD
    .byte $31, $06, $F0, $DC, $8A, $4A, $AA, $DE, $40, $06, $D0, $D7, $BC, $38, $06, $FE
    .byte $38, $06, $B1, $E6, $F0, $B7, $A8, $C9, $FF, $F0, $09, $29, $C0, $C9, $C0, $F0
    .byte $13, $4C, $1C, $BB, $BD, $24, $06, $F0, $1A, $DE, $24, $06, $BD, $3C, $06, $9D
    .byte $38, $06, $D0, $0F, $98, $29, $3F, $9D, $24, $06, $DE, $24, $06, $BD, $38, $06
    .byte $9D, $3C, $06, $4C, $DC, $BA, $4C, $DE, $BB, $4C, $B7, $BB, $98, $29, $B0, $C9
    .byte $B0, $D0, $1D, $98, $29, $0F, $18, $6D, $2B, $06, $A8, $B9, $F7, $BE, $9D, $20
    .byte $06, $A8, $8A, $C9, $02, $F0, $E2, $BC, $38, $06, $FE, $38, $06, $B1, $E6, $A8
    .byte $8A, $C9, $03, $F0, $D1, $48, $AE, $4B, $06, $B9, $78, $BE, $F0, $0B, $9D, $00
    .byte $06, $B9, $77, $BE, $09, $08, $9D, $01, $06, $A8, $68, $AA, $98, $D0, $0F, $A9
    .byte $00, $85, $EA, $8A, $C9, $02, $F0, $0B, $A9, $10, $85, $EA, $D0, $05, $BD, $28
    .byte $06, $85, $EA, $8A, $DE, $53, $06, $DD, $53, $06, $F0, $35, $FE, $53, $06, $AC
    .byte $4B, $06, $8A, $C9, $02, $F0, $05, $BD, $2E, $06, $D0, $05, $A5, $EA, $99, $00
    .byte $40, $A5, $EA, $9D, $6C, $06, $B9, $00, $06, $99, $02, $40, $B9, $01, $06, $99
    .byte $03, $40, $BD, $48, $06, $99, $01, $40, $BD, $20, $06, $9D, $40, $06, $4C, $B3
    .byte $BA, $FE, $53, $06, $4C, $A8, $BB, $AD, $2D, $06, $29, $0F, $D0, $1A, $AD, $2D
    .byte $06, $29, $F0, $D0, $04, $98, $4C, $CD, $BB, $A9, $FF, $D0, $0B, $18, $69, $FF
    .byte $0A, $0A, $C9, $3C, $90, $02, $A9, $3C, $8D, $2A, $06, $4C, $37, $BB, $AD, $88
    .byte $06, $29, $FC, $D0, $12, $B9, $00, $B2, $8D, $0C, $40, $B9, $01, $B2, $8D, $0E
    .byte $40, $B9, $02, $B2, $8D, $0F, $40, $4C, $A8, $BB, $41, $8F, $34, $27, $1A, $0D
    .byte $00, $82, $68, $75, $4E, $5B, $80, $BC, $7A, $BC, $86, $BC, $7A, $BC, $EE, $B4
    .byte $73, $B6, $EC, $B5, $95, $B6, $EE, $B4, $EE, $B4, $EE, $B4, $EE, $B4, $EE, $B4
    .byte $50, $B6, $F6, $B5, $A1, $B6, $83, $BC, $77, $BC, $77, $BC, $77, $BC, $80, $BC
    .byte $7D, $BC, $77, $BC, $80, $BC, $AD, $5D, $06, $A2, $B6, $D0, $05, $AD, $85, $06
    .byte $A2, $B1, $20, $BD, $B4, $20, $53, $BC, $6C, $E2, $00, $AD, $8D, $06, $F0, $26
    .byte $4C, $A5, $BA, $A9, $FF, $8D, $5E, $06, $AD, $4D, $06, $F0, $06, $EE, $5E, $06
    .byte $0A, $90, $FA, $60, $AD, $5E, $06, $18, $69, $08, $8D, $5E, $06, $60, $AD, $8D
    .byte $06, $09, $F0, $8D, $8D, $06, $60, $4C, $AA, $BC, $4C, $A4, $BC, $4C, $9A, $BC
    .byte $4C, $96, $BC, $4C, $89, $BC, $4C, $9E, $BC, $A9, $B3, $AA, $A8, $20, $E4, $B9
    .byte $20, $19, $BF, $4C, $A5, $BA, $A9, $34, $D0, $F1, $A9, $F4, $D0, $ED, $A2, $F5
    .byte $A0, $F6, $D0, $E9, $A2, $B6, $A0, $F6, $D0, $E3, $A2, $92, $A0, $96, $D0, $DD
    .byte $BA, $BC, $C5, $BC, $CF, $BC, $DA, $BC, $03, $BD, $01, $02, $02, $03, $03, $04
    .byte $05, $06, $07, $08, $FF, $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF, $00
    .byte $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF, $02, $06, $07, $07, $07, $06
    .byte $06, $06, $06, $05, $05, $05, $04, $04, $04, $03, $03, $03, $03, $02, $03, $03
    .byte $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01
    .byte $01, $01, $F0, $0A, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $07, $07, $06
    .byte $05, $04, $04, $03, $02, $02, $02, $05, $05, $05, $04, $03, $02, $02, $02, $01
    .byte $01, $04, $04, $03, $02, $01, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01
    .byte $F0, $0B, $FF, $F5, $00, $00, $00, $01, $00, $03, $00, $05, $00, $00, $0B, $FF
    .byte $00, $02, $02, $00, $01, $00, $03, $00, $05, $00, $07, $0B, $FF, $F0, $04, $04
    .byte $00, $01, $00, $03, $00, $05, $00, $07, $00, $FF, $F0, $00, $00, $3F, $B0, $41
    .byte $B0, $AA, $B0, $00, $00, $0B, $FF, $03, $00, $00, $DA, $BD, $DC, $BD, $CD, $BD
    .byte $00, $00, $0B, $FF, $F0, $01, $01, $22, $B0, $31, $B0, $00, $B0, $00, $00, $17
    .byte $00, $00, $02, $01, $00, $01, $00, $03, $00, $05, $00, $07, $17, $00, $F0, $02
    .byte $05, $00, $01, $00, $03, $00, $05, $00, $07, $0B, $00, $F0, $02, $00, $3E, $BE
    .byte $1D, $BE, $36, $BE, $00, $00, $00, $00, $F0, $01, $00, $F7, $BD, $0D, $BE, $08
    .byte $BE, $00, $00, $0B, $FF, $00, $02, $03, $00, $01, $00, $03, $00, $05, $00, $07
    .byte $0B, $FF, $03, $00, $00, $59, $BE, $47, $BE, $62, $BE, $00, $00, $C8, $B0, $38
    .byte $3A, $3C, $3E, $40, $3E, $3C, $3A, $B6, $02, $FF, $B8, $02, $B3, $02, $B2, $74
    .byte $02, $6A, $02, $72, $02, $62, $B4, $02, $B2, $60, $02, $6C, $02, $76, $B3, $02
    .byte $B2, $7E, $02, $7C, $B3, $02, $00, $B3, $48, $42, $B2, $3E, $38, $30, $38, $4C
    .byte $44, $3E, $36, $C8, $B0, $38, $3C, $FF, $B4, $2C, $2A, $1E, $1C, $B2, $22, $2C
    .byte $30, $34, $38, $30, $26, $30, $3A, $34, $2C, $26, $B4, $2A, $00, $C4, $B0, $3E
    .byte $30, $FF, $C4, $42, $30, $FF, $C4, $3A, $2C, $FF, $C4, $38, $26, $FF, $C4, $34
    .byte $20, $FF, $E0, $34, $24, $FF, $B3, $36, $34, $30, $2A, $B4, $1C, $1C, $B3, $34
    .byte $3A, $34, $30, $B4, $2A, $2A, $00, $B4, $12, $B3, $10, $18, $16, $0A, $B4, $14
    .byte $12, $B3, $10, $06, $0E, $04, $B4, $0C, $00, $E0, $B0, $54, $4E, $48, $42, $48
    .byte $4E, $FF, $E0, $B3, $02, $B0, $3C, $40, $44, $4A, $4E, $54, $58, $5C, $62, $66
    .byte $6C, $70, $74, $7A, $B3, $02, $FF, $07, $F0, $00, $00, $06, $4E, $05, $F3, $05
    .byte $4D, $05, $01, $04, $B9, $04, $75, $04, $35, $03, $F8, $03, $BF, $03, $89, $03
    .byte $57, $03, $27, $02, $F9, $02, $CF, $02, $A6, $02, $80, $02, $5C, $02, $3A, $02
    .byte $1A, $01, $FC, $01, $DF, $01, $C4, $01, $AB, $01, $93, $01, $7C, $01, $67, $01
    .byte $52, $01, $3F, $01, $2D, $01, $1C, $01, $0C, $00, $FD, $00, $EE, $00, $E1, $00
    .byte $D4, $00, $C8, $00, $BD, $00, $B2, $00, $A8, $00, $9F, $00, $96, $00, $8D, $00
    .byte $85, $00, $7E, $00, $76, $00, $70, $00, $69, $00, $63, $00, $5E, $00, $58, $00
    .byte $53, $00, $4F, $00, $4A, $00, $46, $00, $42, $00, $3E, $00, $3A, $00, $37, $00
    .byte $34, $00, $31, $00, $2E, $00, $27, $04, $08, $10, $20, $40, $18, $30, $0C, $0B
    .byte $05, $02, $06, $0C, $18, $30, $60, $24, $48, $12, $10, $08, $03, $10, $07, $0E
    .byte $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $FC, $B3, $AD, $4D, $06, $8D
    .byte $8D, $06, $AD, $5E, $06, $A8, $B9, $FA, $BB, $A8, $A2, $00, $B9, $31, $BD, $9D
    .byte $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40, $06, $8D, $41
    .byte $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D, $39, $06, $8D
    .byte $3A, $06, $8D, $3B, $06, $60, $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12
    .byte $02, $03, $20, $2C, $B4, $AD, $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9
    .byte $2A, $BC, $A8, $A2, $00, $B9, $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D
    .byte $D0, $F3, $A9, $01, $8D, $40, $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06
    .byte $A9, $00, $8D, $38, $06, $8D, $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
.elif BUILDTARGET == "NES_PAL"
    .byte $8D, $0B, $40, $20, $D2, $B4, $60, $A9, $03, $A0, $A1, $20, $82, $B4, $4C, $F3
    .byte $B8, $20, $D9, $B4, $F0, $0D, $EE, $73, $06, $AD, $73, $06, $C9, $09, $D0, $E6
    .byte $4C, $C6, $B8, $A5, $2E, $09, $6C, $8D, $0A, $40, $29, $01, $09, $F8, $8D, $0B
    .byte $40, $60, $20, $34, $B4, $A9, $0E, $A0, $A5, $20, $82, $B4, $A9, $15, $8D, $16
    .byte $06, $AD, $A7, $B2, $8D, $10, $06, $A9, $00, $8D, $11, $06, $60, $20, $D9, $B4
    .byte $D0, $1A, $A9, $20, $8D, $12, $06, $A9, $00, $8D, $13, $06, $20, $BC, $B9, $EE
    .byte $73, $06, $AD, $73, $06, $C9, $06, $D0, $E3, $4C, $C6, $B8, $20, $D0, $B9, $AD
    .byte $14, $06, $8D, $12, $06, $AD, $15, $06, $8D, $13, $06, $20, $A8, $B9, $4C, $99
    .byte $B8, $AD, $B3, $B2, $8D, $10, $06, $AD, $B4, $B2, $29, $07, $8D, $11, $06, $A9
    .byte $00, $8D, $13, $06, $A9, $0B, $8D, $12, $06, $A9, $06, $A0, $B1, $4C, $82, $B4
    .byte $20, $D9, $B4, $D0, $2D, $EE, $73, $06, $AD, $73, $06, $C9, $09, $D0, $03, $4C
    .byte $C6, $B8, $AD, $12, $06, $48, $AD, $13, $06, $48, $A9, $25, $8D, $12, $06, $A9
    .byte $00, $8D, $13, $06, $20, $A8, $B9, $68, $8D, $13, $06, $68, $8D, $12, $06, $4C
    .byte $99, $B8, $20, $BC, $B9, $4C, $99, $B8, $18, $AD, $10, $06, $6D, $12, $06, $8D
    .byte $10, $06, $AD, $11, $06, $6D, $13, $06, $8D, $11, $06, $60, $38, $AD, $10, $06
    .byte $ED, $12, $06, $8D, $10, $06, $AD, $11, $06, $ED, $13, $06, $8D, $11, $06, $60
    .byte $AD, $10, $06, $48, $AD, $11, $06, $48, $A9, $00, $8D, $17, $06, $A2, $10, $2E
    .byte $10, $06, $2E, $11, $06, $2E, $17, $06, $AD, $17, $06, $CD, $16, $06, $90, $06
    .byte $ED, $16, $06, $8D, $17, $06, $2E, $10, $06, $2E, $11, $06, $CA, $D0, $E6, $AD
    .byte $10, $06, $8D, $14, $06, $AD, $11, $06, $8D, $15, $06, $68, $8D, $11, $06, $68
    .byte $8D, $10, $06, $60, $A9, $7F, $8D, $48, $06, $8D, $49, $06, $8E, $28, $06, $8C
    .byte $29, $06, $60, $AD, $40, $06, $C9, $01, $D0, $03, $8D, $6A, $06, $AD, $41, $06
    .byte $C9, $01, $D0, $03, $8D, $6B, $06, $60, $AD, $07, $06, $F0, $29, $A9, $00, $8D
    .byte $07, $06, $AD, $48, $06, $8D, $01, $40, $AD, $00, $06, $8D, $02, $40, $AD, $01
    .byte $06, $8D, $03, $40, $AD, $49, $06, $8D, $05, $40, $AD, $04, $06, $8D, $06, $40
    .byte $AD, $05, $06, $8D, $07, $40, $60, $A2, $00, $20, $71, $BA, $E8, $20, $71, $BA
    .byte $60, $BD, $2E, $06, $F0, $45, $85, $EB, $20, $38, $BA, $BD, $6C, $06, $C9, $10
    .byte $F0, $47, $A0, $00, $C6, $EB, $F0, $04, $C8, $C8, $D0, $F8, $B9, $E0, $BC, $85
    .byte $EC, $B9, $E1, $BC, $85, $ED, $BC, $6A, $06, $B1, $EC, $85, $EA, $C9, $FF, $F0
    .byte $1F, $C9, $F0, $F0, $20, $BD, $28, $06, $29, $F0, $05, $EA, $A8, $FE, $6A, $06
    .byte $BD, $53, $06, $D0, $06, $8A, $F0, $04, $8C, $04, $40, $60, $8C, $00, $40, $60
    .byte $BC, $28, $06, $D0, $EB, $A0, $10, $D0, $E7, $A0, $10, $D0, $E0, $20, $20, $B4
    .byte $60, $20, $67, $BA, $60, $20, $23, $BA, $A9, $00, $AA, $8D, $4B, $06, $F0, $12
    .byte $8A, $4A, $AA, $E8, $8A, $C9, $04, $F0, $E8, $AD, $4B, $06, $18, $69, $04, $8D
    .byte $4B, $06, $8A, $0A, $AA, $BD, $30, $06, $85, $E6, $BD, $31, $06, $85, $E7, $BD
    .byte $31, $06, $F0, $DC, $8A, $4A, $AA, $DE, $40, $06, $D0, $D7, $BC, $38, $06, $FE
    .byte $38, $06, $B1, $E6, $F0, $B7, $A8, $C9, $FF, $F0, $09, $29, $C0, $C9, $C0, $F0
    .byte $13, $4C, $4C, $BB, $BD, $24, $06, $F0, $1A, $DE, $24, $06, $BD, $3C, $06, $9D
    .byte $38, $06, $D0, $0F, $98, $29, $3F, $9D, $24, $06, $DE, $24, $06, $BD, $38, $06
    .byte $9D, $3C, $06, $4C, $0C, $BB, $4C, $0E, $BC, $4C, $E7, $BB, $98, $29, $B0, $C9
    .byte $B0, $D0, $1D, $98, $29, $0F, $18, $6D, $2B, $06, $A8, $B9, $27, $BF, $9D, $20
    .byte $06, $A8, $8A, $C9, $02, $F0, $E2, $BC, $38, $06, $FE, $38, $06, $B1, $E6, $A8
    .byte $8A, $C9, $03, $F0, $D1, $48, $AE, $4B, $06, $B9, $A8, $BE, $F0, $0B, $9D, $00
    .byte $06, $B9, $A7, $BE, $09, $08, $9D, $01, $06, $A8, $68, $AA, $98, $D0, $0F, $A9
    .byte $00, $85, $EA, $8A, $C9, $02, $F0, $0B, $A9, $10, $85, $EA, $D0, $05, $BD, $28
    .byte $06, $85, $EA, $8A, $DE, $53, $06, $DD, $53, $06, $F0, $35, $FE, $53, $06, $AC
    .byte $4B, $06, $8A, $C9, $02, $F0, $05, $BD, $2E, $06, $D0, $05, $A5, $EA, $99, $00
    .byte $40, $A5, $EA, $9D, $6C, $06, $B9, $00, $06, $99, $02, $40, $B9, $01, $06, $99
    .byte $03, $40, $BD, $48, $06, $99, $01, $40, $BD, $20, $06, $9D, $40, $06, $4C, $E3
    .byte $BA, $FE, $53, $06, $4C, $D8, $BB, $AD, $2D, $06, $29, $0F, $D0, $1A, $AD, $2D
    .byte $06, $29, $F0, $D0, $04, $98, $4C, $FD, $BB, $A9, $FF, $D0, $0B, $18, $69, $FF
    .byte $0A, $0A, $C9, $3C, $90, $02, $A9, $3C, $8D, $2A, $06, $4C, $67, $BB, $AD, $88
    .byte $06, $29, $FC, $D0, $12, $B9, $30, $B2, $8D, $0C, $40, $B9, $31, $B2, $8D, $0E
    .byte $40, $B9, $32, $B2, $8D, $0F, $40, $4C, $D8, $BB, $41, $8F, $34, $27, $1A, $0D
    .byte $00, $82, $68, $75, $4E, $5B, $B0, $BC, $AA, $BC, $B6, $BC, $AA, $BC, $1E, $B5
    .byte $A3, $B6, $1C, $B6, $C5, $B6, $1E, $B5, $1E, $B5, $1E, $B5, $1E, $B5, $1E, $B5
    .byte $80, $B6, $26, $B6, $D1, $B6, $B3, $BC, $A7, $BC, $A7, $BC, $A7, $BC, $B0, $BC
    .byte $AD, $BC, $A7, $BC, $B0, $BC, $AD, $5D, $06, $A2, $E6, $D0, $05, $AD, $85, $06
    .byte $A2, $E1, $20, $ED, $B4, $20, $83, $BC, $6C, $E2, $00, $AD, $8D, $06, $F0, $26
    .byte $4C, $D5, $BA, $A9, $FF, $8D, $5E, $06, $AD, $4D, $06, $F0, $06, $EE, $5E, $06
    .byte $0A, $90, $FA, $60, $AD, $5E, $06, $18, $69, $08, $8D, $5E, $06, $60, $AD, $8D
    .byte $06, $09, $F0, $8D, $8D, $06, $60, $4C, $DA, $BC, $4C, $D4, $BC, $4C, $CA, $BC
    .byte $4C, $C6, $BC, $4C, $B9, $BC, $4C, $CE, $BC, $A9, $B3, $AA, $A8, $20, $14, $BA
    .byte $20, $62, $BF, $4C, $D5, $BA, $A9, $34, $D0, $F1, $A9, $F4, $D0, $ED, $A2, $F5
    .byte $A0, $F6, $D0, $E9, $A2, $B6, $A0, $F6, $D0, $E3, $A2, $92, $A0, $96, $D0, $DD
    .byte $EA, $BC, $F5, $BC, $FF, $BC, $0A, $BD, $33, $BD, $01, $02, $03, $04, $04, $05
    .byte $06, $06, $07, $08, $FF, $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF, $00
    .byte $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF, $02, $06, $07, $07, $07, $06
    .byte $06, $06, $06, $05, $05, $05, $04, $04, $04, $03, $03, $03, $03, $02, $03, $03
    .byte $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $01, $01
    .byte $01, $01, $F0, $0A, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $07, $07, $06
    .byte $05, $04, $04, $03, $02, $02, $02, $05, $05, $05, $04, $03, $02, $02, $02, $01
    .byte $01, $04, $04, $03, $02, $01, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01
    .byte $F0, $18, $FF, $F5, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $FF
    .byte $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $18, $FF, $F0, $04, $04
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $0C, $FF, $F0, $00, $00, $3F, $B0, $41
    .byte $B0, $AA, $B0, $00, $00, $18, $FF, $03, $00, $00, $0A, $BE, $0C, $BE, $FD, $BD
    .byte $00, $00, $18, $FF, $F0, $01, $01, $22, $B0, $31, $B0, $00, $B0, $00, $00, $24
    .byte $00, $00, $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $24, $00, $F0, $02
    .byte $05, $00, $00, $00, $00, $00, $00, $00, $00, $18, $00, $F0, $02, $00, $6E, $BE
    .byte $4D, $BE, $66, $BE, $00, $00, $00, $00, $F0, $01, $00, $27, $BE, $3D, $BE, $38
    .byte $BE, $00, $00, $18, $FF, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $18, $FF, $03, $00, $00, $89, $BE, $77, $BE, $92, $BE, $00, $00, $C8, $B0, $38
    .byte $3A, $3C, $3E, $40, $3E, $3C, $3A, $B6, $02, $FF, $B8, $02, $B3, $02, $B2, $74
    .byte $02, $6A, $02, $72, $02, $62, $B4, $02, $B2, $60, $02, $6C, $02, $76, $B3, $02
    .byte $B2, $7E, $02, $7C, $B3, $02, $00, $B3, $48, $42, $B2, $3E, $38, $30, $38, $4C
    .byte $44, $3E, $36, $C8, $B0, $38, $3C, $FF, $B4, $2C, $2A, $1E, $1C, $B2, $22, $2C
    .byte $30, $34, $38, $30, $26, $30, $3A, $34, $2C, $26, $B4, $2A, $00, $C4, $B0, $3E
    .byte $30, $FF, $C4, $42, $30, $FF, $C4, $3A, $2C, $FF, $C4, $38, $26, $FF, $C4, $34
    .byte $20, $FF, $E0, $34, $24, $FF, $B3, $36, $34, $30, $2A, $B4, $1C, $1C, $B3, $34
    .byte $3A, $34, $30, $B4, $2A, $2A, $00, $B4, $12, $B3, $10, $18, $16, $0A, $B4, $14
    .byte $12, $B3, $10, $06, $0E, $04, $B4, $0C, $00, $E0, $B0, $54, $4E, $48, $42, $48
    .byte $4E, $FF, $E0, $B3, $02, $B0, $3C, $40, $44, $4A, $4E, $54, $58, $5C, $62, $66
    .byte $6C, $70, $74, $7A, $B3, $02, $FF, $07, $F0, $00, $00, $06, $4E, $05, $F3, $05
    .byte $4D, $05, $01, $04, $B9, $04, $75, $04, $35, $03, $F8, $03, $BF, $03, $89, $03
    .byte $57, $03, $27, $02, $F9, $02, $CF, $02, $A6, $02, $80, $02, $5C, $02, $3A, $02
    .byte $1A, $01, $FC, $01, $DF, $01, $C4, $01, $AB, $01, $93, $01, $7C, $01, $67, $01
    .byte $52, $01, $3F, $01, $2D, $01, $1C, $01, $0C, $00, $FD, $00, $EE, $00, $E1, $00
    .byte $D4, $00, $C8, $00, $BD, $00, $B2, $00, $A8, $00, $9F, $00, $96, $00, $8D, $00
    .byte $85, $00, $7E, $00, $76, $00, $70, $00, $69, $00, $63, $00, $5E, $00, $58, $00
    .byte $53, $00, $4F, $00, $4A, $00, $46, $00, $42, $00, $3E, $00, $3A, $00, $37, $00
    .byte $34, $00, $31, $00, $2E, $00, $27, $03, $06, $0C, $18, $30, $12, $24, $09, $08
    .byte $04, $02, $01, $04, $08, $10, $20, $40, $18, $30, $0C, $0B, $05, $02, $01, $05
    .byte $0A, $14, $28, $50, $1E, $3C, $0F, $0C, $06, $03, $02, $06, $0C, $18, $30, $60
    .byte $24, $48, $12, $10, $08, $03, $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12
    .byte $02, $03, $20, $2C, $B4, $AD, $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9
    .byte $2A, $BC, $A8, $A2, $00, $B9, $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D
    .byte $D0, $F3, $A9, $01, $8D, $40, $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06
    .byte $A9, $00, $8D, $38, $06, $8D, $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $99
    .byte $90, $04, $E5, $99, $85, $9A, $26, $97, $26, $98, $CA, $D0, $ED, $60, $01, $02
.endif

;----------------------------------------------[ RESET ]--------------------------------------------

ROMSWITCH_RESET:
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $006 - Vectors" bank 6 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

