/* Turns on led USR0

The electrical connection for this can be found on page 6 of the schematics.
It looks like it connects to pin V15, which is GPIO1_21.
*/

/* Base address for the clock module peripheral region for GPIO1 is found in Table 2-2.
CM_PER register (0x44e00000). The actual register is at offset 0xAC, TRM 8.1.12.1.29 */
.equ REG_CM_PER_GPIO1_CLKCTRL, 0x44e000AC

/* Base address for GPIO1 (0x4804C000) is found in TRM table 2-3. The offset of the
OE register is 0x134, DATAOUT is 0x13C */
.equ REG_GPIO01_OE, 0x4804C134
.equ REG_GPIO01_DATAOUT, 0x4804C13C

/* I guess the linker needs this as some default starting point */
_start:
  /* Configure the processor mode to let us do whatever we want */
  mrs r0, cpsr                        @ copy the CPSR to r0
  bic r0, r0, #0x1F                   @ clear the mode bits so we start from a known state
  orr r0, r0, #0x13                   @ set SVC mode, defined in ARM Table B1-1. CPSR M[4:0] bits
  orr r0, r0, #0xC0                   @ disable (mask) FIQ and IRQ. These are the CPSR I/F bits
  msr cpsr, r0                        @ copy modified r0 into CPSR

  /* Set clock for GPIO1, TRM 8.1.12.1.29 */
  ldr r0, =REG_CM_PER_GPIO1_CLKCTRL   @ Place address of clock register into R0
  ldr r1, =0x40002                    @ Place value to assign into R1. Enable OFC and periph clock
  str r1, [r0]                        @ Mem store val of R1 -> R0

  /* Set pin 21 for output, led USR0, TRM 25.4.1.16 */
  ldr r0, =REG_GPIO01_OE              @ Place address of GPIO1 OE register to R0
  ldr r1, [r0]                        @ Read value of GPIO01 OE into R1
  bic r1, r1, #(1<<21)                @ Clear the 21st bit, turning pin 21 into an output
  str r1, [r0]                        @ Assign modified value back to GPIO1 OE

  /* Turn on the led, TRM 25.4.1.18 */
  ldr r0, =REG_GPIO01_DATAOUT         @ Place address of GPIO01 DATAOUT register to R0
  ldr r1, [r0]                        @ Read current value of DATAOUT
  orr r1, r1, #(1<<21)                @ Set bit 21 to turn on USR0
  str r1, [r0]                        @ Write new value back to DATAOUT


/* Idle away to infinity */
.loop:
  b .loop
