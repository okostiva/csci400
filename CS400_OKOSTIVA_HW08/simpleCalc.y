%{
int floatCount = 0;
double lastValue = 0.0;
char lastRegister[3] = {0};
int R0 = 0;
int R1 = 0;
int R2 = 0;
int R3 = 0;
int R4 = 0;
double R5 = 0.0;
double R6 = 0.0;
double R7 = 0.0;
double R8 = 0.0;
double R9 = 0.0;
void updateRegister(char* registerName, double value);
void returnValue(char* registerName, double value);
void endProgram();
void endStatement();
int getInt(char* registerName);
double getFloat(char* registerName);
%}
%union {
     float fval;
	 int ival;
	 char *sval;
}

%token <sval> REGISTER
%token <ival> NUMBER
%token <fval> FNUMBER	 
%token NEWLINE

%type <fval> expression
%type <fval> term
%type <fval> factor

%%
program: statement 					{ endStatement(); }
	|	open_brace statements close_brace	{ endProgram(); }
	;

open_brace: '{'
	;
	
close_brace: '}'
	;
	
statements: statement statements
	|	statement
	;
	
statement:	REGISTER '=' expression ';' {  printf("REDUCE: <statement> -> REGISTER (%s) = <expression>\n", $1); updateRegister($1, $3); }
	|	expression ';'				{ lastValue = $1; }
	;

expression:	expression '+' term   { printf("REDUCE: <expression> -> <expression> + <term> (%f)\n", $3); $$ = $1 + $3; }
	|	expression '-' term       { printf("REDUCE: <expression> -> <expression> - <term> (%f)\n", $3); $$ = $1 - $3; }
	|	term                      { printf("REDUCE: <expression> -> <term> (%f)\n", $1); $$ = $1; }
	;

term:	term '*' factor	{ printf("REDUCE: <term> -> <term> (%f) * <factor> (%f)\n", $1, $3); $$ = $1 * $3; }
	|	term '/' factor	{ printf("REDUCE: <term> -> <term> (%f) / <factor> (%f)\n", $1, $3); $$ = $1 / $3; }
	|	factor			{ $$ = $1; }
	;

factor:	'(' expression ')'	{ $$ = ($2); }
	|	NUMBER			{ $$ = $1; }
	|	FNUMBER			{ $$ = $1; floatCount++; }
	|   REGISTER		{ $$ = ($1[1] > '4') ? getFloat($1): getInt($1); }
	;

%%

void endProgram()
{
	printf("\nRegister Contents\n");
	printf("R0\t%d\n", R0);
	printf("R1\t%d\n", R1);
	printf("R2\t%d\n", R2);
	printf("R3\t%d\n", R3);
	printf("R4\t%d\n", R4);
	printf("R5\t%f\n", R5);
	printf("R6\t%f\n", R6);
	printf("R7\t%f\n", R7);
	printf("R8\t%f\n", R8);
	printf("R9\t%f\n", R9);

	exit(0);
}

void endStatement()
{
     
	(lastRegister[0] != '\0') ? printf("\n%s = ", lastRegister) : printf("\nExpression result = ");
    
	if (floatCount > 0)
	{
		printf("%f\n", lastValue);
	}
	else
	{
        int outputValue = lastValue;
		printf("%d\n", outputValue);
    }
	exit(0);
}


void updateRegister(char* registerName, double value)
{
	switch (registerName[1])
	{
		case '0':
			R0 = value;
			break;
		case '1':
			R1 = value;
			break;
		case '2':
			R2 = value;
			break;
		case '3':
			R3 = value;
			break;
		case '4':
			R4 = value;
			break;
		case '5':
			R5 = value;
			break;
		case '6':
			R6 = value;
			break;
		case '7':
			R7 = value;
			break;
		case '8':
			R8 = value;
			break;
		case '9':
			R9 = value;
			break;
	}
	
	strcpy(lastRegister, registerName);
	lastValue = value;
}

int getInt(char* registerName)
{
    switch (registerName[1])
	{
		case '0':
			return R0;
		case '1':
			return R1;
		case '2':
			return R2;
		case '3':
			return R3;
		case '4':
			return R4;
	}
	return 0;
}

double getFloat(char* registerName)
{
    switch (registerName[1])
	{
		case '5':
			return R5;
		case '6':
			return R6;
		case '7':
			return R7;
		case '8':
			return R8;
		case '9':
			return R9;
	}
	return 0.0;
}
