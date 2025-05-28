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

;Brinstar (memory page 1)

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

BANK .set 1
.segment "BANK_01_MAIN"

;--------------------------------------------[ Export ]---------------------------------------------

.export GFX_TheEndFont
.export GFX_BrinstarSprites

;------------------------------------------[ Start of code ]-----------------------------------------

.include "areas_common.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

GFX_TheEndFont:
    .incbin "ending/end_font.chr"       ; 8D60 - "THE END" graphics + partial font
GFX_BrinstarSprites:
    .incbin "brinstar/sprite_tiles.chr" ; 9160 - Brinstar Enemies

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
    .word Palette00                 ;($A271)
    .word Palette01                 ;($A295)
    .word Palette02                 ;($A2A1)
    .word Palette03                 ;($A29B)
    .word Palette04                 ;($A2A7)
    .word Palette05                 ;($A2AD)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette06                 ;($A2D0)
    .word Palette07                 ;($A2D7)
    .word Palette08                 ;($A2DE)
    .word Palette09                 ;($A2E5)
    .word Palette0A                 ;($A2EC)
    .word Palette0B                 ;($A2F4)
    .word Palette0C                 ;($A2FC)
    .word Palette0D                 ;($A304)
    .word Palette0E                 ;($A30C)

AreaPointers:
    .word SpecItmsTbl               ;($A3D6)Beginning of special items table.
    .word RmPtrTbl                  ;($A314)Beginning of room pointer table.
    .word StrctPtrTbl               ;($A372)Beginning of structure pointer table.
    .word MacroDefs                 ;($AEF0)Beginning of macro definitions.
    .word EnFramePtrTable1          ;($9DE0)Pointer table into enemy animation data. Two-->
    .word EnFramePtrTable2          ;($9EE0)tables needed to accommodate all entries.
    .word EnPlacePtrTable           ;($9F0E)Pointers to enemy frame placement data.
    .word EnAnimTbl                 ;($9D6A)index to values in addr tables for enemy animations.

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

AreaRoutine: ; L95C3
    jmp AreaRoutineStub ; Just an RTS

;The following routine returns the two's complement of the value stored in A.
TwosComplement_:
    eor #$FF
    clc
    adc #$01
    rts

; area init data
    .byte $FF                       ;Not used.
AreaMusicFlag:
    .byte $01                       ;Brinstar music init flag.
AreaEnemyDamage:
    .word $0080                     ;Base damage caused by area enemies.

;Special room numbers(used to start item room music).
AreaItemRoomNumbers:
    .byte $2B, $2C, $28, $0B, $1C, $0A, $1A

AreaSamusMapPosX:
    .byte $03   ;Samus start x coord on world map.
AreaSamusMapPosY:
    .byte $0E   ;Samus start y coord on world map.
AreaSamusY:
    .byte $B0   ;Samus start vertical screen position.

AreaPalToggle:
    .byte $01

    .byte $00
AreaFireballKilledAnimIndex:
    .byte EnAnim_9D6D - EnAnimTbl
AreaExplosionAnimIndex:
    .byte EnAnim_9DAD - EnAnimTbl

    .byte $00, $00
AreaFireballFallingAnimIndex:
    .byte $00, $00
AreaFireballSplatterAnimIndex:
    .byte $00, $00
AreaMellowAnimIndex:
    .byte EnAnim_9DD3 - EnAnimTbl

; Enemy AI jump table
ChooseEnemyAIRoutine:
    lda EnType,x
    jsr CommonJump_ChooseRoutine
        .word SidehopperFloorAIRoutine ; 00 - Sidehopper
        .word SidehopperCeilingAIRoutine ; 01 - Ceiling sidehopper
        .word WaverAIRoutine ; 02 - Waver
        .word RipperAIRoutine ; 03 - Ripper
        .word SkreeAIRoutine ; 04 - Skree
        .word CrawlerAIRoutine ; 05 - Zoomer (crawler)
        .word RioAIRoutine ; 06 - Rio (swoopers)
        .word PipeBugAIRoutine ; 07 - Zeb
        .word KraidAIRoutine ; 08 - Kraid (crashes due to bug)
        .word KraidLintAIRoutine ; 09 - Kraid's lint (crashes)
        .word KraidNailAIRoutine ; 0A - Kraid's nail (crashes)
        .word $0000 ; 0B - Null pointers (hard crash)
        .word $0000 ; 0C - Null
        .word $0000 ; 0D - Null
        .word $0000 ; 0E - Null
        .word $0000 ; 0F - Null

; Animation related table ?
EnemyDeathAnimIndex:
    .byte EnAnim_9D91 - EnAnimTbl, EnAnim_9D91 - EnAnimTbl
    .byte EnAnim_9D93 - EnAnimTbl, EnAnim_9D93 - EnAnimTbl
    .byte EnAnim_9D97 - EnAnimTbl, EnAnim_9D95 - EnAnimTbl
    .byte EnAnim_9D9B - EnAnimTbl, EnAnim_9D99 - EnAnimTbl
    .byte EnAnim_9D9D - EnAnimTbl, EnAnim_9D9D - EnAnimTbl
    .byte EnAnim_9DAB - EnAnimTbl, EnAnim_9DAB - EnAnimTbl
    .byte EnAnim_9DB5 - EnAnimTbl, EnAnim_9DB5 - EnAnimTbl
    .byte EnAnim_9DBF - EnAnimTbl, EnAnim_9DBD - EnAnimTbl
    .byte EnAnim_9DDC - EnAnimTbl, EnAnim_9DDE - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

EnemyHitPointTbl:
    .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

; ResetAnimIndex table
EnemyAnimIndex_963B:
    .byte EnAnim_9D6F - EnAnimTbl, EnAnim_9D6F - EnAnimTbl
    .byte EnAnim_9D75 - EnAnimTbl, EnAnim_9D75 - EnAnimTbl
    .byte EnAnim_9D81 - EnAnimTbl, EnAnim_9D7D - EnAnimTbl
    .byte EnAnim_9D85 - EnAnimTbl, EnAnim_9D83 - EnAnimTbl
    .byte EnAnim_9D8D - EnAnimTbl, EnAnim_9D8D - EnAnimTbl
    .byte EnAnim_9D9F - EnAnimTbl, EnAnim_9D9F - EnAnimTbl
    .byte EnAnim_9DB2 - EnAnimTbl, EnAnim_9DB2 - EnAnimTbl
    .byte EnAnim_9DC3 - EnAnimTbl, EnAnim_9DC1 - EnAnimTbl
    .byte EnAnim_9DD6 - EnAnimTbl, EnAnim_9DD9 - EnAnimTbl
    .byte EnAnim_9DC5 - EnAnimTbl, EnAnim_9DC7 - EnAnimTbl
    .byte EnAnim_9DCC - EnAnimTbl, EnAnim_9DD1 - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

; another ResetAnimIndex table
EnemyAnimIndex_965B:
    .byte EnAnim_9D6F - EnAnimTbl, EnAnim_9D6F - EnAnimTbl
    .byte EnAnim_9D75 - EnAnimTbl, EnAnim_9D75 - EnAnimTbl
    .byte EnAnim_9D81 - EnAnimTbl, EnAnim_9D7D - EnAnimTbl
    .byte EnAnim_9D85 - EnAnimTbl, EnAnim_9D83 - EnAnimTbl
    .byte EnAnim_9D8D - EnAnimTbl, EnAnim_9D8D - EnAnimTbl
    .byte EnAnim_9D9F - EnAnimTbl, EnAnim_9D9F - EnAnimTbl
    .byte EnAnim_9DB2 - EnAnimTbl, EnAnim_9DB2 - EnAnimTbl
    .byte EnAnim_9DBA - EnAnimTbl, EnAnim_9DB7 - EnAnimTbl
    .byte EnAnim_9DD6 - EnAnimTbl, EnAnim_9DD9 - EnAnimTbl
    .byte EnAnim_9DC5 - EnAnimTbl, EnAnim_9DC7 - EnAnimTbl
    .byte EnAnim_9DC9 - EnAnimTbl, EnAnim_9DCE - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00

;another animation related table
L967B:
    .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

; Screw attack vulnerability? Hit sound?
; Bit 5 (0x20) determines something about how it computes velocity
L968B:
    .byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00

; EnData0D table (set upon load, and a couple other times)
EnemyData0DTbl:
    .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00

; Some table referenced when loading an enemy
L96AB:
    .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00

EnemyInitDelayTbl:
    .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

; Index to a table starting at L97D1
L96CB:
    .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

; EnData08*2 + one of the low bits of EnData05 is used as an index to this pointer table
; Pointer table to enemy movement strings
EnemyMovementPtrs:
    .word EnemyMovement00
    .word EnemyMovement01
    .word EnemyMovement02
    .word EnemyMovement03
    .word EnemyMovement04
    .word EnemyMovement05
    .word EnemyMovement06
    .word EnemyMovement07
    .word EnemyMovement08
    .word EnemyMovement09
    .word EnemyMovement0A
    .word EnemyMovement0B
    .word EnemyMovement0C
    .word EnemyMovement0D
    .word EnemyMovement0E
    .word EnemyMovement0F
    .word EnemyMovement10
    .word EnemyMovement11
    .word EnemyMovement12
    .word EnemyMovement13
    .word EnemyMovement14
    .word EnemyMovement15
    .word EnemyMovement16
    .word EnemyMovement17
    .word EnemyMovement18
    .word EnemyMovement19
    .word EnemyMovement1A
    .word EnemyMovement1B
    .word EnemyMovement1C
    .word EnemyMovement1D
    .word EnemyMovement1E
    .word EnemyMovement1F
    .word EnemyMovement20
    .word EnemyMovement21
    .word EnemyMovement22
    .word EnemyMovement23
; Unused padding to the above?
    .byte $00, $00, $00, $00, $00, $00, $00, $00

; enemy accel y table ($972B)
EnAccelYTable:  .byte $7F, $40, $30, $C0, $D0, $00, $00, $7F, $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
; enemy accel x table ($973F)
EnAccelXTable:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
; enemy speed y table ($9753)
EnSpeedYTable:  .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
; enemy speed x table ($9767)
EnSpeedXTable:  .byte $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00

; Behavior-Related Table?
L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

; Enemy animation related table?
EnemyFireballRisingAnimIndexTable:
    .byte $00, $00
    .byte EnAnim_9DCE - EnAnimTbl, EnAnim_9DD1 - EnAnimTbl
    .byte EnAnim_9DD3 - EnAnimTbl, EnAnim_9DD3 - EnAnimTbl
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetX:
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
EnemyFireballPosOffsetY:
    .byte $F4
    .byte $00
    .byte $00
    .byte $00

; Another movement pointer table?
; Referenced using EnData0A
EnemyFireballMovementPtrTable:
    .word EnemyFireballMovement0
    .word EnemyFireballMovement1
    .word EnemyFireballMovement2
    .word EnemyFireballMovement3

; Referenced by LFE83
TileBlastFramePtrTable:
    .word TileBlastFrame00
    .word TileBlastFrame01
    .word TileBlastFrame02
    .word TileBlastFrame03
    .word TileBlastFrame04
    .word TileBlastFrame05
    .word TileBlastFrame06
    .word TileBlastFrame07
    .word TileBlastFrame08
    .word TileBlastFrame09
    .word TileBlastFrame0A
    .word TileBlastFrame0B
    .word TileBlastFrame0C
    .word TileBlastFrame0D
    .word TileBlastFrame0E
    .word TileBlastFrame0F
    .word TileBlastFrame10

; If I'm reading the code correctly, this table is accessed with this formula:
;  EnData08 = L97D1[(L97D1[L96CB[EnemyDataIndex]] and (FrameCount xor RandomNumber1))+1]
; These values are used as indexes into EnAccelYTable, EnAccelXTable, EnSpeedYTable, EnSpeedXTable.
L97D1:
    .byte $01, $01, $02, $01, $03, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09
    .byte $00, $00, $00, $0B, $01, $0C, $0D, $00, $0E, $03, $0F, $10, $11, $0F

;-------------------------------------------------------------------------------
;I believe this is the point where the level banks don't need to match addresses
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Enemy movement strings (pointed to by the table L96DB)
;  These are decoded/read starting at about L8244 in areas_common.asm
;  An enemy may use these if bit 6 of their value on the table at L977B is set
;  EnCounter determined the offset within the string to be read
;
; Format
; values <0xF0 specify a duration in frames, followed by a bitpacked velocity vector
; 0xFA-0xFE are control codes I haven't deciphered yet
; 0xFF is "restart"

EnemyMovement00:
    SignMagSpeed $20,  2,  2
    .byte $FE

EnemyMovement01:
    SignMagSpeed $20, -2,  2
    .byte $FE

; probably for wavers
EnemyMovement02:
EnemyMovement03:
EnemyMovement04:
EnemyMovement05:
EnemyMovement06:
EnemyMovement07:
EnemyMovement08:
EnemyMovement09:
EnemyMovement0A:
    SignMagSpeed $02,  2, -7
    SignMagSpeed $04,  2, -6
    SignMagSpeed $04,  2, -5
    SignMagSpeed $05,  2, -3
    SignMagSpeed $03,  2, -1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2,  1
    SignMagSpeed $03,  2,  3
    SignMagSpeed $05,  2,  5
    SignMagSpeed $04,  2,  6
    SignMagSpeed $02,  2,  7
    SignMagSpeed $02,  2,  7
    SignMagSpeed $04,  2,  6
    SignMagSpeed $04,  2,  5
    SignMagSpeed $05,  2,  3
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2, -1
    SignMagSpeed $03,  2, -3
    SignMagSpeed $05,  2, -5
    SignMagSpeed $04,  2, -6
    SignMagSpeed $02,  2, -7
    .byte $FD

    SignMagSpeed $03,  2, -5
    SignMagSpeed $06,  2, -3
    SignMagSpeed $08,  2, -1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2,  1
    SignMagSpeed $05,  2,  3
    SignMagSpeed $04,  2,  5
    SignMagSpeed $03,  2,  5
    SignMagSpeed $06,  2,  3
    SignMagSpeed $08,  2,  1
    SignMagSpeed $05,  2,  0
    SignMagSpeed $07,  2, -1
    SignMagSpeed $05,  2, -3
    SignMagSpeed $04,  2, -5
    .byte $FD
    .byte $FF

EnemyMovement0B:
    SignMagSpeed $02, -2, -7
    SignMagSpeed $04, -2, -6
    SignMagSpeed $04, -2, -5
    SignMagSpeed $05, -2, -3
    SignMagSpeed $03, -2, -1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2,  1
    SignMagSpeed $03, -2,  3
    SignMagSpeed $05, -2,  5
    SignMagSpeed $04, -2,  6
    SignMagSpeed $02, -2,  7
    SignMagSpeed $02, -2,  7
    SignMagSpeed $04, -2,  6
    SignMagSpeed $04, -2,  5
    SignMagSpeed $05, -2,  3
    SignMagSpeed $03, -2,  1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2, -1
    SignMagSpeed $03, -2, -3
    SignMagSpeed $05, -2, -5
    SignMagSpeed $04, -2, -6
    SignMagSpeed $02, -2, -7
    .byte $FD

    SignMagSpeed $03, -2, -5
    SignMagSpeed $06, -2, -3
    SignMagSpeed $08, -2, -1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2,  1
    SignMagSpeed $05, -2,  3
    SignMagSpeed $04, -2,  5
    SignMagSpeed $03, -2,  5
    SignMagSpeed $06, -2,  3
    SignMagSpeed $08, -2,  1
    SignMagSpeed $05, -2,  0
    SignMagSpeed $07, -2, -1
    SignMagSpeed $05, -2, -3
    SignMagSpeed $04, -2, -5
    .byte $FD
    .byte $FF

EnemyMovement0C:
    SignMagSpeed $01,  1,  0
    .byte $FF

EnemyMovement0D:  
    SignMagSpeed $01, -1,  0
    .byte $FF

EnemyMovement0E:
    SignMagSpeed $04,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  2
    SignMagSpeed $01,  2,  4
    SignMagSpeed $01,  2,  6
    SignMagSpeed $01,  2,  4
    SignMagSpeed $04,  2,  6
    .byte $FC, $01, $00, $64, $00, $FB

EnemyMovement0F:
    SignMagSpeed $04, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  2
    SignMagSpeed $01, -2,  4
    SignMagSpeed $01, -2,  6
    SignMagSpeed $01, -2,  4
    SignMagSpeed $04, -2,  6
    .byte $FC, $01, $00, $64, $00, $FB

EnemyMovement10:
EnemyMovement11:
EnemyMovement12:
EnemyMovement13:
EnemyMovement14:
EnemyMovement15:
EnemyMovement16:
EnemyMovement17:
EnemyMovement18:
    SignMagSpeed $14,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14, -1,  1
    .byte $FE

EnemyMovement19:
    SignMagSpeed $14, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $14,  1,  1
    .byte $FE

EnemyMovement1A:
    SignMagSpeed $1E,  1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E, -1,  1
    .byte $FE

EnemyMovement1B:
    SignMagSpeed $1E, -1,  1
    SignMagSpeed $0A,  0,  0
    SignMagSpeed $1E,  1,  1
    .byte $FE

EnemyMovement1C:
    SignMagSpeed $50,  4,  0
    .byte $FF

EnemyMovement1D:
    SignMagSpeed $50, -4,  0
    .byte $FF

EnemyMovement1E:
    SignMagSpeed $02,  3, -7
    SignMagSpeed $04,  3, -6
    SignMagSpeed $04,  3, -5
    SignMagSpeed $05,  3, -3
    SignMagSpeed $03,  3, -1
    SignMagSpeed $04,  3,  0
    SignMagSpeed $05,  3,  1
    SignMagSpeed $03,  3,  3
    SignMagSpeed $05,  3,  5
    SignMagSpeed $04,  3,  6
    SignMagSpeed $50,  3,  7
    .byte $FF

EnemyMovement1F:
    SignMagSpeed $02, -3, -7
    SignMagSpeed $04, -3, -6
    SignMagSpeed $04, -3, -5
    SignMagSpeed $05, -3, -3
    SignMagSpeed $03, -3, -1
    SignMagSpeed $04, -3,  0
    SignMagSpeed $05, -3,  1
    SignMagSpeed $03, -3,  3
    SignMagSpeed $05, -3,  5
    SignMagSpeed $04, -3,  6
    SignMagSpeed $50, -3,  7
    .byte $FF

EnemyMovement20:
    SignMagSpeed $02,  4, -7
    SignMagSpeed $04,  4, -6
    SignMagSpeed $04,  4, -5
    SignMagSpeed $05,  4, -3
    SignMagSpeed $03,  4, -1
    SignMagSpeed $04,  4,  0
    SignMagSpeed $05,  4,  1
    SignMagSpeed $03,  4,  3
    SignMagSpeed $05,  4,  5
    SignMagSpeed $04,  4,  6
    SignMagSpeed $50,  4,  7
    .byte $FF

EnemyMovement21:
    SignMagSpeed $02, -4, -7
    SignMagSpeed $04, -4, -6
    SignMagSpeed $04, -4, -5
    SignMagSpeed $05, -4, -3
    SignMagSpeed $03, -4, -1
    SignMagSpeed $04, -4,  0
    SignMagSpeed $05, -4,  1
    SignMagSpeed $03, -4,  3
    SignMagSpeed $05, -4,  5
    SignMagSpeed $04, -4,  6
    SignMagSpeed $50, -4,  7
    .byte $FF

EnemyMovement22:
    SignMagSpeed $02,  2, -7
    SignMagSpeed $04,  2, -6
    SignMagSpeed $04,  2, -5
    SignMagSpeed $05,  2, -3
    SignMagSpeed $03,  2, -1
    SignMagSpeed $04,  2,  0
    SignMagSpeed $05,  2,  1
    SignMagSpeed $03,  2,  3
    SignMagSpeed $05,  2,  5
    SignMagSpeed $04,  2,  6
    SignMagSpeed $50,  2,  7
    .byte $FF

EnemyMovement23:
    SignMagSpeed $02, -2, -7
    SignMagSpeed $04, -2, -6
    SignMagSpeed $04, -2, -5
    SignMagSpeed $05, -2, -3
    SignMagSpeed $03, -2, -1
    SignMagSpeed $04, -2,  0
    SignMagSpeed $05, -2,  1
    SignMagSpeed $03, -2,  3
    SignMagSpeed $05, -2,  5
    SignMagSpeed $04, -2,  6
    SignMagSpeed $50, -2,  7
    .byte $FF

;-------------------------------------------------------------------------------

; Instruction (?) strings of a different type pointed to by EnemyFireballMovementPtrTable
EnemyFireballMovement0:
    SignMagSpeed $04,  3, -3
    SignMagSpeed $05,  3, -2
    SignMagSpeed $06,  3, -1
    SignMagSpeed $07,  3,  0
    SignMagSpeed $06,  3,  1
    SignMagSpeed $05,  3,  2
    SignMagSpeed $50,  3,  3
    .byte $FF

EnemyFireballMovement1:
    SignMagSpeed $09,  2, -4
    SignMagSpeed $08,  2, -2
    SignMagSpeed $07,  2, -1
    SignMagSpeed $07,  2,  1
    SignMagSpeed $08,  2,  2
    SignMagSpeed $09,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnemyFireballMovement2:
    SignMagSpeed $07,  2, -4
    SignMagSpeed $06,  2, -2
    SignMagSpeed $05,  2, -1
    SignMagSpeed $05,  2,  1
    SignMagSpeed $06,  2,  2
    SignMagSpeed $07,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

EnemyFireballMovement3:
    SignMagSpeed $05,  2, -4
    SignMagSpeed $04,  2, -2
    SignMagSpeed $03,  2, -1
    SignMagSpeed $03,  2,  1
    SignMagSpeed $04,  2,  2
    SignMagSpeed $05,  2,  4
    SignMagSpeed $50,  2,  7
    .byte $FF

;-------------------------------------------------------------------------------

CommonEnemyJump_00_01_02:
    lda EnemyStatus81
    cmp #$01
    beq L99B0
    cmp #$03
    beq L99B5
        lda $00
        jmp CommonJump_00
    L99B0:
        lda $01
        jmp CommonJump_01
    L99B5:
        jmp CommonJump_02

.include "enemies/sidehopper.asm"

;-------------------------------------------------------------------------------

.include "enemies/ripper.asm"

;-------------------------------------------------------------------------------

.include "enemies/waver.asm"

;-------------------------------------------------------------------------------
; SkreeRoutine
.include "enemies/skree.asm"
; The crawler routine below depends upon two of the exit labels in skree.asm

;-------------------------------------------------------------------------------

.include "enemies/crawler.asm"

;-------------------------------------------------------------------------------
; Rio/Swooper Routine
.include "enemies/rio.asm"

;-------------------------------------------------------------------------------

.include "enemies/pipe_bug.asm"

;-------------------------------------------------------------------------------
; Brinstar Kraid Routine
.include "enemies/kraid.asm"
; Note: For this bank the functions StorePositionToTemp and LoadPositionFromTemp
;  are in are in kraid.asm. Extract those functions from that file if you plan
;  on removing it.

AreaRoutineStub: ;L9D35
    rts

; More strings pointed to by EnemyFireballMovementPtrTable
TileBlastFrame00:
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF

TileBlastFrame01:
    .byte $22
    .byte $80, $81
    .byte $82, $83

TileBlastFrame02:
    .byte $22
    .byte $84, $85
    .byte $86, $87

TileBlastFrame03:
    .byte $22
    .byte $88, $89
    .byte $8A, $8B

TileBlastFrame04:
    .byte $22
    .byte $8C, $8D
    .byte $8E, $8F

TileBlastFrame05:
    .byte $22
    .byte $94, $95
    .byte $96, $97

TileBlastFrame06:
    .byte $22
    .byte $9C, $9D
    .byte $9D, $9C

TileBlastFrame07:
    .byte $22
    .byte $9E, $9F
    .byte $9F, $9E

TileBlastFrame08:
    .byte $22
    .byte $90, $91
    .byte $92, $93

TileBlastFrame09:
    .byte $32
    .byte $4E, $4E
    .byte $4E, $4E
    .byte $4E, $4E

TileBlastFrame0A:
TileBlastFrame0B:
TileBlastFrame0C:
TileBlastFrame0D:
TileBlastFrame0E:
TileBlastFrame0F:
TileBlastFrame10:
    ; nothing

.include "brinstar/enemy_sprite_data.asm"

;----------------------------------------[ Palette data ]--------------------------------------------

.include "brinstar/palettes.asm"

;----------------------------[ Room and structure pointer tables ]-----------------------------------

.include "brinstar/room_ptrs.asm"

.include "brinstar/structure_ptrs.asm"

;------------------------------------[ Special items table ]-----------------------------------------

.include "brinstar/items.asm"

;-----------------------------------------[ Room definitions ]---------------------------------------

.include "brinstar/rooms.asm"

;---------------------------------------[ Structure definitions ]------------------------------------

.include "brinstar/structures.asm"

;----------------------------------------[ Macro definitions ]---------------------------------------

.include "brinstar/metatiles.asm"

;------------------------------------------[ Area music data ]---------------------------------------

.include "songs/brinstar.asm"

; Errant Mother Brain BG tiles (unused)
    .byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
    .byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
    .byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
    .byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
    .byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
    .byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
    .byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
    .byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
    .byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
    .byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
    .byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
    .byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
; ???
    .byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

.include "music_engine.asm"

;----------------------------------------------[ RESET ]--------------------------------------------

.include "reset.asm"

;----------------------------------------[ Interrupt vectors ]--------------------------------------

.segment "BANK_01_VEC"
    .word NMI                       ;($C0D9)NMI vector.
    .word RESET                     ;($FFB0)Reset vector.
    .word RESET                     ;($FFB0)IRQ vector.
