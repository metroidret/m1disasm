; Zoomer Routine (Crawler)
CrawlerRoutine:
    JSR CommonJump_03
    AND #$03
    BEQ Crawler03
    LDA $81
    .if BANK = 1
        CMP #$01
        BEQ SkreeExitB
        CMP #$03
        BEQ SkreeExitC
    .elseif BANK = 2
        CMP #$01
        BEQ Crawler03c
        CMP #$03
        BEQ Crawler03b
    .endif
    LDA EnStatus,X
    CMP #$03
    BEQ Crawler03
    LDA EnData0A,X
    AND #$03
    CMP #$01
    BNE Crawler01
    LDY EnYRoomPos,X
    .if BANK = 1
        CPY #$E4
    .elseif BANK = 2
        CPY #$EB
    .endif
    BNE Crawler01
    JSR Crawler07
    LDA #$03
    STA EnData0A,X
    BNE Crawler02
Crawler01:
    JSR JumpByRTS
    JSR Crawler06
Crawler02:
    JSR Crawler09
Crawler03:
    LDA #$03
    JSR CommonJump_UpdateEnemyAnim
Crawler03b:
    JMP CommonJump_02

.if BANK = 2
    Crawler03c:
        JMP CommonJump_01
.endif

Crawler04:
    LDA EnData05,X
    LSR 
    LDA EnData0A,X
    AND #$03
    ROL 
    TAY 
    LDA Crawler05,Y
    JMP CommonJump_05

.if BANK = 1
    Crawler05:  .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E 
.elseif BANK = 2
    Crawler05:  .byte $69, $69, $72, $6C, $6F, $6F, $6C, $72
.endif

Crawler06:
    LDX PageIndex
    BCS Crawler08
    LDA $00
    BNE Crawler07
    LDY EnData0A,X
    DEY 
    TYA 
    AND #$03
    STA EnData0A,X
    JMP Crawler04

Crawler07:
    LDA EnData05,X
    EOR #$01
    STA EnData05,X
Crawler08:
    RTS

Crawler09:
    JSR Crawler11
    JSR JumpByRTS
    LDX PageIndex
    BCC Crawler10
    JSR Crawler11
    STA EnData0A,X
    JSR Crawler04
Crawler10:
    RTS

Crawler11:
    LDY EnData0A,X
    INY 
    TYA 
    AND #$03
    RTS

JumpByRTS:
    LDY EnData05,X
    STY $00
    LSR $00
    ROL 
    ASL 
    TAY 
    LDA L8048+1,Y
    PHA 
    LDA L8048,Y
    PHA 
    RTS

