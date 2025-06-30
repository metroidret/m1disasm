;-------------------------------------[ Hardware defines ]-------------------------------------------

;PPU hardware control registers.
PPUCTRL                = $2000
PPUMASK                = $2001
PPUSTATUS              = $2002
OAMADDR                = $2003
OAMDATA                = $2004
PPUSCROLL              = $2005
PPUADDR                = $2006
PPUDATA                = $2007

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

    PPUSTATUS_OBJOVERFLOW  = %00100000
    PPUSTATUS_OBJ0HIT      = %01000000
    PPUSTATUS_VBLK         = %10000000

    OAMDATA_PAL0       = %00000000
    OAMDATA_PAL1       = %00000001
    OAMDATA_PAL2       = %00000010
    OAMDATA_PAL3       = %00000011
    OAMDATA_PRIORITY   = %00100000
    OAMDATA_HFLIP      = %01000000
    OAMDATA_VFLIP      = %10000000


;SQ1 hardware control registers.
SQ1_VOL                = $4000
SQ1_SWEEP              = $4001
SQ1_LO                 = $4002
SQ1_HI                 = $4003

;SQ2 hardware control registers.
SQ2_VOL                = $4004
SQ2_SWEEP              = $4005
SQ2_LO                 = $4006
SQ2_HI                 = $4007

;Triangle hardware control registers.
TRI_LINEAR             = $4008
TRI_UNUSED             = $4009
TRI_LO                 = $400A
TRI_HI                 = $400B

;Noise hardware control registers.
NOISE_VOL              = $400C
NOISE_UNUSED           = $400D
NOISE_LO               = $400E
NOISE_HI               = $400F

;DMC hardware control registers.
DMC_FREQ               = $4010
DMC_RAW                = $4011
DMC_START              = $4012
DMC_LEN                = $4013

OAMDMA                 = $4014   ;Sprite RAM DMA register.
SND_CHN                = $4015   ;APU common control 1 register.
JOY1                   = $4016   ;Joypad1 register.
JOY2                   = $4017   ;Joypad2/APU common control 2 register.

    BUTTON_RIGHT          = %00000001
    BUTTON_LEFT           = %00000010
    BUTTON_DOWN           = %00000100
    BUTTON_UP             = %00001000
    BUTTON_START          = %00010000
    BUTTON_SELECT         = %00100000
    BUTTON_B              = %01000000
    BUTTON_A              = %10000000
    BUTTONBIT_RIGHT       = 0
    BUTTONBIT_LEFT        = 1
    BUTTONBIT_DOWN        = 2
    BUTTONBIT_UP          = 3
    BUTTONBIT_START       = 4
    BUTTONBIT_SELECT      = 5
    BUTTONBIT_B           = 6
    BUTTONBIT_A           = 7
    
    APU_4STEP             = %00000000
    APU_5STEP             = %10000000
    APU_IRQENABLE         = %00000000
    APU_IRQDISABLE        = %01000000

;----------------------------------------------------------------------------------------------------

;Writing to any of these addresses or any address in between will write configuration bits to the MMC chip.
MMC1Reg0               = $8000
MMC1Reg1               = $A000
MMC1Reg2               = $C000
MMC1Reg3               = $E000

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

;----------------------------------------------------------------------------------------------------

;FDS BIOS routines

FDSBIOS_LoadFiles = $E1F8
FDSBIOS_AppendFile = $E237
FDSBIOS_WriteFile = $E239
FDSBIOS_CheckFileCount = $E2B7
FDSBIOS_AdjustFileCount = $E2BB
FDSBIOS_SetFileCount1 = $E301
FDSBIOS_SetFileCount = $E305
FDSBIOS_GetDiskInfo = $E32A

FDSBIOS_CheckDiskHeader = $E445
FDSBIOS_GetNumFiles = $E484
FDSBIOS_SetNumFiles = $E492
FDSBIOS_FileMatchTest = $E4A0
FDSBIOS_SkipFiles = $E4DA

;----------------------------------------------------------------------------------------------------

SCRN_VX                = 256
SCRN_VY                = 240
