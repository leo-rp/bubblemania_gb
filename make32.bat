::working with GBDK3 3.1 

::@echo off


c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o main.c
c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o bubblemania32.gb main.o
::del *.o *.lst *.map *.sym
@echo done