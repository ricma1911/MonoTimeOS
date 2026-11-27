#include <stdint.h>
#ifndef IDT_H
#define IDT_H

typedef struct {
    int type; // Exception or interrupt
    void* handle_address;
}InterruptDesciptor;

InterruptDesciptor array[256];

#endif