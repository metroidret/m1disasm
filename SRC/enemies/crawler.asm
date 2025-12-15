; Zoomer Routine (Crawler)
CrawlerAIRoutine_BANK{BANK}:
    ; move only 6 frames out of 8 (0.75px per frame)
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    beq @exit

    lda EnemyStatusPreAI
    .if BANK == 1 || BANK == 4
        cmp #enemyStatus_Resting
        beq SkreeExit_Resting_BANK{BANK}
        cmp #enemyStatus_Explode
        beq SkreeExit_Explode_BANK{BANK}
    .elif BANK == 2 || BANK == 5
        cmp #enemyStatus_Resting
        beq CrawlerExit_Resting_BANK{BANK}
        cmp #enemyStatus_Explode
        beq CrawlerExit_Explode_BANK{BANK}
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
    jsr CrawlerFlipDirection_BANK{BANK}
    ; set orientation to moving up the wall
    lda #$03
    sta EnData0A,x
    bne @afterLavaTurnAround ; branch always
@move:
    ; move crawler in its direction
    jsr JumpByRTSToMovementRoutine_BANK{BANK}
    jsr CrawlerInsideCornerCheck_BANK{BANK}
@afterLavaTurnAround:
    jsr CrawlerOutsideCornerCheck_BANK{BANK}
@exit:
    ; change animation frame every 3 frames
    lda #$03
    jsr CommonJump_UpdateEnemyAnim
CrawlerExit_Explode_BANK{BANK}:
    jmp CommonJump_02

.if BANK == 2 || BANK == 5
    CrawlerExit_Resting_BANK{BANK}:
        jmp CommonJump_01
.endif

CrawlerReorientSprite_BANK{BANK}:
    ; Y = orientation * 2 + direction
    lda EnData05,x
    lsr
    lda EnData0A,x
    and #$03
    rol
    tay
    lda CrawlerAnimIndexTable_BANK{BANK},y
    jmp CommonJump_InitEnAnimIndex

CrawlerAnimIndexTable_BANK{BANK}:
.if BANK == 1
    .byte EnAnim_ZoomerOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZoomerOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
.elif BANK == 2
    .byte EnAnim_NovaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_NovaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
.elif BANK == 4
    .byte EnAnim_ZeelaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ZeelaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
.elif BANK == 5
    .byte EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnFloor_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnCeiling_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnRightWall_BANK{BANK} - EnAnimTable_BANK{BANK}
    .byte EnAnim_ViolaOnLeftWall_BANK{BANK} - EnAnimTable_BANK{BANK}
.endif

CrawlerInsideCornerCheck_BANK{BANK}:
    ; inside corner check, check if collided with wall
    ; (carry flag was updated by JumpByRTSToMovementRoutine called before this)
    ldx PageIndex
    bcs RTS_Crawler06_BANK{BANK}
    ; flip direction if tried to move offscreen
    lda $00
    bne CrawlerFlipDirection_BANK{BANK}
        ; at inside corner, stick to wall
        ldy EnData0A,x
        dey
        tya
        and #$03
        sta EnData0A,x
        jmp CrawlerReorientSprite_BANK{BANK}

    CrawlerFlipDirection_BANK{BANK}:
        lda EnData05,x
        eor #$01
        sta EnData05,x
    RTS_Crawler06_BANK{BANK}:
        rts

CrawlerOutsideCornerCheck_BANK{BANK}:
    ; outside corner check, check if there's no floor beneath the crawler
    jsr CrawlerOutsideCornerGetNextOrientation_BANK{BANK}
    jsr JumpByRTSToMovementRoutine_BANK{BANK}
    ldx PageIndex
    bcc @RTS
        ; at outside corner, stick to wall
        jsr CrawlerOutsideCornerGetNextOrientation_BANK{BANK}
        sta EnData0A,x
        jsr CrawlerReorientSprite_BANK{BANK}
    @RTS:
    rts

CrawlerOutsideCornerGetNextOrientation_BANK{BANK}:
    ; returns the orientation needed to turn an outside corner, relative to current orientation
    ldy EnData0A,x
    iny
    tya
    and #$03
    rts

; a: orientation
JumpByRTSToMovementRoutine_BANK{BANK}:
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
