/*
*Joshua Harthan
*Lab 3, CSCI 112
*2/3/17
*/

#include <stdio.h>
#include <math.h> 
#include <float.h>
    
// get_N function that asks user to input a vaule for N, set input equal to N
    int get_N(void)
{
    //declare the N varaible
	int N;
    //do-while loop to store the value of N 
	do { 
        printf ("Enter a value for N that is greater than or equal to  0: ");
	    scanf ("%d" , &N);
        //if the value entered is less than 0
	    if(N < 0)
		{
			printf("Please enter a valid number that is greater than or equal to  0.\n");
	    }
        //if the value entered is greater than 0
		else
		{
			break; // end the loop
		}
            
        } while ( N < 0 ); //run while the value N is less than 0
     //return the value of N
	 return (N);    
}

//get_input function to retrieve input from the user
   double get_input(void)
{
	//declare variable for user input
	double userInput;
	//prompt the user for a number and set variable equal to the number input
	printf("Enter a number: ");
	scanf("%lf" , &userInput);
	//return the input of the user
	return(userInput);
}

//main function that calls and runs the other functions
    int main(void)
{	
	//declare the N variable to the number input from the get_N function
    int N = get_N();
    //declare variables used in the program
	double lowest = DBL_MAX, highest = -DBL_MAX;
	double sum, sum_squares, average, std_dev;
    int num;
	//for loop to count from 0 to N
	for(num = 0; num < N; ++num)
	{
	 //create current variable that is equal to the input from the get_input function    
	 double current = get_input();
        //if current is less than lowest, set lowest equal to the value
	    if (current < lowest)
		{
                lowest = current;
		}
	    //if current is greater than highest, set highest equal to the value
        if (current > highest)
		{
                highest = current;
		}
         //set sum equal to itself plus the value of current
	     sum = sum + current;
         //set sum_squares equal to itself plus current raised to two
	     sum_squares = sum_squares + pow (current, 2.0);
     }
    //set the value of the range variable
	double range = highest - lowest;
    //if N is equal to 0, set the values being calculated equal to 0
	if(N == 0)
	{
        average = 0, std_dev = 0, lowest = 0, highest = 0, range = 0;
	}
    //if N does not equal 0, caluculate the average and standard deviation
	else
	{
        average = sum / N;
        std_dev = sqrt(( sum_squares / N ) - pow (average, 2.0));
    }
	//print out the values that you have found 
    printf("The Highest is: %.3f \n",highest);
	printf("The Lowest is: %.3f \n", lowest);
	printf("The Average is: %.3f \n", average);
	printf("The Range is: %.3f \n", range);
	printf("The Standard Deviation is: %.3f \n", std_dev);
   	return (0);//exit the program
}

