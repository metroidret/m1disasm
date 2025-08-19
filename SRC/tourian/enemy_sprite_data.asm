;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTbl: ;($A406)
EnAnim_00:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_FireballKilled:
    .byte _id_EnFrame_FireballKilled, $FF

EnAnim_Metroid:
    .byte _id_EnFrame_Metroid0, _id_EnFrame_Metroid1, $FF

EnAnim_MetroidExplode:
    .byte _id_EnFrame_MetroidExplode, $FF

EnAnim_CannonBulletDownLeft:
    .byte _id_EnFrame_CannonBulletDownLeft, $FF

EnAnim_CannonBulletDownRight:
    .byte _id_EnFrame_CannonBulletDownRight, $FF

EnAnim_CannonBulletDown:
    .byte _id_EnFrame_CannonBulletDown, $FF

EnAnim_CannonBulletExplode:
    .byte _id_EnFrame_CannonBulletExplode0, _id_EnFrame_CannonBulletExplode0, _id_EnFrame_CannonBulletExplode1, _id_EnFrame_CannonBulletExplode1, $F7, $FF

EnAnim_16:
    .byte _id_EnFrame18, $FF

EnAnim_18:
    .byte _id_EnFrame_CannonTimeBombSet, $F7, $FF

EnAnim_RinkaSpawning:
    .byte _id_EnFrame_RinkaSpawning0, _id_EnFrame_RinkaSpawning1
EnAnim_Rinka:
    .byte _id_EnFrame_Rinka, $FF

EnAnim_RinkaExplode:
    .byte _id_EnFrame_RinkaExplode, $FF

EnAnim_Explosion:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_26:
    ;nothing

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame_FireballKilled
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid0
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid1
    PtrTableEntry EnFramePtrTable1, EnFrame_MetroidExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUp
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDown
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownRight
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonRight
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpRight
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownRight
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDown
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode0
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode1
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations0
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations1
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations2
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations3
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainEyes
    PtrTableEntry EnFramePtrTable1, EnFrame18
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonTimeBombSet
    PtrTableEntry EnFramePtrTable1, EnFrame1A
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning0
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning1
    PtrTableEntry EnFramePtrTable1, EnFrame_Rinka
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaExplode
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
    PtrTableEntry EnPlacePtrTable, EnPlaceF

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

;Enemy explode.
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

EnFrame_Metroid0:
    .byte ($3 << 4) + _id_EnPlace2, $0C, $0C
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

EnFrame_Metroid1:
    .byte ($3 << 4) + _id_EnPlace2, $0C, $0C
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

EnFrame_MetroidExplode:
    .byte ($3 << 4) + _id_EnPlace1, $00, $00
    .byte $C0
    .byte $C2
    .byte $D0
    .byte $D2
    .byte $E0
    .byte $E2
    .byte $FF

EnFrame_CannonUp:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonUpLeft:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonLeft:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonDownLeft:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonDown:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonDownRight:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonRight:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonUpRight:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonBulletDownLeft:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDownRight:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDown:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F2
    .byte $FF

EnFrame_CannonBulletExplode0:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $F3
    .byte $FF

EnFrame_CannonBulletExplode1:
    .byte ($0 << 4) + _id_EnPlaceA, $00, $00
    .byte $FD, $0
    .byte $F4
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FF

EnFrame_MotherBrainPulsations0:
    .byte ($2 << 4) + _id_EnPlace4, $08, $14
    .byte $FD, $2
    .byte $FC, $04, $F0
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $FF

EnFrame_MotherBrainPulsations1:
    .byte ($2 << 4) + _id_EnPlace4, $14, $0C
    .byte $FD, $2
    .byte $FC, $F4, $F8
    .byte $DA
    .byte $FE
    .byte $C9
    .byte $FF

EnFrame_MotherBrainPulsations2:
    .byte ($2 << 4) + _id_EnPlace4, $20, $04
    .byte $FD, $2
    .byte $FC, $EC, $00
    .byte $CB
    .byte $CC
    .byte $DB
    .byte $DC
    .byte $FF

EnFrame_MotherBrainPulsations3:
    .byte ($2 << 4) + _id_EnPlace4, $18, $14
    .byte $FD, $2
    .byte $FC, $F4, $10
    .byte $DD
    .byte $CE
    .byte $FE
    .byte $DE
    .byte $FE
    .byte $DD
    .byte $FF

EnFrame_MotherBrainEyes:
    .byte ($2 << 4) + _id_EnPlace4, $08, $0C
    .byte $FD, $2
    .byte $FC, $0C, $10
    .byte $CD
    .byte $FF

EnFrame18:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FE
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $FF

EnFrame_CannonTimeBombSet:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $ED
    .byte $FF

EnFrame1A:
    .byte ($0 << 4) + _id_EnPlace5, $04, $08
    .byte $FD, $0
    .byte $00
    .byte $00
    .byte $00
    .byte $FF

EnFrame_RinkaSpawning0:
    .byte ($3 << 4) + _id_EnPlaceA, $08, $08
    .byte $FD, $3
    .byte $EF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FF

EnFrame_RinkaSpawning1:
    .byte ($3 << 4) + _id_EnPlaceA, $08, $08
    .byte $FD, $03
    .byte $DF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FF

EnFrame_Rinka:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $FD, $3
    .byte $CF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FF

EnFrame_RinkaExplode:
    .byte ($0 << 4) + _id_EnPlace1, $00, $00
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
