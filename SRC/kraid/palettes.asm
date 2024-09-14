; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi 
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Kraid Palette Data

Palette00:
LA155:  .byte $3F                       ;Upper byte of PPU palette adress.
LA156:  .byte $00                       ;Lower byte of PPU palette adress.
LA157:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA158:  .byte $0F, $20, $10, $00, $0F, $28, $19, $1A, $0F, $28, $16, $04, $0F, $23, $11, $02
;The following values are written to the sprite palette:
LA168:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $1B, $36, $0F, $17, $22, $31

LA178:  .byte $00                       ;End Palette00 info.

Palette01:
LA179:  .byte $3F                       ;Upper byte of PPU palette adress.
LA17A:  .byte $12                       ;Lower byte of PPU palette adress.
LA17B:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA17C:  .byte $19, $27

LA17E:  .byte $00                       ;End Palette01 info.

Palette03:
LA17F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA180:  .byte $12                       ;Lower byte of PPU palette adress.
LA181:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA182:  .byte $2C, $27

LA184:  .byte $00                       ;End Palette03 info.

Palette02:
LA185:  .byte $3F                       ;Upper byte of PPU palette adress.
LA186:  .byte $12                       ;Lower byte of PPU palette adress.
LA187:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA188:  .byte $19, $35

LA18A:  .byte $00                       ;End Palette02 info.

Palette04:
LA18B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA18C:  .byte $12                       ;Lower byte of PPU palette adress.
LA18D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA18E:  .byte $2C, $24

LA190:  .byte $00                       ;End Palette04 info.

Palette05:
LA191:  .byte $3F                       ;Upper byte of PPU palette adress.
LA192:  .byte $11                       ;Lower byte of PPU palette adress.
LA193:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA194:  .byte $04, $09, $07

LA196:  .byte $00                       ;End Palette05 info.

Palette06:
La198:  .byte $3F                       ;Upper byte of PPU palette adress.
LA199:  .byte $11                       ;Lower byte of PPU palette adress.
LA19A:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA19B:  .byte $05, $09, $17

LA19E:  .byte $00                       ;End Palette06 info.

Palette07:
LA19F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A0:  .byte $11                       ;Lower byte of PPU palette adress.
LA1A1:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A2:  .byte $06, $0A, $26

LA1A5:  .byte $00                       ;End Palette07 info.

Palette08:
LA1A6:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A7:  .byte $11                       ;Lower byte of PPU palette adress.
LA1A8:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A9:  .byte $16, $19, $27

LA1AC:  .byte $00                       ;End Palette08 info.

Palette09:
LA1AD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1AE:  .byte $00                       ;Lower byte of PPU palette adress.
LA1AF:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA1B0:  .byte $0F, $30, $30, $21

LA1B4:  .byte $00                       ;End Palette09 info.

Palette0A:
LA1B5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1B6:  .byte $10                       ;Lower byte of PPU palette adress.
LA1B7:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1B8:  .byte $0F, $15, $34, $17

LA1BC:  .byte $00                       ;End Palette0A info.

Palette0B:
LA1BD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1BE:  .byte $10                       ;Lower byte of PPU palette adress.
LA1BF:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1C0:  .byte $0F, $15, $34, $19

LA1C4:  .byte $00                       ;End Palette0B info.

Palette0C:
LA1C5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1C6:  .byte $10                       ;Lower byte of PPU palette adress.
LA1C7:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1C8:  .byte $0F, $15, $34, $28

LA1CC:  .byte $00                       ;End Palette0C info.

Palette0D:
LA1CD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1CE:  .byte $10                       ;Lower byte of PPU palette adress.
LA1CF:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1D0:  .byte $0F, $15, $34, $29

LA1D4:  .byte $00                       ;End Palette0D info.