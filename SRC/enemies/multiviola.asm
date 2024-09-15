MultiviolaRoutine:
    lda EnStatus,X
    cmp #$02
    bne L9AE0
        jsr CommonJump_0A
    L9AE0:
    lda #$02
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02
