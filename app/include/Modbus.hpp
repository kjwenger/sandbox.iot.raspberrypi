#pragma once

#include <cstdint>
#include <string>
#include <vector>
#include <exception>
#include <modbus/modbus.h>

class ModbusError : public std::exception
{
public:
    explicit ModbusError(const char * what);
    explicit ModbusError(const std::string & what);
    virtual const char * what() const _GLIBCXX_TXN_SAFE_DYN _GLIBCXX_USE_NOEXCEPT override;
private:
    std::string _what;
};

class Modbus
{
public:
    explicit Modbus(const char * device);
    ~Modbus();
    void readRegisters(int address, std::vector<uint16_t> & result);
private:
    modbus_t * _ctx;
};
