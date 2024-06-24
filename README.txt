
To run the program :

For Sample1.cu : 
flex cucu.l
bison -d cucu.y
gcc cucu.tab.c lex.yy.c -lfl -o cucu
./cucu Sample1.cu

For Sample2.cu : 
flex cucu.l
bison -d cucu.y
gcc cucu.tab.c lex.yy.c -lfl -o cucu
./cucu Sample2.cu

Order in which the Parser.txt is printed is based on the recursion process.
IF-ELSE statements :
While printing if statement , it will print the condition, identifiers and operands etc first, after that it will print "IF" statement.
WHILE LOOP statements :
While printing while loop statements , it will print the condition, identifiers and operands etc. first, after that it will print "WHILE LOOP" statement.

When encountered an error :
"Syntax Error" will be printed in Parser.txt.
Nothing else would be printed in Lexer.txt after error is detected in particular line.





