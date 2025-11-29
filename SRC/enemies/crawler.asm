; Zoomer Routine (Crawler)
CrawlerAIRoutine:
    ; move only 6 frames out of 8 (0.75px per frame)
    jsr CommonJump_CrawlerAIRoutine_ShouldCrawlerMove
    and #$03
    beq Crawler03

    lda EnemyStatusPreAI
    .if BANK == 1 || BANK == 4
        cmp #enemyStatus_Resting
        beq SkreeExit_Resting
        cmp #enemyStatus_Explode
        beq SkreeExit_Explode
    .elif BANK == 2 || BANK == 5
        cmp #enemyStatus_Resting
        beq CrawlerExit_Resting
        cmp #enemyStatus_Explode
        beq CrawlerExit_Explode
    .endif
    lda EnsExtra.0.status,x
    cmp #enemyStatus_Explode
    beq Crawler03

    ; check crawler orientation
    ; (#$00 = forwards on floor, #$01 = moving down a wall, #$02 = backwards on ceiling, #$03 = moving up an opposite wall)
    lda EnData0A,x
    and #$03
    cmp #$01
    bne Crawler01
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
    bne Crawler01
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
    jsr CrawlerFlipDirection
    ; set orientation to moving up the wall
    lda #$03
    sta EnData0A,x
    bne Crawler02 ; branch always
Crawler01:
    ; move crawler in its direction
    jsr JumpByRTSToMovementRoutine
    jsr CrawlerInsideCornerCheck
Crawler02:
    jsr CrawlerOutsideCornerCheck
Crawler03:
    ; change animation frame every 3 frames
    lda #$03
    jsr CommonJump_UpdateEnemyAnim
CrawlerExit_Explode:
    jmp CommonJump_02

.if BANK == 2 || BANK == 5
    CrawlerExit_Resting:
        jmp CommonJump_01
.endif

CrawlerReorientSprite:
    ; Y = orientation * 2 + direction
    lda EnData05,x
    lsr
    lda EnData0A,x
    and #$03
    rol
    tay
    lda CrawlerAnimIndexTable,y
    jmp CommonJump_InitEnAnimIndex

.if BANK == 1
    CrawlerAnimIndexTable:
        .byte EnAnim_ZoomerOnFloor - EnAnimTbl
        .byte EnAnim_ZoomerOnFloor - EnAnimTbl
        .byte EnAnim_ZoomerOnLeftWall - EnAnimTbl
        .byte EnAnim_ZoomerOnRightWall - EnAnimTbl
        .byte EnAnim_ZoomerOnCeiling - EnAnimTbl
        .byte EnAnim_ZoomerOnCeiling - EnAnimTbl
        .byte EnAnim_ZoomerOnRightWall - EnAnimTbl
        .byte EnAnim_ZoomerOnLeftWall - EnAnimTbl
.elif BANK == 2
    CrawlerAnimIndexTable:
        .byte EnAnim_NovaOnFloor - EnAnimTbl
        .byte EnAnim_NovaOnFloor - EnAnimTbl
        .byte EnAnim_NovaOnLeftWall - EnAnimTbl
        .byte EnAnim_NovaOnRightWall - EnAnimTbl
        .byte EnAnim_NovaOnCeiling - EnAnimTbl
        .byte EnAnim_NovaOnCeiling - EnAnimTbl
        .byte EnAnim_NovaOnRightWall - EnAnimTbl
        .byte EnAnim_NovaOnLeftWall - EnAnimTbl
.elif BANK == 4
    CrawlerAnimIndexTable:
        .byte EnAnim_ZeelaOnFloor - EnAnimTbl
        .byte EnAnim_ZeelaOnFloor - EnAnimTbl
        .byte EnAnim_ZeelaOnLeftWall - EnAnimTbl
        .byte EnAnim_ZeelaOnRightWall - EnAnimTbl
        .byte EnAnim_ZeelaOnCeiling - EnAnimTbl
        .byte EnAnim_ZeelaOnCeiling - EnAnimTbl
        .byte EnAnim_ZeelaOnRightWall - EnAnimTbl
        .byte EnAnim_ZeelaOnLeftWall - EnAnimTbl
.elif BANK == 5
    CrawlerAnimIndexTable:
        .byte EnAnim_ViolaOnFloor - EnAnimTbl
        .byte EnAnim_ViolaOnFloor - EnAnimTbl
        .byte EnAnim_ViolaOnLeftWall - EnAnimTbl
        .byte EnAnim_ViolaOnRightWall - EnAnimTbl
        .byte EnAnim_ViolaOnCeiling - EnAnimTbl
        .byte EnAnim_ViolaOnCeiling - EnAnimTbl
        .byte EnAnim_ViolaOnRightWall - EnAnimTbl
        .byte EnAnim_ViolaOnLeftWall - EnAnimTbl
.endif

CrawlerInsideCornerCheck:
    ; inside corner check, check if collided with wall
    ; (carry flag was updated by JumpByRTSToMovementRoutine called before this)
    ldx PageIndex
    bcs RTS_Crawler06
    ; flip direction if tried to move offscreen
    lda $00
    bne CrawlerFlipDirection
        ; at inside corner, stick to wall
        ldy EnData0A,x
        dey
        tya
        and #$03
        sta EnData0A,x
        jmp CrawlerReorientSprite

    CrawlerFlipDirection:
        lda EnData05,x
        eor #$01
        sta EnData05,x
    RTS_Crawler06:
        rts

CrawlerOutsideCornerCheck:
    ; outside corner check, check if there's no floor beneath the crawler
    jsr CrawlerOutsideCornerGetNextOrientation
    jsr JumpByRTSToMovementRoutine
    ldx PageIndex
    bcc @RTS
        ; at outside corner, stick to wall
        jsr CrawlerOutsideCornerGetNextOrientation
        sta EnData0A,x
        jsr CrawlerReorientSprite
    @RTS:
    rts

CrawlerOutsideCornerGetNextOrientation:
    ; returns the orientation needed to turn an outside corner, relative to current orientation
    ldy EnData0A,x
    iny
    tya
    and #$03
    rts

; a: orientation
JumpByRTSToMovementRoutine:
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
