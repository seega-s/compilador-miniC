%{
#include <stdio.h>
#include "math.h" 
#include "listaCodigo.h"
#include "sintaxis.tab.h"
#include "listaSimbolos.h"
void error_lexico();  
%}
digito              [0-9]
letra               [a-zA-Z]
%option yylineno
%x                  COMENTARIO

%%
"//"(.*)[\n\r]                              ;                  
[ \t\n\r]+                                  ;  /*Ignorar espacios, tabulaciones y saltos de línea*/

"/*" 								        BEGIN COMENTARIO;
<COMENTARIO>[^*]* 						    ;
<COMENTARIO>[*]+[/]						    BEGIN 0;
<COMENTARIO>[*]+[^/*]*					    ;


 /* PALABRAS RESERVADAS */
"var"                                       return VAR;
"const"                                     return CONST;
"int"                                       return INT;
"if"                                        return IF;
"else"                                      return ELSE;
"while"                                     return WHILE;
"print"                                     return PRINT;
"read"                                      return READ;    
 /* CARACTERES ESPECIALES */
";"                                         return DOTCOMMA;
","                                         return COMMA;
"+"                                         return PLUSOP;
"-"                                         return MINUSOP;
"*"                                         return MULTOP;
"/"                                         return DIVOP;
"("                                         return LPAREN;
")"                                         return RPAREN;
"{"                                         return LBRACE;
"}"                                         return RBRACE;
"?"                                         return QMARK;
":"                                         return COLON;
"="                                         return ASIGN;

 /* ERRORES TODO LO QUE NO SEA + FUNCION */
([^A-Za-z0-9_\+\-\/\*{}();,"\[\?\:\n\r\t\ ])+   error_lexico(); // todo lo que no sea lo anterior

 /* VALORES LITERALES */
{digito}+                                   {   if(atol(yytext)>pow(2,31))
                                    		        printf("Entero más grande que 2^31\n");
                                                else{
                                                    yylval.lexema = strdup(yytext);
                                                    return ENTERO;
                                                }
                                            }
\"([^"\n\\]|\\[ntr"])*\"                    {   yylval.lexema= strdup(yytext);
                                                return STRING;
                                            }
 /* IDENTIFICADOR */
({letra}|_)(_|{digito}|{letra})*            {   if (yyleng > 32)
                                                    printf("ID tiene más de 32 caracteres\n");  // return id para que el sintactico no se quede esperando
                                                else{
                                                    yylval.lexema =strdup(yytext);
                                                    return ID;
                                                }
                                            }
%%
void error_lexico(){
    printf("Error léxico en la línea %d: %s \n", yylineno, yytext);
}