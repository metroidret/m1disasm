; side B file $17 - stg5pgm  (prgram $B560-$CF7F)
; Tourian Area Data

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $13
    .ascstr "STG5PGM", $00
FDSFileMacroPart2 $B560, $00



.redef AREA = "STG5PGM"

PalPntrTbl: ;($B560)
    PtrTableEntryArea PalPntrTbl, Palette00
    PtrTableEntryArea PalPntrTbl, Palette01
    PtrTableEntryArea PalPntrTbl, Palette02
    PtrTableEntryArea PalPntrTbl, Palette03
    PtrTableEntryArea PalPntrTbl, Palette04
    PtrTableEntryArea PalPntrTbl, Palette05
    PtrTableEntryArea PalPntrTbl, Palette06
    PtrTableEntryArea PalPntrTbl, Palette07
    PtrTableEntryArea PalPntrTbl, Palette08
    PtrTableEntryArea PalPntrTbl, Palette09
    PtrTableEntryArea PalPntrTbl, Palette0A
    PtrTableEntryArea PalPntrTbl, Palette0B
    PtrTableEntryArea PalPntrTbl, Palette0C
    PtrTableEntryArea PalPntrTbl, Palette0D
    PtrTableEntryArea PalPntrTbl, Palette0E
    PtrTableEntryArea PalPntrTbl, Palette0F
    PtrTableEntryArea PalPntrTbl, Palette10
    PtrTableEntryArea PalPntrTbl, Palette11
    PtrTableEntryArea PalPntrTbl, Palette12
    PtrTableEntryArea PalPntrTbl, Palette13
    PtrTableEntryArea PalPntrTbl, Palette14
    PtrTableEntryArea PalPntrTbl, Palette15
    PtrTableEntryArea PalPntrTbl, Palette16
    PtrTableEntryArea PalPntrTbl, Palette17
    
SpecItmsTblPtr: ;($B590)
    .word SpecItmsTbl_{AREA}

AreaPointers: ;($B592)
    .word RoomPtrTable_{AREA}
    .word StructPtrTable_{AREA}
    .word MetatileDefs_{AREA}
    .word EnFramePtrTable1_{AREA}
    .word EnFramePtrTable2_{AREA}
    .word EnPlacePtrTable_{AREA}
    .word EnAnimTable_{AREA}
    
    .byte $4C, $93, $C3
    .byte $4C, $88, $C3
    .byte $4C, $67, $BC
    .byte $4C, $DE, $BC
    .byte $4C, $19, $BD
    .byte $4C, $35, $BD
    .byte $4C, $64, $BD
    .byte $4C, $41, $C1
    .byte $4C, $BD, $C1
    
    .byte $4C, $1D, $BB
    
    .byte $49, $FF
    .byte $18, $69, $01, $60
    
    .byte $FF
    
    .byte $40
    
    .word $0300
    
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    .byte $03
    
    .byte $04
    
    .byte $6E
    
    .byte $06
    
    .byte $00
    
    .byte $03
    
    .byte $21
    
    .byte $00, $00
    
    .byte $00, $00
    
    .byte $00, $10
    
    .byte $00
    
; Enemy AI jump table
ChooseEnemyAIRoutine: ;($B5DD)
    lda EnsExtra.0.type,x
    jsr CommonJump_ChooseRoutine
        .word $B7F1
        .word $B7F1
        .word $BA1F
        .word $B7D4
        .word $BA24
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
        .word $B7D4
    
    .byte $08, $08
    .byte $08, $08
    .byte $16, $16
    .byte $18, $18
    .byte $1F, $1F
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    
    .byte $FF, $FF, $01, $FF, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $05, $05, $05, $05, $16, $16, $18, $18, $1B, $1B, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $05, $05, $05, $05, $16, $16, $18, $18, $1D, $1D, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $FE, $FE, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $00, $02, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $B7CD, $B7CD
    .word $0000, $0000
    .word $0000, $0000
    
    .byte $18, $30, $00, $C0, $D0, $00, $00, $7F, $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $18, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $50, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    
    .byte $00, $00
    .byte $26, $26
    .byte $26, $26
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $0C, $F4
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
    .byte $F4
    .byte $00
    .byte $00
    .byte $00
    
    .word $B7CD
    .word $B7CD
    .word $B7D0
    .word $B7D3
    .word $C39E
    .word $C3A3
    .word $C3AC
    .word $C3BD
    .word $C3CE
    .word $C3DF
    .word $C3F0
    .word $C3FD
    .word $C406
    .word $C417
    .word $C428
    .word $C439
    .word $C44A
    .word $C453
    .word $C45C
    .word $C465
    .word $C46E
    
    .byte $00
        .byte $00
    .byte $00
        .byte $01





    .byte $50, $22
    .byte $FF
    
    .byte $50, $30
    .byte $FF
    
    .byte $FF



    .byte $A9, $00
    .byte $9D, $60, $B4
    .byte $60
    
    .byte $A5, $7C
    .byte $C9, $01
    .byte $F0, $09
    .byte $C9, $03
    .byte $F0, $0A
    .byte $A5, $00
    .byte $4C, $00, $6C
    .byte $A5, $01
    .byte $4C, $03, $6C
    .byte $4C, $06, $6C



; enemy ai routines
    .byte $AC, $0B, $01, $C8, $F0, $05, $A9, $00, $9D, $60, $B4, $A9, $0F, $85, $00
    .byte $85, $01, $BD, $05, $04, $0A, $30, $D2, $BD, $60, $B4, $C9, $03, $F0, $CB, $20
    .byte $AF, $B9, $B9, $19, $BA, $F0, $03, $4C, $91, $B8, $BC, $08, $04, $B9, $17, $BA
    .byte $48, $BD, $02, $04, $10, $0D, $68, $20, $BE, $B5, $48, $A9, $00, $DD, $06, $04
    .byte $FD, $02, $04, $D9, $17, $BA, $68, $90, $08, $9D, $02, $04, $A9, $00, $9D, $06
    .byte $04, $B9, $17, $BA, $48, $BD, $03, $04, $10, $0D, $68, $20, $BE, $B5, $48, $A9
    .byte $00, $DD, $07, $04, $FD, $03, $04, $D9, $17, $BA, $68, $90, $08, $9D, $03, $04
    .byte $A9, $00, $9D, $07, $04, $BD, $05, $04, $48, $20, $FE, $B9, $9D, $6B, $B4, $68
    .byte $4A, $4A, $20, $FE, $B9, $9D, $6A, $B4, $BD, $60, $B4, $C9, $04, $D0, $0D, $BC
    .byte $0B, $04, $C8, $D0, $0C, $A9, $05, $9D, $0B, $04, $D0, $05, $A9, $FF, $9D, $0B
    .byte $04, $A5, $7C, $C9, $06, $D0, $0A, $DD, $60, $B4, $F0, $05, $A9, $04, $9D, $60
    .byte $B4, $BD, $04, $04, $29, $20, $F0, $5F, $20, $AF, $B9, $B9, $19, $BA, $F0, $37
    .byte $BD, $0E, $04, $C9, $07, $F0, $04, $C9, $0A, $D0, $6F, $A5, $27, $29, $02, $D0
    .byte $69, $B9, $19, $BA, $18, $69, $10, $99, $19, $BA, $29, $70, $C9, $50, $D0, $5A
    .byte $A9, $02, $1D, $0F, $04, $9D, $0C, $04, $A9, $06, $9D, $60, $B4, $A9, $20, $9D
    .byte $0F, $04, $A9, $01, $9D, $0D, $04, $A9, $00, $9D, $04, $04, $99, $19, $BA, $9D
    .byte $06, $04, $9D, $07, $04, $BD, $6A, $B4, $20, $08, $BA, $9D, $02, $04, $BD, $6B
    .byte $B4, $20, $08, $BA, $9D, $03, $04, $20, $AF, $B9, $B9, $19, $BA, $D0, $1B, $BD
    .byte $04, $04, $29, $04, $F0, $46, $BD, $03, $04, $29, $80, $09, $01, $A8, $20, $BB
    .byte $B9, $20, $B5, $B9, $98, $9D, $19, $BA, $8A, $A8, $98, $AA, $BD, $19, $BA, $08
    .byte $29, $0F, $C9, $0C, $F0, $03, $FE, $19, $BA, $A8, $B9, $CF, $B9, $85, $04, $84
    .byte $05, $A9, $0C, $38, $E5, $05, $A6, $45, $28, $30, $03, $20, $BE, $B5, $85, $05
    .byte $20, $DC, $B9, $20, $27, $6C, $20, $EC, $B9, $4C, $5F, $B9, $20, $A6, $B9, $BD
    .byte $60, $B4, $C9, $03, $D0, $03, $20, $A6, $B9, $A0, $00, $AD, $19, $BA, $0D, $1A
    .byte $BA, $0D, $1B, $BA, $0D, $1C, $BA, $0D, $1D, $BA, $0D, $1E, $BA, $29, $0C, $C9
    .byte $0C, $D0, $13, $AD, $06, $01, $0D, $07, $01, $F0, $0B, $84, $69, $A0, $04, $84
    .byte $68, $20, $42, $6C, $A0, $01, $84, $8D, $A5, $65, $30, $07, $BD, $6E, $B4, $09
    .byte $A2, $85, $65, $4C, $DA, $B7, $20, $AF, $B9, $A9, $00, $99, $19, $BA, $60, $8A
    .byte $20, $13, $BB, $A8, $60, $8A, $20, $13, $BB, $AA, $60, $A9, $00, $9D, $02, $04
    .byte $9D, $03, $04, $9D, $07, $04, $9D, $06, $04, $9D, $6B, $B4, $9D, $6A, $B4, $60
    .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8, $AD, $0E, $03, $85
    .byte $09, $AD, $0D, $03, $85, $08, $AD, $0C, $03, $85, $0B, $60, $A5, $09, $9D, $01
    .byte $04, $A5, $08, $9D, $00, $04, $A5, $0B, $29, $01, $9D, $67, $B4, $60, $4A, $BD
    .byte $08, $04, $2A, $A8, $B9, $13, $BA, $60, $0A, $2A, $29, $01, $A8, $B9, $11, $BA
    .byte $60, $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00, $A9
    .byte $01, $4C, $03, $6C, $BC, $60, $B4, $C0, $02, $D0, $7D, $88, $C4, $7C, $D0, $78
    .byte $A9, $00, $20, $C9, $B9, $9D, $68, $B4, $9D, $69, $B4, $AD, $0E, $03, $38, $FD
    .byte $01, $04, $85, $01, $BD, $05, $04, $48, $4A, $48, $90, $06, $A9, $00, $E5, $01
    .byte $85, $01, $AD, $0D, $03, $38, $FD, $00, $04, $85, $00, $68, $4A, $4A, $90, $06
    .byte $A9, $00, $E5, $00, $85, $00, $A5, $00, $05, $01, $A0, $03, $0A, $B0, $03, $88
    .byte $D0, $FA, $88, $30, $06, $46, $00, $46, $01, $10, $F7, $20, $F1, $BA, $68, $4A
    .byte $48, $90, $10, $A9, $00, $FD, $07, $04, $9D, $07, $04, $A9, $00, $FD, $03, $04
    .byte $9D, $03, $04, $68, $4A, $4A, $90, $10, $A9, $00, $FD, $06, $04, $9D, $06, $04
    .byte $A9, $00, $FD, $02, $04, $9D, $02, $04, $BD, $05, $04, $0A, $30, $3E, $BD, $06
    .byte $04, $18, $7D, $68, $B4, $9D, $68, $B4, $BD, $02, $04, $69, $00, $85, $04, $BD
    .byte $07, $04, $18, $7D, $69, $B4, $9D, $69, $B4, $BD, $03, $04, $69, $00, $85, $05
    .byte $BD, $00, $04, $85, $08, $BD, $01, $04, $85, $09, $BD, $67, $B4, $85, $0B, $20
    .byte $27, $6C, $B0, $05, $A9, $00, $9D, $60, $B4, $20, $EC, $B9, $A9, $08, $4C, $03
    .byte $6C, $A5, $00, $48, $20, $13, $BB, $9D, $02, $04, $68, $20, $18, $BB, $9D, $06
    .byte $04, $A5, $01, $48, $20, $13, $BB, $9D, $03, $04, $68, $20, $18, $BB, $9D, $07
    .byte $04, $60, $4A, $4A, $4A, $4A, $4A, $60, $0A, $0A, $0A, $0A, $60, $20, $2F, $BB
    .byte $20, $CC, $BD, $20, $62, $C2, $20, $B3, $C2, $20, $FE, $C2, $4C, $D9, $C1, $A2
    .byte $78, $20, $3C, $BB, $A5, $97, $38, $E9, $08, $AA, $D0, $F5, $86, $97, $BC, $C1
    .byte $C0, $D0, $01, $60, $20, $45, $BC, $98, $D0, $F9, $AC, $0B, $01, $C8, $D0, $0D
    .byte $BD, $C5, $C0, $C9, $05, $F0, $EC, $20, $68, $BB, $4C, $23, $BC, $A5, $27, $29
    .byte $02, $D0, $E0, $A9, $19, $4C, $29, $BC, $BC, $C5, $C0, $BD, $C7, $C0, $D0, $09
    .byte $B9, $87, $BD, $9D, $C7, $C0, $FE, $C8, $C0, $DE, $C7, $C0, $B9, $8C, $BD, $18
    .byte $7D, $C8, $C0, $A8, $B9, $91, $BD, $10, $1A, $C9, $FF, $D0, $0A, $BC, $C5, $C0
    .byte $A9, $00, $9D, $C8, $C0, $F0, $E5, $FE, $C8, $C0, $20, $A7, $BB, $BC, $C5, $C0
    .byte $4C, $7C, $BB, $9D, $C6, $C0, $60, $48, $A5, $98, $C9, $04, $B0, $10, $A0, $60
    .byte $B9, $60, $B4, $F0, $0B, $98, $18, $69, $10, $A8, $C9, $A0, $D0, $F2, $68, $60
    .byte $84, $45, $BD, $C2, $C0, $99, $00, $04, $BD, $C3, $C0, $99, $01, $04, $BD, $C4
    .byte $C0, $99, $67, $B4, $A9, $02, $99, $60, $B4, $A9, $00, $99, $09, $04, $99, $64
    .byte $B4, $99, $08, $04, $68, $20, $BE, $B5, $AA, $99, $0A, $04, $09, $02, $99, $05
    .byte $04, $BD, $1E, $BC, $99, $65, $B4, $99, $66, $B4, $BD, $C4, $BD, $85, $05, $BD
    .byte $C7, $BD, $85, $04, $A6, $97, $BD, $C2, $C0, $85, $08, $BD, $C3, $C0, $85, $09
    .byte $BD, $C4, $C0, $85, $0B, $98, $AA, $20, $27, $6C, $20, $EC, $B9, $A6, $97, $60
    .byte $0C, $0A, $0E, $BC, $C6, $C0, $B9, $BE, $BD, $8D, $43, $B5, $BD, $C2, $C0, $8D
    .byte $E0, $04, $BD, $C3, $C0, $8D, $E1, $04, $BD, $C4, $C0, $8D, $47, $B5, $A9, $E0
    .byte $85, $45, $4C, $3C, $6C, $A0, $00, $BD, $C3, $C0, $C5, $FD, $A5, $43, $29, $02
    .byte $D0, $05, $BD, $C2, $C0, $C5, $FC, $BD, $C4, $C0, $45, $FF, $29, $01, $F0, $03
    .byte $B0, $03, $38, $B0, $01, $C8, $60, $84, $02, $A0, $00, $B9, $C4, $C0, $45, $02
    .byte $4A, $B0, $05, $A9, $00, $99, $C1, $C0, $98, $18, $69, $08, $A8, $10, $EC, $A2
    .byte $00, $BD, $58, $07, $F0, $0B, $20, $5C, $BD, $5D, $5A, $07, $D0, $03, $9D, $58
    .byte $07, $8A, $18, $69, $08, $AA, $C9, $28, $D0, $E7, $A2, $00, $20, $CE, $BC, $A2
    .byte $03, $20, $CE, $BC, $A5, $98, $F0, $13, $C9, $07, $F0, $0F, $C9, $0A, $F0, $0B
    .byte $A5, $9D, $45, $02, $4A, $B0, $04, $A9, $00, $85, $98, $AD, $0D, $01, $F0, $0D
    .byte $AD, $0C, $01, $45, $02, $4A, $B0, $05, $A9, $00, $8D, $0D, $01, $60, $B5, $86
    .byte $30, $0B, $B5, $87, $45, $02, $4A, $B0, $04, $A9, $FF, $95, $86, $60, $A2, $00
    .byte $BD, $C1, $C0, $F0, $09, $8A, $18, $69, $08, $AA, $10, $F4, $30, $2A, $B1, $00
    .byte $20, $13, $BB, $9D, $C5, $C0, $A9, $01, $9D, $C1, $C0, $9D, $C8, $C0, $C8, $B1
    .byte $00, $48, $29, $F0, $09, $07, $9D, $C2, $C0, $68, $20, $18, $BB, $09, $07, $9D
    .byte $C3, $C0, $20, $80, $BD, $9D, $C4, $C0, $60, $A9, $01, $85, $98, $20, $80, $BD
    .byte $85, $9D, $49, $01, $AA, $AD, $34, $BD, $15, $66, $95, $66, $A9, $20, $85, $9A
    .byte $85, $9B, $60, $02, $01, $B1, $00, $29, $F0, $4A, $AA, $0A, $29, $10, $49, $10
    .byte $09, $84, $9D, $59, $07, $20, $5C, $BD, $9D, $5A, $07, $A9, $01, $9D, $58, $07
    .byte $A9, $00, $9D, $5B, $07, $9D, $5C, $07, $9D, $5D, $07, $60, $20, $80, $BD, $0A
    .byte $0A, $09, $61, $60, $A2, $03, $20, $6D, $BD, $30, $14, $A2, $00, $B5, $86, $10
    .byte $0E, $B1, $00, $20, $13, $BB, $95, $86, $20, $80, $BD, $95, $87, $A9, $FF, $60
    .byte $A5, $FF, $45, $43, $29, $01, $60, $28, $28, $28, $28, $28, $00, $0B, $16, $21
    .byte $27, $00, $01, $02, $FD, $03, $04, $FD, $03, $02, $01, $FF, $00, $07, $06, $FE
    .byte $05, $04, $FE, $05, $06, $07, $FF, $02, $03, $FC, $04, $05, $06, $05, $FC, $04
    .byte $03, $FF, $02, $03, $FC, $04, $03, $FF, $06, $05, $FC, $04, $05, $FF, $06, $07
    .byte $08, $09, $0A, $0B, $0C, $0D, $09, $F7, $00, $09, $09, $0B, $A5, $98, $F0, $19
    .byte $20, $24, $6C, $C3, $B5, $1A, $BE, $2E, $BE, $4A, $BE, $7E, $BE, $FA, $BE, $41
    .byte $BF, $B8, $BF, $FA, $BE, $D5, $BF, $C3, $B5, $60, $AD, $0C, $03, $45, $9D, $D0
    .byte $F8, $AD, $0E, $03, $38, $E9, $48, $C9, $20, $B0, $EE, $AD, $0D, $03, $38, $E9
    .byte $80, $10, $03, $20, $BE, $B5, $C9, $20, $B0, $DF, $A9, $00, $85, $68, $A9, $02
    .byte $85, $69, $A9, $38, $8D, $0A, $03, $4C, $42, $6C, $20, $EA, $BD, $20, $E8, $BF
    .byte $20, $16, $C0, $20, $29, $C0, $20, $3C, $C0, $A9, $00, $85, $9E, $60, $20, $3B
    .byte $BE, $B9, $39, $BE, $85, $1C, $4C, $29, $BE, $08, $07, $C6, $9F, $D0, $04, $A9
    .byte $01, $85, $98, $A5, $9F, $29, $02, $4A, $A8, $60, $20, $3B, $BE, $B9, $39, $BE
    .byte $85, $1C, $98, $0A, $0A, $85, $FC, $A4, $98, $88, $D0, $1F, $84, $99, $98, $AA
    .byte $98, $9D, $60, $B4, $20, $F1, $BE, $E0, $C0, $D0, $F5, $A9, $04, $85, $98, $A9
    .byte $28, $85, $9F, $AD, $80, $06, $09, $01, $8D, $80, $06, $4C, $26, $BE, $A9, $10
    .byte $0D, $80, $06, $8D, $80, $06, $20, $6D, $C0, $E6, $9A, $20, $3B, $BE, $A2, $00
    .byte $BD, $60, $B4, $C9, $05, $D0, $05, $A9, $00, $9D, $60, $B4, $20, $F1, $BE, $C9
    .byte $40, $D0, $ED, $AD, $A0, $07, $D0, $05, $B9, $F8, $BE, $85, $1C, $A4, $98, $88
    .byte $D0, $1B, $84, $9A, $A9, $04, $85, $98, $A9, $1C, $85, $9F, $A4, $99, $E6, $99
    .byte $C0, $05, $F0, $07, $A2, $00, $90, $05, $4C, $CE, $BE, $46, $9F, $60, $AD, $85
    .byte $06, $09, $04, $8D, $85, $06, $A9, $05, $85, $98, $A9, $80, $85, $99, $60, $48
    .byte $29, $F0, $09, $07, $9D, $00, $04, $68, $20, $18, $BB, $09, $07, $9D, $01, $04
    .byte $60, $8A, $18, $69, $10, $AA, $60, $60, $09, $0A, $A5, $99, $30, $2D, $C9, $08
    .byte $F0, $2C, $A8, $B9, $39, $BF, $8D, $03, $05, $B9, $31, $BF, $18, $69, $42, $8D
    .byte $08, $05, $08, $A5, $9D, $0A, $0A, $28, $69, $61, $8D, $09, $05, $A9, $00, $85
    .byte $45, $AD, $A0, $07, $D0, $0A, $20, $3F, $6C, $B0, $05, $E6, $99, $60, $E6, $98
    .byte $60, $00, $40, $08, $48, $80, $C0, $88, $C8, $08, $02, $09, $03, $0A, $04, $0B
    .byte $05, $20, $61, $BF, $B0, $16, $A9, $00, $85, $98, $A9, $99, $8D, $0A, $01, $8D
    .byte $0B, $01, $A9, $01, $8D, $0D, $01, $A5, $9D, $8D, $0C, $01, $60, $80, $B0, $A0
    .byte $90, $A5, $4A, $18, $65, $49, $38, $2A, $29, $03, $A8, $BE, $5D, $BF, $A9, $01
    .byte $9D, $0F, $03, $A9, $01, $9D, $07, $03, $A9, $03, $9D, $00, $03, $A5, $9D, $9D
    .byte $0C, $03, $A9, $10, $9D, $0E, $03, $A9, $68, $9D, $0D, $03, $A9, $55, $9D, $05
    .byte $03, $9D, $06, $03, $A9, $00, $9D, $04, $03, $A9, $F7, $9D, $03, $03, $A9, $10
    .byte $8D, $03, $05, $A9, $40, $8D, $08, $05, $A5, $9D, $0A, $0A, $09, $61, $8D, $09
    .byte $05, $A9, $00, $85, $45, $4C, $3F, $6C, $A9, $10, $0D, $80, $06, $8D, $80, $06
    .byte $A5, $26, $D0, $10, $A9, $08, $8D, $00, $03, $A9, $0A, $85, $98, $8D, $20, $B4
    .byte $A9, $01, $85, $1C, $60, $20, $61, $BF, $B0, $0D, $A5, $9D, $8D, $0C, $01, $A0
    .byte $01, $8C, $0D, $01, $88, $84, $98, $60, $A5, $9E, $F0, $29, $AD, $84, $06, $09
    .byte $02, $8D, $84, $06, $E6, $99, $A5, $99, $C9, $20, $A0, $02, $A9, $10, $90, $11
    .byte $A2, $00, $A9, $00, $9D, $00, $05, $20, $F1, $BE, $C9, $D0, $D0, $F4, $C8, $A9
    .byte $80, $84, $98, $85, $9F, $60, $C6, $9A, $D0, $0E, $A5, $28, $29, $03, $85, $9C
    .byte $A9, $20, $38, $E5, $99, $4A, $85, $9A, $60, $C6, $9B, $A5, $9B, $0A, $D0, $0B
    .byte $A9, $20, $38, $E5, $99, $09, $80, $45, $9B, $85, $9B, $60, $A9, $E0, $85, $45
    .byte $A5, $9D, $8D, $47, $B5, $A9, $70, $8D, $E0, $04, $A9, $48, $8D, $E1, $04, $A4
    .byte $9C, $B9, $68, $C0, $8D, $43, $B5, $20, $3C, $6C, $A5, $9B, $30, $09, $AD, $6C
    .byte $C0, $8D, $43, $B5, $20, $3C, $6C, $60, $13, $14, $15, $16, $17, $A4, $99, $F0
    .byte $10, $B9, $BB, $C0, $18, $65, $9A, $A8, $B9, $9E, $C0, $C9, $FF, $D0, $03, $C6
    .byte $9A, $60, $69, $44, $8D, $08, $05, $08, $A5, $9D, $0A, $0A, $09, $61, $28, $69
    .byte $00, $8D, $09, $05, $A9, $00, $8D, $03, $05, $85, $45, $4C, $3F, $6C, $00, $02
    .byte $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27, $FF, $82
    .byte $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86, $FF, $00, $0C, $11, $16
    .byte $1A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $A5, $6B, $F0, $74, $A6, $45, $BD, $00, $03, $C9, $0B, $D0, $6B, $C0, $98
    .byte $D0, $2C, $A2, $00, $BD, $00, $05, $F0, $09, $20, $F1, $BE, $C9, $D0, $D0, $F4
    .byte $F0, $57, $A9, $8C, $9D, $08, $05, $A5, $05, $9D, $09, $05, $A9, $06, $9D, $03
    .byte $05, $A5, $45, $48, $86, $45, $20, $3F, $6C, $68, $85, $45, $D0, $3B, $A5, $04
    .byte $4A, $90, $02, $C6, $04, $A0, $00, $B1, $04, $4A, $B0, $2D, $C9, $48, $90, $29
    .byte $C9, $4C, $B0, $25, $B9, $58, $07, $F0, $10, $A5, $04, $29, $9E, $D9, $59, $07
    .byte $D0, $07, $A5, $05, $D9, $5A, $07, $F0, $0B, $98, $18, $69, $08, $A8, $C9, $28
    .byte $D0, $E2, $F0, $05, $A9, $01, $99, $5D, $07, $68, $68, $18, $60, $A8, $A5, $6B
    .byte $F0, $15, $A6, $45, $BD, $00, $03, $C9, $0B, $D0, $0C, $C0, $5E, $90, $08, $C0
    .byte $72, $B0, $04, $A9, $01, $85, $9E, $98, $60, $AC, $0B, $01, $C8, $D0, $76, $A0
    .byte $03, $20, $E6, $C1, $A0, $00, $84, $45, $B9, $86, $00, $30, $EB, $B9, $87, $00
    .byte $45, $27, $4A, $90, $E3, $A5, $98, $C9, $04, $B0, $DD, $A5, $27, $29, $06, $D0
    .byte $D7, $A2, $20, $BD, $60, $B4, $F0, $0F, $BD, $05, $04, $29, $02, $F0, $08, $8A
    .byte $38, $E9, $10, $AA, $10, $ED, $60, $A9, $01, $9D, $60, $B4, $A9, $04, $9D, $6E
    .byte $B4, $A9, $00, $9D, $0F, $04, $9D, $04, $04, $20, $2A, $6C, $A9, $F7, $9D, $63
    .byte $B4, $A4, $45, $B9, $87, $00, $9D, $67, $B4, $B9, $88, $00, $0A, $19, $86, $00
    .byte $A8, $B9, $56, $C2, $20, $DF, $BE, $A6, $45, $F6, $88, $B5, $88, $C9, $06, $D0
    .byte $04, $A9, $00, $95, $88, $60, $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA
    .byte $BA, $BA, $AC, $0B, $01, $C8, $F0, $4A, $AD, $0A, $01, $85, $03, $A9, $01, $38
    .byte $20, $45, $6C, $8D, $0A, $01, $AD, $0B, $01, $85, $03, $A9, $00, $20, $45, $6C
    .byte $8D, $0B, $01, $A5, $27, $29, $0F, $D0, $08, $AD, $84, $06, $09, $01, $8D, $84
    .byte $06, $AD, $0A, $01, $0D, $0B, $01, $D0, $19, $CE, $0B, $01, $85, $99, $A9, $07
    .byte $85, $98, $AD, $80, $06, $09, $01, $8D, $80, $06, $A9, $0C, $85, $26, $A9, $0B
    .byte $85, $1C, $60, $AD, $0D, $01, $F0, $45, $AD, $0C, $01, $8D, $47, $B5, $A9, $84
    .byte $8D, $E0, $04, $A9, $64, $8D, $E1, $04, $A9, $1A, $8D, $43, $B5, $A9, $E0, $85
    .byte $45, $A5, $55, $48, $20, $3C, $6C, $68, $C5, $55, $F0, $21, $AA, $AD, $0B, $01
    .byte $4A, $4A, $4A, $38, $6A, $9D, $01, $02, $AD, $0B, $01, $29, $0F, $09, $80, $9D
    .byte $05, $02, $AD, $0A, $01, $4A, $4A, $4A, $38, $6A, $9D, $09, $02, $60, $A9, $10
    .byte $85, $45, $A2, $20, $20, $0E, $C3, $8A, $38, $E9, $08, $AA, $D0, $F6, $BD, $58
    .byte $07, $29, $0F, $C9, $01, $D0, $E6, $BD, $5D, $07, $F0, $49, $FE, $5B, $07, $BD
    .byte $5B, $07, $4A, $B0, $40, $A8, $E9, $03, $D0, $03, $FE, $58, $07, $B9, $83, $C3
    .byte $8D, $13, $05, $BD, $59, $07, $8D, $18, $05, $BD, $5A, $07, $8D, $19, $05, $AD
    .byte $A0, $07, $D0, $09, $8A, $48, $20, $3F, $6C, $68, $AA, $90, $11, $BD, $58, $07
    .byte $29, $80, $09, $01, $9D, $58, $07, $9D, $5D, $07, $DE, $5B, $07, $60, $A9, $40
    .byte $9D, $5C, $07, $D0, $18, $BC, $5B, $07, $F0, $13, $DE, $5C, $07, $D0, $0E, $A9
    .byte $40, $9D, $5C, $07, $88, $98, $9D, $5B, $07, $4A, $A8, $90, $B0, $A9, $00, $9D
    .byte $5D, $07, $60, $0C, $0D, $0E, $0F, $07, $A0, $05, $20, $A9, $B9, $88, $10, $FA
    .byte $85, $8D, $60, $8A, $20, $13, $BB, $A8, $20, $A9, $B9, $85, $8D



    .byte $60
    
    .byte $22
    .byte $FF, $FF
    .byte $FF, $FF
    
    .byte $42
    .byte $FF, $98
    .byte $FF, $98
    .byte $FF, $98
    .byte $FF, $98
    
    .byte $28
    .byte $FF, $FF, $FF, $D1, $FF, $FF, $FF, $D1
    .byte $FF, $FF, $D6, $D6, $DA, $DB, $FF, $D6
    
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $DC, $D0, $DD, $DE, $FF, $DF, $E0, $FF
    
    .byte $28
    .byte $FF, $FF, $FF, $FF, $E9, $EA, $E4, $E5
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    .byte $62
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    
    .byte $42
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    .byte $FF, $FF
    
    .byte $28
    .byte $FF, $FF, $D1, $D1, $FF, $D1, $FF, $D1
    .byte $FF, $FF, $D0, $D2, $D3, $D4, $D5, $D6
    
    .byte $28
    .byte $FF, $FF, $FF, $D1, $FF, $FF, $FF, $FF
    .byte $D3, $FF, $D7, $D8, $D9, $FF, $FF, $FF
    
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    .byte $28
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    .byte $42
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91
    .byte $90, $91
    
    .byte $42
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93
    .byte $92, $93
    
    .byte $42
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95
    .byte $94, $95
    
    .byte $42
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97
    .byte $96, $97
    
    .byte $62
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0
    .byte $A0, $A0



.include "sideB/tourian/enemy_sprite_data.asm"


.include "sideB/tourian/palettes.asm"


.include "sideB/tourian/room_ptrs.asm"


.include "sideB/tourian/structure_ptrs.asm"


.include "sideB/tourian/items.asm"


.include "sideB/tourian/rooms.asm"


.include "sideB/tourian/structures.asm"


.include "sideB/tourian/metatiles.asm"



    .byte $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03



FDSFileMacroPart3

