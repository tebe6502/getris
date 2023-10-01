
/*
  MPT Player Demo

  Przyklad wykorzystania relocatora dla plikow MPT (MPT_RELOCATOR.MAC)
  oraz playera MPT (MPT_PLAYER.ASM)

  Makro MPT_RELOCATOR.MAC odczytuje z pliku informacje na temat dlugosci
  patternow (etykieta globalna LENPAT) i tempa gry (etykieta globalna SPEED)  

  Nowy adres dla modulu MPT definiuje etykieta MSX
*/

msx	equ $4123

	mpt_relocator 'porazka.mpt' , msx

	org msx

	.sav [6] length

main
        lda:cmp 20 
        beq *-2

        jsr player.play

        jmp main

        icl 'mpt_player.asm'

;---
        run main

	opt l-
	icl 'mpt_relocator.mac'
