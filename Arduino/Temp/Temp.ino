/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  CREATED: 2020.12.15
**/

#include <Arduino.h>

static constexpr byte BLINK_CNT = 8;
static constexpr byte PIN_BLINK[BLINK_CNT] = { 3, 4, 5, 6, 7, 8, 9, 10 };
static constexpr byte PIN_CLK = 2;

void setup(void)
{
    Serial.begin(57600);
    Serial.println("SERIAL MONITOR BEGUN @ 57600 BAUD");

    {
        const byte* ptr = PIN_BLINK;
        const byte* const end = ptr + BLINK_CNT;
        for (; ptr < end; ptr++)
            pinMode( *ptr, INPUT );
    }

    pinMode(PIN_CLK, OUTPUT);
    digitalWrite(PIN_CLK, LOW);
}

void loop(void)
{
    if (Serial.available() &&
        Serial.read() == 10)
        PulseAndRead();
}

void PulseAndRead(void)
{
    digitalWrite(PIN_CLK, HIGH);
    delay(10);
    digitalWrite(PIN_CLK, LOW);
    unsigned short raw = 0x0;
    {
        const byte* ptr = PIN_BLINK;
        const byte* const end = ptr + BLINK_CNT;
        for (; ptr < end; ptr++)
        {
            raw <<= 0x1;
            raw |= (digitalRead( *ptr ) ? 0x1 : 0x0);
        }
    }
    raw &= 0x00FF;
    byte rd = (byte)(raw);
    Serial.print(rd, BIN);
    Serial.print(F("    "));
    Serial.print(rd, HEX);
    Serial.println();
    delay(10);
}
