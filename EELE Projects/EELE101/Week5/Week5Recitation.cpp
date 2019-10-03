#include <conio.h>			//for_getch() to keep program window open
#include <stdio.h>			//for printf() functions
#include <math.h>			//for pow()
#include <float.h>			//for DBL_MAX

#define Npoints 100			//number of data points
#define cstepsize .1		//c increments for step size
#define cstart 0			//starting point of c

//function of Pload 
double Pload(double c, double Vsource, double Rsource){
		double Rload;					//double array for load resistance
		Rload = (pow(Vsource,2) *  c * Rsource) / (pow(Rsource + (c * Rsource), 2));
		return Rload;
}
				
//max location function
double max_location (double ca[], double pa[], int N) {
	double pmax,cmax;				//double arrays to hold the maximum values of c and p
	double c;						//unknown value of c
	int i;							//array index
	int imax;						//max value of i
	cmax = -1*DBL_MAX;
	pmax = -1*DBL_MAX;
	imax = -1;
	for(i=0; i<N; i++){
		c = ca[i];
		if( (0 <= c) && (c <= 10) ){  //check between c = [0,10]
			if( pmax < pa[i] ){       //if pmax is greater than the current p
				pmax = pa[i];		  //then take on the p value
				cmax = c;             //keep the c value
				imax = i;			
			}
		}
	}
	return cmax, imax;
}

//main fuction
int main()
{
	char source_voltage[100];		//character array for source voltage
	double Vsource;					//double array for source voltage
	char source_resistance[100];	//character array for source resistance
	int i;							//index for arrays
	int imax;						//max value of i
	double c;						//unknown/current value of c
	double Rsource;					//double array for source resistance
	double Rload;					//double array for load resistance
	double ca[Npoints];				//array to hold c values
	double pa[Npoints];				//array to hold p values
	double pmax,cmax;				//double arrays to hold the maximum values of c and p

	//ask for the source voltage and set the value
	printf("What is the source voltage?\n");
	fgets(source_voltage, sizeof(source_voltage), stdin);
	Vsource=atof(source_voltage);
	printf("You entered %f volts for Vs.\n", Vsource);
	printf("\n");

	//ask for the source resistance and set the value
	printf("What is the source resistance?\n");
	fgets(source_resistance, sizeof(source_resistance), stdin);
	Rsource=atof(source_resistance);
	printf("You entered %f ohms for Rs.\n", Rsource);
	printf("\n");	

	//compute the Pload fucntion
	for (i = 0, c=cstart; i<Npoints; i++, c+=cstepsize){
		ca[i] = c;
		pa[i] = Pload(c, Vsource, Rsource); 
	}

	//call the max location function

	imax = max_location(ca,pa,Npoints);
	cmax = ca[imax];
	pmax = pa[imax];

	//set value of resistance load
	Rload = cmax * Rsource;

	//print the max load of p and the values of c and Rl
	printf("The maximum value that P attains is %f watts at c= %f \nand the Resistance Load= %f.\n", pmax, cmax, Rload);
	printf("\n");
	printf("(Press any key to exit the window.)\n");
	
	_getch();	//keep window open

}