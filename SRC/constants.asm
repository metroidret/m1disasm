.MEMORYMAP
    DEFAULTSLOT 0
    SLOT 0 $0000 $FFDC "DummySlot"
    SLOT 1 $0000 $0800 "RAMConsoleSlot"
    SLOT 2 $6000 $8000 "RAMDiskSysSlot"
    SLOT 3 $E000 $2000 "ROMFDSBIOSSlot"
.ENDME

.ROMBANKMAP
    BANKSTOTAL $60
    BANKSIZE $8000
    BANKS $60
.ENDRO


.ASCIITABLE
.ENDA

.STRINGMAPTABLE charmap_kyodaku "SRC/kyodaku.tbl"
.STRINGMAPTABLE charmap_title "SRC/title.tbl"
.STRINGMAPTABLE charmap_savemenu "SRC/savemenu.tbl"
.STRINGMAPTABLE charmap_ending "SRC/ending.tbl"

;-------------------------------------------[ Defines ]----------------------------------------------

CodePtr                = $0C     ;Points to address to jump to when choosing-->
; CodePtr+1              = $0D     ;a routine from a list of routine addresses.

NMIStatus              = $1A     ;0=NMI in progress. anything else, NMI not in progress.
PPUDataPending         = $1B     ;1=not PPU data pending, 1=data pending.

RandomNumber1          = $28        ;Random numbers used-->
RandomNumber2          = $29        ;throughout the game.

FDSBase                = $EE     ;Low byte of base address for FDS music data
; FDSBase+1              = $EF     ;High byte of base address for FDS music data

FDS_CTRL_ZP            = $FB
ScrollY                = $FC     ;Y value loaded into scroll register.
ScrollX                = $FD     ;X value loaded into scroll register.
PPUMASK_ZP             = $FE     ;Data byte to be loaded into PPU control register 1.
PPUCTRL_ZP             = $FF     ;Data byte to be loaded into PPU control register 0.

;-----------------------------------------[ Sprite RAM ]---------------------------------------------

SpriteRAM              = $0200   ;$0200 thru $02FF

;----------------------------------------------------------------------------------------------------

TempX                  = $0414
TempY                  = $0415

;----------------------------------------------------------------------------------------------------

PPUStrIndex            = $07A0   ;# of bytes of data in PPUDataString. #$4F bytes max.

;$07A1 thru $07F0 contain a byte string of data to be written the the PPU. 
;The first two bytes in the string are the address of the starting point in the PPU to write -->
;the data (high byte, low byte).
;The third byte is a configuration byte.
; If the MSB of this byte is set, the PPU is incremented by 32 after each byte write (vertical write).
; If the MSB is cleared, the PPU is incremented by 1 after each write (horizontal write).
; If bit 6 is set, the next data byte is repeated multiple times during successive PPU writes.
; The number of times the next byte is repeated is based on bits 0-5 of the configuration byte.
; Those bytes are a repetition counter.
;Any following bytes are the actual data bytes to be written to the PPU.
;#$00 separates the data chunks.

PPUDataString          = $07A1   ;Thru $07F0. String of data bytes to be written to PPU.

