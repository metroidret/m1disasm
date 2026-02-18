; Lava Seahorse Routine
DragonAIRoutine_{AREA}:
    ; branch if not resting
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Resting
    bne @L9AF5
        ; enemy is resting
        ; set position to under lava
        lda #$E8
        sta EnY,x
    @L9AF5:
    ; exit if not active
    cmp #enemyStatus_Active
    bne @L9B4F

    ; exit if on the first movement instruction (rising from the lava)
    lda EnMovementInstrIndex,x
    beq @L9B4F
    ; exit if moving up or down
    lda EnsExtra.0.jumpDsplcmnt,x
    bne @L9B4F
    
    ; shoot every 32 frames
    lda FrameCount
    and #$1F
    bne @L9B3C
        ; branch if misfired (25% random chance)
        lda RandomNumber1
        and #$03
        beq @L9B59
        
        ; shoot dragon enProjectile
        ; set expected status to #$02
        lda #enemyStatus_Active
        sta SpawnEnProjectile_ExpectedStatus
        ; set movement to EnProjectileMovement0
        lda #$00
        sta SpawnEnProjectile_EnData0A
        ; shooting animation (supposed to be parameter to SpawnEnProjectile, but unused there)
        lda #EnAnim_DragonIdle_R_{AREA} - EnAnimTable_{AREA}.b
        sta SpawnEnProjectile_AnimIndex
        lda #EnAnim_DragonIdle_L_{AREA} - EnAnimTable_{AREA}.b
        sta SpawnEnProjectile_AnimIndex+1.b
        ; set projectile animation
        lda #$03
        sta SpawnEnProjectile_AnimTableIndex
        ; spawn projectile
        jsr CommonJump_SpawnEnProjectile
        ; play shoot sfx
        lda NoiseSFXFlag
        ora #sfxNoise_SpitFlame
        sta NoiseSFXFlag
        ; set shooting animation
        lda EnData05,x
        and #$01
        tay
        lda SpawnEnProjectile_AnimIndex,y
        jsr CommonJump_InitEnAnimIndex
        beq @L9B59 ; branch always
    @L9B3C:
    ; set "prepare to spit" animation 15 frames after having shot
    cmp #$0F
    bcc @L9B59
    ; set animation
    lda EnData05,x
    and #$01
    tay
    lda @prepareToSpitEnAnimTable,y
    jsr CommonJump_InitEnAnimIndex
    jmp @L9B59

@L9B4F:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @L9B59
        ; enemy is not exploding, set animation to active
        jsr CommonJump_InitEnActiveAnimIndex_NoL967BOffset
@L9B59:
    ; change animation frame every frame
    lda #$01
    sta $00
    sta $01
    jmp UpdateEnemyCommon_Decide_{AREA}

@prepareToSpitEnAnimTable:
    .byte EnAnim_DragonPrepareToSpit_R_{AREA} - EnAnimTable_{AREA}, EnAnim_DragonPrepareToSpit_L_{AREA} - EnAnimTable_{AREA}

