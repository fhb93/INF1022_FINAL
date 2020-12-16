INF1022_FINAL
Trabalho Final da Disciplina 
INF1022 - Analisadores Léxicos e Sintáticos
Felipe Holanda Bezerra

Entrega/
|   enunciado-projeto-final.pdf
|   README.txt
|   bin/
|   |   provolonec - executavel do compilador de Provol-One, gerado pelo script ../src/build.sh 
|   |   run.sh - script para execucao do projeto
|   |   teste1.txt - teste baseado no enunciado
|   |   teste2.txt - teste baseado no enunciado com while, =, inc e zera
|   |   teste3.txt - teste com if-then
|   |   teste4.txt - teste com if-then-else
|   |   teste5.txt - teste com mais de um valor de retorno
|   |   teste6.txt - teste com ifs aninhados
|   src/
|   |   build.sh - script de build da pasta src
|   |   lex.yy.c - arquivo .c gerado a partir do lex
|   |   provolonec.l - arquivo lex
|   |   provolonec.tab.c - arquivo .c gerado a partir do yacc
|   |   provolonec.tab.h - arquivo .h gerado a partir do yacc
|   \   provolonec.y - arquivo yacc
\

- Para executar: navegar para a pasta bin e executar run.sh com um dos testes como parametro:
Para rodar o teste1:    ./run.sh teste1.txt
Saida de teste1:
 
,()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int X, int Y, int * Z)
{
	*Z = Y;
	while(X)
	{		
	*Z += 1;
	}
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Para rodar o teste2:    ./run.sh teste2.txt
Saida para teste2:

,()()()()()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int X, int Y, int * Z)
{
	*Z = Y;
	*Z = 0;
	Y = 0;
	X += 1;
	while(X)
	{		
	*Z += 1;
	}
	X = 0;
	X = Y;
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Para rodar o teste3:    ./run.sh teste3.txt

,()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int X, int Y, int * Z)
{
	*Z = Y;
	if(X)
	{		
	*Z += 1;
	}
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Para rodar o teste4:    ./run.sh teste4.txt

,,()()()()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int a, int b, int c, int * d)
{
	b = 0;
	if(a)
	{		
	b += 1;
	c += 1;
	*d = b;
	} else {
	a += 1;
	*d = a;
	}
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Para rodar o teste5:    ./run.sh teste5.txt

,,,,,()()()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int a, int b, int c, int * d, int * e, int * f, int * g)
{
	if(a)
	{		
	b += 1;
	a += 1;
	c += 1;
	}
	*d = c;
	*e = b;
	*f = a;
	*g = a;
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Para rodar o teste6:    ./run.sh teste6.txt

,,()()()()()

Codigo Objeto em C: 
*** INF1022: PROVOL-ONE COMPILER ***
void function(int a, int b, int c, int * d)
{
	b = 0;	int i;
	for(i = 1; i <= a; i++)
	{
	b += 1;
	}
	if(a)
	{		
	b += 1;
	if(b)
	{		
	c += 1;
	}
	*d = b;
	} else {
	a += 1;
	*d = a;
	}
}
*** PROVOL-ONE COMPILER - END OF OUTPUT ***

Fim do README