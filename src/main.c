#include "LPC17xx.h"    // Device-specific header
#include "core_cm3.h"   // CMSIS core header

int main(void) {

    // NOTE: SystemInit is being called via startup_LPC17xx.s (prior to main)

    // Configure P2.0 as output (LED)
    LPC_GPIO2->FIODIR |= (1 << 0);

    while (1) {
        LPC_GPIO2->FIOSET = (1 << 0);  // Turn on LED
        for (volatile int i = 0; i < 4000000; i++);  // Delay
        LPC_GPIO2->FIOCLR = (1 << 0);  // Turn off LED
        for (volatile int i = 0; i < 4000000; i++);  // Delay
    }
}
