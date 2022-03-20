/*
 * Joshua Harthan
 * Lab 7, CSCI 112
 * 3/30/17
 */

#include <stdio.h>

//list function prototypes
char *my_strncpy(char *dest, char *source, int n);
char *my_strncat(char *dest, char *source, int n);

//strncpy function to copy the set amount of chars (n)
char *my_strncpy(char *dest, char *source, int n){
	//index
	int i;
	//for loop to copy the chars from source array to dest array
	for(i = 0; i < n && source[i] != '\0'; i++){
		dest[i] = source[i];
	}
	//while loop to append dest to null character \0	
	while (i < n){
		dest[i++] = '\0';
	}
	return(dest);
}

//strncat function to concatenate the amount of chars(n) from source array to dest array
char *my_strncat(char *dest, char *source, int n){
	//char pointer value to point to dest
	char *value = dest;
	//while the array is pointing to dest, increment dest by one
	while(*dest){
		dest++;
	}
	//while n is being decremented(iterating through the array)
	while (n--){
		//if the pointers of dest doesnt equal source
		if(!(*dest++ = *source++)){
			return value; //return value
		}
	}
	dest = '\0';//set dest to null character \0
	return(value);
}

//main function to run the program
int main(){
	//test functions with various source strings and values of n
	char testSrc[] = "Hello";
	char testDest[40] = "world";
	int n = 5;

	//print dest before the array is changed
	printf("BEFORE: %s \n", testDest);
	
	//run and print results for strncat
	my_strncat(testDest, testSrc, n);
	printf("CAT: %s \n", testDest);

	//run and print results for strncpy 
	my_strncpy(testDest, testSrc, n);
	printf("CPY: %s \n", testDest);

	//print the string after running both functions
	printf("AFTER: %s \n", testDest);
	return(0);//end the program
}
