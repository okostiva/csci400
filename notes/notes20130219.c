//CSCI 400
//Class notes 02/19/2013
//
//
/*	
   
   A = B+C*D
       <EXPR>
   
         LANGUAGE 1
   <EXPR> --> <EXPR>+<EXPR>
   <EXPR> --> <EXPR>*<EXPR>
   <EXPR> --> (<EXPR>)
   <EXPR> --> <VAR>
   
   <VAR> --> A|B|C|D|E|F
   
   
         LANGUAGE 2
   <EXPR> --> <EXPR>+<TERM>
   <EXPR> --> <TERM>
   <TERM> --> <TERM>*<FACTOR>
   <TERM> --> <FACTOR>
 <FACTOR> --> (<EXPR>)
 <FACTOR> --> <VAR>
   
   <VAR> --> A|B|C|D|E|F      
   
   
   S = cdbffabbabac
         <EXPR>
   
         LANGUAGE 3
   S --> BcA | CC | ABc    (a | f) | (b | e) | (c | d)
   A --> cA  | dC          (c) | (d)
   B --> aC  | Da          (a) | (f)
   C --> b   | eA          (b) | (e)
   D --> fBC               (f)
   
   LEFTMOST DERIVATION
      - Always replace the left most non-terminal with it's derivation
      
         USING LANGUAGE 1
      
      <EXPR> --> <EXPR> + <EXPR>
             --> <VAR> + <EXPR>
             --> B + <EXPR>
             --> B + <EXPR> * <EXPR>
             --> B + <VAR> * <EXPR>
             --> B + C * <EXPR>
             --> B + C * <VAR>
             --> B + C * D
             
      - Tree view does not accurately represent the derivation even though the 
        tree was derived from the derivation
         - Any number of derivations could have resulted in the same tree
                   
             
             <EXPR>
               |
               |
         ______|_______
        |      |       |
        |      |       |
        V      V       V
     <EXPR>    +     <EXPR>
       |               |
       |               |
       V          _____|_____
     <VAR>       |     |     |
       |         |     |     |
       |         V     V     V
       V       <EXPR>  *   <EXPR>
       B         |           |
                 |           |
                 V           V
               <VAR>       <VAR>
                 |           |
                 |           |
                 V           V
                 C           D
   
   
      <EXPR> --> <EXPR> * <EXPR>
             --> <EXPR> + <EXPR> * <EXPR>
             --> <VAR> + <EXPR> * <EXPR>
             --> B + <EXPR> * <EXPR>
             --> B + <VAR> * <EXPR>
             --> B + C * <EXPR>
             --> B + C * <VAR>
             --> B + C * D
             
             
              <EXPR>
                |
                |
          ______|_______
         |      |       |
         |      |       |
         V      V       V
      <EXPR>    *     <EXPR>
         |              |
         |              |
    _____|_____         V
   |     |     |      <VAR>
   |     |     |        |
   V     V     V        |
 <EXPR>  *   <EXPR>     V
   |           |        D
   |           |
   V           V
 <VAR>       <VAR>
   |           |
   |           |
   V           V
   B           C  
   
         USING LANGUAGE 2

      <EXPR> --> <EXPR> + <TERM>
             --> <TERM> + <TERM>
             --> <FACTOR> + <TERM>
             --> <VAR> + <TERM>
             --> B + <TERM>
             --> B + <TERM> * <FACTOR>
             --> B + <FACTOR> * <FACTOR>
             --> B + <VAR> * <FACTOR>
             --> B + C * <FACTOR>
             --> B + C * <VAR>
             --> B + C * D
             
             
             <EXPR>
               |
               |
         ______|_______
        |      |       |
        |      |       |
        V      V       V
     <EXPR>    +     <TERM>
       |               |
       |               |
       V          _____|_____
     <TERM>      |     |     |
       |         |     |     |
       |         V     V     V
       V       <TERM>  *  <FACTOR>
    <FACTOR>     |           |
       |         |           |
       |         V           V
       V      <FACTOR>     <VAR>
     <VAR>       |           |
       |         |           |
       |         V           V
       V       <VAR>         D
       B         |           
                 |           
                 V
                 C 
             
   AMBIGUITY
      - Two different derivations of the same type (leftmost derivations) result
        in different parse trees
      - The example above is ambiguous
      - In general, ambiguous languages are bad things
   
   PRECEDENCE
      - Guaranteed in a unambiguous language
      
   ASSOCIATIVITY
      - Always move from left to right on equal precedence objects 
         - Parens are required for any other desired operations
      
   PAIRWISE DISJOINT
      - Take any pair and they do not have any terminals in common
      - This is required in a context free grammar for recursive descent to work
         - This is only required for a given production
      
   RECURSIVE DESCENT
   
               USING LANGUAGE 3
                 cdbffabbabac
                 
           ____a____b____c____d____e____f____
      S|  BcA   CC   ABc  ABc  CC   BcA
      A|  -     -    cA   dC   -    -
      B|  aC    -    -    -    -    Da
      C|  -     b    -    -    eA   -
      D|  -     -    -    -    -    fBC
      
      S --> ABc 
        --> cABc                 
        --> cdCBc
        --> cdbBc
        --> cdbDac
        --> cdbfBCac
        --> cdbfDaCac
        --> cdbffBCaCac
        --> cdbffaCCaCac
        --> cdbffabCaCac
        --> cdbffabbaCac
        --> cdbffabbabac
        
   BOTTOM-UP PARSING
   
*/
