
dst	equ $7000

 org $2000

main

 mwa #pack inputPointer
 mwa #dst  outputPointer
 jsr inflate

 jmp $a290+3

 icl 'inflate.asm'


pack
 ins 'intro3.def'

buffer 

 ini main

 opt l-
 icl 'xasm.mac'
