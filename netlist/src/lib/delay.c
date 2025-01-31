#include "delay.h"

void delay(unsigned int ms) {
    volatile unsigned int cycles = ms / 2; // adjust this accordingly, 5000Hz in Digital
    while (cycles--) {
        __asm__ volatile ("nop");  // Prevent compiler optimizations
    }
}