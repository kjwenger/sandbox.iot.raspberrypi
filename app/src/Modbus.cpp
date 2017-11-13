#include <sstream>
#include <iostream>
#include <iomanip>
#include "Modbus.hpp"

ModbusError::ModbusError(const std::string & what)
        : _what(what)
{

}
ModbusError::ModbusError(const char * what)
        : _what(what)
{

}
const char * ModbusError::what()
    const _GLIBCXX_TXN_SAFE_DYN _GLIBCXX_USE_NOEXCEPT
{
    return _what.c_str();
}

Modbus::Modbus(const char * device)
{
    _ctx = modbus_new_rtu(device, 9600, 'N', 8, 1);
                                                                                std::cout << "Modbus::Modbus(...) _ctx=" << std::hex << _ctx << std::dec << std::endl;
    if (!_ctx)
    {
        throw ModbusError(
                std::string("Modbus error opening device: ") +
                std::string(device));
    }
    int rc = modbus_connect(_ctx);
                                                                                std::cerr << "Modbus::Modbus() rc=" << rc << std::endl;
    if (rc == -1)
    {
        modbus_free(_ctx);
        throw ModbusError(
                std::string("Modbus error connecting through device: ") +
                std::string(device));
    }
    rc = modbus_set_slave(_ctx, 0);
                                                                                std::cerr << "Modbus::Modbus() rc=" << rc << std::endl;
}
Modbus::~Modbus()
{
                                                                                std::cerr << "Modbus::~Modbus()" << std::endl;
    modbus_close(_ctx);
    modbus_free(_ctx);
}
void Modbus::readRegisters(int address, std::vector<uint16_t> & result)
{
                                                                                std::ios::fmtflags flags(std::cout.flags());
                                                                                std::cout << "Modbus::readRegisters(...) address=0x" << std::hex << std::setfill('0') << std::setw(4) << address << std::dec << std::endl;
                                                                                std::cout.flags(flags);
    int count = (int) result.size();
                                                                                std::cout << "Modbus::readRegisters(...) count=" << count << std::endl;
    int num = modbus_read_input_registers(_ctx, address, count, result.data());
                                                                                std::cout << "Modbus::readRegisters(...) num=" << num << std::endl;
    if (num != count)
    {
        std::ostringstream os;
        os << "Modbus error reading from address/count: ";
        os << address;
        os << "/";
        os << count;
        throw ModbusError(os.str());
    }
}
