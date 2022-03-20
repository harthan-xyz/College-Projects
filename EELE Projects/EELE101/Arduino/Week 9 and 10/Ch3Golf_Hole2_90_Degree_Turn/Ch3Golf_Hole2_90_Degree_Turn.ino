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
  Serial.println("Move forward");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(2167);


/////////////////////////////////////////////////////////
  Serial.println("Spin right 90 degrees");
  servoLeft.writeMicroseconds(1600);    //counter-clockwise
  servoRight.writeMicroseconds(1600);   //counter-clockwise
  delay(600);

/////////////////////////////////////////////////////////
  Serial.println("Move forward");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(2750);


/////////////////////////////////////////////////////////
  Serial.println("Stop the servos.");
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);

}

void loop() {
  // put your main code here, to run repeatedly:

}
