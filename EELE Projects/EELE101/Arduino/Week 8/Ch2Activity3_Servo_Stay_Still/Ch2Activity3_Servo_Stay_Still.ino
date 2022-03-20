#include<Servo.h>

Servo servoLeft;  //declaring instances of the motors
Servo servoRight; 
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.print("Activity 3 - Servo Stay Still\n");

  servoLeft.attach(13);   //attach servos and tell pin numbers they are on
  servoRight.attach(12);

  Serial.print("Telling servos to stop.\n");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  Serial.print("Just sent signal.\n");
}

void loop() {
  // put your main code here, to run repeatedly:

}
