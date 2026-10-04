;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable_{AREA}: ; 04:9C86
EnAnim_00_{AREA}: ; 04:9C86
    .byte _id_EnFrame00_{AREA}
    .byte _id_EnFrame01_{AREA}
    .byte _id_FrameEnd

EnAnim_EnProjectileKilled_{AREA}: ; 04:9C89
    .byte _id_EnFrame_EnProjectileKilled_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorIdle_{AREA}: ; 04:9C8B
    .byte _id_EnFrame_SidehopperFloorIdle0_{AREA}
    .byte _id_EnFrame_SidehopperFloorIdle1_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorStartHopping_{AREA}: ; 04:9C8E
    .byte _id_EnFrame_SidehopperFloorIdle1_{AREA}
EnAnim_SidehopperFloorHopping_{AREA}: ; 04:9C8F
    .byte _id_EnFrame_SidehopperFloorHopping_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingIdle_{AREA}: ; 04:9C91
    .byte _id_EnFrame_SidehopperCeilingIdle0_{AREA}
    .byte _id_EnFrame_SidehopperCeilingIdle1_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingStartHopping_{AREA}: ; 04:9C94
    .byte _id_EnFrame_SidehopperCeilingIdle1_{AREA}
EnAnim_SidehopperCeilingHopping_{AREA}: ; 04:9C95
    .byte _id_EnFrame_SidehopperCeilingHopping_{AREA}
    .byte _id_FrameEnd

EnAnim_11_{AREA}: ; 04:9C97
    .byte _id_EnFrame_Ripper_L_{AREA}
    .byte _id_EnFrame_Waver1_L_{AREA}
EnAnim_Waver0_L_{AREA}: ; 04:9C99
    .byte _id_EnFrame_Waver0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_15_{AREA}: ; 04:9C9B
    .byte _id_EnFrame_Ripper_R_{AREA}
    .byte _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver0_R_{AREA}: ; 04:9C9D
    .byte _id_EnFrame_Waver0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Ripper_L_{AREA}: ; 04:9C9F
    .byte _id_EnFrame_Ripper_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Ripper_R_{AREA}: ; 04:9CA1
    .byte _id_EnFrame_Ripper_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Waver1_L_{AREA}: ; 04:9CA3
    .byte _id_EnFrame_Waver1_L_{AREA}
EnAnim_Waver2_L_{AREA}: ; 04:9CA4
    .byte _id_EnFrame_Waver2_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Waver1_R_{AREA}: ; 04:9CA6
    .byte _id_EnFrame_Waver1_R_{AREA}
EnAnim_Waver2_R_{AREA}: ; 04:9CA7
    .byte _id_EnFrame_Waver2_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Skree_{AREA}: ; 04:9CA9
    .byte _id_EnFrame_Skree0_{AREA}
    .byte _id_EnFrame_Skree1_{AREA}
    .byte _id_EnFrame_Skree2_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperFloorExplode_{AREA}: ; 04:9CAD
    .byte _id_EnFrame_SidehopperFloorExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_SidehopperCeilingExplode_{AREA}: ; 04:9CAF
    .byte _id_EnFrame_SidehopperCeilingExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_WaverExplode_L_{AREA}: ; 04:9CB1
    .byte _id_EnFrame_WaverExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_WaverExplode_R_{AREA}: ; 04:9CB3
    .byte _id_EnFrame_WaverExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_RipperExplode_L_{AREA}: ; 04:9CB5
    .byte _id_EnFrame_RipperExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_RipperExplode_R_{AREA}: ; 04:9CB7
    .byte _id_EnFrame_RipperExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_SkreeExplode_{AREA}: ; 04:9CB9
    .byte _id_EnFrame_SkreeExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_ZeelaOnFloor_{AREA}: ; 04:9CBB
    .byte _id_EnFrame_ZeelaOnFloor0_{AREA}
    .byte _id_EnFrame_ZeelaOnFloor1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZeelaOnRightWall_{AREA}: ; 04:9CBE
    .byte _id_EnFrame_ZeelaOnRightWall0_{AREA}
    .byte _id_EnFrame_ZeelaOnRightWall1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZeelaOnCeiling_{AREA}: ; 04:9CC1
    .byte _id_EnFrame_ZeelaOnCeiling0_{AREA}
    .byte _id_EnFrame_ZeelaOnCeiling1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZeelaOnLeftWall_{AREA}: ; 04:9CC4
    .byte _id_EnFrame_ZeelaOnLeftWall0_{AREA}
    .byte _id_EnFrame_ZeelaOnLeftWall1_{AREA}
    .byte _id_FrameEnd

EnAnim_ZeelaExplode_{AREA}: ; 04:9CC7
    .byte _id_EnFrame_ZeelaExplode_{AREA}
    .byte _id_FrameEnd

EnAnim_Explosion_{AREA}: ; 04:9CC9
    .byte _id_EnFrame_Explosion0_{AREA}
    .byte _id_FrameNone
    .byte _id_EnFrame_Explosion1_{AREA}
    .byte _id_FrameNone
    .byte _id_FrameEnd

EnAnim_Geega_L_{AREA}: ; 04:9CCE
    .byte _id_EnFrame_Geega0_L_{AREA}
    .byte _id_EnFrame_Geega1_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Geega_R_{AREA}: ; 04:9CD1
    .byte _id_EnFrame_Geega0_R_{AREA}
    .byte _id_EnFrame_Geega1_R_{AREA}
    .byte _id_FrameEnd

EnAnim_GeegaExplode_L_{AREA}: ; 04:9CD4
    .byte _id_EnFrame_GeegaExplode_L_{AREA}
    .byte _id_FrameEnd

EnAnim_GeegaExplode_R_{AREA}: ; 04:9CD6
    .byte _id_EnFrame_GeegaExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_GeegaResting_L_{AREA}: ; 04:9CD8
    .byte _id_EnFrame_Geega0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_GeegaResting_R_{AREA}: ; 04:9CDA
    .byte _id_EnFrame_Geega0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidLint_R_{AREA}: ; 04:9CDC
    .byte _id_EnFrame_KraidLint_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidLint_L_{AREA}: ; 04:9CDE
    .byte _id_EnFrame_KraidLint_L_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidNailMoving_R_{AREA}: ; 04:9CE0
    .byte _id_EnFrame_KraidNail1_R_{AREA}
    .byte _id_EnFrame_KraidNail2_R_{AREA}
    .byte _id_EnFrame_KraidNail3_R_{AREA}
EnAnim_KraidNailIdle_R_{AREA}: ; 04:9CE3
    .byte _id_EnFrame_KraidNail0_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidNailMoving_L_{AREA}: ; 04:9CE5
    .byte _id_EnFrame_KraidNail1_L_{AREA}
    .byte _id_EnFrame_KraidNail2_L_{AREA}
    .byte _id_EnFrame_KraidNail3_L_{AREA}
EnAnim_KraidNailIdle_L_{AREA}: ; 04:9CE8
    .byte _id_EnFrame_KraidNail0_L_{AREA}
    .byte _id_FrameEnd

EnAnim_Memu_{AREA}: ; 04:9CEA
    .byte _id_EnFrame_Memu0_{AREA}
    .byte _id_EnFrame_Memu1_{AREA}
    .byte _id_FrameEnd

EnAnim_Kraid_R_{AREA}: ; 04:9CED
    .byte _id_EnFrame_Kraid0_R_{AREA}
    .byte _id_EnFrame_Kraid1_R_{AREA}
    .byte _id_FrameEnd

EnAnim_Kraid_L_{AREA}: ; 04:9CF0
    .byte _id_EnFrame_Kraid0_L_{AREA}
    .byte _id_EnFrame_Kraid1_L_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidExplode_R_{AREA}: ; 04:9CF3
    .byte _id_EnFrame_KraidExplode_R_{AREA}
    .byte _id_FrameEnd

EnAnim_KraidExplode_L_{AREA}: ; 04:9CF5
    .byte _id_EnFrame_KraidExplode_L_{AREA}
    .byte _id_FrameEnd

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1_{AREA}: ; 04:9CF7
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnFloor0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnFloor1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnRightWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnRightWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnCeiling0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnCeiling1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnLeftWall0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaOnLeftWall1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_ZeelaExplode_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame63_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame64_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame65_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Geega0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Geega1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GeegaExplode_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Geega0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Geega1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_GeegaExplode_R_{AREA}
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
EnFramePtrTable2_{AREA}: ; 04:9DF7
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
    PtrTableEntry EnFramePtrTable1, EnFrame8A_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8B_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8C_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8D_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame8E_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Memu0_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Memu1_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid0_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_Kraid1_L_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_R_{AREA}
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplode_L_{AREA}

EnPlacePtrTable_{AREA}: ; 04:9E25
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
EnPlace0_{AREA}: ; 04:9E45
    .byte $FC, $FC

;Enemy explode.
EnPlace1_{AREA}: ; 04:9E47
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2_{AREA}: ; 04:9E5F
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3_{AREA}: ; 04:9E77
EnPlace4_{AREA}: ; 04:9E77
EnPlace5_{AREA}: ; 04:9E77
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6_{AREA}: ; 04:9E87
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7_{AREA}: ; 04:9E93
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8_{AREA}: ; 04:9E9B
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9_{AREA}: ; 04:9EA7
EnPlaceA_{AREA}: ; 04:9EA7
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB_{AREA}: ; 04:9EC7
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC_{AREA}: ; 04:9ED5
EnPlaceD_{AREA}: ; 04:9ED5
EnPlaceE_{AREA}: ; 04:9ED5
EnPlaceF_{AREA}: ; 04:9ED5
    .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

EnFrame00_{AREA}: ; 04:9ED9
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01_{AREA}: ; 04:9EDE
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_EnProjectileKilled_{AREA}: ; 04:9EE3
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Waver2_R_{AREA}: ; 04:9EE8
EnFrame_Waver2_L_{AREA}: ; 04:9EE8
EnFrame05_{AREA}: ; 04:9EE8
EnFrame06_{AREA}: ; 04:9EE8
EnFrame07_{AREA}: ; 04:9EE8
EnFrame08_{AREA}: ; 04:9EE8
EnFrame09_{AREA}: ; 04:9EE8
EnFrame0A_{AREA}: ; 04:9EE8
EnFrame0B_{AREA}: ; 04:9EE8
EnFrame0C_{AREA}: ; 04:9EE8
EnFrame0D_{AREA}: ; 04:9EE8
EnFrame0E_{AREA}: ; 04:9EE8
EnFrame0F_{AREA}: ; 04:9EE8
EnFrame10_{AREA}: ; 04:9EE8
EnFrame11_{AREA}: ; 04:9EE8
EnFrame12_{AREA}: ; 04:9EE8
EnFrame13_{AREA}: ; 04:9EE8
EnFrame14_{AREA}: ; 04:9EE8
EnFrame15_{AREA}: ; 04:9EE8
EnFrame16_{AREA}: ; 04:9EE8
EnFrame17_{AREA}: ; 04:9EE8
EnFrame18_{AREA}: ; 04:9EE8
EnFrame_SidehopperFloorIdle0_{AREA}: ; 04:9EE8
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperFloorIdle1_{AREA}: ; 04:9EF6
    .byte ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperFloorHopping_{AREA}: ; 04:9F04
    .byte ($2 << 4) + _id_EnPlace6_{AREA}, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame_SidehopperCeilingIdle0_{AREA}: ; 04:9F10
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperCeilingIdle1_{AREA}: ; 04:9F1E
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5_{AREA}, $08, $0A
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

EnFrame_SidehopperCeilingHopping_{AREA}: ; 04:9F2C
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace6_{AREA}, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame_Ripper_R_{AREA}: ; 04:9F38
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_R_{AREA}: ; 04:9F41
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_R_{AREA}: ; 04:9F4B
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame_Ripper_L_{AREA}: ; 04:9F55
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1_L_{AREA}: ; 04:9F5E
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0_L_{AREA}: ; 04:9F68
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame25_{AREA}: ; 04:9F72
EnFrame26_{AREA}: ; 04:9F72
EnFrame_Skree0_{AREA}: ; 04:9F72
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $FC, $00, $FC
    .byte $DE
    .byte $EE
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EE
    .byte $FF

EnFrame_Skree1_{AREA}: ; 04:9F80
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

EnFrame_Skree2_{AREA}: ; 04:9F87
    .byte ($2 << 4) + _id_EnPlace8_{AREA}, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

EnFrame2A_{AREA}: ; 04:9F90
EnFrame2B_{AREA}: ; 04:9F90
EnFrame2C_{AREA}: ; 04:9F90
EnFrame2D_{AREA}: ; 04:9F90
EnFrame2E_{AREA}: ; 04:9F90
EnFrame2F_{AREA}: ; 04:9F90
EnFrame30_{AREA}: ; 04:9F90
EnFrame31_{AREA}: ; 04:9F90
EnFrame32_{AREA}: ; 04:9F90
EnFrame33_{AREA}: ; 04:9F90
EnFrame34_{AREA}: ; 04:9F90
EnFrame35_{AREA}: ; 04:9F90
EnFrame36_{AREA}: ; 04:9F90
EnFrame_SidehopperFloorExplode_{AREA}: ; 04:9F90
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

EnFrame_SidehopperCeilingExplode_{AREA}: ; 04:9FA4
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

EnFrame_WaverExplode_L_{AREA}: ; 04:9FB8
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame_WaverExplode_R_{AREA}: ; 04:9FC3
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

EnFrame_RipperExplode_L_{AREA}: ; 04:9FCE
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

EnFrame_RipperExplode_R_{AREA}: ; 04:9FD7
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame_SkreeExplode_{AREA}: ; 04:9FE0
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zeela on floor.
EnFrame3E_{AREA}: ; 04:9FEB
EnFrame3F_{AREA}: ; 04:9FEB
EnFrame40_{AREA}: ; 04:9FEB
EnFrame41_{AREA}: ; 04:9FEB
EnFrame42_{AREA}: ; 04:9FEB
EnFrame43_{AREA}: ; 04:9FEB
EnFrame44_{AREA}: ; 04:9FEB
EnFrame45_{AREA}: ; 04:9FEB
EnFrame46_{AREA}: ; 04:9FEB
EnFrame47_{AREA}: ; 04:9FEB
EnFrame48_{AREA}: ; 04:9FEB
EnFrame49_{AREA}: ; 04:9FEB
EnFrame4A_{AREA}: ; 04:9FEB
EnFrame4B_{AREA}: ; 04:9FEB
EnFrame4C_{AREA}: ; 04:9FEB
EnFrame4D_{AREA}: ; 04:9FEB
EnFrame4E_{AREA}: ; 04:9FEB
EnFrame4F_{AREA}: ; 04:9FEB
EnFrame50_{AREA}: ; 04:9FEB
EnFrame51_{AREA}: ; 04:9FEB
EnFrame52_{AREA}: ; 04:9FEB
EnFrame53_{AREA}: ; 04:9FEB
EnFrame54_{AREA}: ; 04:9FEB
EnFrame55_{AREA}: ; 04:9FEB
EnFrame56_{AREA}: ; 04:9FEB
EnFrame57_{AREA}: ; 04:9FEB
EnFrame_ZeelaOnFloor0_{AREA}: ; 04:9FEB
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zeela on floor.
EnFrame_ZeelaOnFloor1_{AREA}: ; 04:9FF3
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zeela on right wall.
EnFrame_ZeelaOnRightWall0_{AREA}: ; 04:9FFB
    .byte ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zeela on right wall.
EnFrame_ZeelaOnRightWall1_{AREA}: ; 04:A003
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zeela on ceiling.
EnFrame_ZeelaOnCeiling0_{AREA}: ; 04:A00B
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zeela on ceiling.
EnFrame_ZeelaOnCeiling1_{AREA}: ; 04:A013
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zeela on left wall.
EnFrame_ZeelaOnLeftWall0_{AREA}: ; 04:A01B
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zeela on left wall.
EnFrame_ZeelaOnLeftWall1_{AREA}: ; 04:A023
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7_{AREA}, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zeela explode.
EnFrame_ZeelaExplode_{AREA}: ; 04:A02B
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_Explosion0_{AREA}: ; 04:A033
    .byte ($0 << 4) + _id_EnPlaceA_{AREA}, $00, $00
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $0
    .byte $75
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $0
    .byte $75
    .byte $FF

EnFrame_Explosion1_{AREA}: ; 04:A041
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

EnFrame63_{AREA}: ; 04:A05B
EnFrame64_{AREA}: ; 04:A05B
EnFrame65_{AREA}: ; 04:A05B
EnFrame_Geega0_L_{AREA}: ; 04:A05B
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Geega1_L_{AREA}: ; 04:A063
    .byte ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_GeegaExplode_L_{AREA}: ; 04:A06B
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_Geega0_R_{AREA}: ; 04:A073
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Geega1_R_{AREA}: ; 04:A07B
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA_{AREA}, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_GeegaExplode_R_{AREA}: ; 04:A083
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_KraidLint_R_{AREA}: ; 04:A08B
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidLint_L_{AREA}: ; 04:A093
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidNail0_R_{AREA}: ; 04:A09B
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_R_{AREA}: ; 04:A0A3
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_R_{AREA}: ; 04:A0AB
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_R_{AREA}: ; 04:A0B3
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail0_L_{AREA}: ; 04:A0BB
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail1_L_{AREA}: ; 04:A0C3
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNail2_L_{AREA}: ; 04:A0CB
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNail3_L_{AREA}: ; 04:A0D3
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame76_{AREA}: ; 04:A0DB
EnFrame77_{AREA}: ; 04:A0DB
EnFrame78_{AREA}: ; 04:A0DB
EnFrame79_{AREA}: ; 04:A0DB
EnFrame7A_{AREA}: ; 04:A0DB
EnFrame7B_{AREA}: ; 04:A0DB
EnFrame7C_{AREA}: ; 04:A0DB
EnFrame7D_{AREA}: ; 04:A0DB
EnFrame7E_{AREA}: ; 04:A0DB
EnFrame7F_{AREA}: ; 04:A0DB
EnFrame_MissilePickup_{AREA}: ; 04:A0DB
    .byte ($0 << 4) + _id_EnPlace6_{AREA}, $08, $04
    .byte $FE
    .byte $FE
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup_{AREA}: ; 04:A0E3
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame82_{AREA}: ; 04:A0E8
EnFrame83_{AREA}: ; 04:A0E8
EnFrame84_{AREA}: ; 04:A0E8
EnFrame85_{AREA}: ; 04:A0E8
EnFrame86_{AREA}: ; 04:A0E8
EnFrame87_{AREA}: ; 04:A0E8
EnFrame88_{AREA}: ; 04:A0E8
EnFrame_BigEnergyPickup_{AREA}: ; 04:A0E8
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

EnFrame8A_{AREA}: ; 04:A0ED
EnFrame8B_{AREA}: ; 04:A0ED
EnFrame8C_{AREA}: ; 04:A0ED
EnFrame8D_{AREA}: ; 04:A0ED
EnFrame8E_{AREA}: ; 04:A0ED
EnFrame_Memu0_{AREA}: ; 04:A0ED
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

EnFrame_Memu1_{AREA}: ; 04:A0F7
    .byte ($3 << 4) + _id_EnPlaceF_{AREA}, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame_Kraid0_R_{AREA}: ; 04:A101
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

EnFrame_Kraid1_R_{AREA}: ; 04:A111
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

EnFrame_Kraid0_L_{AREA}: ; 04:A121
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

EnFrame_Kraid1_L_{AREA}: ; 04:A131
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

EnFrame_KraidExplode_R_{AREA}: ; 04:A141
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame_KraidExplode_L_{AREA}: ; 04:A14B
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
