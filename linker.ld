ENTRY(_start)
SECTIONS
{
    .multiboot 0x10 : 
    {
        *(.multiboot) /* * is "from every object file" */ /*!!! KEEP to do !!!*/
    }
    .bss . : /* . is location counter */ /* !!! ALIGN() maybe to do  !!! */
    {
        *(.bss)
    }
    .data . : 
    {
        *(.data)
    }
    .text . : 
    {
        *(.text)
    }

}