/*
 * Joshua Harthan
 * Lab 4, CSCI 112
 * 2/23/17
 */

#include <stdio.h>
#include <math.h>
#define PI 3.14159 //define PI to be used multiple times in the program
#define LOOP_LIMIT 90 //define the LOOP_LIMIT to be the max number for degrees

//sine() function to calculate the sin of the degrees
double sine(void){
	//define variables to be used in the fucntion
	int degrees;
	double radians, result;
	//for loop to print out multiple instances of different degrees for sin
	for(degrees = 0; degrees <= LOOP_LIMIT; degrees = degrees + 15){
	radians = (double) PI * degrees/180; //convert degrees to radians
	result = sin(radians); //use the sin function of the calculated radian
	printf("\tsin(%d) = %.4lf \n", degrees, result);} //print out the result
	return(result);
}

//cosine() function to calculate the cos of the degrees
double cosine(void){
	//define variables to be used in the function
	int degrees;
	double radians, result;
	//for loop to print out multiple instances of different degrees for cos
	for(degrees = 0; degrees <= LOOP_LIMIT; degrees = degrees + 15){
	radians = (double) PI * degrees/180; //convert degrees to radians
	result = cos(radians); //use the cos function of the calculated radian
	printf("\tcos(%d) = %.4lf \n", degrees, result);} //print out the sesult
	return(result);
}

//tangent() function to calculate the tan of the degrees
double tangent(void){
	//define variables to be used in the function
	int degrees;
	double radians, result;
	//for loop to print out the multiple instances of different degrees for tan
	for(degrees = 0; degrees <= 75; degrees = degrees + 15){
	radians = (double) PI * degrees/180; //convert degrees to radians
	result = tan(radians); //use the tan function of the calculated radian
	printf("\ttan(%d) = %.4lf \n", degrees, result);} //print out the result
	printf("\ttan(90) is UNDEFINED\n"); //if the degree is 90, print out undefined
	return(result);
}

//user_menu() method to prompt user for displaying either the sin, cos, or tan of certain degrees
void user_menu(void){
	//define the values within the enum and assign to data type menu_t 
	typedef enum{
		Sine, Cosine, Tangent, QUIT
	} menu_t;
	menu_t menu_options; //define variable menu_options
	//do while loop to run while the enum doesnt equal QUIT
	do{
		//prompt the user for input and store value into enum variable
		printf("Please choose an option: (0) Sine (1) Cosine (2) Tangent (3) QUIT\n");
		printf("Enter a choice > ");
		scanf("%u",&menu_options);
		//switch statement to run the different functions for the different numbers input
		switch(menu_options){
		case Sine:	
			sine();
			break;
		case Cosine:
			cosine();
			break;
		case Tangent:
			tangent();
			break;
		case QUIT:
			printf("You chose QUIT. Thank you, come again!\n");
			break;
		default:
			printf("%d is an invalid option. Please try again.\n", menu_options);
			break;}
	} while (menu_options != QUIT);
}

//main function to run the program
int main(void){
	user_menu();//run function user_menu()
	return(0);//exit the program
}
