#include <Servo.h>

Servo servoLeft;
Servo servoRight;

void setup() {
  // put your setup code here, to run once:
servoLeft.attach(11);
servoRight.attach(12);
halt();
delay (1000);

}

void loop() {
  // put your main code here, to run repeatedly:

}
void halt ()
{
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
}

