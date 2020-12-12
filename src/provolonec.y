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

/*  Linha com erro de sintaxe */
    extern int yylineno;

/* operacoes de montagem do código objeto */
    char * assembler(char * sym1, char * sym2, char * sym3);
    char * header(char * str1, char * str2);
    char * createVar(char * sym1);
    char * addVar(char * sym1);
    char * returnVarList(char * str1);
    char * addSymbol(char * sym1);
    char * concatVars(char * sym1, char * sym2);
    char * concat(char * sym1, char * sym2);
    char * whileAssembly(char * sym1, char * sym2);
    char * increment(char * sym1);
    char * nullify(char * sym1);
    char * equals(char * sym1, char * sym2);

/* extras para o yacc */
    int yylex();
    void yyerror(const char * str)
    {
        fprintf(stderr,"%s - line %d\n", str, yylineno);

    };

%}

%union
{
    char *str;
    int num;
};

%type<str> program varlist1 varlist2 cmds cmd;
%token<str> ID;
%token<num> PROGRAM;
%token<num> ENTRADA;
%token<num> SAIDA;
%token<num> IGUAL;
%token<num> INC;
%token<num> ZERA;
%token<num> ENQUANTO;
%token<num> FACA;
%token<num> FIM;

%start program
%% 

program: PROGRAM ENTRADA varlist1 SAIDA varlist2 cmds FIM { char * output = assembler($3, $5, $6); printf("\n\nCodigo Objeto em C: \n%s", output); exit(1); };
varlist1 : ID { char * output = createVar($1); $$=output; };
        | varlist1 ID { char * output = createVar($2); out = concatVars($1, output); $$=out; };

varlist2 : ID { char * output = returnVarList($1); $$=output; };
        | varlist2 ID { char * output = returnVarList($2); out = concatVars($1, output); $$=out; };


cmds    : cmd { $$=$1; };
        | cmd cmds { char * output = concat($1, $2); $$=output; };

cmd     : ENQUANTO ID FACA cmds FIM { char * output = whileAssembly($2, $4); $$=output; out = concat(out, output); };
cmd     : ID IGUAL ID { char * output = equals($1, $3); $$=output; };
        | INC ID { char * output = increment($2); $$=output; };
        | ZERA ID { char * output = nullify($2); $$=output; };

%%

int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}

char * header(char * str1, char * str2)
{
    auxiliar1 = "void function(";

    auxiliar2 = ", int ";

    auxiliar3 = strtok(str2, "int ");
    
    auxiliar4 = ")\n{\n"; 
    //auxiliar4 = strtok(str2, ";");

    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(auxiliar3);
    
    length += strlen(str1) + strlen(auxiliar4) + 1;  

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, str1);

    strcat(mem, auxiliar2);

    strcat(mem, auxiliar3);

    strcat(mem, auxiliar4);
    
    return mem;
}

char * createVar(char * sym1)
{
    auxiliar1 = "int ";
    
    // auxiliar2 = " = 0;";
    
    // auxiliar3 = "\n";

    length += strlen(auxiliar1) + strlen(sym1);// + strlen(auxiliar2) + strlen(auxiliar3) + 1;

    char * mem = malloc(length * sizeof(char));

    strcat(mem, auxiliar1);
    
    strcat(mem, sym1);
    
    // strcat(mem, auxiliar2);

    // strcat(mem, auxiliar3);

    return mem;
}

char * addVar(char * sym1)
{
    auxiliar1 = "int ";
    
    auxiliar2 = " = 0;";

    length += strlen(auxiliar1) + strlen(sym1) + strlen(auxiliar2) + 1;
    
    char * mem = malloc(length * sizeof(char));

    strcat(mem, auxiliar1);
    
    strcat(mem, sym1);
    
    strcat(mem, auxiliar2);

    return mem;
}

char * returnVarList(char * str1)
{
    auxiliar1 = " *";

    length = strlen(auxiliar1) + strlen(str1) + 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, str1);

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

char * concatVars(char * sym1, char * sym2)
{
    length = strlen(sym1) + strlen(sym2) + 3; 
    // 2 pq temos o \0 o espaco e a virgula entre variaveis

    char * mem = malloc(length * sizeof(char));

    strcpy(mem, sym1);

    strcat(mem, ", ");

    strcat(mem, sym2);

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
    auxiliar1 = "\n\t";
    
    auxiliar2 = "while(";
    
    auxiliar3 = ")\n\t{";

    auxiliar4 = "\n\t\t";

    auxiliar5 = "\n\t}";

    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(sym1) + strlen(auxiliar3) + strlen(sym2) + strlen(auxiliar4) + strlen(auxiliar5) + 1;

    char * mem = malloc(length * sizeof(char));

    strcpy(mem, auxiliar1);
    
    strcat(mem, auxiliar2);
    
    strcat(mem, sym1);

    strcat(mem, auxiliar3);

    strcat(mem, auxiliar4);

    strcat(mem, sym2);

    strcat(mem, auxiliar5);

    return mem;

}

char * increment(char * sym1)
{
    auxiliar1 = " += 1;";    

    length = strlen(sym1) + strlen(auxiliar1) + 1;

    char * mem = malloc(length);

    strcpy(mem, sym1);

    strcat(mem, auxiliar1);

    // strcat(mem, auxiliar2);

    return mem;
}

char * equals(char * sym1, char * sym2)
{
    auxiliar1 = "\n\t";
    
    auxiliar2 = " = ";

    auxiliar3 = ";";

    length = strlen(auxiliar1) + strlen(sym1) + strlen(sym2)+ strlen(auxiliar2) + strlen(auxiliar3) + 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    strcat(mem, sym2);

    strcat(mem, auxiliar3);

    return mem;
}

char * nullify(char * sym1)
{
    auxiliar1 = "\n\t";
    
    auxiliar2 = " = 0;";

    length = strlen(auxiliar1) + strlen(sym1) + strlen(auxiliar2) + 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    return mem;
}

char * assembler(char * sym1, char * sym2, char * sym3)
{
    char * head = "*** INF1022: PROVOL-ONE COMPILER ***\n";
    
    char * foot = "\n*** PROVOL-ONE COMPILER - END OF OUTPUT ***\n";
    
    char * paramList = sym1;

    char * returnList = sym2;

    char * mem = header(paramList, returnList);

    char * ending = "\n}";
    
    mem = concat(mem, sym3);
    
    length = strlen(head) + strlen(foot) + strlen(mem) + strlen(ending) + 1;

    char * finalOut = malloc(length);

    strcpy(finalOut, head);

    strcat(finalOut, mem);

    strcat(finalOut, ending);

    strcat(finalOut, foot);

    return finalOut;
}