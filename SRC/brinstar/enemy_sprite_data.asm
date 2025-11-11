;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTbl: ;($9D6A)
EnAnim_00:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_EnProjectileKilled:
    .byte _id_EnFrame_EnProjectileKilled, $FF

EnAnim_SidehopperFloorIdle:
    .byte _id_EnFrame_SidehopperFloorIdle0, _id_EnFrame_SidehopperFloorIdle1, $FF

EnAnim_SidehopperFloorStartHopping:
    .byte _id_EnFrame_SidehopperFloorIdle1
EnAnim_SidehopperFloorHopping:
    .byte _id_EnFrame_SidehopperFloorHopping, $FF

EnAnim_SidehopperCeilingIdle:
    .byte _id_EnFrame_SidehopperCeilingIdle0, _id_EnFrame_SidehopperCeilingIdle1, $FF

EnAnim_SidehopperCeilingStartHopping:
    .byte _id_EnFrame_SidehopperCeilingIdle1
EnAnim_SidehopperCeilingHopping:
    .byte _id_EnFrame_SidehopperCeilingHopping, $FF

EnAnim_11:
    .byte _id_EnFrame_RipperFacingLeft, _id_EnFrame_Waver1FacingLeft
EnAnim_Waver0FacingLeft:
    .byte _id_EnFrame_Waver0FacingLeft, $FF

EnAnim_15:
    .byte _id_EnFrame_RipperFacingRight, _id_EnFrame_Waver1FacingRight
EnAnim_Waver0FacingRight:
    .byte _id_EnFrame_Waver0FacingRight, $FF

EnAnim_RipperFacingLeft:
    .byte _id_EnFrame_RipperFacingLeft, $FF

EnAnim_RipperFacingRight:
    .byte _id_EnFrame_RipperFacingRight, $FF

EnAnim_Waver1FacingLeft:
    .byte _id_EnFrame_Waver1FacingLeft,
EnAnim_Waver2FacingLeft:
    .byte _id_EnFrame_Waver2FacingLeft, $FF

EnAnim_Waver1FacingRight:
    .byte _id_EnFrame_Waver1FacingRight
EnAnim_Waver2FacingRight:
    .byte _id_EnFrame_Waver2FacingRight, $FF

EnAnim_Skree:
    .byte _id_EnFrame_Skree0, _id_EnFrame_Skree1, _id_EnFrame_Skree2, $FF

EnAnim_SidehopperFloorExplode:
    .byte _id_EnFrame_SidehopperFloorExplode, $FF

EnAnim_SidehopperCeilingExplode:
    .byte _id_EnFrame_SidehopperCeilingExplode, $FF

EnAnim_WaverExplodeFacingLeft:
    .byte _id_EnFrame_WaverExplodeFacingLeft, $FF

EnAnim_WaverExplodeFacingRight:
    .byte _id_EnFrame_WaverExplodeFacingRight, $FF

EnAnim_RipperExplodeFacingLeft:
    .byte _id_EnFrame_RipperExplodeFacingLeft, $FF

EnAnim_RipperExplodeFacingRight:
    .byte _id_EnFrame_RipperExplodeFacingRight, $FF

EnAnim_SkreeExplode:
    .byte _id_EnFrame_SkreeExplode, $FF

EnAnim_ZoomerOnFloor:
    .byte _id_EnFrame_ZoomerOnFloor0, _id_EnFrame_ZoomerOnFloor1, $FF

EnAnim_ZoomerOnRightWall:
    .byte _id_EnFrame_ZoomerOnRightWall0, _id_EnFrame_ZoomerOnRightWall1, $FF

EnAnim_ZoomerOnCeiling:
    .byte _id_EnFrame_ZoomerOnCeiling0, _id_EnFrame_ZoomerOnCeiling1, $FF

EnAnim_ZoomerOnLeftWall:
    .byte _id_EnFrame_ZoomerOnLeftWall0, _id_EnFrame_ZoomerOnLeftWall1, $FF

EnAnim_ZoomerExplode:
    .byte _id_EnFrame_ZoomerExplode, $FF

EnAnim_Explosion:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_Rio:
    .byte _id_EnFrame_Rio0, _id_EnFrame_Rio1, $FF

EnAnim_RioExplode:
    .byte _id_EnFrame_RioExplode, $FF

EnAnim_ZebFacingLeft:
    .byte _id_EnFrame_ZebFacingLeft0, _id_EnFrame_ZebFacingLeft1, $FF

EnAnim_ZebFacingRight:
    .byte _id_EnFrame_ZebFacingRight0, _id_EnFrame_ZebFacingRight1, $FF

EnAnim_ZebExplodeFacingLeft:
    .byte _id_EnFrame_ZebExplodeFacingLeft, $FF

EnAnim_ZebExplodeFacingRight:
    .byte _id_EnFrame_ZebExplodeFacingRight, $FF

EnAnim_ZebRestingFacingLeft:
    .byte _id_EnFrame_ZebFacingLeft0, $FF

EnAnim_ZebRestingFacingRight:
    .byte _id_EnFrame_ZebFacingRight0, $FF

EnAnim_KraidLintFacingRight:
    .byte _id_EnFrame_KraidLintFacingRight, $FF

EnAnim_KraidLintFacingLeft:
    .byte _id_EnFrame_KraidLintFacingLeft, $FF

EnAnim_KraidNailMovingFacingRight:
    .byte _id_EnFrame_KraidNailFacingRight1, _id_EnFrame_KraidNailFacingRight2, _id_EnFrame_KraidNailFacingRight3
EnAnim_KraidNailIdleFacingRight:
    .byte _id_EnFrame_KraidNailFacingRight0, $FF

EnAnim_KraidNailMovingFacingLeft:
    .byte _id_EnFrame_KraidNailFacingLeft1, _id_EnFrame_KraidNailFacingLeft2, _id_EnFrame_KraidNailFacingLeft3
EnAnim_KraidNailIdleFacingLeft:
    .byte _id_EnFrame_KraidNailFacingLeft0, $FF

EnAnim_Mellow:
    .byte _id_EnFrame_Mellow0, _id_EnFrame_Mellow1, $FF

EnAnim_KraidFacingRight:
    .byte _id_EnFrame_KraidFacingRight0, _id_EnFrame_KraidFacingRight1, $FF

EnAnim_KraidFacingLeft:
    .byte _id_EnFrame_KraidFacingLeft0, _id_EnFrame_KraidFacingLeft1, $FF

EnAnim_KraidExplodeFacingRight:
    .byte _id_EnFrame_KraidExplodeFacingRight, $FF

EnAnim_KraidExplodeFacingLeft:
    .byte _id_EnFrame_KraidExplodeFacingLeft, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2FacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver2FacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame05
    PtrTableEntry EnFramePtrTable1, EnFrame06
    PtrTableEntry EnFramePtrTable1, EnFrame07
    PtrTableEntry EnFramePtrTable1, EnFrame08
    PtrTableEntry EnFramePtrTable1, EnFrame09
    PtrTableEntry EnFramePtrTable1, EnFrame0A
    PtrTableEntry EnFramePtrTable1, EnFrame0B
    PtrTableEntry EnFramePtrTable1, EnFrame0C
    PtrTableEntry EnFramePtrTable1, EnFrame0D
    PtrTableEntry EnFramePtrTable1, EnFrame0E
    PtrTableEntry EnFramePtrTable1, EnFrame0F
    PtrTableEntry EnFramePtrTable1, EnFrame10
    PtrTableEntry EnFramePtrTable1, EnFrame11
    PtrTableEntry EnFramePtrTable1, EnFrame12
    PtrTableEntry EnFramePtrTable1, EnFrame13
    PtrTableEntry EnFramePtrTable1, EnFrame14
    PtrTableEntry EnFramePtrTable1, EnFrame15
    PtrTableEntry EnFramePtrTable1, EnFrame16
    PtrTableEntry EnFramePtrTable1, EnFrame17
    PtrTableEntry EnFramePtrTable1, EnFrame18
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle0
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorIdle1
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorHopping
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle0
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingIdle1
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingHopping
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1FacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0FacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperFacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver1FacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_Waver0FacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame25
    PtrTableEntry EnFramePtrTable1, EnFrame26
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree0
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree1
    PtrTableEntry EnFramePtrTable1, EnFrame_Skree2
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
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperFloorExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_SidehopperCeilingExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplodeFacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_WaverExplodeFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplodeFacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_RipperExplodeFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_SkreeExplode
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnFloor1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnRightWall1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnCeiling1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerOnLeftWall1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZoomerExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio0
    PtrTableEntry EnFramePtrTable1, EnFrame_Rio1
    PtrTableEntry EnFramePtrTable1, EnFrame_RioExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebFacingLeft0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebFacingLeft1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplodeFacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebFacingRight0
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebFacingRight1
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebExplodeFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLintFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidLintFacingLeft
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingRight0
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingRight1
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingRight2
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingRight3
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingLeft0
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingLeft1
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingLeft2
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidNailFacingLeft3
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
    PtrTableEntry EnFramePtrTable1, EnFrame8A
    PtrTableEntry EnFramePtrTable1, EnFrame8B
    PtrTableEntry EnFramePtrTable1, EnFrame8C
    PtrTableEntry EnFramePtrTable1, EnFrame8D
    PtrTableEntry EnFramePtrTable1, EnFrame8E
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow0
    PtrTableEntry EnFramePtrTable1, EnFrame_Mellow1
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidFacingRight0
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidFacingRight1
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidFacingLeft0
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidFacingLeft1
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplodeFacingRight
    PtrTableEntry EnFramePtrTable1, EnFrame_KraidExplodeFacingLeft

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

;Miniboss
EnPlace2:
    .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
    .byte $00, $04, $08, $F4, $08, $FC, $08, $04

EnPlace3:
EnPlace4:
EnPlace5:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlace6:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

EnPlace7:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

EnPlace8:
    .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC:
EnPlaceD:
EnPlaceE:
EnPlaceF:
    .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

;Unused.
EnFrame00:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

;EnProjectile killed.
EnFrame_EnProjectileKilled:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_Waver2FacingRight:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame_Waver2FacingLeft:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $D0
    .byte $D1
    .byte $FF

EnFrame05:
EnFrame06:
EnFrame07:
EnFrame08:
EnFrame09:
EnFrame0A:
EnFrame0B:
EnFrame0C:
EnFrame0D:
EnFrame0E:
EnFrame0F:
EnFrame10:
EnFrame11:
EnFrame12:
EnFrame13:
EnFrame14:
EnFrame15:
EnFrame16:
EnFrame17:
EnFrame18:
EnFrame_SidehopperFloorIdle0:
    .byte ($2 << 4) + _id_EnPlace5, $08, $0A
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

EnFrame_SidehopperFloorIdle1:
    .byte ($2 << 4) + _id_EnPlace5, $08, $0A
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

EnFrame_SidehopperFloorHopping:
    .byte ($2 << 4) + _id_EnPlace6, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

EnFrame_SidehopperCeilingIdle0:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $0A
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

EnFrame_SidehopperCeilingIdle1:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace5, $08, $0A
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

EnFrame_SidehopperCeilingHopping:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace6, $08, $0A
    .byte $B5
    .byte $B3
    .byte $A4
    .byte $B4
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $B5
    .byte $B3
    .byte $FF

;Ripper facing right.
EnFrame_RipperFacingRight:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1FacingRight:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0FacingRight:
    .byte ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper facing left.
EnFrame_RipperFacingLeft:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $FC, $04, $00
    .byte $C0
    .byte $C1
    .byte $FF

EnFrame_Waver1FacingLeft:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $E0
    .byte $E1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $E0
    .byte $E1
    .byte $FF

EnFrame_Waver0FacingLeft:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $06, $08
    .byte $F0
    .byte $F1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F0
    .byte $F1
    .byte $FF

;Skree.
EnFrame25:
EnFrame26:
EnFrame_Skree0:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $FC, $00, $FC
    .byte $DE
    .byte $EE
    .byte $DF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EE
    .byte $FF

;Skree.
EnFrame_Skree1:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $CF
    .byte $EF
    .byte $FF

;Skree.
EnFrame_Skree2:
    .byte ($2 << 4) + _id_EnPlace8, $0C, $08
    .byte $CE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CF
    .byte $EF
    .byte $FF

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
EnFrame_SidehopperFloorExplode:
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

EnFrame_SidehopperCeilingExplode:
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

EnFrame_WaverExplodeFacingLeft:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $FF

EnFrame_WaverExplodeFacingRight:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $F0
    .byte $F1
    .byte $F0
    .byte $F1
    .byte $FF

;Ripper explode facing left (uses waver gfx).
EnFrame_RipperExplodeFacingLeft:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D1
    .byte $D0
    .byte $FF

;Ripper explode facing right (uses waver gfx).
EnFrame_RipperExplodeFacingRight:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $D0
    .byte $D1
    .byte $FF

;Skree explode.
EnFrame_SkreeExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $08, $00
    .byte $DE
    .byte $DF
    .byte $EE
    .byte $EE
    .byte $FF

;Zoomer on floor.
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
EnFrame_ZoomerOnFloor0:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on floor.
EnFrame_ZoomerOnFloor1:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall0:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on right wall.
EnFrame_ZoomerOnRightWall1:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling0:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on ceiling.
EnFrame_ZoomerOnCeiling1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer on left wall.
EnFrame_ZoomerOnLeftWall1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

;Zoomer explode.
EnFrame_ZoomerExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

;Explosion.
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

;Explosion.
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

;Rio.
EnFrame_Rio0:
    .byte ($2 << 4) + _id_EnPlaceB, $08, $08
    .byte $E2
    .byte $E3
    .byte $E4
    .byte $FE
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E3
    .byte $E4
    .byte $FF

;Rio.
EnFrame_Rio1:
    .byte ($2 << 4) + _id_EnPlaceB, $08, $08
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
EnFrame_RioExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $96
    .byte $96
    .byte $98
    .byte $98
    .byte $FF

;Zeb facing left.
EnFrame_ZebFacingLeft0:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing left.
EnFrame_ZebFacingLeft1:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing left.
EnFrame_ZebExplodeFacingLeft:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb facing right.
EnFrame_ZebFacingRight0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

;Zeb facing right.
EnFrame_ZebFacingRight1:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

;Zeb explode facing right.
EnFrame_ZebExplodeFacingRight:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_KraidLintFacingRight:
    .byte ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidLintFacingLeft:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $04
    .byte $FC, $FF, $00
    .byte $F8
    .byte $FF

EnFrame_KraidNailFacingRight0:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNailFacingRight1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

EnFrame_KraidNailFacingRight2:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNailFacingRight3:
    .byte ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNailFacingLeft0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $FE, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNailFacingLeft1:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $FE
    .byte $D8
    .byte $FF

EnFrame_KraidNailFacingLeft2:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $02, $00
    .byte $D9
    .byte $FF

EnFrame_KraidNailFacingLeft3:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace0, $02, $02
    .byte $FC, $00, $02
    .byte $D8
    .byte $FF

;Missile pickup.
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
    .byte ($0 << 4) + _id_EnPlace6, $08, $04
    .byte $FE
    .byte $FE
    .byte $14
    .byte $24
    .byte $FF

;Small energy pickup.
EnFrame_SmallEnergyPickup:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

;Big energy pickup.
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

;Mellow.
EnFrame8A:
EnFrame8B:
EnFrame8C:
EnFrame8D:
EnFrame8E:
EnFrame_Mellow0:
    .byte ($3 << 4) + _id_EnPlaceF, $04, $08
    .byte $FD, $3
    .byte $EC
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $EC
    .byte $FF

;Mellow.
EnFrame_Mellow1:
    .byte ($3 << 4) + _id_EnPlaceF, $04, $08
    .byte $FD, $3
    .byte $ED
    .byte $FD, OAMDATA_HFLIP + $3
    .byte $ED
    .byte $FF

EnFrame_KraidFacingRight0:
    .byte ($2 << 4) + _id_EnPlace2, $10, $0C
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

EnFrame_KraidFacingRight1:
    .byte ($2 << 4) + _id_EnPlace2, $10, $0C
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

EnFrame_KraidFacingLeft0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $10, $0C
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

EnFrame_KraidFacingLeft1:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace2, $10, $0C
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

EnFrame_KraidExplodeFacingRight:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C5
    .byte $C7
    .byte $D5
    .byte $D7
    .byte $E5
    .byte $E7
    .byte $FF

EnFrame_KraidExplodeFacingLeft:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C7
    .byte $C5
    .byte $D7
    .byte $D5
    .byte $E7
    .byte $E5
    .byte $FF
