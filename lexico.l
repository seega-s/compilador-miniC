%{
#include "lexico.h"
#include "math.h" 
#include "listaSimbolos.h"
void error_lexico();  
%}
digito              [0-9]
letra               [a-zA-Z]
entero              {digito}+
id                  ({letra}|_)(_|{digito}|{letra})*
cadena              \"([^"\n\\]|\\[ntr"])*\"

%option yylineno

%%

 /* COMENTARIOS Y CARACTERES QUE HAY QUE SKIPPEAR (saltos, tabs, etc.) */
"//".*[\n]                                  ;
"/*"([^*]|\*[^/])*\*\/                      ;
[ \n\t\r]+                            	    ;


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

 /* ERRORES TODO LO QUE NO SEA + FUNCION */
([^A-Za-z0-9_\+\-\/\*{}()<>!=;,"\[\?\:\n])*  error_lexico(); // todo lo que no sea lo anterior

 /* VALORES LITERALES */
{entero}                                    {   if(atol(yytext)>pow(2,31))
                                    		        error_lexico("entero más grande que 2^31");
                                                else{
                                                    yylval.cadena = strdup(yytext);
                                                    return ENTERO;
                                                }
                                            }
{cadena}                                    {   yylval.cadena = strdup(yytext);
                                                return CADENA;
                                            }
 /* IDENTIFICADOR */
{id}                                        {   if (yyleng > 32)
                                                    error_lexico("ID tiene más de 32 caracteres");
                                                else{
                                                    yylval.cadena=strdup(yytext);
                                                    return ID;
                                                }
                                            }
                                                    


%%
void error_lexico(){
    printf("Error léxico en la línea %d: %s \n", yylineno, yytext);
}