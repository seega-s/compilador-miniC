%{
#include "lexico.h"
int n_err_lexico = 0;  
void error_lexico();  
%}
digito              [0-9]
letra               [a-zA-Z]
%%
 /* VALORES LITERALES */
-?{digito}{1,10}                            {   yylval.cadena = strdup(yytext);
                                                return ENTERO;
                                            }
\"([^\\\"]|\\[\"tnr\\])*\"                  {   yylval.cadena = strdup(yytext);
                                                return CADENA;
                                            }
 /* IDENTIFICADOR */
({letra}|_){digito}{0,31}                   {   if (yyleng > 32)
                                                    error_lexico("ID tiene más de 32 caracteres");
                                                else{
                                                    yylval.cadena=strdup(yytext);
                                                    return ID;
                                                }
                                            }
                                                    
 /* PALABRAS RESERVADAS */
"var"                                       return VAR;
"const"                                     return CONST;
"int"                                       return INT;
"if"                                        return IF;
"else"                                      return ELSE;
"while"                                     return WHILE;
"printf"                                    return PRINTF;
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
 /* COMENTARIOS UNA // y MuLTI /**/ */
\/\/.*                                      ;
"/*"([^*]|\*[^/])*\*\/                      ;

 /* ERRORES TODO LO QUE NO SEA + FUNCION */
.+                                          return error_lexico();

%%
void error_lexico(){
    n_err_lexico++;
    printf("Error léxico en la línea %d: %s \n", yylineno, yytext);
}