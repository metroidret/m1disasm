; Kraid, Lint, and Nails

; Kraid Routine
KraidRoutine:
    LDA EnStatus,X
    CMP #$03
    BCC KraidBranchB
    BEQ KraidBranchA
    CMP #$05
    BNE KraidBranchC

KraidBranchA:
    LDA #$00
    STA EnStatus+$10 ;$6B04
    STA EnStatus+$20 ;$6B14
    STA EnStatus+$30 ;$6B24
    STA EnStatus+$40 ;$6B34
    STA EnStatus+$50 ;$6B44 ??
    BEQ KraidBranchC

KraidBranchB:
    JSR KraidSubA
    JSR KraidSubB
    JSR KraidSubC

KraidBranchC:
    LDA #$0A
    STA $00
    JMP CommonEnemyStub

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLint:
    LDA EnData05,X
    AND #$02
    BEQ KraidLintBranchA
    LDA EnStatus,X
    CMP #$03
    BNE KraidLintBranchB

KraidLintBranchA:
    LDA #$00
    STA EnStatus,X
    BEQ KraidLintBranchC

KraidLintBranchB:
    LDA EnData05,X
    ASL 
    BMI KraidLintBranchC
    
    LDA EnStatus,X
    CMP #$02
    BNE KraidLintBranchC
    
    JSR CommonJump_VertMoveProc
    LDX PageIndex
    LDA $00
    STA EnData02,X
    
    JSR CommonJump_HoriMoveProc
    LDX PageIndex
    LDA $00
    STA EnData03,X
    JSR CommonJump_11
    BCS KraidLintBranchC
    
    LDA #$03
    STA EnStatus,X

KraidLintBranchC:
    LDA #$01
    JSR CommonJump_UpdateEnemyAnim
    JMP CommonJump_02

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNail: ; L9B2C
    JMP KraidLint

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidSubA: ; L9B2F
    LDX #$50 ; For each enemy slot (except Kraid's)
@loop:
    JSR KraidSubASub
    TXA               ;\
    SEC               ;|-- X := X-$10
    SBC #$10          ;|
    TAX               ;/
    BNE @loop
    RTS

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidSubASub:
    LDY EnStatus,X
    BEQ KraidSubASub_BranchB
    LDA EnDataIndex,X
    CMP #$0A
    BEQ KraidSubASub_BranchA
    CMP #$09
    BNE KraidSubASub_Exit

KraidSubASub_BranchA:
    LDA EnData05,X
    AND #$02
    BEQ KraidSubASub_BranchB
    DEY 
    BEQ KraidSubASub_BranchC
    CPY #$02
    BEQ KraidSubASub_BranchB
    CPY #$03
    BNE KraidSubASub_Exit
    LDA EnData0C,X
    CMP #$01
    BNE KraidSubASub_Exit
    BEQ KraidSubASub_BranchC

KraidSubASub_BranchB:
    LDA #$00
    STA EnStatus,X
    STA EnSpecialAttribs,X
    JSR CommonJump_0E

KraidSubASub_BranchC:
    LDA EnData05
    STA EnData05,X
    LSR 
    PHP ;
    TXA  ;\
    LSR  ;|- Y := X/16
    LSR  ;|
    LSR  ;|
    LSR  ;|
    TAY  ;/
    LDA KraidBulletY-1,Y
    STA $04
    LDA KraidBulletType-1,Y
    STA EnDataIndex,X

KraidSubASub_BranchD:
    TYA 
    PLP ;
    ROL 
    TAY ; Y = (X/16)*2 + the LSB of EnData05[0] (direction Kraid is facing)
    LDA KraidBulletX-2,Y
    STA $05

KraidSubASub_BranchE:

; The Brinstar Kraid code makes an incorrect assumption about X, which leads to
;  a crash when attempting to spawn him
.IF BANK <> 1
    TXA 
    PHA ;
.ENDIF

    LDX #$00
    JSR StorePositionToTemp

.IF BANK <> 1
    PLA ;
    TAX 
.ENDIF

    JSR CommonJump_0D
    
.IF BANK = 1
    LDX PageIndex
.ENDIF

    BCC KraidSubASub_Exit
    LDA EnStatus,X
    BNE LoadPositionFromTemp
    INC EnStatus,X

LoadPositionFromTemp:
    LDA $08
    STA EnYRoomPos,X
    LDA $09
    STA EnXRoomPos,X
    LDA $0B
    AND #$01
    STA EnNameTable,X

KraidSubASub_Exit:
    RTS

StorePositionToTemp:
    LDA EnYRoomPos,X
    STA $08
    LDA EnXRoomPos,X
    STA $09
    LDA EnNameTable,X
    STA $0B
    RTS

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
    LDY $7E
    BNE KraidSubB_BranchA
    LDY #$80

KraidSubB_BranchA:
    LDA FrameCount
    AND #$02
    BNE KraidSubB_Exit
    DEY 
    STY $7E
    TYA 
    ASL 
    BMI KraidSubB_Exit
    AND #$0F
    CMP #$0A
    BNE KraidSubB_Exit
    LDA #$01
    LDX #$10
    CMP EnStatus,X
    BEQ KraidSubB_BranchB
    LDX #$20
    CMP EnStatus,X
    BEQ KraidSubB_BranchB
    LDX #$30
    CMP EnStatus,X
    BEQ KraidSubB_BranchB
    INC $7E
    RTS

KraidSubB_BranchB:
    LDA #$08
    STA EnDelay,X

KraidSubB_Exit:
    RTS

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidSubC:
    LDY $7F
    BNE KraidSubC_BranchA
    LDY #$60

KraidSubC_BranchA:
    LDA FrameCount
    AND #$02
    BNE KraidSubC_Exit
    DEY 
    STY $7F
    TYA 
    ASL 
    BMI KraidSubC_Exit
    AND #$0F
    BNE KraidSubC_Exit
    LDA #$01
    LDX #$40
    CMP EnStatus,X
    BEQ KraidSubC_BranchB
    LDX #$50
    CMP EnStatus,X
    BEQ KraidSubC_BranchB
    INC $7F
    RTS

KraidSubC_BranchB:
    LDA #$08
    STA EnDelay,X

KraidSubC_Exit:
    RTS 

; EoF
