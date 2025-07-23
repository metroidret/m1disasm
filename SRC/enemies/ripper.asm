RipperAIRoutine:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq Ripper01
        ; enemy is not exploding, call CommonJump_0A
        jsr CommonJump_0A
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

