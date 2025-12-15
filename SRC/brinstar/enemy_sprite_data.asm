;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_BANK{BANK}: ;($9D6A)
EnAnim_00_BANK{BANK}:
    .byte _id_EnFrame00_BANK{BANK}, _id_EnFrame01_BANK{BANK}, $FF

EnAnim_EnProjectileKilled_BANK{BANK}:
    .byte _id_EnFrame_EnProjectileKilled_BANK{BANK}, $FF

EnAnim_SidehopperFloorIdle_BANK{BANK}:
    .byte _id_EnFrame_SidehopperFloorIdle0_BANK{BANK}, _id_EnFrame_SidehopperFloorIdle1_BANK{BANK}, $FF

EnAnim_SidehopperFloorStartHopping_BANK{BANK}:
    .byte _id_EnFrame_SidehopperFloorIdle1_BANK{BANK}
EnAnim_SidehopperFloorHopping_BANK{BANK}:
    .byte _id_EnFrame_SidehopperFloorHopping_BANK{BANK}, $FF

EnAnim_SidehopperCeilingIdle_BANK{BANK}:
    .byte _id_EnFrame_SidehopperCeilingIdle0_BANK{BANK}, _id_EnFrame_SidehopperCeilingIdle1_BANK{BANK}, $FF

EnAnim_SidehopperCeilingStartHopping_BANK{BANK}:
    .byte _id_EnFrame_SidehopperCeilingIdle1_BANK{BANK}
EnAnim_SidehopperCeilingHopping_BANK{BANK}:
    .byte _id_EnFrame_SidehopperCeilingHopping_BANK{BANK}, $FF

EnAnim_11_BANK{BANK}:
    .byte _id_EnFrame_Ripper_L_BANK{BANK}, _id_EnFrame_Waver1_L_BANK{BANK}
EnAnim_Waver0_L_BANK{BANK}:
    .byte _id_EnFrame_Waver0_L_BANK{BANK}, $FF

EnAnim_15_BANK{BANK}:
    .byte _id_EnFrame_Ripper_R_BANK{BANK}, _id_EnFrame_Waver1_R_BANK{BANK}
EnAnim_Waver0_R_BANK{BANK}:
    .byte _id_EnFrame_Waver0_R_BANK{BANK}, $FF

EnAnim_Ripper_L_BANK{BANK}:
    .byte _id_EnFrame_Ripper_L_BANK{BANK}, $FF

EnAnim_Ripper_R_BANK{BANK}:
    .byte _id_EnFrame_Ripper_R_BANK{BANK}, $FF

EnAnim_Waver1_L_BANK{BANK}:
    .byte _id_EnFrame_Waver1_L_BANK{BANK},
EnAnim_Waver2_L_BANK{BANK}:
    .byte _id_EnFrame_Waver2_L_BANK{BANK}, $FF

EnAnim_Waver1_R_BANK{BANK}:
    .byte _id_EnFrame_Waver1_R_BANK{BANK}
EnAnim_Waver2_R_BANK{BANK}:
    .byte _id_EnFrame_Waver2_R_BANK{BANK}, $FF

EnAnim_Skree_BANK{BANK}:
    .byte _id_EnFrame_Skree0_BANK{BANK}, _id_EnFrame_Skree1_BANK{BANK}, _id_EnFrame_Skree2_BANK{BANK}, $FF

EnAnim_SidehopperFloorExplode_BANK{BANK}:
    .byte _id_EnFrame_SidehopperFloorExplode_BANK{BANK}, $FF

EnAnim_SidehopperCeilingExplode_BANK{BANK}:
    .byte _id_EnFrame_SidehopperCeilingExplode_BANK{BANK}, $FF

EnAnim_WaverExplode_L_BANK{BANK}:
    .byte _id_EnFrame_WaverExplode_L_BANK{BANK}, $FF

EnAnim_WaverExplode_R_BANK{BANK}:
    .byte _id_EnFrame_WaverExplode_R_BANK{BANK}, $FF

EnAnim_RipperExplode_L_BANK{BANK}:
    .byte _id_EnFrame_RipperExplode_L_BANK{BANK}, $FF

EnAnim_RipperExplode_R_BANK{BANK}:
    .byte _id_EnFrame_RipperExplode_R_BANK{BANK}, $FF

EnAnim_SkreeExplode_BANK{BANK}:
    .byte _id_EnFrame_SkreeExplode_BANK{BANK}, $FF

EnAnim_ZoomerOnFloor_BANK{BANK}:
    .byte _id_EnFrame_ZoomerOnFloor0_BANK{BANK}, _id_EnFrame_ZoomerOnFloor1_BANK{BANK}, $FF

EnAnim_ZoomerOnRightWall_BANK{BANK}:
    .byte _id_EnFrame_ZoomerOnRightWall0_BANK{BANK}, _id_EnFrame_ZoomerOnRightWall1_BANK{BANK}, $FF

EnAnim_ZoomerOnCeiling_BANK{BANK}:
    .byte _id_EnFrame_ZoomerOnCeiling0_BANK{BANK}, _id_EnFrame_ZoomerOnCeiling1_BANK{BANK}, $FF

EnAnim_ZoomerOnLeftWall_BANK{BANK}:
    .byte _id_EnFrame_ZoomerOnLeftWall0_BANK{BANK}, _id_EnFrame_ZoomerOnLeftWall1_BANK{BANK}, $FF

EnAnim_ZoomerExplode_BANK{BANK}:
    .byte _id_EnFrame_ZoomerExplode_BANK{BANK}, $FF

EnAnim_Explosion_BANK{BANK}:
    .byte _id_EnFrame_Explosion0_BANK{BANK}, $F7, _id_EnFrame_Explosion1_BANK{BANK}, $F7, $FF

EnAnim_Rio_BANK{BANK}:
    .byte _id_EnFrame_Rio0_BANK{BANK}, _id_EnFrame_Rio1_BANK{BANK}, $FF

EnAnim_RioExplode_BANK{BANK}:
    .byte _id_EnFrame_RioExplode_BANK{BANK}, $FF

EnAnim_Zeb_L_BANK{BANK}:
    .byte _id_EnFrame_Zeb0_L_BANK{BANK}, _id_EnFrame_Zeb1_L_BANK{BANK}, $FF

EnAnim_Zeb_R_BANK{BANK}:
    .byte _id_EnFrame_Zeb0_R_BANK{BANK}, _id_EnFrame_Zeb1_R_BANK{BANK}, $FF

EnAnim_ZebExplode_L_BANK{BANK}:
    .byte _id_EnFrame_ZebExplode_L_BANK{BANK}, $FF

EnAnim_ZebExplode_R_BANK{BANK}:
    .byte _id_EnFrame_ZebExplode_R_BANK{BANK}, $FF

EnAnim_ZebResting_L_BANK{BANK}:
    .byte _id_EnFrame_Zeb0_L_BANK{BANK}, $FF

EnAnim_ZebResting_R_BANK{BANK}:
    .byte _id_EnFrame_Zeb0_R_BANK{BANK}, $FF

EnAnim_KraidLint_R_BANK{BANK}:
    .byte _id_EnFrame_KraidLint_R_BANK{BANK}, $FF

EnAnim_KraidLint_L_BANK{BANK}:
    .byte _id_EnFrame_KraidLint_L_BANK{BANK}, $FF

EnAnim_KraidNailMoving_R_BANK{BANK}:
    .byte _id_EnFrame_KraidNail1_R_BANK{BANK}, _id_EnFrame_KraidNail2_R_BANK{BANK}, _id_EnFrame_KraidNail3_R_BANK{BANK}
EnAnim_KraidNailIdle_R_BANK{BANK}:
    .byte _id_EnFrame_KraidNail0_R_BANK{BANK}, $FF

EnAnim_KraidNailMoving_L_BANK{BANK}:
    .byte _id_EnFrame_KraidNail1_L_BANK{BANK}, _id_EnFrame_KraidNail2_L_BANK{BANK}, _id_EnFrame_KraidNail3_L_BANK{BANK}
EnAnim_KraidNailIdle_L_BANK{BANK}:
    .byte _id_EnFrame_KraidNail0_L_BANK{BANK}, $FF

EnAnim_Mellow_BANK{BANK}:
    .byte _id_EnFrame_Mellow0_BANK{BANK}, _id_EnFrame_Mellow1_BANK{BANK}, $FF

EnAnim_Kraid_R_BANK{BANK}:
    .byte _id_EnFrame_Kraid0_R_BANK{BANK}, _id_EnFrame_Kraid1_R_BANK{BANK}, $FF

EnAnim_Kraid_L_BANK{BANK}:
    .byte _id_EnFrame_Kraid0_L_BANK{BANK}, _id_EnFrame_Kraid1_L_BANK{BANK}, $FF

EnAnim_KraidExplode_R_BANK{BANK}:
    .byte _id_EnFrame_KraidExplode_R_BANK{BANK}, $FF

EnAnim_KraidExplode_L_BANK{BANK}:
    .byte _id_EnFrame_KraidExplode_L_BANK{BANK}, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_BANK{BANK}:
    PtrTableEntry EnFramePtrTable1, EnFrame00_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame01_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame05_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame06_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame07_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame08_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame09_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame0F_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame10_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame11_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame12_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame13_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame14_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame15_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame16_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame17_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame18_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorHopping_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingHopping_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Ripper_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Ripper_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame25_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame26_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree2_BANK{BANK}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplode_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplode_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplode_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplode_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_SkreeExplode_BANK{BANK}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_RioExplode_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplode_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplode_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLint_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLint_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail2_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail3_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail2_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail3_L_BANK{BANK}
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
    PtrTableEntryBank EnFramePtrTable1, EnFrame_MissilePickup
    PtrTableEntryBank EnFramePtrTable1, EnFrame_SmallEnergyPickup
    PtrTableEntry EnFramePtrTable1, EnFrame82_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame83_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame84_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame85_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame86_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame87_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame88_BANK{BANK}
    PtrTableEntryBank EnFramePtrTable1, EnFrame_BigEnergyPickup
    PtrTableEntry EnFramePtrTable1, EnFrame8A_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame8B_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame8C_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame8D_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame8E_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow0_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow1_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_L_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_R_BANK{BANK}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_L_BANK{BANK}

EnPlacePtrTable_BANK{BANK}:
    PtrTableEntryBank EnPlacePtrTable, EnPlace0
    PtrTableEntryBank EnPlacePtrTable, EnPlace1
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

;Health pickup
EnPlace0_BANK{BANK}:
    .byte $FC, $FC

;Enemy explode.
EnPlace1_BANK{BANK}:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2_BANK{BANK}:
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3_BANK{BANK}:
EnPlace4_BANK{BANK}:
EnPlace5_BANK{BANK}:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6_BANK{BANK}:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7_BANK{BANK}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8_BANK{BANK}:
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9_BANK{BANK}:
EnPlaceA_BANK{BANK}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_BANK{BANK}:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_BANK{BANK}:
EnPlaceD_BANK{BANK}:
EnPlaceE_BANK{BANK}:
EnPlaceF_BANK{BANK}:
    .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

;Unused.
EnFrame00_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

;EnProjectile killed.
EnFrame_EnProjectileKilled_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Waver2_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame_Waver2_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame05_BANK{BANK}:
EnFrame06_BANK{BANK}:
EnFrame07_BANK{BANK}:
EnFrame08_BANK{BANK}:
EnFrame09_BANK{BANK}:
EnFrame0A_BANK{BANK}:
EnFrame0B_BANK{BANK}:
EnFrame0C_BANK{BANK}:
EnFrame0D_BANK{BANK}:
EnFrame0E_BANK{BANK}:
EnFrame0F_BANK{BANK}:
EnFrame10_BANK{BANK}:
EnFrame11_BANK{BANK}:
EnFrame12_BANK{BANK}:
EnFrame13_BANK{BANK}:
EnFrame14_BANK{BANK}:
EnFrame15_BANK{BANK}:
EnFrame16_BANK{BANK}:
EnFrame17_BANK{BANK}:
EnFrame18_BANK{BANK}:
EnFrame_SidehopperFloorIdle0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace5_BANK{BANK}, $08, $0A
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

EnFrame_SidehopperFloorIdle1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace5_BANK{BANK}, $08, $0A
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

EnFrame_SidehopperFloorHopping_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace6_BANK{BANK}, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

EnFrame_SidehopperCeilingIdle0_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_BANK{BANK}, $08, $0A
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

EnFrame_SidehopperCeilingIdle1_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_BANK{BANK}, $08, $0A
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

EnFrame_SidehopperCeilingHopping_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace6_BANK{BANK}, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

;Ripper facing right.
EnFrame_Ripper_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper facing left.
EnFrame_Ripper_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Skree.
EnFrame25_BANK{BANK}:
EnFrame26_BANK{BANK}:
EnFrame_Skree0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace8_BANK{BANK}, $0C, $08
    .byte $CE
    .byte $FC, $00, $FC
    .byte $DE
    .byte $EE
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EE
    .byte $FF

;Skree.
EnFrame_Skree1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace8_BANK{BANK}, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

;Skree.
EnFrame_Skree2_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace8_BANK{BANK}, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

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
EnFrame_SidehopperFloorExplode_BANK{BANK}:
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

EnFrame_SidehopperCeilingExplode_BANK{BANK}:
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

EnFrame_WaverExplode_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame_WaverExplode_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper explode facing left (uses waver gfx).
EnFrame_RipperExplode_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

;Ripper explode facing right (uses waver gfx).
EnFrame_RipperExplode_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

;Skree explode.
EnFrame_SkreeExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zoomer on floor.
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
EnFrame_ZoomerOnFloor0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on floor.
EnFrame_ZoomerOnFloor1_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall1_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling0_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling1_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall0_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall1_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_BANK{BANK}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer explode.
EnFrame_ZoomerExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Explosion.
EnFrame_Explosion0_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlaceA_BANK{BANK}, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

;Explosion.
EnFrame_Explosion1_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlaceA_BANK{BANK}, $00, $00
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
EnFrame_Rio0_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceB_BANK{BANK}, $08, $08
    .byte $E2
    .byte $E3
    .byte $E4
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E3
    .byte $E4
    .byte $FF

;Rio.
EnFrame_Rio1_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceB_BANK{BANK}, $08, $08
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
EnFrame_RioExplode_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $96
    .byte $96
    .byte $98
    .byte $98
    .byte $FF

;Zeb facing left.
EnFrame_Zeb0_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceA_BANK{BANK}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing left.
EnFrame_Zeb1_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlaceA_BANK{BANK}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing left.
EnFrame_ZebExplode_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb facing right.
EnFrame_Zeb0_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_BANK{BANK}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing right.
EnFrame_Zeb1_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_BANK{BANK}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing right.
EnFrame_ZebExplode_R_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_KraidLint_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidLint_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidNail0_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_R_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_R_BANK{BANK}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail0_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_L_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_L_BANK{BANK}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

;Missile pickup.
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
    .byte ($0 << 4) + _id_EnPlace6_BANK{BANK}, $08, $04
    .byte $FE
    .byte $FE
    .byte $14
    .byte $24
    .byte $FF

;Small energy pickup.
EnFrame_SmallEnergyPickup_BANK{BANK}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Big energy pickup.
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

;Mellow.
EnFrame8A_BANK{BANK}:
EnFrame8B_BANK{BANK}:
EnFrame8C_BANK{BANK}:
EnFrame8D_BANK{BANK}:
EnFrame8E_BANK{BANK}:
EnFrame_Mellow0_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlaceF_BANK{BANK}, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

;Mellow.
EnFrame_Mellow1_BANK{BANK}:
    .byte ($3 << 4) + _id_EnPlaceF_BANK{BANK}, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame_Kraid0_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace2_BANK{BANK}, $10, $0C
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

EnFrame_Kraid1_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace2_BANK{BANK}, $10, $0C
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

EnFrame_Kraid0_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_BANK{BANK}, $10, $0C
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

EnFrame_Kraid1_L_BANK{BANK}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_BANK{BANK}, $10, $0C
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

EnFrame_KraidExplode_R_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame_KraidExplode_L_BANK{BANK}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
