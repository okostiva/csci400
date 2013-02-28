//CSCI 400
//Class notes 02/28/2013
//
//
/*	
   The Front End (from Engineering a Compiler)
   
   PARSER
      - Checks stream of classified words (parts of speech) for grammatical correctness
      - Determines if code is syntactically well-formed
      - Guides checking at deeper levels than syntax
      - Builds an IR representation of the code
      - Parsing is harder than scanning. Better to put more rules in scanner
      
   The Big Picture
      - Language syntax is specified with parts of speech, not words
      - Syntax checking matches parts of speech against a grammar
      
   Why Study Lexical Analysis?
      - We want to avoid writing scanners by hand
      - Finite automata are used in other applicatoins: grep, website filtering, various "find" commands
      - Goals:
         - To simplifiy specification and implementation of scanners
         - To understand the underlying techniques and technologies
         
   FINITE AUTOMATA
*/
