#ifndef DELAY_H
#define DELAY_H

#include <stdint.h>

/**
 * @brief Generates a delay by performing a busy-wait loop.
 * @param[in] count The number of iterations.
 */
void delay(int count);

/**
 * @brief Generates a delay by performing a busy-wait loop.
 * @param[in] count The number of nanoseconds to wait, must be at least 125. 
 */
void delay_ns(uint32_t val);

/**
 * @brief Generates a delay by performing a busy-wait loop.
 * @param[in] count The number of microseconds to wait.
 */
void delay_us(uint32_t val);

/**
 * @brief Generates a delay by performing a busy-wait loop.
 * @param[in] count The number of milliseconds to wait.
 */
void delay_ms(uint32_t val);

#endif  // DELAY_H
