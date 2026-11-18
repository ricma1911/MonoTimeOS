ENTRY(_start)

PHDRS
{
    LOAD_1 PT_LOAD FLAGS(0x6); /* RW = 0x6 */
    LOAD_2 PT_LOAD FLAGS(0x5); /* RE = 0x5*/
}
SECTIONS
{
    .multiboot 0x10 : 
    {
        *(.multiboot) /* * is "from every object file" */ /*!!! KEEP to do !!!*/
    } : LOAD_2
    .bss . : /* . is location counter */ /* !!! ALIGN() maybe to do  !!! */
    {
        *(.bss)
    } : LOAD_1
    .data . : 
    {
        *(.data)
    } : LOAD_1
    .text . : 
    {
        *(.text)
    } : LOAD_2

}