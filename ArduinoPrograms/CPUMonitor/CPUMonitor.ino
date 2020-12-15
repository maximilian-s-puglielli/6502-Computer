/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  DATE:    2020.12.13
**/

#include <Arduino.h>

static constexpr byte ADDR_CNT = 12;
static constexpr byte ADDR_PINS[ADDR_CNT] = { 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 };
static constexpr byte CLK = 2;

void setup(void)
{
    Serial.begin(57600);
    Serial.println();
    Serial.println("SERIAL STARTED 57600");

    {
        const byte* ptr = ADDR_PINS;
        const byte* const end = ptr + ADDR_CNT;
        for (; ptr < end; ptr++)
            pinMode(*ptr, INPUT);
    }
    pinMode(CLK, INPUT);

    attachInterrupt(digitalPinToInterrupt(CLK), OnClockRise, FALLING);
}

void loop(void)
{}

void OnClockRise(void)
{
    unsigned short addr = 0;
    {
        const byte* ptr = ADDR_PINS;
        const byte* const end = ptr + ADDR_CNT;
        for (; ptr < end; ptr++)
        {
            addr <<= 1;
            addr |= (digitalRead(*ptr) ? 1 : 0);
        }
    }
    addr &= 0x0FFF;
    Serial.print(addr, BIN);
    Serial.print("    ");
    Serial.print(addr, HEX);
    Serial.print("    ");
    Serial.println(addr, DEC);
}
