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
int contEtiquetas = 1;
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

declarations: declarations VAR tipo var_list DOTCOMMA       {   
                                                                $$ = $1;                                                    
                                                            }
	        | declarations CONST tipo const_list DOTCOMMA   {   
                                                                $$ = $1;
                                                                concatenaLC($$, $4);
                                                                liberaLC($4);
                                                            }
	        | %empty                                        {
                                                                $$ = creaLC();
                                                            }
                                                            ;

tipo        : INT
            ;



var_list    : ID                            {  
                                                if(!perteneceTablaS($1))
                                                    anadeEntrada($1, VARIABLE, NULL);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
	        | var_list COMMA ID             {   
                                                if (!perteneceTablaS($3))
                                                    anadeEntrada($3, VARIABLE, NULL);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
                                            ;

const_list  : ID ASIGN expression           {   
                                                if (!perteneceTablaS($1)){
                                                    anadeEntrada($1, CONSTANTE, NULL);
                                                    ListaC codigo = $3;
                                                    char nomVar[20];
                                                    sprintf(nomVar, "_%s", %1);
                                                    Operacion op = {
                                                        .op = "sw",
                                                        .res = recuperaResLC(codigo),
                                                        .arg1 = strdup(nomVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC(codigo, finalLC(codigo), op);
                                                    $$ = codigo;
                                                    liberaLC($3);
                                                    inicializaTemporales(); //liberar registros resultado 
                                                }
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
	        | const_list COMMA ID ASIGN expression  { 
                                                        if (!perteneceTablaS($3)){
                                                            anadeEntrada($3, CONSTANTE, NULL);
                                                            ListaC codigo = $5;
                                                            char nombreVar[20];
                                                            sprintf(nombreVar, "_%s", %3);
                                                            Operacion op = {
                                                                .op = "sw",
                                                                .res = recuperaResLC(codigo),
                                                                .arg1 = strdup(nomVar),
                                                                .arg2 = NULL,
                                                            };
                                                            insertaLC(codigo, finalLC(codigo), op);
                                                            $$ = codigo;
                                                            liberaLC($5);
                                                            inicializaTemporales();
                                                        }
                                                    }
                                                    ;

statement_list  : statement_list statement  { 
                                                concatenaLC($1, $2);
                                                liberaLC($2);
                                                $$ = $1;
                                            }
                | %empty                    { 
                                                $$ = creaLC();
                                            }
                                            ;
	    
statement   : ID ASIGN expression DOTCOMMA  {   
                                                if (perteneceTablaS($1))
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR;
                                                else if (esConstante($1)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR;
                                                }
                                                else{
                                                    $$ = creaLC();
                                                    concatenaLC($$, $3);
                                                    char nombreVar[20];
                                                    // no uso la funcion porque no tengo que recuperar el 
                                                    sprintf(nombreVar, "_%s", $1);
                                                    Operacion op = {
                                                        .op = "sw",
                                                        .res = recuperaResLC($3),
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op);
                                                    inicializaTemporales();
                                                    liberaLC($3);
                                                }
                                            }
            | LBRACE statement_list RBRACE  { 
                                                $$ = $2;
                                            }
            | IF LPAREN expression RPAREN statement ELSE statement  { // el funcionamiento en ensamblador es coger la condicion, si va salta al if sino sigue el else y los dos acaban saltando al final
                                                                        $$ = creaLC();
                                                                        char* etiqIf = nuevaEtiq();
                                                                        char* etiqFin = nuevaEtiq();

                                                                        //ANALISIS, si se da se salta al if
                                                                        concatenaLC($$, $3);
                                                                        Operacion opCond = operSaltoCond("bnez", $3, etiqIf);
                                                                        insertaLC($$, finalLC($$), opCond);
                                                                        inicializaTemporales();
                                                                        
                                                                        //ELSE
                                                                        concatenaLC($$, $7);
                                                                        liberaLC($7);
                                                                        
                                                                        Operacion opSaltoFin = {
                                                                            .op = "b",
                                                                            .res = etiqFin,
                                                                            .arg1 = NULL,
                                                                            .arg2 = NULL
                                                                        };
                                                                        insertaLC($$, finalLC($$), opSaltoFin);
                                                                        inicializaTemporales();

                                                                        // IF
                                                                        Operacion opIf = operEtiq(etiqIf);
                                                                        insertaLC($$, finalLC($$), opIf);
                                                                        concatenaLC($$, $5);
                                                                        liberaLC($5);

                                                                        // F IN
                                                                        Operacion opFin = operEtiq(etiqFin);
                                                                        insertaLC($$, finalLC($$), opFin);

                                                                        liberaLC($3);
                                                                        inicializaTemporales();
                                                                    }
            | IF LPAREN expression RPAREN statement {
                                                        $$ = creaLC();
                                                        char* EtiqFin = nuevaEtiq();
                                                        
                                                        concatenaLC($$, $3);
                                                        Operacion opCond = operSaltoCond("beqz", $3, etiqFin);
                                                        insertaLC($$, finalLC($$), opCond);
                                                        liberaLC($5);

                                                        Operacion opEtiq = operEtiq(etiqFin);
                                                        insertaLC($$, finalLC($$), opEtiq);
                                                        liberaLC($3);
                                                        inicializaTemporales();

                                                    }
            | WHILE LPAREN expression RPAREN statement  { 
                                                            $$ = creaLC();
                                                            char* etiqWhile = nuevaEtiq();
                                                            char* etiqFin = nuevaEtiq();

                                                            // Etiqueta para el bucle
                                                            Operacion opEtiqW = operEtiq(etiqWhile);
                                                            insertaLC($$, finalLC($$), opEtiqW);

                                                            concatena($$, $3);

                                                            Operacion opCond = operSaltoCond("beqz", $3, etiqFin);
                                                            insertaLC($$, finalLC($$), opCond);
                                                            liberaLC($3);
                                                            inicializaTemporales();

                                                            concatenaLC($$, $5);
                                                            liberaLC($5);
                                                            
                                                            inicializaTemporales();
                                                            
                                                            //SUBIDA A COMPROBAR LA CONDICION
                                                            Operacion opReinicio = {
                                                                .op = "b",
                                                                .res = etiqWhile,
                                                                .arg1 = NULL,
                                                                .arg2 = NULL
                                                            };
                                                            insertaLC($$, finalLC($$), opReinicio);
                                                            
                                                            //FIN
                                                            Operacion opEtiqFin = operEtiq(etiqFin);
                                                            insertaLC($$, finalLC($$), opEtiqFin);
                                                        }
            | PRINT LPAREN print_list RPAREN DOTCOMMA   {
                                                            $$ = creaLC();
                                                            concatenaLC($$, $3);
                                                            liberaLC($3)
                                                        }
            | READ LPAREN read_list RPAREN DOTCOMMA     { 
                                                            $$ = creaLC();
                                                            concatenaLC($$, $3);
                                                            liberaLC($3)
                                                        }
                                                        ;

print_list  : print_item                    {
                                                $$ = $1;
                                            }
	        | print_list COMMA print_item   {
                                                concatenaLC($1, $3);
                                                liberaLC($3);
                                                $$ = $1;
                                            }
                                            ;
	   
print_item  : expression                    { 
                                                $$ = $1;
                                                // li   $v0, 1              se carga la syscall que queremos hacer
                                                // la   $a0, entero         se carga como parametro de la syscall la direccion de la cadena
                                                // syscall
                                                Operacion op1 = {
                                                    .op = "li",
                                                    .res = "$v0"    // primer resultado de syscall
                                                    .arg1 = "1"     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op1);

                                                Operacion op2 = {
                                                    .op = "la",
                                                    .res = "$a0",
                                                    .arg1 = recuperaLS($1),
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op2);
                                                
                                                Operacion op3 = {
                                                    .op = "syscall",
                                                    .res = NULL,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op3);
                                            }       
	        | CADENA                        {
                                                $$ = creaLC();
                                                contCadenas++;
                                                anadeEntrada($1, CADENA, contCadenas);
                                                char nomCadena[50];
                                                sprintf(tablaSimb, finalLS(tablaSimb), s);
                                                // li   $v0, 4              se carga la syscall que queremos hacer
                                                // la   $a0, nombreCadena   se carga como parametro de la syscall la direccion de la cadena
                                                // syscall
                                                Operacion op1 = {
                                                    .op = "li",
                                                    .res = "$v0"    // primer resultado de syscall
                                                    .arg1 = "4"     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op1);

                                                Operacion op2 = {
                                                    .op = "la",
                                                    .res = "$a0",
                                                    .arg1 = strdup(nombreCadena),
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op2);
                                                
                                                Operacion op3 = {
                                                    .op = "syscall",
                                                    .res = NULL,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op3);
                                            }
                                            ;

read_list   : ID                            {   //COMPRObACIONAS INICIALES
                                                if (!perteneceTablaS($1)) {
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR;
                                                }
                                                else if (esConstante($1)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", yylineno, $1);
                                                    YYERROR;
                                                }
                                                else{   // aquí iba a crear funciones pero no tenian sentido porque basicamente seria practicamente igual y se llamarian 3 veces contadas
                                                    $$ = creaLC();
                                                    // li   $v0, 5
                                                    // syscalñ
                                                    Operacion op1 = {
                                                        .op = "li",
                                                        .res = "$v0",
                                                        .arg1 = "5",
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op1);

                                                    Operacion op2 = {
                                                        .op = "syscall",
                                                        .res = NULL,
                                                        .arg1 = NULL,
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op2);

                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", $1);
                                                    Operacion op3 = {
                                                        .op = "sw",
                                                        .res = "$v0",
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op3);
                                                }
                                            }
	        | read_list COMMA ID            {   
                                                if (!perteneceTablaS($3)) {
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", yylineno, $3);
                                                    YYERROR;
                                                }
                                                else if (esConstante($3)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", yylineno, $3);
                                                    YYERROR;
                                                }
                                                else{
                                                    $$ = creaLC();
                                                    // li   $v0, 5
                                                    // syscalñ
                                                    Operacion op1 = {
                                                        .op = "li",
                                                        .res = "$v0",
                                                        .arg1 = "5",
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op1);

                                                    Operacion op2 = {
                                                        .op = "syscall",
                                                        .res = NULL,
                                                        .arg1 = NULL,
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op2);

                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", $3);
                                                    Operacion op3 = {
                                                        .op = "sw",
                                                        .res = "$v0",
                                                        .arg1 = strdup(nombreVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC($$, finalLC($$), op3);
                                                }
                                            }
                                            ;

expression  : expression PLUSOP expression  { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);

                                                Operacion op = crearOpArit("add", $1, $3);

                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
            | expression MINUS expression   { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);

                                                Operacion op = crearOpArit("sub", $1, $3);

                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
            | expression MUL expression     { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);

                                                Operacion op = crearOpArit("mul", $1, $3);

                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
            | expression DIV expression     { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);

                                                Operacion op = crearOpArit("div", $1, $3);

                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
            | LPAREN expression QMARK expression COLON expression RPAREN 
                                            { 
                                                $$ = creaLC();
                                                char* etiqT = nuevaEtiq();
                                                char* etiqF = nuevaEtiq();
                                                // aclaraacion para el codigo y todo, el ternario es:
                                                // if(expresion1)
                                                //      expresion2
                                                // else
                                                //      expresion3
                                                // eso en ensam es se comprueba la condicion y se salta al true, se hace el else y se salta al final de la operacion
                                                int temp = nuevoTemp();
                                                char tempStr[5];
                                                sprintf(tempStr, "$t%d", temp);
                                                
                                                // ANALISIS CASO
                                                concatenaLC($$, $2);
                                                
                                                Operacion op1 = operSaltoCond("bnez", $2, etiqTrue);

                                                insertaLC($$, finalLC($$), op1);
                                                liberaLC($2);
                                                
                                                //CASO FLASE
                                                concatenaLC($$, $6);
                                                Operacion opFalse = {
                                                    .op = "move",
                                                    .res = strdup(tempStr),
                                                    .arg1 = recuperaResLC($6),
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), opFalse);
                                                liberaLC($6);
                                                
                                                // SALTO FINAL
                                                Operacion op2 = {
                                                    .op = "b",
                                                    .res = etiqFin,
                                                    .arg1 = NULL,
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op2);


                                                // CASO TRUE
                                                Operacion op3 = operEtiq(etiqTrue);
                                                insertaLC($$, finalLC($$), op3);

                                                concatenaLC($$, $4);
                                                Operacion opTrue = {
                                                    .op = "move",
                                                    .res = strdup(tempStr),
                                                    .arg1 = recuperaResLC($4),
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), opTrue);
                                                liberaLC($4);
                                                // SALTO IFNAL del TRUE
                                                Operacion op4 =  operEtiq(etiqFin);
                                                insertaLC($$, finalLC($$), op4);

                                                guardaResLC($$, strdup(tempStr));

                                            }

            | MINUS expression              { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);

                                                Operacion op = crearOpArit("neg", $2, NULL);

                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
            | LPAREN expression RPAREN      { 
                                                $$ = $2;
                                            }
            | ID                            { 
                                                if (perteneceTablaS($1)) {
                                                    $$ = creaLC();
                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", $1);

                                                    Operacion op = crearOpArit("lw", strdup(nombreVar), NULL);

                                                    insertaLC($$, finalLC($$), op);
                                                    guardaResLC($$, strdup(tempStr));
                                                }
                                                else{
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", yylineno, $3);
                                                    YYERROR;
                                                }

                                            }
            | NUM                           { 
                                                $$ = creaLC();
                                                Operacion op = crearOpArit("li", $1, NULL);
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
                                            ;

%%

/*          ******* IMPLEMENTACION FUNCIONES VIDEOS ******* 
 *               faltan: imprimirTablaS, imprimirTablaC
 */

bool perteneceTablaS(char *nombre)
    return buscaLS(tablaSimb, nombre) != finalLS(t); // si son diferentes está $1 (nombre) en la tabla de sibolos


void anadeEntrada(char *nombre, Tipo t, int v){
    Simbolo s;
    s.nombre = nombre;
    s.tipo = t;
    s.valor = v;
    insertaLS(tablaSimb, finalLS(tablaSimb), s);
}

bool esConstante(char *nombre)
    return recuperaLS(tablaSimb, buscaLS(tablaSimb, nombre)).tipo == CONSTANTE; // sacamos el indice del simbolo en la tabla y luego rescatamos el simbolo y comprobamos el tipo


/*         ******* FUNCION SOLO PARA expression ******* 
     PORQUE EL RESTO ENCADENA VARIAS COSAS Y NO TIENE SENTIDO
        PERO LO QUE ES SUMAR, RESTAR, ETC. ES SISTEMATICO
           ENTONCES CLARO, ASI ME AHORRO ERRORES TONTOS
*/
Operacion crearOpArit(char * op, char *oper1, char *oper2){
    int temp = nuevoTemp();
    char tempStr[5];
    sprintf(tempStr, "$t%d", temp);
    Operacion operacion = {
        .op = op,
        .res = strdup(tempStr),
        .arg1 = recuperaResLC(oper1),
        .arg2 = recuperaResLC(oper2)
    };
    return operacion;
}

Operacion operEtiq (char* etiq){
    Operacion op = {
        .op = etiq,
        .res = NULL,
        .arg1 = NULL,
        .arg2 = NULL
    };
    return op;
}

Operacion operSaltoCond (char* salto, char* exp, char* etiq){
    Operacion op = {
        .op = salto,
        .res = recuperaResLC(exp),
        .arg1 = etiq,
        .arg2 = NULL
    };
    return op;
}


// inicializa TODOS los temporales
void inicializaTemporales(){
	for(int i = 0; i<NUMERO_TEMPORALES;i++)
		temp[i] = 0;
}

void imprimirLC(ListaC codigo){
        PosicionListaC pos = inicioLC(codigo);
        Operacion oper;
        while (pos != finalLC(codigo)) {
            oper = recuperaLC(codigo,pos);
            if (!strcmp(oper.op, "etiq")){
                    printf("%s:\n", oper.res);
            } else{
                    printf("        %s",oper.op);
                    if (oper.res) printf(" %s",oper.res);
                    if (oper.arg1) printf(",%s",oper.arg1);
                    if (oper.arg2) printf(",%s",oper.arg2);
                    printf("\n");
            }
            pos = siguienteLC(codigo,pos);
        }
}

void imprimirLS(){
    PosicionLista pos = inicioLS(tablaSimbtablaSimb);
    printf(".data\n");
    while (pos != finalLS(tablaSimb)) {
        Simbolo s = recuperaLS(l,pos);
        if (s.tipo == CADENA)
            printf("$str%d:\n       .asciiz %s\n",s.valor, s.nombre);
        else
            printf("_%s:\n          .word 0\n",s.nombre); 
        
        pos = siguienteLS(l,pos);
    }
    printf(".text\n.globl main\nmain:\n");
}


// PARA RESERVAR EL PRIMER TEMPORAL LIBRE
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