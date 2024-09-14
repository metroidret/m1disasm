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
    SEI                             ;Disables interrupt.
    CLD                             ;Sets processor to binary mode.
    LDX #$00                        ;
    STX PPUCTRL                     ;Clear PPU control registers.
    STX PPUMASK                     ;
@:  LDA PPUSTATUS                   ;
    BPL @-                          ;Wait for VBlank.
@:  LDA PPUSTATUS                   ;
    BPL @-                          ;
    ORA #$FF                        ;
    STA MMC1Reg0                    ;Reset MMC1 chip.-->
    STA MMC1Reg1                    ;(MSB is set).
    STA MMC1Reg2                    ;
    STA MMC1Reg3                    ;
    JMP Startup                     ;($C01A)Does preliminary housekeeping.

.IF BANK = 7
    ;Not used.
    LFFD5:  .byte $FF, $FF, $FF, $4C, $E4, $B3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    LFFE5:  .byte $FF, $FF, $FF, $FF, $4D, $45, $54, $52, $4F, $49, $44, $E4, $8D, $00, $00, $38
    LFFF5:  .byte $04, $01, $06, $01, $BC
.ELSE
    ;Not used.
    LBFD5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
    LBFE5:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    LBFF5:  .byte $00, $00, $00, $00, $00
.ENDIF
