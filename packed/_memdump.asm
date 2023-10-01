 .get [$1000] 'seg0028.raw'	;	$1000-$1F6B
 .get [$2000] 'seg0029.raw'	;	$2000-$22AB
 .get [$22c8] 'seg0030.raw'	;	$22C8-$415B
 .get [$416a] 'seg0031.raw'	;	$416A-$430C
 .get [$4319] 'seg0032.raw'	;	$4319-$4D4B
 .get [$4de0] 'seg0033.raw'	;	$4DE0-$52D6
 .get [$52e1] 'seg0034.raw'	;	$52E1-$7AED


 .sav [$1000] '_memdump.dat',$6aff
 
; ins 'seg0035.dat'	;	$5656