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

;Brinstar Palettes

Palette00:
LA271:  .byte $3F                       ;Upper byte of PPU palette adress.
LA272:  .byte $00                       ;Lower byte of PPU palette adress.
LA273:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA274:  .byte $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C
;The following values are written to the sprite palette:
LA284:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38

LA294:  .byte $00                       ;End Palette00 info.

Palette01:
LA295:  .byte $3F                       ;Upper byte of PPU palette adress.
LA296:  .byte $12                       ;Lower byte of PPU palette adress.
LA297:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA298:  .byte $19, $27

LA29A:  .byte $00                       ;End Palette01 info.

Palette03:
LA29B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA29C:  .byte $12                       ;Lower byte of PPU palette adress.
LA29D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA29E:  .byte $2C, $27

LA2A0:  .byte $00                       ;End Palette02 info.

Palette02:
LA2A1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2A2:  .byte $12                       ;Lower byte of PPU palette adress.
LA2A3:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA2A4:  .byte $19, $35

LA2A6:  .byte $00                       ;End Palette03 info.

Palette04:
LA2A7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2A8:  .byte $12                       ;Lower byte of PPU palette adress.
LA2A9:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA2AA:  .byte $2C, $24

LA2AC:  .byte $00                       ;End Palette04 info.

Palette05:
LA2AD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2AE:  .byte $00                       ;Lower byte of PPU palette adress.
LA2AF:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA2B0:  .byte $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
LA2C0:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2C1:  .byte $14                       ;Lower byte of PPU palette adress.
LA2C2:  .byte $0C                       ;Palette data length.
;The following values are written to the sprite palette:
LA2C3:  .byte $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38

LA2CF:  .byte $00                       ;End Palette05 info.

Palette06:
LA2D0:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2D1:  .byte $11                       ;Lower byte of PPU palette adress.
LA2D2:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2D3:  .byte $04, $09, $07

LA2D6:  .byte $00                       ;End Palette06 info.

Palette07:
LA2D7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2D8:  .byte $11                       ;Lower byte of PPU palette adress.
LA2D9:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2DA:  .byte $05, $09, $17

LA2DD:  .byte $00                       ;End Palette07 info.

Palette08:
LA2DE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2DF:  .byte $11                       ;Lower byte of PPU palette adress.
LA2E0:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2E1:  .byte $06, $0A, $26

LA2E4:  .byte $00                       ;End Palette08 info.

Palette09:
LA2E5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2E6:  .byte $11                       ;Lower byte of PPU palette adress.
LA2E7:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2E8:  .byte $16, $19, $27

LA2EB:  .byte $00                       ;End Palette09 info.

Palette0A:
LA2EC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2ED:  .byte $00                       ;Lower byte of PPU palette adress.
LA2EE:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA2EF:  .byte $0F, $30, $30, $21

LA2F3:  .byte $00                       ;End Palette0A info.

Palette0B:
LA2F4:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2F5:  .byte $10                       ;Lower byte of PPU palette adress.
LA2F6:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA2F7:  .byte $0F, $15, $34, $17

LA2FB:  .byte $00                       ;End Palette0B info.

Palette0C:
LA2FC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2FD:  .byte $10                       ;Lower byte of PPU palette adress.
LA2FE:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA2FF:  .byte $0F, $15, $34, $19

LA303:  .byte $00                       ;End Palette0C info.

Palette0D:
LA304:  .byte $3F                       ;Upper byte of PPU palette adress.
LA305:  .byte $10                       ;Lower byte of PPU palette adress.
LA306:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA307:  .byte $0F, $15, $34, $28

LA30B:  .byte $00                       ;End Palette0D info.

Palette0E:
LA30C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA30D:  .byte $10                       ;Lower byte of PPU palette adress.
LA30E:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA30F:  .byte $0F, $15, $34, $29

LA313:  .byte $00                       ;End Palette0E info.