

void kernel_main(){
    const char* hw = "Hello, world!";
    int i = 0;
    while (hw[i] != '\0'){
        __asm__ volatile(
            "outb %0, %1" 
            :
            : "a" (hw[i]), "Nd" (0x3F8)
        );
        i++;
    }
}