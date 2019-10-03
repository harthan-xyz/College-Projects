/*
 * Joshua Harthan
 * Program 1, CSCI 112
 * 2/20/17
 */
 
#include <stdio.h>
 //print function to print out the patter, takes in an int that the user inputs
 void print_pattern(int input) {
	 //variables to be used in loops
	 int rows;
	 int counter;
	 int num;
	 //for loop to create a coutner for how many rows present in the pattern, incremented by two, top half of diamond
	 for(rows = 1; rows <= input; rows = rows + 2){
	     //print out the number of spaces
	     printf("%*s", input - rows, ""); 
	     //set the counter variable equal to 0 and the num variable equal to 1
	     counter = 0;
	     num = 1;
	     //while the counter is incremented and not equal to 2 multiplied by the counter subtracted from the counter; to print out the incrementing numbers
	     while(counter++ != (2*rows - rows)){
	     printf("%d ", num++);
	     }
	     printf("\n"); //line break
	  }
	  input--; //subtract one from input to avoid printing middle line twice
	  //for loop to create a counter for how many rows present in the pattern, subtracted by two; bottom half of diamond
	  for(rows = input; rows >= 1; rows = rows - 2){
	     //print out teh number of spaces
	     printf("%*s", input - rows + 2 , "");
	     //set the  counter variable equal to 0 and teh num variable equal to 1
	     counter = 0;
	     num = 1;
	     //while the counter is incremented and not equal to 2 multiplied by the counter subtracted from teh counter + 1; to print out the incrementing numbers
	     while(counter++ != (2*rows - (rows+1))){
	     printf("%d ", num++);
	     }
	     printf("\n");//line break
	  }  
 }
  //is_valid function to check if the number input by the user is odd and between 1 and 9 (including 1 and 9)		
  void is_valid (int input){ 
	 //series of if else statements to notify the user if the input is valid or not
	 if (input > 9){
	     printf("You have entered a number greater than 9. Please try again. \n");}
	 else if(input < 1){ 
	     printf("You have entered a number less than 1. Please try again. \n");}
	 else if (input % 2 == 0){//if the number input has no remainder. the number is even
	     printf("You have entered an even number. Please try again. \n");}
	 else if (input % 2 != 0) {//if the number has a remainder, the number is odd
 	     print_pattern(input);}//if the number is even, print out the pattern
	 else{
	     printf("Enter an odd number between 1 and 9:  \n");}
 }
 //get input function to ask for user input and store that input as an integer
 int get_input(void) {
	 int userInput; //userInput variable to store input
	 //do while loop to continue prompting the user for an odd number until conditions are met
	 do{
	     printf("Enter an odd number between 1 and 9: ");
	     scanf("%d", &userInput);  
 	     is_valid(userInput);
	 } while (userInput % 2 == 0); //while the user input is even
	 return (userInput);
 }
 //main function to call the get_input fucntion and run the program
 int main(void){
	 get_input();
 	 return(0); //end the program
 }
