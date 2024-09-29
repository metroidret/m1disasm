; Lava Seahorse Routine
SeahorseRoutine:
    lda EnStatus,x
    cmp #$01
    bne L9AF5
        lda #$E8
        sta $0400,x
    L9AF5:
    cmp #$02
    bne L9B4F
    lda $0406,x
    beq L9B4F
    lda $6B01,x
    bne L9B4F
    lda $2D
    and #$1F
    bne L9B3C
        lda $2E
        and #$03
        beq L9B59
        lda #$02
        sta $87
        lda #$00
        sta $88
        lda #$43
        sta $83
        lda #$47
        sta $84
        lda #$03
        sta $85
        jsr CommonJump_0B
        lda $0680
        ora #$04
        sta $0680
        lda $0405,x
        and #$01
        tay
        lda $0083,y
        jsr CommonJump_05
        beq L9B59
    L9B3C:
    cmp #$0F
    bcc L9B59
    lda $0405,x
    and #$01
    tay
    lda SeahorseTable,y
    jsr CommonJump_05
    jmp L9B59

L9B4F:
    lda EnStatus,x
    cmp #$03
    beq L9B59
    jsr CommonJump_0A
L9B59:
    lda #$01
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02

; probably animation frame id table
SeahorseTable:
    .byte $45, $49
