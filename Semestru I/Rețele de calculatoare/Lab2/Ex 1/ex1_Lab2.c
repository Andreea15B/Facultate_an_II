#include <unistd.h>
#include <stdio.h> 
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
int fd;
char *fisier;
void readFile(int sig) {
    int fd = open(fisier, O_RDONLY);
    printf("Intrat in readFile!\n");
    char v[100];
    int bytes = read(fd, v, 100);
    if(bytes == -1) printf("Eroare read!\n");
    else printf("Read succes: %d\n", bytes);
    v[bytes] = 0;
    printf("Copilul a citit: %s\n", v);
    close(fd);
}

int main(int argc, char *argv[]) {
    fisier = argv[1];
    pid_t pid;
    const char a[] = "Good morning", b[] = "Good night";
    fd = open(argv[1], O_RDWR);
    if(fd == -1) printf("Eroare open!\n");
    else printf("Open succes!\n");
    switch(pid=fork()) {
	case -1:
	    perror("fork");
	    printf("Eroare fork!\n");
	    exit(1);
	case 0: //copil
	    signal(SIGUSR2, readFile);
	    pause();
	    exit(0);
	default: //parinte
	    //write in file
	    sleep(1);
	    if(pid % 2 == 0) {
		int test = write(fd, a, sizeof(a));
		if(test == -1) printf("Eroare la write1\n");
		else printf("Write1 succes!\n");
	    }
	    else {
		int test = write(fd, b, sizeof(b));
		if(test == -1) printf("Eroare la write2\n");
		else printf("Write2 succes!\n");
	    }
	    close(fd);
	    if(kill(pid, SIGUSR2) == -1) printf("Eroare kill\n");
	    else printf("Kill succes\n");
	    wait(NULL);
	    printf("S-a terminat copilu'\n");
    }
    return 0;
}

