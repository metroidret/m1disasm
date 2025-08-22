; Sidehopper Routine
; Bank 5 is Dessgeega
SidehopperFloorAIRoutine:
    .if BANK == 1 || BANK == 4
        lda #EnAnim_SidehopperFloorHopping - EnAnimTbl.b
    .elif BANK == 5
        lda #EnAnim_DessgeegaFloorHopping - EnAnimTbl.b
    .endif
Sidehopper_Common:
    sta EnemyFlipAfterDisplacementAnimIndex
    sta EnemyFlipAfterDisplacementAnimIndex+1.b
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq CommonEnemyStub2
        jsr CommonJump_EnemyFlipAfterDisplacement
CommonEnemyStub2:
    lda #$06
    sta $00
CommonEnemyStub:
    lda #$08
    sta $01
    jmp CommonEnemyJump_00_01_02

; Ceiling Sidehopper Routine
SidehopperCeilingAIRoutine:
    .if BANK == 1 || BANK == 4
        lda #EnAnim_SidehopperCeilingHopping - EnAnimTbl.b
    .elif BANK == 5
        lda #EnAnim_DessgeegaCeilingHopping - EnAnimTbl.b
    .endif
    jmp Sidehopper_Common

