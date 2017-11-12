#pragma once

#include <mosquittopp.h>
#include <stdint.h>

class Mosquitto : public mosqpp::mosquittopp {
public:
    Mosquitto(const char * id, const char * host, int port);
    ~Mosquitto();

    void on_connect(int rc);
    void on_message(const struct mosquitto_message * message);
    void on_subscribe(uint16_t mid, int qos_count, const uint8_t * granted_qos);
};
