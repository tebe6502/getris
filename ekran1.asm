
  ?old_dli = *

dli
 :5 cmp $ffff
 cmp $ffff

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

 jsr wait60cycle

; line=10

 jsr wait60cycle

; line=11

 jsr wait24cycle
c40 lda #$78
 sta $d017
c41 ldx #$18
 stx $d017
 :2 nop
 nop
 nop
 sta $d017
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=12

 jsr wait60cycle

; line=13

 lda #$46
c9 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=14

 jsr wait60cycle

; line=15

 lda #$45
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=16

 jsr wait24cycle
 cmp $00

; line=17

 jsr wait60cycle

; line=18

 jsr wait60cycle

; line=19

 jsr wait60cycle

; line=20

 jsr wait60cycle

; line=21

 jsr wait60cycle

; line=22

 lda #$44
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=23

 jsr wait60cycle

; line=24

 lda #$F7
 ldx #$4B
 ldy #$00
 sta Missiles_Size
 stx Missile1_PositionX
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=25

 jsr wait60cycle

; line=26

 lda #$4C
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=27
; jsr wait60cycle
; line=28
; jsr wait60cycle
; line=29
; jsr wait60cycle
; line=30
; jsr wait60cycle
; line=31
; jsr wait60cycle

 lda #$45
 sta Player1_PositionX
 
 dli_quit dli1_2



; line=40
dli1_2
 
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

 lda #$46
; ldx #$00
; ldy #$00
 sta Player1_PositionX
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=43
; jsr wait60cycle

; line=44
; jsr wait60cycle

; line=45
; jsr wait60cycle

; line=46
; jsr wait60cycle

; line=47
; jsr wait60cycle

 dli_quit dli1_48



dli1_48

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

 jsr wait60cycle

; line=51

 jsr wait60cycle

; line=52

c10 lda #$D8
 ldx #$45
; ldy #$00
 sta Playfield_Color1_PF1
 stx Player1_PositionX
; sty $d01e
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=53
; jsr wait60cycle

; line=54
; jsr wait60cycle

; line=55
; jsr wait60cycle

 dli_quit dli1_56


dli1_56

; line=56
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

; line=57

 jsr wait60cycle

; line=58

 lda #$F3
 ldx #$44
 ldy #$00
 sta Missiles_Size
 stx Player1_PositionX
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=59

 jsr wait60cycle

; line=60

 jsr wait60cycle

; line=61

 jsr wait60cycle

; line=62

 jsr wait60cycle

; line=63

 jsr wait60cycle

; line=64

c11 lda #$B4
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=65

 jsr wait60cycle

; line=66

 jsr wait60cycle

; line=67

 jsr wait60cycle

; line=68

 lda #$60
c12 ldx #$54
 ldy #$00
 sta Missile1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c42 lda #$D8
 sta $d017
c43 ldy #$18
 sty $d017
 :2 nop
 sta $d017
 lda #$00
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=69

 jsr wait60cycle

; line=70

 jsr wait60cycle

; line=71

 jsr wait60cycle

; line=72

c13 lda #$54
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

/*
 lda #$47
c14 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle
*/

 dli_quit dli1_80


dli1_80

; line=80

 lda >fnt+$400*$02
 ldx #$47
c14 ldy #$18
 sta $d40a
 sta CHARBASE
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
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

 jsr wait60cycle

; line=87

 lda #$43
; ldx #$00
; ldy #$00
 sta Player1_PositionX
; stx $d01e
; sty $d01e
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=88

; jsr wait24cycle
; cmp $00
 
 dli_quit dli1_3


; line=112
dli1_3

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

; line=113

 jsr wait60cycle

; line=114

c15 lda #$54
 ldx #$00
 ldy #$00
 sta Player1_Missile1_Color1_PM1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=115

 lda #$30
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c44 lda #$D8
 sta $d017
c45 ldy #$18
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

c16 lda #$34
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c46 lda #$D8
 sta $d017
c47 ldy #$18
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

 jsr wait24cycle
c48 lda #$D8
 sta $d017
c49 ldy #$18
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
c50 lda #$D8
 sta $d017
c51 ldy #$18
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

 lda #$01
 ldx #$42
c17 ldy #$18
 sta Player1_Size
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
c52 lda #$D8
 sta $d017
c53 ldy #$18
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

 jsr wait24cycle
 cmp $00

; line=121

 jsr wait24cycle
c54 lda #$D8
 sta $d017
c55 ldy #$18
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
c56 lda #$D8
 sta $d017
c57 ldy #$18
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

 jsr wait24cycle
c58 lda #$D8
 sta $d017
c59 ldy #$18
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
c60 lda #$D8
 sta $d017
c61 ldy #$18
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
c62 lda #$D8
 sta $d017
c63 ldy #$18
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

 jsr wait24cycle
c64 lda #$D8
 sta $d017
c65 ldy #$18
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

 jsr wait24cycle
c66 lda #$D8
 sta $d017
c67 ldy #$18
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

 lda >fnt+$400*$03
 ldx #$00
 ldy #$00
 sta CHARBASE
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=129

 lda #$3C
c18 ldx #$54
 ldy #$00
 sta Missile1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c68 lda #$D8
 sta $d017
c69 ldy #$18
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
c70 lda #$D8
 sta $d017
c71 ldy #$18
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
c72 lda #$D8
 sta $d017
c73 ldy #$18
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
c74 lda #$D8
 sta $d017
c75 ldy #$18
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
c76 lda #$D8
 sta $d017
c77 ldy #$18
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
c78 lda #$D8
 sta $d017
c79 ldy #$18
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

c19 lda #$54
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c80 lda #$D8
 sta $d017
c81 ldy #$18
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

 lda #$00
 ldx #$43
c20 ldy #$18
 sta Player1_Size
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
 cmp $00

; line=137

 jsr wait24cycle
c82 lda #$D8
 sta $d017
c83 ldy #$18
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

c21 lda #$F8
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c84 lda #$D8
 sta $d017
c85 ldy #$18
 sty $d017
 :2 nop
 sta $d017
c86 lda #$00
 nop
c87 lda #$F8
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

 dli_quit dli1_144



dli1_144
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
c88 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c89 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$00
 sta $d01e

; line=147

 jsr wait24cycle
c90 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c91 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$00
 sta $d01e

; line=148

 jsr wait24cycle
c92 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c93 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$00
 sta $d01e

; line=149

 jsr wait24cycle
c94 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c95 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$00
 sta $d01e

; line=150

 jsr wait24cycle
c96 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c97 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$00
 sta $d01e

; line=151

c22 lda #$56
 ldx #$5B
c23 ldy #$78
 sta Playfield_Color3_PF3
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
c98 lda #$54
 sta $d019
 lda #$00
 sta $d01e
c99 ldx #$74
 :2 nop
 lda #$00
 sta $d01e
 lda #$00
 stx $d019
 lda #$54
 :2 nop

; line=152

c24 lda #$54
 ldx #$00
 ldy #$00
 sta Playfield_Color3_PF3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=153

 jsr wait24cycle
c100 lda #$18
 sta $d017
c101 ldy #$78
c102 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=154

 jsr wait24cycle
c103 lda #$18
 sta $d017
c104 ldy #$78
c105 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=155

 jsr wait24cycle
c106 lda #$18
 sta $d017
c107 ldy #$78
c108 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=156

 jsr wait24cycle
c109 lda #$18
 sta $d017
c110 ldy #$78
c111 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=157

 jsr wait24cycle
c112 lda #$18
 sta $d017
c113 ldy #$78
c114 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=158

 jsr wait24cycle
c115 lda #$18
 sta $d017
c116 ldy #$78
c117 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=159

 jsr wait24cycle
c118 lda #$18
 sta $d017
c119 ldy #$78
c120 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=160

 lda #$44
c25 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=161

 lda #$5B
c26 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c121 lda #$18
 sta $d017
c122 ldy #$78
c123 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=162

 jsr wait24cycle
c124 lda #$18
 sta $d017
c125 ldy #$78
c126 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=163

 jsr wait24cycle
c127 lda #$18
 sta $d017
c128 ldy #$78
c129 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=164

 jsr wait24cycle
c130 lda #$18
 sta $d017
c131 ldy #$78
c132 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=165

 jsr wait24cycle
c133 lda #$18
 sta $d017
c134 ldy #$78
c135 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=166

 jsr wait24cycle
c136 lda #$18
 sta $d017
c137 ldy #$78
c138 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=167

 jsr wait24cycle
c139 lda #$18
 sta $d017
c140 ldy #$78
c141 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=168

 lda #$42
c27 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=169

 lda #$5B
c28 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c142 lda #$18
 sta $d017
c143 ldy #$78
c144 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=170

 jsr wait24cycle
c145 lda #$18
 sta $d017
c146 ldy #$78
c147 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=171

 jsr wait24cycle
c148 lda #$18
 sta $d017
c149 ldy #$78
c150 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=172

 jsr wait24cycle
c151 lda #$18
 sta $d017
c152 ldy #$78
c153 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
; nop
; lda #$00
; sta $d01e
; lda #$00
; sta $d01e

; line=173
; jsr wait60cycle

; line=174
; jsr wait60cycle

; line=175
; jsr wait60cycle

 dli_quit dli1_176



dli1_176
; line=176

 lda >fnt+$400*$04
 ldx #$00
 ldy #$00
 sta $d40a
 sta CHARBASE
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=177

 lda #$B0
 ldx #$B9
c29 ldy #$0A
 sta Player1_PositionX
 stx Missile1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=178

 jsr wait60cycle

; line=179

 jsr wait60cycle

; line=180

 jsr wait60cycle

; line=181

 jsr wait60cycle

; line=182

 lda #$B2
 ldx #$4E
c30 ldy #$54
 sta Player1_PositionX
 stx Missile1_PositionX
 sty Player1_Missile1_Color1_PM1
; lda #$00
; sta $d01e
; jsr wait36cycle

; line=183
; jsr wait60cycle

 dli_quit dli1_184



dli1_184

; line=184

 lda #$43
 ldx #$00
 ldy #$00
 sta $d40a
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
; sta $d01e
 cmp $00

; line=185

 jsr wait60cycle

; line=186

 lda #$44
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=187

 jsr wait24cycle
c154 lda #$18
 sta $d017
c155 ldy #$78
c156 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=188

 lda #$B2
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c157 lda #$18
 sta $d017
c158 ldy #$78
c159 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=189

 jsr wait24cycle
c160 lda #$18
 sta $d017
c161 ldy #$78
c162 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=190

 lda #$4E
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c163 lda #$18
 sta $d017
c164 ldy #$78
c165 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=191

 jsr wait24cycle
c166 lda #$18
 sta $d017
c167 ldy #$78
c168 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=192

 lda #$43
c31 ldx #$18
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
 cmp $00

; line=193

 jsr wait24cycle
c169 lda #$18
 sta $d017
c170 ldy #$78
c171 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=194

 lda #$4B
c32 ldx #$54
 ldy #$00
 sta Missile1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c172 lda #$18
 sta $d017
c173 ldy #$78
c174 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=195

 lda #$57
c33 ldx #$78
 ldy #$00
 sta Player1_PositionX
 stx Player1_Missile1_Color1_PM1
 sty $d01e
 lda #$00
 sta $d01e
c175 lda #$18
 sta $d017
c176 ldy #$78
c177 ldx #$F8
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=196

c34 lda #$18
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c178 lda #$18
 sta $d017
c179 ldy #$78
c180 ldx #$18
 :2 nop
 sty $d017
 stx $d017
 nop
 lda #$00
 sta $d01e
 lda #$00
 sta $d01e

; line=197

 lda #$57
 ldx #$00
 ldy #$00
 sta Missile1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=198

 lda #$01
 ldx #$30
 ldy #$00
 sta Player1_Size
 stx Player1_PositionX
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=199

 jsr wait60cycle

; line=200

 jsr wait24cycle
 cmp $00

; line=201

 jsr wait60cycle

; line=202

 jsr wait60cycle

; line=203

 jsr wait60cycle

; line=204

 jsr wait60cycle

; line=205

 jsr wait60cycle

; line=206

 jsr wait60cycle

; line=207

 jsr wait60cycle

; line=208

 lda >fnt+$400*$05
 ldx #$00
 ldy #$37
 sta CHARBASE
 stx Player1_Size
 sty Player1_PositionX
c35 lda #$48
 sta Player2_Missile2_Color2_PM2
 cmp $00

; line=209

c36 lda #$34
 ldx #$00
 ldy #$00
 sta Playfield_Color1_PF1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=210

 lda #$3F
 ldx #$00
 ldy #$00
 sta Player1_PositionX
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=211

 jsr wait60cycle

; line=212

 jsr wait60cycle

; line=213

 jsr wait60cycle

; line=214

 jsr wait60cycle

; line=215

 jsr wait60cycle

; line=216

c37 lda #$28
c38 ldx #$3A
c39 ldy #$14
 sta Playfield_Color0_PF0
 stx Playfield_Color2_PF2
 sty Player1_Missile1_Color1_PM1
; lda #$00
; sta $d01e
; cmp $00
 
; jsr wait60cycle
 
 dli_quit ekran2.dli

;-- tutaj nasze tablice (pliki) z programu Graph2Font

text equ text1
fnt  equ fnt1
