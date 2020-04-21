#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
void main() {
    unsigned short int source, destination, length, checksum;
    char data[32];
    int fd = open("testpak",O_RDWR);
    read(fd, &source, 2);
    read(fd, &destination, 2);
    read(fd, &length, 2);
    read(fd, &checksum, 2);
    read(fd, data, 32);

    printf("source: %hu \n destination: %hu \n length: %hu \n checksum: %hu \n", &source, &destination, &length, &checksum);
    printf("data: %s \n", data);
}
