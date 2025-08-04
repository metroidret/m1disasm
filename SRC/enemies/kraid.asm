; Kraid, Lint, and Nails

; Kraid Routine
KraidAIRoutine:
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bcc KraidBranch_Normal ; 0, 1, 2
    beq KraidBranch_Explode ; 3
    cmp #enemyStatus_Pickup
    bne KraidBranch_Exit ; 4, 6
    ; 5
    ; fallthrough

KraidBranch_Explode:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnsExtra.1.status
    sta EnsExtra.2.status
    sta EnsExtra.3.status
    sta EnsExtra.4.status
    sta EnsExtra.5.status
    beq KraidBranch_Exit

KraidBranch_Normal:
    jsr KraidUpdateAllProjectiles
    jsr KraidTryToLaunchLint
    jsr KraidTryToLaunchNail
    ; fallthrough

KraidBranch_Exit:
    ; change animation frame every 10 frames
    lda #$0A
    sta $00
    jmp CommonEnemyStub ;sidehopper.asm

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLintAIRoutine:
    ; branch if lint is invisible
    lda EnData05,x
    and #$02
    beq KraidLintRemove
    ; branch if lint is not exploding
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    bne KraidLintMain

KraidLintRemove:
    ; lint is dead, clear enemy slot
    lda #enemyStatus_NoEnemy
    sta EnsExtra.0.status,x
    beq KraidLintDraw ; branch always

KraidLintMain:
    ; exit if bit7 of EnData05 is set
    lda EnData05,x
    asl
    bmi KraidLintDraw
    ; exit if lint is not active
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Active
    bne KraidLintDraw

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
    bcs KraidLintDraw
    ; movement has failed either because lint hit a wall or went out of bounds
    ; lint dies
    lda #enemyStatus_Explode
    sta EnsExtra.0.status,x

KraidLintDraw:
    ; draw lint
    lda #$01
    jsr CommonJump_UpdateEnemyAnim
    jmp CommonJump_02

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNailAIRoutine: ; L9B2C
    jmp KraidLintAIRoutine

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidUpdateAllProjectiles: ; L9B2F
    ldx #$50 ; For each of Kraid's projectiles
    @loop:
        jsr KraidUpdateProjectile
        txa
        sec
        sbc #$10
        tax
        bne @loop
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidUpdateProjectile:
    ; remove projectile if it doesn't exist (a bit odd, but ok)
    ldy EnsExtra.0.status,x
    beq @remove
    
    ; exit if projectile is not lint or nail
    lda EnsExtra.0.type,x
    cmp #$0A
    beq @branchA
    cmp #$09
    bne KraidUpdateProjectile_Exit

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
    bne KraidUpdateProjectile_Exit
    ; projectile is frozen
    ; exit if projectile state before being frozen was not resting
    lda EnPrevStatus,x
    cmp #$01
    bne KraidUpdateProjectile_Exit
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
    lda KraidProjectileOffsetY-1,y
    sta Temp04_SpeedY
    ; get projectile type from table
    lda KraidProjectileType-1,y
    sta EnsExtra.0.type,x
    ; Y = (X/16)*2 + the LSB of EnData05[0] (direction Kraid is facing)
    tya
    plp
    rol
    tay
    ; get x offset from table
    lda KraidProjectileOffsetX-2,y
    sta Temp05_SpeedX

; The Brinstar Kraid code makes an incorrect assumption about X, which leads to
;  a crash when attempting to spawn him
    .IF BANK != 1
        ; push x to stack
        txa
        pha
    .ENDIF
    ; store kraid's position in temp
    ldx #$00
    jsr StoreEnemyPositionToTemp_
    .IF BANK != 1
        ; pull x from stack
        pla
        tax
    .ENDIF
    ; apply offset to kraid's position
    jsr CommonJump_ApplySpeedToPosition

    .IF BANK == 1
        ; load projectile's enemy slot offset into x
        ; (BUG! this is actually kraid's enemy slot offset) 
        ldx PageIndex
    .ENDIF
    ; exit if initial position for projectile is out of bounds
    bcc KraidUpdateProjectile_Exit
    ; set projectile status to enemyStatus_Resting if it was enemyStatus_NoEnemy
    lda EnsExtra.0.status,x
    bne LoadEnemyPositionFromTemp_
    inc EnsExtra.0.status,x
    ; save as projectile's position
    ; fallthrough

LoadEnemyPositionFromTemp_:
    lda Temp08_PositionY
    sta EnY,x
    lda Temp09_PositionX
    sta EnX,x
    lda Temp0B_PositionHi
    and #$01
    sta EnsExtra.0.hi,x

KraidUpdateProjectile_Exit:
    rts

StoreEnemyPositionToTemp_:
    lda EnY,x
    sta Temp08_PositionY
    lda EnX,x
    sta Temp09_PositionX
    lda EnsExtra.0.hi,x
    sta Temp0B_PositionHi
    rts

KraidProjectileOffsetY:
    .byte -11,  -3,   5, -10,  -2
KraidProjectileOffsetX: ;9BD1
; First column is for facing right, second for facing left
    .byte  10, -10
    .byte  12, -12
    .byte  14, -14
    .byte  -8,   8
    .byte -12,  12
KraidProjectileType: ; L9BDB
    .byte $09, $09, $09, $0A, $0A ; Lint x 3, nail x 2

;-------------------------------------------------------------------------------
; Kraid Subroutine 2
;  Something to do with the lint
KraidTryToLaunchLint:
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
KraidTryToLaunchNail:
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

