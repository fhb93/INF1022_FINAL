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
    char * returnList;

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
    char * ifAssembly(char * sym1, char * sym2);
    char * ifElseAssembly(char * sym1, char * sym2, char * sym3);
    char * forAssembly(char * sym1, char * sym2);
    char * increment(char * sym1);
    char * nullify(char * sym1);
    char * equals(char * sym1, char * sym2);
    char * returningVarAnalysis(char * str);

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
%token<num> FIMENQUANTO;
%token<num> FACA;
%token<num> VEZES; 
%token<num> FIMFACA;
%token<num> FIM;
%token<num> SE;
%token<num> ENTAO;
%token<num> SENAO;
%token<num> FIMSEENTAO;

%start program
%% 

program: PROGRAM ENTRADA varlist1 SAIDA varlist2 cmds FIM { char * output = assembler($3, $5, $6); printf("\n\nCodigo Objeto em C: \n%s", output); exit(1); };

varlist1 : ID { char * output = createVar($1); $$=output; };
        | varlist1 ID { char * output = createVar($2); out = concatVars($1, output); $$=out; };

varlist2 : ID { char * output = returnVarList($1); $$=output; };
        | varlist2 ID { char * output = returnVarList($2); out = concatVars($1, output); $$=out; };


cmds    : cmd { $$=$1; };
        | cmd cmds { char * output = concat($1, $2); $$=output; };

cmd     : ENQUANTO ID FACA cmds FIMENQUANTO { char * output = whileAssembly($2, $4); $$=output; out = concat(out, output); };
cmd     : ID IGUAL ID { char * output = equals($1, $3); $$=output; };
        | INC ID { char * output = increment($2); $$=output; };
        | ZERA ID { char * output = nullify($2); $$=output; };
cmd     : SE ID ENTAO cmds FIMSEENTAO { char * output = ifAssembly($2, $4); $$=output; out = concat(out, output); };
        | SE ID ENTAO cmds SENAO cmds FIMSEENTAO { char * output = ifElseAssembly($2, $4, $6); $$=output; out = concat(out, output); }; 
cmd     : FACA ID VEZES cmds FIMFACA { char * output = forAssembly($2, $4); $$=output; };

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
    
    auxiliar4 = ")\n{"; 
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

//Lista de parametros

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

//definicao de variaveis locais

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

//Inclui variaveis de SAIDA na lista de vars de retorno

char * returnVarList(char * str1)
{
    auxiliar1 = " *";

    length = strlen(str1) + strlen(auxiliar1) + 1;

    char * mem = malloc(length);

    strcpy(mem, str1);

    returnList = mem;

    strcpy(mem, auxiliar1);

    strcat(mem, str1);

    return mem;
}

// char * addSymbol(char * sym1)
// {
//     auxiliar1 = " ";

//     length = strlen(auxiliar1) + strlen(sym1) + 1;

//     char * mem = malloc(length * sizeof(char));

//     strcat(mem, sym1);

//     strcat(mem, auxiliar1);

//     return mem;
// }

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

char * forAssembly(char * sym1, char * sym2)
{
    // for(i = 1; i <= sym1; i++)
    auxiliar1 = "\tint i;\n";
    
    auxiliar2 = "\tfor(i = 1; i <= ";
    
    auxiliar3 = "; i++)\n\t{";

    auxiliar4 = "\n\t}";
    
    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(auxiliar3) + strlen(auxiliar4);
    
    length += strlen(sym1) + strlen(sym2);
    
    length += 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, auxiliar2);

    strcat(mem, sym1);

    strcat(mem, auxiliar3);

    strcat(mem, sym2);

    strcat(mem, auxiliar4);

    return mem;
}

char * ifAssembly(char * sym1, char * sym2)
{
    auxiliar1 = "\n\tif(";
    
    auxiliar2 = ")\n\t{\n\t\t";

    auxiliar3 = "\n\t}";
   
    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(auxiliar3) + strlen(sym1) + strlen(sym2);
    
    length += 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    strcat(mem, sym2);

    strcat(mem, auxiliar3);

    return mem;
}

char * ifElseAssembly(char * sym1, char * sym2, char * sym3)
{
    auxiliar1 = "\n\tif(";
    
    auxiliar2 = ")\n\t{\t\t";

    auxiliar3 = "\n\t}";

    auxiliar4 = " else {";

    auxiliar5 = "\n\t}";

    length = strlen(auxiliar1) + strlen(auxiliar2) + strlen(auxiliar3); 
   
    length += strlen(auxiliar4) + strlen(auxiliar5);

    length += strlen(sym1) + strlen(sym2) + strlen(sym3);

    length += 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    strcat(mem, sym2);

    strcat(mem, auxiliar3);

    strcat(mem, auxiliar4);

    strcat(mem, sym3);

    strcat(mem, auxiliar5);

    return mem;
}
char * increment(char * sym1)
{
    auxiliar1 = "\n\t";

    auxiliar2 = " += 1;";    

    sym1 = returningVarAnalysis(sym1);

    length = strlen(sym1) + strlen(auxiliar1) + strlen(auxiliar2) + 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    // strcat(mem, auxiliar2);

    return mem;
}

char * equals(char * sym1, char * sym2)
{
    auxiliar1 = "\n\t";
    
    auxiliar2 = " = ";

    auxiliar3 = ";";

    sym1 = returningVarAnalysis(sym1);

    sym2 = returningVarAnalysis(sym2);

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

    sym1 = returningVarAnalysis(sym1);

    length = strlen(auxiliar1) + strlen(sym1) + strlen(auxiliar2) + 1;

    char * mem = malloc(length);

    strcpy(mem, auxiliar1);

    strcat(mem, sym1);

    strcat(mem, auxiliar2);

    return mem;
}

char * returningVarAnalysis(char * str)
{
    int i = 0;

    while(returnList[i] != '\0')
    {
        if(returnList[i] == str[0])
        {
            str = concat("*", str);
            break;
        }
        i++;
    }

    return str;
}

char * assembler(char * sym1, char * sym2, char * sym3)
{
    char * head = "*** INF1022: PROVOL-ONE COMPILER ***\n";
    
    char * foot = "\n*** PROVOL-ONE COMPILER - END OF OUTPUT ***\n";
    
    char * paramList = sym1;

    char * tempReturnList = sym2;

    char * mem = header(paramList, tempReturnList);

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