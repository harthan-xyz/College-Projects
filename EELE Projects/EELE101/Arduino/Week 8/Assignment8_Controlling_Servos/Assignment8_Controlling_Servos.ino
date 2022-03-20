#include<Servo.h> //include servo library

Servo servoLeft;  //declaring instances of the motors
Servo servoRight; 
void setup() {
  Serial.begin(9600); //BAUD number for serial monitor
  Serial.print("Activity 6 - Test Servos\n");

  servoLeft.attach(11);   //attach servos and tell pin numbers they are on
  servoRight.attach(12);

  //start the servos in the off position
  Serial.print("Telling servos to stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  Serial.print("Just sent signal.\n");
}

void loop() {
//spin left servo clockwise and counterclockwise every second
/////////////////////////////////////////////////////////  
  Serial.print("LEFT servo spinning clockwise.\n");
  servoLeft.writeMicroseconds(1300);
  servoRight.writeMicroseconds(1500);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

////////////////////////////////////////////////////////////  
  Serial.print("LEFT servo spinning counterclockwise.\n");
  servoLeft.writeMicroseconds(1700);
  servoRight.writeMicroseconds(1500);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

//spin right servo clockwise and counterclockwise every second
 ///////////////////////////////////////////////////////////  
  Serial.print("RIGHT servo spinning clockwise.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1300);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

////////////////////////////////////////////////////////////  
  Serial.print("RIGHT servo spinning counterclockwise.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1700);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

//spin both servos clockwise and counterclockwise every second
/////////////////////////////////////////////////////////////  
  Serial.print("BOTH servos spinning clockwise.\n");
  servoLeft.writeMicroseconds(1300);
  servoRight.writeMicroseconds(1300);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

////////////////////////////////////////////////////////////  
  Serial.print("BOTH servos spinning counterclockwise.\n");
  servoLeft.writeMicroseconds(1700);
  servoRight.writeMicroseconds(1700);
  delay(1000);
    
  Serial.print("Stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);
}
