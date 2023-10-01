
fnt     equ fnt_txt1
text    equ text_over

pmg     equ pmg_over

color_nr equ 14


ant dta d'pppppp'
 dta $44,a(text)
 dta $84,4,$84,4,$84,$84,4,$84,4,4,$84,4,4,4,4
 dta $41,a(ant)


main

 hax #pmg-1
 jsr decode

;-- init PMG
 mva >pmBase_Text $d407	;PMCTL - wyswietlac duchy i pociski
 mva #3 $d01d		;PMCTL - show PMG

 mwa #dli1 dliv+1

 mwa #nmi $fffa		;nasza nowa obsluga przerwania NMI

 mva #$c0 $d40e		;wlaczenie NMI z przerwaniami DLI


 jsr logo.fade_in

 ldx #=over_msx
 jsr switch_bank

 jsr $4400-3

 lda #$fe
 sta $d301
 
 jsr logo.fade_out

 jsr default_nmi
 rts


;--
;-- dli program

dli1
 lda #$83
 sta $d40a                   ;line=64
 sta Missile2_PositionX
 sta $d40a                   ;line=65
 sta $d40a                   ;line=66
 sta $d40a                   ;line=67
 lda #$6E
 sta $d40a                   ;line=68
 sta Missile2_PositionX
; sta $d40a                   ;line=69
; sta $d40a                   ;line=70
; sta $d40a                   ;line=71

 max #dli1_2
 jmp nmiQ
 
 
dli1_2
; sta $d40a                   ;line=72
; sta $d40a                   ;line=73
; sta $d40a                   ;line=74
; sta $d40a                   ;line=75
; sta $d40a                   ;line=76
; sta $d40a                   ;line=77
; sta $d40a                   ;line=78
; sta $d40a                   ;line=79
 lda #$83
 sta $d40a                   ;line=80
 sta Missile2_PositionX
 sta $d40a                   ;line=81
 lda #$7A
 ldx #$6F
 sta $d40a                   ;line=82
 sta Player1_PositionX
 stx Missile2_PositionX
 sta $d40a                   ;line=83
 sta $d40a                   ;line=84
 lda #$01
 ldx #$84
 sta $d40a                   ;line=85
 sta Player1_Size
 stx Player1_PositionX
; sta $d40a                   ;line=86
; sta $d40a                   ;line=87

 max #dli1_3
 jmp nmiQ


dli1_3 
; sta $d40a                   ;line=88
; sta $d40a                   ;line=89
; sta $d40a                   ;line=90
; sta $d40a                   ;line=91
; sta $d40a                   ;line=92
; sta $d40a                   ;line=93
; sta $d40a                   ;line=94
; sta $d40a                   ;line=95
 sta $d40a                   ;line=96
 sta $d40a                   ;line=97
 sta $d40a                   ;line=98
 sta $d40a                   ;line=99
 lda #$70
 sta $d40a                   ;line=100
 sta Missile2_PositionX
; sta $d40a                   ;line=101
; sta $d40a                   ;line=102
; sta $d40a                   ;line=103

 max #dli1_4
 jmp nmiQ
 
 
dli1_4

 sta $d40a                   ;line=104
 lda #$6D
 sta $d40a                   ;line=105
 sta Missile2_PositionX
; sta $d40a                   ;line=106
; sta $d40a                   ;line=107
; sta $d40a                   ;line=108
; sta $d40a                   ;line=109
; sta $d40a                   ;line=110
; sta $d40a                   ;line=111

 max #dli1_5
 jmp nmiQ


dli1_5

; sta $d40a                   ;line=112
; sta $d40a                   ;line=113
; sta $d40a                   ;line=114
; sta $d40a                   ;line=115
; sta $d40a                   ;line=116
; sta $d40a                   ;line=117
; sta $d40a                   ;line=118
; sta $d40a                   ;line=119
 sta $d40a                   ;line=120
 sta $d40a                   ;line=121
 sta $d40a                   ;line=122
 sta $d40a                   ;line=123
 sta $d40a                   ;line=124
 lda #$39
c8 ldx #$0C
 sta $d40a                   ;line=125
 sta Player2_PositionX
 stx Player2_Missile2_Color2_PM2
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127


 sta $d40a                   ;line=128
 lda #$9D
 sta $d40a                   ;line=129
 sta Missile3_PositionX
 sta $d40a                   ;line=130
 sta $d40a                   ;line=131
 lda #$03
c9 ldx #$0C
 sta $d40a                   ;line=132
 sta Player1_Size
 stx Player1_Missile1_Color1_PM1
 sta $d40a                   ;line=133
 sta $d40a                   ;line=134
 sta $d40a                   ;line=135
c10 lda #$0C
 sta $d40a                   ;line=136
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=137
 lda #$03
 ldx #$A9
 ldy #$89
 sta $d40a                   ;line=138
 sta Player3_Size
 stx Player1_PositionX
 sty Player3_PositionX
 
 max #dli2
 jmp nmiQ



dli2

 lda >fnt+$400*$01
c11 ldx #$6A
c12 ldy #$84
 sta $d40a                   ;line=144
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c13 lda #$78
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=145
 sta $d40a                   ;line=146
 sta $d40a                   ;line=147
 lda #$58
 ldx #$A8
 ldy #$38
 sta $d40a                   ;line=148
 sta Player0_PositionX
 stx Player1_PositionX
 sty Player2_PositionX
 lda #$88
 sta Player3_PositionX
 sta $d40a                   ;line=149
 sta $d40a                   ;line=150
 sta $d40a                   ;line=151


 sta $d40a                   ;line=152
 sta $d40a                   ;line=153
 sta $d40a                   ;line=154
 sta $d40a                   ;line=155
 lda #$87
 ldx #$5F
 ldy #$64
 sta $d40a                   ;line=156
 sta Player3_PositionX
 stx Missile0_PositionX
 sty Missile3_PositionX
 sta $d40a                   ;line=157
 sta $d40a                   ;line=158
 lda #$54
 sta $d40a                   ;line=159
 sta Missile2_PositionX

 
 sta $d40a                   ;line=160
 sta $d40a                   ;line=161
 lda #$A0
 sta $d40a                   ;line=162
 sta Missile2_PositionX
 lda #$60
 sta $d40a                   ;line=163
 sta Missile0_PositionX
 lda #$39
 sta $d40a                   ;line=164
 sta Player2_PositionX
 sta $d40a                   ;line=165
 sta $d40a                   ;line=166
 sta $d40a                   ;line=167
 lda #$37
 sta $d40a                   ;line=168
 sta Player2_PositionX
 lda #$C4
 sta $d40a                   ;line=169
 sta Missile2_PositionX
 
 max #dli1
 jmp nmiQ



;--

nmi
 sta rejA
 stx rejX
 sty rejY

 bit $d40f
 bpl vbl

dliv jmp dli1

vbl
 sta $d40f		;reset znacznika przerwania $d40f

 mwa #ant $d402		;adres programu ANTICA ($d402,$d403)
 mva #scr40 $d400	;ustawienie szerokosci obrazu $d400
 
 inc $14

;-- init pierwszej linii

 lda >fnt+$400*$00
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$1A
 sta Playfield_Color0_PF0
c2 lda #$E4
 sta Playfield_Color1_PF1
c3 lda #$F8
 sta Playfield_Color2_PF2
c4 lda #$14
 sta Playfield_Color3_PF3
 
 lda #$04
 sta PRIOR_GTIACTL

 lda #$03
 sta Player0_Size
 sta Player2_Size
 
 lda #$00
 sta Player3_Size
 sta Missiles_Size
 sta Player1_Size
  
 lda #$59
 sta Player0_PositionX
 lda #$91
 sta Player1_PositionX
 lda #$67
 sta Player2_PositionX
 lda #$79
 sta Player3_PositionX
 lda #$5C
 sta Missile0_PositionX
 lda #$7F
 sta Missile2_PositionX
 lda #$72
 sta Missile3_PositionX
 
c5 lda #$0C
 sta Player0_Missile0_Color0_PM0
c6 lda #$1C
 sta Player1_Missile1_Color1_PM1
 sta Player2_Missile2_Color2_PM2
c7 lda #$14
 sta Player3_Missile3_Color3_PM3

 max #dli1              ;DLI ustawiamy na poczatek

nmiQ
 sta dliv+1
 stx dliv+2 

 lda rejA
 ldx rejX
 ldy rejY
 rti

;--

l_tcol
 dta l(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta l(c10,c11,c12,c13)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5,c6,c7,c8,c9)
 dta h(c10,c11,c12,c13)

t_satur .ds color_nr
t_color .ds color_nr
