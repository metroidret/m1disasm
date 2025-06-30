          * = $C000
          CLD
LC001     LDA $2002
          BPL LC001
          LDX #$00
          STX $2000
          STX $2001
          DEX
          TXS
          LDY #$07
          STY $01
          LDY #$00
          STY $00
          TYA
LC019     STA ($00),Y
          INY
          BNE LC019
          DEC $01
          BMI LC02E
          LDX $01
          CPX #$01
          BNE LC019
          INY
          INY
          INY
          INY
          BNE LC019
LC02E     JSR $941D
          JSR $6F3B
          LDY #$00
          STY $2005
          STY $2005
          INY
          STY $1D
          LDA #$90
          STA $2000
          STA $FF
          LDA #$02
          STA $FE
          LDA #$47
          STA $4025
          STA $73
          STA $FB
          STA $28
          JMP $9388
LC058     JSR $6EE4
          LDA #$6C
          STA $00
          LDA #$C0
          STA $01
          JSR $94BC
          JSR $D060
          JMP $B310
          AND ($D4,X)
          ORA ($5B,X)
          AND ($E9,X)
          ASL $4F0B
          .BYTE $5A    ;%01011010 'Z'
          BIT $FF
          .BYTE $3B    ;%00111011 ';'
          AND $3941
          RTI
          AND $3D,X
          SEC
          .BYTE $2F    ;%00101111 '/'
          BRK
          LDA #$01
          STA $70
          INC $1E
          LDA $14
          AND #$C0
          STA $F0
          JSR LC058
          JSR $6F3B
          LDA #$10
          JMP $B261
          CMP ($38,X)
          CMP ($40,X)
          CMP ($A9,X)
          .BYTE $02    ;%00000010
          STA $07F7
          JSR $C0F4
          BNE LC038
          JSR $C0CA
          BEQ LC0B2
          LDA #$00
          STA $D29F
LC0B2     LDA $D29F
          CLC
          ADC #$01
          CMP #$19
          BCC LC0BE
          LDA #$18
LC0BE     STA $009F
          .END

;auto-generated symbols and labels
 LC001      $C001
 LC019      $C019
 LC02E      $C02E
 LC058      $C058
 LC038      $C038
 LC0B2      $C0B2
 LC0BE      $C0BE

