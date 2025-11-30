RipperAIRoutine:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq Ripper01
        ; enemy is not exploding, set animation to active
        jsr CommonJump_InitEnActiveAnimIndex_NoL967BOffset
    Ripper01:
    .if BANK == 1 || BANK == 4
        jmp CommonEnemyStub2 ;sidehopper.asm
    .elif BANK == 2
        ; this is for Ripper II's rocket booster flames
        ; change animation frame every 3 frames
        lda #$03
        sta $00
        sta $01
        jmp CommonEnemyJump_00_01_02
    .endif

