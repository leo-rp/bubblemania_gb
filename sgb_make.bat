@echo off
lcc -c -o sgb_border_example.o sgb_border_example.c
lcc -Wl-yp0x146=0x03 -Wl-yp0x14B=0x33 -o sgb_border_example.gb sgb.o sgb_border_example.o 
del sgb_border_example.o