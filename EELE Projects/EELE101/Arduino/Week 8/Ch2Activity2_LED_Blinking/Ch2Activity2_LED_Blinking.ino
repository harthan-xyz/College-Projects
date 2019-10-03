void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.print("Activity 2 - LED Blinking\n");

  pinMode(13, OUTPUT); //set pin 13 as an output
  pinMode(12, OUTPUT); //set pin 12 as an output
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print("Turning LEDs ON\n");
  digitalWrite(13, HIGH); //Turn on LED on pin 13
  digitalWrite(12, HIGH); //Turn on LED on pin 12
  delay(1000);
    
  Serial.print("Turning LEDs OFF\n");
  digitalWrite(13, LOW); //Turn on LED off pin 13
  digitalWrite(12, LOW); //Turn on LED off pin 12
  delay(1000);
}
