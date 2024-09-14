; Pipe Bug AI Handler

PipeBugRoutine:
    LDA EnStatus,X      ;
    CMP #$02            ;
    BNE PipeBugBranchA  ;
    LDA EnData03,X      ;
    BNE PipeBugBranchA  ;
    LDA EnData1A,X      ;
    BNE PipeBugBranchB  ;
    
    LDA ObjectY         ;\
    SEC                 ;|
    SBC EnYRoomPos,X    ;| - branch if (SamusY - PipeBugY) >= 0x40
    CMP #$40            ;|
    BCS PipeBugBranchA  ;/
    
    LDA #$7F            ;\
    STA EnData1A,X      ;| - EnData1A := $7E, branch always
    BNE PipeBugBranchA  ;/

PipeBugBranchB:      ;
    LDA EnData02,X      ;
    BMI PipeBugBranchA  ;
    LDA #$00            ;
    STA EnData02,X      ;
    STA EnCounter,X     ;
    STA EnData1A,X      ;
    LDA EnData05,X      ;
    AND #$01            ;
    TAY                 ;
    LDA PipeBugTable,Y  ;
    STA EnData03,X      ;

PipeBugBranchA:
    LDA EnData05,X
    ASL 
    BMI PipeBugBranchC
    LDA EnStatus,X
    CMP #$02
    BNE PipeBugBranchC
    JSR CommonJump_12
    PHA 
    JSR CommonJump_13
    STA $05
    PLA 
    STA $04
    JSR StorePositionToTemp
    JSR CommonJump_0D ; Check if onscreen?
    BCC PipeBugDelete
    JSR LoadPositionFromTemp

;Exit 1
PipeBugBranchC:
    LDA #$03
    JMP CommonJump_01 ; Common Enemy Handler

;Exit 2
PipeBugDelete: ; Set enemy status to 0
    LDA #$00
    STA EnStatus,X
    RTS
    
PipeBugTable:
.IF BANK = 1 ; Brinstar
    .byte $04, -$04
.ELSE ; Norfair, Kraid, Ridley
    .byte $08, -$08
.ENDIF
