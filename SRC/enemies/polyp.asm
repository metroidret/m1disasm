; Polyp Routine (mini volcano)
PolypAIRoutine_{AREA}:
    ; set radius to 0
    lda #$00
    sta EnsExtra.0.radiusY,x
    sta EnsExtra.0.radiusX,x
    ; set EnData05 to #$10
    ; the enemy is invisible and will remain resting
    lda #$10
    sta EnData05,x

    .if BANK == 2
        ; put bit 4 of enemy slot offset in bit 6
        txa
        asl
        asl
        sta $00
    .endif
    ; get enemy slot id
    txa
    lsr
    lsr
    lsr
    lsr
    ; add framecount
    adc FrameCount
    .if BANK == 2
        ; polyps in norfair will try shooting 8 times every 8 frames, then stop trying for 64 frames
        ; when polyps of even enemy slot id stops trying, polyps of odd enemy slot id will start trying, and vice versa
        adc $00
        and #$47
    .elif BANK == 5
        ; polyps in ridley will always try to shoot every 8 frames
        ; (there arent any in ridley though)
        and #$07
    .endif
    ; exit if polyp isn't trying to shoot
    bne RTS_Polyp_{AREA}

    ; polyp is trying to shoot
    ; rotate horizontal facing flag into carry
    lsr EnData05,x
    ; set expected status to #$02|$01
    lda #enemyStatus_Resting | enemyStatus_Active
    sta SpawnEnProjectile_ExpectedStatus
    ; set horizontal facing flag to a random bit
    lda RandomNumber1
    lsr
    rol EnData05,x
    ; exit if misfired (25% random chance)
    and #$03
    beq RTS_Polyp_{AREA}
    ; store random number (1, 2 or 3) into SpawnEnProjectile_EnData0A
    ; this chooses between EnProjectileMovement1, EnProjectileMovement2 or EnProjectileMovement3
    sta SpawnEnProjectile_EnData0A
    ; set EnProjectile animation
    lda #$02
    sta SpawnEnProjectile_AnimTableIndex
    ; spawn projectile
    jmp CommonJump_SpawnEnProjectile

RTS_Polyp_{AREA}:
    rts

