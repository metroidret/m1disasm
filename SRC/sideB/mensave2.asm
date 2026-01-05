; side B file $1A - mensave2 (prgram $C3F0-$C59F)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side01_EF
    .ascstr "MENSAVE2"
FDSFileMacroPart2 $C3F0, FDSFileType_PRGRAM



LC3F0:
    .word LC461
LC3F2:
    .word LB32D



LC3F4:
    ; display message on screen
    jsr ClearScreenData
    lda #<VRAMStruct_C40B.b
    sta $00
    lda #>VRAMStruct_C40B.b
    sta $01
    jsr MAIN_VRAMStructWrite
    jsr METHEX_ScreenOn
    
    ; wait for disk to switch to side A
    jsr LB310
    jmp LC425


; "Aメンヲ セットシテクダサイ" message (switch to disk side A)
VRAMStruct_C40B:
    VRAMStructData $21D4, charmap_gameover, \
        "゛"
    VRAMStructData $21E9, charmap_gameover, \
        "aメンヲ セットシテクタサイ"
    VRAMStructDataRepeat $23D0, undefined, $20, \
        $00
    VRAMStructEnd



LC425:
    jsr LB32D
    
    ; load save data to prgram
    ldx #<LoadList_SaveData.b
    ldy #>LoadList_SaveData.b
    jsr LB2B6
    ; determine which ending we got
    jsr ChooseEnding
    ; update money bags
    ldy CurSamusStat.SaveSlot
    lda CurSamusStat.EndingType
    sta SaveData@moneyBags,y
    ; x = y * #$10
    tya
    asl a
    asl a
    asl a
    asl a
    tax
    ; update samus stat
    ldy #$00
    LC443:
        lda CurSamusStat,y
        sta SaveData@samusStat,x
        inx
        iny
        cpy #$10
        bne LC443
    ; write save data to disk
    ldx #<MAIN_SaveDataFileHeader.b
    ldy #>MAIN_SaveDataFileHeader.b
    lda #$0E
    jsr LB22B
    
    ; load ending to prgram if CurSamusStat.byteC is non-zero
    ldx #<LoadList_Ending.b
    ldy #>LoadList_Ending.b
    lda CurSamusStat.byteC
    bne LC465
LC461:
    ldx #<LoadList_NoEnding.b
    ldy #>LoadList_NoEnding.b
LC465:
    jsr LB2B6
    ; jump to reset vector, likely ENDPGM_RESET
    jmp ($DFFC)



LC46B:
    pha
    pha
    cpy #$02
    beq LC4AB
    lda CurSamusStat.SaveSlot
    pha
    lda #$02
    sta CurSamusStat.SaveSlot
    LC47A:
        jsr LC50B
        jsr LC516
        lda #$00
        sta MENSAVE_C3C0@0.TankCount,y
        sta MENSAVE_C3C0@0.SamusGear,y
        sta MENSAVE_C3C0@0.MissileCount,y
        ; (BUG! this should be saved to SaveSlot, not MaxMissiles)
        lda CurSamusStat.SaveSlot
        sta MENSAVE_C3C0@0.MaxMissiles,y
        dec CurSamusStat.SaveSlot
        bpl LC47A
    pla
    sta $B41F
    jsr LC50B
    jsr LC4F6
    lda #$01
    sta CurSamusStat.byteE
    ldy LC50A
    sta MENSAVE_C3C0@0.byteE,y
LC4AB:
    jsr LC50B
    lda CurSamusStat.byteE
    bpl LC4C0
        and #$01
        sta CurSamusStat.byteE
        jsr LC516
        lda #$01
        sta MENSAVE_C3C0@0.MissileCount,y
    LC4C0:
    lda $1E
    cmp #$01
    beq LC4E6
    lda $6E
    jsr LC53B
    ldy #$3F
    LC4CD:
        lda $B420,y
        sta ($00),y
        dey
        bpl LC4CD
    ldy LC50A
    ldx #$00
    LC4DA:
        lda CurSamusStat,x
        sta MENSAVE_C3C0@0,y
        iny
        inx
        cpx #$10
        bne LC4DA
LC4E6:
    pla
    jsr LC53B
    ldy #$3F
    LC4EC:
        lda ($00),y
        sta $B420,y
        dey
        bpl LC4EC
    bmi LC4F7
LC4F6:
    pha
LC4F7:
    ldy LC50A
    ldx #$00
    LC4FC:
        lda MENSAVE_C3C0@0,y
        sta CurSamusStat,x
        iny
        inx
        cpx #$10
        bne LC4FC
    pla
    rts



LC50A: ; variable related to SamusStat.byteE
    .byte $00



LC50B:
    lda CurSamusStat.SaveSlot
    asl a
    asl a
    asl a
    asl a
    sta LC50A
    rts



LC516:
    lda #$00
    jsr LC53B
    inc $03
    ldy #$00
    tya
LC520:
    sta ($00),y
    cpy #$40
    bcs LC528
        sta ($02),y
    LC528:
    iny
    bne LC520
    ldy LC50A
    ldx #$00
    txa
    LC531:
        sta $C3C0,y
        iny
        inx
        cpx #$0C
        bne LC531
    rts



LC53B:
    pha
    ldx CurSamusStat.SaveSlot
    lda LC562,x
    sta $00
    sta $02
    lda LC565,x
    sta $01
    sta $03
    pla
    and #$0F
    tax
    beq RTS_C561
    LC553:
        lda $00
        clc
        adc #$40
        sta $00
        bcc LC55E
            inc $01
        LC55E:
        dex
        bne LC553
RTS_C561:
    rts

LC562:
    .byte <MENSAVE_C000, <MENSAVE_C140, <MENSAVE_C280
LC565:
    .byte >MENSAVE_C000, >MENSAVE_C140, >MENSAVE_C280



ChooseEnding: ;($C568)
    ldy CurSamusStat.byteC
    bne LC56E
        rts
    LC56E:
    ldy CurSamusStat.EndingType
    bne LC585
    beq LC584
    LC575:
        lda #$00
        cmp CurSamusStat.SamusAge+3
        bcc LC589
        lda AgeTable-1,y
        cmp CurSamusStat.SamusAge+2
        bcc LC589
    LC584:
        iny
    LC585:
        cpy #$05
        bne LC575
LC589:
    sty CurSamusStat.EndingType
    ldy #$00
    tya
    LC58F:
        sta CurSamusStat,y
        iny
        cpy #$0C
        bne LC58F
    rts


AgeTable: ;($C598)
    .byte $3C   ; 27 h 35 min
    .byte $0A   ; 4 h 35 min
    .byte $04   ; 1 h 50 min
    .byte $02   ; 55 min


.byte $0A, $00, $B0, $07



FDSFileMacroPart3

