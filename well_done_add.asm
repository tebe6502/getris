
text equ text_wellDone
pmg  equ pmg_wellDone
fnt  equ fnt_txt2

color_nr equ 7


ant dta $44,a(text),d'ppppppppp',$f0
 dta 4,4,$84,4,4,4,4,4
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

 lda:rne $d010
 
 jsr logo.fade_out

 jsr default_nmi
 rts


;--

dli1

 sta $d40a                   ;line=88
 lda #$61
 sta $d40a                   ;line=89
 sta Player2_PositionX
 lda #$81
 sta $d40a                   ;line=90
 sta Player3_PositionX
 sta $d40a                   ;line=91
 lda #$5F
 ldx #$80
 sta $d40a                   ;line=92
 sta Player2_PositionX
 stx Player3_PositionX
 lda #$61
 sta $d40a                   ;line=93
 sta Player2_PositionX
 sta $d40a                   ;line=94
 sta $d40a                   ;line=95
 lda #$60
 sta $d40a                   ;line=96
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=97
 sta Player2_PositionX
 lda #$60
 sta $d40a                   ;line=98
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=99
 sta Player2_PositionX
; sta $d40a                   ;line=100
; sta $d40a                   ;line=101
; sta $d40a                   ;line=102
; sta $d40a                   ;line=103

 max #dli1_2
 jmp nmiQ


dli1_2

; sta $d40a                   ;line=104
; sta $d40a                   ;line=105
; sta $d40a                   ;line=106
; sta $d40a                   ;line=107
; sta $d40a                   ;line=108
; sta $d40a                   ;line=109
; sta $d40a                   ;line=110
; sta $d40a                   ;line=111
 
 sta $d40a                   ;line=112
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 sta $d40a                   ;line=115
 sta $d40a                   ;line=116
 sta $d40a                   ;line=117
 sta $d40a                   ;line=118
 lda #$8C
 sta $d40a                   ;line=119
 sta Missile2_PositionX
 lda #$7F
 sta $d40a                   ;line=120
 sta Player3_PositionX
 lda #$81
 sta $d40a                   ;line=121
 sta Player3_PositionX
 sta $d40a                   ;line=122
 lda #$80
 sta $d40a                   ;line=123
 sta Player3_PositionX
 lda #$60
 sta $d40a                   ;line=124
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=125
 sta Player2_PositionX
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127
 
 sta $d40a                   ;line=128
 sta $d40a                   ;line=129
 lda #$60
 sta $d40a                   ;line=130
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=131
 sta Player2_PositionX
 sta $d40a                   ;line=132
 sta $d40a                   ;line=133
 sta $d40a                   ;line=134
 sta $d40a                   ;line=135
 
 sta $d40a                   ;line=136
 sta $d40a                   ;line=137
 sta $d40a                   ;line=138
 sta $d40a                   ;line=139
 lda #$88
 sta $d40a                   ;line=140
 sta Missile2_PositionX
 sta $d40a                   ;line=141
 sta $d40a                   ;line=142
 sta $d40a                   ;line=143
 
 sta $d40a                   ;line=144
 sta $d40a                   ;line=145
 sta $d40a                   ;line=146
 sta $d40a                   ;line=147
 sta $d40a                   ;line=148
 lda #$68
 sta $d40a                   ;line=149
 sta Missile2_PositionX
 lda #$7F
 sta $d40a                   ;line=150
 sta Player3_PositionX
c6 lda #$0E
 sta $d40a                   ;line=151
 sta Player3_Missile3_Color3_PM3

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
 mva #scr32 $d400	;ustawienie szerokosci obrazu $d400

 inc $14

;-- init pierwszej linii

 lda >fnt+$400*$00
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$C8
 sta Playfield_Color0_PF0
c2 lda #$B4
 sta Playfield_Color1_PF1
c3 lda #$EA
 sta Playfield_Color2_PF2
c4 lda #$00
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$03
 sta Player2_Size
 sta Player3_Size
 lda #$00
 sta Missiles_Size
 lda #$5F
 sta Player2_PositionX
 lda #$7F
 sta Player3_PositionX
 lda #$68
 sta Missile2_PositionX
c5 lda #$0C
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3

 max #dli1	; pierwszy program DLI

nmiQ
 sta dliv+1
 stx dliv+2
 
 lda reja
 ldx rejX
 ldy rejY
 rti

;--

l_tcol
 dta l(c0,c1,c2,c3,c4,c5,c6)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5,c6)

t_satur .ds color_nr
t_color .ds color_nr
