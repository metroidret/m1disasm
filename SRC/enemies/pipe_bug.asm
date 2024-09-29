; Pipe Bug AI Handler

PipeBugRoutine:
    lda EnStatus,x      ;
    cmp #$02            ;
    bne PipeBugBranchA  ;
    lda EnData03,x      ;
    bne PipeBugBranchA  ;
    lda EnData1A,x      ;
    bne PipeBugBranchB  ;

    lda ObjectY         ;\
    sec                 ;|
    sbc EnYRoomPos,x    ;| - branch if (SamusY - PipeBugY) >= 0x40
    cmp #$40            ;|
    bcs PipeBugBranchA  ;/

    lda #$7F            ;\
    sta EnData1A,x      ;| - EnData1A := $7E, branch always
    bne PipeBugBranchA  ;/

PipeBugBranchB:      ;
    lda EnData02,x      ;
    bmi PipeBugBranchA  ;
    lda #$00            ;
    sta EnData02,x      ;
    sta EnCounter,x     ;
    sta EnData1A,x      ;
    lda EnData05,x      ;
    and #$01            ;
    tay                 ;
    lda PipeBugTable,y  ;
    sta EnData03,x      ;

PipeBugBranchA:
    lda EnData05,x
    asl
    bmi PipeBugBranchC
    lda EnStatus,x
    cmp #$02
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
    lda #$00
    sta EnStatus,x
    rts

PipeBugTable:
.if BANK = 1 ; Brinstar
    .byte $04, -$04
.else ; Norfair, Kraid, Ridley
    .byte $08, -$08
.endif
