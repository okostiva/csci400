%option noyywrap

%{

#include <stdio.h>
#include <string.h>
#include "simpleCalc.tab.h"

int extractreg(char *s);
void setInputFile(char* filename);
void token(int tkn);

extern int verbose;

%}

%%

\/\*([^\*]|[\r\n]|(\*+([^\*\/]|[\r\n])))*\*+\/ 		{ token(BCMT); }	/* ignore block comments */
\/\/.*\n?			{ token(LCMT); } 	/* ignore line comments */
\?					{ yylval.sval = yytext; token(PCMD); return PCMD; }	/* This represents a print command */
[eE]				{ yylval.sval = yytext; token(ENOT); return ENOT; }	/* This represents e notation in a floating point number */
[rR][_A-Za-z]*[0-4] { yylval.ival = extractreg(yytext); token(IREG) ; return IREG; }
[rR][_A-Za-z]*[5-9] { yylval.ival = extractreg(yytext); token(FREG); return FREG; }
[0-9]+	{ yylval.ival = atoi(yytext); token(INUM); return INUM; }
[0-9]*\.[0-9]+	{ yylval.fval = atof(yytext); token(FNUM); return FNUM; }
[0-9]+\.[0-9]*	{ yylval.fval = atof(yytext); token(FNUM); return FNUM; }
[ \t]	;		/* ignore white space */
\n    	;		/* ignore white space */
.	    {token(yytext[0]); return yytext[0];}
<<EOF>> {token(0); return 0;}

%%

/*---------------------------------------------------------------------------*/
/* 5. Other C code that we need.                                           */
 
yyerror(char *errmsg)
{
    fprintf(stderr, "%s\n", errmsg);
}

void token(int tkn)
{
	if (verbose)
	{

		switch(tkn)
		{
			case INUM: printf("TOKEN: %s (%i from %s)\n", "INUM", yylval.ival, yytext); break;
			case FNUM: printf("TOKEN: %s (%g from %s)\n", "FNUM", yylval.fval, yytext); break;
			case IREG: printf("TOKEN: %s (%i from %s)\n", "IREG", yylval.ival, yytext); break;
			case FREG: printf("TOKEN: %s (%i from %s)\n", "FREG", yylval.ival, yytext); break;
			case LCMT: printf("TOKEN: %s (line comment ignored)\n", "LCMT"); break;				// line comment
			case BCMT: printf("TOKEN: %s (block comment ignored)\n", "BCMT"); break;			// block comment
			case PCMD: printf("TOKEN: %s (%s from %s)\n", "PCMD", yylval.sval, yytext); break;	// Print Symbol		
			case ENOT: printf("TOKEN: %s (%s from %s)\n", "ENOT", yylval.sval, yytext); break;	// E Notation Symbol
			case 0    : printf("TOKEN: %s\n", "<<EOF>>"); break;
			default   : printf("TOKEN: %c\n", tkn); break;
		}
	}
}

// This function assumes that the string passed is a properly recognized token
int extractreg(char *s)
{
	int reg;
	
	while (*(s+1)) // Start with second character
		s++;
	reg = *s - '0'; // Convert to a number
	return ((reg<5)? reg : reg - 5); // Adjust fp reg index
}

// attempt to set the input based on the file name provided
void setInputFile(char* filename)
{
	yyin = fopen(filename, "rt");
	if (!yyin)
	{
		printf("Failed to open input file <%s>\n", filename);
		exit(1);
	}
}

int main(int argc, char *argv[])
{
	// parse the command line arguments looking for a file name and -v (verbose) flag
	if (argc == 2)
	{
		if (strcmp(argv[1], "-v") == 0)
			verbose = 1;
		else 
			setInputFile(argv[1]);
	}
	else if (argc == 3)
	{
		if (strcmp(argv[1], "-v") == 0)
		{
			verbose = 1;
			setInputFile(argv[2]);
		}
		else if (strcmp(argv[2], "-v") == 0)
		{
			verbose = 1;
			setInputFile(argv[1]);
		}
		else
		{
			printf("An invalid number of paramters were provided.\n");
			exit(1);
		}
	}
	else
		yyin = stdin;
	
	yyparse();
}
