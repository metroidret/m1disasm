;-------------------------------------[ Hardware defines ]-------------------------------------------

PPUCTRL                = $2000   ;
PPUMASK                = $2001   ;
PPUSTATUS              = $2002   ;
OAMADDR                = $2003   ;PPU hardware control registers.
OAMDATA                = $2004   ;
PPUSCROLL              = $2005   ;
PPUADDR                = $2006   ;
PPUDATA                = $2007   ;

    PPUCTRL_NMTBL_2000     = %00000000
    PPUCTRL_NMTBL_2400     = %00000001
    PPUCTRL_NMTBL_2800     = %00000010
    PPUCTRL_NMTBL_2C00     = %00000011
    PPUCTRL_INCR_FWD       = %00000000
    PPUCTRL_INCR_DOWN      = %00000100
    PPUCTRL_OBJ_0000       = %00000000
    PPUCTRL_OBJ_1000       = %00001000
    PPUCTRL_BG_0000        = %00000000
    PPUCTRL_BG_1000        = %00010000
    PPUCTRL_OBJH_8         = %00000000
    PPUCTRL_OBJH_16        = %00100000
    PPUCTRL_SLAVE          = %00000000
    PPUCTRL_MASTER         = %01000000
    PPUCTRL_VBLKNMI_OFF    = %00000000
    PPUCTRL_VBLKNMI_ON     = %10000000

    PPUMASK_COLOR          = %00000000
    PPUMASK_GREYSCALE      = %00000001
    PPUMASK_HIDE8BG        = %00000000
    PPUMASK_SHOW8BG        = %00000010
    PPUMASK_HIDE8OBJ       = %00000000
    PPUMASK_SHOW8OBJ       = %00000100
    PPUMASK_BG_OFF         = %00000000
    PPUMASK_BG_ON          = %00001000
    PPUMASK_OBJ_OFF        = %00000000
    PPUMASK_OBJ_ON         = %00010000

    OAMDATA_PAL0       = %00000000
    OAMDATA_PAL1       = %00000001
    OAMDATA_PAL2       = %00000010
    OAMDATA_PAL3       = %00000011
    OAMDATA_PRIORITY   = %00100000
    OAMDATA_HFLIP      = %01000000
    OAMDATA_VFLIP      = %10000000


SQ1Cntrl0              = $4000   ;
SQ1Cntrl1              = $4001   ;SQ1 hardware control registers.
SQ1Cntrl2              = $4002   ;
SQ1Cntrl3              = $4003   ;

SQ2Cntrl0              = $4004   ;
SQ2Cntrl1              = $4005   ;SQ2 hardware control registers.
SQ2Cntrl2              = $4006   ;
SQ2Cntrl3              = $4007   ;

TriangleCntrl0         = $4008   ;
TriangleCntrl1         = $4009   ;Triangle hardware control registers.
TriangleCntrl2         = $400A   ;
TriangleCntrl3         = $400B   ;

NoiseCntrl0            = $400C   ;
NoiseCntrl1            = $400D   ;Noise hardware control registers.
NoiseCntrl2            = $400E   ;
NoiseCntrl3            = $400F   ;

DMCCntrl0              = $4010   ;
DMCCntrl1              = $4011   ;DMC hardware control registers.
DMCCntrl2              = $4012   ;
DMCCntrl3              = $4013   ;

OAMDMA                 = $4014   ;Sprite RAM DMA register.
APUCommonCntrl0        = $4015   ;APU common control 1 register.
CPUJoyPad1             = $4016   ;Joypad1 register.
APUCommonCntrl1        = $4017   ;Joypad2/APU common control 2 register.

;----------------------------------------------------------------------------------------------------

MMC1Reg0               = $8000   ;Writing to any of these addresses or any-->
MMC1Reg1               = $A000   ;address in between will write configuration-->
MMC1Reg2               = $C000   ;bits to the MMC chip.
MMC1Reg3               = $E000   ;

    MMC1_0_MIRROR_1LOWER   = %00000
    MMC1_0_MIRROR_1UPPER   = %00001
    MMC1_0_MIRROR_VERTI    = %00010
    MMC1_0_MIRROR_HORIZ    = %00011
    MMC1_0_PRGFIXED_8000   = %00000
    MMC1_0_PRGFIXED_C000   = %00100
    MMC1_0_PRGBANK_32K     = %00000
    MMC1_0_PRGBANK_16K     = %01000
    MMC1_0_CHRBANK_8K      = %00000
    MMC1_0_CHRBANK_4K      = %10000



