/*
  Engine sterujacy klockami dla GETRIS'a
  v1.2 by TeBe/Madteam
  changes: 25.02.2005
*/

width	equ 12+3
height	equ 212-3

znak      equ klocek_char  ;$ff         procedura PRZEPISZ_CHAR jest dzieki temu szybsza

kloc      equ zp_free      ;(2)
kloc_tmp  equ kloc+2       ;(2)
klocek_nr equ kloc_tmp+2   ;(1)
pos_x     equ klocek_nr+1  ;(1)
pos_y     equ pos_x+1      ;(1)
old       equ pos_y+1      ;(1)
old_posy  equ old+1        ;(1)
rX        equ old_posy+1   ;(1)
tmpZ      equ rX+1         ;(3)

klocSCR1_tmp equ tmpZ+3         ;(2)
klocSCR2_tmp equ klocSCR1_tmp+2 ;(2)

lvl     equ klocSCR2_tmp+2      ;(1)


main
 
/*
  LET'S GO
*/

 jsr zapal_ekran

 mva #$ff mpt.player	; graj muze


loop
 ldx #max_fps		; opoznienie dla spadajacych klockow
wait equ *-1

hh jsr wajt

spacja lda #0
 bne _pokaz_space 

 lda $d20f
 and #4
 bne _no_key

 lda $d209
 cmp #28	; kod ESC
 beq escape
 cmp #33        ; kod SPACE
 bne _no_key

 sta spacja+1   ; nacisnieto spacje
 jmp _no_key

_pokaz_space
 lda pos_y
 and #7
 bne _no_key

 sta spacja+1
 
 lda #$ff
 sta init.pause_sw
 sta init.test+1

 ldy #0         ; zapamietanie starej zawartosci grafiki graczy
_c0
 lda pmBase1+$0300,y
 sta pg_tmp,y
 lda pmBase1+$0400,y
 sta pg_tmp+height+9,y
 iny
 cpy #height+9
 bne _c0

 jsr zgas_ekran
 jsr pause

 jmp restart


*--- ESCAPE

escape
 jsr zgas_ekran
 jmp logo.new_game


_no_key
 
 dex
 bne hh


 lda lvl                ; test usunietych linii w studni
line cmp #min_line      ; jesli osiagnieto liczbe usunietych linii to zwieksz licznik poziomow (licznik linii ++2)
 bcc _skp

 cmp #max_line          ; maksymalnie MAX_LINE linii do usuniecia na 1 poziom
 bcs _ls

 :2 inc line+1

_ls
 
 jsr zgas_ekran
 jsr well_done
 
 jsr zeruj_pasek

 inc licz_level.level   ; zwiekszamy licznik poziomow
 jsr licz_level

 lda #$ff
 sta init.test+1        ; zablokuj zerowanie licznika poziomow i licznika punktow

 lda delay              ; minimalne opoznienie spadajacych klockow = min_fps
 cmp #min_fps
 beq _res

 dec delay              ; zmniejsz opoznienie spadajacych klockow

_res
 lda #0
 sta msx_losuj+1        ; teraz mozemy wylosowac nowy modul MPT

 jmp restart
 
_skp

 lda #0
faza equ *-1
 beq cont
 
; wstawiamy puste linie w trzech wierszach na PMG
/*
 ldx #0
pustaczek equ *-1
 lda #0
 sta pmBase1+$300+8,x+2
 sta pmBase2+$300+8,x+2
 sta pmBase1+$400+8,x+2
 sta pmBase2+$400+8,x+2

 sta pmBase1+$300+16,x+2
 sta pmBase2+$300+16,x+2
 sta pmBase1+$400+16,x+2
 sta pmBase2+$400+16,x+2

 sta pmBase1+$300+24,x+2
 sta pmBase2+$300+24,x+2
 sta pmBase1+$400+24,x+2
 sta pmBase2+$400+24,x+2
*/

 lda #0
 sta spacja+1

 jsr test_line

.local __t
 bne _skip

 inc licznik.count+5            ; punkty na kazdy upuszczony klocek (+ 10 pkt)
 jsr licznik

_skip 
.endl

 jsr przepisz_char
 
 lda delay
 sta wait

 jsr init.studnia
 
 lda losuj_klocek.wylosowany
 :2 asl @
 sta klocek_nr

; and #%11111100
 sta maska

 jsr losuj_klocek
 jsr pokaz_klocek

 jsr get_kloc
 
 jsr test_posY
 beq cont               ; brak mozliwosci ruchu GAME OVER

/*
  GAME OVER - HIGH SCORE
*/

 jsr zgas_ekran
 
 jmp high_score

cont
 lda #108
 sta pkloc_jsr1.pos_y_add
; sta pkloc_jsr_p2.pos_y_add
 lda #72
 sta pkloc_jsr2.pos_y_add
 lda #36
 sta pkloc_jsr3.pos_y_add

 ldx #128
 lda pos_y
 and #7
 beq _s0
 
 ldx #klocek_char
_s0
 stx pkloc_jsr1.test
; stx pkloc_jsr_p2.test
 stx pkloc_jsr2.test
 stx pkloc_jsr3.test

 ldx #" "
 jsr put_klocek
 
 lda pos_y
 sta old_posy
 
;--- w dol do konca
 lda #0
w_dol equ *-1
 beq _skip2

 jsr test_posY
 sta faza
 bne _skip
 jsr test_posY
 sta faza
 bne _skip
 jsr test_posY
 sta faza
 bne _skip
 jsr test_posY
 sta faza
 jmp _skip

_skip2

;--- zmiana pozycji Y klocka
 jsr test_posY
 sta faza
 bne _skip
  
;--- zmiana fazy klocka
 lda #0
r_d010 equ *-1
 bne _skip_trig

 jsr test_faza
 lda #$ff
 sta r_d010

_skip_trig

;--- zmiana pozycji X klocka
 lda #0
r_d300 equ *-1
 cmp #7		; prawo
 beq _nxt0
 cmp #11	; lewo
 beq _nxt1
 cmp #13	; dol
 beq _nxt2
 
 jmp _end_joy

_nxt0           ; 7 prawo
 ldx #1
 jsr test_posX
 jmp _end_joy

_nxt1           ; 11 lewo
 ldx #$ff
 jsr test_posX
 jmp _end_joy

_nxt2           ; 13 dol
 sta w_dol
 lda #1
 sta wait
 jmp _skip


_end_joy
 lda #0
 sta read_joy
 sta r_d300
 sta w_dol
 lda delay
 sta wait

_skip


; lda w_dol
; beq ___skp
 
 lda $d300                      ; sprawdz czy trzymamy kierunek W_DOL
 and #$f
 cmp #13
 beq ___skp
 
 lda delay
 sta wait

 lda #0
 sta w_dol                      ; jesli inny kierunek to normalne spadanie klocka
 sta read_joy
 
___skp


 lda faza
 beq __skip
 dec pos_y
 
; jsr puste_linie

 lda #8*4
 sta pkloc_jsr1.pos_y_add
; sta pkloc_jsr_p2.pos_y_add
 sta pkloc_jsr2.pos_y_add
 sta pkloc_jsr3.pos_y_add

 lda #klocek_char
 sta pkloc_jsr1.test
; sta pkloc_jsr_p2.test
 sta pkloc_jsr2.test
 sta pkloc_jsr3.test

 ldx #znak
 jsr put_klocek

 jsr przepisz_pmg

 jmp loop 
__skip

; jsr puste_linie

 lda pos_y
 and #7
 asl @
 asl @
 sta pkloc_jsr1.pos_y_add
; sta pkloc_jsr_p2.pos_y_add
 sta pkloc_jsr2.pos_y_add
 sta pkloc_jsr3.pos_y_add

 ldx #znak
 jsr put_klocek

 jsr przepisz_pmg
 
 jmp loop

/*
  Wykasuj co 8-a linie w buforze
*/
/*
.proc puste_linie

 lda pos_y
 :3 lsr @
 :3 asl @
 clc
 adc #8

?ofs=3

 tax
 loa_buf kloc_tmp "+18-?ofs,x"
 
 stx pustaczek
 
 ldy #2
 lda #0
_loop
 sta (kloc_tmp),y
 iny
 cpy #width-1
 bne _loop

 txa
 clc
 adc #8
 cmp #[height/8]*8-1
 bcs stop


.local _f2
 tax
 loa_buf kloc_tmp "+18-?ofs,x"
 
 ldy #2
 lda #0
_loop
 sta (kloc_tmp),y
 iny
 cpy #width-1
 bne _loop
 
 txa
 clc
 adc #8
 cmp #[height/8]*8-1
 bcs stop
.endl 


.local _f3
 tax
 loa_buf kloc_tmp "+18-?ofs,x"
 
 ldy #2
 lda #0
_loop
 sta (kloc_tmp),y
 iny
 cpy #width-1
 bne _loop
.endl


stop
 rts
.endp
*/

/*
  Przepisz bufor na PMG (co wiersz)
*/
.proc przepisz_pmg_all

 lda #0
 sta rX

loop_
 tax
 loa_buf kloc_tmp "+11,x"

 ldx #0

 ldy #2
 move_pmg_i $80
 iny
 move_pmg $40
 iny
 move_pmg $20
 iny
 move_pmg $10
 iny
 move_pmg $08
 iny
 move_pmg $04

?ofs = 19

 txa
 ldx rX
 cmp pmBase1+$300+?ofs,x
 beq cont

 sta pmBase1+$300+?ofs,x
 sta pmBase1+$300+?ofs+1,x
 sta pmBase1+$300+?ofs+2,x
 sta pmBase1+$300+?ofs+3,x
 sta pmBase1+$300+?ofs+4,x
 sta pmBase1+$300+?ofs+5,x
 sta pmBase1+$300+?ofs+6,x

 sta pmBase2+$300+?ofs,x
 sta pmBase2+$300+?ofs+1,x
 sta pmBase2+$300+?ofs+2,x
 sta pmBase2+$300+?ofs+3,x
 sta pmBase2+$300+?ofs+4,x
 sta pmBase2+$300+?ofs+5,x
 sta pmBase2+$300+?ofs+6,x

; lda #0
; sta pmBase1+$300+?ofs+7,x
; sta pmBase2+$300+?ofs+7,x

cont
 ldx #0
 
 iny
 move_pmg_i $20
 iny
 move_pmg $10
 iny
 move_pmg $08
 iny
 move_pmg $04
 iny
 move_pmg $02
 iny
 move_pmg $01

 txa
 ldx rX
 cmp pmBase1+$400+?ofs,x
 beq cont2
 
 sta pmBase1+$400+?ofs,x
 sta pmBase1+$400+?ofs+1,x
 sta pmBase1+$400+?ofs+2,x
 sta pmBase1+$400+?ofs+3,x
 sta pmBase1+$400+?ofs+4,x
 sta pmBase1+$400+?ofs+5,x
 sta pmBase1+$400+?ofs+6,x

 sta pmBase2+$400+?ofs,x
 sta pmBase2+$400+?ofs+1,x
 sta pmBase2+$400+?ofs+2,x
 sta pmBase2+$400+?ofs+3,x
 sta pmBase2+$400+?ofs+4,x
 sta pmBase2+$400+?ofs+5,x
 sta pmBase2+$400+?ofs+6,x

; lda #0
; sta pmBase1+$400+?ofs+7,x
; sta pmBase2+$400+?ofs+7,x

cont2 
; lda rX
 txa
 clc
 adc #8
 sta rX
 cmp #[[height-7]/8]*8
 beq stop
 jmp loop_

stop
 rts
.endp


/*
  Przepisz bufor na znaki
*/
.proc przepisz_char

 lda #0
 sta rX

loop_
 tax
 :3 lsr @
 tay

 loa_buf kloc_tmp "+11,x"
 
 lda l_scr1+1,y
 sta tmp1+1
 lda h_scr1+1,y
 sta tmp1+2

 lda l_scr2+1,y
 sta tmp2+1
 lda h_scr2+1,y
 sta tmp2+2

 ldy #2
loop
 lda (kloc_tmp),y
 bne _put
 
 lda #puste_char
; bne _put

;_char 
; lda #klocek_char

_put
tmp1 sta $ffff,y
tmp2 sta $ffff,y

 iny
 cpy #12+2
 bne loop

; lda rX
 txa
 clc
 adc #8
 sta rX
 cmp #[[height-7]/8]*8
 bne loop_

 rts
.endp


/*
  Przepisz bufor na PMG (co linie)
*/
.macro move_pmg_i
 lda (kloc_tmp),y
 beq _skip
 ldx #:1
_skip
.endm

.macro move_pmg
 lda (kloc_tmp),y
 beq _skip
 txa
 ora #:1
 tax
_skip
.endm


/*
  Spadajacy klocek na PMG  
*/ 
.proc przepisz_pmg

 lda pos_y
 tax
 clc
 adc #24

 cmp #height-2
 bcc ok
 lda #height-1
ok
 sta max_y+1

 ldx old_posy
; stx rX
loop
 stx rX
 loa_buf kloc_tmp  ",x"

 ldx #0

 ldy #2
 move_pmg_i $80
 iny
 move_pmg $40
 iny
 move_pmg $20
 iny
 move_pmg $10
 iny
 move_pmg $08
 iny
 move_pmg $04

 stx tmpZ

 ldx #0

 iny
 move_pmg_i $20
 iny
 move_pmg $10
 iny
 move_pmg $08
 iny
 move_pmg $04
 iny
 move_pmg $02
 iny
 move_pmg $01

 txa
 ldx rX
 sta pmBase1+$400+8+3,x
 sta pmBase2+$400+8+3,x

 lda tmpZ
 sta pmBase1+$300+8+3,x
 sta pmBase2+$300+8+3,x

 inx
; stx rX
max_y cpx #0
 beq stop
 jmp loop

stop
 rts
.endp


/*
  Sprawdz mozliwosc zmiany fazy klocka
*/
.proc test_faza

 mwa kloc kloc_tmp

 ldx klocek_nr
 stx old
 
 inx
 txa
 and #3
 ora maska
 sta klocek_nr

 tay
 lda l_test,y
 sta jump+1
 lda h_test,y
 sta jump+2

 lda #0
jump jsr $ffff
 beq ok
 
 lda old
 sta klocek_nr
 
 lda #$ff
 rts

ok rts
.endp


/*
  Sprawdz mozliwosc zmiany pozycji X klocka
*/
.proc test_posX

 lda pos_x
 sta old

 txa
 clc
 adc pos_x
 sta pos_x
 
 jsr get_kloc

 mwa kloc kloc_tmp

 ldy klocek_nr
 lda l_test,y
 sta jump+1
 lda h_test,y
 sta jump+2

 lda #0
jump jsr $ffff
 beq ok
 
 lda old
 sta pos_x
 
 jsr get_kloc
 rts

ok rts
.endp


/*
  Sprawdz mozliwosc zmiany pozycji Y klocka
*/
.proc test_posY

 inc pos_y
 jsr get_kloc

 mwa kloc kloc_tmp

 ldy klocek_nr
 lda l_test,y
 sta jump+1
 lda h_test,y
 sta jump+2

 lda #0
jump jsr $ffff
 beq ok

; jsr get_kloc
 lda #$ff
 rts

ok
; jsr get_kloc
; lda #0
 rts

.endp


/*
  Skok do odpowiedniej procedury klocka
*/
.proc put_klocek

 lda pos_y
 :3 lsr @
 tay
 
 clc
 lda l_scr1,y
 adc pos_x
 sta klocSCR1_tmp
 sta klocSCR2_tmp
 lda h_scr1,y
 adc #0
 sta klocSCR1_tmp+1
 adc >text2-text1
 sta klocSCR2_tmp+1

 mwa kloc kloc_tmp

 ldy klocek_nr
 lda l_klocek,y
 sta jump+1
 lda h_klocek,y
 sta jump+2
 
 txa
jump jmp $ffff
.endp


/*
  ADD_KLOC_TMP
*/
.proc add_kloc_tmp
 clc
 adc kloc_tmp
 sta kloc_tmp
 bcc _skip
 inc kloc_tmp+1
_skip
 rts
.endp


.macro add_kloc
 ift :1=1
  inw kloc_tmp
 eli :1=2
  inw kloc_tmp
  inw kloc_tmp
 eli :1>2
  tax
  lda #:1
  jsr add_kloc_tmp
  txa
 eif

 .def ?lkl = 0
.endm


.macro lkl_close
 add_kloc ?lkl
.endm


.macro __kloc2tmpZ
 ift :1=0
  lkl_close
  mwx kloc_tmp tmpZ
 els
  mwx tmpZ kloc_tmp
  .def ?lkl = 0
 eif  
.endm


/*
  Procedury i makra dla konkretnej fazy klocka
*/
.macro pkloc

 ldy #:1

 ift :2=1
  jsr pkloc_jsr1
 eli :2=2
  jsr pkloc_jsr2
 eli :2=3
  jsr pkloc_jsr3
; eli :2=-2		; to powodowalo wymazanie klocka, NIE UZYWAC !!!
;  jsr pkloc_jsr_p2
 eif

.endm


// procedura realizujaca opadanie w poziomie dwoch klockow, na znakach
/*
.proc pkloc_jsr_p2
 ldx #0
pos_y_add equ *-1

; ldy #0
 lda (klocSCR1_tmp),y
 cmp #klocek_char
test equ *-1
 beq _skip
 lda klocSCR_fazy,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y
 iny
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y
 dey

_skip 
; ldy #40
 tya
 clc
 adc #40
 tay

 lda klocSCR_fazy+1,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y
 iny
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y 
 rts
.endp
*/


// procedura realizujaca opadanie w pionie jednego klocka, na znakach
.proc pkloc_jsr1
 ldx #0
pos_y_add equ *-1

; ldy #0
 lda (klocSCR1_tmp),y
 cmp #klocek_char
test equ *-1
 beq _skip
 lda klocSCR_fazy,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y

_skip 
; ldy #40
 tya
 clc
 adc #40
 tay

 lda klocSCR_fazy+1,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y 
 rts
.endp


// procedura realizujaca opadanie w pionie dwoch klockow, na znakach
.proc pkloc_jsr2
 ldx #0
pos_y_add equ *-1

; ldy #0
 lda (klocSCR1_tmp),y
 cmp #klocek_char
test equ *-1
 beq _skip
 lda klocSCR_fazy+36,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y

_skip
; ldy #40
 tya
 clc
 adc #40
 tay

 lda klocSCR_fazy+36+1,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y

; ldy #80
 tya
 adc #40
 tay

 lda klocSCR_fazy+36+2,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y 
 rts
.endp


// procedura realizujaca opadanie w pionie trzech klockow, na znakach
.proc pkloc_jsr3
 ldx #0
pos_y_add equ *-1

; ldy #0
 lda (klocSCR1_tmp),y
 cmp #klocek_char
test equ *-1
 beq _skip
 lda klocSCR_fazy+72,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y

_skip
; ldy #40
 tya
 clc
 adc #40
 tay

 lda klocSCR_fazy+72+1,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y

; ldy #80
 tya
 adc #40
 tay

 lda klocSCR_fazy+72+2,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y 

; ldy #120
 tya
 adc #40
 tay

 lda klocSCR_fazy+72+3,x
 sta (klocSCR1_tmp),y
 sta (klocSCR2_tmp),y 
 rts
.endp


// wypelniamy wartosciami bufor studni BUF
// pamiec studni zorganizowana jest jako tablica 2-d o wymiarach WIDTH*HEIGHT
.macro sta_kloc
 .def ?lkl = ?lkl + :1

 ift ?lkl=0
  jsr sta_kloc_jsr
 eli ?lkl=1
  jsr sta_kloc_jsr_plus1
 eli ?lkl=2
  jsr sta_kloc_jsr_plus2
 eli ?lkl=120
  jsr sta_kloc_jsr_plus120
 eli ?lkl=121
  jsr sta_kloc_jsr_plus121
 els
  add_kloc ?lkl
  jsr sta_kloc_jsr
 eif

.endm


sta_kloc_jsr
; ldy #width*7
; sta (kloc_tmp),y
 ldy #width*6
 sta (kloc_tmp),y
 ldy #width*5
 sta (kloc_tmp),y
 ldy #width*4
 sta (kloc_tmp),y
 ldy #width*3
 sta (kloc_tmp),y
 ldy #width*2
 sta (kloc_tmp),y
 ldy #width
 sta (kloc_tmp),y
 ldy #0
 sta (kloc_tmp),y
 rts


sta_kloc_jsr_plus1
; ldy #width*7+1
; sta (kloc_tmp),y
 ldy #width*6+1
 sta (kloc_tmp),y
 ldy #width*5+1
 sta (kloc_tmp),y
 ldy #width*4+1
 sta (kloc_tmp),y
 ldy #width*3+1
 sta (kloc_tmp),y
 ldy #width*2+1
 sta (kloc_tmp),y
 ldy #width+1
 sta (kloc_tmp),y
 ldy #0+1
 sta (kloc_tmp),y
 rts


sta_kloc_jsr_plus2
; ldy #width*7+2
; sta (kloc_tmp),y
 ldy #width*6+2
 sta (kloc_tmp),y
 ldy #width*5+2
 sta (kloc_tmp),y
 ldy #width*4+2
 sta (kloc_tmp),y
 ldy #width*3+2
 sta (kloc_tmp),y
 ldy #width*2+2
 sta (kloc_tmp),y
 ldy #width+2
 sta (kloc_tmp),y
 ldy #0+2
 sta (kloc_tmp),y
 rts


sta_kloc_jsr_plus120
; ldy #width*7+120
; sta (kloc_tmp),y
 ldy #width*6+120
 sta (kloc_tmp),y
 ldy #width*5+120
 sta (kloc_tmp),y
 ldy #width*4+120
 sta (kloc_tmp),y
 ldy #width*3+120
 sta (kloc_tmp),y
 ldy #width*2+120
 sta (kloc_tmp),y
 ldy #width+120
 sta (kloc_tmp),y
 ldy #0+120
 sta (kloc_tmp),y
 rts


sta_kloc_jsr_plus121
; ldy #width*7+121
; sta (kloc_tmp),y
 ldy #width*6+121
 sta (kloc_tmp),y
 ldy #width*5+121
 sta (kloc_tmp),y
 ldy #width*4+121
 sta (kloc_tmp),y
 ldy #width*3+121
 sta (kloc_tmp),y
 ldy #width*2+121
 sta (kloc_tmp),y
 ldy #width+121
 sta (kloc_tmp),y
 ldy #0+121
 sta (kloc_tmp),y
 rts


.macro lda_kloc

 .def ?lkl = ?lkl + :1

 ift ?lkl>=240
  lkl_close
 eif
 
 ldy #0+?lkl
 ora (kloc_tmp),y
; ldy #width
; ora (kloc_tmp),y
; ldy #width*2
; ora (kloc_tmp),y
 ldy #width*3+?lkl
 ora (kloc_tmp),y
; ldy #width*4
; ora (kloc_tmp),y
; ldy #width*5
; ora (kloc_tmp),y
; ldy #width*6
; ora (kloc_tmp),y
 ldy #width*8+?lkl
 ora (kloc_tmp),y
.endm


/*
  Definicje ksztalow i procedury obslugi klockow
*/
* KLOCEK 1 (2 fazy)
; ' * '
; ' * '
; ' * '
.proc klocek1_0
 .def ?lkl = 0
 sta_kloc 1
 sta_kloc width*8
 sta_kloc width*8

 pkloc 1 , 3
 rts

test
 .def ?lkl = 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
 rts 
.endp


; '   '
; '***'
; '   '
.proc klocek1_1
 .def ?lkl = 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc 1       , 1

 pkloc 40   , 1
 pkloc 40+1 , 1
 pkloc 40+2 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc 1
 rts
.endp


* KLOCEK 2 (4 fazy)
; ' * '
; ' * '
; ' **'
.proc klocek2_0
 .def ?lkl = 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40
 sta_kloc 1       , 1

 pkloc 1      , 3
 pkloc 2+2*40 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
 lda_kloc 1
 rts
.endp


; '   '
; '***'
; '*  '
.proc klocek2_1
 .def ?lkl = 0
 sta_kloc width*8 , 40
  __kloc2tmpZ 0
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc 1       , 1
 sta_kloc 1       , 1

 pkloc 40   , 2
 pkloc 40+1 , 1
 pkloc 40+2 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
  __kloc2tmpZ 0
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc 1
 lda_kloc 1
 rts
.endp


; '** '
; ' * '
; ' * '
.proc klocek2_2
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 0 , 1
 pkloc 1 , 3
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


; '  *'
; '***'
; '   '
.proc klocek2_3
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc 2       , 2

 pkloc 40   , 1
 pkloc 40+1 , 1
 pkloc 2    , 2
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc 2
 rts
.endp


* KLOCEK 3 (1 faza)
; '   '
; ' **'
; ' **'
.proc klocek3_0
 .def ?lkl = 0
 sta_kloc 1+width*8 , 1+40
  __kloc2tmpZ 0
 sta_kloc 1         , 1
  __kloc2tmpZ 1
 sta_kloc width*8   , 40
 sta_kloc 1         , 1

 pkloc 1+40 , 2
 pkloc 2+40 , 2 
 rts

test
 .def ?lkl = 0
 lda_kloc 1+width*8
  __kloc2tmpZ 0
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc 1
 rts
.endp


* KLOCEK 4 (2 fazy)
; '   '
; ' **'
; '** '
.proc klocek4_0
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1+width*8 , 1+40
 sta_kloc 1         , 1
  __kloc2tmpZ 1
 sta_kloc width*2*8 , 40*2
 sta_kloc 1         , 1

 pkloc 1+40 , 2
 pkloc 2+40 , 1
 pkloc 2*40 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1+width*8
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*2*8
 lda_kloc 1
 rts
.endp


; '*  '
; '** '
; ' * '
.proc klocek4_1
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc width*8 , 40

 pkloc 0    , 2
 pkloc 1+40 , 2
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc width*8
 rts
.endp


* KLOCEK 5 (2 fazy)
; '   '
; '** '
; ' **'
.proc klocek5_0
 .def ?lkl = 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc 1       , 1

 pkloc 40     , 1
 pkloc 1+40   , 2
 pkloc 2+2*40 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc width*8
 lda_kloc 1
 rts
.endp


; ' * '
; '** '
; '*  '
.proc klocek5_1
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 1  , 2
 pkloc 40 , 2
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


* KLOCEK 6 (1 faza)
; ' * '
; '***'
; ' * '
.proc klocek6_0
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc width*8 , 40
 sta_kloc 2       , 2

 pkloc 1    , 3
 pkloc 40   , 1
 pkloc 2+40 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc 2
 rts
.endp


* KLOCEK 7 (4 fazy)
; '   '
; '***'
; ' * '
.proc klocek7_0
 .def ?lkl = 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
  __kloc2tmpZ 0
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc width*8 , 40

 pkloc 40   , 1
 pkloc 40+1 , 2
 pkloc 40+2 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
 lda_kloc 1
  __kloc2tmpZ 0
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 rts
.endp


; ' * '
; '** '
; ' * '
.proc klocek7_1
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc width*8 , 40

 pkloc 1  , 3
 pkloc 40 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc width*8
 rts
.endp


; ' * '
; '***'
; '   '
.proc klocek7_2
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc width*8 , 40

 pkloc 1    , 2
 pkloc 40   , 1
 pkloc 2+40 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 rts
.endp


; ' * '
; ' **'
; ' * '
.proc klocek7_3
 .def ?lkl = 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
  __kloc2tmpZ 0
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc 1       , 1

 pkloc 1    , 3
 pkloc 2+40 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc 1
 lda_kloc width*8
  __kloc2tmpZ 0
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc 1
 rts
.endp


* KLOCEK 8 (4 fazy)
; '  *'
; '  *'
; '***'
.proc klocek8_0
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 2         , 2
 sta_kloc width*8   , 40
 sta_kloc width*8   , 40
  __kloc2tmpZ 1 
 sta_kloc width*2*8 , 40*2
 sta_kloc 1         , 1

 pkloc 2      , 3
 pkloc 2*40   , 1
 pkloc 2*40+1 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 2
 lda_kloc width*8
 lda_kloc width*8
  __kloc2tmpZ 1 
 lda_kloc width*2*8
 lda_kloc 1
 rts
.endp


; '*  '
; '*  '
; '***'
.proc klocek8_1
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc 1       , 1

 pkloc 0      , 3
 pkloc 1+2*40 , 1
 pkloc 2+2*40 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc width*8
 lda_kloc width*8
 lda_kloc 1
 lda_kloc 1
 rts
.endp


; '***'
; '*  '
; '*  '
.proc klocek8_2
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 0       , 0
 sta_kloc 1       , 1
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 0 , 3
 pkloc 1 , 1
 pkloc 2 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 0
 lda_kloc 1
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


; '***'
; '  *'
; '  *'
.proc klocek8_3
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc 1       , 1
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 0 , 1
 pkloc 1 , 1
 pkloc 2 , 3
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc 1
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


* KLOCEK 9 (4 fazy)
; '** '
; '** '
; '*  '
.proc klocek9_0
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 0       , 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 0 , 3
 pkloc 1 , 2
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 0
 lda_kloc 1
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


; '***'
; ' **'
; '   '
.proc klocek9_1
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc 1       , 1
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
  __kloc2tmpZ 1
 sta_kloc width*8 , 40

 pkloc 0 , 1
 pkloc 1 , 2
 pkloc 2 , 2
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc 1
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc width*8
 rts
.endp


; '  *'
; ' **'
; ' **'
.proc klocek9_2
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 2         , 2
 sta_kloc width*8   , 40
 sta_kloc width*8   , 40
  __kloc2tmpZ 1
 sta_kloc 1+width*8 , 1+40
 sta_kloc width*8   , 40

 pkloc 2    , 3
 pkloc 1+40 , 2
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 2
 lda_kloc width*8
 lda_kloc width*8
  __kloc2tmpZ 1
 lda_kloc 1+width*8
 lda_kloc width*8
 rts
.endp


; '   '
; '** '
; '***'
.proc klocek9_3
 .def ?lkl = 0
 sta_kloc width*8 , 40
  __kloc2tmpZ 0
 sta_kloc 1       , 1
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc width*8 , 40

 pkloc 40     , 2
 pkloc 1+40   , 2
 pkloc 2+2*40 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 rts
.endp


* KLOCEK 10 (4 fazy)
; ' * '
; ' * '
; '** '
.proc klocek10_0
 .def ?lkl = 0
  __kloc2tmpZ 0
 sta_kloc 1         , 1
 sta_kloc width*8   , 40
 sta_kloc width*8   , 40
  __kloc2tmpZ 1 
 sta_kloc width*2*8 , 40*2

 pkloc 1    , 3
 pkloc 2*40 , 1
 rts

test
 .def ?lkl = 0
  __kloc2tmpZ 0
 lda_kloc 1
 lda_kloc width*8
 lda_kloc width*8
  __kloc2tmpZ 1 
 lda_kloc width*2*8
 rts
.endp


; '*  '
; '***'
; '   '
.proc klocek10_1
 .def ?lkl = 0
 sta_kloc 0       , 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc 1       , 1

 pkloc 0     , 2
 pkloc 1+40  , 1
 pkloc 2+40  , 1
 rts

test
 .def ?lkl = 0
 lda_kloc 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc 1
 rts
.endp


; ' **'
; ' * '
; ' * '
.proc klocek10_2
 .def ?lkl = 0
 sta_kloc 1       , 1
  __kloc2tmpZ 0 
 sta_kloc 1       , 1
  __kloc2tmpZ 1
 sta_kloc width*8 , 40
 sta_kloc width*8 , 40

 pkloc 1 , 3
 pkloc 2 , 1
 rts

test
 .def ?lkl = 0
 lda_kloc 1
  __kloc2tmpZ 0
 lda_kloc 1
  __kloc2tmpZ 1
 lda_kloc width*8
 lda_kloc width*8
 rts
.endp


; '   '
; '***'
; '  *'
.proc klocek10_3
 .def ?lkl = 0
 sta_kloc width*8 , 40
 sta_kloc 1       , 1
 sta_kloc 1       , 1
 sta_kloc width*8 , 40

 pkloc 40   , 1
 pkloc 40+1 , 1
 pkloc 40+2 , 2
 rts

test
 .def ?lkl = 0
 lda_kloc width*8
 lda_kloc 1
 lda_kloc 1
 lda_kloc width*8
 rts
.endp


/*
  ustawia adres 'kloc' wg aktualnej pozycji X,Y klocka
*/
.proc get_kloc

 ldy pos_y

 clc
 lda l_buf,y
 adc pos_x
 sta kloc
 lda h_buf,y
 adc #0
 sta kloc+1 
 rts

.endp


/*
  losujemy wartosc z przedzialu <0..8>
*/
.proc losuj_klocek
; lda licz_level.level
; cmp #nowy_klocek               ; jesli level >= NOWY_KLOCEK wtedy dochodzi nowy ksztalt klocka
; bcs los9

; lda $d20a
; and #1
; sta _add0+1

; lda $d20a
; and #%00011100
; :2 lsr @
; clc
;_add0 adc #0

; sta wylosowany
; rts

los9
 lda $d20a
 lsr @
 lsr @
 and #$f
 tay
 lda tlos,y

 sta wylosowany
 rts

wylosowany brk

tlos dta 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5
.endp


/*
  Testowanie linii i przemieszczenie studni w dol
*/
.macro put
 ldy #:1
 lda (kloc),y
 sta (kloc_tmp),y
 ldy #:1+width
 sta (kloc_tmp),y
 ldy #:1+width*2
 sta (kloc_tmp),y
 ldy #:1+width*3
 sta (kloc_tmp),y
 ldy #:1+width*4
 sta (kloc_tmp),y
 ldy #:1+width*5
 sta (kloc_tmp),y
 ldy #:1+width*6
 sta (kloc_tmp),y
.endm

.proc move_kloc
 put 2
 put 3
 put 4
 put 5
 put 6
 put 7
 put 8
 put 9
 put 10
 put 11
 put 12
 put 13
 rts
.endp


.proc move

 lda old
 sta tmp
 
loop2
 ldy #0
tmp equ *-1

 loa_buf kloc_tmp ",y"

 tya
 sec
 sbc #8
 sta tmp
 tay

 loa_buf kloc ",y"

 jsr move_kloc

 lda tmp
 cmp #16
 bcs loop2

 jsr przepisz_char
 jmp przepisz_pmg_all
.endp


// testujemy pozioma linie w studni, jesli jest cala to usuwamy ja i zwiekszamy licznik punktow
.proc test_line
 lda #0
 sta hit+1

 ldy pos_y
; clc
; adc #1
 iny
 sty old

.local _f1
; tay
 loa_buf kloc_tmp ",y"

 ldy #2
 lda (kloc_tmp),y
 ldy #13
 and (kloc_tmp),y 
 beq fault
 ldy #3
 lda (kloc_tmp),y 
 ldy #12
 and (kloc_tmp),y 
 beq fault
 ldy #4
 lda (kloc_tmp),y 
 ldy #11
 and (kloc_tmp),y 
 beq fault
 ldy #5
 lda (kloc_tmp),y 
 ldy #10
 and (kloc_tmp),y 
 beq fault
 ldy #6
 lda (kloc_tmp),y 
 ldy #9
 and (kloc_tmp),y 
 beq fault
 ldy #7
 lda (kloc_tmp),y 
 ldy #8
 and (kloc_tmp),y 
 beq fault

 sty hit+1
 inc lvl
 
 jsr line_pkt
 jsr move
 jmp fault
quit rts

fault
 lda old
 clc
 adc #8
 sta old
 
 cmp #height-1
 bcs quit
.endl


.local _f2
 tay
 loa_buf kloc_tmp ",y"

 ldy #2
 lda (kloc_tmp),y 
 ldy #13
 and (kloc_tmp),y 
 beq fault
 ldy #3
 lda (kloc_tmp),y 
 ldy #12
 and (kloc_tmp),y 
 beq fault
 ldy #4
 lda (kloc_tmp),y 
 ldy #11
 and (kloc_tmp),y 
 beq fault
 ldy #5
 lda (kloc_tmp),y 
 ldy #10
 and (kloc_tmp),y 
 beq fault
 ldy #6
 lda (kloc_tmp),y 
 ldy #9
 and (kloc_tmp),y 
 beq fault
 ldy #7
 lda (kloc_tmp),y 
 ldy #8
 and (kloc_tmp),y 
 beq fault

 sty hit+1
 inc lvl

 jsr line_pkt
 jsr move
 jmp fault
quit rts

fault
 lda old
 clc
 adc #8
 sta old
 
 cmp #height-1
 bcs quit
.endl


.local _f3
 tay
 loa_buf kloc_tmp ",y"

 ldy #2
 lda (kloc_tmp),y 
 ldy #13
 and (kloc_tmp),y 
 beq fault
 ldy #3
 lda (kloc_tmp),y 
 ldy #12
 and (kloc_tmp),y 
 beq fault
 ldy #4
 lda (kloc_tmp),y 
 ldy #11
 and (kloc_tmp),y 
 beq fault
 ldy #5
 lda (kloc_tmp),y 
 ldy #10
 and (kloc_tmp),y 
 beq fault
 ldy #6
 lda (kloc_tmp),y 
 ldy #9
 and (kloc_tmp),y 
 beq fault
 ldy #7
 lda (kloc_tmp),y 
 ldy #8
 and (kloc_tmp),y 
 beq fault

 sty hit+1
 inc lvl
 
 jsr line_pkt
 jsr move
 
fault 
.endl


hit lda #0
 rts


// licznik punktow za skasowanie calej linii (max *16)
line_pkt
 lda licz_level.level
 and #$0f
 tay

pkt_
 inc licznik.count+4            ; + 100 pkt
 jsr licznik

 dey
 bpl pkt_


// jesli zostala usunieta linia (HIT>0) to zwieksz poziomy pasek symbolizujacy usuniete linie
 lda hit+1
 beq _skp

 ldy line+1
 
 lda real
 clc
 adc ulamki-min_line,y
 sta real
 bcc _skp

 inc real+1

 ldy real+1
 cpy #6				; nie mozemy przekroczyc 5 znakow
 bcs _skp

 lda pas1-1,y
 sta text1+17*40+31-1,y		; pasek pokazujacy usuniete linie

 lda pas2-1,y
 sta text2+17*40+31-1,y

_skp
 rts


real 	 .word

pas1 dta 171,172,173,46,47
pas2 dta 154,155,156,29,30

ulamki dta 160 , 142 , 128 , 117 , 107 , 99 , 92 , 85 , 80 , 75

.endp


/*
  Zeruj pasek pokazujacy usuniete linie
*/
zeruj_pasek

 lda #0

 sta lvl                        ; wyzeruj licznik usunietych linii

 sta test_line.real
 sta test_line.real+1

 sta text1+17*40+31		; czyscimy poziomy pasek pokazujacy usuniete linie
 sta text1+17*40+31+1
 sta text1+17*40+31+2
 sta text1+17*40+31+3
 sta text1+17*40+31+4

 sta text2+17*40+31
 sta text2+17*40+31+1
 sta text2+17*40+31+2
 sta text2+17*40+31+3
 sta text2+17*40+31+4

 rts


/*
  INIT
*/
.proc init

test lda #0
 bne _s

 jsr zeruj_pasek

 sta licz_level.level		; zerujemy licznik leveli i punktow
 jsr licz_level

 jsr licznik.reset

_s

 mwa #text1 adr                 ; ustawiamy pierwszy ekran

 lda #delay_joy_default_value
 sta delay_joy
 sta read_joy

 lda #delay_trig_default_value
 sta delay_trig

 lda delay
 sta wait

; czyscimy obszar studni ze spritami

 lda pause_sw           ; czy mamy czyscic zawartosc studni ?
 bne _s0

 ldy #0
 tya
_clr
 sta pmBase1+$0300,y
 sta pmBase1+$0400,y
 sta pmBase2+$0300,y
 sta pmBase2+$0400,y
 iny
 cpy #height+9
 bne _clr

 jsr studnia

 mwa #buf fill+1
 
 ldx >[width*height]
 inx
 ldy #0
 tya

lp jsr fill
 iny
 bne lp
 inc fill+2
 dex
 bne lp

 mwa #buf+width*[height-1] fill+1

 ldy #0
 lda #$ff 

lp2 jsr fill
 iny
 bne lp2

_s0

 jsr przepisz_char
 

 lda pause_sw           ; czy mamy zerowac zawartosc studni ?
 bne _s1

 lda #0
 sta pos_x
 sta faza
 sta pos_y

 jsr get_kloc
 
 ldx #height
loop1 lda #znak
 ldy #0
 sta (kloc),y
 iny
 sta (kloc),y 
 ldy #width-1
 sta (kloc),y

 lda kloc
 clc
 adc #width
 sta kloc
 bcc _skp
 inc kloc+1
_skp

 dex
 bne loop1
 

 lda #height-1
 sta pos_y 
 jsr get_kloc
 
 lda #znak
 ldy #width-1
loop2 sta (kloc),y
 dey
 bpl loop2

 lda #[width-1]/2
 sta pos_x
 sta pos_y
 
 jsr get_kloc

 jsr licz_level
 
 jsr losuj_klocek
 jsr pokaz_klocek

_s1


 lda pause_sw
 beq _s2


 ldy #0         ; przywracamy stara zawartosc grafiki graczy
_c0
 lda pg_tmp,y
 sta pmBase1+$0300,y
 sta pmBase2+$0300,y
 lda pg_tmp+height+9,y
 sta pmBase1+$0400,y
 sta pmBase2+$0400,y
 iny
 cpy #height+9
 bne _c0

 jsr get_kloc   ; ustaw adres klocka

 ldx #" "
 jsr put_klocek

_s2
 
 lda #0
 sta pause_sw
 sta test+1
 rts


studnia
 lda #[width-1]/2
 sta pos_x

 lda #0
 sta faza
 sta w_dol
 sta read_joy
 sta r_d300
 sta pos_y
 sta old_posy
 rts


fill sta $ffff,y
 rts 

pause_sw brk

.endp


/*
  Init PMG
  Wylaczenie obrazu i zerowanie Playera #1
*/
init_pmg
 mva #0 $d40e
 sta $d400
 sta player1_size
 sta player1_positionX
 rts

/*
  Well Done
*/
.proc well_done

 jsr wajt

 jsr init_pmg

 lda <fad_well
 ldx >fad_well
 jsr set_fade

 jsr well.main

 rts

fad_well dta a(well.l_tcol , well.h_tcol , well.t_satur ,well.t_color , well.color_nr)
.endp


/*
  Pause
*/
.proc pause

 jsr wajt

 jsr init_pmg

 lda <fad_pause
 ldx >fad_pause
 jsr set_fade

 jsr pau.main

 rts

fad_pause dta a(pau.l_tcol , pau.h_tcol , pau.t_satur ,pau.t_color , pau.color_nr)
.endp


/*
  High Score
*/
.proc high_score

 jsr wajt
 jsr init_pmg

; ekran CONGRATULATIONS
 jsr logo.input_string.pozycja

 cpx #0
 bne g_over
 
 jsr congrat

 jmp h_score


; ekran GAME OVER
; modyfikacja procedur wygaszajacych kolory
g_over

; jsr wajt
; jsr init_pmg

 lda <fad_over
 ldx >fad_over
 jsr set_fade

 jsr game_over.main


; ekran HIGH SCORE 
h_score

 jsr init_pmg

 lda <fad_high
 ldx >fad_high
 jsr set_fade
 
 jmp logo.main

fad_over dta a(game_over.l_tcol , game_over.h_tcol , game_over.t_satur , game_over.t_color , game_over.color_nr)
fad_high dta a(logo.l_tcol , logo.h_tcol , logo.t_satur , logo.t_color , logo.color_nr)
.endp


/*
  Modyfikujemy procedury fade_in, fade_out
*/
.proc set_fade
 sta tmpZ
 stx tmpZ+1
 
 ldy #0

 lda (tmpZ),y
 sta logo.fade_in.ltc0+1
 sta logo.fade_out.ltc1+1
 sta logo.ltc2+1
 iny
 lda (tmpZ),y
 sta logo.fade_in.ltc0+2
 sta logo.fade_out.ltc1+2
 sta logo.ltc2+2
  
 iny
 lda (tmpZ),y
 sta logo.fade_in.htc0+1
 sta logo.fade_out.htc1+1
 sta logo.htc2+1
 iny
 lda (tmpZ),y
 sta logo.fade_in.htc0+2
 sta logo.fade_out.htc1+2
 sta logo.htc2+2

 iny
 lda (tmpZ),y
 sta logo.fade_in.sat0+1
 sta logo.sat1+1
 iny
 lda (tmpZ),y
 sta logo.fade_in.sat0+2
 sta logo.sat1+2

 iny
 lda (tmpZ),y
 sta logo.fade_in.tco0+1
 sta logo.tco1+1
 iny
 lda (tmpZ),y
 sta logo.fade_in.tco0+2
 sta logo.tco1+2

 iny
 lda (tmpZ),y
 sta logo.fade_in.col_nr0+1
 sta logo.fade_out.col_nr1+1
 sta logo.col_nr2+1

 rts

.endp


/*
  Licznik LEVEL
*/
.macro put_kloc ' '

 lda pokaz_klocek.l_klo,y
 sta kloc_tmp
 lda pokaz_klocek.h_klo,y
 sta kloc_tmp+1

 ldy #0
 lda (kloc_tmp),y
 sta :1
 sta :2
 iny
 lda (kloc_tmp),y
 sta :1+1
 sta :2+1
 iny
 lda (kloc_tmp),y
 sta :1+2
 sta :2+2
 iny
 lda (kloc_tmp),y
 sta :1+3
 sta :2+3
 iny
 lda (kloc_tmp),y
 sta :1+4
 sta :2+4
 iny
 lda (kloc_tmp),y
 sta :1+5
 sta :2+5
 iny
 lda (kloc_tmp),y
 sta :1+6
 sta :2+6
 iny
 lda (kloc_tmp),y
 sta :1+7
 sta :2+7
.endm


/*
  pokazuje na ekranie klocek o numerze 'WYLOSOWANY'
  grafika skompresowana OPTYMIZING (plik SCR i FNT)
*/
.proc pokaz_klocek

 lda losuj_klocek.wylosowany
 sta _add+1

 :3 asl @
 clc
_add adc #0

 tax

; 74,75,76  Charset #2
; 88,89,90  Charset #2
; 11,12,13  Charset #3

; 61,62,63  Charset #2
; 76,77,78  Charset #2
; 92,93,94  Charset #2

 ldy klocki_gfx,x
 put_kloc fnt1+2*$400+74*8  fnt2+2*$400+61*8
 ldy klocki_gfx+1,x
 put_kloc fnt1+2*$400+75*8  fnt2+2*$400+62*8
 ldy klocki_gfx+2,x
 put_kloc fnt1+2*$400+76*8  fnt2+2*$400+63*8

 ldy klocki_gfx+3,x
 put_kloc fnt1+2*$400+88*8  fnt2+2*$400+76*8
 ldy klocki_gfx+4,x
 put_kloc fnt1+2*$400+89*8  fnt2+2*$400+77*8
 ldy klocki_gfx+5,x
 put_kloc fnt1+2*$400+90*8  fnt2+2*$400+78*8

 ldy klocki_gfx+6,x
 put_kloc fnt1+3*$400+11*8  fnt2+2*$400+92*8
 ldy klocki_gfx+7,x
 put_kloc fnt1+3*$400+12*8  fnt2+2*$400+93*8
 ldy klocki_gfx+8,x
 put_kloc fnt1+3*$400+13*8  fnt2+2*$400+94*8
 rts

l_klo
 :24 dta l(klocki_gfx+30*3+#*8)

h_klo
 :24 dta h(klocki_gfx+30*3+#*8)

.endp


/*
  Licznik LEVEL
*/
.macro put_char ' '
 tay
 lda licz_level.l_lev,y
 sta kloc_tmp
 lda licz_level.h_lev,y
 sta kloc_tmp+1

 ldy #0
 lda (kloc_tmp),y
 tax
 ora :3
 sta :1
 txa
 ora :4
 sta :2
 iny
 lda (kloc_tmp),y
 tax
 ora :3+1
 sta :1+1
 txa
 ora :4+1
 sta :2+1
 iny
 lda (kloc_tmp),y
 tax
 ora :3+2
 sta :1+2
 txa
 ora :4+2
 sta :2+2
 iny
 lda (kloc_tmp),y
 tax
 ora :3+3
 sta :1+3
 txa
 ora :4+3
 sta :2+3
 iny
 lda (kloc_tmp),y
 tax
 ora :3+4
 sta :1+4
 txa
 ora :4+4
 sta :2+4
 iny
 lda (kloc_tmp),y
 tax
 ora :3+5
 sta :1+5
 txa
 ora :4+5
 sta :2+5
 iny
 lda (kloc_tmp),y
 tax
 ora :3+6
 sta :1+6
 txa
 ora :4+6
 sta :2+6
 iny
 lda (kloc_tmp),y
 tax
 ora :3+7
 sta :1+7
 txa
 ora :4+7
 sta :2+7
.endm


.proc licz_level

; 14,15,16   Charset #4
; 41,42,43   Charset #4

; 97,98,99   Charset #3
; 20,21,22   Charset #4

;tlo1
; 95,96,97
; 98,7,99

;tlo1
; 100,101,102
; 103,7,104

 ldy level
 cpy #59
 bne skip
 ldy #0
 sty level

skip
 lda l_licz,y
 sta tmpZ
 lda h_licz,y
 sta tmpZ+1

 ldy #0
 lda (tmpZ),y
 put_char fnt1+4*$400+14*8  fnt2+3*$400+97*8  level_gfx+360+95*8  level_gfx+360+100*8
 ldy #1
 lda (tmpZ),y
 put_char fnt1+4*$400+15*8  fnt2+3*$400+98*8  level_gfx+360+96*8  level_gfx+360+101*8
 ldy #2
 lda (tmpZ),y
 put_char fnt1+4*$400+16*8  fnt2+3*$400+99*8  level_gfx+360+97*8  level_gfx+360+102*8
 
 ldy #3
 lda (tmpZ),y
 put_char fnt1+4*$400+41*8  fnt2+4*$400+20*8  level_gfx+360+98*8  level_gfx+360+103*8
 ldy #4
 lda (tmpZ),y
 put_char fnt1+4*$400+42*8  fnt2+4*$400+21*8  level_gfx+360+7*8   level_gfx+360+7*8
 ldy #5
 lda (tmpZ),y
 put_char fnt1+4*$400+43*8  fnt2+4*$400+22*8  level_gfx+360+99*8  level_gfx+360+104*8
 rts


l_licz
 :60 dta l(level_gfx+#*6)

h_licz
 :60 dta h(level_gfx+#*6)

l_lev
 :95 dta l(level_gfx+360+#*8)

h_lev
 :95 dta h(level_gfx+360+#*8)

level brk
.endp


/*
  Licznik SCORE
*/
.proc licznik

 ldx #6

lp
 lda count,x
 cmp #10
 bcc skp
 sec
 sbc #10
 sta count,x
 inc count-1,x

skp
 dex
 bne lp
 

/*
 lda count+6
 cmp #10
 bcc t1
 sec
 sbc #10
 sta count+6
 inc count+5

t1
 lda count+5
 cmp #10
 bcc t2
 sec
 sbc #10
 sta count+5
 inc count+4

t2
 lda count+4
 cmp #10
 bcc t3
 sec
 sbc #10
 sta count+4
 inc count+3

t3
 lda count+3
 cmp #10
 bcc t4
 sec
 sbc #10
 sta count+3
 inc count+2

t4
 lda count+2
 cmp #10
 bcc t5
 sec
 sbc #10
 sta count+2
 inc count+1

t5
 lda count+1
 cmp #10
 bcc t6
 sec
 sbc #10
 sta count+1
 inc count

t6
 rts
*/

display ldx #0
dsp lda count,x

 and #%00001111
 clc
 adc #"Y"*
 sta text1+7*40+30,x
 adc #$ff
 sta text2+7*40+30,x
 
 inx
 cpx #7
 bcc dsp
 rts


reset
 lda #0
 ldx #6

res
 sta count,x
 dex
 bpl res
 jmp display
 

count :7 brk

.endp


/*
 adresy procedur dla klockow

;77    **
;CDE    **
;SSS   ***
t_klocek1
 dta d' 7 '*
 dta d' D '*
 dta d' S '*

 dta d' 7 '*
 dta d' D '*
 dta d' SS'*

 dta d'   '*
 dta d' EE'*
 dta d' SS'*

 dta d'   '*
 dta d' EE'*
 dta d'SS '*

 dta d'   '*
 dta d'EE '*
 dta d' SS'*

 dta d'   '*
 dta d'EEE'*
 dta d' S '*

 dta d'  7'*
 dta d'  D'*
 dta d'SSS'*

 dta d'77 '*
 dta d'DD '*
 dta d'S  '*

 dta d' 7 '*
 dta d'EDE'*
 dta d' S '*

;<<    **
;IJK    **
;YYY   ***
t_klocek2
 dta d' < '*
 dta d' J '*
 dta d' Y '*

 dta d' < '*
 dta d' J '*
 dta d' YY'*

 dta d'   '*
 dta d' KK'*
 dta d' YY'*

 dta d'   '*
 dta d' KK'*
 dta d'YY '*

 dta d'   '*
 dta d'KK '*
 dta d' YY'*

 dta d'   '*
 dta d'KKK'*
 dta d' Y '*

 dta d'  <'*
 dta d'  J'*
 dta d'YYY'*

 dta d'<< '*
 dta d'JJ '*
 dta d'Y  '*

 dta d' < '*
 dta d'KJK'*
 dta d' Y '*
*/


l_klocek
 dta l(klocek1_0,klocek1_1,klocek1_0,klocek1_1)
 dta l(klocek2_0,klocek2_1,klocek2_2,klocek2_3)
 dta l(klocek3_0,klocek3_0,klocek3_0,klocek3_0)
 dta l(klocek4_0,klocek4_1,klocek4_0,klocek4_1)
 dta l(klocek5_0,klocek5_1,klocek5_0,klocek5_1)
 dta l(klocek7_0,klocek7_1,klocek7_2,klocek7_3)
 dta l(klocek8_0,klocek8_1,klocek8_2,klocek8_3)
 dta l(klocek9_0,klocek9_1,klocek9_2,klocek9_3)
 dta l(klocek10_0,klocek10_1,klocek10_2,klocek10_3)
 dta l(klocek6_0,klocek6_0,klocek6_0,klocek6_0)

h_klocek
 dta h(klocek1_0,klocek1_1,klocek1_0,klocek1_1)
 dta h(klocek2_0,klocek2_1,klocek2_2,klocek2_3)
 dta h(klocek3_0,klocek3_0,klocek3_0,klocek3_0)
 dta h(klocek4_0,klocek4_1,klocek4_0,klocek4_1)
 dta h(klocek5_0,klocek5_1,klocek5_0,klocek5_1)
 dta h(klocek7_0,klocek7_1,klocek7_2,klocek7_3)
 dta h(klocek8_0,klocek8_1,klocek8_2,klocek8_3)
 dta h(klocek9_0,klocek9_1,klocek9_2,klocek9_3)
 dta h(klocek10_0,klocek10_1,klocek10_2,klocek10_3)
 dta h(klocek6_0,klocek6_0,klocek6_0,klocek6_0)

l_test
 dta l(klocek1_0.test,klocek1_1.test,klocek1_0.test,klocek1_1.test)
 dta l(klocek2_0.test,klocek2_1.test,klocek2_2.test,klocek2_3.test)
 dta l(klocek3_0.test,klocek3_0.test,klocek3_0.test,klocek3_0.test)
 dta l(klocek4_0.test,klocek4_1.test,klocek4_0.test,klocek4_1.test)
 dta l(klocek5_0.test,klocek5_1.test,klocek5_0.test,klocek5_1.test)
 dta l(klocek7_0.test,klocek7_1.test,klocek7_2.test,klocek7_3.test)
 dta l(klocek8_0.test,klocek8_1.test,klocek8_2.test,klocek8_3.test)
 dta l(klocek9_0.test,klocek9_1.test,klocek9_2.test,klocek9_3.test)
 dta l(klocek10_0.test,klocek10_1.test,klocek10_2.test,klocek10_3.test)
 dta l(klocek6_0.test,klocek6_0.test,klocek6_0.test,klocek6_0.test)

h_test
 dta h(klocek1_0.test,klocek1_1.test,klocek1_0.test,klocek1_1.test)
 dta h(klocek2_0.test,klocek2_1.test,klocek2_2.test,klocek2_3.test)
 dta h(klocek3_0.test,klocek3_0.test,klocek3_0.test,klocek3_0.test)
 dta h(klocek4_0.test,klocek4_1.test,klocek4_0.test,klocek4_1.test)
 dta h(klocek5_0.test,klocek5_1.test,klocek5_0.test,klocek5_1.test)
 dta h(klocek7_0.test,klocek7_1.test,klocek7_2.test,klocek7_3.test)
 dta h(klocek8_0.test,klocek8_1.test,klocek8_2.test,klocek8_3.test)
 dta h(klocek9_0.test,klocek9_1.test,klocek9_2.test,klocek9_3.test)
 dta h(klocek10_0.test,klocek10_1.test,klocek10_2.test,klocek10_3.test)
 dta h(klocek6_0.test,klocek6_0.test,klocek6_0.test,klocek6_0.test)

l_scr1
 :28 dta l(text1_null+12+#*40)

h_scr1
 :28 dta h(text1_null+12+#*40)


l_scr2
 :28 dta l(text2_null+12+#*40)

h_scr2
 :28 dta h(text2_null+12+#*40)


l_buf
 :height+10 dta l(buf+#*width)

h_buf
 :height+10 dta h(buf+#*width)


.macro loa_buf
 lda l_buf:2
 sta :1
 lda h_buf:2
 sta :1+1
.endm
