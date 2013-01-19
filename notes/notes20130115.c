//CSCI 400
//Class notes 01/15/2013
//
//  __________
// |____A_____| bob 1000  <- stack pointer
// |____P_____| bob  
// |____P_____| bob
// |____T_____| bob
// |___...____| bob
// |__null____| bob 1019
// |__________| ptr
// |__________| ptr
// |__________| ptr
// |__________| ptr
// |__________| s		  <- stack pointer after function call to fred
// |__________| s 
// |__________| s
// |__________| s
// |__________| t
// |__________| t
// |__________| t
// |__________| t
// |__________| p
// |__________| p
// |__________| p
// |__________| p
// |__________| i
// |__________| i
// |__________| i
// |__________| i
// |__________| i
//
//  __________
// |__________| After calling malloc() we allocate space on the heap (away from the instruction stack)
// |__________|
// |__________|
// |__________|
//
// Do not return pointers to local variables!!!
// 
// As soon as the variables go out of scope, the memory is free to be overwritten
// and at any point the value stored at the memory location refereneced by the pointer
// may change
//
//

char *fred(char *s, char t[])
{
	char *p;
	//char p[256];
	int i;

	// This will work only because 20 bytes were allocated to bob initially
	// so APPT ON TUESDAY will fit in the allocated space
	// If there was less memeory allocated, say 10 bytes, variables from main
	// might have been overwritten when strcat was called 
	p = strcat(s, t);
	
	// This is just as bad because now we are modifying memory locations 
	// internal to the source code. As a general rule, don't do this!
	p = strcat(t, s);

	// Ok, let's try again now that we have actually allocated space for p
	// This will also fail because p will go out of scope as soon as fred returns
	p = strcopy(p, s);
	p = strcat(p, t);

	// Let's do it correctly now
	i = strlen(s) + strlen(t) + 1;
	p = (char*)malloc(i*sizeof(char));
	
	// Check for a null pointer
	if (!p) 
	{
		printf("ABORT");
		exit(1);
	}

	p = strcat(strcpy(p,s),t);

	return p;
}

int main(void)
{
	char bob[20] = "APPT ON ";
	char *ptr;

	ptr = fred(bob, "TUESDAY");
	
	printf("%s\n", ptr);

	int n;
	file *fp;
	char *s;
	
	n = 250;
	// stringalloc would be an internally defined function
	s = stringalloc(250);

	// fopen arguments:
	// r - read    t - text        + - append mode when in write mode (log files, etc)
	// w - write   b - binary
	fp = fopen("input.txt", "rt");

	if (!fp)
	{
		printf("ERROR OPENING FILE");
		exit(EXIT_FAILURE);
	}

	// Do not use scanf()!
	// Reads until it gets to the end of the file, the end of the line or the max size of the buffer -1
	// Check for a new line character at the end of the string in order to tell if the whole line was read
	fgets(s, n, fp);

	return 0;
}