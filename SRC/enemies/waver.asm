; Waver Routine
WaverAIRoutine:
    lda #$21
    sta $85
    lda #$1E
    sta $86
    lda EnStatus,x
    cmp #$03
    beq L99F7
        jsr CommonJump_09
    L99F7:
    jmp CommonEnemyStub2
