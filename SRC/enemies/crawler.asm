; Zoomer Routine (Crawler)
CrawlerAIRoutine:
    ; move only 6 frames out of 8
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
    lda EnStatus,x
    cmp #enemyStatus_Explode
    beq Crawler03
    lda EnData0A,x
    and #$03
    cmp #$01
    bne Crawler01
    ldy EnY,x
    .if BANK == 1 || BANK == 4
        cpy #$E4
    .elif BANK == 2 || BANK == 5
        cpy #$EB
    .endif
    bne Crawler01
    jsr Crawler06_else
    lda #$03
    sta EnData0A,x
    bne Crawler02
Crawler01:
    jsr JumpByRTSToMovementRoutine
    jsr Crawler06
Crawler02:
    jsr Crawler09
Crawler03:
    lda #$03
    jsr CommonJump_UpdateEnemyAnim
CrawlerExit_Explode:
    jmp CommonJump_02

.if BANK == 2 || BANK == 5
    CrawlerExit_Resting:
        jmp CommonJump_01
.endif

Crawler04:
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
        .byte EnAnim_69 - EnAnimTbl
        .byte EnAnim_69 - EnAnimTbl
        .byte EnAnim_72 - EnAnimTbl
        .byte EnAnim_6C - EnAnimTbl
        .byte EnAnim_6F - EnAnimTbl
        .byte EnAnim_6F - EnAnimTbl
        .byte EnAnim_6C - EnAnimTbl
        .byte EnAnim_72 - EnAnimTbl
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

Crawler06:
    ldx PageIndex
    bcs RTS_Crawler06
    lda $00
    bne Crawler06_else
        ldy EnData0A,x
        dey
        tya
        and #$03
        sta EnData0A,x
        jmp Crawler04
    Crawler06_else:
        lda EnData05,x
        eor #$01
        sta EnData05,x
    RTS_Crawler06:
        rts

Crawler09:
    jsr Crawler11
    jsr JumpByRTSToMovementRoutine
    ldx PageIndex
    bcc RTS_Crawler09
        jsr Crawler11
        sta EnData0A,x
        jsr Crawler04
    RTS_Crawler09:
    rts

Crawler11:
    ldy EnData0A,x
    iny
    tya
    and #$03
    rts

JumpByRTSToMovementRoutine:
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
