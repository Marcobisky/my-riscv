ENTRY(_start)

MEMORY
{
	/* boot rom */
	FLASH (rwx) : ORIGIN = 0x80000000, LENGTH = 5120K
	/* gpio and so on */
	PERIPHERAL(rwx): ORIGIN = 0xA0000000, LENGTH = 128K
	RAM (rwx) : ORIGIN = 0x02000000, LENGTH = 128K
}

SECTIONS
{
	. = ALIGN(4);
	.text 0x80000000: {
		*(.text)
		_etext = .;
	} > FLASH
}
