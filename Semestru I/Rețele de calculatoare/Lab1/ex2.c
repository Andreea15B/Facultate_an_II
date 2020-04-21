#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>

void procesare_recursiva(char *cale);
char fisier[100];

void main(int argc, char *argv[]) {
    struct stat st;
    strcpy(fisier, argv[2]);
    stat(argv[1], &st);
    if(! S_ISDIR(st.st_mode)) {
	printf("Eroare: %s nu e director!", argv[1]);
	exit(1);
    }
    procesare_recursiva(argv[1]);
}

void procesare_recursiva(char *cale) {
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
		    new_cale[length+1] = NULL;
		}
		strcpy(new_cale, de->d_name);
		if(strcmp(de->d_name, fisier) == 0) printf("Am gasit: %s/%s\n", cale, de->d_name);
		procesare_recursiva(de->d_name);
	    }
	}
	closedir(dir);
    }
}