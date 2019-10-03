void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Testing QTI Sensor");

  tone(4, 4000, 500);
  delay(500);

}

void loop() {
  // put your main code here, to run repeatedly:

  //charge capacitor for 1ms
  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);
  delay(1);

  //wait 1ms and let capcitor discharge
  pinMode(2, INPUT);
  delay(1);

  //read pin 2
  byte sensor1 = digitalRead(2);

  Serial.println(sensor1);
  delay(50);
}
