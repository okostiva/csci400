//CSCI 400
//Class notes 01/17/2013
//
//
/*	
	The design of IMPERATIVE LANGUAGES is based directly on the von Neumann architecture
		- Efficiency is the primary concern, rather than the suitability of the language for software development
	The design of the FUNCTIONAL LANGUAGES is based on mathematical functions
		- A solid thoretical basis that is also closer to the user, but relatively unconcerted with the architecture of the machines on which programs will run

	Case for functional programming languages:
		- More readable, more reliable and more likely to be correct 
		- Meaning of expressions are independent of their context (no side effects)

	Objective of a functional programming language:
		- Mimic mathematical functions to the greatest extent possible
		- Variables are not necessary (as is the case in mathematics)
	The basic process of computation is fundamentally different in a function programming languages than in an imperative language
		- Operations are done and stored in variables for later user in imperative languages
		- Management of variables is a constant concern (and source of complexity) for imperative lanuages

	y(x) = sin(3x^3 + cos(1 - log(2x))) + 9

	REFERENTIAL TRANSPARENCY: 
		- The evaluation of a function always produces the same results give the same parameters
		- The expression can be replaced with its result without chaning the meaning of the program
		- Semantics are therefore simpler

	z(x) = 2x
	y(x) = z(1+x) + 3

	Mathematical Functions:
		- Massping of memeers of one set, called the domain set, to another set, the range set
		- Mapping is described as an expression or a table
		- Evaluation order is controlled by recursion and conditional expressions (not sequencing and iteration)
		- Defines a value rather than a sequence of operations (no variables; no side-effects)

	Lambda Expression: 
		- Specifieds the parameters(s) and the mapping of a function in the following form lambda(x) x*x*x for the function cube (x) = x*x*x
		- Describes a nameless function
		- Applied to parameter(s) by placing the parameter(s) after the expression (lambda(x) x*x*x) (2) = 8
		- May have more than one parameter

	FUNCTIONAL FORMS
		- Takes functions as a parameter or
		- Yields a function as a result or
		- Both
		(Derivatives in calculus are an example)  d/dx(f(x)) = g(x)

		Form:		h = f o g
		Result:		h(x) = f(g(x))
		Example:	f(x) = x+2
					g(x) = 3x
		Result:		h(x) = f o g = (3x) + 2

		APPLY-TO-ALL: 
		Example:	h(x) = x*x
					alpha(h, (2,3,4)) 
		Result:		(4,9,16)

	LISP Data Types and Structures
		- Originally a typeless language
		- Originally only atoms and lists
			- Atoms are either symbols or numbers
			- Lists are collections or subsets of atoms

		Lists:
			- `(A B (C D) E) (Single quote so list is not evaluated)
			- `(1 2 3) (No commas)
			- (+ 3 5) (Addition)
			- Stored internally as linked-lists (each element of the linked-list is CONS CELL)

	Scheme Interpreter:
		- Parameters are evaluated in no particular order
		- Values are substituted into the function body
		- Function body is evaluated
		- Value of the last expression in the body is the value of the function

	Function Definitions:
		((lambda (x) (* x x)) 7) 
		- x is a bound variable
*/
