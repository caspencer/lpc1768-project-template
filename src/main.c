#ifdef USE_GPIO_DRIVER
#include "lpc17xx_gpio.h"
#else
#include "LPC17xx.h"
#endif

#include "delay.h"

/**
 * @brief   Blinky GPIO example using driver or direct-register access.
 * 
 * @details The LED connected to P2.0 will blink at two different speeds depending
 *          on the method of GPIO control used. If `USE_GPIO_DRIVER` is defined,
 *          the GPIO driver is used for fast blinking. If `USE_GPIO_DRIVER` is 
 *          not defined, direct-register access is used for slow blinking.
 *
 * @return  Returns an integer, but the return value is not used in typical
 *          embedded applications as it enters an infinite loop.
 */
int main(void) {

    #ifdef USE_GPIO_DRIVER

    GPIO_SetDir(2, _BIT(0), 1);             // Configure P2.0 as output (LED)
    
    while (1) {
        GPIO_SetValue(2, _BIT(0));          // Turn on LED
        delay((1 << 20));                   // Short delay for fast blink
        GPIO_ClearValue(2, _BIT(0));        // Turn off LED
        delay((1 << 20));                   // Short delay for fast blink
    }

    #else

    LPC_GPIO2->FIODIR |= (1 << 0);          // Configure P2.0 as output (LED)
    
    while (1) {
        LPC_GPIO2->FIOSET = (1 << 0);       // Turn on LED
        delay((1 << 22));                   // Longer delay for slow blink
        LPC_GPIO2->FIOCLR = (1 << 0);       // Turn off LED
        delay((1 << 22));                   // Longer delay for slow blink
    }

    #endif

    return 1;
}