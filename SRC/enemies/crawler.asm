; Zoomer Routine (Crawler)
CrawlerAIRoutine_{AREA}:
    ; move only 6 frames out of 8 (0.75px per frame)
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    beq @exit

    lda EnemyStatusPreAI
    .if BANK == 1 || BANK == 4
        cmp #enemyStatus_Resting
        beq SkreeExit_Resting_{AREA}
        cmp #enemyStatus_Explode
        beq SkreeExit_Explode_{AREA}
    .elif BANK == 2 || BANK == 5
        cmp #enemyStatus_Resting
        beq CrawlerExit_Resting_{AREA}
        cmp #enemyStatus_Explode
        beq CrawlerExit_Explode_{AREA}
    .endif
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq @exit

    ; check crawler orientation
    ; (#$00 = forwards on floor, #$01 = moving down a wall, #$02 = backwards on ceiling, #$03 = moving up an opposite wall)
    lda EnData0A,x
    and #$03
    cmp #$01
    bne @move
    ; crawler is on wall moving down
    ; if it's near the bottom of the screen (about to walk into lava), turn around to not walk into it
    ; (BUG! this doesn't check that its a horizontal room, so it will turn around in vertical rooms too.
    ; for example, at the bottom of the top screen in the shaft to brinstar->kraid elevator,
    ; the zoomer will never walk on the underside of the platform it's on)
    ldy EnY,x
    .if BANK == 1 || BANK == 4
        cpy #$E4
    .elif BANK == 2 || BANK == 5
        cpy #$EB
    .endif
    bne @move
    ; it is near the bottom, make it turn around vertically
    
    ; whats noteworthy here is that changing the orientation alone is not enough
    ; you must also horizontally flip the crawler
    ; see this example, a crawler is walking down a wall to its right:
    ;  |=###
    ;  V=###
    ; change only orientation (incorrect)
    ; =^ ###
    ; =| ###
    ; change only horizontal flip (incorrect)
    ; =| ###
    ; =V ###
    ; change both orientation and horizontal flip (correct)
    ;  ^=###
    ;  |=###
    
    ; horizontal flip
    jsr CrawlerFlipDirection_{AREA}
    ; set orientation to moving up the wall
    lda #$03
    sta EnData0A,x
    bne @afterLavaTurnAround ; branch always
@move:
    ; move crawler in its direction
    jsr JumpByRTSToMovementRoutine_{AREA}
    jsr CrawlerInsideCornerCheck_{AREA}
@afterLavaTurnAround:
    jsr CrawlerOutsideCornerCheck_{AREA}
@exit:
    ; change animation frame every 3 frames
    lda #$03
    jsr CommonJump_UpdateEnemyAnim
CrawlerExit_Explode_{AREA}:
    jmp CommonJump_02

.if BANK == 2 || BANK == 5
    CrawlerExit_Resting_{AREA}:
        jmp CommonJump_01
.endif

CrawlerReorientSprite_{AREA}:
    ; Y = orientation * 2 + direction
    lda EnData05,x
    lsr
    lda EnData0A,x
    and #$03
    rol
    tay
    lda CrawlerAnimIndexTable_{AREA},y
    jmp CommonJump_InitEnAnimIndex

CrawlerAnimIndexTable_{AREA}:
.if BANK == 1
    .byte EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnLeftWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZoomerOnLeftWall_{AREA} - EnAnimTable_{AREA}
.elif BANK == 2
    .byte EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnLeftWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_NovaOnLeftWall_{AREA} - EnAnimTable_{AREA}
.elif BANK == 4
    .byte EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnLeftWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ZeelaOnLeftWall_{AREA} - EnAnimTable_{AREA}
.elif BANK == 5
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnFloor_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnLeftWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnCeiling_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnRightWall_{AREA} - EnAnimTable_{AREA}
    .byte EnAnim_ViolaOnLeftWall_{AREA} - EnAnimTable_{AREA}
.endif

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
    ; outside corner check, check if there's no floor beneath the crawler
    jsr CrawlerOutsideCornerGetNextOrientation_{AREA}
    jsr JumpByRTSToMovementRoutine_{AREA}
    ldx PageIndex
    bcc @RTS
        ; at outside corner, stick to wall
        jsr CrawlerOutsideCornerGetNextOrientation_{AREA}
        sta EnData0A,x
        jsr CrawlerReorientSprite_{AREA}
    @RTS:
    rts

CrawlerOutsideCornerGetNextOrientation_{AREA}:
    ; returns the orientation needed to turn an outside corner, relative to current orientation
    ldy EnData0A,x
    iny
    tya
    and #$03
    rts

; a: orientation
JumpByRTSToMovementRoutine_{AREA}:
    ; Y = (orientation * 2 + direction)*2
    ; shift direction bit into carry
    ldy EnData05,x
    sty $00
    lsr $00
    ; rotate it left into orientation in a
    rol
    ; *2 because pointers are 2 bytes
    asl
    tay
    ; push movement routine pointer into stack
    lda CrawlerMovementRoutinesTable+1,y
    pha
    lda CrawlerMovementRoutinesTable,y
    pha
    ; return to the pushed pointer
    rts
