void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); //9600 BAUD rate for USB connection
  Serial.print("--- Activity 2 - Hello World on the Arduino ----\n"); //print function to print text
  Serial.println("Joshua Harthan"); //println function to print my name on a new line
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Hello World");  //println function to print hello world on a new line
  delay(500);   //delay of 500ms, prints hello world every .5 seconds
}
