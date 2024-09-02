#include "delay.h"

void delay(int count)
{
    for (volatile int i = 0; i < count; i++);
}