#include "lib/gpio.h"
#include "lib/delay.h"

int main()
{
    set_all_pins_mode(1);
    set_all_pins(1);
    while(1)
    {
        delay(1000);
        set_all_pins(0);
        delay(1000);
        set_all_pins(1);
    }
}