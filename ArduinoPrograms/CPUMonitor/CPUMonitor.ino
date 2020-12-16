/**
 *  AUTHOR:  Maximilian S Puglielli (MSP)
 *  CREATED: 2020.12.13
**/

#include <Arduino.h>

static constexpr byte CLOCK = 3;
static constexpr byte ADDR_BUS_DIGITAL_CNT = 12;
static constexpr byte ADDR_BUS_DIGITAL[ADDR_BUS_DIGITAL_CNT] = { 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 };
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

    attachInterrupt(digitalPinToInterrupt(CLOCK), OnClockRise, RISING);
}

void loop(void)
{
    // OnClockRise();
    // delay(1000);
}

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
    unsigned int addr = 0x0;
    {
        const byte* ptr = ADDR_BUS_DIGITAL;
        const byte* const end = ptr + ADDR_BUS_DIGITAL_CNT;
        for (; ptr < end; ptr++)
        {
            addr <<= 1;
            addr |= (digitalRead(*ptr) ? 0x1 : 0x0);
        }
    }
    addr &= 0xFFF;
    addr |= 0xF000;
    Serial.print(addr, BIN);
    Serial.print("    ");
    Serial.print(addr, HEX);
    Serial.print("    ");
    Serial.println(addr, DEC);
}
