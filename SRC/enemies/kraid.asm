; Kraid, Lint, and Nails

; Kraid Routine
KraidAIRoutine:
    lda EnStatus,x
    cmp #enemyStatus_Explode
    bcc KraidBranchB
    beq KraidBranchA
    cmp #enemyStatus_Pickup
    bne KraidBranchC

KraidBranchA:
    ; delete projectiles
    lda #enemyStatus_NoEnemy
    sta EnStatus+$10
    sta EnStatus+$20
    sta EnStatus+$30
    sta EnStatus+$40
    sta EnStatus+$50
    beq KraidBranchC

KraidBranchB:
    jsr KraidUpdateAllProjectiles
    jsr KraidSubB
    jsr KraidSubC

KraidBranchC:
    lda #$0A
    sta $00
    jmp CommonEnemyStub ;sidehopper.asm

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLintAIRoutine:
    lda EnData05,x
    and #$02
    beq KraidLintBranchA
    lda EnStatus,x
    cmp #enemyStatus_Explode
    bne KraidLintBranchB

KraidLintBranchA:
    lda #enemyStatus_NoEnemy
    sta EnStatus,x
    beq KraidLintBranchC

KraidLintBranchB:
    lda EnData05,x
    asl
    bmi KraidLintBranchC

    lda EnStatus,x
    cmp #enemyStatus_Active
    bne KraidLintBranchC

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

    jsr CommonJump_11
    bcs KraidLintBranchC

    lda #enemyStatus_Explode
    sta EnStatus,x

KraidLintBranchC:
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
    txa               ;\
    sec               ;|-- X := X-$10
    sbc #$10          ;|
    tax               ;/
    bne @loop
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidUpdateProjectile:
    ldy EnStatus,x
    beq KraidUpdateProjectile_BranchB
    
    ; run KraidUpdateProjectile_BranchA if projectile is lint or nail
    lda EnType,x
    cmp #$0A
    beq KraidUpdateProjectile_BranchA
    cmp #$09
    bne KraidUpdateProjectile_Exit

KraidUpdateProjectile_BranchA:
    lda EnData05,x
    and #$02
    beq KraidUpdateProjectile_BranchB
    dey
    beq KraidUpdateProjectile_BranchC
    cpy #$02
    beq KraidUpdateProjectile_BranchB
    cpy #$03
    bne KraidUpdateProjectile_Exit
    lda EnPrevStatus,x
    cmp #$01
    bne KraidUpdateProjectile_Exit
    beq KraidUpdateProjectile_BranchC

KraidUpdateProjectile_BranchB:
    lda #enemyStatus_NoEnemy ; #$00
    sta EnStatus,x
    sta EnSpecialAttribs,x
    jsr CommonJump_0E

KraidUpdateProjectile_BranchC:
    ; initialize projectile
    lda EnData05
    sta EnData05,x
    lsr
    php ;
    txa  ;\
    lsr  ;|- Y := X/16
    lsr  ;|
    lsr  ;|
    lsr  ;|
    tay  ;/
    lda KraidBulletY-1,y
    sta $04
    lda KraidBulletType-1,y
    sta EnType,x
    tya
    plp ;
    rol
    tay ; Y = (X/16)*2 + the LSB of EnData05[0] (direction Kraid is facing)
    lda KraidBulletX-2,y
    sta $05

; The Brinstar Kraid code makes an incorrect assumption about X, which leads to
;  a crash when attempting to spawn him
.IF BANK <> 1
    txa
    pha ;
.ENDIF

    ldx #$00
    jsr StorePositionToTemp

.IF BANK <> 1
    pla ;
    tax
.ENDIF

    jsr CommonJump_ApplySpeedToPosition

.IF BANK = 1
    ldx PageIndex
.ENDIF

    bcc KraidUpdateProjectile_Exit
    lda EnStatus,x
    bne LoadPositionFromTemp
    inc EnStatus,x

LoadPositionFromTemp:
    lda $08
    sta EnY,x
    lda $09
    sta EnX,x
    lda $0B
    and #$01
    sta EnHi,x

KraidUpdateProjectile_Exit:
    rts

StorePositionToTemp:
    lda EnY,x
    sta $08
    lda EnX,x
    sta $09
    lda EnHi,x
    sta $0B
    rts

KraidBulletY:
    .byte -11,  -3,   5, -10,  -2
KraidBulletX: ;9BD1
; First column is for facing right, second for facing left
    .byte  10, -10
    .byte  12, -12
    .byte  14, -14
    .byte  -8,   8
    .byte -12,  12
KraidBulletType: ; L9BDB
    .byte $09, $09, $09, $0A, $0A ; Lint x 3, nail x 2

;-------------------------------------------------------------------------------
; Kraid Subroutine 2
;  Something to do with the lint
KraidSubB:
    ldy KraidLintCounter
    bne KraidSubB_BranchA
        ldy #$80
    KraidSubB_BranchA:
    lda FrameCount
    and #$02
    bne KraidSubB_Exit
    dey
    sty KraidLintCounter
    tya
    asl
    bmi KraidSubB_Exit
    and #$0F
    cmp #$0A
    bne KraidSubB_Exit
    lda #enemyStatus_Resting
    
    ldx #$10
    cmp EnStatus,x
    beq KraidSubB_BranchB
    
    ldx #$20
    cmp EnStatus,x
    beq KraidSubB_BranchB
    
    ldx #$30
    cmp EnStatus,x
    beq KraidSubB_BranchB
    
    inc KraidLintCounter
    rts

KraidSubB_BranchB:
    lda #$08
    sta EnDelay,x

KraidSubB_Exit:
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidSubC:
    ldy KraidNailCounter
    bne KraidSubC_BranchA
        ldy #$60
    KraidSubC_BranchA:
    lda FrameCount
    and #$02
    bne KraidSubC_Exit
    dey
    sty KraidNailCounter
    tya
    asl
    bmi KraidSubC_Exit
    and #$0F
    bne KraidSubC_Exit
    lda #enemyStatus_Resting
    
    ldx #$40
    cmp EnStatus,x
    beq KraidSubC_BranchB
    
    ldx #$50
    cmp EnStatus,x
    beq KraidSubC_BranchB
    
    inc KraidNailCounter
    rts

KraidSubC_BranchB:
    lda #$08
    sta EnDelay,x

KraidSubC_Exit:
    rts
