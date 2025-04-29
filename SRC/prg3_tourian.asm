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

.export GFX_KraidSprites
.export GFX_RidleySprites
.export GotoLA320
.export GotoClearAllMetroidLatches
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

GFX_KraidSprites:
    .incbin "kraid/sprite_tiles.chr" ; 8D60 - Kraid Sprite CHR
GFX_RidleySprites:
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
    jmp LA320
GotoClearAllMetroidLatches:
    jmp ClearAllMetroidLatches
GotoL9C6F:
    jmp L9C6F
GotoCannonRoutine:
    jmp CannonRoutine
GotoMotherBrainRoutine:
    jmp MotherBrainRoutine
GotoZebetiteRoutine:
    jmp ZebetiteRoutine
GotoRinkaSpawnerRoutine:
    jmp RinkaSpawnerRoutine
GotoLA0C6:
    jmp LA0C6
GotoLA142:
    jmp LA142

AreaRoutine:
    jmp L9B25                       ;Area specific routine.

TwosComplement_:
    eor #$FF                        ;
    clc                             ;The following routine returns the twos-->
    adc #$01                        ;complement of the value stored in A.
Exit__:
    rts                             ;

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
    lda EnDataIndex,x
    jsr CommonJump_ChooseRoutine
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
    lda #$00
    sta EnStatus,x
    rts

CommonEnemyJump_00_01_02:
    lda $81
    cmp #$01
    beq L97F1
    cmp #$03
    beq L97F6
        lda $00
        jmp CommonJump_00
    L97F1:
        lda $01
        jmp CommonJump_01
    L97F6:
        jmp CommonJump_02

;-------------------------------------------------------------------------------
; Metroid Routine
.include "enemies/metroid.asm"

;-------------------------------------------------------------------------------
; ???
L9A27:
    lda #$01
    jmp CommonJump_01

;-------------------------------------------------------------------------------
; Rinka Routine??
.include "enemies/rinka.asm"

;-------------------------------------------------------------------------------
; Tourian specific routine -- called every active frame
L9B25:
    jsr L9B37
    jsr MotherBrainStatusHandler
    jsr LA1E7
    jsr LA238
    jsr LA28B
    jmp LA15E

;-------------------------------------------------------------------------------
L9B37:
    ldx #$78
    L9B39:
        jsr L9B44
        lda $97
        sec
        sbc #$08
        tax
        bne L9B39

L9B44:
    stx $97
    ldy $6BF4,x
    bne L9B4C
RTS_9B4B:
    rts

L9B4C:
    jsr L9C4D
    tya
    bne RTS_9B4B
    ldy $010B
    iny
    bne L9B65
    lda $6BF8,x
    cmp #$05
    beq RTS_9B4B
    jsr L9B70
    jmp L9C2B

L9B65:
    lda $2D
    and #$02
    bne RTS_9B4B
    lda #$19
    jmp L9C31

L9B70:
    ldy $6BF8,x
    lda $6BFA,x
    bne L9B81
        lda L9D8F,y
        sta $6BFA,x
        inc $6BFB,x
    L9B81:
    dec $6BFA,x
L9B84:
    lda L9D94,y
    clc
    adc $6BFB,x
    tay
    lda L9D99,y
    bpl L9BAB
        cmp #$FF
        bne L9B9F
            ldy $6BF8,x
            lda #$00
            sta $6BFB,x
            beq L9B84
        L9B9F:
        inc $6BFB,x
        jsr L9BAF
        ldy $6BF8,x
        jmp L9B84

    L9BAB:
        sta $6BF9,x
        rts

L9BAF:
    pha
    lda MotherBrainStatus
    cmp #$04
    bcs L9BC6
    ldy #$60
    L9BB8:
        lda EnStatus,y
        beq L9BC8
        tya
        clc
        adc #$10
        tay
        cmp #$A0
        bne L9BB8
L9BC6:
    pla
    rts

L9BC8:
    sty PageIndex
    lda $6BF5,x
    sta EnYRoomPos,y
    lda $6BF6,x
    sta EnXRoomPos,y
    lda $6BF7,x
    sta EnNameTable,y
    lda #$02
    sta EnStatus,y
    lda #$00
    sta $0409,y
    sta EnAnimDelay,y
    sta $0408,y
    pla
    jsr TwosComplement_
    tax
    sta $040A,y
    ora #$02
    sta $0405,y
    lda L9C28-2,x
    sta EnResetAnimIndex,y
    sta EnAnimIndex,y
    lda L9DCC,x
    sta $05
    lda L9DCF,x
    sta $04
    ldx $97
    lda $6BF5,x
    sta $08
    lda $6BF6,x
    sta $09
    lda $6BF7,x
    sta $0B
    tya
    tax
    jsr CommonJump_0D
    jsr MetroidSaveResultsOfCommonJump_0D
    ldx $97
    rts

L9C28:  .byte $0C, $0A, $0E

L9C2B:
    ldy $6BF9,x
    lda L9DC6,y
L9C31:
    sta $6BD7
    lda $6BF5,x
    sta $04E0
    lda $6BF6,x
    sta $04E1
    lda $6BF7,x
    sta $6BDB
    lda #$E0
    sta PageIndex
    jmp CommonJump_14

L9C4D:
    ldy #$00
    lda $6BF6,x
    cmp $FD
    lda $49
    and #$02
    bne L9C5F
        lda $6BF5,x
        cmp $FC
    L9C5F:
    lda $6BF7,x
    eor $FF
    and #$01
    beq L9C6B
        bcs L9C6D
        sec
    L9C6B:
    bcs RTS_9C6E
L9C6D:
    iny
RTS_9C6E:
    rts

;-------------------------------------------------------------------------------
L9C6F:
    sty $02
    ldy #$00
    L9C73:
        lda $6BF7,y
        eor $02
        lsr
        bcs L9C80
            lda #$00
            sta $6BF4,y
        L9C80:
        tya
        clc
        adc #$08
        tay
        bpl L9C73
    ldx #$00
    L9C89:
        lda $0758,x
        beq L9C99
        jsr L9D64
        eor $075A,x
        bne L9C99
        sta $0758,x
    L9C99:
        txa
        clc
        adc #$08
        tax
        cmp #$28
        bne L9C89
    ldx #$00
    jsr L9CD6
    ldx #$03
    jsr L9CD6
    lda MotherBrainStatus
    beq L9CC3
    cmp #$07
    beq L9CC3
    cmp #$0A
    beq L9CC3
    lda $9D
    eor $02
    lsr
    bcs L9CC3
    lda #$00
    sta MotherBrainStatus
L9CC3:
    lda $010D
    beq RTS_9CD5
    lda $010C
    eor $02
    lsr
    bcs RTS_9CD5
    lda #$00
    sta $010D
RTS_9CD5:
    rts

L9CD6:
    lda $8B,x
    bmi RTS_9CE5
    lda $8C,x
    eor $02
    lsr
    bcs RTS_9CE5
    lda #$FF
    sta $8B,x
RTS_9CE5:
    rts

;-------------------------------------------------------------------------------
; Tourian Cannon Handler
CannonRoutine:
    ldx #$00
    L9CE8:
        lda $6BF4,x
        beq L9CF6
        txa
        clc
        adc #$08
        tax
        bpl L9CE8
    bmi RTS_9D20
L9CF6:
    lda ($00),y
    jsr Adiv16_
    sta $6BF8,x
    lda #$01
    sta $6BF4,x
    sta $6BFB,x
    iny
    lda ($00),y
    pha
    and #$F0
    ora #$07
    sta $6BF5,x
    pla
    jsr Amul16_
    ora #$07
    sta $6BF6,x
    jsr L9D88
    sta $6BF7,x
RTS_9D20:
    rts

;-------------------------------------------------------------------------------
; Mother Brain Handler
MotherBrainRoutine:
    lda #$01
    sta MotherBrainStatus
    jsr L9D88
    sta $9D
    eor #$01
    tax
    lda L9D3C
    ora $6C,x
    sta $6C,x
    lda #$20
    sta $9A
    sta $9B
    rts

L9D3B:  .byte $02
L9D3C:  .byte $01

;-------------------------------------------------------------------------------
; Zebetite Handler
ZebetiteRoutine:
    lda ($00),y
    and #$F0
    lsr
    tax
    asl
    and #$10
    eor #$10
    ora #$84
    sta $0759,x
    jsr L9D64
    sta $075A,x
    lda #$01
    sta $0758,x
    lda #$00
    sta $075B,x
    sta $075C,x
    sta $075D,x
    rts

L9D64:
    jsr L9D88
    asl
    asl
    ora #$61
    rts

;-------------------------------------------------------------------------------
; Rinka Handler
RinkaSpawnerRoutine:
    ldx #$03
    jsr L9D75
        bmi RTS_9D87
        ldx #$00
    L9D75:
    lda $8B,x
    bpl RTS_9D87
    lda ($00),y
    jsr Adiv16_
    sta $8B,x
    jsr L9D88
    sta $8C,x
    lda #$FF
RTS_9D87:
    rts

L9D88:
    lda $FF
    eor $49
    and #$01
    rts

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
    lda MotherBrainStatus
    beq RTS_9DF1
    jsr CommonJump_ChooseRoutine
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
RTS_9DF1:
    rts

;-------------------------------------------------------------------------------
L9DF2:
    lda ObjectHi
    eor $9D
    bne RTS_9DF1
    lda ObjectX
    sec
    sbc #$48
    cmp #$2F
    bcs RTS_9DF1
    lda ObjectY
    sec
    sbc #$80
    bpl L9E0E
        jsr TwosComplement_
    L9E0E:
    cmp #$20
    bcs RTS_9DF1
    lda #$00
    sta $6E
    lda #$02
    sta $6F
    lda #$38
    sta SamusHit
    jmp CommonJump_SubtractHealth

;-------------------------------------------------------------------------------
L9E22:
    jsr L9DF2
    jsr L9FED
    jsr LA01B
    jsr LA02E
L9E2E:
    jsr LA041
L9E31:
    lda #$00
    sta $9E
    rts

;-------------------------------------------------------------------------------
L9E36:
    jsr L9E43
    lda L9E41,y
    sta $1C
    jmp L9E31

L9E41:  .byte $08, $07

L9E43:
    dec $9F
    bne L9E4B
        lda #$01
        sta MotherBrainStatus
    L9E4B:
    lda $9F
    and #$02
    lsr
    tay
    rts

;-------------------------------------------------------------------------------
L9E52:  JSR L9E43
    lda L9E41,y
    sta $1C
    tya
    asl
    asl
    sta $FC
    ldy MotherBrainStatus
    dey
    bne L9E83
    sty MotherBrainHits
    tya
    tax
    L9E68:
        tya
        sta EnStatus,x
        jsr L9EF9
        cpx #$C0
        bne L9E68
    lda #$04
    sta MotherBrainStatus
    lda #$28
    sta $9F
    lda $0680
    ora #$01
    sta $0680
L9E83:
    jmp L9E2E

;-------------------------------------------------------------------------------
L9E86:
    lda #$10
    ora $0680
    sta $0680
    jsr LA072
    inc $9A
    jsr L9E43
    ldx #$00
    L9E98:
        lda EnStatus,x
        cmp #$05
        bne L9EA4
            lda #$00
            sta EnStatus,x
        L9EA4:
        jsr L9EF9
        cmp #$40
        bne L9E98
    lda $07A0
    bne L9EB5
        lda L9F00,y
        sta $1C
    L9EB5:
    ldy MotherBrainStatus
    dey
    bne RTS_9ED5
    sty $9A
    lda #$04
    sta MotherBrainStatus
    lda #$1C
    sta $9F
    ldy MotherBrainHits
    inc MotherBrainHits
    cpy #$04
    beq L9ED3
        ldx #$00
        bcc RTS_9ED5
        jmp L9ED6

    L9ED3:
    lsr $9F
RTS_9ED5:
    rts

L9ED6:
    lda $0685
    ora #$04
    sta $0685
    lda #$05
    sta MotherBrainStatus
    lda #$80
    sta MotherBrainHits
    rts

L9EE7:
    pha
    and #$F0
    ora #$07
    sta EnYRoomPos,x
    pla
    jsr Amul16_
    ora #$07
    sta EnXRoomPos,x
    rts

L9EF9:
    txa
    clc
    adc #$10
    tax
    rts

L9EFF: .byte $60
L9F00: ORA #$0A

;-------------------------------------------------------------------------------
L9F02:
    lda MotherBrainHits
    bmi L9F33
        cmp #$08
        beq L9F36
        tay
        lda L9F41,y
        sta $0503
        lda L9F39,y
        clc
        adc #$42
        sta $0508
        php
        lda $9D
        asl
        asl
        plp
        adc #$61
        sta $0509
        lda #$00
        sta PageIndex
        lda $07A0
        bne RTS_9F38
        jsr CommonJump_15
        bcs RTS_9F38
    L9F33:
    inc MotherBrainHits
    rts

L9F36:
    inc MotherBrainStatus
RTS_9F38:
    rts

L9F39:  .byte $00, $40, $08, $48, $80, $C0, $88, $C8
L9F41:  .byte $08, $02, $09, $03, $0A, $04, $0B, $05

L9F49:
    jsr L9F69
    bcs RTS_9F64
    lda #$00
    sta MotherBrainStatus
    lda #$99
    sta $010A
    sta $010B
    lda #$01
    sta $010D
    lda $9D
    sta $010C
RTS_9F64:
    rts

L9F65:  .byte $80, $B0, $A0, $90

L9F69:
    lda $50
    clc
    adc $4F
    sec
    rol
    and #$03
    tay
    ldx L9F65,y
    lda #$01
    sta SamusJumpDsplcmnt,x
    lda #$01
    sta SamusOnElevator,x
    lda #$03
    sta ObjAction,x
    lda $9D
    sta ObjectHi,x
    lda #$10
    sta ObjectX,x
    lda #$68
    sta ObjectY,x
    lda #$55
    sta AnimResetIndex,x
    sta AnimIndex,x
    lda #$00
    sta AnimDelay,x
    lda #$F7
    sta AnimFrame,x
    lda #$10
    sta $0503
    lda #$40
    sta $0508
    lda $9D
    asl
    asl
    ora #$61
    sta $0509
    lda #$00
    sta PageIndex
    jmp CommonJump_15

;-------------------------------------------------------------------------------
L9FC0:
    lda #$10
    ora NoiseSFXFlag
    sta NoiseSFXFlag
    lda Timer3
    bne RTS_9FD9
    lda #$08
    sta ObjAction
    lda #$0A
    sta MotherBrainStatus
    lda #$01
    sta PalDataPending
RTS_9FD9:
    rts

;-------------------------------------------------------------------------------
L9FDA:
    jsr L9F69
    bcs RTS_9FEC
    lda $9D
    sta $010C
    ldy #$01
    sty $010D
    dey
    sty MotherBrainStatus
RTS_9FEC:
    rts

;-------------------------------------------------------------------------------
L9FED:
    lda $9E
    beq RTS_A01A
    lda $0684
    ora #$02
    sta $0684
    inc MotherBrainHits
    lda MotherBrainHits
    cmp #$20
    ldy #$02
    lda #$10
    bcc LA016
    ldx #$00
    LA007:
        lda #$00
        sta TileRoutine,x
        jsr L9EF9
        cmp #$D0
        bne LA007
    iny
    lda #$80
LA016:
    sty MotherBrainStatus
    sta $9F
RTS_A01A:
    rts

;-------------------------------------------------------------------------------
LA01B:
    dec $9A
    bne RTS_A02D
    lda $2E
    and #$03
    sta $9C
    lda #$20
    sec
    sbc MotherBrainHits
    lsr
    sta $9A
RTS_A02D:
    rts

;-------------------------------------------------------------------------------
LA02E:
    dec $9B
    lda $9B
    asl
    bne RTS_A040
    lda #$20
    sec
    sbc MotherBrainHits
    ora #$80
    eor $9B
    sta $9B
RTS_A040:
    rts

;-------------------------------------------------------------------------------
LA041:
    lda #$E0
    sta PageIndex
    lda $9D
    sta $6BDB
    lda #$70
    sta EnYRoomPos+$E0
    lda #$48
    sta EnXRoomPos+$E0
    ldy $9C
    lda LA06D,y
    sta EnAnimFrame+$E0
    jsr CommonJump_14
    lda $9B
    bmi RTS_A06C
    lda LA06D+4
    sta EnAnimFrame+$E0
    jsr CommonJump_14
RTS_A06C:
    rts

LA06D:  .byte $13, $14, $15, $16, $17

LA072:
    ldy MotherBrainHits
    beq RTS_A086
    lda LA0C0,y
    clc
    adc $9A
    tay
    lda LA0A3,y
    cmp #$FF
    bne LA087
    dec $9A
RTS_A086:
    rts

LA087:
    adc #$44
    sta TileWRAMLo
    php
    lda $9D
    asl
    asl
    ora #$61
    plp
    adc #$00
    sta TileWRAMHi
    lda #$00
    sta TileAnimFrame
    sta PageIndex
    jmp CommonJump_15

LA0A3:  .byte $00, $02, $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27
LA0B3:  .byte $FF, $82, $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86
LA0C0:  .byte $FF, $00, $0C
LA0C3:  .byte $11, $16, $1A

;-------------------------------------------------------------------------------
LA0C6:
    lda $71
    beq LA13E
    ldx PageIndex
    lda $0300,x
    cmp #$0B
    bne LA13E
    cpy #$98
    bne LA103
        ldx #$00
    LA0D9:
        lda TileRoutine,x
        beq LA0E7
            jsr L9EF9
            cmp #$D0
            bne LA0D9
            beq LA13E
        LA0E7:
        lda #$8C
        sta TileWRAMLo,x
        lda $05
        sta TileWRAMHi,x
        lda #$01
        sta TileAnimFrame,x
        lda PageIndex
        pha
        stx PageIndex
        jsr CommonJump_15
        pla
        sta PageIndex
        bne LA13E
    LA103:
    lda $04
    lsr
    bcc LA10A
        dec $04
    LA10A:
    ldy #$00
    lda ($04),y
    lsr
    bcs LA13E
    cmp #$48
    bcc LA13E
    cmp #$4C
    bcs LA13E
    LA119:
        lda $0758,y
        beq LA12E
        lda $04
        and #$9E
        cmp $0759,y
        bne LA12E
        lda $05
        cmp $075A,y
        beq LA139
    LA12E:
        tya
        clc
        adc #$08
        tay
        cmp #$28
        bne LA119
    beq LA13E
LA139:
    lda #$01
    sta $075D,y
LA13E:
    pla
    pla
    clc
    rts

;-------------------------------------------------------------------------------
LA142:
    tay
    lda $71
    beq LA15C
    ldx PageIndex
    lda ObjAction,x
    cmp #$0B
    bne LA15C
    cpy #$5E
    bcc LA15C
    cpy #$72
    bcs LA15C
    lda #$01
    sta $9E
LA15C:
    tya
RTS_A15D:
    rts

;-------------------------------------------------------------------------------
LA15E:
    ldy EndTimerHi
    iny
    bne RTS_A1DA
    ldy #$03
    jsr LA16B
        ldy #$00
    LA16B:
    sty PageIndex
    lda $8B,y
    bmi RTS_A15D
    lda $8C,y
    eor FrameCount
    lsr
    bcc RTS_A15D
    lda MotherBrainStatus
    cmp #$04
    bcs RTS_A15D
    lda $2D
    and #$06
    bne RTS_A15D
    ldx #$20
    LA188:
        lda EnStatus,x
        beq LA19C
        lda EnData05,x
        and #$02
        beq LA19C
        txa
        sec
        sbc #$10
        tax
        bpl LA188
    rts

LA19C:
    lda #$01
    sta EnStatus,x
    lda #$04
    sta EnDataIndex,x
    lda #$00
    sta EnSpecialAttribs,x
    sta EnData04,x
    jsr CommonJump_0E
    lda #$F7
    sta EnAnimFrame,x
    ldy PageIndex
    lda $8C,y
    sta EnNameTable,x
    lda $8D,y
    asl
    ora $8B,y
    tay
    lda LA1DB,y
    jsr L9EE7
    ldx PageIndex
    inc $8D,x
    lda $8D,x
    cmp #$06
    bne RTS_A1DA
    lda #$00
LA1D8:
    sta $8D,x
RTS_A1DA:
    rts

LA1DB:  .byte $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA, $BA, $BA

;-------------------------------------------------------------------------------
LA1E7:
    ldy EndTimerHi
    iny
    beq RTS_A237
    lda EndTimerLo
    sta $03
    lda #$01
    sec
    jsr CommonJump_Base10Subtract
    sta EndTimerLo
    lda EndTimerHi
    sta $03
    lda #$00
    jsr CommonJump_Base10Subtract
    sta EndTimerHi
    lda $2D
    and #$1F
    bne LA216
        lda SQ1SFXFlag
        ora #$08
        sta SQ1SFXFlag
    LA216:
    lda EndTimerLo
    ora EndTimerHi
    bne RTS_A237
    dec EndTimerHi
    sta MotherBrainHits
    lda #$07
    sta MotherBrainStatus
    lda NoiseSFXFlag
    ora #$01
    sta NoiseSFXFlag
    lda #$0C
    sta Timer3
    lda #$0B
    sta PalDataPending
RTS_A237:
    rts

;-------------------------------------------------------------------------------
LA238:
    lda $010D
    beq RTS_A28A
    lda $010C
    sta EnNameTable+$E0
    lda #$84
    sta EnYRoomPos+$E0
    lda #$64
    sta EnXRoomPos+$E0
    lda #$1A
    sta EnAnimFrame+$E0
    lda #$E0
    sta PageIndex
    lda SpritePagePos
    pha
    jsr CommonJump_14
    pla
    cmp SpritePagePos
    beq RTS_A28A
    tax
    lda EndTimerHi
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+$01,x
    lda EndTimerHi
    and #$0F
    ora #$A0
    sta SpriteRAM+$05,x
    lda EndTimerLo
    lsr
    lsr
    lsr
    sec
    ror
    and #$0F
    ora #$A0
    sta SpriteRAM+$09,x
RTS_A28A:
    rts

;-------------------------------------------------------------------------------
LA28B:
    lda #$10
    sta PageIndex
    ldx #$20
    LA291:
        jsr LA29B
        txa
        sec
        sbc #$08
        tax
        bne LA291
LA29B:
    lda $0758,x
    and #$0F
    cmp #$01
    bne RTS_A28A
    lda $075D,x
    beq LA2F2
    inc $075B,x
    lda $075B,x
    lsr
    bcs LA2F2
    tay
    sbc #$03
    bne LA2BA
    inc $0758,x
LA2BA:
    lda LA310,y
    sta $0513
    lda $0759,x
    sta $0518
    lda $075A,x
    sta $0519
    lda PPUStrIndex
    bne LA2DA
        txa
        pha
        jsr CommonJump_15
        pla
        tax
        bcc LA2EB
    LA2DA:
    lda $0758,x
    and #$80
    ora #$01
    sta $0758,x
    sta $075D,x
    dec $075B,x
    rts

LA2EB:
    lda #$40
    sta $075C,x
    bne LA30A
LA2F2:
    ldy $075B,x
    beq LA30A
    dec $075C,x
    bne LA30A
    lda #$40
    sta $075C,x
    dey
    tya
    sta $075B,x
    lsr
    tay
    bcc LA2BA
LA30A:
    lda #$00
    sta $075D,x
    rts

LA310:  .byte $0C, $0D, $0E, $0F, $07

; Samus no longer has a metroid on her
ClearAllMetroidLatches:
    ldy #$05
    LA317:
        jsr ClearMetroidLatch
        dey
        bpl LA317
    sta $92
    rts
;-----------------
LA320:
    txa
    jsr Adiv16_
    tay
    jsr ClearMetroidLatch
    sta $92
    rts

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

.include "tourian/room_ptrs.asm"

.include "tourian/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "tourian/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "tourian/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "tourian/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "tourian/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

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
