ENTRY(_start)

MEMORY
{
    /* Boot ROM */
    FLASH (rx) : ORIGIN = 0x80000000, LENGTH = 5120K
    /* GPIO and Peripherals */
    PERIPHERAL (rwx) : ORIGIN = 0xA0000000, LENGTH = 128K
    /* SRAM */
    RAM (rwx) : ORIGIN = 0x2000000, LENGTH = 128K
}

SECTIONS
{
    /* Place code and constants in RAM */
    .text : {
        _start = .;               /* Mark the start of the text section */
        *(.starttext)             /* Include .starttext (reset handler) */
        *(.text*)                 /* Include all .text sections from object files */
        *(.rodata*)               /* Include read-only data */
        _etext = .;               /* Mark the end of the text section */
    } > RAM

    /* Place data in RAM */
    .data : {
        _sdata = .;               /* Start of initialized data */
        *(.data*)                 /* Include all .data sections */
        _edata = .;               /* End of initialized data */
    } > RAM

    /* Place uninitialized variables in RAM */
    .bss : {
        _sbss = .;                /* Start of uninitialized data */
        *(COMMON)                 /* Include common uninitialized data */
        *(.bss*)                  /* Include all .bss sections */
        _ebss = .;                /* End of uninitialized data */
    } > RAM
}