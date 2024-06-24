%{
#include <stdio.h>
#include "cucu.tab.h"
FILE *f ;
%}

%%
int                     fprintf(f, "TYPE : int \n" ) ; return INT;
char[ ]\*               fprintf(f, "TYPE : char* \n" ) ; return CHAR_POINTER;
[ \t\n]+                ;
if                      fprintf(f, "CONDITIONAL : if \n" ) ; return IF;
else                    fprintf(f, "ELSE : if \n" ) ; return ELSE;
while                   fprintf(f, "LOOP : while \n") ; return WHILE;
return                  fprintf(f, "RETURN : return \n" ) ; return RETURN;
"="                     fprintf(f, "ASSIGN : =  \n") ; return ASSIGN;
"=="                    fprintf(f, "RELATION : == \n") ; return EQUAL;
"!="                    fprintf(f, "RELATION : != \n") ; return NEQ;
"<"                     fprintf(f, "RELATION : < \n") ; return LESS;
"<="                    fprintf(f, "RELATION : <= \n") ; return LESS_EQ;
">"                     fprintf(f, "RELATION : > \n") ; return GRT;
">="                    fprintf(f, "RELATION : >= \n") ; return GRT_EQ;
"("                     fprintf(f, "PARENTHESIS : ( \n") ; return LRB;
")"                     fprintf(f, "PARENTHESIS : ) \n") ; return RRB;
"{"                     fprintf(f, "PARENTHESIS : { \n") ; return LCB;
"}"                     fprintf(f, "PARENTHESIS : } \n") ; return RCB;
","                     fprintf(f, "COMMA : , \n") ; return COMMA;
"+"                     fprintf(f, "PLUS : + \n") ; return PLUS;
"-"                     fprintf(f, "MINUS : - \n") ; return MIN;
"*"                     fprintf(f, "MULTIPLY : * \n") ; return MUL;
"/"                     fprintf(f, "DIVIDE : / \n") ; return DIV;
";"                     fprintf(f, "SEMICOLON : ; \n") ; return SEMICOLON;
[a-zA-Z_][a-zA-Z0-9_]*  fprintf(f, "IDENTIFIER : %s \n", yytext ) ; yylval.str=strdup(yytext);return IDEN;
[0-9]+                  fprintf( f, "NUMBER : =  %s \n", yytext) ;  yylval.n=atoi(yytext); return NUM;
\"[a-zAA-Z_0-9 ]*\"     {  
                            fprintf(f, "STRING : ");
                            for(int i=1;i<yyleng-1;i++)
                            { 
                                fprintf(f, "%c",yytext[i]);
                            }
                            fprintf(f, "\n");
                            yylval.str=strdup(yytext);
                            return STR;
                        }
\/\/.*                  ;
\/\*[^*]*[*]+([^/][^*]*[*]+)*\/  ;
%%

int yywrap(){
    return 1;
}
