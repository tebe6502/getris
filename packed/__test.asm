; Super Packer v1.0  ;)

 opt h+
 org $4000
.local in0
 icl 'inflate.asm'
.end


 org $4400
 mwa #dep0 inputPointer
 mwa #$2000 outputPointer
 jsr in0.inflate
 jmp $2000
dep0
 ins 'seg0000.def'	;	$2000-$2481
// ins 'seg0001.dat'	;	$2000

 ini $4400


 opt h+
 org $4400
 mwa #dep2 inputPointer
 mwa #$b010 outputPointer
 jmp in0.inflate
dep2
 ins '_seg2-4.def'	;	$B010-$B11A
 
 ini $4400

/*
 opt h+
 org $4400
 mwa #dep2 inputPointer
 mwa #$b010 outputPointer
 jmp in0.inflate
dep2
 ins 'seg0002.def'	;	$B010-$B11A
 
 ini $4400



 org $4400
 mwa #dep3 inputPointer
 mwa #$b300 outputPointer
 jmp in0.inflate
dep3
 ins 'seg0003.def'	;	$B300-$B5FF
 
 ini $4400


 opt h+
 org $4400
 mwa #dep4 inputPointer
 mwa #$b700 outputPointer
 jmp in0.inflate
dep4
 ins 'seg0004.def'	;	$B700-$BF96
 
 ini $4400
*/


 opt h+
 org $4400
 mwa #dep5 inputPointer
 mwa #$7000 outputPointer
 jsr in0.inflate
 jmp $a290 
dep5
 ins '_seg5-7.def'	;	$7000-$9F18
 
 ini $4400
 

/*
 opt h+
 org $4400
 mwa #dep5 inputPointer
 mwa #$7000 outputPointer
 jmp in0.inflate
dep5
 ins 'seg0005.def'	;	$7000-$9F18
 
 ini $4400


 opt h+
 org $4400
 mwa #dep6 inputPointer
 mwa #$a000 outputPointer
 jmp in0.inflate
dep6
 ins 'seg0006.def'	;	$A000-$A4A6
 
 ini $4400
 
 
 org $4400
 mwa #dep7 inputPointer
 mwa #$a4b3 outputPointer
 jsr in0.inflate
 jmp $a290
dep7
 ins 'seg0007.def'	;	$A4B3-$A674
; ins 'seg0008.dat'	;	$A290
 
 ini $4400
*/


 opt h+
 org $1000
 icl 'inflate.asm'

 opt h-
 ins 'seg0009.dat'	;	$0400-$0408
 ins 'seg0010.dat'	;	$0400


 opt h+
 org $7b00
 mwa #dep11 inputPointer
 mwa #$4000 outputPointer
 jmp inflate
dep11
 ins 'seg0011.def'	;	$4000-$7C39
 
 ini $7b00	


 opt h-
 ins 'seg0012.dat'	;	$0400-$0408
 ins 'seg0013.dat'	;	$0400


 opt h+
 org $1400
 mwa #dep14 inputPointer
 mwa #$4000 outputPointer
 jmp inflate
dep14
 ins 'seg0014.def'	;	$4000-$73FF
 
 ini $1400


 opt h-
 ins 'seg0015.dat'	;	$0400-$0408
 ins 'seg0016.dat'	;	$0400


 opt h+
 org $1400
 mwa #dep17 inputPointer
 mwa #$4000 outputPointer
 jmp inflate
dep17
 ins 'seg0017.def'	;	$4000-$73FF
 
 ini $1400


 opt h-
 ins 'seg0018.dat'	;	$0400-$0408	;BANK #0
 ins 'seg0019.dat'	;	$0400


 opt h+
 org $6000
 mwa #dep20 inputPointer
 mwa #$2000 outputPointer
 jmp inflate
dep20
 ins 'seg0020.def'	;	$2000-$3286
 
 ini $6000


 opt h+
 org $6000
 mwa #dep21 inputPointer
 mwa #$3287 outputPointer
 jmp inflate
dep21
 ins 'seg0021.def'	;	$3287-$46A6
 
 ini $6000


 opt h+
 org $6000
 mwa #dep22 inputPointer
 mwa #$8000 outputPointer
 jmp inflate
dep22
 ins 'seg0022.def'	;	$8000-$AFFF
 
 ini $6000


 opt h-
 ins 'seg0023.dat'	;	$B003-$B00B	; wygaszenie logosa GETRIS LOADING
 ins 'seg0024.dat'	;	$B000


 opt h+
 org $6000
 mwa #dep25 inputPointer
 mwa #$b000 outputPointer
 jmp inflate
dep25
 ins 'seg0025.def'	;	$B000-$B561
 
 ini $6000


 org $6000
 mwa #dep26 inputPointer
 mwa #$b600 outputPointer
 jsr inflate
 jmp $2000
dep26
 ins 'seg0026.def'	;	$B600-$BFEC
; ins 'seg0027.dat'	;	$2000		; inicjalizacja, przepisanie pod ROM
 
 ini $6000


 opt h+
.local in1
 org $0c00
 icl 'inflate.asm'
.end


 org $5600
 mwa #_mem inputPointer
 mwa #$1000 outputPointer
 jsr in1.inflate
 jmp $5656
_mem
 ins '_memdump.def'

 ini $5600


 opt h-

/* mem_dump
 ins 'seg0028.dat'	;	$1000-$1F6B
 ins 'seg0029.dat'	;	$2000-$22AB
 ins 'seg0030.dat'	;	$22C8-$415B
 ins 'seg0031.dat'	;	$416A-$430C
 ins 'seg0032.dat'	;	$4319-$4D4B
 ins 'seg0033.dat'	;	$4DE0-$52D6
 ins 'seg0034.dat'	;	$52E1-$7AED
*/

; ins 'seg0035.dat'	;	$5656	


 opt l-
 icl 'xasm.mac'
