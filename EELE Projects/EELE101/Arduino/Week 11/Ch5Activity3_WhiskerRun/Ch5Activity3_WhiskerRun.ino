#include <Servo.h>

Servo servoLeft;
Servo servoRight;


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //BAUD
  Serial.println("Starting Whisker Roam Program...");

  pinMode(5, INPUT); //left whisker
  pinMode(7, INPUT); //right whisker

  //setup servos
  servoLeft.attach(11);
  servoRight.attach(10);

   halt();
   delay(1000);
   tone(4, 1000, 500);
   delay(500);
   
}

void loop() {
  // put your main code here, to run repeatedly:
  //two bytes to read in inputs
  byte wLeft = digitalRead(5);
  byte wRight = digitalRead(7);

  if ((wLeft == 0) && (wRight == 1)) //if left is pressed
  {
    //move backward and turn right
    tone (4, 1000, 50);
    delay(50);
    moveBackward(1500);
    turnRight90();
  }
  else  if ((wLeft == 1) && (wRight == 0)) //if right is pressed
  {
    //move backward and turn left
    tone (4, 2000, 50);
    delay(50);
    moveBackward(1500);
    turnLeft90();
  }
  else  if ((wLeft == 0) && (wRight == 0)) //if both are pressed
  {
    //move backward and turn around
    tone (4, 3000, 50);
    delay(50);
    moveBackward(1500);
    turnLeft90();
    turnLeft90();
  }
  else 
  {
    //automatically move forward
    moveForward(20);
  }
  
  Serial.print(wLeft);
  Serial.print(wRight);
  Serial.print("\n");
  delay(50);

}

void halt()
{
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
}
void moveForward(int time)
{
  servoLeft.writeMicroseconds(1700);
  servoRight.writeMicroseconds(1300);
  delay(time);
}
void moveBackward(int time)
{
  servoLeft.writeMicroseconds(1300);
  servoRight.writeMicroseconds(1700);
  delay(time);
}
void turnRight90()
{
  servoLeft.writeMicroseconds(1600);
  servoRight.writeMicroseconds(1600);
  delay(800); //adjust according to surface
}
void turnLeft90()
{
  servoLeft.writeMicroseconds(1400);
  servoRight.writeMicroseconds(1400);
  delay(800); //adjust according to surface
}



