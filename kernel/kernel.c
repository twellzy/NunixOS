#include "../drivers/ports.h"

void main(){
    char* video_memory = (char*) 0xb0000;

    *video_memory = 'X';
}