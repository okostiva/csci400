%option noyywrap

%{
#include "simpleCalc.tab.h"
#include <string.h>
/*extern int yylval;*/
char *extract_name(char *s);
extern FILE* yyin;
%}

%%
@[_A-Za-z][_A-Za-z0-9]* { yylval.sval = extract_name(yytext); printf("TOKEN: NAME (%d) from \"%s\"\n", yylval.sval, yytext); return NAME; }
[0-9]+	{ yylval.ival = atoi(yytext); printf("TOKEN: NUMBER (%d) from \"%s\"\n", yylval.ival, yytext); return NUMBER; }
([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)	{ yylval.fval = atof(yytext); printf("TOKEN: FNUMBER (%f) from \"%s\"\n", yylval.fval, yytext); return FNUMBER; }
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

char *extract_name(char *s)
{
	char *s2;
	
	s2 = malloc(strlen(s));
	if (!s2)
	{
		printf("Memory Allocation Error in extract_name()\n");
		exit(1);
	}
	
	strcpy(s2, s+1);
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
