#include <iostream>
#include "Mosquitto.hpp"

Mosquitto::Mosquitto(const char * id, const char * host, int port)
        : mosqpp::mosquittopp(id) {
    const int keep_alive = 60;

    int rc = mosqpp::mosquittopp::connect(host, port, keep_alive);
                                                                                std::cerr << "Mosquitto::Mosquitto() rc=" << rc << std::endl;
}
Mosquitto::~Mosquitto() {
    int rc = mosqpp::mosquittopp::disconnect();
                                                                                std::cerr << "Mosquitto::~Mosquitto() rc=" << rc << std::endl;
}

void Mosquitto::on_connect(int rc) {
                                                                                std::cerr << "Mosquitto::on_connect() rc=" << rc << std::endl;
}
void Mosquitto::on_message(const struct mosquitto_message * message) {
                                                                                std::cerr << "Mosquitto::on_message() message=" << std::hex << message << std::dec << std::endl;
}
void Mosquitto::on_subscribe(int mid, int qos_count, const int * granted_qos) {
                                                                                std::cerr << "Mosquitto::on_subscribe() mid=" << std::hex << mid << std::dec << std::endl;
                                                                                std::cerr << "Mosquitto::on_subscribe() qos_count=" << std::hex << qos_count << std::dec << std::endl;
                                                                                std::cerr << "Mosquitto::on_subscribe() granted_qos=" << std::hex << granted_qos << std::dec << std::endl;
}
