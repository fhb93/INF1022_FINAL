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


/* extras para o yacc */
    int yylex();
    void yyerror(const char * str)
    {
        fprintf(stderr,"%s\n", str);

    };

%}


%token ENTRADA
%token ID
%token SAIDA
%token INC
%token ZERA
%token ENQUANTO
%token FACA
%token FIM


