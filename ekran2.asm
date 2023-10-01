
  ?old_dli = *

dli
 :5 cmp $ffff
 inc raster

 lda >fnt+$400*$00
; ldx #$00
; ldy #$00
 sta $d40a
 sta CHARBASE
c0 lda #$08
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3
; sta $d01e
 cmp $00

; line=9

 lda #$4E
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=10

 jsr wait24cycle
c44 lda #$78
 sta $d017
c45 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=11

 lda #$36
c9 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c46 lda #$78
 sta $d017
c47 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=12

 jsr wait24cycle
c48 lda #$78
 sta $d017
c49 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=13

 jsr wait24cycle
c50 lda #$78
 sta $d017
c51 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=14

 lda #$44
c10 ldx #$54
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c52 lda #$78
 sta $d017
c53 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=15

 jsr wait24cycle
c54 lda #$78
 sta $d017
c55 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=16

c11 lda #$18
 ldx #$00
 ldy #$00
 sta Player1_Missile1_Color1_PM1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=17

 jsr wait24cycle
c56 lda #$78
 sta $d017
c57 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=18

 jsr wait24cycle
c58 lda #$78
 sta $d017
c59 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=19

 jsr wait24cycle
c60 lda #$78
 sta $d017
c61 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=20

 lda #$4C
c12 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c62 lda #$78
 sta $d017
c63 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=21

 jsr wait24cycle
c64 lda #$78
 sta $d017
c65 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=22

 jsr wait24cycle
c66 lda #$78
 sta $d017
c67 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=23

 jsr wait24cycle
c68 lda #$78
 sta $d017
c69 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=24

 lda #$01
 ldx #$42
c13 ldy #$18
 sta Player1_Size
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
 cmp $00

; line=25

 lda #$00
 ldx #$44
 ldy #$00
 sta Player1_Size
 stx Player1_PositionX
 sty $d01e
 lda #$00
 sta $d01e
c70 lda #$78
 sta $d017
c71 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=26

 jsr wait24cycle
c72 lda #$78
 sta $d017
c73 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=27

 jsr wait24cycle
c74 lda #$78
 sta $d017
c75 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=28

 jsr wait24cycle
c76 lda #$78
 sta $d017
c77 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=29

 jsr wait24cycle
c78 lda #$78
 sta $d017
c79 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=30

 jsr wait24cycle
c80 lda #$78
 sta $d017
c81 ldx #$18
 stx $d017
 sta $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=31

 jsr wait24cycle
c82 lda #$78
 sta $d017
c83 ldx #$18
 stx $d017
 sta $d017
; nop
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e
 
 dli_quit dli2_2


; line=40
dli2_2

 lda >fnt+$400*$01
 ldx #$00
 ldy #$00
 sta $d40a
 sta CHARBASE
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=41

 jsr wait60cycle

; line=42

 jsr wait60cycle

; line=43

 jsr wait60cycle

; line=44

 lda #$47
c14 ldx #$0A
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=45

 jsr wait60cycle

; line=46

c15 lda #$18
; ldx #$00
; ldy #$00
 sta Player1_Missile1_Color1_PM1
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=47
; jsr wait60cycle

 dli_quit dli2_48



dli2_48

; line=48

 lda #$00
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=49

 jsr wait60cycle

; line=50

 lda #$46
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=51

 jsr wait60cycle

; line=52

c16 lda #$D8
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=53

 lda #$45
; ldx #$00
; ldy #$00
 sta Player1_PositionX
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=54
; jsr wait60cycle

; line=55
; jsr wait60cycle
 
 dli_quit dli2_56


 
dli2_56
; line=56
 lda #0
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e

; line=57

 jsr wait60cycle

; line=58

 jsr wait60cycle

; line=59

 jsr wait60cycle

; line=60

 jsr wait24cycle
c84 lda #$18
 sta $d017
c85 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=61

 jsr wait24cycle
c86 lda #$18
 sta $d017
c87 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=62

 jsr wait24cycle
c88 lda #$18
 sta $d017
c89 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=63

 jsr wait24cycle
c90 lda #$18
 sta $d017
c91 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=64

c17 lda #$B4
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=65

 jsr wait24cycle
c92 lda #$18
 sta $d017
c93 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=66

 jsr wait24cycle
c94 lda #$18
 sta $d017
c95 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=67

 lda #$5B
c18 ldx #$54
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c96 lda #$18
 sta $d017
c97 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=68

 jsr wait24cycle
c98 lda #$18
 sta $d017
c99 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=69

 jsr wait24cycle
c100 lda #$18
 sta $d017
c101 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=70

 jsr wait24cycle
c102 lda #$18
 sta $d017
c103 ldx #$D8
 sta $d01e
 lda #$00
 stx $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=71

 jsr wait60cycle

; line=72

c19 lda #$54
; ldx #$00
; ldy #$00
 sta Playfield_Color3_PF3
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; cmp $00

; line=73
; jsr wait60cycle

; line=74
; jsr wait60cycle

; line=75
; jsr wait60cycle

; line=76
; jsr wait60cycle

; line=77
; jsr wait60cycle

; line=78
; jsr wait60cycle

; line=79
; jsr wait60cycle

 dli_quit dli2_80


dli2_80
; line=80

 lda #$46
c20 ldx #$18
 ldy #$00
 sta $d40a
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=81

 jsr wait60cycle

; line=82

 jsr wait60cycle

; line=83

 jsr wait60cycle

; line=84

 jsr wait60cycle

; line=85

 jsr wait60cycle

; line=86

 lda #$44
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=87

 jsr wait60cycle

; line=88

 lda >fnt+$400*$02
; ldx #$00
; ldy #$00
 sta CHARBASE
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; cmp $00

 dli_quit dli2_3


; line=112
dli2_3

 lda #0
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e

; line=113

 jsr wait60cycle

; line=114

 jsr wait60cycle

; line=115

 jsr wait24cycle
c104 lda #$D8
 sta $d017
c105 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=116

c21 lda #$34
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c106 lda #$D8
 sta $d017
c107 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=117

 lda #$5C
 ldx #$30
c22 ldy #$54
 sta Player1_PositionX
 stx Missile1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
c108 lda #$D8
 sta $d017
c109 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=118

 jsr wait24cycle
c110 lda #$D8
 sta $d017
c111 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=119

 jsr wait24cycle
c112 lda #$D8
 sta $d017
c113 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=120

 lda #$01
 ldx #$3F
 ldy #$4E
 sta Player1_Size
 stx Player1_PositionX
 sty Missile1_PositionX
c23 lda #$18
 sta Player1_Missile1_Color1_PM1
 cmp $00

; line=121

 lda #$00
 ldx #$5C
 ldy #$30
 sta Player1_Size
 stx Player1_PositionX
 sty Missile1_PositionX
c24 lda #$54
 sta Player1_Missile1_Color1_PM1
c114 lda #$D8
 sta $d017
c115 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=122

 jsr wait24cycle
c116 lda #$D8
 sta $d017
c117 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=123

 lda #$3F
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c118 lda #$D8
 sta $d017
c119 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=124

 jsr wait24cycle
c120 lda #$D8
 sta $d017
c121 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=125

 jsr wait24cycle
c122 lda #$D8
 sta $d017
c123 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=126

 lda #$5C
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c124 lda #$D8
 sta $d017
c125 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=127

 lda #$3E
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c126 lda #$D8
 sta $d017
c127 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=128

 lda #$43
c25 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=129

 lda #$5C
c26 ldx #$54
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c128 lda #$D8
 sta $d017
c129 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=130

 jsr wait24cycle
c130 lda #$D8
 sta $d017
c131 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=131

 jsr wait24cycle
c132 lda #$D8
 sta $d017
c133 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=132

 jsr wait24cycle
c134 lda #$D8
 sta $d017
c135 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=133

 jsr wait24cycle
c136 lda #$D8
 sta $d017
c137 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=134

 jsr wait24cycle
c138 lda #$D8
 sta $d017
c139 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=135

c27 lda #$54
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c140 lda #$D8
 sta $d017
c141 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=136

 lda >fnt+$400*$03
 ldx #$00
 ldy #$00
 sta CHARBASE
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=137

 jsr wait24cycle
c142 lda #$D8
 sta $d017
c143 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=138

c28 lda #$F8
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c144 lda #$D8
 sta $d017
c145 ldy #$18
 sty $d017
 :2 nop
 sta $d017
c146 lda #$00
 nop
c147 lda #$F8
 sta $d017
; lda #$00
; sta $d01e

; line=139
; jsr wait60cycle

; line=140
; jsr wait60cycle

; line=141
; jsr wait60cycle

; line=142
; jsr wait60cycle

; line=143
; jsr wait60cycle

 dli_quit dli2_144


dli2_144
; line=144
; jsr wait24cycle
; cmp $00

 lda #$00
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=145

 jsr wait60cycle

; line=146

 jsr wait24cycle
c148 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c149 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=147

 jsr wait24cycle
c150 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c151 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=148

 jsr wait24cycle
c152 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c153 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=149

 jsr wait24cycle
c154 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c155 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=150

 jsr wait24cycle
c156 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c157 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=151

c29 lda #$56
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c158 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c159 lda #$74
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=152

c30 lda #$54
 ldx #$43
c31 ldy #$18
 sta Playfield_Color3_PF3
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
 cmp $00

; line=153

 jsr wait24cycle
c160 lda #$78
 sta $d017
c161 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=154

 jsr wait24cycle
c162 lda #$78
 sta $d017
c163 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=155

 jsr wait24cycle
c164 lda #$78
 sta $d017
c165 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=156

 jsr wait24cycle
c166 lda #$78
 sta $d017
c167 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=157

 jsr wait24cycle
c168 lda #$78
 sta $d017
c169 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=158

 jsr wait24cycle
c170 lda #$78
 sta $d017
c171 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=159

 jsr wait24cycle
c172 lda #$78
 sta $d017
c173 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=160

 jsr wait24cycle
 cmp $00

; line=161

 jsr wait24cycle
c174 lda #$78
 sta $d017
c175 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=162

 jsr wait24cycle
c176 lda #$78
 sta $d017
c177 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=163

 jsr wait24cycle
c178 lda #$78
 sta $d017
c179 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=164

 jsr wait24cycle
c180 lda #$78
 sta $d017
c181 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=165

 jsr wait24cycle
c182 lda #$78
 sta $d017
c183 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=166

 jsr wait24cycle
c184 lda #$78
 sta $d017
c185 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=167

 jsr wait24cycle
c186 lda #$78
 sta $d017
c187 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=168

 jsr wait24cycle
 cmp $00

; line=169

 jsr wait24cycle
c188 lda #$78
 sta $d017
c189 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=170

 jsr wait24cycle
c190 lda #$78
 sta $d017
c191 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=171

 jsr wait24cycle
c192 lda #$78
 sta $d017
c193 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=172

 jsr wait24cycle
c194 lda #$78
 sta $d017
c195 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=173

 jsr wait24cycle
c196 lda #$78
 sta $d017
c197 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
 cmp $00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=174

 jsr wait24cycle
c198 lda #$78
 sta $d017
c199 ldy #$F8
 cmp $00
 :2 nop
 sty $d017
; cmp $00
; nop
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e

; line=175
; jsr wait60cycle

 dli_quit dli2_176



dli2_176
; line=176

 lda #$00
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=177

 jsr wait24cycle
c200 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c201 lda #$0A
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=178

 jsr wait24cycle
c202 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c203 lda #$0A
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=179

 jsr wait24cycle
c204 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c205 lda #$0A
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=180

 jsr wait24cycle
c206 lda #$54
 sta $d019
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e
c207 lda #$0A
 sta $d019
 lda #$54
 :2 nop
 lda #$00
 sta $d01e

; line=181

; jsr wait24cycle
c208 lda #$54
 sta $d019
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e

; line=182
; jsr wait60cycle

; line=183
; jsr wait60cycle

 dli_quit dli2_184



dli2_184

; line=184

 lda >fnt+$400*$04
 ldx #$47
c32 ldy #$54
 sta $d40a
 sta CHARBASE
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
; sta $d01e
 cmp $00

; line=185

 jsr wait24cycle
c209 lda #$78
 sta $d017
c210 ldx #$18
c211 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=186

 lda #$43
c33 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c212 lda #$78
 sta $d017
c213 ldx #$18
c214 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=187

 jsr wait24cycle
c215 lda #$78
 sta $d017
c216 ldx #$18
c217 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=188

 jsr wait24cycle
c218 lda #$78
 sta $d017
c219 ldx #$18
c220 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=189

c34 lda #$0A
 ldx #$00
 ldy #$00
 sta Player1_Missile1_Color1_PM1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c221 lda #$78
 sta $d017
c222 ldx #$18
c223 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=190

 jsr wait24cycle
c224 lda #$78
 sta $d017
c225 ldx #$18
c226 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=191

 jsr wait24cycle
c227 lda #$78
 sta $d017
c228 ldx #$18
c229 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=192

 lda #$45
c35 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=193

 lda #$58
c36 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c230 lda #$78
 sta $d017
c231 ldx #$18
c232 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=194

 jsr wait24cycle
c233 lda #$78
 sta $d017
c234 ldx #$18
c235 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=195

 jsr wait24cycle
c236 lda #$78
 sta $d017
c237 ldx #$18
c238 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=196

c37 lda #$18
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c239 lda #$78
 sta $d017
c240 ldx #$18
c241 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=197

 jsr wait24cycle
c242 lda #$78
 sta $d017
c243 ldx #$18
c244 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=198

 jsr wait24cycle
c245 lda #$78
 sta $d017
c246 ldx #$18
c247 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=199

 jsr wait24cycle
c248 lda #$78
 sta $d017
c249 ldx #$18
c250 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=200

 lda #$43
c38 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=201

 jsr wait24cycle
c251 lda #$78
 sta $d017
c252 ldx #$18
c253 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=202

 jsr wait24cycle
c254 lda #$78
 sta $d017
c255 ldx #$18
c256 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=203

 jsr wait24cycle
c257 lda #$78
 sta $d017
c258 ldx #$18
c259 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=204

 jsr wait24cycle
c260 lda #$78
 sta $d017
c261 ldx #$18
c262 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=205

 jsr wait24cycle
c263 lda #$78
 sta $d017
c264 ldx #$18
c265 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=206

 jsr wait24cycle
c266 lda #$78
 sta $d017
c267 ldx #$18
c268 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=207

 jsr wait24cycle
c269 lda #$78
 sta $d017
c270 ldx #$18
c271 ldy #$F8
 stx $d017
 sta $d017
 sty $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=208
 
 lda #$68
c39 ldx #$48
 ldy #$00
 sta Player3_PositionX
 stx Player3_Missile3_Color3_PM3
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=209

c40 lda #$34
 ldx #$42
 ldy #$00
 sta Playfield_Color1_PF1
 stx Player1_PositionX
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=210

 jsr wait60cycle

; line=211

 jsr wait60cycle

; line=212

 jsr wait60cycle

; line=213

 jsr wait60cycle

; line=214

 jsr wait60cycle

; line=215

 lda #$40
c41 ldx #$14
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=216

 lda >fnt+$400*$05
c42 ldx #$28
c43 ldy #$3A
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color2_PF2
; lda #$00
; sta $d01e
; cmp $00

; jsr wait60cycle

 dli_quit ekran1.dli

;-- tutaj nasze tablice (pliki) z programu Graph2Font

fnt  equ fnt2
text equ text2
