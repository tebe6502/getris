
fnt   equ fnt_txt2
pmg   equ pmg_pause
text  equ text_pause


color_nr equ 6


ant
 dta d'pppppppppppp',$f0,$44,a(text),4,4,4
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

_w
 jsr wajt

 lda $d20f
 and #4
 bne _no_key

 lda $d209
 cmp #33
 beq _q

_no_key
 jmp _w

_q
 jsr logo.fade_out
 
 jsr default_nmi
 rts


;--

dli1

 sta $d40a                   ;line=104
 lda #$59
 sta $d40a                   ;line=105
 sta Player3_PositionX
 lda #$79
 sta $d40a                   ;line=106
 sta Player2_PositionX
 lda #$77
 ldx #$58
 sta $d40a                   ;line=107
 sta Player2_PositionX
 stx Player3_PositionX
 lda #$98
 sta $d40a                   ;line=108
 sta Missile2_PositionX
 sta $d40a                   ;line=109
 sta $d40a                   ;line=110
 sta $d40a                   ;line=111
 lda #$78
 sta $d40a                   ;line=112
 sta Player2_PositionX
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 lda #$77
 sta $d40a                   ;line=115
 sta Player2_PositionX
 lda #$99
 sta $d40a                   ;line=116
 sta Missile2_PositionX
 sta $d40a                   ;line=117
 sta $d40a                   ;line=118
 lda #$56
 sta $d40a                   ;line=119
 sta Player3_PositionX
 sta $d40a                   ;line=120
 lda #$58
 sta $d40a                   ;line=121
 sta Player3_PositionX
 sta $d40a                   ;line=122
 sta $d40a                   ;line=123
 sta $d40a                   ;line=124
 sta $d40a                   ;line=125
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127
 lda #$57
 sta $d40a                   ;line=128
 sta Player3_PositionX
 sta $d40a                   ;line=129
 lda #$58
 sta $d40a                   ;line=130
 sta Player3_PositionX
 sta $d40a                   ;line=131
 sta $d40a                   ;line=132
 sta $d40a                   ;line=133
 sta $d40a                   ;line=134
 sta $d40a                   ;line=135
 lda #$57
 ldx #$38
 ldy #$79
 sta $d40a                   ;line=136
 sta Player2_PositionX
 stx Player3_PositionX
 sty Missile2_PositionX
 lda #$75
 sta Missile3_PositionX
 
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
c1 lda #$38
 sta Playfield_Color0_PF0
c2 lda #$24
 sta Playfield_Color1_PF1
c3 lda #$2A
 sta Playfield_Color2_PF2
c4 lda #$00
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$03
 sta Player2_Size
 sta Player3_Size
 lda #$30
 sta Missiles_Size
 lda #$77
 sta Player2_PositionX
 lda #$58
 sta Player3_PositionX
 lda #$99
 sta Missile2_PositionX
 lda #$95
 sta Missile3_PositionX
c5 lda #$1C
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3

 max #dli1

nmiQ
 sta dliv+1
 stx dliv+2

 lda rejA
 ldx rejX
 ldy rejY
 rti
 
;---

l_tcol
 dta l(c0,c1,c2,c3,c4,c5)

h_tcol
 dta h(c0,c1,c2,c3,c4,c5)

t_satur .ds color_nr
t_color .ds color_nr

