#include "gpio.h"

void set_pin_mode(int pin, int mode) {
    if(mode) {
        *(int*)GPIO_CONFIG_ADDR = *(int*)GPIO_CONFIG_ADDR | (mode << (pin - 1));
    } else {
        *(int*)GPIO_CONFIG_ADDR = *(int*)GPIO_CONFIG_ADDR & ~(mode << (pin - 1));
    }
}

void set_all_pins_mode(int mode) {
    *(int*)GPIO_CONFIG_ADDR = mode;
}

void set_pin(int pin, int value) {
    if(value) {
        *(int*)GPIO_DATA_ADDR = *(int*)GPIO_DATA_ADDR | (1 << (pin - 1));
    } else {
        *(int*)GPIO_DATA_ADDR = *(int*)GPIO_DATA_ADDR & ~(1 << (pin - 1));
    }
}

void set_all_pins(int value) {
    *(int*)GPIO_DATA_ADDR = value;
}

int get_all_pins(void) {
    return *(int*)GPIO_DATA_ADDR;
}

int get_pin(int pin) {
    return *(int*)GPIO_DATA_ADDR & (1 << (pin - 1));
}