;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_BANK{BANK}: ;($A406)
EnAnim_00_BANK{BANK}:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_EnProjectileKilled_BANK{BANK}:
    .byte _id_EnFrame_EnProjectileKilled, $FF

EnAnim_Metroid_BANK{BANK}:
    .byte _id_EnFrame_Metroid0, _id_EnFrame_Metroid1, $FF

EnAnim_MetroidExplode_BANK{BANK}:
    .byte _id_EnFrame_MetroidExplode, $FF

EnAnim_CannonBulletDownLeft_BANK{BANK}:
    .byte _id_EnFrame_CannonBulletDownLeft, $FF

EnAnim_CannonBulletDownRight_BANK{BANK}:
    .byte _id_EnFrame_CannonBulletDownRight, $FF

EnAnim_CannonBulletDown_BANK{BANK}:
    .byte _id_EnFrame_CannonBulletDown, $FF

EnAnim_CannonBulletExplode_BANK{BANK}:
    .byte _id_EnFrame_CannonBulletExplode0, _id_EnFrame_CannonBulletExplode0, _id_EnFrame_CannonBulletExplode1, _id_EnFrame_CannonBulletExplode1, $F7, $FF

EnAnim_16_BANK{BANK}:
    .byte _id_EnFrame18, $FF

EnAnim_18_BANK{BANK}:
    .byte _id_EnFrame_CannonTimeBombSet, $F7, $FF

EnAnim_RinkaSpawning_BANK{BANK}:
    .byte _id_EnFrame_RinkaSpawning0, _id_EnFrame_RinkaSpawning1
EnAnim_Rinka_BANK{BANK}:
    .byte _id_EnFrame_Rinka, $FF

EnAnim_RinkaExplode_BANK{BANK}:
    .byte _id_EnFrame_RinkaExplode, $FF

EnAnim_Explosion_BANK{BANK}:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_26_BANK{BANK}:
    ;nothing

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_BANK{BANK}:
    PtrTableEntry EnFramePtrTable1, EnFrame00_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame01_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Metroid1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MetroidExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUp_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpLeft_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonLeft_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownLeft_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDown_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonDownRight_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonRight_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonUpRight_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownLeft_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDownRight_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletDown_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonBulletExplode1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations2_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainPulsations3_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MotherBrainEyes_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame18_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_CannonTimeBombSet_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaSpawning1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rinka_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RinkaExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame20_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame21_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame22_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame23_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame24_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame25_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame26_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame27_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame28_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame29_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame2F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame30_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame31_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame32_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame33_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame34_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame35_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame36_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame37_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame38_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame39_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame3F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame40_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame41_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame42_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame43_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame44_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame45_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame46_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame47_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame48_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame49_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame4F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame50_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame51_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame52_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame53_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame54_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame55_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame56_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame57_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame58_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame59_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame5F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame60_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame63_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame64_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame65_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame66_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame67_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame68_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame69_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame6F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame70_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame71_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame72_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame73_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame74_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame75_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame76_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame77_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame78_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame79_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame7F_BANK{BANK}
EnFramePtrTable2_BANK{BANK}:
    PtrTableEntry EnFramePtrTable1, EnFrame_MissilePickup_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SmallEnergyPickup_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame82_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame83_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame84_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame85_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame86_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame87_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame88_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_BigEnergyPickup_BANK{BANK}

EnPlacePtrTable_BANK{BANK}:
    PtrTableEntry EnPlacePtrTable, EnPlace0_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace1_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace2_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace3_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace4_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace5_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace6_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace7_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace8_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlace9_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceA_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceB_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceC_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceD_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceE_BANK{BANK}
    PtrTableEntry EnPlacePtrTable, EnPlaceF_BANK{BANK}

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0_BANK{BANK}:
    .byte $FC, $FC

;Enemy explode.
EnPlace1_BANK{BANK}:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace2_BANK{BANK}:
    .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
    .byte $04, $04

EnPlace3_BANK{BANK}:
    .byte $F1, $FC, $F3, $F3, $FC, $F1

EnPlace4_BANK{BANK}:
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

EnPlace5_BANK{BANK}:
    .byte $FC, $F4, $FC, $FC, $FC, $04

EnPlace6_BANK{BANK}:
EnPlace7_BANK{BANK}:
EnPlace8_BANK{BANK}:
EnPlace9_BANK{BANK}:
EnPlaceA_BANK{BANK}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_BANK{BANK}:
EnPlaceC_BANK{BANK}:
    .byte $F8, $FC, $00, $FC

EnPlaceD_BANK{BANK}:
EnPlaceE_BANK{BANK}:
EnPlaceF_BANK{BANK}:
    ;nothing

;Enemy frame drawing data.

EnFrame00_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_EnProjectileKilled_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Metroid0_BANK{BANK}:
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

EnFrame_Metroid1_BANK{BANK}:
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

EnFrame_MetroidExplode_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace1, $00, $00
    .byte $C0
    .byte $C2
    .byte $D0
    .byte $D2
    .byte $E0
    .byte $E2
    .byte $FF

EnFrame_CannonUp_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonUpLeft_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonLeft_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonDownLeft_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonDown_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $EA
    .byte $FF

EnFrame_CannonDownRight_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonRight_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $FE
    .byte $EC
    .byte $FF

EnFrame_CannonUpRight_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace3, $07, $07
    .byte $FE
    .byte $EB
    .byte $FF

EnFrame_CannonBulletDownLeft_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDownRight_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F1
    .byte $FF

EnFrame_CannonBulletDown_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $F2
    .byte $FF

EnFrame_CannonBulletExplode0_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $F3
    .byte $FF

EnFrame_CannonBulletExplode1_BANK{BANK}:
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

EnFrame_MotherBrainPulsations0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace4, $08, $14
    .byte $FD, $2
    .byte $FC, $04, $F0
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $F8
    .byte $FF

EnFrame_MotherBrainPulsations1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace4, $14, $0C
    .byte $FD, $2
    .byte $FC, $F4, $F8
    .byte $DA
    .byte $FE
    .byte $C9
    .byte $FF

EnFrame_MotherBrainPulsations2_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace4, $20, $04
    .byte $FD, $2
    .byte $FC, $EC, $00
    .byte $CB
    .byte $CC
    .byte $DB
    .byte $DC
    .byte $FF

EnFrame_MotherBrainPulsations3_BANK{BANK}:
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

EnFrame_MotherBrainEyes_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace4, $08, $0C
    .byte $FD, $2
    .byte $FC, $0C, $10
    .byte $CD
    .byte $FF

EnFrame18_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FE
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $F5
    .byte $FF

EnFrame_CannonTimeBombSet_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FD, $3
    .byte $ED
    .byte $FF

EnFrame1A_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace5, $04, $08
    .byte $FD, $0
    .byte $00
    .byte $00
    .byte $00
    .byte $FF

EnFrame_RinkaSpawning0_BANK{BANK}:
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

EnFrame_RinkaSpawning1_BANK{BANK}:
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

EnFrame_Rinka_BANK{BANK}:
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

EnFrame_RinkaExplode_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace1, $00, $00
    .byte $FF

EnFrame1F_BANK{BANK}:
EnFrame20_BANK{BANK}:
EnFrame21_BANK{BANK}:
EnFrame22_BANK{BANK}:
EnFrame23_BANK{BANK}:
EnFrame24_BANK{BANK}:
EnFrame25_BANK{BANK}:
EnFrame26_BANK{BANK}:
EnFrame27_BANK{BANK}:
EnFrame28_BANK{BANK}:
EnFrame29_BANK{BANK}:
EnFrame2A_BANK{BANK}:
EnFrame2B_BANK{BANK}:
EnFrame2C_BANK{BANK}:
EnFrame2D_BANK{BANK}:
EnFrame2E_BANK{BANK}:
EnFrame2F_BANK{BANK}:
EnFrame30_BANK{BANK}:
EnFrame31_BANK{BANK}:
EnFrame32_BANK{BANK}:
EnFrame33_BANK{BANK}:
EnFrame34_BANK{BANK}:
EnFrame35_BANK{BANK}:
EnFrame36_BANK{BANK}:
EnFrame37_BANK{BANK}:
EnFrame38_BANK{BANK}:
EnFrame39_BANK{BANK}:
EnFrame3A_BANK{BANK}:
EnFrame3B_BANK{BANK}:
EnFrame3C_BANK{BANK}:
EnFrame3D_BANK{BANK}:
EnFrame3E_BANK{BANK}:
EnFrame3F_BANK{BANK}:
EnFrame40_BANK{BANK}:
EnFrame41_BANK{BANK}:
EnFrame42_BANK{BANK}:
EnFrame43_BANK{BANK}:
EnFrame44_BANK{BANK}:
EnFrame45_BANK{BANK}:
EnFrame46_BANK{BANK}:
EnFrame47_BANK{BANK}:
EnFrame48_BANK{BANK}:
EnFrame49_BANK{BANK}:
EnFrame4A_BANK{BANK}:
EnFrame4B_BANK{BANK}:
EnFrame4C_BANK{BANK}:
EnFrame4D_BANK{BANK}:
EnFrame4E_BANK{BANK}:
EnFrame4F_BANK{BANK}:
EnFrame50_BANK{BANK}:
EnFrame51_BANK{BANK}:
EnFrame52_BANK{BANK}:
EnFrame53_BANK{BANK}:
EnFrame54_BANK{BANK}:
EnFrame55_BANK{BANK}:
EnFrame56_BANK{BANK}:
EnFrame57_BANK{BANK}:
EnFrame58_BANK{BANK}:
EnFrame59_BANK{BANK}:
EnFrame5A_BANK{BANK}:
EnFrame5B_BANK{BANK}:
EnFrame5C_BANK{BANK}:
EnFrame5D_BANK{BANK}:
EnFrame5E_BANK{BANK}:
EnFrame5F_BANK{BANK}:
EnFrame60_BANK{BANK}:
EnFrame_Explosion0_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlaceA, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame_Explosion1_BANK{BANK}:
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

EnFrame63_BANK{BANK}:
EnFrame64_BANK{BANK}:
EnFrame65_BANK{BANK}:
EnFrame66_BANK{BANK}:
EnFrame67_BANK{BANK}:
EnFrame68_BANK{BANK}:
EnFrame69_BANK{BANK}:
EnFrame6A_BANK{BANK}:
EnFrame6B_BANK{BANK}:
EnFrame6C_BANK{BANK}:
EnFrame6D_BANK{BANK}:
EnFrame6E_BANK{BANK}:
EnFrame6F_BANK{BANK}:
EnFrame70_BANK{BANK}:
EnFrame71_BANK{BANK}:
EnFrame72_BANK{BANK}:
EnFrame73_BANK{BANK}:
EnFrame74_BANK{BANK}:
EnFrame75_BANK{BANK}:
EnFrame76_BANK{BANK}:
EnFrame77_BANK{BANK}:
EnFrame78_BANK{BANK}:
EnFrame79_BANK{BANK}:
EnFrame7A_BANK{BANK}:
EnFrame7B_BANK{BANK}:
EnFrame7C_BANK{BANK}:
EnFrame7D_BANK{BANK}:
EnFrame7E_BANK{BANK}:
EnFrame7F_BANK{BANK}:
EnFrame_MissilePickup_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlaceC, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82_BANK{BANK}:
EnFrame83_BANK{BANK}:
EnFrame84_BANK{BANK}:
EnFrame85_BANK{BANK}:
EnFrame86_BANK{BANK}:
EnFrame87_BANK{BANK}:
EnFrame88_BANK{BANK}:
EnFrame_BigEnergyPickup_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF
