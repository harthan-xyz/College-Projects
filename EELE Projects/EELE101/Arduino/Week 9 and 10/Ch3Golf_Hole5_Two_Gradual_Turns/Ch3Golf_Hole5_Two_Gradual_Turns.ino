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

//////////////////////////////////////////////////////////
  Serial.println("Move forward");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(800);

//////////////////////////////////////////////////////////
  Serial.println("Move gradually to the right");
  moveGradualRight();
  
//////////////////////////////////////////////////////////
  Serial.println("Move forward");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(1750);

//////////////////////////////////////////////////////////
  Serial.println("Move gradually to the left");
  moveGradualLeft();
  

//////////////////////////////////////////////////////////
  Serial.println("Move forward");
  servoLeft.writeMicroseconds(1700);    //counter-clockwise
  servoRight.writeMicroseconds(1300);   //clockwise
  delay(2000);


/////////////////////////////////////////////////////////
  Serial.println("Stop the servos.");
  stopServos();

}

void loop() {
  // put your main code here, to run repeatedly:

}
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

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

void moveGradualRight()
{
  servoLeft.writeMicroseconds(1700);
  servoRight.writeMicroseconds(1442);
  delay(5000);
}


void moveGradualLeft()
{
  servoLeft.writeMicroseconds(1550);
  servoRight.writeMicroseconds(1422);
  delay(5200);
}

  
