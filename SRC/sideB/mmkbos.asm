; side B file $14 - mmkbos   (prgram $DEA0-$DFEF)
; Kraid and Ridley Songs

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $1F
    .ascstr "MMKBOS", $00, $00
FDSFileMacroPart2 $DEA0, $00



DataDD0E_BossHit:
    .word LDB4D
    .word FDSWaveform_DBAE
    .byte $82
    .byte $50
    .byte $00
    .byte $0A
    .byte $00
    .byte $A0
    .byte $A0
    .byte $48
    .byte $03

BossHitSFXStart:
    lda #$28
    ldx #<DataDD0E_BossHit.b
    ldy #>DataDD0E_BossHit.b
    jsr LDD0E
    lda #$16
    sta $067E
    lda #$00
    sta $067F
    lda #$B0
    sta $0672
    rts

BossHitSFXContinue:
    jsr LD293
    bne LDECE
        jmp LD4F3
    LDECE:
    jsr LD56D
    jsr LD54C
    dec $0672
    lda $0672
    sta $4086
    rts



.include "songs/ridley.asm"


.include "songs/kraid.asm"



    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $A2, $D7, $A0, $DF, $D0, $E5, $E6, $DF, $4D, $DB, $AE, $DB, $00, $02, $98
    .byte $41, $00, $11, $00, $94, $A0, $B0, $14, $2E, $B5, $38, $00, $FF, $FF, $FF, $FF



FDSFileMacroPart3

