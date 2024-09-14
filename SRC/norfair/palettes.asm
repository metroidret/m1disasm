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

;Norfair Palette Definitions

Palette00:
LA178:  .byte $3F                       ;Upper byte of PPU palette adress.
LA179:  .byte $00                       ;Lower byte of PPU palette adress.
LA17A:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA17B:  .byte $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $31, $13, $15
;The following values are written to the sprite palette:
LA18B:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

LA19B:  .byte $00                       ;End Palette00 info.

Palette01:
LA19C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA19D:  .byte $12                       ;Lower byte of PPU palette adress.
LA19E:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA19F:  .byte $19, $27

LA1A0:  .byte $00                       ;End Palette01 info.

Palette03:
LA1A2:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A3:  .byte $12                       ;Lower byte of PPU palette adress.
LA1A4:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A5:  .byte $2C, $27

LA1A7:  .byte $00                       ;End Palette02 info.

Palette02:
LA1A8:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A9:  .byte $12                       ;Lower byte of PPU palette adress.
LA1AA:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1AB:  .byte $19, $35

LA1AD:  .byte $00                       ;End Palette03 info.

Palette04:
LA1AE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1AF:  .byte $12                       ;Lower byte of PPU palette adress.
LA1B0:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1B1:  .byte $2C, $24

LA1B3:  .byte $00                       ;End Palette04 info.

Palette05:
LA1B4:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1B5:  .byte $00                       ;Lower byte of PPU palette adress.
LA1B6:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA1B7:  .byte $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $35, $1B, $16
LAC17:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1C8:  .byte $14                       ;Lower byte of PPU palette adress.
LA1C9:  .byte $0C                       ;Palette data length.
;The following values are written to the sprite palette:
LA1CA:  .byte $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

LA1D6:  .byte $00                       ;End Palette05 info.

Palette06:
LA1D7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1D8:  .byte $11                       ;Lower byte of PPU palette adress.
LA1D9:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1DA:  .byte $04, $09, $07

LA1DD:  .byte $00                       ;End Palette06 info.

Palette07:
LA1DE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1DF:  .byte $11                       ;Lower byte of PPU palette adress.
LA1E0:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1E1:  .byte $05, $09, $17

LA1E4:  .byte $00                       ;End Palette07 info.

Palette08:
LA1E5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1E6:  .byte $11                       ;Lower byte of PPU palette adress.
LA1E7:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1E8:  .byte $06, $0A, $26

LA1EB:  .byte $00                       ;End Palette08 info.

Palette09:
LA1EC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1ED:  .byte $11                       ;Lower byte of PPU palette adress.
LA1EE:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1EF:  .byte $16, $19, $27

LA1F2:  .byte $00                       ;End Palette09 info.

Palette0A:
LA1F3:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1F4:  .byte $00                       ;Lower byte of PPU palette adress.
LA1F5:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA1F6:  .byte $0F, $30, $30, $21

LA1FA:  .byte $00                       ;End Palette0A info.

Palette0B:
LA1FB:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1FC:  .byte $10                       ;Lower byte of PPU palette adress.
LA1FD:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1FE:  .byte $0F, $15, $34, $17

LA202:  .byte $00                       ;End Palette0B info.

Palette0C:
LA203:  .byte $3F                       ;Upper byte of PPU palette adress.
LA204:  .byte $10                       ;Lower byte of PPU palette adress.
LA205:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA206:  .byte $0F, $15, $34, $19

LA20A:  .byte $00                       ;End Palette0C info.

Palette0D:
LA20B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA20C:  .byte $10                       ;Lower byte of PPU palette adress.
LA20D:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA20E:  .byte $0F, $15, $34, $28

LA212:  .byte $00                       ;End Palette0D info.

Palette0E:
LA213:  .byte $3F                       ;Upper byte of PPU palette adress.
LA214:  .byte $10                       ;Lower byte of PPU palette adress.
LA215:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA216:  .byte $0F, $15, $34, $29

LA21A:  .byte $00                       ;End Palette0E info.