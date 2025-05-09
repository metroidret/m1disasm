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

;---------------------------------------------[ Import ]---------------------------------------------

.import Startup
.import NMI
.import ChooseRoutine
.import Adiv32
.import Adiv16
.import Adiv8
.import Amul16
.import TwosComplement
.import Base10Subtract
.import SubtractHealth
.import SetProjectileAnim
.import SetProjectileAnim2
.import UpdateEnemyAnim
.import VerticalRoomCentered
.import EnemyCheckMoveUp
.import EnemyCheckMoveDown
.import EnemyCheckMoveLeft
.import EnemyCheckMoveRight
.import ExitSub
.import AnimDrawObject
.import SFX_Door
.import OrEnData05
.import ReadTableAt968B
.import MapScrollRoutine
.import MotherBrainMusic
.import TourianMusic
.import SelectSamusPal
.import MakeCartRAMPtr
.import LDD8B
.import LE449
.import LEB6E
.import LF410
.import LF416
.import LF438
.import LF68D
.import LF83E
.import LF852
.import LF85A
.import LF870
.import LFA1E
.import LFB70
.import LFB88
.import LFBB9
.import LFBCA
.import LFD8F
.import DrawTileBlast

;-----------------------------------------[ Start of code ]------------------------------------------

; These first three all jump to different points within the same procedure
CommonJump_00: ;$8000 (yes anim, yes common AI)
    jmp LF410
CommonJump_01: ;$8003 (yes anim, no common AI)
    jmp LF438
CommonJump_02: ;$8006 (no anim, no common AI)
    jmp LF416
CommonJump_03: ;$8009
    jmp LF852
CommonJump_UpdateEnemyAnim: ;$800C
    jmp UpdateEnemyAnim             ;($E094)
CommonJump_05: ;$800F
    jmp LF68D
CommonJump_06: ;$8012
    jmp LF83E
CommonJump_07: ;$8015
    jmp LF85A
CommonJump_08: ;$8018
    jmp LFBB9
CommonJump_09: ;$801B
    jmp LFB88
CommonJump_0A: ;$801E
    jmp LFBCA
CommonJump_0B: ;$8021
    jmp LF870
CommonJump_ChooseRoutine: ;$8024
    jmp ChooseRoutine               ;($C27C)
CommonJump_0D: ;$8027
    jmp LFD8F
CommonJump_0E: ;$802A
    jmp LEB6E
CommonJump_VertMoveProc: ;$802D
    jmp VertMoveProc
CommonJump_HoriMoveProc: ;$8030
    jmp HoriMoveProc
CommonJump_11: ;$8033
    jmp LFA1E
CommonJump_12: ;$8036
    jmp L833F
CommonJump_13: ;$8039
    jmp L8395
CommonJump_14: ;$803C
    jmp LDD8B
CommonJump_DrawTileBlast: ;$803F
    jmp DrawTileBlast
CommonJump_SubtractHealth: ;$8042
    jmp SubtractHealth              ;($CE92)
CommonJump_Base10Subtract: ;$8045
    jmp Base10Subtract              ;($C3FB)

; Crawler jump table
CrawlerMovementRoutinesTable:
    .word L84FE-1 ; right
    .word L84A7-1 ; left
    .word L844B-1 ; down
    .word L844B-1 ; down
    .word L84A7-1 ; right
    .word L84FE-1 ; left
    .word L83F5-1 ; up
    .word L83F5-1 ; up

;-------------------------------------------------------------------------------
; A common enemy AI/movement routine
; called by F410 in the engine, via CommonJump_00
CommonEnemyAI:
; Set x to point to enemy
    ldx PageIndex
; Exit if bit 6 of EnData05 is set
    lda EnData05,x
    asl
    bmi CommonEnemyAI_Exit
; Exit if enemy is not active
    lda EnStatus,x
    cmp #$02
    bne CommonEnemyAI_Exit

    jsr VertMoveProc
    lda $00
    bpl CommonEnemyAI_BranchA
    jsr TwosComplement              ;($C3D4)
    sta Enemy66

; Up Movement
CommonEnemyAI_LoopA:
    jsr L83F5 ; Move one pixel
    jsr L80B8 ; Determine something about the next pixel moved (?0)
    dec Enemy66
    bne CommonEnemyAI_LoopA

CommonEnemyAI_BranchA:
    beq CommonEnemyAI_BranchB
    sta Enemy66

; Down Movement
CommonEnemyAI_LoopB:
    jsr L844B
    jsr L80FB
    dec Enemy66
    bne CommonEnemyAI_LoopB

CommonEnemyAI_BranchB:
    jsr HoriMoveProc
    lda $00
    bpl CommonEnemyAI_BranchC
    jsr TwosComplement              ;($C3D4)
    sta Enemy66

; Left Movement
CommonEnemyAI_LoopC:
    jsr L84A7
    jsr L816E
    dec Enemy66
    bne CommonEnemyAI_LoopC

CommonEnemyAI_BranchC:
    beq CommonEnemyAI_Exit
    sta Enemy66

; Right Movement
CommonEnemyAI_LoopD:
    jsr L84FE
    jsr L8134
    dec Enemy66
    bne CommonEnemyAI_LoopD

CommonEnemyAI_Exit:
    rts

;-------------------------------------------------------------------------------
; A = TableAtL977B[EnemyType]*2
LoadTableAt977B: ; L80B0
    ldy EnDataIndex,x
    lda L977B,y
    asl                             ;*2
    rts

;-------------------------------------------------------------------------------
; Up movement related ?
L80B8:
    ldx PageIndex
    bcs RTS_80FA ; If MoveUpOnePixel returned the carry flag, exit
; Otherwise, do stuff, and make sure it doesn't move anymore pixels the rest of this frame
    lda EnData05,x
    bpl L80C7

L80C1:
    jsr L81FC
    jmp L80F6

L80C7:
    jsr LoadTableAt977B
    bpl L80EA
    lda EnData1F,x
    beq L80C1

    bpl L80D8
    jsr SetBit5OfEnData05_AndClearEnData1A
    beq L80E2

L80D8:
    sec
    ror EnData02,x
    ror EnCounter,x
    jmp L80F6

L80E2:
    sta EnData02,x
    sta EnCounter,x
    beq L80F6

L80EA:
    lda L977B,y
    lsr
    lsr
    bcc L80F6
    lda #$04
    jsr XorEnData05

L80F6:
    lda #$01
    sta Enemy66

RTS_80FA:
    rts
;-------------------------------------------------------------------------------
; Down movement related?
L80FB:
    ldx PageIndex
    bcs RTS_8133
    lda EnData05,x
    bpl L810A
L8104:
    jsr L81FC
    jmp L812F
L810A:
    jsr LoadTableAt977B
    bpl L8123
    lda EnData1F,x
    beq L8104
    bpl L8120
    clc
    ror EnData02,x
    ror EnCounter,x
    jmp L812F

L8120:
    jsr SetBit5OfEnData05_AndClearEnData1A
L8123:
    lda L977B,y
    lsr
    lsr
    bcc L812F
    lda #$04
    jsr XorEnData05

L812F:
    lda #$01
    sta Enemy66
RTS_8133:
    rts

;-------------------------------------------------------------------------------
; Right movement related ?
L8134:
    ldx PageIndex
    bcs RTS_816D

    jsr LoadTableAt977B
    bpl L815E
    lda EnData05,x
    bmi L8148
L8142:
    jsr L81C7
    jmp L8169
L8148:
    lda EnData1F,x
    beq L8142
    bpl L8159
    clc
    ror EnData03,x
    ror EnData07,x
    jmp L8169

L8159:
    jsr SetBit5OfEnData05_AndClearEnData1B
    beq L8169
L815E:
    lda $977B,y
    lsr
    bcc L8169
    lda #$01
    jsr XorEnData05

L8169:
    lda #$01
    sta Enemy66

RTS_816D:
    rts

;-------------------------------------------------------------------------------
; Left Movement related?
L816E:
    ldx PageIndex
    bcs RTS_81B0
    jsr LoadTableAt977B
    bpl L81A0
    lda EnData05,x
    bmi L8182
L817C:
    jsr L81C7
    jmp L81AC
L8182:
    lda EnData1F,x
    beq L817C
    bpl L818E
        jsr SetBit5OfEnData05_AndClearEnData1B
        beq L8198
    L818E:
    sec
    ror EnData03,x
    ror EnData07,x
    jmp L81AC

L8198:
    sta EnData03,x
    sta EnData07,x
    beq L81AC
L81A0:
    jsr LoadTableAt977B
    lsr
    lsr
    bcc L81AC
    lda #$01
    jsr XorEnData05

L81AC:
    lda #$01
    sta Enemy66
RTS_81B0:
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnData1A:
    jsr SetBit5OfEnData05
    sta EnData1A,x
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05:
    lda #$20
    jsr OrEnData05
    lda #$00
    rts

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnData1B:
    jsr SetBit5OfEnData05
    sta EnData1B,x
    rts

;-------------------------------------------------------------------------------
; Horizontal Movement Related
L81C7:
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    lda #$01
    jsr XorEnData05
    lda EnData1B,x
    jsr TwosComplement
    sta EnData1B,x

    jsr LoadBit5ofTableAt968B
    bne RTS_81F5
    jsr LoadTableAt977B
    sec
    bpl L81ED
; Decrement EnCounterX
    lda #$00
    sbc EnData07,x
    sta EnData07,x
; Decrement EnSpeedX (if carry is set)
L81ED:
    lda #$00
    sbc EnData03,x
    sta EnData03,x

RTS_81F5:
    rts

;-------------------------------------------------------------------------------
LoadBit5ofTableAt968B:
    jsr ReadTableAt968B
    and #$20
    rts

;-------------------------------------------------------------------------------
; Vertical Movement Related
L81FC:
    jsr LoadBit5ofTableAt968B
    bne RTS_81F5 ; Exit if bit 5 is set
    lda #$04
    jsr XorEnData05
    lda EnData1A,x
    jsr TwosComplement
    sta EnData1A,x

    jsr LoadBit5ofTableAt968B
    bne RTS_822A ; Exit if bit 5 is set
    jsr LoadTableAt977B
    sec
    bpl L8222
; Decrement EnCounter
    lda #$00
    sbc EnCounter,x
    sta EnCounter,x
; Decrement EnSpeedY (if EnCounter rolls over)
L8222:
    lda #$00
    sbc EnData02,x
    sta EnData02,x
RTS_822A:
    rts

;-------------------------------------------------------------------------------
; Loads a pointer from this table to $81 and $82
LoadEnemyMovementPtr:
    lda EnData05,x
    bpl L8232
        lsr
        lsr
    L8232:
    lsr
    lda EnData08,x
    rol
    asl
    tay
    lda EnemyMovementPtrs,y
    sta $81
    lda EnemyMovementPtrs+1,y
    sta $82
    rts

;-------------------------------------------------------------------------------
; Vertical Movement Related ?
; Determines y-delta for a given frame
VertMoveProc:
    jsr LoadTableAt977B
    bpl L824C
        jmp L833F

    L824C:
    lda EnData05,x
    and #$20
    eor #$20
    beq L82A2

    jsr LoadEnemyMovementPtr ; Puts a pointer at $81
L8258:
    ldy EnCounter,x
VertMoveProc_ReadByte:
    lda ($81),y

;CommonCase
; Branch if the value is <$F0
    cmp #$F0
    bcc VertMoveProc_CommonCase

;CaseFA
    cmp #$FA
    beq VertMoveProc_JumpToCaseFA

;CaseFB
    cmp #$FB
    beq VertMoveProc_CaseFB

;CaseFC
    cmp #$FC
    beq VertMoveProc_CaseFC

;CaseFD
    cmp #$FD
    beq VertMoveProc_CaseFD

;CaseFE
    cmp #$FE
    beq VertMoveProc_CaseFE

;Default case
; Reset enemy counter
    lda #$00
    sta EnCounter,x
    beq L8258

;---------------------------------------
VertMoveProc_JumpToCaseFA: ; L827C
    jmp VertMoveProc_CaseFA

;---------------------------------------
VertMoveProc_CommonCase:
; Take the value from memory
; Branch ahead if velocityString[EnCounter] - EnDelay != 0
    sec
    sbc EnDelay,x
    bne L8290

    sta EnDelay,x
; EnCounter += 2
    iny
    iny
    tya
    sta EnCounter,x
    bne VertMoveProc_ReadByte ; Handle another byte

; Increment EnDelay
L8290:
    inc EnDelay,x

; Read the sign/magnitude of the speed from the next byte
    iny
    lda ($81),y

; Save the sign bit to the carry flag
    asl
    php
; Get the magnitude
    jsr Adiv32                      ;($C2BE)Divide by 32.
; Negate the magnitude if necessary
    plp
    bcc L82A2
    eor #$FF
    adc #$00 ; Since carry is set in this branch, this increments A
; Store this frame's delta-y in temp
L82A2:
    sta $00
    rts

;---------------------------------------
; Clear EnData1D, move on to next byte in the stream
VertMoveProc_CaseFD:
    inc EnCounter,x
    iny
    lda #$00
    sta EnData1D,x
    beq VertMoveProc_ReadByte ; Branch always

;---------------------------------------
; Don't move, and don't advance the movement counter
; HALT, perhaps?
VertMoveProc_CaseFB:
; Double RTS !?
    pla
    pla
    rts
; Retruns back to F416 in the engine bank

;---------------------------------------
; Repeat Previous Movement Until [Condition?]
VertMoveProc_CaseFC:
; If bit 7 of EnData1F is set, then check if you can move up and then jump ahead
    lda EnData1F,x
    bpl L82BE
    jsr EnemyCheckMoveUp
    jmp L82C3
; If EnData1F is non-zero, check if you can move down and then jump ahead
L82BE:
    beq L82D2
    jsr EnemyCheckMoveDown

; If the movement check [succeeded? failed?] move on to the next byte
L82C3:
    ldx PageIndex
    bcs L82D2
    ldy EnCounter,x
    iny
    lda #$00
    sta EnData1F,x
    beq L82D7 ; Branch always

; Else, repeat the previous two bytes
L82D2:
    ldy EnCounter,x
    dey
    dey

; Save EnCounter
L82D7:
    tya
    sta EnCounter,x
; Read the next bytes
    jmp VertMoveProc_ReadByte

;---------------------------------------
; Repeat previous until ???
VertMoveProc_CaseFE:
; Move EnCounter back to the previous movement
    dey
    dey
    tya
    sta EnCounter,x
; Then do some other stuff
    lda EnData1F,x
    bpl L82EF
    jsr EnemyCheckMoveUp
    jmp L82F4

L82EF:
    beq L82FB
    jsr EnemyCheckMoveDown

L82F4:
    ldx PageIndex
    bcc L82FB
    jmp L8258

L82FB:
    ldy EnDataIndex,x
    lda L968B,y
    and #$20
    beq VertMoveProc_CaseFA
    lda EnData05,x
    eor #$05
    ora L968B,y
    and #$1F
    sta EnData05,x

;---------------------------------------
;SetBit5OfEnData05_AndClearEnData1A
; Move horizontally indefinitely (???)
; Is this even used?
VertMoveProc_CaseFA:
    jsr SetBit5OfEnData05_AndClearEnData1A
    jmp L82A2 ; Set delta-y to zero and exit

;-------------------------------------------------------------------------------
; Horizontal Movement Related?
HoriMoveProc:
    jsr LoadTableAt977B
    bpl L8320
    jmp L8395

; If bit 5 of EnData05 is clear, don't move horizontally
L8320:
    lda EnData05,x
    and #$20
    eor #$20
    beq L833C

; Read the same velocity byte as in VertMoveProc
    ldy EnCounter,x
    iny
    lda ($81),y ; $81/$82 were loaded during VertMoveProc earlier
    tax
; Save the sign bit to the processor flags
    and #$08
    php
    txa
; Get the lower three bits
    and #$07
    plp
; Negate, according to the sign bit
    beq L833C
    jsr TwosComplement

L833C:
    sta $00
    rts

;-------------------------------------------------------------------------------
; Nonsense with counters and velocity to substitute for a lack of subpixels?
; Vertical case?
L833F:
    ldy #$0E
    lda EnData1A,x
    bmi L835E
    clc
    adc EnCounter,x
    sta EnCounter,x
    lda EnData02,x
    adc #$00
    sta EnData02,x
    bpl L8376
    L8357:
        jsr TwosComplement
        ldy #$F2
        bne L8376
    L835E:
        jsr TwosComplement
        sec
        sta $00
        lda EnCounter,x
        sbc $00
        sta EnCounter,x
        lda EnData02,x
        sbc #$00
        sta EnData02,x
        bmi L8357
L8376:
    cmp #$0E
    bcc L8383
        lda #$00
        sta EnCounter,x
        tya
        sta EnData02,x
    L8383:
    lda EnData18,x
    clc
    adc EnCounter,x
    sta EnData18,x
    lda #$00
    adc EnData02,x
    sta $00
    rts

;-------------------------------------------------------------------------------
; Nonsense with counters and velocity to substitute for a lack of subpixels?
; Horizontal case?
L8395:
    lda #$00
    sta $00
    sta $02
    lda #$0E
    sta $01
    sta $03
    lda EnData07,x
    clc
    adc EnData1B,x
    sta EnData07,x
    sta $04
    lda #$00
    ldy EnData1B,x
    bpl L83B6
        lda #$FF
    L83B6:
    adc EnData03,x
    sta EnData03,x
    tay
    bpl L83D0
        lda #$00
        sec
        sbc EnData07,x
        sta $04
        lda #$00
        sbc EnData03,x
        tay
        jsr LE449
    L83D0:
    lda $04
    cmp $02
    tya
    sbc $03
    bcc L83E3
        lda $00
        sta EnData07,x
        lda $01
        sta EnData03,x
    L83E3:
    lda EnData19,x
    clc
    adc EnData07,x
    sta EnData19,x
    lda #$00
    adc EnData03,x
    sta $00
    rts

;-------------------------------------------------------------------------------
; Up movement related
; Move one pixel?
L83F5:
    ldx PageIndex
    lda EnYRoomPos,x
    sec
    sbc EnRadY,x
    and #$07
    sec
    bne L8406
        jsr EnemyCheckMoveUp
    L8406:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_844A
    inc $00
    ldy EnYRoomPos,x
    bne L8429
    ldy #$F0
    lda ScrollDir
    cmp #$02
    bcs L8429
    lda ScrollY
    beq RTS_844A
    jsr GetOtherNameTableIndex
    beq RTS_844A
    jsr SwitchEnemyNameTable
L8429:
    dey
    tya
    sta EnYRoomPos,x
    cmp EnRadY,x
    bne L8441

    lda ScrollY
    beq L843C
        jsr GetOtherNameTableIndex
        bne L8441
    L843C:
    inc EnYRoomPos,x
    clc
    rts
L8441:
    lda EnData05,x
    bmi L8449
        inc EnData1D,x
    L8449:
    sec
RTS_844A:
    rts

;-------------------------------------------------------------------------------
; Down movement related ?
L844B:
    ldx PageIndex
    lda EnYRoomPos,x
    clc
    adc EnRadY,x
    and #$07
    sec
    bne L845C
        jsr EnemyCheckMoveDown
    L845C:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_84A6
    inc $00
    ldy EnYRoomPos,x
    cpy #$EF
    bne L8481
    ldy #$FF
    lda ScrollDir
    cmp #$02
    bcs L8481
    lda ScrollY
    beq RTS_84A6
    jsr GetOtherNameTableIndex
    bne RTS_84A6
    jsr SwitchEnemyNameTable
L8481:
    iny
    tya
    sta EnYRoomPos,x
    clc
    adc EnRadY,x
    cmp #$EF
    bne L849D
    lda ScrollY
    beq L8497
        jsr GetOtherNameTableIndex
        beq L849D
    L8497:
    dec EnYRoomPos,x
    clc
    bcc RTS_84A6
L849D:
    lda EnData05,x
    bmi L84A5
        dec EnData1D,x
    L84A5:
    sec
RTS_84A6:
    rts

;-------------------------------------------------------------------------------
; Left movement related
L84A7:
    ldx PageIndex
    lda EnXRoomPos,x
    sec
    sbc EnRadX,x
    and #$07
    sec
    bne L84B8
        jsr EnemyCheckMoveLeft
    L84B8:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_84FD
    inc $00
    ldy EnXRoomPos,x
    bne L84DA
    lda ScrollDir
    cmp #$02
    bcc L84DA
    lda ScrollX
    beq L84D4
        jsr GetOtherNameTableIndex
    L84D4:
    clc
    beq RTS_84FD
    jsr SwitchEnemyNameTable
L84DA:
    dec EnXRoomPos,x
    lda EnXRoomPos,x
    cmp EnRadX,x
    bne L84F4
    lda ScrollX
    beq L84EE
        jsr GetOtherNameTableIndex
        bne L84F4
    L84EE:
    inc EnXRoomPos,x
    clc
    bcc RTS_84FD
L84F4:
    lda EnData05,x
    bpl L84FC
        inc EnData1D,x
    L84FC:
    sec
RTS_84FD:
    rts

;-------------------------------------------------------------------------------
; Right movement related
L84FE:
    ldx PageIndex
; if ((xpos + xrad) % 8) == 0, then EnemyCheckMoveRight()
    lda EnXRoomPos,x
    clc
    adc EnRadX,x
    and #$07
    sec
    bne L850F
        jsr EnemyCheckMoveRight
    L850F:
    ldy #$00
    sty $00
    ldx PageIndex
    bcc RTS_8559
    inc $00
    inc EnXRoomPos,x
    bne L8536
    lda ScrollDir
    cmp #$02
    bcc L8536
    lda ScrollX
    beq L852D
        jsr GetOtherNameTableIndex
        beq L8533
    L852D:
        dec EnXRoomPos,x
        clc
        bcc RTS_8559
    L8533:
    jsr SwitchEnemyNameTable

L8536:
    lda EnXRoomPos,x
    clc
    adc EnRadX,x
    cmp #$FF
    bne L8550
    lda ScrollX
    beq L854A
        jsr GetOtherNameTableIndex
        beq L8550
    L854A:
    dec EnXRoomPos,x
    clc
    bcc RTS_8559

L8550:
    lda EnData05,x
    bpl L8558
        dec EnData1D,x
    L8558:
    sec
RTS_8559:
    rts

;-------------------------------------------------------------------------------
SwitchEnemyNameTable: ; L855A
    lda EnNameTable,x
    eor #$01
    sta EnNameTable,x
    rts

;-------------------------------------------------------------------------------
; Returns the index to the other nametable in A
GetOtherNameTableIndex: ; L8562
    lda EnNameTable,x
    eor PPUCTRL_ZP
    and #$01
    rts

;-------------------------------------------------------------------------------
; XORs the contents of EnData05 with the bitmask in A
XorEnData05: ; L856B
    eor EnData05,x
    sta EnData05,x
    rts

;---------------------------------[ Object animation data tables ]----------------------------------
;----------------------------[ Sprite drawing pointer tables ]--------------------------------------
;------------------------------[ Sprite placement data tables ]-------------------------------------
;-------------------------------[ Sprite frame data tables ]---------------------------------------
.include "common_sprite_data.asm"

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
    lda DoorStatus                  ;The code determines if Samus has entered a door if the-->
    bne RTS_8B6C                       ;door status is 0, but door data information has been-->
    ldy SamusDoorData               ;written. If both conditions are met, Samus has just-->
    beq RTS_8B6C                       ;entered a door.
    sta CurrentMissilePickups       ;
    sta CurrentEnergyPickups        ;Reset current missile and energy power-up counters.
    lda RandomNumber1               ;
    and #$0F                        ;Randomly recalculate max missile pickups(16 max, 0 min).
    sta MaxMissilePickup            ;
    asl                             ;
    ora #$40                        ;*2 for energy pickups and set bit 6(128 max, 64 min).
    sta MaxEnergyPickup             ;
    lda PPUCTRL_ZP                   ;
    eor #$01                        ;
    and #$01                        ;Erase name table door data for new room.
    tay                             ;
    lsr                             ;
    sta DoorOnNameTable3,y                     ;
    lda ScrollDir                   ;
    and #$02                        ;Is Samus scrolling horizontally?-->
    bne L8B4B                       ;If so, branch.
        ldx #$04                        ;Samus currently scrolling vertically.
        lda ScrollY                     ;Is room centered on screen?-->
        beq L8B6D                       ;If so, branch.
        lda PPUCTRL_ZP                         ;
        eor ObjectHi                    ;Get inverse of Samus' current nametable.
        lsr                             ;
        bcc SetDoorEntryInfo                       ;If Samus is on nametable 3, branch.
        bcs L8B52                       ;If Samus is on nametable 0, branch to decrement x.

    L8B4B:
        ldx #$02                        ;Samus is currently scrolling horizontally.
        lda ObjectX                     ;Is Samus entering a left hand door?-->
        bpl SetDoorEntryInfo                       ;If so, branch.
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
    ora ObjAction                   ;Keep Samus action so she will appear the same comming-->
    sta SamusDoorData               ;out of the door as she did going in.
    lda #$05                        ;
    sta ObjAction                   ;Indicate Samus is in a door.
RTS_8B6C:
    rts                             ;

L8B6D:
    jsr SetDoorEntryInfo            ;($8B53)Save Samus action and set door entry timer.
    jsr VerticalRoomCentered        ;($E21B)Room is centered. Toggle scroll.

    txa                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
    ora #$80                        ;Set MSB of DoorStatus to indicate Samus has just-->
    sta DoorStatus                  ;entered a door.
    rts                             ;

;----------------------------------------------------------------------------------------------------
DisplayDoors:
    ldx #$B0
    L8B7B:
        jsr DoorRoutine
        lda PageIndex
        sec
        sbc #$10
        tax
        bmi L8B7B
    rts

DoorRoutine:
    stx PageIndex
    lda ObjAction,x
    jsr ChooseRoutine               ;($C27C)
        .word ExitSub
        .word DoorAction0
        .word DoorAction1
        .word DoorAction2
        .word DoorAction3
        .word DoorAction4
        .word DoorAction5

DoorAction0:
    inc ObjAction,x
    lda #$30
    jsr SetProjectileAnim           ;($D2FA)
    jsr WriteDoorBGTiles_Solid
    ldy $0307,x ; Unsure if $0307 is semantically comparable to SamusOnElevator
    lda ObjActionAnimTable,y
    sta $030F,x
ObjActionSubRoutine8BB1:
    lda $0307,x
    cmp #$03
    bne L8BBA
        lda #$01
    L8BBA:
    ora #$A0
    sta ObjectCntrl
    lda #$00
    sta $030A,x ; SamusHit (DoorHit?)
    txa
    and #$10
    eor #$10
    ora ObjectCntrl
    sta ObjectCntrl
    lda #$06
    jmp AnimDrawObject

ObjActionAnimTable:
    .byte $05, $01, $0A, $01

DoorAction1:
    lda $030A,x
    and #$04
    beq ObjActionSubRoutine8BB1
    dec $030F,x
    bne ObjActionSubRoutine8BB1
    lda #$03
    cmp $0307,x
    bne L8BEE
        ldy EndTimer+1
        iny
        bne ObjActionSubRoutine8BB1
    L8BEE:
    sta ObjAction,x
    lda #$50
    sta $030F,x
    lda #$2C
    sta $0305,x
    sec
    sbc #$03
    jmp ObjActionSubRoutine8C7E

DoorAction2:
    lda DoorStatus
    beq L8C1D
    lda $030C ; ObjNametable
    eor $030C,x
    lsr
    bcs L8C1D
    lda $030E
    eor $030E,x
    bmi L8C1D
    lda #$04
    sta ObjAction,x
    bne L8C73
L8C1D:
    lda $0306,x
    cmp $0305,x
    bcc L8C73
    lda $030F,x
    cmp #$50
    bne L8C57
    jsr WriteDoorBGTiles_Air
    lda $0307,x
    cmp #$01
    beq L8C57
    cmp #$03
    beq L8C57
    lda #$0A
    sta $09
    lda $030C,x
    sta $08
    ldy MapPosX
    txa
    jsr Amul16
    bcc L8C4C
        dey
    L8C4C:
    tya
    jsr MapScrollRoutine
    lda #$00
    sta ObjAction,x
    beq L8C73
L8C57:
    lda $2D
    lsr
    bcs L8C73
    dec $030F,x
    bne L8C73
ObjActionSubRoutine8C61:
    lda #$01
    sta $030F,x
    jsr WriteDoorBGTiles_Solid
    lda #$02
    sta ObjAction,x
    jsr ObjActionSubRoutine8C76
ObjActionSubRoutine8C71:
    ldx PageIndex
L8C73:
    jmp ObjActionSubRoutine8BB1

ObjActionSubRoutine8C76:
    lda #$30
    sta $0305,x
    sec
    sbc #$02
ObjActionSubRoutine8C7E:
    jsr SetProjectileAnim2
    jmp SFX_Door

DoorAction3:
    lda DoorStatus
    cmp #$05
    bcs L8CC3
    jsr WriteDoorBGTiles_Solid
    jsr ObjActionSubRoutine8C76
    ldx PageIndex
    lda $91
    beq L8CA7
    txa
    jsr Adiv16
    eor $91
    lsr
    bcc L8CA7
    lda $76
    eor #$07
    sta $76
    sta $1C
L8CA7:
    inc ObjAction,x
    lda #$00
    sta $91
    lda $0307,x
    cmp #$03
    bne L8CC3
    txa
    jsr Amul16
    bcs L8CC0
        jsr TourianMusic
        bne L8CC3
    L8CC0:
    jsr MotherBrainMusic
L8CC3:
    jmp ObjActionSubRoutine8C71

DoorAction4:
    lda DoorStatus
    cmp #$05
    bne L8CED
    txa
    eor #$10
    tax
    lda #$06
    sta ObjAction,x
    lda #$2C
    sta $0305,x
    sec
    sbc #$03
    jsr SetProjectileAnim2
    jsr SFX_Door
    jsr SelectSamusPal
    ldx PageIndex
    lda #$02
    sta ObjAction,x
L8CED:
    jmp ObjActionSubRoutine8BB1

DoorAction5:
    lda DoorStatus
    bne L8CED
    jmp ObjActionSubRoutine8C61

WriteDoorBGTiles_Air:
    lda #$FF ; air blank tile
    bne WriteDoorBGTiles_Common
WriteDoorBGTiles_Solid:
    lda #$4E ; solid blank tile
WriteDoorBGTiles_Common:
    ; get cart ram pointer of door
    pha
    ; door y coordinate
    lda #$50
    sta $02
    ; door x coordinate (depends on bit 4 of object slot address)
    txa
    jsr Adiv16
    and #$01
    tay
    lda DoorXTable,y
    sta $03
    ; door nametable
    lda ObjectHi,x
    sta $0B
    ; call
    jsr MakeCartRAMPtr
    ldy #$00 ; init y for loop
    pla
    ; cart ram pointer of door is now in $04-$05
    ; write 6 air or solid blank tiles in a vertical line to cart ram
    @loop:
        sta ($04),y
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
    lda $04
    sta DoorCartRAMPtr,y
    lda $05
    sta DoorCartRAMPtr+1,y
    rts

; x coordinate of door in pixels
DoorXTable:
    .byte $E8, $10

.byte $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9
.byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
.byte $85, $00, $AD, $97, $69, $29

; EoF
