/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  CREATED: 2020.12.15
**/

#include <Arduino.h>

static constexpr byte PIN_CLK = 3;

static volatile byte Var;

void setup(void)
{
    Serial.begin(57600);
    Serial.println();
    Serial.println("STARTED SERIAL MONITOR AT 57600 BAUD");

    pinMode(PIN_CLK, INPUT);

    attachInterrupt(digitalPinToInterrupt(PIN_CLK), OnClock, RISING);

    Var = 0;
}

void loop(void) {}

void OnClock(void)
{
    Serial.print("VAR: ");
    Serial.println(Var);
    Var++;
}
