; Sidehopper Routine
; Bank 5 is Dessgeega
SidehopperFloorAIRoutine:
    .if BANK = 1 || BANK = 4
        lda #$09
    .elseif BANK = 5
        lda #$42
    .endif
Sidehopper_Common:
    sta $85
    sta $86
    lda EnStatus,x
    cmp #$03
    beq CommonEnemyStub2
        jsr CommonJump_09
CommonEnemyStub2:
    lda #$06
    sta $00
CommonEnemyStub:
    lda #$08
    sta $01
    jmp CommonEnemyJump_00_01_02

; Ceiling Sidehopper Routine
SidehopperCeilingAIRoutine:
    .if BANK = 1 || BANK = 4
        lda #$0F
    .elseif BANK = 5
        lda #$48
    .endif
    jmp Sidehopper_Common
