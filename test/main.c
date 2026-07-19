#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv) {
    char buf[32] = {0};
    read(STDIN_FILENO, buf, 32);
    memmove(buf, "Some", 4);
    write(STDOUT_FILENO, "You said: ", 10);
    write(STDOUT_FILENO, buf, 32);
    return 0;
}