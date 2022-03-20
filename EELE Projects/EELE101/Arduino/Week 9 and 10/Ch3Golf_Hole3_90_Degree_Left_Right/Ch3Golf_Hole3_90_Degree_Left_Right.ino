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
  Serial.println("Move forward 1 foot");
  moveForward1ft();

///////////////////////////////////////////////////////////  
  Serial.println("Spin right 90 degrees");
  turnRight90();
  
/////////////////////////////////////////////////////////
  Serial.println("Move forward 1 foot");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(1750);
////////////////////////////////////////////////////////////
  Serial.println("Spin left 90 degrees");
  turnLeft90();

//////////////////////////////////////////////////////////
  Serial.println("Move forward");
  moveForward1ft();


/////////////////////////////////////////////////////////
  Serial.println("Stop the servos.");
  stopServos();

}

void loop() {
  // put your main code here, to run repeatedly:

}
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//Function "turnRight 90()"

void turnRight90()
{
  servoLeft.writeMicroseconds(1600);    //counter-clockwise
  servoRight.writeMicroseconds(1600);   //counter-clockwise
  delay(600);
}

void turnLeft90()
{
  servoLeft.writeMicroseconds(1400);    //counter-clockwise
  servoRight.writeMicroseconds(1400);   //counter-clockwise
  delay(600);
}

void moveForward1ft()
{
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(2167);
}

void stopServos()
{
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
}

  
