%{

#include <stdio.h>
#include <stdlib.h>

#define VERBOSE (0)

int endProgram(void);
void rule(char *lhs, char *rhs, int type, void *ival);

int verbose = VERBOSE;
float freg[5] = {0};
int   ireg[5] = {0};

%}

%union {
   float fval;
   int ival;
   char* sval;
}

%token <ival> IREG
%token <ival> FREG
%token <ival> INUM
%token <fval> FNUM	 
%token <sval> LCMT
%token <sval> BCMT
%token <sval> PCMD
%token <sval> ENOT

%type <fval> fexpr
%type <fval> fterm
%type <fval> ffactor
%type <fval> fvalue
%type <ival> iexpr
%type <ival> iterm
%type <ival> ifactor
%type <ival> ivalue

%%
program: 
		statement 					{	rule("program", "statement", 0, NULL);
										return endProgram(); 
									}
	|	'{' statements '}'			{	rule("program", "'{' statements '}'", 0, NULL);
										return endProgram();
									}
	;

statements: 
		statement ';' statements	{	rule("statements", "statement ';' statements", 0, NULL); }
	|	statement ';'				{	rule("statements", "statement ';'", 0, NULL); }
	;
	
statement:	
		PCMD FREG '=' fexpr		{	freg[$2] = $4; 	rule("statement", "PCMD FREG '=' fexpr", 0, NULL); printf("ANS> %g\n", freg[$2]); }
	|	PCMD FREG '=' iexpr		{	freg[$2] = $4; 	rule("statement", "PCMD FREG '=' iexpr", 0, NULL); printf("ANS> %g\n", freg[$2]); }
	|	PCMD IREG '=' fexpr		{	ireg[$2] = $4; 	rule("statement", "PCMD IREG '=' fexpr", 0, NULL); printf("ANS> %d\n", ireg[$2]); }
	|	PCMD IREG '=' iexpr		{	ireg[$2] = $4; 	rule("statement", "PCMD IREG '=' iexpr", 0, NULL); printf("ANS> %d\n", ireg[$2]); }
	|	PCMD fexpr				{						rule("statement", "PCMD fexpr", 0, NULL); printf("ANS> %g\n", $2); }
	|	PCMD iexpr				{						rule("statement", "PCMD iexpr", 0, NULL); printf("ANS> %d\n", $2);}
	|	FREG '=' fexpr	 		{	freg[$1] = $3; 	rule("statement", "FREG '=' fexpr", 0, NULL); }
	|	FREG '=' iexpr	 		{	freg[$1] = $3; 	rule("statement", "FREG '=' iexpr", 0, NULL); }
	|	IREG '=' fexpr	 		{	ireg[$1] = $3; 	rule("statement", "IREG '=' fexpr", 0, NULL); }
	|	IREG '=' iexpr	 		{	ireg[$1] = $3; 	rule("statement", "IREG '=' iexpr", 0, NULL); }
	|	fexpr						{						rule("statement", "fexpr", 0, NULL); }
	|	iexpr						{						rule("statement", "iexpr", 0, NULL); }
	;

fexpr:
		fexpr '+' fterm			{	$$ = $1 + $3;		rule("fexpr", "fexpr '+' fterm", 1, &$$); }
	|	fexpr '+' iterm			{	$$ = $1 + $3;		rule("fexpr", "fexpr '+' iterm", 1, &$$); }
	|	iexpr '+' fterm			{	$$ = $1 + $3;		rule("fexpr", "iexpr '+' fterm", 1, &$$); }
	|	fexpr '-' fterm			{	$$ = $1 - $3;		rule("fexpr", "fexpr '-' fterm", 1, &$$); }
	|	fexpr '-' iterm			{	$$ = $1 - $3;		rule("fexpr", "fexpr '-' iterm", 1, &$$); }
	|	iexpr '-' fterm			{	$$ = $1 - $3;		rule("fexpr", "iexpr '-' fterm", 1, &$$); }
	|	fterm						{	$$ = $1;			rule("fexpr", "fterm", 1, &$$); }
	;
	
iexpr:
		iexpr '+' iterm			{	$$ = $1 + $3;		rule("iexpr", "iexpr '+' iterm", 0, &$$); }
	|	iexpr '-' iterm			{	$$ = $1 - $3;		rule("iexpr", "iexpr '-' iterm", 0, &$$); }
	|	iterm						{	$$ = $1;			rule("iexpr", "iterm", 0, &$$); }
	;
	
fterm:
		iterm ENOT ifactor			{	$$ = $1 * pow(10.0,$3);		rule("fterm", "iterm ENOT ifactor", 1, &$$); }
	|	iterm ENOT ffactor			{	$$ = $1 * pow(10.0,$3);		rule("fterm", "iterm ENOT ffactor", 1, &$$); }
	|	fterm ENOT ifactor			{	$$ = $1 * pow(10.0,$3);		rule("fterm", "fterm ENOT ifactor", 1, &$$); }
	|	fterm ENOT ffactor			{	$$ = $1 * pow(10.0,$3);		rule("fterm", "fterm ENOT ffactor", 1, &$$); }
	|	fterm '*' ffactor			{	$$ = $1 * $3;		rule("fterm", "fterm '*' ffactor", 1, &$$); }
	|	fterm '*' ifactor			{	$$ = $1 * $3;		rule("fterm", "fterm '*' ifactor", 1, &$$); }
	|	iterm '*' ffactor			{	$$ = $1 * $3;		rule("fterm", "iterm '*' ffactor", 1, &$$); }
	|	fterm '/' ffactor			{	$$ = $1 / $3;		rule("fterm", "fterm '/' ffactor", 1, &$$); }
	|	fterm '/' ifactor			{	$$ = $1 / $3;		rule("fterm", "fterm '/' ifactor", 1, &$$); }
	|	iterm '/' ffactor			{	$$ = $1 / $3;		rule("fterm", "iterm '/' ffactor", 1, &$$); }
	|	ffactor					{	$$ = $1; 			rule("fterm", "ffactor", 1, &$$); }
	;
	
iterm:
		iterm '*' ifactor			{	$$ = $1 * $3;		rule("iterm", "iterm '*' ifactor", 0, &$$); }
	|	iterm '/' ifactor			{	$$ = $1 / $3;		rule("iterm", "iterm '/' ifactor", 0, &$$); }
	|	ifactor					{	$$ = $1;			rule("iterm", "ifactor", 0, &$$); }
	;

ffactor:
		fvalue '^' ffactor		{	$$ = pow($1,$3);	rule("ffactor", "fvalue '^' ffactor", 1, &$$); }
	|	fvalue '^' ifactor		{	$$ = pow($1,$3);	rule("ffactor", "fvalue '^' ifactor", 1, &$$); }
	|	ivalue '^' ffactor		{	$$ = pow($1,$3);	rule("ffactor", "ivalue '^' ffactor", 1, &$$); }
	|	ivalue '^' ifactor		{	$$ = pow($1,$3);	rule("ffactor", "ivalue '^' ifactor", 1, &$$); }
	|	fvalue						{	$$ = $1;			rule("ffactor", "fvalue", 1, &$$); }
	;
	
ifactor:
		ivalue						{	$$ = $1;			rule("ifactor", "ivalue", 0, &$$); }
	;
	
fvalue: 
		'+' fvalue					{	$$ = $2;			rule("fvalue", "+fvalue", 1, &$$); }
	|	'-' fvalue					{	$$ = 0.0 - $2;		rule("fvalue", "-fvalue", 1, &$$); }
	|	FNUM						{	$$ = $1;			rule("fvalue", "FNUM", 1, &$$); }
	|   FREG						{	$$ = freg[$1];		rule("fvalue", "FREG", 1, &$$); }
	|	'(' fexpr ')'				{	$$ = $2;			rule("fvalue", "'(' fexpr ')'", 1, &$$); }
	;

ivalue: 
		'+' ivalue					{	$$ = $2;			rule("ivalue", "+ivalue", 0, &$$); }
	|	'-' ivalue					{	$$ = 0 - $2;		rule("ivalue", "-ivalue", 0, &$$); }
	|	INUM						{	$$ = $1;			rule("ivalue", "INUM", 0, &$$); }
	|	IREG						{	$$ = ireg[$1];		rule("ivalue", "IREG", 0, &$$); }
	|	'(' iexpr ')'				{	$$ = $2;			rule("ivalue", "'(' iexpr ')'", 0, &$$);}
	;
	
%%

void rule(char *lhs, char *rhs, int type, void *val)
{
	if (verbose)
	{
		if (val) // Make sure a value is included 
			switch(type)
			{
				case 0:	printf("%40s => %s (%i)\n", lhs, rhs, *((int*)val)); break;
				case 1:	printf("%40s => %s (%f)\n", lhs, rhs, *((float*)val)); break;
			}
		else     // print out only the rule 
			printf("%40s => %s\n", lhs, rhs);
	}
}

int endProgram(void)
{
	printf("Press ENTER to exit:");
	fgetc(stdin);
	return 0;
}

