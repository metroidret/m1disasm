; Kraid, Lint, and Nails

; Kraid Routine
KraidAIRoutine_{AREA}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc KraidBranch_Normal_{AREA} ; 0, 1, 2
    beq KraidBranch_Explode_{AREA} ; 3
    cmp #enemyStatus_Pickup
    bne KraidBranch_Exit_{AREA} ; 4, 6
    ; 5
    ; fallthrough

KraidBranch_Explode_{AREA}:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq KraidBranch_Exit_{AREA} ; branch always

KraidBranch_Normal_{AREA}:
    jsr KraidUpdateAllProjectiles_{AREA}
    jsr KraidTryToLaunchLint_{AREA}
    jsr KraidTryToLaunchNail_{AREA}
    ; fallthrough

KraidBranch_Exit_{AREA}:
    ; change animation frame every 10 frames
    lda #$0A
    sta $00
    jmp CommonEnemyStub_{AREA} ;sidehopper.asm

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLintAIRoutine_{AREA}:
    ; branch if lint is invisible
    lda Ens.0.data05,x
    and #$02
    beq KraidLintRemove_{AREA}
    ; branch if lint is not exploding
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bne KraidLintMain_{AREA}

KraidLintRemove_{AREA}:
    ; lint is dead, clear enemy slot
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    beq KraidLintDraw_{AREA} ; branch always

KraidLintMain_{AREA}:
    ; exit if bit7 of Ens.0.data05 is set
    lda Ens.0.data05,x
    asl
    bmi KraidLintDraw_{AREA}
    ; exit if lint is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne KraidLintDraw_{AREA}

    ; save deltaY into Ens.0.speedY
    jsr CommonJump_EnemyGetDeltaY
    ldx PageIndex
    lda $00
    sta Ens.0.speedY,x
    ; save deltaX into Ens.0.speedX
    jsr CommonJump_EnemyGetDeltaX
    ldx PageIndex
    lda $00
    sta Ens.0.speedX,x
    ; check for bg collision and try movement
    jsr CommonJump_EnemyBGCollideOrApplySpeed
    ; exit if movement succeeded
    bcs KraidLintDraw_{AREA}
    ; movement has failed either because lint hit a wall or went out of bounds
    ; lint dies
    lda #enemyStatus_Explode
    sta EnsExtra.0.status,x

KraidLintDraw_{AREA}:
    ; draw lint
    lda #$01
    jsr CommonJump_UpdateEnemyAnim
    jmp CommonJump_UpdateEnemyCommon_noMoveNoAnim

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNailAIRoutine_{AREA}: ; L9B2C
    jmp KraidLintAIRoutine_{AREA}

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidUpdateAllProjectiles_{AREA}: ; L9B2F
    ldx #$50 ; For each of Kraid's projectiles
    @loop:
        jsr KraidUpdateProjectile_{AREA}
        txa
        sec
        sbc #$10
        tax
        bne @loop
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidUpdateProjectile_{AREA}:
    ; remove projectile if it doesn't exist (a bit odd, but ok)
    ldy EnsExtra.0.status,x
    beq @remove
    
    ; exit if projectile is not lint or nail
    lda EnsExtra.0.type,x
    cmp #$0A
    beq @branchA
    cmp #$09
    bne KraidUpdateProjectile_Exit_{AREA}

@branchA:
    ; remove projectile if it is invisible
    lda Ens.0.data05,x
    and #$02
    beq @remove
    ; branch if projectile is resting
    dey
    beq @resting
    ; remove projectile if its exploding
    cpy #enemyStatus_Explode-1
    beq @remove
    ; exit if projectile is not frozen
    cpy #enemyStatus_Frozen-1
    bne KraidUpdateProjectile_Exit_{AREA}
    ; projectile is frozen
    ; exit if projectile state before being frozen was not resting
    lda Ens.0.prevStatus,x
    cmp #$01
    bne KraidUpdateProjectile_Exit_{AREA}
    ; projectile state before being frozen was resting
    beq @resting ; branch always

@remove:
    lda #enemyStatus_NoEnemy ; #$00
    sta EnsExtra.0.status,x
    sta Ens.0.specialAttribs,x
    jsr CommonJump_0E

@resting:
    ; initialize projectile
    ; copy Kraid's Ens.0.data05 to projectile's Ens.0.data05
    lda Ens.0.data05
    sta Ens.0.data05,x
    ; prepare projectile offset relative to kraid's position
    ; push kraid's facing direction carry flag to stack 
    lsr
    php
    ; set y to x/16
    txa
    lsr
    lsr
    lsr
    lsr
    tay
    ; get y offset from table
    lda KraidProjectileOffsetY_{AREA}-1,y
    sta Temp04_SpeedY
    ; get projectile type from table
    lda KraidProjectileType_{AREA}-1,y
    sta EnsExtra.0.type,x
    ; Y = (X/16)*2 + the LSB of Ens.0.data05[0] (direction Kraid is facing)
    tya
    plp
    rol
    tay
    ; get x offset from table
    lda KraidProjectileOffsetX_{AREA}-2,y
    sta Temp05_SpeedX

; The Brinstar Kraid code makes an incorrect assumption about X, which leads to
;  a crash when attempting to spawn him
    .if BANK != 1
        ; push x to stack
        txa
        pha
    .endif
    ; store kraid's position in temp
    ldx #$00
    jsr StoreEnemyPositionToTemp__{AREA}
    .if BANK != 1
        ; pull x from stack
        pla
        tax
    .endif
    ; apply offset to kraid's position
    jsr CommonJump_ApplySpeedToPosition

    .if BANK == 1
        ; load projectile's enemy slot offset into x
        ; (BUG! this is actually kraid's enemy slot offset) 
        ldx PageIndex
    .endif
    ; exit if initial position for projectile is out of bounds
    bcc KraidUpdateProjectile_Exit_{AREA}
    ; set projectile status to enemyStatus_Resting if it was enemyStatus_NoEnemy
    lda EnsExtra.0.status,x
    bne LoadEnemyPositionFromTemp__{AREA}
    inc EnsExtra.0.status,x
    ; save as projectile's position
    ; fallthrough

LoadEnemyPositionFromTemp__{AREA}:
    lda Temp08_PositionY
    sta Ens.0.y,x
    lda Temp09_PositionX
    sta Ens.0.x,x
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x

KraidUpdateProjectile_Exit_{AREA}:
    rts

StoreEnemyPositionToTemp__{AREA}:
    lda Ens.0.y,x
    sta Temp08_PositionY
    lda Ens.0.x,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

KraidProjectileOffsetY_{AREA}:
    .byte -11,  -3,   5, -10,  -2
KraidProjectileOffsetX_{AREA}: ;9BD1
; First column is for facing right, second for facing left
    .byte  10, -10
    .byte  12, -12
    .byte  14, -14
    .byte  -8,   8
    .byte -12,  12
KraidProjectileType_{AREA}: ; L9BDB
    .byte $09, $09, $09, $0A, $0A ; Lint x 3, nail x 2

;-------------------------------------------------------------------------------
; Kraid Subroutine 2
;  Something to do with the lint
KraidTryToLaunchLint_{AREA}:
    ; load lint counter into y (#$80 if it is zero)
    ldy KraidLintCounter
    bne @endIf_A
        ldy #$80
    @endIf_A:
    ; exit if bit 1 of FrameCount is set
    lda FrameCount
    and #$02
    bne @RTS
    ; decrement lint counter
    dey
    sty KraidLintCounter
    ; a = lint counter * 2, to compensate for exiting when bit 1 of FrameCount is set
    tya
    asl
    ; exit if (lint counter * 2) is not #$0A, #$1A, #$2A, #$3A, #$4A, #$5A, #$6A or #$7A
    ; lint will try firing every 16 frames 8 times, then will pause for 128 frames, in a cycle
    bmi @RTS
    and #$0F
    cmp #$0A
    bne @RTS

    lda #enemyStatus_Resting
    ; branch if first lint is resting
    ldx #$10
    cmp EnsExtra.0.status,x
    beq @primeForLaunch
    
    ; branch if second lint is resting
    ldx #$20
    cmp EnsExtra.0.status,x
    beq @primeForLaunch
    
    ; branch if third lint is resting
    ldx #$30
    cmp EnsExtra.0.status,x
    beq @primeForLaunch
    
    ; all lints are currently launched
    ; undo decrement lint counter so that it will try to launch again the next frame
    inc KraidLintCounter
    rts

@primeForLaunch:
    ; lint will launch after resting for 8 frames
    lda #$08
    sta Ens.0.delay,x

@RTS:
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidTryToLaunchNail_{AREA}:
    ; load nail counter into y (#$60 if it is zero)
    ldy KraidNailCounter
    bne @endIf_A
        ldy #$60
    @endIf_A:
    ; exit if bit 1 of FrameCount is set
    lda FrameCount
    and #$02
    bne @RTS
    ; decrement nail counter
    dey
    sty KraidNailCounter
    ; a = nail counter * 2, to compensate for exiting when bit 1 of FrameCount is set
    tya
    asl
    ; exit if (nail counter * 2)'s low nibble is not 0
    ; nail will try firing every 16 frames 8 times, then will pause for 128 frames, in a cycle
    bmi @RTS
    and #$0F
    bne @RTS

    lda #enemyStatus_Resting
    ; branch if first nail is resting
    ldx #$40
    cmp EnsExtra.0.status,x
    beq @primeForLaunch
    
    ; branch if second nail is resting
    ldx #$50
    cmp EnsExtra.0.status,x
    beq @primeForLaunch
    
    ; all nails are currently launched
    ; undo decrement nail counter so that it will try to launch again the next frame
    inc KraidNailCounter
    rts

@primeForLaunch:
    ; nail will launch after resting for 8 frames
    lda #$08
    sta Ens.0.delay,x

@RTS:
    rts

