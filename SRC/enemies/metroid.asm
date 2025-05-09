MetroidAIRoutine:
    ; Delete self if escape timer is active (EndTimer+1 != #$FF)
    ldy EndTimer+1
    iny
    beq L9804
        lda #$00
        sta EnStatus,x
    L9804:
    
    lda #$0F
    sta $00
    sta $01
    lda EnData05,x
    asl
    bmi CommonEnemyJump_00_01_02
    lda EnStatus,x
    cmp #$03
    beq CommonEnemyJump_00_01_02
    
    jsr LoadEnemySlotIDIntoY
    lda MetroidLatch0400,y
    beq L9822
        jmp L9899

    L9822:
    ; load whether the metroid is red (#$00) or green (#$01) into y
    ldy EnData08,x
    
    ; push y max speed to stack
    lda MetroidMaxSpeed,y
    pha
    
    ; check if y speed is positive
    lda EnData02,x
    bpl L983B
        ; negate y max speed
        pla
        jsr TwosComplement_
        pha
        ; get absolute value of y speed
        lda #$00
        cmp EnCounter,x
        sbc EnData02,x
    L983B:
    ; compare absolute y speed with absolute max speed
    cmp MetroidMaxSpeed,y
    pla
    bcc L9849
        ; limit speed to max
        sta EnData02,x
        lda #$00
        sta EnCounter,x
    L9849:
    
    ; push x max speed to stack
    lda MetroidMaxSpeed,y
    pha
    
    ; check if x speed is positive
    lda EnData03,x
    bpl L985F
        ; negate x speed
        pla
        jsr TwosComplement_
        pha
        ; get absolute value of x speed
        lda #$00
        cmp EnData07,x
        sbc EnData03,x
    L985F:
    ; compare absolute x speed with absolute max speed
    cmp MetroidMaxSpeed,y
    pla
    bcc L986D
        ; limit speed to max
        sta EnData03,x
        lda #$00
        sta EnData07,x
    L986D:
    
    ; load acceleration sign bits into a (bit0: horizontal sign, bit2: vertical sign)
    lda EnData05,x
    pha
    ; get horizontal acceleration
    jsr GetMetroidAccel
    sta EnData1B,x
    pla
    ; get vertical acceleration
    lsr
    lsr
    jsr GetMetroidAccel
    sta EnData1A,x
    
    ; check if metroid is frozen or not
    lda EnStatus,x
    cmp #$04
    bne L9894
        ; metroid is frozen
        ; check if metroid was invincible
        ldy EnHitPoints,x
        iny
        bne L9899
            ; if it was invincible, make it vincible with 5 hit points
            lda #$05
            sta EnHitPoints,x
            bne L9899
    L9894:
        ; metroid is not frozen, metroid is invincible
        lda #$FF
        sta EnHitPoints,x
L9899:
    lda EnemyMovementPtr
    cmp #$06
    bne L98A9
    cmp EnStatus,x
    beq L98A9
    lda #$04
    sta EnStatus,x
L98A9:
    lda EnData04,x
    and #$20
    beq L990F
        ; check if metroid is latched onto Samus
        jsr LoadEnemySlotIDIntoY
        lda MetroidLatch0400,y
        beq L98EF
            ; don't count bomb hit if not hit by a bomb explosion
            lda EnWeaponAction,x
            cmp #wa_Unknown7
            beq L98C3
                cmp #wa_BombExplode
                bne L9932
            L98C3:
            
            ; don't count bomb hit when bit 1 of FrameCount is set
            lda FrameCount
            and #$02
            bne L9932
            
            ; count up one bomb hit
            lda MetroidLatch0400,y
            clc
            adc #$10
            sta MetroidLatch0400,y
            
            ; check if 5 bomb hits have been dealt to the metroid
            and #$70
            cmp #$50
            bne L9932
            
            ; the bomb hits have released the latch of the metroid onto Samus
            lda #$02
            ora EnSpecialAttribs,x
            sta EnData0C,x
            lda #$06
            sta EnStatus,x
            lda #$20
            sta EnSpecialAttribs,x
            lda #$01
            sta EnData0D,x
        L98EF:
        ; let go of Samus
        lda #$00
        sta EnData04,x
        sta MetroidLatch0400,y
        sta EnCounter,x
        sta EnData07,x
        ; set repel speed
        lda EnData1A,x
        jsr GetMetroidRepelSpeed
        sta EnData02,x
        lda EnData1B,x
        jsr GetMetroidRepelSpeed
        sta EnData03,x
    L990F:
    ; check if latched
    jsr LoadEnemySlotIDIntoY
    lda MetroidLatch0400,y
    bne L9932
        ; not latched
        ; check if metroid is touching Samus
        lda EnData04,x
        and #$04
        beq L9964
        
        ; begin attempt to latch onto Samus
        ; put sign of x speed + $01 into latch
        lda EnData03,x
        and #$80
        ora #$01
        tay
        jsr ClearMetroidSpeed
        jsr LoadEnemySlotIDIntoX
        tya
        sta MetroidLatch0400,x
        txa
        tay
    L9932:
    tya
    tax
    lda MetroidLatch0400,x
    php
    and #$0F
    cmp #$0C
    beq L9941
        inc MetroidLatch0400,x
    L9941:
    tay
    lda Table99D8-1,y
    sta $04
    sty $05
    lda #$0C
    sec
    sbc $05
    ldx PageIndex
    plp
    bmi L9956
        jsr TwosComplement_
    L9956:
    sta $05
    ; set metroid position to Samus position
    jsr StoreSamusPositionToTemp
    jsr CommonJump_0D ; scroll enemy position and update enemy speed?
    jsr LoadPositionFromTemp
    jmp L9967

L9964:
    jsr ClearCurrentMetroidLatch
L9967:
    lda EnStatus,x
    cmp #$03
    bne L9971
        jsr ClearCurrentMetroidLatch
    L9971:
    
    ; MetroidOnSamus defaults to false
    ldy #$00
    
    ; Don't suck Samus's energy if no metroids are fully attached to Samus
    lda MetroidLatch0400
    ora MetroidLatch0410
    ora MetroidLatch0420
    ora MetroidLatch0430
    ora MetroidLatch0440
    ora MetroidLatch0450
    and #$0C
    cmp #$0C
    bne L999E
    
    ; Don't suck Samus's energy if she is dead
    lda Health
    ora Health+1
    beq L999E
    
    ; Subtract 1/4 health point from Samus
    sty HealthChange+1
    ldy #$04
    sty HealthChange
    jsr CommonJump_SubtractHealth
    ; Set MetroidOnSamus to true
    ldy #$01
L999E:
    sty MetroidOnSamus
    lda ObjectCntrl
    bmi L99AB
        lda EnDataIndex,x
        ora #$A2
        sta ObjectCntrl
    L99AB:
    jmp CommonEnemyJump_00_01_02

ClearCurrentMetroidLatch:
    jsr LoadEnemySlotIDIntoY
ClearMetroidLatch:
    lda #$00
    sta MetroidLatch0400,y
    rts

LoadEnemySlotIDIntoY:
    txa
    jsr Adiv16_
    tay
    rts

LoadEnemySlotIDIntoX:
    txa
    jsr Adiv16_
    tax
    rts

ClearMetroidSpeed:
    lda #$00
    sta EnData02,x
    sta EnData03,x
    sta EnData07,x
    sta EnCounter,x
ClearRinkaSomething: ; referenced in rinka.asm
    sta EnData1B,x
    sta EnData1A,x
    rts

Table99D8:
    .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8

StoreSamusPositionToTemp:
    ; put Samus position as parameters to CommonJump_0D
    lda ObjectX
    sta $09
    lda ObjectY
    sta $08
    lda ObjectHi
    sta $0B
    rts

LoadPositionFromTemp:
    ; save function result as enemy position
    lda $09
    sta EnXRoomPos,x
    lda $08
    sta EnYRoomPos,x
    lda $0B
    and #$01
    sta EnNameTable,x
    rts

GetMetroidAccel:
    ; put acceleration sign bit in carry
    lsr
    ; load whether the metroid is red (#$00) or green (#$01) into a
    lda EnData08,x
    ; rotate direction bit back into a
    rol
    ; get MetroidAccel at that index
    tay
    lda MetroidAccel,y
    rts

GetMetroidRepelSpeed:
    ; use bit 6 of accel as an index for MetroidRepelSpeed table
    asl
    rol
    and #$01
    tay
    lda MetroidRepelSpeed,y
    rts

    .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00
