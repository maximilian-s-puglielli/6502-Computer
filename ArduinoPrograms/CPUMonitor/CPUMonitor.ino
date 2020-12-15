/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  CREATED: 2020.12.13
**/

#include <Arduino.h>

static constexpr byte CLOCK = 2;
static constexpr byte ADDR_BUS_DIGITAL_CNT = 12;
static constexpr byte ADDR_BUS_DIGITAL[ADDR_BUS_DIGITAL_CNT] = { 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 1 };
// static constexpr byte ADDR_BUS_ANALOG_CNT = 4;
// static constexpr byte ADDR_BUS_ANALOG[ADDR_BUS_ANALOG_CNT] = { A3, A2, A1, A0 };

void setup(void)
{
    Serial.begin(57600);
    Serial.println();
    Serial.println("SERIAL MONITOR STARTED AT 57600 BAUD");

    pinMode(CLOCK, INPUT);
    {
        const byte* ptr = ADDR_BUS_DIGITAL;
        const byte* const end = ptr + ADDR_BUS_DIGITAL_CNT;
        for (; ptr < end; ptr++)
            pinMode(*ptr, INPUT);
    }

    attachInterrupt(digitalPinToInterrupt(CLOCK), OnClockRise, FALLING);
}

void loop(void) {}

void OnClockRise(void)
{
    // unsigned int addr = ( (analogRead(*ADDR_BUS_ANALOG) >= 512) ? 0x1 : 0x0 );
    // {
    //     const byte* ptr = ADDR_BUS_ANALOG + 1;
    //     const byte* const end = ptr + ADDR_BUS_ANALOG_CNT;
    //     for (; ptr < end; ptr++)
    //     {
    //         addr <<= 1;
    //         addr |= ( (analogRead(*ADDR_BUS_ANALOG) >= 512) ? 0x1 : 0x0 );
    //     }
    // }
    unsigned int addr = (digitalRead(*ADDR_BUS_DIGITAL) ? 0x1 : 0x0);
    {
        const byte* ptr = ADDR_BUS_DIGITAL + 1;
        const byte* const end = ptr + ADDR_BUS_DIGITAL_CNT;
        for (; ptr < end; ptr++)
        {
            addr <<= 1;
            addr |= (digitalRead(*ptr) ? 0x1 : 0x0);
        }
    }
    Serial.print(addr, BIN);
    Serial.print("    ");
    Serial.print(addr, HEX);
    Serial.print("    ");
    Serial.println(addr, DEC);
}
