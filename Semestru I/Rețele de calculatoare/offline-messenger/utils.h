#include <string>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

int fd_is_valid(int fd)
{
    return (fcntl(fd, F_GETFD) != -1 || errno != EBADF);
}

bool myWrite(int fd, string msg) {
    int len = msg.size(), nrRead;
    if((nrRead = write(fd, &len, sizeof(len))) == -1) {
        perror("Eroare la write().\n");
        return false;
    }
    if(write(fd, msg.c_str(), len) == -1) {
        perror("Eroare la write().\n");
        return false;
    }
    if(nrRead == 0) return false;
    return true;
}

bool myWrite(int fd, int val) {
    int nrRead;
    if((nrRead = write(fd, &val, 4)) == -1) {
        perror("Eroare la write().\n");
        return false;
    }
    if(nrRead == 0) return false;
    return true;
}

bool myRead(int fd, string &msg) {
    int len, nrRead;
    char *s;
    if(!fd_is_valid(fd)) return false;
    if((nrRead = read(fd, &len, sizeof(len))) == 1) {
        perror("Eroare la read().\n");
        return false;
    }
    s = new char [len +1];
    if(read(fd, s, len) == -1) {
        perror("Eroare la read().\n");
        return false;
    }
    s[len] = 0;
    msg = s;
    if(nrRead == 0) return false;
    return true;
}

bool myRead(int fd, int &val) {
    if(!fd_is_valid(fd)) return false;
    int nrRead;
    if((nrRead = read(fd, &val, 4)) == -1) {
        perror("Eroare la read().\n");
        return false;
    }
    if(nrRead == 0) return false;
    return true;
}