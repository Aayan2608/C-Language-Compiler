%{
    #include<stdio.h>
    #include<stdlib.h>
    int yyerror(char *error_msg);
    int yylex();    
    extern FILE *f, *yyout , *yyin;
%}

%token INT CHAR_POINTER IF ELSE WHILE RETURN ASSIGN EQUAL NEQ LESS LESS_EQ GRT GRT_EQ LRB RRB LCB RCB PLUS MIN DIV MUL COMMA SEMICOLON  
%union{
    int n;
    char *str;
}
%token <str> STR
%token <str> IDEN
%token <n> NUM
%left PLUS MIN
%left MUL DIV
%left LRB RRB

%%
PROGRAM : CODE  ; 

CODE : FUNC_DEC CODE| FUNCTIONS CODE| VARIABLE_DECLARATION CODE | ;

VARIABLE_DECLARATION : INT IDEN SEMICOLON { 
                
                fprintf(yyout,"Variable type : int \n");
                fprintf(yyout,"Identifier : %s \n\n",$2);      
          } 
          | 
          INT IDEN ASSIGN EXPRESSION SEMICOLON {
           
              fprintf(yyout,"Variable type : int \n");
              fprintf(yyout,"Identifier : %s \n\n",$2);    
          }
          |
          IDEN ASSIGN EXPRESSION SEMICOLON {
     
              fprintf(yyout,"Identifier : %s \n\n",$1);    
          } 
          | 
          CHAR_POINTER IDEN SEMICOLON {
            
              fprintf(yyout,"Variable type : int \n");
              fprintf(yyout,"Identifier : %s \n\n",$2);    
          }
          | 
          CHAR_POINTER IDEN ASSIGN IDEN SEMICOLON {
            
              fprintf(yyout,"Variable type : int \n");
              fprintf(yyout,"Identifier : %s \n\n",$2);    
          }
          | 
          CHAR_POINTER IDEN ASSIGN STR SEMICOLON {
       
              fprintf(yyout,"Variable type : char \n");
              fprintf(yyout,"Identifier : %s \n\n",$2);    
          } ;

EXPRESSION :  NUM                  {fprintf(yyout,"Integer :  %d \n", $1);}
        | IDEN                {fprintf(yyout,"Variable : %s \n", $1);}
        | EXPRESSION PLUS EXPRESSION     {fprintf(yyout,"Arithmetic Operator : + \n");}
        | EXPRESSION MIN EXPRESSION    {fprintf(yyout,"Arithmetic Operator : - \n");}
        | EXPRESSION MUL EXPRESSION {fprintf(yyout,"Arithmetic Operator : * \n");}
        | EXPRESSION DIV EXPRESSION   {fprintf(yyout,"Arithmetic Operator : / \n");}
        | LRB EXPRESSION RRB;

FUNC_DEC : INT IDEN LRB ARGS RRB SEMICOLON 
                       {
                           fprintf(yyout,"Function Declaration \n");
                           fprintf(yyout,"Return Type : int \n");
                           fprintf(yyout,"Function name : %s \n",$2);
                       }
                       | CHAR_POINTER IDEN LRB ARGS RRB SEMICOLON 
                       {
                           fprintf(yyout,"Function Declaration \n");
                           fprintf(yyout,"Return Type : char \n");
                           fprintf(yyout,"Function name : %s \n",$2);
                       };

FUNCTIONS: INT IDEN LRB ARGS RRB LCB FUNC_BODY RCB
            {
                fprintf(yyout,"Function \n");
                fprintf(yyout,"Return Type : int \n");
                fprintf(yyout,"Function name : %s \n",$2);
            } 
            |
            CHAR_POINTER IDEN LRB ARGS RRB LCB FUNC_BODY RCB
            {
                fprintf(yyout,"Function \n");
                fprintf(yyout,"Return Type : char \n");
                fprintf(yyout,"Function name : %s \n",$2);
            } 
            |
            IDEN LRB ARGS RRB LCB FUNC_BODY RCB
            {
                fprintf(yyout,"Function \n");
                fprintf(yyout,"Function name : %s \n",$1);
            }
             ;

FUNC_BODY : VARIABLE_DECLARATION FUNC_BODY 
            | 
            IF LRB CONDITION RRB LCB FUNC_BODY RCB ELSE_COND
            {
                fprintf(yyout,"IF statement : \n");
            } 
            |
            WHILE LRB CONDITION RRB LCB FUNC_BODY RCB FUNC_BODY 
            {
                fprintf(yyout,"WHILE LOOP  \n");
            } 
            |
            IDEN ASSIGN IDEN LRB CALL_ARGS RRB SEMICOLON FUNC_BODY 
            {
                fprintf(yyout,"FUNCTION CALL  \n");
                fprintf(yyout,"Return var name : %s \n \n",$1);
                fprintf(yyout,"Function name : %s \n \n",$3);

            }
            |
            INT IDEN ASSIGN IDEN LRB CALL_ARGS RRB SEMICOLON FUNC_BODY 
            {
                fprintf(yyout,"FUNCTION CALL  \n");
                fprintf(yyout,"Return Type : int \n");

                fprintf(yyout,"Return var name : %s \n \n",$2);
                fprintf(yyout,"Function name : %s \n \n",$4);

            }
            |
            CHAR_POINTER IDEN ASSIGN IDEN LRB CALL_ARGS RRB SEMICOLON FUNC_BODY 
            {
                fprintf(yyout,"FUNCTION CALL  \n");
                fprintf(yyout,"Return Type : char \n");
                fprintf(yyout,"Return var name : %s \n \n",$2);
                fprintf(yyout,"Function name : %s \n \n",$4);

            }
            |
            RETURN NUM SEMICOLON |
            RETURN IDEN SEMICOLON |
            RETURN STR SEMICOLON | ;

ELSE_COND : ELSE LCB FUNC_BODY RCB FUNC_BODY 
            {
                fprintf(yyout,"ELSE statement : \n");
            }| FUNC_BODY ;

CONDITION : NUM 
            {
                fprintf(yyout,"CONDITION :  %d > 0 \n",$1);

            }
            | IDEN 
            {
                fprintf(yyout,"CONDITION :  %s > 0 \n",$1);

            }
            | NUM LOGIC NUM 
            {
                
                fprintf(yyout,"First Operand : %d \n",$1);
                fprintf(yyout,"Second Operand : %d \n",$3);
            }|
            IDEN LOGIC IDEN
            {
               
                fprintf(yyout,"First Operand : %s \n",$1);
                fprintf(yyout,"Second Operand : %s \n",$3);
               
            } ;

LOGIC : EQUAL 
        {
            fprintf(yyout,"CONDITION : Equals\n");
        }| 
        NEQ 
        {
            fprintf(yyout,"CONDITION : Not Equals\n");
        }| 
        GRT 
        {
            fprintf(yyout,"CONDITION : Greater than\n");
        }|
        GRT_EQ 
        {
            fprintf(yyout,"CONDITION : Greater than equals\n");
        }|
        LESS 
        {
            fprintf(yyout,"CONDITION : Less than \n");
        }| 
        LESS_EQ
        {
            fprintf(yyout,"CONDITION : Less than equals\n");
        } ; 
CALL_ARGS : EXPRESSION CALL_ARGS
        {
            fprintf(yyout,"Function Arguement : \n");
        }| 
        COMMA CALL_ARGS | ;
ARGS :  INT IDEN ARGS
        {
            fprintf(yyout,"Function Arguement : %s\n",$2);
        }
        | CHAR_POINTER IDEN ARGS
        { 
            fprintf(yyout,"Function Arguement : %s\n",$2);
        }
        | COMMA ARGS | ;
%%

int main(int argc , char *argv[])
{
    yyin = fopen(argv[1],"r");
    f = fopen("Lexer.txt","w");
    yyout = fopen("Parser.txt","w");
    yyparse();
    return 0;
}

int yyerror (char *text){
    fprintf(yyout, "Syntax Error\n");
}