ASEMBLER _memdump.asm
ASEMBLER _seg2-4.asm
ASEMBLER _seg5-7.asm

DEFLATER _memdump.dat _memdump.def
DEFLATER _seg2-4.dat _seg2-4.def
DEFLATER _seg5-7.dat _seg5-7.def

ASEMBLER __test.asm -i:d:\!atari\macro

pause
