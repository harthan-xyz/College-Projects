/* 
* Joshua Harthan
* Lab 1, CSCI 112
* 1/18/17
*/
#include <stdio.h>

int
main (void)
{
	//declare required variables, fahrenheit and celsius
	double celsius = 0, fahrenheit = 0;
	
	//ask the user for the temperature in Celsius
	printf("Enter a temperature in degrees Celsius: ");
	scanf("%lf" , &celsius);

	//convert to Fahrenheit, multiplty by 9 divide by 5 add 32
	fahrenheit = (9.0/5.0) * celsius + 32.0;


	//print out the temperature in Fahrenheit
	printf("That is %.2f degrees Fahrenheit. \n", fahrenheit);

	//ask the user for the temperature in fahrenheit
	printf("Enter a temperature in degrees Fahrenheit: ");
	scanf("%lf" , &fahrenheit);

	//convert to Celsius, subtract by 32 multiply by 5 divide by 9
	celsius = (fahrenheit - 32.0) * 5.0/9.0;
	
	//print out the temperature in Celsius
	printf("That is %.2f degrees Celsius \n", celsius);

	//exit the program
	return(0);
}
