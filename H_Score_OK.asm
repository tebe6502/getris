
pmg  equ pmg_highScore

zp   equ $70
zp_  equ zp+2
txt  equ zp_+2


ant dta $80,$44,a(text)
 dta 4,4,$84,$84,$70,$f0
 dta $70,$44+$10
adr0 dta a(ekran-1),4+$10,$84+$10
 dta $70,$44+$10
adr1 dta a(ekran+3*48-1),4+$10,$84+$10
 dta $70,$44+$10
adr2 dta a(ekran+6*48-1),4+$10,$84+$10
 dta $70,$44+$10
adr3 dta a(ekran+9*48-1),4+$10,$84+$10
 dta $70,$44+$10
adr4 dta a(ekran+12*48-1),4+$10,$84+$10
 dta $41,a(ant)


main
 hax #pmg-1
 jsr decode

;-- init PMG
 mva >pmBase_Text $d407	;PMCTL - wyswietlac duchy i pociski
 mva #3 $d01d		;PMCTL - show PMG

 mwa #dli1 dliv+1
 
 mwa #nmi $fffa		;nasza nowa obsluga przerwania NMI

 ldx #=hscore_msx       ;init modulu MPT
 lda <hscore_msx
 ldy >hscore_msx
 jsr mpt_player.initialization

 mva #$c0 $d40e		;wlaczenie NMI z przerwaniami DLI
 sta mpt.player

 jsr fade_in

 jsr input_string

 lda:rne $d010
 
 jsr fade_out


new_game

; zaczynamy od poczatku
 ldx #1
 jsr wait

 jsr reset_pokey

 mva #0 $d40e
 sta $d400
 sta mpt.player

; lda #0
 sta tetris.init.test+1         ; pozwalaj na wyzerowanie licznika poziomow i licznika punktow

 lda #max_fps                   ; domyslne opoznienie spadania klockow
 sta delay

 lda #min_line                  ; domyslna liczba poziomych linii do usuniecia
 sta tetris.line+1
 
 jmp nowa_gra

;--

licz brk

/********************************************
  Name: WAIT
  Info: wait X frame
  
  Input: regX - frame count
********************************************/
.proc wait

 jsr wajt
 
 dex
 bne wait
 rts
 
.endp

;--

dli1

 sta $d40a                   ;line=0
 sta $d40a                   ;line=1
 sta $d40a                   ;line=2
 sta $d40a                   ;line=3
 sta $d40a                   ;line=4
 sta $d40a                   ;line=5
c8 lda #$6A
c9 ldx #$58
c10 ldy #$44
 sta $d40a                   ;line=6
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 lda #$75
 sta Player0_PositionX
c11 lda #$2A
 sta Player0_Missile0_Color0_PM0
;--
 sta $d40a                   ;line=7
 sta $d40a                   ;line=8
 sta $d40a                   ;line=9
 sta $d40a                   ;line=10
 sta $d40a                   ;line=11
 sta $d40a                   ;line=12
 sta $d40a                   ;line=13
 lda #$7F
 ldx #$7D
 sta $d40a                   ;line=14
 sta Player0_PositionX
 stx Missile0_PositionX
 lda #$4D
 sta $d40a                   ;line=15
 sta Missile0_PositionX
 lda #$84
 sta $d40a                   ;line=16
 sta Missile2_PositionX
 sta $d40a                   ;line=17
 sta $d40a                   ;line=18
 lda #$01
 ldx #$3D
 sta $d40a                   ;line=19
 sta Player0_Size
 stx Player0_PositionX
 sta $d40a                   ;line=20
 sta $d40a                   ;line=21
 lda #$70
 sta $d40a                   ;line=22
 sta Player3_PositionX
 lda #$76
 sta $d40a                   ;line=23
 sta Player0_PositionX
 lda #$75
 ldx #$3F
 sta $d40a                   ;line=24
 sta Player0_PositionX
 stx Missile0_PositionX
; sta $d40a                   ;line=25
; sta $d40a                   ;line=26
; sta $d40a                   ;line=27
; sta $d40a                   ;line=28
; sta $d40a                   ;line=29
; sta $d40a                   ;line=30
; sta $d40a                   ;line=31

 max #dli1_2
 jmp nmiQ


dli1_2
 sta $d40a                   ;line=32
 sta $d40a                   ;line=33
c12 lda #$44
 sta $d40a                   ;line=34
 sta Player0_Missile0_Color0_PM0
c13 lda #$78
c14 ldx #$76
c15 ldy #$74
 sta $d40a                   ;line=35
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 lda #$A6
 sta Missile0_PositionX
 
 max #dli2
 jmp nmiQ


dli2
 lda >fnt3_2
c16 ldx #$AA
 ldy #$D0
 sta $d40a                   ;line=40
 sta CHARBASE
 stx Playfield_Color2_PF2
 sty Player0_PositionX
c17 lda #$00
 sta Player0_Missile0_Color0_PM0
 sta $d40a                   ;line=41
c18 lda #$00
 sta $d40a                   ;line=42
 sta Playfield_Color3_PF3
c19 lda #$A4
 sta $d40a                   ;line=43
 sta Playfield_Color0_PF0
 sta $d40a                   ;line=44
c20 lda #$A6
 sta $d40a                   ;line=45
 sta Playfield_Color1_PF1
 sta $d40a                   ;line=46
; sta $d40a                   ;line=47
c21 lda #$C4
c22 ldx #$C6
c23 ldy #$CC
; sta $d40a                   ;line=48
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
; sta $d40a                   ;line=49
; sta $d40a                   ;line=50
; sta $d40a                   ;line=51
; sta $d40a                   ;line=52
; sta $d40a                   ;line=53
; sta $d40a                   ;line=54
; sta $d40a                   ;line=55
 
 max #dli2_2
 jmp nmiQ


dli2_2
 sta $d40a                   ;line=56
 sta $d40a                   ;line=57
 lda #$33
c24 ldx #$06
 sta $d40a                   ;line=58
 sta Player2_PositionX
 stx Player2_Missile2_Color2_PM2
 sta $d40a                   ;line=59
 lda #$00
 ldx #$33
c25 ldy #$06
 sta $d40a                   ;line=60
 sta Player1_Size
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$33
c26 ldx #$08
c27 ldy #$0E
 sta $d40a                   ;line=61
 sta Player3_PositionX
 stx Player2_Missile2_Color2_PM2
 sty Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=62
c28 lda #$C8
 sta $d40a                   ;line=63
 sta Playfield_Color3_PF3

hp0 lda #0
 sta $d001
 sta $d002
 sta $d003

hs0 lda #0
 sta $d404

 max #dli3
 jmp nmiQ


dli3
; lda >fnt3
c29 ldx #$A4
c30 ldy #$A6
c31 lda #$00
 sta $d40a                   ;line=88
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=89
c32 lda #$AC
 sta $d40a                   ;line=90
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=91
 sta $d40a                   ;line=92
c33 lda #$04
c34 ldx #$06
c35 ldy #$0C
 sta $d40a                   ;line=93
 sta Player1_Missile1_Color1_PM1
 stx Player2_Missile2_Color2_PM2
 sty Player3_Missile3_Color3_PM3
c36 lda #$34
c37 ldx #$36
c38 ldy #$3C
 sta $d40a                   ;line=94
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
c39 lda #$38
 sta $d40a                   ;line=95
 sta Playfield_Color3_PF3
; lda >fnt3_2
; sta $d40a                   ;line=96
; sta CHARBASE

hp1 lda #0
 sta $d001
 sta $d002
 sta $d003

hs1 lda #0
 sta $d404

 max #dli4
 jmp nmiQ
 

dli4
; lda >fnt3
c40 ldx #$A4
c41 ldy #$A6
c42 lda #$00
 sta $d40a                   ;line=120
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=121
c43 lda #$AC
 sta $d40a                   ;line=122
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=123
c44 lda #$0E
 sta $d40a                   ;line=124
 sta Player3_Missile3_Color3_PM3
c45 lda #$0A
 sta $d40a                   ;line=125
 sta Player3_Missile3_Color3_PM3

hp2 lda #0
 sta $d001
 sta $d002
 sta $d003

hs2 lda #0
 sta $d404

 sta $d40a                   ;line=126
c46 lda #$98
 sta $d40a                   ;line=127
 sta Playfield_Color3_PF3
; lda >fnt3_2
c47 ldx #$94
c48 ldy #$96
c49 lda #$9C
 sta $d40a                   ;line=128
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color2_PF2

 max #dli5
 jmp nmiQ


dli5
; lda >fnt3
c50 ldx #$A4
c51 ldy #$A6
c52 lda #$00
 sta $d40a                   ;line=152
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=153
c53 lda #$AC
 sta $d40a                   ;line=154
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=155
c54 lda #$0E
 sta $d40a                   ;line=156
 sta Player3_Missile3_Color3_PM3
c55 lda #$08
 sta $d40a                   ;line=157
 sta Player3_Missile3_Color3_PM3

hp3 lda #0
 sta $d001
 sta $d002
 sta $d003

hs3 lda #0
 sta $d404

 sta $d40a                   ;line=158
c56 lda #$F8
 sta $d40a                   ;line=159
 sta Playfield_Color3_PF3
; lda >fnt3_2
c57 ldx #$E4
c58 ldy #$F6
c59 lda #$FC
 sta $d40a                   ;line=160
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color2_PF2

 max #dli6
 jmp nmiQ


dli6
; lda >fnt3
c60 ldx #$A4
c61 ldy #$A6
c62 lda #$00
 sta $d40a                   ;line=184
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=185
c63 lda #$AC
 sta $d40a                   ;line=186
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=187
c64 lda #$06
 sta $d40a                   ;line=188
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=189

hp4 lda #0
 sta $d001
 sta $d002
 sta $d003

hs4 lda #0
 sta $d404

 sta $d40a                   ;line=190
c65 lda #$28
 sta $d40a                   ;line=191
 sta Playfield_Color3_PF3
; lda >fnt3_2
c66 ldx #$24
c67 ldy #$26
c68 lda #$2C
 sta $d40a                   ;line=192
; sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 sta Playfield_Color2_PF2

; sta $d40a                   ;line=193
; sta $d40a                   ;line=194
; sta $d40a                   ;line=195
; sta $d40a                   ;line=196
; sta $d40a                   ;line=197
; sta $d40a                   ;line=198
; sta $d40a                   ;line=199

 max #dli6_2
 jmp nmiQ


dli6_2
c69 lda #$A4
c70 ldx #$A6
c71 ldy #$00
 sta $d40a                   ;line=216
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color3_PF3
 sta $d40a                   ;line=217
c72 lda #$AC
 sta $d40a                   ;line=218
 sta Playfield_Color2_PF2
c73 lda #$0E
 sta $d40a                   ;line=219
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
 mva #scr40 $d400	;ustawienie szerokosci obrazu $d400

 inc $14

;-- init pierwszej linii
 lda >fnt3
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$2A
 sta Playfield_Color0_PF0
c2 lda #$38
 sta Playfield_Color1_PF1
c3 lda #$34
 sta Playfield_Color2_PF2
c4 lda #$38
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$00
 sta Player0_Size
 sta Player2_Size
 sta Player3_Size
 sta Missiles_Size
 lda #$63
 sta Player0_PositionX
 lda #$49
 sta Player2_PositionX
 lda #$73
 sta Player3_PositionX
 lda #$4D
 sta Missile0_PositionX
 lda #$7B
 sta Missile2_PositionX
 lda #$3F
 sta Missile3_PositionX
c5 lda #$6A
 sta Player0_Missile0_Color0_PM0
c6 lda #$34
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3
 lda #$01
 sta Player1_Size
 lda #$20
 sta Player1_PositionX
c7 lda #$00
 sta Player1_Missile1_Color1_PM1

;---

 ldx #=hscore_msx
 jsr mpt

;---

 lda $14
 and #1
 sne

 jsr falowanie 


 lda $14
 and #3
 bne _skp

mrg lda #0
 eor #1
 sta mrg+1
 beq faza2

// realizujemy mruganie znaku zapytania
// modyfikujemy w tym celu znaki:
// 82  , 83
// 90  , 91
// 102 , 103
ch1 = fnt3_2+82*8
ch2 = fnt3_2+90*8
ch3 = fnt3_2+102*8

ch1_tmp = fnt3_2+110*8
ch2_tmp = fnt3_2+112*8
ch3_tmp = fnt3_2+114*8
// przepisujac ich stara zawartosc do znakow 110...
 
 ldx #15
mv0
 lda ch1,x
 sta ch1_tmp,x

 lda ch2,x
 sta ch2_tmp,x

 lda ch3,x
 sta ch3_tmp,x
 
 lda #0
 sta ch1,x
 sta ch2,x
 sta ch3,x
 
 dex
 bpl mv0

 jmp _skp


faza2
 ldx #15
mv1
 lda ch1_tmp,x
 sta ch1,x

 lda ch2_tmp,x
 sta ch2,x

 lda ch3_tmp,x
 sta ch3,x
 
 lda #0
 sta ch1_tmp,x
 sta ch2_tmp,x
 sta ch3_tmp,x
 
 dex
 bpl mv1

_skp

 max #dli1

nmiQ
 sta dliv+1
 stx dliv+2

 lda rejA
 ldx rejX
 ldy rejY
 rti

;--
;--


.proc falowanie

 ldx #0
 jsr fala
 sta hp0+1
 stx hs0+1

 ldx #1
 jsr fala
 sta hp1+1
 stx hs1+1

 ldx #2
 jsr fala
 sta hp2+1
 stx hs2+1

 ldx #3
 jsr fala
 sta hp3+1
 stx hs3+1

 ldx #4
 jsr fala
 sta hp4+1
 stx hs4+1

 rts

fala
 inc t_licz,x
 lda t_licz,x
 and #$f
 tay
 lda t_fala,y
 pha

 inc t_licz2,x
 lda t_licz2,x
 and #$1f
 tay
 ldx t_scro,y
 pla
 rts

t_licz dta 15,11,7,3,0

t_licz2 dta 20,16,12,8,4

t_fala
 dta 52 , 52 , 52 , 51 , 50 , 49 , 48 , 47 , 46 , 46 , 46 , 47 , 48 , 49 , 50 , 51 

t_scro
; dta 7,7,7,7,7,6,6,6,5,5,4,3,2,2,1,1,0,0,0,0,0,1,1,2,2,3,4,5,5,6,6,6
 dta 6 , 7 , 7 , 8 , 8 , 8 , 8 , 8 
 dta 7 , 7 , 6 , 6 , 5 , 4 , 3 , 2 
 dta 2 , 1 , 1 , 0 , 0 , 0 , 0 , 0 
 dta 1 , 1 , 2 , 2 , 3 , 4 , 5 , 6 

.endp


text
 ins 'H_Score_OK.scr',0,5*40

;ekran
.rept 5
 :4 brk
 ins 'H_Score_OK.scr',5*40+#*120,40
 :4 brk

 :4 brk
 ins 'H_Score_OK.scr',5*40+#*120+40,40
 :4 brk

 :4 brk
 ins 'H_Score_OK.scr',5*40+#*120+80,40
 :4 brk
.endr

/*
  FADE ON-OUT
*/
 icl 'h_score_ok.fad'


/*
  INPUT STRING
*/
 icl 'input_string.asm'
