%{
double total=0.0;
void updateTotal(double v);
void endProgram(void);
%}
%union {
     float fval;
	 int ival;
	 char *sval;
}

%token <sval> NAME
%token <ival> NUMBER
%token <fval> FNUMBER	 
%token NEWLINE

%type <fval> expression
%type <fval> term
%type <fval> factor

%%
program: statement 					{ exit(0); }
	|	open_brace statements close_brace	{ endProgram(); }
	;

open_brace: '{'
	;
	
close_brace: '}'
	;
	
statements: statement statements
	|	statement 
	;
	
statement:	NAME '=' expression ';' { printf("%s = %f\n", $1, $3); updateTotal($3);}
	|	expression ';'				{ printf("= %f\n", $1); updateTotal($1); }
	;

expression:	expression '+' term   { $$ = $1 + $3; }
	|	expression '-' term       { $$ = $1 - $3; }
	|	term                      { $$ = $1; }
	;

term:	term '*' factor	{ $$ = $1 * $3; }
	|	term '/' factor	{ $$ = $1 / $3; }
	|	factor			{ $$ = $1; }
	;

factor:	'(' expression ')'	{ $$ = ($2); }
	|	NUMBER			{ $$ = $1; }
	|	FNUMBER			{ $$ = $1; }
	;

%%

void endProgram(void)
{
	printf("Your total is: %f, Goodbye!\n", total);
	exit(0);
}

void updateTotal(double v)
{
	total+=v;
}
