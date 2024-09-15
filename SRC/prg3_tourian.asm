; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi 

;Tourian (memory page 3)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

BANK .set 3
.segment "BANK_03_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GotoLA320
.export GotoMetroid_LA315
.export GotoL9C6F
.export GotoCannonRoutine
.export GotoMotherBrainRoutine
.export GotoZebetiteRoutine
.export GotoRinkaSpawnerRoutine
.export GotoLA0C6
.export GotoLA142

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

.incbin "kraid/sprite_tiles.chr" ; 8D60 - Kraid Sprite CHR
.incbin "ridley/sprite_tiles.chr" ; 9160 - Ridley Sprite CHR

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A718)
    .word Palette01                 ;($A73C)
    .word Palette02                 ;($A748)
    .word Palette03                 ;($A742)
    .word Palette04                 ;($A74E)
    .word Palette05                 ;($A754)
    .word Palette05                 ;($A754)
    .word Palette06                 ;($A759)
    .word Palette07                 ;($A75E)
    .word Palette08                 ;($A773)
    .word Palette09                 ;($A788)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0A                 ;($A78D)
    .word Palette0B                 ;($A794)
    .word Palette0C                 ;($A79B)
    .word Palette0D                 ;($A7A2)
    .word Palette0E                 ;($A7A9)
    .word Palette0F                 ;($A7B1)
    .word Palette10                 ;($A7B9)
    .word Palette11                 ;($A7C1)
    .word Palette12                 ;($A7C9)

AreaPointers:
    .word SpecItmsTbl               ;($A83B)Beginning of special items table.
    .word RmPtrTbl                  ;($A7D1)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A7FB)Beginning of structure pointer table.
    .word MacroDefs                 ;($AE49)Beginning of macro definitions.
    .word EnemyFramePtrTbl1         ;($A42C)Address table into enemy animation data. Two-->
    .word EnemyFramePtrTbl2         ;($A52C)tables needed to accommodate all entries.
    .word EnemyPlacePtrTbl          ;($A540)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($A406)Index to values in addr tables for enemy animations.

; Special Tourian Routines
GotoLA320:
    JMP LA320
GotoMetroid_LA315:
    JMP Metroid_LA315
GotoL9C6F:
    JMP L9C6F
GotoCannonRoutine:
    JMP CannonRoutine
GotoMotherBrainRoutine:
    JMP MotherBrainRoutine
GotoZebetiteRoutine:
    JMP ZebetiteRoutine
GotoRinkaSpawnerRoutine:
    JMP RinkaSpawnerRoutine
GotoLA0C6:
    JMP LA0C6
GotoLA142:
    JMP LA142

AreaRoutine:
    JMP L9B25                       ;Area specific routine.

TwosCompliment_:
    EOR #$FF                        ;
    CLC                             ;The following routine returns the twos-->
    ADC #$01                        ;compliment of the value stored in A.
Exit__:
    RTS                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $40                       ;Tourian music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $03                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $03                       ;Samus start x coord on world map.
L95D8:  .byte $04                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $21, $00, $00, $00, $00, $00, $10, $00

; Enemy AI Jump Table
ChooseEnemyRoutine:
    LDA EnDataIndex,X
    JSR CommonJump_ChooseRoutine
        .word MetroidRoutine ; 00 - metroid
        .word MetroidRoutine ; 01 - same as 0
        .word L9A27 ; 02 - i dunno but it takes 30 damage with varia
        .word InvalidEnemy ; 03 - disappears
        .word RinkaRoutine ; 04 - rinka ?
        .word InvalidEnemy ; 05 - same as 3
        .word InvalidEnemy ; 06 - same as 3
        .word InvalidEnemy ; 07 - same as 3
        .word InvalidEnemy ; 08 - same as 3
        .word InvalidEnemy ; 09 - same as 3
        .word InvalidEnemy ; 0A - same as 3
        .word InvalidEnemy ; 0B - same as 3
        .word InvalidEnemy ; 0C - same as 3
        .word InvalidEnemy ; 0D - same as 3
        .word InvalidEnemy ; 0E - same as 3
        .word InvalidEnemy ; 0F - same as 3


L960B:  .byte $08, $08, $08, $08, $16, $16, $18, $18, $1F, $1F, $00, $00, $00, $00, $00, $00

L961B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L962B:  .byte $FF, $FF, $01, $FF, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1B, $1B, $00, $00, $00, $00, $00, $00

L964B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1D, $1D, $00, $00, $00, $00, $00, $00

L966B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L968B:  .byte $FE, $FE, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L969B:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96AB:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96CB:  .byte $00, $02, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyMovementPtrs:
    .word L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5
    .word L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5
    .word L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5
    .word L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5, L97D5
    .word L97D5, L97D5, L97D5, L97D5

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $C0, $D0, $00, $00, $7F
L9733:  .byte $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $50, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L978B:  .byte $00, $00, $26, $26, $26, $26, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word L97D5, L97D5, L97D8, L97DB

L97AF:  .word LA32B, LA330, LA337, LA348, LA359, LA36A, LA37B, LA388
L97BF:  .word LA391, LA3A2, LA3B3, LA3C4, LA3D5, LA3DE, LA3E7, LA3F0
L97CF:  .word LA3F9

L97D1:  .byte $00, $00, $00, $01

L97D5:  .byte $50, $22, $FF

L97D8:  .byte $50, $30, $FF

L97DB:  .byte $FF

InvalidEnemy:
    LDA #$00
    STA EnStatus,X
    RTS

CommonEnemyJump_00_01_02:
    LDA $81
    CMP #$01
    BEQ L97F1
    CMP #$03
    BEQ L97F6
        LDA $00
        JMP CommonJump_00
    L97F1:
        LDA $01
        JMP CommonJump_01
    L97F6:
        JMP CommonJump_02

;-------------------------------------------------------------------------------
; Metroid Routine
.include "enemies/metroid.asm"

;-------------------------------------------------------------------------------
; ???
L9A27:
    LDA #$01
    JMP CommonJump_01

;-------------------------------------------------------------------------------
; Rinka Routine??
.include "enemies/rinka.asm"

;-------------------------------------------------------------------------------
; Tourian specific routine -- called every active frame
L9B25:
    JSR L9B37
    JSR MotherBrainStatusHandler
    JSR LA1E7
    JSR LA238
    JSR LA28B
    JMP LA15E

;-------------------------------------------------------------------------------
L9B37:
    LDX #$78
    L9B39:
        JSR L9B44
        LDA $97
        SEC 
        SBC #$08
        TAX 
        BNE L9B39

L9B44:
    STX $97
    LDY $6BF4,X
    BNE L9B4C
L9B4B:
    RTS

L9B4C:
    JSR L9C4D
    TYA 
    BNE L9B4B
    LDY $010B
    INY 
    BNE L9B65
    LDA $6BF8,X
    CMP #$05
    BEQ L9B4B
    JSR L9B70
    JMP L9C2B

L9B65:
    LDA $2D
    AND #$02
    BNE L9B4B
    LDA #$19
    JMP L9C31

L9B70:
    LDY $6BF8,X
    LDA $6BFA,X
    BNE L9B81
        LDA L9D8F,Y
        STA $6BFA,X
        INC $6BFB,X
    L9B81:
    DEC $6BFA,X
L9B84:
    LDA L9D94,Y
    CLC 
    ADC $6BFB,X
    TAY 
    LDA L9D99,Y
    BPL L9BAB
        CMP #$FF
        BNE L9B9F
            LDY $6BF8,X
            LDA #$00
            STA $6BFB,X
            BEQ L9B84
        L9B9F:
        INC $6BFB,X
        JSR L9BAF
        LDY $6BF8,X
        JMP L9B84

    L9BAB:
        STA $6BF9,X
        RTS

L9BAF:
    PHA 
    LDA MotherBrainStatus
    CMP #$04
    BCS L9BC6
    LDY #$60
    L9BB8:
        LDA EnStatus,Y
        BEQ L9BC8
        TYA 
        CLC 
        ADC #$10
        TAY 
        CMP #$A0
        BNE L9BB8
L9BC6:
    PLA 
    RTS

L9BC8:
    STY $4B
    LDA $6BF5,X
    STA EnYRoomPos,Y
    LDA $6BF6,X
    STA EnXRoomPos,Y
    LDA $6BF7,X
    STA EnNameTable,Y
    LDA #$02
    STA EnStatus,Y
    LDA #$00
    STA $0409,Y
    STA EnAnimDelay,Y
    STA $0408,Y
    PLA 
    JSR TwosCompliment_
    TAX 
    STA $040A,Y
    ORA #$02
    STA $0405,Y
    LDA L9C28-2,X
    STA EnResetAnimIndex,Y
    STA EnAnimIndex,Y
    LDA L9DCC,X
    STA $05
    LDA L9DCF,X
    STA $04
    LDX $97
    LDA $6BF5,X
    STA $08
    LDA $6BF6,X
    STA $09
    LDA $6BF7,X
    STA $0B
    TYA 
    TAX 
    JSR CommonJump_0D
    JSR L99F4
    LDX $97
    RTS

L9C28:  .byte $0C, $0A, $0E

L9C2B:
    LDY $6BF9,X
    LDA L9DC6,Y
L9C31:
    STA $6BD7
    LDA $6BF5,X
    STA $04E0
    LDA $6BF6,X
    STA $04E1
    LDA $6BF7,X
    STA $6BDB
    LDA #$E0
    STA $4B
    JMP CommonJump_14

L9C4D:
    LDY #$00
    LDA $6BF6,X
    CMP $FD
    LDA $49
    AND #$02
    BNE L9C5F
        LDA $6BF5,X
        CMP $FC
    L9C5F:
    LDA $6BF7,X
    EOR $FF
    AND #$01
    BEQ L9C6B
        BCS L9C6D
        SEC 
    L9C6B:
    BCS L9C6E
L9C6D:
    INY 
L9C6E:
    RTS

;-------------------------------------------------------------------------------
L9C6F:
    STY $02
    LDY #$00
    L9C73:
        LDA $6BF7,Y
        EOR $02
        LSR 
        BCS L9C80
            LDA #$00
            STA $6BF4,Y
        L9C80:
        TYA 
        CLC 
        ADC #$08
        TAY 
        BPL L9C73
    LDX #$00
    L9C89:
        LDA $0758,X
        BEQ L9C99
        JSR L9D64
        EOR $075A,X
        BNE L9C99
        STA $0758,X
    L9C99:
        TXA 
        CLC 
        ADC #$08
        TAX 
        CMP #$28
        BNE L9C89
    LDX #$00
    JSR L9CD6
    LDX #$03
    JSR L9CD6
    LDA MotherBrainStatus
    BEQ L9CC3
    CMP #$07
    BEQ L9CC3
    CMP #$0A
    BEQ L9CC3
    LDA $9D
    EOR $02
    LSR 
    BCS L9CC3
    LDA #$00
    STA MotherBrainStatus
L9CC3:
    LDA $010D
    BEQ L9CD5
    LDA $010C
    EOR $02
    LSR 
    BCS L9CD5
    LDA #$00
    STA $010D
L9CD5:
    RTS

L9CD6:
    LDA $8B,X
    BMI L9CE5
    LDA $8C,X
    EOR $02
    LSR 
    BCS L9CE5
    LDA #$FF
    STA $8B,X
L9CE5:
    RTS

;-------------------------------------------------------------------------------
; Tourian Cannon Handler
CannonRoutine:
    LDX #$00
    L9CE8:
        LDA $6BF4,X
        BEQ L9CF6
        TXA 
        CLC 
        ADC #$08
        TAX 
        BPL L9CE8
    BMI L9D20
L9CF6:
    LDA ($00),Y
    JSR Adiv16_
    STA $6BF8,X
    LDA #$01
    STA $6BF4,X
    STA $6BFB,X
    INY 
    LDA ($00),Y
    PHA 
    AND #$F0
    ORA #$07
    STA $6BF5,X
    PLA 
    JSR Amul16_
    ORA #$07
    STA $6BF6,X
    JSR L9D88
    STA $6BF7,X
L9D20:
    RTS

;-------------------------------------------------------------------------------
; Mother Brain Handler
MotherBrainRoutine:
    LDA #$01
    STA MotherBrainStatus
    JSR L9D88
    STA $9D
    EOR #$01
    TAX 
    LDA L9D3C
    ORA $6C,X
    STA $6C,X
    LDA #$20
    STA $9A
    STA $9B
    RTS 

L9D3B:  .byte $02
L9D3C:  .byte $01 

;-------------------------------------------------------------------------------
; Zebetite Handler
ZebetiteRoutine:
    LDA ($00),Y
    AND #$F0
    LSR
    TAX 
    ASL 
    AND #$10
    EOR #$10
    ORA #$84
    STA $0759,X
    JSR L9D64
    STA $075A,X
    LDA #$01
    STA $0758,X
    LDA #$00
    STA $075B,X
    STA $075C,X
    STA $075D,X
    RTS

L9D64:
    JSR L9D88
    ASL 
    ASL 
    ORA #$61
    RTS

;-------------------------------------------------------------------------------
; Rinka Handler
RinkaSpawnerRoutine:
    LDX #$03
    JSR L9D75
        BMI L9D87
        LDX #$00
    L9D75:
    LDA $8B,X
    BPL L9D87
    LDA ($00),Y
    JSR Adiv16_
    STA $8B,X
    JSR L9D88
    STA $8C,X
    LDA #$FF
L9D87:
    RTS

L9D88:
    LDA $FF
    EOR $49
    AND #$01
    RTS

L9D8F:  .byte $28, $28, $28, $28, $28
L9D94:  .byte $00, $0B, $16, $21, $27
L9D99:  .byte $00, $01, $02, $FD, $03, $04
L9D9F:  .byte $FD, $03, $02, $01, $FF, $00, $07, $06, $FE, $05, $04, $FE, $05, $06, $07, $FF
L9DAF:  .byte $02, $03, $FC, $04, $05, $06, $05, $FC, $04, $03, $FF, $02, $03, $FC, $04, $03
L9DBF:  .byte $FF, $06, $05, $FC, $04, $05, $FF
L9DC6:  .byte $06, $07, $08, $09, $0A, $0B
L9DCC:  .byte $0C, $0D, $09

L9DCF:  .byte $F7, $00, $09, $09, $0B

;-------------------------------------------------------------------------------
; This is code:
MotherBrainStatusHandler:
    LDA MotherBrainStatus
    BEQ L9DF1
    JSR CommonJump_ChooseRoutine
        .word Exit__    ;#$00=Mother brain not in room, 
        .word L9E22     ;#$01=Mother brain in room
        .word L9E36     ;#$02=Mother brain hit
        .word L9E52     ;#$03=Mother brain dying
        .word L9E86     ;#$04=Mother brain dissapearing
        .word L9F02     ;#$05=Mother brain gone
        .word L9F49     ;#$06=Time bomb set, 
        .word L9FC0     ;#$07=Time bomb exploded
        .word L9F02     ;#$08=Initialize mother brain
        .word L9FDA     ;#$09
        .word Exit__    ;#$0A=Mother brain already dead.
L9DF1:
    RTS

;-------------------------------------------------------------------------------
L9DF2:
    LDA $030C
    EOR $9D
    BNE L9DF1
    LDA ObjectX
    SEC 
    SBC #$48
    CMP #$2F
    BCS L9DF1
    LDA ObjectY
    SEC 
    SBC #$80
    BPL L9E0E
        JSR TwosCompliment_
    L9E0E:
    CMP #$20
    BCS L9DF1
    LDA #$00
    STA $6E
    LDA #$02
    STA $6F
    LDA #$38
    STA $030A
    JMP CommonJump_SubtractHealth

;-------------------------------------------------------------------------------
L9E22:
    JSR L9DF2
    JSR L9FED
    JSR LA01B
    JSR LA02E
L9E2E:
    JSR LA041
L9E31:
    LDA #$00
    STA $9E
    RTS

;-------------------------------------------------------------------------------
L9E36:
    JSR L9E43
    LDA L9E41,Y
    STA $1C
    JMP L9E31

L9E41:  .byte $08, $07

L9E43:
    DEC $9F
    BNE L9E4B
        LDA #$01
        STA MotherBrainStatus
    L9E4B:
    LDA $9F
    AND #$02
    LSR 
    TAY 
    RTS

;-------------------------------------------------------------------------------
L9E52:  JSR L9E43
    LDA L9E41,Y
    STA $1C
    TYA 
    ASL 
    ASL 
    STA $FC
    LDY MotherBrainStatus
    DEY 
    BNE L9E83
    STY MotherBrainHits
    TYA 
    TAX 
    L9E68:
        TYA 
        STA EnStatus,X
        JSR L9EF9
        CPX #$C0
        BNE L9E68
    LDA #$04
    STA MotherBrainStatus
    LDA #$28
    STA $9F
    LDA $0680
    ORA #$01
    STA $0680
L9E83:
    JMP L9E2E

;-------------------------------------------------------------------------------
L9E86:
    LDA #$10
    ORA $0680
    STA $0680
    JSR LA072
    INC $9A
    JSR L9E43
    LDX #$00
    L9E98:
        LDA EnStatus,X
        CMP #$05
        BNE L9EA4
            LDA #$00
            STA EnStatus,X
        L9EA4:
        JSR L9EF9
        CMP #$40
        BNE L9E98
    LDA $07A0
    BNE L9EB5
        LDA L9F00,Y
        STA $1C
    L9EB5:
    LDY MotherBrainStatus
    DEY 
    BNE L9ED5
    STY $9A
    LDA #$04
    STA MotherBrainStatus
    LDA #$1C
    STA $9F
    LDY MotherBrainHits
    INC MotherBrainHits
    CPY #$04
    BEQ L9ED3
        LDX #$00
        BCC L9ED5
        JMP L9ED6
        
    L9ED3:
    LSR $9F
L9ED5:
    RTS

L9ED6:
    LDA $0685
    ORA #$04
    STA $0685
    LDA #$05
    STA MotherBrainStatus
    LDA #$80
    STA MotherBrainHits
    RTS

L9EE7:
    PHA 
    AND #$F0
    ORA #$07
    STA EnYRoomPos,X
    PLA 
    JSR Amul16_
    ORA #$07
    STA EnXRoomPos,X
    RTS

L9EF9:
    TXA 
    CLC 
    ADC #$10
    TAX 
    RTS

L9EFF: .byte $60
L9F00: ORA #$0A

;-------------------------------------------------------------------------------
L9F02:
    LDA MotherBrainHits
    BMI L9F33
        CMP #$08
        BEQ L9F36
        TAY 
        LDA L9F41,Y
        STA $0503
        LDA L9F39,Y
        CLC 
        ADC #$42
        STA $0508
        PHP 
        LDA $9D
        ASL 
        ASL 
        PLP 
        ADC #$61
        STA $0509
        LDA #$00
        STA $4B
        LDA $07A0
        BNE L9F38
        JSR CommonJump_15
        BCS L9F38
    L9F33:
    INC MotherBrainHits
    RTS

L9F36:
    INC MotherBrainStatus
L9F38:
    RTS

L9F39:  .byte $00, $40, $08, $48, $80, $C0, $88, $C8
L9F41:  .byte $08, $02, $09, $03, $0A, $04, $0B, $05

L9F49:
    JSR L9F69
    BCS L9F64
    LDA #$00
    STA MotherBrainStatus
    LDA #$99
    STA $010A
    STA $010B
    LDA #$01
    STA $010D
    LDA $9D
    STA $010C
L9F64:
    RTS

L9F65:  .byte $80, $B0, $A0, $90

L9F69:
    LDA $50 
    CLC
    ADC $4F
    SEC 
    ROL 
    AND #$03
    TAY 
    LDX L9F65,Y
    LDA #$01
    STA $030F,X
    LDA #$01
    STA $0307,X
    LDA #$03
    STA $0300,X
    LDA $9D
    STA $030C,X
    LDA #$10
    STA ObjectX,X
    LDA #$68
    STA ObjectY,X
    LDA #$55
    STA $0305,X
    STA $0306,X
    LDA #$00
    STA $0304,X
    LDA #$F7
    STA $0303,X
    LDA #$10
    STA $0503
    LDA #$40
    STA $0508
    LDA $9D
    ASL 
    ASL 
    ORA #$61
    STA $0509
    LDA #$00
    STA $4B
    JMP CommonJump_15

;-------------------------------------------------------------------------------
L9FC0:
    LDA #$10
    ORA $0680
    STA $0680
    LDA $2C
    BNE L9FD9
    LDA #$08
    STA $0300
    LDA #$0A
    STA MotherBrainStatus
    LDA #$01
    STA $1C
L9FD9:
    RTS

;-------------------------------------------------------------------------------
L9FDA:
    JSR L9F69
    BCS L9FEC
    LDA $9D
    STA $010C
    LDY #$01
    STY $010D
    DEY 
    STY MotherBrainStatus
L9FEC:
    RTS

;-------------------------------------------------------------------------------
L9FED:
    LDA $9E
    BEQ LA01A
    LDA $0684
    ORA #$02
    STA $0684
    INC MotherBrainHits
    LDA MotherBrainHits
    CMP #$20
    LDY #$02
    LDA #$10
    BCC LA016
    LDX #$00
    LA007:
        LDA #$00
        STA $0500,X
        JSR L9EF9
        CMP #$D0
        BNE LA007
    INY 
    LDA #$80
LA016:
    STY MotherBrainStatus
    STA $9F
LA01A:
    RTS

;-------------------------------------------------------------------------------
LA01B:
    DEC $9A
    BNE LA02D
    LDA $2E
    AND #$03
    STA $9C
    LDA #$20
    SEC 
    SBC MotherBrainHits
    LSR 
    STA $9A
LA02D:
    RTS

;-------------------------------------------------------------------------------
LA02E:
    DEC $9B
    LDA $9B
    ASL 
    BNE LA040
    LDA #$20
    SEC 
    SBC MotherBrainHits
    ORA #$80
    EOR $9B
    STA $9B
LA040:
    RTS

;-------------------------------------------------------------------------------
LA041:
    LDA #$E0
    STA $4B
    LDA $9D
    STA $6BDB
    LDA #$70
    STA $04E0
    LDA #$48
    STA $04E1
    LDY $9C
    LDA LA06D,Y
    STA $6BD7
    JSR CommonJump_14
    LDA $9B
    BMI LA06C
    LDA LA06D+4
    STA $6BD7
    JSR CommonJump_14
LA06C:
    RTS

LA06D:  .byte $13, $14, $15, $16, $17

LA072:
    LDY MotherBrainHits
    BEQ LA086
    LDA LA0C0,Y
    CLC 
    ADC $9A
    TAY 
    LDA LA0A3,Y
    CMP #$FF
    BNE LA087
    DEC $9A
LA086:
    RTS

LA087:
    ADC #$44
    STA $0508
    PHP 
    LDA $9D
    ASL 
    ASL 
    ORA #$61
    PLP 
    ADC #$00
    STA $0509
    LDA #$00
    STA $0503
    STA $4B
    JMP CommonJump_15

LA0A3:  .byte $00, $02, $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27
LA0B3:  .byte $FF, $82, $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86
LA0C0:  .byte $FF, $00, $0C
LA0C3:  .byte $11, $16, $1A

;-------------------------------------------------------------------------------
LA0C6:
    LDA $71
    BEQ LA13E
    LDX $4B
    LDA $0300,X
    CMP #$0B
    BNE LA13E
    CPY #$98
    BNE LA103
        LDX #$00
    LA0D9:
        LDA $0500,X
        BEQ LA0E7
            JSR L9EF9
            CMP #$D0
            BNE LA0D9
            BEQ LA13E
        LA0E7:
        LDA #$8C
        STA $0508,X
        LDA $05
        STA $0509,X
        LDA #$01
        STA $0503,X
        LDA $4B
        PHA 
        STX $4B
        JSR CommonJump_15
        PLA 
        STA $4B
        BNE LA13E
    LA103:
    LDA $04
    LSR 
    BCC LA10A
        DEC $04
    LA10A:
    LDY #$00
    LDA ($04),Y
    LSR 
    BCS LA13E
    CMP #$48
    BCC LA13E
    CMP #$4C
    BCS LA13E
    LA119:
        LDA $0758,Y
        BEQ LA12E
        LDA $04
        AND #$9E
        CMP $0759,Y
        BNE LA12E
        LDA $05
        CMP $075A,Y
        BEQ LA139
    LA12E:
        TYA 
        CLC 
        ADC #$08
        TAY 
        CMP #$28
        BNE LA119
    BEQ LA13E
LA139:
    LDA #$01
    STA $075D,Y
LA13E:
    PLA 
    PLA 
    CLC 
    RTS

;-------------------------------------------------------------------------------
LA142:
    TAY 
    LDA $71
    BEQ LA15C
    LDX $4B
    LDA $0300,X
    CMP #$0B
    BNE LA15C
    CPY #$5E
    BCC LA15C
    CPY #$72
    BCS LA15C
    LDA #$01
    STA $9E
LA15C:
    TYA 
LA15D:
    RTS

;-------------------------------------------------------------------------------
LA15E:
    LDY $010B
    INY 
    BNE LA1DA
    LDY #$03
    JSR LA16B
        LDY #$00
    LA16B:
    STY $4B
    LDA $008B,Y
    BMI LA15D
    LDA $008C,Y
    EOR $2D
    LSR 
    BCC LA15D
    LDA MotherBrainStatus
    CMP #$04
    BCS LA15D
    LDA $2D
    AND #$06
    BNE LA15D
    LDX #$20
    LA188:
        LDA EnStatus,X
        BEQ LA19C
        LDA $0405,X
        AND #$02
        BEQ LA19C
        TXA 
        SEC 
        SBC #$10
        TAX 
        BPL LA188
    RTS

LA19C:
    LDA #$01
    STA EnStatus,X
    LDA #$04
    STA $6B02,X
    LDA #$00
    STA $040F,X
    STA $0404,X
    JSR CommonJump_0E
    LDA #$F7
    STA $6AF7,X
    LDY $4B
    LDA $008C,Y
    STA EnNameTable,X
    LDA $008D,Y
    ASL 
    ORA $008B,Y
    TAY 
    LDA LA1DB,Y
    JSR L9EE7
    LDX $4B
    INC $8D,X
    LDA $8D,X
    CMP #$06
    BNE LA1DA
    LDA #$00
LA1D8:
    STA $8D,X
LA1DA:
    RTS

LA1DB:  .byte $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA, $BA, $BA

;-------------------------------------------------------------------------------
LA1E7:
    LDY $010B
    INY 
    BEQ LA237
    LDA $010A
    STA $03
    LDA #$01
    SEC 
    JSR CommonJump_Base10Subtract
    STA $010A
    LDA $010B
    STA $03
    LDA #$00
    JSR CommonJump_Base10Subtract
    STA $010B
    LDA $2D
    AND #$1F
    BNE LA216
        LDA $0681
        ORA #$08
        STA $0681
    LA216:
    LDA $010A
    ORA $010B
    BNE LA237
    DEC $010B
    STA MotherBrainHits
    LDA #$07
    STA MotherBrainStatus
    LDA $0680
    ORA #$01
    STA $0680
    LDA #$0C
    STA $2C
    LDA #$0B
    STA $1C
LA237:
    RTS

;-------------------------------------------------------------------------------
LA238:
    LDA $010D
    BEQ LA28A
    LDA $010C
    STA $6BDB
    LDA #$84
    STA $04E0
    LDA #$64
    STA $04E1
    LDA #$1A
    STA $6BD7
    LDA #$E0
    STA $4B
    LDA $5B
    PHA 
    JSR CommonJump_14
    PLA 
    CMP $5B
    BEQ LA28A
    TAX 
    LDA $010B
    LSR 
    LSR 
    LSR 
    SEC 
    ROR 
    AND #$0F
    ORA #$A0
    STA $0201,X
    LDA $010B
    AND #$0F
    ORA #$A0
    STA $0205,X
    LDA $010A
    LSR 
    LSR 
    LSR 
    SEC 
    ROR 
    AND #$0F
    ORA #$A0
    STA $0209,X
LA28A:
    RTS

;-------------------------------------------------------------------------------
LA28B:
    LDA #$10
    STA $4B
    LDX #$20
    LA291:
        JSR LA29B
        TXA 
        SEC 
        SBC #$08
        TAX 
        BNE LA291
LA29B:
    LDA $0758,X
    AND #$0F
    CMP #$01
    BNE LA28A
    LDA $075D,X
    BEQ LA2F2
    INC $075B,X
    LDA $075B,X
    LSR 
    BCS LA2F2
    TAY 
    SBC #$03
    BNE LA2BA
    INC $0758,X
LA2BA:
    LDA LA310,Y
    STA $0513
    LDA $0759,X
    STA $0518
    LDA $075A,X
    STA $0519
    LDA $07A0
    BNE LA2DA
        TXA 
        PHA 
        JSR CommonJump_15
        PLA 
        TAX 
        BCC LA2EB
    LA2DA:
    LDA $0758,X
    AND #$80
    ORA #$01
    STA $0758,X
    STA $075D,X
    DEC $075B,X
    RTS

LA2EB:
    LDA #$40
    STA $075C,X
    BNE LA30A
LA2F2:
    LDY $075B,X
    BEQ LA30A
    DEC $075C,X
    BNE LA30A
    LDA #$40
    STA $075C,X
    DEY 
    TYA 
    STA $075B,X
    LSR 
    TAY 
    BCC LA2BA
LA30A:
    LDA #$00
    STA $075D,X
    RTS

LA310:  .byte $0C, $0D, $0E, $0F, $07

; maybe smtg to do with removing the connection between metroid and samus
Metroid_LA315:
    LDY #$05
    LA317:
        JSR MetroidRoutine_L99B1
        DEY 
        BPL LA317
    STA $92
    RTS
;-----------------
LA320:
    TXA 
    JSR Adiv16_
    TAY 
    JSR MetroidRoutine_L99B1
    STA $92
    RTS

LA32B:  .byte $22, $FF, $FF, $FF, $FF

LA330:  .byte $32, $FF, $FF, $FF, $FF, $FF, $FF

LA337:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E0, $DE, $ED, $FF, $E8
    .byte $EE 

LA348:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $FF, $DF, $DA, $EC, $ED, $F4
    .byte $FF

LA359:
    .byte $28, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF

LA36A:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF

LA37B:  .byte $62, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA388:  .byte $42, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA391:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF
    .byte $DB

LA3A2:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E8, $E6, $DB, $FF, $EC, $DE, $ED
    .byte $FF

LA3B3:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF

LA3C4:
    .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF

LA3D5:  .byte $42, $90, $91, $90, $91, $90, $91, $90, $91

LA3DE:  .byte $42, $92, $93, $92, $93, $92, $93, $92, $93

LA3E7:  .byte $42, $94, $95, $94, $95, $94, $95, $94, $95

LA3F0:  .byte $42, $96, $97, $96, $97, $96, $97, $96, $97

LA3F9:  .byte $62, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
LA406:  .byte $00, $01, $FF

LA409:  .byte $02, $FF

LA40B:  .byte $03, $04, $FF

LA40E:  .byte $05, $FF

LA410:  .byte $0E, $FF

LA412:  .byte $0F, $FF

LA414:  .byte $10, $FF

LA416:  .byte $11, $11, $12, $12, $F7, $FF

LA41C:  .byte $18, $FF

LA41E:  .byte $19, $F7, $FF

LA421:  .byte $1B, $1C, $1D, $FF

LA425:  .byte $1E, $FF

LA427:  .byte $61, $F7, $62, $F7, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
    .word LA5C8, LA5CD, LA5D2, LA5D7, LA5E4, LA5F1, LA5FB, LA600
    .word LA606, LA60D, LA613, LA618, LA61E, LA625, LA62B, LA630
    .word LA635, LA63A, LA641, LA651, LA65F, LA66B, LA678, LA687
    .word LA691, LA69C, LA6A3, LA6AC, LA6BC, LA6CC, LA6DC, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0, LA6E0
    .word LA6E0, LA6E0, LA6EE, LA708, LA708, LA708, LA708, LA708
    .word LA708, LA708, LA708, LA708, LA708, LA708, LA708, LA708
    .word LA708, LA708, LA708, LA708, LA708, LA708, LA708, LA708
    .word LA708, LA708, LA708, LA708, LA708, LA708, LA708, LA708

EnemyFramePtrTbl2:
    .word LA708, LA70E, LA713, LA713, LA713, LA713, LA713, LA713
    .word LA713, LA713

EnemyPlacePtrTbl:
    .word LA560, LA562, LA57A, LA58C, LA592, LA59E, LA5A4, LA5A4
    .word LA5A4, LA5A4, LA5A4, LA5C4, LA5C4, LA5C8, LA5C8, LA5C8

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

LA560:  .byte $FC, $FC

LA562:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
    .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA57A:
    .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
    .byte $04, $04

LA58C:  .byte $F1, $FC, $F3, $F3, $FC, $F1

LA592:  .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA59E:  .byte $FC, $F4, $FC, $FC, $FC, $04

LA5A4:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

LA5C4:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

LA5C8:  .byte $00, $02, $02, $14, $FF

LA5CD:  .byte $00, $02, $02, $24, $FF

LA5D2:  .byte $00, $00, $00, $04, $FF

LA5D7:  .byte $32, $0C, $0C, $C0, $C1, $C2, $D0, $D1, $D2, $E0, $E1, $E2, $FF

LA5E4:  .byte $32, $0C, $0C, $C3, $C4, $C5, $D3, $D4, $D5, $E3, $E4, $E5, $FF

LA5F1:  .byte $31, $00, $00, $C0, $C2, $D0, $D2, $E0, $E2, $FF

LA5FB:  .byte $23, $07, $07, $EA, $FF

LA600:  .byte $23, $07, $07, $FE, $EB, $FF

LA606:  .byte $23, $07, $07, $FE, $FE, $EC, $FF

LA60D:  .byte $A3, $07, $07, $FE, $EB, $FF

LA613:  .byte $A3, $07, $07, $EA, $FF

LA618:  .byte $E3, $07, $07, $FE, $EB, $FF

LA61E:  .byte $63, $07, $07, $FE, $FE, $EC, $FF

LA625:  .byte $63, $07, $07, $FE, $EB, $FF

LA62B:  .byte $30, $04, $04, $F1, $FF

LA630:  .byte $70, $04, $04, $F1, $FF

LA635:  .byte $30, $04, $04, $F2, $FF

LA63A:  .byte $30, $00, $00, $FD, $03, $F3, $FF

LA641:  .byte $0A, $00, $00, $FD, $00, $F4, $FD, $40, $F4, $FD, $80, $F4, $FD, $C0, $F4, $FF

LA651:  .byte $24, $08, $14, $FD, $02, $FC, $04, $F0, $D8, $D9, $E8, $E9, $F8, $FF

LA65F:  .byte $24, $14, $0C, $FD, $02, $FC, $F4, $F8, $DA, $FE, $C9, $FF

LA66B:  .byte $24, $20, $04, $FD, $02, $FC, $EC, $00, $CB, $CC, $DB, $DC, $FF

LA678:  .byte $24, $18, $14, $FD, $02, $FC, $F4, $10, $DD, $CE, $FE, $DE, $FE, $DD, $FF

LA687:  .byte $24, $08, $0C, $FD, $02, $FC, $0C, $10, $CD, $FF

LA691:  .byte $21, $00, $00, $FE, $F5, $F5, $F5, $F5, $F5, $F5, $FF

LA69C:  .byte $30, $00, $00, $FD, $03, $ED, $FF

LA6A3:  .byte $05, $04, $08, $FD, $00, $00, $00, $00, $FF

LA6AC:  .byte $3A, $08, $08, $FD, $03, $EF, $FD, $43, $EF, $FD, $83, $EF, $FD, $C3, $EF, $FF

LA6BC:  .byte $3A, $08, $08, $FD, $03, $DF, $FD, $43, $DF, $FD, $83, $DF, $FD, $C3, $DF, $FF

LA6CC:  .byte $2A, $08, $08, $FD, $03, $CF, $FD, $43, $CF, $FD, $83, $CF, $FD, $C3, $CF, $FF

LA6DC:  .byte $01, $00, $00, $FF

LA6E0:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA6EE:
    .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
    .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA708:  .byte $0C, $08, $04, $14, $24, $FF

LA70E:  .byte $00, $04, $04, $8A, $FF

LA713:  .byte $00, $04, $04, $8A, $FF

;-----------------------------------------[ Palette data ]-------------------------------------------

.include "tourian/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include "tourian/room_ptrs.asm"

StrctPtrTbl:
.include "tourian/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "tourian/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "tourian/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "tourian/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

MacroDefs:
.include "tourian/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

;There are 3 control bytes associated with the music data and the rest are musical note indexes.
;If the byte has the binary format 1011xxxx ($Bx), then the byte is an index into the corresponding
;musical notes table and is used to set the note length until it is set by another note length
;byte. The lower 4 bits are the index into the note length table. Another control byte is the loop
;and counter btye. The loop and counter byte has the format 11xxxxxx. Bits 0 thru 6 contain the
;number of times to loop.  The third control byte is #$FF. This control byte marks the end of a loop
;and decrements the loop counter. If #$00 is found in the music data, the music has reached the end.
;A #$00 in any of the different music channel data segments will mark the end of the music. The
;remaining bytes are indexes into the MusicNotesTbl and should only be even numbers as there are 2
;bytes of data per musical note.

.include "songs/escape.asm"

.include "songs/mthr_brn_room.asm"

;Unused tile patterns.
    .byte $2B, $3B, $1B, $5A, $D0, $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0
    .byte $2C, $23, $20, $20, $30, $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30
    .byte $1F, $80, $C0, $C0, $60, $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00 
    .byte $01, $00, $00, $00, $00, $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80
    .byte $C4, $A5, $45, $0B, $1B, $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04
    .byte $E6, $E6, $C4, $8E, $1C, $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00 

;-----------------------------------------[ Sound engine ]-------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_03_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
