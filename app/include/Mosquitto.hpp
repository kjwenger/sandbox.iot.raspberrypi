#pragma once

#include <mosquittopp.h>
#include <stdint.h>

class Mosquitto : public mosqpp::mosquittopp {
public:
    explicit Mosquitto(
            const char * id = nullptr,
            const char * host = "localhost",
            int port = 1883);
    ~Mosquitto();
protected:
    virtual void on_connect(int rc) override;
    virtual void on_message(const struct mosquitto_message * message) override;
    virtual void on_subscribe(
            int mid, int qos_count, const int * granted_qos) override;
};
