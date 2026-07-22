#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char **argv) {
    char buf[32] = {0};
    read(STDIN_FILENO, buf, 20);
    memmove(buf+10, buf, 20);
    memcpy(buf, "You said: ", 10);
    puts(buf);
    return 0;
}