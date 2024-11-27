#include "ports.h"
#include "screen.h"

void debug(){
    port_byte_out(CGA_INDEX, 14);
    int testbyte = port_byte_in(CGA_DATA);
    testbyte << 8;

    port_byte_out(CGA_INDEX, 15);
    testbyte += port_byte_in(CGA_DATA);
}
