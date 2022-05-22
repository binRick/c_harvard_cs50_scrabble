all: tests
PASSH = $(shell command -v passh) -c 1

clean:
	@unlink scrabble 2>/dev/null || true

build: clean
	@clang scrabble.c -o scrabble -std=c11 -ggdb -lm -lcs50

test1: build
	@$(PASSH) -P 'Player 2:' -p cat $(PASSH) -P 'Player 1:' -p dog ./scrabble

test2: build
	@$(PASSH) -P 'Player 2:' -p areallybigword $(PASSH) -P 'Player 1:' -p smallword  ./scrabble

test3: build
	@$(PASSH) -P 'Player 2:' -p aaAAbbBB $(PASSH) -P 'Player 1:' -p xxZZYYzz  ./scrabble

test4: build
	@$(PASSH) -P 'Player 2:' -p 'a.!,' $(PASSH) -P 'Player 1:' -p 'xxAA'  ./scrabble

test5: build
	@$(PASSH) -P 'Player 2:' -p 'hai!' $(PASSH) -P 'Player 1:' -p 'Oh,'  ./scrabble


tests: test1 test2 test3 test4 test5

dev:
	@nodemon -w '*.c' -w Makefile -e c,Makefile -x sh -- -c 'make||true'

style: build tests
	@style50 scrabble.c

check: build tests
	@check50 cs50/labs/2022/x/scrabble

submit: build tests
	@submit50 cs50/labs/2022/x/scrabble

