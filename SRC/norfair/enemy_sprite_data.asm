;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9BDA:  .byte _id_EnFrame00, _id_EnFrame01, $FF

L9BDD:  .byte _id_EnFrame02, $FF

L9BDF:  .byte _id_EnFrame03, _id_EnFrame04, $FF

L9BE2:  .byte _id_EnFrame07, _id_EnFrame08, $FF

L9BE5:  .byte _id_EnFrame05, _id_EnFrame06, $FF

L9BE8:  .byte _id_EnFrame09, _id_EnFrame0A, $FF

L9BEB:  .byte _id_EnFrame0B, $FF

L9BED:  .byte _id_EnFrame0C, _id_EnFrame0D, _id_EnFrame0E, _id_EnFrame0F, $FF

L9BF2:  .byte _id_EnFrame10, _id_EnFrame11, _id_EnFrame12, _id_EnFrame13, $FF

L9BF7:  .byte _id_EnFrame15, _id_EnFrame14, $FF

L9BFA:  .byte _id_EnFrame16, $FF

L9BFC:  .byte _id_EnFrame17, _id_EnFrame18, $FF

L9BFF:  .byte _id_EnFrame19, _id_EnFrame1A, $FF

L9C02:  .byte _id_EnFrame1B, $FF

L9C04:  .byte _id_EnFrame1C, _id_EnFrame1D, $FF

L9C07:  .byte _id_EnFrame1E, _id_EnFrame1F, $FF

L9C0A:  .byte _id_EnFrame20, $FF

L9C0C:  .byte _id_EnFrame21, _id_EnFrame22, $FF

L9C0F:  .byte _id_EnFrame23, $FF

L9C11:  .byte _id_EnFrame27, _id_EnFrame28, _id_EnFrame29, _id_EnFrame2A, $FF

L9C16:  .byte _id_EnFrame2B, _id_EnFrame2C, _id_EnFrame2D, _id_EnFrame2E, $FF

L9C1B:  .byte _id_EnFrame2F, $FF

L9C1D:  .byte _id_EnFrame30, $FF

L9C1F:  .byte _id_EnFrame31, $FF

L9C21:  .byte _id_EnFrame32, $FF

L9C23:  .byte _id_EnFrame33, $FF

L9C25:  .byte _id_EnFrame34, $FF

L9C27:  .byte _id_EnFrame42, $FF

L9C29:  .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

L9C2D:  .byte _id_EnFrame3B, $FF

L9C2F:  .byte _id_EnFrame3C, $FF

L9C31:  .byte _id_EnFrame3D, $FF, _id_EnFrame3E, $FF

L9C35:  .byte _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame3F, _id_EnFrame41, _id_EnFrame41, _id_EnFrame41, _id_EnFrame41, _id_EnFrame40, _id_EnFrame40, _id_EnFrame40, $F7, $FF

L9C43:  .byte _id_EnFrame58, _id_EnFrame59, $FF

L9C46:  .byte _id_EnFrame5A, _id_EnFrame5B, $FF

L9C49:  .byte _id_EnFrame5C, _id_EnFrame5D, $FF

L9C4C:  .byte _id_EnFrame5E, _id_EnFrame5F, $FF

L9C4F:  .byte _id_EnFrame60, $FF

L9C51:  .byte _id_EnFrame61, $F7, _id_EnFrame62, $F7, $FF

L9C56:  .byte _id_EnFrame66, _id_EnFrame67, $FF

L9C59:  .byte _id_EnFrame69, _id_EnFrame6A, $FF

L9C5C:  .byte _id_EnFrame68, $FF

L9C5E:  .byte _id_EnFrame6B, $FF

L9C60:  .byte _id_EnFrame66, $FF

L9C62:  .byte _id_EnFrame69, $FF

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

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace2:
EnPlace3:
    .byte $F4, $F4, $F4, $04

EnPlace5:
    .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

EnPlace6:
    .byte $FC, $F8, $FC, $00

EnPlace4:
    .byte $F0, $F8, $F0, $00

EnPlace7:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

EnPlace8:
    .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC:
    .byte $F8, $FC, $00, $FC

EnPlaceD:
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
    .byte ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $F9
    .byte $F8
    .byte $FF

EnFrame04:
    .byte ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $FF

EnFrame05:
    .byte ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $F9
    .byte $F8
    .byte $FE
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame06:
    .byte ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame07:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $F9
    .byte $F8
    .byte $FF

EnFrame08:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $D5
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $FF

EnFrame09:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $F9
    .byte $F8
    .byte $FE
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame0A:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace2, $13, $08
    .byte $C8
    .byte $C9
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $FE
    .byte $D9
    .byte $E6
    .byte $E7
    .byte $E9
    .byte $EA
    .byte $EB
    .byte $D8
    .byte $FE
    .byte $E8
    .byte $D5
    .byte $FA
    .byte $FF

EnFrame0B:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame0C:
    .byte ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame0D:
    .byte ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame0E:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame0F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame10:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame11:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame12:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame13:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame14:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $FB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $FB
    .byte $FF

EnFrame15:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $FA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $FA
    .byte $FF

EnFrame16:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EB
    .byte $FF

EnFrame17:
    .byte ($2 << 4) + _id_ObjPlace5, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $DF
    .byte $FF

EnFrame18:
    .byte ($2 << 4) + _id_ObjPlace5, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $DE
    .byte $FF

EnFrame19:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace5, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DF
    .byte $FF

EnFrame1A:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace5, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DE
    .byte $FF

EnFrame1B:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

EnFrame1C:
    .byte ($3 << 4) + _id_ObjPlace9, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame1D:
    .byte ($3 << 4) + _id_ObjPlace9, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

EnFrame1E:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_ObjPlace9, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame1F:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_ObjPlace9, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

EnFrame20:
    .byte ($3 << 4) + _id_ObjPlace1, $00, $00
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame21:
    .byte ($2 << 4) + _id_ObjPlace9, $04, $08
    .byte $E6
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E6
    .byte $FF

EnFrame22:
    .byte ($2 << 4) + _id_ObjPlace9, $04, $08
    .byte $E5
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E5
    .byte $FF

EnFrame23:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $EA
    .byte $EA
    .byte $EB
    .byte $EB
    .byte $FF

EnFrame24:
EnFrame25:
EnFrame26:
EnFrame27:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame28:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame29:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2A:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2B:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2C:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2D:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2E:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2F:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

EnFrame30:
    .byte ($2 << 4) + _id_ObjPlace4, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame31:
    .byte ($2 << 4) + _id_ObjPlace4, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C7
    .byte $D8
    .byte $D7
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame32:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace4, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame33:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace4, $08, $08
    .byte $FC, $08, $00
    .byte $C8
    .byte $C7
    .byte $D8
    .byte $D7
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $F9
    .byte $FF

EnFrame34:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $FC, $FC, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $FF

EnFrame35:
EnFrame36:
EnFrame37:
EnFrame38:
EnFrame39:
EnFrame3A:
EnFrame3B:
    .byte ($3 << 4) + _id_ObjPlace7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3C:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_ObjPlace7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3D:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_ObjPlace7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3E:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_ObjPlace7, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame3F:
    .byte ($3 << 4) + _id_ObjPlace7, $00, $00
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $3
    .byte $E2
    .byte $FF

EnFrame40:
    .byte ($3 << 4) + _id_ObjPlace8, $00, $00
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $FF

EnFrame41:
    .byte ($3 << 4) + _id_ObjPlace8, $00, $00
    .byte $FE
    .byte $FE
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $FF

EnFrame42:
    .byte ($3 << 4) + _id_ObjPlace0, $04, $04
    .byte $C0
    .byte $FF

EnFrame43:
    .byte ($3 << 4) + _id_ObjPlace0, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44:
    .byte ($3 << 4) + _id_ObjPlace3, $00, $00
    .byte $D1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $3
    .byte $D1
    .byte $FF

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
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame59:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5A:
    .byte ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5B:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DB
    .byte $FF

EnFrame5C:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5D:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5E:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DB
    .byte $FF

EnFrame60:
    .byte ($2 << 4) + _id_ObjPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

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
    .byte ($2 << 4) + _id_ObjPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame67:
    .byte ($2 << 4) + _id_ObjPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame68:
    .byte ($2 << 4) + _id_ObjPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame69:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame6A:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6B:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_ObjPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

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
