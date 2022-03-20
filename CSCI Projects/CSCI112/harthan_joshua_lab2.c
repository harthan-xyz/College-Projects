/*
*Joshua Harthan
*Lab 2, CSCI 112
*1/27/17
*/
#include<stdio.h>

//get_input function to retrieve input from the user
double get_input(void)
{
	//declare variable for user input
	double userInput;
	//prompt the user for a number and set variable equal to the number input
	printf("Enter a number > \n");
	scanf("%lf" , &userInput);
	//return the input of the user
	return(userInput);
}

//get_next function to sequence the value x
double get_next(double x1, double x2)
{
	//declare variables
	double x;
	//sequence the function
	x = x1/2 + 3 * x2; 
	return(x);	
}

//print_result function to print out the results of the equation
void print_result(double x5)
{
	printf("The result is %.2f \n", x5);	
}

//main program entry point
int main(void)
{
	//set the values of the variables of x1 and x2
	double x1 = get_input();
	double x2 = get_input();
	//increment the values to get x5
	double x3 = get_next(x1,x2);
	double x4 = get_next(x2,x3);
	double x5 = get_next(x3,x4);
	//print out the result of x5
	print_result(x5);
	return(0);
}
