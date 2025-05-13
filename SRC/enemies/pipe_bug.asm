; Pipe Bug AI Handler

PipeBugAIRoutine:
    lda EnStatus,x
    cmp #enemyStatus_Active
    bne PipeBugBranchA
    lda EnSpeedX,x
    bne PipeBugBranchA
    lda EnAccelY,x
    bne PipeBugBranchB

    lda ObjY            ;\
    sec                 ;|
    sbc EnY,x           ;| - branch if (SamusY - PipeBugY) >= 0x40
    cmp #$40            ;|
    bcs PipeBugBranchA  ;/

    lda #$7F            ;\
    sta EnAccelY,x      ;| - EnAccelY := $7E, branch always
    bne PipeBugBranchA  ;/

PipeBugBranchB:
    lda EnSpeedY,x
    bmi PipeBugBranchA
    lda #$00
    sta EnSpeedY,x
    sta EnSpeedSubPixelY,x
    sta EnAccelY,x
    lda EnData05,x
    and #$01
    tay
    lda PipeBugTable,y
    sta EnSpeedX,x

PipeBugBranchA:
    lda EnData05,x
    asl
    bmi PipeBugBranchC
    
    lda EnStatus,x
    cmp #enemyStatus_Active
    bne PipeBugBranchC
    
    jsr CommonJump_12
    pha
    jsr CommonJump_13
    sta $05
    pla
    sta $04
    jsr StorePositionToTemp
    jsr CommonJump_0D ; Check if onscreen?
    bcc PipeBugDelete
    jsr LoadPositionFromTemp

;Exit 1
PipeBugBranchC:
    lda #$03
    jmp CommonJump_01 ; Common Enemy Handler

;Exit 2
PipeBugDelete: ; Set enemy status to 0
    lda #enemyStatus_NoEnemy
    sta EnStatus,x
    rts

PipeBugTable:
.if BANK = 1 ; Brinstar
    .byte $04, -$04
.else ; Norfair, Kraid, Ridley
    .byte $08, -$08
.endif
