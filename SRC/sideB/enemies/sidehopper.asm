; Sidehopper Routine
; Bank 5 is Dessgeega
SidehopperFloorAIRoutine_{AREA}:
    .if AREA == "STG1PGM" || AREA == "STG6PGM"
        lda #EnAnim_SidehopperFloorHopping_{AREA} - EnAnimTable_{AREA}.b
    .elif AREA == "STG7PGM"
        lda #EnAnim_DessgeegaFloorHopping_{AREA} - EnAnimTable_{AREA}.b
    .endif
Sidehopper_Common_{AREA}:
    sta EnemyFlipAfterDisplacementAnimIndex
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq CommonEnemyStub2_{AREA}
        jsr CommonJump_EnemyFlipAfterDisplacement
CommonEnemyStub2_{AREA}:
    lda #$06
    sta $00
CommonEnemyStub_{AREA}:
    lda #$08
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

; Ceiling Sidehopper Routine
SidehopperCeilingAIRoutine_{AREA}:
    .if AREA == "STG1PGM" || AREA == "STG6PGM"
        lda #EnAnim_SidehopperCeilingHopping_{AREA} - EnAnimTable_{AREA}.b
    .elif AREA == "STG7PGM"
        lda #EnAnim_DessgeegaCeilingHopping_{AREA} - EnAnimTable_{AREA}.b
    .endif
    jmp Sidehopper_Common_{AREA}
