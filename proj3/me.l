%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "my.tab.h"
 extern YYSTYPE yylval;
 
%}

letter [A-Za-z]
digit  ([0-9]+|[0-9]+"."[0-9]+)
%%

{digit} { yylval.DOUBLE = atof(yytext); return NUMBER; }

{letter}+ { 
 int i = 0; int var = 0;
 while(1){
   if( yyleng == i) { break; }
   var += yytext[i] - 'a' + 1;
   i++;
 }
 yylval.INT = var; return ID; 
 } 

"!" { return NEG; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
";" { return EOL; }
"(" { return LP; }
")" { return RP; }
"{" { return LM; }
"}" { return RM; }
"," { return COMMA; }
"<" { return RBIG; }
">" { return LBIG; }
"<=" { return REB; }
">=" { return LEB; }
"==" { return EQUAL; }
"!=" { return NEQUAL; }
"SET" { return SET; }
"to" { return to; }
"PRINT" { return PRINT; }
"IF" { return IF; }
"THEN" { return THEN; }
"ENDIF" { return ENDIF; }
"ELSE" { return ELSE; }
"ENDWHILE" { return ENDWHILE; }
"FUNC" { return FUNC; }
"RETURN" { return RETURN; }
[ \t\n] { ; } 
. { yyerror("unexpected char"); }

%%



