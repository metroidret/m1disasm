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
    sei                             ;Disables interrupt.
    cld                             ;Sets processor to binary mode.
    ldx #$00                        ;
    stx PPUCTRL                     ;Clear PPU control registers.
    stx PPUMASK                     ;
@:  lda PPUSTATUS                   ;
    bpl @-                          ;Wait for VBlank.
@:  lda PPUSTATUS                   ;
    bpl @-                          ;
    ora #$FF                        ;
    sta MMC1Reg0                    ;Reset MMC1 chip.-->
    sta MMC1Reg1                    ;(MSB is set).
    sta MMC1Reg2                    ;
    sta MMC1Reg3                    ;
    jmp Startup                     ;($C01A)Does preliminary housekeeping.

;Not used.
.if BANK = 7
    .byte $FF, $FF, $FF, $4C, $E4, $B3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $4D, $45, $54, $52, $4F, $49, $44, $E4, $8D, $00, $00, $38
    .byte $04, $01, $06, $01, $BC
.else
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00
.endif
