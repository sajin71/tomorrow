#include <stdint.h>
#include <stdio.h>

int32_t convertToInt(float target){
    int32_t *to = (int32_t *)(void *)&target;
    return *to;
}
float convertToFloat(int32_t target){
    float *to = (float *)(void *)&target;
    return *to;
}
