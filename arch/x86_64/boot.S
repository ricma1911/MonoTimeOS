.intel_syntax noprefix
.section .multiboot, "a"
.balign 8
multiboot2_header:
    .long 0xE85250D6 # magic
    .long 0 # architecture: i386(32-bit x86 protected mode)
    .long 16 + 8 # header_length: 16 bytes + 8 bytes for end tag
    .long 0x100000000 - (0xE85250D6 + 0 + 24) #checksum, magic + architecture + hl + checksum = 0, I use 0x100000000 to have a positve number
    #end tag
    .short 0 # type of tag (0 for end)
    .short 0 # flags: value is 0 because end tag is mandatory
    .long 8 # end tag size in bytes

.bss 
    stack_bottom: 
    .space 1 << 14 # stack size 2^14 bytes (16 KB)
    stack_top:

.text
.code32
.globl _start
_start:
    mov esp, offset stack_top 

    #TO DO 

    #END
    cli 
    halt:
        hlt 
    jmp halt