#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//Function call for printing the help menu
void PrintInfo();

//Function that will take a pointer to the string containing the input key, sanitize the
//key and return a pointer to a dynamically allocated 
char* LoadKey(char* inputKey);

int main(int argc, char* argv[])
{
    //Declare and initialize local variables
    int i;
    int charsFromUpper = 'a' - 'A';
    int currentKeyIndex = 0;
    int totalInputChars = 0;
    int totalInputLines = 0;
    int totalInputUpper = 0;
    int totalInputLower = 0;
    int totalInputNumbers = 0;
    int totalInputSpaces = 0;
    int totalInputOther = 0;
    int totalOutputLines = 0;
    int outputCharCount = 0;
    char* inputFileName;
    char* outputFileName;
    char* cipherKey;
    char* mode;
    char* defaultOutput = "CONSOLE";
    char* encrypt = "ENCRYPT";
    char* decrypt = "DECRYPT";
    FILE* inFile;
    FILE* outFile;
    
    if (argc > 5)
    {
        //Too many parameters were passed to the program
        printf("ERROR: AN INCORRECT NUMBER OF PARAMETERS WERE SPECIFIED\n\n");
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
        printf("ERROR: YOU MUST ENTER AN INPUT FILE (USE /? FOR HELP)\n");
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

    if (argc > 3)
    {
        //Function call to determine the cipher key to be used
        cipherKey = LoadKey(argv[3]);
    }
    //We do not have a third parameter, so we should pass a NULL to the LoadKey function
    else
    {
        cipherKey = LoadKey(NULL);
    }

    if (argc > 4 && (!strcmp(argv[4], "d") || !strcmp(argv[4], "D") || !strcmp(argv[4], "DECRYPT") || !strcmp(argv[4], "decrypt") || !strcmp(argv[4], "Decrypt")))
    {
        mode = decrypt;
    }
    //We do not have a fourth parameter, or the parameter passed was not for decryption
    else
    {
        mode = encrypt;   
    }
        
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
        
    printf("\nThe following parameters will be used:\n");
    printf("INPUT FILE:\t%s\n", inputFileName);
    printf("OUTPUT FILE:\t%s\n", outputFileName);
    printf("CIPHER KEY:\t%s\n", cipherKey);
    printf("MODE:\t\t%s\n", mode);

    //This is the character to be used for input file processing
    char temp = fgetc(inFile);
    
    while(temp != EOF)
    {        
        if ((('a' <= temp) && ('z' >= temp)) || (('A' <= temp) && ('Z' >= temp)))
        {
            if (('a' <= temp) && ('z' >= temp))
            {
                temp = temp - charsFromUpper;
                totalInputLower++;                 
            }
            else
            {
                totalInputUpper++;
            }
            
            if (mode == encrypt)
            {
                temp = (((temp - 'A') + (cipherKey[currentKeyIndex] - 'A')) % 26) + 'A';
                currentKeyIndex = (currentKeyIndex + 1)%strlen(cipherKey);
            }
            else if (mode == decrypt)
            {
                temp = ((26 + ((temp - 'A') - (cipherKey[currentKeyIndex] - 'A'))) % 26) + 'A';
                currentKeyIndex = (currentKeyIndex + 1)%strlen(cipherKey);
            }
            
            if (outputFileName == defaultOutput)
            {
                 printf("%c", temp);
            }
            else
            {
                fprintf(outFile, "%c", temp);
            }
            
            totalInputChars++;
            outputCharCount++;
            //We want to output characters in groups of 5 characters
            if (outputCharCount == 5)
            {
                if (outputFileName == defaultOutput)
                {
                    printf("\n");
                }
                else
                {
                    fprintf(outFile, "\n");
                }
                outputCharCount = 0;
                totalOutputLines++;
            }
        }
        else if (temp == '\n')
        {
            totalInputLines++;
        }
        else if (temp == ' ')
        {
            totalInputChars++;             
            totalInputSpaces++;
        }
        else if (('0' <= temp) && ('9' >= temp))
        {
            totalInputNumbers++;
        }
        else
        {
            totalInputChars++;
            totalInputOther++;
        }
        
        temp = fgetc(inFile);
    }
    totalInputLines++;
    totalOutputLines++;
    
    printf("\nInput File \"%s\" Statistics\n", inputFileName);
    printf("Total Characters:\t\t%i\n", totalInputChars);
    printf("Total Lines:\t\t\t%i\n", totalInputLines);
    printf("Total Letters:\t\t\t%i\n", totalInputUpper + totalInputLower);
    printf("Total Uppercase Letters:\t%i\n", totalInputUpper);
    printf("Total Lowercase Letters:\t%i\n", totalInputLower);    
    printf("Total Numbers:\t\t\t%i\n", totalInputNumbers);    
    printf("Total Whitespace Characters:\t%i\n", totalInputSpaces);
    printf("Total Other Characters:\t\t%i\n", totalInputOther);
    
    printf("\nOuput File \"%s\" Statistics\n", outputFileName);
    printf("Total Characters:\t\t%i\n", totalInputUpper + totalInputLower);
    printf("Total Lines:\t\t\t%i\n", totalOutputLines);
    printf("Total Letters:\t\t\t%i\n", totalInputUpper + totalInputLower);
    printf("Total Uppercase Letters:\t%i\n", totalInputUpper + totalInputLower);
    printf("Total Lowercase Letters:\t%i\n", 0);    
    printf("Total Numbers:\t\t\t%i\n", 0);    
    printf("Total Whitespace Characters:\t%i\n", 0);
    printf("Total Other Characters:\t\t%i\n", 0);
    
    free(cipherKey);

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
     
     return finalKey;
}
