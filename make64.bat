
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o main.o main.c
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o carillon_header.o libs\carillon_header.s
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o fx_hammer_header.o libs\fx_hammer_header.s
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o music.o music\music.s
c:\gbdk\bin\lcc -Wa-l -Wf-bo1 -Wl-m -c -o graphics.o graphics.c


c:\gbdk\bin\lcc -Wa-l -Wl-m -DUSE_SFR_FOR_REG -Wl-yt3 -Wl-yo4 -Wl-ya1 -o bubblemania.gb main.o carillon_header.o fx_hammer_header.o music.o graphics.o
del *.lst *.map *.sym *.o