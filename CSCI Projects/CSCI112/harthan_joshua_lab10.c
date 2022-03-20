/*
 * Joshua Harthan
 * CSCI 112, Lab 10
 * 4/27/17
 */ 


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ELEMENT_FILENAME "element_db.csv"//define the file so the filename wont have to be repeated

//structure for an element that takes in information about said element
typedef struct {
    int atomic_number;
    char symbol[4];
    char name[25];
    float atomic_weight;
    char state[25];
    char bonding_type[25];
    char discovered[25];
} element_t;

//function prototypes
element_t * find_element( element_t * list, char * symbol );
void print_element( element_t * list, FILE * output_file);

//main function that prints out the elements in a format, takes in arguments from the command line
int main( int argc, char * argv[] )
{
    //if the argument in the command line is less than two, print out an error message and end the program	
    if ( argc < 2 )
    {
        printf(" ERROR: Please provide at least one program argument.\n");
        return 0;
    }
    //clear out a certain amount of memory for the size of the structure and save it to a pointer
    element_t * elements = (element_t *)calloc( 118 , sizeof( element_t ) );
    //open up the file being read
    FILE * element_file = fopen( ELEMENT_FILENAME, "r" );
    //if the file is not empty, create an array that reads in info of the document
    if ( element_file != NULL )
    {
        char line[100];
        while( fgets(line, 100, element_file ) != NULL )
        {
            // remove newline character from line
            char * nl = strchr( line, '\n' );
            if ( nl )
            {
                *nl = '\0';
            }
			//search for commas within document, signifies new information being read in
            element_t e;
            char * str = strtok( line, "," );
            int col = 0;
            while ( str != NULL )
            {
				//switch statement to set the values for each element within the structure
                switch( col )
                {
                    case 0:
                        e.atomic_number = atoi( str );
                        break;
                    case 1:
                        strcpy( e.symbol, str );
                        break;
					case 2:
						strcpy( e.name, str );
						break;
					case 3:
						e.atomic_weight = atof( str );
						break;
					case 4:
						strcpy( e.state, str );
						break;
					case 5:
						strcpy( e.bonding_type, str);
						break;
					case 6:
						strcpy( e.discovered, str);
						break;
                }
                str = strtok( NULL, "," );
                col++;
            }
            elements[ e.atomic_number - 1 ] = e;
        }
        fclose( element_file );//close the file after being read
    }

    // process program arguments.
    int fileboolean = 0;//file boolean to see if the output will be read to the output or not
    FILE * output_f = NULL;
    int i;
    for( i = 1; i < argc; i++ )
    {
        if ( i == 1 ) // check for filename, indicated by a dot within command line
        {
            char * dot = strchr( argv[i], '.' );
            if ( dot )
            {
                // this is a filename, open up file to be output to
                fileboolean = 1; //set file boolean to 1 to signify true
				output_f = fopen( argv[i], "w" );
                continue;
            }
        
	}
        // Look up the element that was input into command line
        element_t * ele = find_element( elements, argv[i] );
        if ( ele )
        {
			//if the file is to be output to a document, print to said document
			if ( fileboolean == 1 ){
	   			print_element( ele, output_f );
			}
			//if no document is found, print to screen
			else{	
	 			printf("---------------\n");
	 			printf("| %d\t%.4lf\n", ele->atomic_number, ele->atomic_weight);
	 			printf("| %s\t%s\n", ele->symbol, ele->name);
	 			printf("| %s\n", ele->state);
	 			printf("| %s\n", ele->bonding_type);
	 			printf("| Found: %s\n", ele->discovered);
	 			printf("---------------\n");
			}
		}
		else //if the symbol read in is not an element found, print out error message
		{
			if ( fileboolean == 1 ){
	    		fprintf(output_f, "WARNING: No such element: %s\n", argv[i]);
			}
			else{
			printf("WARNING: No such element: %s\n", argv[i]);	
			}
		}   
    }
    return 0; //end the program
}

//print element function that prints out the element/outputs to a file input into command line
void print_element( element_t * list, FILE * output_file ){	
	 fprintf(output_file, "---------------\n");
	 fprintf(output_file, "| %d\t%.4lf\n", list->atomic_number, list->atomic_weight);
	 fprintf(output_file, "| %s\t%s\n", list->symbol, list->name);
	 fprintf(output_file, "| %s\n", list->state);
	 fprintf(output_file, "| %s\n", list->bonding_type);
	 fprintf(output_file, "| Found: %s\n", list->discovered);
	 fprintf(output_file, "---------------\n");
}

//fiind_element function that searches for element name within file input(element_db.csv)
element_t * find_element( element_t * list, char * symbol )
{
    int i;
    for( i = 0; i < 118; i++ )
    {
        if ( strcmp( list[i].symbol, symbol ) == 0 )
        {
            element_t * result = &list[i];
            return result;
        }
    }
    return NULL;
}

