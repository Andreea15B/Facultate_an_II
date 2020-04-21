#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    int pfd[2], pfd2[2], numar, nr, isPar=0, answer;
    numar = atoi(argv[1]);
    printf("numar = %d\n", numar);
    if (pipe (pfd) == -1)         
    {
      fprintf (stderr, "pipe\n");
      exit (1);
    }
    if (pipe (pfd2) == -1)         
    {
      fprintf (stderr, "pipe\n");
      exit (1);
    }
    write(pfd[1], &numar, 4);
    printf("Scris in pfd: %d\n", numar);
    close(pfd[1]);

    switch (fork ())              
    {
    case -1:
      fprintf (stderr, "fork1\n");
      exit (1);
    case 0:                        /* copilul */
        read(pfd[0], &nr, 4);
        printf("Citit din pfd: %d\n", nr);
        close(pfd[0]);
        if(nr % 2 == 0) {
            isPar = 1;
            write(pfd2[1], &isPar, 4);
        }
        else {
            isPar = 0;
            write(pfd2[1], &isPar, 4); 
        }
        printf("Scris in pfd2: %d\n", isPar);
        close(pfd[1]);
        exit(1);
    }
    read(pfd2[0], &answer, 4);
    printf("Citit din pfd2: %d\n", answer);
    if(answer == 1) printf("Answer: %s\n", "yes");
    else printf("Answer: %s\n", "no");
    return 0;

}