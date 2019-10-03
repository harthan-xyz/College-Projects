#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int main()
{
	char source_voltage[100];
	double v1;
	char resistance1[100];
	double r1;
	char resistance2[100];
	double r2;
	double i;
	double vout;


	printf("What is the source voltage?\n");
	fgets(source_voltage, sizeof(source_voltage), stdin);
	v1=atof(source_voltage); 
	printf("You entered %f volts for V1.\n", v1); 
	printf("\n");

	printf("What is one of the resistance values?\n");
	fgets(resistance1, sizeof(resistance1), stdin);
	r1=atof(resistance1);
	printf("You entered %f ohms for R1.\n", r1);
	printf("\n");

	printf("What is the value of the other resistance?\n");
	fgets(resistance2, sizeof(resistance2), stdin);
	r2=atof(resistance2);
	printf("You entered %f ohms for R2.\n", r2);
	printf("\n");

	i = v1/(r1+r2);
	printf("The total current in the circuit is I = %f ampseres.\n",i);

	vout = v1 * (r2/(r1+r2));
	printf("The output voltage is Vout = %f volts.\n", vout);
	printf("\n");
	
	printf("(Enter any key to exit the window)\n");
	
	_getch();

	return 0;

}