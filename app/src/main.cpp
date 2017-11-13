#include <cstdlib>
#include <exception>
#include <vector>
#include <iostream>
#include <algorithm>
#include <iterator>
#include "Modbus.hpp"

std::ostream & operator<<(std::ostream & os, const std::vector<uint16_t> & v) {
    if (! v.empty()) {
        std::copy(v.begin(), v.end(), std::ostream_iterator<uint16_t>(os, ","));
    }
    return os;
}

int main(int argc, char * argv[]) {
    const char * modbus_dev = std::getenv("MODBUS_DEV");
    try
    {
        Modbus modbus(modbus_dev ? modbus_dev : "/dev/ttyAMA0");
        std::vector<uint16_t> _0x001f(2);
        modbus.readRegisters(0x001f, _0x001f);
        std::cout << "0x001f: " << _0x001f << std::endl;
    }
    catch (const std::exception & e)
    {
        std::cerr << e.what() << std::endl;
        return 1;
    }
    return 0;
}
