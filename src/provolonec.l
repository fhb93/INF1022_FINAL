%option yywrap
    #include <stdio.h>
    #include <string.h>
    #include "provolonec.tab.h"
%%

ENTRADA         return(ENTRADA);
SAIDA           return(SAIDA);
FACA            return(FACA);
ENQUANTO        return(ENQUANTO);
FIMENQUANTO     return(FIMENQUANTO);
FIM             return(FIM);
"="             return(IGUAL);
INC             return(INC);
ZERA            return(ZERA);
[a-zA-Z]+       {   yylval.str = strdup(yytext); return ID;  }
