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

RESET: ;($BFB0)
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
    sta MMC1Reg0
    sta MMC1Reg1
    sta MMC1Reg2
    sta MMC1Reg3
    
    ;($C01A)Does preliminary housekeeping.
    jmp Startup


;Not used.
.if BANK == 7
    .byte $FF, $FF, $FF, $4C, $E4, $B3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $4D, $45, $54, $52, $4F, $49, $44, $E4, $8D, $00, $00, $38
    .byte $04, $01, $06, $01, $BC
.else
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00
.endif
