#pragma once
#include "user.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <string.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <iostream>
#include <vector>
#include <fcntl.h>
#include <signal.h>

using namespace std;

class Server {
    struct sockaddr_in server, from;
    int serverDescriptor;
    vector<User> users;
 public:
    bool init();
    void listenClients();
    User chooseUserToChat(int, User);
    User chooseUserHistory(int, User);
    void populateUsers();
    void chat(int, User, User);
    void viewHistory(int, User, User);
    bool hasNotifications(User);
    void sendNotifications(int, User);
    int checkForNotifications(User, User);
    void deleteNotifications(User, User);
    int countMessages(User, User);
 private:
    void handleClient(int);
};

