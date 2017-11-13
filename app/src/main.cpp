#include <cstdlib>
#include <exception>
#include <vector>
#include <sstream>
#include <iostream>
#include <algorithm>
#include <iterator>
#include "Modbus.hpp"
#include "Mosquitto.hpp"

std::ostream & operator<<(std::ostream & os, const std::vector<uint16_t> & v)
{
    if (! v.empty())
    {
        std::copy(v.begin(), v.end(), std::ostream_iterator<uint16_t>(os, ","));
    }
    return os;
}

int main(int argc, char * argv[])
{
    try
    {
        const char * modbus_dev = std::getenv("MODBUS_DEV");
        const char * device = modbus_dev ? modbus_dev : "/dev/ttyAMA0";
        Modbus modbus(device);

        const char * mqtt_id = std::getenv("MQTT_ID");
        const char * mqtt_host = std::getenv("MQTT_HOST");
        const char * mqtt_port = std::getenv("MQTT_PORT");
        const char * host = mqtt_host ? mqtt_host : "localhost";
        const char * id = mqtt_id ? mqtt_id : argv[0];
        std::istringstream is(mqtt_port ? mqtt_port : "1883");
        int port;
        is >> port;
        Mosquitto mosquitto(id, host, port);

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
