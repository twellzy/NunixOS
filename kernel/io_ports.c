unsigned char port_byte_in(unsigned short port){
    //reads port and returns the byte in it

    unsigned char result;
    __asm__ (" in %% dx , %% al " : "=a " ( result ) : "d " ( port ));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data){
    //modifies port to have byte value of data

    __asm__ (" out %% dx , %% al " : "=a " ( data ) : "d " ( port ));
}

unsigned short port_word_in(unsigned short port){
    //reads port and returns the word in it

    unsigned short result;
    __asm__ (" in %% dx , %% al " : "=a " ( result ) : "d " ( port ));
    return result;
}

void port_word_out(unsigned short port, unsigned short data){
    //modifes port to have word value of data

    __asm__ (" out %% dx , %% al " : "a " ( data ) : "d " ( port ));
}
