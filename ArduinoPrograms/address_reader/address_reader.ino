const char ADDR[] = {1,3,4,5,6,7,8,9,10,11,12,13};

void setup() {
  for(int i = 0; i<12; i++)
  {
    pinMode(ADDR[i], INPUT);
  }
  pinMode(2, INPUT);
  attachInterrupt(digitalPinToInterrupt(2), onClock,RISING);
  Serial.begin(57600);
}
void onClock()
{
  char hexshit[15];
  unsigned int address = 0;
  for(int i = 0; i < 12; i++)
  {
    int bit = digitalRead(ADDR[i]) ? 1 : 0;
    Serial.print(bit);
    address=(address <<1)+bit;
  }
  sprintf(hexshit,"   %04x",address);
  Serial.println(hexshit);
}
void loop() {
}
