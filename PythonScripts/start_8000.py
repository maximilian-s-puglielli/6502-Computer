rom = bytearray([0xEA] * 32768)

rom[0x7FFC] = 0x00
rom[0x7FFD] = 0x80

with open("rom.bin", "wb") as out:
    out.write(rom)
