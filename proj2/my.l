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

{digit} { yylval.DOUBLE = atof(yytext); return DIGIT; }

{letter}+ { 
 int i = 0; int var = 0;
 while(1){
   if( yyleng == i) { break; }
   var += yytext[i] - 'a' + 1;
   i++;
 }
 yylval.INT = var; return VARI; 
 } 

"!" { return NEG; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
"=" { return EQUAL; }
";" { return EOL; }
"(" { return LP; }
")" { return RP; }
[ \t\n] { ; } 
. { yyerror("unexpected char"); }

%%



