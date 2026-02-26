RipperAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @dontInitAnim
        ; enemy is not exploding, set animation to active
        jsr CommonJump_InitEnActiveAnimIndex_NoInitOffset
    @dontInitAnim:
    .if BANK == 1 || BANK == 4
        jmp CommonEnemyStub2_{AREA} ;sidehopper.asm
    .elif BANK == 2
        ; this is for Ripper II's rocket booster flames
        ; change animation frame every 3 frames
        lda #$03
        sta $00
        sta $01
        jmp UpdateEnemyCommon_Decide_{AREA}
    .endif

