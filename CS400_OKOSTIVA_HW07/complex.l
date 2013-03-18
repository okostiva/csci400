%option noyywrap
/* scanner for real, imaginary and complex numbers */ 
%{ 
/* need for the call to atof() and atoi() below */
 #include <math.h> 
%}
DIGIT [0-9]
DEC1 {DIGIT}+"."{DIGIT}*
DEC2 {DIGIT}*"."{DIGIT}+
REAL ({DIGIT}+|{DEC1}|{DEC2})
IMAG {REAL}?i
ADD "+"
SUB "-"
%% 
{REAL}({ADD}|{SUB}){IMAG} { printf ( "A complex number: %s (%s)\n", yytext, yytext); }
{IMAG} { printf ( "An imaginary number: %s (%s)\n", yytext, yytext); }
{REAL} { printf ( "A real number: %s (%g)\n", yytext, atof( yytext ) ); }
{DEC1} { printf ( "A real number: %s (%g)\n", yytext, atof( yytext ) ); }
{DEC2} { printf ( "A real number: %s (%g)\n", yytext, atof( yytext ) ); }
{ADD} { printf( "An addition operator: %s\n", yytext ); } 
{SUB} { printf( "A subtraction operator: %s\n", yytext ); } 
. { printf( "Unrecognized character: %s\n", yytext ); } 
%% 
main() 
{ 
	yylex(); 
}
