#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>

static void alarmHandler(int signo);
static void writeInFile(int signo);
static void killProgram(int signo);
char *fisier;
int afisare;
int main(int argc, char *argv[]){
    fisier = argv[1];
    alarm(3);
    signal(SIGALRM, alarmHandler);
    signal(SIGUSR1, writeInFile);
    signal(SIGINT, killProgram);
    sleep(3);
    return 0;
}

static void killProgram(int signo) {
    if(afisare >= 20) exit(0);
}

static void alarmHandler(int signo){
    printf("Pid: %d Nr afisare: %d\n", getpid(), ++afisare);
    alarm(3);
    sleep(3);
}

static void writeInFile(int signo){
    printf("Intrat\n");
    int fd = open(fisier, O_WRONLY);
    char a[] = "Am primit semnal!\n";
    write(fd, a, sizeof(a));
    close(fd);
}