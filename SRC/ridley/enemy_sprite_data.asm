;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTbl: ;($9B85)
EnAnim_00:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_FireballKilled:
    .byte _id_EnFrame_FireballKilled, $FF

EnAnim_05:
    .byte _id_EnFrame03, _id_EnFrame04, $FF

EnAnim_08:
    .byte _id_EnFrame07, _id_EnFrame08, $FF

EnAnim_0B:
    .byte _id_EnFrame05, _id_EnFrame06, $FF

EnAnim_0E:
    .byte _id_EnFrame09, _id_EnFrame0A, $FF

EnAnim_11:
    .byte _id_EnFrame0B, $FF

EnAnim_13:
    .byte _id_EnFrame0C, _id_EnFrame0D, _id_EnFrame0E, _id_EnFrame0F, $FF

EnAnim_18:
    .byte _id_EnFrame10, _id_EnFrame11, _id_EnFrame12, _id_EnFrame13, $FF

EnAnim_1D:
    .byte _id_EnFrame17, _id_EnFrame18, $FF

EnAnim_20:
    .byte _id_EnFrame19, _id_EnFrame1A, $FF

EnAnim_23:
    .byte _id_EnFrame1B, $FF

EnAnim_25:
    .byte _id_EnFrame21, _id_EnFrame22, $FF

EnAnim_28:
    .byte _id_EnFrame27, _id_EnFrame28, _id_EnFrame29, _id_EnFrame2A, $FF

EnAnim_2D:
    .byte _id_EnFrame2B, _id_EnFrame2C, _id_EnFrame2D, _id_EnFrame2E, $FF

EnAnim_32:
    .byte _id_EnFrame2F, $FF

EnAnim_34:
    .byte _id_EnFrame42, $FF

EnAnim_36:
    .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

EnAnim_3A:
    .byte _id_EnFrame37, $FF

EnAnim_3C:
    .byte _id_EnFrame38, $FF

EnAnim_3E:
    .byte _id_EnFrame30, _id_EnFrame31, $FF

EnAnim_41:
    .byte _id_EnFrame31
EnAnim_42:
    .byte _id_EnFrame32, $FF

EnAnim_44:
    .byte _id_EnFrame33, _id_EnFrame34, $FF

EnAnim_47:
    .byte _id_EnFrame34
EnAnim_48:
    .byte _id_EnFrame35, $FF

EnAnim_4A:
    .byte _id_EnFrame58, _id_EnFrame59, $FF

EnAnim_4D:
    .byte _id_EnFrame5A, _id_EnFrame5B, $FF

EnAnim_50:
    .byte _id_EnFrame5C, _id_EnFrame5D, $FF

EnAnim_53:
    .byte _id_EnFrame5E, _id_EnFrame5F, $FF

EnAnim_56:
    .byte _id_EnFrame60, $FF

EnAnim_58:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_5D:
    .byte _id_EnFrame66, _id_EnFrame67, $FF

EnAnim_60:
    .byte _id_EnFrame69, _id_EnFrame6A, $FF

EnAnim_63:
    .byte _id_EnFrame68, $FF

EnAnim_65:
    .byte _id_EnFrame6B, $FF

EnAnim_67:
    .byte _id_EnFrame66, $FF

EnAnim_69:
    .byte _id_EnFrame69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame_FireballKilled
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
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1
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
    PtrTableEntry EnFramePtrTable1, EnFrame_MissilePickup
    PtrTableEntry EnFramePtrTable1, EnFrame_SmallEnergyPickup
    PtrTableEntry EnFramePtrTable1, EnFrame82
    PtrTableEntry EnFramePtrTable1, EnFrame83
    PtrTableEntry EnFramePtrTable1, EnFrame84
    PtrTableEntry EnFramePtrTable1, EnFrame85
    PtrTableEntry EnFramePtrTable1, EnFrame86
    PtrTableEntry EnFramePtrTable1, EnFrame87
    PtrTableEntry EnFramePtrTable1, EnFrame88
    PtrTableEntry EnFramePtrTable1, EnFrame_BigEnergyPickup

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

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

;Enemy explode.
EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2:
    .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
    .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
    .byte $12, $E8, $14, $F8

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
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlaceE:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

;Enemy frame drawing data.

EnFrame00:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_FireballKilled:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame03:
    .byte ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $13, $14
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
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame0C:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame0D:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame0E:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame0F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame10:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame11:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame12:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame13:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame14:
EnFrame15:
EnFrame16:
EnFrame17:
    .byte ($2 << 4) + _id_EnPlace5, $08, $08
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
    .byte ($2 << 4) + _id_EnPlace5, $08, $08
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
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $08
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
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $08
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
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

EnFrame1C:
EnFrame1D:
EnFrame1E:
EnFrame1F:
EnFrame20:
EnFrame21:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E6
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E6
    .byte $FF

EnFrame22:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E5
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E5
    .byte $FF

EnFrame23:
EnFrame24:
EnFrame25:
EnFrame26:
EnFrame27:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame28:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame29:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2A:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2B:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2C:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2D:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame2E:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame2F:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

EnFrame30:
    .byte ($2 << 4) + _id_EnPlaceD, $08, $0A
    .byte $E2
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FE
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $F2
    .byte $FF

EnFrame31:
    .byte ($2 << 4) + _id_EnPlaceD, $08, $0A
    .byte $E4
    .byte $F2
    .byte $FE
    .byte $FE
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E4
    .byte $F2
    .byte $FF

EnFrame32:
    .byte ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame33:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlaceD, $08, $0A
    .byte $E2
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FE
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $F2
    .byte $FF

EnFrame34:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlaceD, $08, $0A
    .byte $E4
    .byte $F2
    .byte $FE
    .byte $FE
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E4
    .byte $F2
    .byte $FF

EnFrame35:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame36:
EnFrame37:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $FC
    .byte $E2
    .byte $FC, $00, $08
    .byte $E2
    .byte $FC, $00, $F8
    .byte $F2
    .byte $FC, $00, $08
    .byte $F2
    .byte $FF

EnFrame38:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $00, $FC
    .byte $F2
    .byte $FC, $00, $08
    .byte $F2
    .byte $FC, $00, $F8
    .byte $E2
    .byte $FC, $00, $08
    .byte $E2
    .byte $FF

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
    .byte ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $C0
    .byte $FF

EnFrame43:
    .byte ($2 << 4) + _id_EnPlace0, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44:
    .byte ($2 << 4) + _id_EnPlace3, $00, $00
    .byte $D1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
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
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame59:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5A:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5B:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DB
    .byte $FF

EnFrame5C:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5D:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame5E:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame5F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DB
    .byte $FF

EnFrame60:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_Explosion0:
    .byte ($0 << 4) + _id_EnPlaceA, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame_Explosion1:
    .byte ($0 << 4) + _id_EnPlaceA, $00, $00
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
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame67:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame68:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame69:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame6A:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6B:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
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
EnFrame_MissilePickup:
    .byte ($0 << 4) + _id_EnPlaceC, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82:
EnFrame83:
EnFrame84:
EnFrame85:
EnFrame86:
EnFrame87:
EnFrame88:
EnFrame_BigEnergyPickup:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF
