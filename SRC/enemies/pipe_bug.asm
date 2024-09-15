; Pipe Bug AI Handler

PipeBugRoutine:
    lda EnStatus,X      ;
    cmp #$02            ;
    bne PipeBugBranchA  ;
    lda EnData03,X      ;
    bne PipeBugBranchA  ;
    lda EnData1A,X      ;
    bne PipeBugBranchB  ;

    lda ObjectY         ;\
    sec                 ;|
    sbc EnYRoomPos,X    ;| - branch if (SamusY - PipeBugY) >= 0x40
    cmp #$40            ;|
    bcs PipeBugBranchA  ;/

    lda #$7F            ;\
    sta EnData1A,X      ;| - EnData1A := $7E, branch always
    bne PipeBugBranchA  ;/

PipeBugBranchB:      ;
    lda EnData02,X      ;
    bmi PipeBugBranchA  ;
    lda #$00            ;
    sta EnData02,X      ;
    sta EnCounter,X     ;
    sta EnData1A,X      ;
    lda EnData05,X      ;
    and #$01            ;
    tay                 ;
    lda PipeBugTable,Y  ;
    sta EnData03,X      ;

PipeBugBranchA:
    lda EnData05,X
    asl
    bmi PipeBugBranchC
    lda EnStatus,X
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
    sta EnStatus,X
    rts

PipeBugTable:
.if BANK = 1 ; Brinstar
    .byte $04, -$04
.else ; Norfair, Kraid, Ridley
    .byte $08, -$08
.endif
