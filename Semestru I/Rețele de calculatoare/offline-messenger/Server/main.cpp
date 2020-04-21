#include "server.h"
#include <iostream>
#include <stdio.h>
#include <errno.h>

using namespace std;

int main() {
    Server server;
    server.init();
    server.listenClients();
}