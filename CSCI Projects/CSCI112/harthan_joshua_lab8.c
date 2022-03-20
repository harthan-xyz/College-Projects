/*
 * Joshua Harthan
 * CSCI 112, Lab 8
 * 4/6/17
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#define SIZE 80 //size to define max of array

//function prototypes
void reverse(char line[]);

int main(int argc, char * argv[]){
	char string[SIZE];//create the string array
	int i;
	//if the command line doesnt have two arguments print out an error and end the program
	if (argc != 2){
		printf("ERROR: Please provide an integer greater than or equal to 0\n");
		return(0);} 
	//convert the command in the second position into an array
	int N = (int) strtol(argv[1], NULL, 10);	
	//for loop to continue input for amount in command line
	for(i = 0; i < N; i++){
		//if the input is valid, reverse the string
		if(fgets(string, SIZE, stdin)){
			reverse(string);}
	}
	return(0);//end the program
}

//reverse function to reverse the order of words for a given string
void reverse(char line[]){
	//instance variables to iterate through char arrays(strings) 
	int index;
	int index2;
	char temp;
	int length = strlen(line);
	//for loop to completely reverse the string 
	for(index = 0; index < length/2; index++){
		//swap the values of the string line as it iterates through the string
		temp = line[index]; 
		line[index] = line[length - 1 - index];
		line[length - 1 - index] = temp;
	}
	//for loop to swap the characters back to not have words backwards, until a null character is found 
	for(index = 0; line[index] != '\0'; index++){
		if(line[index + 1] == ' ' || line[index+1] == '\0'){
			for(index2 = index; index2 > 0 && line[index2] != ' '; index2--){
				printf("%c", line[index2]); //print out the string
			}	
		}
		printf(" "); //print out spaces between words	
	}
	printf("\n");//line break
} 

