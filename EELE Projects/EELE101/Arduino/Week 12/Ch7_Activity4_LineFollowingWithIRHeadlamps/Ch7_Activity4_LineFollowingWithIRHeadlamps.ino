#include <Servo.h>

//create servo variables
Servo servoLeft;
Servo servoRight;

//functions
void veerLeft(int time)
{
  servoLeft.writeMicroseconds(1500 + 23);
  servoRight.writeMicroseconds(1500 - 77);
  delay(time);
}
void veerRight(int time)
{
  servoLeft.writeMicroseconds(1500 + 77);
  servoRight.writeMicroseconds(1500 - 23);
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

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Line Follower with IR");

  //play tones
  int i;  //index number
  //array for the notes
  int note[] = {493.88, 587.33, 440, 392, 440, 494.88, 587.33, 440, 493.88, 587.33, 880, 783.99, 587.33, 523.25, 493.88, 440};  
  //array for the length of notes
  int noteLength[] = {1000, 500, 1000, 250, 250, 1000, 500, 1275, 1000, 500, 1000, 500, 1000, 250, 250, 1000};
  for (i=0; i<16; i=i+1) //for loop to play the tones
  {
    tone(4, note[i], noteLength[i]);  //play the tone on pin 4, for the note array, for the note length array
    delay(noteLength[i]); //delay for the differing notelengths set by array 
  }


  //setup servos
  servoLeft.attach(11);
  servoRight.attach(12);
  halt();
  delay(1000);

  //setup IR Headlamps Right 
  pinMode(3, OUTPUT);  //left whisker
  pinMode(5, INPUT);  //right whisker

  //setup IR Headlamps Left
  pinMode(9, OUTPUT); //IR LED
  pinMode(10, INPUT); //IR detector
}

void loop() {

  //setup the ir led
  tone(3, 38000, 8);
  delay(1);
  byte irDetect = digitalRead(5);
  delay(2);
  
  //charge capacitors for 1ms
  pinMode(3, OUTPUT);
  digitalWrite(3, HIGH);
  pinMode(6, OUTPUT);
  digitalWrite(6, HIGH);
  pinMode(9, OUTPUT);
  digitalWrite(9, HIGH);
  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
  delay(1);

  //wait 1ms and let capcitors discharge
  pinMode(3, INPUT);
  pinMode(6, INPUT);
  pinMode(9, INPUT);
  pinMode(13, INPUT);
  delay(1);

  //read pins
  byte sensor2 = digitalRead(3); //inside right sensor
  byte sensor3 = digitalRead(6); //inside left sensor
  byte sensor1 = digitalRead(9); //outside right sensor
  byte sensor4 = digitalRead(13);//outside left sensor

  //print out the readings of the sensors
  Serial.print(sensor1);
  Serial.print(sensor2);
  Serial.print(sensor3);
  Serial.print(sensor4);
  Serial.println();
  
  //motion
  if ((irDetect == 0)) //if the ir detector senses something in front of it, stop and play a tone
  { 
   halt();
   delay(8);
   tone(4, 500, 5);
   delay(5);
  }
  if (sensor2 == 1 || sensor3 == 1) //if the inside sensors are on black, move forward
  {
     moveForward(3);
  }
  if (sensor1 == 1 && sensor3 == 0) //if the outside right sensor is on white and the inside left sensor is on black, turn right
  {
    veerRight(3);
  }
  if (sensor2 == 0 && sensor4 == 1) //if the inside left sensor is on white and the outside left sensor is on black, turn left
  {
    veerLeft(3);
  }
}


