#include <conio.h>
#include <stdio.h>
#include <math.h>
#include <float.h>


#define pointsInArray 100
#define stepSize .1
#define cStart 0

int main()
{
	char source_voltage[100];		//character array for source voltage
	double Vs;						//double array for source voltage
	char source_resistance[100];	//character array for source resistance
	double Rs;						//double array for source resistance
	double Rl;						//double array for load resistance
	int i;							//array index
	double c;						//unknown value of c	
	double ca[pointsInArray];		//array to hold c values
	double pa[pointsInArray];		//array to hold p values
	double pmax,cmax;				//double arrays to hold the maximum values of c and p

	//ask for the source voltage and set the value
	printf("What is the source voltage?\n");
	fgets(source_voltage, sizeof(source_voltage), stdin);
	Vs=atof(source_voltage);
	printf("You entered %f volts for Vs.\n", Vs);
	printf("\n");

	//ask for the source resistance and set the value
	printf("What is the source resistance?\n");
	fgets(source_resistance, sizeof(source_resistance), stdin);
	Rs=atof(source_resistance);
	printf("You entered %f ohms for Rs.\n", Rs);
	printf("\n");	
	
	//for statement to set the power equation
	for(i=0, c=cStart; i<pointsInArray; i++, c+=stepSize){
		ca[i] = c;
		pa[i] = (pow(Vs,2) *  c * Rs) / (pow(Rs + (c * Rs), 2));
	}

	//for and if statements to find and set cmax and pmax, and return the values
	cmax = -1*DBL_MAX;
	pmax = -1*DBL_MAX;
	for(i=0; i<pointsInArray; i++){
		c = ca[i];
		if( (0 <= c) && (c <= 10) ){
			if( pmax < pa[i] ){
				pmax = pa[i];
				cmax = c;
			}
		}
	}
	
	Rl = cmax * Rs;		//set value for the resistance load

	//print the max load of p and the values of c and Rl
	printf("The maximum value that P attains is %f watts at c= %f \nand the Resistance Load= %f.\n", pmax, cmax, Rl);
	printf("\n");
	printf("(Press any key to exit the window.)\n");
	
	_getch();	//keep window open

}