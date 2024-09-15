; Kraid, Lint, and Nails

; Kraid Routine
KraidRoutine:
    lda EnStatus,X
    cmp #$03
    bcc KraidBranchB
    beq KraidBranchA
    cmp #$05
    bne KraidBranchC

KraidBranchA:
    lda #$00
    sta EnStatus+$10 ;$6B04
    sta EnStatus+$20 ;$6B14
    sta EnStatus+$30 ;$6B24
    sta EnStatus+$40 ;$6B34
    sta EnStatus+$50 ;$6B44 ??
    beq KraidBranchC

KraidBranchB:
    jsr KraidSubA
    jsr KraidSubB
    jsr KraidSubC

KraidBranchC:
    lda #$0A
    sta $00
    jmp CommonEnemyStub

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLint:
    lda EnData05,X
    and #$02
    beq KraidLintBranchA
    lda EnStatus,X
    cmp #$03
    bne KraidLintBranchB

KraidLintBranchA:
    lda #$00
    sta EnStatus,X
    beq KraidLintBranchC

KraidLintBranchB:
    lda EnData05,X
    asl
    bmi KraidLintBranchC

    lda EnStatus,X
    cmp #$02
    bne KraidLintBranchC

    jsr CommonJump_VertMoveProc
    ldx PageIndex
    lda $00
    sta EnData02,X

    jsr CommonJump_HoriMoveProc
    ldx PageIndex
    lda $00
    sta EnData03,X
    jsr CommonJump_11
    bcs KraidLintBranchC

    lda #$03
    sta EnStatus,X

KraidLintBranchC:
    lda #$01
    jsr CommonJump_UpdateEnemyAnim
    jmp CommonJump_02

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNail: ; L9B2C
    jmp KraidLint

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidSubA: ; L9B2F
    ldx #$50 ; For each enemy slot (except Kraid's)
@loop:
    jsr KraidSubASub
    txa               ;\
    sec               ;|-- X := X-$10
    sbc #$10          ;|
    tax               ;/
    bne @loop
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidSubASub:
    ldy EnStatus,X
    beq KraidSubASub_BranchB
    lda EnDataIndex,X
    cmp #$0A
    beq KraidSubASub_BranchA
    cmp #$09
    bne KraidSubASub_Exit

KraidSubASub_BranchA:
    lda EnData05,X
    and #$02
    beq KraidSubASub_BranchB
    dey
    beq KraidSubASub_BranchC
    cpy #$02
    beq KraidSubASub_BranchB
    cpy #$03
    bne KraidSubASub_Exit
    lda EnData0C,X
    cmp #$01
    bne KraidSubASub_Exit
    beq KraidSubASub_BranchC

KraidSubASub_BranchB:
    lda #$00
    sta EnStatus,X
    sta EnSpecialAttribs,X
    jsr CommonJump_0E

KraidSubASub_BranchC:
    lda EnData05
    sta EnData05,X
    lsr
    php ;
    txa  ;\
    lsr  ;|- Y := X/16
    lsr  ;|
    lsr  ;|
    lsr  ;|
    tay  ;/
    lda KraidBulletY-1,Y
    sta $04
    lda KraidBulletType-1,Y
    sta EnDataIndex,X

KraidSubASub_BranchD:
    tya
    plp ;
    rol
    tay ; Y = (X/16)*2 + the LSB of EnData05[0] (direction Kraid is facing)
    lda KraidBulletX-2,Y
    sta $05

KraidSubASub_BranchE:

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

    jsr CommonJump_0D

.IF BANK = 1
    ldx PageIndex
.ENDIF

    bcc KraidSubASub_Exit
    lda EnStatus,X
    bne LoadPositionFromTemp
    inc EnStatus,X

LoadPositionFromTemp:
    lda $08
    sta EnYRoomPos,X
    lda $09
    sta EnXRoomPos,X
    lda $0B
    and #$01
    sta EnNameTable,X

KraidSubASub_Exit:
    rts

StorePositionToTemp:
    lda EnYRoomPos,X
    sta $08
    lda EnXRoomPos,X
    sta $09
    lda EnNameTable,X
    sta $0B
    rts

KraidBulletY:
    .byte -11, -3, 5, -10, -2
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
    ldy $7E
    bne KraidSubB_BranchA
    ldy #$80

KraidSubB_BranchA:
    lda FrameCount
    and #$02
    bne KraidSubB_Exit
    dey
    sty $7E
    tya
    asl
    bmi KraidSubB_Exit
    and #$0F
    cmp #$0A
    bne KraidSubB_Exit
    lda #$01
    ldx #$10
    cmp EnStatus,X
    beq KraidSubB_BranchB
    ldx #$20
    cmp EnStatus,X
    beq KraidSubB_BranchB
    ldx #$30
    cmp EnStatus,X
    beq KraidSubB_BranchB
    inc $7E
    rts

KraidSubB_BranchB:
    lda #$08
    sta EnDelay,X

KraidSubB_Exit:
    rts

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidSubC:
    ldy $7F
    bne KraidSubC_BranchA
    ldy #$60

KraidSubC_BranchA:
    lda FrameCount
    and #$02
    bne KraidSubC_Exit
    dey
    sty $7F
    tya
    asl
    bmi KraidSubC_Exit
    and #$0F
    bne KraidSubC_Exit
    lda #$01
    ldx #$40
    cmp EnStatus,X
    beq KraidSubC_BranchB
    ldx #$50
    cmp EnStatus,X
    beq KraidSubC_BranchB
    inc $7F
    rts

KraidSubC_BranchB:
    lda #$08
    sta EnDelay,X

KraidSubC_Exit:
    rts
