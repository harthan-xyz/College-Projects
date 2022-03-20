//global variables
int A,B,C;  

void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600); //BAUD connection
  Serial.print("---Assignment 7 - User Input---\n\n"); //print assignment 7 statement
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print("Enter the first integer between 0-9: "); //ask for user to enter int between 0 and 9
  while(Serial.available() == 0) {} //user input, sit in loop
  A = Serial.read() - 48; //convert ASCII to an int using subtraction
  //you entered the value:, with line break
  Serial.print("You entered: ");
  Serial.print(A);
  Serial.print("\n");

  Serial.print("Enter the second integer between 0-9: "); //ask user to enter int between 0 and 9
  while(Serial.available() == 0) {} //user input, sit in loop
  B = Serial.read();  //read B from serial monitor
  // convert ASCII to an int using a switch and case statement
  switch (B) 
  {
      //take in the char value, convert it to an int
      case '0' : B = 0; break;
      case '1' : B = 1; break;
      case '2' : B = 2; break;
      case '3' : B = 3; break;
      case '4' : B = 4; break;
      case '5' : B = 5; break;      
      case '6' : B = 6; break;
      case '7' : B = 7; break;
      case '8' : B = 8; break;
      case '9' : B = 9; break;
      default  : B = 0;  //if user enters any char besides 0-9
  }
  Serial.print("You entered: ");
  Serial.print(B);
  Serial.print("\n");

  //add A and B together to get C
  C = A + B;
  Serial.print("The sum of the two integers is: ");
  Serial.println(C);

   //determine if c is prime or not using switch/case statements
   switch (C){
      case 0  : Serial.println("The sum is NOT a prime number.\n");  break;
      case 1  : Serial.println("The sum is NOT a prime number.\n");  break;
      case 2  : Serial.println("The sum IS a prime number.\n");      break;      
      case 3  : Serial.println("The sum IS a prime number.\n");      break;
      case 4  : Serial.println("The sum is NOT a prime number.\n");  break;
      case 5  : Serial.println("The sum IS a prime number.\n");      break;      
      case 6  : Serial.println("The sum is NOT a prime number.\n");  break;
      case 7  : Serial.println("The sum IS a prime number.\n");      break;
      case 8  : Serial.println("The sum is NOT a prime number.\n");  break;      
      case 9  : Serial.println("The sum is NOT a prime number.\n");  break;
      case 10 : Serial.println("The sum is NOT a prime number.\n");  break;
      case 11 : Serial.println("The sum IS a prime number.\n");      break;      
      case 12 : Serial.println("The sum is NOT a prime number.\n");  break;
      case 13 : Serial.println("The sum IS a prime number.\n");      break;
      case 14 : Serial.println("The sum is NOT a prime number.\n");  break;      
      case 15 : Serial.println("The sum is NOT a prime number.\n");  break;
      case 16 : Serial.println("The sum is NOT a prime number.\n");  break;
      case 17 : Serial.println("The sum IS a prime number.\n");      break;      
      case 18 : Serial.println("The sum is NOT a prime number.\n");  break;
      default : Serial.println("The sum is not between 0 and 18.\n");break;
    }  
}
