#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//Function call for printing the help menu
void PrintInfo();

//Funciton for loading the encryption key
char* LoadKey(char* inputKey);

int main(int argc, char* argv[])
{
    //Declare and initialize local variables
    int i;
    char* inputFileName;
    char* outputFileName;
    char* cipherKey;
    char* mode;
    char* defaultOutput = "CONSOLE";
    char* encrypt = "ENCRYPT";
    char* decrypt = "DECRYPT";
    FILE* inFile;
    FILE* outFile;
    
    for (i=0; i<argc; i++)
    {
        if (i == 0)
        {
            printf("Command: ");
        }
        else
        {
            printf("Parameter %i: ", i);
        }
        printf("%s\n", argv[i]);
    }
    
    if (argc > 5)
    {
        //Too many parameters were passed to the program
        printf("ERROR: AN INCORRECT NUMBER OF PARAMETERS WERE SPECIFIED\n");
        PrintInfo();
        exit(1);
    }
    
    // We expect the following parameters
    // argv[1] = INPUT FILE
    // argv[2] = OUTPUT FILE
    // argv[3] = CIPHER KEY
    // argv[4] = MODE
    
    //We have at least the input file name
    if (argc > 1)
    {
        //
        if (!strcmp(argv[1], "/?") || !strcmp(argv[1], "/help") || !strcmp(argv[1], "--help"))
        {                   
            PrintInfo();
            exit(2);
        }
        else
        {
            inputFileName = argv[1];
            
            //We are opening the input file for reading
            inFile = fopen(inputFileName, "r");
            if (!inFile)
            {
                printf("ERROR: COULD NOT OPEN INPUT FILE \"%s\"\n", inputFileName);
                exit(1);
            }
        }
    }
    //No parameters were passed to the program, only the program name (which is always the first parameter)
    else
    {
        printf("ERROR: YOU MUST ENTER AN INPUT FILE\n");
        exit(1);
    }
    
    if (argc > 2)
    {
        outputFileName = argv[2];
                     
        //We are opening the output file for writing
        outFile = fopen(outputFileName, "w");
        if (!outFile)
        {
            printf("ERROR: COULD NOT OPEN THE OUTPUT FILE \"%s\"\n", outputFileName);
            exit(1);
        }
    }
    //We do not have a second parameter, so we should write to the console
    else
    {
        outputFileName = defaultOutput;
    }

    cipherKey = LoadKey(argv[3]);

    if (argc > 4 && (!strcmp(argv[4], "d") || !strcmp(argv[4], "D") || !strcmp(argv[4], "DECRYPT") || !strcmp(argv[4], "decrypt") || !strcmp(argv[4], "Decrypt")))
    {
        mode = decrypt;
    }
    else
    {
        mode = encrypt;   
    }
        
    printf("\nThe following parameters will be used:\n");
    printf("INPUT FILE:\t%s\n", inputFileName);
    printf("OUTPUT FILE:\t%s\n", outputFileName);
    printf("CIPHER KEY:\t%s\n", cipherKey);
    printf("MODE:\t\t%s\n", mode);

    fclose(inFile);
    fclose(outFile);
    
    free(inFile);
    free(outFile);
    free(inputFileName);
    free(outputFileName);
    free(cipherKey);
    free(mode);

    system("pause");
	return 0;
}

//Function call for printing the help menu
void PrintInfo()
{
     printf("USAGE:\tCS400_OKOSTIVA_HW01.exe PARAM PARAM1 PARAM2 PARAM3\n");
     printf("PARAM :\tINPUT FILE *Required*\n");
     printf("PARAM1:\tOUTPUT FILE *Default is print results to screen*\n");
     printf("PARAM2:\tCIPHER KEY *Default is \"Colorado School of Mines\"*\n");
     printf("PARAM3:\tMODE (ENCRYPT or DECRYPT) *Default is ENCRYPT*\n");
}

//Function that will take a pointer to the string containing the input key, sanitize the
//key and return a pointer to a dynamically allocated 
char* LoadKey(char* inputKey)
{
     //Declare and initialize local variables
     char* tempKey;
     char* finalKey;
     char defaultKey[] = "Colorado School of Mines";
     int charsFromUpper = 'a' - 'A';
     int totalChars = 1;
     int charCount = 0;
     int i;
          
     //The user did not specify an input key to use, so we will need to use the default
     if (inputKey != NULL)
     {
         tempKey = inputKey;
     }
     else
     {
         tempKey = defaultKey;   
     }
     
     //In this for loop, we will convert all valid characters to upper case and count the total 
     //number of characters in the key so that we know how much memory to allocate
     for (i=0; i<strlen(tempKey); i++)
     {
         //If this is a lower case character, covert it to upper case and increment the counter
         if (('a' <= tempKey[i]) && (tempKey[i] <= 'z'))
         {
             tempKey[i] = tempKey[i] - charsFromUpper;
             totalChars++;
         }
         //If this is an upper case character increment the count only
         else if (('A' <= tempKey[i]) && (tempKey[i] <= 'Z'))
         {
             totalChars++;
         }
     }
     
     //Check to make sure that we can allocate the memory needed
     finalKey = (char*)malloc(totalChars*sizeof(char));
     if (!finalKey)
     {
         printf("ERROR: COULD NOT ALLOCATE MEMORY FOR THE FINAL CIPHER TEXT\n");
         exit(1);
     }
     
     //Now we actually need to copy over all of the values in the key so that we can return it 
     //to the calling function in the correct format
     for (i=0; i<strlen(tempKey); i++)
     {
         //If this is an upper case character store the character in the final key
         if (('A' <= tempKey[i]) && (tempKey[i] <= 'Z'))
         {
             finalKey[charCount] = tempKey[i];
             charCount++;
         }
     }
     finalKey[charCount] = '\0';
     
     free(tempKey);
     return finalKey;
}
