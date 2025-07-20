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
;Disassembled using TRaCER.
;Can be reassembled using asm6f

;Common area code (shared between banks)

;-----------------------------------------[ Start of code ]------------------------------------------

; These first three all jump to different points within the same procedure
CommonJump_00: ;$8000 (yes anim, yes common AI)
    jmp LF410
CommonJump_01: ;$8003 (yes anim, no common AI)
    jmp LF438
CommonJump_02: ;$8006 (no anim, no common AI)
    jmp LF416
CommonJump_CrawlerAIRoutine_ShouldCrawlerMove: ;$8009
    jmp CrawlerAIRoutine_ShouldCrawlerMove
CommonJump_UpdateEnemyAnim: ;$800C
    jmp UpdateEnemyAnim             ;($E094)
CommonJump_InitEnAnimIndex: ;$800F
    jmp InitEnAnimIndex
CommonJump_GetEnemyTypeTimes2PlusFacingDirectionBit0: ;$8012 (unused?)
    jmp GetEnemyTypeTimes2PlusFacingDirectionBit0
CommonJump_InitEnemyData0DAndHealth: ;$8015 (unused?)
    jmp InitEnemyData0DAndHealth
CommonJump_InitEnResetAnimIndex: ;$8018 (unused?)
    jmp InitEnResetAnimIndex
CommonJump_EnemyFlipAfterDisplacement: ;$801B
    jmp EnemyFlipAfterDisplacement
CommonJump_0A: ;$801E
    jmp LFBCA
CommonJump_SpawnFireball: ;$8021
    jmp SpawnFireball
CommonJump_ChooseRoutine: ;$8024
    jmp ChooseRoutine               ;($C27C)
CommonJump_ApplySpeedToPosition: ;$8027
    jmp ApplySpeedToPosition
CommonJump_0E: ;$802A
    jmp LEB6E
CommonJump_EnemyGetDeltaY: ;$802D
    jmp EnemyGetDeltaY
CommonJump_EnemyGetDeltaX: ;$8030
    jmp EnemyGetDeltaX
CommonJump_EnemyBGCollideOrApplySpeed: ;$8033
    jmp EnemyBGCollideOrApplySpeed
CommonJump_EnemyGetDeltaY_UsingAcceleration: ;$8036
    jmp EnemyGetDeltaY_UsingAcceleration
CommonJump_EnemyGetDeltaX_UsingAcceleration: ;$8039
    jmp EnemyGetDeltaX_UsingAcceleration
CommonJump_DrawEnemy: ;$803C
    jmp DrawEnemy
CommonJump_DrawTileBlast: ;$803F
    jmp DrawTileBlast
CommonJump_SubtractHealth: ;$8042
    jmp SubtractHealth              ;($CE92)
CommonJump_Base10Subtract: ;$8045
    jmp Base10Subtract              ;($C3FB)

; Crawler jump table
CrawlerMovementRoutinesTable:
    .word EnemyMoveOnePixelRight-1
    .word EnemyMoveOnePixelLeft-1
    .word EnemyMoveOnePixelDown-1
    .word EnemyMoveOnePixelDown-1
    .word EnemyMoveOnePixelLeft-1
    .word EnemyMoveOnePixelRight-1
    .word EnemyMoveOnePixelUp-1
    .word EnemyMoveOnePixelUp-1

;-------------------------------------------------------------------------------
; A common enemy AI/movement routine
; called by F410 in the engine, via CommonJump_00
CommonEnemyAI:
    ; Set x to point to enemy
    ldx PageIndex
    
    ; Exit if bit 6 of EnData05 is set
    lda EnData05,x
    asl
    bmi @RTS
    
    ; Exit if enemy is not active
    lda EnStatus,x
    cmp #enemyStatus_Active
    bne @RTS

    ; load delta y into a
    jsr EnemyGetDeltaY
    lda $00
    bpl @endIf_Up
        ; save absolute delta y into EnemyMovePixelQty
        jsr TwosComplement ; flip negative to positive
        sta EnemyMovePixelQty

        ; move one pixel upwards EnemyMovePixelQty times
        @loop_Up:
            jsr EnemyMoveOnePixelUp ; attempt to move one pixel
            jsr EnemyIfMoveFailedUp ; end loop if attempt failed
            dec EnemyMovePixelQty
            bne @loop_Up
    @endIf_Up:
    beq @endIf_Down
        ; save absolute delta y into EnemyMovePixelQty
        sta EnemyMovePixelQty

        ; move one pixel downwards EnemyMovePixelQty times
        @loop_Down:
            jsr EnemyMoveOnePixelDown ; attempt to move one pixel
            jsr EnemyIfMoveFailedDown ; end loop if attempt failed
            dec EnemyMovePixelQty
            bne @loop_Down
    @endIf_Down:
    
    ; load delta x into a
    jsr EnemyGetDeltaX
    lda $00
    bpl @endIf_Left
        ; save absolute delta x into EnemyMovePixelQty
        jsr TwosComplement ; flip negative to positive
        sta EnemyMovePixelQty

        ; move one pixel to the left EnemyMovePixelQty times
        @loop_Left:
            jsr EnemyMoveOnePixelLeft ; attempt to move one pixel
            jsr EnemyIfMoveFailedLeft ; end loop if attempt failed
            dec EnemyMovePixelQty
            bne @loop_Left
    @endIf_Left:
    beq @endIf_Right
        ; save absolute delta x into EnemyMovePixelQty
        sta EnemyMovePixelQty

        ; move one pixel to the right EnemyMovePixelQty times
        @loop_Right:
            jsr EnemyMoveOnePixelRight ; attempt to move one pixel
            jsr EnemyIfMoveFailedRight ; end loop if attempt failed
            dec EnemyMovePixelQty
            bne @loop_Right
    @endIf_Right:

@RTS:
    rts

;-------------------------------------------------------------------------------
; A = TableAtL977B[EnemyType]*2
LoadTableAt977B: ; L80B0
    ldy EnType,x
    lda L977B,y
    asl                             ;*2
    rts

;-------------------------------------------------------------------------------
; Up movement related ?
EnemyIfMoveFailedUp:
    ldx PageIndex
    bcs RTS_80FA ; If EnemyMoveOnePixelUp returned the carry flag, exit
; Otherwise, do stuff, and make sure it doesn't move anymore pixels the rest of this frame
    lda EnData05,x
    bpl L80C7

L80C1:
    jsr EnemyIfMoveFailedVertical81FC
    jmp L80F6

L80C7:
    jsr LoadTableAt977B
    bpl L80EA
    lda EnData1F,x
    beq L80C1

    bpl L80D8
    jsr SetBit5OfEnData05_AndClearEnAccelY
    beq L80E2

L80D8:
    sec
    ror EnSpeedY,x
    ror EnSpeedSubPixelY,x
    jmp L80F6

L80E2:
    sta EnSpeedY,x
    sta EnSpeedSubPixelY,x
    beq L80F6

L80EA:
    lda L977B,y
    lsr
    lsr
    bcc L80F6
    lda #$04
    jsr XorEnData05

L80F6:
    lda #$01
    sta EnemyMovePixelQty

RTS_80FA:
    rts
;-------------------------------------------------------------------------------
; Down movement related?
EnemyIfMoveFailedDown:
    ldx PageIndex
    bcs RTS_8133
    lda EnData05,x
    bpl L810A
L8104:
    jsr EnemyIfMoveFailedVertical81FC
    jmp L812F
L810A:
    jsr LoadTableAt977B
    bpl L8123
    lda EnData1F,x
    beq L8104
    bpl L8120
    clc
    ror EnSpeedY,x
    ror EnSpeedSubPixelY,x
    jmp L812F

L8120:
    jsr SetBit5OfEnData05_AndClearEnAccelY
L8123:
    lda L977B,y
    lsr
    lsr
    bcc L812F
    lda #$04
    jsr XorEnData05

L812F:
    lda #$01
    sta EnemyMovePixelQty
RTS_8133:
    rts

;-------------------------------------------------------------------------------
; Right movement related ?
EnemyIfMoveFailedRight:
    ldx PageIndex
    bcs RTS_816D

    jsr LoadTableAt977B
    bpl L815E
    lda EnData05,x
    bmi L8148
L8142:
    jsr EnemyIfMoveFailedHorizontal81FC
    jmp L8169
L8148:
    lda EnData1F,x
    beq L8142
    bpl L8159
    clc
    ror EnSpeedX,x
    ror EnSpeedSubPixelX,x
    jmp L8169

L8159:
    jsr SetBit5OfEnData05_AndClearEnAccelX
    beq L8169
L815E:
    lda L977B,y
    lsr
    bcc L8169
    lda #$01
    jsr XorEnData05

L8169:
    lda #$01
    sta EnemyMovePixelQty

RTS_816D:
    rts

;-------------------------------------------------------------------------------
; Left Movement related?
EnemyIfMoveFailedLeft:
    ldx PageIndex
    bcs RTS_81B0
    jsr LoadTableAt977B
    bpl L81A0
    lda EnData05,x
    bmi L8182
L817C:
    jsr EnemyIfMoveFailedHorizontal81FC
    jmp L81AC
L8182:
    lda EnData1F,x
    beq L817C
    bpl L818E
        jsr SetBit5OfEnData05_AndClearEnAccelX
        beq L8198
    L818E:
    sec
    ror EnSpeedX,x
    ror EnSpeedSubPixelX,x
    jmp L81AC

L8198:
    sta EnSpeedX,x
    sta EnSpeedSubPixelX,x
    beq L81AC
L81A0:
    jsr LoadTableAt977B
    lsr
    lsr
    bcc L81AC
    lda #$01
    jsr XorEnData05

L81AC:
    lda #$01
    sta EnemyMovePixelQty
RTS_81B0:
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnAccelY:
    jsr SetBit5OfEnData05
    sta EnAccelY,x
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05:
    lda #$20
    jsr OrEnData05
    lda #$00
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnAccelX:
    jsr SetBit5OfEnData05
    sta EnAccelX,x
    rts

;-------------------------------------------------------------------------------
; Horizontal Movement Related
EnemyIfMoveFailedHorizontal81FC:
    ; exit if bit 5 of L968B is set
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    
    ; flip facing direction on the x axis
    lda #$01
    jsr XorEnData05
L81D1: ;referenced in bank 7
    ; negate acceleration
    lda EnAccelX,x
    jsr TwosComplement
    sta EnAccelX,x

L81DA: ;referenced in bank 7
    ; exit if bit 5 of L968B is set
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    
    ; branch if uses movement strings
    jsr LoadTableAt977B
    sec
    bpl L81ED
        ; enemy uses acceleration
        ; Negate sub-pixel speed
        lda #$00
        sbc EnSpeedSubPixelX,x
        sta EnSpeedSubPixelX,x
    L81ED:
    ; Negate speed
    lda #$00
    sbc EnSpeedX,x
    sta EnSpeedX,x

RTS_81F5:
    rts

;-------------------------------------------------------------------------------
LoadBit5ofTableAt968B:
    jsr ReadTableAt968B
    and #$20
    rts

;-------------------------------------------------------------------------------
; Vertical Movement Related
EnemyIfMoveFailedVertical81FC:
     ; Exit if bit 5 is set
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    
    ; flip facing direction on the y axis
    lda #$04
    jsr XorEnData05
L8206: ;referenced in bank 7
    ; negate acceleration
    lda EnAccelY,x
    jsr TwosComplement
    sta EnAccelY,x
    
L820F: ;referenced in bank 7
    ; Exit if bit 5 is set
    jsr LoadBit5ofTableAt968B
    bne RTS_822A
    
    ; branch if uses movement strings
    jsr LoadTableAt977B
    sec
    bpl L8222
        ; enemy uses acceleration
        ; Negate sub-pixel speed
        lda #$00
        sbc EnSpeedSubPixelY,x
        sta EnSpeedSubPixelY,x
    L8222:
    ; Negate speed
    lda #$00
    sbc EnSpeedY,x
    sta EnSpeedY,x
RTS_822A:
    rts

;-------------------------------------------------------------------------------
; Loads a pointer from this table to $81 and $82
LoadEnemyMovementPtr:
    lda EnData05,x
    bpl L8232
        lsr
        lsr
    L8232:
    lsr
    lda EnMovementIndex,x
    rol
    asl
    tay
    lda EnemyMovementPtrs,y
    sta EnemyMovementPtr
    lda EnemyMovementPtrs+1,y
    sta EnemyMovementPtr+1.b
    rts

;-------------------------------------------------------------------------------
; Determines and returns delta y for a given frame in $00
EnemyGetDeltaY:
    ; jump if enemy uses acceleration to move itself
    jsr LoadTableAt977B
    bpl L824C
        jmp EnemyGetDeltaY_UsingAcceleration
    L824C:

    ; enemy uses movement strings to move itself
    lda EnData05,x
    and #$20
    eor #$20
    beq L82A2

    jsr LoadEnemyMovementPtr ; Puts a pointer at $81
L8258:
    ldy EnMovementInstrIndex,x
EnemyGetDeltaY_ReadByte:
    lda (EnemyMovementPtr),y

;CommonCase
; Branch if the value is <$F0
    cmp #$F0
    bcc EnemyGetDeltaY_CommonCase

;CaseFA
    cmp #$FA
    beq EnemyGetDeltaY_JumpToCaseFA

;CaseFB
    cmp #$FB
    beq EnemyGetDeltaY_CaseFB

;CaseFC
    cmp #$FC
    beq EnemyGetDeltaY_CaseFC

;CaseFD
    cmp #$FD
    beq EnemyGetDeltaY_CaseFD

;CaseFE
    cmp #$FE
    beq EnemyGetDeltaY_CaseFE

;Default case (see this as CaseFF)
; Reset enemy counter
    lda #$00
    sta EnMovementInstrIndex,x
    beq L8258

;---------------------------------------
EnemyGetDeltaY_JumpToCaseFA: ; L827C
    jmp EnemyGetDeltaY_CaseFA

;---------------------------------------
EnemyGetDeltaY_CommonCase:
; Take the value from memory
; Branch ahead if velocityString[EnMovementInstrIndex] - EnDelay != 0
    sec
    sbc EnDelay,x
    bne L8290

    sta EnDelay,x
; EnMovementInstrIndex += 2
    iny
    iny
    tya
    sta EnMovementInstrIndex,x
    bne EnemyGetDeltaY_ReadByte ; Handle another byte

; Increment EnDelay
L8290:
    inc EnDelay,x

; Read the sign/magnitude of the speed from the next byte
    iny
    lda (EnemyMovementPtr),y

EnemyGetDeltaY_8296: ;referenced in bank 7
; Save the sign bit to the carry flag
    asl
    php
; Get the magnitude
    jsr Adiv32                      ;($C2BE)Divide by 32.
; Negate the magnitude if necessary
    plp
    bcc L82A2
    eor #$FF
    adc #$00 ; Since carry is set in this branch, this increments A
; Store this frame's delta y in temp
L82A2:
    sta $00
    rts

;---------------------------------------
; Clear EnJumpDsplcmnt, move on to next byte in the stream
EnemyGetDeltaY_CaseFD:
    inc EnMovementInstrIndex,x
    iny
    lda #$00
    sta EnJumpDsplcmnt,x
    beq EnemyGetDeltaY_ReadByte ; Branch always

;---------------------------------------
; Don't move, and don't advance the movement counter
; HALT, perhaps?
EnemyGetDeltaY_CaseFB:
; Double RTS !?
    pla
    pla
    rts
; Retruns back to F416 in the engine bank

;---------------------------------------
; Repeat Previous Movement Until Vertical Movement Fails
EnemyGetDeltaY_CaseFC:
    ; If bit 7 of EnData1F is set, then check if you can move up and then jump ahead
    lda EnData1F,x
    bpl L82BE
        jsr EnemyCheckMoveUp
        jmp L82C3
    L82BE:
        ; If EnData1F is non-zero, check if you can move down and then jump ahead
        beq L82D2
        jsr EnemyCheckMoveDown
    L82C3:
    ; branch if movement check succeeded
    ldx PageIndex
    bcs L82D2
    ; movement check failed, move on to the next byte
    ldy EnMovementInstrIndex,x
    iny
    lda #$00
    sta EnData1F,x
    beq L82D7 ; Branch always

L82D2:
    ; movement check succeeded
    ; repeat the previous two bytes
    ldy EnMovementInstrIndex,x
    dey
    dey

; Save EnMovementInstrIndex
L82D7:
    tya
    sta EnMovementInstrIndex,x
; Read the next bytes
    jmp EnemyGetDeltaY_ReadByte

;---------------------------------------
; Repeat previous until ???
EnemyGetDeltaY_CaseFE:
    ; Move EnMovementInstrIndex back to the previous movement instruction
    dey
    dey
    tya
    sta EnMovementInstrIndex,x
    ; Then do some other stuff
    lda EnData1F,x
    bpl L82EF
        jsr EnemyCheckMoveUp
        jmp L82F4
    L82EF:
        beq L82FB
        jsr EnemyCheckMoveDown
    L82F4:
    ; branch if movement check failed
    ldx PageIndex
    bcc L82FB
    ; movement check succeeded
    ; run previous movement instruction
    jmp L8258

L82FB:
    ; movement check failed
    ; branch if bit 5 of L968B entry is unset
    ldy EnType,x
    lda L968B,y
    and #$20
    beq EnemyGetDeltaY_CaseFA
        ; toggle facing direction bits
        lda EnData05,x
        eor #$05
        ; or with bits 0-4 of L968B entry
        ora L968B,y
        and #$1F
        ; save to EnData05
        ; (this clears bits 6 and 7, -->
        ;  bit 5 is set by the routine call that follows)
        sta EnData05,x
        ; fallthrough
;---------------------------------------
;SetBit5OfEnData05_AndClearEnAccelY
; Move horizontally indefinitely (???)
; Used only at the end of seahorse's movement string
EnemyGetDeltaY_CaseFA:
    jsr SetBit5OfEnData05_AndClearEnAccelY
    jmp L82A2 ; Set delta-y to zero and exit

;-------------------------------------------------------------------------------
; Horizontal Movement Related?
EnemyGetDeltaX:
    ; jump if enemy uses acceleration to move itself
    jsr LoadTableAt977B
    bpl L8320
        jmp EnemyGetDeltaX_UsingAcceleration
    L8320:
    
    ; enemy uses movement strings to move itself
    ; If bit 5 of EnData05 is clear, don't move horizontally
    lda EnData05,x
    and #$20
    eor #$20
    beq L833C

; Read the same velocity byte as in EnemyGetDeltaY
    ldy EnMovementInstrIndex,x
    iny
    lda (EnemyMovementPtr),y ; $81/$82 were loaded during EnemyGetDeltaY earlier
EnemyGetDeltaX_832F:
    tax
; Save the sign bit to the processor flags
    and #$08
    php
    txa
; Get the lower three bits
    and #$07
    plp
; Negate, according to the sign bit
    beq L833C
    jsr TwosComplement

L833C:
    sta $00
    rts

;-------------------------------------------------------------------------------
; apply acceleration to speed and return delta y for enemy
EnemyGetDeltaY_UsingAcceleration:
    ; default max speed at 14 px/f
    ldy #$0E
    ; branch if enemy is accelerating to the left
    lda EnAccelY,x
    bmi @else_A
        ; enemy is accelerating to the right
        ; add acceleration to speed
        clc
        adc EnSpeedSubPixelY,x
        sta EnSpeedSubPixelY,x
        lda EnSpeedY,x
        adc #$00
        sta EnSpeedY,x
        ; branch if speed is positive
        bpl @endIf_B

        ; common to both branches of if/else_A
        @if_B:
            ; enemy speed is negative
            ; negate speed in a to get absolute speed
            jsr TwosComplement
            ; negate max speed in y
            ldy #$F2
            bne @endIf_B ; branch always

    @else_A:
        ; enemy is accelerating to the left
        ; subtract absolute acceleration from speed
        jsr TwosComplement
        sec
        sta $00
        lda EnSpeedSubPixelY,x
        sbc $00
        sta EnSpeedSubPixelY,x
        lda EnSpeedY,x
        sbc #$00
        sta EnSpeedY,x
        ; branch if speed is negative
        bmi @if_B
    
    @endIf_B:
@endIf_A:
    ; branch if absolute speed is below absolute max
    cmp #$0E
    bcc @endIf_C
        ; speed is at or above max
        ; cap speed at max
        lda #$00
        sta EnSpeedSubPixelY,x
        tya
        sta EnSpeedY,x
    @endIf_C:

    ; apply sub-pixel speed to sub-pixel position
    lda EnSubPixelY,x
    clc
    adc EnSpeedSubPixelY,x
    sta EnSubPixelY,x
    ; $00 stores temp copy of current delta y.
    lda #$00
    adc EnSpeedY,x
    sta $00
    rts

;-------------------------------------------------------------------------------
; apply acceleration to speed and return delta x for enemy
; copy-pasted from HorzAccelerate for samus
EnemyGetDeltaX_UsingAcceleration:
    ; store max speed sub-pixels to temp
    lda #$00
    sta $00
    sta $02
    ; store max speed pixels to temp
    lda #$0E
    sta $01
    sta $03

    ; apply x acceleration to x speed
    ; and save x speed in $04 and y
    lda EnSpeedSubPixelX,x
    clc
    adc EnAccelX,x
    sta EnSpeedSubPixelX,x
    sta $04
    lda #$00
    ldy EnAccelX,x
    bpl L83B6 ;Branch if enemy accelerating to the right.
        lda #$FF
    L83B6:
    adc EnSpeedX,x
    sta EnSpeedX,x
    tay
    ;Branch if enemy is moving to the right.
    bpl L83D0
        ; enemy is moving left
        ; store negative x speed in $04 and y
        lda #$00
        sec
        sbc EnSpeedSubPixelX,x
        sta $04
        lda #$00
        sbc EnSpeedX,x
        tay
        ; negate max speed in temp $00-$01
        jsr NegateTemp00Temp01
    L83D0:
    ;$04 and y now contain absolute x speed
    ;temp $00-$01 now contain signed max x speed
    ;temp $02-$03 now contain absolute max x speed

    ; branch if absolute x speed is less than than absolute max x speed
    lda $04
    cmp $02
    tya
    sbc $03
    bcc L83E3
        ; absolute x speed is greater than than absolute max x speed
        ; cap signed x speed to signed max x speed
        lda $00
        sta EnSpeedSubPixelX,x
        lda $01
        sta EnSpeedX,x
    L83E3:

    ; apply sub-pixel speed to sub-pixel position
    lda EnSubPixelX,x
    clc
    adc EnSpeedSubPixelX,x
    sta EnSubPixelX,x
    ;$00 stores temp copy of current delta x.
    lda #$00
    adc EnSpeedX,x
    sta $00
    rts

;-------------------------------------------------------------------------------
; Up movement related
; Move one pixel?
EnemyMoveOnePixelUp:
    ldx PageIndex
    lda EnY,x
    sec
    sbc EnRadY,x
    and #$07
    sec
    bne L8406
        jsr EnemyCheckMoveUp
    L8406:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_844A
    inc $00
    ldy EnY,x
    bne L8429
    ldy #$F0
    lda ScrollDir
    cmp #$02
    bcs L8429
    lda ScrollY
    beq RTS_844A
    jsr GetOtherNameTableIndex
    beq RTS_844A
    jsr SwitchEnemyNameTable
L8429:
    dey
    tya
    sta EnY,x
    cmp EnRadY,x
    bne L8441

    lda ScrollY
    beq L843C
        jsr GetOtherNameTableIndex
        bne L8441
    L843C:
    inc EnY,x
    clc
    rts
L8441:
    lda EnData05,x
    bmi L8449
        inc EnJumpDsplcmnt,x
    L8449:
    sec
RTS_844A:
    rts

;-------------------------------------------------------------------------------
; Down movement related ?
EnemyMoveOnePixelDown:
    ldx PageIndex
    lda EnY,x
    clc
    adc EnRadY,x
    and #$07
    sec
    bne L845C
        jsr EnemyCheckMoveDown
    L845C:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_84A6
    inc $00
    ldy EnY,x
    cpy #$EF
    bne L8481
    ldy #$FF
    lda ScrollDir
    cmp #$02
    bcs L8481
    lda ScrollY
    beq RTS_84A6
    jsr GetOtherNameTableIndex
    bne RTS_84A6
    jsr SwitchEnemyNameTable
L8481:
    iny
    tya
    sta EnY,x
    clc
    adc EnRadY,x
    cmp #$EF
    bne L849D
    lda ScrollY
    beq L8497
        jsr GetOtherNameTableIndex
        beq L849D
    L8497:
    dec EnY,x
    clc
    bcc RTS_84A6
L849D:
    lda EnData05,x
    bmi L84A5
        dec EnJumpDsplcmnt,x
    L84A5:
    sec
RTS_84A6:
    rts

;-------------------------------------------------------------------------------
; Left movement related
EnemyMoveOnePixelLeft:
    ldx PageIndex
    lda EnX,x
    sec
    sbc EnRadX,x
    and #$07
    sec
    bne L84B8
        jsr EnemyCheckMoveLeft
    L84B8:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_84FD
    inc $00
    ldy EnX,x
    bne L84DA
    lda ScrollDir
    cmp #$02
    bcc L84DA
    lda ScrollX
    beq L84D4
        jsr GetOtherNameTableIndex
    L84D4:
    clc
    beq RTS_84FD
    jsr SwitchEnemyNameTable
L84DA:
    dec EnX,x
    lda EnX,x
    cmp EnRadX,x
    bne L84F4
    lda ScrollX
    beq L84EE
        jsr GetOtherNameTableIndex
        bne L84F4
    L84EE:
    inc EnX,x
    clc
    bcc RTS_84FD
L84F4:
    lda EnData05,x
    bpl L84FC
        inc EnJumpDsplcmnt,x
    L84FC:
    sec
RTS_84FD:
    rts

;-------------------------------------------------------------------------------
; Right movement related
EnemyMoveOnePixelRight:
    ldx PageIndex
; if ((xpos + xrad) % 8) == 0, then EnemyCheckMoveRight()
    lda EnX,x
    clc
    adc EnRadX,x
    and #$07
    sec
    bne L850F
        jsr EnemyCheckMoveRight
    L850F:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_8559
    inc $00
    inc EnX,x
    bne L8536
    lda ScrollDir
    cmp #$02
    bcc L8536
    lda ScrollX
    beq L852D
        jsr GetOtherNameTableIndex
        beq L8533
    L852D:
        dec EnX,x
        clc
        bcc RTS_8559
    L8533:
    jsr SwitchEnemyNameTable

L8536:
    lda EnX,x
    clc
    adc EnRadX,x
    cmp #$FF
    bne L8550
    lda ScrollX
    beq L854A
        jsr GetOtherNameTableIndex
        beq L8550
    L854A:
    dec EnX,x
    clc
    bcc RTS_8559

L8550:
    lda EnData05,x
    bpl L8558
        dec EnJumpDsplcmnt,x
    L8558:
    sec
RTS_8559:
    rts

;-------------------------------------------------------------------------------
SwitchEnemyNameTable: ; L855A
    lda EnHi,x
    eor #$01
    sta EnHi,x
    rts

;-------------------------------------------------------------------------------
; Returns the index to the other nametable in A
GetOtherNameTableIndex: ; L8562
    lda EnHi,x
    eor PPUCTRL_ZP
    and #$01
    rts

;-------------------------------------------------------------------------------
; XORs the contents of EnData05 with the bitmask in A
XorEnData05: ; L856B
    eor EnData05,x
    sta EnData05,x
    rts

;---------------------------------[ Object animation data tables ]----------------------------------
;----------------------------[ Sprite drawing pointer tables ]--------------------------------------
;------------------------------[ Sprite placement data tables ]-------------------------------------
;-------------------------------[ Sprite frame data tables ]---------------------------------------
.include "common_sprite_data.asm"

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
    lda DoorEntryStatus                  ;The code determines if Samus has entered a door if the-->
    bne RTS_8B6C                    ;door status is 0, but door data information has been-->
    ldy SamusDoorData               ;written. If both conditions are met, Samus has just-->
    beq RTS_8B6C                    ;entered a door.
    sta MissilePickupQtyCur         ;
    sta EnergyPickupQtyCur          ;Reset current missile and energy power-up counters.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly recalculate max missile pickups(16 max, 0 min).
    sta MissilePickupQtyMax         ;
    asl                             ;
    ora #$40                        ;*2 for energy pickups and set bit 6(128 max, 64 min).
    sta EnergyPickupQtyMax          ;
    lda PPUCTRL_ZP                  ;
    eor #$01                        ;
    and #$01                        ;Erase name table door data for new room.
    tay                             ;
    lsr                             ;
    sta DoorOnNameTable3,y          ;
    lda ScrollDir                   ;
    and #$02                        ;Is Samus scrolling horizontally?-->
    bne L8B4B                       ;If so, branch.
        ldx #$04                        ;Samus currently scrolling vertically.
        lda ScrollY                     ;Is room centered on screen?-->
        beq L8B6D                       ;If so, branch.
        lda PPUCTRL_ZP                  ;
        eor ObjHi                       ;Get inverse of Samus' current nametable.
        lsr                             ;
        bcc SetDoorEntryInfo            ;If Samus is on nametable 3, branch.
        bcs L8B52                       ;If Samus is on nametable 0, branch to decrement x.

    L8B4B:
        ldx #$02                        ;Samus is currently scrolling horizontally.
        lda ObjX                        ;Is Samus entering a left hand door?-->
        bpl SetDoorEntryInfo            ;If so, branch.
    L8B52:
    dex                             ;

SetDoorEntryInfo:
    txa                             ;X contains door scroll status and is transferred to A.
    sta DoorScrollStatus            ;Save door scroll status.
    jsr SamusInDoor                 ;($8B74)Indicate Samus just entered a door.
    lda #$12                        ;
    sta DoorDelay                   ;Set DoorDelay to 18 frames(going into door).
    lda SamusDoorData               ;
    jsr Amul16                      ;($C2C5)*16. Move scroll toggle data to upper 4 bits.
    ora ObjAction                   ;Keep Samus action so she will appear the same comming-->
    sta SamusDoorData               ;out of the door as she did going in.
    lda #$05                        ;
    sta ObjAction                   ;Indicate Samus is in a door.
RTS_8B6C:
    rts

L8B6D:
    jsr SetDoorEntryInfo            ;($8B53)Save Samus action and set door entry timer.
    jsr VerticalRoomCentered        ;($E21B)Room is centered. Toggle scroll.

    txa                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
    ora #$80                        ;Set MSB of DoorEntryStatus to indicate Samus has just-->
    sta DoorEntryStatus                  ;entered a door.
    rts

;----------------------------------------------------------------------------------------------------
UpdateAllDoors:
    ldx #$B0
    L8B7B:
        jsr UpdateDoor
        lda PageIndex
        sec
        sbc #$10
        tax
        bmi L8B7B
    rts

UpdateDoor:
    stx PageIndex
    lda DoorStatus,x
    jsr ChooseRoutine
        .word ExitSub                   ; no door
        .word UpdateDoor_Init           ; init
        .word UpdateDoor_Closed         ; closed
        .word UpdateDoor_Open           ; open
        .word UpdateDoor_LetSamusIn     ; letting samus in
        .word UpdateDoor_Scroll         ; scrolling
        .word UpdateDoor_LetSamusOut    ; letting samus out

UpdateDoor_Init:
    ; increment door status to "closed"
    inc DoorStatus,x
    ; set door animation to closed
    lda #ObjAnim_DoorClose_Reset - ObjectAnimIndexTbl.b
    jsr InitObjAnimIndex           ;($D2FA)
    ; write solid bg tiles to make door tangible
    jsr WriteDoorBGTiles_Solid
    ; init door hit points based on door type
    ldy DoorType,x
    lda DoorHitPointTable,y
    sta DoorHitPoints,x
DrawDoor:
    ; load door type into A
    lda DoorType,x
    ; blue door that changes the music should be drawn the same as a regular blue door
    cmp #$03
    bne L8BBA
        lda #$01
    L8BBA:
    ; use door type to write to ObjectCntrl
    ora #$80 | OAMDATA_PRIORITY.b
    sta ObjectCntrl

    lda #$00
    sta DoorIsHit,x
    ; use door slot number to determine whether to h-flip the door
    txa
    and #$10
    eor #$10
    ora ObjectCntrl
    sta ObjectCntrl
    ; draw door
    lda #$06 ; move to next door animation frame every 6 frames
    jmp AnimDrawObject

DoorHitPointTable:
    .byte $05 ; red door
    .byte $01 ; blue door
    .byte $0A ; 10-missile door
    .byte $01 ; blue door that changes the music

UpdateDoor_Closed:
    ; branch if door was not hit
    lda DoorIsHit,x
    and #$04
    beq DrawDoor
    ; door was hit, decrease hp
    dec DoorHitPoints,x
    ; branch if door is still alive
    bne DrawDoor

    ; door has succumbed to its wounds, it will now open
    ; check if its a blue door that changes music
    lda #$03
    cmp DoorType,x
    bne L8BEE
        ; it is a blue door that changes music
        ; branch if escape timer is active (not #$FF)
        ; this prevents the right door in mother brain's room from opening during the escape
        ldy EndTimer+1
        iny
        bne DrawDoor
    L8BEE:
    ; increment door status to "open"
    ; a is #$03 here
    sta DoorStatus,x
    ; set re-close delay to 80 * 2 frames
    lda #$50
    sta DoorHitPoints,x
    ; set door animation to opening the door
    ; and play sound effect
    ; (BUG! there is no call to DrawDoor, so the door isn't drawn on this frame)
    lda #ObjAnim_DoorOpen_Reset - ObjectAnimIndexTbl.b
    sta DoorAnimResetIndex,x
    sec
    sbc #ObjAnim_DoorOpen_Reset - ObjAnim_DoorOpen.b
    jmp DoorSubRoutine8C7E

UpdateDoor_Open:
    ; branch if samus is not entering a door
    lda DoorEntryStatus
    beq L8C1D
    ; branch if samus is not in the same nametable as the door
    lda ObjHi
    eor DoorHi,x
    lsr
    bcs L8C1D
    ; branch if samus is not in the same left/right half of the nametable as the door
    lda ObjX
    eor DoorX,x
    bmi L8C1D
    ; increment door status to "letting samus in"
    lda #$04
    sta DoorStatus,x
    bne GotoDrawDoor
L8C1D:
    ; branch if animation of opening the door has not completed
    lda DoorAnimIndex,x
    cmp DoorAnimResetIndex,x
    bcc GotoDrawDoor
    ; branch if this is not the first frame the door is fully open
    lda DoorHitPoints,x
    cmp #$50
    bne L8C57
    ; this is the first frame the door is fully open
    ; write air tiles to allow samus to go through the door
    jsr WriteDoorBGTiles_Air
    ; branch if door is a blue door
    lda DoorType,x
    cmp #$01
    beq L8C57
    cmp #$03
    beq L8C57
    ; door is not a blue door, so it is a missile door
    ; save that the missile door was opened in the UniqueItemHistory
    lda #$0A
    sta Temp09_ItemType
    lda DoorHi,x
    sta Temp08_ItemHi
    ldy SamusMapPosX
    txa
    jsr Amul16
    bcc L8C4C
        dey
    L8C4C:
    tya
    jsr MapScrollRoutine
    ; remove door completely (cannot close again)
    lda #$00
    sta DoorStatus,x
    beq GotoDrawDoor
L8C57:
    ; door is a blue door
    ; decrement re-close delay every 2 frames
    lda FrameCount
    lsr
    bcs GotoDrawDoor
    dec DoorHitPoints,x
    ; branch if delay is not zero
    bne GotoDrawDoor
DoorSubRoutine8C61:
    ; re-close delay is zero, time to close the door
    ; set door hit points to 1
    lda #$01
    sta DoorHitPoints,x
    ; write solid collision so that samus cannot go through the door anymore
    jsr WriteDoorBGTiles_Solid
    ; set door status back to "closed"
    lda #$02
    sta DoorStatus,x
    ; set door animation to closing the door
    jsr DoorSubRoutine8C76
DoorSubRoutine8C71:
    ldx PageIndex
GotoDrawDoor:
    jmp DrawDoor

DoorSubRoutine8C76:
    lda #ObjAnim_DoorClose_Reset - ObjectAnimIndexTbl.b
    sta DoorAnimResetIndex,x
    sec
    sbc #ObjAnim_DoorClose_Reset - ObjAnim_DoorClose.b
DoorSubRoutine8C7E:
    jsr SetObjAnimIndex
    jmp SFX_Door

UpdateDoor_LetSamusIn:
    ; branch if scrolling has not started
    lda DoorEntryStatus
    cmp #$05
    bcs L8CC3
    ; scrolling has started
    ; write solid collision
    jsr WriteDoorBGTiles_Solid
    ; set door animation to closing the door
    jsr DoorSubRoutine8C76
    ; branch if we are not in a palette change room
    ldx PageIndex
    lda DoorPalChangeDir
    beq L8CA7
    ; branch if door is on the same wall as the one you entered the room with
    txa
    jsr Adiv16
    eor DoorPalChangeDir
    lsr
    bcc L8CA7
    ; change the palette
    lda PalToggle
    eor #(_id_Palette00+1)~(_id_Palette05+1).b
    sta PalToggle
    sta PalDataPending
L8CA7:
    ; increment door status to "scroll"
    inc DoorStatus,x
    ; clear DoorPalChangeDir
    lda #$00
    sta DoorPalChangeDir
    ; branch if door isnt a blue door that changes the music
    lda DoorType,x
    cmp #$03
    bne L8CC3
    ; change to a specific music track depending on the direction the door faces
    txa
    jsr Amul16
    bcs L8CC0
        ; the door leads to a room to the right
        ; play tourian music
        jsr TourianMusic
        bne L8CC3 ; branch always
    L8CC0:
        ; the door leads to a room to the left
        ; play mother brain music
        jsr MotherBrainMusic
L8CC3:
    ; draw door
    jmp DoorSubRoutine8C71

UpdateDoor_Scroll:
    ; branch if scrolling has not ended
    lda DoorEntryStatus
    cmp #$05
    bne Goto2DrawDoor
    ; scrolling has ended
    ; get door slot of the door attached to this one
    txa
    eor #$10
    tax
    ; set that door's status to "letting samus out"
    lda #$06
    sta DoorStatus,x
    ; set that door's animation to opening the door
    lda #ObjAnim_DoorOpen_Reset - ObjectAnimIndexTbl.b
    sta DoorAnimResetIndex,x
    sec
    sbc #ObjAnim_DoorOpen_Reset - ObjAnim_DoorOpen.b
    jsr SetObjAnimIndex
    ; play door sfx
    jsr SFX_Door
    ; update samus's palette (probably so that she doesn't remain blue when going in a door with a metroid on her head)
    jsr SelectSamusPal
    ; set the current door's status to "closed"
    ldx PageIndex
    lda #$02
    sta DoorStatus,x
Goto2DrawDoor:
    jmp DrawDoor

UpdateDoor_LetSamusOut:
    ; branch if samus didnt finish exiting the door
    lda DoorEntryStatus
    bne Goto2DrawDoor
    ; samus finished exiting
    ; close the door
    jmp DoorSubRoutine8C61

WriteDoorBGTiles_Air:
    lda #$FF ; air blank tile
    bne WriteDoorBGTiles_Common ; branch always
WriteDoorBGTiles_Solid:
    lda #$4E ; solid blank tile
WriteDoorBGTiles_Common:
    ; get cart ram pointer of door
    pha
    ; door y coordinate
    lda #$50
    sta $02
    ; door x coordinate (depends on bit 4 of object slot address)
    txa
    jsr Adiv16
    and #$01
    tay
    lda DoorXTable,y
    sta $03
    ; door nametable
    lda ObjHi,x
    sta $0B
    ; call
    jsr MakeCartRAMPtr
    ldy #$00 ; init y for loop
    pla
    ; cart ram pointer of door is now in $04-$05
    ; write 6 air or solid blank tiles in a vertical line to cart ram
    @loop:
        sta ($04),y
        tax
        tya
        clc
        adc #$20
        tay
        txa
        cpy #$20*6
        bne @loop
    ldx PageIndex
    txa
    jsr Adiv8
    and #$06
    tay
    lda $04
    sta DoorCartRAMPtr,y
    lda $05
    sta DoorCartRAMPtr+1,y
    rts

; x coordinate of door's background tiles in pixels
DoorXTable:
    .byte $E8, $10

.byte $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9
.byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
.byte $85, $00, $AD, $97, $69, $29

; EoF
