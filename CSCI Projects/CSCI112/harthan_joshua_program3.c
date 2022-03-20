/*
 * Joshua Harthan
 * CSCI 112, Program 3
 * 4/21/17
 */

#include<stdio.h>
#include<stdlib.h>
#define NAME_SIZE 25 //maximum size a student's name can be

//student structure
typedef struct student_t {
	int sid; char last_name[NAME_SIZE]; char first_name[NAME_SIZE]; float* list_of_grades; float gpa_value;
}student_t;

typedef struct student_t student;

//function prototypes
student input_info(int num_grades);
float calculate_gpa(student * students, int num_grades);
void print_records(student * students, int num_students, int num_grades);
void free_memory(student * students, int num_students);

//main function to 
int main(){
	//variables to store in user input and to iterate through for loop
	int num_students;
	int num_grades;
	int i;
	//scan in input to represent the number of students to be input and number of grades to be input, then print out the values
	scanf("%d", &num_students);
	scanf("%d", &num_grades);
	printf("Number of students: %d\n", num_students);
	printf("Number of grades(each): %d\n", num_grades);
	//calloc to allocate memory for the student array
	student * students = (student *)calloc(num_students, sizeof(student));
	//for loop to iterate through structure to input and then print out values
	for(i = 0; i < num_students; i++){
		*(students + i) = input_info(num_grades);	
		print_records(&students[i], num_students, num_grades);
	}
	free_memory(students, num_students);//run the free memory function to release memory associated with structure
	return(0);//exit the program
}

//input_info function that takes in an int and returns an instance of the student struct
student input_info(int num_grades){
	//create an instance of structure
	student new_student;
	//scan in input and store values into respective structure values
	scanf("%d %s %s",
	&new_student.sid,
	new_student.last_name,
	new_student.first_name);
 	int index;//index to iterate through list_of grades
	for(index = 0; index < num_grades; index++){
		scanf("%f", &new_student.list_of_grades[index]);
	}
	//run the calculate gpa function to find the gpa
	new_student.gpa_value = calculate_gpa(&new_student, num_grades);
	return(new_student);//reutrn the student instance
}

//calculate_gpa to take the average of the grades input, takes in pointer to struct and int and returns a float value
float calculate_gpa(student * students, int num_grades){
	float calculated_gpa;//the varible that is to be returned
	int index;//variable to iterate through for loop
	float sum;//varible that is the sum of the grades, to be divided by the number of grades input
	//add the grades that are input
	for(index = 0; index < num_grades; index++){
		sum += (*students).list_of_grades[index];
	}
	//divide the sum from the number of grades and cast this to a float
	calculated_gpa = (float) sum / num_grades;
	return(calculated_gpa);
}

//print_records function to print out the respective values of the stucture
void print_records(student * students, int num_students, int num_grades){
	printf("ID: %d, Name: %s %s, GPA: %.2f\n", (*students).sid, (*students).first_name, (*students).last_name, (*students).gpa_value);
	printf("Grades: ");
	int index;//variable to iterate through for loop
	for(index = 0; index < num_grades; index++){
		printf("%.1f ", (*students).list_of_grades[index]);
	}
	printf("\n");//formatting
}

//free memory function
void free_memory(student * students, int num_students){
	int index;//instance variable to iterate through for loop
	//for loop to free memory allocated for list_of_grades array
	for(index = 0; index < num_students; index++){
		free( (students + index)->list_of_grades );
		(students + index)->list_of_grades = NULL;
	}
	//free memory of the structure array
	free( students );
	students = NULL;
}
