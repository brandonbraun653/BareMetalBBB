# Turn on an LED

This example uses raw assembly to turn on one of the LEDs. I haven't used assembly since a tiny 8051 project in college many years ago, so there
are likely going to be an abundance of comments, most of them pointless to more knowledgeable people. This is just my learning process, so please
ignore it.

What I'm trying to get out of this example:
1. Understand how to load a minimal program to the BBB
2. Learn some of the assembly language syntax

Bonus Things:
1. Be able to debug the program and step through it


## Notes As I Go
I learned that ".equ" statements are effectively creating constants, just like "#define" in C.



## Program the BIN
flashrom -p buspirate_spi:dev=/dev/ttyUSB1 -c AT25SF081 --layout rom.layout --image normal -w led_on_ti_boot_image.bin
