%{
/* Secao de Definicoes */
/* Importacao das bibliotecas */
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

/* saida final */
    char * out = "";

/* variaveis auxiliares */

    char * auxiliar1;
    char * auxiliar2;
    char * auxiliar3;
    char * auxiliar4;
    char * auxiliar5;

/* comprimento da palavra */
    int length = 0;

/* operacoes da linguagem */
    char * createVar(char * sym1);
    char * addVar(char * sym1);
    char * addSymbol(char * sym1);
    char * concat(char * sym1, char * sym2);
    char * whileAssembly(char * sym1, char * sym2);
    char * increment(char * sym1);
    char * nullify(char * sym1);
    char * equals(char * sym1, char * sym2);


/* extras para o yacc */
    int yylex();
    void yyerror(const char * str)
    {
        fprintf(stderr,"%s\n", str);

    };

%}

%union
{
    char *str;
    int num;
};

%type<str> program varlist0 varlist1 cmds cmd;
%token<str> ID;
%token<num> ENTRADA;
// %token ID
%token<num> SAIDA;
%token<num> IGUAL;
%token<num> INC;
%token<num> ZERA;
%token<num> ENQUANTO;
%token<num> FIMENQUANTO
%token<num> FACA;
%token<num> FIM;

%start program
%% 

program : ENTRADA varlist0 SAIDA varlist1 cmds FIM { char * output = assembler($2, $4, $5); printf("\n\nCodigo Objeto em C: \n%s", output) ; exit(1); };
varlist0 : ID { char * output = createVar($1); $$=output; };
         | varlist0 ID { char * output = addVar($2); out = concat($1, output); $$=out; };

varlist1 : ID { char * output = addSymbol($1); $$=output; };
         | varlist1 ID { char * output = addSymbol($2); out = concat($1, output); $$=out; };

cmds    : cmd { $$=$1; };
        | cmd cmds { char * output = concat($1, $2); $$=output };

cmd     : ENQUANTO ID FACA cmds FIMENQUANTO { char * output = whileAssembly($2, $4); output = concat(output, " }\n"); $$=output; out = concat(out, output); };
cmd     : ID IGUAL ID { char * output = equals($1, $3); $$=output };
        | INC ID { char * output = increment($2); $$=output; };
        | ZERA ID { char * output = nullify($2); $$=output; };

%%

int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}

char * createVar(char * sym1)
{
    auxiliar1 = "var ";
    
    auxiliar2 = " = 0;";
    
    auxiliar3 = "\n";

    length += strlen(aux1) + strlen(sym1) + strlen(auxiliar2) = strlen(auxiliar3) + 1;

    char * mem = malloc(length * sizeof(char));

    strcat(mem, auxiliar1);
    
    strcat(mem, sym1);
    
    strcat(mem, auxiliar2);

    strcat(mem, auxiliar3);

    return mem;
}

char * addVar(char * sym1)
{
    auxiliar1 = "var ";
    
    auxiliar2 = " = 0;";
    
    auxiliar3 = "\n";

    length += strlen(aux1) + strlen(sym1) + strlen(auxiliar2) = strlen(auxiliar3) + 1;
    
    char * mem = malloc(length * sizeof(char));

    strcat(mem, auxiliar1);
    
    strcat(mem, sym1);
    
    strcat(mem, auxiliar2);

    strcat(mem, auxiliar3);

    return mem;
}

char * addSymbol(char * sym1)
{
    auxiliar1 = " ";

    length = strlen(auxiliar1) + strlen(sym1) + 1;

    char * mem = malloc(length * sizeof(char));

    strcat(mem, sym1);

    strcat(mem, auxiliar1);

    return mem;
}

char * concat(char * sym1, char * sym2)
{
    length = strlen(sym1) + strlen(sym2) + 1;

    char * mem = malloc(length * sizeof(char));

    strcpy(mem, sym1);

    strcat(mem, sym2);

    return mem;
}

char * whileAssembly(char * sym1, char * sym2)
{
    auxiliar1 = "\n";
    
    auxiliar2 = " while ";
    
    auxiliar3 = "\n{\n";

    auxiliar4 = "\n }\n";

    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(sym1) + strlen(auxiliar3) + strlen(sym2) + strlen(auxiliar4) + 1;

    char * mem = malloc(length * sizeof(char));

    strcpy(mem, auxiliar1);
    
    strcat(mem, auxiliar2);
    
    strcat(mem, sym1);

    strcat(mem, auxiliar3);

    strcat(mem, sym2);

    strcat(mem, auxiliar4);

    return mem;

}