#include "Mosquitto.hpp"

Mosquitto::Mosquitto(const char * id, const char * host, int port)
        : mosqpp::mosquittopp(id) {
    const int keep_alive = 60;
    const bool clean_session = true;

    mosqpp::mosquittopp::connect(host, port, keep_alive);
}
Mosquitto::~Mosquitto() {

}

void Mosquitto::on_connect(int rc) {

}
void Mosquitto::on_message(const struct mosquitto_message *message) {

}
void Mosquitto::on_subscribe(uint16_t mid, int qos_count, const uint8_t * granted_qos) {

}
