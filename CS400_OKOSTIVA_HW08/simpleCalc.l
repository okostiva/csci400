%option noyywrap

%{
#include "simpleCalc.tab.h"
#include <string.h>
#include <math.h>
/*extern int yylval;*/
char *parse_register(char *s);
double parse_exponent(char *s);
extern FILE* yyin;
%}
DIGIT [0-9]
DEC1 {DIGIT}*"."{DIGIT}+
DEC2 {DIGIT}+"."{DIGIT}*
%%
[Rr][_A-Za-z]*[0-9] { yylval.sval = parse_register(yytext); printf("TOKEN: REGISTER (%s from \"%s\")\n", yylval.sval, yytext); return REGISTER; }
({DEC1}|{DEC2}|{DIGIT}+)\^({DEC1}|{DEC2}|{DIGIT}+)	{ yylval.fval = parse_exponent(yytext); printf("TOKEN: FNUMBER (%f from \"%s\")\n", yylval.fval, yytext); return FNUMBER; }
({DEC1}|{DEC2})	{ yylval.fval = atof(yytext); printf("TOKEN: FNUMBER (%f from \"%s\")\n", yylval.fval, yytext); return FNUMBER; }
{DIGIT}+	{ yylval.ival = atoi(yytext); printf("TOKEN: NUMBER (%d from \"%s\")\n", yylval.ival, yytext); return NUMBER; }
[ \t]	;		/* ignore white space */
\n	; /*return NEWLINE;*/
.	return yytext[0];
%%
/*\n	return 0;	/* logical EOF */
/*---------------------------------------------------------------------------*/
/* 5. Other C code that we need.                                           */
 
yyerror(char *errmsg)
{
    fprintf(stderr, "%s\n", errmsg);
}

double parse_exponent(char *s)
{
	double base = 0.0;
	double exponent = 0.0;
	char localString[strlen(s)];	
	
	strcpy(localString, s);
	
	char* baseString = strtok(localString, "^");
	char* exponentString = strtok(NULL, "^");
	
    base = atof(baseString);
	exponent = atof(exponentString);
	
	return pow(base, exponent);
}

char *parse_register(char *s)
{
	char *s2;
	char temp[3];
	
	temp[0] = 'R';
	temp[1] = s[strlen(s) - 1];
	temp[2] = '\0';

	s2 = malloc(3*sizeof(char));
	if (!s2)
	{
		printf("Memory Allocation Error in parse_register()\n");
		exit(1);
	}

	strcpy(s2, temp);
	//printf("extract from %s to %s\n", s, s2);
	
	return s2;
}

readFromFile(char* filename)
{
	yyin = fopen(filename, "rt");
	if (!yyin)
	{
		printf("File %s failed to open.\n", filename);
		exit(1);
	}
}

main(int argc, char* argv[])
{
	if (argc == 2)
	{
		readFromFile(argv[1]);
	}
	else if (argc > 2)
	{
		printf("An invalid number of parameters were provided!\n\n");
		printf("USAGE: SimpleCalc.exe [filename]\n");
		printf("PARAMTERS: filename (Optional): Input file containing program data."); 
		exit(1);
	}
	
	yyparse();
}
