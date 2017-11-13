#include "Mosquitto.hpp"

Mosquitto::Mosquitto(const char * id, const char * host, int port)
        : mosqpp::mosquittopp(id) {
    const int keep_alive = 60;

    mosqpp::mosquittopp::connect(host, port, keep_alive);
}
Mosquitto::~Mosquitto() {
    mosqpp::mosquittopp::disconnect();
}

void Mosquitto::on_connect(int rc) {
    (void) rc;
}
void Mosquitto::on_message(const struct mosquitto_message * message) {
    (void) message;
}
void Mosquitto::on_subscribe(int mid, int qos_count, const int * granted_qos) {
    (void) mid;
    (void) qos_count;
    (void) granted_qos;
}
