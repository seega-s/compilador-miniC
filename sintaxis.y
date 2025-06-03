%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "listaSimbolos.h"
#include "sintaxis.tab.h"

extern char *yytext;
extern int yylineno;

#define N_TEMP 10
// las variables globales a usar
int tmp[N_TEMP] = {0}; 
Lista tablaSimb;
Tipo tipo;
int contEtiq = 0;
int contCadenas = 0;

// las funciones a usar
void inicializaTemporales();
int nuevoTemp();
char* nuevaEtiq();

int yylex(); // en semBison dice que tiene que ser declarado
void yyerror(char *s);

%}
%code requires{#include "listaCodigo.h"}
%union{char *lexema; ListaC  codigo;}

%token <lexema> CADENA ID ENTERO
%type <codigo> expression statement statement_list print_list print_item read_list declarations var_list const_list


%%


program     : {tablaSimb = creaLS();} ID LPAREN RPAREN LBRACKET declarations statement_list RBRACKET { imprimirTablaS(); liberaTS }
            ;
									
declarations: declarations VAR var_list { tipo=VARIABLE; }
	        | declarations CONST var_list{ tipo=CONSTANTE; }
	        | %empty { };

asig        : ID ASIGN asig {   if !(perteneceTablaS($1) ) añadeEntrada($1, tipo)
                                else printf("Variable %s ya declarada \n", $1);};
            | expression { };
/* ***** ESTO CREO QUE PUEDE SERVIR PARA LA AMPLIACION - SemBison DIAPO. 94 en adelante *****
A veces un operador unario y un operador binario tienen la misma representación simbólica 
pero distintas precedencias (ej.: - como unario tiene más precedencia que como binario). 
%prec cambia el nivel de precedencia asociado con una regla particular de la gramática. 
Aparece inmediatamente después que el cuerpo de la regla, antes de la acción o del punto y coma, y es seguido por un token.*/


tipo        : INT { };

var_list    : ID { }
	        | var_list COMMA ID {};
	 
const_list  : ID ASIGN expression { }
	        | const_list COMMA ID ASIGN expression{ };

statement_list  : statement_list statement { }
                | %empty { };
	    
statement   : ID ASIGN asig {   if !(perteneceTablaS($1) ) añadeEntrada($1, tipo)
                                else if (esConstante($1)) printf("Asignacion a constante \n");}
            | LBRACKET statement_list RBRACKET { }
            | IF LPAREN expression RPAREN statement ELSE statement { }
            | IF LPAREN expression RPAREN statement { }
            | WHILE LPAREN expression RPAREN statement { }
            | PRINT LPAREN print_list RPAREN SEMICOLON { }
            | READ LPAREN read_list RPAREN SEMICOLON { };

print_list  : print_item { }
	        | print_list COMMA print_item { };
	   
print_item  : expression { }
	        | CADENA { añadeEntrada($1, CADENA); contCadenas++;};
	   
read_list   : ID { if !(perteneceTablaS($1) ) añadeEntrada($1, tipo)
                                else if (esConstante($1)) printf("Asignacion a constante \n")}
	        | read_list COMMA ID {  if !(perteneceTablaS($3) ) añadeEntrada($3, tipo)
                                    else if (esConstante($3)) printf("Asignacion a constante \n")}

expression  : expression PLUSOP expression { }
            | expression MINUS expression { }
            | expression MUL expression { }
            | expression DIV expression { }
            | LPAREN expression QMARK expression COLON expression RPAREN { }
            | MINUS expression { }
            | LPAREN expression RPAREN { }
            | ID { if !(perteneceTablaS($1) ) añadeEntrada($1, tipo) }
            | NUM { };

%%

/*          ******* IMPLEMENTACION FUNCIONES  ******* 
 *      faltan: perteneceTablaS, añadeEntrada, esConstante, imprimirTablaS
 */

int nuevoTemp(){
	int i = 0;
	while(i<NUMERO_TEMPORALES){
		if(temp[i]==0){
			temp[i] = 1;
			return i;
		}
		i++;
	}
	printf("No hay temporales libres\n");
    exit(1);
}

char* nuevaEtiq() {
    char* etiq = malloc(10);
    sprintf(etiq, "$l%d", contadorEtiq++);
    return etiq;
}

void yyerror(char *s) {
    extern char *yytext;
    fprintf(stderr, "Error sintáctico en línea %d cerca de '%s': %s\n", yylineno, yytext, s);
}