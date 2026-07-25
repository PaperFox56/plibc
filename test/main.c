#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char **argv) {
    char buf[32] = {0};
    read(STDIN_FILENO, buf, 20);
    fputs("You said: ", stdout);
    puts(buf);

    char* str = "This is the end~\n";
    fwrite(str, 1, strlen(str), stdout);
    return 0;
}