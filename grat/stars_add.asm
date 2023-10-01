; !!! licznik COUNT musi zliczac od 0... a nie od tylu !!!

pmg_stars	equ pmBase


sile    equ 11

tmp	equ zp_free


stars

 jsr stars_init

loop

 jsr stars_losuj

 ldx #6
wai lda:cmp:req 20
 dex
 bne wai

 jsr stars_animuj

return jmp loop


;---


.proc STARS_INIT

 mwa #tstars tmp

 mva #sile-1 count

loop
 ldy #tstars_dta.faza
 lda $d20a
 and #7				; dzieki temu gwiazdki pojawiaja sie w roznym tempie
 sta (tmp),y
 
 ldy #tstars_dta.addr		; zerujemy gwiazdke na tej pozycji Y
 lda <stars_0
 sta (tmp),y
 iny
 lda >stars_0
 sta (tmp),y 

 jsr add_tmp

 dec count
 bpl loop
 rts

count	brk
.endp



.proc STARS_LOSUJ

msk equ tmp+2
hps equ msk+2

 mwa #maska msk

 mwa #tstars tmp

 mva #0 count

loop
 ldy #tstars_dta.faza
 lda (tmp),y
 beq _ok
 cmp #8
 bcs _ok
 jmp _skip

_ok
 ldy #tstars_dta.addr		; zerujemy gwiazdke na tej pozycji Y
 lda <stars_0
 sta (tmp),y
 iny
 lda >stars_0
 sta (tmp),y

 ldy #tstars_dta.faza
 lda $d20a
 and #7				; dzieki temu gwiazdki pojawiaja sie w roznym tempie
 sta (tmp),y
 
; lda $d20a
; bpl _skip

 lda $d20a
 and #7
 tay

 lda (msk),y		; wylosowalismy nowa pozycje
 beq _skip

 tya
 :2 asl @
 clc
 adc #108
 tax

 ldy count
 lda lhpos,y
 sta hps
 lda hhpos,y
 sta hps+1

 ldy #1
 txa
 sta (hps),y

; ldy #tstars_dta.posx
; sta (tmp),y
 
 lda $d20a
 and #3
 tax

 ldy #tstars_dta.addr
 lda l_stars,x
 sta (tmp),y
 iny
 lda h_stars,x
 sta (tmp),y

 ldy #tstars_dta.faza
 lda #0
 sta (tmp),y

_skip

 jsr add_tmp
 
 lda msk
 clc
 adc #8
 sta msk
 scc
 inc msk+1

 inc count
 lda count
 cmp #sile
 bne loop
 rts

count	brk
.endp



.proc STARS_ANIMUJ

// zero page declaractions
s_addr	equ tmp+2
;s_faza	equ s_addr+1
;s_posx	equ s_faza+1

// program
 mwa #tstars tmp

 mva #0 count

loop
 ldy #tstars_dta.faza
 lda (tmp),y
 cmp #8
 bcs _skip

 ldy #tstars_dta.addr
 lda (tmp),y
 sta s_addr
 iny
 lda (tmp),y
 sta s_addr+1

 ldy #tstars_dta.faza
 lda (tmp),y
 tax
 clc
 adc #1
 sta (tmp),y

 ldy tmul5,x
 
 ldx count
 lda posy,x
 tax

 lda (s_addr),y
 sta pmg_stars+$400,x
 iny
 lda (s_addr),y
 sta pmg_stars+$401,x
 iny
 lda (s_addr),y
 sta pmg_stars+$402,x
 iny
 lda (s_addr),y
 sta pmg_stars+$403,x
 iny
 lda (s_addr),y
 sta pmg_stars+$404,x

_skip

 jsr add_tmp
 
 inc count
 lda count
 cmp #sile
 bne loop
 rts 

count	brk
.endp


.proc ADD_TMP

 lda tmp
 clc
 adc #tstars_dta	 ; structure TSTARS_DTA length
 sta tmp
 scc
 inc tmp+1
 rts

.endp

;---

// animacje gwiazdek STARS1, STARS2, STARS3
// 8 klatek po 5 bajtow kazda
stars1
 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

 dta %00000000
 dta %00000100
 dta %00001110
 dta %00000100
 dta %00000000

 dta %00000100
 dta %00000100
 dta %00011111
 dta %00000100
 dta %00000100

 dta %00000000
 dta %00000100
 dta %00001110
 dta %00000100
 dta %00000000

 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

stars_0
 :40 brk


stars2
 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

 dta %00000000
 dta %00000100
 dta %00001110
 dta %00000100
 dta %00000000

 dta %00000100
 dta %00000100
 dta %00001110
 dta %00000100
 dta %00000100

 dta %00000000
 dta %00000100
 dta %00011111
 dta %00000100
 dta %00000000

 dta %00000000
 dta %00000100
 dta %00001110
 dta %00000100
 dta %00000000

 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

 :10 brk


stars3
 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

 dta %00000000
 dta %00001010
 dta %00000100
 dta %00001010
 dta %00000000

 dta %00010000
 dta %00001010
 dta %00000100
 dta %00001010
 dta %00000001

 dta %00010001
 dta %00001010
 dta %00000100
 dta %00001010
 dta %00010001

 dta %00000001
 dta %00001010
 dta %00000100
 dta %00001010
 dta %00010000

 dta %00000000
 dta %00001010
 dta %00000100
 dta %00001010
 dta %00000000

 dta %00000000
 dta %00000000
 dta %00000100
 dta %00000000
 dta %00000000

 :5 brk



;---

// tablica z opisem 11 pozycji gwiazdek

.struct tstars_dta
addr .word
faza .byte
.ends

tstars dta tstars_dta [sile] (stars_0,0)

tmul5  dta 0,5,10,15,20,25,30,35,40

l_stars dta l( stars1, stars2 , stars3 , stars2 )
h_stars dta h( stars1, stars2 , stars3 , stars2 )

// pozycja pionowa ducha (11 pozycji co 8 linii)
posy
.rept sile
 dta 40+.r*8
.endr


// maska wczytana od tylu, bo licznik COUNT zliczamy od tylu
maska
.rept 11
 ins 'grat\grat_logos_maska_ok.scr',12+.r*32,8
.endr
