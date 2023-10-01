
_fade_out equ $b000	; adres procedure FADE_OUT

fwidth  equ 48		; screen width in 'intro.scr' file
swidth	equ 128		; screen width

scr40	equ %00111110	;screen 40b
scr48	equ %00111111	;screen 48b

cloc	equ $0014	;(1)

ftmp	equ $80		;(2)
regA	equ ftmp+2	;(1)
regX	equ regA+1	;(1)
regY	equ regX+1	;(1)

hposp0	equ $D000
hposp1	equ $D001
hposp2	equ $D002
hposp3	equ $D003
hposm0	equ $D004
hposm1	equ $D005
hposm2	equ $D006
hposm3	equ $D007
sizep0	equ $D008
sizep1	equ $D009
sizep2	equ $D00A
sizep3	equ $D00B
sizem	equ $D00C

colpm0	equ $D012
colpm1	equ $D013
colpm2	equ $D014
colpm3	equ $D015
color0	equ $D016
color1	equ $D017
color2	equ $D018
color3	equ $D019
colbak	equ $D01A
gtictl	equ $D01B

chbase	equ $D409


.local intro
 icl 'load\load.asm'
.endl


;-- MAIN PROGRAM
	org $7000

fnt	ins 'intro.fnt'

scr_reszta
 :4 brk
 ins 'load_3_reszta.scr'
 :16 brk

scr_first
.rept 30
 :16 brk
 ins 'load\load_2.scr',16+.r*32,16
.endr

	?ofs = 12

ant	dta $44,a(scr_reszta),$44+$80,a(scr_reszta+40),$44,a(scr_reszta+80)
	dta $44, a(scr+?ofs)
        dta $44, a(scr+?ofs+swidth)
        dta $c4, a(scr+?ofs+swidth*2) ,$44,a(scr_reszta+120)
        dta $c4, a(scr+?ofs+swidth*3)
        dta $44, a(scr+?ofs+swidth*4)
        dta $c4, a(scr+?ofs+swidth*5) ,$44+$80,a(scr_reszta+160)
        dta $44, a(scr+?ofs+swidth*6)
        dta $c4, a(scr+?ofs+swidth*7)
        dta $c4, a(scr+?ofs+swidth*8) ,$44+$80,a(scr_reszta+200)
        dta $44, a(scr+?ofs+swidth*9)
        dta $44, a(scr+?ofs+swidth*10)
        dta $c4, a(scr+?ofs+swidth*11) ,$44+$80,a(scr_reszta+240)
        dta $c4, a(scr+?ofs+swidth*12)
        dta $c4, a(scr+?ofs+swidth*13)
        dta $c4, a(scr+?ofs+swidth*14) ,$44+$80,a(scr_reszta+280)
        dta $c4, a(scr+?ofs+swidth*15)
        dta $44, a(scr+?ofs+swidth*16)
        dta $44, a(scr+?ofs+swidth*17)
        
        dta $44+$80,a(scr_reszta+320)
        dta $44+$80,a(scr_reszta+360)
        dta $44+$80,a(scr_reszta+400)
        dta $44+$80,a(scr_reszta+440)
        
 	dta $41, a(ant)

        ?tmp = fwidth*3
        ?hlp = swidth*3

scr
.rept 18   ; 6*3
 :32 brk
 ins 'load_3.scr',20+.r*48,20
 :swidth-20-32 brk
.endr

        ?ofs = 0
        
	lfrm 0      , scr		; G
	lfrm ?tmp   , scr+?hlp		; E
	lfrm ?tmp*2 , scr+?hlp*2	; T
	lfrm ?tmp*3 , scr+?hlp*3	; R
	lfrm ?tmp*4 , scr+?hlp*4	; I
	lfrm ?tmp*5 , scr+?hlp*5	; S

	ALIGN $100

l_prc
.rept ?ofs
 dta .get[$4000+.r]
.endr

h_prc
.rept ?ofs
 dta .get[$4100+.r]
.endr

;	ALIGN $100	

tsin	:96 dta 0
	dta b( sin( 37 , 59 , 128 , 0 , 511 ) )

;_tsin	:144 dta 0
;	dta b( sin( 33 , 48 , 128 , 0 , 511 ) )


main

 .print 'RUN at: ',*

 jsr intro.main

 jsr wait		;wait 1 frame

 sei			;stop interrups
 mva #0 $d40e		;stop all interrupts
 mva #$fe $d301		;switch off ROM to get 16k more ram

/*
 ldy #0
mov
 lda #0
 sta pmg+$400,y
 sta pmg+$500,y
 
 lda _m23,y
 sta pmg+$300,y
 lda _p23,y
 sta pmg+$600,y
 sta pmg+$700,y
 iny
 bne mov
*/

 mwa #nmi $fffa		;new NMI handler
 mva #$c0 $d40e		;switch on NMI+DLI again

;-- SCROLL

loop
 jsr wait

	?ofs = 12
	
	scrol 0      , 0  , 0 , 0 , 96
	scrol ?ofs   , 4  , 0 , 1 , 96
	scrol ?ofs*2 , 8  , 0 , 2 , 96
	scrol ?ofs*3 , 12 , 0 , 3 , 96
	scrol ?ofs*4 , 16 , 0 , 4 , 96
	scrol ?ofs*5 , 20 , 0 , 5 , 96 

 lda stop_l
 beq _lp
 lda stop_l+1
 beq _lp
 lda stop_l+2
 beq _lp
 lda stop_l+3
 beq _lp
 lda stop_l+4
 beq _lp
 lda stop_l+5
 beq _lp

 jsr wait

 mva #{jsr $FFFF}	_fade_out
 mwa #intro.fade_out	_fade_out+1

 mwa #intro.scr		intro.ant.adr
 mwa #intro.ant		$d402
 mwa >intro.fnt		$d409
 mva #intro.scr32	$d400

 mva #$ff $d301
 mva #$40 $d40e
 cli

 rts

_lp
 jmp loop

hpos_l .ds 6
hpos_r .ds 6
thit_l :6 brk
thit_r :6 brk
stop_l :6 brk
stop_r :6 brk


;-- DLI PROGRAM

 ?old_dli equ *


dli0
 sta $d40a

 @p3 0
 DLINEW dli1

dli1
 sta $d40a

 @p3 1
 DLINEW dli2

dli2
 lda >fnt+$400*$01
 sta $d40a                   ;line=40
 sta chbase
 DLINEW dli3

dli3
 lda >fnt+$400*$00
 sta $d40a                   ;line=56
 sta chbase

 @p3 2
 DLINEW dli4

dli4
 lda >fnt+$400*$01
 sta $d40a                   ;line=64
 sta chbase
 DLINEW dli5

dli5
 lda >fnt+$400*$02
 sta $d40a                   ;line=80
 sta chbase
 DLINEW dli6

dli6
 lda >fnt+$400*$00
 sta $d40a                   ;line=88
 sta chbase
 
 @p3 3
 DLINEW dli7

dli7
 lda >fnt+$400*$02
 sta $d40a                   ;line=96
 sta chbase
 DLINEW dli8

dli8
 lda >fnt+$400*$00
 sta $d40a                   ;line=120
 sta chbase

 @p3 4
 DLINEW dli9

dli9
 lda >fnt+$400*$02
 sta $d40a                   ;line=128
 sta chbase
 DLINEW dli10

dli10
 lda >fnt+$400*$01
 sta $d40a                   ;line=136
 sta chbase
 DLINEW dli11

dli11
 lda >fnt+$400*$02
 sta $d40a                   ;line=144
 sta chbase
 DLINEW dli12

dli12
 lda >fnt+$400*$00
 sta $d40a                   ;line=152
 sta chbase
 
 @p3 5
 DLINEW dli13

dli13
 lda >fnt+$400*$02
 sta $d40a                   ;line=160
 sta chbase
 DLINEW dli14

dli14
 lda >fnt+$400*$03
 sta $d40a                   ;line=168
 sta chbase
 jmp NmiQuit

;--

nmi
 sta regA
 stx regX
 sty regY

 bit $d40f
 bpl vbl

dliv jmp dli0

vbl			;VBL routine
 sta $d40f		;reset NMI flag

 inc cloc		;little timer

 mwa #ant $d402		;ANTIC address program
 mva #scr48 $d400	;set new screen's width

;-- first line of screen initialization

 lda >fnt
 sta chbase
c0 lda #$00
 sta colbak
c1 lda #$54
 sta color0
c2 lda #$8A
 sta color1
c3 lda #$68
 sta color2
c4 lda #$14
 sta color3
 lda #$04
 sta gtictl

; lda #$03
; sta sizep2
; sta sizep3
; lda #$00
; sta sizem
 
c5 lda #$0C
 sta colpm2
 sta colpm3

; lda #0
; sta sizep0
; sta sizep1

; sta hposp0
; sta hposp1
; sta hposm0
; sta hposm1

; sta colpm0
; sta colpm1

 mwa #dli0 dliv+1	;set the first address of DLI interrupt

;this area is for yours routines

NmiQuit
 lda regA
 ldx regX
 ldy regY
 rti

wait
 lda:cmp:req cloc
 rts


/*
_m23
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$A0,$50,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_p23
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $7F,$7F,$43,$C3,$C3,$C3,$C3,$C0,$C0,$C0,$C0,$CF,$CF,$C3,$C3,$C3
 dta $C3,$C3,$C3,$C3,$C3,$63,$7F,$7F,$00,$00,$00,$00,$00,$00,$00,$00
 dta $7F,$7F,$43,$C3,$C3,$C3,$C3,$C0,$C0,$C0,$C0,$FC,$FC,$C0,$C0,$C0
 dta $C3,$C3,$C3,$C3,$C3,$63,$7F,$7F,$00,$00,$00,$00,$00,$00,$00,$00
 dta $7F,$7F,$43,$C3,$C3,$C3,$C3,$E3,$03,$03,$03,$03,$03,$03,$03,$03
 dta $03,$03,$03,$03,$03,$03,$03,$03,$00,$00,$00,$00,$00,$00,$00,$00
 dta $FF,$FE,$C2,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C2,$FE,$FE,$C2,$C3,$C3
 dta $C3,$C3,$C3,$C3,$C3,$C3,$C3,$E3,$00,$00,$00,$00,$00,$00,$00,$00
 dta $1C,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$18
 dta $18,$18,$18,$18,$18,$18,$18,$1C,$00,$00,$00,$00,$00,$00,$00,$00
 dta $7F,$7E,$42,$C3,$C3,$C3,$C3,$C3,$C0,$C0,$60,$7F,$7E,$02,$03,$03
 dta $E3,$C3,$C3,$C3,$C3,$62,$7E,$7F,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

*/


;--
 ini main

;--

 opt l-
 icl 'xasm.mac'

 icl 'intro.mac'

.macro lcod
 lda #0
 sta :1,y
 sta :1+swidth,y
 sta :1+swidth*2,y

 sta :1+11,y
 sta :1+swidth+11,y
 sta :1+swidth*2+11,y

 .rept 10
   lda #.get[.r]
   sta :1+.r+1,y
   lda #.get[.r+10]
   sta :1+.r+swidth+1,y
   lda #.get[.r+20]
   sta :1+.r+swidth*2+1,y
 .endr

 rts
.endm


.macro ltab
 .put[$4000+?ofs] = .lo(*)
 .put[$4100+?ofs] = .hi(*)
 
 ?ofs += 1
.endm


.macro lfrm

 ltab
 .get [0] 'intro.scr',:1+4,10
 .get [10] 'intro.scr',:1+48+4,10
 .get [20] 'intro.scr',:1+96+4,10
 lcod :2

 ltab
 .get [0] 'intro.scr',:1+14,10
 .get [10] 'intro.scr',:1+48+14,10
 .get [20] 'intro.scr',:1+96+14,10
 lcod :2

 ltab
 .get [0] 'intro.scr',:1+24,10
 .get [10] 'intro.scr',:1+48+24,10
 .get [20] 'intro.scr',:1+96+24,10
 lcod :2

 ltab
 .get [0] 'intro.scr',:1+34,10
 .get [10] 'intro.scr',:1+48+34,10
 .get [20] 'intro.scr',:1+96+34,10 
 lcod :2

.endm


.macro scrol
idx ldx #0
 lda tsin+:1,x

 sta hpos_l+:4
 sta _x+1

 lsr @
 lsr @

 add #:3
 tay

 lda tsin+:1,x
 and #3
 tax 

 lda l_prc+:2,x
 sta _jsr+1
 lda h_prc+:2,x
 sta _jsr+2

_jsr jsr $ffff 

_x lda #0
 cmp #:5
 bne _cnt

 lda #$ff
 sta stop_l+:4

 lda thit_l+:4
 cmp #1
 bcs _ext
 inc thit_l+:4
 lda #0
 sta stop_l+:4
 
_cnt
 inc idx+1

_ext
.endm


.macro @p3
 lda hpos_l+:1
 sub #12
 sta hposp3
 add #28
 sta hposm3
.endm
