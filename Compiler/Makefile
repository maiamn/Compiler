GRM=parser.y
LEX=lexer.l
BIN=comp

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o main.o ts.o asm_table.o jump.o interpreter.o

all: $(BIN)

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

ts.o: ./sources/ts.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

asm_table.o: ./sources/asm_table.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

jump.o: ./sources/jump.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

interpreter.o: ./sources/interpreter.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d -t -v $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c

test: all
	./$(BIN) < test.c
