;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTbl:
EnAnim_A406:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_A409:
    .byte _id_EnFrame02, $FF

EnAnim_A40B:
    .byte _id_EnFrame03, _id_EnFrame04, $FF

EnAnim_A40E:
    .byte _id_EnFrame05, $FF

EnAnim_A410:
    .byte _id_EnFrame0E, $FF

EnAnim_A412:
    .byte _id_EnFrame0F, $FF

EnAnim_A414:
    .byte _id_EnFrame10, $FF

EnAnim_A416:
    .byte _id_EnFrame11, _id_EnFrame11, _id_EnFrame12, _id_EnFrame12, $F7, $FF

EnAnim_A41C:
    .byte _id_EnFrame18, $FF

EnAnim_A41E:
    .byte _id_EnFrame19, $F7, $FF

EnAnim_A421:
    .byte _id_EnFrame1B, _id_EnFrame1C, _id_EnFrame1D, $FF

EnAnim_A425:
    .byte _id_EnFrame1E, $FF

EnAnim_A427:
    .byte _id_EnFrame61, $F7, _id_EnFrame62, $F7, $FF

EnAnim_A42C:
    ;nothing

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame02
    PtrTableEntry EnFramePtrTable1, EnFrame03
    PtrTableEntry EnFramePtrTable1, EnFrame04
    PtrTableEntry EnFramePtrTable1, EnFrame05
    PtrTableEntry EnFramePtrTable1, EnFrame06
    PtrTableEntry EnFramePtrTable1, EnFrame07
    PtrTableEntry EnFramePtrTable1, EnFrame08
    PtrTableEntry EnFramePtrTable1, EnFrame09
    PtrTableEntry EnFramePtrTable1, EnFrame0A
    PtrTableEntry EnFramePtrTable1, EnFrame0B
    PtrTableEntry EnFramePtrTable1, EnFrame0C
    PtrTableEntry EnFramePtrTable1, EnFrame0D
    PtrTableEntry EnFramePtrTable1, EnFrame0E
    PtrTableEntry EnFramePtrTable1, EnFrame0F
    PtrTableEntry EnFramePtrTable1, EnFrame10
    PtrTableEntry EnFramePtrTable1, EnFrame11
    PtrTableEntry EnFramePtrTable1, EnFrame12
    PtrTableEntry EnFramePtrTable1, EnFrame13
    PtrTableEntry EnFramePtrTable1, EnFrame14
    PtrTableEntry EnFramePtrTable1, EnFrame15
    PtrTableEntry EnFramePtrTable1, EnFrame16
    PtrTableEntry EnFramePtrTable1, EnFrame17
    PtrTableEntry EnFramePtrTable1, EnFrame18
    PtrTableEntry EnFramePtrTable1, EnFrame19
    PtrTableEntry EnFramePtrTable1, EnFrame1A
    PtrTableEntry EnFramePtrTable1, EnFrame1B
    PtrTableEntry EnFramePtrTable1, EnFrame1C
    PtrTableEntry EnFramePtrTable1, EnFrame1D
    PtrTableEntry EnFramePtrTable1, EnFrame1E
    PtrTableEntry EnFramePtrTable1, EnFrame1F
    PtrTableEntry EnFramePtrTable1, EnFrame20
    PtrTableEntry EnFramePtrTable1, EnFrame21
    PtrTableEntry EnFramePtrTable1, EnFrame22
    PtrTableEntry EnFramePtrTable1, EnFrame23
    PtrTableEntry EnFramePtrTable1, EnFrame24
    PtrTableEntry EnFramePtrTable1, EnFrame25
    PtrTableEntry EnFramePtrTable1, EnFrame26
    PtrTableEntry EnFramePtrTable1, EnFrame27
    PtrTableEntry EnFramePtrTable1, EnFrame28
    PtrTableEntry EnFramePtrTable1, EnFrame29
    PtrTableEntry EnFramePtrTable1, EnFrame2A
    PtrTableEntry EnFramePtrTable1, EnFrame2B
    PtrTableEntry EnFramePtrTable1, EnFrame2C
    PtrTableEntry EnFramePtrTable1, EnFrame2D
    PtrTableEntry EnFramePtrTable1, EnFrame2E
    PtrTableEntry EnFramePtrTable1, EnFrame2F
    PtrTableEntry EnFramePtrTable1, EnFrame30
    PtrTableEntry EnFramePtrTable1, EnFrame31
    PtrTableEntry EnFramePtrTable1, EnFrame32
    PtrTableEntry EnFramePtrTable1, EnFrame33
    PtrTableEntry EnFramePtrTable1, EnFrame34
    PtrTableEntry EnFramePtrTable1, EnFrame35
    PtrTableEntry EnFramePtrTable1, EnFrame36
    PtrTableEntry EnFramePtrTable1, EnFrame37
    PtrTableEntry EnFramePtrTable1, EnFrame38
    PtrTableEntry EnFramePtrTable1, EnFrame39
    PtrTableEntry EnFramePtrTable1, EnFrame3A
    PtrTableEntry EnFramePtrTable1, EnFrame3B
    PtrTableEntry EnFramePtrTable1, EnFrame3C
    PtrTableEntry EnFramePtrTable1, EnFrame3D
    PtrTableEntry EnFramePtrTable1, EnFrame3E
    PtrTableEntry EnFramePtrTable1, EnFrame3F
    PtrTableEntry EnFramePtrTable1, EnFrame40
    PtrTableEntry EnFramePtrTable1, EnFrame41
    PtrTableEntry EnFramePtrTable1, EnFrame42
    PtrTableEntry EnFramePtrTable1, EnFrame43
    PtrTableEntry EnFramePtrTable1, EnFrame44
    PtrTableEntry EnFramePtrTable1, EnFrame45
    PtrTableEntry EnFramePtrTable1, EnFrame46
    PtrTableEntry EnFramePtrTable1, EnFrame47
    PtrTableEntry EnFramePtrTable1, EnFrame48
    PtrTableEntry EnFramePtrTable1, EnFrame49
    PtrTableEntry EnFramePtrTable1, EnFrame4A
    PtrTableEntry EnFramePtrTable1, EnFrame4B
    PtrTableEntry EnFramePtrTable1, EnFrame4C
    PtrTableEntry EnFramePtrTable1, EnFrame4D
    PtrTableEntry EnFramePtrTable1, EnFrame4E
    PtrTableEntry EnFramePtrTable1, EnFrame4F
    PtrTableEntry EnFramePtrTable1, EnFrame50
    PtrTableEntry EnFramePtrTable1, EnFrame51
    PtrTableEntry EnFramePtrTable1, EnFrame52
    PtrTableEntry EnFramePtrTable1, EnFrame53
    PtrTableEntry EnFramePtrTable1, EnFrame54
    PtrTableEntry EnFramePtrTable1, EnFrame55
    PtrTableEntry EnFramePtrTable1, EnFrame56
    PtrTableEntry EnFramePtrTable1, EnFrame57
    PtrTableEntry EnFramePtrTable1, EnFrame58
    PtrTableEntry EnFramePtrTable1, EnFrame59
    PtrTableEntry EnFramePtrTable1, EnFrame5A
    PtrTableEntry EnFramePtrTable1, EnFrame5B
    PtrTableEntry EnFramePtrTable1, EnFrame5C
    PtrTableEntry EnFramePtrTable1, EnFrame5D
    PtrTableEntry EnFramePtrTable1, EnFrame5E
    PtrTableEntry EnFramePtrTable1, EnFrame5F
    PtrTableEntry EnFramePtrTable1, EnFrame60
    PtrTableEntry EnFramePtrTable1, EnFrame61
    PtrTableEntry EnFramePtrTable1, EnFrame62
    PtrTableEntry EnFramePtrTable1, EnFrame63
    PtrTableEntry EnFramePtrTable1, EnFrame64
    PtrTableEntry EnFramePtrTable1, EnFrame65
    PtrTableEntry EnFramePtrTable1, EnFrame66
    PtrTableEntry EnFramePtrTable1, EnFrame67
    PtrTableEntry EnFramePtrTable1, EnFrame68
    PtrTableEntry EnFramePtrTable1, EnFrame69
    PtrTableEntry EnFramePtrTable1, EnFrame6A
    PtrTableEntry EnFramePtrTable1, EnFrame6B
    PtrTableEntry EnFramePtrTable1, EnFrame6C
    PtrTableEntry EnFramePtrTable1, EnFrame6D
    PtrTableEntry EnFramePtrTable1, EnFrame6E
    PtrTableEntry EnFramePtrTable1, EnFrame6F
    PtrTableEntry EnFramePtrTable1, EnFrame70
    PtrTableEntry EnFramePtrTable1, EnFrame71
    PtrTableEntry EnFramePtrTable1, EnFrame72
    PtrTableEntry EnFramePtrTable1, EnFrame73
    PtrTableEntry EnFramePtrTable1, EnFrame74
    PtrTableEntry EnFramePtrTable1, EnFrame75
    PtrTableEntry EnFramePtrTable1, EnFrame76
    PtrTableEntry EnFramePtrTable1, EnFrame77
    PtrTableEntry EnFramePtrTable1, EnFrame78
    PtrTableEntry EnFramePtrTable1, EnFrame79
    PtrTableEntry EnFramePtrTable1, EnFrame7A
    PtrTableEntry EnFramePtrTable1, EnFrame7B
    PtrTableEntry EnFramePtrTable1, EnFrame7C
    PtrTableEntry EnFramePtrTable1, EnFrame7D
    PtrTableEntry EnFramePtrTable1, EnFrame7E
    PtrTableEntry EnFramePtrTable1, EnFrame7F

EnFramePtrTable2:
    PtrTableEntry EnFramePtrTable1, EnFrame80
    PtrTableEntry EnFramePtrTable1, EnFrame81
    PtrTableEntry EnFramePtrTable1, EnFrame82
    PtrTableEntry EnFramePtrTable1, EnFrame83
    PtrTableEntry EnFramePtrTable1, EnFrame84
    PtrTableEntry EnFramePtrTable1, EnFrame85
    PtrTableEntry EnFramePtrTable1, EnFrame86
    PtrTableEntry EnFramePtrTable1, EnFrame87
    PtrTableEntry EnFramePtrTable1, EnFrame88
    PtrTableEntry EnFramePtrTable1, EnFrame89

EnPlacePtrTable:
    PtrTableEntry EnPlacePtrTable, EnPlace0
    PtrTableEntry EnPlacePtrTable, EnPlace1
    PtrTableEntry EnPlacePtrTable, EnPlace2
    PtrTableEntry EnPlacePtrTable, EnPlace3
    PtrTableEntry EnPlacePtrTable, EnPlace4
    PtrTableEntry EnPlacePtrTable, EnPlace5
    PtrTableEntry EnPlacePtrTable, EnPlace6
    PtrTableEntry EnPlacePtrTable, EnPlace7
    PtrTableEntry EnPlacePtrTable, EnPlace8
    PtrTableEntry EnPlacePtrTable, EnPlace9
    PtrTableEntry EnPlacePtrTable, EnPlaceA
    PtrTableEntry EnPlacePtrTable, EnPlaceB
    PtrTableEntry EnPlacePtrTable, EnPlaceC
    PtrTableEntry EnPlacePtrTable, EnPlaceD
    PtrTableEntry EnPlacePtrTable, EnPlaceE
    PtrTableEntry EnPlacePtrTable, EnPlaceF

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace2:
    .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
    .byte $04, $04

EnPlace3:
    .byte $F1, $FC, $F3, $F3, $FC, $F1

EnPlace4:
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace5:
    .byte $FC, $F4, $FC, $FC, $FC, $04

EnPlace6:
EnPlace7:
EnPlace8:
EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
EnPlaceC:
    .byte $F8, $FC, $00, $FC

EnPlaceD:
EnPlaceE:
EnPlaceF:
    ;nothing

;Enemy frame drawing data.

EnFrame00:
    .byte ($0 << 4) + _id_ObjPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte ($0 << 4) + _id_ObjPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame02:
    .byte ($0 << 4) + _id_ObjPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame03:
    .byte ($3 << 4) + _id_ObjPlace2, $0C, $0C
    .byte $C0
    .byte $C1
    .byte $C2
    .byte $D0
    .byte $D1
    .byte $D2
    .byte $E0
    .byte $E1
    .byte $E2
    .byte $FF

EnFrame04:
    .byte ($3 << 4) + _id_ObjPlace2, $0C, $0C
    .byte $C3
    .byte $C4
    .byte $C5
    .byte $D3
    .byte $D4
    .byte $D5
    .byte $E3
    .byte $E4
    .byte $E5
    .byte $FF

EnFrame05:
    .byte ($3 << 4) + _id_ObjPlace1, $00, $00
    .byte $C0
    .byte $C2
    .byte $D0
    .byte $D2
    .byte $E0
    .byte $E2
    .byte $FF

EnFrame06:
    .byte ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame07:
    .byte ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame08:
    .byte ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame09:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame0A:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame0B:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame0C:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame0D:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame0E:
    .byte ($3 << 4) + _id_ObjPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame0F:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_ObjPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame10:
    .byte ($3 << 4) + _id_ObjPlace0, $04, $04
    .byte $F2
    .byte $FF

EnFrame11:
    .byte ($3 << 4) + _id_ObjPlace0, $00, $00
    .byte $FD, $3
    .byte $F3
    .byte $FF

EnFrame12:
    .byte ($0 << 4) + _id_ObjPlaceA, $00, $00
    .byte $FD, $0
    .byte $F4
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FF

EnFrame13:
    .byte ($2 << 4) + _id_ObjPlace4, $08, $14
    .byte $FD, $2
    .byte $FC, $04, $F0
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $FF

EnFrame14:
    .byte ($2 << 4) + _id_ObjPlace4, $14, $0C
    .byte $FD, $2
    .byte $FC, $F4, $F8
    .byte $DA
    .byte $FE
    .byte $C9
    .byte $FF

EnFrame15:
    .byte ($2 << 4) + _id_ObjPlace4, $20, $04
    .byte $FD, $2
    .byte $FC, $EC, $00
    .byte $CB
    .byte $CC
    .byte $DB
    .byte $DC
    .byte $FF

EnFrame16:
    .byte ($2 << 4) + _id_ObjPlace4, $18, $14
    .byte $FD, $2
    .byte $FC, $F4, $10
    .byte $DD
    .byte $CE
    .byte $FE
    .byte $DE
    .byte $FE
    .byte $DD
    .byte $FF

EnFrame17:
    .byte ($2 << 4) + _id_ObjPlace4, $08, $0C
    .byte $FD, $2
    .byte $FC, $0C, $10
    .byte $CD
    .byte $FF

EnFrame18:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $FE
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $FF

EnFrame19:
    .byte ($3 << 4) + _id_ObjPlace0, $00, $00
    .byte $FD, $3
    .byte $ED
    .byte $FF

EnFrame1A:
    .byte ($0 << 4) + _id_ObjPlace5, $04, $08
    .byte $FD, $0
    .byte $00
    .byte $00
    .byte $00
    .byte $FF

EnFrame1B:
    .byte ($3 << 4) + _id_ObjPlaceA, $08, $08
    .byte $FD, $3
    .byte $EF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FF

EnFrame1C:
    .byte ($3 << 4) + _id_ObjPlaceA, $08, $08
    .byte $FD, $03
    .byte $DF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FF

EnFrame1D:
    .byte ($2 << 4) + _id_ObjPlaceA, $08, $08
    .byte $FD, $3
    .byte $CF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FF

EnFrame1E:
    .byte ($0 << 4) + _id_ObjPlace1, $00, $00
    .byte $FF

EnFrame1F:
EnFrame20:
EnFrame21:
EnFrame22:
EnFrame23:
EnFrame24:
EnFrame25:
EnFrame26:
EnFrame27:
EnFrame28:
EnFrame29:
EnFrame2A:
EnFrame2B:
EnFrame2C:
EnFrame2D:
EnFrame2E:
EnFrame2F:
EnFrame30:
EnFrame31:
EnFrame32:
EnFrame33:
EnFrame34:
EnFrame35:
EnFrame36:
EnFrame37:
EnFrame38:
EnFrame39:
EnFrame3A:
EnFrame3B:
EnFrame3C:
EnFrame3D:
EnFrame3E:
EnFrame3F:
EnFrame40:
EnFrame41:
EnFrame42:
EnFrame43:
EnFrame44:
EnFrame45:
EnFrame46:
EnFrame47:
EnFrame48:
EnFrame49:
EnFrame4A:
EnFrame4B:
EnFrame4C:
EnFrame4D:
EnFrame4E:
EnFrame4F:
EnFrame50:
EnFrame51:
EnFrame52:
EnFrame53:
EnFrame54:
EnFrame55:
EnFrame56:
EnFrame57:
EnFrame58:
EnFrame59:
EnFrame5A:
EnFrame5B:
EnFrame5C:
EnFrame5D:
EnFrame5E:
EnFrame5F:
EnFrame60:
EnFrame61:
    .byte ($0 << 4) + _id_ObjPlaceA, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame62:
    .byte ($0 << 4) + _id_ObjPlaceA, $00, $00
    .byte $FE
    .byte $FE
    .byte $FE
    .byte $FE
    .byte $3D
    .byte $3E
    .byte $4E
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $3E
    .byte $3D
    .byte $4E
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $4E
    .byte $3E
    .byte $3D
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $4E
    .byte $3D
    .byte $3E
    .byte $FF

EnFrame63:
EnFrame64:
EnFrame65:
EnFrame66:
EnFrame67:
EnFrame68:
EnFrame69:
EnFrame6A:
EnFrame6B:
EnFrame6C:
EnFrame6D:
EnFrame6E:
EnFrame6F:
EnFrame70:
EnFrame71:
EnFrame72:
EnFrame73:
EnFrame74:
EnFrame75:
EnFrame76:
EnFrame77:
EnFrame78:
EnFrame79:
EnFrame7A:
EnFrame7B:
EnFrame7C:
EnFrame7D:
EnFrame7E:
EnFrame7F:
EnFrame80:
    .byte ($0 << 4) + _id_ObjPlaceC, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame81:
    .byte ($0 << 4) + _id_ObjPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82:
EnFrame83:
EnFrame84:
EnFrame85:
EnFrame86:
EnFrame87:
EnFrame88:
EnFrame89:
    .byte ($0 << 4) + _id_ObjPlace0, $04, $04
    .byte $8A
    .byte $FF
