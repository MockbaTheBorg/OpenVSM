all:
	mkdir -p tools
	mkdir -p dll
	make tools
	make lua
	make -C src

distclean:
	rm -f dll/*
	rm -f lib/*
	rm -f tools/*
	rm -f lua/*.exe
	rm -f lua/*.dll
	rm -f lua/*.a
	find . -name *.o -exec rm -f {} +
	find . -name *.mod -exec rm -f {} +
	find . -name *.mod.c -exec rm -f {} +
	find . -name Debug -exec rm -rf {} +
	find . -name Release -exec rm -rf {} +
	cp proteus/*.pdsprj dll/

clean:
	rm -f tools/*
	make -C bin2source clean
	make -C lua clean
	make -C src clean

tools:
	make -C bin2source

lua:
	make -C lua mingw
	cp lua/luac.exe tools/	

.PHONY: all distclean clean tools lua
