#include <stdio.h>

int main()
{
    char* string = (char*) malloc (5*sizeof(char));
    strcpy(string, "Fred");
    string[2] = 'a';

    printf("%s\n", string);

    return 0;
}
