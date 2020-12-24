/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  DATE:    2020.12.23
**/

#include <Arduino.h>

static constexpr byte PIN_CLK = 2;

void setup(void)
{
    Serial.begin(57600);
    Serial.println("SERIAL MONITOR BEGUN @ 57600 BAUD");

    pinMode(PIN_CLK, OUTPUT);
    digitalWrite(PIN_CLK, LOW);
}

void loop(void)
{
    if (Serial.available() &&
        Serial.read() == 10)
        Pulse();
}

void Pulse(void)
{
    digitalWrite(PIN_CLK, HIGH);
    delay(10);
    digitalWrite(PIN_CLK, LOW);
}
