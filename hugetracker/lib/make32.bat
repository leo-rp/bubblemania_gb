
c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o main.o gbdk_player.c
c:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o huge.gb main.o hUGEDriver.obj.o

@echo cleaning: *.o *.lst *.map *.sym *.ihx *.noi
del *.lst *.map *.sym *.ihx *.noi
@echo done

