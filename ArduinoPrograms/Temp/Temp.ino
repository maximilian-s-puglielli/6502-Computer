/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  DATE:    2020.12.15
**/

#include <Arduino.h>

static constexpr byte A_IN_PIN = A0;

void setup(void)
{
    Serial.begin(57600);
    Serial.println();
    Serial.println("STARTED SERIAL MONITOR AT 57600 BAUD");
}

void loop(void)
{
    int rd = analogRead(A_IN_PIN);
    Serial.print("READ: ");
    Serial.println(rd);
    delay(1000);
}