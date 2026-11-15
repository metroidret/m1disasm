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
GFX_Samus: ; 06:8000
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/samus.chr" ; 8000 - Samus and gear tile patterns.
        .incbin "common_chr/items.chr" ; Item Graphics (plus bomb, the N in "EN", and another dot thingy)
    .elif BUILDTARGET == "NES_MZM"
        .ds $9A0, $00
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/samus_cns.chr" ; 8000 - Samus and gear tile patterns.
        .incbin "common_chr/items_cns.chr" ; Item Graphics (plus bomb, the N in "EN", and another dot thingy)
    .endif

GFX_IntroSprites: ; 06:89A0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
        .incbin "common_chr/intro_sprites.chr" ; 89A0 - Intro and end tile patterns.
    .elif BUILDTARGET == "NES_MZM"
        .ds $100, $00
    .endif

; Garbage data
; (part of areas_common.asm from L6_8AA0 to L6_8BDF (sprite data, Samus door routines))
Garbage_06_8AA0: ; 06:8AA0
    .incbin "garbage/06_8AA0.bin"

; 8BE0 - METROID title screen CHR
GFX_Title: ; 06:8BE0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/title.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $500, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/title_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/title_cns.chr"
    .endif

; 90E0 - Suitless Samus (in-game)
GFX_SamusSuitless: ; 06:90E0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/samus_suitless.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $7B0, $00
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/samus_suitless_cns.chr"
    .endif

; 9890 - Exclamation point
GFX_ExclamationPoint: ; 06:9890
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/exclamation_point.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $10, $00
    .elif BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
        .incbin "common_chr/exclamation_point_mzm.chr"
    .endif

; Garbage data (leftovers from Ridley's bank)
Garbage_06_98A0: ; 06:98A0
    .incbin "garbage/06_98A0.bin"

;Blank tile patterns.
GFX_Solid: ; 06:9980
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
        .incbin "common_chr/solid.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $40, $00
    .endif

; Garbage data (leftovers from Ridley's bank)
Garbage_06_99C0: ; 06:99C0
    .incbin "garbage/06_99C0.bin"

; 9DA0 - Brinstar BG CHR data
GFX_BrinBG1: ; 06:9DA0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "brinstar/bg_chr_1.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $150, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "brinstar/bg_chr_1_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "brinstar/bg_chr_1_cns.chr"
    .endif

; 9EF0 - Common Room Elements (loaded in all areas)
GFX_CREBG2: ; 06:9EF0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_CRE_2.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $800, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/bg_CRE_2_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/bg_CRE_2_cns.chr"
    .endif

; A6F0 - Norfair BG CHR data
GFX_NorfBG1: ; 06:A6F0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "norfair/bg_chr_1.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $260, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "norfair/bg_chr_1_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "norfair/bg_chr_1_cns.chr"
    .endif

; A950 - Norfair BG CHR data
GFX_NorfBG2: ; 06:A950
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "norfair/bg_chr_2.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $70, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "norfair/bg_chr_2_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "norfair/bg_chr_2_cns.chr"
    .endif

; A9C0 - Kraid, Ridley, Tourian BG CHR
GFX_BossBG: ; 06:A9C0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/bg_boss_areas.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $2E0, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/bg_boss_areas_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/bg_boss_areas_cns.chr"
    .endif

; ACA0 - Tourian BG CHR
GFX_TourBG: ; 06:ACA0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "tourian/bg_chr.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $600, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "tourian/bg_chr_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "tourian/bg_chr_cns.chr"
    .endif

; B2A0 - Zebetite BG CHR
GFX_Zebetite: ; 06:B2A0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM_G"
        .incbin "tourian/zebetite_chr.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $90, $00
    .elif BUILDTARGET == "NES_CNS"
        .incbin "tourian/zebetite_chr_cns.chr"
    .endif

; B330 - More Kraid BG CHR
GFX_KraiBG2: ; 06:B330
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "kraid/bg_chr_2.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $C0, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "kraid/bg_chr_2_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "kraid/bg_chr_2_cns.chr"
    .endif

; B3F0 - More Ridley BG CHR
GFX_RidlBG: ; 06:B3F0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "ridley/bg_chr.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $C0, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "ridley/bg_chr_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "ridley/bg_chr_cns.chr"
    .endif

;Not used.
Garbage_06_B4B0: ; 06:B4B0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
        .incbin "garbage/06_B4B0.bin"
    .elif BUILDTARGET == "NES_PAL"
        .incbin "garbage/06_B4B0_pal.bin"
    .endif

; B4C0 - Font (upper and lowercase)
GFX_Font: ; 06:B4C0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL"
        .incbin "common_chr/font.chr"
    .elif BUILDTARGET == "NES_MZM"
        .ds $400, $00
    .elif BUILDTARGET == "NES_MZM_G"
        .incbin "common_chr/font_mzm.chr"
    .elif BUILDTARGET == "NES_CNS"
        .incbin "common_chr/font_cns.chr"
    .endif

Garbage_06_B8C0: ; 06:B8C0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_PAL" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G"
        .incbin "garbage/06_B8C0.bin" ; B8C0 - Exclamation point (unused)
    .elif BUILDTARGET == "NES_CNS"
        .incbin "garbage/06_B8C0_cns.bin"
    .endif


; Garbage data (Half of the sound engine)
Garbage_06_B8D0: ; 06:B8D0
    .if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
        .incbin "garbage/06_B8D0.bin"
    .elif BUILDTARGET == "NES_PAL"
        .incbin "garbage/06_B8D0_pal.bin"
    .endif

.ends

;-----------------------------------------------[ RESET ]--------------------------------------------

.section "ROM Bank $006 - Reset" bank 6 slot "ROMSwitchSlot" orga $BFB0 force

ROMSWITCH_RESET: ; 06:BFB0
.include "reset.asm"

.ends

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.section "ROM Bank $006 - Vectors" bank 6 slot "ROMSwitchSlot" orga $BFFA force
    .word NMI                       ;($C0D9)NMI vector.
    .word ROMSWITCH_RESET           ;($BFB0)Reset vector.
    .word ROMSWITCH_RESET           ;($BFB0)IRQ vector.
.ends

