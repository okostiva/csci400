//CSCI 400
//Class notes 01/22/2013
//
//
/*	
   
*/

int main(void)
{
    p = NULL;
    bufsize = 0;
    
    //realloc will simply extend the block of currently allocated memory
    //if possible, and if not, allocate a new block that is large enough, 
    //copy the contents and release the original buffer rather than using 
    //malloc where the memory must be freed and then allocated again
    p = (char*)realloc(p, bufsize*sizeof(char));
    if (!p)
       return NULL;
       
    malloc(strlen(yytext)+1);
    strcopy(temp, yytext);
    temp = srtdup(yytext);
}
