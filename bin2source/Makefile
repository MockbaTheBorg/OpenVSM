BIN2SRC:=../tools/bin2source.exe

SRC:=main.cpp

CFLAGS:=-O2 -gdwarf-2 -std=gnu99 -g3

OBJ=$(SRC:%.c=%.o)

all: $(BIN2SRC)

%.o: %.c
	gcc -c -o $@ $< $(CFLAGS)

$(BIN2SRC): $(OBJ)
	gcc -o $@ $^

clean:
	@-rm -f $(BIN2SRC) *.o	
