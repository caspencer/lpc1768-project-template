#include "delay.h"
#include <stdint.h>

void delay(int count) {
    for (volatile int i = 0; i < count; i++);
}

void delay_ns(uint32_t val) {
    uint32_t count = val * 0.008;
    for (volatile uint32_t i = 0; i < count; i++);
}

void delay_us(uint32_t val) {
    uint32_t count = val << 3;
    for (volatile uint32_t i = 0; i < count; i++);
}

void delay_ms(uint32_t val) {
    uint32_t count = (val * 1000) << 3;
    for (volatile uint32_t i = 0; i < count; i++); 
}