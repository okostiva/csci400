//CSCI 400
//Class notes 02/26/2013
//
//
/*	
   BOTTOM-UP PARSING
      - Used by almost every modern parser
      
   REGULAR GRAMMAR
      - Finite automation
      - Collection of STATES and TRANSITION RULES
      - STATE captures relevant information about the past
      - TRANSITION RULE and input tells which STATE to go to
      
   CONTEXT FREE GRAMMAR 
      - Pushdown Automation
      - Collection of STATES, TRANSITION RULES and STACK
      - STATE captures relevant information about the neat past
      - STACK captures relevant information about the far past
      - TRANSITION RULE and input tells which STATE to go to and whether to 
        PUSH/POP anything to/from the STACK
      
   Goal of LR(1) Parser
      - Processes input stream left-to-right one token at a time (based on name)
      - Produces a right-most derivation of the input stream
      - End up in the Stat State at the end of the input stream
      
      
   GRAMMAR
      E  -> E+T
      E  -> T
      T  -> T*F
      T  -> F
      F  -> ( E )
      F  -> id
      
   SENTENCE
      id + id * id
      
   Rightmost Derivation
      - Always expand the right-most non-terminal
      E  -> E + T
         -> E + T * F
         -> E + T * id
         -> E + F * id
         -> E + id * id
         -> F + id * id
         -> id + id * id
         
   Phrase: sub-stree rooted at an internal node
   Simple-Phrase: sub-tree that has only a root and leaf nodes
      - Must be a production rule
   Handle: leftmost simple phrase
   Reduction: replace handle with its roon
   
   TYPES OF TRANSITION RULES
      Shift - Push the next non-terminal onto the stack
      Reduce - Pop the leaves off the stack and push the root onto the stack
      All pushes also push current state second and all pops remove it
   
   S       RHS    id    +     *     (     )     $     E     T     F
   0  |    null   6     -     -     10    -     -     7     2     4
   1  |E   E + T  6     R     9     10    R     R     7     2     4
   2  |E   T      6     R     9     10    R     R     7     2     4
   3  |T   T*F    6     R     R     10    R     R     7     2     4
   4  |T   F      6     R     R     10    R     R     7     2     4
   5  |F   (E)    6     R     R     10    R     R     7     2     4
   6  |F   id     6     R     R     10    R     R     7     2     4
   7  |    E      6     8     -     10    -     A     7     2     4
   8  |    E+     6     -     -     10    -     -     7     1     4
   9  |    T*     6     -     -     10    -     -     7     2     3
   10 |    (      6     -     -     10    -     -     11    2     4
   11 |    (E     6     8     -     10    5     -     7     2     4


   S       RHS    id    +     *     (     )     $     E     T     F
   0  |    null   6     -     -     10    -     -     7     2     4
   1  |E   E + T  6     R     9     -     R     R     7     2     -
   2  |E   T      6     R     9     -     R     R     7     2     -
   3  |T   T*F    6     R     R     -     R     R     7     2     -
   4  |T   F      6     R     R     -     R     R     7     2     -
   5  |F   (E)    6     R     R     -     R     R     7     2     -
   6  |F   id     6     R     R     -     R     R     7     2     -
   7  |    E      6     8     -     -     -     A     7     2     -
   8  |    E+     6     -     -     10    -     -     7     1     4
   9  |    T*     6     -     -     10    -     -     7     2     3
   10 |    (      6     -     -     10    -     -     11    2     4
   11 |    (E     6     8     -     -     5     -     -     -     -
   
   0_____|_____id
         |  +
         |  id
         |  *
         |  id
         |  $
         
   Push the Start State on to the stack
*/
