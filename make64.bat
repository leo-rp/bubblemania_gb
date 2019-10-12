c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o main.o main.c
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o carillon_header.o libs\carillon_header.s
c:\gbdk\bin\lcc -Wa-l -Wl-m -c -o music.o music\music.s

c:\gbdk\bin\lcc -Wa-l -Wl-m -DUSE_SFR_FOR_REG -Wl-yt1 -Wl-yo4 -Wl-ya0 -o main.gb main.o carillon_header.o music.o
del *.o *.lst *.map *.sym