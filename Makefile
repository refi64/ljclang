MOONC=moonc
CC=clang

all : clang.lua libljclang.so

clang.lua : clang.moon
	$(MOONC) -o $@ $<

libljclang.so : wrap.c
	$(CC) $(CFLAGS) -shared -o $@ $< $(LFLAGS) -lclang
