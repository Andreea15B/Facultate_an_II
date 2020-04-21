#pragma once
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <string.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <iostream>
#include <ctype.h>
#include <signal.h>
#include <vector>
using namespace std;

class Client {
    // 0 initial menu
    // 1 login
    // 2 sign up
    // 3 exit 
    // 4 menu after login
    // 5 chat
    // 6 view history
    // 7 log out
    int port;
    string username, password;
    struct sockaddr_in server;
    char address[50];
    bool loggedIn;
 public: 
    int serverDescriptor, state;
    Client(){
        state = 0;
        loggedIn = 0;
    }
    bool init();
    void listenInput();
    void login();
    void signUp();
    void logOut();
    void quit();
    void chat();
    void viewHistory();
    void checkNotifications();
    void processInput(string input);
    bool validateInput(string input);
};