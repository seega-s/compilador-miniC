salida: lex.yy.c main.c sintaxis.tab.c listaSimbolos.c listaCodigo.c
	gcc -o minic lex.yy.c main.c sintaxis.tab.c listaSimbolos.c listaCodigo.c -lfl

sintaxis.tab.c sintaxis.tab.h: sintaxis.y
	bison -d -v sintaxis.y

lex.yy.c: lexico.l sintaxis.tab.h
	flex lexico.l

clean:
	rm -f lex.yy.c sintaxis.tab.c sintaxis.tab.h salida *.o