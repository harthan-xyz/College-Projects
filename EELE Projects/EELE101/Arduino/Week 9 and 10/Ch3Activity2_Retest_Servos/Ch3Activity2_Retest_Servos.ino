#include <Servo.h>

Servo servoLeft;
Servo servoRight;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  servoLeft.attach(11);
  servoRight.attach(10);

  Serial.println("Stop the servos for 1 second.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Move forward for 1 second.");
  servoLeft.writeMicroseconds(1550);    //counter-clockwise
  servoRight.writeMicroseconds(1450);   //clockwise
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Stop the servos for 1 second.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

 /////////////////////////////////////////////////////////
  Serial.println("Move backward for 1 second.");
  servoLeft.writeMicroseconds(1450);    //clockwise
  servoRight.writeMicroseconds(1550);   //counter-clockwise
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Stop the servos for 1 second.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Spin Right");
  servoLeft.writeMicroseconds(1550);    //counter-clockwise
  servoRight.writeMicroseconds(1550);   //counter-clockwise
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Stop the servos for 1 second.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);

  
/////////////////////////////////////////////////////////
  Serial.println("Spin Left");
  servoLeft.writeMicroseconds(1450);    //counter-clockwise
  servoRight.writeMicroseconds(1450);   //counter-clockwise
  delay(1000);

/////////////////////////////////////////////////////////
  Serial.println("Stop the servos for 1 second.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(1000);
}

void loop() {
  // put your main code here, to run repeatedly:

}
