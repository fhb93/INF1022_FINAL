/*Felipe Holanda Bezerra - 1810238*/ 
/*INF1022 - Analisadores Lexicos e Sintaticos*/
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
VEZES           return(VEZES);
FIMFACA         return(FIMFACA);
ENQUANTO        return(ENQUANTO);
FIMENQUANTO     return(FIMENQUANTO);
FIM             return(FIM);
SE              return(SE);
ENTAO           return(ENTAO);
FIMSEENTAO      return(FIMSEENTAO);
SENAO           return(SENAO);
"="             return(IGUAL);
INC             return(INC);
ZERA            return(ZERA);
[a-zA-Z]+       {   yylval.str = strdup(yytext); return ID;  }
[0-9]+          {   yylval.str = strdup(yytext); return ID;  }
[\t\n ]         {}
