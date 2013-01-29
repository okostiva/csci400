//CSCI 400
//Class notes 01/29/2013
//
//
/*	
    FINITE AUTOMATA
    
                    x; =; 3.157 are all lexemes
                    3.157; 1.43 are floating point tokens (FNUM)
                    
    SOURCE CODE <-- Source Code is a Regular Language
         |          x=3.157*(1.43+y) //COMMENT
         |          z+=x*-y
         |
         V
       LEXER  (Lexical Analyzer - Performs lexical analysis)
         |
         |
         V
    TOKEN STREAM   (id attributes~values)
         |         id x
         |         assign
         |         fnum 3.157
         |         mulp
         |         oparen
         |         fnum 1.43
         |         add
         |         id y
         |         cparen
         |         semi
         |
         V
      PARSER (Syntax analyzer)
         |
         |
         V
    PARSE TREE
         |
         |
         V
   CODE GENERATOR
         |
         |
         V
     EXECUTABLE
    
    
    Lexical Analysis
            - Lexon is the symbol used for communication
            - In the source code we have "characters" from an "alphabet" (ASCII)
            - Identifies groups of letters ("lexeme") that together have meaning
            
    Token Stream
            - Typically the comments are not tokenized
            - A token stream has context free grammar
                   - Every language that has context free grammar is a push down automaton
            
    Parser 
           - Analyzes the token stream
           
    Finite State Machine
           - A FSM can "recogonize" "sentences" is a regular language
                   -3.14E+31 (is a valid "sentence")
                   -3.14E*31
           - An entire program when talking about finite automata is a "sentence"
           - A lexical analyzer is a finite state machine
           
    Regular Language
           - Every regular language is a combination of finite automatons 
    
    Defining a language
           - Our language consits of "a b c"
                 aabaacaacaab is a valid sentence
                 
           - (aab|aac)+ is the rule for validating our language    
           - 3 letter groups
           - At least 1 group, but as many as we like
           - Every group must contain aab or aac
           
                                           START
(We have seen the leading a)  a |-->     a   |  (s1)  <--| a   
(We have seen the second a)     |        a   |  (s2)     |
                                |   -------------------  |
                                |   |                 |  | 
(The final character is a b)  b <---| ((s3))   ((s4)) |---> c (The final character was a C)

If the next character is an 'a' we should go back to s1 from s3 or s4
Even though there would be a final state s5 where all invalid inputs would fall, convention says to not draw it
 
                                               START
(We have seen the leading a)          a |--> a   |  (s1) 
(We have seen the second a)             |    a   |  (s2) 
(The final character is a b or c)  b,c <---------| ((s3))
      
                        |---------------->  ((START)) <--|  *   (Anything else takes us back to the starting state)
                        |                        |       |
                        |                  |-------------|      
                        |              '/' |  (s1)       |  *   (Anything else takes us back to the starting state)
                        |           |-------------|------|    
                        |           |             |  
                        |    '/' <--|  ((s2)) '*' |--> (s3) <--| *
                        |           |             |------------|
                        |-----------| '/n' '*' <--|            | *
                        |                         |------------|
                        --------------------------| '/'
                                                  
            
*/
