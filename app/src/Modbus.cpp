#include <sstream>
#include <iostream>
#include "Modbus.hpp"

ModbusError::ModbusError(const std::string & what)
        : _what(what)
{

}
ModbusError::ModbusError(const char * what)
        : _what(what)
{

}
const char * ModbusError::what() const _GLIBCXX_TXN_SAFE_DYN _GLIBCXX_USE_NOEXCEPT
{
    return _what.c_str();
}

Modbus::Modbus(const char * device)
{
    _ctx = modbus_new_rtu(device, 9600, 'N', 8, 1);
    if (!_ctx)
    {
        throw ModbusError(
                std::string("Modbus error opening device: ") +
                std::string(device));
    }
    if (modbus_connect(_ctx) == -1)
    {
        modbus_free(_ctx);
        throw ModbusError(
                std::string("Modbus error connecting through device: ") +
                std::string(device));
    }
    modbus_set_slave(_ctx, 0);
}
void Modbus::readRegisters(int address, std::vector<uint16_t> & result)
{
    int size = (int) result.size();
    std::cout << "Modbus::readRegisters(...) size=" << size << std::endl;
    int num = modbus_read_registers(_ctx, address, size, result.data());
    std::cout << "Modbus::readRegisters(...) num=" << num << std::endl;
    if (num != size)
    {
        std::ostringstream os;
        os << "Modbus error reading from address/count: ";
        os << address;
        os << "/";
        os << size;
        throw ModbusError(os.str());
    }
}
Modbus::~Modbus()
{
    modbus_close(_ctx);
    modbus_free(_ctx);
}
