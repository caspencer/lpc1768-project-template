//#include "LPC17xx.h"    // Device-specific header
#include "lpc17xx_gpio.h"
#include "delay.h"

int main(void) {
    // NOTE: SystemInit is being called via startup_LPC17xx.s (prior to main)

    // Configure P2.0 as output (LED)
    GPIO_SetDir(2, _BIT(0), 1);
    //LPC_GPIO2->FIODIR |= (1 << 0);

    while (1) {
        GPIO_SetValue(2, _BIT(0));
        //LPC_GPIO2->FIOSET = (1 << 0);  // Turn on LED
        
        delay((1 << 22));
        
        GPIO_ClearValue(2, _BIT(0));
        //LPC_GPIO2->FIOCLR = (1 << 0);  // Turn off LED
        delay((1 << 22));
    }
}
