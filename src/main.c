//#define USE_GPIO_DRIVER

// fast blink = GPIO driver
// slow blink = direct register GPIO

#ifdef USE_GPIO_DRIVER
#include "lpc17xx_gpio.h"
#define delay_count (1 << 20)
#else
#include "LPC17xx.h"    // Device-specific header
#define delay_count (1 << 22)
#endif

#include "delay.h"

void gpio_setup() {
#ifdef USE_GPIO_DRIVER    
    GPIO_SetDir(2, _BIT(0), 1);
#else
    LPC_GPIO2->FIODIR |= (1 << 0);
#endif
}

void gpio_set() {
#ifdef USE_GPIO_DRIVER
    GPIO_SetValue(2, _BIT(0));
#else
    LPC_GPIO2->FIOSET = (1 << 0);  // Turn on LED
#endif
}

void gpio_clear() {
#ifdef USE_GPIO_DRIVER        
    GPIO_ClearValue(2, _BIT(0));
#else
    LPC_GPIO2->FIOCLR = (1 << 0);  // Turn off LED
#endif
}

int main(void) {
    // NOTE: SystemInit is being called via startup_LPC17xx.s (prior to main)

    gpio_setup();           // Configure P2.0 as output (LED)

    while (1) {
        gpio_set();         // Turn on LED
        delay(delay_count);

        gpio_clear();       // Turn off LED
        delay(delay_count);
    }
}
