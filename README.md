# BareMetalBBB
My sandbox for learning how to get started with the AM3358 on the Beagle Bone Black, but with bare metal. I'm following along with these
two repositories as my guides, and will be replicating a lot of what they do.

https://github.com/allexoll/BBB-BareMetal

https://github.com/auselen/down-to-the-bone


# Uploading Binary Blobs Via UART
## Discovery Process
It turns out that these programs can be uploaded to the internal SRAM of the device simply by using
UART. The process ends up being quite simple, but it took forever to figure out what to do as the internet is consumed
with using the BBB to run Linux, while this is project is about understanding bare metal programming. Coming
from a background of STM32 style devices that program directly via JTAG/SWD, this UART approach is new and weird.

I was initially concerned about binary loading over UART after reading
the Technical Reference Manual's section on initialization as it seemed like some special modifications would
need to be made to the loadable file to allow the on-chip boot ROM software to decode the image. That's likely
going to come into play later for more complex images, but for now the boot ROM can handle a simple dump via
the XMODEM protocol and auto-magically start the software when completed.

## Transfering the Data
You're going to want to place the BBB internal boot ROM into the UART boot mode. This can be accomplished by
powering the device through the 5v barrel jack while holding down S2. Don't power via the P4 USB port as that
seems to cause the ROM to look for boot info via USB/TFTP. To date I haven't gotten that working. You'll know
you've successfully booted into the UART mode if you attach a serial cable to the device and see a steady stream
of 'C' characters coming across the screen.

Once you get to this step, use your favorite terminal to send your binary file via the XMODEM protocol. The way
I did this was via minicom, which I'll leave to you to figure out using the power of Google. It's pretty easy.