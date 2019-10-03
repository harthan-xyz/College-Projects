#include <Servo.h>

Servo servoLeft;
Servo servoRight;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Testing Line Follower");

  //play four tones
  tone(4, 500, 500); delay (500);
  tone(4, 1500, 500); delay(500);
  tone(4, 1000, 500); delay(500);
  tone(4, 2000, 500); delay(500);

  //setup servos
  servoLeft.attach(11);
  servoRight.attach(12);
  halt();
  delay(1000);

  //setup whiskers
  pinMode(5, INPUT);  //left whisker
  pinMode(7, INPUT);  //right whisker
}

void loop() {
  // put your main code here, to run repeatedly:

  //read whiskers
  byte wLeft = digitalRead(5); //read from left whisker
  byte wRight = digitalRead(7); //read from right whisker

  //charge capacitor for 1ms
  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);
  delay(1);

  //wait 1ms and let capcitor discharge
  pinMode(2, INPUT);
  delay(1);

  //read pin 2
  byte sensor1 = digitalRead(2);

  //motion

  if ((wLeft == 0) || (wRight == 0))
  {
   halt();
   delay(10);
   tone(4,6000, 10);
   delay(10); 
  }
  else if (sensor1 == 0) //light part of surface
  {
    veerLeft(5);
  }
  else //if on dark part of surface
  {
    veerRight(5);
  }
}

//functions
void veerLeft(int time)
{
  servoLeft.writeMicroseconds(1500 + 25);
  servoRight.writeMicroseconds(1500 - 75);
  delay(time);
}
void veerRight(int time)
{
  servoLeft.writeMicroseconds(1500 + 75);
  servoRight.writeMicroseconds(1500 - 25);
  delay(time);
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
