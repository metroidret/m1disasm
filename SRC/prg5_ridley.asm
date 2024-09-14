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

;Ridley hideout (memory page 5)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

BANK .set 5
.segment "BANK_05_MAIN"

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

.incbin "common_chr/bg_CRE.chr" ; 8D60 - Common Room Elements (loaded everywhere except Tourian)

.incbin "tourian/font_chr.chr" ; 91B0 - Game over, Japanese font tiles (only loaded in Tourian?)

;Unused tile patterns.
    .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A0EB)
    .word Palette01                 ;($A10F)
    .word Palette02                 ;($A11B)
    .word Palette03                 ;($A115)
    .word Palette04                 ;($A121)
    .word Palette05                 ;($A127)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette06                 ;($A13B)
    .word Palette07                 ;($A142)
    .word Palette08                 ;($A149)
    .word Palette09                 ;($A150)
    .word Palette0A                 ;($A157)
    .word Palette0B                 ;($A15F)
    .word Palette0C                 ;($A167)
    .word Palette0D                 ;($A16F)
    .word Palette0E                 ;($A177)

AreaPointers:
    .word SpecItmsTbl               ;($A20D)Beginning of special items table.
    .word RmPtrTbl                  ;($A17F)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A1D3)Beginning of structure pointer table.
    .word MacroDefs                 ;($AB23)Beginning of macro definitions.
    .word EnemyFramePtrTbl1         ;($9BF0)Address table into enemy animation data. Two-->
    .word EnemyFramePtrTbl2         ;($9CF0)tables needed to accommodate all entries.
    .word EnemyPlacePtrTbl          ;($9D04)Pointers to enemy frame placement data.
    .word EnemyAnimIndexTbl         ;($9B85)Index to values in addr tables for enemy animations.

; Tourian-specific jump table (dummied out in other banks)
;  Each line is RTS, NOP, NOP in this bank
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA
    .byte $60, $EA, $EA

AreaRoutine:
    JMP PolypRTS                       ;Area specific routine.

TwosCompliment_:
    EOR #$FF                        ;
    CLC                             ;The following routine returns the twos-->
    ADC #$01                        ;compliment of the value stored in A.
    RTS                             ;

L95CC:  .byte $12                       ;Ridley's room.

L95CD:  .byte $80                       ;Ridley hideout music init flag.

L95CE:  .byte $40                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $19                       ;Samus start x coord on world map.
L95D8:  .byte $18                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $58, $44, $4A, $48, $4A, $4A, $36, $25

ChooseEnemyRoutine:
    LDA EnDataIndex,X
    JSR CommonJump_ChooseRoutine
        .word SwooperRoutine ; 00 - swooper
        .word SwooperRoutine2 ; 01 - becomes swooper ?
        .word SidehopperFloorRoutine ; 02 - dessgeegas
        .word SidehopperCeilingRoutine ; 03 - ceiling dessgeegas
        .word InvalidEnemy ; 04 - disappears
        .word InvalidEnemy ; 05 - same as 4
        .word CrawlerRoutine ; 06 - crawler
        .word PipeBugRoutine ; 07 - zebbo
        .word InvalidEnemy ; 08 - same as 4
        .word RidleyRoutine ; 09 - ridley
        .word RidleyFireballRoutine ; 0A - ridley fireball
        .word InvalidEnemy ; 0B - same as 4
        .word MultiviolaRoutine ; 0C - bouncy orbs
        .word InvalidEnemy ; 0D - same as 4
        .word PolypRoutine ; 0E - ???
        .word InvalidEnemy ; 0F - same as 4

L960B:  .byte $23, $23, $23, $23, $3A, $3A, $3C, $3C, $00, $00, $00, $00, $56, $56, $65, $63

L961B:  .byte $00, $00, $11, $11, $13, $18, $28, $28, $32, $32, $34, $34, $00, $00, $00, $00

L962B:  .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $1D, $1D, $1D, $1D, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $69, $67

L964B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L965B:  .byte $20, $20, $20, $20, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $60, $5D

L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

L96BB:  .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $18, $1A, $00, $03, $00, $00, $08, $08, $00, $0A, $0C, $0F, $14, $16, $18, $00

EnemyMovementPtrs:
    .word L97ED, L97ED, L97ED, L97ED, L97ED, L97F0, L97F3, L97F3
    .word L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3
    .word L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3
    .word L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3, L97F3
    .word L97F3, L97F3, L97F3, L97F3

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $7F, $7F, $81, $81
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01
L9773:  .byte $01, $00, $00, $00, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $34, $34, $44, $4A, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8

L97A7:  .word L97FD, L97FD, L980C, L981B

L97AF:  .word L9B49, L9B4E, L9B53, L9B58, L9B5D, L9B62, L9B67, L9B6C
L97BF:  .word L9B71, L9B76, L9B7B, L9B80, L9B85, L9B85, L9B85, L9B85
L97CF:  .word L9B85

L97D1:  .byte $01, $04, $05, $01, $06, $07, $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03
L97E1:  .byte $00, $01, $02, $03, $00, $10, $00, $11, $00, $00, $00, $01

L97ED:  .byte $01, $03, $FF

L97F0:  .byte $01, $0B, $FF

L97F3:  .byte $14, $90, $0A, $00, $FD, $30, $00, $14, $10, $FA

L97FD:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L980C:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L981B:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

;-------------------------------------------------------------------------------
InvalidEnemy:
    LDA #$00
    STA EnStatus,X
    RTS

CommonEnemyJump_00_01_02:
    LDA $81
    CMP #$01
    BEQ L983F
    CMP #$03
    BEQ L9844
        LDA $00
        JMP CommonJump_00
    L983F:
        LDA $01
        JMP CommonJump_01
    L9844:
        JMP CommonJump_02

;-------------------------------------------------------------------------------

.include "enemies/sidehopper.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Swooper Routine

.include "enemies/swooper.asm"

;-------------------------------------------------------------------------------
; Crawler Routine
.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------

.include "enemies/ridley.asm"

StorePositionToTemp:
    LDA EnYRoomPos,X
    STA $08
    LDA EnXRoomPos,X
    STA $09
    LDA EnNameTable,X
    STA $0B
    RTS

LoadPositionFromTemp:
    LDA $0B
    AND #$01
    STA EnNameTable,X
    LDA $08
    STA EnYRoomPos,X
    LDA $09
    STA EnXRoomPos,X
    RTS

;-------------------------------------------------------------------------------
; Bouncy Orb Routine
.include "enemies/multiviola.asm"

;-------------------------------------------------------------------------------
; Polyp (beta?) Routine
.include "enemies/polyp.asm"

;-------------------------------------------------------------------------------

L9B49:  .byte $22, $FF, $FF, $FF, $FF

L9B4E:  .byte $22, $80, $81, $82, $83

L9B53:  .byte $22, $84, $85, $86, $87

L9B58:  .byte $22, $88, $89, $8A, $8B

L9B5D:  .byte $22, $8C, $8D, $8E, $8F

L9B62:  .byte $22, $94, $95, $96, $97

L9B67:  .byte $22, $9C, $9D, $9D, $9C

L9B6C:  .byte $22, $9E, $9F, $9F, $9E

L9B71:  .byte $22, $90, $91, $92, $93

L9B76:  .byte $22, $70, $71, $72, $73

L9B7B:  .byte $22, $74, $75, $76, $77

L9B80:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9B85:  .byte $00, $01, $FF

L9B88:  .byte $02, $FF

L9B8A:  .byte $03, $04, $FF

L9B8D:  .byte $07, $08, $FF

L9B90:  .byte $05, $06, $FF

L9B93:  .byte $09, $0A, $FF

L9B96:  .byte $0B, $FF

L9B98:  .byte $0C, $0D, $0E, $0F, $FF

L9B9D:  .byte $10, $11, $12, $13, $FF

L9BA2:  .byte $17, $18, $FF

L9BA5:  .byte $19, $1A, $FF

L9BA8:  .byte $1B, $FF

L9BAA:  .byte $21, $22, $FF

L9BAD:  .byte $27, $28, $29, $2A, $FF

L9BB2:  .byte $2B, $2C, $2D, $2E, $FF

L9BB7:  .byte $2F, $FF

L9BB9:  .byte $42, $FF

L9BBB:  .byte $43, $44, $F7, $FF

L9BBF:  .byte $37, $FF, $38, $FF

L9BC3:  .byte $30, $31, $FF

L9BC6:  .byte $31, $32, $FF

L9BC9:  .byte $33, $34, $FF

L9BCC:  .byte $34, $35, $FF

L9BCF:  .byte $58, $59, $FF

L9BD2:  .byte $5A, $5B, $FF

L9BD5:  .byte $5C, $5D, $FF

L9BD8:  .byte $5E, $5F, $FF

L9BDB:  .byte $60, $FF

L9BDD:  .byte $61, $F7, $62, $F7, $FF

L9BE2:  .byte $66, $67, $FF

L9BE5:  .byte $69, $6A, $FF

L9BE8:  .byte $68, $FF

L9BEA:  .byte $6B, $FF

L9BEC:  .byte $66, $FF

L9BEE:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9BF0:  .word L9DD8, L9DDD, L9DE2, L9DE7, L9DFA, L9E0E, L9E24, L9E3A
L9C00:  .word L9E4D, L9E61, L9E77, L9E8D, L9E97, L9E9C, L9EA1, L9EA6
L9C10:  .word L9EAB, L9EB0, L9EB5, L9EBA, L9EBF, L9EBF, L9EBF, L9EBF
L9C20:  .word L9ECE, L9EDD, L9EEE, L9EFF, L9F07, L9F07, L9F07, L9F07
L9C30:  .word L9F07, L9F07, L9F0F, L9F17, L9F17, L9F17, L9F17, L9F17
L9C40:  .word L9F23, L9F31, L9F3F, L9F4D, L9F59, L9F67, L9F75, L9F83
L9C50:  .word L9F8E, L9F9C, L9FAA, L9FB6, L9FC4, L9FD2, L9FDE, L9FDE
L9C60:  .word L9FF2, LA006, LA006, LA006, LA006, LA006, LA006, LA006
L9C70:  .word LA006, LA006, LA006, LA00B, LA013, LA01B, LA01B, LA01B
L9C80:  .word LA01B, LA01B, LA01B, LA01B, LA01B, LA01B, LA01B, LA01B
L9C90:  .word LA01B, LA01B, LA01B, LA01B, LA01B, LA01B, LA01B, LA01B
L9CA0:  .word LA01B, LA027, LA033, LA03F, LA04B, LA057, LA063, LA06F
L9CB0:  .word LA07B, LA083, LA091, LA0AB, LA0AB, LA0AB, LA0AB, LA0B3
L9CC0:  .word LA0BB, LA0C3, LA0CB, LA0D3, LA0DB, LA0DB, LA0DB, LA0DB
L9CD0:  .word LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB
L9CE0:  .word LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB, LA0DB

EnemyFramePtrTbl2:
L9CF0:  .word LA0DB, LA0E1, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6, LA0E6
L9D00:  .word LA0E6, LA0E6

EnemyPlacePtrTbl:
L9D04:  .word L9D22, L9D24, L9D3C, L9D60, L9D72, L9D64, L9D6E, L9D76
L9D14:  .word L9D82, L9D8A, L9D8A, L9DAA, L9DB8, L9DBC, L9DCC

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D22:  .byte $FC, $FC

L9D24:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9D34:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9D3C:  .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
L9D4C:  .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
L9D5C:  .byte $12, $E8, $14, $F8

L9D60:  .byte $F4, $F4, $F4, $04

L9D64:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9D6E:  .byte $FC, $F8, $FC, $00

L9D72:  .byte $F0, $F8, $F0, $00

L9D76:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9D82:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9D8A:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9D9A:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DAA:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9DB8:  .byte $F8, $FC, $00, $FC

L9DBC:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9DCC:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

;Enemy frame drawing data.

L9DD8:  .byte $00, $02, $02, $14, $FF

L9DDD:  .byte $00, $02, $02, $24, $FF

L9DE2:  .byte $00, $00, $00, $04, $FF

L9DE7:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9DF7:  .byte $F9, $F8, $FF

L9DFA:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9D0A:  .byte $D8, $FE, $E8, $FF

L9E0E:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E1E:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E24:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E34:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E3A:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E4A:  .byte $F9, $F8, $FF

L9E4D:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E5D:  .byte $D8, $FE, $E8, $FF

L9E61:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E71:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E77:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E87:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E8D:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9E97:  .byte $30, $07, $07, $EC, $FF

L9E9C:  .byte $30, $07, $07, $FB, $FF

L9EA1:  .byte $F0, $07, $07, $EC, $FF

L9EA6:  .byte $F0, $07, $07, $FB, $FF

L9EAB:  .byte $70, $07, $07, $EC, $FF

L9EB0:  .byte $70, $07, $07, $FB, $FF

L9EB5:  .byte $B0, $07, $07, $EC, $FF

L9EBA:  .byte $B0, $07, $07, $FB, $FF

L9EBF:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9ECE:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9EDD:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9EED:  .byte $FF

L9EEE:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9EFE:  .byte $FF

L9EFF:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F07:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F0F:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF

L9F17:  .byte $27, $08, $08, $EE, $EF, $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9F23:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9F31:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9F3F:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9F4D:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9F59:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9F67:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9F75:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

L9F83:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

L9F8E:  .byte $2D, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9F9C:  .byte $2D, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9FAA:  .byte $2E, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9FB6:  .byte $AD, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9FC4:  .byte $AD, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9FD2:  .byte $AE, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9FDE:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FEE:  .byte $00, $08, $F2, $FF

L9FF2:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
LA002:  .byte $00, $08, $E2, $FF

LA006:  .byte $20, $04, $04, $C0, $FF

LA00B:  .byte $20, $00, $00, $FC, $F8, $00, $D0, $FF

LA013:  .byte $23, $00, $00, $D1, $FD, $62, $D1, $FF

LA01B:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA027:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA033:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA03F:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA04B:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA057:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA063:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA06F:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA07B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA083:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA091:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA0A1:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA0AB:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0B3:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0BB:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0C3:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0CB:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0D3:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0DB:  .byte $0C, $08, $04, $14, $24, $FF

LA0E1:   .byte $00, $04, $04, $8A, $FF

LA0E6:   .byte $00, $04, $04, $8A, $FF


;------------------------------------------[ Palette data ]------------------------------------------

.include "ridley/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
.include "ridley/room_ptrs.asm"

StrctPtrTbl:
.include "ridley/structure_ptrs.asm"

;-----------------------------------[ Special items table ]-----------------------------------------

.include "ridley/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "ridley/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "ridley/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

.include "ridley/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

; Ridley Music Data
.include "songs/ridley.asm"

; Kraid Music Data
.include "songs/kraid.asm"

;Not used.
    .byte $2A, $2A, $2A, $B9, $2A, $2A, $2A, $B2, $2A, $2A, $2A, $2A, $2A, $B9, $2A, $12
    .byte $2A, $B2, $26, $B9, $0E, $26, $26, $B2, $26, $B9, $0E, $26, $26, $B2, $22, $B9
    .byte $0A, $22, $22, $B2, $22, $B9, $0A, $22, $22, $B2, $20, $20, $B9, $20, $20, $20
    .byte $B2, $20, $B9, $34, $30, $34, $38, $34, $38, $3A, $38, $3A, $3E, $3A, $3E, $FF
    .byte $C2, $B2, $18, $30, $18, $30, $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2
    .byte $22, $20, $1C, $18, $16, $14, $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $B2
    .byte $2A, $28, $28, $B9, $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $26
    .byte $26, $3E, $FF, $F0, $B2, $01, $04, $01, $04, $FF, $E0, $BA, $2A, $1A, $02, $3A
    .byte $40, $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C
    .byte $38, $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A
    .byte $4C, $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF
    .byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $2B, $3B, $1B, $5A, $D0, $D1, $C3
    .byte $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF
    .byte $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC
    .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
    .byte $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03
    .byte $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18
    .byte $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_05_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
