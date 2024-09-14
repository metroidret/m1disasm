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
.import TwosCompliment
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
.import LFEDC

;-----------------------------------------[ Start of code ]------------------------------------------

; These first three all jump to different points within the same procedure
CommonJump_00: ;$8000
    JMP LF410
CommonJump_01: ;$8003
    JMP LF438
CommonJump_02: ;$8006
    JMP LF416
CommonJump_03: ;$8009
    JMP LF852
CommonJump_UpdateEnemyAnim: ;$800C
    JMP UpdateEnemyAnim             ;($E094)
CommonJump_05: ;$800F
    JMP LF68D
CommonJump_06: ;$8012
    JMP LF83E
CommonJump_07: ;$8015
    JMP LF85A
CommonJump_08: ;$8018
    JMP LFBB9
CommonJump_09: ;$801B
    JMP LFB88
CommonJump_0A: ;$801E
    JMP LFBCA
CommonJump_0B: ;$8021
    JMP LF870
CommonJump_ChooseRoutine: ;$8024
    JMP ChooseRoutine               ;($C27C)
CommonJump_0D: ;$8027
    JMP LFD8F
CommonJump_0E: ;$802A
    JMP LEB6E
CommonJump_VertMoveProc: ;$802D
    JMP VertMoveProc
CommonJump_HoriMoveProc: ;$8030
    JMP HoriMoveProc
CommonJump_11: ;$8033
    JMP LFA1E
CommonJump_12: ;$8036
    JMP L833F
CommonJump_13: ;$8039
    JMP L8395
CommonJump_14: ;$803C
    JMP LDD8B
CommonJump_15: ;$803F
    JMP LFEDC
CommonJump_SubtractHealth: ;$8042
    JMP SubtractHealth              ;($CE92)
CommonJump_Base10Subtract: ;$8045
    JMP Base10Subtract              ;($C3FB)

; Zoomer jump table
L8048:  .word L84FE-1, L84A7-1, L844B-1, L844B-1, L84A7-1, L84FE-1, L83F5-1, L83F5-1

;-------------------------------------------------------------------------------
; A common enemy AI/movement routine
; called by F410 in the engine, via CommonJump_00
CommonEnemyAI:
; Set x to point to enemy
    LDX PageIndex
; Exit if bit 6 of EnData05 is set
    LDA EnData05,X
    ASL 
    BMI CommonEnemyAI_Exit
; Exit if enemy is not active
    LDA EnStatus,X
    CMP #$02
    BNE CommonEnemyAI_Exit

    JSR VertMoveProc
    LDA $00
    BPL CommonEnemyAI_BranchA
    JSR TwosCompliment              ;($C3D4)
    STA $66

; Up Movement
CommonEnemyAI_LoopA:
    JSR L83F5 ; Move one pixel
    JSR L80B8 ; Determine something about the next pixel moved (?0)
    DEC $66
    BNE CommonEnemyAI_LoopA

CommonEnemyAI_BranchA:
    BEQ CommonEnemyAI_BranchB
    STA $66

; Down Movement
CommonEnemyAI_LoopB:
    JSR L844B
    JSR L80FB
    DEC $66
    BNE CommonEnemyAI_LoopB

CommonEnemyAI_BranchB:
    JSR HoriMoveProc
    LDA $00
    BPL CommonEnemyAI_BranchC
    JSR TwosCompliment              ;($C3D4)
    STA $66

; Left Movement
CommonEnemyAI_LoopC:
    JSR L84A7
    JSR L816E
    DEC $66
    BNE CommonEnemyAI_LoopC

CommonEnemyAI_BranchC:
    BEQ CommonEnemyAI_Exit
    STA $66

; Right Movement
CommonEnemyAI_LoopD:
    JSR L84FE
    JSR L8134
    DEC $66
    BNE CommonEnemyAI_LoopD

CommonEnemyAI_Exit:
    RTS

;-------------------------------------------------------------------------------
; A = TableAtL977B[EnemyType]*2
LoadTableAt977B: ; L80B0
    LDY EnDataIndex,X
    LDA L977B,Y
    ASL                             ;*2 
    RTS

;-------------------------------------------------------------------------------
; Up movement related ?
L80B8:
    LDX PageIndex
    BCS L80FA ; If MoveUpOnePixel returned the carry flag, exit
; Otherwise, do stuff, and make sure it doesn't move anymore pixels the rest of this frame
    LDA EnData05,X
    BPL L80C7

L80C1:
    JSR L81FC
    JMP L80F6

L80C7:
    JSR LoadTableAt977B
    BPL L80EA
    LDA EnData1F,X
    BEQ L80C1

    BPL L80D8
    JSR SetBit5OfEnData05_AndClearEnData1A
    BEQ L80E2

L80D8:
    SEC 
    ROR EnData02,X
    ROR EnCounter,X
    JMP L80F6

L80E2:
    STA EnData02,X
    STA EnCounter,X
    BEQ L80F6

L80EA:
    LDA L977B,Y
    LSR 
    LSR 
    BCC L80F6
    LDA #$04
    JSR XorEnData05

L80F6:
    LDA #$01
    STA $66

L80FA:
    RTS
;-------------------------------------------------------------------------------
; Down movement related?
L80FB:
    LDX PageIndex
    BCS L8133
    LDA EnData05,X
    BPL L810A
L8104:
    JSR L81FC
    JMP L812F
L810A:
    JSR LoadTableAt977B
    BPL L8123
    LDA EnData1F,X
    BEQ L8104
    BPL L8120
    CLC 
    ROR EnData02,X
    ROR EnCounter,X
    JMP L812F

L8120:
    JSR SetBit5OfEnData05_AndClearEnData1A
L8123:
    LDA L977B,Y
    LSR 
    LSR 
    BCC L812F
    LDA #$04
    JSR XorEnData05

L812F:
    LDA #$01
    STA $66
L8133:
    RTS

;-------------------------------------------------------------------------------
; Right movement related ?
L8134:
    LDX PageIndex
    BCS L816D

    JSR LoadTableAt977B
    BPL L815E
    LDA EnData05,X
    BMI L8148
L8142:
    JSR L81C7
    JMP L8169
L8148:
    LDA EnData1F,X
    BEQ L8142
    BPL L8159
    CLC 
    ROR EnData03,X
    ROR EnData07,X
    JMP L8169

L8159:
    JSR SetBit5OfEnData05_AndClearEnData1B
    BEQ L8169
L815E:
    LDA $977B,Y
    LSR 
    BCC L8169
    LDA #$01
    JSR XorEnData05

L8169:
    LDA #$01
    STA $66

L816D:
    RTS

;-------------------------------------------------------------------------------
; Left Movement related?
L816E:
    LDX PageIndex
    BCS L81B0
    JSR LoadTableAt977B
    BPL L81A0
    LDA EnData05,X
    BMI L8182
L817C:
    JSR L81C7
    JMP L81AC
L8182:
    LDA EnData1F,X
    BEQ L817C
    BPL L818E
        JSR SetBit5OfEnData05_AndClearEnData1B
        BEQ L8198
    L818E:
    SEC 
    ROR EnData03,X
    ROR EnData07,X
    JMP L81AC

L8198:
    STA EnData03,X
    STA EnData07,X
    BEQ L81AC
L81A0:
    JSR LoadTableAt977B
    LSR 
    LSR 
    BCC L81AC
    LDA #$01
    JSR XorEnData05

L81AC:
    LDA #$01
    STA $66
L81B0:
    RTS

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnData1A:
    JSR SetBit5OfEnData05
    STA EnData1A,X
    RTS

;-------------------------------------------------------------------------------
SetBit5OfEnData05:
    LDA #$20
    JSR OrEnData05
    LDA #$00
    RTS

;-------------------------------------------------------------------------------
SetBit5OfEnData05_AndClearEnData1B:
    JSR SetBit5OfEnData05
    STA EnData1B,X
    RTS

;-------------------------------------------------------------------------------
; Horizontal Movement Related
L81C7:
    JSR LoadBit5ofTableAt968B
    BNE L81F5
    LDA #$01
    JSR XorEnData05
    LDA EnData1B,X
    JSR TwosCompliment
    STA EnData1B,X

    JSR LoadBit5ofTableAt968B
    BNE L81F5
    JSR LoadTableAt977B
    SEC 
    BPL L81ED
; Decrement EnCounterX
    LDA #$00
    SBC EnData07,X
    STA EnData07,X
; Decrement EnSpeedX (if carry is set)
L81ED:
    LDA #$00
    SBC EnData03,X
    STA EnData03,X

L81F5:
    RTS

;-------------------------------------------------------------------------------
LoadBit5ofTableAt968B:
    JSR ReadTableAt968B
    AND #$20
    RTS

;-------------------------------------------------------------------------------
; Vertical Movement Related
L81FC:
    JSR LoadBit5ofTableAt968B
    BNE L81F5 ; Exit if bit 5 is set
    LDA #$04
    JSR XorEnData05
    LDA EnData1A,X
    JSR TwosCompliment
    STA EnData1A,X

    JSR LoadBit5ofTableAt968B
    BNE L822A ; Exit if bit 5 is set
    JSR LoadTableAt977B
    SEC 
    BPL L8222
; Decrement EnCounter
    LDA #$00
    SBC EnCounter,X
    STA EnCounter,X
; Decrement EnSpeedY (if EnCounter rolls over)
L8222:
    LDA #$00
    SBC EnData02,X
    STA EnData02,X
L822A:
    RTS 

;-------------------------------------------------------------------------------
; Loads a pointer from this table to $81 and $82
LoadEnemyMovementPtr:
    LDA EnData05,X
    BPL L8232
        LSR 
        LSR 
    L8232:
    LSR 
    LDA EnData08,X
    ROL 
    ASL 
    TAY 
    LDA EnemyMovementPtrs,Y
    STA $81
    LDA EnemyMovementPtrs+1,Y
    STA $82
    RTS

;-------------------------------------------------------------------------------
; Vertical Movement Related ?
; Determines y-delta for a given frame
VertMoveProc:
    JSR LoadTableAt977B
    BPL L824C
        JMP L833F

    L824C:
    LDA EnData05,X
    AND #$20
    EOR #$20
    BEQ L82A2

    JSR LoadEnemyMovementPtr ; Puts a pointer at $81
L8258:
    LDY EnCounter,X
VertMoveProc_ReadByte:
    LDA ($81),Y

;CommonCase
; Branch if the value is <$F0
    CMP #$F0
    BCC VertMoveProc_CommonCase

;CaseFA
    CMP #$FA
    BEQ VertMoveProc_JumpToCaseFA

;CaseFB
    CMP #$FB
    BEQ VertMoveProc_CaseFB

;CaseFC
    CMP #$FC
    BEQ VertMoveProc_CaseFC

;CaseFD
    CMP #$FD
    BEQ VertMoveProc_CaseFD

;CaseFE
    CMP #$FE
    BEQ VertMoveProc_CaseFE

;Default case
; Reset enemy counter
    LDA #$00
    STA EnCounter,X
    BEQ L8258

;---------------------------------------
VertMoveProc_JumpToCaseFA: ; L827C
    JMP VertMoveProc_CaseFA

;---------------------------------------
VertMoveProc_CommonCase:
; Take the value from memory
; Branch ahead if velocityString[EnCounter] - EnDelay != 0
    SEC 
    SBC EnDelay,X
    BNE L8290

    STA EnDelay,X
; EnCounter += 2
    INY 
    INY 
    TYA 
    STA EnCounter,X
    BNE VertMoveProc_ReadByte ; Handle another byte

; Increment EnDelay
L8290:
    INC EnDelay,X

; Read the sign/magnitude of the speed from the next byte
    INY 
    LDA ($81),Y
; Save the sign bit to the carry flag
    ASL 
    PHP 
; Get the magnitude
    JSR Adiv32                      ;($C2BE)Divide by 32.
; Negate the magnitude if necessary
    PLP 
    BCC L82A2
    EOR #$FF
    ADC #$00 ; Since carry is set in this branch, this increments A
; Store this frame's delta-y in temp
L82A2:
    STA $00
    RTS

;---------------------------------------
; Clear EnData1D, move on to next byte in the stream
VertMoveProc_CaseFD:
    INC EnCounter,X
    INY 
    LDA #$00
    STA EnData1D,X
    BEQ VertMoveProc_ReadByte ; Branch always

;---------------------------------------
; Don't move, and don't advance the movement counter
; HALT, perhaps?
VertMoveProc_CaseFB:
; Double RTS !?
    PLA 
    PLA 
    RTS
; Retruns back to F416 in the engine bank

;---------------------------------------
; Repeat Previous Movement Until [Condition?]
VertMoveProc_CaseFC:
; If bit 7 of EnData1F is set, then check if you can move up and then jump ahead
    LDA EnData1F,X
    BPL L82BE
    JSR EnemyCheckMoveUp
    JMP L82C3
; If EnData1F is non-zero, check if you can move down and then jump ahead
L82BE:
    BEQ L82D2
    JSR EnemyCheckMoveDown

; If the movement check [succeeded? failed?] move on to the next byte
L82C3:
    LDX PageIndex
    BCS L82D2
    LDY EnCounter,X
    INY 
    LDA #$00
    STA EnData1F,X
    BEQ L82D7 ; Branch always

; Else, repeat the previous two bytes
L82D2:
    LDY EnCounter,X
    DEY 
    DEY 

; Save EnCounter
L82D7:
    TYA 
    STA EnCounter,X
; Read the next bytes
    JMP VertMoveProc_ReadByte

;---------------------------------------
; Repeat previous until ???
VertMoveProc_CaseFE:
; Move EnCounter back to the previous movement
    DEY 
    DEY 
    TYA 
    STA EnCounter,X
; Then do some other stuff
    LDA EnData1F,X
    BPL L82EF
    JSR EnemyCheckMoveUp
    JMP L82F4

L82EF:
    BEQ L82FB
    JSR EnemyCheckMoveDown

L82F4:
    LDX PageIndex
    BCC L82FB
    JMP L8258

L82FB:
    LDY EnDataIndex,X
    LDA L968B,Y
    AND #$20
    BEQ VertMoveProc_CaseFA
    LDA EnData05,X
    EOR #$05
    ORA L968B,Y
    AND #$1F
    STA EnData05,X

;---------------------------------------
;SetBit5OfEnData05_AndClearEnData1A
; Move horizontally indefinitely (???)
; Is this even used?
VertMoveProc_CaseFA:
    JSR SetBit5OfEnData05_AndClearEnData1A
    JMP L82A2 ; Set delta-y to zero and exit

;-------------------------------------------------------------------------------
; Horizontal Movement Related?
HoriMoveProc:
    JSR LoadTableAt977B
    BPL L8320
    JMP L8395

; If bit 5 of EnData05 is clear, don't move horizontally
L8320:
    LDA EnData05,X
    AND #$20
    EOR #$20
    BEQ L833C

; Read the same velocity byte as in VertMoveProc
    LDY EnCounter,X
    INY 
    LDA ($81),Y ; $81/$82 were loaded during VertMoveProc earlier
    TAX 
; Save the sign bit to the processor flags
    AND #$08
    PHP 
    TXA 
; Get the lower three bits
    AND #$07
    PLP 
; Negate, according to the sign bit
    BEQ L833C
    JSR TwosCompliment

L833C:
    STA $00
    RTS

;-------------------------------------------------------------------------------
; Nonsense with counters and velocity to substitute for a lack of subpixels?
; Vertical case?
L833F:
    LDY #$0E
    LDA EnData1A,X
    BMI L835E
    CLC 
    ADC EnCounter,X
    STA EnCounter,X
    LDA EnData02,X
    ADC #$00
    STA EnData02,X
    BPL L8376
    L8357:
        JSR TwosCompliment
        LDY #$F2
        BNE L8376
    L835E:
        JSR TwosCompliment
        SEC 
        STA $00
        LDA EnCounter,X
        SBC $00
        STA EnCounter,X
        LDA EnData02,X
        SBC #$00
        STA EnData02,X
        BMI L8357
L8376:
    CMP #$0E
    BCC L8383
        LDA #$00
        STA EnCounter,X
        TYA 
        STA EnData02,X
    L8383:
    LDA EnData18,X
    CLC 
    ADC EnCounter,X
    STA EnData18,X
    LDA #$00
    ADC EnData02,X
    STA $00
    RTS

;-------------------------------------------------------------------------------
; Nonsense with counters and velocity to substitute for a lack of subpixels?
; Horizontal case?
L8395:
    LDA #$00
    STA $00
    STA $02
    LDA #$0E
    STA $01
    STA $03
    LDA EnData07,X
    CLC 
    ADC EnData1B,X
    STA EnData07,X
    STA $04
    LDA #$00
    LDY EnData1B,X
    BPL L83B6
        LDA #$FF
    L83B6:
    ADC EnData03,X
    STA EnData03,X
    TAY 
    BPL L83D0
        LDA #$00
        SEC 
        SBC EnData07,X
        STA $04
        LDA #$00
        SBC EnData03,X
        TAY 
        JSR LE449
    L83D0:
    LDA $04
    CMP $02
    TYA 
    SBC $03
    BCC L83E3
        LDA $00
        STA EnData07,X
        LDA $01
        STA EnData03,X
    L83E3:
    LDA EnData19,X
    CLC 
    ADC EnData07,X
    STA EnData19,X
    LDA #$00
    ADC EnData03,X
    STA $00
    RTS

;-------------------------------------------------------------------------------
; Up movement related
; Move one pixel?
L83F5:
    LDX PageIndex
    LDA EnYRoomPos,X
    SEC 
    SBC EnRadY,X
    AND #$07
    SEC 
    BNE L8406
        JSR EnemyCheckMoveUp
    L8406:
    LDY #$00
    STY $00
    LDX PageIndex
    BCC L844A
    INC $00
    LDY EnYRoomPos,X
    BNE L8429
    LDY #$F0
    LDA $49
    CMP #$02
    BCS L8429
    LDA $FC
    BEQ L844A
    JSR GetOtherNameTableIndex
    BEQ L844A
    JSR SwitchEnemyNameTable
L8429:
    DEY 
    TYA 
    STA EnYRoomPos,X
    CMP EnRadY,X
    BNE L8441

    LDA $FC
    BEQ L843C
        JSR GetOtherNameTableIndex
        BNE L8441
    L843C:
    INC EnYRoomPos,X
    CLC 
    RTS
L8441:
    LDA EnData05,X
    BMI L8449
        INC EnData1D,X
    L8449:
    SEC
L844A:
    RTS

;-------------------------------------------------------------------------------
; Down movement related ?
L844B:
    LDX PageIndex
    LDA EnYRoomPos,X
    CLC 
    ADC EnRadY,X
    AND #$07
    SEC 
    BNE L845C
        JSR EnemyCheckMoveDown
    L845C:
    LDY #$00
    STY $00
    LDX PageIndex
    BCC L84A6
    INC $00
    LDY EnYRoomPos,X
    CPY #$EF
    BNE L8481
    LDY #$FF
    LDA $49
    CMP #$02
    BCS L8481
    LDA $FC
    BEQ L84A6
    JSR GetOtherNameTableIndex
    BNE L84A6
    JSR SwitchEnemyNameTable
L8481:
    INY 
    TYA 
    STA EnYRoomPos,X
    CLC 
    ADC EnRadY,X
    CMP #$EF
    BNE L849D
    LDA $FC
    BEQ L8497
        JSR GetOtherNameTableIndex
        BEQ L849D
    L8497:
    DEC EnYRoomPos,X
    CLC 
    BCC L84A6
L849D:
    LDA EnData05,X
    BMI L84A5
        DEC EnData1D,X
    L84A5:
    SEC 
L84A6:
    RTS

;-------------------------------------------------------------------------------
; Left movement related
L84A7:
    LDX PageIndex
    LDA EnXRoomPos,X
    SEC 
    SBC EnRadX,X
    AND #$07
    SEC 
    BNE L84B8
        JSR EnemyCheckMoveLeft
    L84B8:
    LDY #$00
    STY $00
    LDX PageIndex
    BCC L84FD
    INC $00
    LDY EnXRoomPos,X
    BNE L84DA
    LDA $49
    CMP #$02
    BCC L84DA
    LDA $FD
    BEQ L84D4
        JSR GetOtherNameTableIndex
    L84D4:
    CLC 
    BEQ L84FD
    JSR SwitchEnemyNameTable
L84DA:
    DEC EnXRoomPos,X
    LDA EnXRoomPos,X
    CMP EnRadX,X
    BNE L84F4
    LDA $FD
    BEQ L84EE
        JSR GetOtherNameTableIndex
        BNE L84F4
    L84EE:
    INC EnXRoomPos,X
    CLC 
    BCC L84FD
L84F4:
    LDA EnData05,X
    BPL L84FC
        INC EnData1D,X
    L84FC:
    SEC 
L84FD:
    RTS

;-------------------------------------------------------------------------------
; Right movement related
L84FE:
    LDX PageIndex
; if ((xpos + xrad) % 8) == 0, then EnemyCheckMoveRight()
    LDA EnXRoomPos,X
    CLC 
    ADC EnRadX,X
    AND #$07
    SEC 
    BNE L850F
        JSR EnemyCheckMoveRight
    L850F:
    LDY #$00
    STY $00
    LDX PageIndex
    BCC L8559
    INC $00
    INC EnXRoomPos,X
    BNE L8536
    LDA $49
    CMP #$02
    BCC L8536
    LDA $FD
    BEQ L852D
        JSR GetOtherNameTableIndex
        BEQ L8533
    L852D:
        DEC EnXRoomPos,X
        CLC
        BCC L8559
    L8533:
    JSR SwitchEnemyNameTable

L8536:
    LDA EnXRoomPos,X
    CLC 
    ADC EnRadX,X
    CMP #$FF
    BNE L8550
    LDA $FD
    BEQ L854A
        JSR GetOtherNameTableIndex
        BEQ L8550
    L854A:
    DEC EnXRoomPos,X
    CLC 
    BCC L8559

L8550:
    LDA EnData05,X
    BPL L8558
        DEC EnData1D,X
    L8558:
    SEC 
L8559:
    RTS

;-------------------------------------------------------------------------------
SwitchEnemyNameTable: ; L855A
    LDA EnNameTable,X
    EOR #$01
    STA EnNameTable,X
    RTS

;-------------------------------------------------------------------------------
; Returns the index to the other nametable in A
GetOtherNameTableIndex: ; L8562
    LDA EnNameTable,X
    EOR $FF
    AND #$01
    RTS

;-------------------------------------------------------------------------------
; XORs the contents of EnData05 with the bitmask in A
XorEnData05: ; L856B
    EOR EnData05,X
    STA EnData05,X
    RTS 

;---------------------------------[ Object animation data tables ]----------------------------------
;----------------------------[ Sprite drawing pointer tables ]--------------------------------------
;------------------------------[ Sprite placement data tables ]-------------------------------------
;-------------------------------[ Sprite frame data tables ]---------------------------------------
.include "common_sprite_data.asm"

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
    LDA DoorStatus                  ;The code determines if Samus has entered a door if the-->
    BNE L8B6C                       ;door status is 0, but door data information has been-->
    LDY SamusDoorData               ;written. If both conditions are met, Samus has just-->
    BEQ L8B6C                       ;entered a door.
    STA CurrentMissilePickups       ;
    STA CurrentEnergyPickups        ;Reset current missile and energy power-up counters.
    LDA RandomNumber1               ;
    AND #$0F                        ;Randomly recalculate max missile pickups(16 max, 0 min).
    STA MaxMissilePickup            ;
    ASL                             ;
    ORA #$40                        ;*2 for energy pickups and set bit 6(128 max, 64 min).
    STA MaxEnergyPickup             ;
    LDA PPUCTRL_ZP                   ;
    EOR #$01                        ;
    AND #$01                        ;Erase name table door data for new room.
    TAY                             ;
    LSR                             ;
    STA DoorOnNameTable3,Y                     ;
    LDA ScrollDir                   ;
    AND #$02                        ;Is Samus scrolling horizontally?-->
    BNE L8B4B                       ;If so, branch.
        LDX #$04                        ;Samus currently scrolling vertically.
        LDA ScrollY                     ;Is room centered on screen?-->
        BEQ L8B6D                       ;If so, branch.
        LDA $FF                         ;
        EOR ObjectHi                    ;Get inverse of Samus' current nametable.
        LSR                             ;
        BCC SetDoorEntryInfo                       ;If Samus is on nametable 3, branch.
        BCS L8B52                       ;If Samus is on nametable 0, branch to decrement x.

    L8B4B:
        LDX #$02                        ;Samus is currently scrolling horizontally.
        LDA ObjectX                     ;Is Samus entering a left hand door?-->
        BPL SetDoorEntryInfo                       ;If so, branch.
    L8B52:
    DEX                             ;

SetDoorEntryInfo:
    TXA                             ;X contains door scroll status and is transferred to A.
    STA DoorScrollStatus            ;Save door scroll status.
    JSR SamusInDoor                 ;($8B74)Indicate Samus just entered a door.
    LDA #$12                        ;
    STA DoorDelay                   ;Set DoorDelay to 18 frames(going into door).
    LDA SamusDoorData               ;
    JSR Amul16                      ;($C2C5)*16. Move scroll toggle data to upper 4 bits.
    ORA ObjAction                   ;Keep Samus action so she will appear the same comming-->
    STA SamusDoorData               ;out of the door as she did going in.
    LDA #$05                        ;
    STA ObjAction                   ;Indicate Samus is in a door.
L8B6C:
    RTS                             ;

L8B6D:
    JSR SetDoorEntryInfo            ;($8B53)Save Samus action and set door entry timer.
    JSR VerticalRoomCentered        ;($E21B)Room is centered. Toggle scroll.

    TXA                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
    ORA #$80                        ;Set MSB of DoorStatus to indicate Samus has just-->
    STA DoorStatus                  ;entered a door.
    RTS                             ;

;----------------------------------------------------------------------------------------------------
DisplayDoors:
    LDX #$B0
    L8B7B:
        JSR DoorRoutine
        LDA PageIndex
        SEC 
        SBC #$10
        TAX 
        BMI L8B7B
    RTS

DoorRoutine:
    STX PageIndex
    LDA ObjAction,X
    JSR ChooseRoutine               ;($C27C)
        .word ExitSub
        .word DoorAction0
        .word DoorAction1
        .word DoorAction2
        .word DoorAction3
        .word DoorAction4
        .word DoorAction5

DoorAction0:
    INC ObjAction,X
    LDA #$30
    JSR SetProjectileAnim           ;($D2FA)
    JSR ObjActionSubRoutine8CFB
    LDY $0307,X ; Unsure if $0307 is semantically comparable to SamusOnElevator
    LDA ObjActionAnimTable,Y
    STA $030F,X
ObjActionSubRoutine8BB1:
    LDA $0307,X
    CMP #$03
    BNE L8BBA
        LDA #$01
    L8BBA:
    ORA #$A0
    STA ObjectCntrl
    LDA #$00
    STA $030A,X ; SamusHit (DoorHit?)
    TXA 
    AND #$10
    EOR #$10
    ORA ObjectCntrl
    STA ObjectCntrl
    LDA #$06
    JMP AnimDrawObject

ObjActionAnimTable:
    .byte $05, $01, $0A, $01

DoorAction1:
    LDA $030A,X
    AND #$04
    BEQ ObjActionSubRoutine8BB1
    DEC $030F,X
    BNE ObjActionSubRoutine8BB1
    LDA #$03
    CMP $0307,X
    BNE L8BEE
        LDY $010B
        INY 
        BNE ObjActionSubRoutine8BB1
    L8BEE:
    STA ObjAction,X
    LDA #$50
    STA $030F,X
    LDA #$2C
    STA $0305,X
    SEC 
    SBC #$03
    JMP ObjActionSubRoutine8C7E

DoorAction2:
    LDA DoorStatus
    BEQ L8C1D
    LDA $030C ; ObjNametable
    EOR $030C,X
    LSR 
    BCS L8C1D
    LDA $030E
    EOR $030E,X
    BMI L8C1D
    LDA #$04
    STA ObjAction,X
    BNE L8C73
L8C1D:
    LDA $0306,X
    CMP $0305,X
    BCC L8C73
    LDA $030F,X
    CMP #$50
    BNE L8C57
    JSR ObjActionSubRoutine8CF7
    LDA $0307,X
    CMP #$01
    BEQ L8C57
    CMP #$03
    BEQ L8C57
    LDA #$0A
    STA $09
    LDA $030C,X
    STA $08
    LDY $50
    TXA 
    JSR Amul16
    BCC L8C4C
        DEY 
    L8C4C:
    TYA 
    JSR MapScrollRoutine
    LDA #$00
    STA ObjAction,X
    BEQ L8C73
L8C57:
    LDA $2D
    LSR 
    BCS L8C73
    DEC $030F,X
    BNE L8C73
ObjActionSubRoutine8C61:
    LDA #$01
    STA $030F,X
    JSR ObjActionSubRoutine8CFB
    LDA #$02
    STA ObjAction,X
    JSR ObjActionSubRoutine8C76
ObjActionSubRoutine8C71:
    LDX PageIndex
L8C73:
    JMP ObjActionSubRoutine8BB1

ObjActionSubRoutine8C76:
    LDA #$30
    STA $0305,X
    SEC 
    SBC #$02
ObjActionSubRoutine8C7E:
    JSR SetProjectileAnim2
    JMP SFX_Door

DoorAction3:
    LDA DoorStatus
    CMP #$05
    BCS L8CC3
    JSR ObjActionSubRoutine8CFB
    JSR ObjActionSubRoutine8C76
    LDX PageIndex
    LDA $91
    BEQ L8CA7
    TXA 
    JSR Adiv16
    EOR $91
    LSR 
    BCC L8CA7
    LDA $76
    EOR #$07
    STA $76
    STA $1C
L8CA7:
    INC ObjAction,X
    LDA #$00
    STA $91
    LDA $0307,X
    CMP #$03
    BNE L8CC3
    TXA 
    JSR Amul16
    BCS L8CC0
        JSR TourianMusic
        BNE L8CC3
    L8CC0:
    JSR MotherBrainMusic
L8CC3:
    JMP ObjActionSubRoutine8C71

DoorAction4:
    LDA DoorStatus
    CMP #$05
    BNE L8CED
    TXA 
    EOR #$10
    TAX 
    LDA #$06
    STA ObjAction,X
    LDA #$2C
    STA $0305,X
    SEC 
    SBC #$03
    JSR SetProjectileAnim2
    JSR SFX_Door
    JSR SelectSamusPal
    LDX PageIndex
    LDA #$02
    STA ObjAction,X
L8CED:
    JMP ObjActionSubRoutine8BB1

DoorAction5:
    LDA DoorStatus
    BNE L8CED
    JMP ObjActionSubRoutine8C61

ObjActionSubRoutine8CF7:
    LDA #$FF
    BNE L8CFD
ObjActionSubRoutine8CFB:
    LDA #$4E
L8CFD:
    PHA 
    LDA #$50
    STA $02
    TXA 
    JSR Adiv16
    AND #$01
    TAY 
    LDA DoorDataTable,Y
    STA $03
    LDA $030C,X
    STA $0B
    JSR MakeCartRAMPtr
    LDY #$00
    PLA 
    L8D19:
        STA ($04),Y
        TAX 
        TYA 
        CLC 
        ADC #$20
        TAY 
        TXA 
        CPY #$C0
        BNE L8D19
    LDX PageIndex
    TXA 
    JSR Adiv8
    AND #$06
    TAY 
    LDA $04
    STA $005C,Y
    LDA $05
    STA $005D,Y
    RTS

DoorDataTable:
    .byte $E8, $10, $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9 
    .byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
    .byte $85, $00, $AD, $97, $69, $29

; EoF
