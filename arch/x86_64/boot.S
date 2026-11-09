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

.bss 
.balign 4096 # 2^12, alignment for paging tables
pml4:
    .space 1 << 12 # PML4
pdpt:
    .space 1 << 12 # PDPT
pd:
    .space 1 << 12 # PD


.data 
gdt: # Global Descriptor Table
    .quad 0 # null descriptor
    .quad 0x00B09A0000000000 # code segment descriptor

.text
.code32
.globl _start
_start:
    mov esp, offset stack_top 

    #TO DO - cpuid check 

    mov dword ptr [pml4], offset pdpt + 3 # last bits are for permissions, first bits are for address which is essentially offset pdpt
    mov dword ptr [pdpt], offset pd + 3
    mov dword ptr [pd], 0x83 # 0th 1st and 7th bits are important and they need to be 1

    mov eax, offset pml4
    mov cr3, eax # we need to use eax because cr3 is not a general-purpose register, therefore there is a limited number of allowed operations
    mov eax, 0x20 #
    mov cr4, eax # same reason like cr3, TO REVIEW (because of override)

    mov ecx, 0xC0000080
    rdmsr
    or eax, (1 << 8) # LME - Long Mode Enable bit
    wrmsr
    mov eax, 1 << 31
    mov cr0, eax # paging byte in cr0, TO REVIEW (because of override)

    mov word ptr [gdtr], 0xE # first two bytes is limit = 16 - 1
    mov dword ptr [gdtr + 2], offset gdt # four bytes for the address of gdt (Global descriptor table)
    lgdt [gdtr]
    .code64


    #END
    cli 
    halt:
        hlt 
    jmp halt