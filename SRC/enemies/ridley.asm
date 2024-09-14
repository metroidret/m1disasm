; Ridley Routine
RidleyRoutine:
    LDA EnStatus,X
    CMP #$03
    BCC L9A33
    BEQ L9A20
    CMP #$05
    BNE L9A41

L9A20:
    LDA #$00
    STA EnStatus+$10
    STA EnStatus+$20
    STA EnStatus+$30
    STA EnStatus+$40
    STA EnStatus+$50
    BEQ L9A41

L9A33:
    LDA #$0B
    STA $85
    LDA #$0E
    STA $86
    JSR CommonJump_09
    JSR L9A79

L9A41:
    LDA #$03
    STA $00
    STA $01
    JMP CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballRoutine:
    LDA $0405,X
    PHA 
    LDA #$02
    STA $00
    STA $01
    JSR CommonEnemyJump_00_01_02
    PLA 
    LDX $4B
    EOR $0405,X
    LSR 
    BCS L9A73
    LDA $0405,X
    LSR 
    BCS L9A78
    LDA $0401,X
    SEC 
    SBC $030E
    BCC L9A78
    CMP #$20
    BCC L9A78
L9A73:
    LDA #$00
    STA EnStatus,X
L9A78:
    RTS

;-------------------------------------------------------------------------------
; Ridley Subroutine
L9A79:
    LDY $80
    BNE L9A7F
        LDY #$60
    L9A7F:
    LDA $2D
    AND #$02
    BNE L9AA9
    DEY 
    STY $80
    TYA 
    ASL 
    BMI L9AA9
    AND #$0F
    CMP #$0A
    BNE L9AA9
    LDX #$50
    L9A94:
        LDA EnStatus,X
        BEQ L9AAA
        LDA $0405,X
        AND #$02
        BEQ L9AAA
        TXA 
        SEC 
        SBC #$10
        TAX 
        BNE L9A94
    INC $7E
L9AA9:
    RTS

L9AAA:
    TXA 
    TAY 
    LDX #$00
    JSR StorePositionToTemp
    TYA 
    TAX 
    LDA $0405
    STA $0405,X
    AND #$01
    TAY 
    LDA L9ADF,Y
    STA $05
    LDA #$F8
    STA $04
    JSR CommonJump_0D
    BCC L9AA9
    LDA #$00
    STA $040F,X
    LDA #$0A
    STA EnDataIndex,X
    LDA #$01
    STA EnStatus,X
    JSR LoadPositionFromTemp
    JMP CommonJump_0E
L9ADF:
    .byte $08, -$08