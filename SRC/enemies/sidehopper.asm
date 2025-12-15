; Sidehopper Routine
; Bank 5 is Dessgeega
SidehopperFloorAIRoutine_BANK{BANK}:
    .if BANK == 1 || BANK == 4
        lda #EnAnim_SidehopperFloorHopping_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    .elif BANK == 5
        lda #EnAnim_DessgeegaFloorHopping_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    .endif
Sidehopper_Common_BANK{BANK}:
    sta EnemyFlipAfterDisplacementAnimIndex
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq CommonEnemyStub2_BANK{BANK}
        jsr CommonJump_EnemyFlipAfterDisplacement
CommonEnemyStub2_BANK{BANK}:
    lda #$06
    sta $00
CommonEnemyStub_BANK{BANK}:
    lda #$08
    sta $01
    jmp CommonEnemyJump_00_01_02_BANK{BANK}

; Ceiling Sidehopper Routine
SidehopperCeilingAIRoutine_BANK{BANK}:
    .if BANK == 1 || BANK == 4
        lda #EnAnim_SidehopperCeilingHopping_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    .elif BANK == 5
        lda #EnAnim_DessgeegaCeilingHopping_BANK{BANK} - EnAnimTable_BANK{BANK}.b
    .endif
    jmp Sidehopper_Common_BANK{BANK}

