;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ;($C47B)
EnAnim_00_{AREA}:
    .byte _id_EnFrame00_{AREA}, _id_EnFrame01_{AREA}, $FF

EnAnim_EnProjectileKilled_{AREA}:
    .byte _id_EnFrame_EnProjectileKilled_{AREA}, $FF

EnAnim_Metroid_{AREA}:
    .byte _id_EnFrame_Metroid0_{AREA}, _id_EnFrame_Metroid1_{AREA}, $FF

EnAnim_MetroidExplode_{AREA}:
    .byte _id_EnFrame_MetroidExplode_{AREA}, $FF

EnAnim_CannonBulletDownLeft_{AREA}:
    .byte _id_EnFrame_CannonBulletDownLeft_{AREA}, $FF

EnAnim_CannonBulletDownRight_{AREA}:
    .byte _id_EnFrame_CannonBulletDownRight_{AREA}, $FF

EnAnim_CannonBulletDown_{AREA}:
    .byte _id_EnFrame_CannonBulletDown_{AREA}, $FF

EnAnim_CannonBulletExplode_{AREA}:
    .byte _id_EnFrame_CannonBulletExplode0_{AREA}, _id_EnFrame_CannonBulletExplode0_{AREA}, _id_EnFrame_CannonBulletExplode1_{AREA}, _id_EnFrame_CannonBulletExplode1_{AREA}, $F7, $FF

EnAnim_16_{AREA}:
    .byte _id_EnFrame18_{AREA}, $FF

EnAnim_18_{AREA}:
    .byte _id_EnFrame_CannonTimeBombSet_{AREA}, $F7, $FF

EnAnim_RinkaSpawning_{AREA}:
    .byte _id_EnFrame_RinkaSpawning0_{AREA}, _id_EnFrame_RinkaSpawning1_{AREA}
EnAnim_Rinka_{AREA}:
    .byte _id_EnFrame_Rinka_{AREA}, $FF

EnAnim_RinkaExplode_{AREA}:
    .byte _id_EnFrame_RinkaExplode_{AREA}, $FF

EnAnim_Explosion_{AREA}:
    .byte _id_EnFrame_Explosion0_{AREA}, $F7, _id_EnFrame_Explosion1_{AREA}, $F7, $FF

EnAnim_26_{AREA}:
    ;nothing

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}: ;($C4A1)
    PtrTableEntry EnFramePtrTable1, EnFrame00_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame01_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MetroidExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUp_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpLeft_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonLeft_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownLeft_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDown_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownRight_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonRight_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpRight_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownLeft_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownRight_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDown_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations2_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations3_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainEyes_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame18_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonTimeBombSet_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame1A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rinka_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame1F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame20_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame21_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame22_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame23_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame24_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame25_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame26_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame27_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame28_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame29_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame2F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame30_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame31_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame32_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame33_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame34_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame35_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame36_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame37_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame38_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame39_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame40_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame41_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame42_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame43_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame44_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame45_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame46_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame47_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame48_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame49_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame4F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame50_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame51_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame52_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame53_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame54_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame55_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame56_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame57_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame58_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame59_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame5F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame60_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame63_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame64_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame65_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame66_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame67_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame68_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame69_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame6F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame70_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame71_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame72_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame73_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame74_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame75_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame76_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame77_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame78_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame79_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame7F_{AREA}
EnFramePtrTable2_{AREA}: ;($C5A1)
    PtrTableEntry EnFramePtrTable1, EnFrame_MissilePickup_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SmallEnergyPickup_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame82_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame83_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame84_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame85_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame86_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame87_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame88_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_BigEnergyPickup_{AREA}

EnPlacePtrTable_{AREA}: ;($C5B5)
    PtrTableEntryArea EnPlacePtrTable, EnPlace0
    PtrTableEntryArea EnPlacePtrTable, EnPlace1
    PtrTableEntry EnPlacePtrTable, EnPlace2_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace3_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace4_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace5_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace6_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace7_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace8_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlace9_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceA_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceB_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceC_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceD_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceE_{AREA}
    PtrTableEntry EnPlacePtrTable, EnPlaceF_{AREA}

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

;Health pickup
EnPlace0_{AREA}:
    .byte $FC, $FC

;Enemy explode.
EnPlace1_{AREA}:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Metroid
EnPlace2_{AREA}:
    .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
    .byte $04, $04

EnPlace3_{AREA}:
    .byte $F1, $FC, $F3, $F3, $FC, $F1

EnPlace4_{AREA}:
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace5_{AREA}:
    .byte $FC, $F4, $FC, $FC, $FC, $04

EnPlace6_{AREA}:
EnPlace7_{AREA}:
EnPlace8_{AREA}:
EnPlace9_{AREA}:
EnPlaceA_{AREA}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}:
EnPlaceC_{AREA}:
    .byte $F8, $FC, $00, $FC

EnPlaceD_{AREA}:
EnPlaceE_{AREA}:
EnPlaceF_{AREA}:
    ;nothing

;Enemy frame drawing data.

EnFrame00_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_EnProjectileKilled_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Metroid0_{AREA}:
    .byte ($3 << 4) + _id_EnPlace2_{AREA}, $0C, $0C
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

EnFrame_Metroid1_{AREA}:
    .byte ($3 << 4) + _id_EnPlace2_{AREA}, $0C, $0C
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

EnFrame_MetroidExplode_{AREA}:
    .byte ($3 << 4) + _id_EnPlace1, $00, $00
    .byte $C0
    .byte $C2
    .byte $D0
    .byte $D2
    .byte $E0
    .byte $E2
    .byte $FF

EnFrame_CannonUp_{AREA}:
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonUpLeft_{AREA}:
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonLeft_{AREA}:
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonDownLeft_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonDown_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonDownRight_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonRight_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonUpRight_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonBulletDownLeft_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDownRight_{AREA}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDown_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F2
    .byte $FF

EnFrame_CannonBulletExplode0_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $F3
    .byte $FF

EnFrame_CannonBulletExplode1_{AREA}:
    .byte ($0 << 4) + _id_EnPlaceA_{AREA}, $00, $00
    .byte $FD, $0
    .byte $F4
    .byte $FD, OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + $0
    .byte $F4
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $F4
    .byte $FF

EnFrame_MotherBrainPulsations0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $14
    .byte $FD, $2
    .byte $FC, $04, $F0
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $FF

EnFrame_MotherBrainPulsations1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $14, $0C
    .byte $FD, $2
    .byte $FC, $F4, $F8
    .byte $DA
    .byte $FE
    .byte $C9
    .byte $FF

EnFrame_MotherBrainPulsations2_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $20, $04
    .byte $FD, $2
    .byte $FC, $EC, $00
    .byte $CB
    .byte $CC
    .byte $DB
    .byte $DC
    .byte $FF

EnFrame_MotherBrainPulsations3_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $18, $14
    .byte $FD, $2
    .byte $FC, $F4, $10
    .byte $DD
    .byte $CE
    .byte $FE
    .byte $DE
    .byte $FE
    .byte $DD
    .byte $FF

EnFrame_MotherBrainEyes_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $0C
    .byte $FD, $2
    .byte $FC, $0C, $10
    .byte $CD
    .byte $FF

EnFrame18_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FE
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $FF

EnFrame_CannonTimeBombSet_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $ED
    .byte $FF

EnFrame1A_{AREA}:
    .byte ($0 << 4) + _id_EnPlace5_{AREA}, $04, $08
    .byte $FD, $0
    .byte $00
    .byte $00
    .byte $00
    .byte $FF

EnFrame_RinkaSpawning0_{AREA}:
    .byte ($3 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $FD, $3
    .byte $EF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $EF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $EF
    .byte $FF

EnFrame_RinkaSpawning1_{AREA}:
    .byte ($3 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $FD, $03
    .byte $DF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $DF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $DF
    .byte $FF

EnFrame_Rinka_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $FD, $3
    .byte $CF
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + $3
    .byte $CF
    .byte $FD, OAMDATA_VFLIP + OAMDATA_HFLIP + $3
    .byte $CF
    .byte $FF

EnFrame_RinkaExplode_{AREA}:
    .byte ($0 << 4) + _id_EnPlace1, $00, $00
    .byte $FF

EnFrame1F_{AREA}:
EnFrame20_{AREA}:
EnFrame21_{AREA}:
EnFrame22_{AREA}:
EnFrame23_{AREA}:
EnFrame24_{AREA}:
EnFrame25_{AREA}:
EnFrame26_{AREA}:
EnFrame27_{AREA}:
EnFrame28_{AREA}:
EnFrame29_{AREA}:
EnFrame2A_{AREA}:
EnFrame2B_{AREA}:
EnFrame2C_{AREA}:
EnFrame2D_{AREA}:
EnFrame2E_{AREA}:
EnFrame2F_{AREA}:
EnFrame30_{AREA}:
EnFrame31_{AREA}:
EnFrame32_{AREA}:
EnFrame33_{AREA}:
EnFrame34_{AREA}:
EnFrame35_{AREA}:
EnFrame36_{AREA}:
EnFrame37_{AREA}:
EnFrame38_{AREA}:
EnFrame39_{AREA}:
EnFrame3A_{AREA}:
EnFrame3B_{AREA}:
EnFrame3C_{AREA}:
EnFrame3D_{AREA}:
EnFrame3E_{AREA}:
EnFrame3F_{AREA}:
EnFrame40_{AREA}:
EnFrame41_{AREA}:
EnFrame42_{AREA}:
EnFrame43_{AREA}:
EnFrame44_{AREA}:
EnFrame45_{AREA}:
EnFrame46_{AREA}:
EnFrame47_{AREA}:
EnFrame48_{AREA}:
EnFrame49_{AREA}:
EnFrame4A_{AREA}:
EnFrame4B_{AREA}:
EnFrame4C_{AREA}:
EnFrame4D_{AREA}:
EnFrame4E_{AREA}:
EnFrame4F_{AREA}:
EnFrame50_{AREA}:
EnFrame51_{AREA}:
EnFrame52_{AREA}:
EnFrame53_{AREA}:
EnFrame54_{AREA}:
EnFrame55_{AREA}:
EnFrame56_{AREA}:
EnFrame57_{AREA}:
EnFrame58_{AREA}:
EnFrame59_{AREA}:
EnFrame5A_{AREA}:
EnFrame5B_{AREA}:
EnFrame5C_{AREA}:
EnFrame5D_{AREA}:
EnFrame5E_{AREA}:
EnFrame5F_{AREA}:
EnFrame60_{AREA}:
EnFrame_Explosion0_{AREA}:
    .byte ($0 << 4) + _id_EnPlaceA_{AREA}, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame_Explosion1_{AREA}:
    .byte ($0 << 4) + _id_EnPlaceA_{AREA}, $00, $00
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

EnFrame63_{AREA}:
EnFrame64_{AREA}:
EnFrame65_{AREA}:
EnFrame66_{AREA}:
EnFrame67_{AREA}:
EnFrame68_{AREA}:
EnFrame69_{AREA}:
EnFrame6A_{AREA}:
EnFrame6B_{AREA}:
EnFrame6C_{AREA}:
EnFrame6D_{AREA}:
EnFrame6E_{AREA}:
EnFrame6F_{AREA}:
EnFrame70_{AREA}:
EnFrame71_{AREA}:
EnFrame72_{AREA}:
EnFrame73_{AREA}:
EnFrame74_{AREA}:
EnFrame75_{AREA}:
EnFrame76_{AREA}:
EnFrame77_{AREA}:
EnFrame78_{AREA}:
EnFrame79_{AREA}:
EnFrame7A_{AREA}:
EnFrame7B_{AREA}:
EnFrame7C_{AREA}:
EnFrame7D_{AREA}:
EnFrame7E_{AREA}:
EnFrame7F_{AREA}:
EnFrame_MissilePickup_{AREA}:
    .byte ($0 << 4) + _id_EnPlaceC_{AREA}, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82_{AREA}:
EnFrame83_{AREA}:
EnFrame84_{AREA}:
EnFrame85_{AREA}:
EnFrame86_{AREA}:
EnFrame87_{AREA}:
EnFrame88_{AREA}:
EnFrame_BigEnergyPickup_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF
