//CSCI 400
//Class notes 02/05/2013
//
//
/*	

VALID TOKENS FOR THE PARSER
    CMT      // /*
    REG      R9
    ASSIGN   =
    OPAREN   (
    CPAREN   )
    MUL      *
    ADD      +
    DIV      /
    SUB      -
    EXP      ^
    SEMI     ;
    FIX      4.39    .2        7.
    INT      37      4
    ENOT     E
    
    4-3       4+(0-3)
    INT 4     INT 4
    SUB       ADD
    INT 3     OPAREN
              SUB
              INT 3
              CPAREN
              
    We will not allow negative numbers!
    
REGULAR EXPRESSIONS
    S = (ab|ac|ad)?    (0 or 1)
    S = (ab|ac|ad)+    (0 or more)
    S = (ab|ac|ad)*    (1 or more)
    
    abacacad
    
    DIGIT  = (0|1|2|3|4|5|6|7|8|9)
           = (0-9)
    ODIGIT = (0-7)
    HDIGIT = (0-9|A-F|a-f)
    INT    = DIGIT+
    FIX    = (DIGIT*).(DIGIT+)|(DIGIT+).(DIGIT*)
    SUBE   = INT-INT
           = INT'-'INT
           
CONTEXT FREE GRAMMARS
    S --> aSa|b
    S =   a^Nba^N
    
    NONTERMINALS
         - Upper case
    TERMINALS
         - Lower case
         
    GENERATION
        We will choose one of the production from the starting state in order to try
        and match a given input string
            - Every nonterminal must be replaced with one of the defined productions
            - As soon as the string no longer contains nonterminals, we are finished
            - If the given string can be derived, then it is valid grammar (syntax) for the current language
    
    aaabaaa
    S --> aSa --> aaSaa --> aaaSaaa --> aaabaaa
    
    
    E = T+T
    T --> F*F|F
    F --> a|b|c
    
    T --> F*F --> a*b
    
    a+b*c    
    E --> T+T --> F+F*F --> a+b*c
    
*/
