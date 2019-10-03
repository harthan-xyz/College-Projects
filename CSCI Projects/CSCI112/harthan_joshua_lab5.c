/*
 * Joshua Harthan
 * Lab 5, CSCI 112
 * 3/2/17
 */

#include <stdio.h>
#define MAX 12 //define MAX as 12 as that is the maximum number of ints that the barcode can be

//create_array function to take in an integer array and store values within it
void create_array(int userInput[]){
	//create the variables used for the array	
	int a, b;
	//prompt the user to enter 12 digits and store values into array
	printf("Enter a bar code to check. Separate digits with a space >\n");
	for(a = 0; a < MAX; a++){
	scanf("%d", &userInput[a]);
	}
	//print out the values of the array
	printf("\n");
	printf("You entered the code: ");
	for(b = 0; b < a; b++){
	printf("%d ", userInput[b]);
	}
	printf("\n");
}

//calculate_odd function to take in an integer array and add the odd elements together, and then multiply this result by three
void calculate_odd(const int userInput[]){
	//create the variables to be used in the for loop and to calculate the total
	int odd;
	int total = 0;
	int result = 0;
	//for every odd element, add to the total
	for(odd = 0; odd <= MAX - 1; odd = odd + 2){
	total = total + userInput[odd];
	}
	//mulitply this total by three to get the reult of the funtion, print out the result
	result = total * 3;
	printf("STEP 1: Sum of odd times 3 is %d\n", result);
}

//get function to return the value of the calculate_odd fucntion without printing out the result
int get_odd(const int userInput[]){
	int odd;
	int total = 0;
	int result = 0;
	for(odd = 0; odd <= MAX - 1; odd = odd + 2){
	total = total + userInput[odd];
	}
	result = total * 3;
	//return the integer being solved for to be used in later functions
	return(result); 
}

//calculate_even function to take in an integer array and add the even elements together
void calculate_even(const int userInput[]){ 
	//create the variables to be used in the for loop and the resulting integer from the sums
	int even;
	int result = 0;
	//for each even element, add to the total
	for(even = 1; even <= MAX - 3; even = even + 2){
	result = result + userInput[even];
	}
	//print out the result of the function
	printf("STEP 2: Sum of the even digits is %d\n", result);
}

//get function to return the value of the calculate_even function without printing out the result
int get_even(const int userInput[]){
	int even;
	int result = 0;
	for(even = 1; even <= MAX - 3; even = even + 2){
	result = result + userInput[even];
	}
	//return the integer being solved for to be used in later functions
	return(result);
}

//total_sum method that takes in two integers and adds them together
void total_sum(int odd, int even){
	//variable to reperesent teh sum of the two ints
	int result;
	//add the two integers and print out the result
	result = odd + even;
	printf("STEP 3: Total sum is %d\n", result);
}

//get function to return the value of the total_sum function without printing out the result
int get_total(int odd, int even){
	int result;
	int lastDigit = 0;
	result = odd + even;
	//modulo function to get the last digit of the result
	lastDigit = result % 10;
	//return the last digit of result to be used in later functions
	return(lastDigit);
}	

//check_digits method that takes in an integer array and an int to figure out if the barcode is valid or not
void check_digit(const int userInput[], int lastDigit){
	//variable to be used to check if the numbers are valid and to calculate a check digit	
	int checkDigit;
	//if the last digit is greater than 0, print out the check digit (10 subtracted from the last digit of the sum calculated in total_sum) and set checkDigit equal to 10 minus lastDigit
	if(lastDigit > 0){
	printf("STEP 4: Calculated check digit is %d\n", 10 - lastDigit);
	checkDigit = 10 - lastDigit;
	}
	//if the last digit equals 0, set checkDigit equal to lastDigit
	else{
	printf("STEP 4: Calculated check digit is %d\n", lastDigit);
	checkDigit = lastDigit;
	}
	//if the last digit of the array equals the check digit, than print out that the barcode is valid
	if (checkDigit == userInput[MAX - 1]){
	printf("STEP 5: Check digit and last digit match\n");
	printf("Barcode is VALID. \n");
	printf("\n");
	}
	//else if the last digit is not equal, print out that the barcode is invalid
	else {
	printf("STEP 5: Check digit and last digit do not match\n");
	printf("Barcode is INVALID. \n");
	printf("\n");
	}
}

//main function to run the different fucntions
int main (void){
	//create the array that holds 12 integers
	int userInput[MAX];
	create_array(userInput);
	calculate_odd(userInput);
	calculate_even(userInput);
	total_sum(get_odd(userInput), get_even(userInput));
	check_digit(userInput, get_total(get_odd(userInput), get_even(userInput)));
	return(0);
}
