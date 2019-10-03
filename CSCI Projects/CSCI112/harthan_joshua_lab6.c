/*
 * Joshua Harthan
 * Lab 6,CSCI 112
 * 3/9/17
 */

#include <stdio.h>//import standard library for basic input
#include <math.h>//import the math library to use pow and sqrt


int user_menu(); //display the user menu, prompt user for input

//list function prototypes
void equation1(float *);
void equation2(float *);
void equation3(float *);
void equation4(float *);

//function prototypes for the get functions
float get_initial_position(void);
float get_final_position(void);
float get_initial_velocity(void);
float get_final_velocity(void);
float get_acceleration(void);
float get_time(void);

//main function that displays user_menu and determines what to do from user input
int main (void){
	printf("Welcome to the MOTION EQUATION CALCULATOR\n\n");
	int user_input; //create variable to store user input
	//do-while loop to continue displaying the menu until they want to quit
	do{
		user_input = user_menu(); //set variable equal to what the user enters
		float result; //variable to store and print out the calculated value
		//switch statement to run different options for different user input
		switch(user_input){
		//run respective functions and print out the result for different options
		case 1:
			equation1(&result);
			printf("Your result is %.4f.\n\n", result);
			break;
		case 2:
			equation2(&result);
			printf("Your result is %.4f.\n\n", result);
			break;
		case 3:
			equation3(&result);
			printf("Your result is %.4f.\n\n", result);
			break;
		case 4:
			equation4(&result);
			printf("Your result is %.4f.\n\n", result);
			break;
		//if the user enters 5, print message and exit program
		case 5:
			printf("Thank you for using the MOTION EQUATION CALCULATOR. Goodbye. \n");
			return(0);
			break;
		default:
			break;
		}			
	}while (user_input != 5);

	return(0);//exit the program
}

//sereies of get functions to take in user input and store/return their respective values
float get_initial_position(void){
	float initial_position;
	printf("\tEnter initial position > ");
	scanf("%f", &initial_position);
	return(initial_position);
}

float get_final_position(void){
	float final_position;
	printf("\tEnter final position > ");
	scanf("%f", &final_position);
	return(final_position);
}

float get_initial_velocity(void){
	float initial_velocity;
	printf("\tEnter initial velocity > ");
	scanf("%f", &initial_velocity);
	return(initial_velocity);
}

float get_final_velocity(void){
	float final_velocity;
	printf("\tEnter final velocity > ");
	scanf("%f", &final_velocity);
	return(final_velocity);
}

float get_acceleration(void){
	float acceleration;
	printf("\tEnter acceleration > ");
	scanf("%f", &acceleration);
	return(acceleration);
}

float get_time(void){
	float time;
	printf("\tEnter time > ");
	scanf("%f", &time);
	return(time);
}

//series of equation functions to calculate results given different values input by user, stored as floats
void equation1(float * vf){
	float vi = get_initial_velocity();
	float a = get_acceleration();
	float t = get_time();
	*vf = vi + a * t;
}
	
void equation2(float * xf){
	float xi = get_initial_position();
	float vi = get_initial_velocity();
	float t = get_time();
	float a = get_acceleration();
	*xf = xi + vi * t + .5 * a * pow(t, 2.0);
}

void equation3(float * vf){
	float vi = get_initial_velocity();
	float a = get_acceleration();
	float xf = get_final_position();
	float xi = get_initial_position();
	*vf = sqrt((pow (vi , 2) + 2 * a * (xf - xi)));
}

void equation4(float * xf){
	float xi = get_initial_position();
	float vf = get_final_velocity();
	float vi = get_initial_velocity();
	float t = get_time();
	*xf = xi + .5 * (vf + vi) * t;	
}

//user_menu function to prompt user for different options, and check if the input is between 1 and 5
int user_menu(void){
	int user_input;
	printf("Choose a motion equation 1-4 or choose 5 to QUIT > ");
	scanf("%d", &user_input);
	if (user_input > 5 || user_input <= 0){
	printf("Invalid Option. Please try again.\n\n");
	}
	return(user_input);	
}



 
