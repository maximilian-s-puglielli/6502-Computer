AUTHOR:  Maximilian S Puglielli (MSP)<br>
AUTHOR:  Maxwell M Parker (MMP)<br>
DATE:    2020.12.13<br>
VERSION: 1.0.0.0<br>

# 6502 8-bit Breadboarded Computer Project

This is our attempt at Ben Eater's 6502 8-bit Computer project.  Here are some links to his website where we bought all the materials and his YouTube video tutorials.

## Ben Eater's Website

  - [eater.net](https://eater.net)
  - [eater.net/6502](https://eater.net/6502)

## Adjustable 555 Timer

  - [Part #1](https://www.youtube.com/watch?v=kRlSFm519Bo)
  - [Part #2](https://www.youtube.com/watch?v=81BgFhm2vz8)
  - [Part #3](https://www.youtube.com/watch?v=WCwJNnx36Rk)
  - [Part #4](https://www.youtube.com/watch?v=SmQ5K7UQPMM)

## 6502 Computer

  - [Why build an entire computer on breadboards?](https://www.youtube.com/watch?v=fCbAafKLqC8&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=8)
  - [Full Playlist](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH)
  - [Part #1: "Hello, world" from scratch on a 6502](https://www.youtube.com/watch?v=LnzuMJLZRdU&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=1)
  - [Part #2: How do CPUs read machine code?](https://www.youtube.com/watch?v=yl8vPW5hydQ&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=2)
  - [Part #3: Assembly language vs. machine code](https://www.youtube.com/watch?v=oO8_2JJV0B4&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=3)
  - [Part #4: Connecting an LCD to our computer](https://www.youtube.com/watch?v=FY3zTUaykVo&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=4)
  - [Part #5: What is a stack and how does it work?](https://www.youtube.com/watch?v=xBjQVxVxOxc&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=5)
  - [Part #6: RAM and bus timing](https://www.youtube.com/watch?v=i_wrxBdXTgM&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=6)
  - [Part #7: Subroutine calls, now with RAM](https://www.youtube.com/watch?v=omI0MrTWiMU&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=7)
  - [How assembly language loops work](https://www.youtube.com/watch?v=ZYJIakkcLYw&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=9)
  - [Binary to decimal can't be that hard, right?](https://www.youtube.com/watch?v=v3-a-zqKfgA&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=10)
  - [Hardware interrupts](https://www.youtube.com/watch?v=DlEa8kd7n3Q&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=11)
  - [Interrupt handling](https://www.youtube.com/watch?v=oOYA-jsWTmc&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH&index=12)

## Schematic

![6502 Schematic](.\6502Schematic.png)

## Data Sheets

  - [Microprocessor (CPU): W65C02](https://eater.net/datasheets/w65c02s.pdf)
  - [Interface Adapter (VIA): W65C22](https://eater.net/datasheets/w65c22.pdf)
  - [Display Controller (LCD)](https://eater.net/datasheets/HD44780.pdf)
  - [NAND Gate Chip](https://eater.net/datasheets/74hc00.pdf)
  - [Program Memory (EEPROM): 28C256](https://eater.net/datasheets/28c256.pdf)
  - [Data Memory (SRAM): 62256](https://eater.net/datasheets/hm62256b.pdf)

# Documentation (Last Updated 12/16/20)
## Clock Construction and Testing
Building a working CPU clock that allowed for automatic and manual pulsing took several attempts. At the time of writing this, it is unclear *why* the clock initially continued to exhibit bouncing behavior. The issue was debugged by looking at each module of the clock and double checking connections. In addition signals were tested in essential areas to make sure the wires themselves were functioning properly. No mistakes were found during this stage of debugging, yet the clock still showed bouncing behavior. A full rebuild of the clock was made from scratch. The full rebuild although appearing identical to the original does not have the same problem. This was a large expenditure of time. Ultimately, the final clock build was functional and accepted to be complete for the purposes of this project. 

### Note on Clock Validation: 
The clock does not allow the user to precisely set the timing. As a result, observing LED illumination was satisfactory for debugging in most cases. For the button bouncing issue, it was much harder to observe the problem without electronic tools. The Arduino and it's built-in interrupt functionality was used to print a line to the computer console every time the clock pulsed. If the button bounced, more than one line would print to the console with only one button press. Although not for sure, it was likely that the Arduino did not deliver reliably for the entirety of the debugging process. There was inconsistency between the documentation and observed behavior of the Arduino regarding the interrupt pin. It is possible that the prepossessor macros were labeled incorrectly.  

## CPU Construction and Testing
The CPU was connected to the breadboard and wired up per the schematics. There were two stages of this process: (1) the **NO-OP** code was manually wired to the data pins using resistors, (2) the same **NO-OP** code was programmed into the ROM and wired to the CPU. In theory, these steps should have resulted in the same instructions and outputs to and from the CPU. During the entire process, there was lots of "unexplained" variability in results. It is likely that human error was responsible for this variation, although it was impossible to observe from the exhaustive testing that was done. Eventually, the CPU printed what was expected from the hard wired NO-OP code. 

Connecting the ROM chip with the same NO-OP code resulted in odd behavior for a long time once again. Eventually, correct behavior was observed in conjunction with new insight at this point in the process(see Note on CPU Reset).

### Note on CPU Reset
The CPU in this project has a reset cycle like most CPUs. It is important to note, that the startup operations are not always identical. This was determined from experimentation and debugging. It appears that these start codes are not significant to any functionality. The last few CPU outputs from the reset operation are always the same however. This matches the documentation's description of the reset operation. The documentation does not say anything about the beginning of the reset operation which appears to be random. 

Strange behavior that would affect the computer's overall operation was noted when the reset operation was done incorrectly. Through experimentation, it was determined that disconnecting all power resulted in a proper reset but not the reset button. **This is because the reset pin (button) must be held LOW for at least 2 clock cycles before releasing.** After a proper reset, the CPU should execute 7 cycles and the last two outputs are intentional. 

### Notes on CPU Validation
LED's were used to read bits manually for each CPU cycle. Binary was written down and converted to hexadecimal. This was how all debugging was done. Normally, the arduino would print these operations instantly, however, it was difficult to determine whether the Arduino interrupt pin was causing issues. 

## CPU Interface
The CPU interface was successfully connected and operational. Binaries were written both manually and with assembly to test functionality. The "blinking" LED sequence was successfully written to the rom. This was one of the smoother steps of the process with few hiccups.

## LCD "HELLOWORLD"
The LCD was connected to the interface chip. In theory, this should not have changed any of the hardware assembled before this. The Hello World program was made in assembly. It did not work. The CPU instructions froze and only outputted an "H" on the LCD screen. To confirm that this was not a programming issue, Ben Eater's code was directly burned to the ROM. The same behavior was observed. Connecting LED's and the LCD to the output shows that the output is behaving as expected for our old programs but not our new Hello World program. It is unclear if this is a software or hardware issue since both are fully functional in isolated situations:
| Program Configuration | Hardware Configuration | Result |
|-|-|-|
|Blinking Code|Interface,LEDs|Blinking Lights|
|Blinking Code|Interface,LCD,LEDs|Blinking Lights|
|Hello Code| Interface,LCD,LEDs| "H" and Freeze

### Debugging Notes
- LCD always stops on an H. 
- Plugging in an unrelated LED caused the CPU to go forward. 
- Some sort of electrical and programming issue. 
- Replacing the ROM chip **fixed this issue.** It appears that flashing time and time again caused fatigue failure in the pins and prevented a reliable connection between ROM and CPU

**DECISION:** It was decided to flash the ROM chip with assembly code from Ben Eater that represents the final state of the project. There will be no more flashing after this to prevent the pin fatigue issue until a solution is found. 

## RAM Chip 
-

## Takeaways for Computer #2
-
