BIN=parser

all: $(BIN).y $(BIN).l
	bison -d -g -v -t $(BIN).y
	dot -Tpng $(BIN).gv -o $(BIN).png
	flex $(BIN).l
	$(CC) -c lex.yy.c -o lex.yy.o
	$(CC) -c $(BIN).tab.c -o $(BIN).tab.o
	$(CC) -o $(BIN).bin lex.yy.o $(BIN).tab.o -lm

clean:
	rm -fv $(BIN).bin $(BIN).tab.h $(BIN).tab.c lex.yy.c lex.yy.o $(BIN).tab.o lex.backup $(BIN).dot $(BIN).gv $(BIN).png $(BIN).output *~ 

