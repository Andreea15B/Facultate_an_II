#include "client.h"
#include <iostream>
#include <stdio.h>
#include <errno.h>

using namespace std;

int main() {
    Client client;
    if(!client.init()) {
        perror("Init fail");
        return -1;
    }
    client.listenInput();
    return 0;
}