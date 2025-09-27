;-------------------------------------[ Hardware defines ]-------------------------------------------

;FDS interrupt control
FDS_ACTONNMI           = $0100

    FDS_ACTONNMI_VINTWAIT  = %00000000
    FDS_ACTONNMI_VEC_DFF6  = %01000000
    FDS_ACTONNMI_VEC_DFF8  = %10000000
    FDS_ACTONNMI_VEC_DFFA  = %11000000

FDS_ACTONIRQ           = $0101

    FDS_ACTONIRQ_DISKSKIP  = %00000000
    FDS_ACTONIRQ_DISKTRANS = %01000000
    FDS_ACTONIRQ_ACKDELAY  = %10000000
    FDS_ACTONIRQ_VEC_DFFE  = %11000000

FDS_RESETFLAG          = $0102

    FDS_RESETFLAG_RESETOK  = $35

FDS_RESETTYPE          = $0103

    FDS_RESETTYPE_HARD     = $AC
    FDS_RESETTYPE_SOFT     = $53


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


; FDS write-only
TIMERIRQ_RELOAD        = $4020
; TIMERIRQ_RELOAD+1      = $4021
TIMERIRQ_CTRL          = $4022

    TIMERIRQ_CTRL_REPEAT   = %00000001
    TIMERIRQ_CTRL_ENABLE   = %00000010

IO_ENABLE              = $4023
IO_WRITE               = $4024
FDS_CTRL               = $4025

    FDS_CTRL_TRANS_RESET   = %00000001
    FDS_CTRL_MOTOR_START   = %00000000
    FDS_CTRL_MOTOR_STOP    = %00000010
    FDS_CTRL_TRANS_WRITE   = %00000000
    FDS_CTRL_TRANS_READ    = %00000100
    FDS_CTRL_MIRROR_VERTI  = %00000000
    FDS_CTRL_MIRROR_HORIZ  = %00001000
    FDS_CTRL_TRANS_CRC     = %00010000
    FDS_CTRL_UNK           = %00100000 ; always set
    FDS_CTRL_CRC_ENABLE    = %01000000
    FDS_CTRL_IRQ_ENABLE    = %10000000

EXPANSION_WRITE        = $4026

; FDS read-only
DISKSTATUS             = $4030

    DISKSTATUS_TIMERIRQ    = %00000001
    DISKSTATUS_TRANSBYTE   = %00000010
    DISKSTATUS_MIRROR      = %00001000
    DISKSTATUS_CRC         = %00010000
    DISKSTATUS_ENDOFHEAD   = %01000000
    DISKSTATUS_ACCESSIBLE  = %10000000

DISKDATA               = $4031
DRIVESTATUS            = $4032

    DRIVESTATUS_NODISK     = %00000001
    DRIVESTATUS_ENDOFDISK  = %00000010
    DRIVESTATUS_NOWRITE    = %00000100

EXPANSION_READ         = $4033

    EXPANSION_READ_VOLT    = %10000000

; FDS write-only
; ($4040-$407F)
FDSAUDIO_WAVETABLE     = $4040

FDSAUDIO_VOL_WRITE     = $4080
FDSAUDIO_UNUSED        = $4081
FDSAUDIO_LO            = $4082
FDSAUDIO_HI            = $4083

FDSAUDIO_MODENV_WRITE  = $4084
FDSAUDIO_MODCNTR_WRITE = $4085
FDSAUDIO_MODLO         = $4086
FDSAUDIO_MODHI         = $4087
FDSAUDIO_MODWRITE      = $4088
FDSAUDIO_MASTERVOL     = $4089
FDSAUDIO_ENVSPEED      = $408A

; FDS read-only
FDSAUDIO_VOL_READ      = $4090
FDSAUDIO_WAVEACC       = $4091
FDSAUDIO_MODENV_READ   = $4092
FDSAUDIO_MODACC        = $4093
FDSAUDIO_MODCNTRGAIN   = $4094
FDSAUDIO_MODCNTRINCR   = $4095
FDSAUDIO_WAVEOUTPUT    = $4096
FDSAUDIO_MODCNTR_READ  = $4097

;----------------------------------------------------------------------------------------------------

;FDS BIOS routines

FDSBIOS_DisPFObj = $E161
FDSBIOS_EnPFObj = $E16B

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

FDSBIOS_Random = $E9B1

FDSBIOS_VRAMFill = $EA84
FDSBIOS_MemFill = $EAD2

;----------------------------------------------------------------------------------------------------

SCRN_VX                = 256
SCRN_VY                = 240

