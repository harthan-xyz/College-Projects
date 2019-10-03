#include <stdio.h>
#include <string.h>
#include <conio.h>

int main()
{
	char first_name[100];
	char last_name[100];
	char full_name[100];

	printf("What is your first name?\n");
	fgets(first_name, sizeof(first_name), stdin);
	
	printf("What is your last name?\n");
	fgets(last_name, sizeof(last_name), stdin);
	
	strcpy (full_name,first_name);
	strcat (full_name,last_name);
	
	printf("Your full name is: %s\n",full_name);	

	printf("(Enter any key to exit the window)\n");
	_getch();

	return 0;
}