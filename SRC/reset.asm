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
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER.
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Common Reset Routine

    ;Disables interrupt.
    sei
    ;Sets processor to binary mode.
    cld
    
    ;Clear PPU control registers.
    ldx #$00
    stx PPUCTRL
    stx PPUMASK
    
    @WaitForVBlank1:
        lda PPUSTATUS
        bpl @WaitForVBlank1
    @WaitForVBlank2:
        lda PPUSTATUS
        bpl @WaitForVBlank2
    
    ;Reset MMC1 chip. (MSB is set).
    ora #$FF
    sta MMC1CTRL
    sta MMC1CHR0
    sta MMC1CHR1
    sta MMC1PRG
    
    ;($C01A)Does preliminary housekeeping.
    jmp Startup


;Not used.
.if BUILDTARGET == "NES_NTSC" || BUILDTARGET == "NES_MZM" || BUILDTARGET == "NES_MZM_G" || BUILDTARGET == "NES_CNS"
    .if BANK == 7
        Garbage_ResetFixed:
            .incbin "garbage/reset_fixed.bin"
    .else
        Garbage_ResetSwitch:
            .incbin "garbage/reset_switch.bin"
    .endif
.elif BUILDTARGET == "NES_PAL"
    .if BANK == 7
        Garbage_ResetFixedPt1:
            .incbin "garbage/reset_fixed_pt1_pal.bin"
        
        GotoSoundEngine:
            jmp SoundEngine
         
        Garbage_ResetFixedPt2:
            .incbin "garbage/reset_fixed_pt2_pal.bin"
    .else
        Garbage_ResetSwitch:
            .incbin "garbage/reset_switch_pal.bin"
    .endif
.endif

