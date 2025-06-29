BIN=parser
PARTIE1_DIR=../../Partie_1/Question_3
PARTIE1_BIN=$(PARTIE1_DIR)/parser.bin

all: $(PARTIE1_BIN) $(BIN).bin

$(PARTIE1_BIN):
	$(MAKE) -C $(PARTIE1_DIR)

$(BIN).bin: lex.yy.o $(BIN).tab.o myparser.o
	$(CC) -o $(BIN).bin lex.yy.o $(BIN).tab.o myparser.o -lm

myparser.o: myparser.c myparser.h
	$(CC) -c myparser.c -o myparser.o

$(BIN).tab.o: $(BIN).tab.c myparser.h
	$(CC) -c $(BIN).tab.c -o $(BIN).tab.o

lex.yy.o: lex.yy.c $(BIN).tab.h myparser.h
	$(CC) -c lex.yy.c -o lex.yy.o

$(BIN).tab.c $(BIN).tab.h: $(BIN).y
	bison -d -g -v -t $(BIN).y

lex.yy.c: $(BIN).l $(BIN).tab.h
	flex $(BIN).l

clean:
	rm -fv $(BIN).bin $(BIN).tab.h $(BIN).tab.c lex.yy.c lex.yy.o $(BIN).tab.o myparser.o lex.backup $(BIN).dot $(BIN).gv $(BIN).png $(BIN).output *~
	$(MAKE) -C $(PARTIE1_DIR) clean
