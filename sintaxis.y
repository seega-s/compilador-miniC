%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "listaSimbolos.h"
#include "sintaxis.tab.h"
#include "listaCodigo.h"

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
%token VAR CONST INT IF ELSE WHILE PRINTF READ DOTCOMMA COMMA PLUSOP MINUSOP MULTOP DIVOP LPAREN RPAREN LBRACE RBRACE QMARK COLON ASIGN
%type <codigo> expression statement statement_list print_list print_item read_list declarations var_list const_list

%left PLUSOP MINUSOP MULTOP DIVOP ASIGN


%%


program     : {tablaSimb = creaLS();} ID LPAREN RPAREN LBRACE declarations statement_list RBRACE {  ListaC codigo = creaLC(); 
                                                                                                    concatenaLC(codigo, $6);
                                                                                                    concatenaLC(codigo, $7);
                                                                                                    liberaLC($6);
                                                                                                    liberaLC($7);
                                                                                                    imprimirTablaS();
                                                                                                    imprimeLC(codigo);
                                                                                                    liberaLC(tablaSimb);
                                                                                                    liberaLC(codigo); 
                                                                                                }
            ;
									
declarations: declarations VAR var_list         {   $$ = $1;
                                                    tipo=VARIABLE; 
                                                }
	        | declarations CONST const_list     {   $$ = $1;
                                                    tipo=CONSTANTE;
                                                    concatenaLC($$, $4);
                                                    liberaLC($4);
                                                }
	        | %empty { $$ = creaLC();};

asig        : ID ASIGN asig                     {   
                                                    if !(perteneceTablaS(tablaSimb, $1) ) 
                                                        anadeEntrada(tablaSimb, $1, tipo);
                                                    else     
                                                        printf("Variable %s ya declarada \n", $1);
                                                }
                                                ;
            | expression { };
/* ***** ESTO CREO QUE PUEDE SERVIR PARA LA AMPLIACION - SemBison DIAPO. 94 en adelante *****
A veces un operador unario y un operador binario tienen la misma representación simbólica 
pero distintas precedencias (ej.: - como unario tiene más precedencia que como binario). 
%prec cambia el nivel de precedencia asociado con una regla particular de la gramática. 
Aparece inmediatamente después que el cuerpo de la regla, antes de la acción o del punto y coma, y es seguido por un token.*/


tipo        : INT;

var_list    : ID                            {  
                                                    if(!perteneceTablaS(tablaSimb, $1))
                                                        anadeEntrada(tablaSimb, $1, VARIABLE);
                                                    else {
                                                        printf("Error semántico en línea %d: variable '%s' ya declarada\n", yylineno, $1);
                                                        YYERROR; // en semBison pone que hay que abortar así
                                                    }
                                            }
	        | var_list COMMA ID             {   
                                                if (!perteneceTablaS(tablaSimb, $3))
                                                    anadeEntrada(tablaSimb, $3, VARIABLE);
                                            }
                                            ;

const_list  : ID ASIGN expression           {   
                                                if !perteneceTablaS(tablaSimb, $1)
                                                    anadeEntrada(tablaSimb, $1, CONSTANTE);
                                            }
	        | const_list COMMA ID ASIGN expression{ };

statement_list  : statement_list statement { }
                | %empty { };
	    
statement   : ID ASIGN asig                 {   
                                                if !(perteneceTablaS($1) ) 
                                                    anadeEntrada($1, tipo);
                                                else if (esConstante($1)) 
                                                    printf("Asignacion a constante \n");
                                            }
            | LBRACE statement_list RBRACE  { }
            | IF LPAREN expression RPAREN statement ELSE statement { }
            | IF LPAREN expression RPAREN statement { }
            | WHILE LPAREN expression RPAREN statement { }
            | PRINT LPAREN print_list RPAREN DOTCOMMA { }
            | READ LPAREN read_list RPAREN DOTCOMMA { };

print_list  : print_item { }
	        | print_list COMMA print_item { };
	   
print_item  : expression { }
	        | CADENA { anadeEntrada($1, CADENA); contCadenas++;};
	   
read_list   : ID                            {  
                                                if !(perteneceTablaS($1) ) 
                                                    anadeEntrada(listaSimb, $1, tipo);
                                                else if (esConstante($1)) 
                                                    printf("Asignacion a constante \n");
                                            }
	        | read_list COMMA ID            {  
                                                if !(perteneceTablaS($3) ) 
                                                    anadeEntrada(listaSimb, $3, tipo);
                                                else if (esConstante($3)) 
                                                    printf("Asignacion a constante \n")
                                            }
                                            ;

expression  : expression PLUSOP expression { }
            | expression MINUS expression { }
            | expression MUL expression { }
            | expression DIV expression { }
            | LPAREN expression QMARK expression COLON expression RPAREN { }
            | MINUS expression { }
            | LPAREN expression RPAREN { }
            | ID { if !(perteneceTablaS($1) ) anadeEntrada($1, tipo) }
            | NUM { };

%%

/*          ******* IMPLEMENTACION FUNCIONES  ******* 
 *      faltan: perteneceTablaS, anadeEntrada, esConstante, imprimirTablaS
 */

bool perteneceTablaS(Lista t, char *nombre)
    return buscaLS(t, nombre) != finalLS(t); // si son diferentes está $1 (nombre) en la tabla de sibolos


void anadeEntrada(listaSimbolos l, char *nombre, Tipo t){
    Simbolo s;
    s.nombre = nombre;
    s.tipo = t;
    insertaLS(l, finalLS(l), s);
}

bool esConstante(char *nombre)
    return recuperaLS(tablaSimb, buscaLS(tablaSimb, nombre)).tipo == CONSTANTE; // sacamos el indice del simbolo en la tabla y luego rescatamos el simbolo y comprobamos el tipo

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