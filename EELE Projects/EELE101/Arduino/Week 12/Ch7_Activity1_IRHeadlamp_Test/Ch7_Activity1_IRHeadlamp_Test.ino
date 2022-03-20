void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Starting IR Headlamp Test...");

  tone(4, 3000, 500);
  delay(500);

  pinMode(3, OUTPUT); //IR LED
  pinMode(5, INPUT);  //IR detector
  pinMode(7, OUTPUT); //IR LED
  pinMode(8, INPUT); // IR detector
  
}

void loop() {
  // put your main code here, to run repeatedly:

  tone(3, 38000, 8);
  delay(1);
  byte ir = digitalRead(5);
  delay(100);

  Serial.println(ir);
  
  tone(7, 38000, 8); //turned on IR pulse
  delay(1);
  byte irDetect = digitalRead(8);
  delay(100);

  //Serial.println(irDetect);

//  if (irDetect == 0)
//  {
//  tone(4, 4000, 100);
//  delay(100);    
//  }

}
