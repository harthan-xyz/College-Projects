void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Starting Whisker Test Program...");

  pinMode(5, INPUT); //left whisker
  pinMode(7, INPUT); //right whisker

  
}

void loop() {
  // put your main code here, to run repeatedly:

  byte wLeft = digitalRead(5);
  byte wRight = digitalRead(7);

  if ((wLeft == 0) && (wRight == 1)) //left pressed
  {
    tone (4, 1000, 50);
    delay(50);
  }
  else  if ((wLeft == 1) && (wRight == 0)) //right pressed
  {
    tone (4, 2000, 50);
    delay(50);
  }
  else  if ((wLeft == 0) && (wRight == 0)) //both pressed
  {
    tone (4, 3000, 50);
    delay(50);
  }
  
  
  
  
  Serial.print(wLeft);
  Serial.print(wRight);
  Serial.print("\n");
  delay(50);

}
