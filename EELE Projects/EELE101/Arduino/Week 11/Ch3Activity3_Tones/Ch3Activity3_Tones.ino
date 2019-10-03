void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600); //BAUD
  Serial.println("Starting Tone Program");

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
}

void loop() {
// put your main code here, to run repeatedly:

}
