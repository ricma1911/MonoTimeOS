ENTRY(_start)
SECTIONS
{
    .multiboot 0x1000000 : 
    {
        *(.multiboot)
    }
}