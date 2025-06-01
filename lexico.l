%{
#include "lexico1.h"
%}
digito              [0-9]
letra               [a-zA-Z]
%%
//              VALORES LITERALES
-?{digito}{1,10}                            return ENTERO;
\"([^\\\"]|\\[\"tnr\\])*\"                  return CADENA;
//              IDENTIFICADORES
({letra}|_){digito}{0,31}                   return ID;
//              PALABRAS RESERVADAS
var                                         return VAR;
const                                       return CONST;
int                                         return INT;
if                                          return IF;
else                                        return ELSE;
while                                       return WHILE;
printf                                      return PRINTF;
read                                        return READ;    
//              CARACTERES ESPECIALES
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
//              COMENTARIOS
//  \/\/.* com una linea version2
"//".*
"/*"([^*]|\*[^/])*\*\/

.                                           printf("Error en carácter %s",yytext );
%%