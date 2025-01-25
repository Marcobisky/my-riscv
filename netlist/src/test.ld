MEMORY
{
    /* kernel memory */
    RAM (rwx): ORIGIN = 0x02000000, LENGTH = 128K
}

ENTRY(_start)

SECTIONS
{
    . = ALIGN(4);
    .text 0x02000000: {
        *(.text)
        _etext = .;
    } > RAM
}