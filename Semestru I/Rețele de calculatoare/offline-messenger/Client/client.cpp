#include "client.h"
#include "./../utils.h"

#define PORT 2024
using namespace std;

Client *global;

void showMenu()
{
    cout << "Select a number:\n";
    cout << "1. Login\n";
    cout << "2. Make account\n";
    cout << "3. Exit\n";
}

void menuAfterLogin()
{
    cout << "Select a number:\n";
    cout << "1. Chat\n";
    cout << "2. View history\n";
    cout << "3. Log out\n";
}

bool Client::validateInput(string input)
{
    int numericInput;
    switch (state)
    {
    case 0:
        try
        {
            numericInput = stoi(input);
        }
        catch (std::invalid_argument &e)
        {
            return false;
        }
        if (numericInput != 1 && numericInput != 2 && numericInput != 3)
            return false;
        break;
    case 1:
        if (username.find(' ') != string::npos || password.find(' ') != string::npos)
            return false;
        break;
    case 2:
        if (username.find(' ') != string::npos || password.find(' ') != string::npos)
            return false;
        break;
    case 4:
        try
        {
            numericInput = stoi(input);
        }
        catch (std::invalid_argument &e)
        {
            return false;
        }
        if (numericInput != 1 && numericInput != 2 && numericInput != 3)
            return false;
        break;
    }
    return true;
}

void Client::processInput(string input)
{
    switch (state)
    {
    case 0:
        state = stoi(input);
        break;
    case 1:
        login();
        break;
    case 2:
        signUp();
        break;
    case 4:
        state = stoi(input) + 4;
        break;
    }
}

static void killProgram(int signo) {
    if(global->state == 5) { // sunt in chat
        myWrite(global->serverDescriptor, "--back--");
    }
    printf("\nProgram ended. You logged out!\n");
    exit(0);
}

void Client::checkNotifications() {
    myWrite(serverDescriptor, state);

    string notifications;
    int hasNotifications;
    myRead(serverDescriptor, hasNotifications);
    if(hasNotifications) {
        myRead(serverDescriptor, notifications);
        printf("%s", notifications.c_str());
    }
}

bool Client::init()
{
    cout << "Server address: ";
    cin >> address;

    if ((serverDescriptor = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        perror("Eroare la socket().\n");
        return false;
    }
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr(address);
    server.sin_port = htons(PORT);

    /* ne conectam la server */
    if (connect(serverDescriptor, (struct sockaddr *)&server, sizeof(struct sockaddr)) == -1)
    {
        perror("[client] Eroare la connect().\n");
        return errno;
    }

    global = this;

    signal(SIGINT, killProgram); // Ctrl+C



    return true;
}

void Client::listenInput()
{
    string input;
    bool quited = 0;
    while (!quited)
    {
        switch (state)
        {
        case 0: // menu
            showMenu();
            cin >> input;
            break;
        case 1: // login
            cout << "Username: ";
            cin >> username;
            cout << "Password: ";
            cin >> password;
            cout << endl;
            break;
        case 2: //sign up
            cout << "Username: ";
            cin >> username;
            cout << "Password: ";
            cin >> password;
            cout << endl;
            break;
        case 3: // quit
            quit();
            quited = 1;
            continue;
        case 4: // menu
            checkNotifications();
            menuAfterLogin();
            cin >> input;
            break;
        case 5: // chat
            chat();
            continue;
        case 6: // view history
            viewHistory();
            continue;
        case 7: // log out
            logOut();
            quited = 1;
            continue;
        }
        if (!validateInput(input))
        {
            cout << "Wrong input!\n";
            continue;
        }
        processInput(input);
    }
}

void clearScreen()
{
    system("@cls||clear");
}

void Client::viewHistory() {
    int nrUsers;
    string otherUsername, myUsername, messageHistory;
    myWrite(serverDescriptor, state);

    myRead(serverDescriptor, myUsername);
    myRead(serverDescriptor, nrUsers);
    cout << "View history with:\n";
    for (int i = 0; i < nrUsers - 1; i++)
    {
        myRead(serverDescriptor, otherUsername);
        printf("%s\n", otherUsername.c_str());
    }

    char chosenUsername[100];
    cin >> chosenUsername;
    printf("Ai ales: %s\n", chosenUsername);
    myWrite(serverDescriptor, chosenUsername); // trimit cu cine vrea sa vorbeasca

    clearScreen();
    myRead(serverDescriptor, messageHistory);
    printf("%s\n", messageHistory.c_str());
    state = 4;
}

void Client::login()
{
    myWrite(serverDescriptor, state);
    myWrite(serverDescriptor, username);
    myWrite(serverDescriptor, password);

    // server-ul verifica daca username-ul si parola exista si trimite mesaj inapoi
    int found;
    myRead(serverDescriptor, found);
    if (found)
    {
        printf("Logged in!\n");
        loggedIn = 1;
        state = 4;
    }
    else
    {
        printf("Not logged in. Try again!\n");
        loggedIn = 0;
    }
}

void Client::signUp()
{
    myWrite(serverDescriptor, state);
    myWrite(serverDescriptor, username);
    myWrite(serverDescriptor, password);
    // verific sa nu existe deja username-ul
    int found;
    myRead(serverDescriptor, found);
    if (found)
    {
        printf("Username already exists!\n");
        loggedIn = 0;
    }
    else
    {
        printf("Account made. You are logged in!\n");
        loggedIn = 1;
        state = 4;
    }
}

void Client::quit()
{
    myWrite(serverDescriptor, state);
    printf("Bye!\n");
}

void Client::logOut()
{
    myWrite(serverDescriptor, state);
    printf("You logged out!\n");
}

void Client::chat()
{
    int nrUsers, flags;
    int isOnline = 0;
    string otherUsername, myUsername, messageHistory;
    vector<string> usernames;

    myWrite(serverDescriptor, state);

    int found = 0;
    char chosenUsername[100];
    myRead(serverDescriptor, myUsername);
    while(!found) {
        myRead(serverDescriptor, nrUsers);
        cout << "Select a username:\n";
        for (int i = 0; i < nrUsers - 1; i++) {
            myRead(serverDescriptor, otherUsername);
            usernames.push_back(otherUsername);
            myRead(serverDescriptor, isOnline);
            printf("%s - ", otherUsername.c_str());
            if (isOnline == 1) printf("online\n");
            else printf("offline\n");
        }
        cin >> chosenUsername;

        for(int i=0; i<usernames.size(); i++) {
            if(usernames[i] == chosenUsername) {
                found = 1;
                break;
            }
        }
        if(!found) printf("Wrong username!\n\n");
        myWrite(serverDescriptor, found);
    }

    myWrite(serverDescriptor, chosenUsername); // trimit cu cine vrea sa vorbeasca

    string message;
    bool quited = 0;

    while (!quited)
    {
        clearScreen();
        printf("Write \"--back--\" to exit conversation.\nPress enter to see new messages.\n");
        printf("Write @nr_message to reply to a specific message.\n\n");
        myRead(serverDescriptor, messageHistory);
        printf("%s\n", messageHistory.c_str());
        printf("%s: ", myUsername.c_str());

        getline(cin, message);
        myWrite(serverDescriptor, message);
        if (message == "--back--") quited = 1;
    }
    state = 4;
}