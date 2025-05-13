; Swooper routine
SwooperAIRoutine:
    lda #$03
    sta $00
    lda #$08
    sta $01
    lda EnStatus,x
    cmp #$01
    bne L98EE
    lda EnData05,x
    and #$10
    beq L98EE
    lda #$01
    jsr L9954
L98EE:
    jsr L98F4
    jmp CommonEnemyJump_00_01_02
L98F4:
    lda EnStatus,x
    cmp #$02
    bne L9907
    .if BANK = 2
        lda #$25
    .elseif BANK = 5
        lda #$20
    .endif
    ldy EnSpeedY,x
    bpl L9904
        .if BANK = 2
            lda #$22
        .elseif BANK = 5
            lda #$1D
        .endif
    L9904:
    sta EnResetAnimIndex,x
L9907:
    rts

;-------------------------------------------------------------------------------
; Swooper Routine 2?
SwooperAIRoutine2:
    lda EnemyStatus81
    cmp #$01
    beq SwooperExitA
        cmp #$03
        beq SwooperExitB
        lda EnStatus,x
        cmp #$01
        bne L9923
        lda #$00
        jsr L9954
    SwooperExitA:
    lda #$08
    jmp CommonJump_01

L9923:
    lda #$80
    sta EnAccelY,x
    lda EnSpeedY,x
    bmi L9949
    lda EnData05,x
    and #$10
    beq L9949
    lda EnY,x
    sec
    sbc ObjY
    bpl L9940
        jsr TwosComplement_
    L9940:
    cmp #$10
    bcs L9949
    lda #$00
    sta EnAccelY,x
L9949:
    jsr L98F4
    lda #$03
    jmp CommonJump_00

SwooperExitB:
    jmp CommonJump_02

L9954:
    sta EnDataIndex,x
    lda $040B,x
    pha
    jsr CommonJump_0E
    pla
    sta EnHitPoints,x
    rts
