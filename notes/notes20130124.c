//CSCI 400
//Class notes 01/24/2013
//
//
/*	
  LISP lists are stored internally as single-linked lists
  
  --> A --> B --> C --> D --> NULL (ABCD)
  
  List Interpretation:
       -Lambda notation is used to specify functions and function definitions.
             -If the list (A B C) is interpreted as data it is a simple list of three atoms A, B and C
             -If it is interpreted as a function application, it means that the function named A is applied to the parameters B and C
       -Functions are first-class entities
             -The can be the values of expressens and elements of a list
             -They can be assigned to variables and passed as parameters
              
Intro to Scheme
      -Language Pack: Swindle
      
      -Interpreter is read-evaluate-write infinite loop
      -Expressions evaluated by EVAL function
            -Parameters are evaluated, in no particular order (literals EVAL to themselves)
            -The values of the parameters are substituted into the function body
            -The function body is evaluated
            -The value of the last express in the body is the of the function
            
      //Do NOT do this!!!
      (sin (3 * 5))
      //REMEMBER WE HAVE TO USE PREFIX NOTATION HERE
      (sin (* 3 5))
      
      -A Racket program is a collection of funciton definitions
      -Pure Form: Lambda Expressions

      -A function for Constructing Function DEFINE - two forms:
            1) To bind a symbol to an expression (a constant)
                  (define pi 3.14159)
                  (* pi 5 5)
            2) To bind names to lambda expressions
                  (define (square x) (* x x))
                  (square 5)
                  
      Names are case-sensitive, including letters, digits and special characters
      
      *This are important built in functions!
      (car '(a b c)) -> a  <->  (first '(a b c)) -> a
      (cdr '(a b c)) -> (b c) <-> (rest '(a b c)) -> (b c)
      
      cons (atom list)
      cons (list list)
           -Result is a new list that includes the first parameter as its first element and the second part as the remainder
           -Applying CONS on two atoms results in a dotted list (cell with to atoms, no pointer)
           
      (cons 'A '(B C)) returns (A B C)
      (cons 'A 'B) returns (A . B)
      (cons '(A B) '(C D)) returns ((A B) C D)
      
      list takes any number of parameters; returns a list with the parameters as elements
      
      (list 'A '(B C)) returns (A (B C))
      (list '(A B) '(B C)) returns ((A B) (B C))
   
      append (list list)
             -Result is a new list containing the elements of the first parameter followed by the elements of the second paramter
                     -Both must be lists!
      
      (append '((A B) C) '(D (E F))) returns ((A B) C D (E F)) 
      
      -list? takes one parameter; it returns #T if the parameter is a list; otherwise ()
             -list? returns #T for the null list '()

      -null? takes one parameter; it returns #T if the parameter is the empty list; otherwise()
             -Note that null? returns #T if the parameter is()  
      
      CONTROL FLOW:
             -Selection-the special form, IF
                   (if predicate true_exp false_exp)
                   
                   (if (<> count 0) (/ sum count) 0)
                   
      OUTPUT FUNCTIONS:
             -(display expression)
             -(newline)  
*/
