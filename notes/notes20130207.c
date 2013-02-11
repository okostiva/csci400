//CSCI 400
//Class notes 02/07/2013
//
//
/*	

   At most 15 sticks in each pile

   1 xxxxxxxxx       1001 --> 0011
   2 xxx             0011 --> 0011
   3 xxxx            0100 --> 0100
   4 xxxxx           0101 --> 0101
   5 x               0001 --> 0001
   
   Parity            1010 --> 0000  
   
   On your turn, take as many sticks as you like from one pile (must take at least one)
   Goal, is to take the last stick to win
   
   Best gameplay theory
        - Every board will have an even or odd number of sticks
        - The winning state has an even number of sticks (0)
        - Given two states an "inner ring" and an "outer ring"
             - If there is no possible way to go from the inner ring to the inner ring the
               optimal solution is to always put the opponent back into the inner ring
               after every turn therefore guaranting that you will always be able to make a
               move to the inner ring (where the winning state is)
             - Winning board has an even parity (all 0s)     
             - If at any time the board has an even parity then it is impossible to return the
               board to an even parity because then an even number of rows would need to change       
               
   Lexical Scope (Scope as written)
   Dynamic Scope (Scope is determined based on calling function at runtime)
    
*/
