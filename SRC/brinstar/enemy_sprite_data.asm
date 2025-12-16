;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ;($9D6A)
EnAnim_00_{AREA}:
    .byte _id_EnFrame00_{AREA}, _id_EnFrame01_{AREA}, $FF

EnAnim_EnProjectileKilled_{AREA}:
    .byte _id_EnFrame_EnProjectileKilled_{AREA}, $FF

EnAnim_SidehopperFloorIdle_{AREA}:
    .byte _id_EnFrame_SidehopperFloorIdle0_{AREA}, _id_EnFrame_SidehopperFloorIdle1_{AREA}, $FF

EnAnim_SidehopperFloorStartHopping_{AREA}:
    .byte _id_EnFrame_SidehopperFloorIdle1_{AREA}
EnAnim_SidehopperFloorHopping_{AREA}:
    .byte _id_EnFrame_SidehopperFloorHopping_{AREA}, $FF

EnAnim_SidehopperCeilingIdle_{AREA}:
    .byte _id_EnFrame_SidehopperCeilingIdle0_{AREA}, _id_EnFrame_SidehopperCeilingIdle1_{AREA}, $FF

EnAnim_SidehopperCeilingStartHopping_{AREA}:
    .byte _id_EnFrame_SidehopperCeilingIdle1_{AREA}
EnAnim_SidehopperCeilingHopping_{AREA}:
    .byte _id_EnFrame_SidehopperCeilingHopping_{AREA}, $FF

EnAnim_11_{AREA}:
    .byte _id_EnFrame_Ripper_L_{AREA}, _id_EnFrame_Waver1_L_{AREA}
EnAnim_Waver0_L_{AREA}:
    .byte _id_EnFrame_Waver0_L_{AREA}, $FF

EnAnim_15_{AREA}:
    .byte _id_EnFrame_Ripper_R_{AREA}, _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver0_R_{AREA}:
    .byte _id_EnFrame_Waver0_R_{AREA}, $FF

EnAnim_Ripper_L_{AREA}:
    .byte _id_EnFrame_Ripper_L_{AREA}, $FF

EnAnim_Ripper_R_{AREA}:
    .byte _id_EnFrame_Ripper_R_{AREA}, $FF

EnAnim_Waver1_L_{AREA}:
    .byte _id_EnFrame_Waver1_L_{AREA},
EnAnim_Waver2_L_{AREA}:
    .byte _id_EnFrame_Waver2_L_{AREA}, $FF

EnAnim_Waver1_R_{AREA}:
    .byte _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver2_R_{AREA}:
    .byte _id_EnFrame_Waver2_R_{AREA}, $FF

EnAnim_Skree_{AREA}:
    .byte _id_EnFrame_Skree0_{AREA}, _id_EnFrame_Skree1_{AREA}, _id_EnFrame_Skree2_{AREA}, $FF

EnAnim_SidehopperFloorExplode_{AREA}:
    .byte _id_EnFrame_SidehopperFloorExplode_{AREA}, $FF

EnAnim_SidehopperCeilingExplode_{AREA}:
    .byte _id_EnFrame_SidehopperCeilingExplode_{AREA}, $FF

EnAnim_WaverExplode_L_{AREA}:
    .byte _id_EnFrame_WaverExplode_L_{AREA}, $FF

EnAnim_WaverExplode_R_{AREA}:
    .byte _id_EnFrame_WaverExplode_R_{AREA}, $FF

EnAnim_RipperExplode_L_{AREA}:
    .byte _id_EnFrame_RipperExplode_L_{AREA}, $FF

EnAnim_RipperExplode_R_{AREA}:
    .byte _id_EnFrame_RipperExplode_R_{AREA}, $FF

EnAnim_SkreeExplode_{AREA}:
    .byte _id_EnFrame_SkreeExplode_{AREA}, $FF

EnAnim_ZoomerOnFloor_{AREA}:
    .byte _id_EnFrame_ZoomerOnFloor0_{AREA}, _id_EnFrame_ZoomerOnFloor1_{AREA}, $FF

EnAnim_ZoomerOnRightWall_{AREA}:
    .byte _id_EnFrame_ZoomerOnRightWall0_{AREA}, _id_EnFrame_ZoomerOnRightWall1_{AREA}, $FF

EnAnim_ZoomerOnCeiling_{AREA}:
    .byte _id_EnFrame_ZoomerOnCeiling0_{AREA}, _id_EnFrame_ZoomerOnCeiling1_{AREA}, $FF

EnAnim_ZoomerOnLeftWall_{AREA}:
    .byte _id_EnFrame_ZoomerOnLeftWall0_{AREA}, _id_EnFrame_ZoomerOnLeftWall1_{AREA}, $FF

EnAnim_ZoomerExplode_{AREA}:
    .byte _id_EnFrame_ZoomerExplode_{AREA}, $FF

EnAnim_Explosion_{AREA}:
    .byte _id_EnFrame_Explosion0_{AREA}, $F7, _id_EnFrame_Explosion1_{AREA}, $F7, $FF

EnAnim_Rio_{AREA}:
    .byte _id_EnFrame_Rio0_{AREA}, _id_EnFrame_Rio1_{AREA}, $FF

EnAnim_RioExplode_{AREA}:
    .byte _id_EnFrame_RioExplode_{AREA}, $FF

EnAnim_Zeb_L_{AREA}:
    .byte _id_EnFrame_Zeb0_L_{AREA}, _id_EnFrame_Zeb1_L_{AREA}, $FF

EnAnim_Zeb_R_{AREA}:
    .byte _id_EnFrame_Zeb0_R_{AREA}, _id_EnFrame_Zeb1_R_{AREA}, $FF

EnAnim_ZebExplode_L_{AREA}:
    .byte _id_EnFrame_ZebExplode_L_{AREA}, $FF

EnAnim_ZebExplode_R_{AREA}:
    .byte _id_EnFrame_ZebExplode_R_{AREA}, $FF

EnAnim_ZebResting_L_{AREA}:
    .byte _id_EnFrame_Zeb0_L_{AREA}, $FF

EnAnim_ZebResting_R_{AREA}:
    .byte _id_EnFrame_Zeb0_R_{AREA}, $FF

EnAnim_KraidLint_R_{AREA}:
    .byte _id_EnFrame_KraidLint_R_{AREA}, $FF

EnAnim_KraidLint_L_{AREA}:
    .byte _id_EnFrame_KraidLint_L_{AREA}, $FF

EnAnim_KraidNailMoving_R_{AREA}:
    .byte _id_EnFrame_KraidNail1_R_{AREA}, _id_EnFrame_KraidNail2_R_{AREA}, _id_EnFrame_KraidNail3_R_{AREA}
EnAnim_KraidNailIdle_R_{AREA}:
    .byte _id_EnFrame_KraidNail0_R_{AREA}, $FF

EnAnim_KraidNailMoving_L_{AREA}:
    .byte _id_EnFrame_KraidNail1_L_{AREA}, _id_EnFrame_KraidNail2_L_{AREA}, _id_EnFrame_KraidNail3_L_{AREA}
EnAnim_KraidNailIdle_L_{AREA}:
    .byte _id_EnFrame_KraidNail0_L_{AREA}, $FF

EnAnim_Mellow_{AREA}:
    .byte _id_EnFrame_Mellow0_{AREA}, _id_EnFrame_Mellow1_{AREA}, $FF

EnAnim_Kraid_R_{AREA}:
    .byte _id_EnFrame_Kraid0_R_{AREA}, _id_EnFrame_Kraid1_R_{AREA}, $FF

EnAnim_Kraid_L_{AREA}:
    .byte _id_EnFrame_Kraid0_L_{AREA}, _id_EnFrame_Kraid1_L_{AREA}, $FF

EnAnim_KraidExplode_R_{AREA}:
    .byte _id_EnFrame_KraidExplode_R_{AREA}, $FF

EnAnim_KraidExplode_L_{AREA}:
    .byte _id_EnFrame_KraidExplode_L_{AREA}, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}:
    PtrTableEntry EnFramePtrTable1, EnFrame00_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame01_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame05_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame06_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame07_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame08_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame09_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame0F_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame10_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame11_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame12_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame13_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame14_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame15_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame16_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame17_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame18_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorHopping_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingHopping_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Ripper_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Ripper_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame25_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame26_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree2_{AREA}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplode_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplode_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplode_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplode_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_SkreeExplode_{AREA}
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_RioExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplode_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Zeb1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplode_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLint_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLint_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail2_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail3_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail2_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNail3_L_{AREA}
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
EnFramePtrTable2_{AREA}:
    PtrTableEntryArea EnFramePtrTable1, EnFrame_MissilePickup
    PtrTableEntryArea EnFramePtrTable1, EnFrame_SmallEnergyPickup
    PtrTableEntry EnFramePtrTable1, EnFrame82_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame83_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame84_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame85_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame86_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame87_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame88_{AREA}
    PtrTableEntryArea EnFramePtrTable1, EnFrame_BigEnergyPickup
    PtrTableEntry EnFramePtrTable1, EnFrame8A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_L_{AREA}

EnPlacePtrTable_{AREA}:
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

;Miniboss
EnPlace2_{AREA}:
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3_{AREA}:
EnPlace4_{AREA}:
EnPlace5_{AREA}:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6_{AREA}:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7_{AREA}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8_{AREA}:
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9_{AREA}:
EnPlaceA_{AREA}:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_{AREA}:
EnPlaceD_{AREA}:
EnPlaceE_{AREA}:
EnPlaceF_{AREA}:
    .byte $FC, $F8, $FC, $00

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

EnFrame_Waver2_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame_Waver2_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame05_{AREA}:
EnFrame06_{AREA}:
EnFrame07_{AREA}:
EnFrame08_{AREA}:
EnFrame09_{AREA}:
EnFrame0A_{AREA}:
EnFrame0B_{AREA}:
EnFrame0C_{AREA}:
EnFrame0D_{AREA}:
EnFrame0E_{AREA}:
EnFrame0F_{AREA}:
EnFrame10_{AREA}:
EnFrame11_{AREA}:
EnFrame12_{AREA}:
EnFrame13_{AREA}:
EnFrame14_{AREA}:
EnFrame15_{AREA}:
EnFrame16_{AREA}:
EnFrame17_{AREA}:
EnFrame18_{AREA}:
EnFrame_SidehopperFloorIdle0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperFloorIdle1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperFloorHopping_{AREA}:
    .byte ($2 << 4) + _id_EnPlace6_{AREA}, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

EnFrame_SidehopperCeilingIdle0_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperCeilingIdle1_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperCeilingHopping_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace6_{AREA}, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

;Ripper facing right.
EnFrame_Ripper_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper facing left.
EnFrame_Ripper_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Skree.
EnFrame25_{AREA}:
EnFrame26_{AREA}:
EnFrame_Skree0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $FC, $00, $FC
    .byte $DE
    .byte $EE
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EE
    .byte $FF

;Skree.
EnFrame_Skree1_{AREA}:
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

;Skree.
EnFrame_Skree2_{AREA}:
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

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
EnFrame_SidehopperFloorExplode_{AREA}:
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

EnFrame_SidehopperCeilingExplode_{AREA}:
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

EnFrame_WaverExplode_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame_WaverExplode_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper explode facing left (uses waver gfx).
EnFrame_RipperExplode_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

;Ripper explode facing right (uses waver gfx).
EnFrame_RipperExplode_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

;Skree explode.
EnFrame_SkreeExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zoomer on floor.
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
EnFrame_ZoomerOnFloor0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on floor.
EnFrame_ZoomerOnFloor1_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall0_{AREA}:
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall1_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling0_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling1_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall0_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall1_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer explode.
EnFrame_ZoomerExplode_{AREA}:
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

;Rio.
EnFrame_Rio0_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceB_{AREA}, $08, $08
    .byte $E2
    .byte $E3
    .byte $E4
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E3
    .byte $E4
    .byte $FF

;Rio.
EnFrame_Rio1_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceB_{AREA}, $08, $08
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
EnFrame_RioExplode_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $96
    .byte $96
    .byte $98
    .byte $98
    .byte $FF

;Zeb facing left.
EnFrame_Zeb0_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing left.
EnFrame_Zeb1_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing left.
EnFrame_ZebExplode_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb facing right.
EnFrame_Zeb0_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing right.
EnFrame_Zeb1_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing right.
EnFrame_ZebExplode_R_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_KraidLint_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidLint_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidNail0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_R_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_R_{AREA}:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_L_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_L_{AREA}:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

;Missile pickup.
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
    .byte ($0 << 4) + _id_EnPlace6_{AREA}, $08, $04
    .byte $FE
    .byte $FE
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

;Mellow.
EnFrame8A_{AREA}:
EnFrame8B_{AREA}:
EnFrame8C_{AREA}:
EnFrame8D_{AREA}:
EnFrame8E_{AREA}:
EnFrame_Mellow0_{AREA}:
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

;Mellow.
EnFrame_Mellow1_{AREA}:
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame_Kraid0_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $10, $0C
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

EnFrame_Kraid1_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace2_{AREA}, $10, $0C
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

EnFrame_Kraid0_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $10, $0C
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

EnFrame_Kraid1_L_{AREA}:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2_{AREA}, $10, $0C
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

EnFrame_KraidExplode_R_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame_KraidExplode_L_{AREA}:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
