/*
 * Joshua Harthan
 * Program 2, CSCI 112
 * 3/22/17
 */

#include <stdio.h>
#define MAX_ARRAY_SIZE 50 //constant to restrict the maximum size of the array

//list function prototypes
int populate_array(int array[]); //fill array with values from user
void print_array(int array[], int n); //print out the array values
void swap(int array[], int index1, int index2); //swap two array elements
void quicksort(int array[], int low, int high); //sorting algorithm
int partition(int array[], int low, int high); //find the partition point (pivot point)

//main function that runs the program
int main (void){
	int array[MAX_ARRAY_SIZE]; //create an array with a size of 50
	int n; //integer to represent a pointer
	//run the functions to run the program
	n = populate_array(array);
	printf("The initial array contains: \n");
	print_array(array, n);
	quicksort(array, 0, n-1);
	printf("The array is now sorted: \n");
	print_array(array, n);
	return(0); //exit the program
}

//poplulate function that asks for user input and creates and populates an array
int populate_array(int array[]){
	int index;//index variable for for loop
	int n; //n variable for user input
	//do while loop to run the program until an appropriate number is input
	do{
	//prompt for user input and store in variable
	printf("Enter the value of n > ");
	scanf("%d", &n);
	//if the input is greater than the limit or smaller than zero, print error message
	if(n > MAX_ARRAY_SIZE){
		printf("%d exceeds the maximum array size. Please try again.\n\n", n);
	}
	else if(n < 0){
		printf("%d is less than zero. Please try again.\n\n", n);
	}
	}while (n > MAX_ARRAY_SIZE || n < 0);
	//prompt user for amount of integers and input the ints into an array
	printf("Enter %d integers (positive, negative, or zero) > \n", n);
	for(index = 0; index < n; index++){
		scanf("%d", &array[index]);
	}
	return(n); //return the user input
}	

//print array function that prints out the value of the array
void print_array(int array[], int n){
	int index;
	for(index = 0; index < n; index++){
		printf("%+5d\n", array[index]);//allows for positive and negative ints to print
	}
}

//swap function to swap the values at certain points in the array
void swap(int array[], int index1, int index2){
	int temp = MAX_ARRAY_SIZE; //temp variable to temporarily hold one value at a point
	array[temp] = array[index1];
	array[index1] = array[index2];
	array[index2] = array[temp];
}

//quick sort function to recursively run the program until the array is sorted 
void quicksort(int array[], int low, int high){
	int pivot; //pivot variable to determine where the array will be split
	if(low < high){
		pivot = partition(array, low, high); //set pivot location
		quicksort(array, low, pivot - 1); //search to the left of the pivot
		quicksort(array, pivot + 1, high);//search to the right of the pivot
	}
}

//partition function to swap the values of the array
int partition(int array[], int low, int high){
	//instance variables to iterate through the array
	int pivot;
	int i;
	int j;
	pivot = array[high];
	i = low;
	//iterate throught the array, swapping when necessary
	for(j = low; j <= high - 1; j++){
		if(array[j] <= pivot){
			swap(array, i, j);
			i = i + 1;
		}
	}
	swap(array, i, high);
	return(i); //return amount of times for loop was ran
}	
