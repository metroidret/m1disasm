;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ;($BBCA)
EnAnim_00_{AREA}:
    .byte _id_EnFrame00_{AREA}, _id_EnFrame01_{AREA}, $FF

EnAnim_EnProjectileKilled_{AREA}:
    .byte _id_EnFrame_EnProjectileKilled_{AREA}, $FF

EnAnim_RidleyIdle_R_{AREA}:
    .byte _id_EnFrame_RidleyIdle0_R_{AREA}, _id_EnFrame_RidleyIdle1_R_{AREA}, $FF

EnAnim_RidleyIdle_L_{AREA}:
    .byte _id_EnFrame_RidleyIdle0_L_{AREA}, _id_EnFrame_RidleyIdle1_L_{AREA}, $FF

EnAnim_RidleyHopping_R_{AREA}:
    .byte _id_EnFrame_RidleyHopping0_R_{AREA}, _id_EnFrame_RidleyHopping1_R_{AREA}, $FF

EnAnim_RidleyHopping_L_{AREA}:
    .byte _id_EnFrame_RidleyHopping0_L_{AREA}, _id_EnFrame_RidleyHopping1_L_{AREA}, $FF

EnAnim_RidleyExplode_{AREA}:
    .byte _id_EnFrame_RidleyExplode_{AREA}, $FF

EnAnim_RidleyFireball_R_{AREA}:
    .byte _id_EnFrame_RidleyFireball0_R_{AREA}, _id_EnFrame_RidleyFireball1_R_{AREA}, _id_EnFrame_RidleyFireball2_R_{AREA}, _id_EnFrame_RidleyFireball3_R_{AREA}, $FF

EnAnim_RidleyFireball_L_{AREA}:
    .byte _id_EnFrame_RidleyFireball0_L_{AREA}, _id_EnFrame_RidleyFireball1_L_{AREA}, _id_EnFrame_RidleyFireball2_L_{AREA}, _id_EnFrame_RidleyFireball3_L_{AREA}, $FF

EnAnim_SqueeptJumping_{AREA}:
    .byte _id_EnFrame_SqueeptJumping0_{AREA}, _id_EnFrame_SqueeptJumping1_{AREA}, $FF

EnAnim_SqueeptFalling_{AREA}:
    .byte _id_EnFrame_SqueeptFalling_{AREA}, $FF

EnAnim_GerutaIdle_{AREA}:
    .byte _id_EnFrame_GerutaIdle0_{AREA}, _id_EnFrame_GerutaIdle1_{AREA}, $FF

EnAnim_GerutaSwooping_{AREA}:
    .byte _id_EnFrame_GerutaSwooping0_{AREA}, _id_EnFrame_GerutaSwooping1_{AREA}, $FF

EnAnim_GerutaExplode_{AREA}:
    .byte _id_EnFrame_GerutaExplode_{AREA}, $FF

EnAnim_RipperII_R_{AREA}:
    .byte _id_EnFrame_RipperII0_R_{AREA}, _id_EnFrame_RipperII1_R_{AREA}, $FF

EnAnim_RipperII_L_{AREA}:
    .byte _id_EnFrame_RipperII0_L_{AREA}, _id_EnFrame_RipperII1_L_{AREA}, $FF

EnAnim_RipperIIExplode_{AREA}:
    .byte _id_EnFrame_RipperIIExplode_{AREA}, $FF

EnAnim_Mella_{AREA}:
    .byte _id_EnFrame_Mella0_{AREA}, _id_EnFrame_Mella1_{AREA}, $FF

EnAnim_SqueeptExplode_{AREA}:
    .byte _id_EnFrame_SqueeptExplode_{AREA}, $FF

EnAnim_MultiviolaSpinningCounterclockwise_{AREA}:
    .byte _id_EnFrame_MultiviolaSpinningCounterclockwise0_{AREA}, _id_EnFrame_MultiviolaSpinningCounterclockwise1_{AREA}, _id_EnFrame_MultiviolaSpinningCounterclockwise2_{AREA}, _id_EnFrame_MultiviolaSpinningCounterclockwise3_{AREA}, $FF

EnAnim_MultiviolaSpinningClockwise_{AREA}:
    .byte _id_EnFrame_MultiviolaSpinningClockwise0_{AREA}, _id_EnFrame_MultiviolaSpinningClockwise1_{AREA}, _id_EnFrame_MultiviolaSpinningClockwise2_{AREA}, _id_EnFrame_MultiviolaSpinningClockwise3_{AREA}, $FF

EnAnim_MultiviolaExplode_{AREA}:
    .byte _id_EnFrame_MultiviolaExplode_{AREA}, $FF

EnAnim_DragonIdle_R_{AREA}:
    .byte _id_EnFrame_DragonIdle_R_{AREA}, $FF

EnAnim_DragonPrepareToSpit_R_{AREA}:
    .byte _id_EnFrame_DragonPrepareToSpit_R_{AREA}, $FF

EnAnim_DragonIdle_L_{AREA}:
    .byte _id_EnFrame_DragonIdle_L_{AREA}, $FF

EnAnim_DragonPrepareToSpit_L_{AREA}:
    .byte _id_EnFrame_DragonPrepareToSpit_L_{AREA}, $FF

EnAnim_DragonExplode_{AREA}:
    .byte _id_EnFrame_DragonExplode_{AREA}, $FF

EnAnim_PolypRock_{AREA}:
    .byte _id_EnFrame_PolypRock_{AREA}, $FF

EnAnim_PolypRockShatter_{AREA}:
    .byte _id_EnFrame_PolypRockShatter0_{AREA}, _id_EnFrame_PolypRockShatter1_{AREA}, $F7, $FF

EnAnim_DragonEnProjectileUp_R_{AREA}:
    .byte _id_EnFrame_DragonEnProjectileUp_R_{AREA}, $FF

EnAnim_DragonEnProjectileDown_R_{AREA}:
    .byte _id_EnFrame_DragonEnProjectileDown_R_{AREA}, $FF

EnAnim_DragonEnProjectileUp_L_{AREA}:
    .byte _id_EnFrame_DragonEnProjectileUp_L_{AREA}, $FF

EnAnim_DragonEnProjectileDown_L_{AREA}:
    .byte _id_EnFrame_DragonEnProjectileDown_L_{AREA}, $FF

EnAnim_DragonEnProjectileSplatter_{AREA}:
    .byte _id_EnFrame_DragonEnProjectileSplatter0_{AREA}, _id_EnFrame_DragonEnProjectileSplatter0_{AREA}, _id_EnFrame_DragonEnProjectileSplatter0_{AREA}, _id_EnFrame_DragonEnProjectileSplatter0_{AREA}, _id_EnFrame_DragonEnProjectileSplatter0_{AREA}, _id_EnFrame_DragonEnProjectileSplatter1_{AREA}, _id_EnFrame_DragonEnProjectileSplatter1_{AREA}, _id_EnFrame_DragonEnProjectileSplatter1_{AREA}, _id_EnFrame_DragonEnProjectileSplatter1_{AREA}, _id_EnFrame_DragonEnProjectileSplatter2_{AREA}, _id_EnFrame_DragonEnProjectileSplatter2_{AREA}, _id_EnFrame_DragonEnProjectileSplatter2_{AREA}, $F7, $FF

EnAnim_NovaOnFloor_{AREA}:
    .byte _id_EnFrame_NovaOnFloor0_{AREA}, _id_EnFrame_NovaOnFloor1_{AREA}, $FF

EnAnim_NovaOnRightWall_{AREA}:
    .byte _id_EnFrame_NovaOnRightWall0_{AREA}, _id_EnFrame_NovaOnRightWall1_{AREA}, $FF

EnAnim_NovaOnCeiling_{AREA}:
    .byte _id_EnFrame_NovaOnCeiling0_{AREA}, _id_EnFrame_NovaOnCeiling1_{AREA}, $FF

EnAnim_NovaOnLeftWall_{AREA}:
    .byte _id_EnFrame_NovaOnLeftWall0_{AREA}, _id_EnFrame_NovaOnLeftWall1_{AREA}, $FF

EnAnim_NovaExplode_{AREA}:
    .byte _id_EnFrame_NovaExplode_{AREA}, $FF

EnAnim_Explosion_{AREA}:
    .byte _id_EnFrame_Explosion0_{AREA}, $F7, _id_EnFrame_Explosion1_{AREA}, $F7, $FF

EnAnim_GametActive_L_{AREA}:
    .byte _id_EnFrame_Gamet0_L_{AREA}, _id_EnFrame_Gamet1_L_{AREA}, $FF

EnAnim_GametActive_R_{AREA}:
    .byte _id_EnFrame_Gamet0_R_{AREA}, _id_EnFrame_Gamet1_R_{AREA}, $FF

EnAnim_GametExplode_L_{AREA}:
    .byte _id_EnFrame_GametExplode_L_{AREA}, $FF

EnAnim_GametExplode_R_{AREA}:
    .byte _id_EnFrame_GametExplode_R_{AREA}, $FF

EnAnim_GametResting_L_{AREA}:
    .byte _id_EnFrame_Gamet0_L_{AREA}, $FF

EnAnim_GametResting_R_{AREA}:
    .byte _id_EnFrame_Gamet0_R_{AREA}, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}: ;($BC54)
    PtrTableEntry EnFramePtrTable1, EnFrame00_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame01_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SqueeptJumping1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SqueeptJumping0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SqueeptFalling_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GerutaIdle0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GerutaIdle1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GerutaSwooping0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GerutaSwooping1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GerutaExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperII0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperII1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperII0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperII1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperIIExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SqueeptExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame24_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame25_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame26_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise2_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise3_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise2_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise3_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonIdle_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonPrepareToSpit_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonIdle_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonPrepareToSpit_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame35_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame36_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame37_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame38_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame39_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame3A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileUp_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileDown_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileUp_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileDown_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileSplatter0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileSplatter2_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_DragonEnProjectileSplatter1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_PolypRock_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_PolypRockShatter0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_PolypRockShatter1_{AREA}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnFloor0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnFloor1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnRightWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnRightWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnCeiling0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnCeiling1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnLeftWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaOnLeftWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_NovaExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame63_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame64_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame65_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Gamet0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Gamet1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GametExplode_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Gamet0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Gamet1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GametExplode_R_{AREA}
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
EnFramePtrTable2_{AREA}: ;($BD54)
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

EnPlacePtrTable_{AREA}: ;($BD68)
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

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

;Health pickup
EnPlace0_{AREA}:
    .byte $FC, $FC

;Enemy explode.
EnPlace1_{AREA}:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2_{AREA}:
    ;nothing

EnPlace3_{AREA}:
    .byte $F4, $F4, $F4, $04

EnPlace5_{AREA}:
    .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

EnPlace6_{AREA}:
    .byte $FC, $F8, $FC, $00

EnPlace4_{AREA}:
    .byte $F0, $F8, $F0, $00

EnPlace7_{AREA}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

EnPlace8_{AREA}:
    .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

EnPlace9_{AREA}:
EnPlaceA_{AREA}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_{AREA}:
    .byte $F8, $FC, $00, $FC

EnPlaceD_{AREA}:
    ;nothing

;Enemy frame drawing data.

;Unused.
EnFrame00_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

;EnProjectile killed.
EnFrame_EnProjectileKilled_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_RidleyIdle0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyIdle1_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyHopping0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyHopping1_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyIdle0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyIdle1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyHopping0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyHopping1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $13, $08
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

EnFrame_RidleyExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame_RidleyFireball0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_R_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_R_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_L_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_L_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $FB
    .byte $FF

;Squeept jumping.
EnFrame_SqueeptJumping1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $FB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $FB
    .byte $FF

;Squeept jumping.
EnFrame_SqueeptJumping0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $FA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $FA
    .byte $FF

;Squeept falling.
EnFrame_SqueeptFalling_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EB
    .byte $FF

;Geruta idle.
EnFrame_GerutaIdle0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $DF
    .byte $FF

;Geruta idle.
EnFrame_GerutaIdle1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $08
    .byte $CE
    .byte $CF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $DE
    .byte $FF

;Geruta swooping.
EnFrame_GerutaSwooping0_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $08
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

;Geruta swooping.
EnFrame_GerutaSwooping1_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $08
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

;Geruta explode.
EnFrame_GerutaExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

;Ripper II facing right.
EnFrame_RipperII0_R_{AREA}:
    .byte ($3 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

;Ripper II facing right.
EnFrame_RipperII1_R_{AREA}:
    .byte ($3 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

;Ripper II facing left.
EnFrame_RipperII0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $F6
    .byte $F7
    .byte $FF

;Ripper II facing left.
EnFrame_RipperII1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $E7
    .byte $F7
    .byte $FF

;Ripper II explode.
EnFrame_RipperIIExplode_{AREA}:
    .byte ($3 << 4) + _id_EnPlace1, $00, $00
    .byte $F6
    .byte $F7
    .byte $FF

;Mella.
EnFrame_Mella0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $E6
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E6
    .byte $FF

;Mella.
EnFrame_Mella1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace9_{AREA}, $04, $08
    .byte $E5
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E5
    .byte $FF

;Squeept explode.
EnFrame_SqueeptExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $EA
    .byte $EA
    .byte $EB
    .byte $EB
    .byte $FF

;Multiviola spinning counterclockwise.
EnFrame24_{AREA}:
EnFrame25_{AREA}:
EnFrame26_{AREA}:
EnFrame_MultiviolaSpinningCounterclockwise0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola spinning counterclockwise.
EnFrame_MultiviolaSpinningCounterclockwise1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola spinning counterclockwise.
EnFrame_MultiviolaSpinningCounterclockwise2_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

;Multiviola spinning counterclockwise.
EnFrame_MultiviolaSpinningCounterclockwise3_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola spinning clockwise.
EnFrame_MultiviolaSpinningClockwise0_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola spinning clockwise.
EnFrame_MultiviolaSpinningClockwise1_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola spinning clockwise.
EnFrame_MultiviolaSpinningClockwise2_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

;Multiviola spinning clockwise.
EnFrame_MultiviolaSpinningClockwise3_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

;Multiviola explode.
EnFrame_MultiviolaExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

;Dragon idle facing right.
EnFrame_DragonIdle_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $08
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

;Dragon prepare to spit facing right.
EnFrame_DragonPrepareToSpit_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace4_{AREA}, $08, $08
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

;Dragon idle facing left.
EnFrame_DragonIdle_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace4_{AREA}, $08, $08
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

;Dragon prepare to spit facing left.
EnFrame_DragonPrepareToSpit_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace4_{AREA}, $08, $08
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

;Dragon explode.
EnFrame_DragonExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $FC, $00
    .byte $C8
    .byte $C9
    .byte $D8
    .byte $D9
    .byte $E8
    .byte $E9
    .byte $FF

;Dragon EnProjectile up-right.
EnFrame35_{AREA}:
EnFrame36_{AREA}:
EnFrame37_{AREA}:
EnFrame38_{AREA}:
EnFrame39_{AREA}:
EnFrame3A_{AREA}:
EnFrame_DragonEnProjectileUp_R_{AREA}:
    .byte ($3 << 4) + _id_EnPlace7_{AREA}, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

;Dragon EnProjectile down-right.
EnFrame_DragonEnProjectileDown_R_{AREA}:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace7_{AREA}, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

;Dragon EnProjectile up-left.
EnFrame_DragonEnProjectileUp_L_{AREA}:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace7_{AREA}, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

;Dragon EnProjectile down-left.
EnFrame_DragonEnProjectileDown_L_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace7_{AREA}, $04, $04
    .byte $E0
    .byte $E1
    .byte $F0
    .byte $F1
    .byte $FF

;Dragon EnProjectile splatter.
EnFrame_DragonEnProjectileSplatter0_{AREA}:
    .byte ($3 << 4) + _id_EnPlace7_{AREA}, $00, $00
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $3
    .byte $E2
    .byte $FF

;Dragon EnProjectile splatter.
EnFrame_DragonEnProjectileSplatter2_{AREA}:
    .byte ($3 << 4) + _id_EnPlace8_{AREA}, $00, $00
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $FF

;Dragon EnProjectile splatter.
EnFrame_DragonEnProjectileSplatter1_{AREA}:
    .byte ($3 << 4) + _id_EnPlace8_{AREA}, $00, $00
    .byte $FE
    .byte $FE
    .byte $E2
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E2
    .byte $FF

;Polyp rock.
EnFrame_PolypRock_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $04, $04
    .byte $C0
    .byte $FF

;Polyp rock shatter.
EnFrame_PolypRockShatter0_{AREA}:
    .byte ($3 << 4) + _id_EnPlace0, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

;Polyp rock shatter.
EnFrame_PolypRockShatter1_{AREA}:
    .byte ($3 << 4) + _id_EnPlace3_{AREA}, $00, $00
    .byte $D1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $3
    .byte $D1
    .byte $FF

;Nova on floor.
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
EnFrame_NovaOnFloor0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DC
    .byte $DD
    .byte $FF

;Nova on floor.
EnFrame_NovaOnFloor1_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Nova on right wall.
EnFrame_NovaOnRightWall0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Nova on right wall.
EnFrame_NovaOnRightWall1_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DB
    .byte $FF

;Nova on ceiling.
EnFrame_NovaOnCeiling0_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DC
    .byte $DD
    .byte $FF

;Nova on ceiling.
EnFrame_NovaOnCeiling1_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Nova on left wall.
EnFrame_NovaOnLeftWall0_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Nova on left wall.
EnFrame_NovaOnLeftWall1_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DB
    .byte $FF

;Nova explode.
EnFrame_NovaExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Explosion.
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

;Explosion.
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

;Gamet facing left.
EnFrame63_{AREA}:
EnFrame64_{AREA}:
EnFrame65_{AREA}:
EnFrame_Gamet0_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Gamet facing left.
EnFrame_Gamet1_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Gamet explode facing left.
EnFrame_GametExplode_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Gamet facing right.
EnFrame_Gamet0_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Gamet facing right.
EnFrame_Gamet1_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Gamet explode facing right.
EnFrame_GametExplode_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Missile pickup.
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

;Small energy pickup.
EnFrame_SmallEnergyPickup_{AREA}:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Big energy pickup.
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
