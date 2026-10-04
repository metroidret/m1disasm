;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ; 03:A406
EnAnim_00_{AREA}: ; 03:A406
    .byte _id_EnFrame00_{AREA}
    .byte _id_EnFrame01_{AREA}
    .byte _id_FrameEnd

EnAnim_EnProjectileKilled_{AREA}: ; 03:A409
    .byte _id_EnFrame_EnProjectileKilled_{AREA}
    .byte _id_FrameEnd

EnAnim_Metroid_{AREA}: ; 03:A40B
    .byte _id_EnFrame_Metroid0_{AREA}
    .byte _id_EnFrame_Metroid1_{AREA}
    .byte _id_FrameEnd

EnAnim_MetroidExplode_{AREA}: ; 03:A40E
    .byte _id_EnFrame_MetroidExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_CannonBulletDownLeft_{AREA}: ; 03:A410
    .byte _id_EnFrame_CannonBulletDownLeft_{AREA}
    .byte _id_FrameEnd

EnAnim_CannonBulletDownRight_{AREA}: ; 03:A412
    .byte _id_EnFrame_CannonBulletDownRight_{AREA}
    .byte _id_FrameEnd

EnAnim_CannonBulletDown_{AREA}: ; 03:A414
    .byte _id_EnFrame_CannonBulletDown_{AREA}
    .byte _id_FrameEnd

EnAnim_CannonBulletExplode_{AREA}: ; 03:A416
    .byte _id_EnFrame_CannonBulletExplode0_{AREA}
    .byte _id_EnFrame_CannonBulletExplode0_{AREA}
    .byte _id_EnFrame_CannonBulletExplode1_{AREA}
    .byte _id_EnFrame_CannonBulletExplode1_{AREA}
    .byte _id_FrameNone
    .byte _id_FrameEnd

EnAnim_16_{AREA}: ; 03:A41C
    .byte _id_EnFrame18_{AREA}
    .byte _id_FrameEnd

EnAnim_18_{AREA}: ; 03:A41E
    .byte _id_EnFrame_CannonTimeBombSet_{AREA}
    .byte _id_FrameNone
    .byte _id_FrameEnd

EnAnim_RinkaSpawning_{AREA}: ; 03:A421
    .byte _id_EnFrame_RinkaSpawning0_{AREA}
    .byte _id_EnFrame_RinkaSpawning1_{AREA}
EnAnim_Rinka_{AREA}: ; 03:A423
    .byte _id_EnFrame_Rinka_{AREA}
    .byte _id_FrameEnd

EnAnim_RinkaExplode_{AREA}: ; 03:A425
    .byte _id_EnFrame_RinkaExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_Explosion_{AREA}: ; 03:A427
    .byte _id_EnFrame_Explosion0_{AREA}
    .byte _id_FrameNone
    .byte _id_EnFrame_Explosion1_{AREA}
    .byte _id_FrameNone
    .byte _id_FrameEnd

EnAnim_26_{AREA}: ; 03:A42C
    ;nothing

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}: ; 03:A42C
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
EnFramePtrTable2_{AREA}: ; 03:A52C
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

EnPlacePtrTable_{AREA}: ; 03:A540
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
EnPlace0_{AREA}: ; 03:A560
    .byte $FC, $FC

;Enemy explode.
EnPlace1_{AREA}: ; 03:A562
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Metroid
EnPlace2_{AREA}: ; 03:A57A
    .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
    .byte $04, $04

EnPlace3_{AREA}: ; 03:A58C
    .byte $F1, $FC, $F3, $F3, $FC, $F1

EnPlace4_{AREA}: ; 03:A592
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace5_{AREA}: ; 03:A59E
    .byte $FC, $F4, $FC, $FC, $FC, $04

EnPlace6_{AREA}: ; 03:A5A4
EnPlace7_{AREA}: ; 03:A5A4
EnPlace8_{AREA}: ; 03:A5A4
EnPlace9_{AREA}: ; 03:A5A4
EnPlaceA_{AREA}: ; 03:A5A4
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}: ; 03:A5C4
EnPlaceC_{AREA}: ; 03:A5C4
    .byte $F8, $FC, $00, $FC

EnPlaceD_{AREA}: ; 03:A5C8
EnPlaceE_{AREA}: ; 03:A5C8
EnPlaceF_{AREA}: ; 03:A5C8
    ;nothing

;Enemy frame drawing data.

EnFrame00_{AREA}: ; 03:A5C8
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_{AREA}: ; 03:A5CD
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_EnProjectileKilled_{AREA}: ; 03:A5D2
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Metroid0_{AREA}: ; 03:A5D7
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

EnFrame_Metroid1_{AREA}: ; 03:A5E4
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

EnFrame_MetroidExplode_{AREA}: ; 03:A5F1
    .byte ($3 << 4) + _id_EnPlace1, $00, $00
    .byte $C0
    .byte $C2
    .byte $D0
    .byte $D2
    .byte $E0
    .byte $E2
    .byte $FF

EnFrame_CannonUp_{AREA}: ; 03:A5FB
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonUpLeft_{AREA}: ; 03:A600
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonLeft_{AREA}: ; 03:A606
    .byte ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonDownLeft_{AREA}: ; 03:A60D
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonDown_{AREA}: ; 03:A613
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonDownRight_{AREA}: ; 03:A618
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonRight_{AREA}: ; 03:A61E
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonUpRight_{AREA}: ; 03:A625
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3_{AREA}, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonBulletDownLeft_{AREA}: ; 03:A62B
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDownRight_{AREA}: ; 03:A630
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDown_{AREA}: ; 03:A635
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F2
    .byte $FF

EnFrame_CannonBulletExplode0_{AREA}: ; 03:A63A
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $F3
    .byte $FF

EnFrame_CannonBulletExplode1_{AREA}: ; 03:A641
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

EnFrame_MotherBrainPulsations0_{AREA}: ; 03:A651
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $14
    .byte $FD, $2
    .byte $FC, $04, $F0
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $FF

EnFrame_MotherBrainPulsations1_{AREA}: ; 03:A65F
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $14, $0C
    .byte $FD, $2
    .byte $FC, $F4, $F8
    .byte $DA
    .byte $FE
    .byte $C9
    .byte $FF

EnFrame_MotherBrainPulsations2_{AREA}: ; 03:A66B
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $20, $04
    .byte $FD, $2
    .byte $FC, $EC, $00
    .byte $CB
    .byte $CC
    .byte $DB
    .byte $DC
    .byte $FF

EnFrame_MotherBrainPulsations3_{AREA}: ; 03:A678
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

EnFrame_MotherBrainEyes_{AREA}: ; 03:A687
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $0C
    .byte $FD, $2
    .byte $FC, $0C, $10
    .byte $CD
    .byte $FF

EnFrame18_{AREA}: ; 03:A691
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FE
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $FF

EnFrame_CannonTimeBombSet_{AREA}: ; 03:A69C
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $ED
    .byte $FF

EnFrame1A_{AREA}: ; 03:A6A3
    .byte ($0 << 4) + _id_EnPlace5_{AREA}, $04, $08
    .byte $FD, $0
    .byte $00
    .byte $00
    .byte $00
    .byte $FF

EnFrame_RinkaSpawning0_{AREA}: ; 03:A6AC
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

EnFrame_RinkaSpawning1_{AREA}: ; 03:A6BC
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

EnFrame_Rinka_{AREA}: ; 03:A6CC
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

EnFrame_RinkaExplode_{AREA}: ; 03:A6DC
    .byte ($0 << 4) + _id_EnPlace1, $00, $00
    .byte $FF

EnFrame1F_{AREA}: ; 03:A6E0
EnFrame20_{AREA}: ; 03:A6E0
EnFrame21_{AREA}: ; 03:A6E0
EnFrame22_{AREA}: ; 03:A6E0
EnFrame23_{AREA}: ; 03:A6E0
EnFrame24_{AREA}: ; 03:A6E0
EnFrame25_{AREA}: ; 03:A6E0
EnFrame26_{AREA}: ; 03:A6E0
EnFrame27_{AREA}: ; 03:A6E0
EnFrame28_{AREA}: ; 03:A6E0
EnFrame29_{AREA}: ; 03:A6E0
EnFrame2A_{AREA}: ; 03:A6E0
EnFrame2B_{AREA}: ; 03:A6E0
EnFrame2C_{AREA}: ; 03:A6E0
EnFrame2D_{AREA}: ; 03:A6E0
EnFrame2E_{AREA}: ; 03:A6E0
EnFrame2F_{AREA}: ; 03:A6E0
EnFrame30_{AREA}: ; 03:A6E0
EnFrame31_{AREA}: ; 03:A6E0
EnFrame32_{AREA}: ; 03:A6E0
EnFrame33_{AREA}: ; 03:A6E0
EnFrame34_{AREA}: ; 03:A6E0
EnFrame35_{AREA}: ; 03:A6E0
EnFrame36_{AREA}: ; 03:A6E0
EnFrame37_{AREA}: ; 03:A6E0
EnFrame38_{AREA}: ; 03:A6E0
EnFrame39_{AREA}: ; 03:A6E0
EnFrame3A_{AREA}: ; 03:A6E0
EnFrame3B_{AREA}: ; 03:A6E0
EnFrame3C_{AREA}: ; 03:A6E0
EnFrame3D_{AREA}: ; 03:A6E0
EnFrame3E_{AREA}: ; 03:A6E0
EnFrame3F_{AREA}: ; 03:A6E0
EnFrame40_{AREA}: ; 03:A6E0
EnFrame41_{AREA}: ; 03:A6E0
EnFrame42_{AREA}: ; 03:A6E0
EnFrame43_{AREA}: ; 03:A6E0
EnFrame44_{AREA}: ; 03:A6E0
EnFrame45_{AREA}: ; 03:A6E0
EnFrame46_{AREA}: ; 03:A6E0
EnFrame47_{AREA}: ; 03:A6E0
EnFrame48_{AREA}: ; 03:A6E0
EnFrame49_{AREA}: ; 03:A6E0
EnFrame4A_{AREA}: ; 03:A6E0
EnFrame4B_{AREA}: ; 03:A6E0
EnFrame4C_{AREA}: ; 03:A6E0
EnFrame4D_{AREA}: ; 03:A6E0
EnFrame4E_{AREA}: ; 03:A6E0
EnFrame4F_{AREA}: ; 03:A6E0
EnFrame50_{AREA}: ; 03:A6E0
EnFrame51_{AREA}: ; 03:A6E0
EnFrame52_{AREA}: ; 03:A6E0
EnFrame53_{AREA}: ; 03:A6E0
EnFrame54_{AREA}: ; 03:A6E0
EnFrame55_{AREA}: ; 03:A6E0
EnFrame56_{AREA}: ; 03:A6E0
EnFrame57_{AREA}: ; 03:A6E0
EnFrame58_{AREA}: ; 03:A6E0
EnFrame59_{AREA}: ; 03:A6E0
EnFrame5A_{AREA}: ; 03:A6E0
EnFrame5B_{AREA}: ; 03:A6E0
EnFrame5C_{AREA}: ; 03:A6E0
EnFrame5D_{AREA}: ; 03:A6E0
EnFrame5E_{AREA}: ; 03:A6E0
EnFrame5F_{AREA}: ; 03:A6E0
EnFrame60_{AREA}: ; 03:A6E0
EnFrame_Explosion0_{AREA}: ; 03:A6E0
    .byte ($0 << 4) + _id_EnPlaceA_{AREA}, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame_Explosion1_{AREA}: ; 03:A6EE
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

EnFrame63_{AREA}: ; 03:A708
EnFrame64_{AREA}: ; 03:A708
EnFrame65_{AREA}: ; 03:A708
EnFrame66_{AREA}: ; 03:A708
EnFrame67_{AREA}: ; 03:A708
EnFrame68_{AREA}: ; 03:A708
EnFrame69_{AREA}: ; 03:A708
EnFrame6A_{AREA}: ; 03:A708
EnFrame6B_{AREA}: ; 03:A708
EnFrame6C_{AREA}: ; 03:A708
EnFrame6D_{AREA}: ; 03:A708
EnFrame6E_{AREA}: ; 03:A708
EnFrame6F_{AREA}: ; 03:A708
EnFrame70_{AREA}: ; 03:A708
EnFrame71_{AREA}: ; 03:A708
EnFrame72_{AREA}: ; 03:A708
EnFrame73_{AREA}: ; 03:A708
EnFrame74_{AREA}: ; 03:A708
EnFrame75_{AREA}: ; 03:A708
EnFrame76_{AREA}: ; 03:A708
EnFrame77_{AREA}: ; 03:A708
EnFrame78_{AREA}: ; 03:A708
EnFrame79_{AREA}: ; 03:A708
EnFrame7A_{AREA}: ; 03:A708
EnFrame7B_{AREA}: ; 03:A708
EnFrame7C_{AREA}: ; 03:A708
EnFrame7D_{AREA}: ; 03:A708
EnFrame7E_{AREA}: ; 03:A708
EnFrame7F_{AREA}: ; 03:A708
EnFrame_MissilePickup_{AREA}: ; 03:A708
    .byte ($0 << 4) + _id_EnPlaceC_{AREA}, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup_{AREA}: ; 03:A70E
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82_{AREA}: ; 03:A713
EnFrame83_{AREA}: ; 03:A713
EnFrame84_{AREA}: ; 03:A713
EnFrame85_{AREA}: ; 03:A713
EnFrame86_{AREA}: ; 03:A713
EnFrame87_{AREA}: ; 03:A713
EnFrame88_{AREA}: ; 03:A713
EnFrame_BigEnergyPickup_{AREA}: ; 03:A713
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF
