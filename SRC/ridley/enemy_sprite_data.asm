;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_BANK{BANK}: ;($9B85)
EnAnim_00_BANK{BANK}:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_EnProjectileKilled_BANK{BANK}:
    .byte _id_EnFrame_EnProjectileKilled, $FF

EnAnim_RidleyIdle_R_BANK{BANK}:
    .byte _id_EnFrame_RidleyIdle0_R, _id_EnFrame_RidleyIdle1_R, $FF

EnAnim_RidleyIdle_L_BANK{BANK}:
    .byte _id_EnFrame_RidleyIdle0_L, _id_EnFrame_RidleyIdle1_L, $FF

EnAnim_RidleyHopping_R_BANK{BANK}:
    .byte _id_EnFrame_RidleyHopping0_R, _id_EnFrame_RidleyHopping1_R, $FF

EnAnim_RidleyHopping_L_BANK{BANK}:
    .byte _id_EnFrame_RidleyHopping0_L, _id_EnFrame_RidleyHopping1_L, $FF

EnAnim_RidleyExplode_BANK{BANK}:
    .byte _id_EnFrame_RidleyExplode, $FF

EnAnim_RidleyFireball_R_BANK{BANK}:
    .byte _id_EnFrame_RidleyFireball0_R, _id_EnFrame_RidleyFireball1_R, _id_EnFrame_RidleyFireball2_R, _id_EnFrame_RidleyFireball3_R, $FF

EnAnim_RidleyFireball_L_BANK{BANK}:
    .byte _id_EnFrame_RidleyFireball0_L, _id_EnFrame_RidleyFireball1_L, _id_EnFrame_RidleyFireball2_L, _id_EnFrame_RidleyFireball3_L, $FF

EnAnim_HoltzIdle_BANK{BANK}:
    .byte _id_EnFrame_HoltzIdle0, _id_EnFrame_HoltzIdle1, $FF

EnAnim_HoltzSwooping_BANK{BANK}:
    .byte _id_EnFrame_HoltzSwooping0, _id_EnFrame_HoltzSwooping1, $FF

EnAnim_HoltzExplode_BANK{BANK}:
    .byte _id_EnFrame_HoltzExplode, $FF

EnAnim_Mella_BANK{BANK}:
    .byte _id_EnFrame_Mella0, _id_EnFrame_Mella1, $FF

EnAnim_MultiviolaSpinningCounterclockwise_BANK{BANK}:
    .byte _id_EnFrame_MultiviolaSpinningCounterclockwise0, _id_EnFrame_MultiviolaSpinningCounterclockwise1, _id_EnFrame_MultiviolaSpinningCounterclockwise2, _id_EnFrame_MultiviolaSpinningCounterclockwise3, $FF

EnAnim_MultiviolaSpinningClockwise_BANK{BANK}:
    .byte _id_EnFrame_MultiviolaSpinningClockwise0, _id_EnFrame_MultiviolaSpinningClockwise1, _id_EnFrame_MultiviolaSpinningClockwise2, _id_EnFrame_MultiviolaSpinningClockwise3, $FF

EnAnim_MultiviolaExplode_BANK{BANK}:
    .byte _id_EnFrame_MultiviolaExplode, $FF

EnAnim_34_BANK{BANK}:
    .byte _id_EnFrame42, $FF

EnAnim_36_BANK{BANK}:
    .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

EnAnim_DessgeegaExplodeFloor_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaExplodeFloor, $FF

EnAnim_DessgeegaExplodeCeiling_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaExplodeCeiling, $FF

EnAnim_DessgeegaIdleFloor_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaIdleFloor0, _id_EnFrame_DessgeegaIdleFloor1, $FF

EnAnim_DessgeegaFloorStartHopping_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaIdleFloor1
EnAnim_DessgeegaFloorHopping_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaFloorHopping, $FF

EnAnim_DessgeegaIdleCeiling_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaIdleCeiling0, _id_EnFrame_DessgeegaIdleCeiling1, $FF

EnAnim_DessgeegaCeilingStartHopping_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaIdleCeiling1
EnAnim_DessgeegaCeilingHopping_BANK{BANK}:
    .byte _id_EnFrame_DessgeegaCeilingHopping, $FF

EnAnim_ViolaOnFloor_BANK{BANK}:
    .byte _id_EnFrame_ViolaOnFloor0, _id_EnFrame_ViolaOnFloor1, $FF

EnAnim_ViolaOnRightWall_BANK{BANK}:
    .byte _id_EnFrame_ViolaOnRightWall0, _id_EnFrame_ViolaOnRightWall1, $FF

EnAnim_ViolaOnCeiling_BANK{BANK}:
    .byte _id_EnFrame_ViolaOnCeiling0, _id_EnFrame_ViolaOnCeiling1, $FF

EnAnim_ViolaOnLeftWall_BANK{BANK}:
    .byte _id_EnFrame_ViolaOnLeftWall0, _id_EnFrame_ViolaOnLeftWall1, $FF

EnAnim_ViolaExplode_BANK{BANK}:
    .byte _id_EnFrame_ViolaExplode, $FF

EnAnim_Explosion_BANK{BANK}:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_Zebbo_L_BANK{BANK}:
    .byte _id_EnFrame_Zebbo0_L, _id_EnFrame_Zebbo1_L, $FF

EnAnim_Zebbo_R_BANK{BANK}:
    .byte _id_EnFrame_Zebbo0_R, _id_EnFrame_Zebbo1_R, $FF

EnAnim_ZebboExplode_L_BANK{BANK}:
    .byte _id_EnFrame_ZebboExplode_L, $FF

EnAnim_ZebboExplode_R_BANK{BANK}:
    .byte _id_EnFrame_ZebboExplode_R, $FF

EnAnim_ZebboResting_L_BANK{BANK}:
    .byte _id_EnFrame_Zebbo0_L, $FF

EnAnim_ZebboResting_R_BANK{BANK}:
    .byte _id_EnFrame_Zebbo0_R, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_BANK{BANK}:
    PtrTableEntry EnFramePtrTable1, EnFrame00_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame01_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame14_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame15_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame16_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzIdle0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzIdle1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzSwooping0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzSwooping1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame1F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame20_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame23_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame24_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame25_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame26_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise2_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise3_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise2_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise3_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleFloor0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleFloor1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaFloorHopping_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleCeiling0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleCeiling1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaCeilingHopping_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame36_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaExplodeFloor_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaExplodeCeiling_BANK{BANK}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnFloor0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnFloor1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnRightWall0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnRightWall1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnCeiling0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnCeiling1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnLeftWall0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnLeftWall1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame63_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame64_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame65_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebboExplode_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebboExplode_R_BANK{BANK}
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

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0_BANK{BANK}:
    .byte $FC, $FC

;Enemy explode.
EnPlace1_BANK{BANK}:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2_BANK{BANK}:
    .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
    .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
    .byte $12, $E8, $14, $F8

EnPlace3_BANK{BANK}:
    .byte $F4, $F4, $F4, $04

EnPlace5_BANK{BANK}:
    .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

EnPlace6_BANK{BANK}:
    .byte $FC, $F8, $FC, $00

EnPlace4_BANK{BANK}:
    .byte $F0, $F8, $F0, $00

EnPlace7_BANK{BANK}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

EnPlace8_BANK{BANK}:
    .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

EnPlace9_BANK{BANK}:
EnPlaceA_BANK{BANK}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_BANK{BANK}:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_BANK{BANK}:
    .byte $F8, $FC, $00, $FC

EnPlaceD_BANK{BANK}:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlaceE_BANK{BANK}:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

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

EnFrame_RidleyIdle0_R_BANK{BANK}:
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

EnFrame_RidleyIdle1_R_BANK{BANK}:
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

EnFrame_RidleyHopping0_R_BANK{BANK}:
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

EnFrame_RidleyHopping1_R_BANK{BANK}:
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

EnFrame_RidleyIdle0_L_BANK{BANK}:
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

EnFrame_RidleyIdle1_L_BANK{BANK}:
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

EnFrame_RidleyHopping0_L_BANK{BANK}:
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

EnFrame_RidleyHopping1_L_BANK{BANK}:
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

EnFrame_RidleyExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame_RidleyFireball0_R_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_R_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_R_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_R_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball0_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_L_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_L_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame14_BANK{BANK}:
EnFrame15_BANK{BANK}:
EnFrame16_BANK{BANK}:
EnFrame_HoltzIdle0_BANK{BANK}:
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

EnFrame_HoltzIdle1_BANK{BANK}:
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

EnFrame_HoltzSwooping0_BANK{BANK}:
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

EnFrame_HoltzSwooping1_BANK{BANK}:
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

EnFrame_HoltzExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

EnFrame1C_BANK{BANK}:
EnFrame1D_BANK{BANK}:
EnFrame1E_BANK{BANK}:
EnFrame1F_BANK{BANK}:
EnFrame20_BANK{BANK}:
EnFrame_Mella0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E6
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E6
    .byte $FF

EnFrame_Mella1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E5
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E5
    .byte $FF

EnFrame23_BANK{BANK}:
EnFrame24_BANK{BANK}:
EnFrame25_BANK{BANK}:
EnFrame26_BANK{BANK}:
EnFrame_MultiviolaSpinningCounterclockwise0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise2_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise3_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise0_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise1_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise2_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame_MultiviolaSpinningClockwise3_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

EnFrame_DessgeegaIdleFloor0_BANK{BANK}:
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

EnFrame_DessgeegaIdleFloor1_BANK{BANK}:
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

EnFrame_DessgeegaFloorHopping_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame_DessgeegaIdleCeiling0_BANK{BANK}:
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

EnFrame_DessgeegaIdleCeiling1_BANK{BANK}:
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

EnFrame_DessgeegaCeilingHopping_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame36_BANK{BANK}:
EnFrame_DessgeegaExplodeFloor_BANK{BANK}:
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

EnFrame_DessgeegaExplodeCeiling_BANK{BANK}:
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
    .byte ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $C0
    .byte $FF

EnFrame43_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace0, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace3, $00, $00
    .byte $D1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $D1
    .byte $FF

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
EnFrame_ViolaOnFloor0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnFloor1_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnRightWall0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame_ViolaOnRightWall1_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DB
    .byte $FF

EnFrame_ViolaOnCeiling0_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnCeiling1_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnLeftWall0_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame_ViolaOnLeftWall1_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DB
    .byte $FF

EnFrame_ViolaExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

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
EnFrame_Zebbo0_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Zebbo1_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_ZebboExplode_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_Zebbo0_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Zebbo1_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_ZebboExplode_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

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
