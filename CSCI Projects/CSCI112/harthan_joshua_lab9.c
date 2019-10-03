/*
 * Joshua Harthan
 * CSCI 112, Lab 9
 * 4/13/17
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#define MAX_ELEMENTS 20 //max element varibale to define the maximum amount of elements within the structure

//initialize the structure to hold the various variables of the element
typedef struct{
	int atomic_number; char name[MAX_ELEMENTS]; char chemical_symbol[MAX_ELEMENTS]; char class[MAX_ELEMENTS]; double atomic_weight; int number_electrons[7];
}element_t;	

//function prototypes
void scan_element(element_t * element);
void print_element(element_t * element);

//main function that requires an int wihtin the command line
int main(int argc, char *argv[]){
	int i;//index variable
	//create an array of sturdctures
	element_t element[MAX_ELEMENTS];
	//if the amount of arguments in the command line dont equal 2, print out an error message and end the program
	if (argc != 2){
		printf("ERROR: You must provide exactly one argument to this program.\n");
		return(0);
	}
	//convert the string that was passed into the command line into an int
	int A = (int) strtol(argv[1], NULL, 10);	
	//if the int is less than 0 or more than 20 print out an error message and end the program
	if(A <= 0 || A > MAX_ELEMENTS){
		printf("ERROR: You must provide an integer greater than 0 and less than or equal to 20.\n");
		return (0);
	}
	//scan in the elements into the structure array
	for(i = 0; i < A; i++){
		scan_element(&element[i]);	
	}
	//print out the amount of elements, and the name of the elements that have min and max atomic numbers	
	printf("%d total element(s).\n", A);
	//int to point to a point within the strucutre array and string to copy the name of the element at that point to
	int smallest_atom = element[0].atomic_number;
	char small_atom_name[100];
	int largest_atom = element[0].atomic_number;
	char large_atom_name[100];
	//for loops to iterate through the array, looking for the smallest and largest atomic number, copying the name of the element into the strings created
	for(i = 0; i < A; i++){
		if(element[i].atomic_number < smallest_atom){
			smallest_atom = element[i].atomic_number;
			strncpy(small_atom_name, element[i].name, strlen(element[i].name));
		}
		if(element[i].atomic_number > largest_atom){
			largest_atom = element[i].atomic_number;
			strncpy(large_atom_name, element[i].name, strlen(element[i].name));
		}
	}
	//print out the results of the largest and smallest atomic number
	printf("%s has the smallest atomic number.\n", small_atom_name);
	printf("%s has the largest atomic number.\n", large_atom_name);
	//print out the structure
	for(i = 0; i < A; i++){
		print_element(&element[i]);
	}
	return(0); // end the program
}

//scan in the values to be used within the structure
void scan_element(element_t * element){
	scanf("%d %s %s %s %lf",
	&element->atomic_number, 
	element->name,
	element->chemical_symbol,
	element->class,
	&element->atomic_weight);
	int i = 0;//index to scan in values for int array in structure
	for(i = 0; i < 7; i++){	
		scanf("%d",&element->number_electrons[i]); 
	}
			
}	

//print out the structe with a certain format
void print_element(element_t * element){
	printf("---------------\n");
	printf("| %d\t%.4lf\n",(*element).atomic_number, (*element).atomic_weight);
	printf("| %s\t%s\n",(*element).chemical_symbol, (*element).name);
	printf("| ");
	int i = 0;
	for(i = 0; i < 7; i++){
		if((*element).number_electrons[i] != 0){
			printf("%d ",(*element).number_electrons[i]);
		}
	}
	printf("\n");
	printf("---------------\n");  
} 	 
