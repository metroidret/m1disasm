; Kraid, Lint, and Nails

; Kraid Routine
KraidAIRoutine_BANK{BANK}:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc KraidBranch_Normal_BANK{BANK} ; 0, 1, 2
    beq KraidBranch_Explode_BANK{BANK} ; 3
    cmp #enemyStatus_Pickup
    bne KraidBranch_Exit_BANK{BANK} ; 4, 6
    ; 5
    ; fallthrough

KraidBranch_Explode_BANK{BANK}:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq KraidBranch_Exit_BANK{BANK} ; branch always

KraidBranch_Normal_BANK{BANK}:
    jsr KraidUpdateAllProjectiles_BANK{BANK}
    jsr KraidTryToLaunchLint_BANK{BANK}
    jsr KraidTryToLaunchNail_BANK{BANK}
    ; fallthrough

KraidBranch_Exit_BANK{BANK}:
    ; change animation frame every 10 frames
    lda #$0A
    sta $00
    jmp CommonEnemyStub_BANK{BANK} ;sidehopper.asm

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLintAIRoutine_BANK{BANK}:
    ; branch if lint is invisible
    lda EnData05,x
    and #$02
    beq KraidLintRemove_BANK{BANK}
    ; branch if lint is not exploding
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bne KraidLintMain_BANK{BANK}

KraidLintRemove_BANK{BANK}:
    ; lint is dead, clear enemy slot
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    beq KraidLintDraw_BANK{BANK} ; branch always

KraidLintMain_BANK{BANK}:
    ; exit if bit7 of EnData05 is set
    lda EnData05,x
    asl
    bmi KraidLintDraw_BANK{BANK}
    ; exit if lint is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne KraidLintDraw_BANK{BANK}

    ; save deltaY into EnSpeedY
    jsr CommonJump_EnemyGetDeltaY
    ldx PageIndex
    lda $00
    sta EnSpeedY,x
    ; save deltaX into EnSpeedX
    jsr CommonJump_EnemyGetDeltaX
    ldx PageIndex
    lda $00
    sta EnSpeedX,x
    ; check for bg collision and try movement
    jsr CommonJump_EnemyBGCollideOrApplySpeed
    ; exit if movement succeeded
    bcs KraidLintDraw_BANK{BANK}
    ; movement has failed either because lint hit a wall or went out of bounds
    ; lint dies
    lda #enemyStatus_Explode
    sta EnsExtra.0.status,x

KraidLintDraw_BANK{BANK}:
    ; draw lint
    lda #$01
    jsr CommonJump_UpdateEnemyAnim
    jmp CommonJump_02

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNailAIRoutine_BANK{BANK}: ; L9B2C
    jmp KraidLintAIRoutine_BANK{BANK}

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidUpdateAllProjectiles_BANK{BANK}: ; L9B2F
    ldx #$50 ; For each of Kraid's projectiles
    @loop:
        jsr KraidUpdateProjectile_BANK{BANK}
        txa
        sec
        sbc #$10
        tax
        bne @loop
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidUpdateProjectile_BANK{BANK}:
    ; remove projectile if it doesn't exist (a bit odd, but ok)
    ldy EnsExtra.0.status,x
    beq @remove
    
    ; exit if projectile is not lint or nail
    lda EnsExtra.0.type,x
    cmp #$0A
    beq @branchA
    cmp #$09
    bne KraidUpdateProjectile_Exit_BANK{BANK}

@branchA:
    ; remove projectile if it is invisible
    lda EnData05,x
    and #$02
    beq @remove
    ; branch if projectile is resting
    dey
    beq @resting
    ; remove projectile if its exploding
    cpy #enemyStatus_Explode-1.b
    beq @remove
    ; exit if projectile is not frozen
    cpy #enemyStatus_Frozen-1.b
    bne KraidUpdateProjectile_Exit_BANK{BANK}
    ; projectile is frozen
    ; exit if projectile state before being frozen was not resting
    lda EnPrevStatus,x
    cmp #$01
    bne KraidUpdateProjectile_Exit_BANK{BANK}
    ; projectile state before being frozen was resting
    beq @resting ; branch always

@remove:
    lda #enemyStatus_NoEnemy ; #$00
    sta EnsExtra.0.status,x
    sta EnSpecialAttribs,x
    jsr CommonJump_0E

@resting:
    ; initialize projectile
    ; copy Kraid's EnData05 to projectile's EnData05
    lda EnData05
    sta EnData05,x
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
    lda KraidProjectileOffsetY_BANK{BANK}-1,y
    sta Temp04_SpeedY
    ; get projectile type from table
    lda KraidProjectileType_BANK{BANK}-1,y
    sta EnsExtra.0.type,x
    ; Y = (X/16)*2 + the LSB of EnData05[0] (direction Kraid is facing)
    tya
    plp
    rol
    tay
    ; get x offset from table
    lda KraidProjectileOffsetX_BANK{BANK}-2,y
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
    jsr StoreEnemyPositionToTemp__BANK{BANK}
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
    bcc KraidUpdateProjectile_Exit_BANK{BANK}
    ; set projectile status to enemyStatus_Resting if it was enemyStatus_NoEnemy
    lda EnsExtra.0.status,x
    bne LoadEnemyPositionFromTemp__BANK{BANK}
    inc EnsExtra.0.status,x
    ; save as projectile's position
    ; fallthrough

LoadEnemyPositionFromTemp__BANK{BANK}:
    lda Temp08_PositionY
    sta EnY,x
    lda Temp09_PositionX
    sta EnX,x
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x

KraidUpdateProjectile_Exit_BANK{BANK}:
    rts

StoreEnemyPositionToTemp__BANK{BANK}:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

KraidProjectileOffsetY_BANK{BANK}:
    .byte -11,  -3,   5, -10,  -2
KraidProjectileOffsetX_BANK{BANK}: ;9BD1
; First column is for facing right, second for facing left
    .byte  10, -10
    .byte  12, -12
    .byte  14, -14
    .byte  -8,   8
    .byte -12,  12
KraidProjectileType_BANK{BANK}: ; L9BDB
    .byte $09, $09, $09, $0A, $0A ; Lint x 3, nail x 2

;-------------------------------------------------------------------------------
; Kraid Subroutine 2
;  Something to do with the lint
KraidTryToLaunchLint_BANK{BANK}:
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
    sta EnDelay,x

@RTS:
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidTryToLaunchNail_BANK{BANK}:
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
    sta EnDelay,x

@RTS:
    rts

