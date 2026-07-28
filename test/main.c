#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char **argv) {
    char buf[32] = {0};
    ssize_t count = read(STDIN_FILENO, buf, 20);
    if (count <= 1) {
        exit(1);
    }
    buf[count-1] = 0;
    // manupulating the truth :3
    strcat(buf, " plouf!");
    fputs("You said: ", stdout);
    puts(buf);

    char* str = "This is the end~\n";
    fwrite(str, 1, strlen(str), stdout);
    return 0;
}