; Zoomer Routine (Crawler)
CrawlerAIRoutine_{AREA}:
    ; move only 6 frames out of 8 (0.75px per frame)
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    beq @exit
    
    lda EnemyStatusPreAI
    cmp #enemyStatus_Resting
    beq SkreeExit_Resting_{AREA}
    cmp #enemyStatus_Explode
    beq SkreeExit_Explode_{AREA}
    
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @exit
    
    ; check crawler orientation
    ; (#$00 = forwards on floor, #$01 = moving down a wall, #$02 = backwards on ceiling, #$03 = moving up an opposite wall)
    lda EnData0A,x
    and #$03
    cmp #$01
    bne @move
    
    ldy EnY,x
    cpy #$E4
    bne @move
    
    .byte $20, $B5, $BA
    ; set orientation to moving up the wall
    lda #$03
    sta EnData0A,x
    bne @afterLavaTurnAround ; branch always
@move:
    .byte $20, $DA, $BA
    .byte $20, $A0, $BA
@afterLavaTurnAround:
    .byte $20, $BE, $BA
@exit:
    ; change animation frame every 3 frames
    lda #$03
    .byte $20, $0C, $6C
CrawlerExit_Explode_{AREA}:
    jmp CommonJump_02

CrawlerReorientSprite_{AREA}:
    .byte $BD, $05, $04
    .byte $4A
    .byte $BD, $0A, $04
    .byte $29, $03
    .byte $2A, $A8
    .byte $B9, $98, $BA
    .byte $4C, $0F, $6C

CrawlerAnimIndexTable_{AREA}:
    .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E

CrawlerInsideCornerCheck_{AREA}:
; inside corner check, check if collided with wall
    ; (carry flag was updated by JumpByRTSToMovementRoutine called before this)
    ldx PageIndex
    bcs RTS_Crawler06_{AREA}
    ; flip direction if tried to move offscreen
    lda $00
    bne CrawlerFlipDirection_{AREA}
        ; at inside corner, stick to wall
        ldy EnData0A,x
        dey
        tya
        and #$03
        sta EnData0A,x
        jmp CrawlerReorientSprite_{AREA}
    
    CrawlerFlipDirection_{AREA}:
        lda EnData05,x
        eor #$01
        sta EnData05,x
    RTS_Crawler06_{AREA}:
        rts

CrawlerOutsideCornerCheck_{AREA}:
    .byte $20, $D2, $BA
    .byte $20, $DA, $BA
    .byte $A6, $45
    .byte $90, $09
    .byte $20, $D2, $BA
    .byte $9D, $0A, $04
    .byte $20, $87, $BA
    .byte $60

CrawlerOutsideCornerGetNextOrientation_{AREA}:
    .byte $BC, $0A, $04, $C8, $98, $29, $03, $60

JumpByRTSToMovementRoutine_{AREA}:
    .byte $BC, $05, $04
    .byte $84, $00
    .byte $46, $00
    .byte $2A, $0A, $A8
    .byte $B9, $49, $6C, $48
    .byte $B9, $48, $6C, $48
    .byte $60

