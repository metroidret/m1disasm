;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnAnimTable: ;($9B85)
EnAnim_00:
    .byte _id_EnFrame00, _id_EnFrame01, $FF

EnAnim_EnProjectileKilled:
    .byte _id_EnFrame_EnProjectileKilled, $FF

EnAnim_RidleyIdle_R:
    .byte _id_EnFrame_RidleyIdle0_R, _id_EnFrame_RidleyIdle1_R, $FF

EnAnim_RidleyIdle_L:
    .byte _id_EnFrame_RidleyIdle0_L, _id_EnFrame_RidleyIdle1_L, $FF

EnAnim_RidleyHopping_R:
    .byte _id_EnFrame_RidleyHopping0_R, _id_EnFrame_RidleyHopping1_R, $FF

EnAnim_RidleyHopping_L:
    .byte _id_EnFrame_RidleyHopping0_L, _id_EnFrame_RidleyHopping1_L, $FF

EnAnim_RidleyExplode:
    .byte _id_EnFrame_RidleyExplode, $FF

EnAnim_RidleyFireball_R:
    .byte _id_EnFrame_RidleyFireball0_R, _id_EnFrame_RidleyFireball1_R, _id_EnFrame_RidleyFireball2_R, _id_EnFrame_RidleyFireball3_R, $FF

EnAnim_RidleyFireball_L:
    .byte _id_EnFrame_RidleyFireball0_L, _id_EnFrame_RidleyFireball1_L, _id_EnFrame_RidleyFireball2_L, _id_EnFrame_RidleyFireball3_L, $FF

EnAnim_HoltzIdle:
    .byte _id_EnFrame_HoltzIdle0, _id_EnFrame_HoltzIdle1, $FF

EnAnim_HoltzSwooping:
    .byte _id_EnFrame_HoltzSwooping0, _id_EnFrame_HoltzSwooping1, $FF

EnAnim_HoltzExplode:
    .byte _id_EnFrame_HoltzExplode, $FF

EnAnim_Mella:
    .byte _id_EnFrame_Mella0, _id_EnFrame_Mella1, $FF

EnAnim_MultiviolaSpinningCounterclockwise:
    .byte _id_EnFrame_MultiviolaSpinningCounterclockwise0, _id_EnFrame_MultiviolaSpinningCounterclockwise1, _id_EnFrame_MultiviolaSpinningCounterclockwise2, _id_EnFrame_MultiviolaSpinningCounterclockwise3, $FF

EnAnim_MultiviolaSpinningClockwise:
    .byte _id_EnFrame_MultiviolaSpinningClockwise0, _id_EnFrame_MultiviolaSpinningClockwise1, _id_EnFrame_MultiviolaSpinningClockwise2, _id_EnFrame_MultiviolaSpinningClockwise3, $FF

EnAnim_MultiviolaExplode:
    .byte _id_EnFrame_MultiviolaExplode, $FF

EnAnim_34:
    .byte _id_EnFrame42, $FF

EnAnim_36:
    .byte _id_EnFrame43, _id_EnFrame44, $F7, $FF

EnAnim_DessgeegaExplodeFloor:
    .byte _id_EnFrame_DessgeegaExplodeFloor, $FF

EnAnim_DessgeegaExplodeCeiling:
    .byte _id_EnFrame_DessgeegaExplodeCeiling, $FF

EnAnim_DessgeegaIdleFloor:
    .byte _id_EnFrame_DessgeegaIdleFloor0, _id_EnFrame_DessgeegaIdleFloor1, $FF

EnAnim_DessgeegaFloorStartHopping:
    .byte _id_EnFrame_DessgeegaIdleFloor1
EnAnim_DessgeegaFloorHopping:
    .byte _id_EnFrame_DessgeegaFloorHopping, $FF

EnAnim_DessgeegaIdleCeiling:
    .byte _id_EnFrame_DessgeegaIdleCeiling0, _id_EnFrame_DessgeegaIdleCeiling1, $FF

EnAnim_DessgeegaCeilingStartHopping:
    .byte _id_EnFrame_DessgeegaIdleCeiling1
EnAnim_DessgeegaCeilingHopping:
    .byte _id_EnFrame_DessgeegaCeilingHopping, $FF

EnAnim_ViolaOnFloor:
    .byte _id_EnFrame_ViolaOnFloor0, _id_EnFrame_ViolaOnFloor1, $FF

EnAnim_ViolaOnRightWall:
    .byte _id_EnFrame_ViolaOnRightWall0, _id_EnFrame_ViolaOnRightWall1, $FF

EnAnim_ViolaOnCeiling:
    .byte _id_EnFrame_ViolaOnCeiling0, _id_EnFrame_ViolaOnCeiling1, $FF

EnAnim_ViolaOnLeftWall:
    .byte _id_EnFrame_ViolaOnLeftWall0, _id_EnFrame_ViolaOnLeftWall1, $FF

EnAnim_ViolaExplode:
    .byte _id_EnFrame_ViolaExplode, $FF

EnAnim_Explosion:
    .byte _id_EnFrame_Explosion0, $F7, _id_EnFrame_Explosion1, $F7, $FF

EnAnim_Zebbo_L:
    .byte _id_EnFrame_Zebbo0_L, _id_EnFrame_Zebbo1_L, $FF

EnAnim_Zebbo_R:
    .byte _id_EnFrame_Zebbo0_R, _id_EnFrame_Zebbo1_R, $FF

EnAnim_ZebboExplode_L:
    .byte _id_EnFrame_ZebboExplode_L, $FF

EnAnim_ZebboExplode_R:
    .byte _id_EnFrame_ZebboExplode_R, $FF

EnAnim_ZebboResting_L:
    .byte _id_EnFrame_Zebbo0_L, $FF

EnAnim_ZebboResting_R:
    .byte _id_EnFrame_Zebbo0_R, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnFramePtrTable1:
    PtrTableEntry EnFramePtrTable1, EnFrame00
    PtrTableEntry EnFramePtrTable1, EnFrame01
    PtrTableEntry EnFramePtrTable1, EnFrame_EnProjectileKilled
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle0_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyIdle1_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping0_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyHopping1_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_R
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball0_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball1_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball2_L
    PtrTableEntry EnFramePtrTable1, EnFrame_RidleyFireball3_L
    PtrTableEntry EnFramePtrTable1, EnFrame14
    PtrTableEntry EnFramePtrTable1, EnFrame15
    PtrTableEntry EnFramePtrTable1, EnFrame16
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzIdle0
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzIdle1
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzSwooping0
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzSwooping1
    PtrTableEntry EnFramePtrTable1, EnFrame_HoltzExplode
    PtrTableEntry EnFramePtrTable1, EnFrame1C
    PtrTableEntry EnFramePtrTable1, EnFrame1D
    PtrTableEntry EnFramePtrTable1, EnFrame1E
    PtrTableEntry EnFramePtrTable1, EnFrame1F
    PtrTableEntry EnFramePtrTable1, EnFrame20
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella0
    PtrTableEntry EnFramePtrTable1, EnFrame_Mella1
    PtrTableEntry EnFramePtrTable1, EnFrame23
    PtrTableEntry EnFramePtrTable1, EnFrame24
    PtrTableEntry EnFramePtrTable1, EnFrame25
    PtrTableEntry EnFramePtrTable1, EnFrame26
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise0
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise1
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise2
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningCounterclockwise3
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise0
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise1
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise2
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaSpinningClockwise3
    PtrTableEntry EnFramePtrTable1, EnFrame_MultiviolaExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleFloor0
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleFloor1
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaFloorHopping
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleCeiling0
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaIdleCeiling1
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaCeilingHopping
    PtrTableEntry EnFramePtrTable1, EnFrame36
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaExplodeFloor
    PtrTableEntry EnFramePtrTable1, EnFrame_DessgeegaExplodeCeiling
    PtrTableEntry EnFramePtrTable1, EnFrame39
    PtrTableEntry EnFramePtrTable1, EnFrame3A
    PtrTableEntry EnFramePtrTable1, EnFrame3B
    PtrTableEntry EnFramePtrTable1, EnFrame3C
    PtrTableEntry EnFramePtrTable1, EnFrame3D
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
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnFloor0
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnFloor1
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnRightWall0
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnRightWall1
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnCeiling0
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnCeiling1
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnLeftWall0
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaOnLeftWall1
    PtrTableEntry EnFramePtrTable1, EnFrame_ViolaExplode
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion0
    PtrTableEntry EnFramePtrTable1, EnFrame_Explosion1
    PtrTableEntry EnFramePtrTable1, EnFrame63
    PtrTableEntry EnFramePtrTable1, EnFrame64
    PtrTableEntry EnFramePtrTable1, EnFrame65
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo0_L
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo1_L
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebboExplode_L
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo0_R
    PtrTableEntry EnFramePtrTable1, EnFrame_Zebbo1_R
    PtrTableEntry EnFramePtrTable1, EnFrame_ZebboExplode_R
    PtrTableEntry EnFramePtrTable1, EnFrame6C
    PtrTableEntry EnFramePtrTable1, EnFrame6D
    PtrTableEntry EnFramePtrTable1, EnFrame6E
    PtrTableEntry EnFramePtrTable1, EnFrame6F
    PtrTableEntry EnFramePtrTable1, EnFrame70
    PtrTableEntry EnFramePtrTable1, EnFrame71
    PtrTableEntry EnFramePtrTable1, EnFrame72
    PtrTableEntry EnFramePtrTable1, EnFrame73
    PtrTableEntry EnFramePtrTable1, EnFrame74
    PtrTableEntry EnFramePtrTable1, EnFrame75
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

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

EnPlace0:
    .byte $FC, $FC

;Enemy explode.
EnPlace1:
    .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85
    .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Miniboss
EnPlace2:
    .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
    .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
    .byte $12, $E8, $14, $F8

EnPlace3:
    .byte $F4, $F4, $F4, $04

EnPlace5:
    .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

EnPlace6:
    .byte $FC, $F8, $FC, $00

EnPlace4:
    .byte $F0, $F8, $F0, $00

EnPlace7:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

EnPlace8:
    .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

EnPlace9:
EnPlaceA:
    .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
    .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

EnPlaceB:
    .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

EnPlaceC:
    .byte $F8, $FC, $00, $FC

EnPlaceD:
    .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

EnPlaceE:
    .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

;Enemy frame drawing data.

EnFrame00:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $14
    .byte $FF

EnFrame01:
    .byte ($0 << 4) + _id_EnPlace0, $02, $02
    .byte $24
    .byte $FF

EnFrame_EnProjectileKilled:
    .byte ($0 << 4) + _id_EnPlace0, $00, $00
    .byte $04
    .byte $FF

EnFrame_RidleyIdle0_R:
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

EnFrame_RidleyIdle1_R:
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

EnFrame_RidleyHopping0_R:
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

EnFrame_RidleyHopping1_R:
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

EnFrame_RidleyIdle0_L:
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

EnFrame_RidleyIdle1_L:
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

EnFrame_RidleyHopping0_L:
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

EnFrame_RidleyHopping1_L:
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

EnFrame_RidleyExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $C6
    .byte $C7
    .byte $D6
    .byte $D7
    .byte $E6
    .byte $E7
    .byte $FF

EnFrame_RidleyFireball0_R:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_R:
    .byte ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_R:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_R:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball0_L:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball1_L:
    .byte OAMDATA_HFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame_RidleyFireball2_L:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $EC
    .byte $FF

EnFrame_RidleyFireball3_L:
    .byte OAMDATA_VFLIP + ($3 << 4) + _id_EnPlace0, $07, $07
    .byte $FB
    .byte $FF

EnFrame14:
EnFrame15:
EnFrame16:
EnFrame_HoltzIdle0:
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

EnFrame_HoltzIdle1:
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

EnFrame_HoltzSwooping0:
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

EnFrame_HoltzSwooping1:
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

EnFrame_HoltzExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CE
    .byte $CE
    .byte $DF
    .byte $DF
    .byte $FF

EnFrame1C:
EnFrame1D:
EnFrame1E:
EnFrame1F:
EnFrame20:
EnFrame_Mella0:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E6
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E6
    .byte $FF

EnFrame_Mella1:
    .byte ($2 << 4) + _id_EnPlace9, $04, $08
    .byte $E5
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $E5
    .byte $FF

EnFrame23:
EnFrame24:
EnFrame25:
EnFrame26:
EnFrame_MultiviolaSpinningCounterclockwise0:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise1:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise2:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame_MultiviolaSpinningCounterclockwise3:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $EE
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise1:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $ED
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaSpinningClockwise2:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $EF
    .byte $EE
    .byte $FF

EnFrame_MultiviolaSpinningClockwise3:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $ED
    .byte $EF
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $EF
    .byte $FF

EnFrame_MultiviolaExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $FC, $04, $00
    .byte $EE
    .byte $EF
    .byte $EF
    .byte $EF
    .byte $FF

EnFrame_DessgeegaIdleFloor0:
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

EnFrame_DessgeegaIdleFloor1:
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

EnFrame_DessgeegaFloorHopping:
    .byte ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame_DessgeegaIdleCeiling0:
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

EnFrame_DessgeegaIdleCeiling1:
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

EnFrame_DessgeegaCeilingHopping:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlaceE, $08, $0A
    .byte $F4
    .byte $F2
    .byte $E3
    .byte $F3
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $F4
    .byte $F2
    .byte $FF

EnFrame36:
EnFrame_DessgeegaExplodeFloor:
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

EnFrame_DessgeegaExplodeCeiling:
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

EnFrame39:
EnFrame3A:
EnFrame3B:
EnFrame3C:
EnFrame3D:
EnFrame3E:
EnFrame3F:
EnFrame40:
EnFrame41:
EnFrame42:
    .byte ($2 << 4) + _id_EnPlace0, $04, $04
    .byte $C0
    .byte $FF

EnFrame43:
    .byte ($2 << 4) + _id_EnPlace0, $00, $00
    .byte $FC, $F8, $00
    .byte $D0
    .byte $FF

EnFrame44:
    .byte ($2 << 4) + _id_EnPlace3, $00, $00
    .byte $D1
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $D1
    .byte $FF

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
EnFrame_ViolaOnFloor0:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnFloor1:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnRightWall0:
    .byte ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame_ViolaOnRightWall1:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DB
    .byte $FF

EnFrame_ViolaOnCeiling0:
    .byte OAMDATA_VFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CC
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnCeiling1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + $2
    .byte $CD
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

EnFrame_ViolaOnLeftWall0:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CB
    .byte $DA
    .byte $DB
    .byte $FF

EnFrame_ViolaOnLeftWall1:
    .byte OAMDATA_VFLIP + OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace7, $08, $08
    .byte $CA
    .byte $CB
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_HFLIP + $2
    .byte $CA
    .byte $FD, OAMDATA_PRIORITY + OAMDATA_VFLIP + OAMDATA_HFLIP + $2
    .byte $DB
    .byte $FF

EnFrame_ViolaExplode:
    .byte ($2 << 4) + _id_EnPlace1, $00, $00
    .byte $CC
    .byte $CD
    .byte $DC
    .byte $DD
    .byte $FF

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

EnFrame63:
EnFrame64:
EnFrame65:
EnFrame_Zebbo0_L:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Zebbo1_L:
    .byte ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_ZebboExplode_L:
    .byte ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_Zebbo0_R:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C3
    .byte $D2
    .byte $D3
    .byte $FF

EnFrame_Zebbo1_R:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlaceA, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame_ZebboExplode_R:
    .byte OAMDATA_HFLIP + ($2 << 4) + _id_EnPlace1, $08, $08
    .byte $C2
    .byte $C4
    .byte $D2
    .byte $D4
    .byte $FF

EnFrame6C:
EnFrame6D:
EnFrame6E:
EnFrame6F:
EnFrame70:
EnFrame71:
EnFrame72:
EnFrame73:
EnFrame74:
EnFrame75:
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
    .byte ($0 << 4) + _id_EnPlaceC, $08, $04
    .byte $14
    .byte $24
    .byte $FF

EnFrame_SmallEnergyPickup:
    .byte ($0 << 4) + _id_EnPlace0, $04, $04
    .byte $8A
    .byte $FF

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
