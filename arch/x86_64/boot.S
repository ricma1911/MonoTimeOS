.intel_syntax noprefix
.section .multiboot
.balign 8
multiboot2_header:
    .long 0xE85250D6 # magic
    .long 0 # architecture: i386(32-bit x86 protected mode)
    .long 16 + 8 # header_length: 16 bytes + 8 bytes for end tag
    .long 0x100000000 - (0xE85250D6 + 0 + 24) #checksum, magic + architecture + hl + checksum = 0, I use 0x100000000 to have a positve number
    