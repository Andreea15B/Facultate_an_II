#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <signal.h>
#include <stdio.h>

void sighandler(int sig) {		/* functia de tratare a semnalului */
    printf("Primit: %d\n", sig);
}

void copil1() {
    execlp("ps", "ps", NULL);
}

void copil2() {
    printf("Id proces copil 2: %d\n", getpid());
}

int main() {
    pid_t pid1, pid2, pid3;
    int cod1, cod2, cod3;
    if (signal (SIGUSR2, sighandler) == SIG_ERR)
    {
      perror ("signal()");
      return 1;
    }

    pid1 = fork();
    if(pid1 == -1) {
        perror("fork1"); exit(2);
    }
    else if(pid1 == 0) { //copil 1
        copil1();
        return 0;
    }
    waitpid(pid1, &cod1, 0);
    pid2 = fork();
    if(pid2 == -1) {
        perror("fork2"); exit(3);
    }
    else if(pid2 == 0) { //copil 2
        copil2();
        return 1;
    }
    waitpid(pid2, &cod2, 0);
    pid3 = fork();
    if(pid3 == -1) {
        perror("fork3"); exit(4);
    }
    else if(pid3 == 0) { //copil 3
        kill(getppid(), SIGUSR2);
        return 0;
    }
    
    waitpid(pid3, &cod3, 0);
    printf("Cod copil 1: %d\n", cod1);
    printf("Cod copil 2: %d\n", cod2);
    printf("Cod copil 3: %d\n", cod3);
    return 0;
}