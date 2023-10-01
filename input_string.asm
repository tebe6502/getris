/*
  INPUT STRING
  wprowadza znaki z klawiatury pod adres 'newString'
*/

scren      equ text
ekran      equ scren+5*40+2

scr_width  equ 48

ile_znakow equ 10

count      equ tetris.licznik.count


/*
  NAME: LITERY
  INFO: ksztalt liter opisany 6 bajtami (na podstawie 'HIGH_SCORE_ALL_2.G2F')
        wczytujemy pierwsze 6 wierszy
    IN: ---
   OUT: ---
*/
litery
 ins 'score_alfabet.scr'


/*
  NAME: INPUT_STRING
  
  INFO: pod adresem 'COUNT' znajduje sie 7 bajtowa tablica reprezentujaca najwyzszy wynik gracza (high_score)
        ten wynik porownywany jest z HIG1..HIG5, jesli jest wystarczajaco dobry
        wyswietlamy go na odpowiedniej pozycji i pobieramy ciag znakow czyli pseudo gracza

    IN: ---

   OUT: pod adresem 'NEWSTRING' znajduja sie wpisane znaki   
*/

/*
.array count [6] .byte
 [2] = 4
 [3] = 4
 [4] = 9
 [5] = 6
 [6] = 1
.enda
*/

.proc input_string

 jsr POZYCJA

 cpx #$ff
 bne ok
 rts

ok
; teraz przeskrolujemy tablice wynikow

 stx hx+1

*---	PUNKTY

 lda <l_hig
 ldy >l_hig
 jsr hscrol
 
 lda <h_hig
 ldy >h_hig
 jsr hscrol

*---	KSYWKI

 lda <l_txt
 ldy >l_txt
 jsr hscrol
 
 lda <h_txt
 ldy >h_txt
 jsr hscrol

 lda l_txt,x	; zamiast ksywki wpisujemy znak konca wiersza $9b
 sta txt
 lda h_txt,x
 sta txt+1

 ldy #ile_znakow-1
 lda #$9b
 sta (txt),y-
 rpl

*---	ADRESY OBRAZU KAZDEGO WIERSZA Z KSYWKA I PUNKTAMI

 lda <l_score
 ldy >l_score
 jsr hscrol
 
 lda <h_score
 ldy >h_score
 jsr hscrol

 lda l_score+5	; modyfikacja, tutaj bedziemy wpisywac nowa ksywke
 sta l_score,x
 lda h_score+5
 sta h_score,x

 ldy #0		; modyfikacja programu ANTIC'a
 jsr new_adr
 stx adr0
 sty adr0+1

 ldy #1
 jsr new_adr
 stx adr1
 sty adr1+1

 ldy #2
 jsr new_adr
 stx adr2
 sty adr2+1

 ldy #3
 jsr new_adr
 stx adr3
 sty adr3+1

 ldy #4
 jsr new_adr
 stx adr4
 sty adr4+1

; zajmiemy sie aktualnie najlepszym wynikiem 

hx ldx #0

 lda l_score,x
 sta put_char.lscr+1
 sta txt
 lda h_score,x
 sta put_char.hscr+1
 sta txt+1
 
 ldy #scr_width*2-1
 lda #0
 sta (txt),y-
 rpl

 ldy #2*scr_width+2		; czyscimy ksywke
cl2_
 lda #"F"
 sta (txt),y
 iny
 lda #"G"
 sta (txt),y
 iny
 cpy #2*scr_width+2+20
 bne cl2_


 lda l_txt,x
 sta txt
 lda h_txt,x
 sta txt+1

; przepisujemy wynik na wybrana pozycje
 ldy #6
mv
 lda count,y
 sta (zp),y
 dey
 bpl mv

 ldx #1
 stx put_char.ofs+1
 dex
 
 ldy #11
 
cpr
 lda count,x
 clc
 adc #"Z"+3
 
 jsr put_char

 iny
 inx 
 cpx #7
 bne cpr


 ldy #0
 sty put_char.ofs+1
cp
 lda (txt),y
 sta newString,y

 iny
 
 jsr put_char
 
 cmp #$9b
 bne cp

 lda #"Z"+1
 jsr put_char

 dey
 sty _2+1

 
_1 jsr get_key

   cmp #$9b
   beq _end
   cmp #$7e
   beq _del

char_ok
   ldy _2+1
   cpy #ile_znakow-1              ; liczba znakow do wpisania
   beq _1
_2 ldy #0
   sta newString,y
   iny
   jsr put_char
   lda #"Z"+1
   iny
   jsr put_char
   inc _2+1
   jmp _1

_del ldy _2+1
   beq _1
   lda #" "
   sta newString,y
   iny
   jsr put_char
   dec _2+1
_4 lda #"Z"+1
   dey
   jsr put_char
   jmp _1

_end
 ldy _2+1
 iny
 lda #" "
 jsr put_char

 ldy _2+1
 lda #$9b
 sta newString,y

 ldy #ile_znakow-1
cp_
 lda newString,y
 sta (txt),y
 dey
 bpl cp_
 rts

/*
  Sprawdzamy czy uzyskany wynik jest wiekszy od dotychczasowych z tablicy HIGH SCORE
*/
POZYCJA
 ldx #0

lp__
 lda l_hig,x
 sta zp
 lda h_hig,x
 sta zp+1

 ldy #0
tst_lp
 lda count,y
 cmp (zp),y
 beq tst_skp
 bcc nxt
 
 jmp jest

tst_skp 
 iny
 cpy #7
 bne tst_lp
 
 jmp jest

nxt
 inx
 cpx #5
 bne lp__

 ldx #$ff	; nie_znalazl

jest		; a tutaj gdy wpis do tablicy jest mozliwy
 rts


HSCROL
 sta _src+1
 sta _dst2+1
 sty _src+2
 sty _dst2+2 
 
 ldy #0
 :5 jsr _src

 txa
 clc
 adc #1
 tay
 :5 jsr _src2

 ldx hx+1
 rts

_src lda $ffff,y
_dst sta _tmp,y
 iny
 rts

_src2 lda _tmp,x
_dst2 sta $ffff,y
 inx 
 iny
 rts


NEW_ADR
 lda l_score,y
 sec
 sbc #5
 tax
 lda h_score,y
 sbc #0
 tay
 rts

l_score dta l( ekran+4 , ekran+3*48+4 , ekran+6*48+4 , ekran+9*48+4 , ekran+12*48+4 , 0,0,0,0,0,0)
h_score dta h( ekran+4 , ekran+3*48+4 , ekran+6*48+4 , ekran+9*48+4 , ekran+12*48+4 , 0,0,0,0,0,0)

l_txt dta l( txt1 , txt2 , txt3 , txt4 , txt5 ,0,0,0,0,0,0,0)
h_txt dta h( txt1 , txt2 , txt3 , txt4 , txt5 ,0,0,0,0,0,0,0)

l_hig dta l( hig1 , hig2 , hig3 , hig4 , hig5 ,0,0,0,0,0,0,0)
h_hig dta h( hig1 , hig2 , hig3 , hig4 , hig5 ,0,0,0,0,0,0,0)

_tmp :10 brk

.endp


/*
  NAME: PUT_CHAR

  INFO: wyswietla znak na wskazanej pozycji i o wskazanym kodzie
        jesli kod znaku jest z przedzialy <$21..$3b+12> to wyswietlamy go
        jesli jest inny to wyswietlamy znak numer 0 czyli kropke
        regA i regY zostaja zachowane

    IN: reg A - kod znaku
        reg Y - pozycja pozioma

   OUT: zwraca poczatkowa zawartosc regA i regY
*/
.proc put_char
 sty regY
 sta regA
 
 cmp #$21
 bcc bad_char
 cmp #$3b+12
 bcs bad_char

 jmp ok_char

bad_char lda #$20

ok_char sec
 sbc #$20
 tay
 
 lda l_adr,y
 sta zp
 lda h_adr,y
 sta zp+1
 
 lda regY
 asl @
 clc
ofs adc #0
lscr adc #0
 sta zp_
 lda #0
hscr adc #0
 sta zp_+1

 ldy #0
 lda (zp),y
 sta (zp_),y
	iny
	lda (zp),y
	sta (zp_),y

 ldy #40
 lda (zp),y
 ldy #scr_width
 sta (zp_),y
	ldy #40+1
	lda (zp),y
	ldy #scr_width+1
	sta (zp_),y

 ldy #40*2
 lda (zp),y
 ldy #scr_width*2
 sta (zp_),y
	ldy #40*2+1
	lda (zp),y
	ldy #scr_width*2+1
	sta (zp_),y
 
 lda #0
regA equ *-1
 ldy #0
regY equ *-1
 rts

l_adr
 :20 dta l(litery+#*2)
 :20 dta l(litery+3*40+#*2)

h_adr
 :20 dta h(litery+#*2)
 :20 dta h(litery+3*40+#*2)

.endp


/*
  NAME: GET_KEY
  INFO: czeka na nacisniecie klawisza
    IN: ---
   OUT: w reg A znajdzie sie kod nacisnietego klawisza
*/
.proc get_key

 jsr wajt

 lda $d20f
 and #4
 bne get_key
 
 ldy $d209
 lda tab,y
 cmp #$ff
 beq get_key
 
 cmp #0
old_key equ *-1
 bne skp
 
 ldx #6
delay equ *-1
 dex
 stx delay
 bne get_key
 
 ldx #6
 stx delay 
 
skp
 sta old_key
 
 ldx #6
 stx delay
 rts

.endp


/*
  NAME: TAB
  INFO: tablica 256 bajtow z kodami nacisnietego klawisza
    IN: ---
   OUT: ---
*/
.array tab [256] .byte = $20

 [63]:[127] = "A"
 [21]:[85]  = "B"
 [18]:[82]  = "C"
 [58]:[122] = "D"
 [42]:[106] = "E"
 [56]:[120] = "F"
 [61]:[125] = "G"
 [57]:[121] = "H"
 [13]:[77]  = "I"
 [1] :[65]  = "J"
 [5] :[69]  = "K"
 [0] :[64]  = "L"
 [37]:[101] = "M"
 [35]:[99]  = "N"
 [8] :[72]  = "O"
 [10]:[74]  = "P"
 [47]:[111] = "Q"
 [40]:[104] = "R"
 [62]:[126] = "S"
 [45]:[109] = "T"
 [11]:[75]  = "U"
 [16]:[80]  = "V"
 [46]:[110] = "W"
 [22]:[86]  = "X"
 [43]:[107] = "Y"
 [23]:[87]  = "Z"
; [33]:[97]  = ' '

 [52]:[180] = $7e
 [12]:[76]  = $9b

.enda


/*
  NAME: NEWSTRING
  INFO: obszar 10 bajtow przeznaczony na wpisywana z klawiatury nazwe
    IN: ---
   OUT: ---
*/
newstring .ds 10


/*
  NAME: TXT1, TXT2, TXT3, TXT4, TXT5
  INFO: pseudonimy na liscie High Score
        po 10 znakow kazdy <0..9>
    IN: ---
   OUT: ---
*/

.array txt1 [ile_znakow] .byte = $9b
 [0] = "VIDOL"
.enda

.array txt2 [ile_znakow] .byte = $9b
 [0] = "SLAVES"
.enda

.array txt3 [ile_znakow] .byte = $9b
 [0] = "DELY"
.enda

.array txt4 [ile_znakow] .byte = $9b
 [0] = "DRACON"
.enda

.array txt5 [ile_znakow] .byte = $9b
 [0] = "MACGYVER"
.enda


/*
  NAME: HIG1, HIG2, HIG3, HIG4, HIG5
  INFO: lista najlepszych wynikow
        5 pozycji po 7 cyfr kazda <0..6>
    IN: ---
   OUT: ---
*/
.array hig1 [7] .byte
 [3] = '5000'-$30
.enda

.array hig2 [7] .byte
 [3] = '4000'-$30
.enda

.array hig3 [7] .byte
 [3] = '3000'-$30
.enda

.array hig4 [7] .byte
 [3] = '2000'-$30
.enda

.array hig5 [7] .byte
 [3] = '1000'-$30
.enda
