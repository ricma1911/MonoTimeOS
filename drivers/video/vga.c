#include "vga.h"

void vga_print(const char* string){
    volatile unsigned short* address = 0xb8000; // address of VGA, the structure is [char][attributes][char][attributes]...
    int i = 0;
    while (string[i] != '\0'){
        unsigned short mask = 0;
        mask |= string[i];
        unsigned short atribute = 0x3F; // cyan background, white char
        atribute <<= 8;
        mask |= atribute;
        address[i] = mask;
        i++;
    }
}
