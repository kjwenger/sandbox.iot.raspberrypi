#pragma once

#include <mosquittopp.h>
#include <stdint.h>

class Mosquitto : public mosqpp::mosquittopp {
public:
    Mosquitto(const char * id, const char * host, int port);
    ~Mosquitto();
protected:
    virtual void on_connect(int rc) override;
    virtual void on_message(const struct mosquitto_message * message) override;
    virtual void on_subscribe(int mid, int qos_count, const int * granted_qos) override;
};
