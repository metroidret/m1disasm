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
CommonJump_UpdateEnemyCommon: ;$8000
    jmp UpdateEnemyCommon
CommonJump_UpdateEnemyCommon_noMove: ;$8003
    jmp UpdateEnemyCommon@noMove
CommonJump_UpdateEnemyCommon_noMoveNoAnim: ;$8006
    jmp UpdateEnemyCommon@noMoveNoAnim
CommonJump_CrawlerAIRoutine_ShouldCrawlerMove: ;$8009
    jmp CrawlerAIRoutine_ShouldCrawlerMove
CommonJump_UpdateEnemyAnim: ;$800C
    jmp UpdateEnemyAnim             ;($E094)
CommonJump_InitEnAnimIndex: ;$800F
    jmp InitEnAnimIndex
CommonJump_GetEnemyTypeTimes2PlusFacingDirectionBit0: ;$8012 (unused?)
    jmp GetEnemyTypeTimes2PlusFacingDirectionBit0
CommonJump_InitEnemyForceSpeedTowardsSamusDelayAndHealth: ;$8015 (unused?)
    jmp InitEnemyForceSpeedTowardsSamusDelayAndHealth
CommonJump_InitEnResetAnimIndex: ;$8018 (unused?)
    jmp InitEnResetAnimIndex
CommonJump_EnemyFlipAfterDisplacement: ;$801B
    jmp EnemyFlipAfterDisplacement
CommonJump_InitEnActiveAnimIndex_NoL967BOffset: ;$801E
    jmp InitEnActiveAnimIndex_NoL967BOffset
CommonJump_SpawnEnProjectile: ;$8021
    jmp SpawnEnProjectile
CommonJump_JumpEngine: ;$8024
    jmp JumpEngine               ;($C27C)
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
; called by F410 in the engine, via CommonJump_UpdateEnemyCommon
EnemyMove:
    ; Set x to point to enemy
    ldx PageIndex
    
    ; Exit if bit 6 of Ens.0.data05 is set
    lda Ens.0.data05,x
    asl
    bmi @RTS
    
    ; Exit if enemy is not active
    lda EnsExtra.0.status,x
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
    ldy EnsExtra.0.type,x
    lda L977B,y
    asl                             ;*2
    rts

;-------------------------------------------------------------------------------
; Up movement related ?
EnemyIfMoveFailedUp:
    ldx PageIndex
    bcs RTS_80FA ; If EnemyMoveOnePixelUp returned the carry flag, exit
; Otherwise, do stuff, and make sure it doesn't move anymore pixels the rest of this frame
    ; branch if enemy faces in a horizontal direction
    lda Ens.0.data05,x
    bpl L80C7

L80C1:
    ; enemy faces in a vertical direction or data1F == 0
    jsr EnemyIfMoveFailedVertical_Bounce
    jmp L80F6

L80C7:
    ; enemy faces in a horizontal direction
    ; branch if enemy uses movement strings
    jsr LoadTableAt977B
    bpl L80EA
    ; enemy uses acceleration
    ; check data1F
    lda EnsExtra.0.data1F,x
    beq L80C1

    bpl L80D8
    ; data1F >= #$80
    ; trigger resting period and clear Y accel and speed
    jsr EnemyTriggerRestingPeriod_AndClearEnAccelY
    beq L80E2 ; branch always

L80D8:
    ; data1F == #$40
    ; half Y speed and make it upwards
    sec
    ror Ens.0.speedY,x
    ror Ens.0.speedSubPixelY,x
    jmp L80F6

L80E2:
    ; zero Y speed
    sta Ens.0.speedY,x
    sta Ens.0.speedSubPixelY,x
    beq L80F6 ; branch always

L80EA:
    ; enemy uses movement strings
    ; branch if bit 1 of L977B is clear
    lda L977B,y
    lsr
    lsr
    bcc L80F6
    ; flip vertical direction
    lda #$04
    jsr XorEnData05

L80F6:
    ; abort loop
    lda #$01
    sta EnemyMovePixelQty

RTS_80FA:
    rts
;-------------------------------------------------------------------------------
; Down movement related?
EnemyIfMoveFailedDown:
    ldx PageIndex
    bcs RTS_8133
    ; branch if enemy faces in a horizontal direction
    lda Ens.0.data05,x
    bpl L810A
L8104:
    ; enemy faces in a vertical direction or data1F == 0
    jsr EnemyIfMoveFailedVertical_Bounce
    jmp L812F
L810A:
    ; enemy faces in a horizontal direction
    ; branch if enemy uses movement strings
    jsr LoadTableAt977B
    bpl L8123
    ; enemy uses acceleration
    ; check data1F
    lda EnsExtra.0.data1F,x
    beq L8104
    bpl L8120
    ; data1F >= #$80
    ; half Y speed and make it downwards
    clc
    ror Ens.0.speedY,x
    ror Ens.0.speedSubPixelY,x
    jmp L812F

L8120:
    ; data1F == #$40
    ; trigger resting period
    jsr EnemyTriggerRestingPeriod_AndClearEnAccelY
L8123:
    ; enemy uses movement strings
    ; branch if bit 1 of L977B is clear
    lda L977B,y
    lsr
    lsr
    bcc L812F
    ; flip vertical direction
    lda #$04
    jsr XorEnData05

L812F:
    ; abort loop
    lda #$01
    sta EnemyMovePixelQty
RTS_8133:
    rts

;-------------------------------------------------------------------------------
; Right movement related ?
EnemyIfMoveFailedRight:
    ldx PageIndex
    bcs RTS_816D

    ; branch if enemy uses movement strings
    jsr LoadTableAt977B
    bpl L815E
    ; enemy uses acceleration
    ; branch if enemy faces in a vertical direction
    lda Ens.0.data05,x
    bmi L8148
L8142:
    ; enemy faces in a horizontal direction or data1F == 0
    jsr EnemyIfMoveFailedHorizontal_Bounce
    jmp L8169
L8148:
    ; enemy faces in a vertical direction
    ; check data1F
    lda EnsExtra.0.data1F,x
    beq L8142
    bpl L8159
    ; data1F >= #$80
    ; half X speed and make it rightwards
    clc
    ror Ens.0.speedX,x
    ror Ens.0.speedSubPixelX,x
    jmp L8169

L8159:
    ; data1F == #$40
    ; trigger resting period
    jsr EnemyTriggerRestingPeriod_AndClearEnAccelX
    beq L8169 ; branch always
L815E:
    ; enemy uses movement strings
    ; branch if bit 0 of L977B is clear
    lda L977B,y
    lsr
    bcc L8169
    ; flip horizontal direction
    lda #$01
    jsr XorEnData05

L8169:
    ; abort loop
    lda #$01
    sta EnemyMovePixelQty

RTS_816D:
    rts

;-------------------------------------------------------------------------------
; Left Movement related?
EnemyIfMoveFailedLeft:
    ldx PageIndex
    bcs RTS_81B0

    ; branch if enemy uses movement strings
    jsr LoadTableAt977B
    bpl L81A0
    ; enemy uses acceleration
    ; branch if enemy faces in a vertical direction
    lda Ens.0.data05,x
    bmi L8182
L817C:
    ; enemy faces in a horizontal direction or data1F == 0
    jsr EnemyIfMoveFailedHorizontal_Bounce
    jmp L81AC
L8182:
    ; enemy faces in a vertical direction
    ; check data1F
    lda EnsExtra.0.data1F,x
    beq L817C
    bpl L818E
        ; data1F >= #$80
        ; trigger resting period and clear X speed
        jsr EnemyTriggerRestingPeriod_AndClearEnAccelX
        beq L8198 ; branch always
    L818E:
    ; data1F == #$40
    ; half X speed and make it leftwards
    sec
    ror Ens.0.speedX,x
    ror Ens.0.speedSubPixelX,x
    jmp L81AC

L8198:
    ; zero X speed
    sta Ens.0.speedX,x
    sta Ens.0.speedSubPixelX,x
    beq L81AC
L81A0:
    ; enemy uses movement strings
    ; branch if bit 1 of L977B is clear
    ; 2 lsr's to compensate for the asl in LoadTableAt977B
    jsr LoadTableAt977B
    lsr
    lsr
    bcc L81AC
    ; flip horizontal direction
    lda #$01
    jsr XorEnData05

L81AC:
    ; abort loop
    lda #$01
    sta EnemyMovePixelQty
RTS_81B0:
    rts

;-------------------------------------------------------------------------------
EnemyTriggerRestingPeriod_AndClearEnAccelY:
    jsr EnemyTriggerRestingPeriod
    sta EnsExtra.0.accelY,x
    rts

;-------------------------------------------------------------------------------
EnemyTriggerRestingPeriod:
    lda #$20
    jsr OrEnData05
    lda #$00
    rts

;-------------------------------------------------------------------------------
EnemyTriggerRestingPeriod_AndClearEnAccelX:
    jsr EnemyTriggerRestingPeriod
    sta EnsExtra.0.accelX,x
    rts

;-------------------------------------------------------------------------------
; Horizontal Movement Related
EnemyIfMoveFailedHorizontal_Bounce:
    ; exit if bit 5 of L968B is set
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    
    ; flip facing direction on the x axis
    lda #$01
    jsr XorEnData05
L81D1: ;referenced in bank 7
    ; negate acceleration
    lda EnsExtra.0.accelX,x
    jsr TwosComplement
    sta EnsExtra.0.accelX,x

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
        sbc Ens.0.speedSubPixelX,x
        sta Ens.0.speedSubPixelX,x
    L81ED:
    ; Negate speed
    lda #$00
    sbc Ens.0.speedX,x
    sta Ens.0.speedX,x

RTS_81F5:
    rts

;-------------------------------------------------------------------------------
LoadBit5ofTableAt968B:
    jsr ReadTableAt968B
    and #$20
    rts

;-------------------------------------------------------------------------------
; Vertical Movement Related
EnemyIfMoveFailedVertical_Bounce:
     ; Exit if bit 5 is set
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    
    ; flip facing direction on the y axis
    lda #$04
    jsr XorEnData05
L8206: ;referenced in bank 7
    ; negate acceleration
    lda EnsExtra.0.accelY,x
    jsr TwosComplement
    sta EnsExtra.0.accelY,x
    
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
        sbc Ens.0.speedSubPixelY,x
        sta Ens.0.speedSubPixelY,x
    L8222:
    ; Negate speed
    lda #$00
    sbc Ens.0.speedY,x
    sta Ens.0.speedY,x
RTS_822A:
    rts

;-------------------------------------------------------------------------------
; Loads a pointer from this table to $81 and $82
LoadEnemyMovementPtr:
    ; use horizontal facing direction if bit 7 of Ens.0.data05 is not set
    lda Ens.0.data05,x
    bpl L8232
        ; use vertical facing direction if bit 7 of Ens.0.data05 is set
        lsr
        lsr
    L8232:
    ; put facing direction bit into carry
    lsr
    ; y = ((Ens.0.movementIndex) * 2 + (facing direction)) * 2
    lda Ens.0.movementIndex,x
    rol
    asl
    tay
    ; load pointer from table
    lda EnemyMovementPtrs,y
    sta EnemyMovementPtr
    lda EnemyMovementPtrs+1,y
    sta EnemyMovementPtr+1
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
    ; exit if enemy is triggering a resting period
    lda Ens.0.data05,x
    and #$20
    eor #$20
    beq L82A2

    ; enemy is not triggering a resting period
    ; load movement string pointer into EnemyMovementPtr
    jsr LoadEnemyMovementPtr
L8258:
    ; read instruction at current index into string
    ldy Ens.0.movementInstrIndex,x
EnemyGetDeltaY_ReadByte:
    lda (EnemyMovementPtr),y

;CommonCase
; Branch if the value is <$F0
    cmp #$F0
    bcc EnemyGetDeltaY_SignMagSpeed

;CaseFA
    cmp #$FA
    beq GotoEnemyGetDeltaY_StopMovementSeahorse

;CaseFB
    cmp #$FB
    beq EnemyGetDeltaY_StopMovement

;CaseFC
    cmp #$FC
    beq EnemyGetDeltaY_RepeatPreviousUntilFailure

;CaseFD
    cmp #$FD
    beq EnemyGetDeltaY_ClearEnJumpDsplcmnt

;CaseFE
    cmp #$FE
    beq EnemyGetDeltaY_CaseFE

;Default case (see this as CaseFF)
; Restart movement string from the beginning
    lda #$00
    sta Ens.0.movementInstrIndex,x
    beq L8258 ; branch always

;---------------------------------------
GotoEnemyGetDeltaY_StopMovementSeahorse: ; L827C
    jmp EnemyGetDeltaY_StopMovementSeahorse

;---------------------------------------
EnemyGetDeltaY_SignMagSpeed:
    ; Take the value from memory
    ; Branch ahead if velocityString[Ens.0.movementInstrIndex] - Ens.0.delay != 0
    sec
    sbc Ens.0.delay,x
    bne @endIf_A
        ; delay has elapsed
        ; reset delay to zero
        sta Ens.0.delay,x
        ; Ens.0.movementInstrIndex += 2
        iny
        iny
        tya
        sta Ens.0.movementInstrIndex,x
        ; Handle another byte
        bne EnemyGetDeltaY_ReadByte ; branch always

    @endIf_A:
    ; Increment Ens.0.delay
    inc Ens.0.delay,x

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
    bcc @endIf_A
        eor #$FF
        adc #$00 ; Since carry is set in this branch, this increments A
    @endIf_A:
    ; Store this frame's delta y in temp
L82A2:
    sta $00
    rts

;---------------------------------------
; Clear EnsExtra.0.jumpDsplcmnt, move on to next byte in the stream
EnemyGetDeltaY_ClearEnJumpDsplcmnt:
    inc Ens.0.movementInstrIndex,x
    iny
    lda #$00
    sta EnsExtra.0.jumpDsplcmnt,x
    beq EnemyGetDeltaY_ReadByte ; Branch always

;---------------------------------------
; Don't move, and don't advance the movement counter
; HALT, perhaps?
EnemyGetDeltaY_StopMovement:
; Double RTS !?
    pla
    pla
    rts
; Retruns back to F416 in the engine bank

;---------------------------------------
; Repeat Previous Movement Until Vertical Movement Fails
EnemyGetDeltaY_RepeatPreviousUntilFailure:
    ; If bit 7 of EnsExtra.0.data1F is set, then check if you can move up and then jump ahead
    lda EnsExtra.0.data1F,x
    bpl L82BE
        jsr EnemyCheckMoveUp
        jmp L82C3
    L82BE:
        ; If EnsExtra.0.data1F is non-zero, check if you can move down and then jump ahead
        beq L82D2
        jsr EnemyCheckMoveDown
    L82C3:
    ; branch if movement check succeeded
    ldx PageIndex
    bcs L82D2
    ; movement check failed, move on to the next byte
    ldy Ens.0.movementInstrIndex,x
    iny
    lda #$00
    sta EnsExtra.0.data1F,x
    beq L82D7 ; Branch always

L82D2:
    ; movement check succeeded
    ; repeat the previous two bytes
    ldy Ens.0.movementInstrIndex,x
    dey
    dey

; Save Ens.0.movementInstrIndex
L82D7:
    tya
    sta Ens.0.movementInstrIndex,x
; Read the next bytes
    jmp EnemyGetDeltaY_ReadByte

;---------------------------------------
; Repeat previous until ???
EnemyGetDeltaY_CaseFE:
    ; Move Ens.0.movementInstrIndex back to the previous movement instruction
    dey
    dey
    tya
    sta Ens.0.movementInstrIndex,x
    ; Then do some other stuff
    lda EnsExtra.0.data1F,x
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
    ldy EnsExtra.0.type,x
    lda L968B,y
    and #$20
    beq EnemyGetDeltaY_StopMovementSeahorse
        ; toggle facing direction bits
        lda Ens.0.data05,x
        eor #$05
        ; or with bits 0-4 of L968B entry
        ora L968B,y
        and #$1F
        ; save to Ens.0.data05
        ; (this clears bits 6 and 7, -->
        ;  bit 5 is set by the routine call that follows)
        sta Ens.0.data05,x
        ; fallthrough
;---------------------------------------
;EnemyTriggerRestingPeriod_AndClearEnAccelY
; Move horizontally indefinitely (???)
; Used only at the end of seahorse's movement string
EnemyGetDeltaY_StopMovementSeahorse:
    jsr EnemyTriggerRestingPeriod_AndClearEnAccelY
    jmp L82A2 ; Set delta-y to zero and exit

;-------------------------------------------------------------------------------
; Horizontal Movement Related?
EnemyGetDeltaX:
    ; jump if enemy uses acceleration to move itself
    jsr LoadTableAt977B
    bpl @endIf_A
        jmp EnemyGetDeltaX_UsingAcceleration
    @endIf_A:
    
    ; enemy uses movement strings to move itself
    ; If bit 5 of Ens.0.data05 is clear, don't move horizontally
    lda Ens.0.data05,x
    and #$20
    eor #$20
    beq L833C

    ; Read the same velocity byte as in EnemyGetDeltaY
    ldy Ens.0.movementInstrIndex,x
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
    beq @endIf_A
        jsr TwosComplement
    @endIf_A:
L833C:
    sta $00
    rts

;-------------------------------------------------------------------------------
; apply acceleration to speed and return delta y for enemy
EnemyGetDeltaY_UsingAcceleration:
    ; default max speed at 14 px/f
    ldy #$0E
    ; branch if enemy is accelerating to the left
    lda EnsExtra.0.accelY,x
    bmi @else_A
        ; enemy is accelerating to the right
        ; add acceleration to speed
        clc
        adc Ens.0.speedSubPixelY,x
        sta Ens.0.speedSubPixelY,x
        lda Ens.0.speedY,x
        adc #$00
        sta Ens.0.speedY,x
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
        lda Ens.0.speedSubPixelY,x
        sbc $00
        sta Ens.0.speedSubPixelY,x
        lda Ens.0.speedY,x
        sbc #$00
        sta Ens.0.speedY,x
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
        sta Ens.0.speedSubPixelY,x
        tya
        sta Ens.0.speedY,x
    @endIf_C:

    ; apply sub-pixel speed to sub-pixel position
    lda EnsExtra.0.subPixelY,x
    clc
    adc Ens.0.speedSubPixelY,x
    sta EnsExtra.0.subPixelY,x
    ; $00 stores temp copy of current delta y.
    lda #$00
    adc Ens.0.speedY,x
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
    lda Ens.0.speedSubPixelX,x
    clc
    adc EnsExtra.0.accelX,x
    sta Ens.0.speedSubPixelX,x
    sta $04
    lda #$00
    ldy EnsExtra.0.accelX,x
    bpl L83B6 ;Branch if enemy accelerating to the right.
        lda #$FF
    L83B6:
    adc Ens.0.speedX,x
    sta Ens.0.speedX,x
    tay
    ;Branch if enemy is moving to the right.
    bpl L83D0
        ; enemy is moving left
        ; store negative x speed in $04 and y
        lda #$00
        sec
        sbc Ens.0.speedSubPixelX,x
        sta $04
        lda #$00
        sbc Ens.0.speedX,x
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
        sta Ens.0.speedSubPixelX,x
        lda $01
        sta Ens.0.speedX,x
    L83E3:

    ; apply sub-pixel speed to sub-pixel position
    lda EnsExtra.0.subPixelX,x
    clc
    adc Ens.0.speedSubPixelX,x
    sta EnsExtra.0.subPixelX,x
    ;$00 stores temp copy of current delta x.
    lda #$00
    adc Ens.0.speedX,x
    sta $00
    rts

;-------------------------------------------------------------------------------
; Up movement related
; Move one pixel?
; Those checks below prevent the enemy from going to unloaded rooms.
EnemyMoveOnePixelUp:
    ldx PageIndex
    ; check for collision if top boundary is at a block boundary
    lda Ens.0.y,x
    sec
    sbc EnsExtra.0.radiusY,x
    and #$07
    sec
    bne L8406
        jsr EnemyCheckMoveUp
    L8406:
    ldy #$00
    sty $00
    ldx PageIndex
    ; return movement failed if collided
    bcc RTS_844A
    inc $00
    ; branch if Ens.0.y != 0
    ldy Ens.0.y,x
    bne L8429
    ; enemy tries to switch nametable
    ; to compensate for screen being #$F0 pixels tall
    ldy #SCRN_VY
    ; branch if scrolling horizontally
    lda ScrollDir
    cmp #$02
    bcs L8429
    ; return movement failed if ScrollY == 0
    lda ScrollY
    beq RTS_844A
    ; return movement failed if enemy nametable == nametable at top of screen
    ; (tried to switch nametable while offscreen)
    jsr GetOtherNameTableIndex
    beq RTS_844A
    ; switch nametable
    jsr SwitchEnemyNameTable
L8429:
    ; decrement Ens.0.y
    dey
    tya
    sta Ens.0.y,x
    ; movement successful if top boundary != 0
    cmp EnsExtra.0.radiusY,x
    bne L8441

    ; return movement failed if ScrollY == 0
    lda ScrollY
    beq L843C
        ; return movement failed if enemy nametable == nametable at top of screen,
        ; otherwise success
        jsr GetOtherNameTableIndex
        bne L8441
    L843C:
    inc Ens.0.y,x
    clc
    rts
L8441:
    ; movement successful
    ; increment jumpDsplcmnt if facing in a horizontal direction
    lda Ens.0.data05,x
    bmi L8449
        inc EnsExtra.0.jumpDsplcmnt,x
    L8449:
    sec
RTS_844A:
    rts

;-------------------------------------------------------------------------------
; Down movement related ?
EnemyMoveOnePixelDown:
    ldx PageIndex
    ; check for collision if bottom boundary is at a block boundary
    lda Ens.0.y,x
    clc
    adc EnsExtra.0.radiusY,x
    and #$07
    sec
    bne L845C
        jsr EnemyCheckMoveDown
    L845C:
    ldy #$00
    sty $00
    ldx PageIndex
    ; return movement failed if collided
    bcc RTS_84A6
    inc $00
    ; branch if Ens.0.y != #$EF
    ldy Ens.0.y,x
    cpy #SCRN_VY-1
    bne L8481
    ; enemy tries to switch nametable
    ; to compensate for screen being #$F0 pixels tall
    ldy #$FF
    ; branch if scrolling horizontally
    lda ScrollDir
    cmp #$02
    bcs L8481
    ; return movement failed if ScrollY == 0
    lda ScrollY
    beq RTS_84A6
    ; return movement failed if enemy nametable != nametable at top of screen
    ; (tried to switch nametable while offscreen)
    jsr GetOtherNameTableIndex
    bne RTS_84A6
    ; switch nametable
    jsr SwitchEnemyNameTable
L8481:
    ; increment Ens.0.y
    iny
    tya
    sta Ens.0.y,x
    ; movement successful if bottom boundary != #$EF
    clc
    adc EnsExtra.0.radiusY,x
    cmp #SCRN_VY-1
    bne L849D
    ; return movement failed if ScrollY == 0
    lda ScrollY
    beq L8497
        ; return movement failed if enemy nametable != nametable at top of screen,
        ; otherwise success
        jsr GetOtherNameTableIndex
        beq L849D
    L8497:
    dec Ens.0.y,x
    clc
    bcc RTS_84A6
L849D:
    ; movement successful
    ; decrement jumpDsplcmnt if facing in a horizontal direction
    lda Ens.0.data05,x
    bmi L84A5
        dec EnsExtra.0.jumpDsplcmnt,x
    L84A5:
    sec
RTS_84A6:
    rts

;-------------------------------------------------------------------------------
; Left movement related
EnemyMoveOnePixelLeft:
    ldx PageIndex
    ; check for collision if left boundary is at a block boundary
    lda Ens.0.x,x
    sec
    sbc EnsExtra.0.radiusX,x
    and #$07
    sec
    bne L84B8
        jsr EnemyCheckMoveLeft
    L84B8:
    ldy #$00
    sty $00
    ldx PageIndex
    ; return movement failed if collided
    bcc RTS_84FD
    inc $00
    ; branch if Ens.0.x != 0
    ldy Ens.0.x,x
    bne L84DA
    ; enemy tries to switch nametable
    ; branch if scrolling vertically
    lda ScrollDir
    cmp #$02
    bcc L84DA
    ; return movement failed if ScrollX == 0
    lda ScrollX
    beq L84D4
        ; return movement failed if enemy nametable == nametable at left edge of screen
        ; (tried to switch nametable while offscreen)
        jsr GetOtherNameTableIndex
    L84D4:
    clc
    beq RTS_84FD
    ; switch nametable
    jsr SwitchEnemyNameTable
L84DA:
    ; decrement Ens.0.x
    dec Ens.0.x,x
    ; movement successful if left boundary != 0
    lda Ens.0.x,x
    cmp EnsExtra.0.radiusX,x
    bne L84F4
    ; return movement failed if ScrollX == 0
    lda ScrollX
    beq L84EE
        ; return movement failed if enemy nametable == nametable at left edge of screen,
        ; otherwise success
        jsr GetOtherNameTableIndex
        bne L84F4
    L84EE:
    inc Ens.0.x,x
    clc
    bcc RTS_84FD
L84F4:
    ; movement successful
    ; increment jumpDsplcmnt if facing in a vertical direction
    lda Ens.0.data05,x
    bpl L84FC
        inc EnsExtra.0.jumpDsplcmnt,x
    L84FC:
    sec
RTS_84FD:
    rts

;-------------------------------------------------------------------------------
; Right movement related
EnemyMoveOnePixelRight:
    ldx PageIndex
    ; check for collision if right boundary is at a block boundary
    lda Ens.0.x,x
    clc
    adc EnsExtra.0.radiusX,x
    and #$07
    sec
    bne L850F
        jsr EnemyCheckMoveRight
    L850F:
    ldy #$00
    sty $00
    ldx PageIndex
    ; return movement failed if collided
    bcc RTS_8559
    inc $00
    ; increment Ens.0.x
    inc Ens.0.x,x
    ; branch if Ens.0.x != 0
    bne L8536
    ; enemy tries to switch nametable
    ; branch if scrolling vertically
    lda ScrollDir
    cmp #$02
    bcc L8536
    ; return movement failed if ScrollX == 0
    lda ScrollX
    beq L852D
        ; return movement failed if enemy nametable != nametable at right edge of screen
        ; (tried to switch nametable while offscreen), otherwise branch
        jsr GetOtherNameTableIndex
        beq L8533
    L852D:
        dec Ens.0.x,x
        clc
        bcc RTS_8559
    L8533:
    ; switch nametable
    jsr SwitchEnemyNameTable

L8536:
    ; branch if left boundary != #$FF
    lda Ens.0.x,x
    clc
    adc EnsExtra.0.radiusX,x
    cmp #$FF
    bne L8550
    ; return movement failed if ScrollX == 0
    lda ScrollX
    beq L854A
        ; return movement failed if enemy nametable != nametable at right edge of screen,
        ; otherwise success
        jsr GetOtherNameTableIndex
        beq L8550
    L854A:
    dec Ens.0.x,x
    clc
    bcc RTS_8559

L8550:
    ; movement successful
    ; decrement jumpDsplcmnt if facing in a vertical direction
    lda Ens.0.data05,x
    bpl L8558
        dec EnsExtra.0.jumpDsplcmnt,x
    L8558:
    sec
RTS_8559:
    rts

;-------------------------------------------------------------------------------
SwitchEnemyNameTable: ; L855A
    lda EnsExtra.0.hi,x
    eor #$01
    sta EnsExtra.0.hi,x
    rts

;-------------------------------------------------------------------------------
; Returns the index to the other nametable in A
GetOtherNameTableIndex: ; L8562
    lda EnsExtra.0.hi,x
    eor PPUCTRL_ZP
    and #$01
    rts

;-------------------------------------------------------------------------------
; XORs the contents of Ens.0.data05 with the bitmask in A
XorEnData05: ; L856B
    eor Ens.0.data05,x
    sta Ens.0.data05,x
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
    sta ScrollBlockOnNameTable3,y   ;
    lda ScrollDir                   ;
    and #$02                        ;Is Samus scrolling horizontally?-->
    bne L8B4B                       ;If so, branch.
        ldx #$04                        ;Samus currently scrolling vertically.
        lda ScrollY                     ;Is room centered on screen?-->
        beq L8B6D                       ;If so, branch.
        lda PPUCTRL_ZP                  ;
        eor Samus.hi                       ;Get inverse of Samus' current nametable.
        lsr                             ;
        bcc SetDoorEntryInfo            ;If Samus is on nametable 3, branch.
        bcs L8B52                       ;If Samus is on nametable 0, branch to decrement x.

    L8B4B:
        ldx #$02                        ;Samus is currently scrolling horizontally.
        lda Samus.x                        ;Is Samus entering a left hand door?-->
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
    ora Samus.status                   ;Keep Samus action so she will appear the same comming-->
    sta SamusDoorData               ;out of the door as she did going in.
    lda #sa_Door                    ;
    sta Samus.status                   ;Indicate Samus is in a door.
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
UpdateAllDoors: ;($8B79)
    ldx #Doors.3 - Objects
    @loop:
        jsr UpdateDoor
        lda PageIndex
        sec
        sbc #_sizeof_Objects.0
        tax
        bmi @loop
    rts

UpdateDoor:
    stx PageIndex
    lda Objects.0.status,x
    jsr JumpEngine
        .word ExitSub                   ; no door
        .word UpdateDoor_Init           ; init
        .word UpdateDoor_Closed         ; closed
        .word UpdateDoor_Open           ; open
        .word UpdateDoor_LetSamusIn     ; letting samus in
        .word UpdateDoor_Scroll         ; scrolling
        .word UpdateDoor_LetSamusOut    ; letting samus out

UpdateDoor_Init:
    ; increment door status to "closed"
    inc Objects.0.status,x
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
    ora #$80 | OAMDATA_PRIORITY
    sta ObjectCntrl

    lda #$00
    sta Objects.0.isHit,x
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
    lda Objects.0.isHit,x
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
    sta Objects.0.status,x
    ; set re-close delay to 80 * 2 frames
    lda #$50
    sta DoorHitPoints,x
    ; set door animation to opening the door
    ; and play sound effect
    ; (BUG! there is no call to DrawDoor, so the door isn't drawn on this frame)
    lda #ObjAnim_DoorOpen_Reset - ObjectAnimIndexTbl.b
    sta Objects.0.animResetIndex,x
    sec
    sbc #ObjAnim_DoorOpen_Reset - ObjAnim_DoorOpen.b
    jmp DoorSubRoutine8C7E

UpdateDoor_Open:
    ; branch if samus is not entering a door
    lda DoorEntryStatus
    beq L8C1D
    ; branch if samus is not in the same nametable as the door
    lda Samus.hi
    eor Objects.0.hi,x
    lsr
    bcs L8C1D
    ; branch if samus is not in the same left/right half of the nametable as the door
    lda Samus.x
    eor Objects.0.x,x
    bmi L8C1D
    ; increment door status to "letting samus in"
    lda #$04
    sta Objects.0.status,x
    bne GotoDrawDoor
L8C1D:
    ; branch if animation of opening the door has not completed
    lda Objects.0.animIndex,x
    cmp Objects.0.animResetIndex,x
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
    lda Objects.0.hi,x
    sta Temp08_ItemHi
    ldy MapPosX
    txa
    jsr Amul16
    bcc L8C4C
        dey
    L8C4C:
    tya
    jsr MapScrollRoutine
    ; remove door completely (cannot close again)
    lda #$00
    sta Objects.0.status,x
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
    sta Objects.0.status,x
    ; set door animation to closing the door
    jsr DoorSubRoutine8C76
DoorSubRoutine8C71:
    ldx PageIndex
GotoDrawDoor:
    jmp DrawDoor

DoorSubRoutine8C76:
    lda #ObjAnim_DoorClose_Reset - ObjectAnimIndexTbl.b
    sta Objects.0.animResetIndex,x
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
    lda DoorPaletteChangeDir
    beq L8CA7
    ; branch if door is on the same wall as the one you entered the room with
    txa
    jsr Adiv16
    eor DoorPaletteChangeDir
    lsr
    bcc L8CA7
    ; change the palette
    lda PaletteToggle
    eor #(_id_Palette00+1)~(_id_Palette05+1).b
    sta PaletteToggle
    sta PaletteDataPending
L8CA7:
    ; increment door status to "scroll"
    inc Objects.0.status,x
    ; clear DoorPaletteChangeDir
    lda #$00
    sta DoorPaletteChangeDir
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
    sta Objects.0.status,x
    ; set that door's animation to opening the door
    lda #ObjAnim_DoorOpen_Reset - ObjectAnimIndexTbl.b
    sta Objects.0.animResetIndex,x
    sec
    sbc #ObjAnim_DoorOpen_Reset - ObjAnim_DoorOpen.b
    jsr SetObjAnimIndex
    ; play door sfx
    jsr SFX_Door
    ; update samus's palette (probably so that she doesn't remain blue when going in a door with a metroid on her head)
    jsr SelectSamusPalette
    ; set the current door's status to "closed"
    ldx PageIndex
    lda #$02
    sta Objects.0.status,x
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
    lda #$4E ; door tile
WriteDoorBGTiles_Common:
    ; get cart ram pointer of door
    pha
    ; door y coordinate
    lda #$50
    sta Temp02_PositionY
    ; door x coordinate (depends on bit 4 of object slot address)
    txa
    jsr Adiv16
    and #$01
    tay
    lda DoorXTable,y
    sta Temp03_PositionX
    ; door nametable
    lda Objects.0.hi,x
    sta Temp0B_PositionHi
    ; call
    jsr MakeRoomRAMPtr
    ldy #$00 ; init y for loop
    pla
    ; cart ram pointer of door is now in $04-$05
    ; write 6 air or door tiles in a vertical line to cart ram
    @loop:
        sta (Temp04_RoomRAMPtr),y
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
    lda Temp04_RoomRAMPtr
    sta DoorRoomRAMPtr,y
    lda Temp04_RoomRAMPtr+1
    sta DoorRoomRAMPtr+1,y
    rts

; x coordinate of door's background tiles in pixels
DoorXTable:
    .byte $E8, $10

.byte $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9
.byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
.byte $85, $00, $AD, $97, $69, $29

; EoF
