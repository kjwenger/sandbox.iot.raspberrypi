// https://stackoverflow.com/questions/29602698/create-a-simple-client-server-using-modbus-in-c

#include <modbus/modbus.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    //Create a new RTU context with proper serial parameters (in this example,
    //device name /dev/ttyS0, baud rate 9600, no parity bit, 8 data bits, 1 stop bit)
    modbus_t *ctx = modbus_new_rtu("/dev/ttyAMA0", 9600, 'N', 8, 1);
    if (!ctx) {
        fprintf(stderr, "Failed to create the context: %s\n", modbus_strerror(errno));
        exit(1);
    }

    if (modbus_connect(ctx) == -1) {
        fprintf(stderr, "Unable to connect: %s\n", modbus_strerror(errno));
        modbus_free(ctx);
        exit(1);
    }

    //Set the Modbus address of the remote slave (to 3)
    modbus_set_slave(ctx, 1);


    uint16_t reg[5];// will store read registers values

    //Read 5 holding registers starting from address 64
    int num = modbus_read_registers(ctx, 50, 2, reg);
    if (num != 5) {// number of read registers is not the one expected
        fprintf(stderr, "Failed to read: %s\n", modbus_strerror(errno));
    }

    modbus_close(ctx);
    modbus_free(ctx);

    return 0;
}
