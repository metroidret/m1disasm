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

    lda EnData0A,x
    and #$03
    cmp #$01
    bne Crawler01
    ; crawler is on wall moving down
    ; flip direction if it's near the bottom
    ldy EnY,x
    .if BANK == 1 || BANK == 4
        cpy #$E4
    .elif BANK == 2 || BANK == 5
        cpy #$EB
    .endif
    bne Crawler01
    jsr CrawlerFlipDirection
    lda #$03
    sta EnData0A,x
    bne Crawler02
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
        .byte EnAnim_4A - EnAnimTbl
        .byte EnAnim_4A - EnAnimTbl
        .byte EnAnim_53 - EnAnimTbl
        .byte EnAnim_4D - EnAnimTbl
        .byte EnAnim_50 - EnAnimTbl
        .byte EnAnim_50 - EnAnimTbl
        .byte EnAnim_4D - EnAnimTbl
        .byte EnAnim_53 - EnAnimTbl
.endif

CrawlerInsideCornerCheck:
    ; inside corner check, check if collided with wall
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
    jsr Crawler11
    jsr JumpByRTSToMovementRoutine
    ldx PageIndex
    bcc @RTS
        ; at outside corner, stick to wall
        jsr Crawler11
        sta EnData0A,x
        jsr CrawlerReorientSprite
    @RTS:
    rts

Crawler11:
    ldy EnData0A,x
    iny
    tya
    and #$03
    rts

JumpByRTSToMovementRoutine:
    ; Y = orientation * 2 + direction
    ldy EnData05,x
    sty $00
    lsr $00
    rol
    asl
    tay
    lda CrawlerMovementRoutinesTable+1,y
    pha
    lda CrawlerMovementRoutinesTable,y
    pha
    rts

