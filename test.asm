
	org $6000
 opt l-
 mpt_relocator 'mpt\revenge.mpt' , *		; zamiast RAMA.MPT
 opt l+
 .sav [6] ?length
 
 .print ?length

	org $b000
 opt l-
 mpt_relocator 'mpt\revenge.mpt' , *		; zamiast RAMA.MPT
 opt l+
 .sav [6] ?length

 .print ?length

 opt l-
 icl 'mpt\mpt_relocator.mac'