code = bytearray([
    0xa9, 0xff,         # load address ff into register A
    0x8d, 0x02, 0x60,   # store contents of register A to address 6002, (writes all 1's to set interface B port to output)

    0xa9, 0x55,         # load 55 into A ("0xa9" is memory address 8005)
    0x8d, 0x00, 0x60,   # store A into 6000 on interface which is port B which is set to output

    0xa9, 0xaa,         # load aa to A
    0x8d, 0x00, 0x60,   # store A into 6000 on interface which is port B which is set to output

    0x4c, 0x05, 0x80    # jump to 8005 (loop)
])

rom = code + bytearray( [0xea] * (32768 - len(code))) #program plus all the empty ea's

#cpu will look at ffc and ffd, little indian form to look for start address on rom chip which is 8000.
rom[0x7ffc]=0x00
rom[0x7ffd]=0x80

with open("rom.bin", "wb") as out_file:
    out_file.write(rom)