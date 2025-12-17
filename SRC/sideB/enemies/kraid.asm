; Kraid, Lint, and Nails

; Kraid Routine
KraidAIRoutine_{AREA}:
    .byte $BD, $60, $B4
    .byte $C9, $03
    .byte $90, $19
    .byte $F0, $04
    .byte $C9, $05
    .byte $D0, $1C
    ; fallthrough

KraidBranch_Explode_{AREA}:
    .byte $A9, $00
    .byte $8D, $70, $B4
    .byte $8D, $80, $B4
    .byte $8D, $90, $B4
    .byte $8D, $A0, $B4
    .byte $8D, $B0, $B4
    .byte $F0, $09

KraidBranch_Normal_{AREA}:
    .byte $20, $15, $BC
    .byte $20, $C4, $BC
    .byte $20, $FD, $BC
    ; fallthrough

KraidBranch_Exit_{AREA}:
    .byte $A9, $0A
    .byte $85, $00
    .byte $4C, $C4, $B9

;-------------------------------------------------------------------------------
; Kraid Projectile
KraidLintAIRoutine_{AREA}:
    .byte $BD, $05, $04
    .byte $29, $02
    .byte $F0, $07
    .byte $BD, $60, $B4
    .byte $C9, $03
    .byte $D0, $07

KraidLintRemove_{AREA}:
    .byte $A9, $00
    .byte $9D, $60, $B4
    .byte $F0, $2B

KraidLintMain_{AREA}:
    .byte $BD, $05, $04
    .byte $0A
    .byte $30, $25
    .byte $BD, $60, $B4
    .byte $C9, $02
    .byte $D0, $1E
    
    .byte $20, $2D, $6C
    .byte $A6, $45
    .byte $A5, $00
    .byte $9D, $02, $04
    .byte $20, $30, $6C
    .byte $A6, $45
    .byte $A5, $00
    .byte $9D, $03, $04
    .byte $20, $33, $6C
    .byte $B0, $05
    .byte $A9, $03
    .byte $9D, $60, $B4

KraidLintDraw_{AREA}:
    .byte $A9, $01
    .byte $20, $0C, $6C
    .byte $4C, $06, $6C

;-------------------------------------------------------------------------------
; Kraid Projectile 2
KraidNailAIRoutine_{AREA}:
    .byte $4C, $CA, $BB

;-------------------------------------------------------------------------------
; Kraid Subroutine 1
KraidUpdateAllProjectiles_{AREA}:
    .byte $A2, $50
    .byte $20, $22, $BC
    .byte $8A
    .byte $38
    .byte $E9, $10
    .byte $AA
    .byte $D0, $F6
    .byte $60

;-------------------------------------------------------------------------------
; Kraid Subroutine 1.1
KraidUpdateProjectile_{AREA}:
    .byte $BC, $60, $B4
    .byte $F0, $26
    
    .byte $BD, $6E, $B4
    .byte $C9, $0A
    .byte $F0, $04
    .byte $C9, $09
    .byte $D0, $6D
    
@branchA:
    .byte $BD, $05, $04
    .byte $29, $02
    .byte $F0, $14
    .byte $88
    .byte $F0, $1C
    .byte $C0, $02
    .byte $F0, $0D
    .byte $C0, $03
    .byte $D0, $5B
    .byte $BD, $0C, $04
    .byte $C9, $01
    .byte $D0, $54
    .byte $F0, $0B

@remove:
    .byte $A9, $00
    .byte $9D, $60, $B4
    .byte $9D, $0F, $04
    .byte $20, $2A, $6C

@resting:
    .byte $AD, $05, $04
    .byte $9D, $05, $04
    .byte $4A
    .byte $08
    .byte $8A
    .byte $4A, $4A, $4A, $4A
    .byte $A8
    .byte $B9, $AF, $BC
    .byte $85, $04
    .byte $B9, $BE, $BC
    .byte $9D, $6E, $B4
    .byte $98
    .byte $28
    .byte $2A
    .byte $A8
    .byte $B9, $B3, $BC
    .byte $85, $05
    
    .byte $A2, $00
    .byte $20, $A0, $BC
    .byte $20, $27, $6C
    
    .byte $A6, $45
    .byte $90, $19
    .byte $BD, $60, $B4
    .byte $D0, $03
    .byte $FE, $60, $B4
    ; fallthrough

LoadEnemyPositionFromTemp__{AREA}:
    .byte $A5, $08
    .byte $9D, $00, $04
    .byte $A5, $09
    .byte $9D, $01, $04
    .byte $A5, $0B
    .byte $29, $01
    .byte $9D, $67, $B4
KraidUpdateProjectile_Exit_{AREA}:
    .byte $60

StoreEnemyPositionToTemp__{AREA}:
    .byte $BD, $00, $04, $85, $08, $BD, $01, $04, $85, $09, $BD, $67, $B4, $85, $0B, $60

KraidProjectileOffsetY_{AREA}:
    .byte $F5, $FD, $05, $F6, $FE

KraidProjectileOffsetX_{AREA}:
    .byte $0A, $F6
    .byte $0C, $F4
    .byte $0E, $F2
    .byte $F8, $08
    .byte $F4, $0C
KraidProjectileType_{AREA}:
    .byte $09, $09, $09, $0A, $0A

;-------------------------------------------------------------------------------
; Kraid Subroutine 2
;  Something to do with the lint
KraidTryToLaunchLint_{AREA}:
    .byte $A4, $79
    .byte $D0, $02
    .byte $A0, $80
    
    .byte $A5, $27
    .byte $29, $02
    .byte $D0, $2C
    
    .byte $88
    .byte $84, $79
    .byte $98
    .byte $0A
    .byte $30, $25
    .byte $29, $0F
    .byte $C9, $0A
    .byte $D0, $1F
    
    .byte $A9, $01
    .byte $A2, $10
    .byte $DD, $60, $B4
    .byte $F0, $11
    .byte $A2, $20
    .byte $DD, $60, $B4
    .byte $F0, $0A
    .byte $A2, $30
    .byte $DD, $60, $B4
    .byte $F0, $03
    .byte $E6, $79
    .byte $60

@primeForLaunch:
    .byte $A9, $08
    .byte $9D, $09, $04
@RTS:
    .byte $60

;-------------------------------------------------------------------------------
; Kraid Subroutine 3
;  Something to do with the nails
KraidTryToLaunchNail_{AREA}:
    .byte $A4, $7A
    .byte $D0, $02
    .byte $A0, $60
    
    .byte $A5, $27
    .byte $29, $02
    .byte $D0, $23
    .byte $88
    .byte $84, $7A
    .byte $98
    .byte $0A
    .byte $30, $1C
    .byte $29, $0F
    .byte $D0, $18
    
    .byte $A9, $01
    .byte $A2, $40
    .byte $DD, $60, $B4
    .byte $F0, $0A
    .byte $A2, $50
    .byte $DD, $60, $B4
    .byte $F0, $03
    .byte $E6, $7A
    .byte $60

@primeForLaunch:
    .byte $A9, $08
    .byte $9D, $09, $04
@RTS:
    .byte $60

