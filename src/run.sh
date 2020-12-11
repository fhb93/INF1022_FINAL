bison -d provolonec.y
flex provolonec.l
gcc -o provolonec lex.yy.c provolonec.tab.c -ll