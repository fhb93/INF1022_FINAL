%option yylineno

%option yywrap
    #include <stdio.h>
    #include <string.h>
    #include "provolonec.tab.h"
    
    int yylineno;
%%

Program         return(PROGRAM);
ENTRADA         return(ENTRADA);
SAIDA           return(SAIDA);
FACA            return(FACA);
ENQUANTO        return(ENQUANTO);
FIM             return(FIM);
"="             return(IGUAL);
INC             return(INC);
ZERA            return(ZERA);
[a-zA-Z]+       {   yylval.str = strdup(yytext); return ID;  }
[\t\n ]         {}
