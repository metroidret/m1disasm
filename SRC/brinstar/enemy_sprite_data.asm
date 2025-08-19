;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTbl: ;($9D6A)
EnAnim_00:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_FireballKilled:
    .byte _id_EnFrame_FireballKilled, $FF

EnAnim_05:
    .byte _id_EnFrame19, _id_EnFrame1A, $FF

EnAnim_08:
    .byte _id_EnFrame1A
EnAnim_09:
    .byte _id_EnFrame1B, $FF

EnAnim_0B:
    .byte _id_EnFrame1C, _id_EnFrame1D, $FF

EnAnim_0E:
    .byte _id_EnFrame1D
EnAnim_0F:
    .byte _id_EnFrame1E, $FF

EnAnim_11:
    .byte _id_EnFrame22, _id_EnFrame23
EnAnim_13:
    .byte _id_EnFrame24, $FF

EnAnim_15:
    .byte _id_EnFrame1F, _id_EnFrame20
EnAnim_17:
    .byte _id_EnFrame21, $FF

EnAnim_RipperFacingLeft:
    .byte _id_EnFrame22, $FF

EnAnim_RipperFacingRight:
    .byte _id_EnFrame1F, $FF

EnAnim_1D:
    .byte _id_EnFrame23,
EnAnim_1E:
    .byte _id_EnFrame04, $FF

EnAnim_20:
    .byte _id_EnFrame20
EnAnim_21:
    .byte _id_EnFrame03, $FF

EnAnim_Skree:
    .byte _id_EnFrame27, _id_EnFrame28, _id_EnFrame29, $FF

EnAnim_27:
    .byte _id_EnFrame37, $FF

EnAnim_29:
    .byte _id_EnFrame38, $FF

EnAnim_2B:
    .byte _id_EnFrame39, $FF

EnAnim_2D:
    .byte _id_EnFrame3A, $FF

EnAnim_RipperExplodeFacingLeft:
    .byte _id_EnFrame3B, $FF

EnAnim_RipperExplodeFacingRight:
    .byte _id_EnFrame3C, $FF

EnAnim_SkreeExplode:
    .byte _id_EnFrame3D, $FF

EnAnim_ZoomerOnFloor:
    .byte _id_EnFrame58, _id_EnFrame59, $FF

EnAnim_ZoomerOnRightWall:
    .byte _id_EnFrame5A, _id_EnFrame5B, $FF

EnAnim_ZoomerOnCeiling:
    .byte _id_EnFrame5C, _id_EnFrame5D, $FF

EnAnim_ZoomerOnLeftWall:
    .byte _id_EnFrame5E, _id_EnFrame5F, $FF

EnAnim_ZoomerExplode:
    .byte _id_EnFrame60, $FF

EnAnim_Explosion:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_Rio:
    .byte _id_EnFrame63, _id_EnFrame64, $FF

EnAnim_RioExplode:
    .byte _id_EnFrame65, $FF

EnAnim_ZebFacingLeft:
    .byte _id_EnFrame66, _id_EnFrame67, $FF

EnAnim_ZebFacingRight:
    .byte _id_EnFrame69, _id_EnFrame6A, $FF

EnAnim_ZebExplodeFacingLeft:
    .byte _id_EnFrame68, $FF

EnAnim_ZebExplodeFacingRight:
    .byte _id_EnFrame6B, $FF

EnAnim_57:
    .byte _id_EnFrame66, $FF

EnAnim_59:
    .byte _id_EnFrame69, $FF

EnAnim_5B:
    .byte _id_EnFrame6C, $FF

EnAnim_5D:
    .byte _id_EnFrame6D, $FF

EnAnim_5F:
    .byte _id_EnFrame6F, _id_EnFrame70, _id_EnFrame71
EnAnim_62:
    .byte _id_EnFrame6E, $FF

EnAnim_64:
    .byte _id_EnFrame73, _id_EnFrame74, _id_EnFrame75
EnAnim_67:
    .byte _id_EnFrame72, $FF

EnAnim_Mellow:
    .byte _id_EnFrame8F, _id_EnFrame90, $FF

EnAnim_6C:
    .byte _id_EnFrame91, _id_EnFrame92, $FF

EnAnim_6F:
    .byte _id_EnFrame93, _id_EnFrame94, $FF

EnAnim_72:
    .byte _id_EnFrame95, $FF

EnAnim_74:
    .byte _id_EnFrame96, $FF

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
    PtrTableEntry EnFramePtrTable1, EnFrame8A
    PtrTableEntry EnFramePtrTable1, EnFrame8B
    PtrTableEntry EnFramePtrTable1, EnFrame8C
    PtrTableEntry EnFramePtrTable1, EnFrame8D
    PtrTableEntry EnFramePtrTable1, EnFrame8E
    PtrTableEntry EnFramePtrTable1, EnFrame8F
    PtrTableEntry EnFramePtrTable1, EnFrame90
    PtrTableEntry EnFramePtrTable1, EnFrame91
    PtrTableEntry EnFramePtrTable1, EnFrame92
    PtrTableEntry EnFramePtrTable1, EnFrame93
    PtrTableEntry EnFramePtrTable1, EnFrame94
    PtrTableEntry EnFramePtrTable1, EnFrame95
    PtrTableEntry EnFramePtrTable1, EnFrame96

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

;Enemy explode.
EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2:
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3:
EnPlace4:
EnPlace5:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8:
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC:
EnPlaceD:
EnPlaceE:
EnPlaceF:
    .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

;Unused.
EnFrame00:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

;Fireball killed.
EnFrame_FireballKilled:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame03:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame04:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame05:
EnFrame06:
EnFrame07:
EnFrame08:
EnFrame09:
EnFrame0A:
EnFrame0B:
EnFrame0C:
EnFrame0D:
EnFrame0E:
EnFrame0F:
EnFrame10:
EnFrame11:
EnFrame12:
EnFrame13:
EnFrame14:
EnFrame15:
EnFrame16:
EnFrame17:
EnFrame18:
EnFrame19:
    .byte ($2 << 4) + _id_EnPlace5, $08, $0A
    .byte $A3
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FE
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $A3
    .byte $B3
    .byte $FF

EnFrame1A:
    .byte ($2 << 4) + _id_EnPlace5, $08, $0A
    .byte $A5
    .byte $B3
    .byte $FE
    .byte $FE
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $A5
    .byte $B3
    .byte $FF

EnFrame1B:
    .byte ($2 << 4) + _id_EnPlace6, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

EnFrame1C:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $0A
    .byte $A3
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FE
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $A3
    .byte $B3
    .byte $FF

EnFrame1D:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $0A
    .byte $A5
    .byte $B3
    .byte $FE
    .byte $FE
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $A5
    .byte $B3
    .byte $FF

EnFrame1E:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace6, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

;Ripper facing right.
EnFrame1F:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame20:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame21:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper facing left.
EnFrame22:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame23:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame24:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Skree.
EnFrame25:
EnFrame26:
EnFrame27:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $FC, $00, $FC
    .byte $DE
    .byte $EE
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EE
    .byte $FF

;Skree.
EnFrame28:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

;Skree.
EnFrame29:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

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
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $FC
    .byte $A3
    .byte $FC, $00, $08
    .byte $A3
    .byte $FC, $00, $F8
    .byte $B3
    .byte $FC, $00, $08
    .byte $B3
    .byte $FF

EnFrame38:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $00, $FC
    .byte $B3
    .byte $FC, $00, $08
    .byte $B3
    .byte $FC, $00, $F8
    .byte $A3
    .byte $FC, $00, $08
    .byte $A3
    .byte $FF

EnFrame39:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame3A:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper explode facing left (uses waver gfx).
EnFrame3B:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

;Ripper explode facing right (uses waver gfx).
EnFrame3C:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

;Skree explode.
EnFrame3D:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zoomer on floor.
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
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on floor.
EnFrame59:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on right wall.
EnFrame5A:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on right wall.
EnFrame5B:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on ceiling.
EnFrame5C:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on ceiling.
EnFrame5D:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on left wall.
EnFrame5E:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on left wall.
EnFrame5F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer explode.
EnFrame60:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Explosion.
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

;Explosion.
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

;Rio.
EnFrame63:
    .byte ($2 << 4) + _id_EnPlaceB, $08, $08
    .byte $E2
    .byte $E3
    .byte $E4
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E3
    .byte $E4
    .byte $FF

;Rio.
EnFrame64:
    .byte ($2 << 4) + _id_EnPlaceB, $08, $08
    .byte $E2
    .byte $E3
    .byte $FE
    .byte $E4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E3
    .byte $FE
    .byte $E4
    .byte $FF

;Rio explode (gfx looks wrong).
EnFrame65:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $96
    .byte $96
    .byte $98
    .byte $98
    .byte $FF

;Zeb facing left.
EnFrame66:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing left.
EnFrame67:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing left.
EnFrame68:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb facing right.
EnFrame69:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing right.
EnFrame6A:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing right.
EnFrame6B:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6C:
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame6D:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame6E:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame6F:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame70:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame71:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame72:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame73:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame74:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame75:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

;Missile pickup.
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
    .byte ($0 << 4) + _id_EnPlace6, $08, $04
    .byte $FE
    .byte $FE
    .byte $14
    .byte $24
    .byte $FF

;Small energy pickup.
EnFrame_SmallEnergyPickup:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Big energy pickup.
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

;Mellow.
EnFrame8A:
EnFrame8B:
EnFrame8C:
EnFrame8D:
EnFrame8E:
EnFrame8F:
    .byte ($3 << 4) + _id_EnPlaceF, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

;Mellow.
EnFrame90:
    .byte ($3 << 4) + _id_EnPlaceF, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame91:
    .byte ($2 << 4) + _id_EnPlace2, $10, $0C
    .byte $C5
    .byte $C6
    .byte $C7
    .byte $D5
    .byte $D6
    .byte $D7
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame92:
    .byte ($2 << 4) + _id_EnPlace2, $10, $0C
    .byte $C5
    .byte $C6
    .byte $C7
    .byte $D5
    .byte $D6
    .byte $D7
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $E8
    .byte $E9
    .byte $F9
    .byte $FF

EnFrame93:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $10, $0C
    .byte $C5
    .byte $C6
    .byte $C7
    .byte $D5
    .byte $D6
    .byte $D7
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $F5
    .byte $F6
    .byte $F7
    .byte $FF

EnFrame94:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $10, $0C
    .byte $C5
    .byte $C6
    .byte $C7
    .byte $D5
    .byte $D6
    .byte $D7
    .byte $E5
    .byte $E6
    .byte $E7
    .byte $E8
    .byte $E9
    .byte $F9
    .byte $FF

EnFrame95:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame96:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
