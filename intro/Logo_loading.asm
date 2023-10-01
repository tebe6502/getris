
fnt
 ins 'Logo_loading.fnt',0,70*8

scr
 ins 'Logo_loading.scr'

ant
 dta d'ppp',$44,a(scr)
 dta $04,$04,$70,$04,$04,$04
 dta $70,$04,$04,$04,$70,$04
 dta $04,$04,$70,$04,$04,$04
 dta $70,$04,$04,$04
 dta $41,a(ant)


main
 jsr wait

 lda #$00
 sta 712
 lda #$54
 sta 708
 lda #$8A
 sta 709
 lda #$68
 sta 710

 lda #$c
 sta 706
 sta 707

 lda <ant
 sta $d402
 sta 560
 lda >ant
 sta $d403
 sta 561

 lda #scr40
 sta $d400
 sta 559

 lda >fnt
 sta chbase

 mva #$40 $d40e		;switch on NMI+DLI again

 lda #$ff
 sta $d301

 rts
