; Ridley Routine
RidleyAIRoutine:
    lda EnStatus,x
    cmp #enemyStatus_Explode
    bcc L9A33
    beq L9A20
    cmp #enemyStatus_Pickup
    bne L9A41

L9A20:
    lda #enemyStatus_NoEnemy
    sta EnStatus+$10
    sta EnStatus+$20
    sta EnStatus+$30
    sta EnStatus+$40
    sta EnStatus+$50
    beq L9A41

L9A33:
    lda #$0B
    sta EnemyLFB88_85
    lda #$0E
    sta EnemyLFB88_85+1
    jsr CommonJump_09
    jsr L9A79

L9A41:
    lda #$03
    sta $00
    sta $01
    jmp CommonEnemyJump_00_01_02

;-------------------------------------------------------------------------------
; Ridley Fireball Routine
RidleyFireballAIRoutine:
    lda EnData05,x
    pha
    lda #$02
    sta $00
    sta $01
    jsr CommonEnemyJump_00_01_02
    pla
    ldx PageIndex
    eor EnData05,x
    lsr
    bcs L9A73
    lda EnData05,x
    lsr
    bcs L9A78
    lda EnX,x
    sec
    sbc ObjX
    bcc L9A78
    cmp #$20
    bcc L9A78
L9A73:
    lda #$00
    sta EnStatus,x
L9A78:
    rts

;-------------------------------------------------------------------------------
; Ridley Subroutine
L9A79:
    ldy Ridley80
    bne L9A7F
        ldy #$60
    L9A7F:
    lda FrameCount
    and #$02
    bne L9AA9
    dey
    sty Ridley80
    tya
    asl
    bmi L9AA9
    and #$0F
    cmp #$0A
    bne L9AA9
    ldx #$50
    L9A94:
        lda EnStatus,x
        beq L9AAA
        lda EnData05,x
        and #$02
        beq L9AAA
        txa
        sec
        sbc #$10
        tax
        bne L9A94
    inc Ridley7E
L9AA9:
    rts

L9AAA:
    txa
    tay
    ldx #$00
    jsr StorePositionToTemp
    tya
    tax
    lda EnData05
    sta EnData05,x
    and #$01
    tay
    lda L9ADF,y
    sta $05
    lda #$F8
    sta $04
    jsr CommonJump_0D
    bcc L9AA9
    lda #$00
    sta EnSpecialAttribs,x
    lda #$0A
    sta EnDataIndex,x
    lda #$01
    sta EnStatus,x
    jsr LoadPositionFromTemp
    jmp CommonJump_0E
L9ADF:
    .byte $08, -$08
