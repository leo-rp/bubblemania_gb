::working with GBDK3 3.1 
::working with GBDK3 4.0

::@echo off

::simple 32k rom
c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o main.c
c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o bubblemania32.gb main.o hUGEDriver.obj.o
::simple 32k rom


::cleaning
@echo cleaning: *.o *.lst *.map *.sym *.ihx *.noi
del  *.lst *.map *.sym *.ihx *.noi
@echo done


::notes
::object
::c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o main.o main.c
::S file
::c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o music.o music\music.s::banked
::c:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wl-m -c -o graphics.o graphics.c
::c:\gbdk\bin\lcc -Wa-l -Wl-m -DUSE_SFR_FOR_REG -Wl-yt3 -Wl-yo4 -Wl-ya1 -o bubblemania.gb main.o 
