#include "server.h"
#include "user.h"
#include "./../utils.h"
#define PORT 2024

using namespace std;

void Server::populateUsers() {
  FILE *file;
  User newUser;
  char s[500], *p;
  if((file = fopen("./usernames_passwords.txt", "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }
  while(fgets(s, sizeof(s), file) != NULL) {
    p = strtok(s, "\n"); 
    strcpy(s, p);
    p = strtok(s, " ");
    newUser.username = p;
    p = strtok(NULL, " ");
    newUser.password = p;
    newUser.isOnline = 0;
    users.push_back(newUser);
  }
}

bool Server::init() {
    int optval = 1;
    if ((serverDescriptor = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
      perror ("[server] Eroare la socket().\n");
      return false;
    }
    setsockopt(serverDescriptor, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval));
    bzero (&server, sizeof (server));
    bzero (&from, sizeof (from));

    server.sin_family = AF_INET;
    server.sin_addr.s_addr = htonl(INADDR_ANY);
    server.sin_port = htons(PORT);

    if (bind(serverDescriptor, (struct sockaddr*)&server, sizeof(struct sockaddr)) == -1) {
      perror ("[server] Eroare la bind().\n");
      return false;
    }

    populateUsers();
}

void Server::listenClients() {
    if (listen(serverDescriptor, 5) == -1) {
        perror ("[server] Eroare la listen().\n");
        return;
    }

    // servim in mod concurent clientii
    while (1) {
      socklen_t length = sizeof(from);    /* lungimea structurii sockaddr_in */
      printf ("[server] Asteptam la portul %d...\n", PORT);
      fflush(stdout);

      /* acceptam un client (stare blocanta pana la realizarea conexiunii) */
      int clientDescriptor = accept(serverDescriptor, (struct sockaddr*)&from, &length);

      /* eroare la acceptarea conexiunii de la un client */
      if (clientDescriptor < 0) {
        perror ("[server] Eroare la accept().\n");
        continue;
      }

      handleClient(clientDescriptor);
      
    }
}

bool checkUsernamePassword(string username, string password) {
  FILE *file;
  char s[500], *p;
  int found_username, found_password, found = 0;
  if((file = fopen("./usernames_passwords.txt", "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return 0;
  }
  while(fgets(s, sizeof(s), file) != NULL) {
    p = strtok(s, "\n");
    strcpy(s, p);
    found_username = 0; found_password = 0;
    p = strtok(s, " ");
    if(strcmp(p, username.c_str()) == 0) {
      printf("Am gasit username: %s\n", p);
      found_username = 1;
    }
    p = strtok(NULL, " ");
    if(strcmp(p, password.c_str()) == 0 && found_username) {
      printf("Am gasit parola: %s\n", p);
      found_password = 1;
    }
    if(found_username && found_password) {
      found = 1;
      break;
    }
  }
  fclose(file);
  return found;
}

bool checkUsername(string username) {
  FILE *file;
  char s[500], *p;
  int found_username = 0;
  if((file = fopen("./usernames_passwords.txt", "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return 0;
  }
  while(fgets(s, sizeof(s), file) != NULL) {
    p = strtok(s, " ");
    if(strcmp(p, username.c_str()) == 0) {
      printf("Am gasit username: %s\n", p);
      found_username = 1; break;
    }
  }
  fclose(file);
  return found_username;
}

void addNewUser(string username, string password) {
  FILE *file;
  if((file = fopen("./usernames_passwords.txt", "a")) == NULL) { // "a" pentru append
    perror("Eroare la fopen().\n");
    return;
  }
  // adaug in fisier username-ul si parola
  fprintf(file, "%s", username.c_str());
  fprintf(file, " %s", password.c_str());
  // ii fac folder in care va avea conversatiile
  if(mkdir(username.c_str(), 0777) == -1) printf("Eroare la mkdir().\n");
  else printf("Folder creat!\n");

  // in folder fac un fisier pt notificari
  char buf[500];
  FILE *file1;
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/notificari.txt", username.c_str());
  if((file1 = fopen(buf, "a+")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }
  fclose(file); fclose(file1);
}

User Server::chooseUserToChat(int clientDescriptor, User user) {
  FILE *file;
  // scriu username-urile din care sa aleaga
  int found = 0;
  char username[1000], password[1000];
  int isOnline;

  myWrite(clientDescriptor, user.username);
  while(!found) {
    if((file = fopen("./usernames_passwords.txt", "r")) == NULL) perror("Eroare la fopen().\n");

    myWrite(clientDescriptor, (int)users.size());
    while(fscanf(file, "%s %s %d\n", username, password, &isOnline) != EOF) {
      string name(username);
      if(name != user.username) {
        myWrite(clientDescriptor, name);
        myWrite(clientDescriptor, isOnline);
      }
    }
    myRead(clientDescriptor, found);
    fclose(file);
  }
  // citesc username-ul ales
  string chosenUser;
  myRead(clientDescriptor, chosenUser);

  for(int i = 0; i < users.size(); i++)
    if(users[i].username == chosenUser) return users[i];
}

User Server::chooseUserHistory(int clientDescriptor, User user) {
  FILE *file;
  // scriu username-urile din care sa aleaga
  if((file = fopen("./usernames_passwords.txt", "r")) == NULL) perror("Eroare la fopen().\n");
  char username[1000], password[1000];
  int isOnline;

  myWrite(clientDescriptor, user.username);
  myWrite(clientDescriptor, (int)users.size());
  while(fscanf(file, "%s %s %d\n", username, password, &isOnline) != EOF) {
    string name(username);
    if(name != user.username) myWrite(clientDescriptor, name);
  }
  fclose(file);

  // citesc username-ul ales
  string chosenUser;
  myRead(clientDescriptor, chosenUser);

  for(int i = 0; i < users.size(); i++)
    if(users[i].username == chosenUser) return users[i];
}

string lastLines(int nr, char buf1[]) {
  FILE *file;
  string messageLine, bigString = "";
  char msg[1000];
  vector<string> lines;

  if((file = fopen(buf1, "r")) == NULL) perror("Eroare la fopen() in lastLine.\n");

  while(fgets(msg, 1000, file) != NULL) {
    messageLine = string(msg);
    lines.push_back(messageLine);
  }

  if(lines.size() >= nr)
    for(int i = lines.size()-nr; i < lines.size(); i++) bigString += lines[i];
  else 
    for(int i = 0; i < lines.size(); i++) bigString += lines[i];

  fclose(file);

  return bigString;
}

int Server::checkForNotifications(User currentUser, User userToChat) {
  FILE *file;
  char buf[500];
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/notificari.txt", currentUser.username.c_str());
  if((file = fopen(buf, "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return 0;
  }

  char username[500]; 
  int nrMessages;
  while(fscanf(file, "%s %d\n", username, &nrMessages) != EOF) {
    string name(username);
    if(name == userToChat.username) {
      fclose(file);
      return nrMessages;
    }
  }
  fclose(file);
  return 0;
}

/// deletes notifications from [userToChat] for user [currentUser]
void Server::deleteNotifications(User currentUser, User userToChat) {
  FILE *file1;
  char buf1[500];
  bzero(buf1, sizeof(buf1));
  snprintf(buf1, sizeof(buf1), "%s/notificari.txt", currentUser.username.c_str());
  if((file1 = fopen(buf1, "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }

  FILE *file2;
  char buf2[500];
  bzero(buf2, sizeof(buf2));
  snprintf(buf2, sizeof(buf2), "%s/copyFile.txt", currentUser.username.c_str());
  if((file2 = fopen(buf2, "a+")) == NULL) {
    perror("Eroare la fopen().\n");
    return ;
  }

  char username[500];
  int nrMessages;
  while(fscanf(file1, "%s %d\n", username, &nrMessages) != EOF) {
    string name(username);
    if(name != userToChat.username) fprintf(file2, "%s %d\n", name.c_str(), nrMessages);
    // copy all lines from file1 except for the line to be deleted
  }
  fflush(file2); fclose(file1); fclose(file2);
  remove(buf1);
  rename(buf2, buf1); // rename file2
}

/// [userToChat] received one more notification from [currentUser]
void updateNrMessages(User currentUser, User userToChat) {
  bool found = false;
  FILE *file;
  char buf[500];
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/notificari.txt", userToChat.username.c_str());
  if((file = fopen(buf, "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }

  char username[500]; 
  int nrMessages;
  string allText;
  while(fscanf(file, "%s %d", username, &nrMessages) != EOF) {
    allText += username; allText += " ";
    string name(username);
    if(name == currentUser.username){
      nrMessages++;
      found = true;
    }
    allText += to_string(nrMessages);
    allText += '\n';
  }
  if(found == false) {
    allText += currentUser.username;
    allText += " 1\n";
  }
  fclose(file);
  file = fopen(buf, "w");
  fprintf(file, "%s", allText.c_str());
  fflush(file); fclose(file);
}

int Server::countMessages(User currentUser, User userToChat) {
  char buf1[500];
  FILE *file1;
  bzero(buf1, sizeof(buf1));
  snprintf(buf1, sizeof(buf1), "%s/%s.txt", currentUser.username.c_str(), userToChat.username.c_str());
  if((file1 = fopen(buf1, "a+")) == NULL) { // a+ for read and append
    perror("Eroare la fopen().\n");
    return 0;
  }

  char msg[1000];
  int nr = 0;
  while(fgets(msg, 1000, file1) != NULL) nr++;
  return nr;
}

void Server::chat(int clientDescriptor, User currentUser, User userToChat) {
  // deschid sau creez fisierele pt conversatie
  char buf1[500], buf2[500];
  FILE *file1, *file2;
  bzero(buf1, sizeof(buf1));
  snprintf(buf1, sizeof(buf1), "%s/%s.txt", currentUser.username.c_str(), userToChat.username.c_str());
  if((file1 = fopen(buf1, "a+")) == NULL) { // a+ for read and append
    perror("Eroare la fopen().\n");
    return;
  }
  bzero(buf2, sizeof(buf2));
  snprintf(buf2, sizeof(buf2), "%s/%s.txt", userToChat.username.c_str(), currentUser.username.c_str());
  if((file2 = fopen(buf2, "a+")) == NULL) { 
    perror("Eroare la fopen().\n");
    return;
  }

  bool quited = 0;
  int nrMesaje = 10, nr;
  string message, messageHistory;

  if(hasNotifications(currentUser)) {
    nr = checkForNotifications(currentUser, userToChat);
    if(nr != 0) nrMesaje = nr;
  }

  while(!quited) {
    // trimit un string cu ultimele mesaje
    deleteNotifications(currentUser, userToChat);
    messageHistory = lastLines(nrMesaje, buf1);
    nrMesaje = 10;
    myWrite(clientDescriptor, messageHistory);

    printf ("Waiting for message from client\n");
    myRead(clientDescriptor, message);
    printf ("Received message: %s\n", message.c_str());
    if(message == "--back--") {
      quited = 1;
      continue;
    }
    if(!message.empty()) {
      FILE *file;
      file = fopen("./usernames_passwords.txt", "r");
      char username[1000], password[100];
      int isOnline;
      while(fscanf(file, "%s %s %d\n", username, password, &isOnline) != EOF) {
        string name(username);
        if(username == userToChat.username && !isOnline) updateNrMessages(currentUser, userToChat);
      }
      fclose(file);

      int nr = countMessages(currentUser, userToChat);
      fprintf(file1, "%d ", nr+1); fprintf(file2, "%d ", nr+1);
    
      int replyNumber = 0;
      if(message[0] == '@') { // reply
        for(int i=1; i<message.size(); i++) {
          if(message[i] == ' ') break;
          replyNumber = replyNumber*10 + (message[i]-'0');
        }
        message.erase(0, 3);
        fprintf(file1, "%s replied to @%d: ", currentUser.username.c_str(), replyNumber);
        fprintf(file2, "%s replied to @%d: ", currentUser.username.c_str(), replyNumber);
      }
      else {
        fprintf(file1, "%s: ", currentUser.username.c_str());
        fprintf(file2, "%s: ", currentUser.username.c_str());
      }
      fprintf(file1, "%s\n", message.c_str());
      fprintf(file2, "%s\n", message.c_str());
      fflush(file1); fflush(file2);
    }
  }
  fclose(file1); fclose(file2);
}

void Server::viewHistory(int clientDescriptor, User currentUser, User chosenUser) {
  // deschid un fisier de conversatie
  char buf[500];
  FILE *file;
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/%s.txt", currentUser.username.c_str(), chosenUser.username.c_str());
  if((file = fopen(buf, "r")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }

  string history;
  // trimit un string cu ultimele mesaje
  history = lastLines(100, buf);
  myWrite(clientDescriptor, history);
  fclose(file);
}

void changeIsOnline(string name, string type) {
  FILE *file;
  file = fopen("./usernames_passwords.txt", "r");
  string allText;
  char username[1000], password[100];
  int isOnline;
  while(fscanf(file, "%s %s %d\n", username, password, &isOnline) != EOF) {
    allText += username; allText += " ";
    allText += password; allText += " ";
    if(username == name) {
      if(type == "logIn") allText += '1';
      else allText += '0';
    }
    else allText += to_string(isOnline);
    allText += '\n';
  }
  fclose(file);
  file = fopen("./usernames_passwords.txt", "w");
  fprintf(file, "%s", allText.c_str());
  fclose(file);
}

bool Server::hasNotifications(User user) {
  FILE *file;
  char buf[500];
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/notificari.txt", user.username.c_str());
  if((file = fopen(buf, "a+")) == NULL) {
    perror("Eroare la fopen().\n");
    return false;
  }

  int size;
  if (NULL != file) {
    fseek (file, 0, SEEK_END);
    size = ftell(file);
    if (size == 0) return false;
  }
  fclose(file);
  return true;
}

void Server::sendNotifications(int clientDescriptor, User user) {
  FILE *file;
  char buf[500];
  bzero(buf, sizeof(buf));
  snprintf(buf, sizeof(buf), "%s/notificari.txt", user.username.c_str());
  if((file = fopen(buf, "a+")) == NULL) {
    perror("Eroare la fopen().\n");
    return;
  }

  int nrMessages;
  char username[500];
  string bigString;
  while(fscanf(file, "%s %d\n", username, &nrMessages) != EOF) {
    string name(username);
    bigString += "You have "; bigString += to_string(nrMessages); bigString += " new messages from ";
    bigString += name; bigString += ". Open conversation to see them.\n";
  }
  myWrite(clientDescriptor, bigString);
  fclose(file);
}

void Server::handleClient(int clientDescriptor){
  int pid = fork();
  if (pid != 0) return; // parintele continua listenClients
  User user;

  while (1) {
    /* s-a realizat conexiunea, se asteapta mesajul */
    bzero (&user.state, sizeof(user.state));
    printf ("[server] Asteptam mesajul...\n"); fflush (stdout);

    /* citirea mesajului */
    if (myRead(clientDescriptor, user.state) == false) break;
    printf ("[server] Mesajul a fost receptionat, state: %d\n", user.state);
    if(user.state == 1) { // log in
      if(myRead (clientDescriptor, user.username) == false) break;
      if(myRead (clientDescriptor, user.password) == false) break;
      printf ("[server] Mesajul a fost receptionat, username: %s\n", user.username.c_str());
      printf ("[server] Mesajul a fost receptionat, password: %s\n", user.password.c_str());

      int found = checkUsernamePassword(user.username, user.password);
      if(myWrite(clientDescriptor, found) == false) break;
      if(found == 1) {
        changeIsOnline(user.username, "logIn");
        user.isOnline = 1;
      }
      else {
        printf("Login unsuccessful!\n");
      }
    }
    else if(user.state == 2) { // sign up
      if(myRead (clientDescriptor, user.username) == false) break;
      if(myRead (clientDescriptor, user.password) == false) break;
      printf ("[server] Mesajul a fost receptionat, username: %s\n", user.username.c_str());
      printf ("[server] Mesajul a fost receptionat, password: %s\n", user.password.c_str());

      int found = checkUsername(user.username);
      if(myWrite(clientDescriptor, found) == false) break;
      if(found == 0) {
        addNewUser(user.username, user.password); // il adaug in fisier
        user.isOnline = 1;
        users.push_back(user); // il adaug in vector
        int fd = open("./usernames_passwords.txt", O_RDONLY|O_APPEND);
        printf("%d\n", '1');
        close(fd);
      }
    }   
    else if(user.state == 3) { // quit
      printf("You quitted!\n");
      user.isOnline = 0;
      break;
    }
    else if(user.state == 4) { // menu
      bool notifications = hasNotifications(user);
      myWrite(clientDescriptor, notifications);
      if(notifications) sendNotifications(clientDescriptor, user);
    }
    else if(user.state == 5) { // chat
      int online = user.isOnline;
      User userToChat;
      userToChat = chooseUserToChat(clientDescriptor, user);
      chat(clientDescriptor, user, userToChat);
    }
    else if(user.state == 6) { // view history
      User chosenUser = chooseUserHistory(clientDescriptor, user);
      viewHistory(clientDescriptor, user, chosenUser);
    }
    else if(user.state == 7) { // log out
      changeIsOnline(user.username, "logOut");
      user.isOnline = 0;
      printf("You logged out!\n");
      break;
    }
  }
  changeIsOnline(user.username, "logOut");
  user.isOnline = 0;
  printf("Program ended. You logged out!\n");
  close(clientDescriptor);
}