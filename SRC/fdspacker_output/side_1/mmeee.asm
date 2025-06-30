          * = $CC00
          .BYTE $0F    ;%00001111
          CPY $DB32
          .BYTE $74    ;%01110100 't'
          .BYTE $DC    ;%11011100
          .BYTE $17    ;%00010111
          JSR $8080
          BRK
          .BYTE $02    ;%00000010
          BRK
          .BYTE $87    ;%10000111
          .BYTE $42    ;%01000010 'B'
          .BYTE $C2    ;%11000010
          LDY $2A,X
          BMI LCC42
          BIT $2AFF
          ROL A
          .BYTE $C2    ;%11000010
          BCS LCC57
          .BYTE $42    ;%01000010 'B'
          JMP $B254
          .BYTE $5A    ;%01011010 'Z'
          LSR $54,X
          LDY $4C,X
          BCS LCC5E
          .BYTE $3C    ;%00111100 '<'
          ROL $B242,X
          JMP $B042
          LSR $54,X
          JMP $B342
          ROL $FF4C,X
          .BYTE $C2    ;%11000010
          .BYTE $B3    ;%10110011
          LSR A
          .BYTE $B2    ;%10110010
          JMP $5442
          BVC LCC94
          .BYTE $54    ;%01010100 'T'
          LDA ($50),Y
          JMP $3E44
          .BYTE $B2    ;%10110010
          .BYTE $3C    ;%00111100 '<'
          JMP $40B1
          LSR $B2
          BVC LCC99
          BVC LCC4E
          CPY $B3
          ROL A
          BMI LCC82
          BIT $B4FF
LCC57     .BYTE $1C    ;%00011100
          .BYTE $C3    ;%11000011
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          LDA $34,X
          LDA ($2A),Y
          LDX $1C,Y
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
          LDA $26,X
          LDA ($24),Y
          CLV
          ASL $12
          .BYTE $1C    ;%00011100
          LDA $B802,Y
          BIT $2A
          .BYTE $34    ;%00110100 '4'
          LDA $B502,Y
          SEC
          LDA ($2C),Y
          .BYTE $B3    ;%10110011
          ROL $2A
          LDA $2A,X
          LDA ($02),Y
          CLV
          ROL $24
          .BYTE $1C    ;%00011100
LCC82     LDA $B802,Y
          JSR $201C
          LDA $B402,Y
          .BYTE $1C    ;%00011100
          CLV
          ROL $2C
          .BYTE $34    ;%00110100 '4'
          LDA $B802,Y
          ROL $4C44,X
          LDA $C802,Y
LCC99     BCS LCCD7
          .BYTE $42    ;%01000010 'B'
          .BYTE $3C    ;%00111100 '<'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          LSR $42
          LSR $4C
          BVC LCCF1
          BVC LCCF7
          .BYTE $54    ;%01010100 'T'
          BVC LCCFE
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          LDY $2A,X
          .BYTE $B3    ;%10110011
          .BYTE $34    ;%00110100 '4'
          LDA $32,X
          LDA ($2E),Y
          LDY $2A,X
          .BYTE $B3    ;%10110011
          .BYTE $1C    ;%00011100
          LDA $26,X
          LDA ($24),Y
          .BYTE $FF    ;%11111111
          LDY $2A,X
          CLV
          CLC
          ROL $30
          LDA $B802,Y
          .BYTE $1C    ;%00011100
          ROL $30
          LDA $B402,Y
          .BYTE $34    ;%00110100 '4'
          CLV
          .BYTE $3A    ;%00111010 ':'
          BMI LCCF7
          LDA $B802,Y
          ROL $3038,X
LCCD7     LDA $B402,Y
          .BYTE $34    ;%00110100 '4'
          .BYTE $B2    ;%10110010
          .BYTE $1C    ;%00011100
          ROL A
          ROL $30
          .BYTE $C2    ;%11000010
          BCS LCD1B
          SEC
          SEC
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          SEC
          SEC
          SEC
          .BYTE $02    ;%00000010
          SEC
          SEC
          SEC
          SEC
          SEC
LCCF1     .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          LDY $38,X
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
LCCF7     BCS LCD15
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $B2    ;%10110010
          ASL $CA
          BCS LCD2B
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          ROL A
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          ROL A
          ROL A
          ROL A
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
LCD15     .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          ROL $2A2E
          ROL A
LCD1B     ROL $26
          BIT $24
          JSR $2A20
          ROL A
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          ROL $26
          BIT $24
          BMI LCD5B
LCD2B     ROL $2C2E
          BIT $2A2A
          PLP
          PLP
          ROL A
          ROL A
          .BYTE $FF    ;%11111111
          INY
          BCS LCD55
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          CLD
          TSX
          .BYTE $64    ;%01100100 'd'
          .BYTE $02    ;%00000010
          .BYTE $64    ;%01100100 'd'
          .BYTE $02    ;%00000010
          LDA $BA02,Y
          .BYTE $72    ;%01110010 'r'
          .BYTE $02    ;%00000010
          .BYTE $72    ;%01110010 'r'
LCD55     .BYTE $02    ;%00000010
          LDA $BA02,Y
          .BYTE $7C    ;%01111100 '|'
          .BYTE $02    ;%00000010
LCD5B     .BYTE $7C    ;%01111100 '|'
          .BYTE $02    ;%00000010
          LDA $BA02,Y
          .BYTE $72    ;%01110010 'r'
          .BYTE $02    ;%00000010
          .BYTE $72    ;%01110010 'r'
          .BYTE $02    ;%00000010
          LDA $FF02,Y
          CPY $B1
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $02    ;%00000010
          BIT $24
          BIT $20
          JSR $2020
          ROL A
          ROL A
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          BIT $24
          BIT $24
          BIT $24
          BIT $B8
          ROL $1C
          JSR $02B9
          CLV
          BIT $262A
          LDA $FF02,Y
          .BYTE $C3    ;%11000011
          BCS LCDAD
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          CLC
          .BYTE $02    ;%00000010
          CLC
          CLC
          CLC
LCDAD     CLC
          CLC
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          LDY $1C,X
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
          BCS LCDE5
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $B2    ;%10110010
          .BYTE $1C    ;%00011100
          DEX
          BCS LCDE3
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
LCDE3     ROL A
          .BYTE $3C    ;%00111100 '<'
LCDE5     SEC
          .BYTE $32    ;%00110010 '2'
          BCS LCE0D
          ROL A
          .BYTE $34    ;%00110100 '4'
          .BYTE $3C    ;%00111100 '<'
          .BYTE $B2    ;%10110010
          .BYTE $42    ;%01000010 'B'
          .BYTE $3C    ;%00111100 '<'
          .BYTE $34    ;%00110100 '4'
          LDA $2E,X
          LDA ($34),Y
          BCS LCE16
          BIT $26
          ROL A
          .BYTE $B2    ;%10110010
          ROL A
          LDA $2E,X
          LDA ($34),Y
          .BYTE $B2    ;%10110010
          ROL $3E
          .BYTE $FF    ;%11111111
          .BYTE $B2    ;%10110010
          ASL $0C0E
          .BYTE $0C    ;%00001100
          CLC
          CLC
          ASL $16,X
          .BYTE $14    ;%00010100
LCE0D     .BYTE $14    ;%00010100
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          BPL LCE22
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $C2    ;%11000010
          BCS LCE41
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          ROL A
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          ROL A
          ROL A
LCE22     ROL A
          ROL A
          ROL A
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $02    ;%00000010
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          CPY $B3
          BIT $26
          ROL $26
          .BYTE $FF    ;%11111111
          DEC $B2
          .BYTE $72    ;%01110010 'r'
          ROR $686C
          ROR $646C
          PLA
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          LDA ($1C),Y
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          PHP
          PHP
          PHP
          PHP
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $02    ;%00000010
          CLV
          ASL $0806
          LDA $B802,Y
          .BYTE $14    ;%00010100
          .BYTE $12    ;%00010010
          ASL $02B9
          .BYTE $FF    ;%11111111
          INY
          BCS LCEB1
          ROL $3E3C,X
          .BYTE $42    ;%01000010 'B'
          LSR $42
          LSR $4C
          BVC LCECB
          BVC LCED1
          .BYTE $54    ;%01010100 'T'
          BVC LCED8
          .BYTE $FF    ;%11111111
          .BYTE $C3    ;%11000011
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          CLC
          .BYTE $02    ;%00000010
          CLC
          CLC
          CLC
          CLC
          CLC
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
LCEB1     .BYTE $02    ;%00000010
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          LDY $06,X
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
          BCS LCEC5
          .BYTE $02    ;%00000010
          ASL $06
          .BYTE $B2    ;%10110010
          ASL $00
LCEC5     .BYTE $C2    ;%11000010
          LDY $20,X
          ROL A
          PLP
          ROL $FF
          JSR $C220
          BCS LCF05
LCED1     .BYTE $3C    ;%00111100 '<'
          .BYTE $42    ;%01000010 'B'
          JMP $54B2
          BVC LCF24
LCED8     .BYTE $B3    ;%10110011
          .BYTE $42    ;%01000010 'B'
          .BYTE $3C    ;%00111100 '<'
          .BYTE $B3    ;%10110011
          LSR $B2
          .BYTE $34    ;%00110100 '4'
          LDA ($4C),Y
          BCS LCF25
          .BYTE $3C    ;%00111100 '<'
          .BYTE $B3    ;%10110011
          SEC
          LSR $FF
          .BYTE $C2    ;%11000010
          .BYTE $B3    ;%10110011
          SEC
          .BYTE $B2    ;%10110010
          .BYTE $3C    ;%00111100 '<'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          BMI LCF29
          .BYTE $34    ;%00110100 '4'
          .BYTE $44    ;%01000100 'D'
          SEC
          .BYTE $34    ;%00110100 '4'
          .BYTE $42    ;%01000010 'B'
          LDA ($3A),Y
          RTI
          .BYTE $B2    ;%10110010
          LSR $3E
          ROL $C8FF,X
          .BYTE $B2    ;%10110010
          .BYTE $34    ;%00110100 '4'
          .BYTE $42    ;%01000010 'B'
          JMP $FF42
LCF05     .BYTE $C3    ;%11000011
          LDY $4C,X
          .BYTE $B3    ;%10110011
          BVC LCF61
          LDY $54,X
          .BYTE $B3    ;%10110011
          LSR $5C,X
          .BYTE $FF    ;%11111111
          INY
          LDA ($5A),Y
          .BYTE $42    ;%01000010 'B'
          LSR $42,X
          .BYTE $54    ;%01010100 'T'
          .BYTE $42    ;%01000010 'B'
          BVC LCF5D
          LSR $3E,X
          .BYTE $54    ;%01010100 'T'
          ROL $3E4C,X
          BVC LCF61
          .BYTE $FF    ;%11111111
LCF24     .BYTE $C3    ;%11000011
LCF25     BCS LCF69
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
LCF29     .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3A    ;%00111010 ':'
          ROL $3E02,X
          ROL $3E3E,X
          ROL $FF02,X
          .BYTE $C2    ;%11000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          LDY $2A,X
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
LCF5D     BCS LCF89
          .BYTE $02    ;%00000010
          ROL A
LCF61     ROL A
          .BYTE $B2    ;%10110010
          ROL A
          DEX
          BCS LCF6B
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
LCF69     ORA ($01,X)
LCF6B     ORA ($04,X)
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ORA ($04,X)
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ORA ($FF,X)
          CPX #$B2
          .BYTE $04    ;%00000100
          .BYTE $07    ;%00000111
          .BYTE $FF    ;%11111111
          INY
          LDA ($04),Y
          BCS LCF85
          .BYTE $04    ;%00000100
          LDA ($04),Y
          BCS LCF8A
          .BYTE $04    ;%00000100
          LDA ($04),Y
LCF89     BCS LCF8F
          .BYTE $04    ;%00000100
          LDA ($07),Y
          BCS LCF94
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          BNE LCF46
LCF94     .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          CPX #$B1
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          CPX #$B0
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          LDA ($07),Y
          BCS LCFAD
          .BYTE $04    ;%00000100
          LDA ($07),Y
          .BYTE $FF    ;%11111111
          INY
          BCS LCFAE
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ORA ($01,X)
LCFAE     ORA ($04,X)
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ORA ($04,X)
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ORA ($FF,X)
          LDY $07,X
          .BYTE $B2    ;%10110010
          ORA ($B0,X)
          .BYTE $07    ;%00000111
          ORA ($07,X)
          .BYTE $07    ;%00000111
          .BYTE $B2    ;%10110010
          .BYTE $07    ;%00000111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .END

;auto-generated symbols and labels
 LCC42      $CC42
 LCC57      $CC57
 LCC5E      $CC5E
 LCC94      $CC94
 LCC99      $CC99
 LCC4E      $CC4E
 LCC82      $CC82
 LCCD7      $CCD7
 LCCF1      $CCF1
 LCCF7      $CCF7
 LCCFE      $CCFE
 LCD1B      $CD1B
 LCD15      $CD15
 LCD2B      $CD2B
 LCD5B      $CD5B
 LCD55      $CD55
 LCDAD      $CDAD
 LCDE5      $CDE5
 LCDE3      $CDE3
 LCE0D      $CE0D
 LCE16      $CE16
 LCE22      $CE22
 LCE41      $CE41
 LCEB1      $CEB1
 LCECB      $CECB
 LCED1      $CED1
 LCED8      $CED8
 LCEC5      $CEC5
 LCF05      $CF05
 LCF24      $CF24
 LCF25      $CF25
 LCF29      $CF29
 LCF61      $CF61
 LCF5D      $CF5D
 LCF69      $CF69
 LCF89      $CF89
 LCF6B      $CF6B
 LCF85      $CF85
 LCF8A      $CF8A
 LCF8F      $CF8F
 LCF94      $CF94
 LCF46      $CF46
 LCFAD      $CFAD
 LCFAE      $CFAE

