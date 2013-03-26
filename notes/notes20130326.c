//CSCI 400
//Class notes 03/26/2013
//
//
/*	
   i = 3
   j = 7
   
   k = i---j;
   k = i-- -j;
   
   k = i- - -j;
   k = i - j;
   
   k = i-- - --j;
   
   k = i-----j;
   k = i-- -- -j;
   
   Max munch (longest match) principle says that the lexer should take the longest
   possible valid string in order to make a valid token
   
   Lex - Definition Section
       Must include the header created by bison
       Must declare yylval as extern
       
       %{
            #include "simpleCalc.tab.h"
            extern int yylval; //Tells the compiler that there is an integer somewhere named yylval (don't allocate memory here, just declare the name)
            #include <math.h>
       %}
       
   Bison Parser - C Section
       At a minimum procde a yyerror and main routines
       
       yyerror(char *errmsg)
       {
           fprintf(stderr, "%s\n", errmsg);
       }
       
       main() 
       {
           yyparse();
       }
       
   Adding other variable types
       YYSTYPE determines the data type of the values returned by the lexter
       If lexer returns different types depending on what is read, include a union:
           
           %union {         //C feature, allows one memory area to be interpreted
               char cval;   //in different ways.
               char *sval;  //For bison, will be used with yylval
               int ival;
           }
       
       The union will be placed at the top of your .y file (in the definitions section)
       Tokens and non-terminals should be defined using the union
       
           %union {
               float fval;
               int ival;
           }
           %token <ival>NUMBER
           %token <fval>FNUMBER
           @type <fval> expression
           
       Using union rules

           {DIGIT}+ { yylval.ival = atoi(yytext); return NUMBER; }
       
       Processing lexemes in flex
           Sometimes you want to modify a lexeme before it is passed to bison
           This can be done by putting a function call in the flex rules
           
           Example: to convert input to lower case
               Put a prototype for your function in the definition section (above the first %%)
               Write the function definition in the C-code section (bottom of the file)
               Call your function when the token in recognized. Use strdup to pass the value to bison
               
               %{
                   #include "example.tab.h"
                   
                   void make_lower(char *text_in);
               %}
               %%
               [A-z]+ {make_lower(yytext);
                       yylval.sval = strdup(yytext);
                       return KEYWORD;}
               %%
               void make_lower(char *text_in)
               {
                   int i;
                   for (i=0; i<strlen(yytext); ++i)
                       yytext [i]=tolower(yytext[i]);
               }
               
       Adding actions to rules
           For more complex processing, functions ban be added to bison
           Remember to add a prototype at the top, and the function at the bottom
       
       Processing more than one line 
           To process more that one line, ensure the \n is simply ignored
           Use a recursive rule to allow multiple inputs
*/
