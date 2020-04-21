#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <time.h>

#define DMAX 500

int login(char *username);
void myFind(char *cale, char *fisier, char *pathsFound);
void myStat(char *fisier, char *raspuns);
int quit();

void procesare_recursiva(char *cale, char *fisier, char *pathsFound);
void meniu();

int main() {
    int nr_comanda, quited = 0, lgMesaj, loggedIn = 0, fd;
    char userName[DMAX], comanda[DMAX], cale[DMAX], fisier[DMAX];
    pid_t pid;
    while(!quited) { // parinte
        meniu();
        scanf("%d", &nr_comanda);
                
        switch (nr_comanda) {
            case 1:
                printf("Ai ales: Login.\n");
                printf("Username: ");
                scanf("%s", userName);
                strcpy(comanda, "login ");
                strcat(comanda, userName);
                break;
            case 2:
                printf("Ai ales: MyFind.\n");
                printf("Cale: ");
                scanf ("%s", cale);
                printf("Fisier: ");    
                scanf("%s", fisier);
                strcpy(comanda, "myFind ");
                strcat(comanda, cale);
                strcat(comanda, " ");
                strcat(comanda, fisier);
                break;
            case 3:
                printf("Ai ales: MyStat.\n");
                printf("Fisier: ");
                scanf("%s", fisier);
                strcpy(comanda, "myStat ");
                strcat(comanda, fisier);
                break;
            case 4:
                printf("Ai ales: Quit.\n");
                strcpy(comanda, "quit ");
                quited = 1;
                break;
            default:
                printf("Numar gresit.\n");
                break;
        }

        int sockp[2];
        socketpair(AF_UNIX, SOCK_STREAM, 0, sockp);

        int pipe1[2];
        pipe(pipe1);

        struct stat stats;
        if (stat("./MyFifo", &stats) >= 0){ // MyFifo exista
            if (unlink("./MyFifo") < 0) // il sterg
            {
                perror("unlink failed");
                return -1;
            }
        }
        if(mkfifo("./MyFifo", S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH) == -1) printf("Eroare la FIFO\n");

        pid = fork();
        if(pid==0) { //copil
            int lungime, lg;
            char command[DMAX], raspuns[DMAX*2], path[DMAX], file[DMAX], paths[DMAX*100]="";
            // citesc comanda de la parinte prin pipe
            close(pipe1[1]);
            read(pipe1[0], &lungime, 4);
            read(pipe1[0], command, lungime);
            close(pipe1[0]);
            command[lungime] = '\0';
            char *p = strtok(command, " ");
            if(strcmp(p, "login") == 0) {
                if(loggedIn == 1) {
                    printf("Esti logat deja!\n");
                    exit(0);
                }
                p = strtok(NULL, " ");
                if(login(p) == 1) {
                    close(sockp[0]);
                    strcpy(raspuns, "Succes");
                    lg = strlen(raspuns);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], raspuns, lg);
                    close(sockp[1]);
                }
                else {
                    close(sockp[0]);
                    strcpy(raspuns, "Failure");
                    lg = strlen(raspuns);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], raspuns, lg);
                    close(sockp[1]);
                }
            }
            else if(strcmp(p, "myFind") == 0) {
                if(loggedIn == 0) {
                    close(sockp[0]);
                    strcpy(raspuns, "NoLogin");
                    lg = strlen(raspuns);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], raspuns, lg);
                    close(sockp[1]);
                    exit(0);
                }
                p = strtok(NULL, " ");
                strcpy(path, p);
                p = strtok(NULL, " ");
                strcpy(file, p);
                myFind(path, file, paths); 
                lg = strlen(paths);
                if(lg == 0) {
                    close(sockp[0]);
                    strcpy(raspuns, "NotFound");
                    lg = strlen(raspuns);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], raspuns, lg);
                    close(sockp[1]);
                }
                else {
                    close(sockp[0]);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], paths, lg);
                    close(sockp[1]);
                }
            }
            else if(strcmp(p, "myStat") == 0) {
                fd = open("./MyFifo", O_WRONLY);
                if(loggedIn == 0) {
                    close(sockp[0]);
                    strcpy(raspuns, "NoLogin");
                    lg = strlen(raspuns);
                    write(sockp[1], &lg, 4);
                    write(sockp[1], raspuns, lg);
                    close(sockp[1]);
                    exit(0);
                }
                p = strtok(NULL, " ");
                myStat(p, raspuns);
                lg = strlen(raspuns);
                write(fd, &lg, 4);
                write(fd, raspuns, lg);
                close(fd);
            }
            else {
                quit();
                close(sockp[0]);
                strcpy(raspuns, "Quited");
                lg = strlen(raspuns);
                write(sockp[1], &lg, 4);
                write(sockp[1], raspuns, lg);
                close(sockp[1]);
            }
            exit(0);
        }
        // trimit comanda de la parinte la fiu prin pipe
        lgMesaj = strlen(comanda);
        close(pipe1[0]);
        write(pipe1[1], &lgMesaj, 4);
        write(pipe1[1], comanda, lgMesaj);
        close(pipe1[1]);

        // citesc raspunsul de la fiu prin socket sau fifo
        int lungimeMesaj;
        char answer[DMAX];
        memset(answer, 0, sizeof (answer));
        if(nr_comanda != 3) {
            close(sockp[1]);
            read(sockp[0], &lungimeMesaj, 4);
            read(sockp[0], answer, lungimeMesaj);
            close(sockp[0]);
        }
        else {
            fd = open("MyFifo", O_RDONLY);
            read(fd, &lungimeMesaj, 4);
            read(fd, answer, lungimeMesaj);
            close(fd);
        }

        if(nr_comanda == 1) {
            if(strcmp(answer, "Succes") == 0) {
                printf("Te-ai logat cu succes!\n");
                loggedIn = 1;
            }
            else if(strcmp(answer, "Failure") == 0) printf("Nu s-a putut efectua logarea. :(\n");
        }
        else if(nr_comanda == 2) {
            if(strcmp(answer, "NotFound") == 0) printf("Nu s-a putut gasi fisierul! :(\n");
            else printf("%s\n", answer);
        }
        else if(nr_comanda == 3) {
            if(strlen(answer) == 0) printf("Fisierul nu exista.\n");
            else printf ("%s\n", answer);
        }
        else if(nr_comanda == 4) {
            if(strcmp(answer, "Quited") == 0) printf("S-a terminat sesiunea!\n");
        }
        if(strcmp(answer, "NoLogin") == 0) printf("Nu esti logat!\n");
    }
    return 0;
}

void meniu() {
    printf("Meniu: \n");
    printf("1. Login\n");
    printf("2. MyFind\n");
    printf("3. MyStat\n");
    printf("4. Quit\n");
}

int login(char *username) {
    char names[DMAX], gasit=0;
    FILE *fisier = fopen("users.txt", "r");         
    while(fscanf(fisier, "%s\n", names) != EOF && !gasit) {
        if(strcmp(names, username) == 0) gasit = 1;
    }
    if(gasit == 1) return 1;
    else return 0;
}

int quit() {
    return 1;
}

void myStat(char *fisier, char *raspuns) {
    int lg = 0;
    struct stat st;
    if (stat(fisier, &st) == -1) {
        raspuns[0] = 0;
        return;
    }
    strcpy(raspuns, "File type: ");
    if(S_ISDIR(st.st_mode)) strcat(raspuns, "director\n");
    else if(S_ISSOCK(st.st_mode)) strcat(raspuns, "socket\n");
    else if(S_ISFIFO(st.st_mode)) strcat(raspuns, "FIFO sau PIPE\n");
    else if(S_ISLNK(st.st_mode)) strcat(raspuns, "link\n");
    else if(S_ISREG(st.st_mode)) strcat(raspuns, "regular file\n");
    else if(S_ISCHR(st.st_mode)) strcat(raspuns, "character device\n");
    else if(S_ISBLK(st.st_mode)) strcat(raspuns, "block device\n");

    lg = strlen(raspuns);
    lg += sprintf(raspuns + lg, "File's last access time: %s", ctime(&st.st_atime));
    lg += sprintf(raspuns + lg, "File's last modification time: %s", ctime(&st.st_mtime));
    lg += sprintf(raspuns + lg, "File's total size (in bytes): %ld\n", st.st_size);
}

void myFind(char *cale, char *fisier, char *pathsFound) {
    struct stat st;
    stat(cale, &st);
    if(! S_ISDIR(st.st_mode)) {
        sprintf(pathsFound, "Eroare: %s nu e director!", cale);
        return;
    }
    procesare_recursiva(cale, fisier, pathsFound);
}

void procesare_recursiva(char *cale, char *fisier, char *pathsFound) {
    DIR *dir;
    struct dirent *de;
    struct stat st;
    stat(cale, &st);
    if(S_ISDIR(st.st_mode)) {
        if(NULL == (dir = opendir(cale))) return;
        while((de=readdir(dir)) != NULL) {
            if(strcmp(de->d_name, ".") && strcmp(de->d_name, "..")) {
                char new_cale[300];
                strcpy(new_cale, cale);
                int length = strlen(new_cale);
                if(new_cale[length-1] != '/') {
                    new_cale[length] = '/';
                    new_cale[length+1] = '\0';
                }
                strcat(new_cale, de->d_name);
                if(strcmp(de->d_name, fisier) == 0) {
                    strcat(pathsFound, new_cale);
                    strcat(pathsFound, "\n");
                    char myStatInfo[DMAX*2];
                    myStat(new_cale, myStatInfo);
                    strcat(pathsFound, myStatInfo);
                    strcat(pathsFound, "\n");
                }
                procesare_recursiva(new_cale, fisier, pathsFound);
            }
        }
        closedir(dir);
    }
}