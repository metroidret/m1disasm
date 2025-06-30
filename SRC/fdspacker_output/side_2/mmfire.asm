          * = $DEA0
          .BYTE $C3    ;%11000011
          LDX $26,Y
          .BYTE $B3    ;%10110011
          .BYTE $22    ;%00100010 '"'
          .BYTE $B2    ;%10110010
          BIT $26B6
          LDY $22,X
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          LDX $30,Y
          .BYTE $34    ;%00110100 '4'
          .BYTE $B3    ;%10110011
          .BYTE $3A    ;%00111010 ':'
          LDA ($38),Y
          .BYTE $34    ;%00110100 '4'
          LDY $2A,X
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B3    ;%10110011
          ROL A
          .BYTE $B2    ;%10110010
          ROL $26B3
          .BYTE $B2    ;%10110010
          ROL A
          LDX $22,Y
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $C3    ;%11000011
          LDX $1E,Y
          .BYTE $B3    ;%10110011
          .BYTE $1A    ;%00011010
          .BYTE $B2    ;%10110010
          BIT $B6
          ASL $1AB4,X
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          LDX $26,Y
          ROL A
          BMI $DE89
          JSR $B61C
          JSR $C2FF
          LDA ($20),Y
          .BYTE $12    ;%00010010
          ASL $20,X
          .BYTE $B2    ;%10110010
          BIT $B1
          .BYTE $1C    ;%00011100
          ASL $1C12
          .BYTE $B2    ;%10110010
          JSR $18B1
          .BYTE $12    ;%00010010
          .BYTE $14    ;%00010100
          CLC
          .BYTE $14    ;%00010100
          LDX $12,Y
          LDA ($02),Y
          .BYTE $FF    ;%11111111
          .BYTE $C3    ;%11000011
          LDA ($34),Y
          .BYTE $02    ;%00000010
          ROL $4202,X
          .BYTE $02    ;%00000010
          .BYTE $B3    ;%10110011
          BMI LDEB3
          .BYTE $3A    ;%00111010 ':'
          .BYTE $02    ;%00000010
          .BYTE $B2    ;%10110010
          .BYTE $34    ;%00110100 '4'
          .BYTE $B3    ;%10110011
          .BYTE $02    ;%00000010
          BMI LDF0C
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
LDF0C     .BYTE $B2    ;%10110010
          .BYTE $22    ;%00100010 '"'
          BMI LDF44
          ROL $34
          SEC
          BIT $3A34
          .BYTE $B3    ;%10110011
          CLC
          .BYTE $B2    ;%10110010
          ROL A
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B3    ;%10110011
          .BYTE $1C    ;%00011100
          .BYTE $B2    ;%10110010
          JSR $18B3
          .BYTE $B2    ;%10110010
          .BYTE $1C    ;%00011100
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $02    ;%00000010
          LDX $02,Y
          .BYTE $FF    ;%11111111
          CPX #$B2
          ORA ($04,X)
          .BYTE $04    ;%00000100
          ORA ($04,X)
          .BYTE $04    ;%00000100
          LDX $04,Y
          .BYTE $04    ;%00000100
          .BYTE $B2    ;%10110010
          ORA ($FF,X)
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $42    ;%01000010 'B'
          ROL $B342,X
LDF44     .BYTE $44    ;%01000100 'D'
          .BYTE $B2    ;%10110010
          .BYTE $3A    ;%00111010 ':'
          LDA $443A,Y
          PHA
          LDY $4C,X
          .BYTE $B3    ;%10110011
          PHA
          LSR $B6
          PHA
          LDA $4C4E,Y
          PHA
          .BYTE $B3    ;%10110011
          JMP $44B2
          LDA $4C44,Y
          .BYTE $52    ;%01010010 'R'
          LDY $54,X
          .BYTE $54    ;%01010100 'T'
          CPY $B4
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C3    ;%11000011
          .BYTE $B2    ;%10110010
          ROL $B9
          ROL $3E
          .BYTE $34    ;%00110100 '4'
          .BYTE $B2    ;%10110010
          ROL $B9
          ROL $34
          ROL $B2
          BIT $2CB9
          .BYTE $3A    ;%00111010 ':'
          BIT $2CB2
          LDA $3A2C,Y
          BIT $C4FF
          .BYTE $B2    ;%10110010
          ROL $B9
          .BYTE $34    ;%00110100 '4'
          ROL $26
          .BYTE $FF    ;%11111111
          BNE LDF42
          CLC
          ROL $18
          .BYTE $B2    ;%10110010
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
          ASL $1EB9,X
          CLC
          ASL $1EB2,X
          LDA $181E,Y
          ASL $1CB2,X
          LDA $141C,Y
          .BYTE $1C    ;%00011100
          .BYTE $B2    ;%10110010
          .BYTE $1C    ;%00011100
          LDA $141C,Y
          .BYTE $1C    ;%00011100
          .BYTE $FF    ;%11111111
          .BYTE $B2    ;%10110010
          ROL $12
          ASL $18,X
          .BYTE $1C    ;%00011100
          JSR $2624
          .BYTE $B2    ;%10110010
          PLP
          LDA $1E28,Y
          CLC
          .BYTE $B2    ;%10110010
          BPL LDF74
          BMI LDFE9
          PLP
          .BYTE $B2    ;%10110010
          ASL $181C,X
          .BYTE $14    ;%00010100
          ROL A
          ROL A
          ROL A
          ROL A
          CPY $2AB9
          .BYTE $FF    ;%11111111
          INX
          .BYTE $B2    ;%10110010
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          LDA $0404,Y
          .BYTE $04    ;%00000100
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
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          DEX
          LDA ($04),Y
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $07    ;%00000111
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
LDFE9     .BYTE $FF    ;%11111111
          CPX #$B4
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $17    ;%00010111
          CLC
          .END

;auto-generated symbols and labels
 LDEB3      $DEB3
 LDF0C      $DF0C
 LDF44      $DF44
 LDF42      $DF42
 LDF74      $DF74
 LDFE9      $DFE9

