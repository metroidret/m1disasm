; RipperRoutine
RipperRoutine:
    lda EnStatus,x
    cmp #$03
    beq Ripper01
        jsr CommonJump_0A
    Ripper01:
    .if BANK = 1 || BANK = 4
        jmp CommonEnemyStub2 ;sidehopper.asm
    .elseif BANK = 2
        lda #$03
        sta $00
        sta $01
        jmp CommonEnemyJump_00_01_02
    .endif
