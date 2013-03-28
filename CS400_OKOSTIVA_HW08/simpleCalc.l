%option noyywrap

%{
#include "simpleCalc.tab.h"
#include <string.h>
/*extern int yylval;*/
char *extract_name(char *s);
%}

%%
@[_A-Za-z][_A-Za-z0-9]* { yylval.sval = extract_name(yytext); return NAME; }
[0-9]+	{ yylval.ival = atoi(yytext); return NUMBER; }
[0-9]+\.[0-9]+	{ yylval.fval = atof(yytext); return FNUMBER; }
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

main()
{
	yyparse();
}
