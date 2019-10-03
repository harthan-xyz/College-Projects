#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int main()
{
	char first_name[100];
	char last_name[100];
	char age[100];
	int  a;
	char pi[100];
	double p; 
	
	printf("What is your first name?\n");
	fgets(first_name, sizeof(first_name),stdin);

	printf("What is your last name?\n");
	fgets(last_name, sizeof(last_name), stdin);

	printf("What is your age?\n");
	fgets(age, sizeof(age), stdin);
	a=atoi(age);

	printf("Enter the value of Pi with as many digits as you can remember.\n");
	fgets(pi, sizeof(pi), stdin);
	p=atof(pi);

	printf("%s%swho is %d years old, entered the following number for Pi: %f\n",first_name,last_name,a,p);
	
	printf("(Enter any key to exit the window)\n");
	_getch();

	return 0;
}