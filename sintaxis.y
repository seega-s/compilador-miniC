%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "listaSimbolos.h"
#include "listaCodigo.h"

extern char *yytext;
extern int yylineno;

#define N_TEMP 10
// las variables globales a usar
int tmp[N_TEMP] = {0}; 
Lista tablaSimb;
Tipo tipo;
int contEtiquetas = 0;
int contCadenas = 0;

// las funciones a usar
void inicializaTemporales();
void liberaTemporal(char * registro);
int nuevoTemp();
char* nuevaEtiq();
bool error_check = false;

void imprimirTablaS();
void imprimeLC(ListaC codigo);
bool perteneceTablaS(char *nombre);
void anadeEntrada(char *nombre, Tipo t, int v);
bool esConstante(char *nombre);
Operacion operSaltoCond(char *op, char *exp, char *etiq);
Operacion operEtiq(char *etiq);
Operacion crearOpArit(char *op, char *oper1, char *oper2, char tempStr[5]);
void siguienteRegistro(char *registro);

int yylex(); // en semBison dice que tiene que ser declarado
void yyerror(char *s);

%}
%code requires{#include "listaCodigo.h"}
%union{char *lexema; ListaC  codigo;}

%token <lexema> STRING ID ENTERO
%token VAR CONST INT IF ELSE WHILE PRINT READ DOTCOMMA COMMA PLUSOP MINUSOP MULTOP DIVOP LPAREN RPAREN LBRACE RBRACE QMARK COLON ASIGN MINUSOP_UN
%type <codigo> expression statement statement_list print_list print_item read_list declarations var_list const_list

%left PLUSOP MINUSOP
%left MULTOP DIVOP
%left MINUSOP_UN

%%


program     : {tablaSimb = creaLS();} ID LPAREN RPAREN LBRACE declarations statement_list RBRACE {  ListaC codigo = creaLC(); 
                                                                                                    concatenaLC(codigo, $6);
                                                                                                    concatenaLC(codigo, $7);
                                                                                                    liberaLC($6);
                                                                                                    liberaLC($7);
                                                                                                    imprimirTablaS();
                                                                                                    if (!error_check){imprimeLC(codigo);}
                                                                                                    liberaLS(tablaSimb);
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
	        | /* empty */                                   {
                                                                $$ = creaLC();
                                                            }
                                                            ;

tipo        : INT
            ;



var_list    : ID                            {  
                                                if(!perteneceTablaS($1))
                                                    anadeEntrada($1, VARIABLE, 0);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
	        | var_list COMMA ID             {   
                                                if (!perteneceTablaS($3))
                                                    anadeEntrada($3, VARIABLE, 0);
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
                                            ;

const_list  : ID ASIGN expression           {   
                                                if (!perteneceTablaS($1)){
                                                    anadeEntrada($1, CONSTANTE, 0);
                                                    ListaC codigo = $3;

                                                    char nomVar[20];
                                                    sprintf(nomVar, "_%s", $1);
                                                    Operacion op = {
                                                        .op = "sw",
                                                        .res = recuperaResLC(codigo),
                                                        .arg1 = strdup(nomVar),
                                                        .arg2 = NULL
                                                    };
                                                    insertaLC(codigo, finalLC(codigo), op);

                                                    inicializaTemporales();
                                                    $$ = codigo;
                                                    
                                                }
                                                else {
                                                    printf("Error semántico: Variable ya declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR; // en semBison pone que hay que abortar así
                                                }
                                            }
	        | const_list COMMA ID ASIGN expression  { 
                                                        if (!perteneceTablaS($3)){
                                                            anadeEntrada($3, CONSTANTE, 0);
                                                            ListaC codigo = $1;
                                                            
                                                            concatenaLC(codigo, $5);
                                                            

                                                            char nombreVar[20];
                                                            sprintf(nombreVar, "_%s", $3);
                                                            Operacion op = {
                                                                .op = "sw",
                                                                .res = recuperaResLC($5),
                                                                .arg1 = strdup(nombreVar),
                                                                .arg2 = NULL,
                                                            };
                                                            insertaLC(codigo, finalLC(codigo), op);
                                                            inicializaTemporales();
                                                            $$ = codigo;
                                                            
                                                            liberaLC($5);
                                                        }
                                                        else {
                                                            printf("Error semántico: Constante ya declarada '%s' (linea: %d)\n", $1, yylineno);
                                                            error_check = true;
                                                            YYERROR; // Aborta el análisis sintáctico****
                                                        }
                                                    }
                                                    ;

statement_list  : statement_list statement  { 
    
                                                concatenaLC($1, $2);
                                                $$ = $1;
                                                liberaLC($2);
                                            }
                | /* empty */               { 
                                                $$ = creaLC();
                                            }
                                            ;
	    
statement   : ID ASIGN expression DOTCOMMA  {   
                                                if (!perteneceTablaS($1)){
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }
                                                else if (esConstante($1)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }
                                                else{
                                                    $$ = creaLC();
                                                    concatenaLC($$, $3);
                                                    char nombreVar[20];
                                                    // no uso la funcion porque no tengo que recuperar
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
                                                                        
                                                                        Operacion opCond = operSaltoCond("bnez", recuperaResLC($3), etiqIf);
                                                                        insertaLC($$, finalLC($$), opCond);
                                                                        inicializaTemporales();
                                                                        liberaLC($3);
                                                                        liberaTemporal(recuperaResLC($3));

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

                                                                        
                                                                        inicializaTemporales();
                                                                    }
            | IF LPAREN expression RPAREN statement {
                                                        $$ = creaLC();
                                                        char* etiqFin = nuevaEtiq();
                                                        
                                                        concatenaLC($$, $3);
                                                        Operacion opCond = operSaltoCond("beqz", recuperaResLC($3), etiqFin);
                                                        insertaLC($$, finalLC($$), opCond);
                                                        liberaTemporal(recuperaResLC($3));
                                                        liberaLC($3);

                                                        concatenaLC($$, $5);
                                                        liberaLC($5);

                                                        Operacion opEtiq = operEtiq(etiqFin);
                                                        insertaLC($$, finalLC($$), opEtiq);

                                                    }
            | WHILE LPAREN expression RPAREN statement  { 
                                                            $$ = creaLC();
                                                            char* etiqWhile = nuevaEtiq();
                                                            char* etiqFin = nuevaEtiq();

                                                            // Etiqueta para el bucle
                                                            Operacion opEtiqW = operEtiq(etiqWhile);
                                                            insertaLC($$, finalLC($$), opEtiqW);

                                                            concatenaLC($$, $3);

                                                            Operacion opCond = operSaltoCond("beqz", recuperaResLC($3), etiqFin);
                                                            insertaLC($$, finalLC($$), opCond);
                                                            liberaLC($3);
                                                            liberaTemporal(recuperaResLC($3));

                                                            concatenaLC($$, $5);
                                                            liberaLC($5);
                                                            
                                                            
                                                            
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
                                                        
            | PRINT LPAREN print_list RPAREN DOTCOMMA  {
                                                            $$ = creaLC();
                                                            concatenaLC($$, $3);
                                                            liberaLC($3);
                                                        }
                                                        
            | READ LPAREN read_list RPAREN DOTCOMMA     { 
                                                            $$ = creaLC();
                                                            concatenaLC($$, $3);
                                                            liberaLC($3);
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
                                                    .res = "$v0",    // primer resultado de syscall
                                                    .arg1 = "1",     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op1);

                                                Operacion op2 = {
                                                    .op = "move",
                                                    .res = "$a0",
                                                    .arg1 = recuperaResLC($1),
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

                                                liberaTemporal(recuperaResLC($1));
                                            }       
	         | STRING                        {
                                                $$ = creaLC();
                                                
                                                Simbolo s;
                                                s.nombre = strdup($1);
                                                s.tipo = CADENA;
                                                s.valor = contCadenas;
                                                insertaLS(tablaSimb, finalLS(tablaSimb), s);

                                                char nomCadena[50];
                                                sprintf(nomCadena, "$str%d", contCadenas++);  

                                                // li   $v0, 4              se carga la syscall que queremos hacer
                                                // la   $a0, nombreCadena   se carga como parametro de la syscall la direccion de la cadena
                                                // syscall
                                                Operacion op1 = {
                                                    .op = "li",
                                                    .res = "$v0",    // primer resultado de syscall
                                                    .arg1 = "4",     // syscall de printear strings
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), op1);

                                                Operacion op2 = {
                                                    .op = "la",
                                                    .res = "$a0",
                                                    .arg1 = NULL,
                                                    .arg2 = strdup(nomCadena)
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
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }
                                                else if (esConstante($1)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
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
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", $3, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }
                                                else if (esConstante($3)){
                                                    printf("Error semántico: Asignación a constante '%s' (linea: %d)\n", $3, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }
                                                else{
                                                    $$ = creaLC();
                                                    concatenaLC($$, $1);
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


                                                Operacion op = crearOpArit("add", recuperaResLC($1), recuperaResLC($3), recuperaResLC($1));
                                                liberaTemporal(recuperaResLC($3));

                                                guardaResLC($$, strdup(recuperaResLC($1)));
                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                            }
            | expression MINUSOP expression { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);


                                                Operacion op = crearOpArit("sub", recuperaResLC($1), recuperaResLC($3), recuperaResLC($1));
                                                liberaTemporal(recuperaResLC($3));

                                                guardaResLC($$, strdup(recuperaResLC($1)));
                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);

                                            }
            | expression MULTOP expression  { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);


                                                Operacion op = crearOpArit("mul", recuperaResLC($1), recuperaResLC($3), recuperaResLC($1));
                                                liberaTemporal(recuperaResLC($3));

                                                guardaResLC($$, strdup(recuperaResLC($1)));
                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);

                                            }
            | expression DIVOP expression   { 
                                                $$ = creaLC();
                                                concatenaLC($$, $1);
                                                concatenaLC($$, $3);


                                                Operacion op = crearOpArit("div", recuperaResLC($1), recuperaResLC($3), recuperaResLC($1));
                                                liberaTemporal(recuperaResLC($3));

                                                guardaResLC($$, strdup(recuperaResLC($1)));
                                                liberaLC($1);
                                                liberaLC($3);
                                                insertaLC($$, finalLC($$), op);
                                            }
            | LPAREN expression QMARK expression COLON expression RPAREN 
                                            { 
                                                $$ = creaLC();
                                                char* etiqTrue = nuevaEtiq();
                                                char* etiqFin = nuevaEtiq();
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
                                                
                                                Operacion op1 = operSaltoCond("bnez", recuperaResLC($2), etiqTrue);

                                                insertaLC($$, finalLC($$), op1);
                                                
                                                //CASO FLASE
                                                concatenaLC($$, $6);
                                                Operacion opFalse = {
                                                    .op = "move",
                                                    .res = strdup(tempStr),
                                                    .arg1 = recuperaResLC($6),
                                                    .arg2 = NULL
                                                };
                                                insertaLC($$, finalLC($$), opFalse);
                                                
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

                                                // SALTO IFNAL del TRUE
                                                Operacion op4 =  operEtiq(etiqFin);
                                                insertaLC($$, finalLC($$), op4);

                                                guardaResLC($$, strdup(tempStr));
                                                liberaTemporal(recuperaResLC($4));
                                                liberaTemporal(recuperaResLC($6));

                                                liberaLC($4);
                                                liberaLC($6);

                                            }

            | MINUSOP expression %prec MINUSOP_UN { 
                                                $$ = creaLC();
                                                concatenaLC($$, $2);

                                                Operacion op = crearOpArit("neg", recuperaResLC($2), NULL, recuperaResLC($2));

                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(recuperaResLC($2)));
                                                liberaLC($2);
                                            }
            | LPAREN expression RPAREN      { 
                                                $$ = $2;
                                            }
            | ID                            { 
                                                if (perteneceTablaS($1)) {
                                                    $$ = creaLC();
                                                    char nombreVar[20];
                                                    sprintf(nombreVar, "_%s", $1);

                                                    int temp = nuevoTemp();
                                                    char tempStr[5];
                                                    sprintf(tempStr, "$t%d", temp);

                                                    Operacion op = crearOpArit("lw", strdup(nombreVar), NULL, tempStr);

                                                    insertaLC($$, finalLC($$), op);
                                                    guardaResLC($$, strdup(tempStr));
                                                }
                                                else{
                                                    printf("Error semántico: Variable no declarada '%s' (linea: %d)\n", $1, yylineno);
                                                    error_check = true;
                                                    YYERROR;
                                                }

                                            }
            | ENTERO                        { 
                                                $$ = creaLC();

                                                int temp = nuevoTemp();
                                                char tempStr[5];
                                                sprintf(tempStr, "$t%d", temp);

                                                Operacion op = crearOpArit("li", $1, NULL, tempStr);
                                                
                                                insertaLC($$, finalLC($$), op);
                                                guardaResLC($$, strdup(tempStr));
                                            }
                                            ;

%%

/*          ******* IMPLEMENTACION FUNCIONES VIDEOS ******* 
 */

bool perteneceTablaS(char *nombre){
    return buscaLS(tablaSimb, nombre) != finalLS(tablaSimb);
}

void anadeEntrada(char *nombre, Tipo t, int v){
    Simbolo s;
    s.nombre = strdup(nombre);
    s.tipo = t;
    s.valor = v;
    insertaLS(tablaSimb, finalLS(tablaSimb), s);
}

bool esConstante(char *nombre){
    return recuperaLS(tablaSimb, buscaLS(tablaSimb, nombre)).tipo == CONSTANTE; // sacamos el indice del simbolo en la tabla y luego rescatamos el simbolo y comprobamos el tipo
}

void imprimirTablaS(){
  printf(".data\n");
  PosicionLista pos_actual = inicioLS(tablaSimb);
    while (pos_actual != finalLS(tablaSimb))
    {
        Simbolo sim = recuperaLS(tablaSimb, pos_actual);
        if(sim.tipo != CADENA) printf("_%s:\n\t .word 0\n",sim.nombre); 
        else printf("$str%d:\n\t .asciiz %s\n",sim.valor, sim.nombre); 
        pos_actual = siguienteLS(tablaSimb,pos_actual);
    }
  
}

void imprimeLC(ListaC codigo){
    printf(".text\n");
    printf(".globl main\n");
        printf("main:\n");
    PosicionListaC pos_actual = inicioLC(codigo);
    for (PosicionListaC pos = pos_actual; pos != finalLC(codigo); pos = siguienteLC(codigo, pos)) {
        Operacion op = recuperaLC(codigo, pos);
        
        if (op.op[0] != '$') {
        printf("\t");
        }
        printf("%s", op.op);

        if (op.res) {
            printf(" %s", op.res);
        }
        if (op.arg1) {
            printf(",%s", op.arg1);
        }
        if (op.arg2) {
            printf(",%s", op.arg2);
        }
        printf("\n");
    }
    
    printf("#\tFin\n");
    printf("\tli $v0, 10\n");
    printf("\tsyscall\n");

}

/*         ******* FUNCION SOLO PARA expression ******* 
     PORQUE EL RESTO ENCADENA VARIAS COSAS Y NO TIENE SENTIDO
        PERO LO QUE ES SUMAR, RESTAR, ETC. ES SISTEMATICO
*/
Operacion crearOpArit(char * op, char *oper1, char *oper2, char tempStr[5]){
    Operacion operacion = {
        .op = op,
        .res = strdup(tempStr),
        .arg1 = oper1,
        .arg2 = oper2
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
        .res = exp,
        .arg1 = etiq,
        .arg2 = NULL
    };
    return op;
}


/*         ******* FUNCION SOLO PARA temporales ******* 
        PARA EL TEMA DE INICIALIZAR, LIBERAR Y RESERVAR EL 
                    PRIMERO QUE HAYA LIBRE
*/
void inicializaTemporales(){
	for(int i = 0; i<N_TEMP;i++)
		tmp[i] = 0;
}

void liberaTemporal(char * temp) {
    int idx = atoi(temp + 2); 
    tmp[idx] = 0;
}

int nuevoTemp(){
	int i = 0;
	while(i<N_TEMP){
		if(tmp[i]==0){
			tmp[i] = 1;
			return i;
		}
		i++;
	}
	printf("No hay temporales libres\n");
    exit(1);
}

/*         ******* FUNCIONES FINALES PARA ETIQUETA Y ERROR *******          */

char* nuevaEtiq() {
    char* etiq = malloc(32);
    sprintf(etiq, "$l%d", contEtiquetas++);
    return etiq;  
}

void yyerror(char *s) {
    extern char *yytext;
    fprintf(stderr, "Error sintáctico en línea %d cerca de '%s': %s\n", yylineno, yytext, s);
}
