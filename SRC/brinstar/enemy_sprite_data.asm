;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ; 01:9D6A
EnAnim_00_{AREA}: ; 01:9D6A
    .byte _id_EnFrame00_{AREA}
    .byte _id_EnFrame01_{AREA}
    .byte _id_FrameEnd

EnAnim_EnProjectileKilled_{AREA}: ; 01:9D6D
    .byte _id_EnFrame_EnProjectileKilled_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorIdle_{AREA}: ; 01:9D6F
    .byte _id_EnFrame_SidehopperFloorIdle0_{AREA}
    .byte _id_EnFrame_SidehopperFloorIdle1_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorStartHopping_{AREA}: ; 01:9D72
    .byte _id_EnFrame_SidehopperFloorIdle1_{AREA}
EnAnim_SidehopperFloorHopping_{AREA}: ; 01:9D73
    .byte _id_EnFrame_SidehopperFloorHopping_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingIdle_{AREA}: ; 01:9D75
    .byte _id_EnFrame_SidehopperCeilingIdle0_{AREA}
    .byte _id_EnFrame_SidehopperCeilingIdle1_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingStartHopping_{AREA}: ; 01:9D78
    .byte _id_EnFrame_SidehopperCeilingIdle1_{AREA}
EnAnim_SidehopperCeilingHopping_{AREA}: ; 01:9D79
    .byte _id_EnFrame_SidehopperCeilingHopping_{AREA}
    .byte _id_FrameEnd

EnAnim_11_{AREA}: ; 01:9D7B
    .byte _id_EnFrame_Ripper_L_{AREA}
    .byte _id_EnFrame_Waver1_L_{AREA}
EnAnim_Waver0_L_{AREA}: ; 01:9D7D
    .byte _id_EnFrame_Waver0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_15_{AREA}: ; 01:9D7F
    .byte _id_EnFrame_Ripper_R_{AREA}
    .byte _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver0_R_{AREA}: ; 01:9D81
    .byte _id_EnFrame_Waver0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Ripper_L_{AREA}: ; 01:9D83
    .byte _id_EnFrame_Ripper_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Ripper_R_{AREA}: ; 01:9D85
    .byte _id_EnFrame_Ripper_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Waver1_L_{AREA}: ; 01:9D87
    .byte _id_EnFrame_Waver1_L_{AREA},
EnAnim_Waver2_L_{AREA}: ; 01:9D88
    .byte _id_EnFrame_Waver2_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Waver1_R_{AREA}: ; 01:9D8A
    .byte _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver2_R_{AREA}: ; 01:9D8B
    .byte _id_EnFrame_Waver2_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Skree_{AREA}: ; 01:9D8D
    .byte _id_EnFrame_Skree0_{AREA}
    .byte _id_EnFrame_Skree1_{AREA}
    .byte _id_EnFrame_Skree2_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorExplode_{AREA}: ; 01:9D91
    .byte _id_EnFrame_SidehopperFloorExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingExplode_{AREA}: ; 01:9D93
    .byte _id_EnFrame_SidehopperCeilingExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_WaverExplode_L_{AREA}: ; 01:9D95
    .byte _id_EnFrame_WaverExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_WaverExplode_R_{AREA}: ; 01:9D97
    .byte _id_EnFrame_WaverExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_RipperExplode_L_{AREA}: ; 01:9D99
    .byte _id_EnFrame_RipperExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_RipperExplode_R_{AREA}: ; 01:9D9B
    .byte _id_EnFrame_RipperExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_SkreeExplode_{AREA}: ; 01:9D9D
    .byte _id_EnFrame_SkreeExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_ZoomerOnFloor_{AREA}: ; 01:9D9F
    .byte _id_EnFrame_ZoomerOnFloor0_{AREA}
    .byte _id_EnFrame_ZoomerOnFloor1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZoomerOnRightWall_{AREA}: ; 01:9DA2
    .byte _id_EnFrame_ZoomerOnRightWall0_{AREA}
    .byte _id_EnFrame_ZoomerOnRightWall1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZoomerOnCeiling_{AREA}: ; 01:9DA5
    .byte _id_EnFrame_ZoomerOnCeiling0_{AREA}
    .byte _id_EnFrame_ZoomerOnCeiling1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZoomerOnLeftWall_{AREA}: ; 01:9DA8
    .byte _id_EnFrame_ZoomerOnLeftWall0_{AREA}
    .byte _id_EnFrame_ZoomerOnLeftWall1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZoomerExplode_{AREA}: ; 01:9DAB
    .byte _id_EnFrame_ZoomerExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_Explosion_{AREA}: ; 01:9DAD
    .byte _id_EnFrame_Explosion0_{AREA}
    .byte _id_FrameNone
    .byte _id_EnFrame_Explosion1_{AREA}
    .byte _id_FrameNone
    .byte _id_FrameEnd

EnAnim_Rio_{AREA}: ; 01:9DB2
    .byte _id_EnFrame_Rio0_{AREA}
    .byte _id_EnFrame_Rio1_{AREA}
    .byte _id_FrameEnd

EnAnim_RioExplode_{AREA}: ; 01:9DB5
    .byte _id_EnFrame_RioExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_Zeb_L_{AREA}: ; 01:9DB7
    .byte _id_EnFrame_Zeb0_L_{AREA}
    .byte _id_EnFrame_Zeb1_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Zeb_R_{AREA}: ; 01:9DBA
    .byte _id_EnFrame_Zeb0_R_{AREA}
    .byte _id_EnFrame_Zeb1_R_{AREA}
    .byte _id_FrameEnd

EnAnim_ZebExplode_L_{AREA}: ; 01:9DBD
    .byte _id_EnFrame_ZebExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_ZebExplode_R_{AREA}: ; 01:9DBF
    .byte _id_EnFrame_ZebExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_ZebResting_L_{AREA}: ; 01:9DC1
    .byte _id_EnFrame_Zeb0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_ZebResting_R_{AREA}: ; 01:9DC3
    .byte _id_EnFrame_Zeb0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidLint_R_{AREA}: ; 01:9DC5
    .byte _id_EnFrame_KraidLint_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidLint_L_{AREA}: ; 01:9DC7
    .byte _id_EnFrame_KraidLint_L_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidNailMoving_R_{AREA}: ; 01:9DC9
    .byte _id_EnFrame_KraidNail1_R_{AREA}
    .byte _id_EnFrame_KraidNail2_R_{AREA}
    .byte _id_EnFrame_KraidNail3_R_{AREA}
EnAnim_KraidNailIdle_R_{AREA}: ; 01:9DCC
    .byte _id_EnFrame_KraidNail0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidNailMoving_L_{AREA}: ; 01:9DCE
    .byte _id_EnFrame_KraidNail1_L_{AREA}
    .byte _id_EnFrame_KraidNail2_L_{AREA}
    .byte _id_EnFrame_KraidNail3_L_{AREA}
EnAnim_KraidNailIdle_L_{AREA}: ; 01:9DD1
    .byte _id_EnFrame_KraidNail0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Mellow_{AREA}: ; 01:9DD3
    .byte _id_EnFrame_Mellow0_{AREA}
    .byte _id_EnFrame_Mellow1_{AREA}
    .byte _id_FrameEnd

EnAnim_Kraid_R_{AREA}: ; 01:9DD6
    .byte _id_EnFrame_Kraid0_R_{AREA}
    .byte _id_EnFrame_Kraid1_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Kraid_L_{AREA}: ; 01:9DD9
    .byte _id_EnFrame_Kraid0_L_{AREA}
    .byte _id_EnFrame_Kraid1_L_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidExplode_R_{AREA}: ; 01:9DDC
    .byte _id_EnFrame_KraidExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidExplode_L_{AREA}: ; 01:9DDE
    .byte _id_EnFrame_KraidExplode_L_{AREA}
    .byte _id_FrameEnd

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}: ; 01:9DE0
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
EnFramePtrTable2_{AREA}: ; 01:9EE0
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

EnPlacePtrTable_{AREA}: ; 01:9F0E
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
EnPlace0_{AREA}: ; 01:9F2E
    .byte $FC, $FC

;Enemy explode.
EnPlace1_{AREA}: ; 01:9F30
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2_{AREA}: ; 01:9F48
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3_{AREA}: ; 01:9F60
EnPlace4_{AREA}: ; 01:9F60
EnPlace5_{AREA}: ; 01:9F60
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6_{AREA}: ; 01:9F70
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7_{AREA}: ; 01:9F7C
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8_{AREA}: ; 01:9F84
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9_{AREA}: ; 01:9F90
EnPlaceA_{AREA}: ; 01:9F90
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}: ; 01:9FB0
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_{AREA}: ; 01:9FBE
EnPlaceD_{AREA}: ; 01:9FBE
EnPlaceE_{AREA}: ; 01:9FBE
EnPlaceF_{AREA}: ; 01:9FBE
    .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

;Unused.
EnFrame00_{AREA}: ; 01:9FC2
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_{AREA}: ; 01:9FC7
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

;EnProjectile killed.
EnFrame_EnProjectileKilled_{AREA}: ; 01:9FCC
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Waver2_R_{AREA}: ; 01:9FD1
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame_Waver2_L_{AREA}: ; 01:9FDA
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame05_{AREA}: ; 01:9FE3
EnFrame06_{AREA}: ; 01:9FE3
EnFrame07_{AREA}: ; 01:9FE3
EnFrame08_{AREA}: ; 01:9FE3
EnFrame09_{AREA}: ; 01:9FE3
EnFrame0A_{AREA}: ; 01:9FE3
EnFrame0B_{AREA}: ; 01:9FE3
EnFrame0C_{AREA}: ; 01:9FE3
EnFrame0D_{AREA}: ; 01:9FE3
EnFrame0E_{AREA}: ; 01:9FE3
EnFrame0F_{AREA}: ; 01:9FE3
EnFrame10_{AREA}: ; 01:9FE3
EnFrame11_{AREA}: ; 01:9FE3
EnFrame12_{AREA}: ; 01:9FE3
EnFrame13_{AREA}: ; 01:9FE3
EnFrame14_{AREA}: ; 01:9FE3
EnFrame15_{AREA}: ; 01:9FE3
EnFrame16_{AREA}: ; 01:9FE3
EnFrame17_{AREA}: ; 01:9FE3
EnFrame18_{AREA}: ; 01:9FE3
EnFrame_SidehopperFloorIdle0_{AREA}: ; 01:9FE3
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

EnFrame_SidehopperFloorIdle1_{AREA}: ; 01:9FF1
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

EnFrame_SidehopperFloorHopping_{AREA}: ; 01:9FFF
    .byte ($2 << 4) + _id_EnPlace6_{AREA}, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

EnFrame_SidehopperCeilingIdle0_{AREA}: ; 01:A00B
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

EnFrame_SidehopperCeilingIdle1_{AREA}: ; 01:A019
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

EnFrame_SidehopperCeilingHopping_{AREA}: ; 01:A027
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
EnFrame_Ripper_R_{AREA}: ; 01:A033
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_R_{AREA}: ; 01:A03C
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_R_{AREA}: ; 01:A046
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper facing left.
EnFrame_Ripper_L_{AREA}: ; 01:A050
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_L_{AREA}: ; 01:A059
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_L_{AREA}: ; 01:A063
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Skree.
EnFrame25_{AREA}: ; 01:A06D
EnFrame26_{AREA}: ; 01:A06D
EnFrame_Skree0_{AREA}: ; 01:A06D
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
EnFrame_Skree1_{AREA}: ; 01:A07B
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

;Skree.
EnFrame_Skree2_{AREA}: ; 01:A082
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

EnFrame2A_{AREA}: ; 01:A08B
EnFrame2B_{AREA}: ; 01:A08B
EnFrame2C_{AREA}: ; 01:A08B
EnFrame2D_{AREA}: ; 01:A08B
EnFrame2E_{AREA}: ; 01:A08B
EnFrame2F_{AREA}: ; 01:A08B
EnFrame30_{AREA}: ; 01:A08B
EnFrame31_{AREA}: ; 01:A08B
EnFrame32_{AREA}: ; 01:A08B
EnFrame33_{AREA}: ; 01:A08B
EnFrame34_{AREA}: ; 01:A08B
EnFrame35_{AREA}: ; 01:A08B
EnFrame36_{AREA}: ; 01:A08B
EnFrame_SidehopperFloorExplode_{AREA}: ; 01:A08B
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

EnFrame_SidehopperCeilingExplode_{AREA}: ; 01:A09F
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

EnFrame_WaverExplode_L_{AREA}: ; 01:A0B3
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame_WaverExplode_R_{AREA}: ; 01:A0BE
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper explode facing left (uses waver gfx).
EnFrame_RipperExplode_L_{AREA}: ; 01:A0C9
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

;Ripper explode facing right (uses waver gfx).
EnFrame_RipperExplode_R_{AREA}: ; 01:A0D2
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

;Skree explode.
EnFrame_SkreeExplode_{AREA}: ; 01:A0DB
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zoomer on floor.
EnFrame3E_{AREA}: ; 01:A0E6
EnFrame3F_{AREA}: ; 01:A0E6
EnFrame40_{AREA}: ; 01:A0E6
EnFrame41_{AREA}: ; 01:A0E6
EnFrame42_{AREA}: ; 01:A0E6
EnFrame43_{AREA}: ; 01:A0E6
EnFrame44_{AREA}: ; 01:A0E6
EnFrame45_{AREA}: ; 01:A0E6
EnFrame46_{AREA}: ; 01:A0E6
EnFrame47_{AREA}: ; 01:A0E6
EnFrame48_{AREA}: ; 01:A0E6
EnFrame49_{AREA}: ; 01:A0E6
EnFrame4A_{AREA}: ; 01:A0E6
EnFrame4B_{AREA}: ; 01:A0E6
EnFrame4C_{AREA}: ; 01:A0E6
EnFrame4D_{AREA}: ; 01:A0E6
EnFrame4E_{AREA}: ; 01:A0E6
EnFrame4F_{AREA}: ; 01:A0E6
EnFrame50_{AREA}: ; 01:A0E6
EnFrame51_{AREA}: ; 01:A0E6
EnFrame52_{AREA}: ; 01:A0E6
EnFrame53_{AREA}: ; 01:A0E6
EnFrame54_{AREA}: ; 01:A0E6
EnFrame55_{AREA}: ; 01:A0E6
EnFrame56_{AREA}: ; 01:A0E6
EnFrame57_{AREA}: ; 01:A0E6
EnFrame_ZoomerOnFloor0_{AREA}: ; 01:A0E6
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on floor.
EnFrame_ZoomerOnFloor1_{AREA}: ; 01:A0EE
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall0_{AREA}: ; 01:A0F6
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall1_{AREA}: ; 01:A0FE
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling0_{AREA}: ; 01:A106
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling1_{AREA}: ; 01:A10E
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall0_{AREA}: ; 01:A116
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall1_{AREA}: ; 01:A11E
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer explode.
EnFrame_ZoomerExplode_{AREA}: ; 01:A126
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Explosion.
EnFrame_Explosion0_{AREA}: ; 01:A12E
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
EnFrame_Explosion1_{AREA}: ; 01:A13C
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
EnFrame_Rio0_{AREA}: ; 01:A156
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
EnFrame_Rio1_{AREA}: ; 01:A162
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
EnFrame_RioExplode_{AREA}: ; 01:A16F
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $96
    .byte $96
    .byte $98
    .byte $98
    .byte $FF

;Zeb facing left.
EnFrame_Zeb0_L_{AREA}: ; 01:A177
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing left.
EnFrame_Zeb1_L_{AREA}: ; 01:A17F
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing left.
EnFrame_ZebExplode_L_{AREA}: ; 01:A187
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb facing right.
EnFrame_Zeb0_R_{AREA}: ; 01:A18F
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing right.
EnFrame_Zeb1_R_{AREA}: ; 01:A197
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing right.
EnFrame_ZebExplode_R_{AREA}: ; 01:A19F
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_KraidLint_R_{AREA}: ; 01:A1A7
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidLint_L_{AREA}: ; 01:A1AF
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidNail0_R_{AREA}: ; 01:A1B7
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_R_{AREA}: ; 01:A1BF
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_R_{AREA}: ; 01:A1C7
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_R_{AREA}: ; 01:A1CF
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail0_L_{AREA}: ; 01:A1D7
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_L_{AREA}: ; 01:A1DF
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_L_{AREA}: ; 01:A1E7
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_L_{AREA}: ; 01:A1EF
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

;Missile pickup.
EnFrame76_{AREA}: ; 01:A1F7
EnFrame77_{AREA}: ; 01:A1F7
EnFrame78_{AREA}: ; 01:A1F7
EnFrame79_{AREA}: ; 01:A1F7
EnFrame7A_{AREA}: ; 01:A1F7
EnFrame7B_{AREA}: ; 01:A1F7
EnFrame7C_{AREA}: ; 01:A1F7
EnFrame7D_{AREA}: ; 01:A1F7
EnFrame7E_{AREA}: ; 01:A1F7
EnFrame7F_{AREA}: ; 01:A1F7
EnFrame_MissilePickup_{AREA}: ; 01:A1F7
    .byte ($0 << 4) + _id_EnPlace6_{AREA}, $08, $04
    .byte $FE
    .byte $FE
    .byte $14
    .byte $24
    .byte $FF

;Small energy pickup.
EnFrame_SmallEnergyPickup_{AREA}: ; 01:A1FF
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Big energy pickup.
EnFrame82_{AREA}: ; 01:A204
EnFrame83_{AREA}: ; 01:A204
EnFrame84_{AREA}: ; 01:A204
EnFrame85_{AREA}: ; 01:A204
EnFrame86_{AREA}: ; 01:A204
EnFrame87_{AREA}: ; 01:A204
EnFrame88_{AREA}: ; 01:A204
EnFrame_BigEnergyPickup_{AREA}: ; 01:A204
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Mellow.
EnFrame8A_{AREA}: ; 01:A209
EnFrame8B_{AREA}: ; 01:A209
EnFrame8C_{AREA}: ; 01:A209
EnFrame8D_{AREA}: ; 01:A209
EnFrame8E_{AREA}: ; 01:A209
EnFrame_Mellow0_{AREA}: ; 01:A209
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

;Mellow.
EnFrame_Mellow1_{AREA}: ; 01:A213
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame_Kraid0_R_{AREA}: ; 01:A21D
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

EnFrame_Kraid1_R_{AREA}: ; 01:A22D
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

EnFrame_Kraid0_L_{AREA}: ; 01:A23D
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

EnFrame_Kraid1_L_{AREA}: ; 01:A24D
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

EnFrame_KraidExplode_R_{AREA}: ; 01:A25D
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame_KraidExplode_L_{AREA}: ; 01:A267
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
