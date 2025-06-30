          * = $C3F0
          ADC ($C4,X)
          AND $20B3
          CPX $6E
          LDA #$0B
          STA $00
          LDA #$C4
          STA $01
          JSR $94BC
          JSR $D060
          JSR $B310
          JMP LC425
          AND ($D4,X)
          ORA ($F3,X)
          AND ($E9,X)
          ASL $A7A6
          TAY
          LDA #$FF
          TAX
          .BYTE $AB    ;%10101011
          LDY $AEAD
          .BYTE $AF    ;%10101111
          .BYTE $F2    ;%11110010
          .BYTE $F4    ;%11110100
          SBC $23,X
          BNE LC483
          BRK
          BRK
LC425     JSR $B32D
          LDX #$E6
          LDY #$B3
          JSR $B2B6
          JSR LC568
          LDY $B41F
          LDA $B41D
          STA $C612,Y
          TYA
          ASL A
          ASL A
          ASL A
          ASL A
          TAX
          LDY #$00
LC443     LDA $B410,Y
          STA $C5E2,X
          INX
          INY
          CPY #$10
          BNE LC443
          LDX #$EC
          LDY #$B3
          LDA #$0E
          JSR $B22B
          LDX #$EA
          LDY #$B3
          LDA $B41C
          BNE LC465
          LDX #$E8
          LDY #$B3
LC465     JSR $B2B6
          JMP ($DFFC)
          PHA
          PHA
          CPY #$02
          BEQ LC4AB
          LDA $B41F
          PHA
          LDA #$02
          STA $B41F
LC47A     JSR LC50B
          JSR LC516
          LDA #$00
          STA $C3C0,Y
          STA $C3C1,Y
          STA $C3C2,Y
          LDA $B41F
          STA $C3C3,Y
          DEC $B41F
          BPL LC47A
          PLA
          STA $B41F
          JSR LC50B
          JSR LC4F6
          LDA #$01
          STA $B41E
          LDY $C50A
          STA $C3CE,Y
LC4AB     JSR LC50B
          LDA $B41E
          BPL LC4C0
          AND #$01
          STA $B41E
          JSR LC516
          LDA #$01
          STA $C3C2,Y
LC4C0     LDA $1E
          CMP #$01
          BEQ LC4E6
          LDA $6E
          JSR LC53B
          LDY #$3F
LC4CD     LDA $B420,Y
          STA ($00),Y
          DEY
          BPL LC4CD
          LDY $C50A
          LDX #$00
LC4DA     LDA $B410,X
          STA $C3C0,Y
          INY
          INX
          CPX #$10
          BNE LC4DA
LC4E6     PLA
          JSR LC53B
          LDY #$3F
LC4EC     LDA ($00),Y
          STA $B420,Y
          DEY
          BPL LC4EC
          BMI LC4F7
LC4F6     PHA
LC4F7     LDY $C50A
          LDX #$00
LC4FC     LDA $C3C0,Y
          STA $B410,X
          INY
          INX
          CPX #$10
          BNE LC4FC
          PLA
          RTS
          BRK
LC50B     LDA $B41F
          ASL A
          ASL A
          ASL A
          ASL A
          STA $C50A
          RTS
LC516     LDA #$00
          JSR LC53B
          INC $03
          LDY #$00
          TYA
LC520     STA ($00),Y
          CPY #$40
          BCS LC528
          STA ($02),Y
LC528     INY
          BNE LC520
          LDY $C50A
          LDX #$00
          TXA
LC531     STA $C3C0,Y
          INY
          INX
          CPX #$0C
          BNE LC531
          RTS
LC53B     PHA
          LDX $B41F
          LDA $C562,X
          STA $00
          STA $02
          LDA $C565,X
          STA $01
          STA $03
          PLA
          AND #$0F
          TAX
          BEQ LC561
LC553     LDA $00
          CLC
          ADC #$40
          STA $00
          BCC LC55E
          INC $01
LC55E     DEX
          BNE LC553
LC561     RTS
          BRK
          RTI
          .BYTE $80    ;%10000000
          CPY #$C1
          .BYTE $C2    ;%11000010
LC568     LDY $B41C
          BNE LC56E
          RTS
LC56E     LDY $B41D
          BNE LC585
          BEQ LC584
LC575     LDA #$00
          CMP $B419
          BCC LC589
          LDA $C597,Y
          CMP $B418
          BCC LC589
LC584     INY
LC585     CPY #$05
          BNE LC575
LC589     STY $B41D
          LDY #$00
          TYA
LC58F     STA $B410,Y
          INY
          CPY #$0C
          BNE LC58F
          RTS
          .BYTE $3C    ;%00111100 '<'
          ASL A
          .BYTE $04    ;%00000100
          .BYTE $02    ;%00000010
          ASL A
          BRK
          BCS $C5A7
          .END

;auto-generated symbols and labels
 LC425      $C425
 LC483      $C483
 LC568      $C568
 LC443      $C443
 LC465      $C465
 LC4AB      $C4AB
 LC50B      $C50B
 LC516      $C516
 LC47A      $C47A
 LC4F6      $C4F6
 LC4C0      $C4C0
 LC4E6      $C4E6
 LC53B      $C53B
 LC4CD      $C4CD
 LC4DA      $C4DA
 LC4EC      $C4EC
 LC4F7      $C4F7
 LC4FC      $C4FC
 LC528      $C528
 LC520      $C520
 LC531      $C531
 LC561      $C561
 LC55E      $C55E
 LC553      $C553
 LC56E      $C56E
 LC585      $C585
 LC584      $C584
 LC589      $C589
 LC575      $C575
 LC58F      $C58F

