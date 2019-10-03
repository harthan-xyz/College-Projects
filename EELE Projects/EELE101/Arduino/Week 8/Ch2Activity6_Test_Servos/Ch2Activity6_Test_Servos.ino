#include<Servo.h>

Servo servoLeft;  //declaring instances of the motors
Servo servoRight; 
void setup() {
  Serial.begin(9600);
  Serial.print("Activity 6 - Test Servos\n");

  servoLeft.attach(13);   //attach servos and tell pin numbers they are on
  servoRight.attach(12);

  Serial.print("Telling servos to stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  Serial.print("Just sent signal.\n");
}

void loop() {
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
}
